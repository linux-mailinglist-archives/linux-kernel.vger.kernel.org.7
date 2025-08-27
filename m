Return-Path: <linux-kernel+bounces-788403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26FD6B383E5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 15:43:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F2E77AB456
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 13:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0FD53568E4;
	Wed, 27 Aug 2025 13:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HCL9JgtT"
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A522ED141
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 13:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756302204; cv=none; b=UdrDyzbSil+atmWLVvLvdr/pYO73QzlAuWivf3oo2MMMOg1fhgDo5gKRqx5/IW3CCg5V8f75I4VXadBunrjCkW9R6lL7M+ro2x8bjJgaYP0noViwLx1JdKfGRkeJ2hoodlqNfSkeq5fGxIjVVZl0+olTz6WQQqaCbqqRYDnyMU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756302204; c=relaxed/simple;
	bh=ROC+BxYJvxo4Ra+SaImrJ8k/XraQYmEOGcoclXesz9k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s3U1sF9aWNxrqmxsbi3GK6Xj/P6cmMbWTbE+3lr7ALq5x+kAYJuIiushRrxRGdlua/xiVctB/ikDVWFihA80zEZlrOAqnw5vHRHnxMRduDdLwS18eE9njQuQ2FHjMRez9OLav8FsDGXUpCbf8cSsKjKvcWa0pVo487LA4A7iVZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=HCL9JgtT; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-74526ca79c2so958925a34.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 06:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1756302201; x=1756907001; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tOO5DJiHFR3uaAgcdyHCL1QPgCU//KGOS5fO6obbhFo=;
        b=HCL9JgtTNHQfyCP2h1cHz7pMZqma08BRAAK2+mSUQVzTxiI30rAvL+8tHZTZoOJxsh
         fIXrTLohDpP3ymWNnK7jvPbfV9godm63Gqgakqqi1qmPV00xbO1G8ZMQZVRSS/pF6Y3D
         OPe/93TvkXwVSp4hSUocup6eE7cYMcLyclMYQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756302201; x=1756907001;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tOO5DJiHFR3uaAgcdyHCL1QPgCU//KGOS5fO6obbhFo=;
        b=Zcpb5BcdW5wT6c+k05P4VM/y4MeX7+xky8MWw53ZG164dP5/rXYQhjPi1nF4hVeSkp
         NSo2hTIzMcqdLPjkONt5lZyjQ0q3l9+nTfIY03T16EwsOrFPGoOfGoVXqEqpS3HhDXVh
         7ts/ZByyTXMr4hs7Vx7DGUAB0UXuUcklZi4od3WLJ+t19XoCJp0BfyR6laT4vlAeEpVH
         4rSKWlHXLqZz0LHW90fdGcsY8eI3M/1eOpzk2uJwbDRezcnUg4XAnVsQO6B3wocX7E5G
         7ycNaHvI6Uygqy51JSXMiVeeuy2KDIb+iabgrPA8QPh935gH+ncj5ZwYlGySDbd/egj0
         ltYA==
X-Forwarded-Encrypted: i=1; AJvYcCUtzwYEDQLLK/fwcFjYqdgAae7uCppI/c6BeTM9ReqnYBNdzdQ7G2X5qRdvF2nEFaYakA2I/hOaXUKC0vs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzP5BWrBV6hpa/Lcqw7X1peY7zKVJr8PSURXXnnkL91d3Yzwcwd
	OJ1/zwadQuE+QR7u0freXIQfOdryZLI7qVRppnDKs4c66lbjxWEqMQJwpRbFGfBQoOw2QuC6g0I
	PB61F1/fzlL856VkR2IrdjDV6C7/lFgVlltkgt4D9
X-Gm-Gg: ASbGncu5hVz6TMi5aqYNQH415jfLHvdcaO7XG7fEAlB2tucgw7K2rAQKaJ18eQCy/ac
	oIl84DIbChIbkB5gFPD3dxUuNh13Nhe9ZTV+4QvqUoBjPiZbZ5Wj6QLbgVRNMta1kmaZTewBeuj
	ayEdI+2vx8BT4HVQarCEI6EVavOZr0GScLGSMOhBdbaVzHVi6pcdohrnhrRv6iY4uyPu1YKxrj5
	AhvYmC97SGvd1UguDQvThEp0s9hLyb+bTE=
X-Google-Smtp-Source: AGHT+IFML09d6OTln5JwHTjKrkwtVYwzmCr1Bxp6r1uvPPk8T241FrUzKZ8dLpbh9eYjr9tFvagSaaECgl+Ih/FJIJg=
X-Received: by 2002:a05:6830:d18:b0:742:fd7f:e105 with SMTP id
 46e09a7af769-74500aafdb9mr10828847a34.19.1756302201636; Wed, 27 Aug 2025
 06:43:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aK8Au3CgZSTvfEJ6@stanley.mountain>
In-Reply-To: <aK8Au3CgZSTvfEJ6@stanley.mountain>
From: Pin-yen Lin <treapking@chromium.org>
Date: Wed, 27 Aug 2025 21:43:10 +0800
X-Gm-Features: Ac12FXwM35V_oehyXQvReVca6XRrKSLZotqLpHmniBQa5j8YidPWQocMII9oIgU
Message-ID: <CAEXTbpcpJsL0te+DA=5PEJjkawZ23Di3v20hdMqUj3SeB_Y82w@mail.gmail.com>
Subject: Re: [PATCH next] HID: i2c-hid: Fix test in i2c_hid_core_register_panel_follower()
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
	Douglas Anderson <dianders@chromium.org>, Aleksandrs Vinarskis <alex.vinarskis@gmail.com>, 
	Wentao Guan <guanwentao@uniontech.com>, 
	=?UTF-8?Q?Bart=C5=82omiej_Mary=C5=84czak?= <marynczakbartlomiej@gmail.com>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Kenny Levinsen <kl@kl.wtf>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Dan,

On Wed, Aug 27, 2025 at 8:57=E2=80=AFPM Dan Carpenter <dan.carpenter@linaro=
.org> wrote:
>
> Bitwise AND was intended instead of OR.  With the current code the
> condition is always true.
>
> Fixes: cbdd16b818ee ("HID: i2c-hid: Make elan touch controllers power on =
after panel is enabled")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  drivers/hid/i2c-hid/i2c-hid-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-hid/i2c=
-hid-core.c
> index 99ce6386176c..30ebde1273be 100644
> --- a/drivers/hid/i2c-hid/i2c-hid-core.c
> +++ b/drivers/hid/i2c-hid/i2c-hid-core.c
> @@ -1189,7 +1189,7 @@ static int i2c_hid_core_register_panel_follower(str=
uct i2c_hid *ihid)
>         struct device *dev =3D &ihid->client->dev;
>         int ret;
>
> -       if (ihid->hid->initial_quirks | HID_QUIRK_POWER_ON_AFTER_BACKLIGH=
T)
> +       if (ihid->hid->initial_quirks & HID_QUIRK_POWER_ON_AFTER_BACKLIGH=
T)
>                 ihid->panel_follower.funcs =3D &i2c_hid_core_panel_follow=
er_enable_funcs;
>         else
>                 ihid->panel_follower.funcs =3D &i2c_hid_core_panel_follow=
er_prepare_funcs;
> --
> 2.47.2
>

Reviewed-by:  Pin-yen Lin <treapking@chromium.org>

Thanks for catching this!

Regards,
Pin-yen

