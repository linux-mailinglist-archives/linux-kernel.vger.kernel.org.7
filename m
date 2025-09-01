Return-Path: <linux-kernel+bounces-794088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DE89B3DCB0
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 10:38:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F0E53BBA42
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 08:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51C192FB62D;
	Mon,  1 Sep 2025 08:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dWxrbkts"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44CDD2FAC1B
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 08:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756715896; cv=none; b=sBd8CmRPtqHEvkNo9nFP6X+DY3HOduyrVOvmMfDHJMxIxEiYyU883B179r+v6ifSYafa/Kwm0znIfSZM00mhqWjZKy46dRAHVCcN0cBEdNcJO7icsoC1PsQVU4CWz7UZO1tWUbA8slKITFDQ89ms/toqETptbmSxaSS1OH2BrwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756715896; c=relaxed/simple;
	bh=CwR8FCY2/m543xGuZWEq5qLPGPl5zO8CW1WzaErCK7M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UqptjKJvbitUgvEJhZeYj14afiaXUiPjS/9wNxiGUJsORQcFnumf3qqBIFKcMZPyNehh9GoZA78mOeySVgaR2nXu1O85Ht7XuPiQDrSwe+LofU/24T5Nj+JzBFo5J3XC/az2bQlxuZURF5d8kHrjTZ89aXXfxrdOGsk4kB3Ni+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dWxrbkts; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756715893;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d1xHHB7KhC/dAebRQ0bO52ouHva0x3VxKkT5XLTb4iU=;
	b=dWxrbktsSliZvh7h7CgXIKMVXDFenTJtC24SIi+iF7FZ2UIMKUjaRKpWa/cfYNCCIcw7/U
	aWsIxfig9u7MClX8bGna9t5PKWZkdF20AxAnX+nV5kxfXyOT00EDIGH/xR0l5T7yUxyp26
	kSsRC0vgFB3TV4o7sR4heL1RG0yKfLw=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-673-lDqKPv3iNM24KURCyfYivA-1; Mon, 01 Sep 2025 04:38:10 -0400
X-MC-Unique: lDqKPv3iNM24KURCyfYivA-1
X-Mimecast-MFC-AGG-ID: lDqKPv3iNM24KURCyfYivA_1756715889
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b49da7c3ff6so2432421a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 01:38:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756715889; x=1757320689;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d1xHHB7KhC/dAebRQ0bO52ouHva0x3VxKkT5XLTb4iU=;
        b=RigQKH9dTQfI8AkuKS6ps43PJfjhY77df98izhpuzB9eQVyok4NMKAjbyQSKMsGFx5
         Vx/6fzfikiiU+ONzVHSItN12GIDN26NJWUWXosZrPsgymkf15zbsnbxVSuS6nqt5UKfP
         qvaTdD54jfz+Nmf7Tq6KNwrE3IfB0ta4R+qnkX5np8WrF5cUESgeleDSlg7eFJOmv1y3
         6BZIZvQ1A2fAX+f1RDViOvmwqhXVO0R8cpYSXbYibpxQqK3iJxVDX9mgn3ybE6BaVspa
         uoNOAivR08tCfTOYAYjuS1THhqv3+i9fK4qJ7gBJp5X9DMGdAbpkRR2uqr8CRbZi3vOT
         GHAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnSIfdS+hDU57jhLhWofwz4mCUFbaRJH/LRHgipTZDWbpplte2eTZW5dPEr8DxkS2gUJSv5754mgl2Alg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyB8zpDNcVlmBoDkrkKvwFuDVX/+EveB4DWg+9NHaO9OrQD4IcB
	b6CXN1v9S6ztSDMz3Ofkxmfxj2T0nPxyfnF2WRZZmCJoLq202yb9gj3DeKoSln9ODAulejzor+g
	pqR/hGS4CdHBLFlq46phin1UT7Mt2ZfPTnSI+SKhwRSSNDpZUBkEoNKe7xgfoqHW3sQ==
