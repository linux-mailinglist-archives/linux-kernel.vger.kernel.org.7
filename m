Return-Path: <linux-kernel+bounces-756712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E011B1B813
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 18:11:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7E9D7A3EA7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 16:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E3CC1C8603;
	Tue,  5 Aug 2025 16:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lg5tS4PY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E552B291C2F
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 16:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754410265; cv=none; b=F7h09wKGyTZnBrVPq2sULuYCx3BkkCs60WzbqUakPkNN6Yu3CAF6Sljl6aHp9ia5RyChJ3IRDWJyCZoC1wQ6N1EfcpirrrPSONEsZnObkbRLy72BU9+isC9HwpfC3PwZMeKO4CZoQn2AvAsK4BG9XfS+uPUA7b8JhsA1b+vJH3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754410265; c=relaxed/simple;
	bh=Oq/nomMnGxM/InKJjU0e56+gpupy+bRKevwpyqg/5fQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dE9pZ755gn38cVhnRmHBRZS/Zn3S8MuDT6QfYz6URSbfuWX6656umP/tHfOEZFKm75QN4ESID8VLe355FEFoVNyBiblJ1bNHfLgYzriABq64K6Xi4JLHoEhd81OrdJOUHO5gJCXTIsAYJ5/FHtTIXXYCnRaunPJ2dw2Bk88H8hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lg5tS4PY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABB1CC4CEF0;
	Tue,  5 Aug 2025 16:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754410264;
	bh=Oq/nomMnGxM/InKJjU0e56+gpupy+bRKevwpyqg/5fQ=;
	h=From:To:Cc:Subject:Date:From;
	b=Lg5tS4PYBdkjeapV7oRjEKmKGpI0a3JrE3yEV+vP5CbHUf+cC6trsUYbyvAP0R78f
	 L2VyYJHXr+5Sumy5mJ7EE3EON2Fx1zPvCniHn2TxEP0yGSIjryOrDVZfqykM8CrQZn
	 nwNtNegBBO/nTBLcz+BjODhYVGYQ0f18tstXKqpPBioOIWSa5mzn5FanCtxdK6OIgH
	 QCAAbek7Ll5HICZqQKUIp1JyAuSW79c9hfDNqBUy9sjEPx0pF7QprkLByC/rLDbTDr
	 3miaQ2I63HXyhg97rmAJheAM76wbuygZCVXgaAB6IXmjBpWqVEYtXeZgfB9kd3NE3b
	 rcwAkjE+6Ko3g==
From: Arnd Bergmann <arnd@kernel.org>
To: Nipun Gupta <nipun.gupta@amd.com>,
	Nikhil Agarwal <nikhil.agarwal@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Marc Zyngier <maz@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuu?= <linux@weissschuh.net>,
	Qiu-ji Chen <chenqiuji666@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	"Rob Herring (Arm)" <robh@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Abhijit Gangurde <abhijit.gangurde@amd.com>,
	Nathan Chancellor <nathan@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] cdx: don't select CONFIG_GENERIC_MSI_IRQ
Date: Tue,  5 Aug 2025 18:10:48 +0200
Message-Id: <20250805161059.4006484-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

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

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
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
2.39.5


