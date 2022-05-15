import pandas as pd
import numpy as np

def missingValues(df, columns=None):
    if columns == None:
        columns = df.columns

    result = {}
    totalMissing = 0
    for column in columns:
        perc = sum(df[column].isnull())/df.shape[0]
        totalMissing += sum(df[column].isnull())
        result[column] = perc

    result["total"] = totalMissing / (df.shape[0] * len(columns))
    return result


def getRowsWithMissingValues(df, columns=None):
    if columns == None:
        columns = df.columns
    
    mask = [0] * df.shape[0]

    for column in columns:
        mask += df[column].isnull()
    
    return df.loc[mask!=0]
