Return-Path: <linux-kernel+bounces-777234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B09B7B2D725
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 10:54:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23CB4188CDE2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 08:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D1402DAFA5;
	Wed, 20 Aug 2025 08:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="gtmRLWd5"
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012048.outbound.protection.outlook.com [40.107.75.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954E92DA75C;
	Wed, 20 Aug 2025 08:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755679876; cv=fail; b=pXIO13rmMJiwhP1+P0vVppuDFyhZWkxSpV9JautRRUeig6aJl05e2kKMTlnxGWH8r9mfVSurV1TWYhdIcwf6t7MWj9ieMUeqYplwmNDWG53nIJ8vO8Gd6JctAqWFd223vpOPRnzFX1mwwcoXzvstZoW33i6TeKrCFe1dBldez9Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755679876; c=relaxed/simple;
	bh=ncH69ZKdIv7Kj5jEXdia8sRq0UajLOO/7XeliW4QFB8=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=avlXUBcBP9t0SLzuxu4vkHyRMGZsk/rA3eKWmGazwZ7AfX5QywZ21YSXnSAY6fEnduIU9tjqi8VH7soWNf27qOimDxxiBDg/0RsESy7l6ocjXmD4kCWuYWHSxspibOJffjKpBm81g63TNCxDyaAfYqCgbn6SM7df1KDtoH30nQQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=gtmRLWd5; arc=fail smtp.client-ip=40.107.75.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fLel962KXW/Htr/viMJVlsi75mL4NsJbMF/zS4ubxOz+4FEcOj1mO/eDJQv01ZIyEGOHNSci1ERU+S/i1ui+I1tE9+qQw2upa1w9y7SpTWv4g8eMnkADajm74h4XoB5FuUBF46iOilX5tdbIOqxG/lqlA/mTwOMpdwUdFlwaNBR681dLOqsahgyFNOhz/PhH88xc3Af/raD95eA5yTTTBVHPxhdSm2B6C/+uRHFv+CC4BlVwi/nB7MjDxYmq6RnIhT2cwyYk1SubsbH4sL8iU/jBDcRirLIKKApO2Y3WswvQ33yfDY0vU2LeO8TzJWIlW/lec4i9qB1qNB3i3sPaig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W9WQacRj1xJAjUUcLTaF4YvTC9vLo5ZySIZzpTJ+dY8=;
 b=bT8AYVysMynmH5dypYutIN1I8WZKWrpzU8W2NEJK58cV7wce5JUCWe5Y+7lNv/C4TyBG2HWFj0A3T4QTEr5SFxkI0U8o02GQxemFdniNv2WAJ0jQMjeu7xo9ehj7OTDRJSDf2YPTWQvPUdyJwUE5wSutcW9NHqMuszJTodlBRPmpikdG8WkcxcOEzVTUEnt9UOll81iK8a7BSD4AQXpct/gj6ng96m97oP3hOEszuJrjVBabJeIIZbCOCZIFNS2RMqi9+VNGERRHTHKZYdBbGLaqQUTJMH/KzTn2L7kDt6lGhn1kZdxo4kMrIZZwNRv2ql0NpXw2R564HkkOIFEGkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W9WQacRj1xJAjUUcLTaF4YvTC9vLo5ZySIZzpTJ+dY8=;
 b=gtmRLWd52sLCSZn0qtRGexcneumZuCqLcDKjkY8mbf+zT8vYJLkBgov6blHDwHnXq600tW8kEVyeeGWXnCN856Z4cJKVbvO2cllZQW9ymanZvc8dFgQzJgQ8TkOin1liqboRQliC6em2IhA/9F4SEiRI152u1vLRMWlldLgpwwWrGe1CHTUOPcYR1CMh1bo6Dh+Bmo0Ig4Ak8ZGfrw4Pn4GvlzV9vPKEALC128hX+T42B/u5I8BfN6m8MDFC1UDsQXvNnxU16KteF2vNe7SExxxEFazn35dawT7/egBV3FE8GtE0wwKIM2ddDQnmBA6m5e9zYsw4TxfOvIomrogLFA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com (2603:1096:820:d8::5)
 by KL1PR06MB6887.apcprd06.prod.outlook.com (2603:1096:820:114::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Wed, 20 Aug
 2025 08:51:10 +0000
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb]) by KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb%5]) with mapi id 15.20.9052.012; Wed, 20 Aug 2025
 08:51:10 +0000
