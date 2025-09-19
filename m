Return-Path: <linux-kernel+bounces-823955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A0BB87CFF
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 05:30:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 068B13B3CD9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 03:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B26C21F4C8C;
	Fri, 19 Sep 2025 03:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IoMfBEpt"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D780B238C07
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 03:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758252615; cv=none; b=edNMVJykkIGcn0cP5xHh5Z0T0mlpEWrDQ+CT9uDr54f6MB+VWM53tzBcJ1QiiEU++2DVdZKRYjLBSwW8oLMwSTitKnQnyr8Oxg6F4uNS1y0Lqr3rTmn7lFBXwgQWGMkZ82l8jeDsB4sZDMVqCpjr6Rg0ka7s8YJojKHl32+tQn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758252615; c=relaxed/simple;
	bh=lb8//f+6rF/7Au/3x/kZXVX3ZgU1Q3olW3ojgiH3sks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pmi2G5luTF7k9a5kFXL/xOG3DEnsAncWOxtC00O8f+elFcD2SjInsFrqip0JZmLr4JgpUNmOS2tDIz7TMS1vcSaY86U7nL6mQjjSBvH5aHUrftTurrQMAKb0s2Of/C3/PWVOqalSuFNK11VmMyVf50XU3nedLKSrKuCUtVDzVTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IoMfBEpt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758252612;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TAkNmTJp2NJK26jQeXTwypnAgJsAqQn3/zrN49Z+2ac=;
	b=IoMfBEptM18uDfMvghIFCWOpAWXPlHMgScjKfzqxqyVA+Bp6RJW4htZAgX17MnsqI6i3Ne
	zzcOGHRdlRGA4Gzhoxy2CkxcEhL3VyUDoKXMC88AohMDbdbzTc2wEnlbQ/+ITFC27TuDKa
	qE14v293P3aG8odnpHN98f+ePSbhbVo=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-241-W9XkXMqvN5uORsjD1f-ZCg-1; Thu, 18 Sep 2025 23:30:11 -0400
X-MC-Unique: W9XkXMqvN5uORsjD1f-ZCg-1
X-Mimecast-MFC-AGG-ID: W9XkXMqvN5uORsjD1f-ZCg_1758252610
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-32ee157b9c9so1438653a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 20:30:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758252610; x=1758857410;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TAkNmTJp2NJK26jQeXTwypnAgJsAqQn3/zrN49Z+2ac=;
        b=nEWDnboOiqH5ZO/5VZgXbYxJsIM/zNQbNL+Abu3CaystJsa8Grj8GiFrR4dM3Rl8S7
         NVT0ez6Rq83nO4m8ZWb84ro4jaxWxj8oPMYaQ9hzixrjO69ZXExQTbn67jH2TIu+LUVu
         LPaVngchWj+VgnuOM7aMRY1g3RD42dIPQzfvUnVsS5Zl08mzrIklHqNZgTKDdYSoFBJc
         O+REsqmakpUIx3lagp5y/VJzsIELjsW3TyLvZh2503hkhJ8tU+7u1GQsQcMNDyZpxFdJ
         33vQdMcY7TpE1B+TuqahNBkN1xZu09tnpCnjDmQbfM1oP9yv/j/oKNQkrxaOEEIY7vbl
         aT3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWFug3906LSBhNba3pLF9VFysyE8ee2CzFooRlu+LagpMLBUGL495xazELqOjET6IKZymPfmZzPG+/rHCo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUnJjSPns3IBfnBQxHBR/r9fbMihPYe3kE40xRy+wadqrDeKEx
	AKkoXfRyKhVkssS2mos4L/WGnLxcdylaSo21y0a+mY44NR1GNXf66pjpERcQvp0lnBAup2MCuf/
	Wr5PNhNGkUpu6k4aOl8fHzS0bIYQ4vOIP852awAgDoDXoliuAHK51G1VN7vqeBF6DKg==
