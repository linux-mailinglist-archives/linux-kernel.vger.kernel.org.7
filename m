Return-Path: <linux-kernel+bounces-819336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3067B59EEF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 19:09:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E1913A34CF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 17:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D0202F7457;
	Tue, 16 Sep 2025 17:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tQGh0I8s"
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FEBA32D5BC
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 17:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758042573; cv=none; b=IAZSF+99ch/nPVQ4gVWtYmYf2SvYgms/rEGOAEumJ9SBjdjF+IRJGhSPagVi9PRX5pGmWByhTQmzGjnRMJaeJAPfcsiM1nGEHvzl4pLoZK08746A0oUFSMfU359+o7q4/iRmcWtTEt3tZDXZ+C3Uq4AoT0lXnQnzgCYO5vxm/j4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758042573; c=relaxed/simple;
	bh=W7Xl1USRfP3WXgLE3mHI0Iy7kOHxnnkysA+hsWz5+9w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nSnYtTCUQrGNkiOIWLPsQaWrx+pTxWD7rEMRcYYaFEfqct2wfTys5x9tnZJPbAipzTM40VypwYr26FTAotBb2UQV3Z8tzbCZYFhJe0in+sNNcd7G3rER8FQVbtybLuQ4jN6LFKHdepafCn1fej/m6mtlVcFQhu4leInKs8B55pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tQGh0I8s; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4b796ff6d45so18331cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 10:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758042571; x=1758647371; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5nObP271o7zKWD/o6CXr8B27todJQZZ/TCUsecAu7bQ=;
        b=tQGh0I8swfAsFdejLDIoUcHT5WnpwI7IHilvxlg+usrriZ3uMV0YzgUgWOMogZXugC
         di9odlk+Ak2fgtbk3It1XyWF4zGcsexBAjERuuN2+ZDCL3SeQbOX8QXrfde9BgQQdzso
         RK09VWuNnB0vJD3tGGfTsUykLz5mnLBhnsdxoV9e/HMIhV1TbfJfUlayg3SGXnT/xNfu
         spq97jNT1K4VP6RJHuQFsD9A4Iz+c2W4ABWD7pvmp/75kQQ1pQhpXCDiqAW0X9h0THAY
         ev61ozYLqVpS2obZ+yv0C4scpUqF5iHYkX6YPiEGqtlzrOQu4doHbodAoeI/CpG1GlvI
         uVjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758042571; x=1758647371;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5nObP271o7zKWD/o6CXr8B27todJQZZ/TCUsecAu7bQ=;
        b=lEfjH03XQczZJm3UCwU4sF/SIxQPb4OEgnv91LxZQgGp8TL7QKL2j+WWVNXUlHfxi6
         /rLK/fAU5gHdAk2Yd/BSHPB21XFNw31M+qW3HB091Oav+6PZipD/iveOYMGGbUuYgVt4
         6nSzfUdfwWCEOYynAhsvYMUb1JN0B5UzQXhNAa1MfzMrru4NbNLZIeDVvJ7lfGMGW3S2
         mgWaHUOFl8zxV3MlggGO0EMzFdF65+l/JQqJDu+7+KBJIMM2joEn7CD0FBTH/G+e/X2o
         br/3i2vVIIfsl/VIj3BqUOcPCIOCiEyTaMa/n/wSyntPXpCBY6DUjKRxPxVHIUMYX2Lb
         JYrA==
X-Forwarded-Encrypted: i=1; AJvYcCXLqG1ZNkfzkb9o/yx49d0X8q+k7iliXy2Iy7kfeOLFdx0qPwOf5sfoS/QxBc0Nmw3dnrJwd98HXsrk3+w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKTJoidKIMpLCq4Rr78F3L2Cz7+PFPvxZOnKB/jw0tabof4OJP
	W6UvahZQiegXgV9IfiSbQh+Y8jj2UYZYnVRPJnYS2xUAUtZdOtyR0PpfkOMVBM2+2eec2a3nVj8
	LzArefBR+jtu1y4F3tIRvwvwTKbOl5skLBaqGJyX3
