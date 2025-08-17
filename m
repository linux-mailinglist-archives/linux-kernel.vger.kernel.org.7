Return-Path: <linux-kernel+bounces-772500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B4347B2936D
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 16:23:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6FB957A3C42
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 14:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BEEB2D46CA;
	Sun, 17 Aug 2025 14:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="LDN15+YG"
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013027.outbound.protection.outlook.com [40.107.44.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9FCB2D3A7D
	for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 14:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755440622; cv=fail; b=mqsgSwZfWKeX3l643stFPqB4vzkEvk4H3USFaA1PIH7qQd2MFSF/lOrqxROe8BwZGh0vb/uh9iO58pVVHL2iozat/uPaHkFZsablo94IiGwKLR1r+RsMtnKLhPhjImd9gze/AwZERX8b49iPD5iu1nVuURllQwKpeT965KuBEv4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755440622; c=relaxed/simple;
	bh=pw+nk61kAc74M/JDOop5GF5WYRNZdQe1NXArIO3GdfQ=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=pNEPCszl/yIRrj3X0da7IU77k+BC732pjEeBfYHUX6+WgUUIZ58rzXG69xgbmC4xsSnz7DtxWwEQJQ7sHZBVMX9HkfDUG6HphCxp+5TKp/5bALrHkSeK+cBmFTe4Kh1Qg/WngtAQIdpbTO7ahHXmYWhGuop8TxGs7jz3fFbYavk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=LDN15+YG; arc=fail smtp.client-ip=40.107.44.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fDx49fHitMk41HLYJUB8hIGaKZ9yYt6ukObpYi7dAX41/CEF3/wqmsUQrYUQFqqHYfpkdejaFMbskZBFhM3hY8Q+sajOzIbnJKgRlAhqjWhNT/UNkD8kr4JoaUyMi3CJB5+i3WRsU9Zb1PSLPoH2PKCcu+Eb4PkICEtSqXNFrYmi/g/geF9GdLgsSi2f/Sd7efiMuvX1WhbX7eGV+Bab0sX8qWJISVIs3EIAwUfvmi+BZjvN3MsuvYRJUv5KD5A/jAMtzWB/bdFibf8MziP+6NseJ7al8ylz9w8OPmzw3Gyg0mk5geNClNalfwaOQMTit8echr8yUe3rG7Sxqw0+3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HKKhNsBASEZmVyNOfwCyu0HfkrSQG6alGqRSaLO+v+c=;
 b=l9f7OIRVwbdJHRhBnR/gL2MGIbgPsWKqE78khvpZ53Bf0iAEthdzpKkHemEAhGRbuRhCNbAuz/WNIFI6HfRMw00X+daZ4WKrXk8siBuaK997xdFsBPSvn38dZgM3Xt0QwPEKyrXGxKmsQLSUXzLD31us9frFbI3z1vhXO01m6s2X3cGTJfviLxy6t7cfc87cAhm7IUjF1RZpPphjK1+k+Ep8XKpDz47jFYVQneRo3YnLA4l043/z9deOzlO/gusw7Qwle318yGZww9tHVg/tLgjbRTmuQM5nc5k9kpaHZgsSCOGLV7WznB+Z1Fy/JtQgt8Bofu/zsFsk8COWTKoXCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HKKhNsBASEZmVyNOfwCyu0HfkrSQG6alGqRSaLO+v+c=;
 b=LDN15+YGIGCfAHvdDahWHgb6K9jtRxiBhXZAqgP8vFaXzIQA9JgUq0TCOA1HLFH4dqIyLJDcwi6HWygj6RszMbL/K197Um23aThL9NAEG7bJDVtpJT6+FH3LK90b2x1CmQNwzuGaMsImGxSXsY/IeZVZk8+gegnESkrJIIpPjjoNPwhDgviH0ksYlUhVkORWQwuET9fPZwcbhG7H+E5VqhkyZmWvUSIvW3usdbpab0FEbV8Dpq9+sNFB9UvYRQyqkxKvXFR+pKZo+UflzFPPhYTY0p6RjpvdKCmtwsnC9Zu4zQl5dHf/LeOcsWr+crXcCc52lhPiiQTmxT8JNl0nAA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 KU2PPF4166F2409.apcprd06.prod.outlook.com (2603:1096:d18::491) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9009.18; Sun, 17 Aug 2025 14:23:37 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666%5]) with mapi id 15.20.9031.021; Sun, 17 Aug 2025
 14:23:37 +0000
