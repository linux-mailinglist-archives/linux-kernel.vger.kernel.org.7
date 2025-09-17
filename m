Return-Path: <linux-kernel+bounces-821306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9316DB80F0F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 18:21:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 618F71C8247E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 16:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FBF12FDC52;
	Wed, 17 Sep 2025 16:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="akDvQyxN"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11E32FDC4E
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 16:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758125691; cv=none; b=QlrC6oO79gP36m7gnk7Tv77bZyv3gx9RPAXvU4se9n6OufKd08YuqKmlX5KRhgF1EAZy8AY6NhZcBkC4c+qvK3GFi2HnBG/R6CiTuPCWDukBaGuJx3qDgKZuCcJjpGKYlG+4LAnx4gXZz8+t0O3LMhm6ro4pL2u1pkropFJepi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758125691; c=relaxed/simple;
	bh=RMvc+oHzDZ/mGe8MqNZjXMhfawRf05GjGyKnSnZBYu4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lOW2xu9IWlZZAdu2YIJrrK/VogyiD9iOJESK4uJyDLtkOCtiny3ouxAXyM0nd0iLulqzEFHkGXNA1ooBwZ10r/cNAqZyDX/n6/EtnWo3dlD3/322comYEciAIrTmeigvA+uDZlHwLJs5e4Gug9N0/MdSx0OUBjR6b+fzkzHpyKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=akDvQyxN; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4b796ff6d45so450831cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 09:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758125689; x=1758730489; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OArBKu/OVLMzSppvTMJHRKcjYiNm1Tha8BBwDyvcaCw=;
        b=akDvQyxNgv3ODheynsE1J+0BmEgVFJrb+ni+XC0d5RrtEa5nf280nj4XOjhCOsefcv
         MXBoewDx1MgHFtYAuOazzsiIE8Kzp/+KcQgksAHUqfKsZ+iL1HT1iHpfCGtvZ7rAybCW
         Js8OQvk6n5d6yVft7/lxOtqoEe2ykNRvln1QFLrvtdyRU8e0luo45Rkoea05TPPhd2Ld
         B+uYfqjvSV+Sngagynh2tqQV3Om3jpBSsPHKhNk8bpNxYdKuPnX1H/oFbahHb8zrSUEl
         ICVk4UClVHFR05h+3iCMfBpaIpTbzUSFOPVb+Yn/uv1Px/JOTlCz1ibOg2pb/xY0Nrjz
         tvnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758125689; x=1758730489;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OArBKu/OVLMzSppvTMJHRKcjYiNm1Tha8BBwDyvcaCw=;
        b=hM4GWKnk6R1YNmhQtBGtg6pcGrxYY3M8f5cceYPDtBcCkvhxLy3/peDs8KFPUnIET6
         tLsm+sf2iPjnasPvIJtW2/FczOQs0XGpcOf3aB2uD2OG8RqY5E7GwuCdLdBdVvEaAgYy
         oDZqVViZfR3uORo9utPJjr6aO8ppby5z+rQLT5rsVpfjE/s2MGgxlThXM00A6AeZJoNm
         c+o+zKsBQKkYN1iH9SmzP6wsBe87clQ9iewzuH67YF0oiYJbEK46+ify8zdAwc4cLnOS
         sMw0qWTuCqB92cI2XRmPRLnEH1bjtNw1e8YnWEeuUGpGd+IFUEYNljRStSlitzW70gwR
         evbA==
X-Forwarded-Encrypted: i=1; AJvYcCUSh00zwqxWOVx6XtvildIDjDwa/xv1TVSpxCpaQwIJZsB61u9MV58PIqfPwd0r74LOONVykPKIvTJwIQA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy12t5iuyB7u1b8BK00iARgPRdMQqXocPNhayixIUmZCpeg9cYQ
	NI/3eMdbh8OwZOFN4XrDEeBSrK5mkMTPtJHC8erpmGPtQgpbnOkq4fKokvReG9c9zzQDSn2cmej
	hQ2J6aLRAuWloECQ5SHk5PlQEIbLHGkLYCmJkOVHl
X-Gm-Gg: ASbGncvi8c6LBPbka/SuJZmZJ9rRPRMx0MRWU6vRHfo+La1tdBth9GzpDJl+aurFx+Q
	dHv0XJOtlzgu4MoM6/1nhKIzS0OBeRPWS3LYCG1+h2iztL9ihuKXDobZ8SlaiC1yg6fiYngrD3z
	r5SdhvTuY+1hoBWIXdwAyIqXwB5ufVHxGypwGZRFqcLctqxau9JpK7PaG2sfK+aPH8ahNDuAQnl
	y8AuPGVs/JmJ+5pzqxi86JTqInL3SXcd/yEjuvlV0fN0uJjC2i9vQ==
