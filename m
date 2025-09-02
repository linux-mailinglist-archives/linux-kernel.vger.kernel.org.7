Return-Path: <linux-kernel+bounces-795731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 637CCB3F729
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 09:56:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B84834841AF
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 07:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B90F72E7653;
	Tue,  2 Sep 2025 07:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4eDtQM5W"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4573E2E7BDA;
	Tue,  2 Sep 2025 07:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756799792; cv=fail; b=RuczBbJWFw5vpjpLzsYHmp0mAMdN0Qh5duRvyHOPjA4SyZau7fob6aGUB/KGYdt4/v8wgPZs6Bfue+Z6ph8HVV+7L0AWhPDRK2VZ13Z9PgLsBhVPaZG7l04ZRFUQq4Bq/4YNaLXnNpY/Kw1INF3eTpPzd358HlLCNuW2voKQAx0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756799792; c=relaxed/simple;
	bh=+R1o28J3mK4M1CEkCThDhig/o0fSJwKbHvD4WYEbxkE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kME6YUol0guypeMQj0Le5nzHOR2lFamnJ+TKjzH5GKYQMuMcb84DAsZZxWo0/uMKRTfzdzs4D7VkItiMr5bXwRCf/WGl07LcPaNgCMXftNM3/QrgImxq6XprkPXtfGkbuOCMJvb8SqeCqiKzRkPb0D7JEWWjz56ee2+W7ZNJCnM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4eDtQM5W; arc=fail smtp.client-ip=40.107.94.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RX+97zFlpHMRfBrsLHcoyknR1d6gSuCXLmbPJcrcFfOBf8O88LhshSCytBaaFY4mcv8lh/IvV7noKbtsQHS8DP9qn5hxJWpc7xl0Krhv99xJ6BfuIWVo30uplFI9xf4jFBVlbOmnGMHWBqW2CpZvQP3b64CbHu1l5s2UhOCkF5frqZSQ+W7iUt6YFaPtRhK0eKuAG7Hq5nHIuvJOCzaUMGlLM40IZUhvZo0L5dwW+tiSpudVvyAC6JP6W550IeAP6Yf8tEMJGGcjkgqYD+sE9FlWI8jlXHBnr59GNTNTs0aANIL52MLw+R6rVVEdTbZ/57Zd1y384xxa3JzhxgqbNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EF0dIesb1CF6eFF1qFsPZXm1e6cJ0gN9TrOkXsHq9QU=;
 b=DVx7ogEhWugvWBGFVz7l6GXe0P7D9W2gDS40UGGZdmqL88iX3A3G515Bbn2axbaGxvOfkXzYkZb3Jvr+5Vle0mCG7eBeWJpzgDJ2RWVI83mwpoLAisqlOVAjCu2cPH3xryZAKAX1IX3A8JqliW8V+fi3KpwbZmXIeUX33YBV4nSSMgsA1gVqiB33yvwkb5DsRiHDl0WOBZU1acz1dnvpB+Igo2kEIjbxqL5xWB/0turDT35DG8BFte738ZHI7l2YS+iCJVVMS11wqS8Nx9fSq3l18ZvziiGFaOClWC878PTAM+DtsNCNcFPsYIrMtsauGawtLgxWghOMVdBNT25UDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EF0dIesb1CF6eFF1qFsPZXm1e6cJ0gN9TrOkXsHq9QU=;
 b=4eDtQM5WTT6ImmjNLavjOog6qQ9u7scRr7lzjnTrKbB+vEfI89fZJhGr+o+t1L4KkqGlzNE7deyrgf2xQfcKTI9Hhj4rujL6u7SxDHYek8ypTh/z/ziWxpPrLCpeoDqPiPPZqvr950CJHCvtJ+CKDCJ1txoZAcB2s9OvjMxXqbQ=
