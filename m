Return-Path: <linux-kernel+bounces-628836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EFADAA62F7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 May 2025 20:38:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9F51178867
	for <lists+linux-kernel@lfdr.de>; Thu,  1 May 2025 18:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6899A22370F;
	Thu,  1 May 2025 18:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SUiPDmGf"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C15122371F
	for <linux-kernel@vger.kernel.org>; Thu,  1 May 2025 18:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746124688; cv=none; b=so3NYubDD/vxKkuft68yGXZ0OoJk+cQMGE/klCCLFBZEWNKqwjP696YobIUnEr4vl/XpwWQhKfZzQ/20fUdI+UaB5x5CLseCC5ZQJb/dwsbtuaT7Q3Znx3I7smhp5FcNe1iL2THvVImvc7gnZKZwv94I3bBo/Vc4S888f8r+Cik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746124688; c=relaxed/simple;
	bh=DxnFwbyrPKOcqAtYcepj6/QO3dHzr/O5vFh2+K3OJCQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W5ELBmuh9KAAH8rhbAHfFuH2zCPTbFnVWD/YNC3Uywt3dytOReBP882JM1vuJYfbynwoyMYZlTPPht23GTMxPjI4rYgVAvY4ThnJHRBRLa/rB9bicxVV0e+TGDsrG5vmy9axcQZMTmKXr2lilfbE3GfHyohaP58KI7C2wM7iEaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SUiPDmGf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746124685;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1DK3REbEj1TGDhbQ2B+tFzyd7w0GXeJQ4DMYyVW608g=;
	b=SUiPDmGfjhrt9/NTwPd6SitTgNGq4IoK0tgAMLYoGr9al7NIVSy9zYskVCS8MMOvTbBHbs
	jusIAVlt+g6pzP1oyHCaf9SNCGDQNCO8O8oTJlyMxwX6FdOc5e673LtBMZAgdbV+AIxBu2
	Qwp3rNoT/BSHNSrQco1/AEb2GjKr/lE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-116-JMktBwGQPSmXujas70seOQ-1; Thu,
 01 May 2025 14:38:01 -0400
X-MC-Unique: JMktBwGQPSmXujas70seOQ-1
X-Mimecast-MFC-AGG-ID: JMktBwGQPSmXujas70seOQ_1746124675
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7C1B219560AF;
	Thu,  1 May 2025 18:37:55 +0000 (UTC)
Received: from chopper.redhat.com (unknown [10.22.88.132])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1E60C1800365;
	Thu,  1 May 2025 18:37:51 +0000 (UTC)
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
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Asahi Lina <lina@asahilina.net>
Subject: [PATCH 4/4] rust: drm: gem: Implement AlwaysRefCounted for all gem objects automatically
Date: Thu,  1 May 2025 14:33:19 -0400
Message-ID: <20250501183717.2058109-5-lyude@redhat.com>
In-Reply-To: <20250501183717.2058109-1-lyude@redhat.com>
References: <20250501183717.2058109-1-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Currently we are requiring AlwaysRefCounted in most trait bounds for gem
objects, and implementing it by hand for our only current type of gem
object. However, all gem objects use the same functions for reference
counting - and all gem objects support reference counting.

We're planning on adding support for shmem gem objects, let's move this
around a bit by instead making IntoGEMObject require AlwaysRefCounted as a
trait bound, and then provide a blanket AlwaysRefCounted implementation for
any object that implements IntoGEMObject so all gem object types can use
the same AlwaysRefCounted implementation. This also makes things less
verbose by making the AlwaysRefCounted trait bound implicit for any
IntoGEMObject bound.

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 rust/kernel/drm/gem/mod.rs | 47 +++++++++++++++++++-------------------
 1 file changed, 24 insertions(+), 23 deletions(-)

diff --git a/rust/kernel/drm/gem/mod.rs b/rust/kernel/drm/gem/mod.rs
index 55b2f1d056c39..929f6c9718362 100644
--- a/rust/kernel/drm/gem/mod.rs
+++ b/rust/kernel/drm/gem/mod.rs
@@ -10,7 +10,7 @@
     drm::driver::{AllocImpl, AllocOps},
     error::{to_result, Result},
     prelude::*,
