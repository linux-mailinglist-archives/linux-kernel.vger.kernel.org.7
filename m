Return-Path: <linux-kernel+bounces-757039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3576B1BCD7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 00:53:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 840B13AE320
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 22:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82D2829B23F;
	Tue,  5 Aug 2025 22:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EZIXLcPs"
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5C129B206
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 22:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754434405; cv=none; b=ueF7AUQPBkQNxSYSYISKA9rvAnTa9vBKc0WMEdvkOOGrnxDQM+bgwRL3D3WPi5zjTbv5IJ5b3H/hudII74cC+pEITCs8FeMD59r8cikwhjF4+9ejDYn5EwFIEkHrDpJmfZDTCqav44pFVvK2stnaklGAJMX3A4gR4007r2hjYnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754434405; c=relaxed/simple;
	bh=hs+keelF6LjAXHQjXmPYefdmvCIfEKA3k7KvHBMdfoY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cngKsTLoDc3K7ZU1+06OLlLjht8nNAR3WDD7fnVPn6u6xXfBTPo1ASxkBrV4TWUlpA9fTSSs3bCw3HfhmldqZkPqm+Gyqb1vbSHteoRTHrFSH0kOkdHilaK1N0IZDaFXX/kG8+fea4BNK/MNuIJNLSLQ4dbhLN8hunSavU3ILto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EZIXLcPs; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-717b580ff2aso56444537b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 15:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754434403; x=1755039203; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZFwxA7VPMgX8JFoPPlt7yWjXlEeDLZQuyMF8h0TO11M=;
        b=EZIXLcPsvqmIsHu9GoansST5NTM0/g8+TbsaKQV+1XaDNj4n6ZCknJ0V0lIiIH+AOH
         W4d08pblfWpLGHxRu551fGoCjZSUqBe04tbnZui5V7JJMMkPO4ndxnej6jSXMigbgEZf
         u6JlAYSsDalPhtEzszpo3NFZSFlIMY1XLOANB3KN6OP3zPsfjvgLbbdJwqt5pBi+r1ZX
         Lt1WXeTgBjyEvh2hpQphteBAZ/8Ja2YxV+/VwuoG7raTE+m1FkvF3fmWLXH4qgIq27on
         gBWAUHYHivr6TWd1MYLQQX5rxmnClh6APqa7nPyZckGUS69TjGmOrVtEer5bM0HK+uax
         kg3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754434403; x=1755039203;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZFwxA7VPMgX8JFoPPlt7yWjXlEeDLZQuyMF8h0TO11M=;
        b=lrmaIhGtKOCJyXfwOofsRtwi8Wh5D/4G85rwHc7OCXv/71/bkr+d54QPZXSj5TK18O
         ELRTiGpb8OrBtHCKZuZ6D13AKyFx5BejBTOEW6wNym3QKILgZhUjWX6Sno5Y7XzoWFxH
         DB1fi8x7auAh43PYI+XsghP14tJCXkBtg3dWsDrz2ikipuQxWAVOp3kmIS49+7BKPvmY
         AOe6GLxVRWbnU57NPwoJigYllwWK+SOQA84YQWC+lfaEgaZF1ddaZoaq11gtvfsDUQYf
         3Wrj3lLcyCFotFGUvxH/3ubkMhEPVO259ym3tn68w1edHNLVa3eZsBb0FTvkEdzwCPjm
         eMLQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYu0PtXrZOr7eE9zBYNqc/syQ1xQF4aiaPIGjELiPkbXyphKWnS3VmzacbjlRJ34Zc1hYyvbKqijjpYV8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7+eeMOqMslnEIdcxUusa/6P2PWVhggeildzqeMtNFlzNAOt9X
	c3va0lywvKp6/mH4CS4hCl+be3mik8wMFAx3tbg2XfPbzohfSgiAgAYPgpOp2+eje4zJJQweqZ8
	D7SpizDkyV+gFPVkAfokb2e9Oos+iHsLoQ4spdmh0aw==
X-Gm-Gg: ASbGncsGdw5fcyU0eFnnW0JioxfUEraUZJCFWOlFrGf6HRTpz+mZLi8sOWqG5X4BS12
	ZbjIwGnjBenzANdYGXcx6V9GV5RQL5IXbdMvzGB/VQKjPcr3cBJwPJDnAaATCUzZP7I8TwH0Lxk
	8x94bIieVUiDJCxflNsP/IIrPxatgE2ZFWtUB+xDE1PrYeUl2T1PEKo0ZFbPf/ImQZBH18Tg0Yi
	2Ejew==
