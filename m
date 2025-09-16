Return-Path: <linux-kernel+bounces-818027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C9FB58BC2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 04:16:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C4DD1680EF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 02:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2EBF2222D0;
	Tue, 16 Sep 2025 02:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="L45HeAS9"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010009.outbound.protection.outlook.com [52.101.69.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03786610B;
	Tue, 16 Sep 2025 02:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757988983; cv=fail; b=V+DhburWE3oHtbXY8N5IudZNXzeuVNppV1g1sryRbE0pMqpwOtI6AP2NjvWZZUcg/JNFGiuQV4GBLc/uYJFEbwl/4U9VQFr+vZCUYuIQVGJDwOy+A1HzVRLo374CpfxxL1nMybZVUyS3d6c5SreQwDgEBDQRstenH/GFUN3szaw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757988983; c=relaxed/simple;
	bh=lDBTrzVKA6A/yVPW91p67QdaWDulF2+r6XibjC6F73Y=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=lf0p6DoXro6q5qJ8v1qYdIBdWTxnKnd41KB0wptH0hClmf4ySn51562dDserxwx1aVUy4cCFWGY0JYLOe6l5OFH4ojujtElE8tr/MABAmSMyduNLN8Zvf/fzCJiP2ku2ii0pdBAgsKx8Gz07RgKLiOhX8vFxeP/fIlVinM4sRBI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=L45HeAS9; arc=fail smtp.client-ip=52.101.69.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V0cCW2PcC6+9e1XX1v3IVhfjvmk0RkUUhGQflWrHHxw6/mzzwjUV/erkIPQ6XfwVBYtoPs1yzUjmfk6ybGK8Di0Gg1/0tu3n9j+uizbecekY6LziMltJzs1ePmGmUZc+JFL4JfOOvm4YXBiZ68+7fxZf84kcIT+IzYzYvVTfbLd799noHq/akINMCuhz3o8P3RNBxE+e/H7q8ZgBYueqaX7rR7fgJUuv18dXsbSkzJ0kXbdWGE1Y2Oma6lJKvN8/ikr03E2AZXiu1WbOtZt8nz9nlWXVHJ9CpOaDDU3Ma15LZdZUOYkM08TlFHD0zScUi+9i4xldrRmpBWcCSn8nLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2LMcCTVZs6SXXZkouXCtUUKSqEfSM6OH95B/c1ABOrs=;
 b=OcdBgoKv0sbs0txKhb1d2gmljWq3GAH63UTbfvVP1iOC8MmMcROuu+Qc9fYzLrbLL0vqsUxgPPszvI9wA+H1lXnB1qP74wCh4sIOP4kg1o53mx3Lh4WKepfUQDlil8a0nXjoK6JdRhV5IuXHGOflAspkka61mAvrAD1qdonDMwb+Q5PXcpVNAMyj/wFSsDr9gC0PDMEo6ZiT6Vm7c7sOAbI7Xvn1UNPoGgPmAdsxrmGOrGtuTPXv+ktFqTqUQZeb9DPsDvoz8rUBSNDbQT1wMNDweb+U+z9XotbjwFhG1L5cWyswVNQn/A/loKEmATMpcZDfELDgY37Tvoybk8dKPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2LMcCTVZs6SXXZkouXCtUUKSqEfSM6OH95B/c1ABOrs=;
 b=L45HeAS9Ja68mmLEPLOIpC/hm2lfSndPGnHrWz7dP20L7EHFLxWz7jYUzksPbi94PjrTve0FyrfZNyXBZajrzjYQ4SIdshrvS0ujX84G6dxMv5w5sfsU0duBomloMjw2pnQx4vveLWhy0ZYa+AqKpDYWkt4WgiHunFblF7R914nKGOzYbPY+1s22QrSyFQ70Zux1+B18T1Fm6H/Si5iWrVDmtZzCZQ5S6qD1xhumJvR08ctNh/tNbUsWQWGx+y+2SwchITeqPr8vlC6XhFnqatZ3Xkt6e6bf1vGKKe/jUJD8sW0cHF0lWdRFk9y2qFyv4CmpUce3evFmBPVwU1vHLQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by FRWPR04MB11103.eurprd04.prod.outlook.com (2603:10a6:d10:172::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.11; Tue, 16 Sep
 2025 02:16:17 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::c67b:71cd:6338:9dce]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::c67b:71cd:6338:9dce%4]) with mapi id 15.20.9137.010; Tue, 16 Sep 2025
 02:16:17 +0000
