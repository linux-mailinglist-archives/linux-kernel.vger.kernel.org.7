Return-Path: <linux-kernel+bounces-779107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E73BCB2EF29
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 09:13:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6129E7AD933
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 07:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F6FB28031D;
	Thu, 21 Aug 2025 07:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="a1bArBvN"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2058.outbound.protection.outlook.com [40.107.101.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210C72D7806
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 07:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755760410; cv=fail; b=Xc+J/vY1wZdN11l7O8vtDXKlWgTFcdloo27+04jn1A+rU6DyMKS1ONkyPO61kS/dIVoW7qVjYkzgcT2GB+U2XjeJ3+TqAV1fGCH4DNPb0wmBiflT8m/QjWb6ct0LewuGbjuwuFil5o93o0Zo1uqo0tYjoiBubLdZ0qi5Vj7u5B4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755760410; c=relaxed/simple;
	bh=ILOH7bMXKSzNVKyyrs7Wy9Bl3nrb0asKJA+nme1xeJk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P52fGv6p2x9QbKCISP/H4spyeBwa4JCGV9sQPJIKwR2c0wORyU6/gDweyNKXVUZwf8Yx9FBMOEutdLj+mUmiDzA1ZcdVQC5nDBImFPENXMoxm8G18iXCadJGNV7sDdOH8FvHFC2zZF7+W9FZA9HVAMAcS2bcVofU90pxEwUs+ME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=a1bArBvN; arc=fail smtp.client-ip=40.107.101.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L9g5fEsSzwMo5uCwwDbAGyAwKbtYwOaqaP5c2XvMzGO37qkzJUZnPr7wyssDHClNkVBv3s1tlFmildBoBHoQpjmey+7Iy8YyIsIPzTIIIQrQoJAcrfNNMGckkzR9YJdoYJ5+T0RtlRPId5bs+7GVbZGxjzOwC5+EVAuj+Cbvjxx+qda5I/31raIkVrRHasRJ8OKQzLcj/BWSiwpSiJxfr4JkeWuvl3LdlOxDeidzvUY5Zw6/3kwJX8KBIHzZ16zoeQzg/AJmu5PAU0HQClxaWdczpl0PNnNFGRpU4P+7p6L2TfUDSuFBwligqQkUfERry0eaNO7YFZOty3kw4RDXfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=krq6ndpsv8x9Hhv4NeEZAGkACdLQ3Dar9ZaFw3UEzhg=;
 b=ZsIkpapcaXVeU8XicgjynjmMydyJgcZW70oF+vJ4T9tjZdVKPPA5ccPKC+7D9odHz2fyXylVAHalRSwtfSahoOt/BeUUiYVslIJUapBzpaThcpvg/Ev4e6ueBDY9wWDTZINfCbL8QffEP5fjoI0VU8EkuHYU9eq2/zG4k+rZwBsEDDlxkWviI96slShIv2Mz77uHoRR5zPq2bwv3cQnmmg5PkGvMF12JzWEv0UUE/ngsH4jn+1e6yyebTR7nW1UQoDaYeMP9a+I2sSWcE9Zogw/+w5usqc/zUCrRXLxDDugSdKZt0IpMgW1qraCurDHlbDPrlcuN/q5R78LLBPF/nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=arndb.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=krq6ndpsv8x9Hhv4NeEZAGkACdLQ3Dar9ZaFw3UEzhg=;
 b=a1bArBvN/ujr5S2rwcD6YcJmLq6+77CWA0yTKF4D/ep2kV7zfNKUmdpiurZe5YFeiBXwq7WZ+xW+HuCdg3LiXiT3E7wTKw9TsWKDZ7IWTPn+3ceVV1V6YLHXeaZvQ7/t1gk32aUZp2v4k68+OQ9tF/fFa7gt8bahsCLfNV0cmoQ=
Received: from SJ0PR03CA0045.namprd03.prod.outlook.com (2603:10b6:a03:33e::20)
 by DS4PR12MB9769.namprd12.prod.outlook.com (2603:10b6:8:2a9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Thu, 21 Aug
 2025 07:13:26 +0000
Received: from CY4PEPF0000EE36.namprd05.prod.outlook.com
 (2603:10b6:a03:33e:cafe::9e) by SJ0PR03CA0045.outlook.office365.com
 (2603:10b6:a03:33e::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.14 via Frontend Transport; Thu,
 21 Aug 2025 07:13:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EE36.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Thu, 21 Aug 2025 07:13:25 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 21 Aug
 2025 02:13:23 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Thu, 21 Aug
 2025 00:13:22 -0700
Received: from xhdnipung41x.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 21 Aug 2025 02:13:18 -0500
From: Nipun Gupta <nipun.gupta@amd.com>
To: <arnd@arndb.de>, <gregkh@linuxfoundation.org>, <nikhil.agarwal@amd.com>
CC: <linux-kernel@vger.kernel.org>, <llvm@lists.linux.dev>,
	<oe-kbuild-all@lists.linux.dev>, <robin.murphy@arm.com>, <krzk@kernel.org>,
	<tglx@linutronix.de>, <maz@kernel.org>, <linux@weissschuh.net>,
	<chenqiuji666@gmail.com>, <peterz@infradead.org>, <robh@kernel.org>,
	<abhijit.gangurde@amd.com>, <nathan@kernel.org>, <nipun.gupta@amd.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH v2 2/2] vfio/cdx: update driver to build without CONFIG_GENERIC_MSI_IRQ
Date: Thu, 21 Aug 2025 12:43:08 +0530
Message-ID: <20250821071308.1572106-2-nipun.gupta@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250821071308.1572106-1-nipun.gupta@amd.com>
References: <20250821071308.1572106-1-nipun.gupta@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE36:EE_|DS4PR12MB9769:EE_
X-MS-Office365-Filtering-Correlation-Id: cd95c130-a968-4e72-fcae-08dde082389f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xMrgTMvQRBUv8tEMA2ocEGrhl2BfgfwGw+Wzo043CosllAs88hbO9/lAGPod?=
 =?us-ascii?Q?/ypXoXbAO3gwsCsp+sXjQ4d5NxYzm11r341/Nvtvyz0aFNAfkWAC2S+/KXDg?=
 =?us-ascii?Q?tiC+Btr1y4nC3pbAKPgDEFiEu6JbJc1GaT6+V5HwD8dMlP9rpALKbptEEV83?=
 =?us-ascii?Q?ZObVUxtWQrpTPo8vFoKcPAhBioMI1zzubT/HcW1N5w4U2p7C32w030NU4wmt?=
 =?us-ascii?Q?RRu6iWP473Zd8o4IdF7tNszZkpt4cAx8b72MBGxCSSmkfw2XIo4yEruo3yPI?=
 =?us-ascii?Q?kG9FI8sj13PYk3q9t6j6RiztB/G9w6vEiNDIkZvfKmpxGN/PFjthDRdmtKM8?=
 =?us-ascii?Q?QPn/9GM9Wet33kSFPSnjzSoPtzdLXOJdX4TP02OVvPdkkKcM1AQu/F7U8PUI?=
 =?us-ascii?Q?ahLr0fW2zI4tfcNHvsERu2MyUfX+LoLFZ/d+ObN9FIvcJsIJ516jk2CBiiIH?=
 =?us-ascii?Q?bEGGzl0jozfszKRFS39TOWIN1OVU6FWG7TfaNJIwe42hZ3meTqCH3+LqT1Mh?=
 =?us-ascii?Q?8qwwDKZNvQWVP6xwbxYCoOPEU66xfr0iawmUpK63+cEv+lp4arVgSBuh6V+I?=
 =?us-ascii?Q?ONJDqzjYpBekclL+ag3OOrswePd+jvSBvb8nLcDvCy2X5u+epugwwFOKgRUR?=
 =?us-ascii?Q?RsYrIsh50Px7sSwxbetiJR5zhcWnyBGDA+JwazpUCgjJLOROFWRyQ5ygITq/?=
 =?us-ascii?Q?ZugpzDYa3baf6r5k1kwVVIQjlm/kKNc8JDYEWxl22RudHyEZBxhRuw4mWN+Y?=
 =?us-ascii?Q?awK0cmkbl3jONq330im2zoxz5GDHOQiWnM20syVGEqMEpbR+WZgxIns5hmuu?=
 =?us-ascii?Q?uocIKrMu8rjkTCoSyDbkAttcN3rXf/PdYFeNZw0ZJlphAli5N5LEH0lOLDp5?=
 =?us-ascii?Q?he34M0YWxM7HdYLypYTc1rVbGJAQvJnNJ0l19XDJhas9zibsxGYYye28WNbg?=
 =?us-ascii?Q?J5jDxtKFve2yHiA33K+3Fz1PV4Vj3KIrNboLIpQBpstA939jJgJThS0G2wqf?=
 =?us-ascii?Q?NQUlpa5IezU9eKdGZT6uo45dTg6cQAAr30bjwCWXFNnxT8KuLJjxCAYF/3zJ?=
 =?us-ascii?Q?tJku2iAuPwcOCJjLJMLFb5bCpxCunB72xcrkQvrhnVMW5AC0o1e91pMQfc73?=
 =?us-ascii?Q?EBYl/caMyHPZV6nIr19Np7oe/N1puHJjTvJV6In2ZTlk2s5qvWNRDX0A3KEc?=
 =?us-ascii?Q?g8w2ocGqI2KGQLiflwqz4xShx7+i5OO6k+AaimTflr6acqCgDIOcc0mQwLXY?=
 =?us-ascii?Q?aGsp5OG3edrFMeCWvjjkT0qmq1PS3kdCdf6mbqZyJNP+rrMwIPFNTq2xper/?=
 =?us-ascii?Q?Kh7+ueaG0vawfkhnVviWtDma9oPFSORD+CvpHJsv/WVGsDjzz8DqXyyexg73?=
 =?us-ascii?Q?PcRnBH+Kne5oT+Elqv0+yUN2u+iylN+V/Aq7K0K5TUl+XD8f5/vh1oNTGbBG?=
 =?us-ascii?Q?QCTb2rpCDmFGrOce8a0I5iFkmGeyd5LK/6RK/zJmsJfFK10IXPG0ADbBYW6E?=
 =?us-ascii?Q?x+tic2kP2vtGBDF1Iqco+g8Ixwaq6+EAL8nDXN1CvWXtly6CVrYJvS6P0A?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 07:13:25.5950
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd95c130-a968-4e72-fcae-08dde082389f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE36.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9769

Define dummy MSI related APIs in VFIO CDX driver to build the
driver without enabling CONFIG_GENERIC_MSI_IRQ flag.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202508070308.opy5dIFX-lkp@intel.com/
Reviewed-by: Nikhil Agarwal <nikhil.agarwal@amd.com>
Signed-off-by: Nipun Gupta <nipun.gupta@amd.com>
---
Changes v1->v2:
- fix linking intr.c file in Makefile

 drivers/vfio/cdx/Makefile  |  6 +++++-
 drivers/vfio/cdx/private.h | 14 ++++++++++++++
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/vfio/cdx/Makefile b/drivers/vfio/cdx/Makefile
index df92b320122a..dadbef2419ea 100644
--- a/drivers/vfio/cdx/Makefile
+++ b/drivers/vfio/cdx/Makefile
@@ -5,4 +5,8 @@
 
 obj-$(CONFIG_VFIO_CDX) += vfio-cdx.o
 
-vfio-cdx-objs := main.o intr.o
+vfio-cdx-objs := main.o
+
+ifdef CONFIG_GENERIC_MSI_IRQ
+vfio-cdx-objs += intr.o
+endif
diff --git a/drivers/vfio/cdx/private.h b/drivers/vfio/cdx/private.h
index dc56729b3114..0482a1516439 100644
--- a/drivers/vfio/cdx/private.h
+++ b/drivers/vfio/cdx/private.h
@@ -38,11 +38,25 @@ struct vfio_cdx_device {
 	u8			config_msi;
 };
 
+#ifdef CONFIG_GENERIC_MSI_IRQ
 int vfio_cdx_set_irqs_ioctl(struct vfio_cdx_device *vdev,
 			    u32 flags, unsigned int index,
 			    unsigned int start, unsigned int count,
 			    void *data);
 
 void vfio_cdx_irqs_cleanup(struct vfio_cdx_device *vdev);
+#else
+static int vfio_cdx_set_irqs_ioctl(struct vfio_cdx_device *vdev,
+				   u32 flags, unsigned int index,
+				   unsigned int start, unsigned int count,
+				   void *data)
+{
+	return 0;
+}
+
+static void vfio_cdx_irqs_cleanup(struct vfio_cdx_device *vdev)
+{
+}
+#endif
 
 #endif /* VFIO_CDX_PRIVATE_H */
-- 
2.34.1


