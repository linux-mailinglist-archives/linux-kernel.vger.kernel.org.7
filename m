Return-Path: <linux-kernel+bounces-779106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53588B2EF28
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 09:13:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EEE5D7B0293
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 07:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B960E2820B2;
	Thu, 21 Aug 2025 07:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xelBFV62"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2049.outbound.protection.outlook.com [40.107.243.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4682027C17F
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 07:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755760405; cv=fail; b=sdBNhiDZ23i/mHfKIN2rP21anEwPIFDHhjQZCAQd+KBc22j5W+FwR9usA2rBi3JQ2i3iTK8Rt8XnOFQFUczCnvfyj2qp1uH57hhVvWDbE56DhZ9RRP0vK0HPN+9m8uJJzXQR1zg6GJPzDHYzfBsStC4E5/P/8WqEFfwBR9CWoq4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755760405; c=relaxed/simple;
	bh=PAO4AxspZ1bMc/gqN/VUryhuhWP0g1UMnSYWxPWkV1g=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YYlPubx5t+rlIee8P0EryhhYeXlFpK8RU3w+VeUDRByg6E09fxXcUx07EcXbgs9PYAlqttOgRlUfS/IazQTyLoV2ml0+zFaefOlRnIBbCO3aU2gm+qFTt8pRJfBeVy3cB1YBjgkksR5TAssZtCQ9Y+4adHixMDD1HTri/4V5qgY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xelBFV62; arc=fail smtp.client-ip=40.107.243.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ehDtgpfUFGEFQq2WWtPcsvzdacD+TI4/S1zMB8xuymBcLH9u+NDFN5OlcUY4tx28MPYtp2vAeH9IjV+8MvvlsXR895x0j0JNvS8fyoiEnM0V9lrVMQKHFnEwCyzCOqsfQ5ue+HruMQdZ0106EFFmDspwtYu9bhNuk5HMgyD5LkRVf+w0hg3kHjMwtebZ3nzNQOUjgGWtnjLnTLk2qjkWo3blENMBiyTQJ4rB2yYcREReVoGKexptS1EoasUD+AEkOHP2f2RO3nt8uQN3NVAq5BkhiXCZkCfW8y1dDHm7iGpZCBrx8urESIILz9A80xKbQCK/M+vjd3nW06pfjpFgMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q+ReWXz4AOR5NBW05Dl4zFJz7bpm+7af6bMofYaInHM=;
 b=Yx37G+B4k5Zms34x/U5ed+a8d8PKNkG9cttfVYmh7X3PZo+itKvI4Ob/kKzNZXlZPh4R+ufVVmkm/nvoYh2AT39WcSeIklFfJ/0hFlxNAHceaQOMpHpMZrTHiijpCo8cPnSSFzdtNxrGZd463sBehAtcUNplr20u2BaiW2yXiV3D8utRBa3ZYnHoSqfphHcRfT8fQhlVBqV1Ra5Av9jYiDgaGbMeVI1C/f48AT3aBodkTvcSzSRCqXxOPX2sVsyxJYBsewt8NTaEAcOtvhZ32XOK+jR/wFqd6zisy/F2u2gR9yZeWI0VWUUxv3NHpnP6EgRIthVemOioPe0r9qko4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=arndb.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q+ReWXz4AOR5NBW05Dl4zFJz7bpm+7af6bMofYaInHM=;
 b=xelBFV62sZm+rofMyKFAz1xeBLVJcDuavhH1fv/eYI8fEumXDwjAMyLymMyfz85lF35OYL/xY6W+cVxGPjJ5HoBUS7BEHjobtW4afDbGUf9Q7bPy4ooYEEZzYxgLWBVX8zcfTMWdfNAhgNzjt11LsvmnB8MBCi/1Z9E8eaOSnUw=
