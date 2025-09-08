Return-Path: <linux-kernel+bounces-806591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74D06B49918
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 20:54:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2ADA1BC6F3F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 18:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B45A23218C6;
	Mon,  8 Sep 2025 18:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WluMYyEU"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D0131C58B
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 18:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757357584; cv=none; b=M5h4p0/QNAnFgkonL+pQEuFDp/cv3ykc/PQwxDD3FksYlZexr3Vv7GuduxSqq93q5SWyNGv2yQnRJ/q4iyddAb23B2PMCbTMBRa69q+Ba5OHhjEEUvakUNc5cP3xQ8guZg/6lSfcnCvkoFUlylN4NfuLXByDT6uD5Wb05Ry/Qok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757357584; c=relaxed/simple;
	bh=eVSoTsQp3yFCMYYNCxpwK17TY0tP08a+zC/Nz6PrZSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D+IkiXKSFqkkc5uq3tUmca2ukmxCWfCFq9hTCXSTwUZOMqigb/m2sT9gzK99noSnebIWoyY//uAZI4Rpa98vouDAHugSMw+hSHjfjXZ0qRGvyr66nz1IskAxcubmoEr8m1MCHpKaOuKQX9oxXeIzdYCSscuwvibaeIvHN3TgHkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WluMYyEU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757357580;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qPQdxCXlJ3BtdYSxtBqdEdPnLwMmTLtCh9wXHQctdug=;
	b=WluMYyEU2tdarkVT3N46qJ5amgaSVhQP3XC0F5iJNa+fXTH8S3yzmjUS6UG8gCdND2dJ6F
	cuA2nZ/Sp69HWKMYAcSbhYFK40++NneqYYLsx44EeK2SkNNYrK4TifAXypgJasqlc4RBUc
	qUB9NHq+SLoiYo62xQBxOpYJEmNIlN4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-690-6dw4KfkwNn-1aVtyN_z8gA-1; Mon,
 08 Sep 2025 14:52:56 -0400
X-MC-Unique: 6dw4KfkwNn-1aVtyN_z8gA-1
X-Mimecast-MFC-AGG-ID: 6dw4KfkwNn-1aVtyN_z8gA_1757357574
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6B0A71800350;
	Mon,  8 Sep 2025 18:52:53 +0000 (UTC)
Received: from chopper.redhat.com (unknown [10.22.64.41])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7A8E718003FC;
	Mon,  8 Sep 2025 18:52:48 +0000 (UTC)
From: Lyude Paul <lyude@redhat.com>
To: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	Alice Ryhl <aliceryhl@google.com>
Cc: Daniel Almeida <daniel.almeida@collabora.com>,
	Danilo Krummrich <dakr@kernel.org>,
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
	Trevor Gross <tmgross@umich.edu>,
	Asahi Lina <lina+kernel@asahilina.net>,
	nouveau@lists.freedesktop.org (open list:DRM DRIVER FOR NVIDIA GPUS [RUST])
Subject: [PATCH v4 1/3] rust: drm: gem: Simplify use of generics
Date: Mon,  8 Sep 2025 14:46:36 -0400
Message-ID: <20250908185239.135849-2-lyude@redhat.com>
In-Reply-To: <20250908185239.135849-1-lyude@redhat.com>
References: <20250908185239.135849-1-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Now that my rust skills have been honed, I noticed that there's a lot of
generics in our gem bindings that don't actually need to be here. Currently
the hierarchy of traits in our gem bindings looks like this:

  * Drivers implement:
    * BaseDriverObject<T: DriverObject> (has the callbacks)
    * DriverObject (has the drm::Driver type)
  * Crate implements:
    * IntoGEMObject for Object<T> where T: DriverObject
      Handles conversion to/from raw object pointers
    * BaseObject for T where T: IntoGEMObject
      Provides methods common to all gem interfaces

  Also of note, this leaves us with two different drm::Driver associated
  types:
    * DriverObject::Driver
    * IntoGEMObject::Driver

I'm not entirely sure of the original intent here unfortunately (if anyone
is, please let me know!), but my guess is that the idea would be that some
objects can implement IntoGEMObject using a different ::Driver than
DriverObject - presumably to enable the usage of gem objects from different
drivers. A reasonable usecase of course.

