Return-Path: <linux-kernel+bounces-819992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1224BB7D776
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:28:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 619267A2945
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 05:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDB271D7E4A;
	Wed, 17 Sep 2025 05:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W12tSvr7"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91CAC18FDBE
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 05:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758086400; cv=none; b=oVibWgy7mOuW9w3CdPBYJUWpb8pjJCxsfISRULwAbMeK3mA9mRUuxdl+2oKwc+ctH0dm0Eb8wIG/lq+t1GeU0uZYyDTR6+AJzR5XtgzhW/zhbuKl3ar9/SHZqnUWKCPez+lSCIP/HBwDHQSEC5pTMuFg6chh9ZcmRknNFq4tya0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758086400; c=relaxed/simple;
	bh=lLkNMPBajuW9Y7+dO0l+pEP4YVKZeExxjU+skKzYZr8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EjDW0auff4R5btNACSRVKnmOyGAdBDEdv6gmPjTHE5bzGbmqYv+m1VeFC1tqeQXPlQVpyPi8nL9lizTm9Q86t/wjjzNcMz9Z/MfZPpNWSCiqVFypB8Z4NxnxHXs1ZEEiRjvarTZqcnS6EM0a49wRoWyl905Cir0X/2RY9p8O7xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W12tSvr7; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-55f7039a9fdso6728753e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 22:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758086397; x=1758691197; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Bmyd5hRjBwGBijd389YyKI2Nhh/nN0koD1xhovKWzlU=;
        b=W12tSvr7+54KthrNNpYPUzl3m+aPv2BQPUhLrzu/7ofQo28z0AvtmIGoUkFF3gbV4D
         erbW8uFSbJhjuki5Xvs8ID0Ay9/4kzBWyNQCLRwLpt2HCzIplHp+pmRfbpjWMXVV9erP
         iyvrqVRKqZMs6Ez+psrc9/lPP5GcFkWoYfaSwCcLLz5XOq/CKVzBdxLs74UU//G2J6uB
         MT3V/r8j/GHSXzdXzj93znSqa/MHvaTz7KG+8q2FpEzEqCMt1+VST5LXABBjpJ9z+gMD
         7Wv56AGF7Hm6F5usLedSzz/eA0zqLzMjW5ZeV07PF1Cf7BoUx3LXhOtrOJ0CRaGcUBF2
         qlSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758086397; x=1758691197;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bmyd5hRjBwGBijd389YyKI2Nhh/nN0koD1xhovKWzlU=;
        b=Vwbm3F8WnK1G7ousc2dcjb/9EhmnQLh83mw4EUIMyv5ce0zSWu5krgD6QflSjjxGa/
         bVP5qxgJGHMlXswCWgUnzps74lSrJ/TOrnFENEbwncP9RVz3w08JoP1cgrSdHyutNqfC
         EpHdgN8OXEfJc2AJVcTF4/gP7VqM88S55O+MLsN22id3DzURLOZYovLgtFjghE2upvbd
         ZCRasx0mZCxvuSee93gDIUBCieC+7P6rMPbg8xWxSS0ofd4/HbJyZMYMNrupBice+Mmq
         R4CoQ8q1mKmB8PiMFFprsad+Sy1LL5n9NLy2fhguCHwvEmJUiiXdXzhDD+mGYIsd35iW
         5IAQ==
X-Forwarded-Encrypted: i=1; AJvYcCWAtsFdDMTU8aQ+M76evIXmCESTl6W2xYO4HDl8PIvTELw8izlQ+SOpBrgChEuRlS9qM6fbgQUmCjp0JtE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxoy81cc7rOTXoeXIu7MmhRa9DDFdtpoFDDp51eI0Bri7yc4aX+
	ZsmNTVPgqitoU7I1zeiGQyiZ3IysZF+hRzAKXEBaXAsBRlXGGc8SX40t
X-Gm-Gg: ASbGncv4UYJXqkjWMN3LuSYeeY2nEOuyDvtk5ms2FyQJwmT1x5ASEDlwH4W6Ikgo64o
	k0ZV2t/PNQHbdP95/eXguvbHZV0COW8TVR6+TOYJs0/xtD213tu2m8IqrsTaGnak7QC++6RsNk5
	Kv2++r0JUiZdbWAmKMwzldsWE76fQH6aAjD1wgsiCeuicWhuQXioILIP9RQT/MxecnhmqKWKIo2
	/60RfM8BvZJ2fDkcqhz+YzcBU7aU4DkrnmIwNPtrAE7qn64RIOUKkDrmtzgBFXswWIUTxbZ/kIc
	pkvQyKHICCfWG7f7woJee9lPQLSOgKXXDpbhH0A6SDH5TSOm3QPBsh91O4npCvAz
