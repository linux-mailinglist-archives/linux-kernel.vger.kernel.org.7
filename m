Return-Path: <linux-kernel+bounces-893007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8097CC46504
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 12:38:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88DBB3B5413
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 11:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 501D430B533;
	Mon, 10 Nov 2025 11:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h/JNlBh9"
Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D832E306B00
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 11:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762774688; cv=none; b=q+6Dao9EXGcu6Lo5FLysuO03KIww08Rre87Ggk1J0QPXRppj8EOJTSSP9iAHO6B5QT2XoTKlqDw9ZxxgM5A+OiOWjkZmFL0Kwms9mVk3/Ec6KngCTwdqrsO5pM2w2bN79bdvilC8PO6XLi5sy9yn6nsDYuAXUEcfPjOXuRtQEtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762774688; c=relaxed/simple;
	bh=uxSBBgdJ6G0wqOTbxb4Aw2gp4edL/LWe0qLGHZZW64A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oo8uCtK0Na1C47f6VBXeLKmQuBg5yjoeEupA1XK4QmPAENz0GpSVGuSdlSiq+Q06y3KHRvcb6P+VhXIo9mz5aigNV83INQjYk3mW1ouJpL6EwkmPf2Csqsjjwso0E/CLKZEuxlBVFpPLw8KrUZbnhLWJDuSHYJ7DNmMaQcelcMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h/JNlBh9; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-6409605a485so2907248a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 03:38:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762774685; x=1763379485; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KMnqzGHQkZQbLlqJI77L5ey44wwkU20ch9eam4NwE+Y=;
        b=h/JNlBh9rSkXgIn7bi2tnlzD0j7SwzJMVwyBijlXQGsyemIGGNCQbwdeOyQd0HrJq2
         Suf9ctGtGA5tSU8HlkdfjDfQdaQ8FtzIKcjsFvPAsGToHyCcrx4hL+Y/RNlV14QB6NIJ
         QmyXuKH8EGNhPOrrnsf1rToK0Gb2zjCv9X89ni2D2CkpADPYDnUkyKaeMRrUIORtoDOe
         7MywCeAsoEfFAA5QWCo8YYJy1HDYqnoHS1VzKjOPytaxDhSt9sJQt/DxDEc1KNwMIOmK
         nGXUlgadghefvUyMl9jP/XwYspnqnEp+TxDl+Q5THEd41/1d2KjSctdd1SV0TQ6B8o3J
         6nQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762774685; x=1763379485;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KMnqzGHQkZQbLlqJI77L5ey44wwkU20ch9eam4NwE+Y=;
        b=ATttoJCMJpj14thBdRPEvtNKnwqJdTKkX7p0PDEBxf67UGfJEwEIcKlVvxAArtWl1Y
         EUDUd7x800GNRnGytTqxAucgmEeG86205BUZg7lrZquiShEE8BHJmLzIGe4EMShv9Pm/
         9R2wxLF6VJXk4TrBvzo0MBovCx5OmlWnHJdwK/spSHPksFPdWIiMmINdr+7PWvdJkHqa
         f4PaSktlHbWbM7IIO2lP5NwehW94WtGq/4H2lH9dCvsctnFWl7E3jA+ae8PiVBJxmvwR
         NT/AkAgrgZl4kbA76wgTA1P77O71sA8m8G5KIDVxBZhnXP+bHTDU+Ayy2Lybf62qb0SU
         yzgA==
X-Forwarded-Encrypted: i=1; AJvYcCWL4BWrV/2jlnVV8ON6UYqB7HKoXOWHGKY4mVxTLFswxJI5QLR7OPcXFKubP4N5yJr81QBBZU5HFntCe6w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyP+EXryw0Y7T4INRyKIGjy4/6xCibP3/VEJuLEqNMEhIc972zY
	oba5v6Tyi+RQkNQ9aVh2rC0cnu2RBwsD6dQ8u2BNfl6J2d91xZ5RzoezTcldT0OIuH9w3RYJMR9
	A4Ee3+V8yl9fAIJDsDw==
