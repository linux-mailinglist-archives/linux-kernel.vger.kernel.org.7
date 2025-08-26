Return-Path: <linux-kernel+bounces-786816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20818B36CA2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 16:58:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A92558E86A3
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 14:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8379F356913;
	Tue, 26 Aug 2025 14:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KPGD+DZU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D403034A325;
	Tue, 26 Aug 2025 14:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756218749; cv=none; b=pAewHko31SoLZfQVAyNvj5xkmwrITUeAvvPKdUTspeayIaCZ7M+xpY83XdYM9HVEVf3PoQNobRnXYnCXon1C8VNQ1TeMAIC+JlXjm3gabUxtzHw7v9dPMufq0EiPrNoShhRFC7ZOY7REB1LC26O2PqkEbK28ZysWOunjSUxBqKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756218749; c=relaxed/simple;
	bh=TRwosFDSgyXJuaLmOPY/+OlOBUOdfMGyuGs6N08ZWLk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=IDMYf7IFBN+FI96Lo1Lo9wREqCGeM3Os58VvvMWNnkbP87nOZESEtwcrvvHM+kGickg6tPclrYJjNVAa7ov3do4sW0MqF+gvPMKCHbpUxUHogVI5f3NfMFNUba6B0DO7IWfZ74C3hH6gBzM5PD4qiTg6/geh7iesjGFA2qb3TKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KPGD+DZU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50AC4C4CEF1;
	Tue, 26 Aug 2025 14:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756218749;
	bh=TRwosFDSgyXJuaLmOPY/+OlOBUOdfMGyuGs6N08ZWLk=;
	h=Date:Cc:To:From:Subject:References:In-Reply-To:From;
	b=KPGD+DZUAyvngYsHdhvkfS3MAbNCZ2g9dExE0HS72vQ6bUXrOrH4HMom4a79ILxc/
	 EFHtmU2R1ukz5EoZzocODFt6I7KDeUS0qCE2lrBn7nC2ctsrWT11pYZgaelmwhRP6N
	 wbwiM14FkRmzOWaloMUnrTq5HZOraK/znRuGVCfP2LJ3dLzeEz3Ap3e1SBqOAkW2U/
	 JalR8Ll4cOiOtIUaypRv61E7xxspthk+sXfuJDTlA2LDSts6zGzV3teyDkQ9L8Jx5b
	 taDo2u88gcPVqsxGCby+b1ITA6n/ebhN8eXOdTMpaJIO7LvQajsKqfNVeAOcamFvvh
	 aTxOi8o4swJkQ==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 26 Aug 2025 16:32:24 +0200
Message-Id: <DCCFL57R0B4B.D289IWKTOTOE@kernel.org>
Cc: <akpm@linux-foundation.org>, <ojeda@kernel.org>,
 <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <tmgross@umich.edu>, <abdiel.janulgue@gmail.com>, <acourbot@nvidia.com>,
 <jgg@ziepe.ca>, <lyude@redhat.com>, <robin.murphy@arm.com>,
 <daniel.almeida@collabora.com>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
To: "Alice Ryhl" <aliceryhl@google.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v3 3/5] rust: scatterlist: Add abstraction for sg_table
References: <20250825132539.122412-1-dakr@kernel.org>
 <20250825132539.122412-4-dakr@kernel.org> <aK3BsV_s-xMQLF4d@google.com>
In-Reply-To: <aK3BsV_s-xMQLF4d@google.com>

On Tue Aug 26, 2025 at 4:16 PM CEST, Alice Ryhl wrote:
> On Mon, Aug 25, 2025 at 03:24:42PM +0200, Danilo Krummrich wrote:
> Overall LGTM. With comments addressed:
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
>
>> +impl RawSGTable {
>> +    fn new(
>> +        pages: &mut [*mut bindings::page],
>
> This should probably be unsafe due to the raw pointer. Or could we pass
> any pointer here?

Good catch, we should indeed make this unsafe and add the corresponding saf=
ety
requirements:

diff --git a/rust/kernel/scatterlist.rs b/rust/kernel/scatterlist.rs
index e76e5c2cbdc7..a562c0360842 100644
--- a/rust/kernel/scatterlist.rs
+++ b/rust/kernel/scatterlist.rs
@@ -251,7 +251,12 @@ unsafe impl Send for RawSGTable {}
 unsafe impl Sync for RawSGTable {}
=20
 impl RawSGTable {
-    fn new(
+    /// # Safety
+    ///
+    /// - `pages` must be a slice of valid `struct page *`.
+    /// - The pages pointed to by `pages` must remain valid for the entire=
 lifetime of the returned
+    ///   [`RawSGTable`].
+    unsafe fn new(
         pages: &mut [*mut bindings::page],
         size: usize,
         max_segment: u32,
@@ -355,7 +360,11 @@ fn new(
         };
=20
         Ok(try_pin_init!(&this in Self {
-            sgt <- RawSGTable::new(&mut page_vec, size, max_segment, flags=
),
+            // SAFETY:
+            // - `page_vec` is a `KVec` of valid `struct page *` obtained =
from `pages`.
+            // - The pages contained in `pages` remain valid for the entir=
e lifetime of the
+            //   `RawSGTable`.
+            sgt <- unsafe { RawSGTable::new(&mut page_vec, size, max_segme=
nt, flags) },
             dma <- {
                 // SAFETY: `this` is a valid pointer to uninitialized memo=
ry.
                 let sgt =3D unsafe { &raw mut (*this.as_ptr()).sgt }.cast(=
);


