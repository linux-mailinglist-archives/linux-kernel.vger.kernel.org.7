Return-Path: <linux-kernel+bounces-743069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE34FB0FA25
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 20:20:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99D837B93F4
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 18:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2331229B21;
	Wed, 23 Jul 2025 18:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g6GGf+0U"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05D9224B07
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 18:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753294790; cv=none; b=WaCloTSsz4xcIpG/IEChE0j/D+ZP5kBltj9c56PQHateWEDJ2GNKtan9t1ECnCN6U3bxxf3lrq8rMZLpGhPSsyDyKRNwANyYF5aI13hWLUSesBJP3JvqTP9cb5BxOtPCZT7x0Mu5qwwhrUKR6QbqChroa+kZp2LfIFBQLVTKqw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753294790; c=relaxed/simple;
	bh=YBnGIFarSyqtsE53H1oY3FRe8TSEyH/jLViQEN9pcvs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VWPStZCeEzycaiUhsaNkFUg//KILRZxzqjCHM6/gsA9IT+YRyxeA0RC2Jtho8WvRCJH5LZeFfGQGm0rps45wdIZhpJ6cqryw+mYFrQouvcQRLB+0Dbbz/CuIHY+Y25psmDQmpbNidUWs7MsWJTK6BrO9CRxf2pWHrpCc0RQkIdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g6GGf+0U; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5f438523d6fso1521a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 11:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753294787; x=1753899587; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KpAEpgDWHeGIH7ss8Nvzd4+y/2+jfURtt3DlfE0yh8U=;
        b=g6GGf+0U1vLmLM07NJsZV2deTlWX9tVj+PaAT0kkxSiy+rORmkq9Zqux2MEWhXCFe6
         TZqs7cqYa+lR4exTuUMGfQMvGOsjlxE/VR6G69N2wdVaJqZgXf6H6Inq7o5gpgllP904
         jLnaii1JWGDnjMK51LP9oDcdA97Z/noL63gdkSUw9BF/gPBd7rhFbEC2iyCXiyaMZutS
         m4AaXgN480hsmUpJlPS8vaEitPLSkZUx4hrGvct9o60NonPxfkpPL/Uwi66R/30BmSea
         wljRKTNT40ikIWF6xyuRcQva1wj+Tz885MvZ/7attLZJ0kQsTc//mMRkVS4dHIDaAL5A
         7FUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753294787; x=1753899587;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KpAEpgDWHeGIH7ss8Nvzd4+y/2+jfURtt3DlfE0yh8U=;
        b=xDc1Tujoi4o9Wu++lgT/s6sqoptodqYeOIB6XiwKYNUyWcXbSu15HaH2tkxXLGi10Y
         Zhxk+wIpg2Y1z6V9Ywn44rzJNp33hVkJreOhaVo6oPLQoAoeiJq5WfqrfelgrsuJtr8g
         c8P7M6bb/Y2BCy/BXQyx0vDtdTbhGBvqgifwmYLytc1ZXXfdh3K4yddZ6vzIOfCz9fUe
         lpMOZtIHYqrZA0yneYDdfrxFN0n7SIqgRHg2mxolmxjFs6sT89OWRW3Lpa6JT79ApXXf
         FlLTJhiQFO5yBC56qNhOeOVMXXC0gJ9R+3ifoXSwe3HY8GZ8J7NmKHtwrOUytoqFOh3b
         aT9A==
X-Forwarded-Encrypted: i=1; AJvYcCVyzdWbrtUIwMSs2PlbpQbKwTtpfx5MRZ1bH7G55dwoQvVFPlPUN4BKkfjQDNwujIWA11y+RtTk1xyK9vs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxhsZUJERIdqCtz7jcT3/g5t5e1u+LMx8nYWKojVcEYOUptrPK
	JwcC6CrWbz6NlgLBaOnRIz03dmOsgUI8hzNeRSaXnpmKPOe25X8xnRVDUnDbiYZGf5v+tPGU9Mh
	N/FBRjXOjA2LDXFMl6bdbgQrFymdJYNUHvP3m4OKQ
