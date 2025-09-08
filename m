Return-Path: <linux-kernel+bounces-806023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B45FB490EB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 16:12:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A06F168BEC
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 14:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA6EE30CD84;
	Mon,  8 Sep 2025 14:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VcOozVcB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAEF330C621
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 14:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757340755; cv=none; b=BvOjhOt7n9ZXXulU2NVXUInCSt9cjSGhpetcW+lArJY0Q1sQgbIQRcxVy7AdbRvTJ+8MBpKnM60iI7zEJretP1MX+C4ST58NSIq8ptRx3VTdaPbUogwNuq+LWcxt47CHNxYTQoFW94Jqwfv1O6kpriuVl2SPqd765cDQek7BwEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757340755; c=relaxed/simple;
	bh=HfqvfZeLfi+bEBIro6O7LDFCF6bFYj3y/jMjtcnOp60=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wgw5LP3iGKAebO0nSzp5nOVc5q0Rh1E9cMZoYyYf8cy34u/2IB0amdDHod0dqRjW7QxFlEqAsXVASTCJeRkoruEVK/GmCy0IsG4BD/vgbq9IQMPVYmVRaiS6+HQXH8WNl5KEvNfv5FlYs+76KSfWLH0SDkOV9AD4qyFvN9SW/18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VcOozVcB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757340752;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MgO2S+dmEWRWP646lE3n7lNOg/USWSkUqgEwQKZIUMA=;
	b=VcOozVcB05NJs8Digszf9SxD4Gz1cXxeWw+3JlD29rZZlb0r08cHvxlWrjeHhvXCeGK4j7
	XdL320nCDpdZzmqmibJeIWVIZvkdiK/jPA3BL54NnPxepviwAZ9ktab4g4I9rLAfnDRBdf
	Bo3dhh91kHnSlzMJMmZiFk9O01tolEM=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-196-XwrmWLPuOdqxaH-DS1Uv0A-1; Mon, 08 Sep 2025 10:12:31 -0400
X-MC-Unique: XwrmWLPuOdqxaH-DS1Uv0A-1
X-Mimecast-MFC-AGG-ID: XwrmWLPuOdqxaH-DS1Uv0A_1757340750
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-329cb4c3f78so4580989a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 07:12:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757340750; x=1757945550;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MgO2S+dmEWRWP646lE3n7lNOg/USWSkUqgEwQKZIUMA=;
        b=lLgAKv1/kO2/nyH29LZ5jCHwIfPQX90JS7g/tL6CDqSpNwQ19m8+S280QT0x/wqY8d
         yz0Y7/O8+0/GdYEXW+WKSDTRNTlwSEKptPbligb7KG6rINmtBu3w5tszdam8it2XaEs/
         VH3yOkyF3H9eGy7hcVd1NnTCjzM+FugfhY7kn7bHt3oC2MfEM80uqenLyGhTi9Bj+I01
         t2dbbPGaIl8eLhOuysND9tLQgBBx3V1BfiKzEkmyume7p4/ab/dn/ZdDDOJGTdBVq4eR
         zt3+GBlR4Kl25V/zPWjsBXyuV8LHViEKonin7tPVFGs0KYJuGFEWSIiR7P3+n55+2b7B
         1KrQ==
X-Forwarded-Encrypted: i=1; AJvYcCXgFslFMuahGC8tCC+/UAkBAT49Gygw9TQn7PEpOfNUSeDfFHA80luzzzfte41rOKMFzBpdu8w1mI+pZ+U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyD55A7Qi2N1xDabfG13zChFmtY39om7PSQkjfwHY0VXvx+ZNpj
	ON3O3+dH1NjDxlVVs2+5BYt4BudgnnmvI465Nr5hS73WPnMyFrt3GiRluorLtbziiapZJEZv7KY
	QyQS7RLF0YLheKuR5IXM834uecp+7rvR50StM9JVSKEKXOoFAcQpEBxRGarFAOgz42w==