From: Xu Yang <xu.yang_2@nxp.com>
To: gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	jun.li@nxp.com
Subject: [PATCH v5] usb: typec: Stub out typec_switch APIs when CONFIG_TYPEC=n
Date: Tue, 16 Sep 2025 10:16:20 +0800
Message-Id: <20250916021620.1303995-1-xu.yang_2@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0006.apcprd04.prod.outlook.com
 (2603:1096:4:197::13) To DU2PR04MB8822.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|FRWPR04MB11103:EE_
X-MS-Office365-Filtering-Correlation-Id: 576d0327-41b6-4050-a715-08ddf4c70481
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|19092799006|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?k0hcpWmYa4u9/pCIXgfFQ31z58Vv+E0Kq+13p45GqNeO/xzF7HWy3uH3V7Fy?=
 =?us-ascii?Q?GLaQS0h6tl2t7iZAYLVZEz+OzgRhbmYyLhKYTNEZMvIUIVDJEufvzBlGC5D5?=
 =?us-ascii?Q?/6FXkwvnZGBV3XNXtCBDi0wK8NdswaurQ+Fw6+EVOX93C8TBXTbYkox/zQlT?=
 =?us-ascii?Q?+8y1gyUmXCwGZ5ThH09oS2QSMzHLRrK8SvkgdUpXn17Jb44KGyWkiTjxJcRm?=
 =?us-ascii?Q?85WZm3lolAcKZqdWY+HrP0HOTD/cTwhUFkPWfSFvTWBh93ZKZ3eugV0UmERv?=
 =?us-ascii?Q?b2n922WJGNdJhezqyVgeyVpm9nuewa2O31LsuCSjtGmAfhhhmtFNB21+hlfI?=
 =?us-ascii?Q?SzoEBf936pTMDTjM+kBfD+iESY+zchwrd4pNqM+QSATyQbE+5fdJJn+7Upny?=
 =?us-ascii?Q?0zPFDvkKf7q/CxqUT8C6KnmYmKKTEwyljJXFGu9JZf6bzpECJC+azrdel/3m?=
 =?us-ascii?Q?zo1QYswS2/0KhO7DL16u0umHc7nwwKq98L3wSzarspVcTeqU290CQQUar7t5?=
 =?us-ascii?Q?isflaoF5SPVt37ScuhJrMkyP2uO9xwnbIf9HK3zaq+KHMTG7hkY7qyqwDfrA?=
 =?us-ascii?Q?ZbEm38X3RBaBYaCErfkD9poG1eygax3K76afPwqh5I/rDjuvbK5lYmxnTgN9?=
 =?us-ascii?Q?ofRGLiz0baIMFNX/WkRTnm5lJQvmnpRuIp6w1T7WJUacahPLq5ud3XCwmXnX?=
 =?us-ascii?Q?miDWXLA0iUc1/UrPMcarcKBBVXtIICamr25swa9fM/qFDpo22Q8L07DUem+f?=
 =?us-ascii?Q?hS8GfOHMc0XohkXPKQDFqK2lU6qNW1c0yP7infm8ARsqgEiObN8fiD6KUEsm?=
 =?us-ascii?Q?FiYtXHClqDfggba0CoJNWo01YyOkrH8SAggZgtNbAUDxszwoxLTEXnh9LHXq?=
 =?us-ascii?Q?ZBlVzZAxPlDvqkw9CRERTPLUbeRtMuJgE/a7Q9aVXkizrqhm4qMCEDQEg2Ju?=
 =?us-ascii?Q?q5JJL+hPp/txIuUpo3Tg1t+v4t6zckfSWGWumMSCDEFhNAPtXGDeIu9Q4Jsq?=
 =?us-ascii?Q?JNv7bUxC55czx17k0M/TOEBcVJa7Ju/LAfpG8J0QXWnryN/r0LBvDkFnlhxw?=
 =?us-ascii?Q?46QYdesUvdcw7v+b8GnDcRWmmzDh8KOpDoQtl3PaU6/vcSgDXgDTH0NnsBlf?=
 =?us-ascii?Q?LyFr8I1TT2EeiXkmxOW0r400JyBI4xWFiMwfXAlZQFbBJ4GAimwuLHlgM0qJ?=
 =?us-ascii?Q?fT6FmVs6BPP+oOgGPczIUeZbj6tQEsSNiSo29STDoD2/XWKSmivlSwAUwsM5?=
 =?us-ascii?Q?VMMY0IJfeLrpMEj77tgfecAxTFNdJ9AQWw6vUOlAqwKLvrob5L2mV2UM3/qA?=
 =?us-ascii?Q?zR2Wl2jWYZWwozMxY+J7IzSxDdmYN/oGbgR3JmA+HkfYGpgqsFCKwB1+btmQ?=
 =?us-ascii?Q?dZwXMEr0yKikIJtk9HYiCpCqfuO/GwS3GGDwvpTSvprLMAWwdOL3lEdD0bvd?=
 =?us-ascii?Q?z5zXq3W0lbwUxL9lzklwotgMjFSwXllQCYv/a2Sb5iz5yKuKdXc6gGi+Vgwf?=
 =?us-ascii?Q?Fy2ys076E2CY4jI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(19092799006)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+qZz69qwvFVv7k+L3zUpS255Z12iwTyA858FxcWLWCHbnGb43cXU9qXUOkaL?=
 =?us-ascii?Q?w39jGSFSq0sE3EFGhxpfW0oRHX074eUHA+rwalh7//H7pKYcLHiN/RQb6oMc?=
 =?us-ascii?Q?6uYKKVwMT+k5eKcOeEf3hEGiuEtBbicIjB45mjQL8RKut2gomdUtdowGME1l?=
 =?us-ascii?Q?4sfH758kh/dqd+9tkfRPT3frOftNnyGtI18ehD4weJ4n2Uh+gdisrOO/UCF3?=
 =?us-ascii?Q?OEGnmuNsAXVc0HG/K5wEWt1rk5ko+HmxJibsl+KqdXhlkSBI6EF4yX/iSOPj?=
 =?us-ascii?Q?NcAYqZYb+KZ4T6J7LDxxHJouMU7KI8/GsGyvqLYcy6kkbch7ryMNx8qsSmQu?=
 =?us-ascii?Q?6kHcicd8Fu/JzXWyLEBchFKoOxteBHy4A5uRs4C5p6o1LiU0xOMWXvjA249u?=
 =?us-ascii?Q?ylcYYo0ugIl8UjgdcfO828f3laK6Hp3zqLRiiC/VGLwUPakzGzwnULfSvv1c?=
 =?us-ascii?Q?VFCIDusbKdHUsg9J11b2n/nouObmP9nWGvw5AhDH5fs3vf08+54VvmIUEKSR?=
 =?us-ascii?Q?l4WkezdGOjFgGK6XHh9Kc7a9R/jZUHIUfGQbmPMzGTLYi9JmpZdT/oEtB45d?=
 =?us-ascii?Q?W/CI6erdnRxt4hu3qtPk/tF1IjTqwChA+3H/k0My54Es3dNJEhG5GLSMUKHk?=
 =?us-ascii?Q?hR3Zc0AkqhHaFrMYctcZNc3hqNIurHHh7YyfaRoMVxJs5uQL6SUGrRLf4yUI?=
 =?us-ascii?Q?qqnSI1ciY8MwYB+Hqz1mCGiMSjfM6HnHoHPHVM0503S8XD22RRW7I+knvep5?=
 =?us-ascii?Q?jRRnmaoxL3dgopZoP25Cyk7qZMZCl9lhgAwQ9xmadVzbGuekepVxMzvyZ3Z/?=
 =?us-ascii?Q?WWSNccLXk2kQd5VhQ8xsiGkZl1G1zm456P6FCnMYOFbP8zKrrbLUKKJjMinh?=
 =?us-ascii?Q?cM5TR5wnNpDtOty6Wj8wZxMw8TNJk8aDl6XDFVbJdES19l0dAnRcAo0Q3hA6?=
 =?us-ascii?Q?WFN1mTsJM50gYxZBTUGzfTsskT1YkCizLLHmcCLLfiQqIohfkXhrmrlMRzZV?=
 =?us-ascii?Q?vvUf2jGskh62zSPVCk570sqYK90OyofdQeiHUhlsITORSMs3jcythlGIO/lt?=
 =?us-ascii?Q?fO8pi8ZUt3WmZkAuK000SEsbOewQP6yuZ7HMx3LmXQjNSianSYk/zJvIz9go?=
 =?us-ascii?Q?D8L5VoNCWL8GM2ek9PKxfs/eXZm8Seaz+dozKAVEE3wsi6Fpsc2M0j/NahCk?=
 =?us-ascii?Q?8qQfAELkAm2CgDNVER0kJKpWyvphYaQU9sjO8U/7RoZyzRDMlFubqKRgFtER?=
 =?us-ascii?Q?/fePX4IbJKewizc0EIxec0HEC5muhuQPQkGUzfUtDeVQDWeDEMCuXLm7RO/a?=
 =?us-ascii?Q?SHzupiIJCNdXs5Ek39rOpntjZCsbeIDBDuC0S12gC6yBuIT+wyeZjyDmWNzU?=
 =?us-ascii?Q?wXIitP93rjD1XHSvoz+ugJ4jX/BGwyWH4Gy7cddXz1ynpam+GF/fYVgID15G?=
 =?us-ascii?Q?SO2rmtStuo7v0x0f61tJnYJX9hCWGiiBb2rdQ9GBoxT7nCkPmqf32NEVVMkV?=
 =?us-ascii?Q?YBVy5qQYWHoNL2X75mBAKsA0VG+KaX3/5F+fASXJWCvUUxwmvspeVf52LEdR?=
 =?us-ascii?Q?z9+VA4y3W+QgmgDJMOpZRIUC9EgvFBCIDgWkqzDR?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 576d0327-41b6-4050-a715-08ddf4c70481
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 02:16:17.0223
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x0XWNAucvvDUA0DthyGLMYHRMA6SKFB0Xx5hHc9YGlp8/QOGfr+RJd9FxM/+eAfnRQulG8j2iElasacrQ4TbCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRWPR04MB11103

