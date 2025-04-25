Return-Path: <linux-kernel+bounces-620572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4105CA9CC4D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Apr 2025 17:04:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52C024E239C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Apr 2025 15:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 202A326FDBA;
	Fri, 25 Apr 2025 15:02:22 +0000 (UTC)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D498E25C705;
	Fri, 25 Apr 2025 15:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745593341; cv=none; b=NB8C1Y10mmPlgA7NSDidXUqlDNDnfARwM+Nn4DjiQT5yMKS7Da0hu+ZveLr2HJrZJp4TC0i+qy3+YXNs2x+3+8bKDMedMoStVCUjdkdDrNfabZVEe3/hymHhO/nLRLmTmnovhb9zsIq9FFj9vPQAmtfTtO6iNv5UrypQC69hnHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745593341; c=relaxed/simple;
	bh=7C4zitTW5z/c4mv5PGjYauKo6Ey/90dfG63hbkBB8rs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IJlNqEz/Ac6XQzbSIGXr9Hq608AcnjcVQaXTRh17d3YaDHpI4p6z42LlAR9HjLoCTZGCt9BBUJCsf+Bh0E2xf+4RlBIPQ7ti4ZgO3xUUE/Kqm01XHm3pLRymBNu/lBjZOSYrGt3Yy8Jge6te8UWlNnJm3s0z91tCRxMy76uuExc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=buenzli.dev; spf=pass smtp.mailfrom=buenzli.dev; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=buenzli.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=buenzli.dev
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4ZkbfS5R5Zz9t6L;
	Fri, 25 Apr 2025 17:02:08 +0200 (CEST)
From: Remo Senekowitsch <remo@buenzli.dev>
To: Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
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
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Dirk Behme <dirk.behme@de.bosch.com>,
	Remo Senekowitsch <remo@buenzli.dev>
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: [PATCH v3 4/7] rust: property: Add bindings for reading device properties
Date: Fri, 25 Apr 2025 17:01:27 +0200
Message-ID: <20250425150130.13917-5-remo@buenzli.dev>
In-Reply-To: <20250425150130.13917-1-remo@buenzli.dev>
References: <20250425150130.13917-1-remo@buenzli.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The device property API is a firmware agnostic API for reading
properties from firmware (DT/ACPI) devices nodes and swnodes.

While the C API takes a pointer to a caller allocated variable/buffer,
the rust API is designed to return a value and can be used in struct
initialization. Rust generics are also utilized to support different
types of properties where appropriate.

Co-developed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Remo Senekowitsch <remo@buenzli.dev>
---
 rust/kernel/device/property.rs | 232 ++++++++++++++++++++++++++++++++-
 1 file changed, 230 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/device/property.rs b/rust/kernel/device/property.rs
index de31a1f56..9505cc35d 100644
--- a/rust/kernel/device/property.rs
+++ b/rust/kernel/device/property.rs
@@ -4,9 +4,17 @@
 //!
 //! C header: [`include/linux/property.h`](srctree/include/linux/property.h)
 
-use core::ptr;
+use core::{mem::MaybeUninit, ptr};
 
