Return-Path: <linux-kernel+bounces-804569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AABAB479E8
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 10:58:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE4C2189DBF3
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 08:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9CD021FF36;
	Sun,  7 Sep 2025 08:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="dCZ7fWQ0"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6F521FF2E
	for <linux-kernel@vger.kernel.org>; Sun,  7 Sep 2025 08:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757235502; cv=none; b=SnAKa55uMWEUsFZWl/MX+6hgWc7ahENw+VEmWIg1PQsnKD8zc8Su6oeN5gzAQmiDfTqk+Epmxv4H4QgexpKJf7Ppka3RaV83U6Uu+08mo64+Dbjl6KfDZZBBVN9oSw/Z1C5VWUMXZKhX6I4pDmDvAFO1BmEoG+Nr8Nkx2CdkAps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757235502; c=relaxed/simple;
	bh=08ikVC4OF4cu4rGxnCVX1VpjNruDz7uCvJo3Qv3TBEI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aCNfvj4ZqOnYlyrpqHetg1mwQJ214baCD5O5oZNYHdu5srHsBYLbVFnqndL5BUaERZlSK2/lw3wV7e1CkfOo6S1eWYSM6ySu6QjESBJANssqEualhKY8EKn5RIxhg2+hcqTVE3OwHfcA5HD97IpsyZM2h7V2WknSUMkJEPrtQc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=dCZ7fWQ0; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from mail.ideasonboard.com (unknown [IPv6:2401:4900:1c67:84a2:d86d:fcf7:24b4:e467])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 98E24156F;
	Sun,  7 Sep 2025 10:57:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1757235426;
	bh=08ikVC4OF4cu4rGxnCVX1VpjNruDz7uCvJo3Qv3TBEI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=dCZ7fWQ0YI1g/72P6teWFqTTlwfOkDy4dtC7dbU1CQ9ElI83tKVWLAwY0+MtPOZhk
	 +ZO79TGowZVkC8tdrWNnGgP2idQkL1YKo9KdBwcT9RODHUObCimaQhP5GNI0qTIvNc
	 npu8v7VmJyjnyqW2ClLN3Wu584hCPX24qyiOFMOI=
From: Jai Luthra <jai.luthra@ideasonboard.com>
Date: Sun, 07 Sep 2025 14:26:23 +0530
Subject: [PATCH v2 3/5] platform/broadcom: Destage VCHIQ interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250907-vchiq-destage-v2-3-6884505dca78@ideasonboard.com>
References: <20250907-vchiq-destage-v2-0-6884505dca78@ideasonboard.com>
In-Reply-To: <20250907-vchiq-destage-v2-0-6884505dca78@ideasonboard.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>
Cc: linux-rpi-kernel@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-staging@lists.linux.dev, 
 linux-kernel@vger.kernel.org, kernel-list@raspberrypi.com, 
 Stefan Wahren <wahrenst@gmx.net>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Jai Luthra <jai.luthra@ideasonboard.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=10558;
 i=jai.luthra@ideasonboard.com; h=from:subject:message-id;
 bh=08ikVC4OF4cu4rGxnCVX1VpjNruDz7uCvJo3Qv3TBEI=;
 b=owEBbQKS/ZANAwAKAUPekfkkmnFFAcsmYgBovUkI8yfEbgw1gZY0apT0ifNy8Z/FNhaFydsh0
 ovd0gbiTdGJAjMEAAEKAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCaL1JCAAKCRBD3pH5JJpx
 RSqSEACf1XtImRCzrp6quqjlaIGwVYhFV5cT1/ncq53XG88bmdTcf7Pk8ws5wUs1v9Z+FkVK6G9
 G6h6goqiCrsbA1x+d0ODkh4ysfY7hB2fbATtOIUpiSWNYt8QL5KfgZdxTluVbeB6RHpyZkSZ+ji
 bSJX75DGxG5p0WCQ4kWlEVPbC7bY956hxYLxur+dYFpGYWQ6srQvU3rt0LskhNecC7NprYjMs2J
 QvWB1dhwCYob6dw0ig2dhSpht32bg8IuM37Cg3exUYWp+iSgU4VhjWp2aHFkNzQdA+Hse69rrj/
 0j4t/8TSUYTbxxMTiLhi+ZlzmKoiksb538gtrI+G//veHRORs+KPkyW0cpNpckKrbe08Z3wuUEH
 RtaVA5BLNW6ERvjBMSgdVC4+aKxOlw9HLBWVo4fChtnWWKSPObmxh/rfwuhMZm5GXCO24qHOVe/
 fWgN3J/NQA+PZEwVNTxvuU+P5Hp37oMdpWGrRPM2xiBl2HiJTLF+prbkbJc3Fm1/lQzyoxwWpsu
 IXCCN//Yzm+HjTF1Bcgk2LAGNfgwFbmLnpOHkByDWUp7lfw2GtJhdVxptp4q/EitwnraK27RI2A
 MHRoT4q+dCz+cx2DIA4SsxftyqF8XeOuE6lNbh0KQC47uv+NH8NJjnb3hdGFnnDdJdzcj74hBO/
 IVrBlkqUEbObTUw==