From: Qianfeng Rong <rongqianfeng@vivo.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: Qianfeng Rong <rongqianfeng@vivo.com>
Subject: [PATCH] regulator: bd718x7: Use kcalloc() instead of kzalloc()
Date: Sun, 17 Aug 2025 22:23:27 +0800
Message-Id: <20250817142327.174531-1-rongqianfeng@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0224.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c5::8) To SI2PR06MB5140.apcprd06.prod.outlook.com
 (2603:1096:4:1af::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB5140:EE_|KU2PPF4166F2409:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b4e7389-e96d-40b1-ac68-08dddd99a7ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ty1kVoKRi6Mu3WPIhvzULNcNJPLw+fA/smIU4GOuqdI01vRu6pL7iCwyNotL?=
 =?us-ascii?Q?TuBr7XmbY0AH7XunRczZRIxQEpfw1fYOXEQS27k23OrQRIG4eTH9fRDAEhHN?=
 =?us-ascii?Q?3OjBV7Z9y4qGpMiipWJIVlFxXMxpNlnfO3Cf71n6z49DjIlJDdDAerhZWZCM?=
 =?us-ascii?Q?1GjRoX+zdPA/BlYEduHDqtBiyA+9mhkPp8xod8W11XV4KQORx6DhCuuOouLj?=
 =?us-ascii?Q?uF5XzZXGMDL0uB5UE7z8DmQ5p8tseW28rk2g+ZKIyvPnJnSbkHSH0+WFfAWk?=
 =?us-ascii?Q?rNNF4t47s+Rqw0phX4FR72sC7zqXJSCs7MXI/33dFTMoEwlYJTlvzmdmsW4e?=
 =?us-ascii?Q?seOeaj8r1Q3ywHgyCHxJMlfMLmM9wNi+eEWC+5ylVP1hiAZTPQnPyjKFPqCQ?=
 =?us-ascii?Q?VTBA/nMgVo9h+L8Uy8BdZdZ4Qp7ded1Dwa83GEv0oLawKwO4T0DKYzvGbcod?=
 =?us-ascii?Q?1gJkOA8PXK46uEwdw8EP2/jG31f9dW06nFS9qjjLFUGHfU17lxKVxyy0rKEV?=
 =?us-ascii?Q?LIcpSgHQtJluyjAb/HaGD1EM0ktTmjHpaSRknHLTRb88v9CL3wYzIyI2Xb5b?=
 =?us-ascii?Q?LIMOBiaLnr16E4ynZlTNw0eD1/GF7rjEjrxmE59w60+8XiwwV2iTSVBvvrZw?=
 =?us-ascii?Q?rWyaWnjCnLZ+F0fVjRKAt+DhZ9q7nJ/2B0n74mzGStpaADMBWAUJPiWtF/Du?=
 =?us-ascii?Q?qV6/ur+Vmy9r3i2I6Bn+fK6FRQ3eja8HMktKxDnCBWY9WIwFnlFHpUotA9YZ?=
 =?us-ascii?Q?Dy80WfK+gmCAE9S7StVLebIuTmcUTcJNxmViEE+nzEPsIt76c/Kna7Qfl69S?=
 =?us-ascii?Q?o0hoJwxNAr9vWsonmX5oF/kSZWoWDW00mqHNCnkoPHaBgnAlmrg4Aw98oGxa?=
 =?us-ascii?Q?BAZbgYsixUFlS5tIyAEbe170YBFZ1nkur5o89NDqcqMvVbHsWPgCeaeAS8N8?=
 =?us-ascii?Q?QaH4o9dhLxU/WGJ77MqcbLp7+wTFJnUwgyRMaF8q2EWlw/uKH7YkCIucITi6?=
 =?us-ascii?Q?T/b51BQONIGxbQJMHdgWqMHiGl8n98UdmuG3Fbku1vfhZAcPQ6SBPc3W5A5a?=
 =?us-ascii?Q?YpCdt2jFDF6Q0qmUbOfwvOkNvwoSVH/4hvZwkQc6PJOJC0Q7fohwMmptXOF8?=
 =?us-ascii?Q?BF3HUgKUHrRrr4tJbhkFTCq/zCD/GIUzFLudHMXNciUhPYNHZvJCambPuKs2?=
 =?us-ascii?Q?N/GOL2lCt9X56CTZ5e/1b1FulAWPoiuWwV2nDTwAjsmNAXlL9PDD4K8GoGtR?=
 =?us-ascii?Q?PgEE0GUWhX0eLrW6onJbeIJ7GIJNiDmkBujc+0VqHsSqwvm7XVuxNZeHYmme?=
 =?us-ascii?Q?bHb0HPICeYqoSlWb73alFVgGfMoWVYGpoMpqKvYD6o6+QJTCVyqh9tXDLzd9?=
 =?us-ascii?Q?KAZMcFsohoLoePYtCzJY8HPGuljXBSEcbxv+23cRESwlZqfjRQU8rBH9w5uS?=
 =?us-ascii?Q?Uz3jvlLwi234iZM9GIAKF6D+crs1WbI7/Jz0fruUamS6kUjtjlXJKDpI2Tir?=
 =?us-ascii?Q?LLZHA8GGDQiNHrI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6J9AynRnjkP26jqYWJ2nZRvmCJvyMt/N8SMwba+nGkfR4i5crZiTN/2KyyX3?=
 =?us-ascii?Q?b2fjjeVwdIiXIYKMGgr1qEZH7ustkVgInGfgpQ5FGQi9SUF6pYdZtzy0iuuv?=
 =?us-ascii?Q?i7sz6huHkG34isPzvzeLF9DMSq+yN6oH8RjT1irNCwvMSqkXAmlEB9lPoPdo?=
 =?us-ascii?Q?t3qvA4mYb5sKGhXkLOcvbeEYOaQB4LLcco4GSbOfHCK+s1WqP2AEJkykPIme?=
 =?us-ascii?Q?6aMiqnYVeHfHAkLiXIesHrPvnzoL0vaOKVDx4JqkBldNLZX0m6FRqX4DsLUZ?=
 =?us-ascii?Q?ke6oNsaQ0r98/Pm/JnUoVF1SE7mg9RxFCNKuFhv6x5127Mi4xQ0nw1HvweNy?=
 =?us-ascii?Q?fgkVAbdVe0WmHAN6wysMNsEcAr+lxwdzG4iSA8y7MZF129JQF00dpXLKuA4g?=
 =?us-ascii?Q?FdHniGsu7q4dRdLNj1bjUsmdw+hjDs7n4uvLO2ifRcYVfJ53BZo0CcxJgl2k?=
 =?us-ascii?Q?og7DR9OQ09EcUu7/6+N8iJ8T0EIwccOWU43QGr+oO8c5+ruzgxV1WNSzBjDF?=
 =?us-ascii?Q?FRGALfbxNveJUrrz7ZFzDoI4DjYw6ZC7Of3go/oQ325gYxSFZ0IYXHGDDlkc?=
 =?us-ascii?Q?6r+3llKBZ3ATx0ng6elkGCmbapLgvck1PhtQtmyWYuAqnn3Dz8U4eSJMC0w9?=
 =?us-ascii?Q?JlIffpd6NuOz/GBgdc+NMkensCW5o7aSbrqVSx4YFq5W32ntBARrP5y/NS76?=
 =?us-ascii?Q?0Y/2duSDLhk2EBcrAdMcwEyPdPNhXNb847gMQulbm/SsZWqBfgUzkOTwzvt+?=
 =?us-ascii?Q?FGpdATaEq/tzOhbY6IS4DwM9vK6Hr8bO99VK9udN/t2EdFsXcvzGBxNxdQ3K?=
 =?us-ascii?Q?j+dJ5uhNG7WjnVheKcpX6CjwZ6UoXj2Ll0XEe1lFufOGdxseZ1bBIqWuS4ls?=
 =?us-ascii?Q?EPB3HIELCMvyg+nWnZWyPTbSibON+PU9sj8MR2GRng4poo2XoHW9vtbpYmVN?=
 =?us-ascii?Q?h/SSJkCNov/xjL5AWSIzpkWir0Ex7JBR+c9yDsPUhnvuv0xHHmAAUw0J8cFr?=
 =?us-ascii?Q?rgMzjQjxYyhsucr/O1E2jXHqmyG3NwCO9bhL1ORks2yZiclVI57ArNKVuMa0?=
 =?us-ascii?Q?3chSWnqkGdcfpI15s2ingU4Y3y8fPhyjgl4ZWttY2uHdebWcNLbXK8zfEYGX?=
 =?us-ascii?Q?P1dCOMii2Gl5taPlgaEDVWDiL8joc4wyzA//XLnTpPJUfT1Rbgna1YUfYtTT?=
 =?us-ascii?Q?ske7hTuuW3iGQ6oySFERrhNWg13d4J0JVEQaKZJ4VVO9fnw93MSbPtsxrSv2?=
 =?us-ascii?Q?M2RxysXL7UFz+MFoH5V+8Amd33Rv+0JzWPD6Fv/X8NGiZzAvz0hZsAS7vpYs?=
 =?us-ascii?Q?RW8o71dr7raq6Oa9ws7ll+7uswr7DxkeBX8ATS3Utcz8tQSBBaqgFdi7cfAu?=
 =?us-ascii?Q?nnzvQyh/4s3CBddBXE0G5NO0Cot2ykzBm+4LiPwuP85lPTiwG67tTjf4uO/R?=
 =?us-ascii?Q?R3EG4jWjdaV4+X25XMV9hxPWDqUnHWgFjGJmxUdoCE2WHWOc5zJtso+goCr8?=
 =?us-ascii?Q?7aNHQOyxeITKoNp3lBKtmM0LNy2Ne8NkSjyNx1bcQ9IO/R/tC+RVKPawEIz2?=
 =?us-ascii?Q?UuIdUHRV6wfTdymv3LsMxxC4VIevr72u1eJ4GEVc?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b4e7389-e96d-40b1-ac68-08dddd99a7ad
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2025 14:23:37.1806
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P09R/TJnGJvfhFT+2H818uKmARlExM5gkxA4MwCtyRknx/9aGp7wwUNysM5u8rEZ9LcKp0t74o0mFiV2k+SH9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KU2PPF4166F2409

Replace calls of 'devm_kzalloc(dev, count * sizeof([type]), flags)'
with 'devm_kcalloc(dev, count, sizeof([type]), flags)' in
setup_feedback_loop() for safer memory allocation with built-in
overflow protection.

Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
---
 drivers/regulator/bd718x7-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/bd718x7-regulator.c b/drivers/regulator/bd718x7-regulator.c
index e803cc59d68a..022d98f3c32a 100644
--- a/drivers/regulator/bd718x7-regulator.c
+++ b/drivers/regulator/bd718x7-regulator.c
@@ -1598,7 +1598,7 @@ static int setup_feedback_loop(struct device *dev, struct device_node *np,
 		if (desc->n_linear_ranges && desc->linear_ranges) {
 			struct linear_range *new;
 
-			new = devm_kzalloc(dev, desc->n_linear_ranges *
+			new = devm_kcalloc(dev, desc->n_linear_ranges,
 					   sizeof(struct linear_range),
 					   GFP_KERNEL);
 			if (!new)
-- 
2.34.1