-use crate::{bindings, device::Device, str::CStr, types::Opaque};
+use crate::{
+    alloc::KVec,
+    bindings,
+    device::Device,
+    error::{to_result, Result},
+    prelude::*,
+    str::{CStr, CString},
+    types::Opaque,
+};
 
 impl Device {
     /// Obtain the fwnode corresponding to the device.
@@ -132,6 +140,104 @@ pub fn property_present(&self, name: &CStr) -> bool {
         // SAFETY: By the invariant of `CStr`, `name` is null-terminated.
         unsafe { bindings::fwnode_property_present(self.as_raw().cast_const(), name.as_char_ptr()) }
     }
+
+    /// Returns firmware property `name` boolean value
+    pub fn property_read_bool(&self, name: &CStr) -> bool {
+        // SAFETY: `name` is non-null and null-terminated. `self.as_raw()` is valid
+        // because `self` is valid.
+        unsafe { bindings::fwnode_property_read_bool(self.as_raw(), name.as_char_ptr()) }
+    }
+
+    /// Returns the index of matching string `match_str` for firmware string property `name`
+    pub fn property_match_string(&self, name: &CStr, match_str: &CStr) -> Result<usize> {
+        // SAFETY: `name` and `match_str` are non-null and null-terminated. `self.as_raw` is
+        // valid because `self` is valid.
+        let ret = unsafe {
+            bindings::fwnode_property_match_string(
+                self.as_raw(),
+                name.as_char_ptr(),
+                match_str.as_char_ptr(),
+            )
+        };
+        to_result(ret)?;
+        Ok(ret as usize)
+    }
+
+    /// Returns firmware property `name` integer array values in a KVec
+    pub fn property_read_array_vec<'fwnode, 'name, T: PropertyInt>(
+        &'fwnode self,
+        name: &'name CStr,
+        len: usize,
+    ) -> Result<PropertyGuard<'fwnode, 'name, KVec<T>>> {
+        let mut val: KVec<T> = KVec::with_capacity(len, GFP_KERNEL)?;
+
+        // SAFETY: `val.as_mut_ptr()` is valid because `KVec::with_capacity`
+        // didn't return an error and it has at least space for `len` number
+        // of elements.
+        let err = unsafe { read_array_out_param::<T>(self, name, val.as_mut_ptr(), len) };
+        let res = if err < 0 {
+            Err(Error::from_errno(err))
+        } else {
+            // SAFETY: fwnode_property_read_int_array() writes exactly `len`
+            // entries on success
+            unsafe { val.set_len(len) }
+            Ok(val)
+        };
+        Ok(PropertyGuard {
+            inner: res,
+            fwnode: self,
+            name,
+        })
+    }
+
+    /// Returns integer array length for firmware property `name`
+    pub fn property_count_elem<T: PropertyInt>(&self, name: &CStr) -> Result<usize> {
+        // SAFETY: `out_param` is allowed to be null because `len` is zero.
+        let ret = unsafe { read_array_out_param::<T>(self, name, ptr::null_mut(), 0) };
+        to_result(ret)?;
+        Ok(ret as usize)
+    }
+
+    /// Returns the value of firmware property `name`.
+    ///
+    /// This method is generic over the type of value to read. Informally,
+    /// the types that can be read are booleans, strings, unsigned integers and
+    /// arrays of unsigned integers.
+    ///
+    /// Reading a `KVec` of integers is done with the separate
+    /// method [`Self::property_read_array_vec`], because it takes an
+    /// additional `len` argument.
+    ///
+    /// When reading a boolean, this method never fails. A missing property
+    /// is interpreted as `false`, whereas a present property is interpreted
+    /// as `true`.
+    ///
+    /// For more precise documentation about what types can be read, see
+    /// the [implementors of Property][Property#implementors] and [its
+    /// implementations on foreign types][Property#foreign-impls].
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// # use kernel::{c_str, device::property::FwNode, str::CString};
+    /// fn examples(fwnode: &FwNode) -> Result {
+    ///     let b: u32 = fwnode.property_read(c_str!("some-number")).required()?;
+    ///     if let Some(s) = fwnode.property_read::<CString>(c_str!("some-str")).optional() {
+    ///         // ...
+    ///     }
+    ///     Ok(())
+    /// }
+    /// ```
+    pub fn property_read<'fwnode, 'name, T: Property>(
+        &'fwnode self,
+        name: &'name CStr,
+    ) -> PropertyGuard<'fwnode, 'name, T> {
+        PropertyGuard {
+            inner: T::read_from_fwnode_property(self, name),
+            fwnode: self,
+            name,
+        }
+    }
 }
 
 // SAFETY: Instances of `FwNode` are always reference-counted.
@@ -147,6 +253,128 @@ unsafe fn dec_ref(obj: ptr::NonNull<Self>) {
     }
 }
 
