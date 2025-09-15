Return-Path: <linux-kernel+bounces-816458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A44FB5740E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 11:06:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10B971A21DC0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 09:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 991362F532D;
	Mon, 15 Sep 2025 09:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="B+EHScyX"
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013027.outbound.protection.outlook.com [40.107.162.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA0B283FF8;
	Mon, 15 Sep 2025 09:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757926955; cv=fail; b=hEU3NIX7xyuCdCNd0xfUVz1PGDt6xslI61mplm/x5rwTKuWY9uAJta/J2zckrNGqIi0XCYwyAKRnlND2jf1cJiMS/0+7RyD2RfZT+kxSx4oTgmRWXdyeywdWcejIYV6UrhQZVBbKx1Nm32R/QUph8OAUdvr34Btus/owubn/3WQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757926955; c=relaxed/simple;
	bh=jUrGxdc2Ks4JxYKR8vdpLF5/PBNbK24BshaaWySEOto=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=VKQIB6WTWyBoTQ1frrg5x9I83lVmgJfQVYFNFXNgFKmQRZY/MClFJ3pw7XVstFdgxdadjmqInwH6NIUJVTqNnH2ybWwr6+tdPGGcEYaVRjcy+7ncpe9ww3k+91lznwW75rbYRgtuum54PJVXRVlCEtT/Vaz8foELDRqsIhha0TE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=B+EHScyX; arc=fail smtp.client-ip=40.107.162.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bGpQMHOCpPYMArzCszmHPmnT/lfmXF+tETCx3pmdeBk4BDnRLDwe9pNS/d1r2oeUbX1po6aqpdQmMULdC3cP3Ub7JzcQiSn1J2sb0P7t9Rf2rsKLMyJ+meW5z2+uNyN5EiGFbN9vOzz2YLTe3xRqZvu55zkE9H59Fs2D7QUypIdr1zPi09B1dKnXD/OfuOVWWvCoqxieovMtaUhOFpZ5uKph3m1aUl0gDRiXqVrZn0tnjbf+ni8tSWZY9w3nv48FX5j4jtF9o+bU+A3SnuKMl0CTouVuTvNRneaNF2cWD9riRyjngxVSvLaSFLKCBDnBSx3w2XInht6jv4e5ey2caA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OxVnN4heDn8CfXYc2w4VbTE1jK/68QZpA0tLeplv8a0=;
 b=DnCIwmFG+FTdC0rpYYKCQDx4J/7waupCdHdMyGXzZHMl1qtq/I04du0ZPIC7eV/qmGAGBl8x0mX1tQ0s4kKz+716DZ1RhUAnJCS64ujBMskVvjpAoYQQxuYWTCd/vnLxLm9XRX9HS0kIBg74Mb0OPWW30hhbSpPkAr6hBYtN8hRejipnquJ2HLJATgD6xO2D450MzW6Bh65R0PbxhPLFelMXix90Um9MnnL1PLMXJjjciHpJZqLieKFp6n0454nTo/+biwiTpA6ke65CHHzUfFx6SydxNtp7+zumGzGLQiza5gqK3fzYeMxOtGDDlV51btCbt+Ddtn/F7lUYNfEkmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OxVnN4heDn8CfXYc2w4VbTE1jK/68QZpA0tLeplv8a0=;
 b=B+EHScyXjSksyMjCSzb24w7+wwLBOj8be6OcUU8c3GNnqh6aS8i409l9XTf7TjwlO76oIyWeFhTK1tKBsvUq0PbPn+a6Y+PYpIxlt0zLZNBQyMOqHt7vAr3ms0jE5aYIHddq/2tVyOiJUQ43roaEEmEQgL48eyQnXLhYBxtsje3TbguzhaXAXsfDACHY9c+BFmaEHm2AxgM0W6tR5ku+O2CY5eL5rPkADMAKEh7cEe3fJrv1nMAxSAD2jPfQZD/V+Xpvg/wF0228QjKKGEJU2zjFCqNwPevBFqZ7A0MjTySkL9XhT0kMChxS24vCJD+xWDe4zlIXZB0cooFtSpD6lA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by PAXPR04MB8782.eurprd04.prod.outlook.com (2603:10a6:102:20d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.11; Mon, 15 Sep
 2025 09:02:30 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::c67b:71cd:6338:9dce]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::c67b:71cd:6338:9dce%4]) with mapi id 15.20.9115.020; Mon, 15 Sep 2025
 09:02:30 +0000
