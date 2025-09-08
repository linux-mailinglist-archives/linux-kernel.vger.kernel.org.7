Return-Path: <linux-kernel+bounces-805062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C5B7B4839B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 07:33:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8146166072
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 05:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 061FC22652D;
	Mon,  8 Sep 2025 05:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="hYVvt+TS"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011037.outbound.protection.outlook.com [52.101.65.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69671BC41;
	Mon,  8 Sep 2025 05:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757309631; cv=fail; b=etRGD+2TUp3WP1Xkn0ZoKySFW4gZQMx17H46PpxcxI85R01j8SLSzzrOungKOaLHIoFSOpe8N8FydAuuWvuEkmjczH8bHZEI3cWZKsz5RZk5QPVwZ/lEX+gFpZJ3t0YunBsDgdcgR0qYOx0gMymUYd8bNc1ySRsRJt6kbNM3bsU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757309631; c=relaxed/simple;
	bh=vx/hBzVUYUle3+Ys9CrIRwnjUBW/8f9atak0lUbHYec=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=rtEEzzvPbxb0JgztyQCAPRV3T0omwPSPanVtWH3wOe0agseqku/vjJW0WMC7F/8nsC8lwA1id9RnP0Q3/TnDoSqoPybsVz74ASknz7T7w2mwnF1FISMIzE0RfTGiXY1lbAyzuPoCONxoH5aI8XjzAiZ+JRen67HwLWav8+1OA78=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=hYVvt+TS; arc=fail smtp.client-ip=52.101.65.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JLHLQjquXqoHf9UKMK8VYPhyByTAMHyZYTv8Y1BuwN9H9uTSBwIRTq7gPkpSY30ipaDUewHh4HPK5Bh+2PyRgBQt2D67iP496m3Zw8P2f14076tpNlrg5e+jI7hzp1+S7BQqKSEgz1AFpYxTECo6/nPElXelcbrji5PolD6RY8g+mHakKZgZldYXexkrcPlKvIoLfottdQ9sXIS/pEmugioTMk9xcAvW4r5ww2Op4Vq6dQ0qQLTEE3hFqxed1cP+SBIDkCM0qwVzzrVKQM/czmDzCeADWN98vJ89W54TyLfnenazK/LgkbxU5hsVwpU4ay1/0xsKWe96PMjCS9RVDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Io9GGpWhzYnUKzTkfAuUlUgvcoiW7OFAVo2SAiXavA=;
 b=k72gkXdBHXutUcNMQTy0AD2Xu5z4fCC5yhB96MqhVcBHdbqQPER6bDMemmfbtaC+dmfaP5JHk9ZSIp5Pk0LCEyLx+EJoj7DUdk7QoIviNb2O1+4Wbzngt7wZejSxep2j4/IYtjm/YlVZrLbDPJczmKH9xS4IDw9xbiD1PpO2lGq3b/XWZYwtU+bkBsRmyXzkdxIf8jfOD7VHcTPG//g6EIOj8skFjztKe4F+UCpxA4rZCdkvLHsI9r5EXkh8mQU4Eb1DWxvD1KgXYFg/NpJ5tqhw9ViWccy4m25jorFT+NLRqJVjzvihhoHpGtjnkQt5nzoUCoubL4URVAotRdRHlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Io9GGpWhzYnUKzTkfAuUlUgvcoiW7OFAVo2SAiXavA=;
 b=hYVvt+TSoQE4JuGGa+TM+8AHCwl0MX//p+ODZsfNXkDasajfaIfD0nOiuVXH2XhVlvRQ6z+zy7YrOPGtBVeCMUERndRwlaB1U6v+ORLaqPkXJZ++Fbf9d/k0skH/8oDiUrDbTqs7gvaiVB3AlarjtQ/L4zx1rToBuaVdAvavZ6GLaATkMrsyzwnFI5fGGYitO2Cf43RoAQeqT+8iVSOHpdYfPY15XxIwPfixQ6j2jSG11uUh7vP7gRXMTY+5yIA2ZLqBxPDLGDu3CHKjxXoz4BqAvhuV4j48MHaZJPbdECFxJs76XFOeWPCbhY49yc+v9bkqlVEElYxK+/m/Q3QYuw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by GV1PR04MB10727.eurprd04.prod.outlook.com (2603:10a6:150:210::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.16; Mon, 8 Sep
 2025 05:33:45 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::c67b:71cd:6338:9dce]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::c67b:71cd:6338:9dce%4]) with mapi id 15.20.9115.010; Mon, 8 Sep 2025
 05:33:45 +0000
