Return-Path: <linux-kernel+bounces-812735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51DBDB53BFD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 20:58:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 431AFAA5837
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 18:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE9CE257843;
	Thu, 11 Sep 2025 18:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NfNBwYlq"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799EE23A994
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 18:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757617082; cv=none; b=Amr3ofYxhInLLrEfpJILn1lswEGR8V0UzSLUav+YTHDniZgDLoySmUqJ2Y2093UF3LVNoyapqRvMO/iqok794C2Tp2X8VJL8ooo3ko3C1TUF/szSWCqyDifcQRZhDzPxFINenON2QWgc9n2ED12WjlUqrh5u6T8mnRXM7a8bLlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757617082; c=relaxed/simple;
	bh=oeGFhXqo5ZBKpJuMsDxY9Z2BX4a2XSfCzho+kOY2tf0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uttxI6bTlTboYE+T3BpxSTTR+6zjMEB/LVQd1dW/CJYc0RpTqpg57nBBJgf4IlvAGL4/+1Mdyqhua/c1QL3+k9vjmT5LfRCnhMSGFejTAXDkXUhxiVvpGMf9joQui1ieGK8hkNmIBCCSRG3/Fub+76FsgOC44TicUOYvqm1ohyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NfNBwYlq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757617079;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0Thl7XTeKGfzx0k+KJGqjMASEd2oDUNwwwlWWZaVka4=;
	b=NfNBwYlqDmropa+D3fL6uXN6M552h+Pryg880NCV8kcWImWJn5frGWIl5xwMquS6nJ1JXC
	4Ef6E5SJtDq4mx/RHUXYC/6hUEoU12Pjt92TAIj8SLG/Z/pboA0HNCGsyyfJdQfO7Nu6aG
	sJGz5FstRKyhGRaXmIwhNZ2VbvtVs5c=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-589-Me-ESYeZM1KFRFAsngsSDA-1; Thu,
 11 Sep 2025 14:57:53 -0400
X-MC-Unique: Me-ESYeZM1KFRFAsngsSDA-1
X-Mimecast-MFC-AGG-ID: Me-ESYeZM1KFRFAsngsSDA_1757617070
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C22C519560BC;
	Thu, 11 Sep 2025 18:57:48 +0000 (UTC)
Received: from chopper.redhat.com (unknown [10.22.65.223])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0484719560BE;
	Thu, 11 Sep 2025 18:57:43 +0000 (UTC)
From: Lyude Paul <lyude@redhat.com>
To: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org
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
	Danilo Krummrich <dakr@kernel.org>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Shankari Anand <shankari.ak0208@gmail.com>,
	Asahi Lina <lina+kernel@asahilina.net>
Subject: [PATCH v2 1/2] Partially revert "rust: drm: gem: Implement AlwaysRefCounted for all gem objects automatically"
Date: Thu, 11 Sep 2025 14:56:04 -0400
Message-ID: <20250911185739.511510-1-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

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

---
 rust/kernel/drm/gem/mod.rs | 36 ++++++++++++++++--------------------
 1 file changed, 16 insertions(+), 20 deletions(-)

diff --git a/rust/kernel/drm/gem/mod.rs b/rust/kernel/drm/gem/mod.rs
index 6ccbb25628a1e..daa92f0eac68e 100644
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

base-commit: cf4fd52e323604ccfa8390917593e1fb965653ee
-- 
2.51.0


