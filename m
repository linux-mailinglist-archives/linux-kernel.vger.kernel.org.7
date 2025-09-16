Return-Path: <linux-kernel+bounces-818285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D07DB58F65
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 09:42:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FC113B3930
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 07:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 587F52E6127;
	Tue, 16 Sep 2025 07:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HSVCqfFK"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD3D2E0B60
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 07:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758008535; cv=none; b=JD7PHhmXvjCKwH6wwIOSiWrpbEl3LBVHbSZp4NOGePE3WC+aC4eNLeqSx3QsEhaXKhtTXyV+HDDc0gQeDDsKjHv31rdjFIuh77itmnTCVAZV/1Mq0DKVqzgI0elqxVTLrjEKcW1oVe+33pYskp/gZ/qOFlkeZff7HNFV6uTRFCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758008535; c=relaxed/simple;
	bh=MajtWc/LSqmypF88GEgwsqo7vwQ0+GiL2Fw7fIStbIU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cHJC2V3R1/ycBKfN8v//39TBEGpwlxy+j0kctYcsOO2FOsqautHBMojaR4vX/168ojAF6ocXVXmuRLJeOQOSq0w4v7zb6WgEDWbSLcQF3fH5qLwaRAIs4yJGwNdBJ+2HWKIxfPF7osmZHKW33Igf2z2HE5f3vRPZw8+pkAA4eus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HSVCqfFK; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b00a9989633so984112166b.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 00:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758008532; x=1758613332; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=seiaS3SE4RcxpYiplP1sTiZbmiKfUGBNakfZvP8oRTE=;
        b=HSVCqfFKUkYMNKW4S2JCKiOdRDkw5BhX6CAs1TvWI9o/8TZky1ungVKWsSiR9YXuV0
         6us8oMG43j4ynyh3hxh3IYieJ+zR+LlVV+VKb3YhWYgWC6lr89r/13/U4axt4LXFA0sU
         zF7FKZj2eLetHkIlGqN8sxWqLd8EcwdDCtYnbjeJdrAYBRmp+N0phmuvwCtf2u5k2THS
         03h6AkUxgdSHXzket1rxAn3+mHl+uqOkPltv7Ts2TszVWT9USICGq55U6p2r9eNQkAfs
         wSezk9eFhWuaoprubK55UrCMwAnnE3ADritSZRa7+4vDpbZJmfpetLav3XYr9cJYGpip
         2iiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758008532; x=1758613332;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=seiaS3SE4RcxpYiplP1sTiZbmiKfUGBNakfZvP8oRTE=;
        b=qJP17Ggf314tJWccW3RA6yv2IWK/B+cTM8G218fWyN3Iot/Komlit4pfMUy2ZITWCj
         vtmeNyZv50ywoY4jL11ykcEEFFGjLM89x0ML/sbIYFnyUgYZm7Pc5iRGWMe0yDXBhNIm
         RRZy/il86k59Rr+QMql9Vfo1Z3nOJ8PF3umtHd2JGB2f/9lvdrDSUXv1PubtUyHK1TsD
         W4UHuH1z/Rw/k9DrYhF2jNod/c+UTNMBx4cWsIuKZY0kJxjXg+TBAkzFWazzc7e9N+nG
         +wahQbqBN/kOIQVmksKx5S/dueCDPELnaiwJ0WyklwZ3McSdsqBRX3E1wCaJ2gFoa623
         dOUg==
X-Forwarded-Encrypted: i=1; AJvYcCWUzYBNqH1ESratQjvKFL4V3e9j/Z1+ebRu5aXRnpIiOWf3Ceu619xrS274rMPHj/5Hq7WA97UZ4M6BAW0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzU5ggkPSV7Lthevr6rdVnwQKe8xFZdrH5XJ/ESBKMVd4+892sF
	yXmuXxLFF31JYNQFH9h3/RvFrgzNKyCRUa/XjtPAwGUcLRsHdy2iBQqvpTgIYZrCj4mmOnzJiq/
	XSkylnLP4BpaVuu8CEDLA0szdW3Xm4S4=
X-Gm-Gg: ASbGnctG8WOPSdZ1OXQ3sntcclMcP5bRmT0dfDwKnYbBYO6A5emLe/IJ2bLA2WaZkzd
	Pr/NS0AGxqnr9rs2lJtQAp9LzRl/LwTGWQyJ194Rjfk4f1iLlZDHl8I41OLNv0wlB5Yk2FP+eu3
	HhixJ1CYzFiDFIUuTzNoly36RbtWDhCZvtn1kqRwDi8zHLdZsr/05y67TtXUeBhQ2T8ZCM7N1be
	CEf4yI=
X-Google-Smtp-Source: AGHT+IGZyHMyvgkDW6LuU35ofsRn0sZACfWWqhSLafHvGIMD3obwLIYTtrG+n/1NkzTnEp1u5/0DGgd/99ITtrLndkM=
X-Received: by 2002:a17:907:da8:b0:b07:dd5e:16be with SMTP id
 a640c23a62f3a-b167deddbdcmr160525866b.4.1758008532394; Tue, 16 Sep 2025
 00:42:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250915-bd79112-v5-0-a74e011a0560@gmail.com> <20250915-bd79112-v5-2-a74e011a0560@gmail.com>
 <aMge0jYwYCiY72Yb@smile.fi.intel.com> <20250915211321.47865d3d@jic23-huawei> <c1d21e3c-b0a3-40a5-b693-a38673f8bf53@gmail.com>
In-Reply-To: <c1d21e3c-b0a3-40a5-b693-a38673f8bf53@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 16 Sep 2025 10:41:36 +0300
X-Gm-Features: AS18NWDftmIhKHIIy4Z72h2BuNDuK9l8wDcCPAp-uHKsQZJ2aCO3R_pGAN3uBKc
Message-ID: <CAHp75VeoN3JCpLKS0LZMP4p2xTz_Vpi9Jfb_2bqxX7wHtQKb-A@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] iio: adc: Support ROHM BD79112 ADC/GPIO
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andriy.shevchenko@intel.com>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 7:52=E2=80=AFAM Matti Vaittinen
<mazziesaccount@gmail.com> wrote:
> On 15/09/2025 23:13, Jonathan Cameron wrote:
> > On Mon, 15 Sep 2025 17:12:34 +0300
> > Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> >> On Mon, Sep 15, 2025 at 10:12:43AM +0300, Matti Vaittinen wrote:

...

> >>> +   data->vref_mv =3D ret / 1000;
> >>
> >> I still think moving to _mV is the right thing to do.
> >> There is no 'mv' in the physics for Volts.
> >
> > I'm not disagreeing with this review but I'm also not going to hold a
> > driver back for that given timing is pretty much such that I merge it
> > today or it sits a cycle and this one is very near...
> > I'll get fussier on this once we have written up some guidance and may
> > well send a patch to modify existing recent cases like this one!
>
> As I replied to Andy, I am disagreeing with this. I hope we won't start
> renaming variables with capital letters :(

Why not? In a new code would be nice to have the units properly spelled out=
.

It seems we have one of the strongest disagreements between us, but I
stand on my position from the angle of the scientific point of view.

--=20
With Best Regards,
Andy Shevchenko

