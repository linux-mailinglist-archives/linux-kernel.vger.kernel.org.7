Return-Path: <linux-kernel+bounces-739724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 37365B0CA1E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 19:49:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46BC37A49D6
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 17:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9263B2E5434;
	Mon, 21 Jul 2025 17:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GVCqqHTt"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E857C2E336F
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 17:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753120020; cv=none; b=EyXylhIKqpDierInHcP4AF5uqCLrit8AjwbtyBKZ9FpyCK+paH0L8A1a4u7u6152LHJ8vp5b69IuMf2rvM/mPue7iryL6iNO5HKunp5HpVTMxF/5OlI4YN/bWncxDLRsGAbYIDwqUEn+DLjVz6VrvOpnEr2yzL/ulPc2Jad/5gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753120020; c=relaxed/simple;
	bh=calo2kPchLTx/0RqT5EzXB5IG6us//9yTqxvYPq5t1E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I7jG9krK+bUx55Cd6Qj5p3mjd9nRU2K3GIOYuLmxeSr3GHBu5cmZf8I3taCYbSMbKhBRDppa9QNmxP+y2NQKUhgKb6m4kDSmhmqt7Lb6lHJX6hZejbPPh4yx9itREmOU4aihubYnZOSaHre4zuhKDpR3r6SRKK4OtpXQV3Stup0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=GVCqqHTt; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-60c01b983b6so9468993a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 10:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1753120017; x=1753724817; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GgdrHVKYOQ9ppPex2pOtGiCrSp3UKPgYB5yU3nqetfQ=;
        b=GVCqqHTtr733EkehvkMoI9U61Ge61vzPlhFpBNvvknPZJVVCpsLYMd1HQTVrF7/6DW
         4PNsCGZSm+6MQfOBsD4qmvqIXDAG9pDDf9xw/apHAe94ejpKvlka05wCB/qEsEuZZGJA
         EzAWlp7LJIC4rYM5+KyzUJURUrS18zcJsu2Is=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753120017; x=1753724817;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GgdrHVKYOQ9ppPex2pOtGiCrSp3UKPgYB5yU3nqetfQ=;
        b=X3HUtdbPZQdenl6DXcS9uUrPJVKtUALN5K1TZ8YV6vF2DLT/Jh0RE1NAJisdt/eCPk
         O1gEh7cUj1Cp/ud/iHM0pzuWwm/VzhOqtybb9pOUZHfBqS7Zo1o015GXapgtMzUhL3Zb
         5IQS0C67clkvfUtujzOvb7li+A6UMF1JjH9af+/nTPMBEUMJWy2+NuJP0kmFFW4PsmeT
         DPc3W5oAS9ZqFOOmKNUoVi/IBIZRgBWHWinIa0Ut3GzwSKsp542QPqUQhTxoeXrSlYTW
         8JDHreRNS02BgQFb30I2OSsMaBHkPvUTLC6nKhEvoFn3/cRNu1XQxvBoNsZS15lpaCp4
         Ko0w==
X-Forwarded-Encrypted: i=1; AJvYcCVV4a6DWWTaFLQJfZlpodrzrLLEyc2klGR3f1Glv3/XPuWe531I56Y7M6dz1wLD5lziP+9gwvYWv/WM/J4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUpLSq6y/LYofTBH3dVFn/RyJn6GMT24k9KEAscyRmU4moqbqb
	QX7X0iG8N4MJFARNkR0CPknn/qLrUtRmybMFYPIv8vjhvVnsYIL7dMqpVzpHu3Q/AI2Blc6eyOv
	rAW2z2dGxaZMRASiguflWe8mamLwgEZeIt+h9AA9wl3L5R4MfbSxPdA==
X-Gm-Gg: ASbGncutKtQLkqwoDw0fA/KkxV3Xc6GqH9qPsvi0OLQWQqXreTMLzgeIO8vAIAFYxuF
	38aEHIxflTPzBv01BgjpnRZwYur1l4FjIJFoeM7f6CASPNb9lwdyqSjNNYGWIilCLmsWPaGfnRJ
	5QX6nN3KH0TqnADpFtu8V0B9e8c4bLpqhQvrebR54pFUuhOF4ODFJ3NLy3W0ZKJTXkx1tISKs3i
	vqixVY=
