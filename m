Return-Path: <linux-kernel+bounces-775538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7D30B2C061
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 13:29:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A76991B65386
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 11:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC45132A3F6;
	Tue, 19 Aug 2025 11:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="QrgRfB3W"
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012051.outbound.protection.outlook.com [52.101.126.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE44311C3B;
	Tue, 19 Aug 2025 11:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755602745; cv=fail; b=qpUPmZwrSTz66eNX88uJ9TkQIwKtliKWNW6Zvs8HSQNomzE86scKTqL0obkqRpgtwzIxQBYnozg0ReEKZGva9hVNJ++7ylYZ/CurrSvhX07Jua+hX/TZODkSuSBSgdcMEY0ddnl7xRu+m+kPLPoT6OS/TzuB2NY1ZbuiJFaU1XQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755602745; c=relaxed/simple;
	bh=JQKaIdnoONSWv4fI///5QxYX9sRnMS8wvZaLzpj1EIY=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=B32LavW0lp01BwjklfJqwm+M9Bcz0SxqQ6aRedBATZRrIpBCF7tw8X3t/0bJUQ2Jvg5ByPO56AZS9+vBtDqOcNoGLuwq57x5QGGka0DI502E7r3IwYy1pqQHCArg0Y1U6gYA7OIFFl3RwnCsK2g1a2scFlfkf+9djStDI4OwXMQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=QrgRfB3W; arc=fail smtp.client-ip=52.101.126.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n1/14jbfKDRv6JiLK8UxTI1XU5l3O3tHzDYhEfR64s4p5KZo4p3j4aw3G/YeBLB10sospXEoPxtavsEIkt5HWqBTqEqGoziCUqBNzNr3mrVDrXsuWWNUk20IUs6cI0pFvlneOkjgsLaFCEQjQRuVkttvWJLySnLHUV9vJ5FrfFDGiPj0HdHpdA6jiU+I/tSQyR3tzVpG07n4Ckr+VHSq4w6igli9CkZMpk6lG6881GnukAuPOF1ro/ADDZNzX9mujtqcLEmxUOr8Vfktg3HWh6OYEUOpZBpNgl/IV1mV7QUjVeHxrEiXcgmwX7czdDrnJaM6vWZfJIeM9rWpB/zUFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2hftecQeLwiG2xtO/b5lno2zHfAL6YJkL8vIduygPpA=;
 b=HaA+syZxGqMVSdyPo9JRjBxtltjDb78NPCLFAunOp8Jh0r9qzlV3VV2wWHliZoVegL44HvbfDRJ66RN13EBCYcKV8NGjSg3bdrMGu6hE/lCp5X8tvcNBHruueQWpsd6oQjLiNZ0aDBkvrdHn8rkAGhcqQSWC65fROZCe4MU2qEJbxni7IKm4XmeUpR682yXkklSwsJ0YdK0Xs019AHqlIomxRrgtfUKYoWquhfwjyuTDyBRmit1+NiWiAgnHadkECa1PjccdF1Bi/H7kvhcaHhyTpfpJk9gh6FUIqncLpwUeW+H3S/7J/33ZpmkTVG1+6gw5/vacBASGO1qfor2oIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2hftecQeLwiG2xtO/b5lno2zHfAL6YJkL8vIduygPpA=;
 b=QrgRfB3WSV+AVXkMx2MUABZxTGPrWjWv+AfHR4wPEfmIxHUqWFVB6X0guJpUvmJV9NvYcyl2WaWLflbOPignbXqJud3QBH+KLUdjpITPxsEqwz9wZHPEFP1nzz414RgJDJ4yQWmTuHl8E8qNcv96psf88IyUbuIITZIGyZxKhckix4pz84luVi51OZiftcX9nTvDRdZlywQySXksmU+Fz0WEky/Cd0n3GJx1E2NDixwD1mbm5WxS73jxL66s6xWOda715H0cKZOfdPbX5dB1jOaZYw+iwBzJoyzwYJFZG0EOSHeq6Ny/8zckEuJe8dC1aBLt4eyQSTT/OsFjvu/DAA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com (2603:1096:820:d8::5)
 by TYQPR06MB8119.apcprd06.prod.outlook.com (2603:1096:405:2fa::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Tue, 19 Aug
 2025 11:25:40 +0000
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb]) by KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb%5]) with mapi id 15.20.9052.012; Tue, 19 Aug 2025
 11:25:38 +0000
