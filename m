Return-Path: <linux-kernel+bounces-736716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ECF7FB0A0E2
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 12:45:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26D995A62F5
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 10:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA2192BCF4B;
	Fri, 18 Jul 2025 10:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Ixk5Nj/H"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2075.outbound.protection.outlook.com [40.107.94.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6210213AF2;
	Fri, 18 Jul 2025 10:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752835528; cv=fail; b=EeY1MUMGk+7fbeUOj+qIqmlRHHEFjK4SJoveH/6gW9F9NbAV5FHxDgz/dNtOoiHDnKxOLQpLzaJBL+Q0DM+jcSwmHft8W7DaAd2YMgmESaPGJNRZZJ74lSgkkqtYiE+8D6Q7fuilQVbvVLP0tyBGLnKgC6hhAIOedmZHbVVu8uw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752835528; c=relaxed/simple;
	bh=yz8DpwRuSGDm8ALBYmQpdh//CbUVTQ/NxyGWYqla7KE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IKWTe0KPLA6azUC5/7Ixk724xL46JGtYHkHrvcZNCA9STz+O/33TrWJ3ATdr5/yR6H+fXo0F8RgPO0DpirT2O71GJilkSi9mIyUm0hGqpnOcHVeV+Ck/rt5Ckgg214GQFmzTjwVVqLYjupZUt7uAlj8xbXMVvtGPa9AiCLNNp/c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Ixk5Nj/H; arc=fail smtp.client-ip=40.107.94.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wV21cpLXFbQFW/nHR/gseYWSuZyfLfwYNeMUB8jeyqrI1UsppxYUpayft4AVMTNZj2oQeAXw/cKcqYUjsXcVB/fKCGdD8H6Ybq5JRez9euq4SLIObEO5X0dgqLSppz2k19xV46t+JJExZGozBaXTF25xM+FBbbTsfYQgfM5WB6H2D11BADVOtKJ3oPXupVuVebbreNm2w6CGwYzBWPUHTkeYqv1GDKt3EcNsi8SXUj1+OXjzJp32XR/ecFzkk/M+7DQmv4Nc7uAlaeUrifOqx+C4t+OidfOaiHEWrmrXIIDEbnix4KZMn79WUA5swZ58z356OeFNmbW1pLfbImBPsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1aPDc3pLTMtGBn0qwQs4lS11npWdKa2uPsX7K69hUoI=;
 b=ZGuRaUm0ST8Nzpe9bKKkh56jFt4EEPaNpw/Y48WK32z1mSMPSA3MBSfSU3yh4ba/fkCUX4HXpuld3Af7kMOdYClK6rTZWp2THctYPgYQJEzStZmpgKXvSHlxNrKRvGutGNxAOt6RxHZQ3kMWREBLqCnX8c3uzBnzShIhfSdEYlu20VLs3oV4vg1aQNlbIixq/N91w3KiaTnnLdtf+M4d/LkM6mmUqkBe+L53o2MmELTR/sPWwlcnYaViZCDdkCklsVFYm9yfxGCX1X8c7iD7H36zJz3b8xW5c4vju02QUvrkRwZgT6Lkv1mIwyfJpm/PyLmkOyvw3QscQ8njKpWjiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1aPDc3pLTMtGBn0qwQs4lS11npWdKa2uPsX7K69hUoI=;
 b=Ixk5Nj/HueBPp50zFkga77X1KH8nMG6hnte3DQucke8P53sqfAvMTDEdWOFvAceZupcbF7QXsxzdsIGPAIubVb+nLPNgeFTG/kzNGfpJmZ+PAHlqudPLY+oMXJFkKJ179BYH+jTidVfECWW8mrmMPqml6b8Py2WsafU6jrYWWak=
