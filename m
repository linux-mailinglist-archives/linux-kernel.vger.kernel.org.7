Return-Path: <linux-kernel+bounces-766142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FC19B242C8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 09:34:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3F68188E4B8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 07:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BF9E2DA778;
	Wed, 13 Aug 2025 07:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H8s3rm4y"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C682C3248
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 07:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755070248; cv=none; b=cBLZLoGgxB4ylOfnYEyoGJAareQppcwQRWoQXH2hdbepAIU7/4Rf7FGTrKzaob9kU1FCdC1WilQez8zAY6WY23kHrQEmTwfC0aUr7t28+HispTmgzETA4YGgJjNraf1dfANtTMB4hDhBFjK6gePUZQsl7toS75yiu4rFwAa6nNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755070248; c=relaxed/simple;
	bh=xFiWYf6vm77n+FxmlLtopRR841nq8GvnS98l1p0hoP4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OGdQ39nvjIQFt1TuUCX6Fb8NKVXrOwUHO6yJuQxjvSeBuBzI0LTpynx1YaAOTGRYAapaZnxSIcAZs23sazkK+1diVZctr1b3Z5+V627mFoo/nxsMUhYhUgG4q9k5/3JobRmUeSCecxXu5yDm5SamEhQF7exhva4sPZb87vQ941c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H8s3rm4y; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3b8d5fc4f94so884173f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 00:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755070246; x=1755675046; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=I9E4czyKyrtOFU4GSVFspn06u33hT1ZkBVcdtezrkgQ=;
        b=H8s3rm4yEQ8hRnqUGBhHfc9lBf/KbWZoDRnL7lFAUKJSrieeGQIQFIBMLEuOPk+Gnq
         uIKZ/npSz8lEsEEiB+pzpgYn/VOx1fnqlXBOa2m2zwpceULZxhohAKa5VIyeB5GanIpB
         zFQm04yutDLfs0WOcfsRZW1qMKVkBTCbt5MZ6P0418vrvzQXs3NFDN3hvHIyz0YfrAgH
         QMhRnq0ZX5ihjlPzK5btfFvHx1DxNgQ2606TMxHy/ruXWwkydo7RnYgOXMIICPt9WbU2
         CcFguxXmR1ZGnL07FveCIuEgyBK+0Ik8siKemLMRQPMY5wClc/1sAZgnoPb4svrZuU0R
         Onmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755070246; x=1755675046;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I9E4czyKyrtOFU4GSVFspn06u33hT1ZkBVcdtezrkgQ=;
        b=GnQri6Y8yczL/4vWtmMlp/0084CYs8H1fvqUKqnhDyk3iVDCFg7i5ICQZd03/BOkDb
         Qz3Oy8XtzEOGrHSPxhNpafWoMpDz/i8BHeFwYB2MD6b+rAfm4ubPiBl2TczSi4BAA2ps
         O1ySRmSnlkocc/XjO55bxJ36hpDTpD2Z9LGnW7akmDtcad8D05bMD8u8MrXHHiJsh4A3
         j2GZH9FWaZ73IC/meCsP8JxAJrcsz61rtCzYmTpX78eLYiEl+U0r+YGc/RjfPEBc655D
         YxOkdUtMu98pyqha362ByigKaFTnE/7IA+5ms+30JH5PhL7SzV7ZDE0yPzKRoBt/bcl6
         RIbw==
X-Forwarded-Encrypted: i=1; AJvYcCXXOnpRcdzINGdB0NWS0iH7ib3FkGFXt0BGtlUPhzHSkNGJ6vkAuVDlF/MfS6Lbn8WrNY5R6jutSMkRTKo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXjtqIXCf37ujCaPWgiR39UxoEdErKrs6RvUQ/5OGXu7VzGYZV
	kmwB60dRBG/XVVbXGkF0XRetqivMe8g9S8miedJBD2kpij+J1rnGhpMJFonQWKcmgp/pNfWt+Zf
	/YkTQqNADhN912IiyhQ==
X-Google-Smtp-Source: AGHT+IHo652ghTmRZRdcMehtLxMpYB3nmtn0BGPYwzhYi+iVXFrTKYXDm2Ct2IcY8FiWrF3mc/zYizwObHRd2AA=
X-Received: from wre18.prod.google.com ([2002:a05:6000:4b12:b0:3b9:95c:a591])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:402a:b0:3b7:8fcd:d145 with SMTP id ffacd0b85a97d-3b917d2b1b8mr1298903f8f.5.1755070245509;
 Wed, 13 Aug 2025 00:30:45 -0700 (PDT)
