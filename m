Return-Path: <linux-kernel+bounces-804567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB8C7B479E6
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 10:58:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60C1D189CEA1
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 08:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69E3C21FF5D;
	Sun,  7 Sep 2025 08:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="rg99lo9I"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111BD21CC58
	for <linux-kernel@vger.kernel.org>; Sun,  7 Sep 2025 08:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757235487; cv=none; b=fF2RB+biJRV0mrH+JqbbQIYMoYNndtgP05B4P/3MMSSj6+84SV4VpVy6V7sBb7kTTTYf2dZN5xX16+rR953njvyqwmIZGEVsRHx7uz9SjJ7vv8niRLlYwtBD/ceF5IOP1NBC7sHAl3qzfk+iPrCP3on4xe9I7S2tLbc28YnsyZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757235487; c=relaxed/simple;
	bh=EAQihaRuTtfloRa+hQ4jULWMXOVjcEwg2wGq7sDs/Aw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fayCQujOJ/uMOKwfVwih/2YsTRKRZaZjm5II14VjxOcMe3eqplLQ0/FcXu63WbIyK17GZado/fVl0CB63US7zMFpnaJxFTS+qPcw/gU4HlqQNA7dARZGWEKkidn2GRL1qCDmpUqUXqD/rzrxCMYNL9ODqm1AhVW9pq6P2tJ0v6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=rg99lo9I; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from mail.ideasonboard.com (unknown [IPv6:2401:4900:1c67:84a2:d86d:fcf7:24b4:e467])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 77873300B;
	Sun,  7 Sep 2025 10:56:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1757235412;
	bh=EAQihaRuTtfloRa+hQ4jULWMXOVjcEwg2wGq7sDs/Aw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=rg99lo9IfuiJrsnbeDT9kv2n0x9URkW5C8hjZ77Ex+cCPlcoifo1jmmV6dsrRt0+Y
	 5Yw7b03ppyfJMmRrTlIDU3SLr5RoAYwHKsoXMWMNHpi0xiYIOEAQtNl6AGuDCqTU0i
	 4nQH45fSmrpSNf278hB3NSZAvfUFKV7vc5nrF4ic=
From: Jai Luthra <jai.luthra@ideasonboard.com>
Date: Sun, 07 Sep 2025 14:26:21 +0530
Subject: [PATCH v2 1/5] include: linux: Destage VCHIQ interface headers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250907-vchiq-destage-v2-1-6884505dca78@ideasonboard.com>
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
 Jai Luthra <jai.luthra@ideasonboard.com>, 
 Umang Jain <umang.jain@ideasonboard.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=12236;
 i=jai.luthra@ideasonboard.com; h=from:subject:message-id;
 bh=lBAIJXENcceevdn50VSoA29GA4QuKSK3Uc69sTGAOlo=;
 b=owEBbQKS/ZANAwAKAUPekfkkmnFFAcsmYgBovUkG/aJii1NqrkN0h3uZvf+LE7g6DYEY4hbqj
 5zXcb/wcXqJAjMEAAEKAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCaL1JBgAKCRBD3pH5JJpx
 RdP3EADLQJlmOjkbbbniHayVMFY8S2WjkoZRSOTxTARDtW9laJe3mUrPgGt/upVy9dcKdWzKi/u
 7FNmkJgWi4AAYJbKH6MP75WukJ9gaPjT7S5tts71hoRrVaxbRhmgchlPD4yxXLIHXo4+dvou0a8
 jvTEGj1PumfIvIQNUvXFVdkx5r2vAcxYXyi8gYhU3YUAdzj57hhcsW7uBp/biG/UBEQTF2yAZ0p
 ojesfM8JMUY/24kMiZ7FhvrgmAoZ81PAKVYwKA9RYZK6hEeoCsiDO5NHXwe+MWohwUUTECPW/ic
 OCMPUsk9sp1N5BgJ9ctbQ/2UPc65878aOw/5MY8dF//rTf5aoBGlMQJ8y9YuRQUysVBneLqRArv
 C3j4ZuYMhayqGT3HRB8bK6qp8kmmomRi5j/2rVwF6+T75MxxhCjuG3AdE1Il+ch5BLb9YsorFYP
 OqNNIVZFgDmwbuR9eXMNrAS1KPmuIa95oJlLgKg1ZYUyplL3z6MX5IMSWRVHuWFsEQ2esakbVcT
 X4+wsfwAxsWMjg6aLQ3laKLSfOeyBhdIfeFwaHI1g7GjYa/7DJXHPnRbqBv86Ua92S8mLvZx6qy
 Qgx0raDZJOyDFsbcMb68NEBV4CM+k8B0Wd22/OcfyoY4FVwyiuRomGKNj/AjbIlqeIbjOD7Ataq
 OvVBXbt5kGEWUww==
