Return-Path: <linux-kernel+bounces-792873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B1DD7B3C9ED
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 11:51:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5BADA4E251A
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 09:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B5C9257824;
	Sat, 30 Aug 2025 09:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="CHB+C8Tu"
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012042.outbound.protection.outlook.com [52.101.126.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84043214210;
	Sat, 30 Aug 2025 09:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756547483; cv=fail; b=eLEXTdjQpmguV15awXY5iz5mhyOJASI+5gytH2pU/0dX4WfjCWUNcOfoFq3NNuyeJNC9iVWSvkL96G3GUnX0uKaxSv4RtNn1a60ly1VejulGi9d9zIOg30oJnnvXq+/HD9t6iRWNsiFkrUDCW95TykawRF91GB8EEcvKegE4plU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756547483; c=relaxed/simple;
	bh=WkaU86o2zTDssFC5uJhCedEjVtWswOdlj4QboaJyqg8=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=K2uESc/HKztoQUo7UA93IwPXqj2G4YzFPOljJr6+pdPF7T5PBuBQba5j/hfTd3wjLMYPWkxA7mjrqftt2jk8v/x/OBiD8aJ4bcppEStczZuRixWAlXCXLAIz7koBXLW9lXhqgTZPudYCbqXK2o9i1SK3aNVA4Q/jgmibhGmEcBI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=CHB+C8Tu; arc=fail smtp.client-ip=52.101.126.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BH7uTGikHadfI9ULsavgYZ30XqfjX+6aSgNxZxeXYEO5V6ua9W13U0WFlmFynKCHlMsaUG7pOcaLf+AKpfRBi6ZURIp3mEbDtZ7hPHWb3u1i6oIn82V0GyvurckMvAe0sz4erogppUOCM/eEglMkLxQIUyKfox82Xn2XuZXhIKA/7q7VbNU849FeEGGc2U0qmeCi+WCT7MlbaP0vjS+pJqP+9ZLu3v+XYqRJQMbmjMN6VjPy7IRFoP7vJrnsCbpt4x2vhgWRiWEwAalTG5h3epYfOCNrUBJKOt0R6zG5Wj7R/2A4HQR5AlQufa5itrPVkCEQS1/HT0s9IBGo5FBTIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2cESHfxQ9WIt1V0paCUuhcmVGB5Di64Hgz1bd66YxuI=;
 b=kzaj+zpANiVuWMglX0ORkDv7+7xolxMul9owaHLPgqs+NYxDX/SWsmoqqU74y+6u0h+cxpA9MX0deL7IogK+90sN81nG+b9kpKNyR4J1N/EmBvQoVTQAPSJIbQczw7AptrM6SAboWpaCvon5mz2n6mLueLUCIcX9YirAGW2kzbZr0ILXXug3P0uP/FqD9VyB+3Qzwc2CQppH2ncDF1/bHTYYAYGVaI7gMptekrhV734/48z6r04LrXp/4JKrTxCQgyXIzfsdUSWKn0q9OpkqhO3v3We1AiKJQb9KiHAco26EsO2FYMvp5Rg8zUJfZX53CL9XO6ZExTRYl3IdXRxceQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2cESHfxQ9WIt1V0paCUuhcmVGB5Di64Hgz1bd66YxuI=;
 b=CHB+C8Tu5yyReCb5AgjCwLcmUoTU6frP457SzjH6yvK9npa3im+puIkNQt9FYNE7SNJ2S1BM/wUmOTNV2OhViNjOpOokgFwaVG1Pl3dhe6kdjtf9cdB4lQLjPrfKhnrPmPe9aYq/wLiE1Ahf7AEv2Do6WrtYsuO2K11gfMM61vGP22+R5qZNakG/K8u5cOYUyC2ril6QyeVeNm48SyjQyOBzDxGLBO/jvcZJcIU9owV5qyy7MakXr1ae0HOGxPezkI2sDc0J+VewqGIO4/QkP5KwniH9CsDrCwHPmxNatetUW12ByhGT8qFWbi7ziIydM638jAB9J8e8qsVFV6/aPQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 TYZPR06MB6165.apcprd06.prod.outlook.com (2603:1096:400:336::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.21; Sat, 30 Aug
 2025 09:51:17 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666%5]) with mapi id 15.20.9073.021; Sat, 30 Aug 2025
 09:51:17 +0000
