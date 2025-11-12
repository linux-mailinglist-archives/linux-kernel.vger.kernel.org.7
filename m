Return-Path: <linux-kernel+bounces-897145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B9CDBC5226D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 13:03:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CE5644E78BE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 11:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7DF1314A7C;
	Wed, 12 Nov 2025 11:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ghs86QX8"
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010023.outbound.protection.outlook.com [52.101.56.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46AC03148A1;
	Wed, 12 Nov 2025 11:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762948518; cv=fail; b=bh94JxHVfgFakQXQsJY+/fd3+YY5rzh2tP1uq1Lw9sdF93FeED7AFwoWwE52U1Y2hq3C319zyOYapZKfXQKhZj6Ww3xUVVxshOotn7wn8cdZPkHdGOJhVz/9SrMeDu1GL9VkwphKs/EIfNf2AtXNnKjmAQXRFRh8f+D8WFHJu4U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762948518; c=relaxed/simple;
	bh=m731IOFGJzSg7wpVxOxAeaURUEIDX4Vm/YL2O28WKUU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NHfnOtyC1P0zHaduUKPyBLFvawjNLIMgU/B+ctnOrEqGaLeNmRxVBcjUPuAf9w6R77SRhiWYhEWWZNQlG/CNxzWliZLbstH5PKUWeqRWNxMjCXsTA6QvHL0bnmWCeUU/vUj6XqSPHt9cEwq5V6ZlljLfpKGai2WV7ADDnVvBXKU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ghs86QX8; arc=fail smtp.client-ip=52.101.56.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JafWhb5sIB4p24R0NqEsZ3l58l5yVgEByDc5BP9ZiIh1Cizg2ItolGGhPDkYwYdcI5M5Brjr/GuAQvUOfap3EZ6Y/dtZ97kP/iRKpSf3X+iEzkXGARs1k1Q3e/wOWEKEsN9QR6rxSAQkXby3uGUxpl+jfMMd+PTfhupruIjDg5c3PXCm4HPKVrmRbODmqzOUV1anzhIIOKiibR0q2BrOMiqPB+gSjDZU5jUNPI9ZkThTsTXt7FIXSXiG/YiB4eo3laqECvTmrZ+9BzIVyJATDB6DpHmBY2MuumHfvF7hF37epDFWWgkDEolAiaCw01uMyzrrALM3IZgmtJwsn9qykg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fuxRsSXDgmk6tl9Pc4LPnHGl8bNRt0ZNKWH2Wb+I3Go=;
 b=gWUW9KU/0qpfSmiFBkt3q0VvWAQ26icllsA8U4pANruPe5DctVch8m1rXrWjIFMSE7+qXuL14nFSGYZC53sAgniqDkKEIykRz2EUefhd6RHx8JT4e/g5R72lSta4wAng3g51Y/fjlHu6JqFCa3Ij2TEFs5Y4cVwd4obbFMYNwV1S4BqrrLbQ1+SrvfJqrmZGuqGu7FC/55z8D7CwsXT35CEQvKpAeUzgpVJbcSPlh3uqFEmcGQdIcxIv87dWwYqVgY4dGdLSct62p+1psohstuAlP6EzyEYvadIJ0Teyj2pZdclmCsrAe7MBpwdZ+qPzJHxR46qZnO3/WlIUzCp+5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fuxRsSXDgmk6tl9Pc4LPnHGl8bNRt0ZNKWH2Wb+I3Go=;
 b=ghs86QX8v3cvUlAGt4MkUoWn34XIa77MummaJLgqqrr+WjOUS7Dv3RwrJLxHWT3sZvPdWflL4d2fL7Up3aFU2BrMJnzzsoNW+hcqjjlbVmHgmwax7gBQ78G1bBnMKBaVaJh5+Se9FzRTRqW2Ms452ex+rXMXnAX2Ne1sjFWfPAw=
Received: from MW4PR04CA0070.namprd04.prod.outlook.com (2603:10b6:303:6b::15)
 by SA1PR10MB997582.namprd10.prod.outlook.com (2603:10b6:806:4b4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Wed, 12 Nov
 2025 11:55:12 +0000
Received: from SJ1PEPF0000231A.namprd03.prod.outlook.com
 (2603:10b6:303:6b:cafe::84) by MW4PR04CA0070.outlook.office365.com
 (2603:10b6:303:6b::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.17 via Frontend Transport; Wed,
 12 Nov 2025 11:55:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SJ1PEPF0000231A.mail.protection.outlook.com (10.167.242.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Wed, 12 Nov 2025 11:55:12 +0000
Received: from DLEE209.ent.ti.com (157.170.170.98) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 12 Nov
 2025 05:55:07 -0600
Received: from DLEE203.ent.ti.com (157.170.170.78) by DLEE209.ent.ti.com
 (157.170.170.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 12 Nov
 2025 05:55:06 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 12 Nov 2025 05:55:06 -0600
Received: from ws.dhcp.ti.com (ws.dhcp.ti.com [172.24.233.149])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5ACBsxbo2638977;
	Wed, 12 Nov 2025 05:55:00 -0600
From: Rishikesh Donadkar <r-donadkar@ti.com>
To: <jai.luthra@linux.dev>, <laurent.pinchart@ideasonboard.com>,
	<mripard@kernel.org>
CC: <r-donadkar@ti.com>, <y-abhilashchandra@ti.com>, <devarsht@ti.com>,
	<s-jain1@ti.com>, <vigneshr@ti.com>, <mchehab@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <p.zabel@pengutronix.de>, <conor+dt@kernel.org>,
	<sakari.ailus@linux.intel.com>, <hverkuil-cisco@xs4all.nl>,
	<tomi.valkeinen@ideasonboard.com>, <jai.luthra@ideasonboard.com>,
	<changhuang.liang@starfivetech.com>, <jack.zhu@starfivetech.com>,
	<sjoerd@collabora.com>, <dan.carpenter@linaro.org>,
	<hverkuil+cisco@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v8 00/18] media: cadence,ti: CSI2RX Multistream Support
Date: Wed, 12 Nov 2025 17:24:41 +0530
Message-ID: <20251112115459.2479225-1-r-donadkar@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231A:EE_|SA1PR10MB997582:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c29bac8-8984-4642-c2ba-08de21e25600
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JnCBBRWaA+r87SMdIk1dGFinh2s6MTQAEdcxshrPTaAxrd4gEDk0YD0RMobR?=
 =?us-ascii?Q?yzIHCUP7c1x+c8+fNQ/ZpeNpr1L4L4ExswNbAN3EP8A05BXchhQNDcMdDXpZ?=
 =?us-ascii?Q?hQHp8KSs2GpjDmXWHB1IpC5mAD0OSC+RF7cMVN1AvNFv6VeaB84t3ghknddn?=
 =?us-ascii?Q?2gbsPZNEvYrHIMjr4ePnozIuodzeUqAqCLSAnBFXctN8sHUwDCYylkP+FBYT?=
 =?us-ascii?Q?NSC/+tiYv2p/g70GwHVBtZEB2YeFV8IuvMnUzOvw2zECucyCu/LH2XkZ5nul?=
 =?us-ascii?Q?zm73Li6y1dVRemVIAgOS5EHx4PbenPglhCkGREC1HiAtEJJjhl+bMmauH2jR?=
 =?us-ascii?Q?mHbg1eUw0M0xT22Ctox9Ug7TXMlcKJe/5C0xUB0/LQcWuE/h4EROzSRunV/g?=
 =?us-ascii?Q?ajHGqkAgFYsEovAUKSq0fVFn+eMVhD/EqlYwMS0aKLa4u/ymeoxYbCNon34Q?=
 =?us-ascii?Q?yimjTZwTh0BnaOyXQP6Pt1yLVPWWxsPYX5cMRgOafd154YXTP/Seg5nI+EVa?=
 =?us-ascii?Q?FcMOeuMs6XtDonTUdUcp+vlfDajCOWrxuzughBezoOik/iH37bNjihQIe3DC?=
 =?us-ascii?Q?MZW1/HPiSJUNnPr5Tq0bGhc1jyHK1iATYafPmAIpJGehRmNYTUzC3cR4pT5P?=
 =?us-ascii?Q?r80HrEzRGbDlX9iTfW9LBYLbwb1ZhB3xN8I5Y9tW34/p3OOrFDOvoXcUVxKX?=
 =?us-ascii?Q?uPVbOc4dTv1nliIfDyCYDzAmRWCKi0yXH5w67tMmEVzs8J0j08pPPfZZdtxp?=
 =?us-ascii?Q?63RsUrb0aVFBNb9eOY6LezLnyOBCalP08pRAomuOfDddQnFeaKL4+eoy1u6f?=
 =?us-ascii?Q?lefzQi3z0fXT3O1V1wZBiLiuBt3PMjert+To6Xb6Lo9ABVvA/g9Yt0laYmCk?=
 =?us-ascii?Q?iYqt4hOxeAyTzPj3n5FMaYW49gdkiy6bOG/CMaJ1fN5i/453jbqZezdewnzm?=
 =?us-ascii?Q?EYMx4YcbRf5P7p8KOUcn6NNst5JE+g/4ybvXyHxEd6jZ3NVJgCW3Ot74ca0C?=
 =?us-ascii?Q?4YLpfqzHW5kFanVLuc2n+9rpHgxAJYU1EeB2loAPSOiJt8vK7/cLsAv/bmDK?=
 =?us-ascii?Q?H6HSCp5K+1wNBDM/flKo/E1bE5cxwryF+u0ToHiasNx9zUvdYMo5xcXPxvD8?=
 =?us-ascii?Q?69LTOnLxvYWqcj21A/VLFLaITdFRePUBFv0hsXFpTu8ZbSi2QPI2VAQx7uK1?=
 =?us-ascii?Q?RBDBWRfezsvwrXZzTRRIJZlY6+QP5V6z/AlD8U6mgWDVmIAsozw3R3Ph1U6m?=
 =?us-ascii?Q?Xgwy9PZ9XMdW2rvGaU+ijxc1te+NFx4zyUXRB9S9wh21jv1rzwZQx2lYrHDR?=
 =?us-ascii?Q?tmMG0XXbPjLyNqSIgofRRSJpGgW6kj71ATwv7MW/giSsg/qMfZFrs7bG2m42?=
 =?us-ascii?Q?2yt8etopv8g/5jK+8asByncCY5c1XTFq84tU0tY8FWvLUEP7vIn8MuC1pokw?=
 =?us-ascii?Q?qV+QB+o2ybGqcvmj+q5aLJBf3jICZI0+YKaxb0d66Ht1yXh0aZsEmV0ULqWn?=
 =?us-ascii?Q?H69cZLCtDFoiS1DpxJn+pkvyqdUo8qK8u7kpIinm5LZCZk5Eho6UJUb+51Ax?=
 =?us-ascii?Q?UiPBuE0HZu2Ke5grfi0=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 11:55:12.1353
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c29bac8-8984-4642-c2ba-08de21e25600
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB997582

This series adds multi-stream support and PM support for Cadence CSI2RX
and TI CSI2RX SHIM drivers.

PM patches are picked from:
https://lore.kernel.org/all/20250902-ti_csi_pm-v2-0-59a3be199940@ideasonboard.com/

PATCH 01 :    Remove word size alignment restriction on frame width
PATCH 02-09:  Support multiple DMA contexts/video nodes in TI CSI2RX
PATCH 10-11:  Use get_frame_desc to propagate virtual channel
              information across Cadence and TI CSI-RX subdevs
PATCH 12-13:  Use new multi-stream APIs across the drivers to support
              multiplexed cameras from sources like UB960 (FPDLink)
PATCH 14:     Optimize stream on by submitting all queued buffers to DMA
PATCH 15:     Change the drain architecture to support multi-stream and
              implement completion barriers for last drain.
PATCH 16-18:  Runtime PM and System PM support for CSI-RX.

Testing for this series has been done on top of media tree with 4x IMX219
camera modules connected to TI's AM62A using V3 Link fusion mini board.

Overlay and defconfig changes for the same can be found below:
https://github.com/RISHI27-dot/linux/commits/u/multistream_v8

v4l2-compliance results:
https://gist.github.com/Rishikesh-D/c43ff1653ef59f2eb81ea76bd56780a4

---
Changes in v8:

# New patches in v8:
[PATCH v8 07/18] media: cadence: csi2rx: Move to .enable/disable_streams API
[PATCH v8 08/18] media: ti: j721e-csi2rx: Move to .enable/disable_streams API
- Remove the s_stream API and use the enable/disable_streams API right
  after adding the subdev for core device

Changes:
[PATCH v8 01/18] media: ti: j721e-csi2rx: Remove word size alignment on frame width
- Remove define for PSIL_WORD_SIZE_BYTES.
[PATCH v8 06/18] media: ti: j721e-csi2rx: add a subdev for the core device
- Use v4l2_subdev_state_get_format() instead of using the get_fmt from the 
  subdev pad ops in the ti_csi2rx_link_validate() function.
[PATCH v8 11/18] media: ti: j721e-csi2rx: add support for processing virtual channels
- Move routing support form this patch to PATCH 13/18.
[PATCH v8 12/18] media: cadence: csi2rx: add multistream support
- Move support for enable/disable_streams() API that was added in this patch to
  PATCH 07/18 earlier in this series.
- Remove the mutex from the driver
[PATCH v8 13/18] media: ti: j721e-csi2rx: add multistream support
- Move support for enable/disable_streams() API that was added in this patch to
  PATCH 08/18 earlier in this series.
- Remove csi->mutex protection inside enable/disable_streams() function calls to
  solve circular locking dependency warning.
- Mention that DT filtering is also supported in the commit message.

Link to (v7):
https://lore.kernel.org/all/20250911102832.1583440-1-r-donadkar@ti.com/#t

---
Changes in v7:

[PATCH v6 03/16] media: ti: j721e-csi2rx: separate out device and context
- Resolve bisect test fail because of undefined 'csi' variable
- Resolve bisect test fail because of 'vdev' not being in scope when used
[PATCH v6 07/16] media: ti: j721e-csi2rx: get number of contexts from device tree
- Resolve compiler warning regarding missing error code 'ret'
[PATCH v6 12/16] media: ti: j721e-csi2rx: Submit all available buffers
- Remove unused variable

Link to (v6):
https://lore.kernel.org/all/20250908134729.3940366-1-r-donadkar@ti.com/

---
Changes in v6:

# New patches in v6:

[PATCH v6 14/16] media: cadence: csi2rx: Support runtime PM
[PATCH v6 15/16] media: ti: j721e-csi2rx: Support runtime suspend
[PATCH v6 16/16] media: ti: j721e-csi2rx: Support system suspend
using pm_notifier

# Changes in patches from v5:
[PATCH v5 01/16] media: ti: j721e-csi2rx: Remove word size alignment
on frame width
- Remove restrictions on minimum frame width in ti_csi2rx_fill_fmt()
- Add Reviewed-by from Abhilash
[PATCH v5 02/16] dt-bindings: media: ti,j721e-csi2rx-shim: Support 32 dma chans
- No change
[PATCH v5 03/16] media: ti: j721e-csi2rx: separate out device and context
- No change
[PATCH v5 04/16] media: ti: j721e-csi2rx: prepare SHIM code for multiple contexts
- No change
[PATCH v5 05/16] media: ti: j721e-csi2rx: allocate DMA channel based on context index
- No change
[PATCH v5 06/16] media: ti: j721e-csi2rx: add a subdev for the core device
- No change
[PATCH v5 07/16] media: ti: j721e-csi2rx: get number of contexts from device tree
- Solve compilation warnings
[PATCH v5 08/16] media: cadence: csi2rx: add get_frame_desc wrapper
- No change
[PATCH v5 09/16] media: ti: j721e-csi2rx: add support for processing virtual channels
- Remove unnecessary call to v4l2_unlock_state()
[PATCH v5 10/16] media: cadence: csi2rx: add multistream support
- No change
[PATCH v5 11/16] media: ti: j721e-csi2rx: add multistream support
- No change
[PATCH v5 12/16] media: ti: j721e-csi2rx: Submit all available buffers
- No change
[PATCH v5 13/16] media: ti: j721e-csi2rx: Change the drain architecture for multistream
- Squash implementation of completion barriers for last drain cycle
- Make struct completion per ctx

Link to (v5):
https://lore.kernel.org/all/20250825142522.1826188-1-r-donadkar@ti.com/

---
Changes in v5:

# New patches in v5:

[PATCH v5 01/14] media: ti: j721e-csi2rx: Remove word size alignment
[PATCH v5 14/14] media: ti: j721e-csi2rx: Wait for the last drain

# Changes in patches from v4:

[PATCH v4 01/12] dt-bindings: media: ti,j721e-csi2rx-shim: Support 32 dma chans
- No change
[PATCH v4 02/12] media: ti: j721e-csi2rx: separate out device and context
- No change
[PATCH v4 03/12] media: ti: j721e-csi2rx: prepare SHIM code for multiple contexts
- No change
[PATCH v4 04/12] media: ti: j721e-csi2rx: allocate DMA channel based on context index
- No change
[PATCH v4 05/12] media: ti: j721e-csi2rx: add a subdev for the core device
- No change
[PATCH v4 06/12] media: ti: j721e-csi2rx: get number of contexts from device tree
- No change
[PATCH v4 07/12] media: cadence: csi2rx: add get_frame_desc wrapper
- No change
[PATCH v4 08/12] media: ti: j721e-csi2rx: add support for processing virtual channels
- No change
[PATCH v4 09/12] media: cadence: csi2rx: add multistream support
- No change
[PATCH v4 10/12] media: ti: j721e-csi2rx: add multistream support
- Serialize stream stop
- Remove the break statement to avoid early return in the loop, as
  reported by Sjoerd
[PATCH v4 11/12] media: ti: j721e-csi2rx: Submit all available buffers
- Delete the list node on DMA error to avoid kernel panic
[PATCH v4 12/12] media: ti: j721e-csi2rx: Change the drain architecture for multistream
- Mention about next frame after drain being bogus

Link to (v4):
  https://lore.kernel.org/all/20250514112527.1983068-1-r-donadkar@ti.com/

Changes in v4:

[PATCH 01/13] dt-bindings: media: ti,j721e-csi2rx-shim: Support 32 dma chans
  - No change
[PATCH 02/13] media: ti: j721e-csi2rx: separate out device and context
  - Add ctx identifier in the dev_err() message
  - No change
[PATCH 03/13] media: ti: j721e-csi2rx: prepare SHIM code for multiple contexts
  - Reduced the name string lenght from 32 chars to 5 chars
[PATCH 04/13] media: ti: j721e-csi2rx: allocate DMA channel based on context index
  - No change
[PATCH 05/13] media: ti: j721e-csi2rx: add a subdev for the core device
  - Add .enum_mbus_code callback
  - Replace statically allocated struct with a global static const struct
    v4l2_mbus_framefmt and used that in the _init_state() function
[PATCH 06/13] media: ti: j721e-csi2rx: get number of contexts from device tree
  - Fix the drain buffer being leaked
  - If the shows more number of ctx than the TI_CSI2RX_MAX_CTX, return an error
    instead of warning
[PATCH 07/13] media: cadence: csi2rx: add get_frame_desc wrapper
  - No change
[PATCH 08/13] media: ti: j721e-csi2rx: add support for processing virtual channels
  - Call ti_csi2rx_get_vc() only once on first stream start and cache the VC data in
    the driver, use the corresponding VC in all subsequent stream starts.
[PATCH 09/13] media: cadence: csi2rx: Use new enable stream APIs
[PATCH 10/13] media: cadence: csi2rx: Enable multi-stream support
  - Squash the above two patches into
    [PATCH v4 09/12] media: cadence: csi2rx: add multistream support
  - Use already obtained csi2rx->source_pad in enable_streams() and
    disable_streams() call
  - Update commit message with the reason for using a custom helper for s_stream
    instead of v4l2_subdev_s_stream_helper()
  - Use v4l2_get_link_freq() variant that takes pad of the source as its first
    argument instead of the one that takes v4l2_ctrl_handler
  - Call v4l2_get_link_freq() with bpp = 0 to prevent fallback to V4L2_CID_PIXEL_RATE
    in multi-stream case
  - Use lock guards to simplify error handling
  - Call csi2rx_update_vc_select() at first stream start before enabling the controller
[PATCH 11/13] media: ti: j721e-csi2rx: add multistream support
  - No change
[PATCH 12/13] media: ti: j721e-csi2rx: Submit all available buffers
  - No change
[PATCH 13/13] media: ti: j721e-csi2rx: Change the drain architecture for multistream
  - Fix checkpatch warning
  - Change commit message to give a better description of the patch

Link to (v3):
  https://lore.kernel.org/all/20250417065554.437541-1-r-donadkar@ti.com/

Changes in v3:

- Drop [PATCH v2 01/13] media: cadence: csi2rx: Support runtime PM from
  v2, support for runtime PM will be added in a separate series:
  https://lore.kernel.org/all/20250224-ti_csi_pm-v1-0-8f8c29ef646d@ideasonboard.com/
- Change the drain architecture to prevent FIFO overflow in multistream
  usecases.
- With the new drain architecture, we don't need the the driver to wait
  for userspace to start streaming on all "actively routed" video nodes
  before starting streaming on the source. So, revert back to the capture
  architecture where streams can be started and stopped independent
  to each other.

Link to (v2):
  https://lore.kernel.org/r/20240627-multistream-v2-0-6ae96c54c1c3@ti.com

Changes in v2:

- Change the multi-camera capture architecture to be similar to that of
  Tomi's RPi5 FE series, where the driver will wait for userspace to
  start streaming on all "actively routed" video nodes before starting
  streaming on the source. This simplifies things a lot from the HW
  perspective, which might run into deadlocks due to a shared FIFO
  between multiple DMA channels.

- Drop a few fixes that were posted separately and are already merged
- Fix dtschema warnings reported by Rob on [02/13]
- Fix warnings for uninitialized `used_vc` variable in cdns-csi2rx.c
- Return -EBUSY if someone updates routes for j721e-csi2rx subdev while
  streaming
- Only allow single-streams to be routed to the source pads (linked to
  video nodes) of the j721e-csi2rx device
- Squash the patches marked "SQUASH" in the v1 RFC series


Changhuang Liang (1):
  media: cadence: csi2rx: Support runtime PM

Jai Luthra (9):
  dt-bindings: media: ti,j721e-csi2rx-shim: Support 32 dma chans
  media: ti: j721e-csi2rx: separate out device and context
  media: ti: j721e-csi2rx: add a subdev for the core device
  media: ti: j721e-csi2rx: add support for processing virtual channels
  media: cadence: csi2rx: add multistream support
  media: ti: j721e-csi2rx: add multistream support
  media: ti: j721e-csi2rx: Submit all available buffers
  media: ti: j721e-csi2rx: Support runtime suspend
  media: ti: j721e-csi2rx: Support system suspend using pm_notifier

Pratyush Yadav (4):
  media: ti: j721e-csi2rx: prepare SHIM code for multiple contexts
  media: ti: j721e-csi2rx: allocate DMA channel based on context index
  media: ti: j721e-csi2rx: get number of contexts from device tree
  media: cadence: csi2rx: add get_frame_desc wrapper

Rishikesh Donadkar (4):
  media: ti: j721e-csi2rx: Remove word size alignment on frame width
  media: cadence: csi2rx: Move to .enable/disable_streams API
  media: ti: j721e-csi2rx: Move to .enable/disable_streams API
  media: ti: j721e-csi2rx: Change the drain architecture for multistream

 .../bindings/media/ti,j721e-csi2rx-shim.yaml  |   39 +-
 drivers/media/platform/cadence/Kconfig        |    1 +
 drivers/media/platform/cadence/cdns-csi2rx.c  |  496 +++++--
 drivers/media/platform/ti/Kconfig             |    1 +
 .../platform/ti/j721e-csi2rx/j721e-csi2rx.c   | 1186 +++++++++++++----
 5 files changed, 1304 insertions(+), 419 deletions(-)

-- 
2.34.1


