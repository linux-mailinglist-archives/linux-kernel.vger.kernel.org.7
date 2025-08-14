Return-Path: <linux-kernel+bounces-768453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FCD3B2612E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 11:40:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3E2A882771
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 09:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 502AA2F60A6;
	Thu, 14 Aug 2025 09:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mlpMIgZ1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7818C302777;
	Thu, 14 Aug 2025 09:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755163903; cv=none; b=OPqykDnMMpT4fiNB+o9IjiHK+QJxgRT0TFu1bADg0ynhk3N8UNQGykQrP2/SYQiuSCgeYnWtQoZqHYkkT1VrZBww2BmO2NgdDavgjlzipYzW6fnuObR5pLf2IQ/fPvcGBzu/nbxz5u8MLGF59CrxxQET74olp7srfATCfurUFqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755163903; c=relaxed/simple;
	bh=3tRYt8/zI8ilWmNhtocIT47p7zCmr22HkgGyst1ct5s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uMxW609UwbCuOo8Z+JBQZAtnz85GzikCetI77GWrogto0iPlIbvgDRf8eDHIkHZj5u1aESkXqRIzphIn93k3j6yX3p/apr8y1LY90oS+hOgXDSCqtaG88mHQXzQstJ+tKntEJFSR0q8LzX0bvap0z6sTJ1fbtWpVcnfWs2zXMck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mlpMIgZ1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26956C4CEED;
	Thu, 14 Aug 2025 09:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755163903;
	bh=3tRYt8/zI8ilWmNhtocIT47p7zCmr22HkgGyst1ct5s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mlpMIgZ1bCIrjYoqizhUP3oByuYyLo+OjU+YL9zlImV8FdTTX+P5POh7z0R4RyyRe
	 MdvBlhn5sfCW7xqcmWnyBySw1QxV5XmlL00WqGPgJ6BNoGaMZVYc1quKa9q+ynpf/d
	 nQLI6CLzc/DvZIgHYtFWd5nu9s9p8cYKxnHVJMmoIDCIVJ0UKCy5MfO3iv1AvjJLau
	 jrGd8KN+Dl4UXyM37+9dxLBu1caKdBLRgMyf+jxRABXtE8erC6sBKZ4sUNNu+d0DuT
	 uRil0v0Xkmcs6qL0kMVHZOOL/uEqsUFp7Gr1YvMzcj9DGt/3l1w8jKKYZ8CQFBO9XV
	 FJvpwHzHCpp7Q==
From: Benno Lossin <lossin@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dave Ertman <david.m.ertman@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Leon Romanovsky <leon@kernel.org>,
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
Cc: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 09/11] rust: auxiliary: replace `core::mem::zeroed` with `pin_init::zeroed`
Date: Thu, 14 Aug 2025 11:30:36 +0200
Message-ID: <20250814093046.2071971-10-lossin@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250814093046.2071971-1-lossin@kernel.org>
References: <20250814093046.2071971-1-lossin@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All types in `bindings` implement `Zeroable` if they can, so use
`pin_init::zeroed` instead of relying on `unsafe` code.

If this ends up not compiling in the future, something in bindgen or on
the C side changed and is most likely incorrect.

Signed-off-by: Benno Lossin <lossin@kernel.org>
---
 rust/kernel/auxiliary.rs | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/rust/kernel/auxiliary.rs b/rust/kernel/auxiliary.rs
index 4749fb6bffef..10ec1f3b4a6d 100644
--- a/rust/kernel/auxiliary.rs
+++ b/rust/kernel/auxiliary.rs
@@ -108,11 +108,7 @@ pub const fn new(modname: &'static CStr, name: &'static CStr) -> Self {
         let name = name.as_bytes_with_nul();
         let modname = modname.as_bytes_with_nul();
 
-        // TODO: Replace with `bindings::auxiliary_device_id::default()` once stabilized for
-        // `const`.
-        //
-        // SAFETY: FFI type is valid to be zero-initialized.
-        let mut id: bindings::auxiliary_device_id = unsafe { core::mem::zeroed() };
+        let mut id: bindings::auxiliary_device_id = pin_init::zeroed();
 
         let mut i = 0;
         while i < modname.len() {
-- 
2.50.1


