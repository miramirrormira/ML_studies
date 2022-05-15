import unittest
import pandas as pd
import dataCleaning

class TestDataCleaning(unittest.TestCase):

    def test_missingValues(self):
        d = {'col1': [0, 1, 2, 3], 'col2': pd.Series([2, 3], index=[2, 3])}
        df = pd.DataFrame(data=d, index=[0, 1, 2, 3])
        result = dataCleaning.missingValues(df)
        self.assertEqual(result['col1'], 0)
        self.assertEqual(result['col2'], 0.5)
        self.assertEqual(result['total'], 0.25)

    
    def test_getRowsWithMissingValues(self):
        d = {'col1': [0, 1, 2, 3], 'col2': pd.Series([2, 3], index=[2, 3])}
        df = pd.DataFrame(data=d, index=[0, 1, 2, 3])
        result = dataCleaning.getRowsWithMissingValues(df)
        self.assertTrue(result.equals(df.iloc[[0,1]]))

if __name__ == '__main__':
    unittest.main()