X-Gm-Gg: ASbGncuHc0sZI2VykE+SRaEAFF2RWmPT3zDHgZ10aP+EJzMHi14q51qWbqVeCIgfC7/
	FnQqXwOsXgxi/81Qlro3jTP4LOPR1tzDTG19TLYOEcNQzaPMqvKjIEGZo4v0cl7f7MOWNYsSJq6
	MVl59pM9TsfTAKlppUPFVzmSrWoUxl7rgFcVSwGZ+rKKGGWzd5a1mBpuFctDhUTJcNYU3roG/ti
	pVFtTJU0o87TNp9BcdftbTMOkp/XeoNtpn5x4/GP/9Ovloq4jdVMrXdfRsUWgPBrbiSVVQ4NnWz
	jeZV4+8YwB+bALP5Abep3q/fq165urD25Q8=
X-Received: by 2002:a17:90b:3b4b:b0:32e:ef4:bc7c with SMTP id 98e67ed59e1d1-330983417ecmr2096596a91.24.1758252609804;
        Thu, 18 Sep 2025 20:30:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEiVbgp4sODJuf0YuLex9BXXsbUMxP4K49M04/Qd6n+eGRXU9bB1DG5bwU8gKiMf06LNd13Og==
X-Received: by 2002:a17:90b:3b4b:b0:32e:ef4:bc7c with SMTP id 98e67ed59e1d1-330983417ecmr2096571a91.24.1758252609335;
        Thu, 18 Sep 2025 20:30:09 -0700 (PDT)
Received: from zeus ([2405:6580:83a0:7600:6e93:a15a:9134:ae1f])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-330606509e9sm4054289a91.9.2025.09.18.20.30.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 20:30:08 -0700 (PDT)
From: Ryosuke Yasuoka <ryasuoka@redhat.com>
To: zack.rusin@broadcom.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	jfalempe@redhat.com,
	ian.forbes@broadcom.com
Cc: Ryosuke Yasuoka <ryasuoka@redhat.com>,
	bcm-kernel-feedback-list@broadcom.com,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH drm-misc-next v3 1/1] drm/vmwgfx: add drm_panic support for stdu mode
Date: Fri, 19 Sep 2025 12:29:30 +0900
Message-ID: <20250919032936.2267240-2-ryasuoka@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250919032936.2267240-1-ryasuoka@redhat.com>
References: <20250919032936.2267240-1-ryasuoka@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add drm_panic module for vmwgfx stdu mode so that panic screen can be
displayed on panic. Since implemented by writing to VRAM and switching
back to legacy mode, it would expect to work in all DU modes.

Signed-off-by: Ryosuke Yasuoka <ryasuoka@redhat.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.h  |   4 +
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c  | 165 +++++++++++++++++++++++++++
 drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c |   2 +
 3 files changed, 171 insertions(+)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h
index eda5b6f8f4c4..1259112ee2c2 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h
@@ -16,6 +16,7 @@
 #include <drm/drm_auth.h>
 #include <drm/drm_device.h>
 #include <drm/drm_file.h>
+#include <drm/drm_panic.h>
 #include <drm/drm_rect.h>
 
 #include <drm/ttm/ttm_execbuf_util.h>
@@ -1046,6 +1047,9 @@ void vmw_kms_lost_device(struct drm_device *dev);
 extern int vmw_resource_pin(struct vmw_resource *res, bool interruptible);
 extern void vmw_resource_unpin(struct vmw_resource *res);
 extern enum vmw_res_type vmw_res_type(const struct vmw_resource *res);
