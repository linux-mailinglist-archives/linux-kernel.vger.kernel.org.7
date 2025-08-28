Return-Path: <linux-kernel+bounces-789630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D196B39874
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 11:39:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5439D1C274DD
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 09:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52E4C2D877F;
	Thu, 28 Aug 2025 09:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HletbSBP"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ACBC1FE47B
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 09:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756373952; cv=none; b=npmfuH3MLQ8IP0JzxuHAd6kCjfW8IwSS9bMCrcUo/RKYAXoGsdIvA+AXUSAkP+AO/Y5OOW8wEqjL49Nv9C5Qf91h1evOQv0nYb8vfAAS61qNyGQktcJY0Qq+nLC7H9SZxI6ZBehHjJf+XoYbye7X6G6Go/twGxOaHmdWvRqCWb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756373952; c=relaxed/simple;
	bh=19V//VrXn/wkpRMgYXRhcd2yEQGifiSW/l30sA7YBTQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FaKF1mqmYBmyJrEE8GuXqYpy7AuZ45UW2bmsPHftFoEavGKq8t0nH0XAfAs7RBEGu8wIBop3rf+wMY/8EfnFqUZFTdgn85uRie4XvrABzHj8lBPzJhwtSIhXUqcWgN1aFAGNQtPq1mPyoSAJ4DqbbBJLamhoUpb6ywqyi6eQzUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HletbSBP; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-45b618e067eso12527145e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 02:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756373949; x=1756978749; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hzbPaZibccHjU0FoSS1gsWi6heTM3EUmA3XuL3SLQ94=;
        b=HletbSBPo7JzyZTuOIYahQh8UxEZn7Ve2Fjx/pOjFenb68eZdkkIBz5fwxRIj9tMqo
         Z/f6sMuD8RV0z7a+0O3DqZ7wfsFvmW9+D8ugvCtT3Paetf3EQw8rsWO8aYQdCG9duQNZ
         R1RjlGSBIHx81ux4h2spbAsts7DgCDqQgXeryUI3Erze7dgVuQw4+UsnudF5R81WwPrB
         +sBbCDMAuuPKKHAxpWQgoped+Uv+8Nv5IDwNo5/3sR75gL80f3fmPVjRKe5InzUdzI1P
         5vLzMtay8WWfjBsa3m3ZZ3WWQninqgN8bAWaEK3w+V82FaTYZHXP0hy/Ouxs/nYWo/Mi
         vGDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756373949; x=1756978749;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hzbPaZibccHjU0FoSS1gsWi6heTM3EUmA3XuL3SLQ94=;
        b=JSRHHy5Bs8LyDq7N2G/bd2M9nT5ZyMVSzVrx3AsgRx0Ed3eZJY8IcP4Wf9CmIJbGsc
         MTfU+UV66LijPor+woifOs75cWQbgf7KAG6L3SodzxMnbsXqwP21YU35u0v3RNvzTvc8
         tns/qy8wKp5UL8El3xJCzwjyk8TCU5eI3W1F3zDX+0oMaGOzzSLwi2KKHMM6TYJMOVuN
         q4N8rrbMWmYAxnCVifhZJRi9xDMdHhZKjh9MGGnP5ndJs99sTHopu6pJkiq2sLGNdxWB
         21DCLB2CdfOeNrQhq8XX5MMCs9AaTHz73wX/KZjXRYrKnEa02Hc6lYMix87QGKJL2qrF
         jBpg==
X-Forwarded-Encrypted: i=1; AJvYcCW7ZEnd4uPqE19T3h6+5UZG7sPL2zoARWkDLbufeVqpFoO2fEKnJXtZjoM2czw4eyixqUp+owP4Ys8vKRw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCVTvkdK7x1V94wUUn5SQ2yMvRRkdpBqOZcM8Kwo5AgiY63Ov5
	5s49GiUIuPf1rDKlehVJqKINDQ/vLa+RHEJm+HsBRTsc8VjOtt6hGP+bpGs2znsmpqG5mgy+SLA
	scqRkg7wQJWU4WzD/Rc3OBig/qTsMJQNBznG2MnjJ
