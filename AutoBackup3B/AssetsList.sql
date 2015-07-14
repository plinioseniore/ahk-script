SET NOCOUNT ON;
SELECT RTRIM(STRATEGY.StrategyName)
FROM STRATEGY INNER JOIN TEMPLATE ON STRATEGY.TemplateID = TEMPLATE.TemplateID
WHERE TEMPLATE.TemplateID = 2
ORDER BY Strategy.StrategyName;
