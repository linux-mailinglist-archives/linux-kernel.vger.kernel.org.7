Return-Path: <linux-kernel+bounces-884357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F74FC30040
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 09:45:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F2E818C1AAD
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 08:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8157F31A06F;
	Tue,  4 Nov 2025 08:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uMPvTSfW"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE01317701
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 08:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762245425; cv=none; b=oE0vljn6ev3kRQEIgG36BjI9NyusYPVTKONOWmynddjbqwvtyTMrbpgcfUAqaKEsURD9i6yyW0H49dn1Gv5H1v0osvtQ1aBb8I/t/wPzOF2ItvWU1Mjjivh2UaZFqTIAzELZpDT1LJ6vTwgYbN1chJxceDanuMvwbhmrJ7uVi9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762245425; c=relaxed/simple;
	bh=KjBRbZ4bkrlSakH8TMfjW4NCE/Px2HuvZ+aVWMkIPE4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=szwr8FSJEhY8edhzB2ZWkd4elyvhAOOh45sxtmPX5W9AiSr+V9DNnOjyEyF6uKsoWb0La7OqjpcP4fIfYCrRLFz4yxGUW5vPwiOVsapzk1aqrJU1v4se6x0PWmv/MjWmpzx/OLnMBATG+7YTIEY7uayO49b2nEUJdIfrlHBDwj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uMPvTSfW; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4710d174c31so56948285e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 00:37:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762245422; x=1762850222; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7SIFibIxGtr22aof+eoY73n2jRzngRkz56RLCEf2qwc=;
        b=uMPvTSfWLq3fHAiX7p7s82c4FooFLNUGtYlUoo0b4LPIPhEB6b1FgB7/2f5G4r8dk6
         V7WGhoS+hIkF+Pg/BhsAenOSklfuTm2FXnram1yQ5129weQLWaKzxOOi4zbohfP9uA4D
         qAcHb+UgpDEEVmKDvdX71JwCBo7IV1maxOj60WSYJgwtBVjpmek/sDLb2MFZ+HDGoIJh
         L5D4JHBMEfCVvBPoAEgnNwy52wySHlQ7w8/El9PbcvtAITC9hsiq0tG3f/JwqzrjfQGd
         7Mn0gVmodQfmd1mjq+xKlVmomiLLtRSCg1v6cbtG3Y/4K9+nBsKsiypw2biKlkhxfKjt
         e4IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762245422; x=1762850222;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7SIFibIxGtr22aof+eoY73n2jRzngRkz56RLCEf2qwc=;
        b=ujRSiRf+FDJjy4rvRVrp57eXbEyw48JCvkrM3nuZx4kKE7c4+gOpmLRucxXAlBu4pZ
         /kbANf61b4PeRSWQK9En+PDXbtxTKx0qOv9LangsFwaj6WSWOEAA/G+NTu47GK9psBIL
         yFQ2a3d7p0x/50G0HUK+42SENTDHvtl0fJNltjgF0/EoiZVmdFTPYk5Pbhep5OXqCC6M
         T6fuK7l47bQ6OY3k2//GTom89ygX0zwRXYcQXzh3QV2Ugo2XyHQqbDhaolN/EPwh5Xca
         GIgSc1QxVc+WcR31eUbn/ghfZyikZjzQa1PeP4ObKTcYKRmsigUi2ULGHZBnJkZ6H2hu
         XVTQ==
X-Forwarded-Encrypted: i=1; AJvYcCVsmEuLlGVynuj2olSr++aWoe2JgZwqu1XmUp15E31XM9fjaJnpJUl9mRQSflqeip0MEJxyp5paBvmEYFI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKHDMDw3VS1ETSB4mj+IXuAVVb4Aypk+zinwS2nof0RKiwYtyr
	1kOv4zI+va/vB55g2ikhGXc8yJaLKSXV+CHD8nE+yWjfgItAXljDAvaenf7fQUOawzQzx5LkgfL
	KvcfvRezk/WsgVvPFYQ==
X-Google-Smtp-Source: AGHT+IEg5xttFX2ft6eTsCCjP1/B0SKHrlRkwGAmvuAZGburwGNPSoMEYyhqVEPJi3uwc+HT+qYKC0k+Vu62A0Q=
X-Received: from wmf19.prod.google.com ([2002:a05:600c:2293:b0:477:10f8:4597])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:621b:b0:475:d917:7218 with SMTP id 5b1f17b1804b1-477308a6900mr139520125e9.36.1762245421804;
 Tue, 04 Nov 2025 00:37:01 -0800 (PST)
