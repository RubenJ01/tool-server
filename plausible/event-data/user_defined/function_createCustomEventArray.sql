CREATE FUNCTION createCustomEventArray AS (foundIndex, scaleBy) -> if(foundIndex > 0, [toUInt64(foundIndex + scaleBy)], [])
