Return-Path: <linux-kernel+bounces-787725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35DCEB37A4B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 08:25:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA7FB2083E9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 06:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 575A62D3237;
	Wed, 27 Aug 2025 06:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="XCz0P9Xy"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2277A2D6E67
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 06:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756275902; cv=none; b=KDwe7TK7l7GcNvMRSrEUTi/8KaGugXFZITuC4fs456/dvWhivqqRBc3nqhAGUtcWnkAEclB144Kwt38GXpaYTRE+P2MRlFfhmkJE1bINJDOI4pqzRUl402HONqD51fllhg7ZycWO4Ol/A652wOq5euKmzYg04ZQKGZXnO+vwbRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756275902; c=relaxed/simple;
	bh=rsY3OZd55mCHoO8iNPlykEq+MF77VDdAzU7AmJEQOK4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oeIpMT22/xu6APaqVBKwDQFkL6d/eh8mzzhLn7LbkTJJTrnBsNM2illiIazCWG015fU34yk1yIoNcz9cLRPIsVCYpWKSa8mojt5i5K/xeay8DnxqieI4h0e5JNQg7hwXPmNVwdHdvmB0Kb+kh+ZzeyudXmH3sargGWp8FKpT3Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=XCz0P9Xy; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from mail.ideasonboard.com (unknown [223.190.80.94])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id D8594300E;
	Wed, 27 Aug 2025 08:23:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1756275834;
	bh=rsY3OZd55mCHoO8iNPlykEq+MF77VDdAzU7AmJEQOK4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=XCz0P9XyF9rnqPiv5t18qp28vaMal4HFJnPMvrl5X76aqHQRKuk+p8LGCOYJ5ddkt
	 6pBVgsQhnSQrbl4eZzwRSWXSOYHushr6TKrUmVLVzooPHfagpZBVzc8NVWGr2GSMMk
	 IZ9f/A4kSNSt7KvRVgA0lvU3NJlBCgwIxbYX7A34=
From: Jai Luthra <jai.luthra@ideasonboard.com>
Date: Wed, 27 Aug 2025 11:54:08 +0530
Subject: [PATCH 1/5] include: linux: Destage VCHIQ interface headers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250827-vchiq-destage-v1-1-5052a0d81c42@ideasonboard.com>
References: <20250827-vchiq-destage-v1-0-5052a0d81c42@ideasonboard.com>
In-Reply-To: <20250827-vchiq-destage-v1-0-5052a0d81c42@ideasonboard.com>
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
 Jai Luthra <jai.luthra@ideasonboard.com>, 
 Umang Jain <umang.jain@ideasonboard.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=11940;
 i=jai.luthra@ideasonboard.com; h=from:subject:message-id;
 bh=gzwzF9agRWStJirrJe87JvmVxXcBxN9SVu3rMY6P0u8=;
 b=owEBbQKS/ZANAwAKAUPekfkkmnFFAcsmYgBorqSZtu7ttezLfbsV/ONiPWL2o6Tm7cMgpTdIJ
 jIMTLZOn6eJAjMEAAEKAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCaK6kmQAKCRBD3pH5JJpx
 RefiEACRFjTlqRQ3wZ7s8TEjC+scrNB49JK3afwNY5eykQoPUqZZul2ziGP3tqiU0rkR+7oFt0i
 HLEDW8zWMt3yzAQg3zqvEn/XQ5fApaBEZwdnSvqmpt1eoCskPULiiIgTYsr+jRqgrlgpujLgaP8
 qMxwBZnR6SfFej3y8bp/FX8sQBkeV8habCp+Ky8jkaT/tYHkF16WiHjDd1osAfrFPeL1FG/42au
 xRY1OsPeyDDSiKfXXOUNCV36LqoneRhthhvihlQGK2Oen+a3sIr+eHeBKZ3TFigAuTFFSQr46j1
 wb2Ebaq/AyCR5D/bC6C0sLuoBoHmdqFED/HAz7V3vfms5bjV2VrgNnp+Sc1YeE8iIXwZS6K8X2y
 ytLWSIo6XIGMnfp+9nzJGuRelDRzoTo2HT0NIukeFhhgPdER40Jcp5/oDIozbbN5XqYRw6GRubb
 2p6LWgBWIE6pCAKJ8RgaWVToCw0PvPZv4wr0MGooZah+ZL4LXmGocwW3SxYPs5E3jIJcdwxMarX
 TtZgAkhlpNf4MBUkS/FRWKFWypyg5CrCRemvoX0y9IR9kVYkj8QsUj+jmD/IjIWQ0LXf+fGTegM
 Om8k/jvOUwwPKwq4kt3bbwaPPUe7YQmz4KsGdq7N4QXrY2V2vJrUmRUHjuAuQuz+1sXnsSYIozz
 vGq2VcokdtLRztw==
