Return-Path: <linux-kernel+bounces-880727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF93C266DD
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 18:43:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01A24467AA8
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 17:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22F76358D3A;
	Fri, 31 Oct 2025 17:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="jV94fz2B"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF06357A3A
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 17:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761931740; cv=none; b=b2bpYxA486kMUbjPQN7g8T1lzLsnsfPqXokB4blMweSiUB/zspvG0nkqwEeHsRGUQBZFGvKQ4QN5uVoi1eAhffvacvhPsxB4HyDwFHHrQcS1GhlpwYYO5cQQ3RU54GblagCn8ueQBpuACpKPChg8f1GyevVQDyv2hAdJ4rNGUZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761931740; c=relaxed/simple;
	bh=grQSPhX3M2C7APZ+VGWgSK9kwgE76L2fxhG0WwyognQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZBrtAtcNqEAU2ThzjizZP9ugrajTSMhrh+S8f89pkDHIh/KtCUR8HFSr1SwRIVOu5b3rv630GfyW4nG7G/5Gsesox4bYqROIsmxm0gat7blLJSczkUtAI/xRBVvhJ0yIm1O6KOmxJN+I5e4NwAac/+7sh8kq3UmxzUj30EO4nuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=jV94fz2B; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from mail.ideasonboard.com (unknown [IPv6:2401:4900:1c69:314e:ee86:ae6e:30:9d13])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 98BA41690;
	Fri, 31 Oct 2025 18:27:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1761931623;
	bh=grQSPhX3M2C7APZ+VGWgSK9kwgE76L2fxhG0WwyognQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=jV94fz2Byn15cicqeMule0DF1d1sY1iEKId9rlpgLBHM3vqgfPPzNS775WD5EWcPu
	 6bXDBcj8L+zTSRnNG3wIRKg9E44+0t+c5GiXW3R5QAmlGKB/CAZCmS1frAkWvqtjip
	 rL33XKMkSWRTm5BD1yP9/GyHedZpwaCe4UEgIHYs=
From: Jai Luthra <jai.luthra@ideasonboard.com>
Date: Fri, 31 Oct 2025 22:57:29 +0530
Subject: [PATCH 09/13] platform/raspberrypi: Add new vc-sm-cma driver
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251031-b4-vc-sm-cma-v1-9-0dd5c0ec3f5c@ideasonboard.com>
References: <20251031-b4-vc-sm-cma-v1-0-0dd5c0ec3f5c@ideasonboard.com>
In-Reply-To: <20251031-b4-vc-sm-cma-v1-0-0dd5c0ec3f5c@ideasonboard.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 bcm-kernel-feedback-list@broadcom.com
Cc: Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Phil Elwell <phil@raspberrypi.com>, Stefan Wahren <wahrenst@gmx.net>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Kieran Bingham <kieran.bingham@ideasonboard.com>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Jai Luthra <jai.luthra@ideasonboard.com>, Dom Cobley <popcornmix@gmail.com>, 
 Alexander Winkowski <dereference23@outlook.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Juerg Haefliger <juerg.haefliger@canonical.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=88084;
 i=jai.luthra@ideasonboard.com; h=from:subject:message-id;
 bh=j+UQKltJZS78gTzfXzY90CvKGz4glRg/+kKymXhlljc=;
 b=owEBbQKS/ZANAwAKAUPekfkkmnFFAcsmYgBpBPGcGnqQW4oi4u4Xlenodqc6iIVjSS3Swo9gr
 YB6fCHzdHuJAjMEAAEKAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCaQTxnAAKCRBD3pH5JJpx
 RfJbD/9dXk5YM8lIcHwXciCatZRy1VnQ7fJfJzdhCmTmBcbZGJWbG+WVktCQlTA47LLQUFtfjGJ
 dysyE7Z9Lk6AeTBExS4WH0dv951v9705HXELwk6jemsW/idbgrfvJs0dy/T07RnxOG6wKLlWbLJ
 n5GjVjpfZwFjt4uYexCT8gVe080xj3r48JipYGC254CrAzuuQjn0KqtrUyMIcKTG6UCSjfecgpb
 fA2U9VcSj2F6+s12kiBXnXKu2NqK+J6sMH7r00EjEPkRdKTHwwVX0z28vPbuSH/vplLCsJf3HZj
 gdeA8VmLI4iAZN3+fFDL686zVHyT1DsM8F/vNQOQdu9GtIw6Y+2VHKG71t+qLPGEVVQ4HpnKIcE
 xqOonmKZY0q09wfRwtjgGGqjjcEFYjyjXefeflBuUy6yrQ7BY1NYgIM/f/LD9LEadz2ES6VE2j6
 787JU2C4nhcJWgzyFWJClMlKb+WHKf3sdBBlo9x4VMz+hjgzXXcMuKQymYmQNpjh05FhGZra3PD
 jkagemiu2fMoLZyRlzeA2ZiScEJl2wh1jAoElsFvaSU/2k0f043KJfLeOvo1n1DwEnIwLAJmjdl
 Uh4viWuLgX2sHlpNRv0a5HxSOgW1IManfGrv6V13YFx3GLstJjNvp5Ns1KcBTBm586+wjFpYTXT
 i/Lrh6l44u505bg==
X-Developer-Key: i=jai.luthra@ideasonboard.com; a=openpgp;
 fpr=4DE0D818E5D575E8D45AAFC543DE91F9249A7145

From: Dave Stevenson <dave.stevenson@raspberrypi.com>

Add Broadcom VideoCore Shared Memory support.

This new driver allows contiguous memory blocks to be imported into the
VideoCore VPU memory map, and manages the lifetime of those objects,
only releasing the source dmabuf once the VPU has confirmed it has
finished with it.

Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>

staging: vcsm-cma: Fix memory leak from not detaching dmabuf

When importing there was a missing call to detach the buffer, so each
import leaked the sg table entry.

Actually the release process for both locally allocated and imported
buffers is identical, so fix them to both use the same
function.

Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>

staging/vc-sm-cma: Avoid log spamming on Pi0/1 over cache alias.

Pi 0/1 use the 0x80000000 cache alias as the ARM also sees the world
through the VPU L2 cache.
vc-sm-cma was trying to ensure it was in an uncached alias (0xc), and
complaining on every allocation if it weren't. Reduce this logging.

Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>

vc-sm-cma: Restore correct cache maintainance operations

We have been using the more expensive flush operations rather than
invalidate and clean since kernel rpi-5.9.y

These are exposed with:
52f1453513ba95084ab811a030032fe605b0cbe2 Re-expose some dmi APIs for use
in VCSM

But I believe that commit was dropped when (non-cma) vc-sm was dropped,
and didn't get updated when the commit was restored

Signed-off-by: Dom Cobley <popcornmix@gmail.com>

staging: vc04_services: Fix clang14 warning

Insert a break to fix a fallthrough warning from clang14. Since the
fallthrough was to another break, this is a cosmetic change.

See: https://github.com/raspberrypi/linux/issues/5078

Signed-off-by: Phil Elwell <phil@raspberrypi.com>

vc04_services/vc-sm-cma: Handle upstream require vchiq_instance to be
passed around

vc04_services/vc-sm-cma: Switch one-bit bitfields to bool

Clang 16 warns:

../drivers/staging/vc04_services/vc-sm-cma/vc_sm.c:816:19: warning:
implicit truncation from 'int' to a one-bit wide bit-field changes value
from 1 to -1 [-Wsingle-bit-bitfield-constant-conversion]
    buffer->imported = 1;
		     ^ ~
../drivers/staging/vc04_services/vc-sm-cma/vc_sm.c:822:17: warning:
implicit truncation from 'int' to a one-bit wide bit-field changes value
from 1 to -1 [-Wsingle-bit-bitfield-constant-conversion]
    buffer->in_use = 1;
		   ^ ~
2 warnings generated.

Signed-off-by: Alexander Winkowski <dereference23@outlook.com>

vc04_services: vcsm-cma: Detach from the correct dmabuf