X-Developer-Key: i=jai.luthra@ideasonboard.com; a=openpgp;
 fpr=4DE0D818E5D575E8D45AAFC543DE91F9249A7145

From: Umang Jain <umang.jain@ideasonboard.com>

Move the VCHIQ headers from drivers/staging/vc04_services/include to
include/linux/raspberrypi

This is done so that they can be shared between the VCHIQ interface
(which is going to be de-staged in a subsequent commit from staging) and
the VCHIQ drivers left in the staging/vc04_services (namely
bcm2835-audio, bcm2835-camera).

The include/linux/raspberrypi/ provides a central location to serve both of
these areas.

Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
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
 .../vc04_services/include => include}/linux/raspberrypi/vchiq.h  | 0
 .../vchiq_arm => include/linux/raspberrypi}/vchiq_arm.h          | 0
 .../vchiq_arm => include/linux/raspberrypi}/vchiq_bus.h          | 0
 .../vchiq_arm => include/linux/raspberrypi}/vchiq_cfg.h          | 0
 .../vchiq_arm => include/linux/raspberrypi}/vchiq_core.h         | 2 +-
 .../vchiq_arm => include/linux/raspberrypi}/vchiq_debugfs.h      | 0
 18 files changed, 30 insertions(+), 25 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index fe168477caa45799dfe07de2f54de6d6a1ce0615..5f79e377ad707ca65fe01f9882c95f8ab1aaa755 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4754,6 +4754,7 @@ T:	git https://github.com/broadcom/stblinux.git
 F:	Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
 F:	drivers/pci/controller/pcie-brcmstb.c
 F:	drivers/staging/vc04_services
+F:	include/linux/raspberrypi/vchiq*
 N:	bcm2711
 N:	bcm2712
 N:	bcm283*
diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c
index 0dbe76ee557032d7861acfc002cc203ff2e6971d..7368b384497f7b1439252a857f5845d3c4108c75 100644
--- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c
+++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c
@@ -4,11 +4,12 @@
 #include <linux/slab.h>
 #include <linux/module.h>
 #include <linux/completion.h>
+
+#include <linux/raspberrypi/vchiq_arm.h>
+
 #include "bcm2835.h"
 #include "vc_vchi_audioserv_defs.h"
 
