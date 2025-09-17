Return-Path: <linux-kernel+bounces-821808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1059B8254F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 02:00:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2716C4A458C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 00:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB6822EB5DE;
	Wed, 17 Sep 2025 23:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2JyInma7"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D34634BA47
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 23:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758153598; cv=none; b=Dny8quhY+0/x2CkpFvX3bTkrZpCVXtveuTEa2uoTE9HR9IkxUaLwVRziFmfGgxJ/yTKAV375nXAlH8OaW0M/wqmj/hvEaNtFnw8c9MTrRngnfQJYSJ57DcnfM+G5fLUyz9Q6a01YabKAWKvLXXhPsocDDg/2NgQXgV8tOcjxhsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758153598; c=relaxed/simple;
	bh=UbRTRpfsOGgfpZIioAFpAKOsaB1KVt6XbNZbqziAcT8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T8eMW0M9S8NiF2KdyDv5seNDHLB3msYCtWA2aLmhGJ+I4E4r9zWN9B9K+QVydKIEV7DlIJXsPMDaPBsctILz0unaGB3uzQQoPlr87kuFGHrrsofm5Ja3Qn6OECkMFc94GWW76oJk5kH3lffQ3YJC02FpDNHo0BUx1KI4DpVwsW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2JyInma7; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-62faa04afd9so83a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 16:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758153595; x=1758758395; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+k4UBANduixrTliP8GJRSvLIs5e04GQ1F54MlhsKt70=;
        b=2JyInma7xf/gZzccMy4Qo3o+iMG9nhvU3BW/6g1q5+awfgdHy74BqmjRlLAMc+JtWz
         978hIlzhwgAJyDvE2Ej7gC7rg9TaPx3JzhLVG9+dO+QedtVNzojkjexoee5oeouTXM2e
         4qGG7LB9a37RWo3Mji7/nyndiJNWV53UyuhuwXZTAVJ7Kl03d6Uma2hqQHPOq7BTGh/g
         8BRKEPvEqnQeR6sIDfAwjr9Wd0EYz2r0lBOuTDEk54MFz5NGRa6VM3OB5jESGHFab5XE
         1UwfAO0romsZaA/sPC0kZrTM/d7duGpmNxfBZIkzC1rPefRmNB0ot4R0PAkDHKhIEep7
         Bkkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758153595; x=1758758395;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+k4UBANduixrTliP8GJRSvLIs5e04GQ1F54MlhsKt70=;
        b=MFKxWmzN8XN82x3y2/jSLOnX+nbuVl6ucogP2Zu0pzzuvN8p71dAJQD04wZl6UAwqi
         EKSMXx+sMDyTEu3vXz+XkgOnoehdrrv1SkeHKYadsfK2hw1lI0KEV/GI1W9C5v9QOICs
         CVUUE5SMkxMtYZXyGBF7ruGMqZlJMQHMquPrfvB/Hc+16WEYxqXTt35IfoQwa+TMQaHw
         dj1qUg0EG4uy0yRXt2q+a+7/p30LXhQXzCDnQqI2oxYX5+VcMe8qDz1J2JClASLV2OFx
         ITTWoGyaRlkYUU5Im4JKGfx0HAa5CZpwLfJ9ZrNroc9F54CXxbifNbx3A+zFjolejTnt
         5fFQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2vdsP88vkJm8DDiMRFo8XwH27g62yaYgqCb8jUOVA5x2pp7VKshzlBuXj+ufdre0nEKRsn7E66FbNg2c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx58UsVa1kNGUdnnM3ZgjGHTLB07iLT3LM0Wzzhp/dnTCzp5lBc
	squUedysYiU+mygt8ea3777NUZ9WFCvctlFAHTPZaHc0ZrLd7k5sWu0xWVyRIKv+0UnxGbsrDzs
	PQwo5phB4L2vLhc+fqHbq6t2momLR8B7jQyudGp0J
X-Gm-Gg: ASbGncsL0hqmieNPJPmliQ8wzsgGHmbpAVLRWWo4jszBcU+5wazyMoji1C+TQ6R9XPr
	pb1xWi2+UHbhSp203j9HFknrCPuOMdJsaFBYnBD1hJhZHdGbFqiMevGQMVzx6fTxfMmIvH5zGFf
	5N4CnGFdK1ZPI6qVKk7jENSIOtbWxhVTPh9YwlrDA7CQqy4vSkiAsCVW/YP71qawkpt2ngeE24g
	a6d9Mv4U5GSMXSftcmDSB30t+VjQ/s=
X-Google-Smtp-Source: AGHT+IGwvBQ/ma4OjhAb3mJBBGrTHlUUNFKF6gBGTFjvv6da4khKOL5MOMEB4k37fIEHnqabA3kXBI6Biko6ndlOJCc=
X-Received: by 2002:a50:c05c:0:b0:61c:c08d:359d with SMTP id
 4fb4d7f45d1cf-62f7e134801mr85622a12.4.1758153594515; Wed, 17 Sep 2025
 16:59:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250723-slub-percpu-caches-v5-0-b792cd830f5d@suse.cz>
 <20250913000935.1021068-1-sudarsanm@google.com> <qs3967pq-4nq7-67pq-2025-r7259o0s52p4@vanv.qr>
 <f5792407-d2b9-42b3-bc85-ed14eac945ec@paulmck-laptop> <d1ef1cbb-c18d-4da6-b56b-342e86dca525@suse.cz>
 <CAJuCfpEQ=RUgcAvRzE5jRrhhFpkm8E2PpBK9e9GhK26ZaJQt=Q@mail.gmail.com>
 <aMpE-oSjtlDU4TSl@pc636> <CAJuCfpHQ_JedSRHKKoYXyVzaFOm=dDWzgFZwqerfEC1fn35j0w@mail.gmail.com>