Commit d3292daee319 ("dma-buf: Make locking consistent in
dma_buf_detach()")
added checking that the same dmabuf for which dma_buf_attach
was called is passed into dma_buf_detach, which flagged up
that vcsm-cma was passing in the wrong dmabuf.

Correct this so that we don't get the WARN on every dma_buf
release.

Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>

staging: vc04_services: vc-sm-cma: Remove deprecated header

The vchiq_connected.h header was removed in f875976ecf45 ("staging:
vc04_services: Drop vchiq_connected.[ch] files") to simplify the
implementation.

Update the vc_sm driver accordingly which can still use the same
functions through the vchiq_arm.h header declarations.

Signed-off-by: Kieran Bingham <kieran.bingham@ideasonboard.com>

staging: vc04_services: vc-sm-cma: Drop include Makefile directive

Drop the include directive. They can break the build, when one only
wants to build a subdirectory. Replace with "../" for the includes in
the vc_sm files instead.

The fix is equivalent to the four patches between 29d49a76c5b2
("staging: vc04_services: bcm2835-audio: Drop include Makefile
directive")...2529ca211402 ("staging: vc04_services: interface: Drop
include Makefile directive")

Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Kieran Bingham <kieran.bingham@ideasonboard.com>

staging: vc04_services: vc-sm-cma: Register with vchiq_bus_type

Register the vcsm rive with the vchiq_bus_type instead of useing the
platform driver/device.

Signed-off-by: Kieran Bingham <kieran.bingham@ideasonboard.com>

staging: vc04_services: vc-sm-cma: Explicitly set DMA mask

The platform model originally handled the DMA mask. Now that
we are on the vchiq_bus we need to explicitly set this.

Signed-off-by: Kieran Bingham <kieran.bingham@ideasonboard.com>

staging: vc04_services: vc-sm-cma: Use [map|unmap]_attachment_unlocked

lockdep throws warnings when using libcamera as buffers are
mapped and unmapped as the dmabuf->resv lock hasn't been taken.

Switch to using the _unlocked variants so that the framework takes
the lock.

https://github.com/raspberrypi/linux/issues/6814

Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>

staging: vc04_services: vc-sm-cma: Use a mutex instead of spinlock

There are no contexts where we should be calling the kernelid_map
IDR functions where we can't sleep, so switch from using a spinlock
to using a mutex.

https://github.com/raspberrypi/linux/issues/6815

Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>

staging: vc-sm-cma: Fix field-spanning write warning

Replace one-element array with flexible-array member to fix:

[   11.725017] ------------[ cut here ]------------
[   11.725038] memcpy: detected field-spanning write (size 4) of single field "hdr->body" at drivers/staging/vc04_services/vc-sm-cma/vc_sm_cma_vchi.c:130 (size 0)
[   11.725113] WARNING: CPU: 3 PID: 455 at drivers/staging/vc04_services/vc-sm-cma/vc_sm_cma_vchi.c:130 vc_vchi_cmd_create+0x1a8/0x1d0 [vc_sm_cma]

Signed-off-by: Juerg Haefliger <juerg.haefliger@canonical.com>

platform/raspberrypi: vc-sm-cma: Fix smatch warnings

Fix these two smatch warnings for the vc-sm-cma driver, rest were false
positives:

../drivers/platform/raspberrypi/vc-sm-cma/vc_sm.c:413
vc_sm_dma_buf_attach() warn: inconsistent returns '&buf->lock'.
  Locked on  : 396
  Unlocked on: 413
../drivers/platform/raspberrypi/vc-sm-cma/vc_sm.c:1225
vc_sm_cma_ioctl_alloc() error: we previously assumed 'buffer' could be
null (see line 1113)

Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
[jai.luthra: fix checkpatch and smatch warnings, add entry in MAINTAINERS]
Co-developed-by: Jai Luthra <jai.luthra@ideasonboard.com>
Signed-off-by: Jai Luthra <jai.luthra@ideasonboard.com>
---
 MAINTAINERS                                             |    7 +
 drivers/platform/raspberrypi/Kconfig                    |    2 +
 drivers/platform/raspberrypi/Makefile                   |    1 +
 drivers/platform/raspberrypi/vc-sm-cma/Kconfig          |    9 +
 drivers/platform/raspberrypi/vc-sm-cma/Makefile         |    9 +
 drivers/platform/raspberrypi/vc-sm-cma/vc_sm.c          | 1619 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/platform/raspberrypi/vc-sm-cma/vc_sm.h          |   83 ++++++
 drivers/platform/raspberrypi/vc-sm-cma/vc_sm_cma_vchi.c |  513 +++++++++++++++++++++++++++++++++++++
 drivers/platform/raspberrypi/vc-sm-cma/vc_sm_cma_vchi.h |   63 +++++
 drivers/platform/raspberrypi/vc-sm-cma/vc_sm_defs.h     |  298 +++++++++++++++++++++
 drivers/platform/raspberrypi/vc-sm-cma/vc_sm_knl.h      |   28 ++
 include/linux/raspberrypi/vc_sm_cma_ioctl.h             |  114 +++++++++
 12 files changed, 2746 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index df07d1a3c28d048e14a0f65c9f9ff01cc260013a..352c29bb3b94543bcb37c62d26d4c8bae48130ff 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5289,6 +5289,13 @@ L:	netdev@vger.kernel.org
 S:	Maintained
 F:	drivers/net/ethernet/broadcom/tg3.*
 
+BROADCOM VIDEOCORE SHARED MEMORY DRIVER
+M:	Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>
+L:	linux-kernel@vger.kernel.org
+S:	Maintained
+F:	drivers/platform/raspberrypi/vc-sm-cma/*
+F:	include/linux/raspberrypi/vc_sm_cma*
+
 BROADCOM VK DRIVER
 M:	Scott Branden <scott.branden@broadcom.com>
 R:	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
diff --git a/drivers/platform/raspberrypi/Kconfig b/drivers/platform/raspberrypi/Kconfig
index 2c928440a47c08e4d452fe838fe4105c608995a4..68a7a2d5701cd6821ec4b7418a86bf61011c83f6 100644
--- a/drivers/platform/raspberrypi/Kconfig
+++ b/drivers/platform/raspberrypi/Kconfig
@@ -48,5 +48,7 @@ config VCHIQ_CDEV
 endif
 
 source "drivers/platform/raspberrypi/vchiq-mmal/Kconfig"
+source "drivers/platform/raspberrypi/vc-sm-cma/Kconfig"
+
 
 endif
diff --git a/drivers/platform/raspberrypi/Makefile b/drivers/platform/raspberrypi/Makefile
index 2a7c9511e5d8bbe11c05680eea016ef40796b648..1980f618e2185228e1fe173b1e94a3ede0e15bbb 100644
--- a/drivers/platform/raspberrypi/Makefile
+++ b/drivers/platform/raspberrypi/Makefile
@@ -13,3 +13,4 @@ vchiq-objs += vchiq-interface/vchiq_dev.o
 endif
 
 obj-$(CONFIG_BCM2835_VCHIQ_MMAL)	+= vchiq-mmal/
+obj-$(CONFIG_BCM_VC_SM_CMA)		+= vc-sm-cma/
diff --git a/drivers/platform/raspberrypi/vc-sm-cma/Kconfig b/drivers/platform/raspberrypi/vc-sm-cma/Kconfig
new file mode 100644
index 0000000000000000000000000000000000000000..7daec14dcfc14b6a1492ca9e1670807b5b4f87d8
--- /dev/null
+++ b/drivers/platform/raspberrypi/vc-sm-cma/Kconfig
@@ -0,0 +1,9 @@
+config BCM_VC_SM_CMA
+	tristate "VideoCore Shared Memory (CMA) driver"
+	select BCM2835_VCHIQ
+	select DMA_SHARED_BUFFER
+	help
+	  Say Y here to enable the shared memory interface that
+	  supports sharing dmabufs with VideoCore.
+	  This operates over the VCHIQ interface to a service
+	  running on VideoCore.
diff --git a/drivers/platform/raspberrypi/vc-sm-cma/Makefile b/drivers/platform/raspberrypi/vc-sm-cma/Makefile
new file mode 100644
index 0000000000000000000000000000000000000000..c12c1a13165c18927ab03e8edde762bcb7f32c9b
--- /dev/null
+++ b/drivers/platform/raspberrypi/vc-sm-cma/Makefile
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0
+vc-sm-cma-$(CONFIG_BCM_VC_SM_CMA) := \
+	vc_sm.o vc_sm_cma_vchi.o
+
+obj-$(CONFIG_BCM_VC_SM_CMA) += vc-sm-cma.o
+
+ccflags-y += \
+	-D__VCCOREVER__=0
+
diff --git a/drivers/platform/raspberrypi/vc-sm-cma/vc_sm.c b/drivers/platform/raspberrypi/vc-sm-cma/vc_sm.c
new file mode 100644
index 0000000000000000000000000000000000000000..134a8fde7ebfc1325fcd2f5cc9b81ad48a22a802
--- /dev/null
+++ b/drivers/platform/raspberrypi/vc-sm-cma/vc_sm.c
@@ -0,0 +1,1619 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * VideoCore Shared Memory driver using CMA.
+ *
+ * Copyright: 2018, Raspberry Pi (Trading) Ltd
+ * Dave Stevenson <dave.stevenson@raspberrypi.org>
+ *
+ * Based on vmcs_sm driver from Broadcom Corporation for some API,
+ * and taking some code for buffer allocation and dmabuf handling from
+ * videobuf2.
+ *
+ *
+ * This driver has 3 main uses:
+ * 1) Allocating buffers for the kernel or userspace that can be shared with the
+ *    VPU.
+ * 2) Importing dmabufs from elsewhere for sharing with the VPU.
+ * 3) Allocating buffers for use by the VPU.
+ *
+ * In the first and second cases the native handle is a dmabuf. Releasing the
+ * resource inherently comes from releasing the dmabuf, and this will trigger
+ * unmapping on the VPU. The underlying allocation and our buffer structure are
+ * retained until the VPU has confirmed that it has finished with it.
+ *
+ * For the VPU allocations the VPU is responsible for triggering the release,
+ * and therefore the released message decrements the dma_buf refcount (with the
+ * VPU mapping having already been marked as released).
+ */
+
+/* ---- Include Files ----------------------------------------------------- */
+#include <linux/cacheflush.h>
+#include <linux/cdev.h>
+#include <linux/device.h>
+#include <linux/debugfs.h>
+#include <linux/dma-mapping.h>
+#include <linux/dma-buf.h>
+#include <linux/errno.h>
+#include <linux/fs.h>
+#include <linux/kernel.h>
+#include <linux/list.h>
+#include <linux/miscdevice.h>
+#include <linux/module.h>
+#include <linux/mm.h>
+#include <linux/of_device.h>
+#include <linux/proc_fs.h>
+#include <linux/raspberrypi/vchiq_arm.h>
+#include <linux/raspberrypi/vchiq_bus.h>
+#include <linux/raspberrypi/vc_sm_cma_ioctl.h>
+#include <linux/slab.h>
+#include <linux/seq_file.h>
+#include <linux/syscalls.h>
+#include <linux/types.h>
+
+#include "vc_sm_cma_vchi.h"
+
+#include "vc_sm.h"
+#include "vc_sm_knl.h"
+
+MODULE_IMPORT_NS("DMA_BUF");
+
+/* ---- Private Constants and Types --------------------------------------- */
+
+#define DEVICE_NAME		"vcsm-cma"
+#define DEVICE_MINOR		0
+
+#define VC_SM_RESOURCE_NAME_DEFAULT       "sm-host-resource"
+
+#define VC_SM_DIR_ROOT_NAME	"vcsm-cma"
+#define VC_SM_STATE		"state"
+
+/* Private file data associated with each opened device. */
+struct vc_sm_privdata_t {
+	pid_t pid;                      /* PID of creator. */
+
+	int restart_sys;		/* Tracks restart on interrupt. */
+	enum vc_sm_msg_type int_action;	/* Interrupted action. */
+	u32 int_trans_id;		/* Interrupted transaction. */
+};
+
+typedef int (*VC_SM_SHOW) (struct seq_file *s, void *v);
+struct sm_pde_t {
+	VC_SM_SHOW show;          /* Debug fs function hookup. */
+	struct dentry *dir_entry; /* Debug fs directory entry. */
+	void *priv_data;          /* Private data */
+};
+
+/* Global state information. */
+struct sm_state_t {
+	struct vchiq_device *device;
+
+	struct miscdevice misc_dev;
+
+	struct sm_instance *sm_handle;	/* Handle for videocore service. */
+
+	struct mutex kernelid_map_lock;	/* Mutex protecting kernelid_map */
+	struct idr kernelid_map;
+
+	struct mutex map_lock;          /* Global map lock. */
+	struct list_head buffer_list;	/* List of buffer. */
+
+	struct vc_sm_privdata_t *data_knl;  /* Kernel internal data tracking. */
+	struct vc_sm_privdata_t *vpu_allocs; /* All allocations from the VPU */
+	struct dentry *dir_root;	/* Debug fs entries root. */
+	struct sm_pde_t dir_state;	/* Debug fs entries state sub-tree. */
+
+	bool require_released_callback;	/* VPU will send a released msg when it
+					 * has finished with a resource.
+					 */
+	u32 int_trans_id;		/* Interrupted transaction. */
+	struct vchiq_instance *vchiq_instance;
+};
+
+struct vc_sm_dma_buf_attachment {
+	struct device *dev;
+	struct sg_table sg_table;
+	struct list_head list;
+	enum dma_data_direction	dma_dir;
+};
+
+/* ---- Private Variables ----------------------------------------------- */
+
+static struct sm_state_t *sm_state;
+static int sm_inited;
+
+/* ---- Private Function Prototypes -------------------------------------- */
+
+/* ---- Private Functions ------------------------------------------------ */
+
+static int get_kernel_id(struct vc_sm_buffer *buffer)
+{
+	int handle;
+
+	mutex_lock(&sm_state->kernelid_map_lock);
+	handle = idr_alloc(&sm_state->kernelid_map, buffer, 0, 0, GFP_KERNEL);
+	mutex_unlock(&sm_state->kernelid_map_lock);
+
+	return handle;
+}
+
+static struct vc_sm_buffer *lookup_kernel_id(int handle)
+{
+	return idr_find(&sm_state->kernelid_map, handle);
+}
+
+static void free_kernel_id(int handle)
+{
+	mutex_lock(&sm_state->kernelid_map_lock);
+	idr_remove(&sm_state->kernelid_map, handle);
+	mutex_unlock(&sm_state->kernelid_map_lock);
+}
+
+static int vc_sm_cma_seq_file_show(struct seq_file *s, void *v)
+{
+	struct sm_pde_t *sm_pde;
+
+	sm_pde = (struct sm_pde_t *)(s->private);
+
+	if (sm_pde && sm_pde->show)
+		sm_pde->show(s, v);
+
+	return 0;
+}
+
+static int vc_sm_cma_single_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, vc_sm_cma_seq_file_show, inode->i_private);
+}
+
+static const struct file_operations vc_sm_cma_debug_fs_fops = {
+	.open = vc_sm_cma_single_open,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = single_release,
+};
+
+static int vc_sm_cma_global_state_show(struct seq_file *s, void *v)
+{
+	struct vc_sm_buffer *resource = NULL;
+	int resource_count = 0;
+
+	if (!sm_state)
+		return 0;
+
+	seq_printf(s, "\nVC-ServiceHandle     %p\n", sm_state->sm_handle);
+
+	/* Log all applicable mapping(s). */
+
+	mutex_lock(&sm_state->map_lock);
+	seq_puts(s, "\nResources\n");
+	if (!list_empty(&sm_state->buffer_list)) {
+		list_for_each_entry(resource, &sm_state->buffer_list,
+				    global_buffer_list) {
+			resource_count++;
+
+			seq_printf(s, "\nResource                %p\n",
+				   resource);
+			seq_printf(s, "           NAME         %s\n",
+				   resource->name);
+			seq_printf(s, "           SIZE         %zu\n",
+				   resource->size);
+			seq_printf(s, "           DMABUF       %p\n",
+				   resource->dma_buf);
+			if (resource->imported) {
+				seq_printf(s, "           ATTACH       %p\n",
+					   resource->import.attach);
+				seq_printf(s, "           SGT          %p\n",
+					   resource->import.sgt);
+			} else {
+				seq_printf(s, "           SGT          %p\n",
+					   resource->alloc.sg_table);
+			}
+			seq_printf(s, "           DMA_ADDR     %pad\n",
+				   &resource->dma_addr);
+			seq_printf(s, "           VC_HANDLE     %08x\n",
+				   resource->vc_handle);
+			seq_printf(s, "           VC_MAPPING    %d\n",
+				   resource->vpu_state);
+		}
+	}
+	seq_printf(s, "\n\nTotal resource count:   %d\n\n", resource_count);
+
+	mutex_unlock(&sm_state->map_lock);
+
+	return 0;
+}
+
+/*
+ * Adds a buffer to the private data list which tracks all the allocated
+ * data.
+ */
+static void vc_sm_add_resource(struct vc_sm_privdata_t *privdata,
+			       struct vc_sm_buffer *buffer)
+{
+	mutex_lock(&sm_state->map_lock);
+	list_add(&buffer->global_buffer_list, &sm_state->buffer_list);
+	mutex_unlock(&sm_state->map_lock);
+
+	pr_debug("[%s]: added buffer %p (name %s, size %zu)\n",
+		 __func__, buffer, buffer->name, buffer->size);
+}
+
+/*
+ * Cleans up imported dmabuf.
+ * Should be called with mutex held.
+ */
+static void vc_sm_clean_up_dmabuf(struct vc_sm_buffer *buffer)
+{
+	if (!buffer->imported)
+		return;
+
+	/* Handle cleaning up imported dmabufs */
+	if (buffer->import.sgt) {
+		dma_buf_unmap_attachment_unlocked(buffer->import.attach,
+						  buffer->import.sgt,
+						  DMA_BIDIRECTIONAL);
+		buffer->import.sgt = NULL;
+	}
+	if (buffer->import.attach) {
+		dma_buf_detach(buffer->import.dma_buf, buffer->import.attach);
+		buffer->import.attach = NULL;
+	}
+}
+
+/*
+ * Instructs VPU to decrement the refcount on a buffer.
+ */
+static void vc_sm_vpu_free(struct vc_sm_buffer *buffer)
+{
+	if (buffer->vc_handle && buffer->vpu_state == VPU_MAPPED) {
+		struct vc_sm_free_t free = { buffer->vc_handle, 0 };
+		int status = vc_sm_cma_vchi_free(sm_state->sm_handle, &free,
+					     &sm_state->int_trans_id);
+		if (status != 0 && status != -EINTR) {
+			pr_err("[%s]: failed to free memory on videocore (status: %u, trans_id: %u)\n",
+			       __func__, status, sm_state->int_trans_id);
+		}
+
+		if (sm_state->require_released_callback) {
+			/* Need to wait for the VPU to confirm the free. */
+
+			/* Retain a reference on this until the VPU has
+			 * released it
+			 */
+			buffer->vpu_state = VPU_UNMAPPING;
+		} else {
+			buffer->vpu_state = VPU_NOT_MAPPED;
+			buffer->vc_handle = 0;
+		}
+	}
+}
+
+/*
+ * Release an allocation.
+ * All refcounting is done via the dma buf object.
+ *
+ * Must be called with the mutex held. The function will either release the
+ * mutex (if defering the release) or destroy it. The caller must therefore not
+ * reuse the buffer on return.
+ */
+static void vc_sm_release_resource(struct vc_sm_buffer *buffer)
+{
+	pr_debug("[%s]: buffer %p (name %s, size %zu), imported %u\n",
+		 __func__, buffer, buffer->name, buffer->size,
+		 buffer->imported);
+
+	if (buffer->vc_handle) {
+		/* We've sent the unmap request but not had the response. */
+		pr_debug("[%s]: Waiting for VPU unmap response on %p\n",
+			 __func__, buffer);
+		goto defer;
+	}
+	if (buffer->in_use) {
+		/* dmabuf still in use - we await the release */
+		pr_debug("[%s]: buffer %p is still in use\n", __func__, buffer);
+		goto defer;
+	}
+
+	/* Release the allocation (whether imported dmabuf or CMA allocation) */
+	if (buffer->imported) {
+		if (buffer->import.dma_buf)
+			dma_buf_put(buffer->import.dma_buf);
+		else
+			pr_err("%s: Imported dmabuf already been put for buf %p\n",
+			       __func__, buffer);
+		buffer->import.dma_buf = NULL;
+	} else {
+		dma_free_coherent(&sm_state->device->dev, buffer->size,
+				  buffer->cookie, buffer->dma_addr);
+	}
+
+	/* Free our buffer. Start by removing it from the list */
+	mutex_lock(&sm_state->map_lock);
+	list_del(&buffer->global_buffer_list);
+	mutex_unlock(&sm_state->map_lock);
+
+	pr_debug("%s: Release our allocation - done\n", __func__);
+	mutex_unlock(&buffer->lock);
+
+	mutex_destroy(&buffer->lock);
+
+	kfree(buffer);
+	return;
+
+defer:
+	mutex_unlock(&buffer->lock);
+}
+
+/* Create support for private data tracking. */
+static struct vc_sm_privdata_t *vc_sm_cma_create_priv_data(pid_t id)
+{
+	char alloc_name[32];
+	struct vc_sm_privdata_t *file_data = NULL;
+
+	/* Allocate private structure. */
+	file_data = kzalloc(sizeof(*file_data), GFP_KERNEL);
+
+	if (!file_data)
+		return NULL;
+
+	snprintf(alloc_name, sizeof(alloc_name), "%d", id);
+
+	file_data->pid = id;
+
+	return file_data;
+}
+
+/* Dma buf operations for use with our own allocations */
+
+static int vc_sm_dma_buf_attach(struct dma_buf *dmabuf,
+				struct dma_buf_attachment *attachment)
+
+{
+	struct vc_sm_dma_buf_attachment *a;
+	struct sg_table *sgt;
+	struct vc_sm_buffer *buf = dmabuf->priv;
+	struct scatterlist *rd, *wr;
+	int ret, i;
+
+	a = kzalloc(sizeof(*a), GFP_KERNEL);
+	if (!a)
+		return -ENOMEM;
+
+	pr_debug("%s dmabuf %p attachment %p\n", __func__, dmabuf, attachment);
+
+	mutex_lock(&buf->lock);
+
+	INIT_LIST_HEAD(&a->list);
+
+	sgt = &a->sg_table;
+
+	/* Copy the buf->base_sgt scatter list to the attachment, as we can't
+	 * map the same scatter list to multiple attachments at the same time.
+	 */
+	ret = sg_alloc_table(sgt, buf->alloc.sg_table->orig_nents, GFP_KERNEL);
+	if (ret) {
+		kfree(a);
+		mutex_unlock(&buf->lock);
+		return -ENOMEM;
+	}
+
+	rd = buf->alloc.sg_table->sgl;
+	wr = sgt->sgl;
+	for (i = 0; i < sgt->orig_nents; ++i) {
+		sg_set_page(wr, sg_page(rd), rd->length, rd->offset);
+		rd = sg_next(rd);
+		wr = sg_next(wr);
+	}
+
+	a->dma_dir = DMA_NONE;
+	attachment->priv = a;
+
+	list_add(&a->list, &buf->attachments);
+	mutex_unlock(&buf->lock);
+
+	return 0;
+}
+
+static void vc_sm_dma_buf_detach(struct dma_buf *dmabuf,
+				 struct dma_buf_attachment *attachment)
+{
+	struct vc_sm_dma_buf_attachment *a = attachment->priv;
+	struct vc_sm_buffer *buf = dmabuf->priv;
+	struct sg_table *sgt;
+
+	pr_debug("%s dmabuf %p attachment %p\n", __func__, dmabuf, attachment);
+	if (!a)
+		return;
+
+	sgt = &a->sg_table;
+
+	/* release the scatterlist cache */
+	if (a->dma_dir != DMA_NONE)
+		dma_unmap_sg(attachment->dev, sgt->sgl, sgt->orig_nents,
+			     a->dma_dir);
+	sg_free_table(sgt);
+
+	mutex_lock(&buf->lock);
+	list_del(&a->list);
+	mutex_unlock(&buf->lock);
+
+	kfree(a);
+}
+
+static struct sg_table *vc_sm_map_dma_buf(struct dma_buf_attachment *attachment,
+					  enum dma_data_direction direction)
+{
+	struct vc_sm_dma_buf_attachment *a = attachment->priv;
+	/* stealing dmabuf mutex to serialize map/unmap operations */
+	struct sg_table *table;
+
+	pr_debug("%s attachment %p\n", __func__, attachment);
+	table = &a->sg_table;
+
+	/* return previously mapped sg table */
+	if (a->dma_dir == direction)
+		return table;
+
+	/* release any previous cache */
+	if (a->dma_dir != DMA_NONE) {
+		dma_unmap_sg(attachment->dev, table->sgl, table->orig_nents,
+			     a->dma_dir);
+		a->dma_dir = DMA_NONE;
+	}
+
+	/* mapping to the client with new direction */
+	table->nents = dma_map_sg(attachment->dev, table->sgl,
+				  table->orig_nents, direction);
+	if (!table->nents) {
+		pr_err("failed to map scatterlist\n");
+		return ERR_PTR(-EIO);
+	}
+
+	a->dma_dir = direction;
+
+	pr_debug("%s attachment %p\n", __func__, attachment);
+	return table;
+}
+
+static void vc_sm_unmap_dma_buf(struct dma_buf_attachment *attachment,
+				struct sg_table *table,
+				enum dma_data_direction direction)
+{
+	pr_debug("%s attachment %p\n", __func__, attachment);
+	dma_unmap_sg(attachment->dev, table->sgl, table->nents, direction);
+}
+
+static int vc_sm_dmabuf_mmap(struct dma_buf *dmabuf, struct vm_area_struct *vma)
+{
+	struct vc_sm_buffer *buf = dmabuf->priv;
+	int ret;
+
+	pr_debug("%s dmabuf %p, buf %p, vm_start %08lX\n", __func__, dmabuf,
+		 buf, vma->vm_start);
+
+	/* now map it to userspace */
+	vma->vm_pgoff = 0;
+
+	ret = dma_mmap_coherent(&sm_state->device->dev, vma, buf->cookie,
+				buf->dma_addr, buf->size);
+
+	if (ret) {
+		pr_err("Remapping memory failed, error: %d\n", ret);
+		return ret;
+	}
+
+	vm_flags_reset(vma, vma->vm_flags | VM_DONTEXPAND | VM_DONTDUMP);
+
+	if (ret)
+		pr_err("%s: failure mapping buffer to userspace\n",
+		       __func__);
+
+	return ret;
+}
+
+static void vc_sm_dma_buf_release(struct dma_buf *dmabuf)
+{
+	struct vc_sm_buffer *buffer;
+
+	if (!dmabuf)
+		return;
+
+	buffer = (struct vc_sm_buffer *)dmabuf->priv;
+
+	mutex_lock(&buffer->lock);
+
+	pr_debug("%s dmabuf %p, buffer %p\n", __func__, dmabuf, buffer);
+
+	buffer->in_use = false;
+
+	/* Unmap on the VPU */
+	vc_sm_vpu_free(buffer);
+	pr_debug("%s vpu_free done\n", __func__);
+
+	/* Unmap our dma_buf object (the vc_sm_buffer remains until released
+	 * on the VPU).
+	 */
+	vc_sm_clean_up_dmabuf(buffer);
+	pr_debug("%s clean_up dmabuf done\n", __func__);
+
+	/* buffer->lock will be destroyed by vc_sm_release_resource if finished
+	 * with, otherwise unlocked. Do NOT unlock here.
+	 */
+	vc_sm_release_resource(buffer);
+	pr_debug("%s done\n", __func__);
+}
+
+static int vc_sm_dma_buf_begin_cpu_access(struct dma_buf *dmabuf,
+					  enum dma_data_direction direction)
+{
+	struct vc_sm_buffer *buf;
+	struct vc_sm_dma_buf_attachment *a;
+
+	if (!dmabuf)
+		return -EFAULT;
+
+	buf = dmabuf->priv;
+	if (!buf)
+		return -EFAULT;
+
+	mutex_lock(&buf->lock);
+
+	list_for_each_entry(a, &buf->attachments, list) {
+		dma_sync_sg_for_cpu(a->dev, a->sg_table.sgl,
+				    a->sg_table.nents, direction);
+	}
+	mutex_unlock(&buf->lock);
+
+	return 0;
+}
+
+static int vc_sm_dma_buf_end_cpu_access(struct dma_buf *dmabuf,
+					enum dma_data_direction direction)
+{
+	struct vc_sm_buffer *buf;
+	struct vc_sm_dma_buf_attachment *a;
+
+	if (!dmabuf)
+		return -EFAULT;
+	buf = dmabuf->priv;
+	if (!buf)
+		return -EFAULT;
+
+	mutex_lock(&buf->lock);
+
+	list_for_each_entry(a, &buf->attachments, list) {
+		dma_sync_sg_for_device(a->dev, a->sg_table.sgl,
+				       a->sg_table.nents, direction);
+	}
+	mutex_unlock(&buf->lock);
+
+	return 0;
+}
+
+static const struct dma_buf_ops dma_buf_ops = {
+	.map_dma_buf = vc_sm_map_dma_buf,
+	.unmap_dma_buf = vc_sm_unmap_dma_buf,
+	.mmap = vc_sm_dmabuf_mmap,
+	.release = vc_sm_dma_buf_release,
+	.attach = vc_sm_dma_buf_attach,
+	.detach = vc_sm_dma_buf_detach,
+	.begin_cpu_access = vc_sm_dma_buf_begin_cpu_access,
+	.end_cpu_access = vc_sm_dma_buf_end_cpu_access,
+};
+
+/* Dma_buf operations for chaining through to an imported dma_buf */
+
+static
+int vc_sm_import_dma_buf_attach(struct dma_buf *dmabuf,
+				struct dma_buf_attachment *attachment)
+{
+	struct vc_sm_buffer *buf = dmabuf->priv;
+
+	if (!buf->imported)
+		return -EINVAL;
+	return buf->import.dma_buf->ops->attach(buf->import.dma_buf,
+						attachment);
+}
+
+static
+void vc_sm_import_dma_buf_detatch(struct dma_buf *dmabuf,
+				  struct dma_buf_attachment *attachment)
+{
+	struct vc_sm_buffer *buf = dmabuf->priv;
+
+	if (!buf->imported)
+		return;
+	buf->import.dma_buf->ops->detach(buf->import.dma_buf, attachment);
+}
+
+static
+struct sg_table *vc_sm_import_map_dma_buf(struct dma_buf_attachment *attachment,
+					  enum dma_data_direction direction)
+{
+	struct vc_sm_buffer *buf = attachment->dmabuf->priv;
+
+	if (!buf->imported)
+		return NULL;
+	return buf->import.dma_buf->ops->map_dma_buf(attachment,
+						     direction);
+}
+
+static
+void vc_sm_import_unmap_dma_buf(struct dma_buf_attachment *attachment,
+				struct sg_table *table,
+				enum dma_data_direction direction)
+{
+	struct vc_sm_buffer *buf = attachment->dmabuf->priv;
+
+	if (!buf->imported)
+		return;
+	buf->import.dma_buf->ops->unmap_dma_buf(attachment, table, direction);
+}
+
+static
+int vc_sm_import_dmabuf_mmap(struct dma_buf *dmabuf, struct vm_area_struct *vma)
+{
+	struct vc_sm_buffer *buf = dmabuf->priv;
+
+	pr_debug("%s: mmap dma_buf %p, buf %p, imported db %p\n", __func__,
+		 dmabuf, buf, buf->import.dma_buf);
+	if (!buf->imported) {
+		pr_err("%s: mmap dma_buf %p- not an imported buffer\n",
+		       __func__, dmabuf);
+		return -EINVAL;
+	}
+	return buf->import.dma_buf->ops->mmap(buf->import.dma_buf, vma);
+}
+
+static
+int vc_sm_import_dma_buf_begin_cpu_access(struct dma_buf *dmabuf,
+					  enum dma_data_direction direction)
+{
+	struct vc_sm_buffer *buf = dmabuf->priv;
+
+	if (!buf->imported)
+		return -EINVAL;
+	return buf->import.dma_buf->ops->begin_cpu_access(buf->import.dma_buf,
+							  direction);
+}
+
+static
+int vc_sm_import_dma_buf_end_cpu_access(struct dma_buf *dmabuf,
+					enum dma_data_direction direction)
+{
+	struct vc_sm_buffer *buf = dmabuf->priv;
+
+	if (!buf->imported)
+		return -EINVAL;
+	return buf->import.dma_buf->ops->end_cpu_access(buf->import.dma_buf,
+							  direction);
+}
+
+static const struct dma_buf_ops dma_buf_import_ops = {
+	.map_dma_buf = vc_sm_import_map_dma_buf,
+	.unmap_dma_buf = vc_sm_import_unmap_dma_buf,
+	.mmap = vc_sm_import_dmabuf_mmap,
+	.release = vc_sm_dma_buf_release,
+	.attach = vc_sm_import_dma_buf_attach,
+	.detach = vc_sm_import_dma_buf_detatch,
+	.begin_cpu_access = vc_sm_import_dma_buf_begin_cpu_access,
+	.end_cpu_access = vc_sm_import_dma_buf_end_cpu_access,
+};
+
+/* Import a dma_buf to be shared with VC. */
+static int
+vc_sm_cma_import_dmabuf_internal(struct vc_sm_privdata_t *private,
+				 struct dma_buf *dma_buf,
+				 int fd,
+				 struct dma_buf **imported_buf)
+{
+	DEFINE_DMA_BUF_EXPORT_INFO(exp_info);
+	struct vc_sm_buffer *buffer = NULL;
+	struct vc_sm_import import = { };
+	struct vc_sm_import_result result = { };
+	struct dma_buf_attachment *attach = NULL;
+	struct sg_table *sgt = NULL;
+	dma_addr_t dma_addr;
+	u32 cache_alias;
+	int ret = 0;
+	int status;
+
+	/* Setup our allocation parameters */
+	pr_debug("%s: importing dma_buf %p/fd %d\n", __func__, dma_buf, fd);
+
+	if (fd < 0)
+		get_dma_buf(dma_buf);
+	else
+		dma_buf = dma_buf_get(fd);
+
+	if (!dma_buf)
+		return -EINVAL;
+
+	attach = dma_buf_attach(dma_buf, &sm_state->device->dev);
+	if (IS_ERR(attach)) {
+		ret = PTR_ERR(attach);
+		goto error;
+	}
+
+	sgt = dma_buf_map_attachment_unlocked(attach, DMA_BIDIRECTIONAL);
+	if (IS_ERR(sgt)) {
+		ret = PTR_ERR(sgt);
+		goto error;
+	}
+
+	/* Verify that the address block is contiguous */
+	if (sgt->nents != 1) {
+		ret = -ENOMEM;
+		goto error;
+	}
+
+	/* Allocate local buffer to track this allocation. */
+	buffer = kzalloc(sizeof(*buffer), GFP_KERNEL);
+	if (!buffer) {
+		ret = -ENOMEM;
+		goto error;
+	}
+
+	import.type = VC_SM_ALLOC_NON_CACHED;
+	dma_addr = sg_dma_address(sgt->sgl);
+	import.addr = (u32)dma_addr;
+	cache_alias = import.addr & 0xC0000000;
+	if (cache_alias != 0xC0000000 && cache_alias != 0x80000000) {
+		pr_err("%s: Expecting an uncached alias for dma_addr %pad\n",
+		       __func__, &dma_addr);
+		/* Note that this assumes we're on >= Pi2, but it implies a
+		 * DT configuration error.
+		 */
+		import.addr |= 0xC0000000;
+	}
+	import.size = sg_dma_len(sgt->sgl);
+	import.allocator = current->tgid;
+	import.kernel_id = get_kernel_id(buffer);
+
+	memcpy(import.name, VC_SM_RESOURCE_NAME_DEFAULT,
+	       sizeof(VC_SM_RESOURCE_NAME_DEFAULT));
+
+	pr_debug("[%s]: attempt to import \"%s\" data - type %u, addr %pad, size %u.\n",
+		 __func__, import.name, import.type, &dma_addr, import.size);
+
+	/* Allocate the videocore buffer. */
+	status = vc_sm_cma_vchi_import(sm_state->sm_handle, &import, &result,
+				       &sm_state->int_trans_id);
+	if (status == -EINTR) {
+		pr_debug("[%s]: requesting import memory action restart (trans_id: %u)\n",
+			 __func__, sm_state->int_trans_id);
+		ret = -ERESTARTSYS;
+		private->restart_sys = -EINTR;
+		private->int_action = VC_SM_MSG_TYPE_IMPORT;
+		goto error;
+	} else if (status || !result.res_handle) {
+		pr_debug("[%s]: failed to import memory on videocore (status: %u, trans_id: %u)\n",
+			 __func__, status, sm_state->int_trans_id);
+		ret = -ENOMEM;
+		goto error;
+	}
+
+	mutex_init(&buffer->lock);
+	INIT_LIST_HEAD(&buffer->attachments);
+	memcpy(buffer->name, import.name,
+	       min(sizeof(buffer->name), sizeof(import.name) - 1));
+
+	/* Keep track of the buffer we created. */
+	buffer->private = private;
+	buffer->vc_handle = result.res_handle;
+	buffer->size = import.size;
+	buffer->vpu_state = VPU_MAPPED;
+
+	buffer->imported = true;
+	buffer->import.dma_buf = dma_buf;
+
+	buffer->import.attach = attach;
+	buffer->import.sgt = sgt;
+	buffer->dma_addr = dma_addr;
+	buffer->in_use = true;
+	buffer->kernel_id = import.kernel_id;
+
+	/*
+	 * We're done - we need to export a new dmabuf chaining through most
+	 * functions, but enabling us to release our own internal references
+	 * here.
+	 */
+	exp_info.ops = &dma_buf_import_ops;
+	exp_info.size = import.size;
+	exp_info.flags = O_RDWR;
+	exp_info.priv = buffer;
+
+	buffer->dma_buf = dma_buf_export(&exp_info);
+	if (IS_ERR(buffer->dma_buf)) {
+		ret = PTR_ERR(buffer->dma_buf);
+		goto error;
+	}
+
+	vc_sm_add_resource(private, buffer);
+
+	*imported_buf = buffer->dma_buf;
+
+	return 0;
+
+error:
+	if (result.res_handle) {
+		struct vc_sm_free_t free = { result.res_handle, 0 };
+
+		vc_sm_cma_vchi_free(sm_state->sm_handle, &free,
+				    &sm_state->int_trans_id);
+	}
+	free_kernel_id(import.kernel_id);
+	kfree(buffer);
+	if (sgt)
+		dma_buf_unmap_attachment_unlocked(attach, sgt, DMA_BIDIRECTIONAL);
+	if (attach)
+		dma_buf_detach(dma_buf, attach);
+	dma_buf_put(dma_buf);
+	return ret;
+}
+
+static int vc_sm_cma_vpu_alloc(u32 size, u32 align, const char *name,
+			       u32 mem_handle, struct vc_sm_buffer **ret_buffer)
+{
+	DEFINE_DMA_BUF_EXPORT_INFO(exp_info);
+	struct vc_sm_buffer *buffer = NULL;
+	struct sg_table *sgt;
+	int aligned_size;
+	int ret = 0;
+
+	/* Align to the user requested align */
+	aligned_size = ALIGN(size, align);
+	/* and then to a page boundary */
+	aligned_size = PAGE_ALIGN(aligned_size);
+
+	if (!aligned_size)
+		return -EINVAL;
+
+	/* Allocate local buffer to track this allocation. */
+	buffer = kzalloc(sizeof(*buffer), GFP_KERNEL);
+	if (!buffer)
+		return -ENOMEM;
+
+	mutex_init(&buffer->lock);
+	/* Acquire the mutex as vc_sm_release_resource will release it in the
+	 * error path.
+	 */
+	mutex_lock(&buffer->lock);
+
+	buffer->cookie = dma_alloc_coherent(&sm_state->device->dev,
+					    aligned_size, &buffer->dma_addr,
+					    GFP_KERNEL);
+	if (!buffer->cookie) {
+		pr_err("[%s]: dma_alloc_coherent alloc of %d bytes failed\n",
+		       __func__, aligned_size);
+		ret = -ENOMEM;
+		goto error;
+	}
+
+	pr_debug("[%s]: alloc of %d bytes success\n",
+		 __func__, aligned_size);
+
+	sgt = kmalloc(sizeof(*sgt), GFP_KERNEL);
+	if (!sgt) {
+		ret = -ENOMEM;
+		goto error;
+	}
+
+	ret = dma_get_sgtable(&sm_state->device->dev, sgt, buffer->cookie,
+			      buffer->dma_addr, buffer->size);
+	if (ret < 0) {
+		pr_err("failed to get scatterlist from DMA API\n");
+		kfree(sgt);
+		ret = -ENOMEM;
+		goto error;
+	}
+	buffer->alloc.sg_table = sgt;
+
+	INIT_LIST_HEAD(&buffer->attachments);
+
+	memcpy(buffer->name, name,
+	       min(sizeof(buffer->name), strlen(name)));
+
+	exp_info.ops = &dma_buf_ops;
+	exp_info.size = aligned_size;
+	exp_info.flags = O_RDWR;
+	exp_info.priv = buffer;
+
+	buffer->dma_buf = dma_buf_export(&exp_info);
+	if (IS_ERR(buffer->dma_buf)) {
+		ret = PTR_ERR(buffer->dma_buf);
+		goto error;
+	}
+	buffer->dma_addr = (u32)sg_dma_address(buffer->alloc.sg_table->sgl);
+	if ((buffer->dma_addr & 0xC0000000) != 0xC0000000) {
+		pr_warn_once("%s: Expecting an uncached alias for dma_addr %pad\n",
+			     __func__, &buffer->dma_addr);
+		buffer->dma_addr |= 0xC0000000;
+	}
+	buffer->private = sm_state->vpu_allocs;
+
+	buffer->vc_handle = mem_handle;
+	buffer->vpu_state = VPU_MAPPED;
+	buffer->vpu_allocated = 1;
+	buffer->size = size;
+	/*
+	 * Create an ID that will be passed along with our message so
+	 * that when we service the release reply, we can look up which
+	 * resource is being released.
+	 */
+	buffer->kernel_id = get_kernel_id(buffer);
+
+	vc_sm_add_resource(sm_state->vpu_allocs, buffer);
+
+	mutex_unlock(&buffer->lock);
+
+	*ret_buffer = buffer;
+	return 0;
+error:
+	if (buffer)
+		vc_sm_release_resource(buffer);
+	return ret;
+}
+
+static void
+vc_sm_vpu_event(struct sm_instance *instance, struct vc_sm_result_t *reply,
+		int reply_len)
+{
+	switch (reply->trans_id & ~0x80000000) {
+	case VC_SM_MSG_TYPE_CLIENT_VERSION:
+	{
+		/* Acknowledge that the firmware supports the version command */
+		pr_debug("%s: firmware acked version msg. Require release cb\n",
+			 __func__);
+		sm_state->require_released_callback = true;
+	}
+	break;
+	case VC_SM_MSG_TYPE_RELEASED:
+	{
+		struct vc_sm_released *release = (struct vc_sm_released *)reply;
+		struct vc_sm_buffer *buffer =
+					lookup_kernel_id(release->kernel_id);
+		if (!buffer) {
+			pr_err("%s: VC released a buffer that is already released, kernel_id %d\n",
+			       __func__, release->kernel_id);
+			break;
+		}
+		mutex_lock(&buffer->lock);
+
+		pr_debug("%s: Released addr %08x, size %u, id %08x, mem_handle %08x\n",
+			 __func__, release->addr, release->size,
+			 release->kernel_id, release->vc_handle);
+
+		buffer->vc_handle = 0;
+		buffer->vpu_state = VPU_NOT_MAPPED;
+		free_kernel_id(release->kernel_id);
+
+		if (buffer->vpu_allocated) {
+			/* VPU allocation, so release the dmabuf which will
+			 * trigger the clean up.
+			 */
+			mutex_unlock(&buffer->lock);
+			dma_buf_put(buffer->dma_buf);
+		} else {
+			vc_sm_release_resource(buffer);
+		}
+	}
+	break;
+	case VC_SM_MSG_TYPE_VC_MEM_REQUEST:
+	{
+		struct vc_sm_buffer *buffer = NULL;
+		struct vc_sm_vc_mem_request *req =
+					(struct vc_sm_vc_mem_request *)reply;
+		struct vc_sm_vc_mem_request_result reply;
+		int ret;
+
+		pr_debug("%s: Request %u bytes of memory, align %d name %s, trans_id %08x\n",
+			 __func__, req->size, req->align, req->name,
+			 req->trans_id);
+		ret = vc_sm_cma_vpu_alloc(req->size, req->align, req->name,
+					  req->vc_handle, &buffer);
+
+		reply.trans_id = req->trans_id;
+		if (!ret) {
+			reply.addr = buffer->dma_addr;
+			reply.kernel_id = buffer->kernel_id;
+			pr_debug("%s: Allocated resource buffer %p, addr %pad\n",
+				 __func__, buffer, &buffer->dma_addr);
+		} else {
+			pr_err("%s: Allocation failed size %u, name %s, vc_handle %u\n",
+			       __func__, req->size, req->name, req->vc_handle);
+			reply.addr = 0;
+			reply.kernel_id = 0;
+		}
+		vc_sm_vchi_client_vc_mem_req_reply(sm_state->sm_handle, &reply,
+						   &sm_state->int_trans_id);
+		break;
+	}
+	break;
+	default:
+		pr_err("%s: Unknown vpu cmd %x\n", __func__, reply->trans_id);
+		break;
+	}
+}
+
+/* Userspace handling */
+/*
+ * Open the device.  Creates a private state to help track all allocation
+ * associated with this device.
+ */
+static int vc_sm_cma_open(struct inode *inode, struct file *file)
+{
+	/* Make sure the device was started properly. */
+	if (!sm_state) {
+		pr_err("[%s]: invalid device\n", __func__);
+		return -EPERM;
+	}
+
+	file->private_data = vc_sm_cma_create_priv_data(current->tgid);
+	if (!file->private_data) {
+		pr_err("[%s]: failed to create data tracker\n", __func__);
+
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+/*
+ * Close the vcsm-cma device.
+ * All allocations are file descriptors to the dmabuf objects, so we will get
+ * the clean up request on those as those are cleaned up.
+ */
+static int vc_sm_cma_release(struct inode *inode, struct file *file)
+{
+	struct vc_sm_privdata_t *file_data =
+	    (struct vc_sm_privdata_t *)file->private_data;
+	int ret = 0;
+
+	/* Make sure the device was started properly. */
+	if (!sm_state || !file_data) {
+		pr_err("[%s]: invalid device\n", __func__);
+		ret = -EPERM;
+		goto out;
+	}
+
+	pr_debug("[%s]: using private data %p\n", __func__, file_data);
+
+	/* Terminate the private data. */
+	kfree(file_data);
+
+out:
+	return ret;
+}
+
+/*
+ * Allocate a shared memory handle and block.
+ * Allocation is from CMA, and then imported into the VPU mappings.
+ */
+static int vc_sm_cma_ioctl_alloc(struct vc_sm_privdata_t *private,
+			  struct vc_sm_cma_ioctl_alloc *ioparam)
+{
+	DEFINE_DMA_BUF_EXPORT_INFO(exp_info);
+	struct vc_sm_buffer *buffer = NULL;
+	struct vc_sm_import import = { 0 };
+	struct vc_sm_import_result result = { 0 };
+	struct dma_buf *dmabuf = NULL;
+	struct sg_table *sgt;
+	int aligned_size;
+	int ret = 0;
+	int status;
+	int fd = -1;
+
+	aligned_size = PAGE_ALIGN(ioparam->size);
+
+	if (!aligned_size)
+		return -EINVAL;
+
+	/* Allocate local buffer to track this allocation. */
+	buffer = kzalloc(sizeof(*buffer), GFP_KERNEL);
+	if (!buffer) {
+		ret = -ENOMEM;
+		goto error;
+	}
+
+	buffer->cookie = dma_alloc_coherent(&sm_state->device->dev,
+					    aligned_size,
+					    &buffer->dma_addr,
+					    GFP_KERNEL);
+	if (!buffer->cookie) {
+		pr_err("[%s]: dma_alloc_coherent alloc of %d bytes failed\n",
+		       __func__, aligned_size);
+		ret = -ENOMEM;
+		goto error;
+	}
+
+	import.type = VC_SM_ALLOC_NON_CACHED;
+	import.allocator = current->tgid;
+
+	if (*ioparam->name)
+		memcpy(import.name, ioparam->name, sizeof(import.name) - 1);
+	else
+		memcpy(import.name, VC_SM_RESOURCE_NAME_DEFAULT,
+		       sizeof(VC_SM_RESOURCE_NAME_DEFAULT));
+
+	mutex_init(&buffer->lock);
+	INIT_LIST_HEAD(&buffer->attachments);
+	memcpy(buffer->name, import.name,
+	       min(sizeof(buffer->name), sizeof(import.name) - 1));
+
+	exp_info.ops = &dma_buf_ops;
+	exp_info.size = aligned_size;
+	exp_info.flags = O_RDWR;
+	exp_info.priv = buffer;
+
+	dmabuf = dma_buf_export(&exp_info);
+	if (IS_ERR(dmabuf)) {
+		ret = PTR_ERR(dmabuf);
+		goto error;
+	}
+	buffer->dma_buf = dmabuf;
+
+	import.addr = buffer->dma_addr;
+	import.size = aligned_size;
+	import.kernel_id = get_kernel_id(buffer);
+
+	/* Wrap it into a videocore buffer. */
+	status = vc_sm_cma_vchi_import(sm_state->sm_handle, &import, &result,
+				       &sm_state->int_trans_id);
+	if (status == -EINTR) {
+		pr_debug("[%s]: requesting import memory action restart (trans_id: %u)\n",
+			 __func__, sm_state->int_trans_id);
+		ret = -ERESTARTSYS;
+		private->restart_sys = -EINTR;
+		private->int_action = VC_SM_MSG_TYPE_IMPORT;
+		goto error;
+	} else if (status || !result.res_handle) {
+		pr_err("[%s]: failed to import memory on videocore (status: %u, trans_id: %u)\n",
+		       __func__, status, sm_state->int_trans_id);
+		ret = -ENOMEM;
+		goto error;
+	}
+
+	/* Keep track of the buffer we created. */
+	buffer->private = private;
+	buffer->vc_handle = result.res_handle;
+	buffer->size = import.size;
+	buffer->vpu_state = VPU_MAPPED;
+	buffer->kernel_id = import.kernel_id;
+
+	sgt = kmalloc(sizeof(*sgt), GFP_KERNEL);
+	if (!sgt) {
+		ret = -ENOMEM;
+		goto error;
+	}
+
+	ret = dma_get_sgtable(&sm_state->device->dev, sgt, buffer->cookie,
+			      buffer->dma_addr, buffer->size);
+	if (ret < 0) {
+		/* FIXME: error handling */
+		pr_err("failed to get scatterlist from DMA API\n");
+		kfree(sgt);
+		ret = -ENOMEM;
+		goto error;
+	}
+	buffer->alloc.sg_table = sgt;
+
+	fd = dma_buf_fd(dmabuf, O_CLOEXEC);
+	if (fd < 0)
+		goto error;
+
+	vc_sm_add_resource(private, buffer);
+
+	pr_debug("[%s]: Added resource as fd %d, buffer %p, private %p, dma_addr %pad\n",
+		 __func__, fd, buffer, private, &buffer->dma_addr);
+
+	/* We're done */
+	ioparam->handle = fd;
+	ioparam->vc_handle = buffer->vc_handle;
+	ioparam->dma_addr = buffer->dma_addr;
+	return 0;
+
+error:
+	pr_err("[%s]: something failed - cleanup. ret %d\n", __func__, ret);
+
+	if (dmabuf) {
+		/* dmabuf has been exported, therefore allow dmabuf cleanup to
+		 * deal with this
+		 */
+		dma_buf_put(dmabuf);
+	} else {
+		/* No dmabuf, therefore just free the buffer here */
+		if (buffer && buffer->cookie)
+			dma_free_coherent(&sm_state->device->dev, buffer->size,
+					  buffer->cookie, buffer->dma_addr);
+		kfree(buffer);
+	}
+	return ret;
+}
+
+static long vc_sm_cma_ioctl(struct file *file, unsigned int cmd,
+			    unsigned long arg)
+{
+	int ret = 0;
+	unsigned int cmdnr = _IOC_NR(cmd);
+	struct vc_sm_privdata_t *file_data =
+	    (struct vc_sm_privdata_t *)file->private_data;
+
+	/* Validate we can work with this device. */
+	if (!sm_state || !file_data) {
+		pr_err("[%s]: invalid device\n", __func__);
+		return -EPERM;
+	}
+
+	/* Action is a re-post of a previously interrupted action? */
+	if (file_data->restart_sys == -EINTR) {
+		pr_debug("[%s]: clean up of action %u (trans_id: %u) following EINTR\n",
+			 __func__, file_data->int_action,
+			 file_data->int_trans_id);
+
+		file_data->restart_sys = 0;
+	}
+
+	/* Now process the command. */
+	switch (cmdnr) {
+		/* New memory allocation.
+		 */
+	case VC_SM_CMA_CMD_ALLOC:
+	{
+		struct vc_sm_cma_ioctl_alloc ioparam;
+
+		/* Get the parameter data. */
+		if (copy_from_user
+		    (&ioparam, (void *)arg, sizeof(ioparam)) != 0) {
+			pr_err("[%s]: failed to copy-from-user for cmd %x\n",
+			       __func__, cmdnr);
+			ret = -EFAULT;
+			break;
+		}
+
+		ret = vc_sm_cma_ioctl_alloc(file_data, &ioparam);
+		if (!ret &&
+		    (copy_to_user((void *)arg, &ioparam,
+				  sizeof(ioparam)) != 0)) {
+			/* FIXME: Release allocation */
+			pr_err("[%s]: failed to copy-to-user for cmd %x\n",
+			       __func__, cmdnr);
+			ret = -EFAULT;
+		}
+		break;
+	}
+
+	case VC_SM_CMA_CMD_IMPORT_DMABUF:
+	{
+		struct vc_sm_cma_ioctl_import_dmabuf ioparam;
+		struct dma_buf *new_dmabuf;
+
+		/* Get the parameter data. */
+		if (copy_from_user
+		    (&ioparam, (void *)arg, sizeof(ioparam)) != 0) {
+			pr_err("[%s]: failed to copy-from-user for cmd %x\n",
+			       __func__, cmdnr);
+			ret = -EFAULT;
+			break;
+		}
+
+		ret = vc_sm_cma_import_dmabuf_internal(file_data,
+						       NULL,
+						       ioparam.dmabuf_fd,
+						       &new_dmabuf);
+
+		if (!ret) {
+			struct vc_sm_buffer *buf = new_dmabuf->priv;
+
+			ioparam.size = buf->size;
+			ioparam.handle = dma_buf_fd(new_dmabuf,
+						    O_CLOEXEC);
+			ioparam.vc_handle = buf->vc_handle;
+			ioparam.dma_addr = buf->dma_addr;
+
+			if (ioparam.handle < 0 ||
+			    (copy_to_user((void *)arg, &ioparam,
+					  sizeof(ioparam)) != 0)) {
+				dma_buf_put(new_dmabuf);
+				/* FIXME: Release allocation */
+				ret = -EFAULT;
+			}
+		}
+		break;
+	}
+
+	default:
+		pr_debug("[%s]: cmd %x tgid %u, owner %u\n", __func__, cmdnr,
+			 current->tgid, file_data->pid);
+
+		ret = -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+
+#ifdef CONFIG_COMPAT
+struct vc_sm_cma_ioctl_clean_invalid2_32 {
+	u32 op_count;
+	struct vc_sm_cma_ioctl_clean_invalid_block_32 {
+		u16 invalidate_mode;
+		u16 block_count;
+		compat_uptr_t start_address;
+		u32 block_size;
+		u32 inter_block_stride;
+	} s[];
+};
+
+#define VC_SM_CMA_CMD_CLEAN_INVALID2_32\
+	_IOR(VC_SM_CMA_MAGIC_TYPE, VC_SM_CMA_CMD_CLEAN_INVALID2,\
+	 struct vc_sm_cma_ioctl_clean_invalid2_32)
+
+static long vc_sm_cma_compat_ioctl(struct file *file, unsigned int cmd,
+				   unsigned long arg)
+{
+	switch (cmd) {
+	case VC_SM_CMA_CMD_CLEAN_INVALID2_32:
+		/* FIXME */
+		return -EINVAL;
+
+	default:
+		return vc_sm_cma_ioctl(file, cmd, arg);
+	}
+}
+#endif
+
+/* Device operations that we managed in this driver. */
+static const struct file_operations vc_sm_ops = {
+	.owner = THIS_MODULE,
+	.unlocked_ioctl = vc_sm_cma_ioctl,
+#ifdef CONFIG_COMPAT
+	.compat_ioctl = vc_sm_cma_compat_ioctl,
+#endif
+	.open = vc_sm_cma_open,
+	.release = vc_sm_cma_release,
+};
+
+/* Driver load/unload functions */
+/* Videocore connected.  */
+static void vc_sm_connected_init(void)
+{
+	int ret;
+	struct vc_sm_version version;
+	struct vc_sm_result_t version_result;
+
+	/*
+	 * Digging the vchiq_drv_mgmt, so low here and through a global seems
+	 * suspicious.
+	 *
+	 * The callbacks should be able to pass a parameter or context.
+	 */
+	struct vchiq_drv_mgmt *mgmt = dev_get_drvdata(sm_state->device->dev.parent);
+
+	pr_debug("[%s]: start\n", __func__);
+
+	/*
+	 * Initialize and create a VCHI connection for the shared memory service
+	 * running on videocore.
+	 */
+	ret = vchiq_initialise(&mgmt->state, &sm_state->vchiq_instance);
+	if (ret) {
+		pr_err("[%s]: failed to initialise VCHI instance (ret=%d)\n",
+		       __func__, ret);
+
+		return;
+	}
+
+	ret = vchiq_connect(sm_state->vchiq_instance);
+	if (ret) {
+		pr_err("[%s]: failed to connect VCHI instance (ret=%d)\n",
+		       __func__, ret);
+
+		return;
+	}
+
+	/* Initialize an instance of the shared memory service. */
+	sm_state->sm_handle = vc_sm_cma_vchi_init(sm_state->vchiq_instance, 1,
+						  vc_sm_vpu_event);
+	if (!sm_state->sm_handle) {
+		pr_err("[%s]: failed to initialize shared memory service\n",
+		       __func__);
+
+		return;
+	}
+
+	/* Create a debug fs directory entry (root). */
+	sm_state->dir_root = debugfs_create_dir(VC_SM_DIR_ROOT_NAME, NULL);
+
+	sm_state->dir_state.show = &vc_sm_cma_global_state_show;
+	sm_state->dir_state.dir_entry =
+		debugfs_create_file(VC_SM_STATE, 0444, sm_state->dir_root,
+				    &sm_state->dir_state,
+				    &vc_sm_cma_debug_fs_fops);
+
+	INIT_LIST_HEAD(&sm_state->buffer_list);
+
+	/* Create a shared memory device. */
+	sm_state->misc_dev.minor = MISC_DYNAMIC_MINOR;
+	sm_state->misc_dev.name = DEVICE_NAME;
+	sm_state->misc_dev.fops = &vc_sm_ops;
+	sm_state->misc_dev.parent = NULL;
+	/* Temporarily set as 666 until udev rules have been sorted */
+	sm_state->misc_dev.mode = 0666;
+	ret = misc_register(&sm_state->misc_dev);
+	if (ret) {
+		pr_err("vcsm-cma: failed to register misc device.\n");
+		goto err_remove_debugfs;
+	}
+
+	sm_state->data_knl = vc_sm_cma_create_priv_data(0);
+	if (!sm_state->data_knl) {
+		pr_err("[%s]: failed to create kernel private data tracker\n",
+		       __func__);
+		goto err_remove_misc_dev;
+	}
+
+	version.version = 2;
+	ret = vc_sm_cma_vchi_client_version(sm_state->sm_handle, &version,
+					    &version_result,
+					    &sm_state->int_trans_id);
+	if (ret) {
+		pr_err("[%s]: Failed to send version request %d\n", __func__,
+		       ret);
+	}
+
+	/* Done! */
+	sm_inited = 1;
+	pr_debug("[%s]: installed successfully\n", __func__);
+	return;
+
+err_remove_misc_dev:
+	misc_deregister(&sm_state->misc_dev);
+err_remove_debugfs:
+	debugfs_remove_recursive(sm_state->dir_root);
+	vc_sm_cma_vchi_stop(sm_state->vchiq_instance, &sm_state->sm_handle);
+}
+
+/* Driver loading. */
+static int bcm2835_vc_sm_cma_probe(struct vchiq_device *device)
+{
+	int err;
+
+	pr_info("%s: Videocore shared memory driver\n", __func__);
+
+	err = dma_set_mask_and_coherent(&device->dev, DMA_BIT_MASK(32));
+	if (err) {
+		dev_err(&device->dev, "dma_set_mask_and_coherent failed: %d\n",
+			err);
+		return err;
+	}
+
+	sm_state = devm_kzalloc(&device->dev, sizeof(*sm_state), GFP_KERNEL);
+	if (!sm_state)
+		return -ENOMEM;
+	sm_state->device = device;
+	mutex_init(&sm_state->map_lock);
+
+	mutex_init(&sm_state->kernelid_map_lock);
+	idr_init_base(&sm_state->kernelid_map, 1);
+
+	device->dev.dma_parms = devm_kzalloc(&device->dev,
+					     sizeof(*device->dev.dma_parms),
+					     GFP_KERNEL);
+	/* dma_set_max_seg_size checks if dma_parms is NULL. */
+	dma_set_max_seg_size(&device->dev, 0x3FFFFFFF);
+
+	vchiq_add_connected_callback(device, vc_sm_connected_init);
+	return 0;
+}
+
+/* Driver unloading. */
+static void bcm2835_vc_sm_cma_remove(struct vchiq_device *device)
+{
+	pr_debug("[%s]: start\n", __func__);
+	if (sm_inited) {
+		misc_deregister(&sm_state->misc_dev);
+
+		/* Remove all proc entries. */
+		debugfs_remove_recursive(sm_state->dir_root);
+
+		/* Stop the videocore shared memory service. */
+		vc_sm_cma_vchi_stop(sm_state->vchiq_instance, &sm_state->sm_handle);
+	}
+
+	if (sm_state) {
+		idr_destroy(&sm_state->kernelid_map);
+
+		/* Free the memory for the state structure. */
+		mutex_destroy(&sm_state->map_lock);
+	}
+
+	pr_debug("[%s]: end\n", __func__);
+}
+
+/* Kernel API calls */
+/* Get an internal resource handle mapped from the external one. */
+int vc_sm_cma_int_handle(void *handle)
+{
+	struct dma_buf *dma_buf = (struct dma_buf *)handle;
+	struct vc_sm_buffer *buf;
+
+	/* Validate we can work with this device. */
+	if (!sm_state || !handle) {
+		pr_err("[%s]: invalid input\n", __func__);
+		return 0;
+	}
+
+	buf = (struct vc_sm_buffer *)dma_buf->priv;
+	return buf->vc_handle;
+}
+EXPORT_SYMBOL_GPL(vc_sm_cma_int_handle);
+
+/* Free a previously allocated shared memory handle and block. */
+int vc_sm_cma_free(void *handle)
+{
+	struct dma_buf *dma_buf = (struct dma_buf *)handle;
+
+	/* Validate we can work with this device. */
+	if (!sm_state || !handle) {
+		pr_err("[%s]: invalid input\n", __func__);
+		return -EPERM;
+	}
+
+	pr_debug("%s: handle %p/dmabuf %p\n", __func__, handle, dma_buf);
+
+	dma_buf_put(dma_buf);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(vc_sm_cma_free);
+
+/* Import a dmabuf to be shared with VC. */
+int vc_sm_cma_import_dmabuf(struct dma_buf *src_dmabuf, void **handle)
+{
+	struct dma_buf *new_dma_buf;
+	int ret;
+
+	/* Validate we can work with this device. */
+	if (!sm_state || !src_dmabuf || !handle) {
+		pr_err("[%s]: invalid input\n", __func__);
+		return -EPERM;
+	}
+
+	ret = vc_sm_cma_import_dmabuf_internal(sm_state->data_knl, src_dmabuf,
+					       -1, &new_dma_buf);
+
+	if (!ret) {
+		pr_debug("%s: imported to ptr %p\n", __func__, new_dma_buf);
+
+		/* Assign valid handle at this time.*/
+		*handle = new_dma_buf;
+	} else {
+		/*
+		 * succeeded in importing the dma_buf, but then
+		 * failed to look it up again. How?
+		 * Release the fd again.
+		 */
+		pr_err("%s: imported vc_sm_cma_get_buffer failed %d\n",
+		       __func__, ret);
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(vc_sm_cma_import_dmabuf);
+
+static struct vchiq_driver bcm2835_vcsm_cma_driver = {
+	.probe = bcm2835_vc_sm_cma_probe,
+	.remove = bcm2835_vc_sm_cma_remove,
+	.driver = {
+		.name = DEVICE_NAME,
+		.owner = THIS_MODULE,
+	},
+};
+
+module_vchiq_driver(bcm2835_vcsm_cma_driver);
+
+MODULE_AUTHOR("Dave Stevenson");
+MODULE_DESCRIPTION("VideoCore CMA Shared Memory Driver");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("vcsm-cma");
diff --git a/drivers/platform/raspberrypi/vc-sm-cma/vc_sm.h b/drivers/platform/raspberrypi/vc-sm-cma/vc_sm.h
new file mode 100644
index 0000000000000000000000000000000000000000..aba4c0c0c7bb6688b24acc9f1ed00566341a28de
--- /dev/null
+++ b/drivers/platform/raspberrypi/vc-sm-cma/vc_sm.h
@@ -0,0 +1,83 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * VideoCore Shared Memory driver using CMA.
+ *
+ * Copyright: 2018, Raspberry Pi (Trading) Ltd
+ *
+ */
+
+#ifndef VC_SM_H
+#define VC_SM_H
+
+#include <linux/device.h>
+#include <linux/dma-direction.h>
+#include <linux/kref.h>
+#include <linux/mm_types.h>
+#include <linux/mutex.h>
+#include <linux/sched.h>
+#include <linux/shrinker.h>
+#include <linux/types.h>
+#include <linux/miscdevice.h>
+
+#define VC_SM_MAX_NAME_LEN 32
+
+enum vc_sm_vpu_mapping_state {
+	VPU_NOT_MAPPED,
+	VPU_MAPPED,
+	VPU_UNMAPPING
+};
+
+struct vc_sm_alloc_data {
+	unsigned long num_pages;
+	void *priv_virt;
+	struct sg_table *sg_table;
+};
+
+struct vc_sm_imported {
+	struct dma_buf *dma_buf;
+	struct dma_buf_attachment *attach;
+	struct sg_table *sgt;
+};
+
+struct vc_sm_buffer {
+	struct list_head global_buffer_list;	/* Global list of buffers. */
+
+	/* Index in the kernel_id idr so that we can find the
+	 * mmal_msg_context again when servicing the VCHI reply.
+	 */
+	int kernel_id;
+
+	size_t size;
+
+	/* Lock over all the following state for this buffer */
+	struct mutex lock;
+	struct list_head attachments;
+
+	char name[VC_SM_MAX_NAME_LEN];
+
+	bool in_use:1;   /* Kernel is still using this resource */
+	bool imported:1; /* Imported dmabuf */
+
+	enum vc_sm_vpu_mapping_state vpu_state;
+	u32 vc_handle;	/* VideoCore handle for this buffer */
+	int vpu_allocated;	/*
+				 * The VPU made this allocation. Release the
+				 * local dma_buf when the VPU releases the
+				 * resource.
+				 */
+
+	/* DMABUF related fields */
+	struct dma_buf *dma_buf;
+	dma_addr_t dma_addr;
+	void *cookie;
+
+	struct vc_sm_privdata_t *private;
+
+	union {
+		struct vc_sm_alloc_data alloc;
+		struct vc_sm_imported import;
+	};
+};
+
+#endif
diff --git a/drivers/platform/raspberrypi/vc-sm-cma/vc_sm_cma_vchi.c b/drivers/platform/raspberrypi/vc-sm-cma/vc_sm_cma_vchi.c
new file mode 100644
index 0000000000000000000000000000000000000000..cb21becd69fe5ea02aecfc8cda69aaadbaa1c76e
--- /dev/null
+++ b/drivers/platform/raspberrypi/vc-sm-cma/vc_sm_cma_vchi.c
@@ -0,0 +1,513 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * VideoCore Shared Memory CMA allocator
+ *
+ * Copyright: 2018, Raspberry Pi (Trading) Ltd
+ * Copyright 2011-2012 Broadcom Corporation.  All rights reserved.
+ *
+ * Based on vmcs_sm driver from Broadcom Corporation.
+ *
+ */
+
+/* ---- Include Files ----------------------------------------------------- */
+#include <linux/completion.h>
+#include <linux/kernel.h>
+#include <linux/kthread.h>
+#include <linux/list.h>
+#include <linux/mutex.h>
+#include <linux/semaphore.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+
+#include "vc_sm_cma_vchi.h"
+
+#define VC_SM_VER  1
+#define VC_SM_MIN_VER 0
+
+/* ---- Private Constants and Types -------------------------------------- */
+
+/* Command blocks come from a pool */
+#define SM_MAX_NUM_CMD_RSP_BLKS 32
+
+/* The number of supported connections */
+#define SM_MAX_NUM_CONNECTIONS 3
+
+struct sm_cmd_rsp_blk {
+	struct list_head head;	/* To create lists */
+	/* To be signaled when the response is there */
+	struct completion cmplt;
+
+	u32 id;
+	u16 length;
+
+	u8 msg[VC_SM_MAX_MSG_LEN];
+
+	uint32_t wait:1;
+	uint32_t sent:1;
+	uint32_t alloc:1;
+
+};
+
+struct sm_instance {
+	u32 num_connections;
+	unsigned int service_handle[SM_MAX_NUM_CONNECTIONS];
+	struct task_struct *io_thread;
+	struct completion io_cmplt;
+
+	vpu_event_cb vpu_event;
+
+	/* Mutex over the following lists */
+	struct mutex lock;
+	u32 trans_id;
+	struct list_head cmd_list;
+	struct list_head rsp_list;
+	struct list_head dead_list;
+
+	struct sm_cmd_rsp_blk free_blk[SM_MAX_NUM_CMD_RSP_BLKS];
+
+	/* Mutex over the free_list */
+	struct mutex free_lock;
+	struct list_head free_list;
+
+	struct semaphore free_sema;
+	struct vchiq_instance *vchiq_instance;
+};
+
+/* ---- Private Variables ------------------------------------------------ */
+
+/* ---- Private Function Prototypes -------------------------------------- */
+
+/* ---- Private Functions ------------------------------------------------ */
+static int
+bcm2835_vchi_msg_queue(struct vchiq_instance *vchiq_instance, unsigned int handle,
+		       void *data,
+		       unsigned int size)
+{
+	return vchiq_queue_kernel_message(vchiq_instance, handle, data, size);
+}
+
+static struct
+sm_cmd_rsp_blk *vc_vchi_cmd_create(struct sm_instance *instance,
+				   enum vc_sm_msg_type id, void *msg,
+				   u32 size, int wait)
+{
+	struct sm_cmd_rsp_blk *blk;
+	struct vc_sm_msg_hdr_t *hdr;
+
+	if (down_interruptible(&instance->free_sema)) {
+		blk = kmalloc(sizeof(*blk), GFP_KERNEL);
+		if (!blk)
+			return NULL;
+
+		blk->alloc = 1;
+		init_completion(&blk->cmplt);
+	} else {
+		mutex_lock(&instance->free_lock);
+		blk =
+		    list_first_entry(&instance->free_list,
+				     struct sm_cmd_rsp_blk, head);
+		list_del(&blk->head);
+		mutex_unlock(&instance->free_lock);
+	}
+
+	blk->sent = 0;
+	blk->wait = wait;
+	blk->length = sizeof(*hdr) + size;
+
+	hdr = (struct vc_sm_msg_hdr_t *)blk->msg;
+	hdr->type = id;
+	mutex_lock(&instance->lock);
+	instance->trans_id++;
+	/*
+	 * Retain the top bit for identifying asynchronous events, or VPU cmds.
+	 */
+	instance->trans_id &= ~0x80000000;
+	hdr->trans_id = instance->trans_id;
+	blk->id = instance->trans_id;
+	mutex_unlock(&instance->lock);
+
+	if (size)
+		memcpy(hdr->body, msg, size);
+
+	return blk;
+}
+
+static void
+vc_vchi_cmd_delete(struct sm_instance *instance, struct sm_cmd_rsp_blk *blk)
+{
+	if (blk->alloc) {
+		kfree(blk);
+		return;
+	}
+
+	mutex_lock(&instance->free_lock);
+	list_add(&blk->head, &instance->free_list);
+	mutex_unlock(&instance->free_lock);
+	up(&instance->free_sema);
+}
+
+static void vc_sm_cma_vchi_rx_ack(struct sm_instance *instance,
+				  struct sm_cmd_rsp_blk *cmd,
+				  struct vc_sm_result_t *reply,
+				  u32 reply_len)
+{
+	mutex_lock(&instance->lock);
+	list_for_each_entry(cmd,
+			    &instance->rsp_list,
+			    head) {
+		if (cmd->id == reply->trans_id)
+			break;
+	}
+	mutex_unlock(&instance->lock);
+
+	if (&cmd->head == &instance->rsp_list) {
+		//pr_debug("%s: received response %u, throw away...",
+		pr_err("%s: received response %u, throw away...",
+		       __func__,
+		       reply->trans_id);
+	} else if (reply_len > sizeof(cmd->msg)) {
+		pr_err("%s: reply too big (%u) %u, throw away...",
+		       __func__, reply_len,
+		     reply->trans_id);
+	} else {
+		memcpy(cmd->msg, reply,
+		       reply_len);
+		complete(&cmd->cmplt);
+	}
+}
+
+static int vc_sm_cma_vchi_videocore_io(void *arg)
+{
+	struct sm_instance *instance = arg;
+	struct sm_cmd_rsp_blk *cmd = NULL, *cmd_tmp;
+	struct vc_sm_result_t *reply;
+	struct vchiq_header *header;
+	s32 status;
+	int svc_use = 1;
+
+	while (1) {
+		if (svc_use)
+			vchiq_release_service(instance->vchiq_instance,
+					      instance->service_handle[0]);
+		svc_use = 0;
+
+		if (wait_for_completion_interruptible(&instance->io_cmplt))
+			continue;
+		vchiq_use_service(instance->vchiq_instance, instance->service_handle[0]);
+		svc_use = 1;
+
+		do {
+			/*
+			 * Get new command and move it to response list
+			 */
+			mutex_lock(&instance->lock);
+			if (list_empty(&instance->cmd_list)) {
+				/* no more commands to process */
+				mutex_unlock(&instance->lock);
+				break;
+			}
+			cmd = list_first_entry(&instance->cmd_list,
+					       struct sm_cmd_rsp_blk, head);
+			list_move(&cmd->head, &instance->rsp_list);
+			cmd->sent = 1;
+			mutex_unlock(&instance->lock);
+			/* Send the command */
+			status =
+				bcm2835_vchi_msg_queue(instance->vchiq_instance,
+						       instance->service_handle[0],
+						       cmd->msg, cmd->length);
+			if (status) {
+				pr_err("%s: failed to queue message (%d)",
+				       __func__, status);
+			}
+
+			/* If no reply is needed then we're done */
+			if (!cmd->wait) {
+				mutex_lock(&instance->lock);
+				list_del(&cmd->head);
+				mutex_unlock(&instance->lock);
+				vc_vchi_cmd_delete(instance, cmd);
+				continue;
+			}
+
+			if (status) {
+				complete(&cmd->cmplt);
+				continue;
+			}
+
+		} while (1);
+
+		while ((header = vchiq_msg_hold(instance->vchiq_instance,
+						instance->service_handle[0]))) {
+			reply = (struct vc_sm_result_t *)header->data;
+			if (reply->trans_id & 0x80000000) {
+				/* Async event or cmd from the VPU */
+				if (instance->vpu_event)
+					instance->vpu_event(instance, reply,
+							    header->size);
+			} else {
+				vc_sm_cma_vchi_rx_ack(instance, cmd, reply,
+						      header->size);
+			}
+
+			vchiq_release_message(instance->vchiq_instance,
+					      instance->service_handle[0],
+					      header);
+		}
+
+		/* Go through the dead list and free them */
+		mutex_lock(&instance->lock);
+		list_for_each_entry_safe(cmd, cmd_tmp, &instance->dead_list,
+					 head) {
+			list_del(&cmd->head);
+			vc_vchi_cmd_delete(instance, cmd);
+		}
+		mutex_unlock(&instance->lock);
+	}
+
+	return 0;
+}
+
+static int vc_sm_cma_vchi_callback(struct vchiq_instance *vchiq_instance,
+				   enum vchiq_reason reason,
+				   struct vchiq_header *header,
+				   unsigned int handle, void *userdata,
+				   void __user *cb_userdata)
+{
+	struct sm_instance *instance = vchiq_get_service_userdata(vchiq_instance, handle);
+
+	switch (reason) {
+	case VCHIQ_MESSAGE_AVAILABLE:
+		vchiq_msg_queue_push(vchiq_instance, handle, header);
+		complete(&instance->io_cmplt);
+		break;
+
+	case VCHIQ_SERVICE_CLOSED:
+		pr_info("%s: service CLOSED!!", __func__);
+		break;
+
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+struct sm_instance *vc_sm_cma_vchi_init(struct vchiq_instance *vchiq_instance,
+					unsigned int num_connections,
+					vpu_event_cb vpu_event)
+{
+	u32 i;
+	struct sm_instance *instance;
+	int status;
+
+	pr_debug("%s: start", __func__);
+
+	if (num_connections > SM_MAX_NUM_CONNECTIONS) {
+		pr_err("%s: unsupported number of connections %u (max=%u)",
+		       __func__, num_connections, SM_MAX_NUM_CONNECTIONS);
+
+		goto err_null;
+	}
+	/* Allocate memory for this instance */
+	instance = kzalloc(sizeof(*instance), GFP_KERNEL);
+
+	/* Misc initialisations */
+	mutex_init(&instance->lock);
+	init_completion(&instance->io_cmplt);
+	INIT_LIST_HEAD(&instance->cmd_list);
+	INIT_LIST_HEAD(&instance->rsp_list);
+	INIT_LIST_HEAD(&instance->dead_list);
+	INIT_LIST_HEAD(&instance->free_list);
+	sema_init(&instance->free_sema, SM_MAX_NUM_CMD_RSP_BLKS);
+	mutex_init(&instance->free_lock);
+	for (i = 0; i < SM_MAX_NUM_CMD_RSP_BLKS; i++) {
+		init_completion(&instance->free_blk[i].cmplt);
+		list_add(&instance->free_blk[i].head, &instance->free_list);
+	}
+
+	instance->vchiq_instance = vchiq_instance;
+
+	/* Open the VCHI service connections */
+	instance->num_connections = num_connections;
+	for (i = 0; i < num_connections; i++) {
+		struct vchiq_service_params_kernel params = {
+			.version = VC_SM_VER,
+			.version_min = VC_SM_MIN_VER,
+			.fourcc = VCHIQ_MAKE_FOURCC('S', 'M', 'E', 'M'),
+			.callback = vc_sm_cma_vchi_callback,
+			.userdata = instance,
+		};
+
+		status = vchiq_open_service(vchiq_instance, &params,
+					    &instance->service_handle[i]);
+		if (status) {
+			pr_err("%s: failed to open VCHI service (%d)",
+			       __func__, status);
+
+			goto err_close_services;
+		}
+	}
+	/* Create the thread which takes care of all io to/from videoocore. */
+	instance->io_thread = kthread_create(&vc_sm_cma_vchi_videocore_io,
+					     (void *)instance, "SMIO");
+	if (!instance->io_thread) {
+		pr_err("%s: failed to create SMIO thread", __func__);
+
+		goto err_close_services;
+	}
+	instance->vpu_event = vpu_event;
+	set_user_nice(instance->io_thread, -10);
+	wake_up_process(instance->io_thread);
+
+	pr_debug("%s: success - instance %p", __func__, instance);
+	return instance;
+
+err_close_services:
+	for (i = 0; i < instance->num_connections; i++) {
+		if (instance->service_handle[i])
+			vchiq_close_service(vchiq_instance, instance->service_handle[i]);
+	}
+	kfree(instance);
+err_null:
+	pr_debug("%s: FAILED", __func__);
+	return NULL;
+}
+
+int vc_sm_cma_vchi_stop(struct vchiq_instance *vchiq_instance, struct sm_instance **handle)
+{
+	struct sm_instance *instance;
+	u32 i;
+
+	if (!handle) {
+		pr_err("%s: invalid pointer to handle %p", __func__, handle);
+		goto lock;
+	}
+
+	if (!*handle) {
+		pr_err("%s: invalid handle %p", __func__, *handle);
+		goto lock;
+	}
+
+	instance = *handle;
+
+	/* Close all VCHI service connections */
+	for (i = 0; i < instance->num_connections; i++) {
+		vchiq_use_service(vchiq_instance, instance->service_handle[i]);
+		vchiq_close_service(vchiq_instance, instance->service_handle[i]);
+	}
+
+	kfree(instance);
+
+	*handle = NULL;
+	return 0;
+
+lock:
+	return -EINVAL;
+}
+
+static int vc_sm_cma_vchi_send_msg(struct sm_instance *handle,
+				   enum vc_sm_msg_type msg_id, void *msg,
+				   u32 msg_size, void *result, u32 result_size,
+				   u32 *cur_trans_id, u8 wait_reply)
+{
+	int status = 0;
+	struct sm_instance *instance = handle;
+	struct sm_cmd_rsp_blk *cmd_blk;
+
+	if (!handle) {
+		pr_err("%s: invalid handle", __func__);
+		return -EINVAL;
+	}
+	if (!msg) {
+		pr_err("%s: invalid msg pointer", __func__);
+		return -EINVAL;
+	}
+
+	cmd_blk =
+	    vc_vchi_cmd_create(instance, msg_id, msg, msg_size, wait_reply);
+	if (!cmd_blk) {
+		pr_err("[%s]: failed to allocate global tracking resource",
+		       __func__);
+		return -ENOMEM;
+	}
+
+	if (cur_trans_id)
+		*cur_trans_id = cmd_blk->id;
+
+	mutex_lock(&instance->lock);
+	list_add_tail(&cmd_blk->head, &instance->cmd_list);
+	mutex_unlock(&instance->lock);
+	complete(&instance->io_cmplt);
+
+	if (!wait_reply)
+		/* We're done */
+		return 0;
+
+	/* Wait for the response */
+	if (wait_for_completion_interruptible(&cmd_blk->cmplt)) {
+		mutex_lock(&instance->lock);
+		if (!cmd_blk->sent) {
+			list_del(&cmd_blk->head);
+			mutex_unlock(&instance->lock);
+			vc_vchi_cmd_delete(instance, cmd_blk);
+			return -ENXIO;
+		}
+
+		list_move(&cmd_blk->head, &instance->dead_list);
+		mutex_unlock(&instance->lock);
+		complete(&instance->io_cmplt);
+		return -EINTR;	/* We're done */
+	}
+
+	if (result && result_size) {
+		memcpy(result, cmd_blk->msg, result_size);
+	} else {
+		struct vc_sm_result_t *res =
+			(struct vc_sm_result_t *)cmd_blk->msg;
+		status = (res->success == 0) ? 0 : -ENXIO;
+	}
+
+	mutex_lock(&instance->lock);
+	list_del(&cmd_blk->head);
+	mutex_unlock(&instance->lock);
+	vc_vchi_cmd_delete(instance, cmd_blk);
+	return status;
+}
+
+int vc_sm_cma_vchi_free(struct sm_instance *handle, struct vc_sm_free_t *msg,
+			u32 *cur_trans_id)
+{
+	return vc_sm_cma_vchi_send_msg(handle, VC_SM_MSG_TYPE_FREE,
+				   msg, sizeof(*msg), 0, 0, cur_trans_id, 0);
+}
+
+int vc_sm_cma_vchi_import(struct sm_instance *handle, struct vc_sm_import *msg,
+			  struct vc_sm_import_result *result, u32 *cur_trans_id)
+{
+	return vc_sm_cma_vchi_send_msg(handle, VC_SM_MSG_TYPE_IMPORT,
+				   msg, sizeof(*msg), result, sizeof(*result),
+				   cur_trans_id, 1);
+}
+
+int vc_sm_cma_vchi_client_version(struct sm_instance *handle,
+				  struct vc_sm_version *msg,
+				  struct vc_sm_result_t *result,
+				  u32 *cur_trans_id)
+{
+	return vc_sm_cma_vchi_send_msg(handle, VC_SM_MSG_TYPE_CLIENT_VERSION,
+				   //msg, sizeof(*msg), result, sizeof(*result),
+				   //cur_trans_id, 1);
+				   msg, sizeof(*msg), NULL, 0,
+				   cur_trans_id, 0);
+}
+
+int vc_sm_vchi_client_vc_mem_req_reply(struct sm_instance *handle,
+				       struct vc_sm_vc_mem_request_result *msg,
+				       uint32_t *cur_trans_id)
+{
+	return vc_sm_cma_vchi_send_msg(handle,
+				       VC_SM_MSG_TYPE_VC_MEM_REQUEST_REPLY,
+				       msg, sizeof(*msg), 0, 0, cur_trans_id,
+				       0);
+}
diff --git a/drivers/platform/raspberrypi/vc-sm-cma/vc_sm_cma_vchi.h b/drivers/platform/raspberrypi/vc-sm-cma/vc_sm_cma_vchi.h
new file mode 100644
index 0000000000000000000000000000000000000000..a4f40d4cef0556e125cec4e8c31cdab44b0be4f2
--- /dev/null
+++ b/drivers/platform/raspberrypi/vc-sm-cma/vc_sm_cma_vchi.h
@@ -0,0 +1,63 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * VideoCore Shared Memory CMA allocator
+ *
+ * Copyright: 2018, Raspberry Pi (Trading) Ltd
+ * Copyright 2011-2012 Broadcom Corporation.  All rights reserved.
+ *
+ * Based on vmcs_sm driver from Broadcom Corporation.
+ *
+ */
+
+#ifndef __VC_SM_CMA_VCHI_H__INCLUDED__
+#define __VC_SM_CMA_VCHI_H__INCLUDED__
+
+#include <linux/raspberrypi/vchiq.h>
+
+#include "vc_sm_defs.h"
+
+/*
+ * Forward declare.
+ */
+struct sm_instance;
+
+typedef void (*vpu_event_cb)(struct sm_instance *instance,
+			     struct vc_sm_result_t *reply, int reply_len);
+
+/*
+ * Initialize the shared memory service, opens up vchi connection to talk to it.
+ */
+struct sm_instance *vc_sm_cma_vchi_init(struct vchiq_instance *vchi_instance,
+					unsigned int num_connections,
+					vpu_event_cb vpu_event);
+
+/*
+ * Terminates the shared memory service.
+ */
+int vc_sm_cma_vchi_stop(struct vchiq_instance *vchi_instance, struct sm_instance **handle);
+
+/*
+ * Ask the shared memory service to free up some memory that was previously
+ * allocated by the vc_sm_cma_vchi_alloc function call.
+ */
+int vc_sm_cma_vchi_free(struct sm_instance *handle, struct vc_sm_free_t *msg,
+			u32 *cur_trans_id);
+
+/*
+ * Import a contiguous block of memory and wrap it in a GPU MEM_HANDLE_T.
+ */
+int vc_sm_cma_vchi_import(struct sm_instance *handle, struct vc_sm_import *msg,
+			  struct vc_sm_import_result *result,
+			  u32 *cur_trans_id);
+
+int vc_sm_cma_vchi_client_version(struct sm_instance *handle,
+				  struct vc_sm_version *msg,
+				  struct vc_sm_result_t *result,
+				  u32 *cur_trans_id);
+
+int vc_sm_vchi_client_vc_mem_req_reply(struct sm_instance *handle,
+				       struct vc_sm_vc_mem_request_result *msg,
+				       uint32_t *cur_trans_id);
+
+#endif /* __VC_SM_CMA_VCHI_H__INCLUDED__ */
diff --git a/drivers/platform/raspberrypi/vc-sm-cma/vc_sm_defs.h b/drivers/platform/raspberrypi/vc-sm-cma/vc_sm_defs.h
new file mode 100644
index 0000000000000000000000000000000000000000..7cabbadfe7ca4b4ed3e74e07194d55294722380c
--- /dev/null
+++ b/drivers/platform/raspberrypi/vc-sm-cma/vc_sm_defs.h
@@ -0,0 +1,298 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * VideoCore Shared Memory CMA allocator
+ *
+ * Copyright: 2018, Raspberry Pi (Trading) Ltd
+ *
+ * Based on vc_sm_defs.h from the vmcs_sm driver Copyright Broadcom Corporation.
+ * All IPC messages are copied across to this file, even if the vc-sm-cma
+ * driver is not currently using them.
+ *
+ ****************************************************************************
+ */
+
+#ifndef __VC_SM_DEFS_H__INCLUDED__
+#define __VC_SM_DEFS_H__INCLUDED__
+
+#include <linux/types.h>
+
+/* Maximum message length */
+#define VC_SM_MAX_MSG_LEN (sizeof(union vc_sm_msg_union_t) + \
+	sizeof(struct vc_sm_msg_hdr_t))
+#define VC_SM_MAX_RSP_LEN (sizeof(union vc_sm_msg_union_t))
+
+/* Resource name maximum size */
+#define VC_SM_RESOURCE_NAME 32
+
+/*
+ * Version to be reported to the VPU
+ * VPU assumes 0 (aka 1) which does not require the released callback, nor
+ * expect the client to handle VC_MEM_REQUESTS.
+ * Version 2 requires the released callback, and must support VC_MEM_REQUESTS.
+ */
+#define VC_SM_PROTOCOL_VERSION	2
+
+enum vc_sm_msg_type {
+	/* Message types supported for HOST->VC direction */
+
+	/* Allocate shared memory block */
+	VC_SM_MSG_TYPE_ALLOC,
+	/* Lock allocated shared memory block */
+	VC_SM_MSG_TYPE_LOCK,
+	/* Unlock allocated shared memory block */
+	VC_SM_MSG_TYPE_UNLOCK,
+	/* Unlock allocated shared memory block, do not answer command */
+	VC_SM_MSG_TYPE_UNLOCK_NOANS,
+	/* Free shared memory block */
+	VC_SM_MSG_TYPE_FREE,
+	/* Resize a shared memory block */
+	VC_SM_MSG_TYPE_RESIZE,
+	/* Walk the allocated shared memory block(s) */
+	VC_SM_MSG_TYPE_WALK_ALLOC,
+
+	/* A previously applied action will need to be reverted */
+	VC_SM_MSG_TYPE_ACTION_CLEAN,
+
+	/*
+	 * Import a physical address and wrap into a MEM_HANDLE_T.
+	 * Release with VC_SM_MSG_TYPE_FREE.
+	 */
+	VC_SM_MSG_TYPE_IMPORT,
+	/*
+	 *Tells VC the protocol version supported by this client.
+	 * 2 supports the async/cmd messages from the VPU for final release
+	 * of memory, and for VC allocations.
+	 */
+	VC_SM_MSG_TYPE_CLIENT_VERSION,
+	/* Response to VC request for memory */
+	VC_SM_MSG_TYPE_VC_MEM_REQUEST_REPLY,
+
+	/*
+	 * Asynchronous/cmd messages supported for VC->HOST direction.
+	 * Signalled by setting the top bit in vc_sm_result_t trans_id.
+	 */
+
+	/*
+	 * VC has finished with an imported memory allocation.
+	 * Release any Linux reference counts on the underlying block.
+	 */
+	VC_SM_MSG_TYPE_RELEASED,
+	/* VC request for memory */
+	VC_SM_MSG_TYPE_VC_MEM_REQUEST,
+
+	VC_SM_MSG_TYPE_MAX
+};
+
+/* Type of memory to be allocated */
+enum vc_sm_alloc_type_t {
+	VC_SM_ALLOC_CACHED,
+	VC_SM_ALLOC_NON_CACHED,
+};
+
+/* Message header for all messages in HOST->VC direction */
+struct vc_sm_msg_hdr_t {
+	u32 type;
+	u32 trans_id;
+	u8 body[];
+};
+
+/* Request to allocate memory (HOST->VC) */
+struct vc_sm_alloc_t {
+	/* type of memory to allocate */
+	enum vc_sm_alloc_type_t type;
+	/* byte amount of data to allocate per unit */
+	u32 base_unit;
+	/* number of unit to allocate */
+	u32 num_unit;
+	/* alignment to be applied on allocation */
+	u32 alignment;
+	/* identity of who allocated this block */
+	u32 allocator;
+	/* resource name (for easier tracking on vc side) */
+	char name[VC_SM_RESOURCE_NAME];
+
+};
+
+/* Result of a requested memory allocation (VC->HOST) */
+struct vc_sm_alloc_result_t {
+	/* Transaction identifier */
+	u32 trans_id;
+
+	/* Resource handle */
+	u32 res_handle;
+	/* Pointer to resource buffer */
+	u32 res_mem;
+	/* Resource base size (bytes) */
+	u32 res_base_size;
+	/* Resource number */
+	u32 res_num;
+
+};
+
+/* Request to free a previously allocated memory (HOST->VC) */
+struct vc_sm_free_t {
+	/* Resource handle (returned from alloc) */
+	u32 res_handle;
+	/* Resource buffer (returned from alloc) */
+	u32 res_mem;
+
+};
+
+/* Request to lock a previously allocated memory (HOST->VC) */
+struct vc_sm_lock_unlock_t {
+	/* Resource handle (returned from alloc) */
+	u32 res_handle;
+	/* Resource buffer (returned from alloc) */
+	u32 res_mem;
+
+};
+
+/* Request to resize a previously allocated memory (HOST->VC) */
+struct vc_sm_resize_t {
+	/* Resource handle (returned from alloc) */
+	u32 res_handle;
+	/* Resource buffer (returned from alloc) */
+	u32 res_mem;
+	/* Resource *new* size requested (bytes) */
+	u32 res_new_size;
+
+};
+
+/* Result of a requested memory lock (VC->HOST) */
+struct vc_sm_lock_result_t {
+	/* Transaction identifier */
+	u32 trans_id;
+
+	/* Resource handle */
+	u32 res_handle;
+	/* Pointer to resource buffer */
+	u32 res_mem;
+	/*
+	 * Pointer to former resource buffer if the memory
+	 * was reallocated
+	 */
+	u32 res_old_mem;
+
+};
+
+/* Generic result for a request (VC->HOST) */
+struct vc_sm_result_t {
+	/* Transaction identifier */
+	u32 trans_id;
+
+	s32 success;
+
+};
+
+/* Request to revert a previously applied action (HOST->VC) */
+struct vc_sm_action_clean_t {
+	/* Action of interest */
+	enum vc_sm_msg_type res_action;
+	/* Transaction identifier for the action of interest */
+	u32 action_trans_id;
+
+};
+
+/* Request to remove all data associated with a given allocator (HOST->VC) */
+struct vc_sm_free_all_t {
+	/* Allocator identifier */
+	u32 allocator;
+};
+
+/* Request to import memory (HOST->VC) */
+struct vc_sm_import {
+	/* type of memory to allocate */
+	enum vc_sm_alloc_type_t type;
+	/* pointer to the VC (ie physical) address of the allocated memory */
+	u32 addr;
+	/* size of buffer */
+	u32 size;
+	/* opaque handle returned in RELEASED messages */
+	u32 kernel_id;
+	/* Allocator identifier */
+	u32 allocator;
+	/* resource name (for easier tracking on vc side) */
+	char     name[VC_SM_RESOURCE_NAME];
+};
+
+/* Result of a requested memory import (VC->HOST) */
+struct vc_sm_import_result {
+	/* Transaction identifier */
+	u32 trans_id;
+
+	/* Resource handle */
+	u32 res_handle;
+};
+
+/* Notification that VC has finished with an allocation (VC->HOST) */
+struct vc_sm_released {
+	/* cmd type / trans_id */
+	u32 cmd;
+
+	/* pointer to the VC (ie physical) address of the allocated memory */
+	u32 addr;
+	/* size of buffer */
+	u32 size;
+	/* opaque handle returned in RELEASED messages */
+	u32 kernel_id;
+	u32 vc_handle;
+};
+
+/*
+ * Client informing VC as to the protocol version it supports.
+ * >=2 requires the released callback, and supports VC asking for memory.
+ * Failure means that the firmware doesn't support this call, and therefore the
+ * client should either fail, or NOT rely on getting the released callback.
+ */
+struct vc_sm_version {
+	u32 version;
+};
+
+/* Request FROM VideoCore for some memory */
+struct vc_sm_vc_mem_request {
+	/* cmd type */
+	u32 cmd;
+
+	/* trans_id (from VPU) */
+	u32 trans_id;
+	/* size of buffer */
+	u32 size;
+	/* alignment of buffer */
+	u32 align;
+	/* resource name (for easier tracking) */
+	char     name[VC_SM_RESOURCE_NAME];
+	/* VPU handle for the resource */
+	u32 vc_handle;
+};
+
+/* Response from the kernel to provide the VPU with some memory */
+struct vc_sm_vc_mem_request_result {
+	/* Transaction identifier for the VPU */
+	u32 trans_id;
+	/* pointer to the physical address of the allocated memory */
+	u32 addr;
+	/* opaque handle returned in RELEASED messages */
+	u32 kernel_id;
+};
+
+/* Union of ALL messages */
+union vc_sm_msg_union_t {
+	struct vc_sm_alloc_t alloc;
+	struct vc_sm_alloc_result_t alloc_result;
+	struct vc_sm_free_t free;
+	struct vc_sm_lock_unlock_t lock_unlock;
+	struct vc_sm_action_clean_t action_clean;
+	struct vc_sm_resize_t resize;
+	struct vc_sm_lock_result_t lock_result;
+	struct vc_sm_result_t result;
+	struct vc_sm_free_all_t free_all;
+	struct vc_sm_import import;
+	struct vc_sm_import_result import_result;
+	struct vc_sm_version version;
+	struct vc_sm_released released;
+	struct vc_sm_vc_mem_request vc_request;
+	struct vc_sm_vc_mem_request_result vc_request_result;
+};
+
+#endif /* __VC_SM_DEFS_H__INCLUDED__ */
diff --git a/drivers/platform/raspberrypi/vc-sm-cma/vc_sm_knl.h b/drivers/platform/raspberrypi/vc-sm-cma/vc_sm_knl.h
new file mode 100644
index 0000000000000000000000000000000000000000..988fdd967922b75a3edcc5db67a1666f34c8fa93
--- /dev/null
+++ b/drivers/platform/raspberrypi/vc-sm-cma/vc_sm_knl.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * VideoCore Shared Memory CMA allocator
+ *
+ * Copyright: 2018, Raspberry Pi (Trading) Ltd
+ *
+ * Based on vc_sm_defs.h from the vmcs_sm driver Copyright Broadcom Corporation.
+ *
+ */
+
+#ifndef __VC_SM_KNL_H__INCLUDED__
+#define __VC_SM_KNL_H__INCLUDED__
+
+#if !defined(__KERNEL__)
+#error "This interface is for kernel use only..."
+#endif
+
+/* Free a previously allocated or imported shared memory handle and block. */
+int vc_sm_cma_free(void *handle);
+
+/* Get an internal resource handle mapped from the external one. */
+int vc_sm_cma_int_handle(void *handle);
+
+/* Import a block of memory into the GPU space. */
+int vc_sm_cma_import_dmabuf(struct dma_buf *dmabuf, void **handle);
+
+#endif /* __VC_SM_KNL_H__INCLUDED__ */
diff --git a/include/linux/raspberrypi/vc_sm_cma_ioctl.h b/include/linux/raspberrypi/vc_sm_cma_ioctl.h
new file mode 100644
index 0000000000000000000000000000000000000000..e43bb2e76dfffb50cf0ec955f9b805fc840b91ab
--- /dev/null
+++ b/include/linux/raspberrypi/vc_sm_cma_ioctl.h
@@ -0,0 +1,114 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * Copyright 2019 Raspberry Pi (Trading) Ltd.  All rights reserved.
+ *
+ * Based on vmcs_sm_ioctl.h Copyright Broadcom Corporation.
+ */
+
+#ifndef __VC_SM_CMA_IOCTL_H
+#define __VC_SM_CMA_IOCTL_H
+
+/* ---- Include Files ---------------------------------------------------- */
+
+#if defined(__KERNEL__)
+#include <linux/types.h>	/* Needed for standard types */
+#else
+#include <stdint.h>
+#endif
+
+#include <linux/ioctl.h>
+
+/* ---- Constants and Types ---------------------------------------------- */
+
+#define VC_SM_CMA_RESOURCE_NAME               32
+#define VC_SM_CMA_RESOURCE_NAME_DEFAULT       "sm-host-resource"
+
+/* Type define used to create unique IOCTL number */
+#define VC_SM_CMA_MAGIC_TYPE                  'J'
+
+/* IOCTL commands on /dev/vc-sm-cma */
+enum vc_sm_cma_cmd_e {
+	VC_SM_CMA_CMD_ALLOC = 0x5A,	/* Start at 0x5A arbitrarily */
+
+	VC_SM_CMA_CMD_IMPORT_DMABUF,
+
+	VC_SM_CMA_CMD_CLEAN_INVALID2,
+
+	VC_SM_CMA_CMD_LAST	/* Do not delete */
+};
+
+/* Cache type supported, conveniently matches the user space definition in
+ * user-vcsm.h.
+ */
+enum vc_sm_cma_cache_e {
+	VC_SM_CMA_CACHE_NONE,
+	VC_SM_CMA_CACHE_HOST,
+	VC_SM_CMA_CACHE_VC,
+	VC_SM_CMA_CACHE_BOTH,
+};
+
+/* IOCTL Data structures */
+struct vc_sm_cma_ioctl_alloc {
+	/* user -> kernel */
+	__u32 size;
+	__u32 num;
+	__u32 cached;		/* enum vc_sm_cma_cache_e */
+	__u32 pad;
+	__u8 name[VC_SM_CMA_RESOURCE_NAME];
+
+	/* kernel -> user */
+	__s32 handle;
+	__u32 vc_handle;
+	__u64 dma_addr;
+};
+
+struct vc_sm_cma_ioctl_import_dmabuf {
+	/* user -> kernel */
+	__s32 dmabuf_fd;
+	__u32 cached;		/* enum vc_sm_cma_cache_e */
+	__u8 name[VC_SM_CMA_RESOURCE_NAME];
+
+	/* kernel -> user */
+	__s32 handle;
+	__u32 vc_handle;
+	__u32 size;
+	__u32 pad;
+	__u64 dma_addr;
+};
+
+/*
+ * Cache functions to be set to struct vc_sm_cma_ioctl_clean_invalid2
+ * invalidate_mode.
+ */
+#define VC_SM_CACHE_OP_NOP       0x00
+#define VC_SM_CACHE_OP_INV       0x01
+#define VC_SM_CACHE_OP_CLEAN     0x02
+#define VC_SM_CACHE_OP_FLUSH     0x03
+
+struct vc_sm_cma_ioctl_clean_invalid2 {
+	__u32 op_count;
+	__u32 pad;
+	struct vc_sm_cma_ioctl_clean_invalid_block {
+		__u32 invalidate_mode;
+		__u32 block_count;
+		void *  __user start_address;
+		__u32 block_size;
+		__u32 inter_block_stride;
+	} s[];
+};
+
+/* IOCTL numbers */
+#define VC_SM_CMA_IOCTL_MEM_ALLOC\
+	_IOR(VC_SM_CMA_MAGIC_TYPE, VC_SM_CMA_CMD_ALLOC,\
+	 struct vc_sm_cma_ioctl_alloc)
+
+#define VC_SM_CMA_IOCTL_MEM_IMPORT_DMABUF\
+	_IOR(VC_SM_CMA_MAGIC_TYPE, VC_SM_CMA_CMD_IMPORT_DMABUF,\
+	 struct vc_sm_cma_ioctl_import_dmabuf)
+
+#define VC_SM_CMA_IOCTL_MEM_CLEAN_INVALID2\
+	_IOR(VC_SM_CMA_MAGIC_TYPE, VC_SM_CMA_CMD_CLEAN_INVALID2,\
+	 struct vc_sm_cma_ioctl_clean_invalid2)
+
+#endif /* __VC_SM_CMA_IOCTL_H */

-- 
2.51.0


