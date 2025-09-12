Return-Path: <linux-kernel+bounces-813419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38E70B54520
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 10:21:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B26DE3B9B7A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 08:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DF192D7386;
	Fri, 12 Sep 2025 08:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Doqc4iw3"
Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D493253355
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 08:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757665222; cv=none; b=k+Ij1mALQRePNlFHXLLwcimFiB6ZGWGOtt+rMjII9xMzodEO8IKUFw6KQsmJy5GFFxktVf9zsAFHaBiw9lFCnFR2GqYaKuUGAP7zBS62j+ff7eWR8AsX6Udk/E20qlGGzW2x/6/HLKdndLR/ccgFLiyGlEyBO+josaWU7nWj+4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757665222; c=relaxed/simple;
	bh=uyTp1DNo2Pl+/MWTpG2OwBe458XML+7oqAeQeYUzoZk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WtNqonm1I0muX2n8CwNRGuTyH9/V0BXNJaFOp6Lm62Yo6lPTblTdKvk5k2gafyFAq3/dWyAXFvt2f1XWyThWBe5JqPb1TuwXuSHEPBx8HL9n0slEzCPv39dJctedityYeBlMB+slHa+j6dB/9Fb43EKcKxlTTVYoikT171ENiJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Doqc4iw3; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-b07c9056963so33303366b.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 01:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757665219; x=1758270019; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=htk3m70PkqmNQYQ1yM5F8kN8JeFHH68mo4wtDzJpwoU=;
        b=Doqc4iw393hc9nTtbgtGwR3gXH243VsCbpvfc5vea+JrdIAh8hKtwkQ2L9kd6R9+Cc
         zHMrWD1bWBjmdogYzaW7R9pFrXOq4g5rhg6WHjzpTJUWxo90o5cfIlF6nJpushw/WabJ
         yi3W9tPNGuEI5pzi+Y0cKePpYelsrRaMIXZEk8R/X/+SI9gAAE457n/cJaPhIUU/vU3I
         JpDrmaf9sBGUkyXafgMdoPLio7ahrYzSkur/6V/eNrMRWmQwh7kqVJkcEgEkLoRBKhCv
         JRV//5g/GQ8+kDIypoOB++usaw6G39WWIaVM4tI2CRe6aDd9G+rVuRD7YB0XzcY889cG
         2llg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757665219; x=1758270019;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=htk3m70PkqmNQYQ1yM5F8kN8JeFHH68mo4wtDzJpwoU=;
        b=s0QfYM8zwWJaDVVGhcQubKpvtAoSF9fcSqCM6s2TKcguQS84OgAlEXiDYBBIBnNWfQ
         +wDe+bdSyfmVmDcRetD2ufeLHTwKQonY+XYTI1g77bpk6yHcXlNwsqepVzUAGLbgNTOw
         lDrpswcIZJgvTOe7qvdprfiVaRcTWgLWA+z1GBzcZL0l9/qwSs+XO0GxWKd+KtKCNiXN
         JuvY+t81eVEW/iaJRGuNj6VhLOwf3bPnzRe2whAW8TiDRk6KFK8g3LSKbwN022q+HWWL
         xFqpAc3a1ArTq6OMho0H6YyfEt/G77MOKNXVAr1vy9s8EXk00QDfRFNT5duO/xur9g32
         EGOA==
X-Forwarded-Encrypted: i=1; AJvYcCXbj1fxAl0O0mthOOToLDLjMITEcUBpe6sECbrTxehUbI9xXylRHgUbJcRPvNQssSb+7e2HiVlU2VTvUsU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ7kvIb8YeHavZbCI6lNtcSIX2PFIdWcjZzNfyBFcJ5ruXNEq8
	tkTQYJcSsqbQPRmOYkexEzebxHqFBoOSMy24OTcOg0KdEWrMj3Wm5pgbNUpL/CLTRTn28n0OhlH
	xT4a3+EocuTj/Z92VmA==
X-Google-Smtp-Source: AGHT+IGUMJAjpyCLFfDMgu2t5nhGP0t48j39Qyhwy6+dlmbmq8TAneB4QA7fEvHNFobhxTxMbIPzssYdjTCps3M=
X-Received: from ejej11.prod.google.com ([2002:a17:906:2a0b:b0:aff:53b:4790])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:980a:b0:b04:7ea3:a10c with SMTP id a640c23a62f3a-b07c3551576mr183083666b.8.1757665219559;
 Fri, 12 Sep 2025 01:20:19 -0700 (PDT)
