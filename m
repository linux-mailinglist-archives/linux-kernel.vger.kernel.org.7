Return-Path: <linux-kernel+bounces-895511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C940C4E21C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 14:35:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01F6918857D3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 13:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 953E233AD8C;
	Tue, 11 Nov 2025 13:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TogU5/CQ"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B7A32827A
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 13:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762868112; cv=none; b=rGUEUYQ4r6xrnHjXcYcHiJ0gj200FTNxmSBl2zWudHyLciE1/z8yxCiZF5WxN1p9xunNtsb7TOqTArFVEjzr4H2/ot38am/td30rTerpkyRR/LLlVb6MJ0/y2ho1ekHD7Mc2B0q4AUy8i3vR22cu04sPmi/Bbmbt3fv1FS67QnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762868112; c=relaxed/simple;
	bh=44f+GGBR2oWTuYZdNolnAn15TPhOowpsnt5jgSu+WJ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UsVBxr/AArdTUbZaC4KLCrylUJL8gUw/2OoQbJFF53qkul8wMwFrSG2JuI00uAV5Ez5zfVD6slrrHEqifTvkpOI9ipjB/JCxkrBl26DYUxqjcusfwWcPsCIyPYpao/Pzj5hnT3D933Q6qez6HN3j+6qYdfe/yAXVNu5yljBfCjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TogU5/CQ; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-42b427cda88so712727f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 05:35:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762868109; x=1763472909; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0zh7RVlz9/fn4Pl4MaeRlvONIISFdEg92t4/EjrGZ5o=;
        b=TogU5/CQKt3gFVpr3F5BucXjKpkgWAK5iPWPCtD5c+SGKmBXceOa3pxwlp6mGeju8Z
         VkjaBrzEyP84kS/jKc630hRoTAHvWMiXg4jYqz16kjp1oLOM5JkT2u8CQ7v/zxH4u+2p
         aPmEs9BxjT8kdmgBtDULJfiojnrmsO8koRiqbMAAvnA4+7cDbHTnGqbHHsUAgtGiaCdl
         TOmlLtDue9102u3ob0RiyJckKsJ4Qa3sU6+2QtcWcjwQREn/km4n5eQVE0Fp469PIWu3
         wd83UwFhJSqpu6e3D/DqOrrLIJ+XSixoVoSdl3fj5DgYODk/FJ5/YZp10D2YBQkPqueZ
         9gYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762868109; x=1763472909;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0zh7RVlz9/fn4Pl4MaeRlvONIISFdEg92t4/EjrGZ5o=;
        b=P8yHIAaj2sVKZ5Qr2KEIzqerRO1xreLFxUJ0Hf89txseHW5MPAaFbVJ2PrztRwuIvN
         fALky7kz82TWiXLz+lMtCaRNKQdnbe4DIPGwFGRneM5L6IiZi37P4pRVEALFAp2ZQiNd
         tk5OEGfUyZucj8YyftJHJc7zn74Qu77LpjN4NGbh3rBwX+YJtFf23ZNfDiP6QAXsKWVT
         K4jH2wZTE5bWbgetcrgNEgXwyvb0U3wHHUSnMmIsZ4P2wdHLrZtLHtjQZowE8QC9jPAi
         V5BEFuMtPsrtm40Ur618f7r4J3U0pbMuuh8mui9N+3JJNvbN0NquUqYf0EEwOtCmNZlz
         Jo1A==
X-Forwarded-Encrypted: i=1; AJvYcCVjDJXuaddfrvKKOy+VC+3TJpvSpdc8wuOyr7ofuBNRezvBjCECU98CIVrsIVo8OJcONa/rxCCEHVgO05I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yya4v2fPIJEAPleQQzIbRuAaIr0YKvD2+LyYaabbbPEDufFzjf0
	ofrRV/pC1DQig8Wglboe7HEd8Gv1IhzKLDGqJtTKstPuy1LGAovv+953UGxKWQTMAeqxFsUS0bo
	yiCHRSLWHS0t7AdcDhRR6OhdSOlD2OdU=
