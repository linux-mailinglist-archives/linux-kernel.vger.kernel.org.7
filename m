Return-Path: <linux-kernel+bounces-837660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F0BABACD9F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 14:35:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFDCA1922AF1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 12:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 871D82C11C5;
	Tue, 30 Sep 2025 12:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ch91hNZI"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C18123183F
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 12:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759235700; cv=none; b=HDr3v4zUmAoC6g6T3CZpITWsiO/RbPa55HRjIgqJ1+bvcTzgkY0SG9VagyJiG0EpeksswwT49caEbwIoxWpDiY6gKqNVrn4n+UFyrI0H/gTcHjB8NJ4hdD/NZiKbyBmYXYgY//8vWdQRo7YzbxImrDQNA3OCiF4ogU32BtAFOk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759235700; c=relaxed/simple;
	bh=hQHCtgoQk3zqFHEz812bCMjEr9bOmzY6j1w2qd3TfmY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sSjHC4rlDXCNpRDMZbBUfXSTOOaPY33SepKboP05VjWUbIVFHQGJEsQkOEfwuT8xVJLgGAQS5YaJsKVkBi7WJul3RmkYsFBfGDJmM33f6n+Yj23behR3Hw4hFviVEWysjP9gBF3SD3lvflqKUtZuGSIwJFujjOrZNyExhZQCo+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ch91hNZI; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-36295d53a10so51928241fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 05:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759235697; x=1759840497; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=//xkitOYEIBnBowE0figA5jcXr1QSGKbTFftNJcWdSY=;
        b=ch91hNZIMmE/fJQQay1+iKdIS28/QXgL1MzZJmcKBZnWpOCyDLyq0s2hD6pAFs8Hx9
         M3rRLkKePh193MAijdH1+DnvyLQ9u78L5ota2m1O0SoPeIPz5SVV88ZbnhaFyqrNfNxj
         G47hugYMOQIyyESCZCZDkceXxNmpcYoK1vLxuRXvTu/LSjy281WQ9wJWgVvYh5UznJay
         6tN6RBNyLWS0qc4rjypAOotwxh8thNeTgzstGt2idiJlInxH4K6m4sl3Lwgm7EUhxHXu
         CoghBu98adCQiEMuA2WyzBfnTEdx/N9F7ieKeCuTs6pjPqU5syH3KjLJUb9B+DHd+her
         e1ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759235697; x=1759840497;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=//xkitOYEIBnBowE0figA5jcXr1QSGKbTFftNJcWdSY=;
        b=KIgcNj3FlT3ZIvbLeKBlkL63knJVZMpiPX92LjkyzqhPrg+3p7FUSyh7YXkdP1ZIQ3
         x7s2TdeEJRTMZs5/0+Fd3iEi7QzZRldbyNBcvDIPfYkMgALTVjVSnva2Yj5/k+8rA5C1
         9HmD/rsZr0nEmHKyvKPVG0kuJBoGWPdmP4GELr+zyVt7tJHMzLDdBsxIwt9qUI4Ue7aj
         p5krGJ4L8FJ2Uj9sAKMOuifmFlfnkAyZzydA7bWRIcn9EHR4PEcjERKovkdkBj9K7UZ1
         KOmv2FmWPRjRoBHupFYdOHjv/NEVJTiu/o6W8NmrIQAFGMgV64F6Vm8VZBe2xLDDLscx
         yM3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXQ3JN3eRkFzxBs2OzkB9c4CXkQF6rkBabF3Swdy1dw+t67+sc96LyL2tp7KOauthB+3pWBKrRcui3OCFM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRnxo3DKKrN5QfCdIx0S4VkZMy6pv1OxOBIcUxqQgwhInC7MXp
	BfZiG867THroDJxhmGmHA5f9FOwe00nUE4kCJLXJXy9/6HchO+hn4EE45Hvj2y2ALqAgXpVPb1K
	OQ5ejAggyVQxZZdbhdmHOHXm/uBE8TlxK81rdNc/pGA==
