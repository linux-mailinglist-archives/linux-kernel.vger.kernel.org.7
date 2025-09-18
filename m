Return-Path: <linux-kernel+bounces-822850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BA94B84CA6
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 15:26:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1346E624163
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 13:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFC63308F0F;
	Thu, 18 Sep 2025 13:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Q2OD75CJ"
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011040.outbound.protection.outlook.com [52.101.62.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1E12459ED
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 13:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758201980; cv=fail; b=rAyR9LHwIVjwn4zhiWOCZzAkbKtbDTC1foY0KEFVRa7WhsI1zkpVzBoXxge35l3fUtyI8Dmnimmwe5FfC8UnvwtmZczqMVPSy1gz1mSlbKT6qKPtgaTQcZjQSE1cUEkQ4x8j5S8zc988aAmu+rBCkE0QrM1ovIetYqS2YVPg2B0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758201980; c=relaxed/simple;
	bh=RGAS+eqQv8OEF4oTHkpFykiaYORWjhLIzX/UBtmp2XQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jyvHxxZiXUp2YdXviM2ck3+67MFga6fZO41omGq3FgsGf3i6gHRp5ltHLZVbD36HrXLiaJ1UkXOEqLDXEbjDPxZD5qJgFt3kq/MhzR+Y/4gc3Re0sCf5SBASV/A41lbHZOZVWxb8GBbkoNGFhAGe/YSaZInTAK7BVZ2Hw64+J+0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Q2OD75CJ; arc=fail smtp.client-ip=52.101.62.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ej8znNl39a1m2qlWjzC77cPFla9QTxe1Rh/D8I9IrWA+PZE86kneeTZoNtkJiRuZUPt0gSuyes2Hy89BZP2CuzhIeKtKYv4xImEeIm4Pf+kM3gCtNL7AjrcS/bcSLVN1LD6pS9cV37YyK4LgHx0fC70eX88fr+/rWVv52daAtdKYQeId+VGGv75VJHqSx8phlBqpJspl5zpTHuQLn/1YXzdXAoejO6sM7JVU1QmoxQVN43n2y9RdyuJfUxU3OuNvo2bmLHfZ3YyYGkAbzvgR037ZZGXxHAoon0wVSARZhQ2iMza/XmiN+6qmIh8QsM8LFS4zwvx7b9aVXQP85h3dLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qxa8kePjA8oPf8ZJQwqTD5fif5VzYgM8BwBlSKuZW0U=;
 b=pHvFZ1D6OtTJuyAhlPuBzXds+z5I0BIIWADINm8GhF51VtIlRm8L0PALzw0NBwPaWkpyc8+VbmVVdOJSVCXatQc33s1yOM25L6JVENeoZbe9ze1ecVCR2/an2F81SOlVt01u8pPJHQ1L8+G2wI0Ul1yujjLJF4w3+zqaNCnldWXTGIkxbt5ypbcC3tj8JpuutQSNw10GYFdRtKy4E/Q1kGnLiA3yYgtEoJnXcjhLO9RZwcQTdauEQ2ORVgnKrdzCS065VcJc1YfYtrv3u2p63F1FIvHkYTBFjcCRhz1XX2p9VmbcGok0MaMsg3Q0gEw49qNSFEPUb10EgOazA8qfow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qxa8kePjA8oPf8ZJQwqTD5fif5VzYgM8BwBlSKuZW0U=;
 b=Q2OD75CJ+v7eXMtcuf8ACGiZV9DfmgMO0Mf/HK6fl129waIOKMRRxyLh2R1r5xGls2CSKPcvMPGPc0EjqjknVPGLvUwHN5/vwajDsm4KDlgM/CiFdH4ITf7se2IEwwBZ3/WIiOYfOYOyz+IVK70JwfyMNsFVq5Co87i61QZmLTD7OXff7J0WLd0ROPj/3voZ+Ucs/30GTLEnh+rYJfuxa5eMtdlemgbMQX00gUPhzSo8h3C4F6GecmELODfQDazujuyu+0b2BR6OA95GgjBG19IFSYci0pb9QXL6sQTXlsJptiwYQG4tKzba6QRbeeqG+ieBWMKRNFx3lFqNHfzE2g==
Received: from BYAPR05CA0013.namprd05.prod.outlook.com (2603:10b6:a03:c0::26)
 by DS0PR12MB8454.namprd12.prod.outlook.com (2603:10b6:8:15e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Thu, 18 Sep
 2025 13:26:14 +0000
Received: from SJ1PEPF000023CC.namprd02.prod.outlook.com
 (2603:10b6:a03:c0:cafe::42) by BYAPR05CA0013.outlook.office365.com
 (2603:10b6:a03:c0::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.13 via Frontend Transport; Thu,
 18 Sep 2025 13:26:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ1PEPF000023CC.mail.protection.outlook.com (10.167.244.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Thu, 18 Sep 2025 13:26:14 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 18 Sep
 2025 06:26:05 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 18 Sep 2025 06:26:05 -0700
Received: from SDONTHINENI-DESKTOP.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 18 Sep 2025 06:26:04 -0700
From: Shanker Donthineni <sdonthineni@nvidia.com>
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
CC: <linux-kernel@vger.kernel.org>, Shanker Donthineni
	<sdonthineni@nvidia.com>, Vikram Sethi <vsethi@nvidia.com>
Subject: [PATCH 2/2] arm64: cpufeature: Add Olympus MIDR to BBML2 allow list
Date: Thu, 18 Sep 2025 08:25:48 -0500
Message-ID: <20250918132548.1141306-3-sdonthineni@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250918132548.1141306-1-sdonthineni@nvidia.com>
References: <20250918132548.1141306-1-sdonthineni@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CC:EE_|DS0PR12MB8454:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b03819b-721b-4a37-69b7-08ddf6b6f144
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BiWYVDP7VBoCkrjchsfi4//Sdm8IeToaMVl/5XQZrKIcXzGwOQ1nN+gstgSj?=
 =?us-ascii?Q?fXQTJFNwNuSU1LpgB4PRQgwW1CYgFVP07Y3rDtFhWQ1d5q0OsfAvjAZ7g6Il?=
 =?us-ascii?Q?ThLXu4yNWRUBkLFHQyxVnrg1XTkCiwZ++hFSIe3HJPSdyKbtUkVb1zJe38Bd?=
 =?us-ascii?Q?e2MVfndyBzTeWV6/mDbQqPdBnXHyUgLIhFd/G7QWVID3T7dhvXFlu0bPgr/G?=
 =?us-ascii?Q?YUhzhxwq3S5MWOoOLqVIUDOOp+3cExBrSXIYulR8XQc8YI21XOCLBeRUo7gr?=
 =?us-ascii?Q?8zcibAMflpLohuxqQ4oge7YV7agf4e0Tm5sCJSU+8VtUfmYzwr1owWW9VUo7?=
 =?us-ascii?Q?mRddzXsP1LKsw9JyBBeoOm7HhHFFPedLgPp4Mv0xYpfdECJaTsNcn8M2XBzD?=
 =?us-ascii?Q?GH+kFD52PNqjQyNbzYKEePJs0go/0jG9loabTB7Jof97mHM5XIsagRf5x7f1?=
 =?us-ascii?Q?XhrRXjT/ba86tjNV3Q6Zv94KrG5SgIs2T6ig/Q7gZFuarB1vQhtWmshw/Nlo?=
 =?us-ascii?Q?HFlkrMGMP7/PPoOmAUJd34EKDTUCJ4r96K415TjE6n+sEjoKPNjN5yAFzhBo?=
 =?us-ascii?Q?R45krOff25ExHS+6iK+HsKnhEM37RzYg6ZLxoC7F+/cTA2Dyd0fCukISZRXY?=
 =?us-ascii?Q?LPCwlqH4YK9Yb0U0XiiHfMfBPGmPkdUCTVxNVSL+neo1c1h3CqnJkanJ+FP7?=
 =?us-ascii?Q?MrYAIM1RAtGKZCa4AadEM6JJGproDPhU4AZVzJ0EaXKGZNkd2BrfvQrat7uu?=
 =?us-ascii?Q?qb0Rs6k3riNANNWRMMJENMrBdU7EXxnQln1Xs+KNi2ppvMzxJvJecreyHGua?=
 =?us-ascii?Q?4xuOrDuylt0VHyKTz6RnXnVIFUS/L34xUu3RKhIQ3UbQY6ne2XjLp/Gj4hW9?=
 =?us-ascii?Q?bBEpDEdyllZCmR1C0Y2OCTSBSoK8JCOEDwZTJUwbXi+F9wOb5d/IxwBaM6Mx?=
 =?us-ascii?Q?iXL8TzGAynZCEfEgNqnwRmmq9eq4deOfODuoXTb8Lb/sIfIGcA56i94bZQR0?=
 =?us-ascii?Q?vDlmwH61AT8yxYtir3LBxD236JgqiFIMI7MqJ4L6439Bw18ZduZUO5mNp2Hj?=
 =?us-ascii?Q?eS3HXB/PnCByUefE1+g0qesWdvTvvaPbdxok31dxeaWqAwmFR/YBMYLvBw4O?=
 =?us-ascii?Q?xGcUPu0/iL7D5r1SOtKQolTa1TEtjepZaZQ2rVBNT+4Kdila8shmHiTAIovh?=
 =?us-ascii?Q?FaSvBe25zMZfw7sRLF0zsqEvWOEmiOkQoQAAfEyFN3xz+Nmqt9bmKX4hA5ag?=
 =?us-ascii?Q?sKAp1eycfMLBhNo4R1s/bF5LF/P83Ew3E/L/yi6dBURWL76QB8y0xc79rNea?=
 =?us-ascii?Q?ZZiX1iMIV/CBcpv94snM7FGlNOMLuf/xov8HfdfuZWd1KpidhYrXsBWROK5+?=
 =?us-ascii?Q?+xDRE+R71a3132BBnntJmWc4sw4jsRaYUFB2leoaVcgfVH+9UME8+gIhl8Jl?=
 =?us-ascii?Q?NxZsUmjP1gVauAOdJJX4RtaHmZ2wUryepdJEIss005HyK7U2kIvWeZ7OZaYh?=
 =?us-ascii?Q?cBVaCDN8LVM/M9dDtD6VLhy928fZrggq7P0+?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 13:26:14.8409
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b03819b-721b-4a37-69b7-08ddf6b6f144
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023CC.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8454

The NVIDIA Olympus core supports BBML2 without conflict abort. Add
its MIDR to the allow list to enable FEAT_BBM.

Signed-off-by: Shanker Donthineni <sdonthineni@nvidia.com>
---
 arch/arm64/kernel/cpufeature.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index bb6d82b2f7584..30f45af3b684e 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -2236,6 +2236,7 @@ static bool has_bbml2_noabort(const struct arm64_cpu_capabilities *caps, int sco
 	static const struct midr_range supports_bbml2_noabort_list[] = {
 		MIDR_REV_RANGE(MIDR_CORTEX_X4, 0, 3, 0xf),
 		MIDR_REV_RANGE(MIDR_NEOVERSE_V3, 0, 2, 0xf),
+		MIDR_ALL_VERSIONS(MIDR_NVIDIA_OLYMPUS),
 		{}
 	};
 
-- 
2.25.1


