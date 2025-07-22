Return-Path: <linux-kernel+bounces-740786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6329CB0D924
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 14:15:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98599547DCD
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 12:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D60712E92C8;
	Tue, 22 Jul 2025 12:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N5nPqevr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2A02E4271;
	Tue, 22 Jul 2025 12:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753186493; cv=none; b=fyic6MnFbl5RBf/q8Q9GzTKnnf+HDGimyavesTUdjhqOdQNEwPY223/8kZz6KuUccF9up11gZs3z8LaZPlasCzLBhSFvdmu5d7S52NhrDgrcuGFrtupmxE2Gz18nIipZSvCdVqJDKOh+ZdHtIQEJxeObh36KCnEMrV4KJ8v0WU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753186493; c=relaxed/simple;
	bh=JQgWORT+yd+fNVMRTNPdGaw2laFR3PPdmmdnmMN0VOA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Pkw4rT9gBJdkjZJHUKd7ffnEiJAQUAnKHeYvW3xtjfJPvtKusMWfvWm+78S0+PXMQI1nmiFvsVoyxXuZbBCTfBr8MZ73WfUXzTNkh+6AN+OJCv9o8rRV+EsTY+Tulxgl+589XELBJ+BsmhsNxK1J1LzpnNPXriVHhCM5htS8n3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N5nPqevr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 290A0C4CEEB;
	Tue, 22 Jul 2025 12:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753186492;
	bh=JQgWORT+yd+fNVMRTNPdGaw2laFR3PPdmmdnmMN0VOA=;
	h=From:To:Cc:Subject:Date:From;
	b=N5nPqevrwnRlYNqrHyZz3RjvCvV5Wgy+HNDXh7jIthqM9Tm2E+1+Se5JRSLuFJehJ
	 NacatAEgqmo2fQfmTVL0BkTCkDA1EWeXXfifB2N0IG1Zf7ATzjbeDVYe/p+ps3XYsT
	 W2c0LPeAeDNuuXKO7vyD0VTBngr7s65pPuJ/KwflJ7YBIQMQzAnsfMG135llNM8o3D
	 RiW3+1OTVB/hBVtTPaE2legoTpbpoe0QM9fm1a66VKQJh66UWH8b3ajXd7pR1O6pH7
	 XaE/SiHcU8AMAPFdUPeEvB0b4lx53W1ZMuMnIWOdPR/313xpsLLlOBiNgzPC9X0p1L
	 jEZy1QKkxDvgw==
From: Benno Lossin <lossin@kernel.org>
To: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Shankari Anand <shankari.ak0208@gmail.com>
Cc: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] rust: sync: extend module documentation of aref
Date: Tue, 22 Jul 2025 14:14:38 +0200
Message-ID: <20250722121441.224439-1-lossin@kernel.org>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 07dad44aa9a9 ("rust: kernel: move ARef and AlwaysRefCounted to
sync::aref") moved `ARef` and `AlwaysRefCounted` into their own module.
In that process only a short, single line description of the module was
added. Extend the description by explaining what is meant by "internal
reference counting", the two items in the trait & the difference to
`Arc`.

Signed-off-by: Benno Lossin <lossin@kernel.org>
---
 rust/kernel/sync/aref.rs | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/rust/kernel/sync/aref.rs b/rust/kernel/sync/aref.rs
index dbd77bb68617..1c212238c0e5 100644
--- a/rust/kernel/sync/aref.rs
+++ b/rust/kernel/sync/aref.rs
@@ -1,6 +1,21 @@
 // SPDX-License-Identifier: GPL-2.0
 
 //! Internal reference counting support.
+//!
+//! Many C types already have their own reference counting mechanism (e.g. by storing a
+//! `refcount_t`). This module provides support for directly using their internal reference count
+//! from Rust; instead of making users have to use an additional Rust-reference count in the form of
+//! [`Arc`].
+//!
+//! The smart pointer [`ARef<T>`] acts similarly to [`Arc<T>`] in that it holds a refcount on the
+//! underlying object, but this refcount is internal to the object. It essentially is a Rust
+//! implementation of the `get_` and `put_` pattern used in C for reference counting.
+//!
+//! To make use of [`ARef<MyType>`], `MyType` needs to implement [`AlwaysRefCounted`]. It is a trait
+//! for accessing the internal reference count of an object of the `MyType` type.
+//!
+//! [`Arc`]: crate::sync::Arc
+//! [`Arc<T>`]: crate::sync::Arc
 
 use core::{marker::PhantomData, mem::ManuallyDrop, ops::Deref, ptr::NonNull};
 

base-commit: 07dad44aa9a93b16af19e8609a10b241c352b440
-- 
2.50.0