From: Xichao Zhao <zhao.xichao@vivo.com>
To: hansg@kernel.org,
	ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xichao Zhao <zhao.xichao@vivo.com>
Subject: [PATCH] platform/x86: x86-android-tablets: Remove the use of dev_err_probe()
Date: Wed, 20 Aug 2025 16:51:01 +0800
Message-Id: <20250820085101.395377-1-zhao.xichao@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0249.apcprd06.prod.outlook.com
 (2603:1096:4:ac::33) To KL1PR06MB6020.apcprd06.prod.outlook.com
 (2603:1096:820:d8::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR06MB6020:EE_|KL1PR06MB6887:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a5b274d-4bb9-4e76-89b2-08dddfc6b575
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?A6ydilqDiOGxUL0SICWMC+GibmUG9w8L2cY/CXWoUzcQsDqz3d0JYyjjAPLD?=
 =?us-ascii?Q?QbFF4jQSdmrxSot0Bazn9q42917wnCAdxc8TfIKGLB7DhO7Z5PYFEAepMpJw?=
 =?us-ascii?Q?w2w5RGNViNipXdyvy60qS65x0JybdWDdTsL+Dr8UHaYiKSs4tlW33zCeNXd+?=
 =?us-ascii?Q?gcBpP7cGF/Wyli2lXkyIeGYZtYUHQuoxW6L0TQdyyEn/CN7ji4D9IUE7als7?=
 =?us-ascii?Q?zdxNa2jX4/pEt3AW6qG/2izTcZwf0M7Rt153nhrHOT+w6wZWnjskviFwkdtS?=
 =?us-ascii?Q?YJc6F1vLJ39whMEtTXcAtGnGzINl2LlLoLMbusIH8V7S4hoJxec8rv+J9K4c?=
 =?us-ascii?Q?UTqvuXAcJSBL0Ke+iswLoQGWq62ZqMJzXT1DTLvDWHfi/eqr2xzjBtn8U9ch?=
 =?us-ascii?Q?VVTIxOUMKTHOdZPYp9nvwqKjkKyXSrytCvhTAHQZ6pV0wuRHdgBgZFXriz5B?=
 =?us-ascii?Q?8rCSqKxCcGTmHLLl6xq8dXGAb/U0IJO66epbHbz8QnUuq2+mmKPWkJ6bnCuQ?=
 =?us-ascii?Q?8nQzw6Ow+L6bVFONgf2CBdYuKD+DBoTcrqZnGn5dq7/8Qok49VM2Kl38UtNy?=
 =?us-ascii?Q?jx+mpwFeAKGB90Z2vGU/DHTETeNhaHRTYGCItT/V8LyYWS4NcfCIq34GmBqK?=
 =?us-ascii?Q?bOLbLJhyMTc8RYMACrn03kwnriSJSTh+qNLlvOA0PrRApFHIhlCBXofMfODp?=
 =?us-ascii?Q?J/TkooJNHBiIBdeWmZrTBaKHQowovs+qcxcZ762gFwwMqWIaMxiqsJS3STIE?=
 =?us-ascii?Q?k9/zE44UEMqAPpSAUG9sBwGkzqyoGzh58AjFb+Y9xTS1AqoN60WgI1ZUEPls?=
 =?us-ascii?Q?2r3GJgs0kpYEMZr10NDoqHjIx18jsF0WR6op7SPGxyWKy24BXp5aFYG5rrV0?=
 =?us-ascii?Q?IAZGng54Jsf3xi4uPyKg/j6pvLCYPYObI6vZhKhOH5A4M2UX1aDNnAVWlt2w?=
 =?us-ascii?Q?DDSHGK1Z0XvvuvdZyHR83JZGUYQ6EtWhIXYt4sVEcSpZObxyijkKFZjIUQN+?=
 =?us-ascii?Q?2jmDFA89FM1ranx9+TbOXu7j/5EzK58idTO9DITxR8Gm5K+nZH/EnTSLdw+E?=
 =?us-ascii?Q?44kSXr1K2ObSl/Q2Ii+itz+Ir39PiwLT3ou8+EikA3YpFQSdWLSCjOo0/+G4?=
 =?us-ascii?Q?pdoWPNQMCvPwMiPCCuacBvJx1ZGtrKqoQVjr3/8C1OQF1l1QzymoK2TkBmoI?=
 =?us-ascii?Q?WJceYaYTqVCvUKvk97gxNEPGG90xZZxwpX/QdqLLCKvqvvfCQUva9G6EPjyg?=
 =?us-ascii?Q?q5WlQhOG/15bROJkZuQ21TcTjD/IPqoZmumubX4jJuCH9Sb0HVpkLgl4TgiE?=
 =?us-ascii?Q?YwQ3CHXHLnXzde4Oi5tmIC4HMJiSdR2eNOzHJEhirwXAUmwL/YfxCjCIA/wS?=
 =?us-ascii?Q?it5PFjbOXBzWJ4zFXaG+b/HY7dCVNa+1AICF/Kgjje1gIP+sg4zIQTPf5SsU?=
 =?us-ascii?Q?ycVYRP8XKFaWG5/DlG9D2awMymxFmJT8F39KtHFul/ECa4/eRVxhPw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB6020.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/CpyxK9cs7gGBT1Y+xWHRNSm4XdNOKrlYtfmprt48C0I1hFnT0Y/DJVKbops?=
 =?us-ascii?Q?V9F82vdVLy67/H9YmrDWt3b5cWUHd3PljUfrhg/eJQarHtVmXi+ixFhnAKxv?=
 =?us-ascii?Q?Ln55qQ1IVBtoRjFfsxeKpQ7KXJpK7UdYW1QVwng1JwwSI0rIic0Mqz4VNM99?=
 =?us-ascii?Q?/TC+B6i5m4Hytby30OJdYeNnh/WtCMahg2PdQDtAjwImu4xrPBIHmE0yO/Fp?=
 =?us-ascii?Q?mf5DRNDaubIFu+5rC607QvoJCBsyO/ugXw6jC2zOUAS/7+Bwb9mwOJHuMPUK?=
 =?us-ascii?Q?1fbqQUEJvdfiP3q0PQXQO+dv3eUYlsQzBhbZlvCo7Dru0eIrG0IMBDL8kWOk?=
 =?us-ascii?Q?eOV50hhX9Nm93uuPh5XSt8zWnHXiYWzdbWwZS3df6MIMoROnt4IhBPkOIm0u?=
 =?us-ascii?Q?NJJmReH5XGzVbLRZC9749uuO2zCGEcP1RIiBArBqADGZuL6Cck397mNUnDeT?=
 =?us-ascii?Q?Y2bXMm7U649oGOat8dxR5NSG8o9KlqJF2mae3FFzHdcAND3E7tEPmRACOTe8?=
 =?us-ascii?Q?iCWg/mqz28feF04YkpDk23TUzpMvCdUy5YQJH0D4Oe9n47Eg44HPGAI4MWXG?=
 =?us-ascii?Q?MyEYMzlD/NGVzJ6ydJ2nRhr0V/T4bhvxKqt0vmGKOV1cm+0kwikRj4cl7KXj?=
 =?us-ascii?Q?Drx2S+a6mz0HI7E8kAuKvd/LOjNkI/lG5CUNbhSRSX8DJWJUQIaiOOgkrwlM?=
 =?us-ascii?Q?5Hdx4YID/O13QjyjbYKz8wsHgfwLP2F5R1KSfUy91jZ9/siWVNuBaF39YYqz?=
 =?us-ascii?Q?HD5Rqh88c1oSFvIibe6cv2OJR35QzcCYBVaTgo/AAJrmrsPLhK1f1+sLD7bE?=
 =?us-ascii?Q?7gyrCLcMfIjL928mdPfdsS/QJcNN4reUfN8HGnia2qsvfNNoKO4FPHj2dkrm?=
 =?us-ascii?Q?AzYX2Q1c5UN2ZPjK+zXA+dds9Ayt/UpaGImXnlMwZUIeNQwl0aRL56M24+0o?=
 =?us-ascii?Q?7yQexJHvedNOeoiR1e/FAtYc541YQuV4TroEsL8kuCjXcxx6INDKy1hkwX5W?=
 =?us-ascii?Q?lM2YljgZQFDluTON8RmYBnkVMrgHsUDiCYTo5uWpc1UMsoYb4z0gQiD7kICG?=
 =?us-ascii?Q?ZZlPVoL3EQ+ZqrqDFQSX8RKq4BlfD6gTnaqGs3OnlvN5gKNHyCQ304N+j8rm?=
 =?us-ascii?Q?5ENRkLCS2Q8S/722/NH8vrwJOlAHWgQYIWjVbZSAgSzoth66qIkgrG/RopQY?=
 =?us-ascii?Q?V6ar5hk6FmLXh9FFai7LDXRsHckrKtJ+/YZjJawLanyYxHthTxCk7DP3Ohh3?=
 =?us-ascii?Q?iddW7K1Ks/ksrEbcwxoC15EhaO+nTVoMPClcSbceX3dablpp1nZ+rlY4jwap?=
 =?us-ascii?Q?GxhdBRe5bDtyqRIGSGkpYCGfrGrDT+55vXPQsbZV8hAmjuJGDKB3v9n/j57O?=
 =?us-ascii?Q?sTn4ArOGWlaDe/71m0xeqBt0JS9mwPoU3RViIEX1MBuPPxDFUF5oJNvgLNFw?=
 =?us-ascii?Q?ntgI0vIm4+9In0xJjUzky9RmbvNwbIQ7xklMLnrAFRtXN8aaW/TFp4YrJjhf?=
 =?us-ascii?Q?eKwBknUeYXhE6+k3UGXxJ1cKC134BD85If9TL3V7qdmPOSoYfe6EzHX+sPuq?=
 =?us-ascii?Q?ffmJOpA/nXFmgDWdRTecNe3h0L6hU74hsOpXamVR?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a5b274d-4bb9-4e76-89b2-08dddfc6b575
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB6020.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 08:51:09.9511
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RfbfDO6edvdwgiD/mTIEXSIJ/ynH7letOXRBsHhSwxA4QoQbzqKeO9fufymWT7Pn3CL1zI8m3ZFH/K8o6xn/xA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6887

The dev_err_probe() doesn't do anything when error is '-ENOMEM'.
Therefore, remove the useless call to dev_err_probe(), and just
return the value instead.

Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
---
 drivers/platform/x86/x86-android-tablets/core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/platform/x86/x86-android-tablets/core.c b/drivers/platform/x86/x86-android-tablets/core.c
index 2a9c47178505..db76ba3abd7b 100644
--- a/drivers/platform/x86/x86-android-tablets/core.c
+++ b/drivers/platform/x86/x86-android-tablets/core.c
@@ -265,8 +265,7 @@ static __init int x86_instantiate_spi_dev(const struct x86_dev_info *dev_info, i
 	spi_devs[idx] = spi_new_device(controller, &board_info);
 	put_device(&controller->dev);
 	if (!spi_devs[idx])
-		return dev_err_probe(&controller->dev, -ENOMEM,
-				     "creating SPI-device %d\n", idx);
+		return -ENOMEM;
 
 	return 0;
 }
-- 
2.34.1


