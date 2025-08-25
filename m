Return-Path: <linux-kernel+bounces-784718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3399EB34041
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 15:01:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5345C7AB2EA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 13:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C03AA1E0E08;
	Mon, 25 Aug 2025 13:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="mDLyigWd"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0573B1E0DE3
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 13:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756126885; cv=none; b=YfnQ/H8Hj3m95rLLIGsJIZLoEkiCq75jNuC9ktbJRV/kkKYp4GGpiaaCJDp4fVPcVlkvvNM2YxHU7gGKJ7Jpyn284/DLg6I+M+vWzg/KKVgtwRYJW2wbCzk+2f8iim94c2mON+/Q5SSey/4BwFQ2BhRr7bgBDWklyvumZx4PI08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756126885; c=relaxed/simple;
	bh=dQlK3wXG7sop1i8Jgraua6l3U7jzqZIBJa/jEdUPy4M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QRZgdxzf/SmOlIHVZi51RPo6M6BTWe1Ae+l9TCTuwYPGwmroCrdRPohZKmHVUHrnivV6mDoMpWC0rgV5sC5PYnR4EYgPSOJXQVb0Uvh/kWyVZup3isCv4/rvP3Zdwdq3dZBE2WrQYyl2fzWz6h5jsg50Q0+R8MSL56lkUPs8beQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=mDLyigWd; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-55ce526627dso4371440e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 06:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1756126880; x=1756731680; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dQlK3wXG7sop1i8Jgraua6l3U7jzqZIBJa/jEdUPy4M=;
        b=mDLyigWdXswkeZt7lRAFvB3o8gZ8PtldTvaQo7OnXliJ+zpKptVJnADL2NscXTplbj
         AwpAwxFKwGRbARZLC5jQbBZpVVL49mpfGuz+QLF12U2RupYkiki0q9/OuVRecJuUcgHS
         OLIRnOq9i1lsDRgIwdzPwjHIRDyciJODikp8ycPDNoGeZJUNqEzrGjgla6a8IXxwOthB
         5Dod/RPvnBAnm1zCIiVYSGM/aLWg3smayGEh4BNDIEKkAD9sy5aqf5/oZNqL1rGb75iX
         NtdlXHOgku9IsOaLH1si+rlh7+9TRd8icLWOZBUaRdETWVsKnGIwf3yZ3z5ze51fzm0n
         j+ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756126880; x=1756731680;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dQlK3wXG7sop1i8Jgraua6l3U7jzqZIBJa/jEdUPy4M=;
        b=ghABvKQ2HODEchlJtfwD8RlwJ9rjNaUczm/To9aPLyjKIHUR0Ks2cPAO9fAe5MaKXc
         MB9Qr/wmpXasYdLqhiEHDgg2gBJv1+5xRBbyubI40rBtYAd3vDC0Bdzpl46SoP9HbyOm
         KjgAsA5KlbTlf25+8wfYA/SN06iVWwwcdkKyXgVo7T9w9/Xr08NvFnorNRS9iCths9T1
         vcUFHvLjUjFZEe75VafVRkMt6nXjDv8Dk0xcKWDMR/hDOaKsZTomW5Ab/PsBfv9z9DsS
         i/BoiaWxF+c4wiVIMC6VD28jZif1O7Ts775w1lWaUxzgAuV8le8wTo+gl+QFfx1Szwtm
         x71g==
X-Forwarded-Encrypted: i=1; AJvYcCVYFC2BjtAZMUI2puhx1K3vI6SvcQsq4c8U02PVc55D7bVBFeHpUy/LDtlzj1YB6x/St3Hht/OExySPC6Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOHREy5MBU4sU0cxBNNZMzbHzSBlQI2P4IWnEZam7bOjcDP094
	7thNkZV1M3FyZQm221d+YVT/BF0RT8OuA5/BubAmiQdSef5wzCjLK/x0bvD1YMmKG8A3s1xBpHm
	F/UFVdjdl4/dBe4TiX83ugdaqUFH+QcAPt7OnrP19g99TBtgQSKyqQAA=
X-Gm-Gg: ASbGncubvTH4YXC9lgcFJJs6uC7lZFIXezAvw0gtf1176zqERKqVh6IuHPge/SS1a/O
	MCA60UU2UBZ81Z2NJybeT3zfE5al/+QsaiZMFpLaYYDSEaunOy11gT7V/Z5XOxDzAWL2fAKbmbw
	6evL75S6oCQc3tiTSdkFxagzvLwRW9XCsAym1pQ8g19zhyuOVtSWnrBvfhzkHaazoDad9+Iy+o9
	DWZ9UTyJnoKCDWgXU38MzHCicOO1ebK3zn6wLCtLNLlZYq1sTRZ4IoUDXII
X-Google-Smtp-Source: AGHT+IH5N5gh1e2Wid0aMR0FMRyM9pyDqp/u65+mskc935zM8TPlDDSTI+H4ckU5CTPXH5byLfWl83YU1oyPWy+p/Uw=
X-Received: by 2002:a05:6512:135a:b0:55e:11ca:1549 with SMTP id
 2adb3069b0e04-55f0c6b5589mr4032238e87.19.1756126880025; Mon, 25 Aug 2025
 06:01:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1756104334.git.christophe.leroy@csgroup.eu>
 <e05a0959d794016bde79e48e25ff71253cf51aae.1756104334.git.christophe.leroy@csgroup.eu>
 <CAMRc=MfPTtdFtE63UKfbuK3h1mLEk2aUGazBsbRS-OLZzm7e9g@mail.gmail.com>
In-Reply-To: <CAMRc=MfPTtdFtE63UKfbuK3h1mLEk2aUGazBsbRS-OLZzm7e9g@mail.gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 25 Aug 2025 15:01:09 +0200
X-Gm-Features: Ac12FXwiA1VNOuENMZgX8e0TVhBXubdvgS_jWd_PUQ_1hAXM92SKRJ_pWmQYzEg
Message-ID: <CAMRc=Mcsvkt1OJfVmB2peQJPpEKqFJ=6=86m=fd+VOEoMGf8Yw@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] soc: fsl: qe: Change GPIO driver to a proper
 platform driver
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Qiang Zhao <qiang.zhao@nxp.com>, Linus Walleij <linus.walleij@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org, 
	devicetree@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 25, 2025 at 2:56=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:
>
> On Mon, Aug 25, 2025 at 8:53=E2=80=AFAM Christophe Leroy
> <christophe.leroy@csgroup.eu> wrote:
> >
> > In order to be able to add interrupts to the GPIOs, first change the
> > QE GPIO driver to the proper platform driver in order to allow
> > initialisation to be done in the right order, otherwise the GPIOs
> > get added before the interrupts are registered.
> >
> > Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> > Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> Hi! I retracted my review tag under v1 because...
>

Ah, sorry for the noise, you did that in a separate patch, please keep my R=
-b.

Bartosz

