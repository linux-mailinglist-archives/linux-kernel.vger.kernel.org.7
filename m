Return-Path: <linux-kernel+bounces-885938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3073C34539
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 08:45:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A3AF462D15
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 07:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55F182D7806;
	Wed,  5 Nov 2025 07:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="RWEfCKkx"
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013003.outbound.protection.outlook.com [40.107.159.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ADDB2D6E60;
	Wed,  5 Nov 2025 07:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762328678; cv=fail; b=W7YCrZUD6JOkL7LJ/MMy3jNNJ9/mYIKixZtd6YPReEMvHcY+9qvs9FzrVcrWr7NCTi7y19+VEr+sc/zrmjyGGSQv4QKjRpk95dHIMyZ8/3/EU/eZm+9nLYwDCbxEA8QjsvwzpEt99pkEhtSsS9tOXhyHAv0HaO3dXsTfE0R7zAs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762328678; c=relaxed/simple;
	bh=/nNTe9Wn8y4NLIW3y7mKX7+wRWHpbkkdXVYRC5Nnvrk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oUifmyBKZQjULjXYrmc1wm6Sb9aRaO+AbIKZbJfj+h40BhEs2N6l5oQEffzzPAQ8g1WXi1F4YLmIwBHp+dzTo5Q5WM/2I3V2pRG4DborqURCD5JKg33yBQ0TfmQDEaRHYRhnx/Smp1j9C3YqkyvXMhxo0n3QpZz/iB02I5K/f7g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=RWEfCKkx; arc=fail smtp.client-ip=40.107.159.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ANxxGtNZOFiIXa5HQk26VlSjMjUviH7/u2THi5/Pj3G8VmGYKnfH3tc9BoTYZkk4M3/Zx2foo4CJlE7V4TNLcCWzYJK0Gt2olqDn5+1PRMtKs+unmGWmbSF1JKsQSC9ZrVepWLy6xNfQAvrB6sVwz2pZBe2L5Co/c5kZYKoks0woqctvlWtwBrxBeAoaqbymn5J3m9LKJuMppyHuz4nPN2PA3Ny/9Bi95Gm9L/BII3SEGH7M4u5AanapoXNdxV1ms/JfLb7jbAG/NoMHEf+tKdfKluFeSMPLvO00Yymha6e53BZO5QbUrmVI5qjDX7nAZyXPgRzOFoLBkNsLzdLrNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qojqQJmDw4xZB1ij+nxVQqH1Bu29yUA2tFIWMi03inw=;
 b=GQiz89uo4Yx+MT+RJEHmZnHoz6+5iw4jftH21aN+RYHME44I5lEUqsJJTQiLr//Ne6TIfZ7fj6VZDQIVjeFVwwy9/A2qsA5LZpCtNzjTyZtgQGRgdNjsK/Dggow2RTVKfIcFmNuBaBcYM77Jl4bX7cbnaTODh302Zmnmb6RIRXqa4awLFer0vRJRzXG/xrPulMfVKHqxvhHe79uwy85IVjfnI5y9iojf8+o04USdgBiKJrUXulL/5WPY2n86KzdfhM6ZdMGTdbOtCuWnq84tqpe4SpTi/3y7/p8MUZ5eFbglakndWxPEIxS/hXdsgMnzltN4uEZmUp2CN+chJBNcsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qojqQJmDw4xZB1ij+nxVQqH1Bu29yUA2tFIWMi03inw=;
 b=RWEfCKkx4uWcBW+48npaoCM2BEksiJcCLa6TL1d/XM3hVofb55Xnak0JFBAn0YX1ffghg9FTNaFNl7S+4gk541/43sabDoYslOQYexc7706du/Ztce6zVghfDAo0hYlfnwqdjaIeojjG/MAk/sn8Nmjh4lOho0mxOynP5ilFYjg0Hw9bmz1x8mbbBHL5Choscn2mgtZ2dVrkzzqgF1uQrHJDiS1mlVTNlypQkIczoy6xi1sl74oBMcVY6+NpjecEUkvpD/g6i67Ys+d1aX3K8Vx4OtmtbJgSte62o46xBd29iOOQw8i8rwxXv3tzkd9Xsq1D0dmKfdNhWlKigS5GxA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8829.eurprd04.prod.outlook.com (2603:10a6:102:20c::17)
 by DU4PR04MB11079.eurprd04.prod.outlook.com (2603:10a6:10:589::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Wed, 5 Nov
 2025 07:44:31 +0000
Received: from PAXPR04MB8829.eurprd04.prod.outlook.com
 ([fe80::cdc5:713a:9592:f7ad]) by PAXPR04MB8829.eurprd04.prod.outlook.com
 ([fe80::cdc5:713a:9592:f7ad%7]) with mapi id 15.20.9298.007; Wed, 5 Nov 2025
 07:44:31 +0000
From: Xu Yang <xu.yang_2@nxp.com>
To: Thinh.Nguyen@synopsys.com,
	gregkh@linuxfoundation.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	jun.li@nxp.com
Subject: [PATCH 2/2] usb: dwc3: imx8mp: disable auto suspend for host role
Date: Wed,  5 Nov 2025 15:45:03 +0800
Message-Id: <20251105074504.1427926-2-xu.yang_2@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251105074504.1427926-1-xu.yang_2@nxp.com>
References: <20251105074504.1427926-1-xu.yang_2@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0020.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::6) To PAXPR04MB8829.eurprd04.prod.outlook.com
 (2603:10a6:102:20c::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8829:EE_|DU4PR04MB11079:EE_
X-MS-Office365-Filtering-Correlation-Id: dc8aeec7-2c14-43f0-3b7d-08de1c3f27d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|52116014|7416014|366016|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?07fyBkaTMS0HKLj8eU52IJM4bEJzPc62frGrWuDk+XYR3IAq+3liQo4PbAe4?=
 =?us-ascii?Q?AUGP3cvTuo4jsPKJ2Z1BkWXXKQ2QstfSPEl2bJR/uWTawQQ++f0FdtnII32Y?=
 =?us-ascii?Q?p/I2/VLKd4OVfN4/IfdBEISv5t3kfO+p+jOHyO+e+XKHks/z12bd4lo3slUs?=
 =?us-ascii?Q?qJAyzrhpokMWRYzu+M+IRWiem8YRf6tG/9KFI2OR61uaXOi5ZcGrRq/D2VAQ?=
 =?us-ascii?Q?LTR+gMbnIfsNAr4oZLfG+zREsUDCB8P0W4rD2Ivmz9oMentHRXoR4HeYOWcg?=
 =?us-ascii?Q?n91RARpKcCBJfU5s+a5OG1VjPmkmhdqJnpevzmgb+F0XCIDEr1CzvhyHcWGf?=
 =?us-ascii?Q?pOMsylPH6YZldleEAVqSzL//KgEZyrDQraAuYSp00Y9SZoF4CTXbPJw7hy5a?=
 =?us-ascii?Q?Kd5wIPOP3SZhxbdIOkhkd7T63bZi14YeJUIA5uekaA/gxIGtulaTpDd0LOr3?=
 =?us-ascii?Q?Ybp6mJ3X3cP5oboQVbgy6LMSrt2LxPKKmXsfJY4Me+MuyhbbRluAOumzoKue?=
 =?us-ascii?Q?uPGsm/xkKQ24wsutwY5Hh+zsQp5vVQaboHP/l+9vhVCPCQ1s5l5wcmuNFWcV?=
 =?us-ascii?Q?Pzth98mnvDEJHUQ76OZMkKQ9faMqzcP496phQ2XBcvelzewJPkCnyT3KQ0Lh?=
 =?us-ascii?Q?hsn3d+7Xw0jD65AAA5eGdME9rR4jSOz4U0b62C8AWJ1Y7iSKAcmKW7hLISmE?=
 =?us-ascii?Q?lbnEDY/gffRNpumgx3PxdxXOH2gtS+Sqldu+uSh8bH5pKCA7F2m4Ks0wqOBt?=
 =?us-ascii?Q?ZVU8vw3Ihitc8cAwQeZ1Yl7TyZYzOS+FpqtJz47F0HD3RXlEBhDiSrNy3v+I?=
 =?us-ascii?Q?rcf0cgtp9ZXqYhxsuEsp7giSH6XAViBXdrnRb0gdpSx//9o7IdBfha29N5Hw?=
 =?us-ascii?Q?4KEOoVoNzWW65EIv8tghxeGCLK+qBSRgK9t/Ky6V5nn5wsjpJr4a8GFS5iv5?=
 =?us-ascii?Q?78nJNuhmWvYwn4/K1B/yv79Q/31y1YiUB7xV2NfgLb9zqS3OWxyOPzGKfv2b?=
 =?us-ascii?Q?6w4RN8lEiRAICG7J3coVv/rVudFMI4G4es1QTzlJ97vHH65+SiaQb9LGEAkd?=
 =?us-ascii?Q?+pSAnDg3G11nBqTQMqSkIZQviRbLagqKXgjg6DTTM0iRsKR/NZ/QRVsFPf5N?=
 =?us-ascii?Q?jK0nS9SFy0iWl0SDoxqS8IcpiHh+pFeGlusHOiUngDkB/VlIN10YY0U3Jz6x?=
 =?us-ascii?Q?DWl5r9yEoptKSunyULlQwNhRB5dRW+OuJ323PCtDXNvPM7M/PEolsnUrYhES?=
 =?us-ascii?Q?bnO1tI2WO1FG2bdM/G3u8mfcMMF/mgESR5UVzdTOD8AJDJCO1lsLMWmQ1S31?=
 =?us-ascii?Q?dEE2SUHWcDs1PJdeZSkExDVL9KCorzdkgAWPPcj6WLlS6dJwCCtplZWZ862+?=
 =?us-ascii?Q?N8p8BsH0CdeNhBZW6ESCGDnb3Ks4KBqV7vZlBJcrE3LXuiOkQrCTwb2/0T6m?=
 =?us-ascii?Q?qbKpZ/UjnbFsQzcVF7bksP1IK49/KQ29+HV7frPX0kabTVQXJSSO7VCeCafO?=
 =?us-ascii?Q?HuqSjJU8o9AF7L7flToKWGflAtumqRl9nmiE?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8829.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(52116014)(7416014)(366016)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Z1YZ6uaGrgp+3hPB9QU6Ksgpg+u0xiZG2ClovIDFNZqKZMNlECdc4RHM7JgQ?=
 =?us-ascii?Q?LuG2U4nOYXHomEPOm+M4tjNWtk5aAQKifcvQAHZ+jNeMGeO2eQaxM9sDSdFY?=
 =?us-ascii?Q?uZ0hElyYef6G60VxsYGZlCK/1+wvjBYftxqkIAN65FMsx4pCCJfZlC/6OGcN?=
 =?us-ascii?Q?OTomm/vzyQjgnnmJgyCAS2Y2aqZiqx4Tu2q88nHX7TjjVcHkrKdDvHoCFK7M?=
 =?us-ascii?Q?jCgW00d4GKTn1ogxsacrU3REQXuhyS/5NXxvBPA8IoZpypI6ZdFrnHwjzuBP?=
 =?us-ascii?Q?a5hPIfLeuNF1iP1TYHE+KDWg+6KXetim/iBd0YjkRV9E5g/jipG90sBLCUNS?=
 =?us-ascii?Q?S3N5WhWpLC8yFyk9gBHGAiZbmSWwbncuHlIKD66eKUY1h5L411J6BqRQv2sm?=
 =?us-ascii?Q?Tc2m/6pEtT0w+LAucFE+7KL+6OGnE/wWYNlKTeuUuPY/CvMu06fhRLLuOoL9?=
 =?us-ascii?Q?MM3IHBk6hYvgn132lZp6vaba1YjepoQcNJY7E2LUpyp/qSc+G38AR/wKi4WA?=
 =?us-ascii?Q?e5wOOmNsrZ6E+zjD+joKFNtr/359T3oEpE2xPhS5O9IRlh+9FLG2UAelsPrq?=
 =?us-ascii?Q?kLeLCBkFMZ9Wf7GUrgYw5sXJWL7JW0hy33+INbxVJ/9T09yg1S+fgRYnwWIm?=
 =?us-ascii?Q?cTs5iUjqNTqxfhIf98aI4ZcrNR4EN31LcMiFbqRV0TohZfUcLyS/1usUEzWr?=
 =?us-ascii?Q?0Cfx3Nxinhg1zo+/105xPZiwNYxj8qqTo6ZpZJbvESMKVeV/2p48PN6yLUIC?=
 =?us-ascii?Q?8wcdJDW6HbefIcg7aUzFBOke6g5BG7GbncNm4STkANZ5+mNyjXAZc/DENAUj?=
 =?us-ascii?Q?Ukz8o7kVKOvGKltQ2mBF/LZzSYlJpDdV6a2uYxdTukmi5KdkiTLLr48mW05n?=
 =?us-ascii?Q?JzOgWwKd6VBbWrBO+u46KbTSh5cB11jM9VrtD2oCn9IGYqHR/f2Xg+4GP+7I?=
 =?us-ascii?Q?8lH9db5IrWTbKY8ws2XXl4b7/JmwvCLkEe140WxF6F4Tc59ZFwBgJ6fT9pxO?=
 =?us-ascii?Q?mZKpG4Hzalth0D748ESse0PpYSbDr2G0Mt1cx7wdmbUrTyE02O9MxZsfDyoI?=
 =?us-ascii?Q?Urls68RE5OO+72U2W/eF59skvKgnOjlBndz2cx6fqiQCwzadP6Ul15MbE2Xw?=
 =?us-ascii?Q?panKos3Z4ZN1hAp3lVAjCAWWuu+osd85CJtrB+FcHFRfB1zGaKpWR81vxG1+?=
 =?us-ascii?Q?N8m1MFMIW1PalRlx8F3Om2eJn4Timbm25kKnOq3BuPQgpT7mgGSW3lFXHH+y?=
 =?us-ascii?Q?U3xGBo0hg+MhoH4Psd2lfutojluUOwQ4NE2pQAorRuoKNCv1zxwI0uBoB+qG?=
 =?us-ascii?Q?QN9IHdrcDGvAS3fhBtvXzzFUHlSyCifd5LHZZev1tMh8qqzVSJE5ophMSive?=
 =?us-ascii?Q?W5Tpz5G9I6BN2xeKONkV+peFw72/x96kBt8Ks9HKbc57cCLg4ZZkLbgCj8Lm?=
 =?us-ascii?Q?CyOZWZbPHFIKdgA8np4f6VRn+XIpVgTFrAD2dV1wZSNJ+QZHsnSCQXEmT67V?=
 =?us-ascii?Q?gW5Y4yM9xMbZHI2GR1IhYJX+sLTjNQmPyolM5ilv7nZnJ2Hv1KQB+VGUZL3G?=
 =?us-ascii?Q?XNPVh9vomkZvh0sB5UCvvviRKB+Irhf560Sdp+zL?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc8aeec7-2c14-43f0-3b7d-08de1c3f27d6
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8829.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 07:44:31.2050
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jjAHXcK8eE5cln0zsYYN2JioIOPYbXGD4w4LwxDapaBsUWiDmXwMXd15koHwq44qgIf0JaFrh00SYNHuikeTpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11079

Do dwc3 core auto suspend enable for device and disable for host
, this can make sure dwc3 core device auto suspend setting is
correct all the time, the background of disable dwc3 core device
auto suspend is to make its parent device suspend immediately
(so wakeup enable can be enabled) after xhci-plat device suspended,
for device mode, we keep the dwc3 core device auto suspend is to
give some wait for gadget to be enumerated.

Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
---
 drivers/usb/dwc3/dwc3-imx8mp.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/usb/dwc3/dwc3-imx8mp.c b/drivers/usb/dwc3/dwc3-imx8mp.c
index bce6af82f54c..80a431cb6fed 100644
--- a/drivers/usb/dwc3/dwc3-imx8mp.c
+++ b/drivers/usb/dwc3/dwc3-imx8mp.c
@@ -158,11 +158,31 @@ static irqreturn_t dwc3_imx8mp_interrupt(int irq, void *_dwc3_imx)
 	return IRQ_HANDLED;
 }
 
+static void dwc3_imx_pre_set_role(struct dwc3 *dwc, enum usb_role role)
+{
+	if (role == USB_ROLE_HOST)
+		/*
+		 * For xhci host, we need disable dwc core auto
+		 * suspend, because during this auto suspend delay(5s),
+		 * xhci host RUN_STOP is cleared and wakeup is not
+		 * enabled, if device is inserted, xhci host can't
+		 * response the connection.
+		 */
+		pm_runtime_dont_use_autosuspend(dwc->dev);
+	else
+		pm_runtime_use_autosuspend(dwc->dev);
+}
+
+struct dwc3_glue_ops dwc3_imx_glue_ops = {
+	.pre_set_role   = dwc3_imx_pre_set_role,
+};
+
 static int dwc3_imx8mp_probe(struct platform_device *pdev)
 {
 	struct device		*dev = &pdev->dev;
 	struct device_node	*node = dev->of_node;
 	struct dwc3_imx8mp	*dwc3_imx;
+	struct dwc3		*dwc3;
 	struct resource		*res;
 	int			err, irq;
 
@@ -240,6 +260,17 @@ static int dwc3_imx8mp_probe(struct platform_device *pdev)
 		goto depopulate;
 	}
 
+	dwc3 = platform_get_drvdata(dwc3_imx->dwc3);
+	if (!dwc3) {
+		err = dev_err_probe(dev, -EPROBE_DEFER, "failed to get dwc3 platform data\n");
+		goto depopulate;
+	}
+
+	dwc3->glue_ops = &dwc3_imx_glue_ops;
+
+	if (dwc3->dr_mode == USB_DR_MODE_HOST)
+		pm_runtime_dont_use_autosuspend(dwc3->dev);
+
 	err = devm_request_threaded_irq(dev, irq, NULL, dwc3_imx8mp_interrupt,
 					IRQF_ONESHOT, dev_name(dev), dwc3_imx);
 	if (err) {
-- 
2.34.1


