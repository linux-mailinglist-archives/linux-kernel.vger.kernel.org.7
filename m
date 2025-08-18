Return-Path: <linux-kernel+bounces-773559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA746B2A18E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 14:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C97B3AD048
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 12:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 813D22264B2;
	Mon, 18 Aug 2025 12:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="db2Gr3ZP"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14FB2309BE
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 12:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755520077; cv=none; b=JWhlUbCgzO6FiqagwAVzKCSz/olZz7I6BGt4fNJ6G9JXiIqiXXpBIScLkGvjvkLY0OUD9lduSQ/a4Qu5Yl0a5VQLgGOhJEimafyLqXuOKBlAy18G81+gfwbYT0yrw+hsKSKbdCOB51mvWEllAmmi2bJfpuHgwktlIzDPbuzVbRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755520077; c=relaxed/simple;
	bh=c44Z6yQp8ysYueekb2CfKo8BEtCobKFj2t3T1e9UxtQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=p8vTVKYoaZgYRuhLGFLLwxxJi0swicSsMP48/Qhfg3vcuhSCs7ZFssMEkrowdacczeDl0Fyx/142uaR/ti2AsTSmwDafKig1sNimCTmmfaPl0J8DwEgv93CV58Vj2QWFWtkamdn5O20rK/uOcG7SOTwTK5zZTTlHWR5w8IlmvX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=db2Gr3ZP; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-45a1b0d221aso16091045e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 05:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755520074; x=1756124874; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UwX7zuNS/X2mIasfqo3N5De8MZW3EwFMFitLgES6eLg=;
        b=db2Gr3ZPF8wxYngqyAmUY5vs3AVB0U8/cPbrvg8SSCDHQVNqb1hUodSYaaBqM1jcSG
         Hunlr/O5jtLruYIpmPe77SV1xPPjMYFWDIwhj9M0L9aVkzlgvsbGPHHBq/ru6uV788W3
         pJv7B/nFKQ6rxnEk/E/iqCKYUs32jP3TIVJcKj27ZK57GUw2mY322s7/G8CurgxqM6Ad
         lBD/oPcXsOZT+Tgwrq+6erxs1T0TJvE3+WZUSjDp7LrgqCNPJsvmzXZSKCOevDreH7UT
         ftrWG78+8fggWwhmDxsUJ1jl/YyZpVGz1pZZHC+vO18yB9vrTtZ3UOX/Mua89iAKXIiu
         q0Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755520074; x=1756124874;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UwX7zuNS/X2mIasfqo3N5De8MZW3EwFMFitLgES6eLg=;
        b=RIC5Vh/DEsgtncpBi6I1gxyIY9OdSZOwgy52WwSf1IZ+0S8Eif7uypSImUJEad/th4
         vHX6Pq5cViO2uYnUoW9Y7691B+0IytSrxPbwFul4857CQzlyv8/3dF0HTc6aMpG/WUJ0
         uyzLxOitWzPCTMhUKGxaP+ZQ6jK7ldw7VcS1M4G5aHAzqQrn5mayx5VzhSiRgGN1vuq6
         wwgUlmyd57zXoemgCAwf3/AEA2v3XWJcQ6G6PhkqCIUFU5xBCT/nbFzXTDv6dMPkdLHR
         TB/xqkyuFJcM8gccwN/xdSH9fJCTs1IzJwjJKF7CDW5zLTd1rzbma9/X4CJ1ljxsJMr+
         LZDA==
X-Forwarded-Encrypted: i=1; AJvYcCVgy1K91wsMSbQICFlpAgQhVbOon8+whxEibwnQfucsnUNeJ7AVQaXzerbuuaWylXC6GGxMAwORrgw889Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzk+dZJpMPI4Gle0Uji3aDy7pkbbyMms367txNzQSWomsSuajuo
	2W3v8S8d2ohqGunNV40F1rBS6iSo1bIzaW2+YnT41qJ1axq77rEdFFwy0sht7WHpulTN13cXQ7i
	+VHcd/FtyEEqB9NAHrQ==