From: Xu Yang <xu.yang_2@nxp.com>
To: krzk@kernel.org,
	myungjoo.ham@samsung.com,
	cw00.choi@samsung.com,
	robh@kernel.org,
	conor+dt@kernel.org,
	gregkh@linuxfoundation.org
Cc: swboyd@chromium.org,
	heikki.krogerus@linux.intel.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	jun.li@nxp.com
Subject: [RESEND v4 1/4] usb: typec: Stub out typec_switch APIs when CONFIG_TYPEC=n
Date: Mon,  8 Sep 2025 13:33:32 +0800
Message-Id: <20250908053335.36685-1-xu.yang_2@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0015.apcprd06.prod.outlook.com
 (2603:1096:4:186::7) To DU2PR04MB8822.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|GV1PR04MB10727:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a39d071-f311-4616-7778-08ddee99471b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|52116014|376014|366016|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VwefgwT6AH8Jyq27wwmRcvqaZoupdNynfibQ11aEUz1jNRuytyJabdMfOaWJ?=
 =?us-ascii?Q?oWsuMrTMRYri26DQRbUDdJpTyt9YlvSqDp1+6l8q8bck1deTeLQIfeuMCA44?=
 =?us-ascii?Q?ho62+duD5J7PU2ECAEWlqvFIphkXQT/wmbYmb9AWm3nKT4JZ0ueETJH7c6cf?=
 =?us-ascii?Q?quvLDXFWsaaXMjrvGYIByGb9ESt04uqUGA1F+XIYvlbwfrhT9kCbdnoR/25v?=
 =?us-ascii?Q?AHUr71I2OPoaOH1o2lOI0aIjUF5BC2pOt8VfBqgfE6VQBiJq8D4aNFHJQDdE?=
 =?us-ascii?Q?+COcM8SD0Yi4SBTqYC2g3ykpC8ymJxb12Zl2nleOR/80gH3R4BcM9Ng29wqT?=
 =?us-ascii?Q?AtZ98Uj61GL4vfgXs0EANNDmiN13P2XZK+PqmP2DbyWB1infnzx2Q60L0ptG?=
 =?us-ascii?Q?snC11l49ELPMqlN9sl8GcUOC4UmMB0rBwJM6rudb1qVMQg/mGFeK4dMo009m?=
 =?us-ascii?Q?PuYYZ82ej1xj+sTqQc0F7yxYEIfRSABOqUFLSnVPGA0G3XVzDZcojGHMBq49?=
 =?us-ascii?Q?kKmdZY7XbQh03Cw6Q7eVu5ab0aL7d/i/4sGg1Z+D6y+fUPEwSh2C9E5Vl87M?=
 =?us-ascii?Q?bunCHBSuN5XKXAHZ9PEcTl/uNtdiviLcT9L0F1OxJQtocDz3leYMnXpkAFqL?=
 =?us-ascii?Q?osRRY74qf6OF4aYeMEZa/ezx6R3MLm224myO+LcVVZF80pwik4ozCSYeZ9D7?=
 =?us-ascii?Q?Zxs5dFEujoEv0dgJ5BomUod3lmW9OmmLskRvcndXDibj8iSpO7APN66liwn8?=
 =?us-ascii?Q?kP/j7iN2r7COl6nUjU6OsKf2ReJx8RjFRrDM1eeTneItyuNEqsntz92owUcZ?=
 =?us-ascii?Q?X4qr1hz7jAePmyIuSfFuEW9ced32qh6+hvt3hgtdXzll0bVcUyxt40Vhb2Gu?=
 =?us-ascii?Q?Oe/neD2RbdkXOz/dNzoIka2yPsED0Z/7a4ic9n29EpRKVXJMZabRFpv51Qlt?=
 =?us-ascii?Q?S1/Gaag+nECKDX0j01fcslcggScj01Y0AEG6rcbKa7uM98YidGDxG0ZsqSuN?=
 =?us-ascii?Q?EUpTjkR1IyJJM+ePaGFrtCG9T+S68OsSRepOvCGyrXp21Vfds9x7RTVRiSHD?=
 =?us-ascii?Q?7YrTf5hh1qa+jPHE+WY4Qhb1QkaeG2D1ETkUNQMCvWxCMFxCUIaJW/Ve6YeE?=
 =?us-ascii?Q?r9b1bR+31Iag8G0qfwh8SKgvPWt+3C+0UQPX8Ee5Z8hoEVMBDRu7fytv//MT?=
 =?us-ascii?Q?TFMnpttAaqZL95rqaGqJTfT7UEvTcITeQ9qCrDXtyYyn0XGK57QsGb34nEbW?=
 =?us-ascii?Q?qy1QX5cQCRQAyNNTaFJPZXGgNOSrXukm0UwCHnzRxrzvAUrHvx9vqgHkc064?=
 =?us-ascii?Q?jjL6DwOzpRy7Jstz/rveadXec6UJTzs8AH8xuPD/vpqa+Zkmu7Dpvpd23WOi?=
 =?us-ascii?Q?cDF4YMZYX7pe3BK7pcQr9rmGNiTynMXiU7/zAstvPU0SGergJXwPggVRsCTc?=
 =?us-ascii?Q?URP/tyUm06hZRDZdNpWc/GXGoE6twSCfTPgwkTUEIqkwMMMEOR+ps2p5ZpME?=
 =?us-ascii?Q?i8Ju+Ml2dtTXYtQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(52116014)(376014)(366016)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8AtMW2jNcxGlT7MV7V+mWF7GVx2tzR3oUqfxdMIcpHwo+LC/xv4LblYxpf0P?=
 =?us-ascii?Q?/0QvxuG1Smh5rXjjSw7m607pCNP6c80t5rzsKyE3Q27AHD4GvOkBVxxDgP0x?=
 =?us-ascii?Q?xGVL7KLnsmNKxpQbbo6aAkf832k8Y2PrA/FS+WiqsnTwMM/GEzvdA0eXva1K?=
 =?us-ascii?Q?Id3X8p+DeTsUKl4BQwUNFXjrtOw9KBloqDCNMUUrdxX0bvA8NjizQZg8slwd?=
 =?us-ascii?Q?ixLCOxM9FTYM3SVRB2B23NDIaRQV0i7KTfu2wrFxQnfUbdygcGCDmtJLKij0?=
 =?us-ascii?Q?D5nuah/GqWLszvLXVkOos0EB+d/VItntWa3lCQwpqwW7OrPXHWotVJw/9I9V?=
 =?us-ascii?Q?ZbV033yeBxM/xCkbCoDQxRsXFaaKzRZgo00mI6oO/KCHVhXJ4/qsKtcxfuPb?=
 =?us-ascii?Q?IR7ogu3iSt32qhjWyYB+5Ft62Nbd6GwZZq7GhyBdxUcQhHygo1Yb3ZZKU/Fr?=
 =?us-ascii?Q?6Y7+HAI6mEBSkTnCJ6HBT6koE4RAXSY9Z21ND9yFfnKz4NXbEa5ESOpwaA4z?=
 =?us-ascii?Q?wL0MQMg13G98DAST7HnDhHYgHhXfKzoCEOww8kX17c8DJPz854SD4BXroCTN?=
 =?us-ascii?Q?oCMEknjZ54dkUNd0YVyc2zvqekupp+CHMD/9SN/4V5KlDCd/87XchdiWjs7a?=
 =?us-ascii?Q?pqrTUupT/wrDhZFKEGg5838jFVN/SvnBRpJ84iP7UU/X2zy0YufrGDVyAV0j?=
 =?us-ascii?Q?/0VpytM0GAH47a+INs66LHuGjDIIVNK3tH+Dy7md8+JV0SU7weWiS+355CKq?=
 =?us-ascii?Q?04WZWouCasZIzFOZ08nkE574zum235ZNHOpLz/DLlhi5OyVYRCM1cfb7ipeB?=
 =?us-ascii?Q?gnLVIFuXvswIUJsKSE/Mm7XoT0y1EFowj7cMrmYpn9uFizxIV7wTyDp9v9ZV?=
 =?us-ascii?Q?ckRfbdD2+uVfPXJnhhI33YmhNZQ5NxlFh5/6sygAj7+mxaCN+TajTBox7m1E?=
 =?us-ascii?Q?pbvpqDskbitFMMF66nZg+H1JDYFIOz+eoUr3oeUWcH65oF3XQ1J8UZ62yv5u?=
 =?us-ascii?Q?h8HOQ+zkO+vKQ6G+mjz3kh4Hu2F4LOlV/m1OSX6qtd3IPvFI7FkxBAAEmSqI?=
 =?us-ascii?Q?fCe3xXNutiC0VQ0qeef/dpZjU69MSlRnt2v+bdGqpud1Fpz7KYRxNfs58tNO?=
 =?us-ascii?Q?0GqFWtTqw35Pu04H1IkGFkXMR3jUCOL5B8gAPUCWe7VzppSPN0arXKzJoIkq?=
 =?us-ascii?Q?HNXH9xM7miMe+rOYHyBUUFYJqe525eGnVtTkS0BcUmDdXvOhSiJ7wLaLNWyh?=
 =?us-ascii?Q?s5wDVeStnoxSTmTU1gy0YwH6U9GFJsC33luY4nnVHSl9KSJetknTVD2TcbVE?=
 =?us-ascii?Q?AjiUyfSMXuYFph9KFpEQQtk4JozttUp8ZO2IllswzgePhlgZJ9G4u9HDFNvC?=
 =?us-ascii?Q?P2eABzuu4P0ORm6kNBQW3GAO+bFCuhdS1X4qFxnWmZlTp1ZfhOuBKLhEH8jB?=
 =?us-ascii?Q?GcaecWJ/5lJpfF9J3JBKPRcW5MVRY2qR47ePzB1b7oFtK3oIHOhrEZyUaL2J?=
 =?us-ascii?Q?LjT/hZ1QTzOU7VGMrma4pf7t5Ky3Vx6ydAx24Uue+Dvxk4pukA3MrEeHQ225?=
 =?us-ascii?Q?vZAlYXBr/2+HVti5RUenincEYdyFnmfZoJghAWs3?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a39d071-f311-4616-7778-08ddee99471b
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 05:33:44.9468
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M4lo+ESn6XQM9IRtPjhCO2KZErNMsWkw7YMqU9w8dyaBBOD3JbE0W87YJohJ2IlrZxX+3KjGi/3coeJXLH+tyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10727

