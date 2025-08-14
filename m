Return-Path: <linux-kernel+bounces-768447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87245B2611E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 11:38:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EFFE584FE4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 09:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B14FC2F39B9;
	Thu, 14 Aug 2025 09:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DPXujJuS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029242E9EAD;
	Thu, 14 Aug 2025 09:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755163878; cv=none; b=A7XY/1OCsy3uPeJOxzHZ/8QzVO43neyXbDQdcsviLRZg9UmDwfG77r/6qDwjCFpeyUuf4+Wg/RJnEnRny9Pz5Ti74wO0kBYTp0nPIRFKM+7Z5Rc/m7BqC18R7Qr6DYMvivD5VGWPrHdC0o/4gees2PuiY+zPQ4xvffRGUuKZzK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755163878; c=relaxed/simple;
	bh=Y2LN4gp+cwJ2nX5J6gBtHp2+0MsQKkxDPHVHbH0DTIc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZgihBDehi53wAt+ncsKEgSw0WSTUUcdJL7/tVJIaKSEtxDthoHoXA6EUEJLPcd14Rh/aiOZINe/XpzgVSPDuW+Rvd8sWeh+L1amQpFjGT4OusV8zicKZKwVJZcup5v5Gx1jFBeaqvox2oR6m8FR+CZneC0VZoaBtyPOJu+6io/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DPXujJuS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAD23C4CEED;
	Thu, 14 Aug 2025 09:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755163875;
	bh=Y2LN4gp+cwJ2nX5J6gBtHp2+0MsQKkxDPHVHbH0DTIc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DPXujJuSqNDIkQI5jEZm+oKYw56g5OxPFs5McsqphQQoymAILYlSLJdxvka7k/Jxi
	 uQDwgIWdaRobN6lPAFr0D9qGJQug7/EL2io2nFMil6CCY9G0Gl2RMgSBy6iwgYQXKe
	 2M1mjLzUGw1fzAMcxXG+0vO0qnX7KBjr2U/Zr3j+KG56PzXjhpazcVlktqTMhtzD14
	 Cq1kGSiBQTgsbIxqOJ/D2ogkoBSZ6qjr7QsAfRXZf/JfjepGyIJySNeb5TiJPTPqht
	 OpYvnKkSk3uOiPkg/YP0TLtYzymqIDv0EX+laMQ704zIKI6TPlJ1nknBpIMdD480Y8
	 T2VAbcMYwPOvA==
From: Benno Lossin <lossin@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
Subject: [PATCH v3 03/11] rust: miscdevice: replace `MaybeUninit::zeroed().assume_init()` with `pin_init::zeroed()`
Date: Thu, 14 Aug 2025 11:30:30 +0200
Message-ID: <20250814093046.2071971-4-lossin@kernel.org>
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
 rust/kernel/miscdevice.rs | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/rust/kernel/miscdevice.rs b/rust/kernel/miscdevice.rs
index 6373fe183b27..cecd1f265324 100644
--- a/rust/kernel/miscdevice.rs
+++ b/rust/kernel/miscdevice.rs
@@ -19,7 +19,7 @@
     seq_file::SeqFile,
     types::{ForeignOwnable, Opaque},
 };
-use core::{marker::PhantomData, mem::MaybeUninit, pin::Pin};
+use core::{marker::PhantomData, pin::Pin};
 
 /// Options for creating a misc device.
 #[derive(Copy, Clone)]
@@ -31,8 +31,7 @@ pub struct MiscDeviceOptions {
 impl MiscDeviceOptions {
     /// Create a raw `struct miscdev` ready for registration.
     pub const fn into_raw<T: MiscDevice>(self) -> bindings::miscdevice {
-        // SAFETY: All zeros is valid for this C type.
-        let mut result: bindings::miscdevice = unsafe { MaybeUninit::zeroed().assume_init() };
+        let mut result: bindings::miscdevice = pin_init::zeroed();
         result.minor = bindings::MISC_DYNAMIC_MINOR as ffi::c_int;
         result.name = self.name.as_char_ptr();
         result.fops = MiscdeviceVTable::<T>::build();
@@ -359,8 +358,7 @@ impl<T: MiscDevice> MiscdeviceVTable<T> {
         } else {
             None
         },
-        // SAFETY: All zeros is a valid value for `bindings::file_operations`.
-        ..unsafe { MaybeUninit::zeroed().assume_init() }
+        ..pin_init::zeroed()
     };
 
     const fn build() -> &'static bindings::file_operations {
-- 
2.50.1


