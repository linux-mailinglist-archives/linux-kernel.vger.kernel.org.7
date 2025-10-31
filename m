Return-Path: <linux-kernel+bounces-880728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6723FC26666
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 18:38:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6070460F37
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 17:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 115C131BC96;
	Fri, 31 Oct 2025 17:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="nTNNG1FM"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48FEE358D04
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 17:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761931743; cv=none; b=sO+W59p0FVBMxa2RdNEM57pDz6Av04CCw35Qpo3Wr04Jjrw2C5ke583HiJkP05p0/9o4728+jTReucE9GbsP35/ZHSJ6qfQ5mCQiWtNgjEtuCXjmQhb1HItexGcvLnbQKQEa06/GAkiFEMkyEikube8UuLQh89fBe1uZ8eMnIxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761931743; c=relaxed/simple;
	bh=U1r0nv5AXygGMHYcKigeFLaG8n4Xm2MMN1SRS4hoeyw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jnPBKe7LWChCvT/x0OEDz4n3kthTsckQAwK/sJNdSRod3MqciA7FLriErDT1WM8MD7CQXMFIiZa/AemQ09TM/0o6taYoiCr5r6YOvBg3QuhEyoruNMzCD5aKm8ZnFKpUGNuHfJNjgPmWec+LQQ3mZKPdWC9Xb/9brQjZYKNfHF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=nTNNG1FM; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from mail.ideasonboard.com (unknown [IPv6:2401:4900:1c69:314e:ee86:ae6e:30:9d13])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id B6C2D153F;
	Fri, 31 Oct 2025 18:27:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1761931629;
	bh=U1r0nv5AXygGMHYcKigeFLaG8n4Xm2MMN1SRS4hoeyw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=nTNNG1FM2zgGSzRXaFvLucUi75VvZ2uvC/EszDkGVml1QISKRmL5fqgeHqhg6CUex
	 XdjQ1iWDoWBIdZjz1E9ifa8UGW9x44L+Kw8shIZXerMZo0+dBkHyZ592UdY+eWdIlb
	 dw4Ld0aYfY7lmhfm6PWyCcHi+as1uX6waMZ3gYy4=
From: Jai Luthra <jai.luthra@ideasonboard.com>
Date: Fri, 31 Oct 2025 22:57:30 +0530
Subject: [PATCH 10/13] platform/raspberrypi: vchiq-mmal: Use vc-sm-cma to
 support zero copy
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251031-b4-vc-sm-cma-v1-10-0dd5c0ec3f5c@ideasonboard.com>
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
 Jai Luthra <jai.luthra@ideasonboard.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6627;
 i=jai.luthra@ideasonboard.com; h=from:subject:message-id;
 bh=KDZDtOhXem1yRuj7hrgmvwIXzDdN3L/y3Nt8Pyh7uA4=;
 b=owEBbQKS/ZANAwAKAUPekfkkmnFFAcsmYgBpBPGdtXvKBuOM6wX4NA/G4afVFB8/czUATffgD
 BAE7Lbf6QeJAjMEAAEKAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCaQTxnQAKCRBD3pH5JJpx
 Rd6KEACOsBycJdEJ60ZiBxbt/2wiVGKvhO+ug0UJN2OFrTX2GBMYGOII4eDXr5xLHOMKHmKxd1F
 h7CGPWWeZtMNsbRqlCkvdw5ZCEqv/VF3p1YF6ECiv3x01sZnYhsVgpT3mI7h4Arz53ziXQIX9up
 7XthqUdx2MhjqgoyFGjRryDC+y5vSWwXwyrxFjWxprDdhfZM5Q0e/HjuLb8RBbebsfknG4qpS/E
 6iUsIaPXZi2gso/e1/VVPPSYfpe/WvZ6D3fN50w/Zg3AQ2LekZFCq6kPBjPMCTTqqtTZYJGz86H
 SFoDDVq53t/l9uhCLnbWWmt0/xVDKpG2G6NxJ7aEVcY7h27TLtnIBgIA7U4TCV1qBmLB8nP5Uno
 zIpnxptIquyHlomXUdiqkH1iKmBsF5YHzZUH3kMOiMIIpx2uV4oFWVwSGEe9eE6ID/Z17xf0yny
 qyIhcp2XiiNLaEghJHG5Jzmg75rD58uzwHX8bqR00cNoq1XslaQtbb/ZyBgddJ1GRxnpGYv+Fgt
 THJWKPzMbscEF2ivWNfci1ezD7tCsEVOMAez1X9JVxdeseFdbJdX/XQrr648YG2KGASXeY2Xeco
 xu0M0XvBCgK8KyUMjPC+/QmpxuMmb7CoS16IPtZZweVtEJdEGnmpLcNEn9dVhENw5tUwBGkgzR3
 d3a1PKw/8VScq6A==