X-Gm-Gg: ASbGncvJcVSH8QqY9W3HMqFP0fcMVZuVxF5zK46FySpGTuL6wP+Q6Gss7wWoKFHRAak
	TRLiwJHxJx08alESKAy6pESfJWOEGsBWaslCwFuyaWDZ9pTIpAiF3IKy5JYH3BCJ7N4YL0mSwOR
	KgB8MFS6BAlDbJgknchQlEbwDxJmHzd7ZSys4q+nkuGwlsdKkfswAfXFbXIM+5gGeDivbqRJT2z
	sQx+a58vSmuMKtpiDyElxNlzJEibQ/fruxUo8vB1m+9
X-Google-Smtp-Source: AGHT+IHlnZD0xzveloqY1NwivFqIQ3M/IVLjLUBP4FRJ+7Uqzu5AIbMylt6KL7+KR956Bl7yUYehkcOeC/F8nnahyEY=
X-Received: by 2002:ac8:7c56:0:b0:4b3:1617:e617 with SMTP id
 d75a77b69052e-4b7b2d81b34mr6548031cf.11.1758042570374; Tue, 16 Sep 2025
 10:09:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250723-slub-percpu-caches-v5-0-b792cd830f5d@suse.cz>
 <20250913000935.1021068-1-sudarsanm@google.com> <qs3967pq-4nq7-67pq-2025-r7259o0s52p4@vanv.qr>
 <f5792407-d2b9-42b3-bc85-ed14eac945ec@paulmck-laptop> <d1ef1cbb-c18d-4da6-b56b-342e86dca525@suse.cz>
In-Reply-To: <d1ef1cbb-c18d-4da6-b56b-342e86dca525@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 16 Sep 2025 10:09:18 -0700
X-Gm-Features: AS18NWBm5mFEewsCE7hgqPbGCMob1rkMeU0y4GD4Rj9Jw-SRj0_ytqyTNwX9TZE
Message-ID: <CAJuCfpEQ=RUgcAvRzE5jRrhhFpkm8E2PpBK9e9GhK26ZaJQt=Q@mail.gmail.com>
Subject: Re: Benchmarking [PATCH v5 00/14] SLUB percpu sheaves
To: Vlastimil Babka <vbabka@suse.cz>
Cc: paulmck@kernel.org, Jan Engelhardt <ej@inai.de>, 
	Sudarsan Mahendran <sudarsanm@google.com>, Liam.Howlett@oracle.com, cl@gentwo.org, 
	harry.yoo@oracle.com, howlett@gmail.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, maple-tree@lists.infradead.org, rcu@vger.kernel.org, 
	rientjes@google.com, roman.gushchin@linux.dev, urezki@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 15, 2025 at 8:22=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> On 9/15/25 14:13, Paul E. McKenney wrote:
> > On Mon, Sep 15, 2025 at 09:51:25AM +0200, Jan Engelhardt wrote:
> >>
> >> On Saturday 2025-09-13 02:09, Sudarsan Mahendran wrote:
> >> >
> >> >Summary of the results:
>
> In any case, thanks a lot for the results!
>
> >> >- Significant change (meaning >10% difference
> >> >  between base and experiment) on will-it-scale
> >> >  tests in AMD.
> >> >
> >> >Summary of AMD will-it-scale test changes:
> >> >
> >> >Number of runs : 15
> >> >Direction      : + is good
> >>
> >> If STDDEV grows more than mean, there is more jitter,
> >> which is not "good".
> >
> > This is true.  On the other hand, the mean grew way more in absolute
> > terms than did STDDEV.  So might this be a reasonable tradeoff?
>
> Also I'd point out that MIN of TEST is better than MAX of BASE, which mea=
ns
> there's always an improvement for this config. So jitter here means it's
> changing between better and more better :) and not between worse and (mor=
e)
> better.
>
> The annoying part of course is that for other configs it's consistently t=
he
> opposite.