X-Developer-Key: i=jai.luthra@ideasonboard.com; a=openpgp;
 fpr=4DE0D818E5D575E8D45AAFC543DE91F9249A7145

From: Umang Jain <umang.jain@ideasonboard.com>

Move the VCHIQ headers from drivers/staging/vc04_services/include to
include/linux/vchiq

This is done so that they can be shared between the VCHIQ interface
(which is going to be de-staged in a subsequent commit from staging)
and the VCHIQ drivers left in the staging/vc04_services (namely
bcm2835-audio, bcm2835-camera).

The include/linux/vchiq/ provides a central location to serve both
of these areas.

Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
Signed-off-by: Jai Luthra <jai.luthra@ideasonboard.com>
---
 MAINTAINERS                                                      | 1 +
 drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c      | 5 +++--
 drivers/staging/vc04_services/bcm2835-audio/bcm2835.c            | 3 ++-
 drivers/staging/vc04_services/bcm2835-audio/bcm2835.h            | 3 +--
 drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c    | 3 ++-
 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c    | 9 +++++----
 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_bus.c    | 4 ++--
 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c   | 4 ++--
 .../staging/vc04_services/interface/vchiq_arm/vchiq_debugfs.c    | 6 +++---
 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c    | 7 ++++---
 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_ioctl.h  | 3 +--
 drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c            | 5 +++--
 .../include/linux/raspberrypi => include/linux/vchiq}/vchiq.h    | 0
 .../interface/vchiq_arm => include/linux/vchiq}/vchiq_arm.h      | 0
 .../interface/vchiq_arm => include/linux/vchiq}/vchiq_bus.h      | 0
 .../interface/vchiq_arm => include/linux/vchiq}/vchiq_cfg.h      | 0
 .../interface/vchiq_arm => include/linux/vchiq}/vchiq_core.h     | 2 +-
 .../interface/vchiq_arm => include/linux/vchiq}/vchiq_debugfs.h  | 0
 18 files changed, 30 insertions(+), 25 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index fe168477caa45799dfe07de2f54de6d6a1ce0615..f17ebb1fa51bd7e4dcb2ae1b0fced6d41685dc84 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4754,6 +4754,7 @@ T:	git https://github.com/broadcom/stblinux.git
 F:	Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
 F:	drivers/pci/controller/pcie-brcmstb.c
 F:	drivers/staging/vc04_services
+F:	include/linux/vchiq
 N:	bcm2711
 N:	bcm2712
 N:	bcm283*
diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c
index 0dbe76ee557032d7861acfc002cc203ff2e6971d..c49f2f7409b84ed6ebdd71787566efb1bc230f55 100644
--- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c
+++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c
@@ -4,11 +4,12 @@
 #include <linux/slab.h>
 #include <linux/module.h>
 #include <linux/completion.h>
+
+#include <linux/vchiq/vchiq_arm.h>
+
 #include "bcm2835.h"
 #include "vc_vchi_audioserv_defs.h"
 
