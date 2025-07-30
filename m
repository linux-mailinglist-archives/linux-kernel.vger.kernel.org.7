Return-Path: <linux-kernel+bounces-750541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 598C3B15DC7
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 12:05:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF8367A3860
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 10:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A69ED238D53;
	Wed, 30 Jul 2025 10:05:21 +0000 (UTC)
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0D822156D
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 10:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753869921; cv=none; b=XmO8KSf5DhkM9xvZFQYtYlglqskw6k2qkUvrRujJHPlRKoxwQkqEUg/EMGTvRYgnKVQZOHxpHYxtuCxXX6Qq3Y2aUGyL9Gc3SnYu/bXRY0czKLg+xv549jVXeEEKBfPZgyCY1atfmA83umx3eAWPJIMv7hwo2sz54aYiRuuqLgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753869921; c=relaxed/simple;
	bh=3sUA/KOgsfzhmthv63Ee3iRgy6n2DJjRUUokISVQg74=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LY37i+jAL5edu6Eh8Mae7cBCUy+BnSDOpIEyOxaxp6fVovzY2UGQyxoMx507P+RIn6O1KMBlZULbuR+Dng7qxY0LTUDGzAppwyAwrjDDGnEbRN+q9o63/Ls/pMriGRHEU9UjDtW5If4ykKajEhWMTT41LcCxwA9JUKZW8I3Wj2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-53185535ed9so623968e0c.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 03:05:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753869918; x=1754474718;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hvFOMtlzmgf57aIdk7rzIqnMh7+rkPSLEpyIZ7Q84yo=;
        b=p4HEnJYCgaI0utA5xhu+PhrAq7bUshw3QvTb9Zsh1d0U3HM/J2AOCPl20bgjgcB63L
         C2W06Asp+gZIMyln8d0W56azPD6tl42d1u53xj6dFHFe9c1Mhu++n3PslotsMVszAG3C
         e+CJ9thqcNn5lU7hDNCbYaf1H+rOLaZ4/kkY/WFReqmmH/dFLYNyXxnDIXAd+kI/W6uW
         dGqbPH45Wal/l09HLGbT6J2MedJ3dOZif4dCU32mOOlXkMuNfIuNoLLxHzPO72cLB2g7
         JlO6YUEUiRCCP9XOhu/iBY1x4k/Dfb5okSA3HGtgxyRBjlXoIiNsOIzxkBx7FpLdpl2+
         dmXA==
X-Forwarded-Encrypted: i=1; AJvYcCXlY1Xe3cLDnDpoEw32eWUDzhv4sT8U9DSXhqKwfXoxmrN6HcwwO6fhRWUocKECkSycSPetGeUI66j8nNY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJx9mFhswqr/ydR0Vuck/s5ivXfsEgmNpSf5/6E6TLNVrb6fv2
	fKTlGG24xXPSmgIiy07WGTV/H2aj0ocBopUEPYknKqEjhOW8WX8slVmEY8Vz4HuL
X-Gm-Gg: ASbGncsKiDeNT7c9+3vG2RStaMsI4Wb/+NAsQ0Y70j/s58KWmguL756K1+KDS/TGPr8
	gJ2Wi5uN/9CO2QyI2tR2inVb9WEalCFgOFHNIg+65Tk8p1QS8k7HvCp27/7hA/6MjE+KbvaexJN
	s6B1eXuWWUxz0YyJqerHObBpzd5rEn2+TZJV5ixu/Rgqzja6yj0qeA8RkySWVMNxNlVNeAHFoxT
	5gR16dqQ3rb5vltIpafoCGpG0kkRrkq+29ZPukEjuS4ssk/9ZYWzi7hiSCReIKG51wjBKsL8iUd
	EJzWBhXC3kIw70qXBNWF9UbaQwQgf2Tp4/QQ59MRblr31nKAQojO3Hy3rkMdWJZfPHtT9binHqF
	CR63CQkjvVYYa1B1xGTJ4cfAeH3huxeGhHJ0mMihstsWwdKUx6SU2RrWRwfhw