X-Google-Smtp-Source: AGHT+IGB2IAmQmaimZaar4vlRXTB5elF9KD3WHugEVd5zhXssue2GqCwq5b5W8l5x9hC6+gNaxnbEQ==
X-Received: by 2002:a05:6512:15aa:b0:55f:33e0:9602 with SMTP id 2adb3069b0e04-57798947d80mr238319e87.9.1758086396325;
        Tue, 16 Sep 2025 22:19:56 -0700 (PDT)
Received: from pc636 ([2001:9b1:d5a0:a500::800])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-57327ed142bsm2809676e87.136.2025.09.16.22.19.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 22:19:55 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Wed, 17 Sep 2025 07:19:54 +0200
To: Suren Baghdasaryan <surenb@google.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, paulmck@kernel.org,
	Jan Engelhardt <ej@inai.de>,
	Sudarsan Mahendran <sudarsanm@google.com>, Liam.Howlett@oracle.com,
	cl@gentwo.org, harry.yoo@oracle.com, howlett@gmail.com,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	maple-tree@lists.infradead.org, rcu@vger.kernel.org,
	rientjes@google.com, roman.gushchin@linux.dev, urezki@gmail.com
Subject: Re: Benchmarking [PATCH v5 00/14] SLUB percpu sheaves
Message-ID: <aMpE-oSjtlDU4TSl@pc636>
References: <20250723-slub-percpu-caches-v5-0-b792cd830f5d@suse.cz>
 <20250913000935.1021068-1-sudarsanm@google.com>
 <qs3967pq-4nq7-67pq-2025-r7259o0s52p4@vanv.qr>
 <f5792407-d2b9-42b3-bc85-ed14eac945ec@paulmck-laptop>
 <d1ef1cbb-c18d-4da6-b56b-342e86dca525@suse.cz>
 <CAJuCfpEQ=RUgcAvRzE5jRrhhFpkm8E2PpBK9e9GhK26ZaJQt=Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpEQ=RUgcAvRzE5jRrhhFpkm8E2PpBK9e9GhK26ZaJQt=Q@mail.gmail.com>

On Tue, Sep 16, 2025 at 10:09:18AM -0700, Suren Baghdasaryan wrote:
> On Mon, Sep 15, 2025 at 8:22 AM Vlastimil Babka <vbabka@suse.cz> wrote:
> >
> > On 9/15/25 14:13, Paul E. McKenney wrote:
> > > On Mon, Sep 15, 2025 at 09:51:25AM +0200, Jan Engelhardt wrote:
> > >>
> > >> On Saturday 2025-09-13 02:09, Sudarsan Mahendran wrote:
> > >> >
> > >> >Summary of the results:
> >
> > In any case, thanks a lot for the results!
> >
> > >> >- Significant change (meaning >10% difference
> > >> >  between base and experiment) on will-it-scale
> > >> >  tests in AMD.
> > >> >
> > >> >Summary of AMD will-it-scale test changes:
> > >> >
> > >> >Number of runs : 15
> > >> >Direction      : + is good
> > >>
> > >> If STDDEV grows more than mean, there is more jitter,
> > >> which is not "good".
> > >
> > > This is true.  On the other hand, the mean grew way more in absolute
> > > terms than did STDDEV.  So might this be a reasonable tradeoff?
> >
> > Also I'd point out that MIN of TEST is better than MAX of BASE, which means
> > there's always an improvement for this config. So jitter here means it's
> > changing between better and more better :) and not between worse and (more)
> > better.
> >
> > The annoying part of course is that for other configs it's consistently the
> > opposite.
> 
> Hi Vlastimil,
> I ran my mmap stress test that runs 20000 cycles of mmapping 50 VMAs,
> faulting them in then unmapping and timing only mmap and munmap calls.
> This is not a realistic scenario but works well for A/B comparison.
> 
> The numbers are below with sheaves showing a clear improvement:
> 
> Baseline
>             avg             stdev
> mmap        2.621073        0.2525161631
> munmap      2.292965        0.008831973052
> total       4.914038        0.2572620923
> 
> Sheaves
>             avg            stdev           avg_diff        stdev_diff
> mmap        1.561220667    0.07748897037   -40.44%        -69.31%
> munmap      2.042071       0.03603083448   -10.94%        307.96%
> total       3.603291667    0.113209047     -26.67%        -55.99%
> 
Could you run your test with dropping below patch?

[PATCH v8 04/23] slab: add sheaf support for batching kfree_rcu() operations

mmap()/munmap(), i assume it is a duration time in average, is the time
in microseconds?

Thank you. 

--
Uladzislau Rezki