In-Reply-To: <CAJuCfpHQ_JedSRHKKoYXyVzaFOm=dDWzgFZwqerfEC1fn35j0w@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 17 Sep 2025 16:59:41 -0700
X-Gm-Features: AS18NWBx5aUJDxzgSbTWFT8kC_EPDfnr02N4rctMkVtLm9XJWaAMV1S3L1bSwvY
Message-ID: <CAJuCfpE48n=QM0nY8yE3drqZU0wgC76=70EyftL1WZewEcykyA@mail.gmail.com>
Subject: Re: Benchmarking [PATCH v5 00/14] SLUB percpu sheaves
To: Uladzislau Rezki <urezki@gmail.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, paulmck@kernel.org, Jan Engelhardt <ej@inai.de>, 
	Sudarsan Mahendran <sudarsanm@google.com>, Liam.Howlett@oracle.com, cl@gentwo.org, 
	harry.yoo@oracle.com, howlett@gmail.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, maple-tree@lists.infradead.org, rcu@vger.kernel.org, 
	rientjes@google.com, roman.gushchin@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 9:14=E2=80=AFAM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Tue, Sep 16, 2025 at 10:19=E2=80=AFPM Uladzislau Rezki <urezki@gmail.c=
om> wrote:
> >
> > On Tue, Sep 16, 2025 at 10:09:18AM -0700, Suren Baghdasaryan wrote:
> > > On Mon, Sep 15, 2025 at 8:22=E2=80=AFAM Vlastimil Babka <vbabka@suse.=
cz> wrote:
> > > >
> > > > On 9/15/25 14:13, Paul E. McKenney wrote:
> > > > > On Mon, Sep 15, 2025 at 09:51:25AM +0200, Jan Engelhardt wrote:
> > > > >>
> > > > >> On Saturday 2025-09-13 02:09, Sudarsan Mahendran wrote:
> > > > >> >
> > > > >> >Summary of the results:
> > > >
> > > > In any case, thanks a lot for the results!
> > > >
> > > > >> >- Significant change (meaning >10% difference
> > > > >> >  between base and experiment) on will-it-scale
> > > > >> >  tests in AMD.
> > > > >> >
> > > > >> >Summary of AMD will-it-scale test changes:
> > > > >> >
> > > > >> >Number of runs : 15
> > > > >> >Direction      : + is good
> > > > >>
> > > > >> If STDDEV grows more than mean, there is more jitter,
> > > > >> which is not "good".
> > > > >
> > > > > This is true.  On the other hand, the mean grew way more in absol=
ute
> > > > > terms than did STDDEV.  So might this be a reasonable tradeoff?
> > > >
> > > > Also I'd point out that MIN of TEST is better than MAX of BASE, whi=
ch means
> > > > there's always an improvement for this config. So jitter here means=
 it's
> > > > changing between better and more better :) and not between worse an=
d (more)
> > > > better.
> > > >
> > > > The annoying part of course is that for other configs it's consiste=
ntly the
> > > > opposite.
> > >
> > > Hi Vlastimil,
> > > I ran my mmap stress test that runs 20000 cycles of mmapping 50 VMAs,
> > > faulting them in then unmapping and timing only mmap and munmap calls=
.
> > > This is not a realistic scenario but works well for A/B comparison.
> > >
> > > The numbers are below with sheaves showing a clear improvement:
> > >
> > > Baseline
> > >             avg             stdev
> > > mmap        2.621073        0.2525161631
> > > munmap      2.292965        0.008831973052
> > > total       4.914038        0.2572620923
> > >
> > > Sheaves
> > >             avg            stdev           avg_diff        stdev_diff
> > > mmap        1.561220667    0.07748897037   -40.44%        -69.31%
> > > munmap      2.042071       0.03603083448   -10.94%        307.96%
> > > total       3.603291667    0.113209047     -26.67%        -55.99%
> > >
> > Could you run your test with dropping below patch?
>
> Sure, will try later today and report.

Sheaves with [04/23] patch reverted:

            avg             avg_diff
mmap     2.143948        -18.20%
munmap     2.343707        2.21%
total     4.487655        -8.68%


>
> >
> > [PATCH v8 04/23] slab: add sheaf support for batching kfree_rcu() opera=
tions
> >
> > mmap()/munmap(), i assume it is a duration time in average, is the time
> > in microseconds?
>
> Yeah, it ends up being in microseconds. The actual reported time is
> the total time in seconds that all mmap/munmap in the test consumed.
> With 20000 cycles of 50 mmap/munmap calls we end up with 1000000
> syscalls, so the number can be considered as duration in microseconds
> for a single call.
>
> >
> > Thank you.
> >
> > --
> > Uladzislau Rezki

