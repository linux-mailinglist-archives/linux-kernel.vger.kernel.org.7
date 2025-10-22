Return-Path: <linux-kernel+bounces-864471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 31D87BFADC1
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 10:21:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 26B92504B36
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 08:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1116308F14;
	Wed, 22 Oct 2025 08:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SZWu7dOt"
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3842309DCD
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 08:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761121278; cv=none; b=G1zxbuBNUfqTNGkusQo7zkWUY29SxNpFzyUMZs/+t7p2g+zT5DVzPhYUtaFwlUlcWl0M4+G7qYLsIWpPNHykHtr5JoxrZda9M7Nx0Ld+RZN8Sukjlet39POMkFrpmzJShS/jEls/UFG+lFXGdHS4wX82TZNfy6kI9M1FzA1+Q7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761121278; c=relaxed/simple;
	bh=22MKP3ktD+MHsOGmBMWxOpQesj09oYBxSIEKCIk7RNg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PMguUYGE4vTJSSkTurvokhMpMCM8LeRXh1Xmk4uOddC8I0mMuZDYsjvijz9VFUVI2YVb/PAlvdchJS87eixQrGsSuf+6J4lvcEvqUssUimZfima1AeQWnroLiIOQnSwztrtKhYux2vMCh/cYqVkUZre9z872sR+tN5updeAKlzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SZWu7dOt; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-883902b96c3so642465585a.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 01:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761121274; x=1761726074; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FbBDIydICMMlUqTAYZ2roYG//mlAxe9Am6ycKGnO2fs=;
        b=SZWu7dOtLGkgZdw7pjZl15QT8rHjhkfCL1fjXtzXX62ZaCMtFhFncu1tuqfqi76b6J
         n/kCj04zvjZkgGwFTvAhi35vyiiX+9yk29cwKsoBQBnxZLuNYZuCs3Yj71tg+xJvVO/8
         /k4jXXJ+scKCQMoJHB/O2gR5IarL5FdGpKJaLfTyr9fObn3jzEjcxs7SPV4jz2obDvEC
         Y2WTE4YpmOYSbXPjCHlXqikMlQrcq7FKsEMCsAdzNWTLwj4eQvICBkgBAbieVWTOXFAI
         Bw14DBvgSY8xqIffIvvlzIT5BoRVsXn3xY8vbPOmxpA7g1TukN+ZptkpumFiaGTt02JR
         ppbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761121274; x=1761726074;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FbBDIydICMMlUqTAYZ2roYG//mlAxe9Am6ycKGnO2fs=;
        b=IHlEF0Su3JTKxxO62OVCcPBQjCmi+v+8u5bH14UEfxuIf5xPDa/CgSLxepRzcVFQYP
         DQs00NMSxHM+vY/HTG86FjjVxgUwTGg1m1BIa/zGYaeP9VTuYXmt7lkRvf9QHM/19cQF
         p3ibWX4hoVyv/kI16LVjHZ6TWAc17I3M2rwuh+BqMo0+KS09HuE7eqwPPmqWpYyxIWlO
         LwgJ9rBbuYDGlJ4U2huzVFoBprjLm/LUW6QWFJm+0X/fL2fhbpJGzP9KjftlQTSAGOp3
         6f7GdsbmJkcLRopkayhvQpJrzs5a809Y6SuxFmeYoF6gBMoiA6mcp+ZMTVJOfWADHZgI
         MQvQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXCcUP8GD6LU3bF7CMERxtMCb824aN+wz55fHZc/wnrHR6B/XZWLyHm6B0BH2pt6ky/8aW6X3/YQOJabU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEnnylSozX4E1oSecY43f163Fv2A98Zb4BNO19LE83ZjLqq4uZ
	SjS99/JHdxHx7JIPgZ9znA7sERIybmx06Rp8My1Rb1KevzShjlBxM9dsDH0nnv7sYXYm57oXIk+
	/89Jr4fot3WQmHrW/3FZiDNuROt4nzWE=
X-Gm-Gg: ASbGncsO6Kg8fufFqr26bOewSiLZsqN9OEPQ4pnVFfLKlwXKPKQwYsejF82BH7q0Ev0
	FNBGfiUPJwdC1XxixB7Gg5o325McjtskXWSqXY9rgRmn9y/sEqaLVwttySYiC+r8SDFM2LqbAHM
	32+kVNdBHHWaFT/tbn3krmhoTMVfi4fEIsvDjncNyNedur9DQW1aMMSTp0rqwlVkFLinaodvaJk
	DzaixM0VjWhABEZBEWdXQ8KozFONpBlkodTSULxKPC6JWtULAaBJ9XZKajPsONh432ucdMy3s8B
	TPLpbnTl+vFme48suVFkD97NQSY=