X-Gm-Gg: ASbGncsncOJsTYkC2PFbe/rPXxOLodo+0o3vQhVlLfG5bR66T664WZ/S4+vBZ0OSIPU
	CRVBalGMGtgCpU5UBUIeLZmbg0MCbKbZ610dPEYUgfjb2XdL6fqMnHcx1bUPridCH06k2/Ti/10
	rSkkiBCELCh1S9Eya6/391ajcLMQHKhokS5dTMyN0andwUkpNlEcYwG7m0Ht+p0zG1EK0kOdKH1
	+n+ifmcGDLrpQQZuERW3cyCEHGRX6D+NQaEGYMLMeB3Y9RVQMNM95EbUBIEkz9a7MqHvKKKdDJ5
	bAD31qISR+BdgU2ZILN1DiPONAQbxxGAHwo=
X-Received: by 2002:a17:90b:3852:b0:32b:55b1:445 with SMTP id 98e67ed59e1d1-32d43f5a5bbmr12171479a91.21.1757340750031;
        Mon, 08 Sep 2025 07:12:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE1RN07Q/Groy3ce2bkRYfYtXEA9rVHjb/aUmYiI3bQ8kQWmXsh4jbs+BJMTypC4h2EiBkEmw==
X-Received: by 2002:a17:90b:3852:b0:32b:55b1:445 with SMTP id 98e67ed59e1d1-32d43f5a5bbmr12171433a91.21.1757340749565;
        Mon, 08 Sep 2025 07:12:29 -0700 (PDT)
Received: from zeus ([2405:6580:83a0:7600:6e93:a15a:9134:ae1f])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32d89f32ebfsm2937596a91.0.2025.09.08.07.12.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 07:12:28 -0700 (PDT)
From: Ryosuke Yasuoka <ryasuoka@redhat.com>
To: zack.rusin@broadcom.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	ian.forbes@broadcom.com,
	jfalempe@redhat.com
Cc: Ryosuke Yasuoka <ryasuoka@redhat.com>,
	bcm-kernel-feedback-list@broadcom.com,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH drm-misc-next v2 1/1] drm/vmwgfx: add drm_panic support for stdu
Date: Mon,  8 Sep 2025 23:11:34 +0900
Message-ID: <20250908141152.221291-2-ryasuoka@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250908141152.221291-1-ryasuoka@redhat.com>
References: <20250908141152.221291-1-ryasuoka@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add drm_panic module for vmwgfx stdu so that panic screen can be
displayed on panic.

Signed-off-by: Ryosuke Yasuoka <ryasuoka@redhat.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_cmd.c  | 73 ++++++++++++++++++++++++++++
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.h  | 18 +++++++
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c  |  9 ++++
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.h  |  1 +
 drivers/gpu/drm/vmwgfx/vmwgfx_ldu.c  | 43 ++++++++++++++++
 drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c | 34 +++++++++++++
 6 files changed, 178 insertions(+)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_cmd.c b/drivers/gpu/drm/vmwgfx/vmwgfx_cmd.c
index 8fe02131a6c4..fe6275a6cc31 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_cmd.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_cmd.c
@@ -156,6 +156,16 @@ struct vmw_fifo_state *vmw_fifo_create(struct vmw_private *dev_priv)
 	return fifo;
 }
 
