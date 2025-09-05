Return-Path: <linux-kernel+bounces-803442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A13CB45FD2
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 19:18:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 580347BA979
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 17:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B05992F7AA4;
	Fri,  5 Sep 2025 17:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JjGjOhIp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B9117BA6;
	Fri,  5 Sep 2025 17:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757092712; cv=none; b=NyPV8mHOulB6vPugHqlysoOGZCbd8R7ZeFq4LLZxK/DhyJcuoPX/IHv04uisV4jMn+p0dmTiV52lbyVO3uM3N6iKIZ4F/JhubbZGKdsExuLML1d2v2G+ZZ9YggBHKFKdab3CcpSkSosnwxjpWqIcSQmqeeFMaIvJj/3U5ew3lV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757092712; c=relaxed/simple;
	bh=AWSjBgq3zhHdP9BGjciHx5eMjuRmw2yC8sc9IocKhxs=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=b6Svd09LIvOy/hH9pzgWJnwSOSGuq0SEXFOCZxnGP5zWubVdzL13wBU3uGezNKgqON3s+1qje0zRB88tExGpIXrhdrRvpe5pKwaO1lmhV5cDuH3oNSeaaz0Za3mFJiWlWN81CnTpwZ6n19TqrBPVEyLwJnyqZABpxIfnAhhVc/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JjGjOhIp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 238E8C4CEF1;
	Fri,  5 Sep 2025 17:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757092711;
	bh=AWSjBgq3zhHdP9BGjciHx5eMjuRmw2yC8sc9IocKhxs=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=JjGjOhIpa+Dq4GYo24uci2y36ObrtkBRW01e4SkHWqZBdSPvB4i1p2iKiZx3vOmZg
	 H2e+GPe27P7++gklGKgvKerqhuEtc6mkgE7QQWF4zd51UgCovyuUNr3j9Gu0yO/wVe
	 om4Cl/+W+Ennk5zXfyUmEmprEkwbSLOlzjpfZGLeYDZE0jnl5HTirBa5UZBM+LK1Fd
	 UVYLHvo7FORuyKZtXRydnPsWdb7JOuQP5AUp4LxCrAwx3Z1GGSsclzHme8rU+LDi+c
	 KL1sz+nKya/wJ7VIaGq2/uN+l3Mgq9xR/Xb4YV85uei8S8uTeSG42iTEZ8V2S/V7aF
	 n8iizHXS66zUg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 05 Sep 2025 19:18:25 +0200
Message-Id: <DCL1DPN708H0.3JTL93J2GD2DR@kernel.org>
Cc: <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rust: pin-init: add references to previously
 initialized fields
From: "Benno Lossin" <lossin@kernel.org>
To: "Benno Lossin" <lossin@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>,
 "Alex Gaynor" <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>,
 "Gary Guo" <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 "Danilo Krummrich" <dakr@kernel.org>, "Fiona Behrens" <me@kloenk.dev>,
 "Alban Kurti" <kurti@invicto.ai>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 "Bjorn Helgaas" <bhelgaas@google.com>,
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>
X-Mailer: aerc 0.20.1
References: <20250905140047.3325945-1-lossin@kernel.org>
In-Reply-To: <20250905140047.3325945-1-lossin@kernel.org>

On Fri Sep 5, 2025 at 4:00 PM CEST, Benno Lossin wrote:
> After initializing a field in an initializer macro, create a variable
> holding a reference that points at that field. The type is either
> `Pin<&mut T>` or `&mut T` depending on the field's structural pinning
> kind.
>
> Link: https://github.com/Rust-for-Linux/pin-init/pull/83/commits/0f658594=
c39398f58cd5cb99a8141e370e225e74
> Signed-off-by: Benno Lossin <lossin@kernel.org>

I forgot to test with the right configuration and found some errors with
existing code. Here are their fixes. If I don't need to re-send, I will
add them on apply (if you want a v2, let me know).

---
Cheers,
Benno

diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
index da18091143a6..91dbf3f4b166 100644
--- a/rust/kernel/devres.rs
+++ b/rust/kernel/devres.rs
@@ -134,11 +134,9 @@ pub fn new<'a, E>(
         T: 'a,
         Error: From<E>,
     {
-        let callback =3D Self::devres_callback;
-
         try_pin_init!(&this in Self {
             dev: dev.into(),
-            callback,
+            callback: Self::devres_callback,
             // INVARIANT: `inner` is properly initialized.
             inner <- {
                 // SAFETY: `this` is a valid pointer to uninitialized memo=
ry.
@@ -151,7 +149,7 @@ pub fn new<'a, E>(
                 //    properly initialized, because we require `dev` (i.e.=
 the *bound* device) to
                 //    live at least as long as the returned `impl PinInit<=
Self, Error>`.
                 to_result(unsafe {
-                    bindings::devm_add_action(dev.as_raw(), Some(callback)=
, inner.cast())
+                    bindings::devm_add_action(dev.as_raw(), Some(*callback=
), inner.cast())
                 })?;
=20
                 Opaque::pin_init(try_pin_init!(Inner {
diff --git a/samples/rust/rust_driver_pci.rs b/samples/rust/rust_driver_pci=
.rs
index 606946ff4d7f..1ac0b06fa3b3 100644
--- a/samples/rust/rust_driver_pci.rs
+++ b/samples/rust/rust_driver_pci.rs
@@ -78,8 +78,8 @@ fn probe(pdev: &pci::Device<Core>, info: &Self::IdInfo) -=
> Result<Pin<KBox<Self>
=20
         let drvdata =3D KBox::pin_init(
             try_pin_init!(Self {
-                pdev: pdev.into(),
                 bar <- pdev.iomap_region_sized::<{ Regs::END }>(0, c_str!(=
"rust_driver_pci")),
+                pdev: pdev.into(),
                 index: *info,
             }),
             GFP_KERNEL,