-    types::{ARef, Opaque},
+    types::{ARef, AlwaysRefCounted, Opaque},
 };
 use core::{mem, ops::Deref, ptr, ptr::NonNull};
 
@@ -36,7 +36,7 @@ fn close(
 }
 
 /// Trait that represents a GEM object subtype
-pub trait IntoGEMObject: Sized + super::private::Sealed {
+pub trait IntoGEMObject: Sized + super::private::Sealed + AlwaysRefCounted {
     /// Owning driver for this type
     type Driver: drm::Driver;
 
@@ -52,6 +52,26 @@ pub trait IntoGEMObject: Sized + super::private::Sealed {
     unsafe fn as_ref<'a>(self_ptr: *mut bindings::drm_gem_object) -> &'a Self;
 }
 
+// SAFETY: All gem objects are refcounted.
+unsafe impl<T: IntoGEMObject> AlwaysRefCounted for T {
+    fn inc_ref(&self) {
+        // SAFETY: The existence of a shared reference guarantees that the refcount is non-zero.
+        unsafe { bindings::drm_gem_object_get(self.as_gem_obj()) };
+    }
+
+    unsafe fn dec_ref(obj: NonNull<Self>) {
+        // SAFETY: We either hold the only refcount on `obj`, or one of many - meaning that no one
+        // else could possibly hold a mutable reference to `obj` and thus this immutable reference
+        // is safe.
+        let obj = unsafe { obj.as_ref() }.as_gem_obj();
+
+        // SAFETY:
+        // - The safety requirements guarantee that the refcount is non-zero.
+        // - We hold no references to `obj` now, making it safe for us to potentially deallocate it.
+        unsafe { bindings::drm_gem_object_put(obj) };
+    }
+}
+
 /// Trait which must be implemented by drivers using base GEM objects.
 pub trait DriverObject: BaseDriverObject<Object<Self>> {
     /// Parent `Driver` for this object.
@@ -110,10 +130,7 @@ unsafe fn as_ref<'a>(self_ptr: *mut bindings::drm_gem_object) -> &'a Self {
 }
 
 /// Base operations shared by all GEM object classes
-pub trait BaseObject
-where
-    Self: crate::types::AlwaysRefCounted + IntoGEMObject,
-{
+pub trait BaseObject: IntoGEMObject {
     /// Returns the size of the object in bytes.
     fn size(&self) -> usize {
         // SAFETY: `self.into_gem_obj()` is guaranteed to be a pointer to a valid `struct
@@ -175,7 +192,7 @@ fn create_mmap_offset(&self) -> Result<u64> {
     }
 }
 
-impl<T> BaseObject for T where Self: crate::types::AlwaysRefCounted + IntoGEMObject {}
+impl<T: IntoGEMObject> BaseObject for T {}
 
 /// A base GEM object.
 ///
@@ -269,22 +286,6 @@ extern "C" fn free_callback(obj: *mut bindings::drm_gem_object) {
     }
 }
 
-// SAFETY: Instances of `Object<T>` are always reference-counted.
-unsafe impl<T: DriverObject> crate::types::AlwaysRefCounted for Object<T> {
-    fn inc_ref(&self) {
-        // SAFETY: The existence of a shared reference guarantees that the refcount is non-zero.
-        unsafe { bindings::drm_gem_object_get(self.as_raw()) };
-    }
-
-    unsafe fn dec_ref(obj: NonNull<Self>) {
-        // SAFETY: `obj` is a valid pointer to an `Object<T>`.
-        let obj = unsafe { obj.as_ref() };
-
-        // SAFETY: The safety requirements guarantee that the refcount is non-zero.
-        unsafe { bindings::drm_gem_object_put(obj.as_raw()) }
-    }
-}
-
 impl<T: DriverObject> super::private::Sealed for Object<T> {}
 
 impl<T: DriverObject> Deref for Object<T> {
-- 
2.48.1


