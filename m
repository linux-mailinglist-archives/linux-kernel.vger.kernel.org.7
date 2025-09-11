Return-Path: <linux-kernel+bounces-812963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F03DBB53EE9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 01:02:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A719C4422DE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 23:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9623D2F5483;
	Thu, 11 Sep 2025 23:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KO9sHN/9"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518472F617E
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 23:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757631744; cv=none; b=IAKLQd3yQocZhsGNCWknFc1JKq6rsbepQGGYs7WCO2y/0u5yBbXWff4034eGaEpaPcThfbMmytchryoCsr/+ZnwLdAmAuYuqBfuq+BhpUFL1PNdnuI6linZa/aS5jMu6PbMQ/+Ln/KizXVAdlofdDUzkMMFclK+6exx/4kPB2uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757631744; c=relaxed/simple;
	bh=zkb+msNpNOoGW826Z4j/D1GwFn1YWFvM+oLUjtAxGsk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eEu0RFbbcQ98zPjuA9heGpb/TEoUdmWJ1mjtqhuzCe7GksJsh12dz4NySTtX65mkERsr7XS20Fzbsrrv12X9fgZ3VvUU0heqerLEAHojkDXFkjYR7hqd9VdGD8Tx85ajblrUkQUU/DhR8YlwjzWaW0wqmEwIlYDggFqtJrUNkUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KO9sHN/9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757631742;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xIN0/MhzULHsO+NOutgb84cZx03vcIUbF7Dq4BB0wAc=;
	b=KO9sHN/9RQbbHh+TrLAk5MkHYbFeAGqUBQFeriLbkTh2ZbjcAtB7RYaDD1wUv3IYX7enYO
	wZJRxIfqL7WFKht5BqcaSP3/BFT+QhqDa9c0gl6ONUumgyCjbEcq3tgNFwf3iRWyoOc2iP
	9utAu464R+nP8eEyXj8Dna4RLjNhhDg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-260-fb-PDMdBOBWUvQhtt4BQgQ-1; Thu,
 11 Sep 2025 19:02:16 -0400
X-MC-Unique: fb-PDMdBOBWUvQhtt4BQgQ-1
X-Mimecast-MFC-AGG-ID: fb-PDMdBOBWUvQhtt4BQgQ_1757631733
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 25A5E180057B;
	Thu, 11 Sep 2025 23:02:13 +0000 (UTC)
Received: from chopper.redhat.com (unknown [10.22.64.100])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1493219432AE;
	Thu, 11 Sep 2025 23:02:08 +0000 (UTC)
From: Lyude Paul <lyude@redhat.com>
To: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Cc: Daniel Almeida <daniel.almeida@collabora.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH v4 1/3] drm/gem/shmem: Extract drm_gem_shmem_init() from drm_gem_shmem_create()
Date: Thu, 11 Sep 2025 18:57:38 -0400
Message-ID: <20250911230147.650077-2-lyude@redhat.com>
In-Reply-To: <20250911230147.650077-1-lyude@redhat.com>
References: <20250911230147.650077-1-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

With gem objects in rust, the most ideal way for us to be able to handle
gem shmem object creation is to be able to handle the memory allocation of
a gem object ourselves - and then have the DRM gem shmem helpers initialize
the object we've allocated afterwards. So, let's spit out
drm_gem_shmem_init() from drm_gem_shmem_create() to allow for doing this.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
---
 drivers/gpu/drm/drm_gem_shmem_helper.c | 75 +++++++++++++++++---------
 include/drm/drm_gem_shmem_helper.h     |  1 +
 2 files changed, 51 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
index 5d1349c34afd3..b20a7b75c7228 100644
--- a/drivers/gpu/drm/drm_gem_shmem_helper.c
+++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
@@ -48,28 +48,12 @@ static const struct drm_gem_object_funcs drm_gem_shmem_funcs = {
 	.vm_ops = &drm_gem_shmem_vm_ops,
 };
 
