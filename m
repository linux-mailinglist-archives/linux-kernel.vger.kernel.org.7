Return-Path: <linux-kernel+bounces-803516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3384CB461A6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 20:03:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC36C5C462C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 18:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53450393DD3;
	Fri,  5 Sep 2025 18:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DFWcyiYe"
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1AA374289
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 18:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757095363; cv=none; b=RdCFNmF4ef+JItnySwjebkjfxPEed+q8fmhUvU/Q01QxRkex5rGFMOm8IDREV9DY6TWu5GT1jWiqW6/qBrtJAsATn3qLAmJnrimV4vUVJ6hZUjk7dniKCIwOHj8UUT+voaYiIKal/w5ze41sPKmc2NwLol55dJUz6tITOAK/NnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757095363; c=relaxed/simple;
	bh=uy/ix0e95VVYwUSkJMdAcPZuFXbPYyC4yMaPlrU0hnM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YkWh4RmAgXviFRC85lARwsHPqu30/BlZUIhOkYzuEJuIBfjncJ8FolVwuJ4ch5BH9TeBN346BmJjR2bP+F6uGopiYG3FHuuypZtvBwkF80N1LDQeZTIGYMQTbW8mo2oLfPdj3n0HKgOCspG1D1sLbgYigAFzjjv90zXAzpDkPv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DFWcyiYe; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3f05a8fa19bso25658765ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 11:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757095361; x=1757700161; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dx9xTgCy72/MrGwJEKodSiBTPmC6Mwn5gz5BEaZ5f3c=;
        b=DFWcyiYe16Ajhw99MymwmeZ9qxskSNmYivzQdeX39OuzXi78blwf3KwvMR4eS/T9ee
         x9+YcCyQgzBrqdBzq7lIdreUrZJ1qfpVBeo7z7Q/77YuP6gmncXAPMHoSWIVuSKkA7Fl
         ixPlvt91u3M3TgmOxkBlOZabK6LshEf88suFsDZIYHwjuDAOAFh2ep5Nk7B46oSIliXT
         INto+lJw9O2/w7puv8Xng+EECPXtRyuk+cW2ZPMxG3VwOXcCaJakQMDbF0eD4omXaOUY
         k1/t8zhqyS/B4yDPWYnZmy6SfeRphaFF/ORLU3RLJ5SKTsk7pNVSuX5waARv3T5j9Mzd
         KuhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757095361; x=1757700161;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dx9xTgCy72/MrGwJEKodSiBTPmC6Mwn5gz5BEaZ5f3c=;
        b=jAMYkjISAOXTSuWIDPiS3TOBvP52svWd0VTb86qopAEjc5oP/97LkGMCSZzeAWCgG3
         YHoYY4ThjafK5Rv0G8MjIX/J+WDIYswc0vEu33+j1ovhbQGGf2qZ/BiWUgwBHq0V3J4z
         XZrxWvS+KLKghFTjinMOExMTvm13+FOiaTjaXf6PoROlpBxOyOgmtbHACSrBtGd72cZa
         D8lnn2X8wfcZtQ2fmICHffAAE4giHjAkkhZDBn1HasaKR/YHIWtkLnXxTi3kbscQP/6F
         TdeqwHhHhgmPVbzqCn6VdQhPOcCkWrshjvlzI8mzyAz4eYV2vCMcUXNiDO4nb2l2W4s+
         oCJA==
X-Forwarded-Encrypted: i=1; AJvYcCUwddoX5/O2ifi3rzfHGI2VixvKb1W74EoyntxFJl5HGPylBmdDy7L0QpFxFJTH5gBb1xlPAPzof38UfzI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjoVxHC5ZsJsLfdZn21gv0uOKdch8g6aMLs5gm9cbBZobQyG/o
	+kUW2HkgWI+2dH91t0nj/dwkG11g09Mqhqwe0wDEgz9l5xsBgaX45QOP5ZwKE2IAqiuhzaAJgL6
	8csk6BcyNe2eYaIVwbwsSOHpHu/ZOHRx6uLcL
X-Gm-Gg: ASbGncsWrMPs2CGXShi8kpJp3cW4Ehe7Ob3hjHCLlvavYHF0IkfJRPiYrVXga/1Kpgn
	pc7ux2ZsvN8RBG85m71lKDqMfqjIPmWa/gZtuP7mH5rVcTlK6bff3bprmxUHN/0Oqa9/cUyf3GH
	/ly6VwJqTGKe1JYo9P6Uww5uTrA9cD1+nBq0E3rJmL49bC0BWK/ldi+xTMxNcn6aORKD1ZXpvLe
	bND
