Return-Path: <linux-kernel+bounces-848752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1623BCE7F6
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 22:37:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59581542C35
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 20:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12ADA259CB9;
	Fri, 10 Oct 2025 20:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rm8s3l5Y"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F711DDC33
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 20:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760128615; cv=none; b=qYCjDioWgiouvPgN9z3+tBfZxDkM4trlNom3woFL9bMRfzY5Gf8uyTOK4XvpBa51do4zq0pptbnD4ubd9JHWdyL5sTZYhuQw6EJs4+RQJ2q7wp8Ntw84SMT774qeFRUv1XsWV687+o74RE4C17sbtB2fmGYz7G1Vba7z8KwZcaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760128615; c=relaxed/simple;
	bh=Emo7hhyobRfducLrcbdgGE5EzoH+3R3fQ3ddbvBlCu0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V6yw/P8vwQaZhhiJaoAtuQK0HGgDXZzj9zcWYRpV38pEjBIE4MZ5kcOxY4+FhkaajOmmkEJ7/+84K0kdDSDVeQyV01ydSFy9F2HRhXso2flbVZ+XakAV8iyawio9MBY+2rLYtg0+SKmPwufswpMH0paHB1mrV13IS9H9LUBU0cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rm8s3l5Y; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b67684e2904so1186380a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 13:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760128613; x=1760733413; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=z342sgXhiD/O8A715zP2egB65IpjdIWZS6PWIEJhgKI=;
        b=Rm8s3l5Y9ymJS5f9tPpiIQZB0fH47+5z/y/3qFVEU2HwpqmuiN5+JWVBGER64fol/k
         UQu5gTrmnIDOGQH8qL9Y+AYym6bkIepg2XiADGeHjEvUO4qdOxrB256Bhvty6HP7XqSL
         PdFN+Np6FbHnOIaAJa7pYb/9ouErxom+1yKRmoA0bjpQicC7l6t71j+sSeD36NW14d8L
         vHWO0Y6tZb+mVZzSt+4UD05EaROcaMXKdKXPw2jGAn5Rl8OvcJ+xbkUC9RwXZOdfUAeH
         BT3LFyYADKwGLw46TpCRK/w+ABf3v5C5cGTcrcLvcLAGUwx5zRD7ZbpSaQP/q/a1GeUg
         R8UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760128613; x=1760733413;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z342sgXhiD/O8A715zP2egB65IpjdIWZS6PWIEJhgKI=;
        b=U9R0JNC8ppd17uDvnzI0GxCP6RtoXLOLI9ZWakbhkBcjin5p4kVFcHZXssBsdUm6GT
         nBTOjKm/6dOgvQ89Rc0sjYKMJdjGi5pxGJEIsnCEpwrIne5aCZuqxTIj2f7yGsijg36A
         MyoWthTp4U0y40d1ZFEkDZzH146qyhuiJNA6MzSXJXYzoDzZRMU8eD8/OXB/7yNYN+16
         FkSF0mYr6Vxf7QQpGdzVTmVT+fpCyLRPWqmBwhZmnEh4izAjwMuVfYU5kvuR6/39dA+G
         ZxHVlx0bZSLqyOxdR84tg/IphH43a95u77A6u8hk+nVC7nqG0l2Y5a1etLSyDvXmUMTa
         QwFw==
X-Forwarded-Encrypted: i=1; AJvYcCUHsMAHDkrqekavr5d9nNXe1SotdCbAjFAkHm+upn5CzCD9y2gB89RzJDIIyy4vjJ8gp6D6/24EdwTby9w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcI4xcNZpwvWKVY8aPtpvcGZykf3CUPJjW5dWXktNH/gMt3JJF
	hAd7hVtEqvOPM+b0tW037cRDc7/4IpIoJmR5TY4uPOxk9/+hi3rlluAt
X-Gm-Gg: ASbGncv6aZvYGJ80ahw03Sk6RBFEaUGsOjMp80nqv7ak4r9w7ujEwD9tjtdv+6tguOv
	M0/R9QlhOgUyZJ+6F2uGTixNloTajlG0qJi8Z40zvK4dFfLY1IVdLxzctVJ9rcTs2ZHF10l2/8P
	p366E5JMe1PMaot+ObrcZXX7KjSIvnqPJRW2pHgPV9KgeKQA3rq3/8QwT996WHZYlV9Jh42hTNu
	gwr08yT6Wj2J/up1Up/Qp4uQZYbzB91kBTUr6jMBV27//+Q1JuGrLIOQNLJO+MYTNYE4I8bfBFF
	41BxcQoFx8RCdbYO2ezqVI8zvpqir5ECfqUcVIY3GNacbk7rMvaxLRrtRvf6Rc4PQNJPsWefuJ9
	3yXA4xcM8jBVMdhgD4iOoXFFEhY45swTKZkZ+bNGAiJjrMyCtFA==