X-Developer-Key: i=jai.luthra@ideasonboard.com; a=openpgp;
 fpr=4DE0D818E5D575E8D45AAFC543DE91F9249A7145

Destage the VCHIQ interface driver to drivers/platform/raspberrypi.

There is still the remaining TODO item of improving the documentation,
which can be handled post destaging.

Secondly, multimedia drivers like codec and ISP that rely on this
interface need to be upstreamed. And lastly, the drivers that facilitate
the shared memory between VideoCore and Linux, like the vc-sm-cma driver
and vc_mem char driver also need to be upstreamed.

Signed-off-by: Jai Luthra <jai.luthra@ideasonboard.com>
---
 MAINTAINERS                                        |  1 +
 drivers/platform/Kconfig                           |  2 +
 drivers/platform/Makefile                          |  1 +
 drivers/platform/raspberrypi/Kconfig               | 50 ++++++++++++++++++++++
 drivers/platform/raspberrypi/Makefile              | 14 ++++++
 .../raspberrypi/vchiq-interface}/TESTING           |  0
 .../raspberrypi/vchiq-interface}/TODO              |  0
 .../raspberrypi/vchiq-interface}/vchiq_arm.c       |  0
 .../raspberrypi/vchiq-interface}/vchiq_bus.c       |  0
 .../raspberrypi/vchiq-interface}/vchiq_core.c      |  0
 .../raspberrypi/vchiq-interface}/vchiq_debugfs.c   |  0
 .../raspberrypi/vchiq-interface}/vchiq_dev.c       |  0
 .../raspberrypi/vchiq-interface}/vchiq_ioctl.h     |  0
 drivers/staging/vc04_services/Kconfig              | 45 -------------------
 drivers/staging/vc04_services/Makefile             | 12 ------
 15 files changed, 68 insertions(+), 57 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5f79e377ad707ca65fe01f9882c95f8ab1aaa755..fc74a9e2e5a47b8c82cf68ef7c1fe3d37e2fe89b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4753,6 +4753,7 @@ S:	Maintained
 T:	git https://github.com/broadcom/stblinux.git
 F:	Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
 F:	drivers/pci/controller/pcie-brcmstb.c
+F:	drivers/platform/raspberrypi/vchiq-interface
 F:	drivers/staging/vc04_services
 F:	include/linux/raspberrypi/vchiq*
 N:	bcm2711
diff --git a/drivers/platform/Kconfig b/drivers/platform/Kconfig
index 960fd6a82450a4c7b97d51ea3bc29795ee74efd1..324c69c63f76d90643736d00d056382f396adbca 100644
--- a/drivers/platform/Kconfig
+++ b/drivers/platform/Kconfig
@@ -18,3 +18,5 @@ source "drivers/platform/surface/Kconfig"
 source "drivers/platform/x86/Kconfig"
 
 source "drivers/platform/arm64/Kconfig"
+
+source "drivers/platform/raspberrypi/Kconfig"
diff --git a/drivers/platform/Makefile b/drivers/platform/Makefile
index 19ac54648586eb617af0f8a69e3205bd83e8c35b..b97c54e12459fb8c6395d66bd28235b05a729e82 100644
--- a/drivers/platform/Makefile
+++ b/drivers/platform/Makefile
@@ -13,3 +13,4 @@ obj-$(CONFIG_CHROME_PLATFORMS)	+= chrome/
 obj-$(CONFIG_CZNIC_PLATFORMS)	+= cznic/
 obj-$(CONFIG_SURFACE_PLATFORMS)	+= surface/
 obj-$(CONFIG_ARM64_PLATFORM_DEVICES)	+= arm64/
