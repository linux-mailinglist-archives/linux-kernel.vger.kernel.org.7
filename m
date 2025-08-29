Return-Path: <linux-kernel+bounces-792528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F11FBB3C543
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 00:43:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90B2D188E14A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 22:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45C582D8DDA;
	Fri, 29 Aug 2025 22:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WgpYD7g3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761212D9485
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 22:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756507361; cv=none; b=s36ySlxU++FVcwLhOBVPoqdVoBGI5/TjOqtLGjRb7gUbMw4FN5DAnx50D37WtFZ+bxELeCuNUEgwBsomOAd64HoEfedtxZFooOOETstG83zzIMT/pEy12lj8lLrK7mRaQPIUITEUyBpISh4Mh3iIvyon4IYxZv+GEGWg5AqG9r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756507361; c=relaxed/simple;
	bh=EtUsR3n0ijhYX7N98y4g5s32rGilNcHAFZRsCaZ/L7w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YF0tWXbGHui2KI9clLQQvVEKoUY86sE5AzdaFYSGyatSmRp+fKJnfBEWfEbRyZUa1aU/kgFLpS+S1x+876f4HOXcQCOoqGiRJyfhkRXjoE8si7D+/XvMkHewmZGViCLn77jBzFxbIOs1SEI2d8qyN3D+8O+hIuStR7+ZwW4o22A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WgpYD7g3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756507358;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8XT8+KxxRjgfrj31cXlfL66GVxfKzDgbyTpTZPzgyGw=;
	b=WgpYD7g3lGtBqrfg51gsAUbGG47NIaTgr1hgHYhO80KdKNzx/Qo/CviLMaYogCtnwzpJTs
	TGIyehPRk1/01ejGyIk7XUXFQWw0ImvY14VdDe0TsNCBBApHSfGQZXDjdVvpOadtKOIlkc
	qKOOpFZCZn2zeCZiB5onrZX0klkVyEQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-687-gL577qKcMpaQEaDutDZZkw-1; Fri,
 29 Aug 2025 18:42:34 -0400
X-MC-Unique: gL577qKcMpaQEaDutDZZkw-1
X-Mimecast-MFC-AGG-ID: gL577qKcMpaQEaDutDZZkw_1756507351
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BDC9F19560AA;
	Fri, 29 Aug 2025 22:42:31 +0000 (UTC)
Received: from chopper.redhat.com (unknown [10.22.80.78])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 234BC1800280;
	Fri, 29 Aug 2025 22:42:26 +0000 (UTC)
From: Lyude Paul <lyude@redhat.com>
To: dri-devel@lists.freedesktop.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Danilo Krummrich <dakr@kernel.org>,
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
	Daniel Almeida <daniel.almeida@collabora.com>,
	Asahi Lina <lina+kernel@asahilina.net>,
	nouveau@lists.freedesktop.org (open list:DRM DRIVER FOR NVIDIA GPUS [RUST])
Subject: [PATCH v3 09/14] rust: gem: Introduce DriverObject::Args
Date: Fri, 29 Aug 2025 18:35:24 -0400
Message-ID: <20250829224116.477990-10-lyude@redhat.com>
In-Reply-To: <20250829224116.477990-1-lyude@redhat.com>
References: <20250829224116.477990-1-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

This is an associated type that may be used in order to specify a data-type
to pass to gem objects when construction them, allowing for drivers to more
easily initialize their private-data for gem objects.

Signed-off-by: Lyude Paul <lyude@redhat.com>

---
V3:
* s/BaseDriverObject/DriverObject/

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/nova/gem.rs |  5 ++-
 rust/kernel/drm/gem/mod.rs  | 75 +++++++++++++++++++++++++++++++++----
 2 files changed, 71 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/nova/gem.rs b/drivers/gpu/drm/nova/gem.rs
index 10e3053f1a246..015cb56061a56 100644
--- a/drivers/gpu/drm/nova/gem.rs
+++ b/drivers/gpu/drm/nova/gem.rs
@@ -19,8 +19,9 @@ pub(crate) struct NovaObject {}
 impl gem::DriverObject for NovaObject {
     type Driver = NovaDriver;
     type Object = gem::Object<Self>;
+    type Args = ();
 
-    fn new(_dev: &NovaDevice, _size: usize) -> impl PinInit<Self, Error> {
+    fn new(_dev: &NovaDevice, _size: usize, _args: Self::Args) -> impl PinInit<Self, Error> {
         try_pin_init!(NovaObject {})
     }
 }
@@ -34,7 +35,7 @@ pub(crate) fn new(dev: &NovaDevice, size: usize) -> Result<ARef<gem::Object<Self
             return Err(EINVAL);
         }
 
-        gem::Object::new(dev, aligned_size)
+        gem::Object::new(dev, aligned_size, ())
     }
 
     /// Look up a GEM object handle for a `File` and return an `ObjectRef` for it.
diff --git a/rust/kernel/drm/gem/mod.rs b/rust/kernel/drm/gem/mod.rs
index f901d4263ee87..fe6ff3762a504 100644
--- a/rust/kernel/drm/gem/mod.rs
+++ b/rust/kernel/drm/gem/mod.rs
@@ -6,13 +6,14 @@
 
 use crate::{
     alloc::flags::*,
-    bindings, drm,
+    bindings,
     drm::driver::{AllocImpl, AllocOps},
+    drm::{self, private::Sealed},
     error::{to_result, Result},
     prelude::*,
     types::{ARef, AlwaysRefCounted, Opaque},
 };
