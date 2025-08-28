Return-Path: <linux-kernel+bounces-790256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6191B3A38D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 17:09:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C9525E3CC1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 15:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09E79255F22;
	Thu, 28 Aug 2025 15:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="WFLjj7kg"
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013038.outbound.protection.outlook.com [40.107.44.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017E71F1932
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 15:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756393640; cv=fail; b=aZNp4tuUkyadfOU3X1AcE04IxgzXzlkifQFUH9P5COHvYt2Ggsk/4m7xx5nTviPSVg8j48Bl0+D61WSOWsh49BneyxPMEDJij7K6LL2Cx59PJGG+FtvUXBVgcMipjkdC7AiEapQNUTw0vyWXG5AKgv/Q2OyDBN7nGxP46qhwvmA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756393640; c=relaxed/simple;
	bh=GcdcwTv8qHzoTBn0ExM21ihtJGCwxR0K9OhwELPP9To=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=so4zG+03+pUhjVjMMv9CVgfhtIxT0VvEsPufMaprIqFvFbDd/+gW2I0Np9Nd1KA36EA2Tv8WTBI9n/52pC5WLiR81VlcClsDzQtqvvPTvBuDIfZV/hQ4YBaSUX+5SMJPStX0q9RZnMr9P5MDN/c+falyVYTCx54N4oi0iplfDOI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=WFLjj7kg; arc=fail smtp.client-ip=40.107.44.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MWIEO6DfXu/ZRi5ZtEfFj0iLKmvNCe/PWUpa84yv7Y3LnGca5PeIji/9p7s8avd7H6lLkZP/E3PFgAFP5FUIQ2PwjNLP61ZFcc4/U/TAIWB/FTy9MjGFePzsftU548ajkbtHAV2pk3f/pY3mh9Hc9QcjI5dJtwL0+8GL2KADJD5Di/8CuTzQc36aAChGykCJgC7VKX+Cv7YwXykaDQrU8LEFdEK6aDyaupKx1izb76kkXQ4qex6iWHVZ2qf/vBLPmvsplQEbpjHuxsHmTPHP+/YhbsMbUpQYxR2Nx6eFZ57FP768cAPVsgqAQ1CMxpL3013jIeKXklwd7LEoo3lP3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zFW/VmBOnBtQUUeJM1veQz0wUKn4QhHG6Lo0PJSrtgE=;
 b=Ua0ZQhkmQNWhlfT4RV2bsyIGUkWxwkZtNoptoNv3mN81jflDhTXA2D9ta53sPuc+1CqP98kydpw1Cy/y2oEf0XQlBtDnOU3KEzrt2btwISkfTzF/fap46Q+98poHvahz97Ipm520+RdsXeLphNNuzkuDv/nfUXxcg92IEMhE+ai9KgW0M1fkK+7sVExmY8DJSEcC/59aK+m9ReNpKu9YON5avkEOFdRNEDvEam2920Ao84kG2fxRwe4c20vKZ2AQXcoMXf0g8qkaw9QVPuHAX7DniVhjdTf5zWdhFuUpTn/7sGTO5N229hQ+2qFtQ25lk6v+8+lzX5iX4uyYcEfikw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zFW/VmBOnBtQUUeJM1veQz0wUKn4QhHG6Lo0PJSrtgE=;
 b=WFLjj7kgGVijweosapnqb9K2fos25sBYEHyC8xMm20xve4f4AgXMdV7lSES8G1mQnBi/SkkXsOAB7U5yCB1WucYAw4M/BUnyQJ2Smng8VC2lkhpxMNErTeWNGAe8192u1YyhcJ0amaJryBwcNXbqrw5/QfGa+kWZClTdcFfuL1ifYtNbio4yRixcLAoR6BDcqXzrLnduvzeToZ+IkjFXtYbNScdA/U78d7pTLlygBLS2fEnjyJBeeq2dlfE1YcU1mJCnS5FiQKzwjdj0AGOaFIny5PPKNcX29JEW/Ul/pbbUY5ntQzS3o8D1gsnjQq5Sch63uy6vT+FupC33wzmuCw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 TY0PR06MB5495.apcprd06.prod.outlook.com (2603:1096:400:266::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Thu, 28 Aug
 2025 15:07:12 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666%5]) with mapi id 15.20.9073.010; Thu, 28 Aug 2025
 15:07:12 +0000
