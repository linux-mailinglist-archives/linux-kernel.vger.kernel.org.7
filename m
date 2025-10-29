Return-Path: <linux-kernel+bounces-875794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02E57C19D61
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 11:47:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AC4D562556
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 10:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F44633A031;
	Wed, 29 Oct 2025 10:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="ew074Uhh"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F108233859A
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 10:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761733899; cv=none; b=Ax0H26FuWKLwlFuOMFenaSpmVaQh+AKPo22BN55CZlXw0xNCsQQJVgxRyYsWLb1F9QGvy7WFclVzuDhlhVG4fYSaFAZ0AWHLQoCwMokyz65dwtY7Rk3QMNiUI3fI89dMnsQ1fyypaaMbmrnQJVuWYKcfQxIJR0qpWj/3PRSCE94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761733899; c=relaxed/simple;
	bh=hqk1es6eP0bxoVwg0ZcIdNvxOEpzgiRwNfLQzmPrpnA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u23FKaAJRq4L2/c9uziG4q6g3h+8G7IycxsLq4+kC7s5N4+WEvfmgYJP3ewHIqx4R+obvhnMUgMY0gqg8HkKJ9SYnTzPbxk4ttLN0ZMvY1cG+a8bn7SfyzL9+QWLZoDvG86lSsdPB1WQJ9xdwG5dA8MuyiPsgcKDZ3stg5G/7to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=ew074Uhh; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from mail.ideasonboard.com (unknown [IPv6:2401:4900:1c69:314e:ee86:ae6e:30:9d13])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 38AED15D2;
	Wed, 29 Oct 2025 11:29:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1761733786;
	bh=hqk1es6eP0bxoVwg0ZcIdNvxOEpzgiRwNfLQzmPrpnA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ew074Uhh7Ukuu1yRxDplnqtQSq8nVRM8O5rQXT/mbyn3b6ikVvlzccPLJ+O5ZlEng
	 tf8TQ7KKKrGuOH5DkUXWIjvJw7RsVshvZhkC/tfoS23vgETn5DYRZileLyUJ9e+xUI
	 0Aah2RV1hckAmJiPKQxSbIOUtnLMsSs+3gp0gD1I=