From: Xu Yang <xu.yang_2@nxp.com>
To: gregkh@linuxfoundation.org,
	tglx@linutronix.de,
	mingo@kernel.org
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	jun.li@nxp.com
Subject: [PATCH] usb: gadget: zero: add function wakeup support
Date: Mon, 15 Sep 2025 17:02:30 +0800
Message-Id: <20250915090230.1280460-1-xu.yang_2@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0029.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::20) To DU2PR04MB8822.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|PAXPR04MB8782:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a4f423d-51fa-48b5-cb25-08ddf43699aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|19092799006|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vqjpBHB1lIhwiUlSFCJeuC7kcFeEnTt6f39vuy/mDX8pnRhjyKIhHbzXFbRm?=
 =?us-ascii?Q?JsSAXGKUEYCUeTnHrD2vzCKFmzEih8j/CHbb4tnqhmTRr/Mdzr5+6vPuvCWj?=
 =?us-ascii?Q?eY7K7yU04EsKkL2Ec+9tXOIywQRy1Eemr29gKQzHjCWHDe1GnpF/da0pJo+v?=
 =?us-ascii?Q?kfAyMuk0Hgd4PxqAissr4mDiWZTd/nKwEiyB09jAGsMl78HmQipYJQGcBMem?=
 =?us-ascii?Q?80eEaBfLKpwjB6zPT5A6yY70X1euqtzRqsIkYsqfs8us4Uu499psu2rRS87E?=
 =?us-ascii?Q?bOGPRUJ9TwkYLB3ulvnHRZKdHfRv2Rp9n4gEVaD6DtNEDd4oYo93lnNcMjLa?=
 =?us-ascii?Q?9eBpzOfhMAK7J5E/Os/5VDx4Zmorr3D3AnkH1jXfpqNYgv4OwlpG60EGJl/X?=
 =?us-ascii?Q?MhT1tpdGlEHKLcXV2O+qHChnzEOCfj/xvRckqFUr7eTE3N++VXmbjeTRXl8+?=
 =?us-ascii?Q?O2F1ZEJAREUlZOYLVVPRJStvnnb42rD+2i0P0QdtMBXGNdhVV3THcfZHPfZh?=
 =?us-ascii?Q?B/iwDJF6Jjyg7XuCQLt5jRM8yAtVxshGG7hA2W6Uoi6bvqPZJT+Yn12BcaOe?=
 =?us-ascii?Q?stsPEhLlC3GCRPHB6qcFd64YIEjsEBjTHf+CDsw6RSKERzCc5ZN5CCAgGNJG?=
 =?us-ascii?Q?vvx3yhCNAcXAk2dCjuupk1G2pMn+jDWbMC20CoG9uBHLMmFQjzTPSD9MqnjV?=
 =?us-ascii?Q?LOe27MGjpQM+3NvbmxQiQRhQU8tXyk+6O1nImSADLT7wDMutmFI97OhXd3yT?=
 =?us-ascii?Q?/iEw/Rm4iaSVHoCNBL7O8WkVFFMy35TsnIDCeiZLL6d7I6jHOzIWc5xc8lSm?=
 =?us-ascii?Q?2+5dNSCLxUk7uHg/i0NcG7Zhh/YxXRsdNP2FF597mhizasSRGhYB8lwjzZFf?=
 =?us-ascii?Q?xjv8BuYyhFf+ClCLDDxzeIYfXJI0M4I/L12A4EA/Jl74EGVSCN2b+mGSxWt4?=
 =?us-ascii?Q?iGP5RIWsQ/MTCYoyEPzyWKroAJxRdaN4w/JyszUgp227uKYT8PXiHM6sfaVn?=
 =?us-ascii?Q?wWWck0aaxSi/BQqWV46sJ0OY1H1145k046Lkrk/iO/iCuMvLCWi8vq5c34jz?=
 =?us-ascii?Q?KSksggoXI2esIhdXce+0ziike2pk2oG9cCZ/S9sM7L+cssLYQRvBEbtSlxuZ?=
 =?us-ascii?Q?GbZxsYmI8z8jqdddqIaKysuCzvBhUOtg/9Vo4cjVKR56aLInxsj1NGvAtvP7?=
 =?us-ascii?Q?VmwfMD4cuz2IHxc2HoVe3mgA3xry3UKPKfhfPPCVMnFrR9rxaQ4ONsimMDT4?=
 =?us-ascii?Q?c6gPWuB0EUCSnoUgcRgQlQmTUycY2J2t+i/cJcKa4pE7l5d4EQsmOXfqY4W2?=
 =?us-ascii?Q?pUu1vVc5uytCsGu5m8UHR79lqPi8UEYwHeoM+EnHNdvKOeZi8yrHt2qK80hb?=
 =?us-ascii?Q?t71w4NBMfwYbdzzVpmR9TeNd8jCQMEw+8uwXEABk44dJ+A9hN8p6HYPcbOXb?=
 =?us-ascii?Q?UsIX/JectNefqwS9Vvw0AVRlyThv5CohUuEvsgQEPQekTmByO2HCxg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(19092799006)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KRm++bmvzEuB6ds6fFVATav84zGAkEEK/ThzN1mQUGSogIXkPOvwT0xrEGGf?=
 =?us-ascii?Q?Wo91WRgRfRNaXGOtsKxjC8+i/WAK9rDEBmYBlnVmz2aTDVUJxDquBm7hTf/Z?=
 =?us-ascii?Q?pVoULYAUxbuXZbTT0Ei2ZbQSkMsaX10WmDVCQZY0I80j2gMBp9nGAKQV9q2B?=
 =?us-ascii?Q?vxOw4Mcdo41Db26Xnq0T2zDFiYpn10sN6SX/hj37ZeDupwnLkzWOCfXhEK0v?=
 =?us-ascii?Q?Qya45s7eNxm7N3XEk6aQ/Uvg8l18HCFndf/CWsx4KWdK0YSMBgy5Gm2ZcFTV?=
 =?us-ascii?Q?6zczm+2PJTR68yx3PprLT446JK4HRrA+kPbFni9J76HoDhu/wtqPWEW7opDQ?=
 =?us-ascii?Q?qjj7JEcrN4VRurrcxQtvL5Eh72V0Ram/SZtiwTy5K7EwQ8GwGeSVqU+R0kyw?=
 =?us-ascii?Q?EJeurYt2vUjDfyQPNqWDwjJzRaVUTOXeCMGt4QrcTuWUFIkkgmuf1MKZbu12?=
 =?us-ascii?Q?bjtI+ZwKs2UImZpVbPKWPCD/N7OAdE1PqtLmRFPjdHw0+Urnu38oWx7Lf8nV?=
 =?us-ascii?Q?hfoRuwQzOBSkkbHSotHd43WbGlDZyO3bR22dgZC78Mi0bzvzoqAich2/Teg3?=
 =?us-ascii?Q?cOVigvwCXK74VxDdKx2xizfIdAejf6mmB5cVlHwpr13qK7cuNpU2Op3o3JSX?=
 =?us-ascii?Q?0Wkw4qg1HKhiUqpsyDNGIWreO1sPM752P3bfE2n2uvMa2PDHcxxELXccv7Ls?=
 =?us-ascii?Q?8/S9APhZpurpHwFVOAiXjUnSbvm3Nt/H5PeMxvHxvMIleTuTBXVhcMS6xgMm?=
 =?us-ascii?Q?TFcYI4bNNXMn/HeyFx/EICcryXJzjqXA4NST8NWHmS3NS++9e5tFtMVpYjXS?=
 =?us-ascii?Q?9tCyWF+j5vM2fPCX0b30DPGsK5thPHVVs0ZO55nVUFqfiQmV3C7MLTXi8ufC?=
 =?us-ascii?Q?6fDG8T3xYOXsq2JU9VSah4f83355yRAeYI7sAWZNNxdqZmraiFUtshaBLMOg?=
 =?us-ascii?Q?/hSOT/276P0NtXAHkYnTUklkxIrs7FgjBuN5VFsv1+U30AmagoSBX/TIznlr?=
 =?us-ascii?Q?DEh81OfMeBsSKP93SbzR/h/xvnpqGbAe14Wg2ZEMvpt6hnnAcd0iUEsZA9+M?=
 =?us-ascii?Q?z5SwX6bf/38DpFZ0B6gjLWNJUOmuk7Eiji6KqALITqOrEcM2Gvkn+z/eR7/b?=
 =?us-ascii?Q?85/K1o7c18oEz8Sra8LiwJueAqWnnOGlgk1cddm+fy6IIliu08HRwOsaKenq?=
 =?us-ascii?Q?ywP8p4geCyXIgp17nsv201n6Mx/8y9EW118dbhrZyqOjw8ipEvb/cnu+4AWN?=
 =?us-ascii?Q?NZkftqYU4AuEDu81M4Or2SGCSI7CMiJcevDdW13MhY2+wJr3GnBBesTgxSuT?=
 =?us-ascii?Q?fbUnJ/PV2jL7qCa74EEm7jJratXHxCLyOQLx72TvYj3EYwEJrQXsXrFkyNH5?=
 =?us-ascii?Q?BGdp0dDDBczTqslY6utYjS0dL56f2fKyhQQdCf7RVSGmltjd9qEf8/TdJKyo?=
 =?us-ascii?Q?00IIR77y9K8RrtVDaxW2maOx1bpPewB5yfwDWNAaCpNMKVY3L7Vc1I2GciB6?=
 =?us-ascii?Q?EhVRVDooJsQb6rbvzRECrKL2KaWnIWHtKRo9ARVCPu1MYDxMwQMuqNu3AQol?=
 =?us-ascii?Q?HDLN9xcUK6KYfmd/U+L0xCdtpnTd0moTPuIIsFba?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a4f423d-51fa-48b5-cb25-08ddf43699aa
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 09:02:30.2635
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3N+5uKERHMKAybSvKgNk8BVImBdN0AWLeKGFb/SdiE5IoggzxtD0fLmjy26CEiyreeftLRtxcg897/P7P+aMWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8782