From: Qianfeng Rong <rongqianfeng@vivo.com>
To: Mark Brown <broonie@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: Qianfeng Rong <rongqianfeng@vivo.com>
Subject: [PATCH] regmap: use int type to store negative error codes
Date: Thu, 28 Aug 2025 23:07:01 +0800
Message-Id: <20250828150702.193288-1-rongqianfeng@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0062.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31a::7) To SI2PR06MB5140.apcprd06.prod.outlook.com
 (2603:1096:4:1af::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB5140:EE_|TY0PR06MB5495:EE_
X-MS-Office365-Filtering-Correlation-Id: a7b57dc6-281c-40a6-588b-08dde6449132
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dYFMI36URw9iR9i28t4v7IU0XW3Vib8N66vaJbA6X8H2nkzsy9JKwZcugl8f?=
 =?us-ascii?Q?mGTaw7JpV806NuceLEbhygpgXTglMSAwIf5BahCv5QEejGRxsY1WcUUUl0x2?=
 =?us-ascii?Q?ev3Q5GzhWtNgvX0Sr4wtl/2U0q9P2oKCRPCxT7RfxjrekJlag4QtvecHnoKu?=
 =?us-ascii?Q?3iYGtSKBG+RDgx1hKB9cw7hSpgP5pGl+SyRBB1rdCvTuIlBYboqhT5ekpOmm?=
 =?us-ascii?Q?uM2kWFLH7jPFuIwu89hUg7L8lFONq41uPZOjH+QUDvqTvaDPeOe1ogIPFD6Y?=
 =?us-ascii?Q?nr8AYOnodWXuuTKt+0TVCujUtpbIdoGMWOpwP3Ykg7+J0354R8AQi2ms4kB2?=
 =?us-ascii?Q?2MJjgfLpiBcapoq3OuBT0DZmfS/H6DfjzNZaNGUCCqq6oe0SsA3FCPriOAa/?=
 =?us-ascii?Q?d0KN5GX6Rzy25Vv1ruWeRzFqGyok9Da/ZomQhoLIm35BpvpgpixXjQDtX69n?=
 =?us-ascii?Q?58cvqPkEflsc9wReYZfZmwedHHdI18VgZX4Evo+HryAEUj/eCD6gsGWBD5oZ?=
 =?us-ascii?Q?oOMcMWdh7oK7S8pkSPlKd0lM5lPGUeA+cVISndL3e0KfpXTZDxQwna2pvRnd?=
 =?us-ascii?Q?9zsVaCSFfeqr0JyY58pParzdHNmb5m886bNWScLxguiClNFR7hWDY0REsmUv?=
 =?us-ascii?Q?Ddja3ktZhn7oH70YBFOLCUJygmzsqagljhCa6LW3rOEx3DjblMWlDuaLtT/B?=
 =?us-ascii?Q?uvcAt5vH3FZqtuMTIOqRTaZOvl/nrKtR4A6tQBgpFA4MEJSeQZyEbtyChkwW?=
 =?us-ascii?Q?X+g7vHyhhteN6h/tj4yG1wti636unS/ShduFn+dCNtCHy6vjvAaRlUHCNRYy?=
 =?us-ascii?Q?dJRfzssSp4g4+CrGrNBn34LaIQoyfmGaCpjcphiKN6tV9MguF3PTVB39XuQy?=
 =?us-ascii?Q?5wjVEys3KwjZBkUiVBJlxrhEIe6LX8hQVZdXVN4vmD7bA0zh2ivI5SXZ0jLP?=
 =?us-ascii?Q?AWQkA3xKi2rYtBbqcwT0bLrtaNtkBl/mU6cIugD3MkZiarfEI7vwf97jZWCg?=
 =?us-ascii?Q?1i5GM1x23mT4WNuFo7tceew8EdqdIAgHYc+93i6LRdf94g/rsoUxXV9zrGso?=
 =?us-ascii?Q?rUcurXLQxdBr5DAyCN/pgMk22xWtblXG5XPC5+NjoaqAh1QvADfwQiT9dXpo?=
 =?us-ascii?Q?VAls7yNUsM9MTSdqDvDVx1TDa/EVmY7VXer2X4F1VYLZL7+K/U8pvoAzPZxj?=
 =?us-ascii?Q?hhx2E5lf3YcxacNq0/ULR/26Uu8KRTlYa0zi9Fr36K3LCt5x2AbGDVW7Jpvd?=
 =?us-ascii?Q?9s08QiE9BhiYAkr2GIByiB5NIi/UIQQOfdnJt5FNZEtmLOHBQJtWbqIwd3jo?=
 =?us-ascii?Q?Bd1d4aukEmkWOHrlqaPHaNJ3UHhBFjzmHrRrp/icm+TlDleRbUR8hzWiDalp?=
 =?us-ascii?Q?vAL/88jxQOX5Medf2bATTS08EUo1JL2pVeoK6ssghU8fUjWQnlaJnvULqthE?=
 =?us-ascii?Q?71zr4SBDRvxaJemJZijkSfdxMUNmW6APMkPW/e5SLUxnlLiAfZE0NQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KShWwqL8ufR7YGIZriogpVQLQktJdUK71N9yGQE73JiKdcIuZ/4UfKZe4ga7?=
 =?us-ascii?Q?0l0ugwPby5GkD4pdOZ7d1WSa8FLv3HwW0rKK8ZCUkN2gYnLiPWytWa9xX6Rf?=
 =?us-ascii?Q?yii8NlF3SKx9h77lnpm/dIWKqHy68LyD9b3k3qaDACwucGf51gMqS0hrUSBq?=
 =?us-ascii?Q?53O/eySyNpHcxpMDiTq9vNTgGfMm1lfErlYNJ/DVmB1c5DQy5wVy1LJeopYq?=
 =?us-ascii?Q?lAYyQ1bskBW1vVUs+jhj7yToq32+ZSBnS3j3gluEo2LqpdikvrJChvwAn//8?=
 =?us-ascii?Q?k8fUS8uq6324DTj1F01ErHxQ0wE1UUTxbqSMGl71w1ntKl3ianqZfGFeMNZE?=
 =?us-ascii?Q?YV3gUf29ZHf3hFSx/xcw/GI/Tmu7C2wUvuZJf9DgF6TULr7jFfN5dmfsMlE5?=
 =?us-ascii?Q?7Kl+BVi5ZowED6IggZ78k9CxbFhPHOxsYkXpHSc9pM0PpoRF0s0gYX/y7AtQ?=
 =?us-ascii?Q?nCPNqXCuAHBcYp7r7p5dw5COvP2BObPaXSA9q2goej5WPlHM38kqRhwhj4UK?=
 =?us-ascii?Q?QyZMZJiqT7x2rmaseiJwLbz7XoBzHnDz18Szn3onmzXclwdEocDYBdoq3uIX?=
 =?us-ascii?Q?spek3quDaz5zryo420v4+1SNwsij2c/rkR/GUoMqZi8oQPnKj7KRysoMbbPF?=
 =?us-ascii?Q?mmI79z9mgL6lhl+ywisCrphJT/uiQ/HhyyqpnxNEHsiHFSuHaqBYaeVk8yqM?=
 =?us-ascii?Q?Hmk6vg7wg4xuGebWlecif7+Axad8ju505p+v5g3aVboxpd8kvwrV+qnw89XG?=
 =?us-ascii?Q?UjVoYFjQOvfln/JFwURjQAYXbphqd/sUyrLp5oZ8y5lcLWAj2RXaiCUJTo35?=
 =?us-ascii?Q?tz2wdMyUSUihJEGXACXZxkxb0cLRvGQ7M6zO2hFyDK/qtqR32RBGmCr9xunY?=
 =?us-ascii?Q?gbPxW7Eh9CfZK8LRBUxgU/3JJ1laS8yr5ImMrL57YhAm0d/yye2k7UuWfhkM?=
 =?us-ascii?Q?1SGR6CX5PvdKOgbMXr4o4/aAPGob2V43TtW6a8Esg/NzjQhErWA8eFsWoO70?=
 =?us-ascii?Q?S/wAkYMxIY6H+NQySK5RlhZ+T0KGKoIO2UejGX1QTHGWk2POu5bTGI/HBDlf?=
 =?us-ascii?Q?XmNFfqipM8oYzhQB8b+iieKny83Ys10/wJplBKfFrVJPdGiVRJQ0QVSQrSby?=
 =?us-ascii?Q?wQhPxrpjaoHpl7ltkMA5qVTj6UjadUVHWs4WaD4fFB6kcz90w/Ud+KpY56r7?=
 =?us-ascii?Q?wsIcW0BI7ILjMUycCWbgS7X3IsFmBY8YYrM5+Sa/Zz4wZFU/ceug8LC4oT7F?=
 =?us-ascii?Q?eoI/QSXDv/2UZZRjYUjMhKIRroZ+EROuErSEbM9aWYZVxViDLodWTl2KXRcB?=
 =?us-ascii?Q?G0LIxPOgzSMajpFmaINonX2EmZv7WXFnOLj9d8psae5cGSOtTR47YkpWL529?=
 =?us-ascii?Q?giXubwQqapKTXdCccbpRIsrcXaPk+6WDi/78WARi0T4LugskaJVsiONfetep?=
 =?us-ascii?Q?j3XhVGk3odZVEP6cxvngMQxQ/9G2pwA0eZ2Kt2iIHvmDsjhSFOdjt2l4jrK2?=
 =?us-ascii?Q?dLySP0KC/Dq9ETW5lqwYml7WGrUIiucpRDbZz55n29czRYTl6lQ3Pn6Solcx?=
 =?us-ascii?Q?j1UhVX8zryrTfnbhayr/J62ylP+3iJNJwGSvEDY6?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7b57dc6-281c-40a6-588b-08dde6449132
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 15:07:12.6065
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8ikPp1Vo1lce7LukbIcUtu7pC2DP5YafwlFL/isr89qgebYOuChWKYDGGB6S+2tn/Y9tmubpVbfXuNteja4Taw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5495

Change the 'ret' variable from unsigned int to int to store negative error
codes or zero returned by regmap_field_read() and regmap_read(), and change
'-1' to 'negative errno' in the comments.

Storing the negative error codes in unsigned type, doesn't cause an issue
at runtime but it's ugly as pants. Additionally, assigning negative error
codes to unsigned type may trigger a GCC warning when the -Wsign-conversion
flag is enabled.

No effect on runtime.

Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
---
 drivers/base/regmap/regmap.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index 6883e1a43fe5..ce9be3989a21 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -2258,12 +2258,14 @@ EXPORT_SYMBOL_GPL(regmap_field_update_bits_base);
  * @field: Register field to operate on
  * @bits: Bits to test
  *
- * Returns -1 if the underlying regmap_field_read() fails, 0 if at least one of the
- * tested bits is not set and 1 if all tested bits are set.
+ * Returns negative errno if the underlying regmap_field_read() fails,
+ * 0 if at least one of the tested bits is not set and 1 if all tested
+ * bits are set.
  */
 int regmap_field_test_bits(struct regmap_field *field, unsigned int bits)
 {
-	unsigned int val, ret;
+	unsigned int val;
+	int ret;
 
 	ret = regmap_field_read(field, &val);
 	if (ret)
@@ -3309,7 +3311,8 @@ EXPORT_SYMBOL_GPL(regmap_update_bits_base);
  */
 int regmap_test_bits(struct regmap *map, unsigned int reg, unsigned int bits)
 {
-	unsigned int val, ret;
+	unsigned int val;
+	int ret;
 
 	ret = regmap_read(map, reg, &val);
 	if (ret)
-- 
2.34.1