Date: Fri, 12 Sep 2025 08:20:18 +0000
In-Reply-To: <20250911230147.650077-4-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250911230147.650077-1-lyude@redhat.com> <20250911230147.650077-4-lyude@redhat.com>
Message-ID: <aMPXwhpskU1gWANU@google.com>
Subject: Re: [PATCH v4 3/3] rust: Add dma_buf stub bindings
From: Alice Ryhl <aliceryhl@google.com>
To: Lyude Paul <lyude@redhat.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, Daniel Almeida <daniel.almeida@collabora.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>, 
	"Christian =?utf-8?B?S8O2bmln?=" <christian.koenig@amd.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Tamir Duberstein <tamird@gmail.com>, Xiangfei Ding <dingxiangfei2009@gmail.com>, 
	"open list:DMA BUFFER SHARING FRAMEWORK:Keyword:bdma_(?:buf|fence|resv)b" <linux-media@vger.kernel.org>, 
	"moderated list:DMA BUFFER SHARING FRAMEWORK:Keyword:bdma_(?:buf|fence|resv)b" <linaro-mm-sig@lists.linaro.org>
Content-Type: text/plain; charset="utf-8"

On Thu, Sep 11, 2025 at 06:57:40PM -0400, Lyude Paul wrote:
> In order to implement the gem export callback, we need a type to represent
> struct dma_buf. So - this commit introduces a set of stub bindings for
> dma_buf. These bindings provide a ref-counted DmaBuf object, but don't
> currently implement any functionality for using the DmaBuf.
> 
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
> 
> ---
> V3:
> * Rename as_ref() to from_raw()
> V4:
> * Add missing period to rustdoc at top of file
> 
>  rust/kernel/dma_buf.rs | 40 ++++++++++++++++++++++++++++++++++++++++
>  rust/kernel/lib.rs     |  1 +
>  2 files changed, 41 insertions(+)
>  create mode 100644 rust/kernel/dma_buf.rs
> 
> diff --git a/rust/kernel/dma_buf.rs b/rust/kernel/dma_buf.rs
> new file mode 100644
> index 0000000000000..50be3e4dd4098
> --- /dev/null
> +++ b/rust/kernel/dma_buf.rs
> @@ -0,0 +1,40 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! DMA buffer API.
> +//!
> +//! C header: [`include/linux/dma-buf.h`](srctree/include/linux/dma-buf.h)
> +
> +use bindings;
> +use kernel::types::*;
> +
> +/// A DMA buffer object.
> +///
> +/// # Invariants
> +///
> +/// The data layout of this type is equivalent to that of `struct dma_buf`.

I can already deduce that from the fact that it's a repr(transparent)
wrapper around Opaque<bindings::dma_buf>. Invariants should provide
*additional* guarantees that can't be deduced just from the declaration.

I would reword this to say that it contains a valid dma_buf rather than
speaking about the layout.

> +#[repr(transparent)]
> +pub struct DmaBuf(Opaque<bindings::dma_buf>);
> +
> +// SAFETY: `struct dma_buf` is thread-safe
> +unsafe impl Send for DmaBuf {}
> +// SAFETY: `struct dma_buf` is thread-safe
> +unsafe impl Sync for DmaBuf {}
> +
> +#[expect(unused)]

By making these methods pub, you don't need this #[expect].

> +impl DmaBuf {
> +    /// Convert from a `*mut bindings::dma_buf` to a [`DmaBuf`].
> +    ///
> +    /// # Safety
> +    ///
> +    /// The caller guarantees that `self_ptr` points to a valid initialized `struct dma_buf` for the
> +    /// duration of the lifetime of `'a`, and promises to not violate rust's data aliasing rules
> +    /// using the reference provided by this function.

I would just drop the sentence about the aliasing rules. If the caller
performs an unsafe operation on this DmaBuf, then the safety comment on
*that* unsafe operation should justify this - it's not needed here.

And if they violate the aliasing rules with a safe operation, then
probably that safe operation should be redesigned to prevent that,
rather than having a blanket statement here.

Alice

