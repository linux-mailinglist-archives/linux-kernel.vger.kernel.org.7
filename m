Return-Path: <linux-kernel+bounces-761403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 80128B1F9A4
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 12:31:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7306D18990EA
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 10:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DB1C23D2A0;
	Sun, 10 Aug 2025 10:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="AUvjfIUi"
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazolkn19010001.outbound.protection.outlook.com [52.103.66.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE64C224D7;
	Sun, 10 Aug 2025 10:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.66.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754821900; cv=fail; b=d32d6EERQXOV//RAsJ/Ne7T2qXx0nG9QCxD0f+jzw9x2uU0gvKMQIu1SMVyIyMjn4zu2OZB4sIDLI6kWzaUd840hMQkErPD22xfVjrUH2rjk53V5uUwj9393k0oO3tZdka9upHGt4opPcaLFZ5ZyXtrPnLKM1/zqTmCdkQpg8BE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754821900; c=relaxed/simple;
	bh=DSSgaGU/m2oL2GXDnlHqkkLJI3jSsGiQgqnH5ZdiRJE=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Fqg+mGhlRr5to4wfdKN/iF5tzO8tauMHQVTlilccgFCU6u5o2BCRkVtkdsd60H9LbjFkc3uziYl6U2KqST+H9u4AvVmmHA+oZYMnuzWfEVH5e0VGkGOP+0cYPsj2YrT4LFjoUWN5SkpBGwn9dUEiVzqScYVBe7xX9xtdJampmic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=AUvjfIUi; arc=fail smtp.client-ip=52.103.66.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q2YtXt0IpxjeEub8ZapLrOZQ/kStbuy0j0VqrIzg6GxSor9kVvZduLrLb8UToQYS6CDqcGRMt4HrxN2bUV2B6RduwN+RiqsVkd2Ju8gOD6qvdnrEey+O+fc31ciftXxsmYcFHlvxthx2/iH9J0VvDfYtb/jdS14wrySIudXq0s3KDcqIxabW2kemjDkh4I0+iw17i9SJtgs4YmDMLeiLHPiMqr4IKJ9zj3pNnrMVe2acQOhY79Qawr4g3O3cnwFVz6NHX4E8VyUVyN1QERQAjMU/lleZtFD5Nbw1qq1hnlPDH9TaYuraf0m7Xfc2GRXMsEzaLPP1DVCz57/eZdKgYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k5pojPfDyVvs559M2XGm2RMLEnoqbUiEl1g7qIbo/Wo=;
 b=Dm+ugUx3zhGGkxez0kZmerYFLYVYIvvgTMUYW7QxXTgPGD0gBGcHlnML9chxDP5KsuUTSji0+EUreCad0vnLXyfH0aes9keezp5hOQk0i1HlFpobtCRh7Sudg6nlpGBOUvfx7Y0k1F2++F68PxmKgPSwcf3vNYC9hl0s1EMcTgw7KKla8zuUXXb6LqbIP0K8awaGdQnma/YBuPP8p3KxUoUjn12IZQ4mQ5FEZ9SWQirCYDpyB/w7KUgc4O4PnHIeE8pcoWvq5RtG35MBfTifdKMl9kJtNAxKMnHCgIODlqn3RAW72soCBohwTqgwfubZxFVhTlStKzfPTI4j3JZhqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k5pojPfDyVvs559M2XGm2RMLEnoqbUiEl1g7qIbo/Wo=;
 b=AUvjfIUiNsbRTj/gpYnwaUsyng11saGvPoyAt2HlXrARb99E0fK7ZHakZ2FAWlUfxx/R3GU8e/KQ6cc68D1N8LL6Jh24HfM2Yn1s9DA7fzbagA4LXFUZ6kEMq7yaOSqvceuIlWCTXLJvCXApShQcWgARpKQmSh+d87xJPuGFVOazONCH3Zo2nwbT2nJiAOVoNClTNYv2cS4gO5eM/jxm99WBlg0ecEW3ODmjsAUkGN6Gi1W2zUJ3IwtFgoTAS1wwBSqUz0zYouUA2YwvuAQQXPFXvb1fNFpBbpFlASI12EpLGnYC2mWIMAOmI83AwcI5xAYhCFRAVh7pfmxORjrTrQ==
Received: from OSBPR01MB1670.jpnprd01.prod.outlook.com (2603:1096:603:2::18)
 by TYYPR01MB14263.jpnprd01.prod.outlook.com (2603:1096:405:19f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.20; Sun, 10 Aug
 2025 10:31:33 +0000
Received: from OSBPR01MB1670.jpnprd01.prod.outlook.com
 ([fe80::c00:ec4e:ee7e:9b7f]) by OSBPR01MB1670.jpnprd01.prod.outlook.com
 ([fe80::c00:ec4e:ee7e:9b7f%3]) with mapi id 15.20.9009.018; Sun, 10 Aug 2025
 10:31:33 +0000
From: Shiji Yang <yangshiji66@outlook.com>
To: linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shiji Yang <yangshiji66@outlook.com>
Subject: [PATCH] arm64: dts: mediatek: mt7986: increase ATF reserved memory to 256 kiB
Date: Sun, 10 Aug 2025 18:30:49 +0800
Message-ID:
 <OSBPR01MB16701BDF64C43EF07390C830BC29A@OSBPR01MB1670.jpnprd01.prod.outlook.com>
X-Mailer: git-send-email 2.50.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0027.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::22) To OSBPR01MB1670.jpnprd01.prod.outlook.com
 (2603:1096:603:2::18)
X-Microsoft-Original-Message-ID:
 <20250810103049.28342-1-yangshiji66@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSBPR01MB1670:EE_|TYYPR01MB14263:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c05b281-6bd8-4668-17bc-08ddd7f91274
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|41001999006|15080799012|5072599009|461199028|8022599003|5062599005|19110799012|8060799015|1602099012|10035399007|440099028|3412199025|4302099013|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?P8OMXtagrpzQ5rtS8OgAv2XTr+8XWgpqMMEg1sJ0hBMVR9mrLQvgmRtWRlIt?=
 =?us-ascii?Q?Y1Yc11aUXKlzsF+N+Oi1Ys/ubXRX2gyvWYVnr0lABFSNIuSBRLwmv61Eij18?=
 =?us-ascii?Q?ZwSaWhQgrVAIoCwIkr10thHzaJNdlmcG7SLZQvHdBtog6NN4uM9EkeMcAGom?=
 =?us-ascii?Q?pwMcBy7FEHxlZkiWMhTEEHCEdV+ZXC2pSzy9n4JiJj7Xf8Y5xmr6hi4T6tBe?=
 =?us-ascii?Q?kXDb+aNZkqJPFi5YIqByRLWdB9CiHpw/yI1NQfDn2yMZaKEpkLfO6xdy2xI0?=
 =?us-ascii?Q?8gvtN/IakyJMdZ6+9YphMWFntg9kxnnvToRHGGsXOzu6fMud4CULZOFlgNSU?=
 =?us-ascii?Q?EXCXOYBeV70CiooFRNhJpQkxdVfbQXJdVkJcfFBdqhTdplu9tIsokFmBCeQ1?=
 =?us-ascii?Q?oHbfoPMPZUv7TY/kcZAnhvVjvPxHpLdL1WXUI3DMV0IFEdqji6a+VvJ6hIoW?=
 =?us-ascii?Q?UyIxPoBKVh3tZeRYT4SqdU2RCOT+x9vjbfpEtFDlEUPT9SX4sCkVm9TyIscd?=
 =?us-ascii?Q?78y8GguM3oA1VF+rdLp/c9MRQ+V9Be7e4sff/fWP15BOaPs0DdTQJTEjdSHF?=
 =?us-ascii?Q?g/LqxTVc0cQB9aG1GstS5XUQewPy4d+ZRYgJ7fh/WcOPh8Cuvqf/IyFpWjKO?=
 =?us-ascii?Q?m1AlsHaTlybeqoeX9lUqhcMV838y5rTTgmteVQchMFPxP95N4WmaeApMp322?=
 =?us-ascii?Q?qtLQ47n5WtP+5lKyRicHwr2MI4A/BfSLZD/WpXyDIKinBIRr1FKbOkMvnP3C?=
 =?us-ascii?Q?9uYvDq/TwHeZJcW8ht/OOMRf/ae1lnGIQY+h4BcZnhQXepAWyimyMh7G9Fdo?=
 =?us-ascii?Q?DD+tsjkyqhPpEgQQhgloPCyNDQ/pSy+LCjThC/EK1mPZv1+dAs6NFW7zhg4I?=
 =?us-ascii?Q?W/kdtn4Yvcse7gBQM0PrVp2/BueMYj4r3xhE9oWiQ15m/ZJKBrD+/kVW/ukj?=
 =?us-ascii?Q?4dvsEP9eKtmjC8PnTfuVXGckzJuCKLxqo6NVz1uluU4h7dnl/dm6N66PnHwE?=
 =?us-ascii?Q?mGtdM+2a317i0B+wTju0ZyTja/HzKGBuzj2e/Z+LrjyZZ2QvDA1VGqdDLq9E?=
 =?us-ascii?Q?1EgwjUSsYOqZA/sh9csJdRoZkPhKmO0zontPT5tcdvWBu2WckE+PW1d7/hMY?=
 =?us-ascii?Q?C1mtEseDmVpYt0E3EeZnYuo+x8vxpo0JLxw9KDBju0buDa98Ev7siV9P6TwU?=
 =?us-ascii?Q?5m4DR496MtzsQ86RSniZ7uCmU2hZTbsih9RKhBU0w8FGSPc0LH2AeAwvWsHH?=
 =?us-ascii?Q?CLvcgnUUD7TXljnOjobQrv766np9oGWyH/Yeqdom4w=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NC5+Ylv+MRvXa5Q7rdPJ0CDetb/lRJbFytwGxP4yG7n7iJNIHZvofIGyLLby?=
 =?us-ascii?Q?UwS/hbVkKtoYj0qM3+vATPJu5I8TFP6Be5LQ9vi8RgQxGoUtuBvkyVW7Ll5w?=
 =?us-ascii?Q?vfA7qv0pJmPVRhpK8MUVb0D5V5j+Yuasd902DoyC3L/bRE/xKfIqAplS/5xX?=
 =?us-ascii?Q?lX4z2zu2VK+aZSTVECJSEq9VXh9LFSlF8OLbav5C3TxYq+xJM735VS+Ml8cw?=
 =?us-ascii?Q?be3Ea1hZaXRf5N002S2EZuBhD56lZyxgYZBdeFVb97M8qy9XaH8wsYhQEMhz?=
 =?us-ascii?Q?omECDYkS4Yd5VvG/tcNqEfvMvR/zaY9AX7f+3vFuiKq9cyqTASEo07IoqLbc?=
 =?us-ascii?Q?p+2id6ZbyvFXeipVPE6FLJNVpXRnYOm2esSoYf6bGdOqhPzgNzXZ5Wfsrc9X?=
 =?us-ascii?Q?xyGeVgGLWjQKVx1BImsn6UGhjNL3/UzWlVDLjpIA/aE7mOZrAlqiFRZhY4D4?=
 =?us-ascii?Q?bCC7qRtvjlMOpDr0gnqysdJtUdJlZE+ok0AMR4c+Nq+okqiN3R5UILoWCJHD?=
 =?us-ascii?Q?hDFyVHtE2GAppaN5VR39+3eEgD7avQpBy85ovZArKBFVXOvDcM2K+2m6oOc1?=
 =?us-ascii?Q?G7dq15g8i0DCNJmc9cy69BRnZ+XVXTSlPLDPIWxdc9cBT4Sg5JzUalnBe407?=
 =?us-ascii?Q?W00UGqQ/yGKrZ1dWOc4GwE1mv2rfShoegsREUSbMP8Qu5PCa6XDBrxggiqZ9?=
 =?us-ascii?Q?TMXbndC066hIQ6Sc8rX47pjYyjVwjjfRy96zQiLLRaItYgz16GlaJTFJ5fRT?=
 =?us-ascii?Q?d6pNRjMYAqTMWELUDtKIiXfDDZJNMigpHFQak2QG3/U0qM1cr9+2VMfShBCb?=
 =?us-ascii?Q?IVrYjwSXKPQrFB+104SWDQlmTFZwKejUWj9KIA5QDBzZx7d1EBXDZv5w+pP+?=
 =?us-ascii?Q?y1LFl6ohvnGr4mwJiBh2i/pd5fLL/cITGMISbXDaT88Ari1IRJW109NGqy1C?=
 =?us-ascii?Q?z0gmP5SwpeWGV9TUNI+losAwU81rgWmpNvv+cYStY3zBA6A2FOhuTVikngwQ?=
 =?us-ascii?Q?NjW2Vq2DZXud3IwsPm01OVq0ikiBUVbq3ngGqO9bIoLzGubEqL0+iFhTBKu3?=
 =?us-ascii?Q?EAwl357jrE8WHq+5nULcO/CXDqpW38glw+k8Je1+i33WHUNGsL7bPXXOZWRw?=
 =?us-ascii?Q?pu4qDAGgHQHrsuDW14ZT2U6qnIvGXOuzTufbz8XiqzeDw2h2jJWKlSa6HbeR?=
 =?us-ascii?Q?BsvhFXd2bjKZT5dhK/IeCUzFzBhaenJtSlqaA/Eonb1abzLw9Lqz6RGx85JX?=
 =?us-ascii?Q?f0n8fhht8YbPqllZW2/n?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c05b281-6bd8-4668-17bc-08ddd7f91274
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB1670.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2025 10:31:33.7777
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB14263

The latest Mediatek open-source Trusted Firmware-A project has
reserved 256 KiB for BL2 and BL31. It is better to increase the
reserved memory region in the Linux kernel to protect the data.

Signed-off-by: Shiji Yang <yangshiji66@outlook.com>
---

Ref:
https://github.com/mtk-openwrt/arm-trusted-firmware/blob/78a0dfd927bb00ce973a1f8eb4079df0f755887a/plat/mediatek/mt7986/include/platform_def.h#L61-L71

 arch/arm64/boot/dts/mediatek/mt7986a.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt7986a.dtsi b/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
index 559990dcd..d21e0d13f 100644
--- a/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
@@ -68,9 +68,9 @@ reserved-memory {
 		#address-cells = <2>;
 		#size-cells = <2>;
 		ranges;
-		/* 192 KiB reserved for ARM Trusted Firmware (BL31) */
+		/* 256 KiB reserved for ARM Trusted Firmware (BL31 + BL32) */
 		secmon_reserved: secmon@43000000 {
-			reg = <0 0x43000000 0 0x30000>;
+			reg = <0 0x43000000 0 0x40000>;
 			no-map;
 		};
 
-- 
2.50.0


