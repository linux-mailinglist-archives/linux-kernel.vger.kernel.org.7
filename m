Return-Path: <linux-kernel+bounces-841822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 18FA9BB8524
	for <lists+linux-kernel@lfdr.de>; Sat, 04 Oct 2025 00:31:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 911F9348E97
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 22:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3373283CAA;
	Fri,  3 Oct 2025 22:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nPIGjXCD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF29C2EC099;
	Fri,  3 Oct 2025 22:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759530474; cv=none; b=B0nmWJxK2wpoZfxPhEJGzPF1kIuUBDfuiJ7NhTH1KXbZF3MU3OaxpyIgRAUHnK0xDiR8SaVbOPE26qsCe5OLxfJ+7eThOpQsQoW1CrnX6BwQPScxvZDnW5XdgzYl1M1DwltaO4oNrucRAuakxv2DrZ0QRgN3grPeCTi1xZ58EuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759530474; c=relaxed/simple;
	bh=u53Uk/PsduccUptjZR9Ccs65J+jFhHu+M/uud08l/Fc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LwwNRy3t0cpwWguwlb9/CZIXqPuEjBALvrlTJWjKd5kNPh4rTirQzGKGGESS9lM9Sh0QdhOrJXDpdtn+9GQuzDh6rUgxyKal++aulxmMdIM9qyRUZgES3jxLg3XEc/rW22DOfdXfsusTMXDG72sgHuIEfsPDkRdhSDknfwxlcs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nPIGjXCD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37BD7C4CEFA;
	Fri,  3 Oct 2025 22:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759530474;
	bh=u53Uk/PsduccUptjZR9Ccs65J+jFhHu+M/uud08l/Fc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nPIGjXCD2b24WQW+CqGX9OzRI+NTfiO1boYYrR/tZJMHxfJ6txgE5AeXTNClZ2NQ4
	 loDnYoxQ9M4Rr8kBWxdKjXRPHUr3azREs/VOVxaUmdXM+zy5xCkVYVl8wUtLtaRVgl
	 JP8JwOZzQkPf22nN+PaHfTpBFsiw2RVeOJtGvxRqPZmBEJVkdS7ebRLhTdRJw9VvL+
	 B5opazvKVW19aMrHgkLrB62cl32rEvqrH/DU5zbbK5r3j4ZvOlt82/41574ZCqKhdS
	 5w/2v8L4NCcK5FreWzTV2qA22wKksELLK4VmTyKP3yiakLjecFuQqH69xCrGgh2m2X
	 SlOy5WpDpBLmQ==
From: Danilo Krummrich <dakr@kernel.org>
To: gregkh@linuxfoundation.org,
	rafael@kernel.org,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	mmaurer@google.com
Cc: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH 4/7] rust: debugfs: support blobs from smart pointers
Date: Sat,  4 Oct 2025 00:26:41 +0200
Message-ID: <20251003222729.322059-5-dakr@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251003222729.322059-1-dakr@kernel.org>
References: <20251003222729.322059-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend Rust debugfs binary support to allow exposing data stored in
common smart pointers and heap-allocated collections.

- Implement BinaryWriter for Box<T>, Pin<Box<T>>, Arc<T>, and Vec<T>.
- Introduce BinaryReaderMut for mutable binary access with outer locks.
- Implement BinaryReaderMut for Box<T>, Vec<T>, and base types.
- Update BinaryReader to delegate to BinaryReaderMut for Mutex<T>,
  Box<T>, Pin<Box<T>> and Arc<T>.

This enables debugfs files to directly expose or update data stored
inside heap-allocated, reference-counted, or lock-protected containers
without manual dereferencing or locking.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/debugfs.rs        |   2 +-
 rust/kernel/debugfs/traits.rs | 145 +++++++++++++++++++++++++++++++++-
 2 files changed, 144 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/debugfs.rs b/rust/kernel/debugfs.rs
index b1a3adca7fd4..3c3bbcc126ef 100644
--- a/rust/kernel/debugfs.rs
+++ b/rust/kernel/debugfs.rs
@@ -21,7 +21,7 @@
 use core::ops::Deref;
 
 mod traits;
-pub use traits::{BinaryReader, BinaryWriter, Reader, Writer};
+pub use traits::{BinaryReader, BinaryReaderMut, BinaryWriter, Reader, Writer};
 
 mod callback_adapters;
 use callback_adapters::{FormatAdapter, NoWriter, WritableAdapter};