From: Xichao Zhao <zhao.xichao@vivo.com>
To: romain.gantois@bootlin.com,
	heikki.krogerus@linux.intel.com,
	gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xichao Zhao <zhao.xichao@vivo.com>
Subject: [PATCH] usb: typec: mux: Remove the use of dev_err_probe()
Date: Tue, 19 Aug 2025 19:24:51 +0800
Message-Id: <20250819112451.587817-1-zhao.xichao@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0019.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::12) To KL1PR06MB6020.apcprd06.prod.outlook.com
 (2603:1096:820:d8::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR06MB6020:EE_|TYQPR06MB8119:EE_
X-MS-Office365-Filtering-Correlation-Id: 866457b2-016c-4623-5b60-08dddf1318a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JcvMCAt6ZYROVetldDRCEUOea9zwtAxldmLcUcyXsWRbNGYvJeOquF1jhj9n?=
 =?us-ascii?Q?HG/9ny/xDyOqY9sMjcF5vg+Kzd9x/MeYgiveZpHtyHnmT6ylE1Ooac1MR2qG?=
 =?us-ascii?Q?lGXM27Z68BR3Jp0Oo/VVTlwD7yHHMm5rrjaeQe/Xrm1RUgFD4p6Nsmwz8JGq?=
 =?us-ascii?Q?LceAg+r0YAvUdby0Tc/OWfFgHhzkozL3MNt+eFPWztBsHqCiFmOiOUbjYKY4?=
 =?us-ascii?Q?RCMj46rr9j7zxutHwN1qfir6lVT5oMsvTEjtrLAQjnLllzvikctpyX0MfMk8?=
 =?us-ascii?Q?1XH99bmXsugFXfSRNBa1lPs2sjAEDBfdxnXp6WUI5k1TIMBKtmphWMpSbcMO?=
 =?us-ascii?Q?AixdxDIeRTeqGf5sp5D8ZHSkEJvUZbnF1X64LTNUfP8rRSSjNoH1cgpAmd6n?=
 =?us-ascii?Q?7S8WVDzIe0BbKluXFgOHtpdhPChR5lv4QwBWky5ES4fKnMKwEKbx4NbZRurT?=
 =?us-ascii?Q?HAwzKBjNEM6V+uVZzAqOVmpITDFlZrEC27S3gt+26XJe6j4DuZDnR+ncHOaj?=
 =?us-ascii?Q?pSfGvj8qD4muO6zcnswN2zjPcuk/32II0LGyO+2VOCud/PdWK+UNn2Wl5wjc?=
 =?us-ascii?Q?W2dRI5CNwcdoBGNiEwtXZKa52CGPZtLe1U2CWkZkwQG+uYifY2pl5Sk5fIAP?=
 =?us-ascii?Q?AH9+Qhjlnv1RbfDpmt8gVEbrE5fi9NohOgAa5og2/Y0ZjB2XeYKEkVXpd5aa?=
 =?us-ascii?Q?XFYp2Qw41S1SeMOnuEwmKpi5mzEK8bCep9DCukayYJPjNtyPftxJmQhC8foX?=
 =?us-ascii?Q?9BUM12hVX58b+c2jgqqxq22CdfLIz/WjHhkwbEV0/3jOe+hEa/td7sTdOWHr?=
 =?us-ascii?Q?Gyspd/F5RJNeDBenjpZxGx7T/2p99jX49tBPznE8vHKHPo9EyOs+jY2odSu6?=
 =?us-ascii?Q?bKE4tQYMy8XVOifOHo5Frj6k/Ff2vMgyNMi45Cvt6nN+PuEIV1kHPOMw2S2z?=
 =?us-ascii?Q?Tb+uz7U4uFujmPj9jfe+mHDZRYHWhh3/RDaHI/57MX15R1E43XbmmznJqlDI?=
 =?us-ascii?Q?Uq1N1rUSxLF6GJw83MZEDvRvnZqDJ0yw8ZkRWKqgCe+Uxb1Q9m3HPLKUhWbG?=
 =?us-ascii?Q?TTA4yK0WgrQPOpiqXfAdHb6qhnAHhxXTgBelcljGriYe81xJ2SJwl+9iBdc6?=
 =?us-ascii?Q?OkMsUx5V+VSWtvJmeFzx9kgSPyuuHyNp5IkR0ZJgFawGubYGGmHQ3zi3/82w?=
 =?us-ascii?Q?cCOHw/2TQznv6PCjmATQC/gyoHMXEvQ95pLQP4sY24YPeIqq6zNcYXWIxGWP?=
 =?us-ascii?Q?gn/cjOQqnwPHHjj1Lg7kmGUHR+KVtWSuhkKPJzcYQ9uIaExW2xyc7ZZqf0gp?=
 =?us-ascii?Q?KNi3hYggdpPdHTeNeI3rObNpNnUX5fNo+UqNdd2KpSy1XBvq6TWt7NwOQhJC?=
 =?us-ascii?Q?WBTUWSM/PKGU3cITcXjrEq2riRAKLUZ5/6uO72dz50HFPay0FwK2FcWJPvTV?=
 =?us-ascii?Q?2C/MDG3nDDOSPGs1bKDVjVv56Y08Q6/1xl5mGRzA/gwgite7WfR4fA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB6020.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Yb+WQKN1uodYeXSZtZw0wpsgP+IcPpRzZ2+c13T5m1swtZPtnsf+NFIOiAk3?=
 =?us-ascii?Q?Kxl8t46f+UHDBGA315qQ0p7DjVp26mFblV5Qm2OcCWrBcGGBrDSKqKL7UTRj?=
 =?us-ascii?Q?JezwtpwvDEJ4Za1TiXzEvTso/h2skEUA//rxTAANhlzdiARMK9Pc01dGPFmz?=
 =?us-ascii?Q?yhL+kTQFdCnJWUSBlVQsAx4XCQ15CQstD7IuGqsMpIA/A6963fGidhsj6U32?=
 =?us-ascii?Q?oqbKOTVzMLkbenD4vXDfQPuKa6FcMW/lZE/PypHOlPFncR5QSvAEt0jGCshm?=
 =?us-ascii?Q?GAVjHQfx8HjuX2A9rtTYbF3dn1+/VIUXoWyYir1FeQohHf4NBJToQb1usNSv?=
 =?us-ascii?Q?axVGAcdbT6Pa3O3VN7KChXKDQK9eyuzTsmhHGjjRFiomfdufI7OSW+96x0X0?=
 =?us-ascii?Q?bZ4HU9tGVTirFbdaMMORA4hFCqaBSrRctK8Fhs2w1UaOiU4m0TvQSnF7MahU?=
 =?us-ascii?Q?HSxYSIkvUyBp71wLqYGQzmiVk92el5KIMMpH17+lUZ7GGmXy8lfYNnuwusmC?=
 =?us-ascii?Q?88EgPdxIlTKjqUk7yYemu1DIP7u6daqLuM2IJ/lovkc28sId3oHoZ6LbI3To?=
 =?us-ascii?Q?6v22REtHA8pScJmfOHgQe7VzRjTFJBdOQzlaMbmUOpf7VcSG/fyZdGT3Q188?=
 =?us-ascii?Q?W+QZrL7njT2kFNktbNx1sA7VQcICZrz+1U2GQhXXcqgGEviM3kCnrPzM4TOB?=
 =?us-ascii?Q?Pu2uLXO9Q+7B+PQSyKDgcqTDRk+8GSz27auCd5euPQ61FoRHC5crkwz5Bxaz?=
 =?us-ascii?Q?G7lU69DIL6LWCaJKzM7Iks8NqjjUoxmIUijGo7TPEFYB/SnFYFi26vTmdPA5?=
 =?us-ascii?Q?ODQlEaYaDzddBp0PdfJQf4GgKKK5nAayJmLgf/KQo5/TuFa6N3DySDWjp2bT?=
 =?us-ascii?Q?wqtI8ZlEkPy3sRERfJY5VfSQsaB+BMTzYF4mKtGTytsn9OMgd+zDVTh4sytb?=
 =?us-ascii?Q?wn0QLD7G6pWz8f4ZIMb38qhvo1u0ZEr86rgx1FFJQV4UpQC7mSRZKjxWECEm?=
 =?us-ascii?Q?htxdLYko9Zb0VepwUjIzbzjNRkiFHbraGIXAoCToQF1b9zjuRRM/Az+v817E?=
 =?us-ascii?Q?Q5xU7/g/S6fvLEXleyLurof3RKtk9ivxBxY6ACzmGK9EqfYbnd7QMmRsPC/+?=
 =?us-ascii?Q?ELxkyVvhKXqc5zKEgLtQ2MiCiXPGwLaW6hxcD1YJ6q9bmWZGVMmvnG7P4pHN?=
 =?us-ascii?Q?d8hVU0c0LV3mAtqungv3n+m9FiDPW8wdXHsCkfIO/ylcs6Bqgek6RJ64noyF?=
 =?us-ascii?Q?Lgnx9nkTaNPb4EGoWKOUcYUAL4+ogifYLzxYnzf5YJtLbbZkjAgHox4jjpiD?=
 =?us-ascii?Q?Tx9S4G5doex9pvgYXXAXD7M/e/tN8AN7W38bLt75zxBEikpVXJe7RRtm+VbR?=
 =?us-ascii?Q?UOsw+VnFqXGkfxUWE8FFfyQbPScaZ/adT2erJ5t7q4H9HCnmjZbMmzDWuuBY?=
 =?us-ascii?Q?zBYcttk6/UiDiZL3+MZs/HDD45qnRq8RzZBr6OXhzRFci9i2CbwNlnAYMNBO?=
 =?us-ascii?Q?TqwhhKylrN/Ur29pfg2At1u5UIg6Aedg0uYliyfrWtvx9Td6JBgAPoh0Kh5p?=
 =?us-ascii?Q?1vJmOdNmLVurXJrkxnQoLrQi4rKTcotdNbtMacAy?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 866457b2-016c-4623-5b60-08dddf1318a5
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB6020.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 11:25:37.7766
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fkVPG2KOQh7tAi8Hx+E6lW74fu2H4s9DXO5FzsFVXfBrmQyAYg+ve0ieI6JIdtw/LZckadYTXjKa9pZew/bCoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYQPR06MB8119

The dev_err_probe() doesn't do anything when error is '-ENOMEM'.
Therefore, remove the useless call to dev_err_probe(), and just
return the value instead.

Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
---
 drivers/usb/typec/mux/tusb1046.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/typec/mux/tusb1046.c b/drivers/usb/typec/mux/tusb1046.c
index b4f45c217b59..3c1a4551c2fb 100644
--- a/drivers/usb/typec/mux/tusb1046.c
+++ b/drivers/usb/typec/mux/tusb1046.c
@@ -129,7 +129,7 @@ static int tusb1046_i2c_probe(struct i2c_client *client)
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
-		return dev_err_probe(dev, -ENOMEM, "failed to allocate driver data\n");
+		return -ENOMEM;
 
 	priv->client = client;
 
-- 
2.34.1