X-Google-Smtp-Source: AGHT+IGSOTdSHkqL0poJ5tqc7TrtRGaLiDYCsGpAd4/lDD5jX1KPXKGf/AHVmm5qz5MunTDbIDoNGHc6Ka1J5BQ=
X-Received: from edbek21.prod.google.com ([2002:a05:6402:3715:b0:640:cfc4:f37f])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:354b:b0:640:9b11:5d65 with SMTP id 4fb4d7f45d1cf-6415e822920mr5942384a12.24.1762774685141;
 Mon, 10 Nov 2025 03:38:05 -0800 (PST)
Date: Mon, 10 Nov 2025 11:38:04 +0000
In-Reply-To: <20251110095025.1475896-10-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251110095025.1475896-1-ojeda@kernel.org> <20251110095025.1475896-10-ojeda@kernel.org>
Message-ID: <aRHOnGyLx-bEVqcY@google.com>
Subject: Re: [PATCH 09/18] rust: proc-macro2: enable support in kbuild
From: Alice Ryhl <aliceryhl@google.com>
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	patches@lists.linux.dev
Content-Type: text/plain; charset="utf-8"

On Mon, Nov 10, 2025 at 10:50:14AM +0100, Miguel Ojeda wrote:
> With all the new files in place and ready from the new crate, enable
> the support for it in the build system.
> 
> `proc_macro_byte_character` and `proc_macro_c_str_literals` were
> stabilized in Rust 1.79.0 [1] and were implemented earlier than our
> minimum Rust version (1.78) [2][3]. Thus just enable them instead of using
> the `cfg` that `proc-macro2` uses to emulate them in older compilers.
> 
> Link: https://github.com/rust-lang/rust/pull/123431 [1]
> Link: https://github.com/rust-lang/rust/pull/112711 [2]
> Link: https://github.com/rust-lang/rust/pull/119651 [3]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> ---
>  Makefile                          |  3 +++
>  rust/Makefile                     | 32 +++++++++++++++++++++++++++++--
>  scripts/generate_rust_analyzer.py |  7 +++++++
>  3 files changed, 40 insertions(+), 2 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index fb4389aa5d5f..6ff887523eee 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1830,6 +1830,9 @@ PHONY += rustfmt rustfmtcheck
>  
>  rustfmt:
>  	$(Q)find $(srctree) $(RCS_FIND_IGNORE) \
> +		\( \
> +			-path $(srctree)/rust/proc-macro2 \
> +		\) -prune -o \
>  		-type f -a -name '*.rs' -a ! -name '*generated*' -print \
>  		| xargs $(RUSTFMT) $(rustfmt_flags)
>  
> diff --git a/rust/Makefile b/rust/Makefile
> index 9eea6563ef35..a614a23023cb 100644
> --- a/rust/Makefile
> +++ b/rust/Makefile
> @@ -27,6 +27,8 @@ endif
>  
>  obj-$(CONFIG_RUST) += exports.o
>  
> +always-$(CONFIG_RUST) += libproc_macro2.rlib
> +
>  always-$(CONFIG_RUST_KERNEL_DOCTESTS) += doctests_kernel_generated.rs
>  always-$(CONFIG_RUST_KERNEL_DOCTESTS) += doctests_kernel_generated_kunit.c
>  
> @@ -76,6 +78,17 @@ core-flags := \
>      --edition=$(core-edition) \
>      $(call cfgs-to-flags,$(core-cfgs))
>  
> +proc_macro2-cfgs := \
> +    feature="proc-macro" \
> +    wrap_proc_macro \
> +    $(if $(call rustc-min-version,108800),proc_macro_span_file proc_macro_span_location)
> +
> +# Stable since Rust 1.79.0: `feature(proc_macro_byte_character,proc_macro_c_str_literals)`.
> +proc_macro2-flags := \
> +    --cap-lints=allow \
> +    -Zcrate-attr='feature(proc_macro_byte_character,proc_macro_c_str_literals)' \
> +    $(call cfgs-to-flags,$(proc_macro2-cfgs))
> +

I don't understand this. We enable the features even on 1.79, but we
only pass the proc_macro_span_file, proc_macro_span_location cfgs on
1.88 and above?

We add the appropriate feature(_) invocations on older compilers, so
should we not support those things on those compilers?

Alice