X-Gm-Gg: ASbGnct4sXdWA1JzY+QO2Em+hHeaC2k6mkJCIaRqxmdi+5HgUMrNxXwPjTCl8oqbz+J
	Yb0pvD1C6TnGeaS5KbSEhiej4RudvrAhLTqut3TfvRr3yqn6Qw6MfpYnxGtMTcdPinrgjEJKtsO
	fO1a7KYgfcfKM3RXNoArOl2MybosttNuv2nSFL11fdMswtQU2S1NcL2f/Tln3xMte5Vl6DOou9S
	auP9Ybl+0BtuwwmskzsC2/QbCOhLw6TIJMlsFMIzxySbbI9kmJ2f+lzra3ApV2pxLJopy1XgHA=
X-Google-Smtp-Source: AGHT+IFlktDkaWiKRUo1z5/QhTcPRf5IjIBVdJ474S3mSdXUJtSFTm3Jsl9elK6Srq7Fmm/7XEbe55lLoaf2t8fE14g=
X-Received: by 2002:a5d:5f43:0:b0:3c6:e655:e878 with SMTP id
 ffacd0b85a97d-3cbb15ca65amr7606825f8f.31.1756373949317; Thu, 28 Aug 2025
 02:39:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250827-gpuva-mutex-in-gem-v3-0-bd89f5a82c0d@google.com>
 <20250827-gpuva-mutex-in-gem-v3-3-bd89f5a82c0d@google.com> <DCDYCT8QSYGM.XIKU6FJ1ESAQ@kernel.org>
In-Reply-To: <DCDYCT8QSYGM.XIKU6FJ1ESAQ@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 28 Aug 2025 11:38:57 +0200
X-Gm-Features: Ac12FXyFqot6FQ7A-cFSBHp_abEIYrxD9hUKRbVhXYWKrC9K5-tovvApSPC6tSM
Message-ID: <CAH5fLggJViOUQGB-oK764PdL37LioFWt3gNpYijq_Q8Cmi8mjw@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] gpuvm: remove gem.gpuva.lock_dep_map
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

On Thu, Aug 28, 2025 at 11:27=E2=80=AFAM Danilo Krummrich <dakr@kernel.org>=
 wrote:
>
> On Wed Aug 27, 2025 at 3:38 PM CEST, Alice Ryhl wrote:
> >  #ifdef CONFIG_LOCKDEP
> > -/**
> > - * drm_gem_gpuva_set_lock() - Set the lock protecting accesses to the =
gpuva list.
> > - * @obj: the &drm_gem_object
> > - * @lock: the lock used to protect the gpuva list. The locking primiti=
ve
> > - * must contain a dep_map field.
> > - *
> > - * Call this if you're not proctecting access to the gpuva list with t=
he
> > - * dma-resv lock, but with a custom lock.
> > - */
> > -#define drm_gem_gpuva_set_lock(obj, lock) \
> > -     if (!WARN((obj)->gpuva.lock_dep_map, \
> > -               "GEM GPUVA lock should be set only once.")) \
> > -             (obj)->gpuva.lock_dep_map =3D &(lock)->dep_map
> > -#define drm_gem_gpuva_assert_lock_held(obj) \
> > -     lockdep_assert((obj)->gpuva.lock_dep_map ? \
> > -                    lock_is_held((obj)->gpuva.lock_dep_map) : \
> > +#define drm_gem_gpuva_assert_lock_held(gpuvm, obj) \
> > +     lockdep_assert(drm_gpuvm_immediate_mode(gpuvm) ? \
> > +                    lock_is_held(&(obj)->gpuva.lock.dep_map) : \
>
> NIT: I think this can just be:
>
>         lockdep_is_held(&(obj)->gpuva.lock)
>
> If you want I can fix it up on apply.

IF that works, then sure.

Alice

