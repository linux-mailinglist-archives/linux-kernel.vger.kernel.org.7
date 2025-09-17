Return-Path: <linux-kernel+bounces-821535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22AA9B81904
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 21:19:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A6A11C20C59
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 19:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3934F2BEFE7;
	Wed, 17 Sep 2025 19:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="Si8NfNVe"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02583227EB9
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 19:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758136777; cv=pass; b=FvaUXSHsNzseh9eNQmcjTH+L6SXRbFYHEhxC2DLJoAnWs0jn/xy3QYScsdpvHLbutKvCyBZSUODNpb1ccKX3TCzuEDJ58z3JvGCup91xxcD8UhCxDHhzhaX/o/ags5BwhMHz3PO2nrrBTycjvaloqttJYrFMkgTA9kz/QforqHQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758136777; c=relaxed/simple;
	bh=0vN1Qpz+opao2hhEfgfmxGduSRipiHd0S9+BfmoFL3I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kCNgzme3GM6re5idQBvoCOYZZLGtbGPxdOyMxsgYiWF60FpqZNHt9QBliiH7e5MsFavkUCiOSg5xuQQ5J94t4ntDGmwliLGerr+a47pNhrckTBXPqw84Fbm1tKufbsKUwov8nPwrgR7OcSjDOvfQMw7AFw05VsrGd3V3fiVPczs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b=Si8NfNVe; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1758136756; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=XB26pLUemW58MZOK0KVymCEpWLm9gnq00BiJpiXa4xnbWYTRS23slv5ncaAAkkChDYM8MRFf0PJwEQtf6RVQKr8+xn529mTmd5F8ZZPqBtrRIWEuV+oz6LJlD0+0SbhjqfnyhFj0m66/ep1RnxpOWLrEGE6n8Uzx2GHvIdQ75g4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1758136756; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=6+ZIdpmAN6Df2fd8uQfrWxJVH5jJLe8fOueBMvGAvug=; 
	b=ABBiRDRmzY93sRkCvU4b0rO2Zx9BFpumHt5wvsjHB9x+ZfQVf/hXsTSTApLHekPFKRpCkQRdp8LgHY+bCNRy9S9k0+XZQvHg+aMrK90+xgtcNzYlWttqA20AK9FiQUAt5GILXz/EtGUzscqBeU36hCrOgqR3OnktCpfd1PKzuHk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
	dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1758136756;
	s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=6+ZIdpmAN6Df2fd8uQfrWxJVH5jJLe8fOueBMvGAvug=;
	b=Si8NfNVerUJkqU55zX51tUAynMamjQvjOb7k/kdOUidfkc01jZniGX4Mn8UzhRJg
	CmY8c2r9D9/vkhZAF+yJTqe5eMFqYz9GrJFx7GuVVtgqSH++csYr498XIAXViie6vqE
	DwhyrBH7RcbkWlJ16hTMyyTuZxrIOo2HVhn7Mvz8=
Received: by mx.zohomail.com with SMTPS id 1758136755515546.0238143636809;
	Wed, 17 Sep 2025 12:19:15 -0700 (PDT)
From: =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org,
	Steven Price <steven.price@arm.com>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	kernel@collabora.com,
	=?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>,
	Rob Herring <robh@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Subject: [PATCH v4 1/4] drm/panfrost: Introduce uAPI for JM context creation
Date: Wed, 17 Sep 2025 20:18:37 +0100
Message-ID: <20250917191859.500279-2-adrian.larumbe@collabora.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250917191859.500279-1-adrian.larumbe@collabora.com>
References: <20250917191859.500279-1-adrian.larumbe@collabora.com>
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