X-Google-Smtp-Source: AGHT+IFPQD46MAxnRPc4XD80G1FRckOzbsES2lh1jn0CLQnQJq0WjxlFx9sY5Jok9vm71L88exnNcyi2+UjLvaHGm4k=
X-Received: by 2002:a05:690c:3349:b0:71a:2961:e2c8 with SMTP id
 00721157ae682-71bc97b1c7amr12964657b3.10.1754434403162; Tue, 05 Aug 2025
 15:53:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20250724081336epcas2p38e95932ddc5c702e05a6436f05582993@epcas2p3.samsung.com>
 <20250724080854.3866566-1-sw617.shin@samsung.com> <20250724080854.3866566-3-sw617.shin@samsung.com>
 <CAPLW+4nRh9DEnkhunG68xvGdaNJswC8fN4v4uBA1Aaao_5pxfw@mail.gmail.com>
 <000a01dc05c0$9f0ab110$dd201330$@samsung.com> <18adfcd0-e955-4c3f-a68a-6a2f75ebd24d@roeck-us.net>
 <CAPLW+4kVMo68DAO0y_=m3k81Xeh4wYV9+KX3fg=5S7xwOh0O7Q@mail.gmail.com> <008501dc05da$36362600$a2a27200$@samsung.com>
In-Reply-To: <008501dc05da$36362600$a2a27200$@samsung.com>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Tue, 5 Aug 2025 17:53:12 -0500
X-Gm-Features: Ac12FXygs7x0aZJlJlnwWjTdQedCFmhrYOQr3itTJ2SIN3Q4cTe-cGU5fCA1CyY
Message-ID: <CAPLW+4mNejXUMW0VqZW8hieNUFmDqS_-qqE=p+bV4TnwM_TWgw@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] watchdog: s3c2410_wdt: Fix max_timeout being
 calculated larger
To: sw617.shin@samsung.com
Cc: Guenter Roeck <linux@roeck-us.net>, krzk@kernel.org, alim.akhtar@samsung.com, 
	wim@linux-watchdog.org, khwan.seo@samsung.com, dongil01.park@samsung.com, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 5, 2025 at 2:26=E2=80=AFAM <sw617.shin@samsung.com> wrote:
>
> On Tuesday, August 5, 2025 at 2:03 PM Sam Protsenko <semen.protsenko@lina=
ro.org> wrote:
>
> >
> > > > +       u64 t_max =3D n_max / freq;
> > > >
> > >
> > > Make sure this compiles on 32-bit builds.
> > >
> >
> > Can you please elaborate what might be the possible problem -- just
> > curious? I admit I never though about 32-bit case when writing that cod=
e,
> > but don't see any immediate issues with that too.
> >
>
> In my opinion, it seems that Gunter Reck's explanation is correct.
> I've found out that the error of "undefined reference to '__aeabi_uldivmo=
d'" may occur when compiling new code on a 32-bit architecture.

Indeed. I was able to reproduce that behavior when building for ARM32 too.

> If you don't mind, I would like to proceed with maintaining the previous =
revision below.
> From my perspective, this approach appears to be the most reasonable solu=
tion for supporting both 32-bit and 64-bit architectures.
>
> @@ -411,8 +411,8 @@ static inline unsigned int s3c2410wdt_max_timeout(str=
uct s3c2410_wdt *wdt)
>  {
>         const unsigned long freq =3D s3c2410wdt_get_freq(wdt);
>
> -       return S3C2410_WTCNT_MAXCNT / (freq / (S3C2410_WTCON_PRESCALE_MAX=
 + 1)
> -                                      / S3C2410_WTCON_MAXDIV);
> +       return S3C2410_WTCNT_MAXCNT / DIV_ROUND_UP(freq,
> +               (S3C2410_WTCON_PRESCALE_MAX + 1) * S3C2410_WTCON_MAXDIV);
>  }
>

I don't mind, although it's quite easy to fix the code I suggested by
replacing this line:

    u64 t_max =3D n_max / freq;

with this one:

    u64 t_max =3D div64_ul(n_max, freq);

from <math64.h>, as Guenter suggested. But I'm totally fine with your
implementation as well.

