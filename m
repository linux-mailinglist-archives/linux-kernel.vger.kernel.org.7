Return-Path: <linux-kernel+bounces-841824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DAE9BB8527
	for <lists+linux-kernel@lfdr.de>; Sat, 04 Oct 2025 00:32:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 231694EFA82
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 22:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3B262F0C79;
	Fri,  3 Oct 2025 22:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XYDj+wTO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F89B284896;
	Fri,  3 Oct 2025 22:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759530481; cv=none; b=XCWEnAxisKJjMpzopWX7G/9WXkC8BTNGzlnLQ/wW0BwkI4Ify9YaglZSHeN++qFsGb8HiJ1bvRj4uwLsWrUW486fY1nBUWJmSTkRUMvNlwwKvhjMYV7zQoWdDe2W7PnlSVoyEWqRV1jPcoKqcqmfhYBXc3Q0O/CMVz+YfIEPLS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759530481; c=relaxed/simple;
	bh=Pa3T2gqcpn0BfO0PymfzEhzrhpkSorm3T1eSWoUkyH0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zmmvs1ANAB1+FO2B/1ve4NksFMXnQTvKudXsmzVpV2qWU1Hx2j8Hj8U+UYnO1yElxCLaDc2+O1VfP1IS2NQZpV4AApTEEnghMLT1ZASRE28H3tmUtfGmp44dRm2jr/UfDAqj96Y/sWdZdF+fBbTjq1l56qXjlzQcxCqoYRpHYy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XYDj+wTO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B039C4CEF5;
	Fri,  3 Oct 2025 22:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759530481;
	bh=Pa3T2gqcpn0BfO0PymfzEhzrhpkSorm3T1eSWoUkyH0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XYDj+wTODqHxaHbquId7LGMtxNt3goBHrAQ9vkcFhKnFu86t98L9ASjTBy+temGYe
	 LGlRrqKOWIEUyZzoCe58MRv8+kHH17UDU/NeqS+aAyrsSL1krOzcO838w5jf0i1Rxq
	 skBqyqClUr69XUO06ONTokhbuou8XbD4foQA/ZBALQT9psjGZvDOPiarmr31jJwKKD
	 hcA9+ojKhOsGS5+K/w2Fgho0yu5ULXRATqow1Cr/clMPSMb+En2DX/EU3qz5s+8ysY
	 ugKMVRk+BnsJbzOv+osFlzdwgLpjCTWbvrmYeWy73XRT9/FEmZDsRSJppusmCuqjP8
	 AIzvt+WLonTNg==
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
Subject: [PATCH 6/7] rust: debugfs: support binary large objects for ScopedDir
Date: Sat,  4 Oct 2025 00:26:43 +0200
Message-ID: <20251003222729.322059-7-dakr@kernel.org>
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

Add support for creating binary debugfs files via ScopedDir. This
mirrors the existing functionality for Dir, but without producing an
owning handle -- files are automatically removed when the associated
Scope is dropped.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/debugfs.rs | 45 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/rust/kernel/debugfs.rs b/rust/kernel/debugfs.rs
index 3c3bbcc126ef..0eb1719e4953 100644
--- a/rust/kernel/debugfs.rs
+++ b/rust/kernel/debugfs.rs
@@ -531,6 +531,20 @@ pub fn read_only_file<T: Writer + Send + Sync + 'static>(&self, name: &CStr, dat
         self.create_file(name, data, &T::FILE_OPS)
     }
 
+    /// Creates a read-only binary file in this directory.
+    ///
+    /// The file's contents are produced by invoking [`BinaryWriter::write_to_slice`].
+    ///
+    /// This function does not produce an owning handle to the file. The created file is removed
+    /// when the [`Scope`] that this directory belongs to is dropped.
+    pub fn read_binary_file<T: BinaryWriter + Send + Sync + 'static>(
+        &self,
+        name: &CStr,
+        data: &'data T,
+    ) {
+        self.create_file(name, data, &T::FILE_OPS)
+    }
+
     /// Creates a read-only file in this directory, with contents from a callback.
     ///
     /// The file contents are generated by calling `f` with `data`.
@@ -568,6 +582,22 @@ pub fn read_write_file<T: Writer + Reader + Send + Sync + 'static>(
         self.create_file(name, data, vtable)
     }
 
+    /// Creates a read-write binary file in this directory.
+    ///
+    /// Reading the file uses the [`BinaryWriter`] implementation on `data`. Writing to the file
+    /// uses the [`BinaryReader`] implementation on `data`.
+    ///
+    /// This function does not produce an owning handle to the file. The created file is removed
+    /// when the [`Scope`] that this directory belongs to is dropped.
+    pub fn read_write_binary_file<T: BinaryWriter + BinaryReader + Send + Sync + 'static>(
+        &self,
+        name: &CStr,
+        data: &'data T,
+    ) {
+        let vtable = &<T as BinaryReadWriteFile<_>>::FILE_OPS;
+        self.create_file(name, data, vtable)
+    }
+
     /// Creates a read-write file in this directory, with logic from callbacks.
     ///
     /// Reading from the file is handled by `f`. Writing to the file is handled by `w`.
@@ -607,6 +637,21 @@ pub fn write_only_file<T: Reader + Send + Sync + 'static>(&self, name: &CStr, da
         self.create_file(name, data, vtable)
     }
 
+    /// Creates a write-only binary file in this directory.
+    ///
+    /// Writing to the file uses the [`BinaryReader`] implementation on `data`.
+    ///
+    /// This function does not produce an owning handle to the file. The created file is removed
+    /// when the [`Scope`] that this directory belongs to is dropped.
+    pub fn write_binary_file<T: BinaryReader + Send + Sync + 'static>(
+        &self,
+        name: &CStr,
+        data: &'data T,
+    ) {
+        let vtable = &<T as BinaryWriteFile<_>>::FILE_OPS;
+        self.create_file(name, data, vtable)
+    }
+
     /// Creates a write-only file in this directory, with write logic from a callback.
     ///
     /// Writing to the file is handled by `w`.
-- 
2.51.0


