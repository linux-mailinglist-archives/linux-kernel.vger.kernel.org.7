Return-Path: <linux-kernel+bounces-730504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B507EB045B8
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 18:43:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 788647AE8A8
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 16:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E3D9264A76;
	Mon, 14 Jul 2025 16:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jj9Uat1g"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915AC263F38
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 16:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752511117; cv=none; b=XzTh3lK7hX69JTOn/iWp+dfnIb+jk+i0LVRyXbLydlYvXMTnDaPnkyiLTCRX2LLQPk2xIk1yxsfRo41ctT8yNmpe4hkIo8o4T99hrTH20E1d2/q/AP1Xnyn5pY5Z3523NT26soNB1Mv6nLAhOUiqXUCzGHp5fKgMWdNPRMYGofQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752511117; c=relaxed/simple;
	bh=OvX1o4Xe0KwoA95UmnLfFc9oEE9tei1n0VStVxlruSw=;
	h=From:Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:To:
	 References:In-Reply-To; b=A2bzhF3Q11hRM2W/KKIk/DQNStqiVEa3wVKr2a9VuuatLC6IVFu93zDF07IRKQA6rBbYurWqPKtrvYlimobEtCYPrskF0G6DyVaGF4iZRfXDV2uCC1w5yAUeXr0yUYn+2Gbn1SXDMI9lc4BOeVLzJtaFYRTAnVk3w17Ltc9V9kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jj9Uat1g; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-455b00339c8so21591825e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 09:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752511114; x=1753115914; darn=vger.kernel.org;
        h=in-reply-to:references:to:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nA6MOwgCp6FTYVinfvEZJR7VSvHLCjeqeD7Gs1ZsFHc=;
        b=jj9Uat1gz8e2NKSHUyou8bGNYx63vdd8GaRvjM2Z+BQBcOoPSbksG8xSPWS9RwmIKv
         YVN+Cs513SW+iuouW5i0RNOOkKdh5iWi0YQIIBrnQCiA9AK2n1QYgq8nF+ssJGNQdwKJ
         srAYt1Zy1LRCMNt0g3uasbF3vUh8MZOLM5geXnJABVpZPd2/22XxotxuUZpWkSNd/gZI
         RDk2pID+hZCxEBKIloG4Pnpw+tZU4hLPkg4VsPWrQL9KMtntZQA460c/QW1ZFn59tsID
         gBOMAMthZPWU9b9Fdmhf8NXrSaoN0yw33sE1V6Zaxfh+jICJEUKrPnYd7l8jgVXPX3Gq
         cx3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752511114; x=1753115914;
        h=in-reply-to:references:to:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nA6MOwgCp6FTYVinfvEZJR7VSvHLCjeqeD7Gs1ZsFHc=;
        b=qhTl/0rw60uT9iC8AyAHOpdYrii2JZCnoxlq+CPZeFKZMYEi5UMOtICBLMe5Poilew
         EIZEWZYEBPs4xX+5MbVANk4WFeq/WCtDBTFMiet2DiYJ9BUUWq7bdFEn5rsDo4mNUfxB
         iaqvxv882dtiDSID48YDDQs8lhxp0yWrPZCmBkFY+0KDSD6aHx32xEf7QwNQPbf6LVhX
         BG2kBv1DbtdeCFftR5OLTTPL4L0x5GXj8euey+kLN1p0BE8oasjAagHcyE8YB0DXV5zH
         Gnd2y2Ix31vXyFgXqItZB5A27QYPRN/18wrWMhMlvPUeKC7lIxiiHjXYh87C32nz6SuC
         I1WA==
X-Forwarded-Encrypted: i=1; AJvYcCX2QP7wM/zTK+KjOQowWhxAkU/Fh2wKCqsoZbdeUGiowxJo5da8b5RJ836ijxVR34jaOyTfP8GnXcHvZ5E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxow6jouCmmVyjxEiWsxCkv1WEd9SG2PxYq/mZcsLYqaXwpP9uq
	PgZCqNduRjLuh3TGECeoWF2ZncDhr/UzIfuLRX7YUxkxeHYvtMqwJ+yV
X-Gm-Gg: ASbGncs83sasIHRakfCLXi4pJAK8qogRjsxroUVy8D797CfBfpePtFHFz+0uoG38XXr
	ClgW2Pqh0zVhAsucOlS7ngC4/NmzuUFmoNdRI0V8Xub/jIYeddGC/FiLH3bOhxJMTmxB102pi7D
	Ox2WCuFN/wSHN2biXMNMjDMJFuZ29dyRPcgPweQFvD1Da6NJ6QKN+NXgmdDr4qPHtFClB76O6n4
	ep89zjilmrNUsnwhLtVN0DbDvLdmogtG8IhZc2CPrWIucgj3imJqxgLQDRvXsZ9arzyfC1gmeNr
	vPGJn1dzxYNZ8xUI4zCDspyq2T2rdmg/uG8nN2JtKLHRTlRvHjQND3gZQDcQZsN2bEr/vgH5Z8B
	iQJ/XOzpa0do2Hozh/9MrVFhLidVO4XC/p+kL7GwyMTs5E5PjTA==