-use core::{ops::Deref, ptr::NonNull};
+use core::{marker::PhantomData, ops::Deref, ptr::NonNull};
 
 /// A type alias for retrieving a [`Driver`]s [`DriverFile`] implementation from its
 /// [`DriverObject`] implementation.
@@ -21,6 +22,26 @@
 /// [`DriverFile`]: drm::file::DriverFile
 pub type DriverFile<T> = drm::File<<<T as DriverObject>::Driver as drm::Driver>::File>;
 
+/// A helper macro for implementing AsRef<OpaqueObject<…>>
+macro_rules! impl_as_opaque {
+    ($type:ty where $tparam:ident : $tparam_trait:ident) => {
+        impl<D, $tparam> core::convert::AsRef<kernel::drm::gem::OpaqueObject<D>> for $type
+        where
+            D: kernel::drm::driver::Driver,
+            Self: kernel::drm::gem::DriverObject<Driver = D>,
+            Self: kernel::drm::gem::IntoGEMObject,
+            $tparam: $tparam_trait,
+        {
+            fn as_ref(&self) -> &kernel::drm::gem::OpaqueObject<D> {
+                // SAFETY: This cast is safe via our type invariant.
+                unsafe { &*((self.as_raw().cast_const()).cast()) }
+            }
+        }
+    };
+}
+
+pub(crate) use impl_as_opaque;
+
 /// GEM object functions, which must be implemented by drivers.
 pub trait DriverObject: Sync + Send + Sized {
     /// Parent `Driver` for this object.
@@ -29,8 +50,15 @@ pub trait DriverObject: Sync + Send + Sized {
     /// The GEM object type that will be passed to various callbacks.
     type Object: AllocImpl;
 
+    /// The data type to use for passing arguments to [`BaseDriverObject::new`].
+    type Args;
+
     /// Create a new driver data object for a GEM object of a given size.
-    fn new(dev: &drm::Device<Self::Driver>, size: usize) -> impl PinInit<Self, Error>;
+    fn new(
+        dev: &drm::Device<Self::Driver>,
+        size: usize,
+        args: Self::Args,
+    ) -> impl PinInit<Self, Error>;
 
     /// Open a new handle to an existing object, associated with a File.
     fn open(_obj: &Self::Object, _file: &DriverFile<Self>) -> Result {
@@ -42,7 +70,7 @@ fn close(_obj: &Self::Object, _file: &DriverFile<Self>) {}
 }
 
 /// Trait that represents a GEM object subtype
-pub trait IntoGEMObject: Sized + super::private::Sealed + AlwaysRefCounted {
+pub trait IntoGEMObject: Sized + Sealed + AlwaysRefCounted {
     /// Returns a reference to the raw `drm_gem_object` structure, which must be valid as long as
     /// this owning object is valid.
     fn as_raw(&self) -> *mut bindings::drm_gem_object;
@@ -233,11 +261,11 @@ impl<T: DriverObject> Object<T> {
     };
 
     /// Create a new GEM object.
-    pub fn new(dev: &drm::Device<T::Driver>, size: usize) -> Result<ARef<Self>> {
+    pub fn new(dev: &drm::Device<T::Driver>, size: usize, args: T::Args) -> Result<ARef<Self>> {
         let obj: Pin<KBox<Self>> = KBox::pin_init(
             try_pin_init!(Self {
                 obj: Opaque::new(bindings::drm_gem_object::default()),
-                data <- T::new(dev, size),
+                data <- T::new(dev, size, args),
                 // INVARIANT: The drm subsystem guarantees that the `struct drm_device` will live
                 // as long as the GEM object lives.
                 dev: dev.into(),
@@ -289,7 +317,7 @@ extern "C" fn free_callback(obj: *mut bindings::drm_gem_object) {
     }
 }
 
-impl<T: DriverObject> super::private::Sealed for Object<T> {}
+impl<T: DriverObject> Sealed for Object<T> {}
 
 impl<T: DriverObject> Deref for Object<T> {
     type Target = T;
@@ -313,6 +341,39 @@ impl<T: DriverObject> AllocImpl for Object<T> {
     };
 }
 
+impl_as_opaque!(Object<T> where T: DriverObject);
+
+/// A GEM object whose private-data layout is not known.
+///
+/// Not all GEM objects are created equal, and subsequently drivers may occasionally need to deal
+/// with situations where they are working with a GEM object but have no knowledge of its
+/// private-data layout.
+///
+/// It may be used just like a normal [`Object`], with the exception that it cannot access
+/// driver-private data.
+///
+/// # Invariant
+///
+/// Via `#[repr(transparent)]`, this type is guaranteed to have an identical data layout to
+/// `struct drm_gem_object`.
+#[repr(transparent)]
+pub struct OpaqueObject<T: drm::Driver>(Opaque<bindings::drm_gem_object>, PhantomData<T>);
+
+impl<T: drm::Driver> IntoGEMObject for OpaqueObject<T> {
+    unsafe fn from_raw<'a>(self_ptr: *mut bindings::drm_gem_object) -> &'a Self {
+        // SAFETY:
+        // - This cast is safe via our type invariant.
+        // - `self_ptr` is guaranteed to be a valid pointer to a gem object by our safety contract.
+        unsafe { &*self_ptr.cast::<Self>().cast_const() }
+    }
+
+    fn as_raw(&self) -> *mut bindings::drm_gem_object {
+        self.0.get()
+    }
+}
+
+impl<D: drm::Driver> Sealed for OpaqueObject<D> {}
+
 pub(super) const fn create_fops() -> bindings::file_operations {
     // SAFETY: As by the type invariant, it is safe to initialize `bindings::file_operations`
     // zeroed.
-- 
2.50.0


