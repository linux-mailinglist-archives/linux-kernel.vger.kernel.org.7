Return-Path: <linux-kernel+bounces-824803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EACBB8A2E6
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 17:07:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 309BB1C868B6
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 15:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95D27313E30;
	Fri, 19 Sep 2025 15:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CzHx0qAU"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047DD3112C2
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 15:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758294427; cv=none; b=kBw5SWNHSR3Go6pnziqUQuPi0EiPUBmwyJuoX9R0C0APsm0gtz5RaxBKoySE+mdphsWOgpUncwFAsvoJQ36N2OVqNdsz7P1N7TPPgChQ1WMpCuwMRSZ9XG7bIKoR1RfFJybNeV16ZRsb9lldEkrqmjimjj4KZD+u00ssOHid6+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758294427; c=relaxed/simple;
	bh=qqLPyn2F/B7KQ90p8JSC5m/CEx7iHLU/RePy/Usuchk=;
	h=From:Date:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R3bd6Q40H6V5sYhtfuVBcu9Nk393SiZJmaN51VnoUT/AIsxlILRJ4nOVEqwwaz5L+rM4wKTcaybaQvo+xqe/hBzyUXSNxUPCkCUFPa0JKBVhXPAecKuK92n2Inl8HEpKYTpDRgQZz9xMopczHwxdlQMH1pjChrKRjEYX+giTErA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CzHx0qAU; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-57afc648b7dso318915e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 08:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758294424; x=1758899224; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:to:date:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0X7gv2ca1L0/lLvJb6ek6nlX9wHB+NyrwieWqFd2Ims=;
        b=CzHx0qAUHQk/L/ai7avgapkHapmr8UcMtWVL7QYmZuM6vvNxE14KI0KM7jNnAA9fHT
         b1uOcTRbQ8/Rfu88KdVTxoUlwh3GIDlZYIZF0B7+f1r9wGFvprv5y6mw+sG2UTk9KtSK
         jFO9zaL+nlTwHnAsd5yKZcOAwuyOVBVMgeY9f9QeYOW+9CTmncCAHMC/XK3izKEa0xWf
         kOTFB40G9bxvl1FX2pECY+mOqgJreUBCv1r2E65bFMms368ehwVneoMUclUsxjDE4nc0
         g0CcMROi7nxxRVUYlNVcQxdwQs6Z2TWDxkGx2/SnTzkMY0g8v7GFdOC856Ucgy6/YN3+
         Fxzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758294424; x=1758899224;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0X7gv2ca1L0/lLvJb6ek6nlX9wHB+NyrwieWqFd2Ims=;
        b=mhaZFg9NTKUljwhovM8JMiW6JnPU1iouIV39zfvyaHrPjwiPOtANF+dQm5BoLVvXja
         uTnqXyCw7HCSMd89FBDh7fDgsr3qqOiIklv2Ny0uW+fslz+11k8LchPlTOQO4vAfbE2i
         1+S1bCVXVvQ7GsmMDL8c8cbnvSLoT6H4XkOjZoZqjx0T2U3kAmXdXNjSuEwhDHrSS976
         ZjtBEt+/XLqiR32yNElw4YZY+8pZfcsrbj+Le9JYDFP69Icn32K4zaEGmVjsUdL3UnJK
         LsF78eJ1odnoPZuX++/mYHTnz6MBH9RQfJWaHATJU4AcfA7HVgG/BOU1xYYPwx7O4I6Q
         zz0A==
X-Forwarded-Encrypted: i=1; AJvYcCVbxGWoowecRTu0j1MEYsy7YieaVUm0jAAmKzpPvv+FehgKNjwxWDu5zYRF5H5bOdDKGSnnaFJdw+kQM8g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDs2SUHufxy8BbNkOPZBtEiaWRAmYUkjmMt5keP7k0F33PVIfB
	rKNuH8AFY2JogIVw53vAFy5hTCdULNGEXVPN520ktqlX2fdQBh0sODL/