X-Google-Smtp-Source: AGHT+IGiYyidmAq6v93wMhiyCaihmAv1fXpC5YqNooqiisGt2zleeKxqjBgJkCIJbbPMcehgUQ9z1qa/au/BWzzRRxc=
X-Received: by 2002:a05:620a:4621:b0:865:cacf:e125 with SMTP id
 af79cd13be357-8906e8add88mr2315519985a.10.1761121274425; Wed, 22 Oct 2025
 01:21:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022035528.1981892-1-xiaqinxin@huawei.com>
 <CAGsJ_4wMtWZUTWRePK9_90LrbANUo7RcVkBRbQJ4aBEypWwtLQ@mail.gmail.com> <04ac708f-922e-4aca-80ea-e1217da89ce2@huawei.com>
In-Reply-To: <04ac708f-922e-4aca-80ea-e1217da89ce2@huawei.com>
From: Barry Song <21cnbao@gmail.com>
Date: Wed, 22 Oct 2025 21:21:03 +1300
X-Gm-Features: AS18NWC2MO-Kh8o40313Qk4q6NptXcYwgO5cIFTXw5He2u8c1tDt8oo4GnMs3gI
Message-ID: <CAGsJ_4woVFtej3HU7vXt2wDSDLGkr_wrqzBP6SqV73O-h2AoSg@mail.gmail.com>
Subject: Re: [PATCH v4] tools/dma: move dma_map_benchmark from selftests to tools/dma
To: Qinxin Xia <xiaqinxin@huawei.com>
Cc: m.szyprowski@samsung.com, robin.murphy@arm.com, prime.zeng@huawei.com, 
	fanghao11@huawei.com, linux-kernel@vger.kernel.org, linuxarm@huawei.com, 
	wangzhou1@hisilicon.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 22, 2025 at 9:16=E2=80=AFPM Qinxin Xia <xiaqinxin@huawei.com> w=
rote:
>
>
>
> On 2025/10/22 12:23:04, Barry Song <21cnbao@gmail.com> wrote:
> >>
> >>   #define DMA_MAP_BENCHMARK       _IOWR('d', 1, struct map_benchmark)
> >>   #define DMA_MAP_MAX_THREADS     1024
> >> @@ -27,5 +29,7 @@ struct map_benchmark {
> >>          __u32 dma_dir; /* DMA data direction */
> >>          __u32 dma_trans_ns; /* time for DMA transmission in ns */
> >>          __u32 granule;  /* how many PAGE_SIZE will do map/unmap once =
a time */
> >> +       __u8 expansion[76]; /* For future use */
> >>   };
> >
> > I didn=E2=80=99t realize you were hiding a bugfix within the code clean=
up.
> >
> > We agreed this is a hotfix that should be merged promptly[1]. Before se=
nding
> > v5, please submit the hotfix first using the existing folder (without m=
oving
> > the code from selftest to tools). Once it is merged, resend v5 based on=
 it.
> >
> > [1] https://lore.kernel.org/lkml/f8c0cbdc-9c68-46bb-8dad-1d7c80f3f741@s=
amsung.com/
> >
> > Thanks
> > Barry
>
> Hello Barry:
> For the previous patch has not merged, I have carefully considered this.
> (I didn't include this in v1. You can see it in the 'Changes')
>
> Previously, struct map_benchmark is defined in map_benchmark.h. The
> header file in include/linux/ generally does not guarantee stable uABI.
> (Although it does get used in userspace, I thought that's because we
> include the kernel header in userspace.Referencing kernel headers in
> userspace programs is inherently risky)
>
> This patch moves map_benchmark.h from include/linux to include/uapi
> /linux. I think maybe it's reasonable to restore that here...
>
> I'm sure you have more experience in this area, and if you still insist
> on separation, I will prepare v5 based on merged version.

Please treat the hotfix as a true hotfix, meaning it should contain only th=
e
fix=E2=80=94nothing else. We must ensure that each patch does exactly one j=
ob.

The hotfix should include a Fixes: tag and be Cc: stable so it can be
backported to stable kernel releases.

Thanks
Barry