diff --git a/rust/kernel/debugfs/traits.rs b/rust/kernel/debugfs/traits.rs
index 60a6ee6c6b58..bcd0a9db3cc9 100644
--- a/rust/kernel/debugfs/traits.rs
+++ b/rust/kernel/debugfs/traits.rs
@@ -3,11 +3,14 @@
 
 //! Traits for rendering or updating values exported to DebugFS.
 
+use crate::alloc::Allocator;
 use crate::prelude::*;
+use crate::sync::Arc;
 use crate::sync::Mutex;
 use crate::transmute::{AsBytes, FromBytes};
 use crate::uaccess::{UserSliceReader, UserSliceWriter};
 use core::fmt::{self, Debug, Formatter};
+use core::ops::{Deref, DerefMut};
 use core::str::FromStr;
 use core::sync::atomic::{
     AtomicI16, AtomicI32, AtomicI64, AtomicI8, AtomicIsize, AtomicU16, AtomicU32, AtomicU64,
@@ -50,12 +53,14 @@ pub trait BinaryWriter {
     fn write_to_slice(&self, writer: &mut UserSliceWriter, offset: usize) -> Result<usize>;
 }
 
+// Base implementation for any `T: AsBytes`.
 impl<T: AsBytes> BinaryWriter for T {
     fn write_to_slice(&self, writer: &mut UserSliceWriter, offset: usize) -> Result<usize> {
         writer.write_slice_partial(self.as_bytes(), offset)
     }
 }
 
+// Delegate for `Mutex<T>`: Support a `T` with an outer mutex.
 impl<T: BinaryWriter> BinaryWriter for Mutex<T> {
     fn write_to_slice(&self, writer: &mut UserSliceWriter, offset: usize) -> Result<usize> {
         let guard = self.lock();
@@ -64,6 +69,56 @@ fn write_to_slice(&self, writer: &mut UserSliceWriter, offset: usize) -> Result<
     }
 }
 
+// Delegate for `Box<T, A>`: Support a `Box<T, A>` with no lock or an inner lock.
+impl<T, A> BinaryWriter for Box<T, A>
+where
+    T: BinaryWriter,
+    A: Allocator,
+{
+    fn write_to_slice(&self, writer: &mut UserSliceWriter, offset: usize) -> Result<usize> {
+        self.deref().write_to_slice(writer, offset)
+    }
+}
+
+// Delegate for `Pin<Box<T, A>>`: Support a `Pin<Box<T, A>>` with no lock or an inner lock.
+impl<T, A> BinaryWriter for Pin<Box<T, A>>
+where
+    T: BinaryWriter,
+    A: Allocator,
+{
+    fn write_to_slice(&self, writer: &mut UserSliceWriter, offset: usize) -> Result<usize> {
+        self.deref().write_to_slice(writer, offset)
+    }
+}
+
+// Delegate for `Arc<T>`: Support a `Arc<T>` with no lock or an inner lock.
+impl<T> BinaryWriter for Arc<T>
+where
+    T: BinaryWriter,
+{
+    fn write_to_slice(&self, writer: &mut UserSliceWriter, offset: usize) -> Result<usize> {
+        self.deref().write_to_slice(writer, offset)
+    }
+}
+
+// Delegate for `Vec<T, A>`.
+impl<T, A> BinaryWriter for Vec<T, A>
+where
+    T: AsBytes,
+    A: Allocator,
+{
+    fn write_to_slice(&self, writer: &mut UserSliceWriter, offset: usize) -> Result<usize> {
+        let slice = self.as_slice();
+
+        // SAFETY: `T: AsBytes` allows us to treat `&[T]` as `&[u8]`.
+        let buffer = unsafe {
+            core::slice::from_raw_parts(slice.as_ptr().cast(), core::mem::size_of_val(slice))
+        };
+
+        writer.write_slice_partial(buffer, offset)
+    }
+}
+
 /// A trait for types that can be updated from a user slice.
 ///
 /// This works similarly to `FromStr`, but operates on a `UserSliceReader` rather than a &str.
@@ -92,6 +147,70 @@ fn read_from_slice(&self, reader: &mut UserSliceReader) -> Result {
 }
 
 /// Trait for types that can be constructed from a binary representation.
+///
+/// See also [`BinaryReader`] for interior mutability.
+pub trait BinaryReaderMut {
+    /// Reads the binary form of `self` from `reader`.
+    ///
+    /// Same as [`BinaryReader::read_from_slice`], but takes a mutable reference.
+    ///
+    /// `offset` is the requested offset into the binary representation of `self`.
+    ///
+    /// On success, returns the number of bytes read from `reader`.
+    fn read_from_slice_mut(&mut self, reader: &mut UserSliceReader, offset: usize)
+        -> Result<usize>;
+}
+
+// Base implementation for any `T: AsBytes + FromBytes`.
+impl<T: AsBytes + FromBytes> BinaryReaderMut for T {
+    fn read_from_slice_mut(
+        &mut self,
+        reader: &mut UserSliceReader,
+        offset: usize,
+    ) -> Result<usize> {
+        reader.read_slice_partial(self.as_bytes_mut(), offset)
+    }
+}
+
+// Delegate for `Box<T, A>`: Support a `Box<T, A>` with an outer lock.
+impl<T: ?Sized + BinaryReaderMut, A: Allocator> BinaryReaderMut for Box<T, A> {
+    fn read_from_slice_mut(
+        &mut self,
+        reader: &mut UserSliceReader,
+        offset: usize,
+    ) -> Result<usize> {
+        self.deref_mut().read_from_slice_mut(reader, offset)
+    }
+}
+
+// Delegate for `Vec<T, A>`: Support a `Vec<T, A>` with an outer lock.
+impl<T, A> BinaryReaderMut for Vec<T, A>
+where
+    T: AsBytes + FromBytes,
+    A: Allocator,
+{
+    fn read_from_slice_mut(
+        &mut self,
+        reader: &mut UserSliceReader,
+        offset: usize,
+    ) -> Result<usize> {
+        let slice = self.as_mut_slice();
+
+        // SAFETY: `T: AsBytes` allows us to treat `&[T]` as `&[u8]`.
+        let buffer = unsafe {
+            core::slice::from_raw_parts_mut(
+                slice.as_mut_ptr().cast(),
+                core::mem::size_of_val(slice),
+            )
+        };
+
+        reader.read_slice_partial(buffer, offset)
+    }
+}
+
+/// Trait for types that can be constructed from a binary representation.
+///
+/// See also [`BinaryReaderMut`] for the mutable version.
 pub trait BinaryReader {
     /// Reads the binary form of `self` from `reader`.
     ///
@@ -101,11 +220,33 @@ pub trait BinaryReader {
     fn read_from_slice(&self, reader: &mut UserSliceReader, offset: usize) -> Result<usize>;
 }
 
-impl<T: AsBytes + FromBytes> BinaryReader for Mutex<T> {
+// Delegate for `Mutex<T>`: Support a `T` with an outer `Mutex`.
+impl<T: BinaryReaderMut> BinaryReader for Mutex<T> {
     fn read_from_slice(&self, reader: &mut UserSliceReader, offset: usize) -> Result<usize> {
         let mut this = self.lock();
 
-        reader.read_slice_partial(this.as_bytes_mut(), offset)
+        this.read_from_slice_mut(reader, offset)
+    }
+}
+
+// Delegate for `Box<T, A>`: Support a `Box<T, A>` with an inner lock.
+impl<T: ?Sized + BinaryReader, A: Allocator> BinaryReader for Box<T, A> {
+    fn read_from_slice(&self, reader: &mut UserSliceReader, offset: usize) -> Result<usize> {
+        self.deref().read_from_slice(reader, offset)
+    }
+}
+
+// Delegate for `Pin<Box<T, A>>`: Support a `Pin<Box<T, A>>` with an inner lock.
+impl<T: ?Sized + BinaryReader, A: Allocator> BinaryReader for Pin<Box<T, A>> {
+    fn read_from_slice(&self, reader: &mut UserSliceReader, offset: usize) -> Result<usize> {
+        self.deref().read_from_slice(reader, offset)
+    }
+}
+
+// Delegate for `Arc<T>`: Support an `Arc<T>` with an inner lock.
+impl<T: ?Sized + BinaryReader> BinaryReader for Arc<T> {
+    fn read_from_slice(&self, reader: &mut UserSliceReader, offset: usize) -> Result<usize> {
+        self.deref().read_from_slice(reader, offset)
     }
 }
 
-- 
2.51.0


