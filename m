Return-Path: <linux-kernel+bounces-820285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B3ADB7D8D6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:30:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D09F3B3A87
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 08:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC23E30C63D;
	Wed, 17 Sep 2025 08:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5KXuyKMP"
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012001.outbound.protection.outlook.com [52.101.48.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 146E223D7E5
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 08:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758099146; cv=fail; b=fWce2OEGYm4Mb9MqD6DI0pscQdPnCo1yUZQsDizaLAA8vkax+rEweaj35sXfeMwvNrcn/EIFVsS+iDusprgvxS9u9kO9MkaN7IGyB4NPPhOYmICkwSpayfpktaDYi1j+Z3NmCNwT5HSoFkel6ugHCIcxMDQvKijXAwTiNMPlSFU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758099146; c=relaxed/simple;
	bh=XPml7sJx5PebgDKkCBg34VKl7fLzfJrIgieJmzwNzh4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gMhYxkJwvPI94+EIijE4l0bOWE4EjMih+sbpAwzfTN8bxC2W6NAfuzm3Z2zQoyt+nMQxXBYBtgKjCqArJh6sedzA4ixhPtNAx0jDKA0fzdY0LR9bKyEd0zeseIp4DJHy2cwTnrADyoxi367HnEeapZn5FMwRVx/ajDph+F4cz+s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5KXuyKMP; arc=fail smtp.client-ip=52.101.48.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wQaJ/F8Ftg0pqgSotmP2WuXhYO+8W1KX3i9I7DYlQjrF0Y9nWvLAAAaxV5bF+8BgTG5wLqI85SFuwisnxAYoo1K0Kk9+nh7I7b3PA/FmGB3tfOUDxQP8crZMSeOGQbfeaUTse/hjdLZ6sDOt3J87+E0mZuGWUMl3oRXcPFKQ2e+sjnLyckwkSphbIywFP072YVKhy3ec4jfrGCrIPoMbsg1SKMJ+UGNjT0LhMv7A0JxVzduBVQNUAxTewqh3q/bhaU3GHM5IQzytPruiDf79WUePaCWzprCQF1CzU1rF45znK03nrWyGx4nan1+hgZ2llFWHp+IXFr4jc6k+7KlbCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g8fq96neXMvURA4lCahLSKmLh3+2zLw67Cg61ECTaK0=;
 b=fgZJbnvV24gsoMTB/N83yWyu9QDrl4+Kjn3S8Siv1orR4etnvlz03qEm7V817E36+dU86bsiDB6OjVILBSdz5V2DCtqCBPozRoaqZtwqnmk/oElEiBGHDSVNt1d8u6fbyorQrzkj5gWl0fhlpDfzu/Gm0dDkhj2vO8PP4OLKAlaf8bQ3rFsKvcsi1FiLZiRLLaUihPvXzDs5nxbBZWh/DHr0DGb3sMWvsdIXpkMajDNuZUIrIiTEQsmZTJK1du89VoX2Hin02MA1vSZBva3CCMePIBQVoO2XMyRrSJhmvB+lfxOqqNiLkjJCxaqTw/9AxQQykICDsFxASBHa6dBWaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g8fq96neXMvURA4lCahLSKmLh3+2zLw67Cg61ECTaK0=;
 b=5KXuyKMPj329tWYcr82AYjg9uT1CCL7yLVkMDC/mejLHUh5Tvw8nvVvKZ2uYegEog20jMOHRGXgLjXmk5SDr1ChF5QHUDK78+4x2AuAqW/OI6l0jNRgMAkqKX2qwl4wQwb15iRisGXqzbMIiiVU9REGsa9E2vL6FeplCnW94suw=
Received: from BL1P223CA0014.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::19)
 by PH0PR12MB8774.namprd12.prod.outlook.com (2603:10b6:510:28e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.23; Wed, 17 Sep
 2025 08:50:59 +0000
Received: from BN3PEPF0000B069.namprd21.prod.outlook.com
 (2603:10b6:208:2c4:cafe::88) by BL1P223CA0014.outlook.office365.com
 (2603:10b6:208:2c4::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.14 via Frontend Transport; Wed,
 17 Sep 2025 08:50:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN3PEPF0000B069.mail.protection.outlook.com (10.167.243.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.0 via Frontend Transport; Wed, 17 Sep 2025 08:50:59 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 17 Sep
 2025 01:50:59 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 17 Sep
 2025 03:50:57 -0500
Received: from localhost (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Wed, 17 Sep 2025 01:50:57 -0700
From: Michal Simek <michal.simek@amd.com>
To: <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
	<michal.simek@amd.com>, <git@amd.com>, <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH] arm64: defconfig: Enable missing AMD/Xilinx drivers
Date: Wed, 17 Sep 2025 10:50:52 +0200
Message-ID: <457c3a128e300241afd20da693d1d80a35d1ece6.1758099050.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6307; i=michal.simek@amd.com; h=from:subject:message-id; bh=XPml7sJx5PebgDKkCBg34VKl7fLzfJrIgieJmzwNzh4=; b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWScKstTi3BrWW63jGtK1t81eTYcfBMOTQqvq264HD5P3 jpy5sTojlIWBjEOBlkxRZbpTDoOa75dWyq2PDIfZg4rE8gQBi5OAZjI6WCGP5zyqXPnMS9q6a1M ujDL7Hy1n/XPq18b9lYo7tFvnHzIXI7hn7LbPa2/Cil7BGwZOcpecU84eSdc0Nt6X+Ga1cvEjS2 e8AAA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: michal.simek@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B069:EE_|PH0PR12MB8774:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c8249e8-9c6f-4abe-800a-08ddf5c752d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GL71EJqHbeUeE6Yl5cTK22/KbOJIG/RWqYei4jeho1ZJveXxJG0QsnGh31oU?=
 =?us-ascii?Q?UMZEUSZG1IsmHp2LDPeB5Ac//LI4bNNWPn1lH0Q8cD+97mUtUpJrwDfCGMkw?=
 =?us-ascii?Q?WRD0a6Jw8OdTz4UCI2FwBKubRQoMa7doi7ve/lATNF3yT6zbIxuOa1Juj3ZH?=
 =?us-ascii?Q?7ZeL9kwOymTxtDTSHiSuXhD8uPB4omgVJHnUDdQTf5BHZv7Oma2AHVSbKWVa?=
 =?us-ascii?Q?TQzI2NjR7ofYeNjrpEHKz2SLx408XLxTB8oUzc1Z1nhN4geQyzyDl/DfSqE8?=
 =?us-ascii?Q?JM9IT1wvl8YtfGIMkKoNYanEzcqSXDg2xZPZC7mIxXxz+0Dd22CwSRDlRDy8?=
 =?us-ascii?Q?CMl44avcDspR//qzW7ym/BTt01QHLPTGrwUjGv2dWlPsIAFD6IHWm+a7MF3o?=
 =?us-ascii?Q?/67gZL/HTL3CWVRNdYX0yEckxqaXqApurRxiZ1jhsK28CWvSfdHawVKrthzp?=
 =?us-ascii?Q?Mir77FvTMMyzK04GqU4+qp0CVOyta0XgKhRyD4IrH8jQNbK3zO19YPew+EXp?=
 =?us-ascii?Q?KeuTbXp3qwYuzb6Abg981qX8GMcTjAXveC3gCYdO4CW7qJWWDw3zyFw2dpTC?=
 =?us-ascii?Q?6gB4OAgdC1qdYPP1h0FJnbK8h/sYd+i2WTIxVKTWmqdPA3gLOHYcZVaRg/YD?=
 =?us-ascii?Q?pcKBI2t7ZX2Nm+rzgsKSRHc7UWEh4UGxBQbLc9PFGXQLBttR+p67M6QGYnqB?=
 =?us-ascii?Q?5PTTAkEq3sOJ62w1dPZxXRbv2GxpHF2xkpFSFMgDcZAf4SGgiIq1y3uCrkYB?=
 =?us-ascii?Q?El8TgAa7VoRu8CXHEPfeSIBJ3sDV4YM0OBaYvQuXpH1kkOtZJoCCeND3ZgUn?=
 =?us-ascii?Q?TnTkhaIAE0uJvXimYSNN0HGoJHLiex5FQ/udYY+8vVdl6ACryVdQAXmNeaJK?=
 =?us-ascii?Q?FuK1shwuR/CHDqLx6lwkFHCyKx9Y0tGQkU4BLD3JTQEDCWds3h/Cr7Xvs/bt?=
 =?us-ascii?Q?bREFrk2diz+lA20wNvf4csjh/G52RBkW5enuhukNLgvygNmUsnZi98VwP/L4?=
 =?us-ascii?Q?DycQ8GK2uYANBOsJNAfb7cNnHynnknVzHsLug9cBy/LSxaxoZMYCfX6vVsOf?=
 =?us-ascii?Q?Niq5yM5aeQHW/pKnzIvrLsV743DdwRW910fEht1JRkaVd7pnWyaX1i3s5Hh0?=
 =?us-ascii?Q?nbNGNH28KOYnznzYqP/rc9RzHHzz5PnVn2zcGS6rln91ENAPBIkzTiP28ruv?=
 =?us-ascii?Q?Q2EzcbFtV0394bFog8Xu5LtDMA/+m0OY5WR38CBp0VrefavZS9+H4ddHtRo+?=
 =?us-ascii?Q?hH1z3KpGKR2S7ucOqwXVDY3Xe/CA9HkzFH6vYyb3eTM7Y6LL0Scwywci4no/?=
 =?us-ascii?Q?b1pJDFNVmHzwYx0w/67c3gse1rsQ3Z7zE4hL8z7vdy9NAuo2awq2Hnpgs3E5?=
 =?us-ascii?Q?VZD2z3xcm2g8Zx1AoMwRD4a2zk8Ga6vvp1JKGRx/MWjUBcUkmMslIhbyM4oB?=
 =?us-ascii?Q?OzYZEQQi8/zYhULafJKhp7VPKj2DSMAvpWvYOLXlEkukmbcSXT+BPyC8qSSC?=
 =?us-ascii?Q?zMl59QghuO4ChgU=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 08:50:59.3150
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c8249e8-9c6f-4abe-800a-08ddf5c752d6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B069.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8774

Over years number of upstream drivers have grown for AMD/Xilinx SOCs
(ZynqMP, Versal, Versal NET) but they are not enabled by default in
defconfig that's why enable all drivers for these SOCs including USB5744
on board USB hub available on Kria ZynqMP based SOMs and Carrier Cards.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm64/configs/defconfig | 43 ++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index e3a2d37bd104..10b0c71a4e3e 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -232,6 +232,10 @@ CONFIG_PCIE_RCAR_HOST=y
 CONFIG_PCIE_RCAR_EP=y
 CONFIG_PCIE_ROCKCHIP_HOST=m
 CONFIG_PCI_XGENE=y
+CONFIG_PCIE_XILINX=y
+CONFIG_PCIE_XILINX_DMA_PL=y
+CONFIG_PCIE_XILINX_NWL=y
+CONFIG_PCIE_XILINX_CPM=y
 CONFIG_PCI_IMX6_HOST=y
 CONFIG_PCI_LAYERSCAPE=y
 CONFIG_PCI_HISI=y
@@ -271,6 +275,7 @@ CONFIG_QCOM_QSEECOM=y
 CONFIG_QCOM_QSEECOM_UEFISECAPP=y
 CONFIG_EXYNOS_ACPM_PROTOCOL=m
 CONFIG_TEGRA_BPMP=y
+CONFIG_ZYNQMP_FIRMWARE_DEBUG=y
 CONFIG_GNSS=m
 CONFIG_GNSS_MTK_SERIAL=m
 CONFIG_MTD=y
@@ -303,6 +308,7 @@ CONFIG_QCOM_COINCELL=m
 CONFIG_QCOM_FASTRPC=m
 CONFIG_SRAM=y
 CONFIG_PCI_ENDPOINT_TEST=m
+CONFIG_XILINX_SDFEC=m
 CONFIG_EEPROM_AT24=m
 CONFIG_EEPROM_AT25=m
 CONFIG_UACCE=m
@@ -390,6 +396,7 @@ CONFIG_DWMAC_MEDIATEK=m
 CONFIG_DWMAC_TEGRA=m
 CONFIG_TI_K3_AM65_CPSW_NUSS=y
 CONFIG_TI_ICSSG_PRUETH=m
+CONFIG_XILINX_AXI_EMAC=m
 CONFIG_QCOM_IPA=m
 CONFIG_MESON_GXL_PHY=m
 CONFIG_AQUANTIA_PHY=y
@@ -406,7 +413,9 @@ CONFIG_DP83867_PHY=y
 CONFIG_DP83869_PHY=m
 CONFIG_DP83TD510_PHY=y
 CONFIG_VITESSE_PHY=y
+CONFIG_XILINX_GMII2RGMII=m
 CONFIG_CAN_FLEXCAN=m
+CONFIG_CAN_XILINXCAN=m
 CONFIG_CAN_M_CAN=m
 CONFIG_CAN_M_CAN_PLATFORM=m
 CONFIG_CAN_RCAR=m
@@ -556,6 +565,7 @@ CONFIG_I2C_S3C2410=y
 CONFIG_I2C_SH_MOBILE=y
 CONFIG_I2C_TEGRA=y
 CONFIG_I2C_UNIPHIER_F=y
+CONFIG_I2C_XILINX=m
 CONFIG_I2C_RCAR=y
 CONFIG_I2C_CROS_EC_TUNNEL=y
 CONFIG_SPI=y
@@ -593,6 +603,8 @@ CONFIG_SPI_STM32_OSPI=m
 CONFIG_SPI_SUN6I=y
 CONFIG_SPI_TEGRA210_QUAD=m
 CONFIG_SPI_TEGRA114=m
+CONFIG_SPI_XILINX=m
+CONFIG_SPI_ZYNQMP_GQSPI=m
 CONFIG_SPI_SPIDEV=m
 CONFIG_SPMI=y
 CONFIG_SPMI_MTK_PMIF=m
@@ -683,6 +695,8 @@ CONFIG_GPIO_WCD934X=m
 CONFIG_GPIO_VF610=y
 CONFIG_GPIO_XGENE=y
 CONFIG_GPIO_XGENE_SB=y
+CONFIG_GPIO_XILINX=m
+CONFIG_GPIO_ZYNQ=m
 CONFIG_GPIO_MAX732X=y
 CONFIG_GPIO_PCA953X=y
 CONFIG_GPIO_PCA953X_IRQ=y
@@ -752,6 +766,8 @@ CONFIG_QCOM_LMH=m
 CONFIG_UNIPHIER_THERMAL=y
 CONFIG_KHADAS_MCU_FAN_THERMAL=m
 CONFIG_WATCHDOG=y
+CONFIG_XILINX_WATCHDOG=m
+CONFIG_XILINX_WINDOW_WATCHDOG=m
 CONFIG_SL28CPLD_WATCHDOG=m
 CONFIG_ARM_SP805_WATCHDOG=y
 CONFIG_ARM_SBSA_WATCHDOG=y
@@ -987,6 +1003,8 @@ CONFIG_DRM_LIMA=m
 CONFIG_DRM_PANFROST=m
 CONFIG_DRM_PANTHOR=m
 CONFIG_DRM_TIDSS=m
+CONFIG_DRM_ZYNQMP_DPSUB=m
+CONFIG_DRM_ZYNQMP_DPSUB_AUDIO=y
 CONFIG_DRM_POWERVR=m
 CONFIG_FB=y
 CONFIG_FB_EFI=y
@@ -1068,6 +1086,9 @@ CONFIG_SND_SOC_TEGRA210_MIXER=m
 CONFIG_SND_SOC_TEGRA_AUDIO_GRAPH_CARD=m
 CONFIG_SND_SOC_DAVINCI_MCASP=m
 CONFIG_SND_SOC_J721E_EVM=m
+CONFIG_SND_SOC_XILINX_I2S=m
+CONFIG_SND_SOC_XILINX_AUDIO_FORMATTER=m
+CONFIG_SND_SOC_XILINX_SPDIF=m
 CONFIG_SND_SOC_AK4613=m
 CONFIG_SND_SOC_AK4619=m
 CONFIG_SND_SOC_DA7213=m
@@ -1151,6 +1172,7 @@ CONFIG_USB_SERIAL_OPTION=m
 CONFIG_USB_QCOM_EUD=m
 CONFIG_USB_HSIC_USB3503=y
 CONFIG_USB_ONBOARD_DEV=m
+CONFIG_USB_ONBOARD_DEV_USB5744=y
 CONFIG_NOP_USB_XCEIV=y
 CONFIG_USB_MXS_PHY=m
 CONFIG_USB_GADGET=y
@@ -1248,6 +1270,8 @@ CONFIG_LEDS_TRIGGER_PANIC=y
 CONFIG_EDAC=y
 CONFIG_EDAC_GHES=y
 CONFIG_EDAC_LAYERSCAPE=m
+CONFIG_EDAC_ZYNQMP=m
+CONFIG_EDAC_VERSAL=m
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_DS1307=m
 CONFIG_RTC_DRV_HYM8563=m
@@ -1268,6 +1292,7 @@ CONFIG_RTC_DRV_DS3232=y
 CONFIG_RTC_DRV_PCF2127=m
 CONFIG_RTC_DRV_DA9063=m
 CONFIG_RTC_DRV_EFI=y
+CONFIG_RTC_DRV_ZYNQMP=m
 CONFIG_RTC_DRV_CROS_EC=y
 CONFIG_RTC_DRV_FSL_FTM_ALARM=m
 CONFIG_RTC_DRV_S3C=y
@@ -1296,6 +1321,9 @@ CONFIG_PL330_DMA=y
 CONFIG_TEGRA186_GPC_DMA=y
 CONFIG_TEGRA20_APB_DMA=y
 CONFIG_TEGRA210_ADMA=m
+CONFIG_XILINX_DMA=m
+CONFIG_XILINX_ZYNQMP_DMA=m
+CONFIG_XILINX_ZYNQMP_DPDMA=m
 CONFIG_MTK_UART_APDMA=m
 CONFIG_QCOM_BAM_DMA=y
 CONFIG_QCOM_GPI_DMA=m
@@ -1459,6 +1487,8 @@ CONFIG_SM_VIDEOCC_8450=m
 CONFIG_CLK_RCAR_USB2_CLOCK_SEL=y
 CONFIG_CLK_RENESAS_VBATTB=m
 CONFIG_CLK_SOPHGO_CV1800=y
+CONFIG_XILINX_VCU=m
+CONFIG_COMMON_CLK_XLNX_CLKWZRD=m
 CONFIG_HWSPINLOCK=y
 CONFIG_HWSPINLOCK_OMAP=m
 CONFIG_HWSPINLOCK_QCOM=y
@@ -1570,6 +1600,8 @@ CONFIG_RZG2L_ADC=m
 CONFIG_SOPHGO_CV1800B_ADC=m
 CONFIG_TI_ADS1015=m
 CONFIG_TI_AM335X_ADC=m
+CONFIG_XILINX_XADC=m
+CONFIG_XILINX_AMS=m
 CONFIG_IIO_CROS_EC_SENSORS_CORE=m
 CONFIG_IIO_CROS_EC_SENSORS=m
 CONFIG_IIO_ST_LSM6DSX=m
@@ -1602,7 +1634,9 @@ CONFIG_PWM_TEGRA=m
 CONFIG_PWM_TIECAP=m
 CONFIG_PWM_TIEHRPWM=m
 CONFIG_PWM_VISCONTI=m
+CONFIG_PWM_XILINX=m
 CONFIG_SL28CPLD_INTC=y
+CONFIG_XILINX_INTC=y
 CONFIG_QCOM_PDC=y
 CONFIG_QCOM_MPM=y
 CONFIG_TI_SCI_INTR_IRQCHIP=y
@@ -1666,6 +1700,8 @@ CONFIG_PHY_UNIPHIER_USB3=y
 CONFIG_PHY_TEGRA_XUSB=y
 CONFIG_PHY_AM654_SERDES=m
 CONFIG_PHY_J721E_WIZ=m
+CONFIG_OMAP_USB2=m
+CONFIG_PHY_XILINX_ZYNQMP=m
 CONFIG_ARM_CCI_PMU=m
 CONFIG_ARM_CCN=m
 CONFIG_ARM_CMN=m
@@ -1696,14 +1732,18 @@ CONFIG_NVMEM_SNVS_LPGPR=y
 CONFIG_NVMEM_SPMI_SDAM=m
 CONFIG_NVMEM_SUNXI_SID=y
 CONFIG_NVMEM_UNIPHIER_EFUSE=y
+CONFIG_NVMEM_ZYNQMP=m
 CONFIG_FPGA=y
 CONFIG_FPGA_MGR_ALTERA_CVP=m
 CONFIG_FPGA_MGR_STRATIX10_SOC=m
 CONFIG_FPGA_BRIDGE=m
 CONFIG_ALTERA_FREEZE_BRIDGE=m
+CONFIG_XILINX_PR_DECOUPLER=m
 CONFIG_FPGA_REGION=m
 CONFIG_OF_FPGA_REGION=m
 CONFIG_OF_OVERLAY=y
+CONFIG_FPGA_MGR_ZYNQMP_FPGA=m
+CONFIG_FPGA_MGR_VERSAL_FPGA=m
 CONFIG_TEE=y
 CONFIG_OPTEE=y
 CONFIG_MUX_GPIO=m
@@ -1797,6 +1837,9 @@ CONFIG_CRYPTO_DEV_FSL_DPAA2_CAAM=m
 CONFIG_CRYPTO_DEV_QCE=m
 CONFIG_CRYPTO_DEV_QCOM_RNG=m
 CONFIG_CRYPTO_DEV_TEGRA=m
+CONFIG_CRYPTO_DEV_XILINX_TRNG=m
+CONFIG_CRYPTO_DEV_ZYNQMP_AES=m
+CONFIG_CRYPTO_DEV_ZYNQMP_SHA3=m
 CONFIG_CRYPTO_DEV_CCREE=m
 CONFIG_CRYPTO_DEV_HISI_SEC2=m
 CONFIG_CRYPTO_DEV_HISI_ZIP=m
-- 
2.43.0

base-commit: 05af764719214d6568adb55c8749dec295228da8
branch: xnext/usbhub-defconfig

