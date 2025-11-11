Return-Path: <linux-kernel+bounces-895161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A87EBC4D1FA
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 11:42:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6D7284F14DB
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 10:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CBA034F472;
	Tue, 11 Nov 2025 10:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A5K3Vj1c"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083D234EF03
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 10:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762857352; cv=none; b=D9SOBrcNRrk+sH0uZu3hFEZeqkOnC00ZyD5yXcGxgBdzd8nh/Z90xUC2J4TF0ZAUAbesMN3LdrLEgYWV3ZHDfkdVqYQBMYuVziyR7GIrYaRiOylRlW3phvdvKC7gY48yrCEHu06TUjSquKz+7YzOjkauKtQ5D+fU4GffEJ8iJjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762857352; c=relaxed/simple;
	bh=b5cTARWnCH0O+wzlNreNZEZCG3YtR/z+aB364cLgDRc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OOcEOI70nvOykIZ0xuf15XXA3u4I/hOlqN8SGpvIeBp0nbA2zdOHCQP3EdbC03cxPSKO/tgy0i9rIV5mi5/KIn/l1/dxXcdS3PJsrkL5VSHy5oecQFjZIpikG6RlTG2Jg5klCvq5OgnsGcmOm/ME05wWsgrQDvxb/5yIk4vejB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=A5K3Vj1c; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-37a48fc48deso37599051fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 02:35:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762857349; x=1763462149; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b5cTARWnCH0O+wzlNreNZEZCG3YtR/z+aB364cLgDRc=;
        b=A5K3Vj1cV3ibGiIR+o5kYeDkP1LkFeJkJQ2AYzJ7Ueyiwmtcr2ywQVaykLSnAeMCgj
         EPqy2hQoLPARSunxPZsKJUddW/N/u34Y+LUskmmXxR/pr+8BN/MVMBB79PzKlZGgIsBF
         qAz20kgVN/CARA1DsNTJQzLAv6Mj1oepbEhxcK03bRTInIYMy05xLTiHsuTOCFSm5So2
         0xwf6tCRutJ8t289wOT9kF/akxV3GfJcPvtvY3qJUoEA0TgFNE0ZcM8Vhqfy3zaXX+pN
         eF8Lk9aHYKL9aXRObdVCeBBNDJEwVilstRk2D7oSVt8Oyd0PSIj750vIt30jb6UL/gKZ
         ClWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762857349; x=1763462149;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=b5cTARWnCH0O+wzlNreNZEZCG3YtR/z+aB364cLgDRc=;
        b=CkB6j8KSkVzItZmeraNxoQVe5g5S+lweqDKrvHT4XjMUEkNOVEcb/+T7dCTv9DP2m9
         A7cOWzrHpt6VRjXiUZMT8zWtasQr3pXokb7cmrfjgjtJQ1FkpVn1D3xDI+NuheOI2D0f
         5W3K1zg7qfsjVjolUQI63nrDKQCovY3YoOv4xSyhN6pZGfoLz9As9dkX7/Dn5c/Lw0W+
         fgeukyc9Q7bbfIsA7+fEcFtGuE2MdwU8YiBV+C6K8CIIfBxgWGmR9rUcz3UekkIq49dg
         Whbbs7K+8pY34PLWbuhw3DZD8kiOhpS2gHBNcxYgv1Rcc4TAnPtnthrdCctcgW1YFf2u
         MORg==
X-Forwarded-Encrypted: i=1; AJvYcCXE+KCPf4KEym0uRuGWMLfiYnKaA9TLoCmUk1Y4Lit+m4skrepauiPyg1+xJ4WIRTR0mg7JL0w2ROSD5hs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5TWRPifynO9kvoxF5cRg3sSzAf+gVlHaAAQzUDWxR3K5HcKS2
	vlzYeAYTKusPKLuBTR+upUDdLMrHHqeRTpw50p71Xae5VOqXdfujC6APgTqvMLrLhPXdgwVzH1Y
	2X4GYErdvUfVtTYp6BDMNG4mvEV4ytWTXauxe7gvToQ==
X-Gm-Gg: ASbGnctTEGE6XUUUybvQomT2YlrtHFx2s63hFWieN/vl5eSCtpmdmwx8AlHx7iChZDV
	UhGtz+Cp7HU4E+cQsEiZLwZRwDmI8v8/IQbQecVcVyhMiS0DtCUxnNaqVsv653VrbezN6n/Ln4q
	e/VXKFfEaTpFJzEsSsuJzmyKnWXkPzhGVfJBP8bgeAHvEHrHfjUlDRitqjkaI40EsicG6IPmyuO
	VzwZ/EkIUzC0zUNDCfS1mMB4psB4UHXwioFuyGE4hAsEFL8BolpBO10J4RqzHPRZCn0WfA=
X-Google-Smtp-Source: AGHT+IHiG+EjsNieo0IH9vKGvPYVnnnJhmFUXHoDPqz54BHP96ylxBdjlT/JInKjKxLz/khK4ncylVpRxXU4D16MeYo=
X-Received: by 2002:a2e:95d2:0:b0:37a:2f0b:ef24 with SMTP id
 38308e7fff4ca-37a7b1995e0mr22288641fa.16.1762857349004; Tue, 11 Nov 2025
 02:35:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251104203315.85706-1-shenwei.wang@nxp.com> <20251104203315.85706-4-shenwei.wang@nxp.com>
In-Reply-To: <20251104203315.85706-4-shenwei.wang@nxp.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 11 Nov 2025 11:35:37 +0100
X-Gm-Features: AWmQ_bnM-SUasW3cn2Gm4EW3aePYZpGnjIZZVnW89VcDCfJSgNXVTHUcuXdKqUo
Message-ID: <CACRpkdZR2C=+ssYOKnF=hyOqTakGjVxzp5_qz=3-uYRpzaZgNQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/5] docs: staging: gpio-rpmsg: gpio over rpmsg bus
To: Shenwei Wang <shenwei.wang@nxp.com>, Bjorn Andersson <andersson@kernel.org>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Jonathan Corbet <corbet@lwn.net>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>, 
	linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-imx@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Shenwei,

thanks for your patch!

Also, a big thanks for working on improving the standardization of rpmsg
so we can get some order here. This is very important work.

On Tue, Nov 4, 2025 at 9:34=E2=80=AFPM Shenwei Wang <shenwei.wang@nxp.com> =
wrote:

> +- **Major**: Major version number.
> +
> +- **Minor**: Minor version number.

I'm not contesting these if they come from similar fields in other rpmsg
devices.

What I'm thinking is that the driver will eventually have to quirk around
bugs in the responding rpmsg CPU, and there will be bugs. This can end
up with this situation:

major,minor =3D (1,2) NXP implementation, no bug
major,minor =3D (1,2) Sharp implementation, no bug
major,minor =3D (1,2) Sony implementation, ooops this has a bug

What is the driver going to do here to work around that bug?

The scheme kind of suppose that all vendors use the same codebase
and they don't.

I would rather have:

**Vendor**: Vendor ID number (such as the PCI or USB ID)

**Version**: Vendor-specific version number (such as SW release)

This will make it possible to identify buggy firmware and apply
quirks.

My apologies if the rpmsg community has already thought about
this.

Bjorns input would be appreciated!

Yours,
Linus Walleij