X-Google-Smtp-Source: AGHT+IH9jJP+gVV3DYzKpzglB7kWoF3neWRRoVNVj3O59IVhAsyeWrtkFm3S3KlF9BP78LUiXGfghg==
X-Received: by 2002:a17:902:e952:b0:262:4878:9dff with SMTP id d9443c01a7336-290273567a8mr166430805ad.12.1760128613169;
        Fri, 10 Oct 2025 13:36:53 -0700 (PDT)
Received: from localhost ([2804:30c:b65:6a00:ceaa:2ed0:e81e:8f51])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-29034f99fbfsm65398065ad.128.2025.10.10.13.36.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 13:36:52 -0700 (PDT)
Date: Fri, 10 Oct 2025 17:37:52 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
	jic23@kernel.org, kernel test robot <lkp@intel.com>,
	Trevor Gamblin <tgamblin@baylibre.com>,
	Axel Haslam <ahaslam@baylibre.com>, dlechner@baylibre.com
Subject: Re: [PATCH] pwm: Declare waveform stubs for when PWM is not reachable
Message-ID: <aOluoP01oaDzaseV@debian-BULLSEYE-live-builder-AMD64>
References: <1ac0fc529e02744aacfcb9140ed597ff60886f39.1759873890.git.marcelo.schmitt@analog.com>
 <6v4hny7hxjsdf6zvinhpagtbhluxbd6psq7wpx5ls6zdbnjtym@lnygnkav4ewk>
 <2e82eaf275b5c8df768c8b842167c3562991e50c.camel@gmail.com>
 <aOlYDyLzVGbCh5mE@debian-BULLSEYE-live-builder-AMD64>
 <04eb5b1ccc0268ff7e9b88835203771886c5ee25.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <04eb5b1ccc0268ff7e9b88835203771886c5ee25.camel@gmail.com>

...
> > > 
> > > I did not tested but I also wonder if 'imply SPI_OFFLOAD_TRIGGER_PWM' is not
> > > similar to the above.
> > 
> > It works, and I'll update the IIO patch to have
> > 	select SPI_OFFLOAD
> > 	imply PWM
> > 	imply SPI_OFFLOAD_TRIGGER_PWM
> > in Kconfig. The PWM imply is because I think SPI offload support meets the 
> > "highly desirable feature" criterion mentioned by kbuild doc [1].
> 
> With imply we then need to take care either using stubs (which seems not to be an
> option) or with preprocessor conditions in your driver. As discussed in the other
> thread I would just select SPI_OFFLOAD. Basically I would:
> 
> 	select SPI_OFFLOAD
> 	select SPI_OFFLOAD_TRIGGER_PWM
> 	depends on PWM

Yeah, depending on PWM is what I was trying to avoid because the ADC can be used
without PWM. Doing the above is the easiest solution - depend on everything,
select everything. Though, I guess I'm technically not keeping backwards
compatibility if I add a new dependency to the driver.

IIO_BUFFER_DMA and IIO_BUFFER_DMAENGINE are part of IIO subsystem so okay to
select them? Otherwise, yeah, they should be optional too (would either imply
them or select if SPI_OFFLOAD).

I'm currently leaning towards
 	imply PWM
 	imply SPI_OFFLOAD_TRIGGER_PWM //(SPI_OFFLOAD_TRIGGER_PWM depends on SPI_OFFLOAD)
but not really sure.

It's sort of a feature bundle we want to enable to provide SPI offloading.

if SPI_OFFLOAD && PWM
	select SPI_OFFLOAD_TRIGGER_PWM
	select IIO_BUFFER_DMA
	select IIO_BUFFER_DMAENGINE

we can have
	imply IIO_BUFFER_DMA
	imply IIO_BUFFER_DMAENGINE
 	imply PWM
 	imply SPI_OFFLOAD_TRIGGER_PWM

but we could then have IIO_BUFFER_DMA=y and PWM=n and still be unable to SPI offload?

Maybe
	imply IIO_BUFFER_DMA if (SPI_OFFLOAD && PWM)
	imply IIO_BUFFER_DMAENGINE if (SPI_OFFLOAD && PWM)
 	imply PWM
 	imply SPI_OFFLOAD_TRIGGER_PWM if (SPI_OFFLOAD && PWM)
?

Forgot to add David to CC list on previous reply so doing it now.

> 
> - Nuno Sá
> 	
> > 
> > [1]:
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/kbuild/kconfig-language.rst?h=v6.17#n197
> > 
> > One alternative to this patch is to have `#if IS_REACHABLE(CONFIG_PWM)` in the
> > ADC driver as David suggested in the other thread. I'll probably do that and
> > drop the changes to PWM.
> > 
> > I first thought of using `#ifdef CONFIG_PWM`, but couldn't convince myself about
> > that from the relatively small number of ifdef use-cases in IIO.
> > 
> > Thanks,
> > Marcelo
> > 
> > > 
> > > - Nuno Sá
> > > 
> > > > Best regards
> > > > Uwe