X-Gm-Gg: ASbGncvjWgd5WjkwifxZkS2xw9G/I0/jLfKaxuD8WtmmHRXW83uBDXHzLuhRxXiGZt/
	vD0InHX1pYBwH+floQf+DXH2Cwfd7CxoxlOcyTFjbJAMWjUMQSEArvwLjxrZcf2D+mJqTkOHW9M
	VSeDPY7PkexkRcGZhrovt1dTFIVy5HOuY5X9oZXZln9p8D/6vuA4JtySccclvGbEP01lv2O+K8q
	wg/wXUp8i2l1gC89CrriJRVyUf4aqseNQk=
X-Google-Smtp-Source: AGHT+IHwTkwUxwmYJznW+JoSJ51XwKQLHjaGqTtI67K+dfaGKw+YkDZZvw+WbR1Q0In1LKGZVLGLErdnUgjne9ZVvMs=
X-Received: by 2002:a05:6402:3135:b0:612:ce4f:3c5 with SMTP id
 4fb4d7f45d1cf-614c4521044mr8154a12.0.1753294786700; Wed, 23 Jul 2025 11:19:46
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAG48ez0-deFbVH=E3jbkWx=X3uVbd8nWeo6kbJPQ0KoUD+m2tA@mail.gmail.com>
 <16c97e30-19c9-41e8-b73b-c0b3c8eceff3@suse.cz> <CAG48ez1qhjQNHC+3572udqVWHTANFpQ0ngxn_4ZDC9F8NCXsFA@mail.gmail.com>
 <c53b22c3-9f7f-4793-9d10-f4df861a3e32@suse.cz>
In-Reply-To: <c53b22c3-9f7f-4793-9d10-f4df861a3e32@suse.cz>
From: Jann Horn <jannh@google.com>
Date: Wed, 23 Jul 2025 20:19:09 +0200
X-Gm-Features: Ac12FXz9_i6SxLpXiajqVAiG94JEsCjfzLCX1gvk2m4O6lVv_x28mnHa_UAhCLM
Message-ID: <CAG48ez2cGX3e5bqgcw0OEnho29+YhwG2eOrHRgNwGAA_Nb65nw@mail.gmail.com>
Subject: Re: [BUG] hard-to-hit mm_struct UAF due to insufficiently careful
 vma_refcount_put() wrt SLAB_TYPESAFE_BY_RCU
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Suren Baghdasaryan <surenb@google.com>, 
	Pedro Falcato <pfalcato@suse.de>, Linux-MM <linux-mm@kvack.org>, 
	kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 23, 2025 at 8:10=E2=80=AFPM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
> On 7/23/25 19:49, Jann Horn wrote:
> > On Wed, Jul 23, 2025 at 7:32=E2=80=AFPM Vlastimil Babka <vbabka@suse.cz=
> wrote:
> >> On 7/23/25 18:26, Jann Horn wrote:
> >> > There's a racy UAF in `vma_refcount_put()` when called on the
> >> > `lock_vma_under_rcu()` path because `SLAB_TYPESAFE_BY_RCU` is used
> >> > without sufficient protection against concurrent object reuse:
> >>
> >> Oof.
> >>
> >> > I'm not sure what the right fix is; I guess one approach would be to
> >> > have a special version of vma_refcount_put() for cases where the VMA
> >> > has been recycled by another MM that grabs an extra reference to the
> >> > MM? But then dropping a reference to the MM afterwards might be a bi=
t
> >> > annoying and might require something like mmdrop_async()...
> >>
> >> Would we need mmdrop_async()? Isn't this the case for mmget_not_zero()=
 and
> >> mmput_async()?
> >
> > Now I'm not sure anymore if either of those approaches would work,
> > because they rely on the task that's removing the VMA to wait until we
> > do __refcount_dec_and_test() before deleting the MM... but I don't
> > think we have any such guarantee...
>
> I think it would be waiting in exit_mmap->vma_mark_detached(), but then
> AFAIU you're right and we'd really need to work with mmgrab/mmdrop becaus=
e
> at that point the  mmget_not_zero() would already be failing...

Ah, I see! vma_mark_detached() drops its reference, then does
__vma_enter_locked() to bump the refcount by VMA_LOCK_OFFSET again
(after which the reader path can't acquire it anymore), then waits
until the refcount drops to VMA_LOCK_OFFSET, and then decrements it
down to 0 from there. Makes sense.