X-Gm-Gg: ASbGnctaFfwrWlJY97ifoFaPNO9Voaw8TpJl0am13JyILNSugZbMGN8pn/DiEpi+XoZ
	0/713jkiULViGzKarlnl1pkXLVzDPF/71fC++QE+mhzZW+vjw0pwnds77Ec3JEVMJ5IWrPeGxT/
	ZfLOkd75zDXkljYaM6c8I3gG3b5co/U85bkFuq5dgaB2Tj1na7blKvQK6d3c4Iqbw3UZLvuaNse
	7IIYVmMAxpI9CfoKEUHHDtv2OEEGgtU0i04mO9lxw==
X-Google-Smtp-Source: AGHT+IFkGyQJTXX+l3/fVG1kpg3S7XkLrTud3tl3gd71kpZbk5gd/flj5ygP5W+NqOo2/jq0RMyArIGv0CKoRXGvQt0=
X-Received: by 2002:a05:651c:1545:b0:36b:ce19:d853 with SMTP id
 38308e7fff4ca-36f7ff20073mr53691811fa.45.1759235697194; Tue, 30 Sep 2025
 05:34:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250912060650.2180691-1-gary.yang@cixtech.com>
 <20250912060650.2180691-2-gary.yang@cixtech.com> <CACRpkdYgTjerG5mks_+3sjhKKYtCsFY=1NWhgw_YEuib7gZm3g@mail.gmail.com>
 <TYUPR06MB5876BB28E3C30EEB9BB05997EF15A@TYUPR06MB5876.apcprd06.prod.outlook.com>
 <CACRpkdYKnFAyq8C5h2=5NQ8AU92RmzShNHd6+=21rWednjv-fA@mail.gmail.com> <PUZPR06MB5887DA8FE0E128993F11E2B3EF16A@PUZPR06MB5887.apcprd06.prod.outlook.com>
In-Reply-To: <PUZPR06MB5887DA8FE0E128993F11E2B3EF16A@PUZPR06MB5887.apcprd06.prod.outlook.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 30 Sep 2025 14:34:46 +0200
X-Gm-Features: AS18NWCe8gc0I9F23q-ySgwePTXWrU-J25uwnqfg_Oxcxpo9nPVmUWN-Gc4LkU0
Message-ID: <CACRpkdaQYb+tB+a9Q6j3xPq=BHbQV5-3hu3XiJkSU9CGtcHpiA@mail.gmail.com>
Subject: Re: [v2 1/3] pinctrl: cix: Add pin-controller support for sky1
To: Gary Yang <gary.yang@cixtech.com>
Cc: "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>, 
	"conor+dt@kernel.org" <conor+dt@kernel.org>, 
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	cix-kernel-upstream <cix-kernel-upstream@cixtech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Gary,

thanks for your efforts!

Sorry for taking so much time to respond. I was coding.

On Thu, Sep 18, 2025 at 8:17=E2=80=AFAM Gary Yang <gary.yang@cixtech.com> w=
rote:

> New scheme with macros has verified ok. I just want to confirm with you b=
efore submit codes

No need to confirm with me just post it!
Better one post too much than one too little.

> > But I think you can still use a macro to define the long pin tables?
> > Albeit macros with flexible arguments is a bit hard to write.
> > Save it until everything else is working.
> >
> In header file:
>
> struct sky1_pin_desc {
>         const struct pinctrl_pin_desc pin;
>         const char **func_group;
>         unsigned int nfunc;
> };
>
> #define SKY_PINFUNCTION(_pin, _func)                            \
>  (struct sky1_pin_desc) {                                        \
>                  .pin =3D _pin,                                    \
>                  .func_group =3D _func##_group,                    \
>                  .nfunc =3D ARRAY_SIZE(_func##_group),             \
>          }
>
> In C file:
>
> static const char *gpio1_group[] =3D {"GPIO1"};
> static const char *gpio2_group[] =3D {"GPIO2"};
>
> static const struct sky1_pin_desc sky1_pinctrl_s5_pads[] =3D {
>         SKY_PINFUNCTION(PINCTRL_PIN(0, "GPIO1"), gpio1),
>         SKY_PINFUNCTION(PINCTRL_PIN(1, "GPIO2"), gpio2),
>                 .......
> };
>
> What's your suggestion? Thanks

It's OK as-is if this is how you want to structure things!

Yours,
Linus Walleij

