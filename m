Return-Path: <linux-kernel+bounces-789157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96260B391C3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 04:35:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AA5C1B23C24
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 02:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CC0D25FA05;
	Thu, 28 Aug 2025 02:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="OiP/IveF"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26E325EF87
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 02:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756348535; cv=pass; b=tAl8X07UIpF2zbDcxz+sJNEEggcU3Ru4WNFBcsU2pS/Ut4Zqj8LdwmRq4X+k4pPWF6EnMVEz9LO+HXpCpe8fm7qXdNNa84++ZfgZZ2SraxeCMqRNh6HPHUyp3O4pW/uVPGBvmJQqpP8Q950HI5YKhNclpx/46XfAhACehdJcwyU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756348535; c=relaxed/simple;
	bh=vpA/e9lW6KbW/rfuADTMc1pz4n5U0uW8lJ41HDzh+hI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qKBnQmK2BRcECl73Az3yvbFVUeUU3geTezR3A5aroOfD2FbvAPGCITEQBP0Sj4o+QM2WIvW4UbvT+M/kz71IPE/zXgsjBgLJM62Tnti3pxddtOKEvv8a0GUCxdyijGDAqhrrMlde9yzKYzUnHsb2EwEIiGBP/yKJWiPg+s14jLw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b=OiP/IveF; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1756348511; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=guORNmwwjDjNHrywXAGqBMD1KpboHPrMY2vlIr4bnj/JOujlbbALWgrf2t2LHUnnq49RyeaGwXdIHJ6bS6imkjrN+hCTG54BXxjcnE33aAmGBv3dVRWBYVrCK91RlVd8cP9rOQjtaf/g0L/ZivIocKpmGWtKIEYkhzHl/sG6xnA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1756348511; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=PHsI4CYV0V3r9lD5ytBPM7HtZI5OLJ3XqOdRLkAvVSA=; 
	b=cZWQLo75gPv8cdXCY+l2dRKj7TFxi3ZreJC2EImctj9Ah265RzFoSfwJZ0TwjOQHi3P9ioXJZp3MZP78Qf84/hlWZNmWr1iic3+OZR/9/EGPnRArLFMo/J2w3ZV1nSMKDcRf6iZRx7NhcnyXz6B895WiyDiLvEmlvql2Ww5CQkY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
	dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1756348511;
	s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=PHsI4CYV0V3r9lD5ytBPM7HtZI5OLJ3XqOdRLkAvVSA=;
	b=OiP/IveFFD0n/80TxzwrNR/xbVgptcQhpfDxxNAiWtTCmR1qRgfhv62vQNwP/HJ0
	8qWlLHO3B/66XkKA/KLR5T3F6o1tjtgmJUJ1LEGvgN6i5XIu8nmT8JL3SOswX8YIGBh
	jHtfzxfgayiN2HGgBiRlWCkKbRpYJESRpzWy6baE=
Received: by mx.zohomail.com with SMTPS id 1756348509179663.5810528333795;
	Wed, 27 Aug 2025 19:35:09 -0700 (PDT)
From: =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org,
	Boris Brezillon <boris.brezillon@collabora.com>,
	kernel@collabora.com,
	=?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>,
	Rob Herring <robh@kernel.org>,
	Steven Price <steven.price@arm.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 2/5] drm/panfrost: Introduce uAPI for JM context creation
Date: Thu, 28 Aug 2025 03:34:05 +0100
Message-ID: <20250828023422.2404784-3-adrian.larumbe@collabora.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250828023422.2404784-1-adrian.larumbe@collabora.com>
References: <20250828023422.2404784-1-adrian.larumbe@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Boris Brezillon <boris.brezillon@collabora.com>

The new uAPI lets user space query the KM driver for the available
priorities a job can be given at submit time. These are managed through
the notion of a context, which besides a priority, codifies the list
of L2 caches, shading cores and tiler units a job is allowed to use,
for all three of the available device job slots.

Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
 include/uapi/drm/panfrost_drm.h | 93 +++++++++++++++++++++++++++++++++
 1 file changed, 93 insertions(+)

