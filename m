Return-Path: <linux-kernel+bounces-802521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BFA5B45319
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 11:25:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 667653A5116
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 09:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D38727EFF1;
	Fri,  5 Sep 2025 09:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FvnOCCcZ"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576AB2459E7
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 09:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757064270; cv=none; b=NRHWm6vf1Vdgs7jfPZEt0wk+qYWWNJ3ERnaa6+HJ/iCuDCcbD2+elg0wM6MyvYLMhaDbmopO5Hr+V5Vjbm8CSK2d6wsylQp7JmATsQGW7VAaZXYzFLz89grM+xsWirVDCmOaGiXaRm1d3SgECoY1CYJw6kBx3nzjtTZeSckcxtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757064270; c=relaxed/simple;
	bh=cYCiiH3gm9SqbiIxuEfhcs8IFMHPpd2Rxvg3pb29fjk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=baYHCBZjrqqdkkAP5CWJ5yHDb0NLBOGKjMIFWOfHua5UWpstoONnbzUAGAjQ7eISgu6FXtczKq5LJRVNKgrzgu19fc4QrqUfJuY1lbc+UvF0RNEXxYA8vhVLDdLbhRRuWBOkIwL4bKDAmBW3jIe4EvNIiq1Ao063palngH21ayA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FvnOCCcZ; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-336b071e806so17471121fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 02:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757064266; x=1757669066; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W4iBW7toaydLQ7imUc/GfTyAbD/CCBjwzlb8LKJDuO8=;
        b=FvnOCCcZCYVKlWtrCmrQwyHS+BxFOSch5CoDMvesZzbD7K7PjemItF/j3pCcd2pJhe
         42DIn25za9146IAUKAvk0VaL+kfurESR6UuBwAIVfjAFF6Jr4bF2b9aejvf/D839qP2G
         mDTaNRUd+hJoRZbq2sPGTh/rmpc4z/w2vVo9dcnQCCR3f9NmpYW9z+777yCi0UTtGe72
         mNd3VtcGIsTyGO3uXMoOCRG0r/EqUA2fSeTGXbBN696OKkjqHAWH4k80eDIxiQnIETbt
         VkUQMPdENzgZWxjDs+cBbYQVczNgFI3tWMoUQlCCgJC8yGBJRqVCsYJNW3+xZwAuDaOP
         mp7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757064266; x=1757669066;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W4iBW7toaydLQ7imUc/GfTyAbD/CCBjwzlb8LKJDuO8=;
        b=JjyNWufwHWuITiNvMbGpSPwf5QN8tAemwD4YjL4qfYB8kF25M9TpdNOsBjVF1nJ2Gd
         mWKI/ErbjTAu+LvTBp9iP1gzoV/OjqOEADXigsgmnRvQkadE6l5tzGIOoEZ4CKH5CPXq
         8L+8JOMoCezCB4kB+eB/nj/jPKkobBanQeLjAdBYw34odNJlomRm/BLbDY/pYqqetTVC
         N9mYEVEAINkJtudSRoATBwRuwi+WKZ9f+f/1fJxCeorjn8JXxNXXQqkVn0Ea+R2FHb1g
         5fpfzbszGiG9on6SCaPlpqes9mQVgnSL05WDnoCmn0kYeDclKaBMslN2sBiSrKCKGjRy
         2OTg==
X-Forwarded-Encrypted: i=1; AJvYcCUOF5iNsLTBY/2eZx4wVA1UZEIR7mAdCj+ps8faaX8yn+hlJ4kPitY4Zcqho4gW3VI8Hxz69bZH18iida0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8hjXQsr13uW/pTY9uXh0Cb0eff75KwkX+oRSyycwFfwsld/Nz
	nH0e0NzvN5cAXoXTtWNUttCSvnyiuKKbl4Msg+F8UsH4MFPv/r1igbEk9aEU7YOrjl3ohoB3blU
	O72JKflDZHHf9JYdmabk7YxywuzEpO9+KEXA+Tn/r5A==
X-Gm-Gg: ASbGncsbKlVifvPSsDJiNm84FLl3XXUHGWxhHCoVgYBCn4okj3kQGX0hT/aLWY2RZRa
	Fasyvx8N+arXZfv6+Bpm3Kxh4stl9qD2XnQLf4LzP2q0bvCSFdOFTMte6pGcb51NYAEp2fIaZ9s
	zYNkPpaQvYB35RGiy3Nmgzcj/77Ah6zgxa2OA19LsFUpcsuJWKPr4afsqd5uMbiaKhmI/bMG7Zu
	l9JvJtattHv7jSNUA==