From: Stephen Boyd <swboyd@chromium.org>

Ease driver development by adding stubs for the typec_switch APIs when
CONFIG_TYPEC=n. Copy the same method used for the typec_mux APIs to be
consistent.

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
Signed-off-by: Xu Yang <xu.yang_2@nxp.com>

---
Changes in v5:
 - fix checkpatch warnings
Changes in v4:
 - no changes
Changes in v3:
 - add my Signed-off-by
 - add Acked-by tag
Changes in v2:
 - pick up this patch to fix build error in v1
 - refer to https://lore.kernel.org/linux-usb/Ztb1sI2W7t5k2yT7@kuha.fi.intel.com/
---
 include/linux/usb/typec_mux.h | 46 +++++++++++++++++++++++++++++++----
 1 file changed, 41 insertions(+), 5 deletions(-)

diff --git a/include/linux/usb/typec_mux.h b/include/linux/usb/typec_mux.h
index 2489a7857d8e..aa9ebb7e2fe0 100644
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
@@ -42,6 +40,44 @@ void typec_switch_unregister(struct typec_switch_dev *sw);
 void typec_switch_set_drvdata(struct typec_switch_dev *sw, void *data);
 void *typec_switch_get_drvdata(struct typec_switch_dev *sw);
 
+#else
+
+static inline struct typec_switch *
+fwnode_typec_switch_get(struct fwnode_handle *fwnode)
+{
+	return NULL;
+}
+
+static inline void typec_switch_put(struct typec_switch *sw) {}
+
+static inline int typec_switch_set(struct typec_switch *sw,
+				   enum typec_orientation orientation)
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
+
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