X-Google-Smtp-Source: AGHT+IG9w0PDQP5VzsbXW+qZNvO2uClVZrTUiqPIC6ePHQIbByt0FQbuPg77WNGmS8ZH42TU2TS5A3kWp2z/r71KEQ4=
X-Received: by 2002:a05:622a:1818:b0:479:1958:d81a with SMTP id
 d75a77b69052e-4b9dd4b6fa5mr7747081cf.6.1758125688026; Wed, 17 Sep 2025
 09:14:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250723-slub-percpu-caches-v5-0-b792cd830f5d@suse.cz>
 <20250913000935.1021068-1-sudarsanm@google.com> <qs3967pq-4nq7-67pq-2025-r7259o0s52p4@vanv.qr>
 <f5792407-d2b9-42b3-bc85-ed14eac945ec@paulmck-laptop> <d1ef1cbb-c18d-4da6-b56b-342e86dca525@suse.cz>
 <CAJuCfpEQ=RUgcAvRzE5jRrhhFpkm8E2PpBK9e9GhK26ZaJQt=Q@mail.gmail.com> <aMpE-oSjtlDU4TSl@pc636>
In-Reply-To: <aMpE-oSjtlDU4TSl@pc636>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 17 Sep 2025 09:14:37 -0700
X-Gm-Features: AS18NWAl3tnnsDRXh1YlHaUElOip_SV2qsqTsXfBx-HZev1MuKyA-GY3Dn540H0
Message-ID: <CAJuCfpHQ_JedSRHKKoYXyVzaFOm=dDWzgFZwqerfEC1fn35j0w@mail.gmail.com>
Subject: Re: Benchmarking [PATCH v5 00/14] SLUB percpu sheaves
To: Uladzislau Rezki <urezki@gmail.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, paulmck@kernel.org, Jan Engelhardt <ej@inai.de>, 
	Sudarsan Mahendran <sudarsanm@google.com>, Liam.Howlett@oracle.com, cl@gentwo.org, 
	harry.yoo@oracle.com, howlett@gmail.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, maple-tree@lists.infradead.org, rcu@vger.kernel.org, 
	rientjes@google.com, roman.gushchin@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 10:19=E2=80=AFPM Uladzislau Rezki <urezki@gmail.com=
> wrote:
>
> On Tue, Sep 16, 2025 at 10:09:18AM -0700, Suren Baghdasaryan wrote:
> > On Mon, Sep 15, 2025 at 8:22=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz=
> wrote:
> > >
> > > On 9/15/25 14:13, Paul E. McKenney wrote:
> > > > On Mon, Sep 15, 2025 at 09:51:25AM +0200, Jan Engelhardt wrote:
> > > >>
> > > >> On Saturday 2025-09-13 02:09, Sudarsan Mahendran wrote:
> > > >> >
> > > >> >Summary of the results:
> > >
> > > In any case, thanks a lot for the results!
> > >
> > > >> >- Significant change (meaning >10% difference
> > > >> >  between base and experiment) on will-it-scale
> > > >> >  tests in AMD.
> > > >> >
> > > >> >Summary of AMD will-it-scale test changes:
> > > >> >
> > > >> >Number of runs : 15
> > > >> >Direction      : + is good
> > > >>
> > > >> If STDDEV grows more than mean, there is more jitter,
> > > >> which is not "good".
> > > >
> > > > This is true.  On the other hand, the mean grew way more in absolut=
e
> > > > terms than did STDDEV.  So might this be a reasonable tradeoff?
> > >
> > > Also I'd point out that MIN of TEST is better than MAX of BASE, which=
 means
> > > there's always an improvement for this config. So jitter here means i=
t's
> > > changing between better and more better :) and not between worse and =
(more)
> > > better.
> > >
> > > The annoying part of course is that for other configs it's consistent=
ly the
> > > opposite.
> >
> > Hi Vlastimil,
> > I ran my mmap stress test that runs 20000 cycles of mmapping 50 VMAs,
> > faulting them in then unmapping and timing only mmap and munmap calls.
> > This is not a realistic scenario but works well for A/B comparison.
> >
> > The numbers are below with sheaves showing a clear improvement:
> >
> > Baseline
> >             avg             stdev
> > mmap        2.621073        0.2525161631
> > munmap      2.292965        0.008831973052
> > total       4.914038        0.2572620923
> >
> > Sheaves
> >             avg            stdev           avg_diff        stdev_diff
> > mmap        1.561220667    0.07748897037   -40.44%        -69.31%
> > munmap      2.042071       0.03603083448   -10.94%        307.96%
> > total       3.603291667    0.113209047     -26.67%        -55.99%
> >
> Could you run your test with dropping below patch?

Sure, will try later today and report.

>
> [PATCH v8 04/23] slab: add sheaf support for batching kfree_rcu() operati=
ons
>
> mmap()/munmap(), i assume it is a duration time in average, is the time
> in microseconds?

Yeah, it ends up being in microseconds. The actual reported time is
the total time in seconds that all mmap/munmap in the test consumed.
With 20000 cycles of 50 mmap/munmap calls we end up with 1000000
syscalls, so the number can be considered as duration in microseconds
for a single call.

>
> Thank you.
>
> --
> Uladzislau Rezki