X-Google-Smtp-Source: AGHT+IFPVIzj1heJC4xdYp57RPHBBljMZk8U+lP7fm9+s51jcjtAr6Yb9xHWJbThKl2wyBq7MibFQndBCgCu4ws=
X-Received: from wmpz13.prod.google.com ([2002:a05:600c:a0d:b0:459:dcca:571e])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:8507:b0:456:2b4d:d752 with SMTP id 5b1f17b1804b1-45a285ca477mr54960285e9.20.1755520074198;
 Mon, 18 Aug 2025 05:27:54 -0700 (PDT)
Date: Mon, 18 Aug 2025 12:27:53 +0000
In-Reply-To: <DC5IF4AUVJP6.5B68OUOXQLCM@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250815171058.299270-1-dakr@kernel.org> <20250815171058.299270-3-dakr@kernel.org>
 <aKL338gQ7qPNKoBu@google.com> <DC5IF4AUVJP6.5B68OUOXQLCM@kernel.org>
Message-ID: <aKMcSWXEFZXIkwG6@google.com>
Subject: Re: [PATCH 2/4] rust: scatterlist: Add type-state abstraction for sg_table
From: Alice Ryhl <aliceryhl@google.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: akpm@linux-foundation.org, ojeda@kernel.org, alex.gaynor@gmail.com, 
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	lossin@kernel.org, a.hindborg@kernel.org, tmgross@umich.edu, 
	abdiel.janulgue@gmail.com, acourbot@nvidia.com, jgg@ziepe.ca, 
	lyude@redhat.com, robin.murphy@arm.com, daniel.almeida@collabora.com, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Mon, Aug 18, 2025 at 01:16:55PM +0200, Danilo Krummrich wrote:
> On Mon Aug 18, 2025 at 11:52 AM CEST, Alice Ryhl wrote:
> > On Fri, Aug 15, 2025 at 07:10:03PM +0200, Danilo Krummrich wrote:
> >> +/// A single entry in a scatter-gather list.
> >> +///
> >> +/// An `SGEntry` represents a single, physically contiguous segment of memory that has been mapped
> >> +/// for DMA.
> >> +///
> >> +/// Instances of this struct are obtained by iterating over an [`SGTable`]. Drivers do not create
> >> +/// or own [`SGEntry`] objects directly.
> >> +#[repr(transparent)]
> >> +pub struct SGEntry(Opaque<bindings::scatterlist>);
> >
> > Send/Sync?
> 
> I think SGEntry doesn't need it, but both would be valid.
> 
> For the other types, I simply forgot to impl Sync.

I would add them when it's valid to do so.