+/* For drm_panic */
+void vmw_panic_fifo_ping_host(struct vmw_private *dev_priv, uint32_t reason)
+{
+	u32 *fifo_mem = dev_priv->fifo_mem;
+
+	if (fifo_mem && cmpxchg(fifo_mem + SVGA_FIFO_BUSY, 0, 1) == 0)
+		vmw_panic_write(dev_priv, SVGA_REG_SYNC, reason);
+
+}
+
 void vmw_fifo_ping_host(struct vmw_private *dev_priv, uint32_t reason)
 {
 	u32 *fifo_mem = dev_priv->fifo_mem;
@@ -264,6 +274,46 @@ static int vmw_fifo_wait(struct vmw_private *dev_priv,
 	return ret;
 }
 
+/* For drm_panic */
+void *vmw_panic_fifo_reserve(struct vmw_private *dev_priv, uint32_t bytes)
+{
+	struct vmw_fifo_state *fifo_state = dev_priv->fifo;
+	u32  *fifo_mem = dev_priv->fifo_mem;
+	uint32_t reserveable = fifo_state->capabilities & SVGA_FIFO_CAP_RESERVE;
+
+	/*
+	 * Access to fifo registers without mutex lock because it is only called is
+	 * panic handler
+	 */
+	uint32_t max = vmw_fifo_mem_read(dev_priv, SVGA_FIFO_MAX);
+	uint32_t min = vmw_fifo_mem_read(dev_priv, SVGA_FIFO_MIN);
+	uint32_t stop = vmw_fifo_mem_read(dev_priv, SVGA_FIFO_STOP);
+	uint32_t next_cmd = vmw_fifo_mem_read(dev_priv, SVGA_FIFO_NEXT_CMD);
+
+	if (unlikely(bytes >= (max - min)))
+		return NULL;
+
+	bool has_space;
+
+	if (next_cmd >= stop) {
+		has_space = (next_cmd + bytes < max ||
+			     (next_cmd + bytes == max && stop > min));
+	} else {
+		has_space = (next_cmd + bytes < stop);
+	}
+
+	if (unlikely(!has_space || (!reserveable && bytes > sizeof(uint32_t))))
+		return NULL;
+
+	fifo_state->reserved_size = bytes;
+	fifo_state->using_bounce_buffer = false;
+
+	if (reserveable)
+		vmw_fifo_mem_write(dev_priv, SVGA_FIFO_RESERVED, bytes);
+
+	return (void __force *) (fifo_mem + (next_cmd >> 2));
+}
+
 /*
  * Reserve @bytes number of bytes in the fifo.
  *
@@ -424,6 +474,29 @@ static void vmw_fifo_slow_copy(struct vmw_fifo_state *fifo_state,
 	}
 }
 
+/* For drm_panic */
+void vmw_panic_fifo_commit(struct vmw_private *dev_priv, uint32_t bytes)
+{
+	struct vmw_fifo_state *fifo_state = dev_priv->fifo;
+	uint32_t next_cmd = vmw_fifo_mem_read(dev_priv, SVGA_FIFO_NEXT_CMD);
+	uint32_t max = vmw_fifo_mem_read(dev_priv, SVGA_FIFO_MAX);
+	uint32_t min = vmw_fifo_mem_read(dev_priv, SVGA_FIFO_MIN);
+	bool reserveable = fifo_state->capabilities & SVGA_FIFO_CAP_RESERVE;
+
+	fifo_state->reserved_size = 0;
+
+	if (reserveable) {
+		next_cmd += bytes;
+		if (next_cmd >= max)
+			next_cmd -= max - min;
+		mb();
+		vmw_fifo_mem_write(dev_priv, SVGA_FIFO_NEXT_CMD, next_cmd);
+		vmw_fifo_mem_write(dev_priv, SVGA_FIFO_RESERVED, 0);
+	}
+	mb();
+	vmw_panic_fifo_ping_host(dev_priv, SVGA_SYNC_GENERIC);
+}
+
 static void vmw_local_fifo_commit(struct vmw_private *dev_priv, uint32_t bytes)
 {
 	struct vmw_fifo_state *fifo_state = dev_priv->fifo;
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h
index eda5b6f8f4c4..a1dc6d63c079 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h
@@ -635,6 +635,17 @@ static inline bool vmw_is_svga_v3(const struct vmw_private *dev)
 	return dev->pci_id == VMWGFX_PCI_ID_SVGA3;
 }
 
+/*
+ * For drm_panic
+ * Lockless vmw_write() because drm_panic calls this in panic handler
+ */
+static inline void vmw_panic_write(struct vmw_private *dev_priv,
+				   unsigned int offset, uint32_t value)
+{
+	outl(offset, dev_priv->io_start + SVGA_INDEX_PORT);
+	outl(value, dev_priv->io_start + SVGA_VALUE_PORT);
+}
+
 /*
  * The locking here is fine-grained, so that it is performed once
  * for every read- and write operation. This is of course costly, but we
@@ -854,16 +865,19 @@ extern void vmw_fifo_destroy(struct vmw_private *dev_priv);
 extern bool vmw_cmd_supported(struct vmw_private *vmw);
 extern void *
 vmw_cmd_ctx_reserve(struct vmw_private *dev_priv, uint32_t bytes, int ctx_id);
+extern void vmw_panic_fifo_commit(struct vmw_private *dev_priv, uint32_t bytes);
 extern void vmw_cmd_commit(struct vmw_private *dev_priv, uint32_t bytes);
 extern void vmw_cmd_commit_flush(struct vmw_private *dev_priv, uint32_t bytes);
 extern int vmw_cmd_send_fence(struct vmw_private *dev_priv, uint32_t *seqno);
 extern bool vmw_supports_3d(struct vmw_private *dev_priv);
+extern void vmw_panic_fifo_ping_host(struct vmw_private *dev_priv, uint32_t reason);
 extern void vmw_fifo_ping_host(struct vmw_private *dev_priv, uint32_t reason);
 extern bool vmw_fifo_have_pitchlock(struct vmw_private *dev_priv);
 extern int vmw_cmd_emit_dummy_query(struct vmw_private *dev_priv,
 				    uint32_t cid);
 extern int vmw_cmd_flush(struct vmw_private *dev_priv,
 			 bool interruptible);
+extern void *vmw_panic_fifo_reserve(struct vmw_private *dev_priv, uint32_t bytes);
 
 #define VMW_CMD_CTX_RESERVE(__priv, __bytes, __ctx_id)                        \
 ({                                                                            \
@@ -1027,6 +1041,8 @@ void vmw_kms_cursor_snoop(struct vmw_surface *srf,
 			  struct ttm_object_file *tfile,
 			  struct ttm_buffer_object *bo,
 			  SVGA3dCmdHeader *header);
+void vmw_kms_panic_write_svga(struct vmw_private *vmw_priv,
+			      unsigned int width, unsigned int height, unsigned int pitch);
 int vmw_kms_write_svga(struct vmw_private *vmw_priv,
 		       unsigned width, unsigned height, unsigned pitch,
 		       unsigned bpp, unsigned depth);
@@ -1349,6 +1365,8 @@ int vmw_mksstat_remove_ioctl(struct drm_device *dev, void *data,
 		      struct drm_file *file_priv);
 int vmw_mksstat_remove_all(struct vmw_private *dev_priv);
 
+void vmw_ldu_primary_plane_panic_flush(struct drm_plane *plane);
+
 /* VMW logging */
 
 /**
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
index 54ea1b513950..89d04d6be83e 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
@@ -1203,6 +1203,15 @@ int vmw_kms_close(struct vmw_private *dev_priv)
 	return ret;
 }
 
+/* For drm_panic */
+void vmw_kms_panic_write_svga(struct vmw_private *vmw_priv,
+			      unsigned int width, unsigned int height, unsigned int pitch)
+{
+	vmw_panic_write(vmw_priv, SVGA_REG_PITCHLOCK, pitch);
+	vmw_panic_write(vmw_priv, SVGA_REG_WIDTH, width);
+	vmw_panic_write(vmw_priv, SVGA_REG_HEIGHT, height);
+}
+
 int vmw_kms_write_svga(struct vmw_private *vmw_priv,
 			unsigned width, unsigned height, unsigned pitch,
 			unsigned bpp, unsigned depth)
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.h b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.h
index 445471fe9be6..e6299390ffea 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.h
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.h
@@ -499,6 +499,7 @@ int vmw_kms_stdu_readback(struct vmw_private *dev_priv,
 			  struct drm_crtc *crtc);
 
 int vmw_du_helper_plane_update(struct vmw_du_update_plane *update);
+int vmw_du_panic_helper_plane_update(struct vmw_du_update_plane *update);
 
 /**
  * vmw_du_translate_to_crtc - Translate a rect from framebuffer to crtc
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_ldu.c b/drivers/gpu/drm/vmwgfx/vmwgfx_ldu.c
index c23c9195f0dc..b7c3dfbab541 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_ldu.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_ldu.c
@@ -304,6 +304,49 @@ static int vmw_kms_ldu_do_bo_dirty(struct vmw_private *dev_priv,
 				   struct drm_mode_rect *clips,
 				   unsigned int num_clips);
 
+/* For drm_panic */
+static int vmw_kms_ldu_panic_do_bo_dirty(struct vmw_private *dev_priv,
+					 struct drm_framebuffer *fb)
+{
+	size_t fifo_size;
+	struct {
+		uint32_t header;
+		SVGAFifoCmdUpdate body;
+	} *cmd;
+
+	fifo_size = sizeof(*cmd);
+	cmd = vmw_panic_fifo_reserve(dev_priv, fifo_size);
+	if (IS_ERR_OR_NULL(cmd))
+		return -ENOMEM;
+
+	memset(cmd, 0, fifo_size);
+
+	cmd[0].header = SVGA_CMD_UPDATE;
+	cmd[0].body.x = 0;
+	cmd[0].body.y = 0;
+	cmd[0].body.width = fb->width;
+	cmd[0].body.height = fb->height;
+
+	vmw_panic_fifo_commit(dev_priv, fifo_size);
+	return 0;
+}
+
+/* For drm_panic */
+void vmw_ldu_primary_plane_panic_flush(struct drm_plane *plane)
+{
+	struct drm_plane_state *state = plane->state;
+	struct drm_crtc *crtc = state->crtc;
+	struct vmw_private *dev_priv = vmw_priv(crtc->dev);
+	struct drm_framebuffer *fb = state->fb;
+	int ret;
+
+	vmw_kms_panic_write_svga(dev_priv, fb->width, fb->height, fb->pitches[0]);
+
+	ret = vmw_kms_ldu_panic_do_bo_dirty(dev_priv, fb);
+	if (ret)
+		pr_warn("Failed to vmw_kms_ldu_panic_do_bo_dirty\n");
+}
+
 /*
  * Legacy Display Plane Functions
  */
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c b/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c
index 20aab725e53a..faa7135bd699 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c
@@ -36,6 +36,7 @@
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_damage_helper.h>
 #include <drm/drm_fourcc.h>
+#include <drm/drm_panic.h>
 #include <drm/drm_vblank.h>
 
 #define vmw_crtc_to_stdu(x) \
@@ -1458,6 +1459,37 @@ vmw_stdu_primary_plane_atomic_update(struct drm_plane *plane,
 		vmw_fence_obj_unreference(&fence);
 }
 
+static int
+vmw_stdu_primary_plane_get_scanout_buffer(struct drm_plane *plane,
+					  struct drm_scanout_buffer *sb)
+{
+	struct drm_plane_state *state = plane->state;
+	struct drm_crtc *crtc = state->crtc;
+	struct vmw_private *dev_priv = vmw_priv(crtc->dev);
+
+	if (!plane->state || !plane->state->fb || !plane->state->visible)
+		return -ENODEV;
+
+	sb->format = plane->state->fb->format;
+	sb->width = plane->state->fb->width;
+	sb->height = plane->state->fb->height;
+	sb->pitch[0] = plane->state->fb->pitches[0];
+
+	u64 size = sb->height * sb->pitch[0];
+
+	sb->map[0].vaddr = memremap(dev_priv->vram_start, size, MEMREMAP_WT);
+
+	if (!sb->map[0].vaddr)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static void vmw_stdu_primary_plane_panic_flush(struct drm_plane *plane)
+{
+	vmw_ldu_primary_plane_panic_flush(plane);
+}
+
 static void
 vmw_stdu_crtc_atomic_flush(struct drm_crtc *crtc,
 			   struct drm_atomic_state *state)
@@ -1506,6 +1538,8 @@ drm_plane_helper_funcs vmw_stdu_primary_plane_helper_funcs = {
 	.atomic_update = vmw_stdu_primary_plane_atomic_update,
 	.prepare_fb = vmw_stdu_primary_plane_prepare_fb,
 	.cleanup_fb = vmw_stdu_primary_plane_cleanup_fb,
+	.get_scanout_buffer = vmw_stdu_primary_plane_get_scanout_buffer,
+	.panic_flush = vmw_stdu_primary_plane_panic_flush,
 };
 
 static const struct drm_crtc_helper_funcs vmw_stdu_crtc_helper_funcs = {
-- 
2.51.0