diff --git a/include/uapi/drm/panfrost_drm.h b/include/uapi/drm/panfrost_drm.h
index ed67510395bd..2d8b32448e68 100644
--- a/include/uapi/drm/panfrost_drm.h
+++ b/include/uapi/drm/panfrost_drm.h
@@ -22,6 +22,8 @@ extern "C" {
 #define DRM_PANFROST_PERFCNT_DUMP		0x07
 #define DRM_PANFROST_MADVISE			0x08
 #define DRM_PANFROST_SET_LABEL_BO		0x09
+#define DRM_PANFROST_JM_CTX_CREATE		0x0a
+#define DRM_PANFROST_JM_CTX_DESTROY		0x0b
 
 #define DRM_IOCTL_PANFROST_SUBMIT		DRM_IOW(DRM_COMMAND_BASE + DRM_PANFROST_SUBMIT, struct drm_panfrost_submit)
 #define DRM_IOCTL_PANFROST_WAIT_BO		DRM_IOW(DRM_COMMAND_BASE + DRM_PANFROST_WAIT_BO, struct drm_panfrost_wait_bo)
@@ -31,6 +33,8 @@ extern "C" {
 #define DRM_IOCTL_PANFROST_GET_BO_OFFSET	DRM_IOWR(DRM_COMMAND_BASE + DRM_PANFROST_GET_BO_OFFSET, struct drm_panfrost_get_bo_offset)
 #define DRM_IOCTL_PANFROST_MADVISE		DRM_IOWR(DRM_COMMAND_BASE + DRM_PANFROST_MADVISE, struct drm_panfrost_madvise)
 #define DRM_IOCTL_PANFROST_SET_LABEL_BO		DRM_IOWR(DRM_COMMAND_BASE + DRM_PANFROST_SET_LABEL_BO, struct drm_panfrost_set_label_bo)
+#define DRM_IOCTL_PANFROST_JM_CTX_CREATE	DRM_IOWR(DRM_COMMAND_BASE + DRM_PANFROST_JM_CTX_CREATE, struct drm_panfrost_jm_ctx_create)
+#define DRM_IOCTL_PANFROST_JM_CTX_DESTROY	DRM_IOWR(DRM_COMMAND_BASE + DRM_PANFROST_JM_CTX_DESTROY, struct drm_panfrost_jm_ctx_destroy)
 
 /*
  * Unstable ioctl(s): only exposed when the unsafe unstable_ioctls module
@@ -71,6 +75,12 @@ struct drm_panfrost_submit {
 
 	/** A combination of PANFROST_JD_REQ_* */
 	__u32 requirements;
+
+	/** JM context handle. Zero if you want to use the default context. */
+	__u32 jm_ctx_handle;
+
+	/** Padding field. MBZ. */
+	__u32 pad;
 };
 
 /**
@@ -177,6 +187,7 @@ enum drm_panfrost_param {
 	DRM_PANFROST_PARAM_AFBC_FEATURES,
 	DRM_PANFROST_PARAM_SYSTEM_TIMESTAMP,
 	DRM_PANFROST_PARAM_SYSTEM_TIMESTAMP_FREQUENCY,
+	DRM_PANFROST_PARAM_ALLOWED_JM_CTX_PRIORITIES,
 };
 
 struct drm_panfrost_get_param {
@@ -299,6 +310,88 @@ struct panfrost_dump_registers {
 	__u32 value;
 };
 
+enum drm_panfrost_jm_ctx_priority {
+	/**
+	 * @PANFROST_JM_CTX_PRIORITY_LOW: Low priority context.
+	 */
+	PANFROST_JM_CTX_PRIORITY_LOW = 0,
+
+	/**
+	 * @PANFROST_JM_CTX_PRIORITY_MEDIUM: Medium priority context.
+	 */
+	PANFROST_JM_CTX_PRIORITY_MEDIUM,
+
+	/**
+	 * @PANFROST_JM_CTX_PRIORITY_HIGH: High priority context.
+	 *
+	 * Requires CAP_SYS_NICE or DRM_MASTER.
+	 */
+	PANFROST_JM_CTX_PRIORITY_HIGH,
+};
+
+#define PANFROST_JS_FLAG_ENABLED		(1 << 0)
+
+struct drm_panfrost_js_ctx_info {
+	/** @flags: Combination of PANFROST_JS_FLAG_xxx values */
+	__u32 flags;
+
+	/** @priority: Context priority (see enum drm_panfrost_jm_ctx_priority). */
+	__u8 priority;
+
+	/**
+	 * @tiler_mask: Mask encoding tiler units that can be used by the job slot
+	 *
+	 * When this field is zero, it means the tiler won't be used.
+	 *
+	 * The bits set here should also be set in drm_panthor_gpu_info::tiler_present.
+	 */
+	__u8 tiler_mask;
+
+	/**
+	 * @l2_mask: Mask encoding L2 caches that can be used by the job slot
+	 *
+	 * The bits set here should also be set in drm_panthor_gpu_info::l2_present.:
+	 */
+	__u16 l2_mask;
+
+	/**
+	 * @core_mask: Mask encoding cores that can be used by the job slot
+	 *
+	 * When this field is zero, it means the queue won't be used.
+	 *
+	 * The bits set here should also be set in drm_panthor_gpu_info::shader_present.
+	 */
+	__u64 core_mask;
+};
+
+struct drm_panfrost_jm_ctx_create {
+	/** @handle: Handle of the created JM context */
+	__u32 handle;
+
+	/** @pad: Padding field, MBZ. */
+	__u32 pad;
+
+	/**
+	 * @slots: Job slots
+	 *
+	 * This field must be greater than zero and less than 8 (only three slots
+	 * available).
+	 */
+	struct drm_panfrost_js_ctx_info slots[3];
+};
+
+struct drm_panfrost_jm_ctx_destroy {
+	/**
+	 * @handle: Handle of the JM context to destroy.
+	 *
+	 * Must be a valid context handle returned by DRM_IOCTL_PANTHOR_JM_CTX_CREATE.
+	 */
+	__u32 handle;
+
+	/** @pad: Padding field, MBZ. */
+	__u32 pad;
+};
+
 #if defined(__cplusplus)
 }
 #endif
-- 
2.50.0