+int vmw_primary_plane_get_scanout_buffer(struct drm_plane *plane,
+					 struct drm_scanout_buffer *sb);
+void vmw_primary_plane_panic_flush(struct drm_plane *plane);
 
 /**
  * Overlay control - vmwgfx_overlay.c
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
index 54ea1b513950..c79e39c1845e 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
@@ -2022,3 +2022,168 @@ bool vmw_user_object_is_null(struct vmw_user_object *uo)
 {
 	return !uo->buffer && !uo->surface;
 }
+
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
+/* For drm_panic */
+static void
+vmw_kms_panic_write_svga(struct vmw_private *vmw_priv, unsigned int width,
+			 unsigned int height, unsigned int pitch)
+{
+	vmw_panic_write(vmw_priv, SVGA_REG_PITCHLOCK, pitch);
+	vmw_panic_write(vmw_priv, SVGA_REG_WIDTH, width);
+	vmw_panic_write(vmw_priv, SVGA_REG_HEIGHT, height);
+}
+
+/* For drm_panic */
+static void *vmw_panic_fifo_reserve(struct vmw_private *dev_priv, uint32_t bytes)
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
+/* For drm_panic */
+static void
+vmw_panic_fifo_ping_host(struct vmw_private *dev_priv, uint32_t reason)
+{
+	u32 *fifo_mem = dev_priv->fifo_mem;
+
+	if (fifo_mem && cmpxchg(fifo_mem + SVGA_FIFO_BUSY, 0, 1) == 0)
+		vmw_panic_write(dev_priv, SVGA_REG_SYNC, reason);
+
+}
+
+/* For drm_panic */
+static void vmw_panic_fifo_commit(struct vmw_private *dev_priv, uint32_t bytes)
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
+/* For drm_panic */
+static int vmw_kms_panic_do_bo_dirty(struct vmw_private *dev_priv)
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
+	cmd[0].body.width = dev_priv->initial_width;
+	cmd[0].body.height = dev_priv->initial_height;
+
+	vmw_panic_fifo_commit(dev_priv, fifo_size);
+	return 0;
+}
+
+int vmw_primary_plane_get_scanout_buffer(struct drm_plane *plane,
+					 struct drm_scanout_buffer *sb)
+{
+	struct drm_plane_state *state = plane->state;
+	struct drm_crtc *crtc = state->crtc;
+	struct vmw_private *dev_priv = vmw_priv(crtc->dev);
+	struct vmw_display_unit *du = vmw_crtc_to_du(crtc);
+
+	if (!plane->state || !plane->state->fb || !plane->state->visible || du->unit != 0)
+		return -ENODEV;
+
+	sb->format = state->fb->format;
+	sb->width = dev_priv->initial_width;
+	sb->height = dev_priv->initial_height;
+	sb->pitch[0] = dev_priv->initial_width * state->fb->format->cpp[0];
+
+	u64 size = sb->height * sb->pitch[0];
+
+	sb->map[0].vaddr = memremap(dev_priv->vram_start, size, MEMREMAP_WB | MEMREMAP_DEC);
+
+	if (!sb->map[0].vaddr)
+		return -ENOMEM;
+
+	return 0;
+}
+
+/* For drm_panic */
+void vmw_primary_plane_panic_flush(struct drm_plane *plane)
+{
+	struct drm_plane_state *state = plane->state;
+	struct drm_crtc *crtc = state->crtc;
+	struct vmw_private *dev_priv = vmw_priv(crtc->dev);
+	struct drm_framebuffer *fb = state->fb;
+	unsigned int pitch = dev_priv->initial_width * fb->format->cpp[0];
+	int ret;
+
+	vmw_kms_panic_write_svga(dev_priv, dev_priv->initial_width,
+				 dev_priv->initial_height, pitch);
+
+	ret = vmw_kms_panic_do_bo_dirty(dev_priv);
+	if (ret)
+		pr_warn("Failed to vmw_kms_ldu_panic_do_bo_dirty\n");
+}
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c b/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c
index 20aab725e53a..93c02308d44b 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c
@@ -1506,6 +1506,8 @@ drm_plane_helper_funcs vmw_stdu_primary_plane_helper_funcs = {
 	.atomic_update = vmw_stdu_primary_plane_atomic_update,
 	.prepare_fb = vmw_stdu_primary_plane_prepare_fb,
 	.cleanup_fb = vmw_stdu_primary_plane_cleanup_fb,
+	.get_scanout_buffer = vmw_primary_plane_get_scanout_buffer,
+	.panic_flush = vmw_primary_plane_panic_flush,
 };
 
 static const struct drm_crtc_helper_funcs vmw_stdu_crtc_helper_funcs = {
-- 
2.51.0