-static struct drm_gem_shmem_object *
-__drm_gem_shmem_create(struct drm_device *dev, size_t size, bool private,
-		       struct vfsmount *gemfs)
+static int __drm_gem_shmem_init(struct drm_device *dev, struct drm_gem_shmem_object *shmem,
+				size_t size, bool private, struct vfsmount *gemfs)
 {
-	struct drm_gem_shmem_object *shmem;
-	struct drm_gem_object *obj;
+	struct drm_gem_object *obj = &shmem->base;
 	int ret = 0;
 
-	size = PAGE_ALIGN(size);
-
-	if (dev->driver->gem_create_object) {
-		obj = dev->driver->gem_create_object(dev, size);
-		if (IS_ERR(obj))
-			return ERR_CAST(obj);
-		shmem = to_drm_gem_shmem_obj(obj);
-	} else {
-		shmem = kzalloc(sizeof(*shmem), GFP_KERNEL);
-		if (!shmem)
-			return ERR_PTR(-ENOMEM);
-		obj = &shmem->base;
-	}
-
 	if (!obj->funcs)
 		obj->funcs = &drm_gem_shmem_funcs;
 
@@ -81,7 +65,7 @@ __drm_gem_shmem_create(struct drm_device *dev, size_t size, bool private,
 	}
 	if (ret) {
 		drm_gem_private_object_fini(obj);
-		goto err_free;
+		return ret;
 	}
 
 	ret = drm_gem_create_mmap_offset(obj);
@@ -102,14 +86,55 @@ __drm_gem_shmem_create(struct drm_device *dev, size_t size, bool private,
 				     __GFP_RETRY_MAYFAIL | __GFP_NOWARN);
 	}
 
-	return shmem;
-
+	return 0;
 err_release:
 	drm_gem_object_release(obj);
-err_free:
-	kfree(obj);
+	return ret;
+}
 
-	return ERR_PTR(ret);
+/**
+ * drm_gem_shmem_init - Initialize an allocated object.
+ * @dev: DRM device
+ * @obj: The allocated shmem GEM object.
+ *
+ * Returns:
+ * 0 on success, or a negative error code on failure.
+ */
+int drm_gem_shmem_init(struct drm_device *dev, struct drm_gem_shmem_object *shmem, size_t size)
+{
+	return __drm_gem_shmem_init(dev, shmem, size, false, NULL);
+}
+EXPORT_SYMBOL_GPL(drm_gem_shmem_init);
+
+static struct drm_gem_shmem_object *
+__drm_gem_shmem_create(struct drm_device *dev, size_t size, bool private,
+		       struct vfsmount *gemfs)
+{
+	struct drm_gem_shmem_object *shmem;
+	struct drm_gem_object *obj;
+	int ret = 0;
+
+	size = PAGE_ALIGN(size);
+
+	if (dev->driver->gem_create_object) {
+		obj = dev->driver->gem_create_object(dev, size);
+		if (IS_ERR(obj))
+			return ERR_CAST(obj);
+		shmem = to_drm_gem_shmem_obj(obj);
+	} else {
+		shmem = kzalloc(sizeof(*shmem), GFP_KERNEL);
+		if (!shmem)
+			return ERR_PTR(-ENOMEM);
+		obj = &shmem->base;
+	}
+
+	ret = __drm_gem_shmem_init(dev, shmem, size, private, gemfs);
+	if (ret) {
+		kfree(obj);
+		return ERR_PTR(ret);
+	}
+
+	return shmem;
 }
 /**
  * drm_gem_shmem_create - Allocate an object with the given size
diff --git a/include/drm/drm_gem_shmem_helper.h b/include/drm/drm_gem_shmem_helper.h
index 92f5db84b9c22..235dc33127b9a 100644
--- a/include/drm/drm_gem_shmem_helper.h
+++ b/include/drm/drm_gem_shmem_helper.h
@@ -107,6 +107,7 @@ struct drm_gem_shmem_object {
 #define to_drm_gem_shmem_obj(obj) \
 	container_of(obj, struct drm_gem_shmem_object, base)
 
+int drm_gem_shmem_init(struct drm_device *dev, struct drm_gem_shmem_object *shmem, size_t size);
 struct drm_gem_shmem_object *drm_gem_shmem_create(struct drm_device *dev, size_t size);
 struct drm_gem_shmem_object *drm_gem_shmem_create_with_mnt(struct drm_device *dev,
 							   size_t size,
-- 
2.51.0


