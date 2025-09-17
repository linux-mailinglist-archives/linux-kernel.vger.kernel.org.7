Return-Path: <linux-kernel+bounces-821537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C90FB8193A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 21:22:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6288E483765
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 19:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA8C83054D1;
	Wed, 17 Sep 2025 19:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="BozZWFoz"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6B82F25F3
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 19:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758136782; cv=pass; b=RotYCy8jK5EI23ORzGR58Er9h/+y7Y9nzRvXSFG22ltz+UIIFq/2CBUpP6kxFP6oZb75/gmKCV6zup39QzfPwGoT2uTgHf0nRkQ0l9S3eSZOeB2Js6VTeR8G7Hvg1w/Td9AkaEgirZgBRjscKdnV3DZhKuLpCX8kc0iHGWjli6E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758136782; c=relaxed/simple;
	bh=6xoS03COl4TLo0haCKiHwaGSHA/vLmSoyfnsTqOv/tQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a8w9h1GExIsml9k0+LE18dIg7oOQEQrIOTrKQGDIq6cCiWnmNGHOr6KN3fY/4hxTPYDqw7cXb/dRVNFG29EXSZ+h40qcgx/ovjWfHIMNazeRbBDtHW+zw7orBTuAlCcN7vUkgUt/uhZK2gdhpxc4pwbseAuffggDAZHt3ivu5g8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b=BozZWFoz; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1758136764; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=KbcKNRxENWFSiIgPSWx16Sxdj1KqGc00KRg1ZBKVKbroTkwtN/CzbkySZnFjlBuDy1fMI8YpmWrb2z4L/ArHNjBFlUWLi6kddSKMajJ3LoIW3tAKtDgA6PSSCRh3JYTJw/0ajFmxiwhzvdWxW0rSYh4i23r2e/5ZCF2DQWQHPVM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1758136764; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=cxi2wukW0Zh14Hj1ZHgQ4cBOZaU5H61tQKPpgirVITY=; 
	b=aTwAu3eAF80ksP5dApO+5ExxoWGveUjKPPR8JggokJWbZLdAtpHesNlFpkUKvFzJxY5PjFpSzvPO6Bht/Aa/rHqxYQH9tcDl7R/sUKgf6QryiRQ2mSdWG3H4TvqIPji0s7m6d2kefbpda4L5sZYQ3zpmetskFyNPC+gfJeCmxj8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
	dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1758136764;
	s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=cxi2wukW0Zh14Hj1ZHgQ4cBOZaU5H61tQKPpgirVITY=;
	b=BozZWFozlcMrN0bg1oqfcRypI6lCEHrt6fHjB8wlgYEj5j3H1Gp6p0jKCwheLBSe
	PLea+dJQBc/xNC5ldWZZ3qeW/Ggaq4gOo0pwKNF4Aa95X4jydZcjLCJIA/JnSoMBlLc
	cm8DrjtyIytpUQzxCzLIeKc894ybHFuEItfvvXBo=
Received: by mx.zohomail.com with SMTPS id 1758136762541460.2589926270573;
	Wed, 17 Sep 2025 12:19:22 -0700 (PDT)
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
Subject: [PATCH v4 3/4] drm/panfrost: Expose JM context IOCTLs to UM
Date: Wed, 17 Sep 2025 20:18:39 +0100
Message-ID: <20250917191859.500279-4-adrian.larumbe@collabora.com>
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

Minor revision of the driver must be bumped because this expands the
uAPI. On top of that, let UM know about the available priorities so that
they can create contexts with legal priority values.

Reviewed-by: Steven Price <steven.price@arm.com>
Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
 drivers/gpu/drm/panfrost/panfrost_drv.c | 36 ++++++++++++++++++++++---
 1 file changed, 33 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
index be384b18e8fd..69e72a800cd1 100644
--- a/drivers/gpu/drm/panfrost/panfrost_drv.c
+++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
@@ -109,6 +109,14 @@ static int panfrost_ioctl_get_param(struct drm_device *ddev, void *data, struct
 #endif
 		break;
 
+	case DRM_PANFROST_PARAM_ALLOWED_JM_CTX_PRIORITIES:
+		param->value = BIT(PANFROST_JM_CTX_PRIORITY_LOW) |
+			       BIT(PANFROST_JM_CTX_PRIORITY_MEDIUM);
+
+		if (panfrost_high_prio_allowed(file))
+			param->value |= BIT(PANFROST_JM_CTX_PRIORITY_HIGH);
+		break;
+
 	default:
 		return -EINVAL;
 	}
@@ -286,9 +294,6 @@ static int panfrost_ioctl_submit(struct drm_device *dev, void *data,
 	if (args->pad)
 		return -EINVAL;
 
-	if (args->jm_ctx_handle)
-		return -EINVAL;
-
 	if (!args->jc)
 		return -EINVAL;
 
@@ -552,6 +557,27 @@ static int panfrost_ioctl_set_label_bo(struct drm_device *ddev, void *data,
 	return ret;
 }
 
+static int panfrost_ioctl_jm_ctx_create(struct drm_device *dev, void *data,
+					struct drm_file *file)
+{
+	return panfrost_jm_ctx_create(file, data);
+}
+
+static int panfrost_ioctl_jm_ctx_destroy(struct drm_device *dev, void *data,
+					 struct drm_file *file)
+{
+	const struct drm_panfrost_jm_ctx_destroy *args = data;
+
+	if (args->pad)
+		return -EINVAL;
+
+	/* We can't destroy the default context created when the file is opened. */
+	if (!args->handle)
+		return -EINVAL;
+
+	return panfrost_jm_ctx_destroy(file, args->handle);
+}
+
 int panfrost_unstable_ioctl_check(void)
 {
 	if (!unstable_ioctls)
@@ -619,6 +645,8 @@ static const struct drm_ioctl_desc panfrost_drm_driver_ioctls[] = {
 	PANFROST_IOCTL(PERFCNT_DUMP,	perfcnt_dump,	DRM_RENDER_ALLOW),
 	PANFROST_IOCTL(MADVISE,		madvise,	DRM_RENDER_ALLOW),
 	PANFROST_IOCTL(SET_LABEL_BO,	set_label_bo,	DRM_RENDER_ALLOW),
+	PANFROST_IOCTL(JM_CTX_CREATE,	jm_ctx_create,	DRM_RENDER_ALLOW),
+	PANFROST_IOCTL(JM_CTX_DESTROY,	jm_ctx_destroy,	DRM_RENDER_ALLOW),
 };
 
 static void panfrost_gpu_show_fdinfo(struct panfrost_device *pfdev,
@@ -715,6 +743,8 @@ static void panfrost_debugfs_init(struct drm_minor *minor)
  * - 1.3 - adds JD_REQ_CYCLE_COUNT job requirement for SUBMIT
  *       - adds SYSTEM_TIMESTAMP and SYSTEM_TIMESTAMP_FREQUENCY queries
  * - 1.4 - adds SET_LABEL_BO
+ * - 1.5 - adds JM_CTX_{CREATE,DESTROY} ioctls and extend SUBMIT to allow
+ *	   context creation with configurable priorities/affinity
  */
 static const struct drm_driver panfrost_drm_driver = {
 	.driver_features	= DRIVER_RENDER | DRIVER_GEM | DRIVER_SYNCOBJ,
-- 
2.51.0