From: Stephen Boyd <swboyd@chromium.org>

Ease driver development by adding stubs for the typec_switch APIs when
CONFIG_TYPEC=n. Copy the same method used for the typec_mux APIs to be
consistent.

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
Signed-off-by: Xu Yang <xu.yang_2@nxp.com>

---
Changes in v4:
 - no changes
Changes in v3:
 - add my Signed-off-by
 - add Acked-by tag
Changes in v2:
 - pick up this patch to fix build error in v1
 - refer to https://lore.kernel.org/linux-usb/Ztb1sI2W7t5k2yT7@kuha.fi.intel.com/
---
 include/linux/usb/typec_mux.h | 43 +++++++++++++++++++++++++++++++----
 1 file changed, 38 insertions(+), 5 deletions(-)

diff --git a/include/linux/usb/typec_mux.h b/include/linux/usb/typec_mux.h
index 2489a7857d8e..efb5ed32b813 100644
--- a/include/linux/usb/typec_mux.h
+++ b/include/linux/usb/typec_mux.h
@@ -3,6 +3,7 @@
 #ifndef __USB_TYPEC_MUX
 #define __USB_TYPEC_MUX
 
+#include <linux/err.h>
 #include <linux/property.h>
 #include <linux/usb/typec.h>
 
@@ -24,16 +25,13 @@ struct typec_switch_desc {
 	void *drvdata;
 };
 