-#include "../interface/vchiq_arm/vchiq_arm.h"
-
 struct bcm2835_audio_instance {
 	struct device *dev;
 	unsigned int service_handle;
diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835.c b/drivers/staging/vc04_services/bcm2835-audio/bcm2835.c
index b74cb104e9de00e7688a320949111a419cca084a..5011720940715c12a2d2fe58b40ed84dcb2e6824 100644
--- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835.c
+++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835.c
@@ -6,7 +6,8 @@
 #include <linux/slab.h>
 #include <linux/module.h>
 
-#include "../interface/vchiq_arm/vchiq_bus.h"
+#include <linux/vchiq/vchiq_bus.h>
+
 #include "bcm2835.h"
 
 static bool enable_hdmi;
diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835.h b/drivers/staging/vc04_services/bcm2835-audio/bcm2835.h
index 49ec5b496edb4ba8634171b1390c4e15181e4048..7e63ef251c37269032fc20ae1237855245e5e0a7 100644
--- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835.h
+++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835.h
@@ -5,13 +5,12 @@
 #define __SOUND_ARM_BCM2835_H
 
 #include <linux/device.h>
+#include <linux/vchiq/vchiq.h>
 #include <linux/wait.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/pcm-indirect.h>
 
-#include "../include/linux/raspberrypi/vchiq.h"
-
 #define MAX_SUBSTREAMS   (8)
 #define AVAIL_SUBSTREAMS_MASK  (0xff)
 
diff --git a/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c b/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
index fa7ea4ca4c36f4ec7f76f6ffbea9f45205116bb8..fcbbe1aa60b768e5a7a08a131f595a0457f4473a 100644
--- a/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
+++ b/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
@@ -26,7 +26,8 @@
 #include <media/v4l2-common.h>
 #include <linux/delay.h>
 
-#include "../interface/vchiq_arm/vchiq_bus.h"
+#include <linux/vchiq/vchiq_bus.h>
+
 #include "../vchiq-mmal/mmal-common.h"
 #include "../vchiq-mmal/mmal-encodings.h"
 #include "../vchiq-mmal/mmal-vchiq.h"
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index 721b15b7e13b9f25cee7619575bbfa1a4734cce8..10138c1454dd7fdcbab6b95ea41f8e1ac2defc4b 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -30,11 +30,12 @@
 #include <linux/uaccess.h>
 #include <soc/bcm2835/raspberrypi-firmware.h>
 
-#include "vchiq_core.h"
+#include <linux/vchiq/vchiq_core.h>
+#include <linux/vchiq/vchiq_arm.h>
+#include <linux/vchiq/vchiq_bus.h>
+#include <linux/vchiq/vchiq_debugfs.h>
+
 #include "vchiq_ioctl.h"
-#include "vchiq_arm.h"
-#include "vchiq_bus.h"
-#include "vchiq_debugfs.h"
 
 #define DEVICE_NAME "vchiq"
 
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_bus.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_bus.c
index 41ece91ab88aa647a348910a0b913d0b28a8c761..5d55dbff82150a84b15483e71718c48f5cb8caea 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_bus.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_bus.c
@@ -11,8 +11,8 @@
 #include <linux/slab.h>
 #include <linux/string.h>
 
-#include "vchiq_arm.h"
-#include "vchiq_bus.h"
+#include <linux/vchiq/vchiq_arm.h>
+#include <linux/vchiq/vchiq_bus.h>
 
 static int vchiq_bus_type_match(struct device *dev, const struct device_driver *drv)
 {
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
index e2cac0898b8faa3c255de6b8562c7096a9683c49..ac0379f5f45dfa331dc2fec8d580d176f931cf2b 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
@@ -15,8 +15,8 @@
 #include <linux/rcupdate.h>
 #include <linux/sched/signal.h>
 
-#include "vchiq_arm.h"
-#include "vchiq_core.h"
+#include <linux/vchiq/vchiq_arm.h>
+#include <linux/vchiq/vchiq_core.h>
 
 #define VCHIQ_SLOT_HANDLER_STACK 8192
 
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_debugfs.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_debugfs.c
index d5f7f61c5626934b819e8ff322e22ae3d6158b31..b1a8f1abafc2fa83132b1a02ba343d71315950de 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_debugfs.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_debugfs.c
@@ -5,9 +5,9 @@
  */
 
 #include <linux/debugfs.h>
-#include "vchiq_core.h"
-#include "vchiq_arm.h"
-#include "vchiq_debugfs.h"
+#include <linux/vchiq/vchiq_core.h>
+#include <linux/vchiq/vchiq_arm.h>
+#include <linux/vchiq/vchiq_debugfs.h>
 
 #ifdef CONFIG_DEBUG_FS
 
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c
index 3b20ba5c736221ce1cacfc9ce86eca623382a30b..781d6dd64ee33816b52b62f1f25bcd33363d8e02 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c
@@ -11,10 +11,11 @@
 #include <linux/compat.h>
 #include <linux/miscdevice.h>
 
-#include "vchiq_core.h"
+#include <linux/vchiq/vchiq_core.h>
+#include <linux/vchiq/vchiq_arm.h>
+#include <linux/vchiq/vchiq_debugfs.h>
+
 #include "vchiq_ioctl.h"
-#include "vchiq_arm.h"
-#include "vchiq_debugfs.h"
 
 static const char *const ioctl_names[] = {
 	"CONNECT",
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_ioctl.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_ioctl.h
index afb71a83cfe7035e5dd61003fa99fd514ca18047..638469f18f859a0c7e738ef5bed7bf3c3ebebe59 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_ioctl.h
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_ioctl.h
@@ -5,8 +5,7 @@
 #define VCHIQ_IOCTLS_H
 
 #include <linux/ioctl.h>
-
-#include "../../include/linux/raspberrypi/vchiq.h"
+#include <linux/vchiq/vchiq.h>
 
 #define VCHIQ_IOC_MAGIC 0xc4
 #define VCHIQ_INVALID_HANDLE (~0)
diff --git a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
index 3fe482bd279390a7586c49bde00f38c61558ca8e..f5e141908b0f91ca4172d48aee37f0329d239d7c 100644
--- a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
+++ b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
@@ -22,11 +22,12 @@
 #include <linux/mm.h>
 #include <linux/slab.h>
 #include <linux/completion.h>
+#include <linux/vchiq/vchiq.h>
 #include <linux/vmalloc.h>
 #include <media/videobuf2-vmalloc.h>
 
-#include "../include/linux/raspberrypi/vchiq.h"
-#include "../interface/vchiq_arm/vchiq_arm.h"
+#include <linux/vchiq/vchiq_arm.h>
+
 #include "mmal-common.h"
 #include "mmal-vchiq.h"
 #include "mmal-msg.h"
diff --git a/drivers/staging/vc04_services/include/linux/raspberrypi/vchiq.h b/include/linux/vchiq/vchiq.h
similarity index 100%
rename from drivers/staging/vc04_services/include/linux/raspberrypi/vchiq.h
rename to include/linux/vchiq/vchiq.h
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.h b/include/linux/vchiq/vchiq_arm.h
similarity index 100%
rename from drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.h
rename to include/linux/vchiq/vchiq_arm.h
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_bus.h b/include/linux/vchiq/vchiq_bus.h
similarity index 100%
rename from drivers/staging/vc04_services/interface/vchiq_arm/vchiq_bus.h
rename to include/linux/vchiq/vchiq_bus.h
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_cfg.h b/include/linux/vchiq/vchiq_cfg.h
similarity index 100%
rename from drivers/staging/vc04_services/interface/vchiq_arm/vchiq_cfg.h
rename to include/linux/vchiq/vchiq_cfg.h
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h b/include/linux/vchiq/vchiq_core.h
similarity index 99%
rename from drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
rename to include/linux/vchiq/vchiq_core.h
index 9b4e766990a493d6e9d4e0604f2c84f4e7b77804..dbcb19e7a6d39b94967261c4ab23d6325e999249 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
+++ b/include/linux/vchiq/vchiq_core.h
@@ -15,7 +15,7 @@
 #include <linux/spinlock_types.h>
 #include <linux/wait.h>
 
-#include "../../include/linux/raspberrypi/vchiq.h"
+#include "vchiq.h"
 #include "vchiq_cfg.h"
 
 /* Do this so that we can test-build the code on non-rpi systems */
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_debugfs.h b/include/linux/vchiq/vchiq_debugfs.h
similarity index 100%
rename from drivers/staging/vc04_services/interface/vchiq_arm/vchiq_debugfs.h
rename to include/linux/vchiq/vchiq_debugfs.h

-- 
2.50.1