X-Gm-Gg: ASbGncsvulqU0hf+LnJpodbGH7tV1Vclm8kqT4+iq4hA8vPvGwtDKkp9sL4GkhWHNr3
	dmV/bf6XitP+dbcPNk7Qzxps8PZ1Zbum1qKE6MzMY391CKzm3SPi1WaIn+dS7MEIK5IUjN1WkWZ
	1bYifLJpOdL4o1LUk7yuxkZviiMRAsFYmacQk9UJ6UuijYxhpl1Qhp7gmqpnEmd47+gbsAbKBUv
	HudveH4j3eMulKW6PXxJN/CZ4eAv8kuNCSYDvIAOO+Jv3Gw2H/1VYGGdt1eWvuM7Zv3dEYsKFhm
	jGF/FP+CBtFEih42+XjJ9rpzAR2IavdkYvY=
X-Received: by 2002:a05:6a20:a105:b0:240:1c56:64a5 with SMTP id adf61e73a8af0-243d6e07ab8mr10523584637.15.1756715888788;
        Mon, 01 Sep 2025 01:38:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGobT95N8kzjBtsfufXMHPEIDXY4eb0mCtmV/up1r1FBORIADzfZ2oVGR3wXK4FGmPpxiQHIw==
X-Received: by 2002:a05:6a20:a105:b0:240:1c56:64a5 with SMTP id adf61e73a8af0-243d6e07ab8mr10523562637.15.1756715888376;
        Mon, 01 Sep 2025 01:38:08 -0700 (PDT)
Received: from zeus ([2405:6580:83a0:7600:6e93:a15a:9134:ae1f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a26ae02sm9815337b3a.21.2025.09.01.01.38.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 01:38:07 -0700 (PDT)
From: Ryosuke Yasuoka <ryasuoka@redhat.com>
To: zack.rusin@broadcom.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	jfalempe@redhat.com
Cc: Ryosuke Yasuoka <ryasuoka@redhat.com>,
	bcm-kernel-feedback-list@broadcom.com,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH drm-misc-next 1/1] drm/vmwgfx: add drm_panic support for stdu
Date: Mon,  1 Sep 2025 17:36:55 +0900
Message-ID: <20250901083701.32365-2-ryasuoka@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250901083701.32365-1-ryasuoka@redhat.com>
References: <20250901083701.32365-1-ryasuoka@redhat.com>
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
 drivers/gpu/drm/vmwgfx/vmwgfx_blit.c   |  43 ++++++++
 drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf.c |  11 ++
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.h    |   4 +
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c    |  48 +++++++++
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.h    |   1 +
 drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c   | 139 +++++++++++++++++++++++++
 6 files changed, 246 insertions(+)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_blit.c b/drivers/gpu/drm/vmwgfx/vmwgfx_blit.c
index fa5841fda659..d7ed04531249 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_blit.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_blit.c
@@ -514,6 +514,49 @@ static int vmw_external_bo_copy(struct vmw_bo *dst, u32 dst_offset,
 	return ret;
 }
 
+/* For drm_panic */
+void vmw_panic_bo_cpu_blit(struct vmw_bo *vmw_dst, u32 dst_stride,
+			   struct vmw_bo *vmw_src, u32 src_stride,
+			   u32 w, u32 h, struct vmw_diff_cpy *diff)
+{
+	struct ttm_buffer_object *src = &vmw_src->tbo;
+	struct ttm_buffer_object *dst = &vmw_dst->tbo;
+	u32 j;
+	u32 initial_line = 0;
+	u32 dst_offset = 0;
+	u32 src_offset = 0;
+	int ret = 0;
+	struct vmw_bo_blit_line_data d = {
+		.mapped_dst = 0,
+		.mapped_src = 0,
+		.dst_addr = NULL,
+		.src_addr = NULL,
+		.dst_pages = dst->ttm->pages,
+		.src_pages = src->ttm->pages,
+		.dst_num_pages = PFN_UP(dst->resource->size),
+		.src_num_pages = PFN_UP(src->resource->size),
+		.dst_prot = ttm_io_prot(dst, dst->resource, PAGE_KERNEL),
+		.src_prot = ttm_io_prot(src, src->resource, PAGE_KERNEL),
+		.diff = diff,
+	};
+
+	for (j = 0; j < h; ++j) {
+		diff->line = j + initial_line;
+		diff->line_offset = dst_offset % dst_stride;
+		ret = vmw_bo_cpu_blit_line(&d, dst_offset, src_offset, w);
+		if (ret)
+			goto out;
+
+		dst_offset += dst_stride;
+		src_offset += src_stride;
+	}
+out:
+	if (d.src_addr)
+		kunmap_atomic(d.src_addr);
+	if (d.dst_addr)
+		kunmap_atomic(d.dst_addr);
+}
+
 /**
  * vmw_bo_cpu_blit - in-kernel cpu blit.
  *
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf.c b/drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf.c
index 94e8982f5616..e39cc2f214be 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf.c
@@ -983,6 +983,17 @@ void *vmw_cmdbuf_alloc(struct vmw_cmdbuf_man *man,
 	return header->cmd;
 }
 
+/* For drm_panic */
+char *vmw_panic_cmdbuf_reserve_cur(struct vmw_cmdbuf_man *man, size_t size)
+{
+	/* Refer to cur without cur_mutex since this func is called in panic handler */
+	struct vmw_cmdbuf_header *cur = man->cur;
+
+	cur->reserved = size;
+
+	return (char *) (man->cur->cmd + man->cur_pos);
+}
+
 /**
  * vmw_cmdbuf_reserve_cur - Reserve space for commands in the current
  * command buffer.
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h
index eda5b6f8f4c4..c71ce975bf52 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h
@@ -1271,6 +1271,7 @@ extern int vmw_cmdbuf_idle(struct vmw_cmdbuf_man *man, bool interruptible,
 extern void *vmw_cmdbuf_reserve(struct vmw_cmdbuf_man *man, size_t size,
 				int ctx_id, bool interruptible,
 				struct vmw_cmdbuf_header *header);
+extern char *vmw_panic_cmdbuf_reserve_cur(struct vmw_cmdbuf_man *man, size_t size);
 extern void vmw_cmdbuf_commit(struct vmw_cmdbuf_man *man, size_t size,
 			      struct vmw_cmdbuf_header *header,
 			      bool flush);
@@ -1329,6 +1330,9 @@ int vmw_bo_cpu_blit(struct vmw_bo *dst,
 		    u32 src_offset, u32 src_stride,
 		    u32 w, u32 h,
 		    struct vmw_diff_cpy *diff);
+void vmw_panic_bo_cpu_blit(struct vmw_bo *dst, u32 dst_stride,
+			   struct vmw_bo *src, u32 src_stride,
+			   u32 w, u32 h, struct vmw_diff_cpy *diff);
 
 /* Host messaging -vmwgfx_msg.c: */
 void vmw_disable_backdoor(void);
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
index 54ea1b513950..160a4efbf342 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
@@ -1717,6 +1717,54 @@ void vmw_kms_lost_device(struct drm_device *dev)
 	drm_atomic_helper_shutdown(dev);
 }
 