Received: from BL6PEPF00016410.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1004:0:17) by PH0PR12MB8099.namprd12.prod.outlook.com
 (2603:10b6:510:29d::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.25; Thu, 21 Aug
 2025 07:13:18 +0000
Received: from BN2PEPF00004FBE.namprd04.prod.outlook.com
 (2a01:111:f403:c803::7) by BL6PEPF00016410.outlook.office365.com
 (2603:1036:903:4::a) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.15 via Frontend Transport; Thu,
 21 Aug 2025 07:13:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF00004FBE.mail.protection.outlook.com (10.167.243.184) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Thu, 21 Aug 2025 07:13:18 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 21 Aug
 2025 02:13:17 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 21 Aug
 2025 02:13:16 -0500
Received: from xhdnipung41x.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 21 Aug 2025 02:13:12 -0500
From: Nipun Gupta <nipun.gupta@amd.com>
To: <arnd@arndb.de>, <gregkh@linuxfoundation.org>, <nikhil.agarwal@amd.com>
CC: <linux-kernel@vger.kernel.org>, <llvm@lists.linux.dev>,
	<oe-kbuild-all@lists.linux.dev>, <robin.murphy@arm.com>, <krzk@kernel.org>,
	<tglx@linutronix.de>, <maz@kernel.org>, <linux@weissschuh.net>,
	<chenqiuji666@gmail.com>, <peterz@infradead.org>, <robh@kernel.org>,
	<abhijit.gangurde@amd.com>, <nathan@kernel.org>, <nipun.gupta@amd.com>, "Arnd
 Bergmann" <arnd@kernel.org>
Subject: [PATCH v2 1/2] cdx: don't select CONFIG_GENERIC_MSI_IRQ
Date: Thu, 21 Aug 2025 12:43:07 +0530
Message-ID: <20250821071308.1572106-1-nipun.gupta@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBE:EE_|PH0PR12MB8099:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ead3589-fa62-4393-402e-08dde0823413
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ATzkNq5Xfe+Ec161+WYvEa7MVLoy54RWoPQs9DZTR97AszVAnEtMKmVSojJi?=
 =?us-ascii?Q?4xdJv8p58WAaq7MCo+6YzodgZdhyst7ngKjnHPhBDI8sVxaIWQLmRf+hEodf?=
 =?us-ascii?Q?IoZua9CPW/2Db8FV5Sbc2aFXk47zD/vKLxPgkNpXisvMqn62suDYshdWTwJw?=
 =?us-ascii?Q?DuKqsjSWv9+8003ILjx1x6IUsMwj6/je33N5rODH2ezcGateB4nCXEmM4yD0?=
 =?us-ascii?Q?7lxWIxRRPHd4TXXyPJkxBatH9nzYNRprQuMdrMHK7SOY/YBlUNYJRjEWXAzF?=
 =?us-ascii?Q?jp8C97M9IQJJAT6GquuBuUObTDi5dBiSGbp8oY6703iSg00Zgm13l5pa5SPf?=
 =?us-ascii?Q?eb3poIiEc/DeZfukLlJC+rSdJ6vWYD7Nn+MB9ffOhZ0G0H2uddpEZx8STGON?=
 =?us-ascii?Q?5pInemYuaq5p56h/XpMIxazM/t6zIUiRrb67xvpozT7Zvwn5k7rRrgBueTmw?=
 =?us-ascii?Q?VJF73MqZj88kk88pY+5ty422qEKywsLGivnW0SRm+mTLwB6EbZL/9/zkUGAn?=
 =?us-ascii?Q?XCooJNyYS9NO35mNfvKcWZVoD0Gtc5bN0Ezw9e9wQiViVAhBQ4QKEqZ3im+G?=
 =?us-ascii?Q?XsRAdCJkcbgF+prfRm9yPO4HdFu6tTYp/f8Ak+CBEqDOU93esdnZP/R7eJC8?=
 =?us-ascii?Q?4pfguaf+1UkXy6z9fMzQuHlqXHOQ8RjLlmTLg/7p84cVYdaZmJlUBYSCKpom?=
 =?us-ascii?Q?fUCfMi8Q0zIo4n7kA6KTM0LwYQYC3hfxr17FUagIkDSfh1XRZdk3b7OJbS6M?=
 =?us-ascii?Q?mJnMtUU7lB0GdcH2BRV8LBNBn69t05MU7bu8TgrlHtF+vDCJJ4aYgomUZLLj?=
 =?us-ascii?Q?JM0i+PUQEsCJ5L6jBZUEbsoN5DiU2qpO9Rmf6vkfl+aSElYXcokVyKABLJo/?=
 =?us-ascii?Q?jiLAOIUCOJ7XC3EojYMQvHNv39D+1bcP6spFEnZCzS3XYIl/SRYhFqxumQ6P?=
 =?us-ascii?Q?93ELPrNsaVbJUvEeSA1rA1ehc99wsQz8Cjzk4SwPFTBdTFq5KtR3WKS+zxhc?=
 =?us-ascii?Q?Y8WTOfVpWALRdIoj+cgiJ1c6mNnZdbPIjz30KWpvbwzlv1qQTLsN7dB18Unw?=
 =?us-ascii?Q?4hgfCwabaej+oSYMU7NukEVjq7umZFy2I1XVHiJd4jHpDKemoiSapJ9Gph8F?=
 =?us-ascii?Q?4vNOnlZe0EcoOYHlGFo6/IXI3UYqkQtPeySCw6a4YyYFdWm/lYeBTppruSQS?=
 =?us-ascii?Q?cKQULaGcEOL4NoONixXORtYK4hzGmx+xQ45jJWa30IKZKE8N5t1h5WlHERYJ?=
 =?us-ascii?Q?Mhgtavi7PGlFvRq7lpEqFsp+dPvMWhlNbMoZJWF9b57j5rxwR0DrZHhTEWs8?=
 =?us-ascii?Q?LWKnx/MmWdqIVfDUvuY70+sXbNtRr00s9hbh4KEAojCam7n8sX7XdlFnno6/?=
 =?us-ascii?Q?JtOIApA9TqJW+lH9/cOzYl6xb162KqJy1+vLr5LxrHjADhlJBJQrFjQxn4Il?=
 =?us-ascii?Q?LMaudK6+Y044rgFoxT+WuXpL8OGwWkkG2hAmQUAAKsutA1tuKqN4dwlPjFSO?=
 =?us-ascii?Q?R99CU/eFOrSVe3tpSJ37ydQH0f9PwdQhmbY9?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 07:13:18.0095
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ead3589-fa62-4393-402e-08dde0823413
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8099

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
Reviewed-by: Nikhil Agarwal <nikhil.agarwal@amd.com>
Signed-off-by: Arnd Bergmann <arnd@kernel.org>
---

No change in this patch from v1 -> v2 (change is in patch 2/2)

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