X-Google-Smtp-Source: AGHT+IEUfIwkviQEN15ms4c5dONy5PWOugl2vpJmJN5pI2IRPqkTjy2HY+0hhAUB0Sd4G+eYatXIm8q1LTV9tZhQ+6o=
X-Received: by 2002:a05:6e02:1a41:b0:3fc:7359:a850 with SMTP id
 e9e14a558f8ab-3fc7359aa77mr9736775ab.16.1757095360837; Fri, 05 Sep 2025
 11:02:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250829162212.208258-1-hannes@cmpxchg.org> <20250904093325.2768507-1-vitaly.wool@konsulko.se>
 <7b1ca42d-1b89-44f4-bffb-e6b09f86fdc5@suse.cz> <1d42c513-cc83-4f08-a10c-cbd6206070f4@konsulko.se>
In-Reply-To: <1d42c513-cc83-4f08-a10c-cbd6206070f4@konsulko.se>
From: Nhat Pham <nphamcs@gmail.com>
Date: Fri, 5 Sep 2025 11:02:29 -0700
X-Gm-Features: Ac12FXyset2Epjt40edRs0yWUbEmmO231z0PSN40ziEioBbvE56l5ZG-g-ZhWSI
Message-ID: <CAKEwX=MMNSg-QdA2XdBpzhi_d-o9Pv4OOPR5nqrvUVWRdnnpLA@mail.gmail.com>
Subject: Re: [PATCH 0/3] mm: remove zpool
To: Vitaly Wool <vitaly.wool@konsulko.se>
Cc: Vlastimil Babka <vbabka@suse.cz>, hannes@cmpxchg.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Christoph Hellwig <hch@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 4, 2025 at 4:49=E2=80=AFPM Vitaly Wool <vitaly.wool@konsulko.se=
> wrote:
>
>
>
> On 9/4/25 12:13, Vlastimil Babka wrote:
> > On 9/4/25 11:33, Vitaly Wool wrote:
> >>> With zswap using zsmalloc directly, there are no more in-tree users o=
f
> >>> this code. Remove it.
> >>>
> >>> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> >>
> >> Per the previous discussions, this gets a *NACK* from my side. There i=
s
> >> hardly anything _technical_ preventing new in-tree users of zpool API.
> >> zpool API is neutral and well-defined, I don=E2=80=99t see *any* good =
reason for
> >> it to be phased out.
> >
> > AFAIK it's a policy that unused code should be removed ASAP. And that's=
 the
> > case for zpool after Patch 1, no? It could be different if another user=
 was
> > about to be merged (to avoid unnecessary churn), but that doesn't seem =
the
> > case for zblock?
>
> For the C implementation of zblock, no. But there's another
> implementation which is in Rust and it's nearing the submission.
>
> > My concern would be if the removal breaks any existing installations re=
lying
> > on zswap. Presumably not as a make oldconfig will produce a config wher=
e
> > nothing important is missing, and existing boot options such as
> > "zswap.zpool=3D" or attempts to write to in the init scripts to
> > "/sys/module/zswap/parameters/zpool" will cause some errors/noise but n=
ot
> > prevent booting correctly?
>
> I don't expect heavy breakage but misconfigurations will definitely occur=
.
> > I mean if we were paranoid and anticipated somebody would break their
> > booting if writing to /sys/module/zswap/parameters/zpool failed, we cou=
ld
> > keep the file (for a while) and just produce a warning in dmesg that it=
's
> > deprecated and does nothing?
> >
> >  From Patch 1:
> >
> >> Note that this does not preclude future improvements and experiments
> >> with different allocation strategies. Should it become necessary, it's
> >> possible to provide an alternate implementation for the zsmalloc API,
> >> selectable at compile time. However, zsmalloc is also rather mature
> >> and feature rich, with years of widespread production exposure; it's
> >> encouraged to make incremental improvements rather than fork it.
> >
> > With my history of maintaining the slab allocators I can only support t=
his
> > approach.
>
> There was the time when slab was the best option and it was more mature
> than slub, which is now the best and only option. Thus, the "maturity"
> point is indeed valid but not being backed by anything else it doesn't
> weigh too much. Besides, zsmalloc's production exposure from all I know
> is limited to the 4K page case, and zsmalloc is truly struggling when
> the system is configured for 16K pages.

That doesn't sound unfixable, if I recall our conversation correctly.
Perhaps all of this effort is better off being spent fixing zsmalloc's
inefficiencies :)

>
> Things keep changing, and some of the proven solutions may not be a good
> fit moving forward. While not suggesting that we should have a handful
> of zpool backends just for the sake of variety, I'd like to emphasize
> that there are good reasons to have zblock (especially the Rust one),
> and there are good reasons to keep zsmalloc. That leads to the
> conclusion that zpool should stay.

IMHO, the needs for multiple allocators do not necessitate the zpool API.

The zpool API is only needed if you want to switch the allocators
arbitrarily at runtime. This one is a much harder sell.

We can always add zblock, and select the backend via build options.
Overtime, as zsmalloc improves to acquire zblock's advances, or zblock
implements the missing features (migratability, compaction, etc.), we
can unify/remove one of them.

