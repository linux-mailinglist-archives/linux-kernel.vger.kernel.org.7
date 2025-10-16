Return-Path: <linux-kernel+bounces-856953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E3F8BE5891
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 23:11:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F00B650672C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 21:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0ED12E62A6;
	Thu, 16 Oct 2025 21:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BbQ0wq5L"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4E92E0928
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 21:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760649019; cv=none; b=nFxeNZKzQ/tUiDMdMIJT4c+xZL5+xak1hdu3SX1ucfZxfJDArSk7DtNusU8cdxWvtWaZoH9wfXUqAFDH6QyDmg4kP76nZ9U8J8QtrESGFcAxwH4rBJBp8wX+vlDEWCSjRJfQkKQgHnrRZ+ez0pOvoPj+qabfPNqpiO0hXxuuvtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760649019; c=relaxed/simple;
	bh=IkvvMLfAcSiqjzXM7tBkYN5m8wSa78Ue7+7guvvGX2U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=COvU5m2OHfpdgANRZMjf5/DrBQYH2K5pKIqsqk2uWMkfjVBn2tS7+WBPrV9dg0ANfxwIgGUnHoB6otzsdjPyq3BIiGi4X6bkHKuN2DILnBbmoZpxOCvX4BtaEknRb4RPuy6pdEld9OV1bWIVije4OZ12tGLTr2sjv5mxobKcOlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BbQ0wq5L; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760649016;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sg6MAGoXEC+Wnc3smQsly6XUqGdLH2hnjBmbClcx1kM=;
	b=BbQ0wq5LxRZLm6hZ3miwitwJQjRtsCLSniURA3c5WgZM7vPU2kuABLXDgJSTyVQGvTQdBi
	45PUgAlQExZCnDLllgZZPdET2J1CrGUNBRQlgfyQBUIiSQQXQyYFJZ2jsBBohhuXThcbw5
	d306U2KJwiVJ90w6ttFqYTKxuwRoQxg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-436-aIPLdvCGNdyZv-bAZjA2HQ-1; Thu,
 16 Oct 2025 17:10:13 -0400
X-MC-Unique: aIPLdvCGNdyZv-bAZjA2HQ-1
X-Mimecast-MFC-AGG-ID: aIPLdvCGNdyZv-bAZjA2HQ_1760649010
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 780DF180065F;
	Thu, 16 Oct 2025 21:10:10 +0000 (UTC)
Received: from chopper.lan (unknown [10.22.80.252])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DF02B300019F;
	Thu, 16 Oct 2025 21:10:07 +0000 (UTC)
From: Lyude Paul <lyude@redhat.com>
To: dri-devel@lists.freedesktop.org,
	rust-for-linux@vger.kernel.org,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Alice Ryhl <aliceryhl@google.com>
Cc: Danilo Krummrich <dakr@kernel.org>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Asahi Lina <lina+kernel@asahilina.net>,
	Shankari Anand <shankari.ak0208@gmail.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 1/9] Partially revert "rust: drm: gem: Implement AlwaysRefCounted for all gem objects automatically"
Date: Thu, 16 Oct 2025 17:08:14 -0400
Message-ID: <20251016210955.2813186-2-lyude@redhat.com>
In-Reply-To: <20251016210955.2813186-1-lyude@redhat.com>
References: <20251016210955.2813186-1-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Currently in order to implement AlwaysRefCounted for gem objects, we use a
blanket implementation:

  unsafe impl<T: IntoGEMObject> AlwaysRefCounted for T { … }

While this technically works, it comes with the rather unfortunate downside
that attempting to create a similar blanket implementation in any other
kernel crate will now fail in a rather confusing way.

Using an example from the (not yet upstream) rust DRM KMS bindings, if we
were to add:

  unsafe impl<T: RcModeObject> AlwaysRefCounted for T { … }

Then the moment that both blanket implementations are present in the same
kernel tree, compilation fails with the following:

   error[E0119]: conflicting implementations of trait `types::AlwaysRefCounted`
      --> rust/kernel/drm/kms.rs:504:1
       |
   504 | unsafe impl<T: RcModeObject> AlwaysRefCounted for T {
       | ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ conflicting implementation
       |
      ::: rust/kernel/drm/gem/mod.rs:97:1
       |
   97  | unsafe impl<T: IntoGEMObject> AlwaysRefCounted for T {
       | ---------------------------------------------------- first implementation here

So, revert these changes for now. The proper fix for this is to introduce a
macro for copy/pasting the same implementation of AlwaysRefCounted around.

This reverts commit 38cb08c3fcd3f3b1d0225dcec8ae50fab5751549.

Signed-off-by: Lyude Paul <lyude@redhat.com>

---
V2:
* Rewrite the commit message to explain a bit more why we don't want a
  blanket implementation for this.

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 rust/kernel/drm/gem/mod.rs | 36 ++++++++++++++++--------------------
 1 file changed, 16 insertions(+), 20 deletions(-)

diff --git a/rust/kernel/drm/gem/mod.rs b/rust/kernel/drm/gem/mod.rs
index 30c853988b942..20c2769a8c9d6 100644
--- a/rust/kernel/drm/gem/mod.rs
+++ b/rust/kernel/drm/gem/mod.rs
@@ -55,26 +55,6 @@ pub trait IntoGEMObject: Sized + super::private::Sealed + AlwaysRefCounted {
     unsafe fn from_raw<'a>(self_ptr: *mut bindings::drm_gem_object) -> &'a Self;
 }
 
-// SAFETY: All gem objects are refcounted.
-unsafe impl<T: IntoGEMObject> AlwaysRefCounted for T {
-    fn inc_ref(&self) {
-        // SAFETY: The existence of a shared reference guarantees that the refcount is non-zero.
-        unsafe { bindings::drm_gem_object_get(self.as_raw()) };
-    }
-
-    unsafe fn dec_ref(obj: NonNull<Self>) {
-        // SAFETY: We either hold the only refcount on `obj`, or one of many - meaning that no one
-        // else could possibly hold a mutable reference to `obj` and thus this immutable reference
-        // is safe.
-        let obj = unsafe { obj.as_ref() }.as_raw();
-
-        // SAFETY:
-        // - The safety requirements guarantee that the refcount is non-zero.
-        // - We hold no references to `obj` now, making it safe for us to potentially deallocate it.
-        unsafe { bindings::drm_gem_object_put(obj) };
-    }
-}
-
 extern "C" fn open_callback<T: DriverObject>(
     raw_obj: *mut bindings::drm_gem_object,
     raw_file: *mut bindings::drm_file,
@@ -273,6 +253,22 @@ extern "C" fn free_callback(obj: *mut bindings::drm_gem_object) {
     }
 }
 
+// SAFETY: Instances of `Object<T>` are always reference-counted.
+unsafe impl<T: DriverObject> crate::types::AlwaysRefCounted for Object<T> {
+    fn inc_ref(&self) {
+        // SAFETY: The existence of a shared reference guarantees that the refcount is non-zero.
+        unsafe { bindings::drm_gem_object_get(self.as_raw()) };
+    }
+
+    unsafe fn dec_ref(obj: NonNull<Self>) {
+        // SAFETY: `obj` is a valid pointer to an `Object<T>`.
+        let obj = unsafe { obj.as_ref() };
+
+        // SAFETY: The safety requirements guarantee that the refcount is non-zero.
+        unsafe { bindings::drm_gem_object_put(obj.as_raw()) }
+    }
+}
+
 impl<T: DriverObject> super::private::Sealed for Object<T> {}
 
 impl<T: DriverObject> Deref for Object<T> {
-- 
2.51.0