X-Google-Smtp-Source: AGHT+IFqokLmqiNE25yQShtr7ccElzpCo1UwA/pcRqLTfpxjhYvrB54zbRqWhFdtI5MXBLY9bUeYtg==
X-Received: by 2002:a05:6122:2a53:b0:524:2fe0:61bc with SMTP id 71dfb90a1353d-5391eff6816mr1459699e0c.5.1753869917382;
        Wed, 30 Jul 2025 03:05:17 -0700 (PDT)
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com. [209.85.222.48])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-538e2621a62sm2637291e0c.14.2025.07.30.03.05.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jul 2025 03:05:17 -0700 (PDT)
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-88ba493e984so350287241.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 03:05:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWIm8IWmvMms7Yi2we0fBtoJLZDuEPmrn2YnNCYF2jKtZSeal5Lxv4SqmUJXLs/GqMaKug8fdBzIbiKlYk=@vger.kernel.org
X-Received: by 2002:a05:6102:3249:10b0:4fa:3f49:a3b4 with SMTP id
 ada2fe7eead31-4fa778c5582mr2504514137.3.1753869916655; Wed, 30 Jul 2025
 03:05:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250702114924.091581796@infradead.org> <20250702121158.465086194@infradead.org>
 <CAMuHMdXn4z1pioTtBGMfQM0jsLviqS2jwysaWXpoLxWYoGa82w@mail.gmail.com> <aInp78zC_WwVW6yd@jlelli-thinkpadt14gen4.remote.csb>
In-Reply-To: <aInp78zC_WwVW6yd@jlelli-thinkpadt14gen4.remote.csb>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 30 Jul 2025 12:05:05 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVPR7Q7pvn+QqGcq2pJ00apDgUcaCmAgq6nnM1uHySMcw@mail.gmail.com>
X-Gm-Features: Ac12FXzT6dorMp5Cef-PIa_OaBJW01JDox25_62CFaduLwIvUCuQGOZNFREweac
Message-ID: <CAMuHMdVPR7Q7pvn+QqGcq2pJ00apDgUcaCmAgq6nnM1uHySMcw@mail.gmail.com>
Subject: Re: [PATCH v2 02/12] sched/deadline: Less agressive dl_server handling
To: Juri Lelli <juri.lelli@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com, vincent.guittot@linaro.org, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, vschneid@redhat.com, clm@meta.com, 
	linux-kernel@vger.kernel.org, linux-m68k <linux-m68k@lists.linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"

Hi Juri,

On Wed, 30 Jul 2025 at 11:46, Juri Lelli <juri.lelli@redhat.com> wrote:
> On 30/07/25 11:34, Geert Uytterhoeven wrote:
> Apologies for interjecting.

No apologies needed, much appreciated!

> > On Wed, 2 Jul 2025 at 14:19, Peter Zijlstra <peterz@infradead.org> wrote:
> > > Chris reported that commit 5f6bd380c7bd ("sched/rt: Remove default
> > > bandwidth control") caused a significant dip in his favourite
> > > benchmark of the day. Simply disabling dl_server cured things.
> > >
> > > His workload hammers the 0->1, 1->0 transitions, and the
> > > dl_server_{start,stop}() overhead kills it -- fairly obviously a bad
> > > idea in hind sight and all that.
> > >
> > > Change things around to only disable the dl_server when there has not
> > > been a fair task around for a whole period. Since the default period
> > > is 1 second, this ensures the benchmark never trips this, overhead
> > > gone.
> > >
> > > Fixes: 557a6bfc662c ("sched/fair: Add trivial fair server")
> > > Reported-by: Chris Mason <clm@meta.com>
> > > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > > Link: https://lkml.kernel.org/r/20250520101727.507378961@infradead.org
> >
> > Thanks for your patch, which is now commit cccb45d7c4295bbf
> > ("sched/deadline: Less agressive dl_server handling") upstream.
> >
> > This commit causes
> >
> >     sched: DL replenish lagged too much
> >
> > to be printed after full user-space (Debian) start-up on m68k
> > (atari_defconfig running on ARAnyM).  Reverting this commit and fixing
> > the small conflict gets rid of the message.
>
> Does
> https://lore.kernel.org/lkml/20250615131129.954975-1-kuyo.chang@mediatek.com/
> help already (w/o the revert)?

Thanks, it does!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

