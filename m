Return-Path: <linux-kernel+bounces-788393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C0D9B383C2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 15:36:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C47DA7C4261
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 13:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ADA1352FFE;
	Wed, 27 Aug 2025 13:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F18HWOZd"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC781CD208
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 13:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756301764; cv=none; b=nomozoZnIypEgWykak8yInh3H28NN8Gu/OfQyK7DX9SsK8CDfzV99eSfAOOywuQ3VaQdkX7heewK8FCn/axL01SeZZMEQhYCemR0laVL1AIgKi8ObgjSBUkipzCZHD4kKqna+uUeMs/rhmfEyi/sCABm5S3SmFxazRumLw3s0HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756301764; c=relaxed/simple;
	bh=4kF4Capffi4pJAT/zuXl0ulNWRdXVyQ2+t47laUeFWo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AOQkncm9N4d9BJJxMUF3rV550YIngL7dehKNx8AT05My90/hX/t6JTF6gVc3ouQA2y3O6PGEck/ttCHjqLUkCYdQRiWkcSFqpheNo++CN++Bfm6GJo3NnORC1bP5qeIh9mCUWOPlcaFYg3XqoP70s3qxORNgpEMJXYdpTCOwZgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F18HWOZd; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3c79f0a5c29so3633377f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 06:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756301761; x=1756906561; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eGOmUMQiFrZLOh8vf9B0X5R9r/nRdm1RYB7hggPhOyQ=;
        b=F18HWOZdH+5aoLwsePksmFGCL9i//vEzWvSyav6Ms6GnjHlJzAJIiIsd+0LZ5y8VnE
         7CJNprlgcig+TFqBl6JTJSeZCwwvY+g6h/K3VdeXmfZMzksTQypcjt8V7/+m+G7HHCKD
         A3u87t2HWnWqcZWi1obGF4E629sFDEzVeJht5+RAsDRHrmo4mhEZ7KTfE7JDXSDVRpHE
         xjgQEagmdGW9kS8hA5F/HGWzcrixL+cNvVk2mZtqcVDjAItu0uBFQTV+OvR+GK8MSq+n
         rrhFVvt4rVEzY3d6aMI5FoZAfbfOkVcH/pcZJeChTFSYMX1vk3WdLOW5Cclg8ezfZpsq
         4Y2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756301761; x=1756906561;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eGOmUMQiFrZLOh8vf9B0X5R9r/nRdm1RYB7hggPhOyQ=;
        b=XA1R49L93PNQODLB0AuvjIpwrz83EhemGDMI6wqS7BIHcxgV4HsNRN09SM4g3IN0ua
         2+cCKakCU6YrrORGOOPfY68IYN0xpKxFkZGRKNsYXn3MCT7vJQjDkVkfF4UdWEWEGcqK
         P+WfYrcSH3G8xTANjrHbSY+pt/cBeYfaRqEgQiIlCl5TrR8FdXzUDYx5PYFE8yymEkHv
         v+uy+W+d/mLeuf76L5VJ48HbBLZzxugH7x2AvT3H55357wOBBE8s8T8Or2s61yVydlVn
         bJAEaWPzrdut8oktnjstueo4Hntb+YyxUo4xHq9KgW9aQot0ihfPn1edEZmer4BCKo4E
         9YVg==
X-Forwarded-Encrypted: i=1; AJvYcCX9akcIcKd65VmNglx0dj2kg9uMeytHIHx9q4Mc+VlgtD+c9V1+yU17MbI8M2RcllQKvoduTqv1Xt1aEFQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdxpBNpYI4ObyLqkONb+t82buuCAEtwkeYwqC7KP0gWBos3ccp
	Y3h3W8Y5gwvUOJeE6f/0he10fTLI2wQEWEKj5pTrAEdEptfSZjTj8DbMnRJ6lCUGy8WSu6Is1QG
	QffMkEkuujjOfeS/BfU36O0Mc0OgyVTqfMgQQzJar
