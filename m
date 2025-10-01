Return-Path: <linux-kernel+bounces-839021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 15596BB0A7B
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 16:12:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B33294E2BFC
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 14:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0921A3019D1;
	Wed,  1 Oct 2025 14:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="QKukphD1"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE40512C544
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 14:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759327930; cv=none; b=Byg2j6GFfxEeRKmHG8hEcUJgd6z5gVGSLC90gKYLwI0bdC6r7nzHnNq6gdPgOYDp8JuORptJfx1i3bAJ0DrW3zpl20/5lhb/e5zlUlcLFQr10emVHSs0BoZ79r/y2XKbiYMSuXMZx0Bjpag01Yhiz7bQn6AQ2zUq985adcdFcRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759327930; c=relaxed/simple;
	bh=wFyFhTbS6MYQfUcIRKicbUEZvplEsfeplnap1waRaQM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T7MUkCvdIo9qqZsXlHluSTVCEwRyEoTBfAyCK1e+Yriz9GiGl72tISI42CYvdKtEjsCwtSXJ9740iB8Q+8Fh2r1VT5rXc9032b4chmXNuHD0HL0fEMaoOK5+rMLy0epnbbi4Cclo9hcX1vo80XDH0OjWFFgy4yAxtgWdOIdt2RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=QKukphD1; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-57e8e67aa3eso1453211e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 07:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1759327927; x=1759932727; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UIO3uPK5ZuAhIy7LIVCZMJNgvs3A+QGnfF2bur8/4Gc=;
        b=QKukphD1C0MmR65Sf1btFq2nxvCf5myywiLKOGkgeF5yEM0HQkJTKryNtVZ7guQlAm
         qG67HzpXXjKX5bMAYCVySzkKPjfUqbDlLMrzrcosQkkAbHDeX91owOcEO2cfEFPdb7NI
         YHANQMA10jJMt976OuISBzrJPwIJe4DKAU8XRsbarjUbyyYBxN1aQjp4/UJe4BhmIAZb
         W377KcePmoPfx4KMjflxc0a+aCOln4YsYjReOjjm13dlZbAAK4MHLe+HeSAwkZSAwaEr
         +5oAp23oJV8GW7wPqdNLlRij13YxHRgQDHoDdgFors1FQ2SyAApucZeX568M8WPZXCEx
         e2nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759327927; x=1759932727;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UIO3uPK5ZuAhIy7LIVCZMJNgvs3A+QGnfF2bur8/4Gc=;
        b=jqOYDLxpP8MEpHjme5qozwLl1F45uDsRWLCQWf0sEV4sTrZ2EDmdSuTZYLmTPP2/u1
         BLiiMZCGKMa92SMPJjY6SI2PtbLuQS7n/grYvmwSnrEWJinYIZrsRFwKfk9KOjwhbxfr
         If/1S62g2FZHsqHKca0qTa2BSM58OMqjedRdA4CnjQDveBV8Tw6gdhlG1oTG+kjVVaRv
         ALgV/tDmeMbnN9BzNFPfLqFXId63eQZDvWu4elbnbs1yS3XU7XKdMUEo6VSEVqyVJpPY
         2jiZfe3s+mWbc13Xq8+4A6uJwYuDRXnKhEZGR8ZvuJJzvk5oW09kJqZwRC0OgzojLlk9
         t58Q==
X-Forwarded-Encrypted: i=1; AJvYcCUgFayXuSyr/bMQdpVzkeOPgleoceR1deHmLCq73B94SHTVJRX5oT3gzd5neGpQn4UxHrCpr92Eo42mRFE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzP1jfSy7Jh9R9Y4sEUT9XuGhBFv4pxYTTOzPPME9kIELm2hnHf
	eyO8v9wX+M+alMSpuq/xfLA12TABqhgqxIZw+aiPhiUNdnejtAIdwFXbXK8BEzhk5qhLEmxrksN
	aK4bbxfnjPFoaXpPGzwXho5pW+p48WjBdz2ZngZ4qew==
X-Gm-Gg: ASbGncvdnwM5FHcuWfMtuLBnk6vTlPCxywgQr27Kem1AliHOXibRYUEZKK5N2hZwYHV
	Stx5lzUnQcqMbsjZ/17vXmk+9qd/uKYBEvgDEOlTtzGEmeUg6A5By6cJQyVyGSFhqKqe/8m1pHN
	UYPHnzpCKSTFFLSDC4qQKznKIplX410iNETyYfdKpSch0Ax8x3JHmXGHiW2B7cuJ00HySlPTGNj
	LtexVw/9+DEaWGA3M+RlW6aQmyd4KMPL460HL0xwHuX/cHELDjuEmb3Oyspa/4=
X-Google-Smtp-Source: AGHT+IGYKyPwOjoJA/hN/vRW2SG6PgxLO9/q7FFW4TMg9Moy1/qo7wnwhOI+IYoqfFAAWCFgOdsUybjzG2hZKPloTzo=
X-Received: by 2002:a05:651c:b2a:b0:36b:2fab:fa6f with SMTP id
 38308e7fff4ca-372fa205bc5mr26251721fa.3.1759327926662; Wed, 01 Oct 2025
 07:12:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251001091006.4003841-1-viken.dadhaniya@oss.qualcomm.com>
 <20251001091006.4003841-6-viken.dadhaniya@oss.qualcomm.com>
 <CAMRc=MfMO-+SSrTY-XQLtsDnxpj_E3TdTJ43ZxCUi-iDrvnc2w@mail.gmail.com> <20251001-fascinating-orange-skunk-7545f3-mkl@pengutronix.de>
In-Reply-To: <20251001-fascinating-orange-skunk-7545f3-mkl@pengutronix.de>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 1 Oct 2025 16:11:55 +0200
X-Gm-Features: AS18NWBg8ZyVBRpzM7I__xJ4toRDqBMebQLTblgXUJ2wZSl8Fd91gvWOuz_1g1A
Message-ID: <CAMRc=MfhyX+5hTz2BqSuBaZbbtayJWzR75EQeniPv6KCOSaWUA@mail.gmail.com>
Subject: Re: [PATCH v6 5/6] can: mcp251xfd: add gpio functionality
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>, mani@kernel.org, 
	thomas.kopp@microchip.com, mailhol.vincent@wanadoo.fr, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, linus.walleij@linaro.org, 
	linux-can@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mukesh.savaliya@oss.qualcomm.com, 
	anup.kulkarni@oss.qualcomm.com, 
	Gregor Herburger <gregor.herburger@ew.tq-group.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 1, 2025 at 3:59=E2=80=AFPM Marc Kleine-Budde <mkl@pengutronix.d=
e> wrote:
>
> On 01.10.2025 15:52:56, Bartosz Golaszewski wrote:
> > On Wed, Oct 1, 2025 at 11:10=E2=80=AFAM Viken Dadhaniya
> > <viken.dadhaniya@oss.qualcomm.com> wrote:
> > > +
> > > +       if (!device_property_present(&priv->spi->dev, "gpio-controlle=
r"))
> > > +               return 0;
> > > +
> >
> > Hi! I didn't notice this before you're returning 0 here, meaning the
> > device will be attached to the driver even though it doesn't do
> > anything. It would make more sense to return -ENODEV.
>
> I consider the GPIO functionality of the mcp251xfd CAN controllers
> optional. So if the DT doesn't contain gpio-controller, continue without
> GPIO functionality.
>

Ah, sorry, I thought this was the driver's probe() callback. It's
actually just a function. This could probably be registered as an
auxiliary device for less build-time dependencies but whatever.
Nevermind my last comment.

Bart

