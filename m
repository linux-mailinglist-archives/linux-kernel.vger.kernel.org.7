Return-Path: <linux-kernel+bounces-803966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72D98B46807
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 03:35:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAD1A7C05E0
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 01:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D69B1A316E;
	Sat,  6 Sep 2025 01:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jeGEp8jM"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E70A55;
	Sat,  6 Sep 2025 01:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757122510; cv=none; b=SvOQhs3T55XCjJRCcyRhBFWE/08Ym2IPS22KqRyWwcgUa+2Ca+F8GQuplpgJDO3ukiyhC7/rZ8B3Vm4OmJeyHtaIGbK4/r7DnYrMJ2hrfZOwXTdh7i3X69/g90P3w4xIHKnAPKK/fvT84l/y1ZA7C8Tlc/Ll7ui87G3I8xyOv9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757122510; c=relaxed/simple;
	bh=yuxno6aCRHrUWvFqeYUtAlBYHeeI/Dg5Qu4SNRdlRG8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=elRdrBCKQmlP0NvK2PgmrnEYta8qXJ1UGV6yfauX2qF5HAR0tdnHyxlIReICqou04j0ZvnmmGx9c5o0pQ1q8S9J3gQ7ZXMPy0YhrEMBjdH1hDPajgLpzsh+g+85wL00mKWR0TUsotZdscOaNi+KbNZwTkniZirffoFkRCcwOuZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jeGEp8jM; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-61cebce2f78so3295808a12.1;
        Fri, 05 Sep 2025 18:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757122507; x=1757727307; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CqNxXQ4nHpsF+qXR4Dx8odJeFWSsZU+70lFnX5QCDhY=;
        b=jeGEp8jMxr/onFev5Fc6AmzIF/fLFNxmCkJgXbo5o4XdKkSZA5HMxTTLwYMAWuLvDH
         PxqYd5VTSNAzwulzmLBkSFc2Q46JLg/+DPxh717qiBXLTrpMbX0mF3QlGXvbsOHg0o4/
         7ZOO2zhOn42LYFCA+gxJw6+iKAguZmPsa/J9Fma4N2qo7TUUUfO5hTxTDSxt70oXl/CJ
         m0ApOYioNVzsfBZADIL7fcPjJ8h8hQmJsIUnMeO4BLfkdsqjDHjjNH0PXeB8XwyP0piS
         wrrBYzZaYqCDDZNHgxE5wD7mTbnhC7VQ3nNsFoBX+gp8F+yv1z9r+tsIq8B+O0ZT5RBh
         gHAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757122507; x=1757727307;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CqNxXQ4nHpsF+qXR4Dx8odJeFWSsZU+70lFnX5QCDhY=;
        b=O52ivj/4oZLbdVd6YIdyVJkVadzg77kfdrPi302wukxhz2nSCovJh/OjR2WB9y+RQx
         UXehByEXmJeCUqETOJvLUVUvjsQqZzuwuYNRBD1XJz1F/7b5YOd0aIpK325MMZ17Zpaw
         3etIksbhxpoyi8nkmMCPTNcc2NQhE0Hgnl73fKkupbhJjKfZ7zNJk+OyHtZW9lpnWlxz
         aMuooSTDOVrA6ZzPVeLy9TYMkI1x2mT35diWbwqdqXkYj7MF1gJ7443HKx3ImDvP01Xf
         D2XpF04SRIj8vOXSrwByEQ6Iv6ciK4tShYjJAjP8i0Vl3x302vqeyPOHASsM8a9gUyc/
         2RrQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmCkZn/VHbRAeWvNu+W+kAvTvYX6AfrvtRYHVVJF8U/dVFKGxpM+hrKxfr2iHWDpyiBvPfsTLWdoMlYhBJ@vger.kernel.org, AJvYcCWNZFAbh0dX+ndzghR7ycrT2hrI7bokU6mxbSahd1fXQH3hLE1B90kq1Ui2s0qFACDRSRelbzHtK3DA@vger.kernel.org, AJvYcCX9bqhHwH4asXug3vulYII1rn1+IauhfmxOV+9o4UOaQ4i2eGPuBEPNToY8byErOioojyCi89Z+FHr3@vger.kernel.org
