Return-Path: <linux-kernel+bounces-770444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 549BFB27AC5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 10:19:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 720511C8270F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 08:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4908347DD;
	Fri, 15 Aug 2025 08:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wOSQ28Bo"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06AE78F51
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 08:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755245943; cv=none; b=DmKIutJ4Rts/H4DdGzaKywIagMbVtMgQADpK8Xwjz+nrzLvqsoHrRyxWaJozB7vrnN3mu9jsm6H0BdXPd2XhCPMh3vDIcey206ExW5/e322/lZKk3Z4d1sxQvfxCs3JVVwX1QxA9Bf4FbuXwdtuRT/4K3fawHGtyZf5tJgYzvRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755245943; c=relaxed/simple;
	bh=qYNnASJXGgxVvYIwlxVKql8fQDStNuzDeqooYI3aAFg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nJfMg40BDh9jxcyxPTC8zqsi3PynnSHIY6a0SH/gFVCrm5s5/qRfNmy7IUx/SKOqdoGHVkrK/50FkZl7yj8b7NJJm8m1VJjYCC4UYPvu63sJ4X2pL18QCjvjFBR0CdlzS2vKucgQ6ndFjEUaKecjkYgaQkWJVfM/npRDS4VrNWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wOSQ28Bo; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3b9e41475edso1080055f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 01:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755245940; x=1755850740; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=683V42xtEdd11uSq7e5NHFZBkZMDGTB8S0uZQebs/ak=;
        b=wOSQ28Bo158IqBqy/pWlDlFsgtv9lfDvzorqDQKoth20vEcitXK+2wDnxfOALv7fHa
         dUak24mcckjIEVFM9bPAPC022MTuZJ4EwkRnWUcpwZZT6OFgmlLjtuf6npzuc7nZwmE/
         kQ7mwFi+d6erloD63Pe0pXsHkhftKzd+JYmu2JPW9WyOOO87valTu1DRAqvWUdTNO7hX
         Dp5fSu8G1HNEmP/4D650Yo89oaUTs70BX9aAVdgZSe5lXVDC9GRrLGX25h2vOO7HU2eO
         3YXDFHABpy/F4j0G47HQA4kcyAsWXL/7LP8QvJoMkWU3w2A14KcBj8YU0rojYWDpgkyC
         Z4oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755245940; x=1755850740;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=683V42xtEdd11uSq7e5NHFZBkZMDGTB8S0uZQebs/ak=;
        b=jK0CnDKa5dDrRiZeqP3sBE93wl75g9m+GpVeqQkJuQJ7RYo4223xxPmEwkEzprBYSg
         6bir8AzbRzgXn+E7xPGCYR+FIOSM3Dv1AkfsO0gQLGO2uiGc/ynMg9b+BBQFAsvcuiLR
         ++bTGMuc14Sj8C2x6SIWxioeHHArCKQ0Ne+Ol7W0cqxXvm483eGAQiiSdE2hsEagviE+
         NSZ/z/qdv9QLc0qY1kK+FCMyifD4k/jbI3jZiGzsUcf0irD4MuF1UohhZZgu96BfRm1A
         Mr7HnKF2f9u4kvX2cCkIqECh/Rl/eJgiqDEtWSeMCWbY/gvW8/f2xpPGafHft9FBbLrA
         04zg==
X-Forwarded-Encrypted: i=1; AJvYcCXE7v0m9lNK9dR9/HyBNCfRzmBIWkiOOw71BxTkF476LheymWyIVexWyV85ouQuASI2WfuAMbbsHW/M1cI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2fgG0quJ7Ys7uius+RTkz+2oHf28nBPAuIL4z5vtn2/Doqv6D
	4rTgFDtTjO1x/NMr3H5siyxxte5HlsxAAFUEpQSMRUtlVqGJh9ELJFZkaAt9hcLHyOVPqP3roDi
	rLpA+JYV0VJW4d4E8hQ==
X-Google-Smtp-Source: AGHT+IE+8bwfxGrPX5c+j72P+UldeW2lUoB6l/CiAAVFVMchFmuMTZGNT3nWFVg4Xnt+KARKO8gZ/bdkM0nin/4=
X-Received: from wmsd12.prod.google.com ([2002:a05:600c:3acc:b0:459:eecf:e14e])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a5d:64e8:0:b0:3b7:89a2:bb8c with SMTP id ffacd0b85a97d-3bb671f5058mr803318f8f.16.1755245939593;
 Fri, 15 Aug 2025 01:18:59 -0700 (PDT)
Date: Fri, 15 Aug 2025 08:18:58 +0000
In-Reply-To: <20250815-rnull-up-v6-16-v5-15-581453124c15@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250815-rnull-up-v6-16-v5-0-581453124c15@kernel.org> <20250815-rnull-up-v6-16-v5-15-581453124c15@kernel.org>
Message-ID: <aJ7tcmOHfFmHgrY9@google.com>
Subject: Re: [PATCH v5 15/18] rust: block: add `GenDisk` private data support
From: Alice Ryhl <aliceryhl@google.com>
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Breno Leitao <leitao@debian.org>, linux-block@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Fri, Aug 15, 2025 at 09:30:50AM +0200, Andreas Hindborg wrote:
> Allow users of the rust block device driver API to install private data in
> the `GenDisk` structure.
> 
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

>          self,
>          name: fmt::Arguments<'_>,
>          tagset: Arc<TagSet<T>>,
> +        queue_data: T::QueueData,
>      ) -> Result<GenDisk<T>> {
> +        let data = queue_data.into_foreign();
> +        let recover_data = ScopeGuard::new(|| {
> +            // SAFETY: T::QueueData was created by the call to `into_foreign()` above
> +            drop(unsafe { T::QueueData::from_foreign(data) });
> +        });
> +
>          // SAFETY: `bindings::queue_limits` contain only fields that are valid when zeroed.
>          let mut lim: bindings::queue_limits = unsafe { core::mem::zeroed() };
>  
> @@ -113,7 +121,7 @@ pub fn build<T: Operations>(
>              bindings::__blk_mq_alloc_disk(
>                  tagset.raw_tag_set(),
>                  &mut lim,
> -                core::ptr::null_mut(),
> +                data.cast(),

Is the cast necessary?

Alice