X-Google-Smtp-Source: AGHT+IHf8M+zGLz7Z5SlYPw0WPpQqAm9QKyvMQ2dhbv1sQOwJcfYvYdYRxdgHr8ORJ09bjn8JpTeTz4W49oHRu491HM=
X-Received: by 2002:a05:651c:4183:b0:336:95e1:9583 with SMTP id
 38308e7fff4ca-336cab04db0mr57663561fa.21.1757064266436; Fri, 05 Sep 2025
 02:24:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1753039612.git.dan.carpenter@linaro.org>
 <6f732f53-7e00-4f0d-82a3-480bc81497bd@sabinyo.mountain> <CACRpkdZ9EHoHiKit+T-ur0xDKMEoN_=TydzTfoggNBQGdra2bQ@mail.gmail.com>
 <CACRpkdY3_ifPsQOTqa2e-kHR24Khy0axrZ=K+vO4OJB+FjdB2A@mail.gmail.com>
In-Reply-To: <CACRpkdY3_ifPsQOTqa2e-kHR24Khy0axrZ=K+vO4OJB+FjdB2A@mail.gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 5 Sep 2025 11:24:14 +0200
X-Gm-Features: Ac12FXxefXSGz6SnyspKuWNLPpG5rs79kfLCyyMTukP-5craFHKIm7xv9A9F5nI
Message-ID: <CACRpkdaJNK4+Viv+kdZUSXH6r6jRfGt0KixsTuRTP56qwQccYA@mail.gmail.com>
Subject: Re: [PATCH RFC v2 4/7] pinctrl-scmi: add PIN_CONFIG_INPUT_VALUE
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, AKASHI Takahiro <takahiro.akashi@linaro.org>, 
	Michal Simek <michal.simek@amd.com>, Cristian Marussi <cristian.marussi@arm.com>, 
	arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 5, 2025 at 10:31=E2=80=AFAM Linus Walleij <linus.walleij@linaro=
.org> wrote:
> On Fri, Sep 5, 2025 at 10:27=E2=80=AFAM Linus Walleij <linus.walleij@lina=
ro.org> wrote:
> > On Sun, Jul 20, 2025 at 9:39=E2=80=AFPM Dan Carpenter <dan.carpenter@li=
naro.org> wrote:
> >
> > > In SCMI the value of the pin is just another configuration option.  A=
dd
> > > this as an option in the pin_config_param enum and creating a mapping=
 to
> > > SCMI_PIN_INPUT_VALUE in pinctrl_scmi_map_pinconf_type()
> > >
> > > Since this is an RFC patch, I'm going to comment that I think the SCM=
I
> > > pinctrl driver misuses the PIN_CONFIG_OUTPUT enum.  It should be for
> > > enabling and disabling output on pins which can serve as both input a=
nd
> > > output.  Enabling it is supposed to write a 1 and disabling it is
> > > supposed to write a 0 but we use that side effect to write 1s and 0s.=
  I
> > > did't change this because it would break userspace but I'd like to ad=
d a
> > > PIN_CONFIG_OUTPUT_VALUE enum as well and use that in the GPIO driver.
> > > But in this patchset I just use PIN_CONFIG_OUTPUT.
> > >
> > > Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> >
> > I tweaked this patch around a bit and applied: removed the second comme=
nt
> > in the commit message and wrote the docs to be more generic since
> > in the future other things than SCMI might want to use this
> > config option.
>
> Then I thought about it some more. ...
>
> Isn't it more intuitive that we rewrite the curren PIN_CONFIG_OUTPUT_VALU=
E
> to just PIN_CONFIG_VALUE that can be used for both reading and
> writing binary low/high instead of having two different things like this?
>
> I will look over current users and maybe propose a patch.

I discovered that several in-tree drivers are already *reading* the
property PIN_CONFIG_OUTPUT_VALUE to get the logic level of
the line.

I sent a patch renaming this property to PIN_CONFIG_LEVEL so
it is clear that this can also be read, and you can drop this patch
and just read/write PIN_CONFIG_LEVEL instead for the GPIO
driver.

Yours,
Linus Walleij