Received: from CH0PR03CA0435.namprd03.prod.outlook.com (2603:10b6:610:10e::9)
 by IA1PR12MB7519.namprd12.prod.outlook.com (2603:10b6:208:418::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Fri, 18 Jul
 2025 10:45:21 +0000
Received: from CH2PEPF0000009F.namprd02.prod.outlook.com
 (2603:10b6:610:10e:cafe::9) by CH0PR03CA0435.outlook.office365.com
 (2603:10b6:610:10e::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.23 via Frontend Transport; Fri,
 18 Jul 2025 10:45:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH2PEPF0000009F.mail.protection.outlook.com (10.167.244.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8943.21 via Frontend Transport; Fri, 18 Jul 2025 10:45:21 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 18 Jul
 2025 05:45:18 -0500
Received: from localhost (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Fri, 18 Jul 2025 05:45:17 -0500
From: Michal Simek <michal.simek@amd.com>
To: <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
	<michal.simek@xilinx.com>, <git@xilinx.com>
CC: Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>, "open list:OPEN FIRMWARE
 AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, "moderated
 list:ARM/ZYNQ ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 0/7] arm64: zynqmp: Misc changes
Date: Fri, 18 Jul 2025 12:45:05 +0200
Message-ID: <cover.1752835501.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1510; i=michal.simek@amd.com; h=from:subject:message-id; bh=yz8DpwRuSGDm8ALBYmQpdh//CbUVTQ/NxyGWYqla7KE=; b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWRUqW7Sdrm6t01gi0G3bRP70ekr1TfO3rH/5g//zC1Z2 7sd1lgxd5SyMIhxMMiKKbJMZ9JxWPPt2lKx5ZH5MHNYmUCGMHBxCsBELogy/LOblLLlf2vHlmlP t51wz9KxbpnQtG5OUaNp8A6nW/sWV3Az/FPhj35b81TX5G3VkwVPojzfdc59Lvl0xpbidx2RKQb 37fgA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: michal.simek@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009F:EE_|IA1PR12MB7519:EE_
X-MS-Office365-Filtering-Correlation-Id: fe4ac463-6654-4139-ba9e-08ddc5e831bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GQgjl4CqWYLE30m+pfsq6w0+m0XwUq+ER9w5U/35/f/3jz0iYeHRkXRqbBgO?=
 =?us-ascii?Q?spT7BR1hB93N7jlN7k3cexAsTKS2PZ5wbQ9w9m9kDGwnXufrw5EpE459X+LE?=
 =?us-ascii?Q?NnTjd4BWpRJ8TR98rgmrVo51CSYZCAPyMd+3t+mIQm1RxgoGEqB1w2OCecLs?=
 =?us-ascii?Q?uwOH2NznvQAtfNd5Lc5p0QFVIGu3wZ8GCeE90z88Tx84rDk9/Djft9DRutrR?=
 =?us-ascii?Q?uoVaweAzm4Qvh6Z4PuuiaHZij5Wlb0hqWGVcsQCxm/FbwQaonEOHdE/bxiKD?=
 =?us-ascii?Q?i16pc1P/dzvRV/qWOo1nbtC9a/VV8qfat7mJNSMaoMUNmGcQ9cGcBuIqp8rW?=
 =?us-ascii?Q?UdLaj4dqYCE5ZqhqI8zXsP+mBLQLx7k341tqo/5xrgzf6f/1C9+63fDT5RA/?=
 =?us-ascii?Q?UsjgRwCKlvZ8jQBZsgVEKCepenRrQKc4YrfNn0j5BiUussDkU1f8bdabfA7L?=
 =?us-ascii?Q?UTFlkhlWgOisKqTv7C0schphJOh0y37n/jBUWYgt1rjuWvffYRGOydgjC/sY?=
 =?us-ascii?Q?1mOyITGv00c1TKU/L/T4gRVUJ2MDpwprW6zSBUwDlfoJw8wPvD0WAEHWDcwx?=
 =?us-ascii?Q?xGdv80EeP18HXe8G8cMG7XK1JbEg55bz0OyWFFiEcooF8pCWjRJoFwPP6XqJ?=
 =?us-ascii?Q?bs+2RJASyhse1rBrgFiz7eXuBkfw30Li48ibAAy4haq8zMP6aoDl+kmvVCPh?=
 =?us-ascii?Q?HUrafUTjWXg6Bz08BQCneWvKQCQp1qDUtpSok2RPszH6NSzgilgcb6n9c7NR?=
 =?us-ascii?Q?fBCQGqcEUeQbcxm/ilYewAjrYsYdAxWJjcaAVzyw+5DRcUcamDB2d3f1La5r?=
 =?us-ascii?Q?i9J1JM11p76/U4TDqmu4L5nJF5pnpk8var8LKgXyWXHULkm+GBzNYsnyAzVa?=
 =?us-ascii?Q?Kb74h2+eBLOEEKknwe7qu5LBHiYlzfQdcth7GWvR8YSR/2IzcRHphgIYJHLf?=
 =?us-ascii?Q?+NxfkMd6UoHPlE0+goae9acD3u3DOfYOZr1EheLtzRHj/i1YixZYAZ4cyNqJ?=
 =?us-ascii?Q?Vq0Gduz4gL+E7oW1Z/aVsCA7i1rHnk5BysZ/lEpY9sXI1pKdnTzzqoKnYnmW?=
 =?us-ascii?Q?kguk43Bsim767u/bgog9HOoD+ZQAUDhS4DAbyvUGxM04o/9iuheSN40AIP3J?=
 =?us-ascii?Q?Lv+4O5mFEhouXrVjHMsNv2dhuezkjrHi91STYQoO7E7aR574yxoeWF+mj6oA?=
 =?us-ascii?Q?P/jysnLtADZFkDMWCOT8eJFJ0oUxkoNqZdk/mQDhlMnqf/xIx34txZt4w3jX?=
 =?us-ascii?Q?PrPY9WlwWGbRjW7ynHy4+nePagm33aXWH5qCyDuuzuAMuBPcjA7sSsYPbBVA?=
 =?us-ascii?Q?o5V2WqIe+/Z/xq6MiRKnkR/FcYeCZv1mX2U6dYNkuO+q5+t9N87cMKwFQiyt?=
 =?us-ascii?Q?2wJa9NCTOdM7LjMzO6Qc4nMw1xjOu+6pt3JtaXmdEwbP3/SBDXkYZgjt2mcb?=
 =?us-ascii?Q?PSJ/YqyZ3SpQIFcygjVtSzOT4Ej7R40AlZDp9JCQfZgdkEFn5R1R/ELW8ZW4?=
 =?us-ascii?Q?rfY4mBn4iuhADZM+im878fy1TllEhwGWipeW?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 10:45:21.3409
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe4ac463-6654-4139-ba9e-08ddc5e831bb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7519

Hi,

these are patches which I found in Xilinx tree which have never been
upstreamed.

Thanks,
Michal


Michal Simek (3):
  arm64: zynqmp: Use generic spi@ name in zcu111-revA
  arm64: zynqmp: Remove undocumented arasan,has-mdma property
  arm64: zynqmp: Introduce DP port labels

Paul Alvin (1):
  arm64: zynqmp: Add cap-mmc-hw-reset and no-sd, no-sdio property to
    eMMC

Rohit Visavalia (1):
  arm64: zynqmp: Enable DP for zcu100, zcu102, zcu104, zcu111

Venkatesh Yadav Abbarapu (1):
  arm64: zynqmp: Update the usb5744 hub node as per binding

Vishal Patel (1):
  arm64: zynqmp: Fix pwm-fan polarity

 .../boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso | 19 +++++++++-
 .../boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso | 35 +++++++++++++++----
 .../boot/dts/xilinx/zynqmp-sm-k26-revA.dts    |  7 ++--
 .../dts/xilinx/zynqmp-zc1751-xm016-dc2.dts    |  1 -
 .../dts/xilinx/zynqmp-zc1751-xm017-dc3.dts    |  1 -
 .../boot/dts/xilinx/zynqmp-zcu100-revC.dts    | 21 +++++++++++
 .../boot/dts/xilinx/zynqmp-zcu102-revA.dts    | 18 ++++++++++
 .../boot/dts/xilinx/zynqmp-zcu104-revA.dts    | 18 ++++++++++
 .../boot/dts/xilinx/zynqmp-zcu104-revC.dts    | 18 ++++++++++
 .../boot/dts/xilinx/zynqmp-zcu106-revA.dts    | 10 +++---
 .../boot/dts/xilinx/zynqmp-zcu111-revA.dts    | 20 ++++++++++-
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi        | 12 +++----
 12 files changed, 155 insertions(+), 25 deletions(-)

-- 
2.43.0

base-commit: 6832a9317eee280117cd695fa885b2b7a7a38daf

