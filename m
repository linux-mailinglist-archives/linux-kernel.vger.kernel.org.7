Return-Path: <linux-kernel+bounces-619045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43E94A9B698
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Apr 2025 20:41:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC2DD4C37B7
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Apr 2025 18:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F4AE2857E6;
	Thu, 24 Apr 2025 18:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="ZpjD8Hjx"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0BC32820D0
	for <linux-kernel@vger.kernel.org>; Thu, 24 Apr 2025 18:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745520103; cv=pass; b=Cfhk5zI8Tm7rLcvrn1dAy4UIJxudQDQDlzfufH9xtGYr2nFbTEeNC/E6uhH2cMR8QVRQkzqNJHIRHAoTrorgkDn1nGsKt/bA9US5AplAzMMJRqTYPfq1wE08/tEQeLs8B8ZnYzm8tstbjO8QpQMHCrMHXHb9amY4pIsETzlGHFk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745520103; c=relaxed/simple;
	bh=6QDY2QlgTAoMtxAm4+AWExyyfiAsTbhtjS1gYHPng74=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Y6zElNq3c9hVVvPFO6IwgAojoMYUKXmU2KXF9s6ML2Ntwqd6bCrbz60jhQdJW1NtYBuRezCaHSWxFkzUMBLqBHcI3R+vXAB08LdAvHiT9l9KnE8sWI657D01yuzgaLZYIa+BVdnV83GU95MM3OawYAsPhGq2lellGVl1WgKoe5E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b=ZpjD8Hjx; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1745520081; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Yhe5Xr9t12zwU+IOcKtiaA3sKod3DXZjlytupzWF+5Fi7DRPzBdz3McMvACkn6bXO3GhxxPPJ5aDyvzUAv0ZZsPRZiqr0598Mzr2Mpmd3y5uisFZDwJcdQ1JVr/5SFlykYcIMk83s+07QNO+03KWqnMWYxNs4AF2sN2JM5PLyzE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1745520081; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=wo4SNOOXx8cgEs1+iLeNUIV7Y12odEqq00gmOP6sgDE=; 
	b=RelQ2wx+nIsAnuS8OA5QzaTKqoZbLfy7ClNk3j4IknRwAJGU3dpW3PI2TDCftM+2q0w9yWl2BgSTbk7233EcUElNGwhiG/mmVjY/lGywVy0FoNRRbA6R6MN+QZgTenD9gx8yEkmuV8qb6zETcMtj5cu7AvpPwIx2wSaV0xKmwOg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
	dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1745520081;
	s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=wo4SNOOXx8cgEs1+iLeNUIV7Y12odEqq00gmOP6sgDE=;
	b=ZpjD8HjxiH3FB165+xZW9kOvSnZAF+W5DVJluxxC78R/qyKDcmxwLgaOcuITw0I5
	9w5le2ZCSl4K9E9FoMWFZPlF2/Hcy+B2Rdm3eASk+NDST75TbSvlzlZ53vGzZBBbVaK
	pzkrAyixcEBqT2YQB1r+a+4lrk5rmKZpmr5XMAD8=
Received: by mx.zohomail.com with SMTPS id 1745520078498206.35498888534835;
	Thu, 24 Apr 2025 11:41:18 -0700 (PDT)
From: =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@kernel.org>,
	=?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Steven Price <steven.price@arm.com>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/panthor: Fix build warning when DEBUG_FS is disabled
Date: Thu, 24 Apr 2025 19:40:34 +0100
Message-ID: <20250424184041.356191-1-adrian.larumbe@collabora.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Commit a3707f53eb3f ("drm/panthor: show device-wide list of DRM GEM
objects over DebugFS") causes a build warning and linking error when
built without support for DebugFS, because of a non-inline non-static
function declaration in a header file.

On top of that, the function is only being used inside a single
compilation unit, so there is no point in exposing it as a global
symbol.

This is a follow-up from Arnd Bergmann's first fix.
Also move panthor_gem_debugfs_set_usage_flags() into panthor_gem.c and
declare it static.

Fixes: a3707f53eb3f ("drm/panthor: show device-wide list of DRM GEM objects over DebugFS")
Reported-by: Arnd Bergmann <arnd@arndb.de>
Closes: https://lore.kernel.org/dri-devel/20250424142419.47b9d457@collabora.com/T/#t
Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
 drivers/gpu/drm/panthor/panthor_gem.c | 5 +++++
 drivers/gpu/drm/panthor/panthor_gem.h | 8 --------
 2 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_gem.c b/drivers/gpu/drm/panthor/panthor_gem.c
index 2dcf308094b2..7c00fd77758b 100644
--- a/drivers/gpu/drm/panthor/panthor_gem.c
+++ b/drivers/gpu/drm/panthor/panthor_gem.c
@@ -42,11 +42,16 @@ static void panthor_gem_debugfs_bo_rm(struct panthor_gem_object *bo)
 	mutex_unlock(&ptdev->gems.lock);
 }
 
+static void panthor_gem_debugfs_set_usage_flags(struct panthor_gem_object *bo, u32 usage_flags)
+{
+	bo->debugfs.flags = usage_flags | PANTHOR_DEBUGFS_GEM_USAGE_FLAG_INITIALIZED;
+}
 #else
 static void panthor_gem_debugfs_bo_add(struct panthor_device *ptdev,
 				       struct panthor_gem_object *bo)
 {}
 static void panthor_gem_debugfs_bo_rm(struct panthor_gem_object *bo) {}
+static void panthor_gem_debugfs_set_usage_flags(struct panthor_gem_object *bo, u32 usage_flags) {}
 #endif
 
 static void panthor_gem_free_object(struct drm_gem_object *obj)
diff --git a/drivers/gpu/drm/panthor/panthor_gem.h b/drivers/gpu/drm/panthor/panthor_gem.h
index 4641994ddd7f..4dd732dcd59f 100644
--- a/drivers/gpu/drm/panthor/panthor_gem.h
+++ b/drivers/gpu/drm/panthor/panthor_gem.h
@@ -212,14 +212,6 @@ void panthor_kernel_bo_destroy(struct panthor_kernel_bo *bo);
 #ifdef CONFIG_DEBUG_FS
 void panthor_gem_debugfs_print_bos(struct panthor_device *pfdev,
 				   struct seq_file *m);
-static inline void
-panthor_gem_debugfs_set_usage_flags(struct panthor_gem_object *bo, u32 usage_flags)
-{
-	bo->debugfs.flags = usage_flags | PANTHOR_DEBUGFS_GEM_USAGE_FLAG_INITIALIZED;
-}
-
-#else
-void panthor_gem_debugfs_set_usage_flags(struct panthor_gem_object *bo, u32 usage_flags) {};
 #endif
 
 #endif /* __PANTHOR_GEM_H__ */

base-commit: 3a2b7389feea9a7afd18d58cda59b7a989445f38
-- 
2.48.1