X-Gm-Gg: ASbGncur+9PuMwOsXCMKT6LtirecsvQweKSlWx3veZCSzE+G5/OjWZviblpk5lBQsCt
	cXFYWpVBWOm9H9LEEsBOx9iELbn+5xA4rgJxESG9qAV6KDe/yPgXFeJ1J8vesKjGtoRTJu9y90c
	vDuHgXRIFeQpzdlA1j4kCSInoilg4uN1wuZcuQPGnEJKzfrc39JsVkowZCev4cNvA5PsboFmy1s
	UH6+reQCO5rUX79D3qG+4biWBvW+5nYoqlhlsczh9SH06v90Sfg9Vgf7hsjTWQfQY1fC4QgGhac
	9eHezCfFSNVEr+DMW9ZIrYSS+oKLPe+4PWdZHc4ysFKexUvUv/MBADj6RhG4IIQYobfj0BhFpaH
	Y
X-Google-Smtp-Source: AGHT+IHlcfeC9Aa/jvbPtaam41unsEAYkZd0ZLBNWZtY3ZSGc+Og1wqJBQuKyUq6sNnJxk0X88wdvw==
X-Received: by 2002:a05:6512:1598:b0:55f:4926:df1c with SMTP id 2adb3069b0e04-579e461b887mr1360111e87.46.1758294423504;
        Fri, 19 Sep 2025 08:07:03 -0700 (PDT)
Received: from milan ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-579a1bacef8sm878143e87.103.2025.09.19.08.07.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 08:07:02 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@milan>
Date: Fri, 19 Sep 2025 17:07:01 +0200
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>, paulmck@kernel.org,
	Jan Engelhardt <ej@inai.de>,
	Sudarsan Mahendran <sudarsanm@google.com>, cl@gentwo.org,
	harry.yoo@oracle.com, howlett@gmail.com,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	maple-tree@lists.infradead.org, rcu@vger.kernel.org,
	rientjes@google.com, roman.gushchin@linux.dev
Subject: Re: Benchmarking [PATCH v5 00/14] SLUB percpu sheaves
Message-ID: <aM1xlYbvp13rOs6r@milan>
References: <20250913000935.1021068-1-sudarsanm@google.com>
 <qs3967pq-4nq7-67pq-2025-r7259o0s52p4@vanv.qr>
 <f5792407-d2b9-42b3-bc85-ed14eac945ec@paulmck-laptop>
 <d1ef1cbb-c18d-4da6-b56b-342e86dca525@suse.cz>
 <CAJuCfpEQ=RUgcAvRzE5jRrhhFpkm8E2PpBK9e9GhK26ZaJQt=Q@mail.gmail.com>
 <aMpE-oSjtlDU4TSl@pc636>
 <CAJuCfpHQ_JedSRHKKoYXyVzaFOm=dDWzgFZwqerfEC1fn35j0w@mail.gmail.com>
 <CAJuCfpE48n=QM0nY8yE3drqZU0wgC76=70EyftL1WZewEcykyA@mail.gmail.com>
 <aMvx9GKgIWtrkZ_R@milan>
 <vhp6cqq6gx5xgs2ueo7az4wobs2rddjsucjwlxckx3us3p3pey@s62u2ruxkjw7>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <vhp6cqq6gx5xgs2ueo7az4wobs2rddjsucjwlxckx3us3p3pey@s62u2ruxkjw7>