From: Qianfeng Rong <rongqianfeng@vivo.com>
To: Guenter Roeck <linux@roeck-us.net>,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Qianfeng Rong <rongqianfeng@vivo.com>
Subject: [PATCH] hwmon: (nct6775) Use int type to store negative error codes
Date: Sat, 30 Aug 2025 17:51:05 +0800
Message-Id: <20250830095105.3271-1-rongqianfeng@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0047.apcprd02.prod.outlook.com
 (2603:1096:4:196::14) To SI2PR06MB5140.apcprd06.prod.outlook.com
 (2603:1096:4:1af::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB5140:EE_|TYZPR06MB6165:EE_
X-MS-Office365-Filtering-Correlation-Id: a7c07986-dea2-40f2-0bbd-08dde7aac3cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2XZI7v7Wmj3pRVO6XIM3eeT/tdzPNoDlGR8T3FZNUb31RC/Gz0Ilm2LlCt/X?=
 =?us-ascii?Q?p4ueQbmPRjxZvJvNLioi738F8hWdm++VSeZk6hjipwP4jThPmNJRl5TfRx6+?=
 =?us-ascii?Q?HkGxCwz3i2vn65a5rRNNrfDXsscbnpmfLsVoSYh6xvgtfrCgS3ICbZ6q2fbj?=
 =?us-ascii?Q?c/n1tY7MAuhc5ndjkwj3uRfKgLxh0BVR1YpkCdi7wJjSZJrl6iqhX1BGYkk4?=
 =?us-ascii?Q?ODS2ySEVC9HEZpVcxajfj8nxIKFkLXRHcz9dDJJOHHz9aAMuv7l4s+WGllKP?=
 =?us-ascii?Q?RizP9xuOmMJxRTdFLLjqIMm/nbmay72DYeiA1OxEemh6Mj+6uEeY7koacBm1?=
 =?us-ascii?Q?FR05IKW3FMaVRFKnU1b1YHpordslC5NTQlFAMA3+8Ipjw586cVAIbNvtsQje?=
 =?us-ascii?Q?I2yARgRmRqcdHfhnEkHKWP7SJi11i9Yn/Ldl6ficrbplpnuzB1xLpHtWB2FT?=
 =?us-ascii?Q?9ghOvDNj1gwnXyKVh02zj+mUMvp9UoyuwO9KmNC7dZWurC/glkl1PHrlHH/k?=
 =?us-ascii?Q?icujcmnqjpR9YuLD3tgr4WQL9Wf5xuS/0pGIf1YrXDFIPfUiLF85987hgQxE?=
 =?us-ascii?Q?AxioAsNqRRbuisEtOd+tpCQozMkYjkG4JLZ8uW6pSQN8+ZXuNgLjSNy5dmg7?=
 =?us-ascii?Q?lnK6k8lDkDvdxco0DZM3318txJf7EgFPzALkWAvs6VkIIeU5e6KQmjB2dcJ4?=
 =?us-ascii?Q?Ao+MCTwbAUF80+8oo/mjH9FqmMV99fUC9webbAKxG/i0vDbjnvukXxBmG69U?=
 =?us-ascii?Q?znWK1sR0zDH0vuxDcnMCWtqexBR8XSN06Rr8S8wsl+Ko7xezAzsKm4gVlrk5?=
 =?us-ascii?Q?O3Ndpp4jIBnxd2742RYz2DK0Cqvmybg/HlBgavcsrn/pVYCrQyoR0pJAU35e?=
 =?us-ascii?Q?5LIjy6u5f6RDB6XXkxNvg5Y3cIgU4WFaR6j1XlkiNgbjPRDnRAqb47PpAO9+?=
 =?us-ascii?Q?3Q3WOg/tTeGfSWFqCf/FLhui5TfHMmILHGigcYYv1fC1BloFJLu2JQ7PezF4?=
 =?us-ascii?Q?BsAOMuJpqc15X9IoBjcNbxLeArHF4v7myGdpysS3W2chbRsSc+eOQi88nVtr?=
 =?us-ascii?Q?xEBB2L/JG1z/0wlxXgizotjzAvB1ayZoo5TSmVV1BtRJtFBIPjH6Rs8IF4M5?=
 =?us-ascii?Q?PTX0gmbCZY1FPvFIbEoVQih1kU4UUBjVcjC53P1SM5MBu+phIoc59S/ufLXg?=
 =?us-ascii?Q?+K/nm/4am+urTO+CEK964SMBrTFSECPTsmcNCF7lrry9CdjuXeeABNq9UBLj?=
 =?us-ascii?Q?AAIcp+sKeQqSHsmJ4jGTt3B/uu8j/81rAxlf/l0ca3Quh34ByxAKGYJTdT3B?=
 =?us-ascii?Q?jYA0rxMmiP7KV2hrADyvC3JnSY2JdcC2RJmbNVdkoHlbdOwUqKhqI5zank/H?=
 =?us-ascii?Q?Ru9Wx6xqa8J3pJt9FO9muzViGhzmnW70Z3/Y/kSvuDh4PsmXH01AYA1JBAdL?=
 =?us-ascii?Q?TSl8Y86+VEemKIQ/L0uK9cAv26oSH01Spg/Ii0S+hlVQ/Mrw7ZY6ew=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Lwy32uysPJaUzZW4oRdb31kNiUCrAO0LeDwA4R0+Kzz1SujnWvMIKd2w+e7a?=
 =?us-ascii?Q?DirO63fnfkqz/iLzyRU0iH5a5jRPlVzWRZOeVjdddwqn7m7Wj5H9fUxfxHuS?=
 =?us-ascii?Q?VckcRiYawJ+GW6cy0so++lwqZi47h7R3hwXjWwoRzRZRMrVfVU6ohD+2l/v5?=
 =?us-ascii?Q?wPSlrfh96o4hW7QowSkTB0mk1FJ+XRkwSWjXv/9d/ok8+0i0Ed6MvGvTz7K1?=
 =?us-ascii?Q?dZnNVsfEW9gcovtpUEDRfipE4ktzsLPNiYy21+ncLsj9yHCNen6vKj9wT2km?=
 =?us-ascii?Q?irkfStrPRJYwZmbnC1w+PAAw3oe+HjhvphGJvRdGugd3HvkJ/3jqcWPiqzmb?=
 =?us-ascii?Q?5qkGWFNAgf2xOTRVPRCCmWw00YmUiX2E2PPj4d9I3by1cJ+a1Ek8jxB09tfm?=
 =?us-ascii?Q?n6jz8ZjWaNaDvv8fooTXxVEXKcug0kQ2aPV/QyrFtNgcnjOaPFuX3XvrN3//?=
 =?us-ascii?Q?6Y9giCmy8iM5DlZ1K4lA9CCEqY7HhlSKHF5JG+26EvSQYa6DY6JXfI/+ahif?=
 =?us-ascii?Q?lGwzAWDoaucRGXogW97g5KzWWGEDLpZa4+h8OUU8PPB108ywwmrEE35M7hXy?=
 =?us-ascii?Q?R3MkVgSiVer5bKktqqaaAFGVBmJ28hOirPovD44IxskMC28cncWSqjWm2t7j?=
 =?us-ascii?Q?HetGwPlwNPXjIhwb3/PlAOfvBrx1Vqzes3fJckyBP0fa74+P1/OjNpiWP+EP?=
 =?us-ascii?Q?eq/wCjjHwEKhuYQeMogvFqyUV76V+nR/+T6dqOk0H5aHKxHkDVQ9Ksbaznzi?=
 =?us-ascii?Q?vusILyLWz+RyWmdIF6K7D8Py/hEhFLhe63acL5vyhWYakggzW4KUF3OpmpQA?=
 =?us-ascii?Q?IsnlPZ2Kn0EuvT6qmWVWtAxZNJ8KDtllUkY8fVmj0yHmDOJUSiG0PkBlJvNW?=
 =?us-ascii?Q?2TeOrtvwrJk862YeeI9LGyWPdEBVXF0H/6W8nO2uN6aGsynR5qyGrauFxKLO?=
 =?us-ascii?Q?Cd6FC7N0tPD+MMtX0JEI0PVQewKjHyB5ZzZkqJnXZPYgrSfBjUDutmX2FHjH?=
 =?us-ascii?Q?+WB578KKA4oajyK17pQEvKq+W6WeneP0dC5PCDV3tysEm37zK55IOR2zkiut?=
 =?us-ascii?Q?CWe7KPHXMTi5eIOyixgwo7UreP6n9Fn87YoUFevb0tDrmM5+pUKFYilsh0ZL?=
 =?us-ascii?Q?UU671aKrRcnbhCu/HAfO8hMMA6eusUHVcm87HyB5K2tvl8Nz8CfPZMtHKnHg?=
 =?us-ascii?Q?upcOn5iEA1G5QWwh2wQ0ibXvpQwBUV/noGQ77qtn/lrJrGN3z4XRHtem3Kqo?=
 =?us-ascii?Q?NYT+6GiPKKVVn+I+K4EYX4QiFJYjukBOyOu11+krAzlCGq7S2tjlWbWdpESx?=
 =?us-ascii?Q?VXCpBOo+HghmLw4t6p6LTMlYlp9QD5iDITElRBA5eusVw8K6RS9BAc39FxxO?=
 =?us-ascii?Q?eiags8vcFaMBFPexx2wuU7h2Iph3C8Uqk7dnV8E+V+14bcytpXB3s4chZIu5?=
 =?us-ascii?Q?4ORJ3xnYFkDpoZKz9CMosUaUZTQIdi3iVh/VEbN1JUCDLMGEi0lVYGQjERYb?=
 =?us-ascii?Q?XhVkx+Cm5vH/6wpiv81ai+Zo8qbACdHz0Xm1XOKsbmLoojOCWiFWk/T1PwVW?=
 =?us-ascii?Q?xiQvW3UV+xNMLH51ZK6uPIAh6sdvE2KlP9aIYe2s?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7c07986-dea2-40f2-0bbd-08dde7aac3cd
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2025 09:51:17.4103
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p5f9805z5T4K7rqDnw8cE5v97O1P/tZCLqtEQDq3J4errcBDTbZz8g8YHFRlJsnWsW5WLEShAYKmZb9Qqklpmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6165

Change the 'ret' variable from u32 to int in nct6775_asuswmi_read() to
store negative error codes or zero;

Storing the negative error codes in unsigned type, doesn't cause an issue
at runtime but can be confusing. Additionally, assigning negative error
codes to unsigned type may trigger a GCC warning when the -Wsign-conversion
flag is enabled.

No effect on runtime.

Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
---
 drivers/hwmon/nct6775-platform.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/nct6775-platform.c b/drivers/hwmon/nct6775-platform.c
index 0a040364b512..407945d2cd6a 100644
--- a/drivers/hwmon/nct6775-platform.c
+++ b/drivers/hwmon/nct6775-platform.c
@@ -167,7 +167,8 @@ static inline int nct6775_asuswmi_write(u8 bank, u8 reg, u8 val)
 
 static inline int nct6775_asuswmi_read(u8 bank, u8 reg, u8 *val)
 {
-	u32 ret, tmp = 0;
+	u32 tmp = 0;
+	int ret;
 
 	ret = nct6775_asuswmi_evaluate_method(ASUSWMI_METHODID_RHWM, bank,
 					      reg, 0, &tmp);
-- 
2.34.1


