Return-Path: <linux-kernel+bounces-812964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D483BB53EEB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 01:02:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90A973ACF3F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 23:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 308782F5338;
	Thu, 11 Sep 2025 23:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TW4ZNleh"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006752F6562
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 23:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757631748; cv=none; b=e0Ak/WonsFtAo3tRNZb9VpPyq56IR8Zr2h5TuwpA5Z8WgboMJiKBZmxIN4CjtiPtYRpNtDSmx+Z1J5YsVT4aQwyhkY2nKmrmQxodE5MNLRwrVrR4NSbdMQ7N0GhKeFU4gLjky6PeIfZZA8sDVC7kQG6mxWGL4vzNhLogkuF8MTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757631748; c=relaxed/simple;
	bh=W150JFoMYx09O4E3+LSOEgsW2cosMKOfQWEo0EsBvEo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HQsHDLx29W9dUDZADSaV4+vv9XhnSaSVa/2Yz1xhda9RIxb8i/TVKeHM+0jacYmUbNls1kLmUR1XkPRsmI1zNh1VcIITPUKS2ObyA3yzXvNh5dJLyzB3/1Q+wXT9AnzNPI7qI3dQ2G4eHTUjxxyV6vvdP/U2MXo3k/iJjFV3ucU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TW4ZNleh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757631746;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oki6K+pbJ2z7ZPJUTxki20bybBrN7tk4yeB2QThY9ug=;
	b=TW4ZNlehcGaA5TgqEysfnC9OKNrLzKblfighz9NRXVSLmk5Lyx2mZpGSq+I+UbUbbVtQY2
	STxbCDMYpNsP1TR7u9v9XJfOUFRAPtclCvEwIUt7HM37q4fBK9a9pFZ+TXzfYQeYtVAKPR
	VeVcpaYR5Ofcd+zbts2U58rSQr+z7fs=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-558-XX4uhEhoOXOhFIOjDA4c5A-1; Thu,
 11 Sep 2025 19:02:20 -0400
X-MC-Unique: XX4uhEhoOXOhFIOjDA4c5A-1
X-Mimecast-MFC-AGG-ID: XX4uhEhoOXOhFIOjDA4c5A_1757631738
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F3C7519107DB;
	Thu, 11 Sep 2025 23:02:17 +0000 (UTC)
Received: from chopper.redhat.com (unknown [10.22.64.100])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CE1E01944CCA;
	Thu, 11 Sep 2025 23:02:13 +0000 (UTC)
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
Subject: [PATCH v4 2/3] drm/gem/shmem: Extract drm_gem_shmem_release() from drm_gem_shmem_free()
Date: Thu, 11 Sep 2025 18:57:39 -0400
Message-ID: <20250911230147.650077-3-lyude@redhat.com>
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

At the moment, the way that we currently free gem shmem objects is not
ideal for rust bindings. drm_gem_shmem_free() releases all of the
associated memory with a gem shmem object with kfree(), which means that
for us to correctly release a gem shmem object in rust we have to manually
drop all of the contents of our gem object structure in-place by hand
before finally calling drm_gem_shmem_free() to release the shmem resources
and the allocation for the gem object.

Since the only reason this is an issue is because of drm_gem_shmem_free()
calling kfree(), we can fix this by splitting drm_gem_shmem_free() out into
itself and drm_gem_shmem_release(), where drm_gem_shmem_release() releases
the various gem shmem resources without freeing the structure itself. With
this, we can safely re-acquire the KBox for the gem object's memory
allocation and let rust handle cleaning up all of the other struct members
automatically.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>

---
V4:
* Fix accidental word salad that made it into the commit message

 drivers/gpu/drm/drm_gem_shmem_helper.c | 23 ++++++++++++++++++-----
 include/drm/drm_gem_shmem_helper.h     |  1 +
 2 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
index b20a7b75c7228..50594cf8e17cc 100644
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
 
@@ -208,6 +208,19 @@ void drm_gem_shmem_free(struct drm_gem_shmem_object *shmem)
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
index 235dc33127b9a..589f7bfe7506e 100644
--- a/include/drm/drm_gem_shmem_helper.h
+++ b/include/drm/drm_gem_shmem_helper.h
@@ -112,6 +112,7 @@ struct drm_gem_shmem_object *drm_gem_shmem_create(struct drm_device *dev, size_t
 struct drm_gem_shmem_object *drm_gem_shmem_create_with_mnt(struct drm_device *dev,
 							   size_t size,
 							   struct vfsmount *gemfs);
+void drm_gem_shmem_release(struct drm_gem_shmem_object *shmem);
 void drm_gem_shmem_free(struct drm_gem_shmem_object *shmem);
 
 void drm_gem_shmem_put_pages_locked(struct drm_gem_shmem_object *shmem);
-- 
2.51.0