However - if I'm not mistaken, I don't think that this is actually how
things would go in practice. Driver implementations are of course
implemented by their associated drivers, and generally drivers are not
linked to each-other when building the kernel. Which is to say that even in
a situation where we would theoretically deal with gem objects from another
driver, we still wouldn't have access to its drm::driver::Driver
implementation. It's more likely we would simply want a variant of gem
objects in such a situation that have no association with a
drm::driver::Driver type.

Taking that into consideration, we can assume the following:
* Anything that implements BaseDriverObject will implement DriverObject
  In other words, all BaseDriverObjects indirectly have an associated
  ::Driver type - so the two traits can be combined into one with no
  generics.
* Not everything that implements IntoGEMObject will have an associated
  ::Driver, and that's OK.

And with this, we now can do quite a bit of cleanup with the use of
generics here. As such, this commit:

* Removes the generics on BaseDriverObject
* Moves DriverObject::Driver into BaseDriverObject
* Removes DriverObject
* Removes IntoGEMObject::Driver
* Add AllocImpl::Driver, which we can use as a binding to figure out the
  correct File type for BaseObject

Leaving us with a simpler trait hierarchy that now looks like this:

  * Drivers implement: BaseDriverObject
  * Crate implements:
    * IntoGEMObject for Object<T> where T: DriverObject
    * BaseObject for T where T: IntoGEMObject

Which makes the code a lot easier to understand and build on :).

Signed-off-by: Lyude Paul <lyude@redhat.com>
Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>

---
V2:
* Don't refer to Object<T> in callbacks, as this would result in drivers
  getting the wrong gem object type for shmem gem objects once we add
  support for those. Instead, we'll just add a type alias to clean this
  part up.
V3:
* Fix nova compilation
* Also, add an associated driver type to AllocImpl - as we still need the
  current driver accessible from BaseObject so that we can use the driver's
  various associated types, like File
* Add missing Object = Self constraint to type bounds for create_handle,
  lookup_handle. I forgot that if drivers can have private gem objects with
  a different data layout, we can only guarantee gem objects with handles
  are of the same gem object type as the main one in use by the driver.
V4:
* Add <Driver = D> to DriverFile bounds for create_handle(),
  lookup_handle()

 drivers/gpu/drm/nova/gem.rs |  8 ++--
 rust/kernel/drm/driver.rs   |  3 ++
 rust/kernel/drm/gem/mod.rs  | 77 ++++++++++++++++---------------------
 3 files changed, 40 insertions(+), 48 deletions(-)

diff --git a/drivers/gpu/drm/nova/gem.rs b/drivers/gpu/drm/nova/gem.rs
index cd82773dab92c..2760ba4f3450b 100644
--- a/drivers/gpu/drm/nova/gem.rs
+++ b/drivers/gpu/drm/nova/gem.rs
@@ -16,16 +16,14 @@
 #[pin_data]
 pub(crate) struct NovaObject {}
 