X-Google-Smtp-Source: AGHT+IH3FzHWgfO64SorIO2LSrTeSaITLBr9pADAESGyIjq06fDfQg9wHeJoPO/Fp0S4R0e2GAEolg==
X-Received: by 2002:a05:600c:5304:b0:456:207e:fd83 with SMTP id 5b1f17b1804b1-456207efef8mr27541745e9.4.1752511113555;
        Mon, 14 Jul 2025 09:38:33 -0700 (PDT)
Received: from localhost (a95-94-245-170.cpe.netcabo.pt. [95.94.245.170])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4560538da14sm80523135e9.23.2025.07.14.09.38.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 09:38:32 -0700 (PDT)
From: Rui Miguel Silva <rmfrfs@gmail.com>
X-Google-Original-From: "Rui Miguel Silva" <rui.silva@linaro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 14 Jul 2025 17:38:31 +0100
Message-Id: <DBBXCAEMM5ZO.GTKVMMR2XDJ7@linaro.com>
Cc: <~lkcamp/patches@lists.sr.ht>, <koike@igalia.com>
Subject: Re: [PATCH] staging: greybus: power_supply fix alignment
To: "Akhil Varkey" <akhilvarkey@disroot.org>,
 <greybus-dev@lists.linaro.org>, <linux-staging@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>, <rmfrfs@gmail.com>, <johan@kernel.org>,
 <elder@kernel.org>, <gregkh@linuxfoundation.org>
References: <20250714135606.41671-1-akhilvarkey@disroot.org>
In-Reply-To: <20250714135606.41671-1-akhilvarkey@disroot.org>

Hey Akhil,
Thanks for your patch.

All looks good with the exception of a small nit...

On Mon Jul 14, 2025 at 2:56 PM WEST, Akhil Varkey wrote:

> Fix checkpatch check "CHECK:Alignment should match open parenthesis"
>
> Signed-off-by: Akhil Varkey <akhilvarkey@disroot.org>
> ---
>
> Hello, This is my first patch, I appreciate any feedbacks. Thanks!!

Welcome, and continue...

> ---
>  drivers/staging/greybus/power_supply.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/staging/greybus/power_supply.c b/drivers/staging/gre=
ybus/power_supply.c
> index 2ef46822f676..a484c0ca058d 100644
> --- a/drivers/staging/greybus/power_supply.c
> +++ b/drivers/staging/greybus/power_supply.c
> @@ -324,7 +324,7 @@ static struct gb_power_supply_prop *get_psy_prop(stru=
ct gb_power_supply *gbpsy,
>  }
> =20
>  static int is_psy_prop_writeable(struct gb_power_supply *gbpsy,
> -				     enum power_supply_property psp)
> +				 enum power_supply_property psp)
>  {
>  	struct gb_power_supply_prop *prop;
> =20
> @@ -493,7 +493,7 @@ static int gb_power_supply_description_get(struct gb_=
power_supply *gbpsy)
>  	if (!gbpsy->model_name)
>  		return -ENOMEM;
>  	gbpsy->serial_number =3D kstrndup(resp.serial_number, PROP_MAX,
> -				       GFP_KERNEL);
> +					GFP_KERNEL);
>  	if (!gbpsy->serial_number)
>  		return -ENOMEM;
> =20
> @@ -546,7 +546,7 @@ static int gb_power_supply_prop_descriptors_get(struc=
t gb_power_supply *gbpsy)
>  	}
> =20
>  	gbpsy->props =3D kcalloc(gbpsy->properties_count, sizeof(*gbpsy->props)=
,
> -			      GFP_KERNEL);
> +			       GFP_KERNEL);
>  	if (!gbpsy->props) {
>  		ret =3D -ENOMEM;
>  		goto out_put_operation;
> @@ -634,8 +634,8 @@ static int __gb_power_supply_property_get(struct gb_p=
ower_supply *gbpsy,
>  }
> =20
>  static int __gb_power_supply_property_strval_get(struct gb_power_supply =
*gbpsy,
> -						enum power_supply_property psp,
> -						union power_supply_propval *val)
> +						 enum power_supply_property psp,
> +						 union power_supply_propval *val)

Here you fix the alignment, but the last line goes over column 81, even
though 80 is not really one hard requirement anymore, all code
(strings is ok to go over to be easier to grep for messages) is on that
register.

So, to be coherent, if you could please send a V2 without this specific cha=
nge
would be great, Or even better, if you could get rid of all the _ and __
prefixes in functions names that would be great, and will give more
space for function paramethers.
Your call.

Also, gives you also the chance to practice to send a new
version ;).

Cheers,
    Rui

>  {
>  	switch (psp) {
>  	case POWER_SUPPLY_PROP_MODEL_NAME:
> @@ -943,8 +943,8 @@ static int gb_power_supplies_setup(struct gb_power_su=
pplies *supplies)
>  		goto out;
> =20
>  	supplies->supply =3D kcalloc(supplies->supplies_count,
> -				     sizeof(struct gb_power_supply),
> -				     GFP_KERNEL);
> +				   sizeof(struct gb_power_supply),
> +				   GFP_KERNEL);
> =20
>  	if (!supplies->supply) {
>  		ret =3D -ENOMEM;
> --=20
> 2.47.2