> >> +        // SAFETY: `self.as_raw()` is a valid pointer to a `struct scatterlist`.
> >> +        unsafe { bindings::sg_dma_address(self.as_raw()) }
> >> +    }
> >> +
> >> +    /// Returns the length of this SG entry in bytes.
> >> +    pub fn dma_len(&self) -> u32 {
> >
> > Is u32 really the right length type?
> 
> The C type uses unsigned int unfortunately, and SG entries larger than u32
> probably don't make sense.
> 
> Formally, bus addresses and hence this size, can exceed size_t. However, it
> obviously makes no sense for this to happen, so size_t would be a reasonable
> choice. ressource_size_t would be resonable too.

resource_size_t is what makes sense in my mind.

> >> +/// # Invariants
> >> +///
> >> +/// `sgt` is a valid pointer to a `struct sg_table` for the entire lifetime of an [`DmaMapSgt`].
> >
> > I think we probably want an invariant for why it's safe to call
> > dma_unmap_sgtable in Drop.
> 
> I assume you're suggesting that the invariant should say that the SG table is
> always mapped? And that we should add a safety requirement to DmaMapSgt::new()
> that the caller must guarantee that the SG table is never unmapped other than by
> dropping DmaMapSgt?
> 
> If so, that sounds reasonable.

Something like that, yeah.

> >> +struct DmaMapSgt {
> >> +    sgt: NonNull<bindings::sg_table>,
> >> +    dev: ARef<Device>,
> >> +    dir: dma::DataDirection,
> >> +}
> 
> <snip>
> 
> >> +impl RawSGTable {
> >> +    fn new(
> >> +        mut pages: KVec<*mut bindings::page>,
> >> +        size: usize,
> >> +        max_segment: u32,
> >> +        flags: alloc::Flags,
> >> +    ) -> impl PinInit<Self, Error> {
> >> +        try_pin_init!(Self {
> >> +            sgt <- Opaque::try_ffi_init(|slot: *mut bindings::sg_table| {
> >> +                // `sg_alloc_table_from_pages_segment()` expects at least one page, otherwise it
> >> +                // produces a NPE.
> >> +                if pages.is_empty() {
> >> +                    return Err(EINVAL);
> >> +                }
> >> +
> >> +                // SAFETY:
> >> +                // - `slot` is a valid pointer to uninitialized memory.
> >> +                // - As by the check above, `pages` is not empty.
> >> +                error::to_result(unsafe {
> >> +                    bindings::sg_alloc_table_from_pages_segment(
> >> +                        slot,
> >> +                        pages.as_mut_ptr(),
> >> +                        pages.len().try_into()?,
> >
> > The `pages` vector is dropped immediately after this call to
> > sg_alloc_table_from_pages_segment. Is that ok?
> 
> Yes, it's only needed during sg_alloc_table_from_pages_segment().
> 
> > If it's ok, then I would change `pages` to `&[*mut page]` so that the
> > caller can manage the allocation of the array.
> 
> We can immediately drop it after sg_alloc_table_from_pages_segmen(), so why do
> we want the caller to take care of the lifetime?

I think the API is easier to understand that way. With a slice, it's
clear that you only expect it to be alive for the duration of the
method. Whereas with a vector, it looks like you're going to keep the
allocation alive long-term, but that's not the case.

> >> +impl<P> Owned<P>
> >> +where
> >> +    for<'a> P: page::AsPageIter<Iter<'a> = VmallocPageIter<'a>> + 'static,
> >
> > If you specifically require the iterator type to be VmallocPageIter,
> > then I would hard-code that in the trait instead of specifying it here.
> 
> I do not follow, hard-code in which trait?

By hard-code, I meant that you refer to `VmallocPageIter` directly in
`trait AsPageIter`. But I don't think that's the correct solution.

> > But I think you just want `P: AsPageIter`.
> 
> Yeah, I thought for now it's probably good enough to require VmallocPageIter and
> revisit once we get more implementors of AsPageIter, but I think we can also do
> it right away.
> 
> I think we'd need a trait PageIterator, which implements page_count(), since we
> technically can't rely on Iterator::size_hint(). Though, in this case I think we
> can also just make AsPageIter::Iter: ExactSizeIterator?

I mean, ExactSizeIterator is not an unsafe trait, so it's allowed to lie
about the length. But it doesn't look like getting it wrong has any
problematic consequences here. At most we allocate too much in the
vector, or we have to reallocate it.

> >> +{
> >> +    fn new(
> >> +        dev: &Device<Bound>,
> >> +        mut pages: P,
> >> +        dir: dma::DataDirection,
> >> +        flags: alloc::Flags,
> >> +    ) -> Result<impl PinInit<Self, Error> + use<'_, P>> {
> >
> > We would probably want to move the logic into the initializer so that we
> > don't have the double Result here.
> 
> That'd be nice, but I think it's not possible.
> 
> We can't borrow from pages in the initializer closure while at the same time
> store pages with another initializer, can we?
> 
> Either way, it's not that big a deal I think, since this constructor is not
> exposed to the outside world. Which is also why it didn't bother me too much.

Ok. Shrug.

Alice