X-Developer-Key: i=jai.luthra@ideasonboard.com; a=openpgp;
 fpr=4DE0D818E5D575E8D45AAFC543DE91F9249A7145

From: Dave Stevenson <dave.stevenson@raspberrypi.com>

With the vc-sm-cma driver we can support zero copy of buffers between
the kernel and VPU. Add this support to mmal-vchiq.

Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
Signed-off-by: Jai Luthra <jai.luthra@ideasonboard.com>
---
 drivers/platform/raspberrypi/vchiq-mmal/Kconfig       |  3 ++-
 drivers/platform/raspberrypi/vchiq-mmal/mmal-common.h |  4 ++++
 drivers/platform/raspberrypi/vchiq-mmal/mmal-vchiq.c  | 66 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 drivers/platform/raspberrypi/vchiq-mmal/mmal-vchiq.h  |  1 +
 4 files changed, 71 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/raspberrypi/vchiq-mmal/Kconfig b/drivers/platform/raspberrypi/vchiq-mmal/Kconfig
index c99525a0bb4525d497c74984b8b44a9079279b6f..5df9198cdab1786353aeab287f83ea7f0630b317 100644
--- a/drivers/platform/raspberrypi/vchiq-mmal/Kconfig
+++ b/drivers/platform/raspberrypi/vchiq-mmal/Kconfig
@@ -1,6 +1,7 @@
 config BCM2835_VCHIQ_MMAL
 	tristate "BCM2835 MMAL VCHIQ service"
-	depends on BCM2835_VCHIQ
+	select BCM2835_VCHIQ
+	select BCM_VC_SM_CMA
 	help
 	  Enables the MMAL API over VCHIQ interface as used for the
 	  majority of the multimedia services on VideoCore.