+/* For drm_panic */
+int vmw_du_panic_helper_plane_update(struct vmw_du_update_plane *update)
+{
+	struct drm_plane_state *state = update->plane->state;
+	struct vmw_framebuffer_bo *vfbbo =
+		container_of(update->vfb, typeof(*vfbbo), base);
+	struct drm_rect src = drm_plane_state_src(state);
+	struct drm_rect clip = {
+		.x1 = 0,
+		.y1 = 0,
+		.x2 = (src.x2 >> 16) + !!(src.x2 & 0xFFFF),
+		.y2 = (src.y2 >> 16) + !!(src.y2 & 0xFFFF),
+	};
+	DECLARE_VAL_CONTEXT(val_ctx, NULL, 0);
+	uint32_t reserved_size = 0;
+	uint32_t submit_size = 0;
+	char *cmd;
+	int ret;
+
+	vmw_bo_placement_set(vfbbo->buffer,
+			     VMW_BO_DOMAIN_SYS | VMW_BO_DOMAIN_MOB | VMW_BO_DOMAIN_GMR,
+			     VMW_BO_DOMAIN_SYS | VMW_BO_DOMAIN_MOB | VMW_BO_DOMAIN_GMR);
+
+	ret = vmw_validation_add_bo(&val_ctx, vfbbo->buffer);
+	if (ret)
+		return ret;
+
+	ret = vmw_validation_prepare(&val_ctx, NULL, false);
+	if (ret)
+		return ret;
+
+	reserved_size = update->calc_fifo_size(update, 1);
+	cmd = vmw_panic_cmdbuf_reserve_cur(update->dev_priv->cman, reserved_size);
+	if (!cmd)
+		return -ENOMEM;
+
+	vmw_du_translate_to_crtc(state, &clip);
+
+	update->clip(update, cmd, &clip, 0, 0);
+	submit_size = update->post_clip(update, cmd, &clip);
+
+	vmw_cmd_commit(update->dev_priv, submit_size);
+
+	vmw_kms_helper_validation_finish(update->dev_priv, NULL, &val_ctx,
+					 NULL, NULL);
+	return ret;
+}
+
 /**
  * vmw_du_helper_plane_update - Helper to do plane update on a display unit.
  * @update: The closure structure.
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
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c b/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c
index 20aab725e53a..65b41338c620 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c
@@ -36,6 +36,7 @@
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_damage_helper.h>
 #include <drm/drm_fourcc.h>
+#include <drm/drm_panic.h>
 #include <drm/drm_vblank.h>
 
 #define vmw_crtc_to_stdu(x) \
@@ -1164,6 +1165,66 @@ static uint32_t vmw_stdu_bo_clip_cpu(struct vmw_du_update_plane  *update,
 	return 0;
 }
 
+/* For drm_panic */
+static uint32_t
+vmw_stdu_panic_bo_populate_update_cpu(struct vmw_du_update_plane  *update, void *cmd,
+				      struct drm_rect *bb)
+{
+	struct vmw_du_update_plane_buffer *bo_update;
+	struct vmw_screen_target_display_unit *stdu;
+	struct vmw_framebuffer_bo *vfbbo;
+	struct vmw_diff_cpy diff = VMW_CPU_BLIT_DIFF_INITIALIZER(0);
+	struct vmw_stdu_update_gb_image *cmd_img = cmd;
+	struct vmw_stdu_update *cmd_update;
+	struct vmw_bo *src_bo, *dst_bo;
+	s32 src_pitch, dst_pitch;
+	s32 width, height;
+
+	bo_update = container_of(update, typeof(*bo_update), base);
+	stdu = container_of(update->du, typeof(*stdu), base);
+	vfbbo = container_of(update->vfb, typeof(*vfbbo), base);
+
+	width = bb->x2;
+	height = bb->y2;
+
+	diff.cpp = stdu->cpp;
+
+	dst_bo = stdu->display_srf->res.guest_memory_bo;
+	dst_pitch = stdu->display_srf->metadata.base_size.width * stdu->cpp;
+
+	src_bo = vfbbo->buffer;
+	src_pitch = update->vfb->base.pitches[0];
+
+	vmw_panic_bo_cpu_blit(dst_bo, dst_pitch, src_bo, src_pitch,
+			      width * stdu->cpp, height, &diff);
+
+	if (drm_rect_visible(&diff.rect)) {
+		SVGA3dBox *box = &cmd_img->body.box;
+
+		cmd_img->header.id = SVGA_3D_CMD_UPDATE_GB_IMAGE;
+		cmd_img->header.size = sizeof(cmd_img->body);
+		cmd_img->body.image.sid = stdu->display_srf->res.id;
+		cmd_img->body.image.face = 0;
+		cmd_img->body.image.mipmap = 0;
+
+		box->x = diff.rect.x1;
+		box->y = diff.rect.y1;
+		box->z = 0;
+		box->w = drm_rect_width(&diff.rect);
+		box->h = drm_rect_height(&diff.rect);
+		box->d = 1;
+
+		cmd_update = (struct vmw_stdu_update *)&cmd_img[1];
+		vmw_stdu_populate_update(cmd_update, stdu->base.unit,
+					 diff.rect.x1, diff.rect.x2,
+					 diff.rect.y1, diff.rect.y2);
+
+		return sizeof(*cmd_img) + sizeof(*cmd_update);
+	}
+
+	return 0;
+}
+
 static uint32_t
 vmw_stdu_bo_populate_update_cpu(struct vmw_du_update_plane  *update, void *cmd,
 				struct drm_rect *bb)