+obj-$(CONFIG_BCM_VIDEOCORE)	+= raspberrypi/
diff --git a/drivers/platform/raspberrypi/Kconfig b/drivers/platform/raspberrypi/Kconfig
new file mode 100644
index 0000000000000000000000000000000000000000..9085e7464ec348fce5ec9f41a9019ab12eee964b
--- /dev/null
+++ b/drivers/platform/raspberrypi/Kconfig
@@ -0,0 +1,50 @@
+# SPDX-License-Identifier: GPL-2.0
+
+menuconfig BCM_VIDEOCORE
+	tristate "Broadcom VideoCore support"
+	depends on OF
+	depends on RASPBERRYPI_FIRMWARE || (COMPILE_TEST && !RASPBERRYPI_FIRMWARE)
+	default y
+	help
+		Support for Broadcom VideoCore services including
+		the BCM2835 family of products which is used
+		by the Raspberry PI.
+
+if BCM_VIDEOCORE
+
+config BCM2835_VCHIQ
+	tristate "BCM2835 VCHIQ"
+	depends on HAS_DMA
+	imply VCHIQ_CDEV
+	help
+		Broadcom BCM2835 and similar SoCs have a VPU called VideoCore.
+		This config enables the VCHIQ driver, which implements a
+		messaging interface between the kernel and the firmware running
+		on VideoCore. Other drivers use this interface to communicate to
+		the VPU. More specifically, the VCHIQ driver is used by
+		audio/video and camera drivers as well as for implementing MMAL
+		API, which is in turn used by several multimedia services on the
+		BCM2835 family of SoCs.
+
+		Defaults to Y when the Broadcom Videocore services are included
+		in the build, N otherwise.
+
+if BCM2835_VCHIQ
+
+config VCHIQ_CDEV
+	bool "VCHIQ Character Driver"
+	help
+		Enable the creation of VCHIQ character driver. The cdev exposes
+		ioctls used by userspace libraries and testing tools to interact
+		with VideoCore, via the VCHIQ core driver (Check BCM2835_VCHIQ
+		for more info).
+
+		This can be set to 'N' if the VideoCore communication is not
+		needed by userspace but only by other kernel modules
+		(like bcm2835-audio).
+
+		If not sure, set this to 'Y'.
+
+endif
+
+endif
diff --git a/drivers/platform/raspberrypi/Makefile b/drivers/platform/raspberrypi/Makefile
new file mode 100644
index 0000000000000000000000000000000000000000..a807571c59a47bb418cbb1dfcc389219d0d0ff22
--- /dev/null
+++ b/drivers/platform/raspberrypi/Makefile
@@ -0,0 +1,14 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_BCM2835_VCHIQ)	+= vchiq.o
+
+vchiq-objs := \
+   vchiq-interface/vchiq_core.o  \
+   vchiq-interface/vchiq_arm.o \
+   vchiq-interface/vchiq_bus.o \
+   vchiq-interface/vchiq_debugfs.o \
+
+ifdef CONFIG_VCHIQ_CDEV
+vchiq-objs += vchiq-interface/vchiq_dev.o
+endif
+
diff --git a/drivers/staging/vc04_services/interface/TESTING b/drivers/platform/raspberrypi/vchiq-interface/TESTING
similarity index 100%
rename from drivers/staging/vc04_services/interface/TESTING
rename to drivers/platform/raspberrypi/vchiq-interface/TESTING
diff --git a/drivers/staging/vc04_services/interface/TODO b/drivers/platform/raspberrypi/vchiq-interface/TODO
similarity index 100%
rename from drivers/staging/vc04_services/interface/TODO
rename to drivers/platform/raspberrypi/vchiq-interface/TODO
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/platform/raspberrypi/vchiq-interface/vchiq_arm.c
similarity index 100%
rename from drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
rename to drivers/platform/raspberrypi/vchiq-interface/vchiq_arm.c
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_bus.c b/drivers/platform/raspberrypi/vchiq-interface/vchiq_bus.c
similarity index 100%
rename from drivers/staging/vc04_services/interface/vchiq_arm/vchiq_bus.c
rename to drivers/platform/raspberrypi/vchiq-interface/vchiq_bus.c
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c b/drivers/platform/raspberrypi/vchiq-interface/vchiq_core.c
similarity index 100%
rename from drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
rename to drivers/platform/raspberrypi/vchiq-interface/vchiq_core.c
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_debugfs.c b/drivers/platform/raspberrypi/vchiq-interface/vchiq_debugfs.c
similarity index 100%
rename from drivers/staging/vc04_services/interface/vchiq_arm/vchiq_debugfs.c
rename to drivers/platform/raspberrypi/vchiq-interface/vchiq_debugfs.c
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c b/drivers/platform/raspberrypi/vchiq-interface/vchiq_dev.c
similarity index 100%
rename from drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c
rename to drivers/platform/raspberrypi/vchiq-interface/vchiq_dev.c
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_ioctl.h b/drivers/platform/raspberrypi/vchiq-interface/vchiq_ioctl.h
similarity index 100%
rename from drivers/staging/vc04_services/interface/vchiq_arm/vchiq_ioctl.h
rename to drivers/platform/raspberrypi/vchiq-interface/vchiq_ioctl.h
diff --git a/drivers/staging/vc04_services/Kconfig b/drivers/staging/vc04_services/Kconfig
index ccc8e15886482e8caa4aeb12440036183fc9b80c..f599f36c54062416305f49a9bba076c3f91c06d3 100644
--- a/drivers/staging/vc04_services/Kconfig
+++ b/drivers/staging/vc04_services/Kconfig
@@ -1,51 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
-menuconfig BCM_VIDEOCORE
-	tristate "Broadcom VideoCore support"
-	depends on OF
-	depends on RASPBERRYPI_FIRMWARE || (COMPILE_TEST && !RASPBERRYPI_FIRMWARE)
-	default y
-	help
-		Support for Broadcom VideoCore services including
-		the BCM2835 family of products which is used
-		by the Raspberry PI.
-
 if BCM_VIDEOCORE
 