diff --git a/drivers/platform/raspberrypi/vchiq-mmal/mmal-common.h b/drivers/platform/raspberrypi/vchiq-mmal/mmal-common.h
index 0443be8198ea57fcd66d598ef7a46309d82ec7b7..a643cad54b1200a4c8bda9ea1228da54298b2862 100644
--- a/drivers/platform/raspberrypi/vchiq-mmal/mmal-common.h
+++ b/drivers/platform/raspberrypi/vchiq-mmal/mmal-common.h
@@ -50,6 +50,10 @@ struct mmal_buffer {
 
 	struct mmal_msg_context *msg_context;
 
+	struct dma_buf *dma_buf;/* Exported dmabuf fd from videobuf2 */
+	void *vcsm_handle;	/* VCSM handle having imported the dmabuf */
+	u32 vc_handle;		/* VC handle to that dmabuf */
+
 	u32 cmd;		/* MMAL command. 0=data. */
 	unsigned long length;
 	u32 mmal_flags;
diff --git a/drivers/platform/raspberrypi/vchiq-mmal/mmal-vchiq.c b/drivers/platform/raspberrypi/vchiq-mmal/mmal-vchiq.c
index 3c99d0f3e57178761ec57d97cd77e59aa26143fa..02fbf061c171cba287657266aa1731333609b3b0 100644
--- a/drivers/platform/raspberrypi/vchiq-mmal/mmal-vchiq.c
+++ b/drivers/platform/raspberrypi/vchiq-mmal/mmal-vchiq.c
@@ -29,9 +29,12 @@
 #include <linux/raspberrypi/vchiq_arm.h>
 
 #include "mmal-common.h"
+#include "mmal-parameters.h"
 #include "mmal-vchiq.h"
 #include "mmal-msg.h"
 
+#include "../vc-sm-cma/vc_sm_knl.h"
+
 /*
  * maximum number of components supported.
  * This matches the maximum permitted by default on the VPU
@@ -418,8 +421,13 @@ buffer_from_host(struct vchiq_mmal_instance *instance,
 
 	/* buffer header */
 	m.u.buffer_from_host.buffer_header.cmd = 0;
-	m.u.buffer_from_host.buffer_header.data =
-		(u32)(unsigned long)buf->buffer;
+	if (port->zero_copy) {
+		m.u.buffer_from_host.buffer_header.data = buf->vc_handle;
+	} else {
+		m.u.buffer_from_host.buffer_header.data =
+			(u32)(unsigned long)buf->buffer;
+	}
+
 	m.u.buffer_from_host.buffer_header.alloc_size = buf->buffer_size;
 	if (port->type == MMAL_PORT_TYPE_OUTPUT) {
 		m.u.buffer_from_host.buffer_header.length = 0;
@@ -585,6 +593,22 @@ static void buffer_to_host_cb(struct vchiq_mmal_instance *instance,
 
 		msg_context->u.bulk.status = msg->h.status;
 
+	} else if (msg->u.buffer_from_host.is_zero_copy) {
+		/*
+		 * Zero copy buffer, so nothing to do.
+		 * Copy buffer info and make callback.
+		 */
+		msg_context->u.bulk.buffer_used =
+				msg->u.buffer_from_host.buffer_header.length;
+		msg_context->u.bulk.mmal_flags =
+				msg->u.buffer_from_host.buffer_header.flags;
+		msg_context->u.bulk.dts =
+				msg->u.buffer_from_host.buffer_header.dts;
+		msg_context->u.bulk.pts =
+				msg->u.buffer_from_host.buffer_header.pts;
+		msg_context->u.bulk.cmd =
+				msg->u.buffer_from_host.buffer_header.cmd;
+
 	} else if (msg->u.buffer_from_host.buffer_header.length == 0) {
 		/* empty buffer */
 		if (msg->u.buffer_from_host.buffer_header.flags &
@@ -1531,6 +1555,9 @@ int vchiq_mmal_port_parameter_set(struct vchiq_mmal_instance *instance,
 
 	mutex_unlock(&instance->vchiq_mutex);
 
+	if (parameter == MMAL_PARAMETER_ZERO_COPY && !ret)
+		port->zero_copy = !!(*(bool *)value);
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(vchiq_mmal_port_parameter_set);
@@ -1699,6 +1726,31 @@ int vchiq_mmal_submit_buffer(struct vchiq_mmal_instance *instance,
 	unsigned long flags = 0;
 	int ret;
 
+	/*
+	 * We really want to do this in mmal_vchi_buffer_init but can't as
+	 * videobuf2 won't let us have the dmabuf there.
+	 */
+	if (port->zero_copy && buffer->dma_buf && !buffer->vcsm_handle) {
+		pr_debug("%s: import dmabuf %p\n", __func__, buffer->dma_buf);
+		ret = vc_sm_cma_import_dmabuf(buffer->dma_buf,
+					      &buffer->vcsm_handle);
+		if (ret) {
+			pr_err("%s: vc_sm_import_dmabuf_fd failed, ret %d\n",
+			       __func__, ret);
+			return ret;
+		}
+
+		buffer->vc_handle = vc_sm_cma_int_handle(buffer->vcsm_handle);
+		if (!buffer->vc_handle) {
+			pr_err("%s: vc_sm_int_handle failed %d\n",
+			       __func__, ret);
+			vc_sm_cma_free(buffer->vcsm_handle);
+			return ret;
+		}
+		pr_debug("%s: import dmabuf %p - got vc handle %08X\n",
+			 __func__, buffer->dma_buf, buffer->vc_handle);
+	}
+
 	ret = buffer_from_host(instance, port, buffer);
 	if (ret == -EINVAL) {
 		/* Port is disabled. Queue for when it is enabled. */
@@ -1732,6 +1784,16 @@ int mmal_vchi_buffer_cleanup(struct mmal_buffer *buf)
 		release_msg_context(msg_context);
 	buf->msg_context = NULL;
 
+	if (buf->vcsm_handle) {
+		int ret;
+
+		pr_debug("%s: vc_sm_cma_free on handle %p\n", __func__,
+			 buf->vcsm_handle);
+		ret = vc_sm_cma_free(buf->vcsm_handle);
+		if (ret)
+			pr_err("%s: vcsm_free failed, ret %d\n", __func__, ret);
+		buf->vcsm_handle = 0;
+	}
 	return 0;
 }
 EXPORT_SYMBOL_GPL(mmal_vchi_buffer_cleanup);
diff --git a/drivers/platform/raspberrypi/vchiq-mmal/mmal-vchiq.h b/drivers/platform/raspberrypi/vchiq-mmal/mmal-vchiq.h
index 190a0f42bd6b22c7493463da94c094265d85d8fa..ae9e26a3b05b9b640ecd6844990a776d27354185 100644
--- a/drivers/platform/raspberrypi/vchiq-mmal/mmal-vchiq.h
+++ b/drivers/platform/raspberrypi/vchiq-mmal/mmal-vchiq.h
@@ -49,6 +49,7 @@ typedef void (*vchiq_mmal_buffer_cb)(struct vchiq_mmal_instance  *instance,
 
 struct vchiq_mmal_port {
 	bool enabled;
+	u32 zero_copy:1;
 	u32 handle;
 	u32 type; /* port type, cached to use on port info set */
 	u32 index; /* port index, cached to use on port info set */

-- 
2.51.0


