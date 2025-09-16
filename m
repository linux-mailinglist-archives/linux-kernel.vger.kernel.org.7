Return-Path: <linux-kernel+bounces-818276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9BC2B58F3E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 09:33:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91A621BC40D8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 07:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A8AA2E7BC9;
	Tue, 16 Sep 2025 07:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IJ3cEDld"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C2B2E0935
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 07:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758008006; cv=none; b=V0ztrw4ru93bA5eAyslr7ahOYbaAsJGk4O7BytH9kCcYlreH+uQH5+ko7OXC5FNnskh0EMSDpZmoKUYXkTN8BvfORZ0KATGw0G+2UQXY2o6NC/m8frk2ke+omqFe2sfvcVRv9qVNX4cnhfPhOqHDFOc2e9b0ka6GlugAvUVIhmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758008006; c=relaxed/simple;
	bh=xCeRAMSeik3Ij+GYUSuPeX8oLZZe8/JHQM9MhsrFjbE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pYiIWAepTml7BQPoAgkKG1MLkG1l0jy0xGf1OAG9pyEzrg/IWWV7zgq5QwzqE0DFiy5nJxzyOzctJti3beb5POw0FXsxu5Y05XyomhS/yc83A5nJorFuc90dnM5/nb64Ogx0xrc2c2i8Aab2iYxjPYTtYvcEURoJvXp2n8VdLNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IJ3cEDld; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-337e5daf5f5so54412261fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 00:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758008002; x=1758612802; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KRaB0QRQ+CwkntAtDL6wAD1iaM0SOq9+/31jrQixXeE=;
        b=IJ3cEDldfEGaKcTaMUddrPQbdPf9nJwHdM5eIWA6xe9d+ifNGskeFHIzZk8v5OH2yM
         xMNmbjEv/g1qksXD487rOluL+6LDSXf3BMu8OnUGCdLqx0gs4bTaSD2Pr+iIwp6ilhpb
         Lzw8lcH9ab33xpshZANrz4lklvLM1YAz8BGyKXRxu/3/snVu1iBgHmCJRjk7SKhEDcJp
         fR9JMw2c/tpMEb2tg5RaoMGpHG3joAMHO3s2Y18wRWLc/hMdEW4Wq9EZYX+vQxYudpjT
         7EbEHm4IZXUkCDsE4GcTdqHtvVZKTff1w/o15ogr00tbck41HSpzZoDsOxT5f9w/98m3
         CFxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758008002; x=1758612802;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KRaB0QRQ+CwkntAtDL6wAD1iaM0SOq9+/31jrQixXeE=;
        b=rQeOgld891E/9aKn/yyQjrdc4LbHm0FA58bos679KWcafe8D8C3G2o4CuZok685iUg
         HcqMUo/m1Vp4gt4iFj35wbzZR+vGJ4NR+Nis/Cs7tH1SYkMdcDF9Z9wFvwqDuileYa1F
         udJpe1/RVdwOrkaxvHF8fDvVg+XrmWqvkaUiemQc/QGr1Q1BCRjcbou0LuTVgFQMyAx1
         KMqAhduSk9F7jIM/QaUy/9aJvMR+Pns9YU07ip+wpQKG40aqHZNYfSVZ6RTSr0fxakKu
         awPJ5cU7cRGJIGN6zY71CFjuaxcbLnzYQv0b2WOLrUJpnDZTHZQkKjib0nYMH37Rx33y
         Ms9Q==
X-Forwarded-Encrypted: i=1; AJvYcCXohxQ+wV0PWliTgSWvnGiaJR/Ty6DkC08NZAfrAKdBPBxaNBqq2uWaYV5/ZwMVZskMRtF7vMV5oUbzKME=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4hxaogeT9fhdv10uRwjigZZ8FbV4F1OH87/EnAScEnvurHpWP
	8V4argbDrF1VNxE/8pwGovg6D1nq9MoCeHBDTbtsEk6pcrokFzumvZSLNix9QTim70ATEIMUr6x
	K9naLnNXk8pPRWEv2k4LDIlMSxCIGEaw=
X-Gm-Gg: ASbGncs57xTc/7OxpunPOgrwojBZIxYYUJl4zRtSV4Gro0PZ0XnADhkC+APBgqc0cfo
	VJ2BzJrTV1pI9tvm5EQQidkTEL0JBUZdLtSAvhZQda5jN8eyb7Pj+cnBDv0dvTb6vKvovbNzuRj
	tuF5QkfKZLRJV1Ix65FyZ8xIv4wpB+OzjZH82ggdPNotq3Om3G7I+eq3kuNnqED243enKyeq1Qf
	xryM4M=
X-Google-Smtp-Source: AGHT+IG7pjCLsgXwD5N0VxlPDgIAlAe43EQY6konXmywpkCawCRcZViVf5KqJj0G3f36rR6VMBI3m9oWeXKQcQHVTPw=
X-Received: by 2002:a05:651c:b1e:b0:333:f25b:2900 with SMTP id
 38308e7fff4ca-35cc02b7981mr4653811fa.5.1758008002137; Tue, 16 Sep 2025
 00:33:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250915-bd79112-v5-0-a74e011a0560@gmail.com> <20250915-bd79112-v5-2-a74e011a0560@gmail.com>
 <aMge0jYwYCiY72Yb@smile.fi.intel.com> <20250915211321.47865d3d@jic23-huawei>
In-Reply-To: <20250915211321.47865d3d@jic23-huawei>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 16 Sep 2025 10:32:45 +0300
X-Gm-Features: AS18NWCO2CWCadsZfD4Zx3x2Kk_cH8eq1ZHLhEBNLfL8EtEvcHNkIFb9wcymKKQ
Message-ID: <CAHp75VdJ8MH=S4GbEbuky0-gFFxhKbBHsNiiajh-+jxCSPMDXw@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] iio: adc: Support ROHM BD79112 ADC/GPIO
To: Jonathan Cameron <jic23@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, Matti Vaittinen <mazziesaccount@gmail.com>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 15, 2025 at 11:13=E2=80=AFPM Jonathan Cameron <jic23@kernel.org=
> wrote:
> On Mon, 15 Sep 2025 17:12:34 +0300
> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> > On Mon, Sep 15, 2025 at 10:12:43AM +0300, Matti Vaittinen wrote:

...

> > > +   data->vref_mv =3D ret / 1000;
> >
> > I still think moving to _mV is the right thing to do.
> > There is no 'mv' in the physics for Volts.
>
> I'm not disagreeing with this review but I'm also not going to hold a
> driver back for that given timing is pretty much such that I merge it
> today or it sits a cycle and this one is very near...

Sure, nothing in my last reply is anyhow a serious obstacle.

> I'll get fussier on this once we have written up some guidance and may
> well send a patch to modify existing recent cases like this one!

--=20
With Best Regards,
Andy Shevchenko

