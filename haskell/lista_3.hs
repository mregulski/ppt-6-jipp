import Data.List hiding (permutations)
scalarproduct :: Num a => [a] -> [a] -> a
scalarproduct x1 x2 = sum [x*y | (x,y) <- zip x1 x2]

split :: [a] -> ([a], [a])
split []  = ([],[])
split [x] = ([x], [])
split (x:y:rest) = (x:xs, y:ys) where (xs,ys) = split rest

permutations :: Eq a => [a] -> [[a]]
permutations [] = [[]]
permutations [x] = [[x]]
permutations as = [x:xs | x <- as, xs <- permutations (delete x as)]