On Thu, Sep 18, 2025 at 11:29:14AM -0400, Liam R. Howlett wrote:
> * Uladzislau Rezki <urezki@gmail.com> [250918 07:50]:
> > On Wed, Sep 17, 2025 at 04:59:41PM -0700, Suren Baghdasaryan wrote:
> > > On Wed, Sep 17, 2025 at 9:14 AM Suren Baghdasaryan <surenb@google.com> wrote:
> > > >
> > > > On Tue, Sep 16, 2025 at 10:19 PM Uladzislau Rezki <urezki@gmail.com> wrote:
> > > > >
> > > > > On Tue, Sep 16, 2025 at 10:09:18AM -0700, Suren Baghdasaryan wrote:
> > > > > > On Mon, Sep 15, 2025 at 8:22 AM Vlastimil Babka <vbabka@suse.cz> wrote:
> > > > > > >
> > > > > > > On 9/15/25 14:13, Paul E. McKenney wrote:
> > > > > > > > On Mon, Sep 15, 2025 at 09:51:25AM +0200, Jan Engelhardt wrote:
> > > > > > > >>
> > > > > > > >> On Saturday 2025-09-13 02:09, Sudarsan Mahendran wrote:
> > > > > > > >> >
> > > > > > > >> >Summary of the results:
> > > > > > >
> > > > > > > In any case, thanks a lot for the results!
> > > > > > >
> > > > > > > >> >- Significant change (meaning >10% difference
> > > > > > > >> >  between base and experiment) on will-it-scale
> > > > > > > >> >  tests in AMD.
> > > > > > > >> >
> > > > > > > >> >Summary of AMD will-it-scale test changes:
> > > > > > > >> >
> > > > > > > >> >Number of runs : 15
> > > > > > > >> >Direction      : + is good
> > > > > > > >>
> > > > > > > >> If STDDEV grows more than mean, there is more jitter,
> > > > > > > >> which is not "good".
> > > > > > > >
> > > > > > > > This is true.  On the other hand, the mean grew way more in absolute
> > > > > > > > terms than did STDDEV.  So might this be a reasonable tradeoff?
> > > > > > >
> > > > > > > Also I'd point out that MIN of TEST is better than MAX of BASE, which means
> > > > > > > there's always an improvement for this config. So jitter here means it's
> > > > > > > changing between better and more better :) and not between worse and (more)
> > > > > > > better.
> > > > > > >
> > > > > > > The annoying part of course is that for other configs it's consistently the
> > > > > > > opposite.
> > > > > >
> > > > > > Hi Vlastimil,
> > > > > > I ran my mmap stress test that runs 20000 cycles of mmapping 50 VMAs,
> > > > > > faulting them in then unmapping and timing only mmap and munmap calls.
> > > > > > This is not a realistic scenario but works well for A/B comparison.
> > > > > >
> > > > > > The numbers are below with sheaves showing a clear improvement:
> > > > > >
> > > > > > Baseline
> > > > > >             avg             stdev
> > > > > > mmap        2.621073        0.2525161631
> > > > > > munmap      2.292965        0.008831973052
> > > > > > total       4.914038        0.2572620923
> > > > > >
> > > > > > Sheaves
> > > > > >             avg            stdev           avg_diff        stdev_diff
> > > > > > mmap        1.561220667    0.07748897037   -40.44%        -69.31%
> > > > > > munmap      2.042071       0.03603083448   -10.94%        307.96%
> > > > > > total       3.603291667    0.113209047     -26.67%        -55.99%
> > > > > >
> > > > > Could you run your test with dropping below patch?
> > > >
> > > > Sure, will try later today and report.
> > > 
> > > Sheaves with [04/23] patch reverted:
> > > 
> > >             avg             avg_diff
> > > mmap     2.143948        -18.20%
> > > munmap     2.343707        2.21%
> > > total     4.487655        -8.68%
> > > 
> > With offloading over sheaves the mmap/munmap is faster, i assume it is
> > because of same objects are reused from the sheaves after reclaim. Whereas we,
> > kvfree_rcu() just free them.
> 
> Sorry, I am having trouble following where you think the speed up is
> coming from.
> 
> Can you clarify what you mean by offloading and reclaim in this context?
> 
[1] <Sheaves series>
             avg            stdev           avg_diff        stdev_diff
 mmap        1.561220667    0.07748897037   -40.44%        -69.31%
 munmap      2.042071       0.03603083448   -10.94%        307.96%
 total       3.603291667    0.113209047     -26.67%        -55.99%
[1] <Sheaves series>

[2] <Sheaves series but with [04/23] patch reverted>
             avg             avg_diff
 mmap     2.143948        -18.20%
 munmap     2.343707        2.21%
 total     4.487655        -8.68%
[2] <Sheaves series but with [04/23] patch reverted>

I meant those two data results. It is comparison of freeing over
or to "sheaves" and without it in the kvfree_rcu() path.

--
Uladzislau Rezki