-#include "../interface/vchiq_arm/vchiq_arm.h"
-
 struct bcm2835_audio_instance {
 	struct device *dev;
 	unsigned int service_handle;
diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835.c b/drivers/staging/vc04_services/bcm2835-audio/bcm2835.c
index b74cb104e9de00e7688a320949111a419cca084a..f292a6618166fe2581dffce873873c67af3d3b54 100644
--- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835.c
+++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835.c
@@ -6,7 +6,8 @@
 #include <linux/slab.h>
 #include <linux/module.h>
 
-#include "../interface/vchiq_arm/vchiq_bus.h"
+#include <linux/raspberrypi/vchiq_bus.h>
+
 #include "bcm2835.h"
 
 static bool enable_hdmi;
diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835.h b/drivers/staging/vc04_services/bcm2835-audio/bcm2835.h
index 49ec5b496edb4ba8634171b1390c4e15181e4048..5a1348747ff4e0b63b244156a2252bb276863514 100644
--- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835.h
+++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835.h
@@ -5,13 +5,12 @@
 #define __SOUND_ARM_BCM2835_H
 
 #include <linux/device.h>
+#include <linux/raspberrypi/vchiq.h>
 #include <linux/wait.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/pcm-indirect.h>
 
-#include "../include/linux/raspberrypi/vchiq.h"
-
 #define MAX_SUBSTREAMS   (8)
 #define AVAIL_SUBSTREAMS_MASK  (0xff)
 
diff --git a/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c b/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
index fa7ea4ca4c36f4ec7f76f6ffbea9f45205116bb8..d5e7b2d78eb478372e249ef0029874dffbc7e84f 100644
--- a/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
+++ b/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
@@ -26,7 +26,8 @@
 #include <media/v4l2-common.h>
 #include <linux/delay.h>
 
-#include "../interface/vchiq_arm/vchiq_bus.h"
+#include <linux/raspberrypi/vchiq_bus.h>
+
 #include "../vchiq-mmal/mmal-common.h"
 #include "../vchiq-mmal/mmal-encodings.h"
 #include "../vchiq-mmal/mmal-vchiq.h"
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index 721b15b7e13b9f25cee7619575bbfa1a4734cce8..53e162278b478d4eea8dec6dd31f9a0ec15224c6 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -30,11 +30,12 @@
 #include <linux/uaccess.h>
 #include <soc/bcm2835/raspberrypi-firmware.h>
 
-#include "vchiq_core.h"
+#include <linux/raspberrypi/vchiq_core.h>
+#include <linux/raspberrypi/vchiq_arm.h>
+#include <linux/raspberrypi/vchiq_bus.h>
+#include <linux/raspberrypi/vchiq_debugfs.h>
+
 #include "vchiq_ioctl.h"
-#include "vchiq_arm.h"
-#include "vchiq_bus.h"
-#include "vchiq_debugfs.h"
 
 #define DEVICE_NAME "vchiq"
 
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_bus.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_bus.c
index 41ece91ab88aa647a348910a0b913d0b28a8c761..f50e637d505cc58e86351de4e22ac57152570075 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_bus.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_bus.c
@@ -11,8 +11,8 @@
 #include <linux/slab.h>
 #include <linux/string.h>
 
-#include "vchiq_arm.h"
-#include "vchiq_bus.h"
+#include <linux/raspberrypi/vchiq_arm.h>
+#include <linux/raspberrypi/vchiq_bus.h>
 
 static int vchiq_bus_type_match(struct device *dev, const struct device_driver *drv)
 {
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
index e2cac0898b8faa3c255de6b8562c7096a9683c49..dc2c304c886edf59115fdd66c8842cb8eeeacff8 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
@@ -15,8 +15,8 @@
 #include <linux/rcupdate.h>
 #include <linux/sched/signal.h>
 
-#include "vchiq_arm.h"
-#include "vchiq_core.h"
+#include <linux/raspberrypi/vchiq_arm.h>
+#include <linux/raspberrypi/vchiq_core.h>
 
 #define VCHIQ_SLOT_HANDLER_STACK 8192
 
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_debugfs.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_debugfs.c
index d5f7f61c5626934b819e8ff322e22ae3d6158b31..c82326a9b6d9cfba7d4233a48530f85443eb2f5a 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_debugfs.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_debugfs.c
@@ -5,9 +5,9 @@
  */
 
 #include <linux/debugfs.h>
-#include "vchiq_core.h"
-#include "vchiq_arm.h"
-#include "vchiq_debugfs.h"
+#include <linux/raspberrypi/vchiq_core.h>
+#include <linux/raspberrypi/vchiq_arm.h>
+#include <linux/raspberrypi/vchiq_debugfs.h>
 
 #ifdef CONFIG_DEBUG_FS
 
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c
index 3b20ba5c736221ce1cacfc9ce86eca623382a30b..0f3dde2657d6b81fab64daa17d26592712fe8473 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c
@@ -11,10 +11,11 @@
 #include <linux/compat.h>
 #include <linux/miscdevice.h>
 
-#include "vchiq_core.h"
+#include <linux/raspberrypi/vchiq_core.h>
+#include <linux/raspberrypi/vchiq_arm.h>
+#include <linux/raspberrypi/vchiq_debugfs.h>
+
 #include "vchiq_ioctl.h"
-#include "vchiq_arm.h"
-#include "vchiq_debugfs.h"
 
 static const char *const ioctl_names[] = {
 	"CONNECT",
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_ioctl.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_ioctl.h
index afb71a83cfe7035e5dd61003fa99fd514ca18047..d0c759f6d8ea79e43247048f8b3903df67dd84c8 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_ioctl.h
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_ioctl.h
@@ -5,8 +5,7 @@
 #define VCHIQ_IOCTLS_H
 
 #include <linux/ioctl.h>
-
-#include "../../include/linux/raspberrypi/vchiq.h"
+#include <linux/raspberrypi/vchiq.h>
 
 #define VCHIQ_IOC_MAGIC 0xc4
 #define VCHIQ_INVALID_HANDLE (~0)
diff --git a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
index 3fe482bd279390a7586c49bde00f38c61558ca8e..5caf9ae56ee48290401f86eadea9f1ca0149b11e 100644
--- a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
+++ b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
@@ -22,11 +22,12 @@
 #include <linux/mm.h>
 #include <linux/slab.h>
 #include <linux/completion.h>
+#include <linux/raspberrypi/vchiq.h>
 #include <linux/vmalloc.h>
 #include <media/videobuf2-vmalloc.h>
 
-#include "../include/linux/raspberrypi/vchiq.h"
-#include "../interface/vchiq_arm/vchiq_arm.h"
+#include <linux/raspberrypi/vchiq_arm.h>
+
 #include "mmal-common.h"
 #include "mmal-vchiq.h"
 #include "mmal-msg.h"
diff --git a/drivers/staging/vc04_services/include/linux/raspberrypi/vchiq.h b/include/linux/raspberrypi/vchiq.h
similarity index 100%
rename from drivers/staging/vc04_services/include/linux/raspberrypi/vchiq.h
rename to include/linux/raspberrypi/vchiq.h
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.h b/include/linux/raspberrypi/vchiq_arm.h
similarity index 100%
rename from drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.h
rename to include/linux/raspberrypi/vchiq_arm.h
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_bus.h b/include/linux/raspberrypi/vchiq_bus.h
similarity index 100%
rename from drivers/staging/vc04_services/interface/vchiq_arm/vchiq_bus.h
rename to include/linux/raspberrypi/vchiq_bus.h
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_cfg.h b/include/linux/raspberrypi/vchiq_cfg.h
similarity index 100%
rename from drivers/staging/vc04_services/interface/vchiq_arm/vchiq_cfg.h
rename to include/linux/raspberrypi/vchiq_cfg.h
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h b/include/linux/raspberrypi/vchiq_core.h
similarity index 99%
rename from drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
rename to include/linux/raspberrypi/vchiq_core.h
index 9b4e766990a493d6e9d4e0604f2c84f4e7b77804..dbcb19e7a6d39b94967261c4ab23d6325e999249 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
+++ b/include/linux/raspberrypi/vchiq_core.h
@@ -15,7 +15,7 @@
 #include <linux/spinlock_types.h>
 #include <linux/wait.h>
 
-#include "../../include/linux/raspberrypi/vchiq.h"
+#include "vchiq.h"
 #include "vchiq_cfg.h"
 
 /* Do this so that we can test-build the code on non-rpi systems */
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_debugfs.h b/include/linux/raspberrypi/vchiq_debugfs.h
similarity index 100%
rename from drivers/staging/vc04_services/interface/vchiq_arm/vchiq_debugfs.h
rename to include/linux/raspberrypi/vchiq_debugfs.h

-- 
2.50.1


