Return-Path: <linux-kernel+bounces-772953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42FCDB299BF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 08:33:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CA621697BB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 06:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4B4B275B02;
	Mon, 18 Aug 2025 06:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Vq5QSNvz"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2075.outbound.protection.outlook.com [40.107.92.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89207275863
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 06:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755498787; cv=fail; b=J1wXXU93jv4V+LfrW3c0dtUPoRK/c/ZW5v9rS94+cB+YFv/OE6+OyqCqsMqIqVlMXJkD7eEuWN6Z7CJDZCzwCPIGNnvJYgf7nqbKZrS2iP2UawPPNkhfmik1A/23JhXovEidFogiT5s9T6EdRcqLxvmV3DDZmR0DuQ+dOTfxxHM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755498787; c=relaxed/simple;
	bh=abzz5QkIh4y4Hpcw5T4ZZ/fNEWf9JTmxKtMJTZ9WG38=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JEUNMk4rgXwnqkzJe6mG1KT5QKp5mceFFylnidEdDtAf0OlIrUh9bL/unfAn4Xo+ARiyUycfKPHXpb53iC2YzMYTvMBjvzjXvZC74S6j3v6TKBrxGHOfNRKu3m4pFpG9E6E8hT2E1BpnBazV1ZYktsteKzUEvv8sacDohtHADCE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Vq5QSNvz; arc=fail smtp.client-ip=40.107.92.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k++d5CYXdVUfsPyO/PvG/FltupNnQJx/ST0qlI31L5EDaj4Vh0uTNpKH7Wq8ag1pu5MwFm2QSD3Seh9cjWhSVvbVqRMHIVJbFlxohI3borTv/1kzXogg0hZw9PmBw3ldncjz4SuqlXQtvDBljJM/t7BwM94AWyppMgYD3gm/7r0U/B+7rVKEk1ueN7Ju+etsVfUcwDz5c5catYqqjKAIX19/0Qumr0eF1h0m+ITXrKGY+i5Hjew0zPRTBnsd7jjeKV+/dquCAp+p/i3vihkrvQHuGBbX3Ccs50jw2PjDFLHJ7nSEVCetyLdOOvU7ihL2zBnEdFpi2LgkMqPrkdRXDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wkDC8Pv/N9cDgskO+l69+BmtHD9FumEhT6izsqYkSDI=;
 b=Kh0/Octe9ziIsKvC9Rae/rOTQe5uP/HEcfyW1ZaaxrEANclhkKq71la2Xi447ay2TtV01Yhud+XfkiQ7a0K9/TPYaIyxFrqpqQVK5jJePG1dyTmcuKWCyhdWxApWtnV8QVDjJHM+g0Fw95C3fLt6QolVjFrVV0a4I53ggM7kyTHqYjz3CsHUwccijA24cIcHsYQbC3nqSEZj9aZ00Wn8y9JGOc7bOldvttacFeg5/sCPXQfehD1eOWzVPT8lXT6gwiugPWGMWJlGnpLoiZKYKfM/L9lQBmNNC9lUXDLzLwCQeQ/sqYirQDs18QgEVmG/B3SG++vJv//7p4z68U3Z0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=arndb.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wkDC8Pv/N9cDgskO+l69+BmtHD9FumEhT6izsqYkSDI=;
 b=Vq5QSNvzWKro5eZxJSBPhL08Sa/dWLqoHHd7Nf3R1q+c/RXmY0HAHw5/hAK3DTubJFJeNTax4e9iihZOn+8KgNi4ccE/fna39ZWS3gl3NU6P92/7M/JjmdkzCM3RUSo6iiYhQziYRk+ZKZQwMt0/g5q5oGy67QtWKS4kLMzqLwA=
