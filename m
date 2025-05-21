Return-Path: <linux-kernel+bounces-658207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 76BDDABFE85
	for <lists+linux-kernel@lfdr.de>; Wed, 21 May 2025 22:54:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8A877A13C9
	for <lists+linux-kernel@lfdr.de>; Wed, 21 May 2025 20:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4478E2C17B0;
	Wed, 21 May 2025 20:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MBLaDBtU"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B4F2C17A3
	for <linux-kernel@vger.kernel.org>; Wed, 21 May 2025 20:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747860470; cv=none; b=i6kSz8Gfiq6BcAODTSzP1xB7ABJUIaZ3GA+tPKpWP3qWJ2u6wbQcyl5mGPLNQ2yHqF+NErVMlZpyB+uk95gGikOvub72JGrnbqYnBB2uli8SEGd29D2o60Vnh6dkyOqQgwsK5IBsxrNGs6sKXBDTJRivm8JutiVm02Y8JoTiQ34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747860470; c=relaxed/simple;
	bh=fK1MynsL225wWo3dHGnSbcLRkU5iw/wknAYv04lLgS8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AZusfTxSVKQfUEoEMLDEg6knG5VAsR7stJMF/RB++9wvMxCieEL8AKLo15uxS0cLcAb/yE8U8h0EgT//V/kW7e4xDX23yhovLmKsYVOWreCt5V/yT84mPMKarM4kFXz6wJH9CzcfyB7XSbCFafPwbMUVKVqsnZnHXkEWpjwywus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MBLaDBtU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747860467;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T5V2okoaOmmH00na+R0WqQ3AiEj1bd5ShKvbaofJb94=;
	b=MBLaDBtUpOIf9cKsqP+4gsoWhiARPogI42Jc9mzwXDj2EXsKcLeyUKPErpgkQ1L6REUNpr
	LmBOpt4im40onJvy+oq6cRHK/5xo9h+83m1E8IuMScGaU5mXPGmdgsSPE2hbHMveJBZYDP
	jQ8nil9aHF0uhJvdyTgd1T3p+QJF6Yo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-562-jZQT4f8POSOyI2WeOE0xgw-1; Wed,
 21 May 2025 16:47:44 -0400
X-MC-Unique: jZQT4f8POSOyI2WeOE0xgw-1
X-Mimecast-MFC-AGG-ID: jZQT4f8POSOyI2WeOE0xgw_1747860461
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 723D1180034A;
	Wed, 21 May 2025 20:47:41 +0000 (UTC)
Received: from chopper.redhat.com (unknown [10.22.80.100])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E441819560B7;
	Wed, 21 May 2025 20:47:36 +0000 (UTC)
From: Lyude Paul <lyude@redhat.com>
To: dri-devel@lists.freedesktop.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH v2 04/12] drm/gem/shmem: Extract drm_gem_shmem_release() from drm_gem_shmem_free()
Date: Wed, 21 May 2025 16:29:11 -0400
Message-ID: <20250521204654.1610607-5-lyude@redhat.com>
In-Reply-To: <20250521204654.1610607-1-lyude@redhat.com>
References: <20250521204654.1610607-1-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

At the moment the way that freeing gem shmem objects is not ideal for rust
bindings. drm_gem_shmem_free() releases all of the associated memory with a
gem shmem object with kfree(), which means that for us to correctly release
a gem shmem object in rust we have to manually drop all of the contents of
our gem object structure in-place by hand before finally calling
drm_gem_shmem_free() to release the shmem resources and the allocation for
the gem object.

Since the only reason this is an issue is because of drm_gem_shmem_free()
calling kfree(), we can fix this by splitting drm_gem_shmem_free() out into
itself and drm_gem_shmem_release(), where drm_gem_shmem_release() releases
the various gem shmem resources without freeing the structure itself. With
this, we can safely re-acquire the KBox for the gem object's memory
allocation and let rust handle cleaning up all of the other struct members
automatically.

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/drm_gem_shmem_helper.c | 23 ++++++++++++++++++-----
 include/drm/drm_gem_shmem_helper.h     |  1 +
 2 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
index f3e88fb579b52..42652be37ba77 100644
--- a/drivers/gpu/drm/drm_gem_shmem_helper.c
+++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
@@ -175,13 +175,13 @@ struct drm_gem_shmem_object *drm_gem_shmem_create_with_mnt(struct drm_device *de
 EXPORT_SYMBOL_GPL(drm_gem_shmem_create_with_mnt);
 
 /**
- * drm_gem_shmem_free - Free resources associated with a shmem GEM object
- * @shmem: shmem GEM object to free
+ * drm_gem_shmem_release - Release resources associated with a shmem GEM object.
+ * @shmem: shmem GEM object
  *
- * This function cleans up the GEM object state and frees the memory used to
- * store the object itself.
+ * This function cleans up the GEM object state, but does not free the memory used to store the
+ * object itself. This function is meant to be a dedicated helper for the Rust GEM bindings.
  */
-void drm_gem_shmem_free(struct drm_gem_shmem_object *shmem)
+void drm_gem_shmem_release(struct drm_gem_shmem_object *shmem)
 {
 	struct drm_gem_object *obj = &shmem->base;
 
@@ -207,6 +207,19 @@ void drm_gem_shmem_free(struct drm_gem_shmem_object *shmem)
 	}
 
 	drm_gem_object_release(obj);
+}
+EXPORT_SYMBOL_GPL(drm_gem_shmem_release);
+
+/**
+ * drm_gem_shmem_free - Free resources associated with a shmem GEM object
+ * @shmem: shmem GEM object to free
+ *
+ * This function cleans up the GEM object state and frees the memory used to
+ * store the object itself.
+ */
+void drm_gem_shmem_free(struct drm_gem_shmem_object *shmem)
+{
+	drm_gem_shmem_release(shmem);
 	kfree(shmem);
 }
 EXPORT_SYMBOL_GPL(drm_gem_shmem_free);
diff --git a/include/drm/drm_gem_shmem_helper.h b/include/drm/drm_gem_shmem_helper.h
index ea0785d1700a5..e009022b0bb48 100644
--- a/include/drm/drm_gem_shmem_helper.h
+++ b/include/drm/drm_gem_shmem_helper.h
@@ -101,6 +101,7 @@ struct drm_gem_shmem_object *drm_gem_shmem_create(struct drm_device *dev, size_t
 struct drm_gem_shmem_object *drm_gem_shmem_create_with_mnt(struct drm_device *dev,
 							   size_t size,
 							   struct vfsmount *gemfs);
+void drm_gem_shmem_release(struct drm_gem_shmem_object *shmem);
 void drm_gem_shmem_free(struct drm_gem_shmem_object *shmem);
 
 void drm_gem_shmem_put_pages(struct drm_gem_shmem_object *shmem);
-- 
2.49.0