@@ -1228,6 +1289,28 @@ vmw_stdu_bo_populate_update_cpu(struct vmw_du_update_plane  *update, void *cmd,
 	return 0;
 }
 
+/* For drm_panic */
+static int vmw_stdu_panic_plane_update_bo(struct vmw_private *dev_priv,
+					  struct drm_plane *plane,
+					  struct vmw_framebuffer *vfb)
+{
+	struct vmw_du_update_plane_buffer bo_update;
+
+	memset(&bo_update, 0, sizeof(struct vmw_du_update_plane_buffer));
+	bo_update.base.plane = plane;
+	bo_update.base.old_state = plane->state;
+	bo_update.base.dev_priv = dev_priv;
+	bo_update.base.du = vmw_crtc_to_du(plane->state->crtc);
+	bo_update.base.vfb = vfb;
+
+	bo_update.base.calc_fifo_size = vmw_stdu_bo_fifo_size_cpu;
+	bo_update.base.pre_clip = vmw_stdu_bo_pre_clip_cpu;
+	bo_update.base.clip = vmw_stdu_bo_clip_cpu;
+	bo_update.base.post_clip = vmw_stdu_panic_bo_populate_update_cpu;
+
+	return vmw_du_panic_helper_plane_update(&bo_update.base);
+}
+
 /**
  * vmw_stdu_plane_update_bo - Update display unit for bo backed fb.
  * @dev_priv: device private.
@@ -1458,6 +1541,60 @@ vmw_stdu_primary_plane_atomic_update(struct drm_plane *plane,
 		vmw_fence_obj_unreference(&fence);
 }
 
+static int
+vmw_stdu_primary_plane_get_scanout_buffer(struct drm_plane *plane,
+					  struct drm_scanout_buffer *sb)
+{
+	struct vmw_framebuffer *vfb;
+	struct vmw_framebuffer_bo *vfbbo;
+	void *virtual;
+
+	if (!plane->state || !plane->state->fb || !plane->state->visible)
+		return -ENODEV;
+
+	vfb = vmw_framebuffer_to_vfb(plane->state->fb);
+
+	if (!vfb->bo)
+		return -ENODEV;
+
+	vfbbo = container_of(vfb, typeof(*vfbbo), base);
+	virtual = vmw_bo_map_and_cache(vfbbo->buffer);
+	if (!virtual)
+		return -ENODEV;
+	iosys_map_set_vaddr(&sb->map[0], virtual);
+
+	sb->format = plane->state->fb->format;
+	sb->width = plane->state->fb->width;
+	sb->height = plane->state->fb->height;
+	sb->pitch[0] = plane->state->fb->pitches[0];
+
+	return 0;
+}
+
+static void vmw_stdu_primary_plane_panic_flush(struct drm_plane *plane)
+{
+	struct drm_plane_state *state = plane->state;
+	struct vmw_plane_state *vps = vmw_plane_state_to_vps(state);
+	struct drm_crtc *crtc = state->crtc;
+	struct vmw_private *dev_priv = vmw_priv(crtc->dev);
+	struct vmw_framebuffer *vfb = vmw_framebuffer_to_vfb(state->fb);
+	struct vmw_screen_target_display_unit *stdu = vmw_crtc_to_stdu(crtc);
+	int ret;
+
+	stdu->display_srf = vmw_user_object_surface(&vps->uo);
+	stdu->content_fb_type = vps->content_fb_type;
+	stdu->cpp = vps->cpp;
+
+	ret = vmw_stdu_bind_st(dev_priv, stdu, &stdu->display_srf->res);
+	if (ret)
+		DRM_ERROR("Failed to bind surface to STDU.\n");
+
+	if (vfb->bo)
+		ret = vmw_stdu_panic_plane_update_bo(dev_priv, plane, vfb);
+	if (ret)
+		DRM_ERROR("Failed to update STDU.\n");
+}
+
 static void
 vmw_stdu_crtc_atomic_flush(struct drm_crtc *crtc,
 			   struct drm_atomic_state *state)
@@ -1506,6 +1643,8 @@ drm_plane_helper_funcs vmw_stdu_primary_plane_helper_funcs = {
 	.atomic_update = vmw_stdu_primary_plane_atomic_update,
 	.prepare_fb = vmw_stdu_primary_plane_prepare_fb,
 	.cleanup_fb = vmw_stdu_primary_plane_cleanup_fb,
+	.get_scanout_buffer = vmw_stdu_primary_plane_get_scanout_buffer,
+	.panic_flush = vmw_stdu_primary_plane_panic_flush,
 };
 
 static const struct drm_crtc_helper_funcs vmw_stdu_crtc_helper_funcs = {
-- 
2.51.0


