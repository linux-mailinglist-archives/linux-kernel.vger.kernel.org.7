Return-Path: <linux-kernel+bounces-812732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2AC2B53BF6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 20:57:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA7B7AA36FF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 18:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 819C02571D4;
	Thu, 11 Sep 2025 18:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VmRsfn/N"
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com [209.85.208.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364C5223DD6
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 18:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757617031; cv=none; b=Qxk2Y6chw1v791l6Xo+unALseoL7zJuAw1T5NgrT4luD2to2cLUsg/MnqW6fvhcaB7DVcsa4GsEt6U433e77zLNoF3FCg7ZXiioyQ9XrPv9bEYvztE7mfBgZXplVXn+Tgw7JoCqvikxmo804OkW7t35/9tzDmJ5i16CMnw0NuY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757617031; c=relaxed/simple;
	bh=s9bQCZmwLqgSpo6W3MThOpW7wZh6pS3/XtZlBy31OMU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=opu81IxG3rsAYYGWmivy5DFTAIE7jfxvizxr2eROBJr0OKaU5zQftcOv/K87fHkOS8eMQwTz6sAUFXygWLvFq78r5XVGr1Mwh0Jsy8yUqOAEXTGl9iBC5+KSVmXD9XdR+G5v1d1eoh2P4d1Bf1jYrLzXXeicRgjbgORYfLZCQiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VmRsfn/N; arc=none smtp.client-ip=209.85.208.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f66.google.com with SMTP id 4fb4d7f45d1cf-6188b6f7f15so1436727a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 11:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757617028; x=1758221828; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pr9tX7pp1WDhvourRe0B/uP9WABiFIXN6KF2E46kYr8=;
        b=VmRsfn/NjoecdgCm5VD6IcHmT5U25QkMdKJI0QoSZ0NuFuYI3ZXuUCrutoVA9ug291
         uUVtAPKbIRdnSAZ3qliG9dV8ldDzr0ugv6oeDtrnI6Nc4sLHqIJrxPCGrtVhsHSli0q5
         e+mnOwqKaL1CF29Jlzze37wW0PadKTM6WR1OYR6Imx0gommAyzm0tfCHLcouAmIK/viR
         znUaU468UMJE4BGZIbwQlSqTN/VqKJrVOl2TKSwWX7Wxl87IvDxrRY5yFcGTUxKjixLs
         LybuOg9D3AZy+CsToMOA87QRhAbTQnOEm+LaSBipmqnRbUT61vhK3z+QTMrGQKFtOTuN
         Ftiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757617028; x=1758221828;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pr9tX7pp1WDhvourRe0B/uP9WABiFIXN6KF2E46kYr8=;
        b=PCCz//REHPKS1YlMpaagAvpp/5YzPyzJql3Y1EZz2Sq5al49Cq9hjdYHObT0eCK4go
         PQRnKop2P/VXuHQNwvRnve6E46w86cyEYP99EXVx5iCLBlyiHD78h1FtPFMqO4j7Vvqj
         CHANUOnex4DIfvJSG7kILpt1jxT7E3KaDbNCW69uVl9Ej3pPQODoUR44v6RiXj96Lp5L
         Om8824a4sEd5qoS5pZ4nl3ET6dOziHNTDhFQ384IbsUdajRcYSMDL4ENmOcHIbPt493X
         NJIKzcLcOlYN19/+uISrZCm84SPJkBiAHkKD0ypjNxqeJ4DbtjUM94+56G/Ly2+P2vd0
         xJvw==
X-Forwarded-Encrypted: i=1; AJvYcCVwnIo6CckTgttIG7VlHP9s5lP+zMe4CHbK6eqaP4dbYmgfnjuGAqP8NYQawWrVHcWKQYbu6ozHyxQDCe8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzubGDsNgCung3KJEIOphvnJTAE5p8iLZr58HIw41+SkYjaWSJV
	+lj6RDxNJPxQ56cWN11xRa8gIJ6tVEWtQCeqDKE3Ja05ntx7gSYuags7DbwUAaRHmoc8+imsw3G
	B/SDP9GCQc++0Sv4n08Y7SMJC6UFNdwU=
X-Gm-Gg: ASbGncs5An7RVSHERIOH950iLipEKvZIwNXma6Gemj3DbND85JY52myU+lfynUfx5LU
	85m6238x2GR0omiZTpJpyN99SYgG0+i1+ayvqTI4uBA2r+to9twKp+Lm4n1GLq9+Gt4V6sjBb+e
	y2UwoZE5pQuYaofmZDCN9hwNrJCgLJHKSyVlt1J7djtwTQ3IUevKlpN938OoWSUg0WpLpaTLNMI
	9OlMErukOrJH4qLtD/KcjyfF+PykQlKVzffMk0NKMM6jo2f0w4=
X-Google-Smtp-Source: AGHT+IGKxDih6ERXHwgyq0yZdSI3KYy7AT+aqJ67B4OiUGV2Ac/JxHPP/UIhhWHfeURuCo8qEbRbLD4HPdE5MiweW1U=
X-Received: by 2002:a05:6402:40d5:b0:61d:2405:b47c with SMTP id
 4fb4d7f45d1cf-62ed864bcc9mr495434a12.37.1757617028259; Thu, 11 Sep 2025
 11:57:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250911034655.3916002-1-ankur.a.arora@oracle.com>
 <20250911034655.3916002-6-ankur.a.arora@oracle.com> <aMLdZyjYqFY1xxFD@arm.com>
In-Reply-To: <aMLdZyjYqFY1xxFD@arm.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Thu, 11 Sep 2025 20:56:31 +0200
X-Gm-Features: AS18NWD_vDg9CGLpqBo3-WZ0dCqpbP__-WdZRDuhupRZ7xI3H77I9oF8KLziKGM
Message-ID: <CAP01T778qzHqNYanGtQ_UB9av9BtxLYdf2xWnJWtsf=-w=gANA@mail.gmail.com>
Subject: Re: [PATCH v5 5/5] rqspinlock: Use smp_cond_load_acquire_timeout()
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	bpf@vger.kernel.org, arnd@arndb.de, will@kernel.org, peterz@infradead.org, 
	akpm@linux-foundation.org, mark.rutland@arm.com, harisokn@amazon.com, 
	cl@gentwo.org, ast@kernel.org, zhenglifeng1@huawei.com, 
	xueshuai@linux.alibaba.com, joao.m.martins@oracle.com, 
	boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 11 Sept 2025 at 16:32, Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> On Wed, Sep 10, 2025 at 08:46:55PM -0700, Ankur Arora wrote:
> > Switch out the conditional load inerfaces used by rqspinlock
> > to smp_cond_read_acquire_timeout().
> > This interface handles the timeout check explicitly and does any
> > necessary amortization, so use check_timeout() directly.
>
> It's worth mentioning that the default smp_cond_load_acquire_timeout()
> implementation (without hardware support) only spins 200 times instead
> of 16K times in the rqspinlock code. That's probably fine but it would
> be good to have confirmation from Kumar or Alexei.
>
> > diff --git a/kernel/bpf/rqspinlock.c b/kernel/bpf/rqspinlock.c
> > index 5ab354d55d82..4d2c12d131ae 100644
> > --- a/kernel/bpf/rqspinlock.c
> > +++ b/kernel/bpf/rqspinlock.c
> [...]
> > @@ -313,11 +307,8 @@ EXPORT_SYMBOL_GPL(resilient_tas_spin_lock);
> >   */
> >  static DEFINE_PER_CPU_ALIGNED(struct qnode, rqnodes[_Q_MAX_NODES]);
> >
> > -#ifndef res_smp_cond_load_acquire
> > -#define res_smp_cond_load_acquire(v, c) smp_cond_load_acquire(v, c)
> > -#endif
> > -
> > -#define res_atomic_cond_read_acquire(v, c) res_smp_cond_load_acquire(&(v)->counter, (c))
> > +#define res_atomic_cond_read_acquire_timeout(v, c, t)                \
> > +     smp_cond_load_acquire_timeout(&(v)->counter, (c), (t))
>
> BTW, we have atomic_cond_read_acquire() which accesses the 'counter' of
> an atomic_t. You might as well add an atomic_cond_read_acquire_timeout()
> in atomic.h than open-code the atomic_t internals here.
>

+1, and then drop res_atomic_cond_read_acquire_timeout from this file.

> Otherwise the patch looks fine to me, much simpler than the previous
> attempt.
>
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