X-Google-Smtp-Source: AGHT+IG4Cb5/Upf1NGKGvBZwFob4DGiucz5xEVtSKX10XiT/wE6bKqZSI17ZGyvJg3qfJi2tuPumtNfMrEU7WAFbjUA=
X-Received: by 2002:a17:907:9703:b0:ae2:3544:8121 with SMTP id
 a640c23a62f3a-af1529e3c52mr46079466b.9.1753120016973; Mon, 21 Jul 2025
 10:46:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250717-su-v1-1-0f740fd8bfb6@chromium.org> <7ebb8be3-ce67-4989-bae6-8459aef74528@kernel.org>
In-Reply-To: <7ebb8be3-ce67-4989-bae6-8459aef74528@kernel.org>
From: Allen Ballway <ballway@chromium.org>
Date: Mon, 21 Jul 2025 10:46:46 -0700
X-Gm-Features: Ac12FXyOtiUUTetIfpqOJ6vnbLB_uoBVrW7m1UCGcyztucen20Jk7eiRahyse1o
Message-ID: <CAEs41JAt5Hjp7G6LPr36e+BT0dp6RU5p25kzCwnwBpBfF-3dJw@mail.gmail.com>
Subject: Re: [PATCH] media: ov8865: Preserve hflip in ov8865_mode_binning_configure
To: Hans de Goede <hansg@kernel.org>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

On Mon, Jul 21, 2025 at 4:51=E2=80=AFAM Hans de Goede <hansg@kernel.org> wr=
ote:
>
> Hi,
>
> On 17-Jul-25 11:07 PM, Allen Ballway wrote:
> > Prevents ov8865_mode_binning_configure from overwriting the hflip
> > register values. Allows programs to configure the hflip.
> >
> > Signed-off-by: Allen Ballway <ballway@chromium.org>
>
> Thank you for your patch.
>
> > ---
> >  drivers/media/i2c/ov8865.c | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/media/i2c/ov8865.c b/drivers/media/i2c/ov8865.c
> > index 95ffe7536aa6aba814f4e5c3d12e7279470b2f07..40a852d31f13aff960acfd0=
9b378d71525e19332 100644
> > --- a/drivers/media/i2c/ov8865.c
> > +++ b/drivers/media/i2c/ov8865.c
> > @@ -1746,7 +1746,13 @@ static int ov8865_mode_binning_configure(struct =
ov8865_sensor *sensor,
> >       if (ret)
> >               return ret;
> >
> > -     value =3D OV8865_FORMAT2_HSYNC_EN;
> > +     ret =3D ov8865_read(sensor, OV8865_FORMAT2_REG, &value);
> > +     if (ret)
> > +             return ret;
> > +
> > +     value &=3D OV8865_FORMAT2_FLIP_HORZ_ISP_EN |
> > +               OV8865_FORMAT2_FLIP_HORZ_SENSOR_EN;
> > +     value |=3D OV8865_FORMAT2_HSYNC_EN;
> >
> >       if (mode->binning_x)
> >               value |=3D OV8865_FORMAT2_FST_HBIN_EN;
>
> this change should not be necessary. Lets assume we start
> with the sensor runtime-suspended, then ov8865_resume()
> will call:
>
> ov8865_sensor_power(true)
> ov8865_sensor_init()
>   ov8865_state_configure()
>     ov8865_mode_configure()
>       ov8865_mode_binning_configure()
> __v4l2_ctrl_handler_setup()
>
> Where the __v4l2_ctrl_handler_setup() call will apply
> all control settings including hflip.
>
> So unless you manage to hit a code-path where somehow
> ov8865_state_configure() gets called without calling
> __v4l2_ctrl_handler_setup() afterwards then this should
> not be necessary.

ov8865_state_configure() is also being called from ov8865_set_fmt(),
and makes no calls to __v4l2_ctrl_handler_setup(). I'm not sure if
calling __v4l2_ctrl_handler_setup() here as well is the right fix, but
the driver ov8865 seems to be based upon, ov5648, seems to avoid
this issue by preserving the flip values when setting the binning
register values in ov5648_mode_configure by using
ov5648_update_bits() rather than ov5648_write(). I believe that we
just need to preserve the register values unrelated to binning inside
ov8865_mode_binning_configure, possibly by just using
ov8865_update_bits() instead of ov8865_write().

>
> Note the whole runtime-pm / calling of ov8865_sensor_init() /
> ov8865_state_configure() code in this driver is somewhat
> unusual. So it could be there is a bug there.
>
> But I don't believe that this patch is the correct fix.
>
> Regards,
>
> Hans

Thanks,
Allen
>
>
>
>
>
> >
> > ---
> > base-commit: 6832a9317eee280117cd695fa885b2b7a7a38daf
> > change-id: 20250717-su-94b187fa3d1e
> >
> > Best regards,
>

