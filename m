Return-Path: <linux-kernel+bounces-709518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1390AEDEED
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jun 2025 15:25:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F0B93A3F15
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jun 2025 13:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 555F827F001;
	Mon, 30 Jun 2025 13:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="ZQTv4zdI"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057752701DF
	for <linux-kernel@vger.kernel.org>; Mon, 30 Jun 2025 13:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751289694; cv=none; b=U1eA9QfAGwBmYueQtKvDs4SdjSK481zGWusE1xwM2cF3+GR9ccg/qojWE49HzGgOFvd+abCsw6nhyoP0hL3SX90HXYuIv3xWuIwyEyxKWVupqeYzsWDKyCbGYGe7H/7XBrOmdbAl5va9NeZSHg5Hw2OYOu+f+8d0Iq0EdI9mgvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751289694; c=relaxed/simple;
	bh=wYSk7fxInjdJNOHqBT3fau/40lgp1kFco8w401sE950=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GzoL6uRAyEa9h5Q/XPaDoI7mQKgwjrzk0pFyqy+yKYwx2whpxgqZW3iyKtYgdbntYig8s2/3+ANAN8dGn2ekBvELrknizcF7y4ye5orclJGYUkrSWR9oXwGmA0xJyu7Ew5WtyB6eAzayWemr1wzxov5W50GGyRnMHthhYn61W+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=ZQTv4zdI; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ae35f36da9dso441003766b.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jun 2025 06:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1751289691; x=1751894491; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2I8CsrHjtRtD5BaYjtdOSFNgRck9IxhroTpwRBGBREc=;
        b=ZQTv4zdIh7dZ1Lg/rGgUPmWqnPT5GKG51d2hj3rr+Iar5/ZdgH8ostY0HGD9nH98oF
         eLRWZgiyAITEb6Z/oyXegjB/VS4cCK9L3P7t7+tyEjFsfjg/dygDensV6bQF1hvoGx5c
         d5gRhGF+PhBCLXbX2rAInJUHXRKouIPD2NBcwh2jGNn8Ih3bqVNq0Kam+RtqQB4QBVAC
         Ngn7WKq6Tz+uOwudmI+78VjSWRXZYyztWpu1dVtyMw7dWEIFzV0AgVniYKzRoxHVCH97
         SFmR0ZISn2FInckrd0R5ptTd95F6m1/KV+sUy6BAideGWb3nEgqWSKIFtN8pT9Jhp1zB
         9CwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751289691; x=1751894491;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2I8CsrHjtRtD5BaYjtdOSFNgRck9IxhroTpwRBGBREc=;
        b=pgLWWK4LLGU6V260pzVnQLsN52kVYd6MJbJ9O70qs4TjNCGQ2sl+TDMVx0wjVOZgEQ
         aYpa9r8JSK6/3VXkJx4TuAZr0OozYhh9sl7rX0OCXsZWhSai5HAiGsVIYGXPMRQZYQG3
         l8P8pdG//Pdpbbs7Hk4g9D2N4CJk/+oKWhsaj6N/hwmjU6YbgAQG8ZYDSmo7wfn6bUX1
         OsyE1soG+hjBV8G3yd/MD95leUHdOUbCbtN5E8Vxu8fnm4SVUviU+YcWxwM16/hnEemJ
         02FGcIS946buH37vNgiuD5juv884iW6V6PBgIv7ZzduNO3oADUPJSu2FpV+vS1FGpwAw
         eLlg==
X-Forwarded-Encrypted: i=1; AJvYcCUxxcgn0l+2G9H7vt8ggi3luljmkW+eRJ5RPYS5kpm0kLv19SElOuFtU9iDJqcY6vMUKmfR5sJGd6Ef+LI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkcnsTwhltffex9Q/qcAIPP8+5SEb1jCFYmHMPRmYwi18Z+9dK
	nOdiBdS7QIN6Zlw5vW4/tyX+3IjuG0lzU/G2VbwAyaYa6+8WwROmTfpJT57gkWaUwZcRVBmGh7b
	oYtxVx4ipnD0KSJU6m4aGodZJ4/HlVoAsp+zDdkvykQ==