X-Gm-Message-State: AOJu0YzwXqQ2YYY21M6YU5pYNS8TT7RZuhVP7FnZj/yxw17WG0sPXTGd
	SiIKt0NHtvskCyDZwEYNuGHeFOLNaNNf6tsfyU6FsiIoz02Fch5/kfXy0MPJ+E2/UNJgz8z/YQH
	H9MR8YwHY8O7R+vxljsSW0Eg8lIINF998xYqaPX5xWUqw
X-Gm-Gg: ASbGncsXi3R+CHUOkXIu3TeLQ8qlHL9xkoLskPeFTiJWvmGAhtwgRJI8Q16j4U86Jlt
	veqqNaapvE1kPSsQ7KXtJjf81GNaAMD+76fMj9fQnpieIimc/ELFb+e/YAn7ksmzSqFZuEtQlcF
	VFst1u45MalIQz02wAy1pDM+tQvWA/9A2zjyrOix3ZcawNwrP2T00S2Ok6xoaGn8B1RUoWorG2u
	0fwS+RVDxN6w9vXIg==
X-Google-Smtp-Source: AGHT+IHUk2XfEP3oZ1qlnnJyiPfNm42Q4P5RUupaRScX2mRrTgQl+/WpyWfrV8JDjZaSVCFI462i2vBCUsBzJ3JREIg=
X-Received: by 2002:a05:6402:370d:b0:61c:5cac:2963 with SMTP id
 4fb4d7f45d1cf-6237f944ec1mr747810a12.29.1757122507114; Fri, 05 Sep 2025
 18:35:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905132328.9859-1-cn.liweihao@gmail.com> <20250905132328.9859-3-cn.liweihao@gmail.com>
 <707aad1d-fcdb-4c66-8d96-41cf1a1b02ce@kernel.org>
In-Reply-To: <707aad1d-fcdb-4c66-8d96-41cf1a1b02ce@kernel.org>
From: =?UTF-8?B?5p2O57u06LGq?= <cn.liweihao@gmail.com>
Date: Sat, 6 Sep 2025 09:34:51 +0800
X-Gm-Features: Ac12FXz_ebvQ7hvtXykd69gMxtD2syeHiyJATPrpJ61FnCFXWiMfi64X3YV7b4Q
Message-ID: <CAPEOAkRTVtKBsmiGTbKOCar0oNS-C3dRXqdpuowroRPH1bFS7g@mail.gmail.com>
Subject: Re: [PATCH v1 2/4] dt-bindings: clock: rk3368: add CLK_I2S_8CH_PRE
 and CLK_I2S_8CH_FRAC
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: heiko@sntech.de, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Krzysztof Kozlowski <krzk@kernel.org> =E4=BA=8E2025=E5=B9=B49=E6=9C=885=E6=
=97=A5=E5=91=A8=E4=BA=94 22:13=E5=86=99=E9=81=93=EF=BC=9A
>
> On 05/09/2025 15:23, WeiHao Li wrote:
> > We need a clock id to assign clock parent when use i2s 8ch as audio
> > device, CLK_I2S_8CH_FRAC should be CLK_I2S_8CH_PRE parent so we can get
> > frequency we want.
> >
> > Signed-off-by: WeiHao Li <cn.liweihao@gmail.com>
> > ---
> >  include/dt-bindings/clock/rk3368-cru.h | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/include/dt-bindings/clock/rk3368-cru.h b/include/dt-bindin=
gs/clock/rk3368-cru.h
> > index b951e29069..795e721957 100644
> > --- a/include/dt-bindings/clock/rk3368-cru.h
> > +++ b/include/dt-bindings/clock/rk3368-cru.h
> > @@ -183,6 +183,9 @@
> >  #define HCLK_BUS             477
> >  #define HCLK_PERI            478
> >
> > +#define CLK_I2S_8CH_PRE              500
>
> 479
>
> > +#define CLK_I2S_8CH_FRAC     501
>
> 480, no?
>

Neither of these clocks belong to the previous grouping in terms of
type, so I chose to start with a new integer id here.

Yours,
WeiHao