When the device working at enhanced superspeed, it needs to send function
remote wakeup signal to the host instead of device remote wakeup. Add
function wakeup support for the purpose.

Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
---
 drivers/usb/gadget/legacy/zero.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/gadget/legacy/zero.c b/drivers/usb/gadget/legacy/zero.c
index a05785bdeb30..fe286b597f9f 100644
--- a/drivers/usb/gadget/legacy/zero.c
+++ b/drivers/usb/gadget/legacy/zero.c
@@ -147,6 +147,12 @@ static struct usb_gadget_strings *dev_strings[] = {
 	NULL,
 };
 
+static struct usb_function *func_lb;
+static struct usb_function_instance *func_inst_lb;
+
+static struct usb_function *func_ss;
+static struct usb_function_instance *func_inst_ss;
+
 /*-------------------------------------------------------------------------*/
 
 static struct timer_list	autoresume_timer;
@@ -156,6 +162,7 @@ static void zero_autoresume(struct timer_list *unused)
 {
 	struct usb_composite_dev	*cdev = autoresume_cdev;
 	struct usb_gadget		*g = cdev->gadget;
+	int status;
 
 	/* unconfigured devices can't issue wakeups */
 	if (!cdev->config)
@@ -165,10 +172,18 @@ static void zero_autoresume(struct timer_list *unused)
 	 * more significant than just a timer firing; likely
 	 * because of some direct user request.
 	 */
-	if (g->speed != USB_SPEED_UNKNOWN) {
-		int status = usb_gadget_wakeup(g);
-		INFO(cdev, "%s --> %d\n", __func__, status);
+	if (g->speed == USB_SPEED_UNKNOWN)
+		return;
+
+	if (g->speed >= USB_SPEED_SUPER) {
+		if (loopdefault)
+			status = usb_func_wakeup(func_lb);
+		else
+			status = usb_func_wakeup(func_ss);
+	} else {
+		status = usb_gadget_wakeup(g);
 	}
+	INFO(cdev, "%s --> %d\n", __func__, status);
 }
 
 static void zero_suspend(struct usb_composite_dev *cdev)
@@ -206,9 +221,6 @@ static struct usb_configuration loopback_driver = {
 	/* .iConfiguration = DYNAMIC */
 };
 
-static struct usb_function *func_ss;
-static struct usb_function_instance *func_inst_ss;
-
 static int ss_config_setup(struct usb_configuration *c,
 		const struct usb_ctrlrequest *ctrl)
 {
@@ -248,9 +260,6 @@ module_param_named(isoc_maxburst, gzero_options.isoc_maxburst, uint,
 		S_IRUGO|S_IWUSR);
 MODULE_PARM_DESC(isoc_maxburst, "0 - 15 (ss only)");
 
-static struct usb_function *func_lb;
-static struct usb_function_instance *func_inst_lb;
-
 module_param_named(qlen, gzero_options.qlen, uint, S_IRUGO|S_IWUSR);
 MODULE_PARM_DESC(qlen, "depth of loopback queue");
 
-- 
2.34.1