From: Jai Luthra <jai.luthra@ideasonboard.com>
Date: Wed, 29 Oct 2025 16:00:10 +0530
Subject: [PATCH v3 6/7] platform/raspberrypi: Destage VCHIQ interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-vchiq-destage-v3-6-da8d6c83c2c5@ideasonboard.com>
References: <20251029-vchiq-destage-v3-0-da8d6c83c2c5@ideasonboard.com>
In-Reply-To: <20251029-vchiq-destage-v3-0-da8d6c83c2c5@ideasonboard.com>
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
 Kieran Bingham <kieran.bingham@ideasonboard.com>, 
 Phil Elwell <phil@raspberrypi.com>, Umang Jain <uajain@igalia.com>, 
 Jai Luthra <jai.luthra@ideasonboard.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=11423;
 i=jai.luthra@ideasonboard.com; h=from:subject:message-id;
 bh=hqk1es6eP0bxoVwg0ZcIdNvxOEpzgiRwNfLQzmPrpnA=;
 b=owEBbQKS/ZANAwAKAUPekfkkmnFFAcsmYgBpAezep8uSPLbEjLlMETD808XPwzPN0UEtOWCSf
 w5FhZLfJ76JAjMEAAEKAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCaQHs3gAKCRBD3pH5JJpx
 RegqD/9qHBg7KwY157j8JMO2+MpTbjvl1dqVj/LG04ZgHowhXXbrqJ/wEj7D8WYCn874TuZ6RU1
 8bvkCt/1M2LmyupEvijRkIbkwcNIbtWhkpHJJ+GudapPoWFYAETt3XqLhjq3Zb2wnQSJ7l9htDg
 uP8G1FEdKquy581vNhSoawfyvDidGwmyCLz+gtbYUDa1ym/WmFQPvAlc0JCLx5FCNhbLAdcrVY4
 6jt9J1sbYqbRl6hmlEvVhkgItrxHvWGCO87sbR/BY0q0e39miNZSYcBnPrDH+YE11IJFLzIlJuh
 CSf2/eYjbDFNoIVdKqQKlPwzEO2xrkZ9J1P+z2fXEIm2jogDRGSIKr1zh7k0P1ih6Y9pOd9wLsH
 G8KMAmljer/K6o+ms63qWPnnTVnMYcTt/40U/7iZJFqe/lM76mOquWohis1THiuh0xtmok1i66E
 WbIrNRy7C5yDGt9dbGxzz+9VDbPKGZ4uFxTgxTmNWEubMK5pyTUWHC3zka58mTR9Sr4HxUBbr3b
 wd2VRg+dVbQanttbcPeNb4Cq4uO8dALGfkQYbDc+kSd9s6eCHqmEx3jER77gg4jMH7eF5/JG3hP
 Mj3GHpm3mt5SL6rAEsgX1C+UjJ8pQOPaDA9zbCH4almhzpVI+MHMSV2LA0m9HTDBL3B0A+1D8dU
 c1zzwTjaMGgOjHA==
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
 MAINTAINERS                                                                                                 |  1 +
 drivers/platform/Kconfig                                                                                    |  2 ++
 drivers/platform/Makefile                                                                                   |  1 +
 drivers/platform/raspberrypi/Kconfig                                                                        | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/platform/raspberrypi/Makefile                                                                       | 14 ++++++++++++++
 drivers/{staging/vc04_services/interface => platform/raspberrypi/vchiq-interface}/TESTING                   |  0
 drivers/{staging/vc04_services/interface => platform/raspberrypi/vchiq-interface}/TODO                      |  0
 drivers/{staging/vc04_services/interface/vchiq_arm => platform/raspberrypi/vchiq-interface}/vchiq_arm.c     |  0
 drivers/{staging/vc04_services/interface/vchiq_arm => platform/raspberrypi/vchiq-interface}/vchiq_bus.c     |  0
 drivers/{staging/vc04_services/interface/vchiq_arm => platform/raspberrypi/vchiq-interface}/vchiq_core.c    |  0
 drivers/{staging/vc04_services/interface/vchiq_arm => platform/raspberrypi/vchiq-interface}/vchiq_debugfs.c |  0
 drivers/{staging/vc04_services/interface/vchiq_arm => platform/raspberrypi/vchiq-interface}/vchiq_dev.c     |  0
 drivers/{staging/vc04_services/interface/vchiq_arm => platform/raspberrypi/vchiq-interface}/vchiq_ioctl.h   |  0
 drivers/staging/vc04_services/Kconfig                                                                       | 45 ---------------------------------------------
 drivers/staging/vc04_services/Makefile                                                                      | 12 ------------
 15 files changed, 68 insertions(+), 57 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index cd223e119d48ec24ed00119fbc95653fff88cf34..df07d1a3c28d048e14a0f65c9f9ff01cc260013a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4828,6 +4828,7 @@ S:	Maintained
 T:	git https://github.com/broadcom/stblinux.git
 F:	Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
 F:	drivers/pci/controller/pcie-brcmstb.c
+F:	drivers/platform/raspberrypi/vchiq-*
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
index 19ac54648586eb617af0f8a69e3205bd83e8c35b..b0935c602adaff0d94534f51c7d7592ea9569d1a 100644
--- a/drivers/platform/Makefile
+++ b/drivers/platform/Makefile
@@ -13,3 +13,4 @@ obj-$(CONFIG_CHROME_PLATFORMS)	+= chrome/
 obj-$(CONFIG_CZNIC_PLATFORMS)	+= cznic/
 obj-$(CONFIG_SURFACE_PLATFORMS)	+= surface/
 obj-$(CONFIG_ARM64_PLATFORM_DEVICES)	+= arm64/
+obj-$(CONFIG_BCM2835_VCHIQ)	+= raspberrypi/
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
index c803cb8e4cccefa1740444514e3e4ea0f1742d05..b9e6f369f54c3af6225f181e08ac14e3de044062 100644
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
 
 source "drivers/staging/vc04_services/vchiq-mmal/Kconfig"
diff --git a/drivers/staging/vc04_services/Makefile b/drivers/staging/vc04_services/Makefile
index c14be508dcddd459f0aff762782b7622d69a5b2b..7a716a5c781530b673027b9f82ec94ebfd615f8a 100644
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
 obj-$(CONFIG_BCM2835_VCHIQ_MMAL)	+= vchiq-mmal/
 

-- 
2.51.0