+#if IS_ENABLED(CONFIG_TYPEC)
+
 struct typec_switch *fwnode_typec_switch_get(struct fwnode_handle *fwnode);
 void typec_switch_put(struct typec_switch *sw);
 int typec_switch_set(struct typec_switch *sw,
 		     enum typec_orientation orientation);
 
-static inline struct typec_switch *typec_switch_get(struct device *dev)
-{
-	return fwnode_typec_switch_get(dev_fwnode(dev));
-}
-
 struct typec_switch_dev *
 typec_switch_register(struct device *parent,
 		      const struct typec_switch_desc *desc);
@@ -42,6 +40,41 @@ void typec_switch_unregister(struct typec_switch_dev *sw);
 void typec_switch_set_drvdata(struct typec_switch_dev *sw, void *data);
 void *typec_switch_get_drvdata(struct typec_switch_dev *sw);
 
+#else
+
+static inline struct typec_switch *
+fwnode_typec_switch_get(struct fwnode_handle *fwnode)
+{
+	return NULL;
+}
+static inline void typec_switch_put(struct typec_switch *sw) {}
+static inline int typec_switch_set(struct typec_switch *sw,
+		     enum typec_orientation orientation)
+{
+	return 0;
+}
+
+static inline struct typec_switch_dev *
+typec_switch_register(struct device *parent,
+		      const struct typec_switch_desc *desc)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
+static inline void typec_switch_unregister(struct typec_switch_dev *sw) {}
+
+static inline void typec_switch_set_drvdata(struct typec_switch_dev *sw, void *data) {}
+static inline void *typec_switch_get_drvdata(struct typec_switch_dev *sw)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
+
+#endif /* CONFIG_TYPEC */
+
+static inline struct typec_switch *typec_switch_get(struct device *dev)
+{
+	return fwnode_typec_switch_get(dev_fwnode(dev));
+}
+
 struct typec_mux_state {
 	struct typec_altmode *alt;
 	unsigned long mode;
-- 
2.34.1


