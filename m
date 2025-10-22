Return-Path: <linux-kernel+bounces-864399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26D83BFAB38
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 09:53:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C530258243B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 07:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD5EF2FD69A;
	Wed, 22 Oct 2025 07:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ABypplDr"
Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65FC2FD673
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 07:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761119561; cv=none; b=d8XtXZkrjSQMWIVd3w7BoHnuT5fcAAUAqR368vlORJ9FVIu98++3djyILWUTGuVnhBOdUjFcTkzOR+weFhkLuQe0BBui/91qRDEcrqL4ZMhYvC0xXli8YqwAgRLXk4aoqpnABA51dCWP++RD+vU3F9poInr9/+SQNHleD1Nfg1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761119561; c=relaxed/simple;
	bh=A854G8Q+az7SMF928a56CKf41JBBm3BPM7QWQ64soKM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ovTaeU2ELh+kQwCK7w6WoPmKoLOpSRq4R8qT4Mq7G4yStcHDPPcZ4+slauo9F9sruvpZ6gQWOCtWxDY29xZW4zYxcsTtJ1nt8QFWxzF3p3n29CT4RC2do2yyjB7XP0L0wmIMUhG1gmonVhEgmhiUCE40Yk6J4GeWVnutqzYKl0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ABypplDr; arc=none smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-63e3568f90dso3420875d50.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 00:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761119558; x=1761724358; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5SQfEz/e2hOwh+iWueKx4wWRyZ4LmWDiG7JhS1t4UW0=;
        b=ABypplDrXNLD4T/kKJ8lfRsP5bAAtauYUpcOOjCU4U3BaAiZ48Ob/t0wWVC7nYxEqn
         iO3duOiuHQEF319w8UeJEZq1xDYgqXT9br+tNIMGrE8Tga8g472DY7QJxLbRD7B4v1SU
         oQIaIAtfPyzCkFpqqg2iUvqNk/H8ul9rN8XyMG/C68CxTwiwpLnXxIsayJidKNrtEonr
         Zcgd6d8LiJGfXl4kcyDR6bup4+G2WIfhnOUaKzewBr2XXA+isVqLHN6aXbFtEaipwaGS
         fswA7EXWHRQm4e0MWaLN8oivQjea9CRMHOdz/AqyIxgEBpDj0gkQ2T11DjxEI3jGsm8O
         bqsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761119558; x=1761724358;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5SQfEz/e2hOwh+iWueKx4wWRyZ4LmWDiG7JhS1t4UW0=;
        b=rB//c5Rd+Coo0GAVS8vhHLH22Ayp651Vgz09xynPdBCEEVt+acY/3InABdZJn1hoIG
         QyxqdL84o6WoCyLIM/TVN2Ps646ALpHS9uY9htcRNni4p8+1IWsp28Wp9Qmx/33tQKJ4
         HwW/E9lmjGpXWkEBCeVKzqAMPdsP2HAN0G25qFA8EWUnEnU8VkGZXFclZ/+VaeUJ7UmQ
         cuesxPTOcXIs8+yWH2DQAbB+AfsV9SiFSSp672HBQHcZoKxeH0fgJW4kVqwFXC/V3M2D
         JD9W8BOOBHvGZfR+YOmEB3Xmf1fv8X22ztBD2e6EV+xOPY8ngjlaB+ascHrquK/Fle4t
         eTPw==
X-Forwarded-Encrypted: i=1; AJvYcCUg4kLd/NaHjNr/2nGqN+H6YcTW3xmSPpXYVJ5eB/leO3OH2dPucwtNjuAOALtec0Zl5kA2/qWloCBe7Do=@vger.kernel.org
X-Gm-Message-State: AOJu0YzT6ot4amCQrfYWoOe1/60FqabyChzytJYotX9czGscaE52NBET
	nwxsLHd0d89idrehnL769R3PcBvAJ32iJ1lg5OP1ptWpm8ZgVNB8vBuo0cPr2Y+onSf9VlZJohI
	OM+aucZRM1etR8m24egRSnjZz8j/Kvgxd2DT54Bkb1w==
X-Gm-Gg: ASbGnctqrFqa1z6UcAF5TVw31jktJSnqbXNYI0wFsK7W/BNDtN/hYUHJWXwYT1vy9KI
	hfIJA3kBTplKYZo4/0DQ0FT1UL6tRFnSHM6xDlxwrdveLTaLlIXCpj+EIdJc9vpJMk7o4pbAGcV
	yggM+NOyqA/PqY4pvDsjmkHK+oFpGx9JCYH2QJZL81uO9rrnD0a3ooOCP1MHZqIw4WonjfojG5n
	I4eyrZddmSh7rZFdtWBBMAwJtyfazF6PHGWnMMPbDvZyIHhJC/9ecpIEV07GdfW10c3RAs=
X-Google-Smtp-Source: AGHT+IGOnPQWJDBN6sjrOxFjPZZTij/Niq/8Rg21Q+EknYQnuJrFX6ATSFspu4lRM1YW7AwwhMSNREKhsGRl4TKmTgw=
X-Received: by 2002:a05:690e:4008:b0:63e:1ee2:eb0a with SMTP id
 956f58d0204a3-63e1ee2ecb5mr12241395d50.26.1761119557691; Wed, 22 Oct 2025
 00:52:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251021142407.307753-1-sander@svanheule.net> <20251021142407.307753-7-sander@svanheule.net>
 <CACRpkdYde+=85f6Zfz40bMwOxSE-bszHzvBhQwC+G-E2CZr3Lg@mail.gmail.com>
In-Reply-To: <CACRpkdYde+=85f6Zfz40bMwOxSE-bszHzvBhQwC+G-E2CZr3Lg@mail.gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 22 Oct 2025 09:52:25 +0200
X-Gm-Features: AS18NWChHJVKsQEprXAlHgw_Y74ygS-pAN-Cj80aJrWmlHy4f-JX2hUVSzNGAmI
Message-ID: <CACRpkdazC7KC7HUZTkN-QqjuWXaJKLQrXfC30=GKUOymfpVJTQ@mail.gmail.com>
Subject: Re: [PATCH v6 6/8] pinctrl: Add RTL8231 pin control and GPIO support
To: Sander Vanheule <sander@svanheule.net>
Cc: Michael Walle <mwalle@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>, linux-gpio@vger.kernel.org, 
	Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-leds@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Replying to self:

On Wed, Oct 22, 2025 at 9:42=E2=80=AFAM Linus Walleij <linus.walleij@linaro=
.org> wrote:

> >  drivers/pinctrl/pinctrl-rtl8231.c | 538 ++++++++++++++++++++++++++++++
>
> Should we put the driver in
> drivers/pinctrl/realtek/*?

This is because these are SoC drivers and this is an MFD
expander, right. Keep it where it is!

Sorry for the noise.

This driver is finished.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