Date: Wed, 13 Aug 2025 07:30:43 +0000
In-Reply-To: <20250812-rnull-up-v6-16-v4-12-ed801dd3ba5c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250812-rnull-up-v6-16-v4-0-ed801dd3ba5c@kernel.org> <20250812-rnull-up-v6-16-v4-12-ed801dd3ba5c@kernel.org>
Message-ID: <aJw_I-YQUfupWCXL@google.com>
Subject: Re: [PATCH v4 12/15] rust: block: add `GenDisk` private data support
From: Alice Ryhl <aliceryhl@google.com>
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Tue, Aug 12, 2025 at 10:44:30AM +0200, Andreas Hindborg wrote:
> Allow users of the rust block device driver API to install private data in
> the `GenDisk` structure.
> 
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>

Overall LGTM.
Reviewed-by: Alice Ryhl <aliceryhl@google.com>

>          self,
>          name: fmt::Arguments<'_>,
>          tagset: Arc<TagSet<T>>,
> +        queue_data: T::QueueData,
>      ) -> Result<GenDisk<T>> {
> +        let data = queue_data.into_foreign();
> +        let recover_data = ScopeGuard::new(|| {
> +            drop(
> +                // SAFETY: T::QueueData was created by the call to `into_foreign()` above
> +                unsafe { T::QueueData::from_foreign(data) },
> +            );

This is usually formatted as:

// SAFETY: T::QueueData was created by the call to `into_foreign()` above
drop(unsafe { T::QueueData::from_foreign(data) });

>  impl<T: Operations> Drop for GenDisk<T> {
>      fn drop(&mut self) {
> +        // SAFETY: By type invariant of `Self`, `self.gendisk` points to a valid
> +        // and initialized instance of `struct gendisk`, and, `queuedata` was
> +        // initialized with the result of a call to
> +        // `ForeignOwnable::into_foreign`.
> +        let queue_data = unsafe { (*(*self.gendisk).queue).queuedata };
> +
>          // SAFETY: By type invariant, `self.gendisk` points to a valid and
>          // initialized instance of `struct gendisk`, and it was previously added
>          // to the VFS.
>          unsafe { bindings::del_gendisk(self.gendisk) };
> +
> +        drop(
> +            // SAFETY: `queue.queuedata` was created by `GenDiskBuilder::build` with
> +            // a call to `ForeignOwnable::into_foreign` to create `queuedata`.
> +            // `ForeignOwnable::from_foreign` is only called here.
> +            unsafe { T::QueueData::from_foreign(queue_data) },
> +        );

Ditto here.

>          //    reference counted by `ARef` until then.
>          let rq = unsafe { Request::aref_from_raw((*bd).rq) };
>  
> +        // SAFETY: `hctx` is valid as required by this function.
> +        let queue_data = unsafe { (*(*hctx).queue).queuedata };
> +
> +        // SAFETY: `queue.queuedata` was created by `GenDisk::try_new()` with a
> +        // call to `ForeignOwnable::into_pointer()` to create `queuedata`.
> +        // `ForeignOwnable::from_foreign()` is only called when the tagset is
> +        // dropped, which happens after we are dropped.
> +        let queue_data = unsafe { T::QueueData::borrow(queue_data.cast()) };

Is this cast necessary? Is it not a void pointer?

> @@ -110,9 +129,18 @@ impl<T: Operations> OperationsVTable<T> {
>      ///
>      /// # Safety
>      ///
> -    /// This function may only be called by blk-mq C infrastructure.
> -    unsafe extern "C" fn commit_rqs_callback(_hctx: *mut bindings::blk_mq_hw_ctx) {
> -        T::commit_rqs()
> +    /// This function may only be called by blk-mq C infrastructure. The caller
> +    /// must ensure that `hctx` is valid.
> +    unsafe extern "C" fn commit_rqs_callback(hctx: *mut bindings::blk_mq_hw_ctx) {
> +        // SAFETY: `hctx` is valid as required by this function.
> +        let queue_data = unsafe { (*(*hctx).queue).queuedata };
> +
> +        // SAFETY: `queue.queuedata` was created by `GenDisk::try_new()` with a
> +        // call to `ForeignOwnable::into_pointer()` to create `queuedata`.
> +        // `ForeignOwnable::from_foreign()` is only called when the tagset is
> +        // dropped, which happens after we are dropped.
> +        let queue_data = unsafe { T::QueueData::borrow(queue_data.cast()) };

Ditto here.

Alice

