Return-Path: <linux-kernel+bounces-592595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFE79A7EEEF
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Apr 2025 22:19:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 883E07A4906
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Apr 2025 20:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C854E224238;
	Mon,  7 Apr 2025 20:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="Mu0LksBd"
Received: from mail-10630.protonmail.ch (mail-10630.protonmail.ch [79.135.106.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B1721D5AF
	for <linux-kernel@vger.kernel.org>; Mon,  7 Apr 2025 20:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744057120; cv=none; b=BEOROuDTC2oXnSmEs10CdwpQzVqURrS9j2AnCtzWTMiN6E96k7YRsNntAJv87V/wPSf9/L9WlkpV7QBRDgm/iYw1mi9Rzm/8VnBpTg2psPrYWVAI3r597u5Ir0IWcSe1h9g6T886wM9yimPYcfaiSD+oZKp6rT9n9VyU/xKPSpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744057120; c=relaxed/simple;
	bh=uZLBs3qvTbVeszKw8/QGoedRECVolOOFtbOnrkgJMlE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AN8JJhCkKfcb8TxV83do9RQ9a/XLLB5toRAnm7P+OYaH+Oit8t/SY25UD59eXD7lCK+/tIZfwoU7meSqE/HFysKSQm8nFFrmy0zOiGhdpTfXiIUwQnsu3rWfcThn0LW6NppCbCuN8lApOBv2AuFdkZ+F5Bt15d3ZWM/Vml7uvk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=Mu0LksBd; arc=none smtp.client-ip=79.135.106.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1744057116; x=1744316316;
	bh=3HOvpKhOizPU1F0RyIH+COEyqizo7qUni/3Vi+keVtE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=Mu0LksBdP/ebXf6N2ST5gbKOmr6rQDbeXH1EodCZWSCLclhONzK9swgiOTk/59iiZ
	 Wk6aSgFR08Ao/yZZ80y1hYZzzELrTUDqICRYDDxNWsAS0u60oUEdSDx6qUFWHo5b3g
	 W0fryrKeLDg8PTbfgpMkhsw0PMOELtjdyf2ZmfkB1VcE9357cYVJL4szRwtZbBeCEd
	 0ZTHzslYyRbDppTyk+GzrcON0WyWJr1WULymfCPPV3CHinU6cdry4p5CsaKOGQRtpZ
	 7h43cn+153d1VDr9pJ4m3bWwQss8qxpAtn1hCJBdZ08SdyOS40oMcZyVGUypbBnE6T
	 tqHOVhbB2Mt9g==
Date: Mon, 07 Apr 2025 20:18:29 +0000
To: Benno Lossin <benno.lossin@proton.me>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Fiona Behrens <me@kloenk.dev>
From: Benno Lossin <benno.lossin@proton.me>
Cc: stable@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] rust: pin-init: use Markdown autolinks in Rust comments
Message-ID: <20250407201755.649153-3-benno.lossin@proton.me>
In-Reply-To: <20250407201755.649153-1-benno.lossin@proton.me>
References: <20250407201755.649153-1-benno.lossin@proton.me>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: e81f0c728d6f7bed1ebd13a22ed203e5894549d3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

From: Miguel Ojeda <ojeda@kernel.org>

"Normal" comments in Rust (`//`) are also formatted in Markdown, like
the documentation (`///` and `//!`), see
Documentation/rust/coding-guidelines.rst

Thus use Markdown autolinks for a couple links that were missing it.

It also helps to get proper linking in some software like kitty [1].

Suggested-by: Benno Lossin <benno.lossin@proton.me>
Link: https://github.com/Rust-for-Linux/pin-init/pull/32#discussion_r202310=
3712 [1]
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
Link: https://github.com/Rust-for-Linux/pin-init/pull/32/commits/dd230d61bf=
0538281072fbff4bb71efc58f3420c
Fixes: 84837cf6fa54 ("rust: pin-init: change examples to the user-space ver=
sion")
Cc: stable@vger.kernel.org
[ Change case in title. Reworded commit message. - Benno ]
Signed-off-by: Benno Lossin <benno.lossin@proton.me>
---
 rust/pin-init/examples/pthread_mutex.rs | 2 +-
 rust/pin-init/src/lib.rs                | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/rust/pin-init/examples/pthread_mutex.rs b/rust/pin-init/exampl=
es/pthread_mutex.rs
index 9164298c44c0..5ac22f1880d2 100644
--- a/rust/pin-init/examples/pthread_mutex.rs
+++ b/rust/pin-init/examples/pthread_mutex.rs
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: Apache-2.0 OR MIT
=20
-// inspired by https://github.com/nbdd0121/pin-init/blob/trunk/examples/pt=
hread_mutex.rs
+// inspired by <https://github.com/nbdd0121/pin-init/blob/trunk/examples/p=
thread_mutex.rs>
 #![allow(clippy::undocumented_unsafe_blocks)]
 #![cfg_attr(feature =3D "alloc", feature(allocator_api))]
 #[cfg(not(windows))]
diff --git a/rust/pin-init/src/lib.rs b/rust/pin-init/src/lib.rs
index 05c44514765e..0806c689f693 100644
--- a/rust/pin-init/src/lib.rs
+++ b/rust/pin-init/src/lib.rs
@@ -1447,7 +1447,7 @@ macro_rules! impl_zeroable {
     {<T: ?Sized + Zeroable>} UnsafeCell<T>,
=20
     // SAFETY: All zeros is equivalent to `None` (option layout optimizati=
on guarantee:
-    // https://doc.rust-lang.org/stable/std/option/index.html#representati=
on).
+    // <https://doc.rust-lang.org/stable/std/option/index.html#representat=
ion>).
     Option<NonZeroU8>, Option<NonZeroU16>, Option<NonZeroU32>, Option<NonZ=
eroU64>,
     Option<NonZeroU128>, Option<NonZeroUsize>,
     Option<NonZeroI8>, Option<NonZeroI16>, Option<NonZeroI32>, Option<NonZ=
eroI64>,
--=20
2.48.1



