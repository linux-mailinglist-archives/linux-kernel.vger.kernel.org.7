Return-Path: <linux-kernel+bounces-740696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DFC69B0D80C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 13:21:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A7AE3A2F23
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 11:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95F892E425B;
	Tue, 22 Jul 2025 11:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FRF+ZPzo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1872E3B09;
	Tue, 22 Jul 2025 11:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753183283; cv=none; b=L9DDp0sNo8fDNAPZUkK9CyHBF47YmfL59TO84uuhmoUMF86mfR40N/kOwRDZ9DNwFSR3TLtrKjBPVf7HxAZ2FXk1BsKUpaggoorcH3VnNtjtgAed2hOo2qbuKZEF4dyWUmsMFmobfV9gNUocDMErVvSy2gDcRHLqDaZ9sQedi/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753183283; c=relaxed/simple;
	bh=NzGAvcs2Ewa3S+nrvovcuvZsuyg/I5mB7QKeAsaxHUU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=hsv56DAgLw8LrimAvfXi5Plzq9JCf5tJFT2AK5sp2PZTqwzjL/BYpEa9y4agxnZ3qtcuQSSFBiLjjd3/DUE1FrJLruq+i3Vocc4MJDQGUg3W2P6p6wsc3XWMpDEFg42dODG9Buc5kkRi2ziUKeQEq/7B9Cr6mMx9TT/uF5+x8k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FRF+ZPzo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFD6DC4CEF5;
	Tue, 22 Jul 2025 11:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753183282;
	bh=NzGAvcs2Ewa3S+nrvovcuvZsuyg/I5mB7QKeAsaxHUU=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=FRF+ZPzoYIG2OwOQ/NUbZSRGT3T00PhfaiEbVfKrXR1eCv8Vuqb8DUFboe7pEtGqn
	 CWGPbz1bMlmEVRDAH2W1O+LTYWOcVgmY0A159DH7voO9z/TmSLWRkG10WvbbsiiYii
	 8aYTz5TjgPREAGD2MArYLFLLfd0Q1BrjPeD4jJnlyT4dnWkXg5j8jioi7i0KQZbHuR
	 r7chB56AqFtjzCYqtmpYoxlBlIvUh4B4avqIMIQAuEp7tknLoPjnRknoJnEb/FaBFe
	 8IL2Ws8tf9HjfjY1/fH0ePu/p38t8aHXxdcwbUHRTp5p4IdczpW29Rpw8e8GWC4/qQ
	 eMq4eSX7/bQZA==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 22 Jul 2025 13:21:17 +0200
Message-Id: <DBIJLR7XNI6U.21PMPODHE83DZ@kernel.org>
Cc: <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rust: sync: fix safety comment for `static_lock_class`
From: "Benno Lossin" <lossin@kernel.org>
To: "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <benno.lossin@proton.me>,
 "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Danilo
 Krummrich" <dakr@kernel.org>, "Lyude Paul" <lyude@redhat.com>, "Mitchell
 Levy" <levymitchell0@gmail.com>, "Wedson Almeida Filho"
 <wedsonaf@gmail.com>
X-Mailer: aerc 0.20.1
References: <20250520231714.323931-1-lossin@kernel.org>
In-Reply-To: <20250520231714.323931-1-lossin@kernel.org>

On Wed May 21, 2025 at 1:17 AM CEST, Benno Lossin wrote:
> The safety comment mentions lockdep -- which from a Rust perspective
> isn't important -- and doesn't mention the real reason for why it's
> sound to create `LockClassKey` as uninitialized memory.
>
> Signed-off-by: Benno Lossin <lossin@kernel.org>
> ---
>
> I don't think we need to backport this.
>
> ---
>  rust/kernel/sync.rs | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
> index 36a719015583..a10c812d8777 100644
> --- a/rust/kernel/sync.rs
> +++ b/rust/kernel/sync.rs
> @@ -93,8 +93,11 @@ fn drop(self: Pin<&mut Self>) {
>  macro_rules! static_lock_class {
>      () =3D> {{
>          static CLASS: $crate::sync::LockClassKey =3D
> -            // SAFETY: lockdep expects uninitialized memory when it's ha=
nded a statically allocated
> -            // lock_class_key
> +            // Lockdep expects uninitialized memory when it's handed a s=
tatically allocated `struct
> +            // lock_class_key`.
> +            //
> +            // SAFETY: `LockClassKey` transparently wraps `Opaque` which=
 permits uninitialized
> +            // memory.
>              unsafe { ::core::mem::MaybeUninit::uninit().assume_init() };

Looking at this patch with fresh eyes (thanks for the bump, Alice :) I
think we should rather have a public unsafe function on `LockClassKey`
that creates an uninitialized lock class key. I'd like to avoid the
`MaybeUninit::uninit().assume_init()` pattern, as it might confuse
people & it looks very wrong.

We can take this patch, as it definitely is an improvement, but I think
we should also just fix this properly. Any thoughts?

---
Cheers,
Benno

>          $crate::prelude::Pin::static_ref(&CLASS)
>      }};
>
> base-commit: a5806cd506af5a7c19bcd596e4708b5c464bfd21