X-Gm-Gg: ASbGncvqg1k3/cssezXdn7h/rXuAZ01iDYG113IcEOe2svYnaqmunavdHsQ+DojUC93
	SPcE97rpgjHsjgkCBf9LutQZuZhGwThSOmyyqKKWd/QB7FODrJNOESInTUl3Neec/wVTZ1+krce
	L4FI/GZaxsvwVoaAYcSnYsSktf7eVH6iRInk7ekyooRvokO3hNKuPz2TPg3H39OZ7f/wgdna7+4
	OipPgftLddw9gGcbo1znzharsiFUiUp7+btBtCfaNTZshg=
X-Google-Smtp-Source: AGHT+IHjHJmGD5DH9knJOvdRvJjpphE0DRT+0QgA7e0zgvj/m6tmppysdXDHMexnnD+ApseovkD6UD97qJ9iYad+xmk=
X-Received: by 2002:a5d:5f8d:0:b0:3c8:89e9:6ab3 with SMTP id
 ffacd0b85a97d-3c889e96d40mr10372677f8f.46.1756301761013; Wed, 27 Aug 2025
 06:36:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822-gpuva-mutex-in-gem-v2-0-c41a10d1d3b9@google.com>
 <20250822-gpuva-mutex-in-gem-v2-3-c41a10d1d3b9@google.com> <DC8VTZ5OZY42.1OCS3QJHZGPAK@kernel.org>
In-Reply-To: <DC8VTZ5OZY42.1OCS3QJHZGPAK@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 27 Aug 2025 15:35:48 +0200
X-Gm-Features: Ac12FXxAkj8iFKvJ5DYueBHinszRbjebva-Cfx5kFVxyDxjx17skWDdJUMDf4aA
Message-ID: <CAH5fLghHYguGp=0OkL11u27x_K7x+xhd1QhQZoub-dQ1QbZpfA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] gpuvm: remove gem.gpuva.lock_dep_map
To: Danilo Krummrich <dakr@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Boris Brezillon <boris.brezillon@collabora.com>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Steven Price <steven.price@arm.com>, 
	Liviu Dudau <liviu.dudau@arm.com>, Rob Clark <robin.clark@oss.qualcomm.com>, 
	Rob Herring <robh@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 22, 2025 at 12:25=E2=80=AFPM Danilo Krummrich <dakr@kernel.org>=
 wrote:
>
> On Fri Aug 22, 2025 at 11:28 AM CEST, Alice Ryhl wrote:
> > diff --git a/include/drm/drm_gpuvm.h b/include/drm/drm_gpuvm.h
> > index 4a22b9d848f7b3d5710ca554f5b01556abf95985..598ba376b9430cdd4ab7bac=
dc15de031a887cf71 100644
> > --- a/include/drm/drm_gpuvm.h
> > +++ b/include/drm/drm_gpuvm.h
> > @@ -196,10 +196,20 @@ enum drm_gpuvm_flags {
> >        */
> >       DRM_GPUVM_RESV_PROTECTED =3D BIT(0),
> >
> > +     /**
> > +      * @DRM_GPUVM_IMMEDIATE_MODE: use the locking scheme that makes i=
t safe
> > +      * to modify the GPUVM during the fence signalling path
>
> I think this isn't entirely true yet or at least can be ambiguous for now=
,
> because it doesn't prevent users from having DRM_GPUVM_RESV_PROTECTED set=
, which
> requires the DMA resv lock to destroy a struct drm_gpuvm_bo, which may ha=
ppen
> from drm_gpuva_unlink().
>
> So, for now, until we have the deferred drop idea in place, it also
> requires DRM_GPUVM_RESV_PROTECTED to not be set.
>
> (Eventually, we of course want both to be represented as a single flag, s=
uch
> that it becomes an either or.)

I'm going to introduce "designed for" in the wording to address this.
I don't think we need to say that you are required to only pick one of
DRM_GPUVM_RESV_PROTECTED or this flag, since you can use both if you
manually postpone vm_bo cleanup. Let's just not elaborate on that
here.

> I also wouldn't say "makes it safe to", but rather "makes it possible to
> safely". We have no control over what the users do with the mutex. :)
>
> NIT: missing period

I didn't put a period for consistency. Nothing else has a period in
the summary sentence at the top of the doc-comment.

Alice