Date: Tue, 4 Nov 2025 08:37:00 +0000
In-Reply-To: <DDZ5J5OC26UH.1B8CGNEJGRTS5@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251101-b4-as-flattened-v1-1-860f2ebeedfd@nvidia.com>
 <aQiCeZE7eN_KVdZ5@google.com> <DDZ5J5OC26UH.1B8CGNEJGRTS5@nvidia.com>
Message-ID: <aQm7LNwPwxm8HZ_I@google.com>
Subject: Re: [PATCH RESEND] rust: enable slice_flatten feature and abstract it
 through an extension trait
From: Alice Ryhl <aliceryhl@google.com>
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas.schier@linux.dev>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Tue, Nov 04, 2025 at 12:06:54AM +0900, Alexandre Courbot wrote:
> On Mon Nov 3, 2025 at 7:22 PM JST, Alice Ryhl wrote:
> > On Sat, Nov 01, 2025 at 10:31:38PM +0900, Alexandre Courbot wrote:
> >> In Rust 1.80, the previously unstable `slice::flatten` family of methods
> >> have been stabilized and renamed to `as_flattened`.
> >> 
> >> This creates an issue as we want to use `as_flattened`, but need to
> >> support the MSRV (which at the moment is Rust 1.78) where it is named
> >> `flatten`.
> >> 
> >> Solve this by enabling the `slice_flatten` feature, and abstracting
> >> `as_flatten` behind an extension trait that calls the right method
> >> depending on the Rust version.
> >> 
> >> This extension trait can be removed once the MSRV passes 1.80.
> >> 
> >> Suggested-by: Miguel Ojeda <ojeda@kernel.org>
> >> Link: https://lore.kernel.org/all/CANiq72kK4pG=O35NwxPNoTO17oRcg1yfGcvr3==Fi4edr+sfmw@mail.gmail.com/
> >> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> >> ---
> >> This patch was part of the Nova GSP boot series [1], but since it
> >> requires attention from the core Rust team (and possibly the build
> >> maintainers?) and is otherwise buried under Nova patches, I am taking
> >> the freedom to send it separately for visibility.
> >> 
> >> Hopefully it captures Miguel's suggestion [2] accurately, but please let
> >> me know if I missed something.
> >> 
> >> Since the Nova GSP boot series makes use of this, I hope to eventually
> >> merge it alongside the series, through the DRM tree.
> >> 
> >> Thanks!
> >> 
> >> [1] https://lore.kernel.org/all/20251029-gsp_boot-v7-0-34227afad347@nvidia.com/
> >> [2] https://lore.kernel.org/all/CANiq72kK4pG=O35NwxPNoTO17oRcg1yfGcvr3==Fi4edr+sfmw@mail.gmail.com/
> >> ---
> >>  init/Kconfig           |  3 +++
> >>  rust/kernel/lib.rs     |  4 ++++
> >>  rust/kernel/slice.rs   | 63 ++++++++++++++++++++++++++++++++++++++++++++++++++
> >>  scripts/Makefile.build |  3 ++-
> >>  4 files changed, 72 insertions(+), 1 deletion(-)
> >> 
> >> diff --git a/init/Kconfig b/init/Kconfig
> >> index cab3ad28ca49..7da93c9cccc3 100644
> >> --- a/init/Kconfig
> >> +++ b/init/Kconfig
> >> @@ -147,6 +147,9 @@ config LD_CAN_USE_KEEP_IN_OVERLAY
> >>  	# https://github.com/llvm/llvm-project/pull/130661
> >>  	def_bool LD_IS_BFD || LLD_VERSION >= 210000
> >>  
> >> +config RUSTC_HAS_SLICE_AS_FLATTENED
> >> +	def_bool RUSTC_VERSION >= 108000
> >> +
> >>  config RUSTC_HAS_COERCE_POINTEE
> >>  	def_bool RUSTC_VERSION >= 108400
> >>  
> >> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> >> index 3dd7bebe7888..2581a356d114 100644
> >> --- a/rust/kernel/lib.rs
> >> +++ b/rust/kernel/lib.rs
> >> @@ -21,6 +21,9 @@
> >>  #![feature(inline_const)]
> >>  #![feature(pointer_is_aligned)]
> >>  //
> >> +// Stable since Rust 1.80.0.
> >> +#![feature(slice_flatten)]
> >> +//
> >>  // Stable since Rust 1.81.0.
> >>  #![feature(lint_reasons)]
> >>  //
> >> @@ -128,6 +131,7 @@
> >>  pub mod security;
> >>  pub mod seq_file;
> >>  pub mod sizes;
> >> +pub mod slice;
> >>  mod static_assert;
> >>  #[doc(hidden)]
> >>  pub mod std_vendor;
> >> diff --git a/rust/kernel/slice.rs b/rust/kernel/slice.rs
> >> new file mode 100644
> >> index 000000000000..7e837bec4bed
> >> --- /dev/null
> >> +++ b/rust/kernel/slice.rs
> >> @@ -0,0 +1,63 @@
> >> +// SPDX-License-Identifier: GPL-2.0
> >> +
> >> +//! Additional (and temporary) slice helpers.
> >> +
> >> +/// Extension trait providing a portable version of [`as_flattened`] and
> >> +/// [`as_flattened_mut`].
> >> +///
> >> +/// In Rust 1.80, the previously unstable `slice::flatten` family of methods
> >> +/// have been stabilized and renamed from `flatten` to `as_flattened`.
> >> +///
> >> +/// This creates an issue for as long as the MSRV is < 1.80, as the same functionality is provided
> >> +/// by different methods depending on the compiler version.
> >> +///
> >> +/// This extension trait solves this by abstracting `as_flatten` and calling the correct  method
> >> +/// depending on the Rust version.
> >> +///
> >> +/// This trait can be removed once the MSRV passes 1.80.
> >> +///
> >> +/// [`as_flattened`]: slice::as_flattened
> >> +/// [`as_flattened_mut`]: slice::as_flattened_mut
> >> +pub trait AsFlattened<T> {
> >> +    /// Takes an `&[[T; N]]` and flattens it to a `&[T]`.
> >> +    ///
> >> +    /// This is an portable layer on top of [`as_flattened`]; see its documentation for details.
> >> +    ///
> >> +    /// [`as_flattened`]: slice::as_flattened
> >> +    fn as_flattened_slice(&self) -> &[T];
> >> +
> >> +    /// Takes an `&mut [[T; N]]` and flattens it to a `&mut [T]`.
> >> +    ///
> >> +    /// This is an portable layer on top of [`as_flattened_mut`]; see its documentation for details.
> >> +    ///
> >> +    /// [`as_flattened_mut`]: slice::as_flattened_mut
> >> +    fn as_flattened_slice_mut(&mut self) -> &mut [T];
> >> +}
> >> +
> >> +impl<T, const N: usize> AsFlattened<T> for [[T; N]] {
> >> +    #[allow(clippy::incompatible_msrv)]
> >> +    fn as_flattened_slice(&self) -> &[T] {
> >> +        #[cfg(not(CONFIG_RUSTC_HAS_SLICE_AS_FLATTENED))]
> >> +        {
> >> +            self.flatten()
> >> +        }
> >> +
> >> +        #[cfg(CONFIG_RUSTC_HAS_SLICE_AS_FLATTENED)]
> >> +        {
> >> +            self.as_flattened()
> >> +        }
> >> +    }
> >> +
> >> +    #[allow(clippy::incompatible_msrv)]
> >> +    fn as_flattened_slice_mut(&mut self) -> &mut [T] {
> >> +        #[cfg(not(CONFIG_RUSTC_HAS_SLICE_AS_FLATTENED))]
> >> +        {
> >> +            self.flatten_mut()
> >> +        }
> >> +
> >> +        #[cfg(CONFIG_RUSTC_HAS_SLICE_AS_FLATTENED)]
> >> +        {
> >> +            self.as_flattened_mut()
> >> +        }
> >
> > Hmm. Why not have this match the name that this was stabilized under?
> > That way, when bumping the MSRV, we can just remove this trait without
> > changing the callers.
> 
> I expected that doing so would clash with the methods of the same name
> in `slice` on Rust >= 1.80, but instead I just got a warning that my
> `AsFlattened` import was ignored - it looks like Rust did the right
> thing and picked the non-trait method by default.
> 
> So all we need to do to make your proposal work is to make the import
> conditional on Rust being < 1.80. And we can also make the whole trait
> and its impl block that way.
> 
> That would actually be much cleaner! Thanks a lot.

One option is to put the trait in the prelude on relevant rustc
versions. That way, users of the method don't need any conditional
logic.

Alice