+/// Implemented for several types that can be read as properties.
+///
+/// Informally, this is implemented for strings, integers and arrays of
+/// integers. It's used to make [`FwNode::property_read`] generic over the
+/// type of property being read. There are also two dedicated methods to read
+/// other types, because they require more specialized function signatures:
+/// - [`property_read_bool`](Device::property_read_bool)
+/// - [`property_read_array_vec`](Device::property_read_array_vec)
+pub trait Property: Sized {
+    /// Used to make [`FwNode::property_read`] generic.
+    fn read_from_fwnode_property(fwnode: &FwNode, name: &CStr) -> Result<Self>;
+}
+
+impl Property for CString {
+    fn read_from_fwnode_property(fwnode: &FwNode, name: &CStr) -> Result<Self> {
+        let mut str: *mut u8 = ptr::null_mut();
+        let pstr: *mut _ = &mut str;
+
+        // SAFETY: `name` is non-null and null-terminated. `fwnode.as_raw` is
+        // valid because `fwnode` is valid.
+        let ret = unsafe {
+            bindings::fwnode_property_read_string(fwnode.as_raw(), name.as_char_ptr(), pstr.cast())
+        };
+        to_result(ret)?;
+
+        // SAFETY: `pstr` contains a non-null ptr on success
+        let str = unsafe { CStr::from_char_ptr(*pstr) };
+        Ok(str.try_into()?)
+    }
+}
+/// Implemented for all integers that can be read as properties.
+///
+/// This helper trait is needed on top of the existing [`Property`]
+/// trait to associate the integer types of various sizes with their
+/// corresponding `fwnode_property_read_*_array` functions.
+pub trait PropertyInt: Copy {
+    /// # Safety
+    ///
+    /// Callers must uphold the same safety invariants as for the various
+    /// `fwnode_property_read_*_array` functions.
+    unsafe fn read_array_from_fwnode_property(
+        fwnode: *const bindings::fwnode_handle,
+        propname: *const ffi::c_char,
+        val: *mut Self,
+        nval: usize,
+    ) -> ffi::c_int;
+}
+// This macro generates implementations of the traits `Property` and
+// `PropertyInt` for integers of various sizes. Its input is a list
+// of pairs separated by commas. The first element of the pair is the
+// type of the integer, the second one is the name of its corresponding
+// `fwnode_property_read_*_array` function.
+macro_rules! impl_property_for_int {
+    ($($int:ty: $f:ident),* $(,)?) => { $(
+        impl PropertyInt for $int {
+            unsafe fn read_array_from_fwnode_property(
+                fwnode: *const bindings::fwnode_handle,
+                propname: *const ffi::c_char,
+                val: *mut Self,
+                nval: usize,
+            ) -> ffi::c_int {
+                // SAFETY: The safety invariants on the trait require
+                // callers to uphold the invariants of the functions
+                // this macro is called with.
+                unsafe {
+                    bindings::$f(fwnode, propname, val.cast(), nval)
+                }
+            }
+        }
+    )* };
+}
+impl_property_for_int! {
+    u8: fwnode_property_read_u8_array,
+    u16: fwnode_property_read_u16_array,
+    u32: fwnode_property_read_u32_array,
+    u64: fwnode_property_read_u64_array,
+    i8: fwnode_property_read_u8_array,
+    i16: fwnode_property_read_u16_array,
+    i32: fwnode_property_read_u32_array,
+    i64: fwnode_property_read_u64_array,
+}
+/// # Safety
+///
+/// Callers must ensure that if `len` is non-zero, `out_param` must be
+/// valid and point to memory that has enough space to hold at least
+/// `len` number of elements.
+unsafe fn read_array_out_param<T: PropertyInt>(
+    fwnode: &FwNode,
+    name: &CStr,
+    out_param: *mut T,
+    len: usize,
+) -> ffi::c_int {
+    // SAFETY: `name` is non-null and null-terminated.
+    // `fwnode.as_raw` is valid because `fwnode` is valid.
+    // `out_param` is valid and has enough space for at least
+    // `len` number of elements as per the safety requirement.
+    unsafe {
+        T::read_array_from_fwnode_property(fwnode.as_raw(), name.as_char_ptr(), out_param, len)
+    }
+}
+impl<T: PropertyInt, const N: usize> Property for [T; N] {
+    fn read_from_fwnode_property(fwnode: &FwNode, name: &CStr) -> Result<Self> {
+        let mut val: [MaybeUninit<T>; N] = [const { MaybeUninit::uninit() }; N];
+
+        // SAFETY: `val.as_mut_ptr()` is valid and points to enough space for
+        // `N` elements. Casting from `*mut MaybeUninit<T>` to `*mut T` is safe
+        // because `MaybeUninit<T>` has the same memory layout as `T`.
+        let ret = unsafe { read_array_out_param::<T>(fwnode, name, val.as_mut_ptr().cast(), N) };
+        to_result(ret)?;
+
+        // SAFETY: `val` is always initialized when
+        // fwnode_property_read_<T>_array is successful.
+        Ok(val.map(|v| unsafe { v.assume_init() }))
+    }
+}
+impl<T: PropertyInt> Property for T {
+    fn read_from_fwnode_property(fwnode: &FwNode, name: &CStr) -> Result<Self> {
+        let val: [_; 1] = <[T; 1] as Property>::read_from_fwnode_property(fwnode, name)?;
+        Ok(val[0])
+    }
+}
+
 /// A helper for reading device properties.
 ///
 /// Use [`Self::required`] if a missing property is considered a bug and
-- 
2.49.0