-impl gem::BaseDriverObject<gem::Object<NovaObject>> for NovaObject {
+impl gem::DriverObject for NovaObject {
+    type Driver = NovaDriver;
+
     fn new(_dev: &NovaDevice, _size: usize) -> impl PinInit<Self, Error> {
         try_pin_init!(NovaObject {})
     }
 }
 
-impl gem::DriverObject for NovaObject {
-    type Driver = NovaDriver;
-}
-
 impl NovaObject {
     /// Create a new DRM GEM object.
     pub(crate) fn new(dev: &NovaDevice, size: usize) -> Result<ARef<gem::Object<Self>>> {
diff --git a/rust/kernel/drm/driver.rs b/rust/kernel/drm/driver.rs
index fe7e8d06961aa..dae0f4d1bbe3c 100644
--- a/rust/kernel/drm/driver.rs
+++ b/rust/kernel/drm/driver.rs
@@ -86,6 +86,9 @@ pub struct AllocOps {
 
 /// Trait for memory manager implementations. Implemented internally.
 pub trait AllocImpl: super::private::Sealed + drm::gem::IntoGEMObject {
+    /// The [`Driver`] implementation for this [`AllocImpl`].
+    type Driver: drm::Driver;
+
     /// The C callback operations for this memory manager.
     const ALLOC_OPS: AllocOps;
 }
diff --git a/rust/kernel/drm/gem/mod.rs b/rust/kernel/drm/gem/mod.rs
index b71821cfb5eaa..f5b19865d7453 100644
--- a/rust/kernel/drm/gem/mod.rs
+++ b/rust/kernel/drm/gem/mod.rs
@@ -15,31 +15,31 @@
 use core::{mem, ops::Deref, ptr::NonNull};
 
 /// GEM object functions, which must be implemented by drivers.
-pub trait BaseDriverObject<T: BaseObject>: Sync + Send + Sized {
+pub trait DriverObject: Sync + Send + Sized {
+    /// Parent `Driver` for this object.
+    type Driver: drm::Driver;
+
     /// Create a new driver data object for a GEM object of a given size.
-    fn new(dev: &drm::Device<T::Driver>, size: usize) -> impl PinInit<Self, Error>;
+    fn new(dev: &drm::Device<Self::Driver>, size: usize) -> impl PinInit<Self, Error>;
 
     /// Open a new handle to an existing object, associated with a File.
     fn open(
-        _obj: &<<T as IntoGEMObject>::Driver as drm::Driver>::Object,
-        _file: &drm::File<<<T as IntoGEMObject>::Driver as drm::Driver>::File>,
+        _obj: &<Self::Driver as drm::Driver>::Object,
+        _file: &drm::File<<Self::Driver as drm::Driver>::File>,
     ) -> Result {
         Ok(())
     }
 
     /// Close a handle to an existing object, associated with a File.
     fn close(
-        _obj: &<<T as IntoGEMObject>::Driver as drm::Driver>::Object,
-        _file: &drm::File<<<T as IntoGEMObject>::Driver as drm::Driver>::File>,
+        _obj: &<Self::Driver as drm::Driver>::Object,
+        _file: &drm::File<<Self::Driver as drm::Driver>::File>,
     ) {
     }
 }
 
 /// Trait that represents a GEM object subtype
 pub trait IntoGEMObject: Sized + super::private::Sealed + AlwaysRefCounted {
-    /// Owning driver for this type
-    type Driver: drm::Driver;
-
     /// Returns a reference to the raw `drm_gem_object` structure, which must be valid as long as
     /// this owning object is valid.
     fn as_raw(&self) -> *mut bindings::drm_gem_object;
@@ -74,25 +74,15 @@ unsafe fn dec_ref(obj: NonNull<Self>) {
     }
 }
 
-/// Trait which must be implemented by drivers using base GEM objects.
-pub trait DriverObject: BaseDriverObject<Object<Self>> {
-    /// Parent `Driver` for this object.
-    type Driver: drm::Driver;
-}
-
-extern "C" fn open_callback<T: BaseDriverObject<U>, U: BaseObject>(
+extern "C" fn open_callback<T: DriverObject>(
     raw_obj: *mut bindings::drm_gem_object,
     raw_file: *mut bindings::drm_file,
 ) -> core::ffi::c_int {
     // SAFETY: `open_callback` is only ever called with a valid pointer to a `struct drm_file`.
-    let file = unsafe {
-        drm::File::<<<U as IntoGEMObject>::Driver as drm::Driver>::File>::from_raw(raw_file)
-    };
-    // SAFETY: `open_callback` is specified in the AllocOps structure for `Object<T>`, ensuring that
-    // `raw_obj` is indeed contained within a `Object<T>`.
-    let obj = unsafe {
-        <<<U as IntoGEMObject>::Driver as drm::Driver>::Object as IntoGEMObject>::from_raw(raw_obj)
-    };
+    let file = unsafe { drm::File::<<T::Driver as drm::Driver>::File>::from_raw(raw_file) };
+    // SAFETY: `open_callback` is specified in the AllocOps structure for `DriverObject<T>`,
+    // ensuring that `raw_obj` is contained within a `DriverObject<T>`
+    let obj = unsafe { <<T::Driver as drm::Driver>::Object as IntoGEMObject>::from_raw(raw_obj) };
 
     match T::open(obj, file) {
         Err(e) => e.to_errno(),
@@ -100,26 +90,21 @@ extern "C" fn open_callback<T: BaseDriverObject<U>, U: BaseObject>(
     }
 }
 
-extern "C" fn close_callback<T: BaseDriverObject<U>, U: BaseObject>(
+extern "C" fn close_callback<T: DriverObject>(
     raw_obj: *mut bindings::drm_gem_object,
     raw_file: *mut bindings::drm_file,
 ) {
     // SAFETY: `open_callback` is only ever called with a valid pointer to a `struct drm_file`.
-    let file = unsafe {
-        drm::File::<<<U as IntoGEMObject>::Driver as drm::Driver>::File>::from_raw(raw_file)
-    };
+    let file = unsafe { drm::File::<<T::Driver as drm::Driver>::File>::from_raw(raw_file) };
+
     // SAFETY: `close_callback` is specified in the AllocOps structure for `Object<T>`, ensuring
     // that `raw_obj` is indeed contained within a `Object<T>`.
-    let obj = unsafe {
-        <<<U as IntoGEMObject>::Driver as drm::Driver>::Object as IntoGEMObject>::from_raw(raw_obj)
-    };
+    let obj = unsafe { <<T::Driver as drm::Driver>::Object as IntoGEMObject>::from_raw(raw_obj) };
 
     T::close(obj, file);
 }
 
 impl<T: DriverObject> IntoGEMObject for Object<T> {
-    type Driver = T::Driver;
-
     fn as_raw(&self) -> *mut bindings::drm_gem_object {
         self.obj.get()
     }
@@ -141,10 +126,12 @@ fn size(&self) -> usize {
 
     /// Creates a new handle for the object associated with a given `File`
     /// (or returns an existing one).
-    fn create_handle(
-        &self,
-        file: &drm::File<<<Self as IntoGEMObject>::Driver as drm::Driver>::File>,
-    ) -> Result<u32> {
+    fn create_handle<D, F>(&self, file: &drm::File<F>) -> Result<u32>
+    where
+        Self: AllocImpl<Driver = D>,
+        D: drm::Driver<Object = Self, File = F>,
+        F: drm::file::DriverFile<Driver = D>,
+    {
         let mut handle: u32 = 0;
         // SAFETY: The arguments are all valid per the type invariants.
         to_result(unsafe {
@@ -154,10 +141,12 @@ fn create_handle(
     }
 
     /// Looks up an object by its handle for a given `File`.
-    fn lookup_handle(
-        file: &drm::File<<<Self as IntoGEMObject>::Driver as drm::Driver>::File>,
-        handle: u32,
-    ) -> Result<ARef<Self>> {
+    fn lookup_handle<D, F>(file: &drm::File<F>, handle: u32) -> Result<ARef<Self>>
+    where
+        Self: AllocImpl<Driver = D>,
+        D: drm::Driver<Object = Self, File = F>,
+        F: drm::file::DriverFile<Driver = D>,
+    {
         // SAFETY: The arguments are all valid per the type invariants.
         let ptr = unsafe { bindings::drm_gem_object_lookup(file.as_raw().cast(), handle) };
         if ptr.is_null() {
@@ -212,8 +201,8 @@ impl<T: DriverObject> Object<T> {
 
     const OBJECT_FUNCS: bindings::drm_gem_object_funcs = bindings::drm_gem_object_funcs {
         free: Some(Self::free_callback),
-        open: Some(open_callback::<T, Object<T>>),
-        close: Some(close_callback::<T, Object<T>>),
+        open: Some(open_callback::<T>),
+        close: Some(close_callback::<T>),
         print_info: None,
         export: None,
         pin: None,
@@ -296,6 +285,8 @@ fn deref(&self) -> &Self::Target {
 }
 
 impl<T: DriverObject> AllocImpl for Object<T> {
+    type Driver = T::Driver;
+
     const ALLOC_OPS: AllocOps = AllocOps {
         gem_create_object: None,
         prime_handle_to_fd: None,
-- 
2.51.0


