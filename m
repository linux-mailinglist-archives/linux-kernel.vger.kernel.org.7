Return-Path: <linux-kernel+bounces-814102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58DB5B54F4B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 15:21:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 160FF5A3C85
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 13:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 416AF27BF99;
	Fri, 12 Sep 2025 13:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="Ug1/m3Ot"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA9F301003
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 13:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757683264; cv=pass; b=kMuJRHXGGGZTd+pHiuHAvuVaxxKvzGVihPVpABfbmM2a1TKV4Xz8a/tKVVuHbSo9+vvOnRvcZn/2zRJL9pL6OVaLhCdC6jdLvNlnolqm9TMkkHwnYhL1hn/PqaoKQJbsROYVGuQVhRSbNA3Cx4r3IFyRYF4hWZnjisAUose5TSk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757683264; c=relaxed/simple;
	bh=0vN1Qpz+opao2hhEfgfmxGduSRipiHd0S9+BfmoFL3I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KkfsdilUMoWR6MPaKuA5t1OuwFojaOQxFGq3+uTYEbJfGOO+KEJnVHN0oJnTq8udg/eCeFmZua7oGaIfiu9CeT3EKwGq4xFWOyuK1TcGNS7BYKiTeCaAdFYXqQ8Dog1Mc84X70nAflYMOX0ameNt0de/UxXi5KYorkkZ3aO3N3o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b=Ug1/m3Ot; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1757683244; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=DxCb21K/pmgGkPVVXzyUgutNZuRzjq69oDXbSkVQ5JyhPmLwexzqERl6sHq7FLahIH4ptHzQmLMuGNec76852MBa5XCSNReQVUbNLaosqJ4RmapUXjA+2lSVmdcm5SMijpoPNGwuoi427Btn4hlLje1wQJbn2cKo7iFAceg0800=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1757683244; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=6+ZIdpmAN6Df2fd8uQfrWxJVH5jJLe8fOueBMvGAvug=; 
	b=Z0gEDFZNV7YHIjOKarDI5qHBze3eHMoX7eic+LkNpS3u9C2VMmJkkOK/XlVwmnrkaCErU18zecaQcDoW2cli+VEwMjgbizljDDGjwGjzl/Ta0oqP8qEgp3dp7z50HzN6fjPG5wQAgkhH8n0HS1F0WdtWpvCBVqM7StQEkDCGTIo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
	dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1757683244;
	s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=6+ZIdpmAN6Df2fd8uQfrWxJVH5jJLe8fOueBMvGAvug=;
	b=Ug1/m3OtuW0MI0WA2SXWuiOD3WsGJXeB5LMJd/gdpYG3dtdlKw29oQ8K9aokoBI2
	sb7hHil3IDvmMCLl1R/n6IaEAgtAT7yrPdUg3/txM/y2bB0MJsATynfCvm6RxVhKTl1
	diiaMYcXP8jKERWXF59izig253eZhh+Sbk5Upyp0=
Received: by mx.zohomail.com with SMTPS id 1757683241751439.3730049410336;
	Fri, 12 Sep 2025 06:20:41 -0700 (PDT)
From: =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org,
	Steven Price <steven.price@arm.com>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	kernel@collabora.com,
	=?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>,
	Rob Herring <robh@kernel.org>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v3 1/4] drm/panfrost: Introduce uAPI for JM context creation
Date: Fri, 12 Sep 2025 14:19:12 +0100
Message-ID: <20250912132002.304187-2-adrian.larumbe@collabora.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250912132002.304187-1-adrian.larumbe@collabora.com>
References: <20250912132002.304187-1-adrian.larumbe@collabora.com>
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
the notion of a context, for which we also provide new creation and
destruction ioctls.

Reviewed-by: Steven Price <steven.price@arm.com>
Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
 include/uapi/drm/panfrost_drm.h | 50 +++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/include/uapi/drm/panfrost_drm.h b/include/uapi/drm/panfrost_drm.h
index ed67510395bd..e8b47c9f6976 100644
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
@@ -299,6 +310,45 @@ struct panfrost_dump_registers {
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
+struct drm_panfrost_jm_ctx_create {
+	/** @handle: Handle of the created JM context */
+	__u32 handle;
+
+	/** @priority: Context priority (see enum drm_panfrost_jm_ctx_priority). */
+	__u32 priority;
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
2.51.0