X-Gm-Gg: ASbGncsSXZbPvnFBb5p2RjJmPSLcsoivI+mocudbm0Ws0s0PBOKT2VHWlxMCXfkB6we
	VTl+X0GU7lP3pP/9oYTnoGQh73a7nmc8cdjI6i8E5BOjZhkSd0YOIunrTIFsJ3XgFFRLRm3kNvl
	PoTc3lMlFaHX7KWhumEbLYl0LsAZqiMRHgHZQUcPxSDHLxAUsxaTYb
X-Google-Smtp-Source: AGHT+IExvta/iWzBmIlIztBuCgl2cUU6u80HBaLHyHvJJXhxVNxMY8nK4KaXwhnRKNkDAhQ4ZeG0igRs73XqWwJLjCE=
X-Received: by 2002:a17:906:df08:b0:ae0:a88e:6f20 with SMTP id
 a640c23a62f3a-ae34fd88f8cmr778815366b.15.1751289691157; Mon, 30 Jun 2025
 06:21:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250613114148.1943267-1-robert.marko@sartura.hr> <3ba837f8-70bb-4b9e-a9f9-0e71b9e073c4@app.fastmail.com>
In-Reply-To: <3ba837f8-70bb-4b9e-a9f9-0e71b9e073c4@app.fastmail.com>
From: Robert Marko <robert.marko@sartura.hr>
Date: Mon, 30 Jun 2025 15:21:19 +0200
X-Gm-Features: Ac12FXxhA2Gp9rwQDhKKgV4ARb8lKQ6I8YMqCzExRny5q7pcafJNPwE_zl3e6I4
Message-ID: <CA+HBbNFd5hCKqUZY25Sws-o-0QALLue-JROyze_9biyuZZv4mg@mail.gmail.com>
Subject: Re: [PATCH v7 0/6] arm64: lan969x: Add support for Microchip LAN969x SoC
To: Arnd Bergmann <arnd@arndb.de>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Olivia Mackall <olivia@selenic.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	"David S . Miller" <davem@davemloft.net>, Vinod Koul <vkoul@kernel.org>, 
	Andi Shyti <andi.shyti@kernel.org>, Mark Brown <broonie@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-crypto@vger.kernel.org, dmaengine@vger.kernel.org, 
	linux-i2c@vger.kernel.org, linux-spi@vger.kernel.org, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, ore@pengutronix.de, luka.perkov@sartura.hr, 
	Daniel Machon <daniel.machon@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 16, 2025 at 8:34=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wrote=
:
>
> On Fri, Jun 13, 2025, at 13:39, Robert Marko wrote:
> > This patch series adds basic support for Microchip LAN969x SoC.
> >
> > It introduces the SoC ARCH symbol itself and allows basic peripheral
> > drivers that are currently marked only for AT91 to be also selected for
> > LAN969x.
> >
> > DTS and further driver will be added in follow-up series.
> >
> > Robert Marko (6):
> >   arm64: lan969x: Add support for Microchip LAN969x SoC
> >   spi: atmel: make it selectable for ARCH_LAN969X
> >   i2c: at91: make it selectable for ARCH_LAN969X
> >   dma: xdmac: make it selectable for ARCH_LAN969X
> >   char: hw_random: atmel: make it selectable for ARCH_LAN969X
> >   crypto: atmel-aes: make it selectable for ARCH_LAN969X
>
> If the drivers on ARCH_LAN969X are largely shared with those on
> ARCH_AT91, should they perhaps depend on a common symbol?
>
> That could be either the existing ARCH_AT91 as we do with LAN966,
> or perhaps ARCH_MICROCHIP, which is already used for riscv/polarfire.

Hi Arnd, I thought about this, but I am not sure whether its worth it
since we need
LAN969x arch anyway for other drivers that currently depend on LAN966x
or SparX-5
but will be extended for LAN969x (I have this already queued locally
but need this to
land first).

I hope this makes sense

Regards,
Robert
>
>     Arnd



--=20
Robert Marko
Staff Embedded Linux Engineer
Sartura d.d.
Lendavska ulica 16a
10000 Zagreb, Croatia
Email: robert.marko@sartura.hr
Web: www.sartura.hr

