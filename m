Return-Path: <linux-kernel+bounces-792527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AEEEB3C53F
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 00:43:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC192188D5C9
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 22:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B78652C11FD;
	Fri, 29 Aug 2025 22:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BkWyHfaD"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F8B2D8381
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 22:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756507355; cv=none; b=HbNWYmpr7aZM6LA73EESlwPVhau5pL7HEucL5qH3QyQda/i/e7jEsrdcJb+GOwBihsR0FDcdyFNgM7a4ZLawlzqO80kkao9+/fdQcdJkOFxSwA4kNiuHCdgtNdm9zmPuNZ+ZmH/G6EkqSqvSL4R0Hb+a8Dwcj/UIZfs2DE9TsrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756507355; c=relaxed/simple;
	bh=iLaDtpubQ3yFSxlFHwnSPrbBmSc/n7SRhDXXmqcJ5Cw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HFozH2oJuZBXDATWzO36YQgni8Q9wxViE59yq2SFdKMVskN5fYe1Zt5O+YhdglJU80KFWJ1rCFmMQIimgAAp/z+wAG3w+W101fFiik05b1+4vz78qYhmuZRJ6SwR0OO2c3BQzskF3RAukecKEv8Rs/BareFJuqmA5bldyF1mEe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BkWyHfaD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756507352;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CFSZNST5duWLIhbj/eS+ZDxBrcrRDSRdFnWdf10qxmk=;
	b=BkWyHfaDU/EVeGfOEm6IZp8JJgZfFL5q+ksRDiDZ25+TpU4zs2/aADm1ssnyseoudOlH01
	c79/q48LkiDLHgrJwNFknTDDjgKJsPmSJZ29UhEBgUqJ5iOCCBCLt6mPGCpsqjMpqqG9Jx
	vtKdgPFhKaP2KPgoxMm2zWtvYlpOHMI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-76-V6LUbupkMjmau9Issj1dWQ-1; Fri,
 29 Aug 2025 18:42:26 -0400
X-MC-Unique: V6LUbupkMjmau9Issj1dWQ-1
X-Mimecast-MFC-AGG-ID: V6LUbupkMjmau9Issj1dWQ_1756507343
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D0EDF1800342;
	Fri, 29 Aug 2025 22:42:23 +0000 (UTC)
Received: from chopper.redhat.com (unknown [10.22.80.78])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 133DD18003FC;
	Fri, 29 Aug 2025 22:42:19 +0000 (UTC)
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
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH v3 08/14] drm/gem/shmem: Extract drm_gem_shmem_release() from drm_gem_shmem_free()
Date: Fri, 29 Aug 2025 18:35:23 -0400
Message-ID: <20250829224116.477990-9-lyude@redhat.com>
In-Reply-To: <20250829224116.477990-1-lyude@redhat.com>
References: <20250829224116.477990-1-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

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
2.50.0