Received: from MW4P220CA0015.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::20)
 by DM6PR12MB4233.namprd12.prod.outlook.com (2603:10b6:5:210::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 07:56:27 +0000
Received: from CO1PEPF000066E7.namprd05.prod.outlook.com
 (2603:10b6:303:115:cafe::56) by MW4P220CA0015.outlook.office365.com
 (2603:10b6:303:115::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.26 via Frontend Transport; Tue,
 2 Sep 2025 07:56:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000066E7.mail.protection.outlook.com (10.167.249.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9094.14 via Frontend Transport; Tue, 2 Sep 2025 07:56:27 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 2 Sep
 2025 02:56:24 -0500
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Tue, 2 Sep 2025 02:56:23 -0500
From: Michal Simek <michal.simek@amd.com>
To: <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
	<michal.simek@xilinx.com>, <git@xilinx.com>
CC: Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>, "open list:OPEN FIRMWARE
 AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, "moderated
 list:ARM/ZYNQ ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 0/4] arm64: zynqmp: Minor DT changes
Date: Tue, 2 Sep 2025 09:56:17 +0200
Message-ID: <cover.1756799774.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1012; i=michal.simek@amd.com; h=from:subject:message-id; bh=+R1o28J3mK4M1CEkCThDhig/o0fSJwKbHvD4WYEbxkE=; b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWRsW6w0u/FdxOT34fn198pOv1Pn8HgtPeu8dn7B4df7/ 8pXuZvs7ShlYRDjYJAVU2SZzqTjsObbtaViyyPzYeawMoEMYeDiFICJ9Osy/BVvTvryslxniZbR sVMvCmomrU5fI8owv6i45pL7t2sXNQ8w/A85kH964pqWFfd8WqLlXR/ZzSjLMUvaue2n6NoaLeE rGVwA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: michal.simek@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E7:EE_|DM6PR12MB4233:EE_
X-MS-Office365-Filtering-Correlation-Id: 94c8988b-d0c6-47bd-5948-08dde9f63870
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?c+uSgHs9VaIfd/bdDVm7vD04L5RIz7g2eW8fkpyuINmAcxD01dI1L4LO91x/?=
 =?us-ascii?Q?JqVgvJEt3vjVrkZAnhEpRNXgZd2Js/45J32QJ0/Crtk8gW4ZkeJMyqEgJ2o7?=
 =?us-ascii?Q?tzTyq/tlLS0VOgEbdw6m0ehAQipB/orC0DRabzXQT3VN9VxXcoh0lb3wD3ex?=
 =?us-ascii?Q?4MxcCLlYZhwG+/ro7ttsspEZVicp6F4ra4BGiRg6uPkIr8zm56Puk8vIZH6Z?=
 =?us-ascii?Q?aPLbKb9L52+hIW/5Hmt0VJzX9EFFKIKrN57D07+FcvVsbVMrINL4Y0nShxIY?=
 =?us-ascii?Q?pgdk7YY1p4gQU4pGagy6vV3MTBv/GetRengoqpEJSNk9c5e+N9CsoCDUc4Dl?=
 =?us-ascii?Q?Sh8x/kPCpt57H3XVuqVUjbyBxTZviq38bYAopo7a1WVuZ4P0s6T7oEAmGTTp?=
 =?us-ascii?Q?dfFXXfCAkaQ/Y5new2HaL43q678ApNlA0Ldr1VLDa8et+5Qd1u6OGq2mEo1F?=
 =?us-ascii?Q?7dUFRXNmdoVdj278NvXZTIdshB/mWQ5eufl/NclIULzxtkB007cFpdWmrwi7?=
 =?us-ascii?Q?gqi3hsUJfKdSDxDe2y1SPGoTFU+1nmNN23Ve/0ZOhH+22GoMHhTPf2AvMqTz?=
 =?us-ascii?Q?et5Dr8k6Om7nO+0LZ+1s2WBGQ8YFeZOk71a5koLOQEd2OqlSvchd2srDPAmW?=
 =?us-ascii?Q?EBE9mZ09vu3OEzFc5eL8Fx6esp6RpBuRjWQONGpUmylDLGwYhv0/SWrxM5Ei?=
 =?us-ascii?Q?+mZToBzd3SlOUUQh2TsHMmu1Kkfu91PCXN1upVuiUPJ9DwaqbtXV7fR05Z8O?=
 =?us-ascii?Q?4loVDMQyvjSgij+EddZEZUnLI3pq7OwdL0Usn0iI7ohLdHBoeNfC5sCPK1HW?=
 =?us-ascii?Q?Zjt1u4HWWx9gnkSNGbxPZxkw/oi9SOvILCj7YpEFSUtbPSdZwlf5zypsq3or?=
 =?us-ascii?Q?KSgaU8qlZUwG0RhhHC2ACtqfR/aQVDGrgRAhPgpPbANiZAFMD0XFY1musToI?=
 =?us-ascii?Q?Cb/xVsTvn2a6ZtiA7Bul+9nxBwbOLZ7J5Cqbe1+64igh6zX1vA3cWaHqEdVQ?=
 =?us-ascii?Q?OK4ZXgFCrOOOAHPCnIr2GROOR58tt0o/k+VRemo4G5Z/yv8LBewDw21q+/77?=
 =?us-ascii?Q?zV+k0fpufFwKk7T7xlK7RrJKR7NmgzYzJEe7Rme+/En3qfqCLXgspIcPjby5?=
 =?us-ascii?Q?Zf0IyU4T8Gyv33w8gWxC9Og60VvYGJarA6wk2q1xWoDz+AgSJqeaPBY9R4nU?=
 =?us-ascii?Q?45/PNB64KncPcr7hmSezCzD0Gpl0lEHQTXK/oKz1ng48xLoJs7c80kK4YmKg?=
 =?us-ascii?Q?Pk1HydC2nlhyf4GbxiDOZl+YoYlQC9+ZiKMFgecJo+9xVTJ9MlpkRBOSPEek?=
 =?us-ascii?Q?eQGZLNC5py9EgTqfhnTEFgY99sSUlrQNxSyzWUJkhjyT8ik6eiCvXQ4j2ZQV?=
 =?us-ascii?Q?djXrU7EITy07EWvW6OnSe/EXT+D6oCGh/olVFNGu2t2mJNM0Z5WNRG5slMtw?=
 =?us-ascii?Q?cr4nhmei96JECI5nHhQ9Cg/0nHof+aHG/MU4+/UR9Hm8TgDFyqRgazRfKoVa?=
 =?us-ascii?Q?zTrV/j1pkh9sLI+K/+/b2RIuZoUxhfQ789bl?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 07:56:27.3254
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 94c8988b-d0c6-47bd-5948-08dde9f63870
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066E7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4233

Hi,

sending some small amount of patches to get in sync with U-Boot DTs
to be able to switch U-Boot to OF_UPSTREAM.
The next step is going to be to add missing boards to Linux.

Thanks,
Michal


Michal Simek (2):
  arm64: zynqmp: Describe ethernet controllers via aliases on SOM
  arm64: zynqmp: Enable DP in kr260/kv260 revA

Quanyang Wang (1):
  arm64: zynqmp: Disable coresight by default

Radhey Shyam Pandey (1):
  arm64: zynqmp: Revert usb node drive strength and slew rate for zcu106

 .../boot/dts/xilinx/zynqmp-sck-kr-g-revA.dtso | 17 +++++++++++++++
 .../boot/dts/xilinx/zynqmp-sck-kr-g-revB.dtso |  5 +++++
 .../boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso | 21 +++++++++++++++++++
 .../boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso |  4 ++++
 .../boot/dts/xilinx/zynqmp-zcu106-revA.dts    |  4 ++--
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi        |  4 ++++
 6 files changed, 53 insertions(+), 2 deletions(-)

-- 
2.43.0

base-commit: 4f96c5db61f238e8a957df2b81d6343a5e38ca59

