Return-Path: <linux-kernel+bounces-886524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4324C35D1B
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 14:25:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B015462057D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 13:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52E7431DD96;
	Wed,  5 Nov 2025 13:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="H5aM/14D"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135E231C56A
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 13:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762349107; cv=none; b=j1IFKNPtOIcGn4YusC3KaOCA7teYuJya/5w53kbqnurocJ9ThhV0Mlbx65YlwhT3J5yKJ1gw/cZ8HJqO5Hic2580mdaPOU/ksPPtbnpndjC/JNkaO+1jr73TAEkR4+07az60fd1UW1aTqa0+bmSaWN58ZhF4fMfwafsMFw6dW1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762349107; c=relaxed/simple;
	bh=TrSa4ghZQKzIuSKDGuaDiLF4L2HFeJmSO5cfB35UcUY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fvWzHCzK1sioUcPDW4F0HHiLJHoD5w+N3J7QGl6DLxNLQl8OtLbdo62Cyi9pZibbsxbXF/PW+rCHkkOJ6thcI/po5Wph5agtL6GRgrmJb5RYGM1ApbMuYjWIowjIp4JrmQNhgT2wR2vgqkikE13M4E5FZJa0ARBuRkm9P8HpI4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=H5aM/14D; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-59052926cf9so7293681e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 05:25:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1762349104; x=1762953904; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TrSa4ghZQKzIuSKDGuaDiLF4L2HFeJmSO5cfB35UcUY=;
        b=H5aM/14DDS2y2yasv44lvw7tjSSWgOIZHByPwh7LtVvMeAdcXuzL4MXWYO1gwVDhJl
         WW1Kzm+/xwtpOkYFksTd15StQ67V4L3qwgm/U7B6EEtt75fSr2g6Hc5yUOZHBE5qe/f5
         x6JPMQ8GjS0F/ogyQh2Hy5n7Pk+HuiMPHnKga1Tf17xcnyQiifPGxTWRJr5Tdot3XDKg
         fjgB3Ox9H+EOfGOFwDzrr4wudlI1ppPqeZxeL6jqEKrzuGN92b61UmONrukX4m3xUNKo
         Xw7bvkrwsBGyARIqGtmAHk5vfWCPmmurJW+AkbOCexCPdxHecU7n7mQijCqjEDkM/UYj
         DeGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762349104; x=1762953904;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TrSa4ghZQKzIuSKDGuaDiLF4L2HFeJmSO5cfB35UcUY=;
        b=b1i+YrdvlOVZzAnJMOpsBfEIDqKLDwVegMSO8MJLPconYiTCbnLXJ3ZLPcKc5SaWWI
         OwBZ+CAK1BmThPddNxTpWPJNH2JHEtv6qk3Z/3O0roGTXjqSA36g49lU32ynqkcK8bh+
         k2qd6nUpj/pMdn/FXb3gi0NW07T9D6X/cVWMGW3f717ynGY/CmcgZcS18EGiimBbRGuV
         Uxo3uc1YKyqRnMNuqOkVMx2yDaDREDBkVna89Lp67YvzflYLmwmEE8/Dxe51KGuGjdA+
         r3o6XSYU1B7wOinGeRe7jj4eduIENSm/JPLKXqlJCT6zuCtc1EXMBv86dgbjBYq5syiR
         fiAw==
X-Forwarded-Encrypted: i=1; AJvYcCVzuVXfaCyzJ+VE90YqQGMvJ6zB+3qyZXNS1gDPc4nEms4iuTEOY8Sd2xFLV+LKTQWo37Du6+vVlVQ3zFg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwW4d3L8Wp9rarvyKwyLXuw762gH09EvRjy8bGIO8v/maiBPSEV
	R96qrjdNFAMDR/vFwt5exMIKpuUONSnApV46JJ96nFv4UDhIseFaHUpNSdTEQ+kVIAoPY5goW9K
	D8XKEvUKhItSDn/fTvd0N9CJgjL+b+DivsJbEvflXTA==
X-Gm-Gg: ASbGncuYxaMZyq6ceeKOLLSaxPBqjJarGP4z00SuvWUi05vqmTXz43ItFnfls6PQkFV
	2jTRRXQ3t+LqMHZOOhQXsDP5HpYnVqM4/qirQLZZCjs1Q4qamsaTKtETIRMAnZ+GGJQAZmpKUB9
	qLIu80PIzUqgH1Y2ilcM3MXj4ez0Zw7bIqqr0OuZ9Hf1YIj4vL4wHQt+oAw3CpWYyxmavY3t1Gc
	h+yHWWmHFUtV/g16H5kNK5hxgnf7I/kpmX0un4xqON5BoqVBeAfBT8bslxque4KYLB02Tc1XJxV
	IpWF36UQUl+cQXTr
X-Google-Smtp-Source: AGHT+IGm329bASqpQbGMOOPH57UpX4cZo4K9TUQscnkpdCvPtrdbzBWsruITlGGdHpntoOIdxoHEKnC7zRfEUlIFYrc=
X-Received: by 2002:a05:6512:61a1:b0:563:2efc:dea7 with SMTP id
 2adb3069b0e04-5943d7c9126mr1161326e87.34.1762349104205; Wed, 05 Nov 2025
 05:25:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251105103607.393353-1-jelonek.jonas@gmail.com>
 <20251105103607.393353-3-jelonek.jonas@gmail.com> <CAMRc=MdQLN5s+MpkLUF2Ggc4vYo30zOXrA=8qkGmXvu7N3JjeA@mail.gmail.com>
 <12efb5b2-058e-4a9c-a45d-4b1b0ee350e7@gmail.com>
In-Reply-To: <12efb5b2-058e-4a9c-a45d-4b1b0ee350e7@gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 5 Nov 2025 14:24:52 +0100
X-Gm-Features: AWmQ_blr-G19bOwpzIuYCmZgKOMhVIdGSCKsTqCX17CAXGfOa6NJEbc7vw0NKFQ
Message-ID: <CAMRc=MehBmd+-z5PRQ04UTWVFYzn7U4=32kyvDCf4ZQ4iTqXhw@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] gpio: add gpio-line-mux driver
To: Jonas Jelonek <jelonek.jonas@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Peter Rosin <peda@axentia.se>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, linux-gpio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Thomas Richard <thomas.richard@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 5, 2025 at 2:23=E2=80=AFPM Jonas Jelonek <jelonek.jonas@gmail.c=
om> wrote:
>
> Hi Bartosz,
>
> On 05.11.25 14:15, Bartosz Golaszewski wrote:
> > Hi Jonas!
> >
> > This looks good, I'm ready to queue it but I'm afraid the consumer
> > label "shared" will logically conflict with the work I'm doing on the
> > shared GPIO support[1] as the shared GPIOs will appear as proxy
> > devices containing the name "shared". Do you see any problem with
> > changing the label to "gpio-mux"? I can even change it myself when
> > applying.
>
> Another name is fine for me if it conflicts with your work, as long as th=
e name is obvious
> enough. Not sure about "gpio-mux" though. Maybe "muxed-gpio"?. Just let m=
e know
> what you think and if I should adjust it or you do.

Yes, "muxed-gpio" is good. I can change it myself when applying.

Bartosz