-config BCM2835_VCHIQ
-	tristate "BCM2835 VCHIQ"
-	depends on HAS_DMA
-	imply VCHIQ_CDEV
-	help
-		Broadcom BCM2835 and similar SoCs have a VPU called VideoCore.
-		This config enables the VCHIQ driver, which implements a
-		messaging interface between the kernel and the firmware running
-		on VideoCore. Other drivers use this interface to communicate to
-		the VPU. More specifically, the VCHIQ driver is used by
-		audio/video and camera drivers as well as for implementing MMAL
-		API, which is in turn used by several multimedia services on the
-		BCM2835 family of SoCs.
-
-		Defaults to Y when the Broadcom Videocore services are included
-		in the build, N otherwise.
-
-if BCM2835_VCHIQ
-
-config VCHIQ_CDEV
-	bool "VCHIQ Character Driver"
-	help
-		Enable the creation of VCHIQ character driver. The cdev exposes
-		ioctls used by userspace libraries and testing tools to interact
-		with VideoCore, via the VCHIQ core driver (Check BCM2835_VCHIQ
-		for more info).
-
-		This can be set to 'N' if the VideoCore communication is not
-		needed by userspace but only by other kernel modules
-		(like bcm2835-audio).
-
-		If not sure, set this to 'Y'.
-
-endif
-
 source "drivers/staging/vc04_services/bcm2835-audio/Kconfig"
 
 source "drivers/staging/vc04_services/bcm2835-camera/Kconfig"
diff --git a/drivers/staging/vc04_services/Makefile b/drivers/staging/vc04_services/Makefile
index dad3789522b80420f1f72ca8f740c816fb3d9843..51c9466ec7a28141cf66508f602f43cd89ad408b 100644
--- a/drivers/staging/vc04_services/Makefile
+++ b/drivers/staging/vc04_services/Makefile
@@ -1,16 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
-obj-$(CONFIG_BCM2835_VCHIQ)	+= vchiq.o
-
-vchiq-objs := \
-   interface/vchiq_arm/vchiq_core.o  \
-   interface/vchiq_arm/vchiq_arm.o \
-   interface/vchiq_arm/vchiq_bus.o \
-   interface/vchiq_arm/vchiq_debugfs.o \
-
-ifdef CONFIG_VCHIQ_CDEV
-vchiq-objs += interface/vchiq_arm/vchiq_dev.o
-endif
-
 obj-$(CONFIG_SND_BCM2835)		+= bcm2835-audio/
 obj-$(CONFIG_VIDEO_BCM2835)		+= bcm2835-camera/
 obj-$(CONFIG_BCM2835_VCHIQ_MMAL)	+= vchiq-mmal/

-- 
2.50.1