Received: from SA1PR02CA0024.namprd02.prod.outlook.com (2603:10b6:806:2cf::24)
 by PH7PR12MB6834.namprd12.prod.outlook.com (2603:10b6:510:1b4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Mon, 18 Aug
 2025 06:33:00 +0000
Received: from SN1PEPF0002636A.namprd02.prod.outlook.com
 (2603:10b6:806:2cf:cafe::ae) by SA1PR02CA0024.outlook.office365.com
 (2603:10b6:806:2cf::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.20 via Frontend Transport; Mon,
 18 Aug 2025 06:33:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF0002636A.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Mon, 18 Aug 2025 06:33:00 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 18 Aug
 2025 01:32:59 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 18 Aug
 2025 01:32:59 -0500
Received: from xhdnipung41x.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 18 Aug 2025 01:32:55 -0500
From: Nipun Gupta <nipun.gupta@amd.com>
To: <arnd@arndb.de>, <gregkh@linuxfoundation.org>, <nikhil.agarwal@amd.com>
CC: <linux-kernel@vger.kernel.org>, <llvm@lists.linux.dev>,
	<oe-kbuild-all@lists.linux.dev>, <robin.murphy@arm.com>, <krzk@kernel.org>,
	<tglx@linutronix.de>, <maz@kernel.org>, <linux@weissschuh.net>,
	<chenqiuji666@gmail.com>, <peterz@infradead.org>, <robh@kernel.org>,
	<abhijit.gangurde@amd.com>, <nathan@kernel.org>, Arnd Bergmann
	<arnd@kernel.org>
Subject: [PATCH RESEND 1/2] cdx: don't select CONFIG_GENERIC_MSI_IRQ
Date: Mon, 18 Aug 2025 12:02:43 +0530
Message-ID: <20250818063244.1242634-1-nipun.gupta@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: nipun.gupta@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636A:EE_|PH7PR12MB6834:EE_
X-MS-Office365-Filtering-Correlation-Id: 55006abd-c390-4eb0-bd16-08ddde2113b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013|7416014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?agIAl1gC259fRBEaO8U1W9XJ/VtwxpFn/uSqyJgldMVvCBocCCvLpKUbpNRl?=
 =?us-ascii?Q?nUWmp/crNQqp2JFdIWAgbKwODTT4hDCHqOGaxNuEBC/CRC5/cbdkwA3dJsw4?=
 =?us-ascii?Q?BKjVEj6O1ANjXZ6xSB43TPV8p1Ct/3Y7GhhfDIAng8/C12Tf0il66hqDaYt4?=
 =?us-ascii?Q?4XILpe5hJeeen+K/cmVg6cyzqlAPJKEnAJnEJpHo9dmiyI9VroVEL5J2/qCY?=
 =?us-ascii?Q?Ok1TWOFXcoJDmXq63HAS7n/RIpw4wE70Y+xLnY6amZAzI7Gza0JPrj4ioNWM?=
 =?us-ascii?Q?9gBaOuCdnmCT0Gbsk7kiHAB3DxujRADdT57yR3WQUeC+ffVfc9pzs/xPJYWF?=
 =?us-ascii?Q?LisVqoeoAAhjnNGP83L3WMVn+6axcjndqL0LMkn958INFhWk44vwdYCmAATw?=
 =?us-ascii?Q?PuQJoMpb7/jDaQ9bLJS68LcL9LLzOp1WL2bOtkvjNG9xE5hD+4jczyQ4To+B?=
 =?us-ascii?Q?uOR/iyEkm19RQ+7Gnh9LUBTUhCbRjzW3jE03TOCW/nYsya43Mg1xPMNoMlER?=
 =?us-ascii?Q?lta9354aoX6oY946QqWkEfX0RkFTukVIpDXGzZ84ZnlFtCYJvDA2Qj1xw9Lq?=
 =?us-ascii?Q?SrgoPJwHziPlDGLR4jyZyvX2GrzOespIHSXnSWCE4dqpnrr0elp9lyDU6Mu0?=
 =?us-ascii?Q?K71youbtGGAdCGySJzMgo6841OLMJlAonVEVOciWNNVcing3OFgeEokLif0m?=
 =?us-ascii?Q?rSonC1T/zEL+fwDYEbav8OitS6iLwpqYgk5SzBQ4T4JbDbXVI88r6iytXZKO?=
 =?us-ascii?Q?VuXZTiFFSL7tcsfQiFyFBC5Smj7ZVSwANwyF0yixhwjWTWPptNFwtMDMYwXL?=
 =?us-ascii?Q?Y/3vZm7M2MWa8lc6nojpFZvGvjCs2KvLKBB/BVa+pqo0FzcT0XfFbHisgQrW?=
 =?us-ascii?Q?2HkLrN2Xctr2By/mpl1XgpZGgd2zvEMAScCnctrpP9EibC0VofZaD71NHz+X?=
 =?us-ascii?Q?DUBUXXSrKoyrozaKzjNiiCM1RmL/bhOtp/mQMgq/kcwilYJBvN93xx0RHyfr?=
 =?us-ascii?Q?hKmVfCgN38NlL1W9KIDy/JHtxJfvWLFv+96FUciGh+bp+9GBFFjLRXd+VPHt?=
 =?us-ascii?Q?M5Vo96fTxj+IEsKJvG2ANp1tE52dAjMvT99YxNAiGSyFncf5DZOH6FLg/gHw?=
 =?us-ascii?Q?k6o42/Frnh2pVtQvOonAJj1OeLGiFeYltU6NHSVGVtU9BitVbBk+toZPP32p?=
 =?us-ascii?Q?yR99Za4jtrLu95JhNMWAAxml9EEqzGtlOKJpxBq3HTFD55SRhP+sUrJKuoH3?=
 =?us-ascii?Q?9ezvu8ruzc9Ctdos/UWs7PWFloA1kPGXJUGBSrJAZmH+GWfPufrLd4TBobuM?=
 =?us-ascii?Q?xLou7CJrbErXAeABbb/hs0SA59Aim3kYAYcpKUJj19klPn9IQj2IJ+jDVefB?=
 =?us-ascii?Q?XuKwqyneyFvFSh4Xny3XKIRC41CMHI3rjG9lQavQ2h/sQC0+MePPzbeSQCHy?=
 =?us-ascii?Q?8ajif/3J5Bvdb/DGMi7y7A9r8EwmshUxC/6STi3SkEG5rsUptiPzNKspnDX5?=
 =?us-ascii?Q?n+m1KDOwfADH+KNeu9FM2hIfpEEMtjFBHjWrl6BsIN2KwAmZakvyMT/eyw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013)(7416014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 06:33:00.1778
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55006abd-c390-4eb0-bd16-08ddde2113b6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6834

From: Arnd Bergmann <arnd@kernel.org>

x86 does not use CONFIG_GENERIC_MSI_IRQ, and trying to enable it anyway
results in a build failure:

In file included from include/linux/ssb/ssb.h:10,
                 from drivers/ssb/pcihost_wrapper.c:18:
include/linux/gpio/driver.h:41:33: error: field 'msiinfo' has incomplete type
   41 |         msi_alloc_info_t        msiinfo;
      |                                 ^~~~~~~
In file included from include/linux/kvm_host.h:19,
                 from arch/x86/events/intel/core.c:17:
include/linux/msi.h:528:33: error: field 'alloc_info' has incomplete type
  528 |         msi_alloc_info_t        alloc_info;

Change the driver to actually build without this symbol and remove the
incorrect 'select' statements.

Fixes: e8b18c11731d ("cdx: Fix missing GENERIC_MSI_IRQ on compile test")
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Arnd Bergmann <arnd@kernel.org>
---

This change is resent from:
https://lore.kernel.org/all/20250805161059.4006484-1-arnd@kernel.org/

VFIO CDX needed similar compilation changes as reported by Kernel bot at:
https://lore.kernel.org/all/202508070308.opy5dIFX-lkp@intel.com/
Patch 2/2 adds changes in VFIO CDX driver.

 drivers/cdx/Kconfig                     | 1 -
 drivers/cdx/cdx.c                       | 2 +-
 drivers/cdx/controller/Kconfig          | 1 -
 drivers/cdx/controller/cdx_controller.c | 3 ++-
 4 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/cdx/Kconfig b/drivers/cdx/Kconfig
index 3af41f51cf38..1f1e360507d7 100644
--- a/drivers/cdx/Kconfig
+++ b/drivers/cdx/Kconfig
@@ -8,7 +8,6 @@
 config CDX_BUS
 	bool "CDX Bus driver"
 	depends on OF && ARM64 || COMPILE_TEST
-	select GENERIC_MSI_IRQ
 	help
 	  Driver to enable Composable DMA Transfer(CDX) Bus. CDX bus
 	  exposes Fabric devices which uses composable DMA IP to the
diff --git a/drivers/cdx/cdx.c b/drivers/cdx/cdx.c
index 092306ca2541..1a5c95ba09ba 100644
--- a/drivers/cdx/cdx.c
+++ b/drivers/cdx/cdx.c
@@ -310,7 +310,7 @@ static int cdx_probe(struct device *dev)
 	 * Setup MSI device data so that generic MSI alloc/free can
 	 * be used by the device driver.
 	 */
-	if (cdx->msi_domain) {
+	if (IS_ENABLED(CONFIG_GENERIC_MSI_IRQ) && cdx->msi_domain) {
 		error = msi_setup_device_data(&cdx_dev->dev);
 		if (error)
 			return error;
diff --git a/drivers/cdx/controller/Kconfig b/drivers/cdx/controller/Kconfig
index 0641a4c21e66..a480b62cbd1f 100644
--- a/drivers/cdx/controller/Kconfig
+++ b/drivers/cdx/controller/Kconfig
@@ -10,7 +10,6 @@ if CDX_BUS
 config CDX_CONTROLLER
 	tristate "CDX bus controller"
 	depends on HAS_DMA
-	select GENERIC_MSI_IRQ
 	select REMOTEPROC
 	select RPMSG
 	help
diff --git a/drivers/cdx/controller/cdx_controller.c b/drivers/cdx/controller/cdx_controller.c
index fca83141e3e6..5e3fd89b6b56 100644
--- a/drivers/cdx/controller/cdx_controller.c
+++ b/drivers/cdx/controller/cdx_controller.c
@@ -193,7 +193,8 @@ static int xlnx_cdx_probe(struct platform_device *pdev)
 	cdx->ops = &cdx_ops;
 
 	/* Create MSI domain */
-	cdx->msi_domain = cdx_msi_domain_init(&pdev->dev);
+	if (IS_ENABLED(CONFIG_GENERIC_MSI_IRQ))
+		cdx->msi_domain = cdx_msi_domain_init(&pdev->dev);
 	if (!cdx->msi_domain) {
 		ret = dev_err_probe(&pdev->dev, -ENODEV, "cdx_msi_domain_init() failed");
 		goto cdx_msi_fail;
-- 
2.34.1


