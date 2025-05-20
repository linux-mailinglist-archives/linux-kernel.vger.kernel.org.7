Return-Path: <linux-kernel+bounces-656172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F953ABE286
	for <lists+linux-kernel@lfdr.de>; Tue, 20 May 2025 20:22:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 540603AB0D0
	for <lists+linux-kernel@lfdr.de>; Tue, 20 May 2025 18:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 810DF280014;
	Tue, 20 May 2025 18:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dddb4imp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83912441B4;
	Tue, 20 May 2025 18:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747765326; cv=none; b=ugPASCxs8NxYC6R/10iZx2u0Vv7fT7K+F3RLrhWSub3XrFk1SIuut9ymJKAasrKVZf/fkAY5mzh9KqNX7y5YGvcFwGioBF7mvugMN+jna22rHbfbXe24B4zP07eTrfTD9jIfJy8LxRhnhfmywO/IINcEjYQR4wr3OyWht3W/Cao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747765326; c=relaxed/simple;
	bh=oFzdpd2yc5D7rMJdLpf9Avjzs2bAR0+fMOdTiwKSyKk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OItozX8Tpr/QQDPBHBLoVs45LAQvXtbT6nkl2OKF3ZLb/h8hvaqUmNUcWESY1MgCJodaHpOdVXSTPl64n/4ShqtPj5DMnB/0TWHvGQ3O0LmlBe+0KCYSELXbu9YmAw+QSPoh3H+c89w27WRUjG6zjYAPPxdAQXvAQxepmSfF2gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dddb4imp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AAA0C4CEED;
	Tue, 20 May 2025 18:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747765325;
	bh=oFzdpd2yc5D7rMJdLpf9Avjzs2bAR0+fMOdTiwKSyKk=;
	h=From:To:Cc:Subject:Date:From;
	b=Dddb4impTC4CB40Afjwqdp6IvmKMKZY4kZy0jB6oui+yPVzUoDg2fLiv+zeyIOkiX
	 lQ5gFql/4Ux2zkxkFczUJWEuca43qI1UQjSwRkR1OJH8HfOgqIoNWFqdw28bPprbz+
	 xnv3THJ1Bvs3LcEKIDMHbDPw/9LfjtGI6suQKrWwhD77C9bPv4Ie6Vxsk6ubHYywm7
	 75KuFMWsJGCGH6/b4Qre1Z8MYrQL4a5E9JSO3SX7zwBhQPZiES9quDP616KKsKO5Ue
	 8Ei+J5D3ngg3YSl5G0YRCkcICeaT7JAQFbOASW7zhw09K0pRHms22Er+znXV5sQ8K1
	 dbl+G2LrWGcpQ==
From: Miguel Ojeda <ojeda@kernel.org>
To: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Danilo Krummrich <dakr@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev
Subject: [PATCH] rust: remove unneeded Rust 1.87.0 `allow(clippy::ptr_eq)`
Date: Tue, 20 May 2025 20:21:25 +0200
Message-ID: <20250520182125.806758-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Before a change to relax the lint was backported to Rust 1.87.0 before
its release, Clippy was expected to warn with:

    error: use `core::ptr::eq` when comparing raw pointers
       --> rust/kernel/list.rs:438:12
        |
    438 |         if self.first == item {
        |            ^^^^^^^^^^^^^^^^^^ help: try: `core::ptr::eq(self.first, item)`
        |
        = help: for further information visit https://rust-lang.github.io/rust-clippy/master/index.html#ptr_eq
        = note: `-D clippy::ptr-eq` implied by `-D warnings`
        = help: to override `-D warnings` add `#[allow(clippy::ptr_eq)]`

The backported finally landed indeed, thus remove the `allow`s we added
back then, which were added just in case the backport did not land
in time.

See commit a39f30870927 ("rust: allow Rust 1.87.0's `clippy::ptr_eq`
lint") for details.

Link: https://github.com/rust-lang/rust/pull/140859 [1]
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 rust/kernel/alloc/kvec.rs | 3 ---
 rust/kernel/list.rs       | 3 ---
 2 files changed, 6 deletions(-)

diff --git a/rust/kernel/alloc/kvec.rs b/rust/kernel/alloc/kvec.rs
index 87a71fd40c3c..ae9d072741ce 100644
--- a/rust/kernel/alloc/kvec.rs
+++ b/rust/kernel/alloc/kvec.rs
@@ -2,9 +2,6 @@
 
 //! Implementation of [`Vec`].
 
-// May not be needed in Rust 1.87.0 (pending beta backport).
-#![allow(clippy::ptr_eq)]
-
 use super::{
     allocator::{KVmalloc, Kmalloc, Vmalloc},
     layout::ArrayLayout,
diff --git a/rust/kernel/list.rs b/rust/kernel/list.rs
index 2054682c5724..a335c3b1ff5e 100644
--- a/rust/kernel/list.rs
+++ b/rust/kernel/list.rs
@@ -4,9 +4,6 @@
 
 //! A linked list implementation.
 
-// May not be needed in Rust 1.87.0 (pending beta backport).
-#![allow(clippy::ptr_eq)]
-
 use crate::sync::ArcBorrow;
 use crate::types::Opaque;
 use core::iter::{DoubleEndedIterator, FusedIterator};

base-commit: a5806cd506af5a7c19bcd596e4708b5c464bfd21
-- 
2.49.0