X-Gm-Gg: ASbGncu1ur0caFfEX4EJCipLu9sfsx2EJ/6cWwKBBqdO/r7gL/UO8rZC9Ydo5WGOUBW
	jjKLJpfpyuBFlgSnL35aeD69x9EkO0vcoSn2fy9vy8VJaGjaoev5oaMaYjSPKHnK3Nf1nXzr4jA
	3j80AObY38QO5gYyUQDmWRltR9CaH5itv3wiJujET6FY2u66t4mutanO6kqjUNRmNoQQvF+zNF/
	HcA67fAwNPikqC9PO33t2WdYJrfGFNxzI93wA0boIIUrA4tlQvwg4pv711AeA==
X-Google-Smtp-Source: AGHT+IEtivyRqo5lmF9BZUpAcCnMPsflKj+Yv2TwjeYH2DfqbpxfoITaNpUO+HHZcDmnNtTIfPFQUG2YLx/3HTHTlHw=
X-Received: by 2002:a05:6000:2507:b0:429:c54d:8bd3 with SMTP id
 ffacd0b85a97d-42b2dc3ea86mr11789923f8f.53.1762868109221; Tue, 11 Nov 2025
 05:35:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250915080157.28195-1-clamor95@gmail.com> <20250915080157.28195-2-clamor95@gmail.com>
 <3455911.aeNJFYEL58@senjougahara>
In-Reply-To: <3455911.aeNJFYEL58@senjougahara>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Tue, 11 Nov 2025 15:34:57 +0200
X-Gm-Features: AWmQ_blV6d3G7hE5fg-sUlAJ4jm_DAmDeF4LDT7xiVBDSmfK9MhRSP1-jMuZj_A
Message-ID: <CAPVz0n3qXBLEVDKDDc6DRrN+WFiAdeL1wDaA94DkdST7NoRXyQ@mail.gmail.com>
Subject: Re: [PATCH v3 01/11] devfreq: tegra30-devfreq: add support for Tegra114
To: Mikko Perttunen <mperttunen@nvidia.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thierry Reding <treding@nvidia.com>, Thierry Reding <thierry.reding@gmail.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, Prashant Gaikwad <pgaikwad@nvidia.com>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Dmitry Osipenko <digetx@gmail.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, 
	Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-tegra@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=B2=D1=82, 11 =D0=BB=D0=B8=D1=81=D1=82. 2025=E2=80=AF=D1=80. =D0=BE 10:5=
5 Mikko Perttunen <mperttunen@nvidia.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Monday, September 15, 2025 5:01=E2=80=AFPM Svyatoslav Ryhel wrote:
> > Lets add Tegra114 support to activity monitor device as a preparation t=
o
> > upcoming EMC controller support.
> >
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > ---
> >  drivers/devfreq/tegra30-devfreq.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra3=
0-devfreq.c
> > index 8ea5b482bfb3..d976077d4757 100644
> > --- a/drivers/devfreq/tegra30-devfreq.c
> > +++ b/drivers/devfreq/tegra30-devfreq.c
> > @@ -980,6 +980,7 @@ static const struct tegra_devfreq_soc_data tegra30_=
soc =3D {
> >
> >  static const struct of_device_id tegra_devfreq_of_match[] =3D {
> >       { .compatible =3D "nvidia,tegra30-actmon",  .data =3D &tegra30_so=
c, },
> > +     { .compatible =3D "nvidia,tegra114-actmon", .data =3D &tegra124_s=
oc, },
> >       { .compatible =3D "nvidia,tegra124-actmon", .data =3D &tegra124_s=
oc, },
> >       { },
> >  };
> >
>
> Looking at my copy of L4T r21, the EMC count_weight should be 256 on Tegr=
a114, while it is 4*256 on Tegra124, so different SoC data should be used. =
(I haven't checked if anything else is different)
>

You are correct, tegra114 seems to use 1 EMC clock per transaction. I
will move and expand comment from tegra124 entry regarding
count_weight to include info about all 3 supported entries if you
don't mind.

I have a question regarding tegra_devfreq_device_config to be used
with tegra114. From tegratab kernel I have, existing
tegra124_device_configs configuration seems to fit tegra114, may you
confirm this? Or, if L4T r21 you use, uses different values, may you
provide those to fill up tegra_devfreq_device_config for tegra114.

> Cheers,
> Mikko
>
>