Hi Vlastimil,
I ran my mmap stress test that runs 20000 cycles of mmapping 50 VMAs,
faulting them in then unmapping and timing only mmap and munmap calls.
This is not a realistic scenario but works well for A/B comparison.

The numbers are below with sheaves showing a clear improvement:

Baseline
            avg             stdev
mmap        2.621073        0.2525161631
munmap      2.292965        0.008831973052
total       4.914038        0.2572620923

Sheaves
            avg            stdev           avg_diff        stdev_diff
mmap        1.561220667    0.07748897037   -40.44%        -69.31%
munmap      2.042071       0.03603083448   -10.94%        307.96%
total       3.603291667    0.113209047     -26.67%        -55.99%

Stdev for munmap went high but I see that there was only one run that
was very different from others, so that might have been just a noisy
run.

One thing I noticed is that with my stress testing mmap/munmap in a
loop we get lots of in-flight freed-by-RCU sheaves before the grace
period arrives and they get freed in bulk. Note that Android enables
lazy RCU config, so that affects the grace period and makes it longer
than normal. This results in sheaves being freed in bulk and when that
happens, the barn gets quickly full (we only have 10
(MAX_FULL_SHEAVES) free slots), the rest of the sheaves being freed
are destroyed instead of being reused.

I tried two modifications:
1. Use call_rcu_hurry() instead of call_rcu() when freeing the
sheaves. This should remove the effects of lazy RCU;
2. Keep a running count of in-flight RCU-freed sheaves and once it
reaches the number of free slots for full sheaves in the barn, I
schedule an rcu_barrier() to free all these in-flight sheaves. Note
that I added an additional condition to skip this RCU flush if the
number of free slots for full sheaves is less than MAX_FULL_SHEAVES/2.
That should prevent flushing to free only a small number of sheaves.

With these modifications the numbers get even better:

Sheaves with call_rcu_hurry
            avg                            avg_diff (vs Baseline)
mmap        1.279308                       -51.19%
munmap      1.983921                       -13.48%
total       3.263228                       -33.59%

Sheaves with rcu_barrier
            avg                            avg_diff (vs Baseline)
mmap        1.210455                       -53.82%
munmap      1.963739                       -14.36%
total       3.174194                       -35.41%

I didn't capture stdev because I did not run as many times as the
first two configurations.

Again, the tight loop in my test is not representative of a real
workloads and the numbers are definitely affected by the use of lazy
RCU mode in Android. While this information can be used for later
optimizations, I don't think these findings should block current
deployment of the sheaves.
Thanks,
Suren.


>
> > Of course, if adjustments can be made to keep the increase in mean whil=
e
> > keeping STDDEV low, that would of course be even better.
> >
> >                                                       Thanx, Paul
> >
> >> >|            | MIN        | MAX        | MEAN       | MEDIAN     | ST=
DDEV     |
> >> >|:-----------|:-----------|:-----------|:-----------|:-----------|:--=
---------|
> >> >| brk1_8_processes
> >> >| BASE       | 7,667,220  | 7,705,767  | 7,682,782  | 7,676,211  | 12=
,733     |
> >> >| TEST       | 9,477,395  | 10,053,058 | 9,878,753  | 9,959,360  | 18=
2,014    |
> >> >| %          | +23.61%    | +30.46%    | +28.58%    | +29.74%    | +1=
,329.46% |
> >> >
> >> >| mmap2_256_processes
> >> >| BASE       | 7,483,929  | 7,532,461  | 7,491,876  | 7,489,398  | 11=
,134     |
> >> >| TEST       | 11,580,023 | 16,508,551 | 15,337,145 | 15,943,608 | 1,=
489,489  |
> >> >| %          | +54.73%    | +119.17%   | +104.72%   | +112.88%   | +1=
3,276.75%|
> >>
>

