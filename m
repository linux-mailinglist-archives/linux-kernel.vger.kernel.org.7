Return-Path: <linux-kernel+bounces-843190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5620BBBE997
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 18:11:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1505E4ED4AD
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 16:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AA3F2D9EE7;
	Mon,  6 Oct 2025 16:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="VLrtECs6"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99372D94B3
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 16:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759767075; cv=none; b=luIx81i4vTklx+sfLRRpXuwBHIOTZA0tWsLfGEFhDKQ6l8HJtnDFuijqiub5yYwvu41RsG9mFS6NXci5zZOpC0jG2t6Zbo/7san1cOUy7I/MmT3jTS7Rs7YQU0QPOxVTRYi5mgyF6/Zoy68LipoBkvaIPyz6W3QTMugClN6Q2uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759767075; c=relaxed/simple;
	bh=bAAmP6Vor3+frUWo9VM5DAgXz95oSL+3FrW7uk1ufUM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C54AKwPhD4a1opc1OCAzYyRf1kud1heaTQNmL2ECc2t6qtN6Z5WNRiVoaSn/eehbcJ48VAbC4bA/sbWiv5wS1AgeODVlZsRVnq+Ir7I5TfUujB5dRVpJukEikdCdbHKzSss0aEA+y08W0a3S89/E+ZxXuoq3pyFkGDBWKUiOovY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=VLrtECs6; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-36527ac0750so48836911fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 09:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1759767071; x=1760371871; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bAAmP6Vor3+frUWo9VM5DAgXz95oSL+3FrW7uk1ufUM=;
        b=VLrtECs6+aeEeZz+5cjvV6B/jGEJBVfEd/gTDAJD2K2FcF7e15k3LADejBcX6p7l0Y
         KrHQ10WvOU1U3EUD5RcMEz1+TNFrUT96t6wuLEOm0yM9HD5ZeC+Qbnq/dP94FHbyrUGt
         gfhhf9RCiTUsVzFIExZhtsKkDZl9osqBoiCb85qDZL2GVxeRfdDl7Q9rp9pjQAUsufYy
         g0exd8nmbboKMV/CVUjzM8ohVf4ACv63d0TDNGV7PweeyWSwQtX3Bf4ec3v81SXKkEe7
         OYNkWKFno8CxXi1kQuCtjz0uTO6mmN03TBYF2aBQjubIfGOmDZaZqLhIoW72Wc5q/mmL
         0/GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759767071; x=1760371871;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bAAmP6Vor3+frUWo9VM5DAgXz95oSL+3FrW7uk1ufUM=;
        b=FyQbx00Ng7OUvf0pr0jfU2dHmx0oVUjZC6IKXqsg8XriLn77YtRWdsrB8U8LmFiyo6
         ggdrmh/DXFY032aRo9Ub394T3fE8OvwpUQOMNszxHb3xuhyO7IqVKEgDZrp/XCwa6Fu3
         QeSzShl01NgMefiSyEmsslawx2Djkd6yA11vIXc/iPaaEMd4w4ooiRW/rt/zILs/QnGH
         7qi9FzLpcGlSGUSc7NgS/dEzU+TV3/QhyqFrSBCmsgj4qZVukFzgjwTs30UT8Gbuln9s
         4iQRXiBxir0ElzcAeV2Ba6xKmzusKy0/bB9DUl3c4+497Bt9tXBrisGQKexVj0qhV1xd
         05aA==
X-Forwarded-Encrypted: i=1; AJvYcCVE/o4sdFayPbm/SRmtQve4nSRwkVPxP9bTZ87zQ8GVpOzsNi+7X7nvFgTtbIuAfZnxNNDMiiqAi5MOP20=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlmBGmXS2LI/zAjQtEkQ7BZnD+JVBcWfAZ0lScn+A4TxMf/Nlq
	PoCa3Hc1LP+LlzlxzRblxeVgEGDGemNnhMT2dkgHaBxbcWK66hf/quDAiKb2lC0+iALgtMW3aXV
	++2hbajQi7TOHD0/mr+Duj71NMkwHP2MoxcWebqbY+g==
X-Gm-Gg: ASbGncv6Worl3c/MtpsE84YgQE6kHV0Uns0/cS3kgFdo8N28vkeYKoe6KRUEdvex/jF
	FrlUX/2ojEtkVV5W640Jd3MHtBNL2Mw2eTdaIzlVsvoJnfJrDET2NiffQ+JkcVKD+cWQt+61BY+
	wdaTvtBiTfLLJldnj6y1VBD+VcbcNm55o0zfAjDlhemeZrxIOkYnbXzsgiZm7VjBydjswzXNlns
	b0ftBc00Ye3m30oBtc6IdcWaeHHT6faidf13yNtsB5hl1MSM8xgYfOBt4O0iEM=
X-Google-Smtp-Source: AGHT+IHQni+hoN/f23d0O8IX74fUFomrJ9gkJXQ0jq6YVPXYNOJtNrLGQEvHZJ8/WlypXR2ARa7kU4bjK03qJXmCeP8=
X-Received: by 2002:a2e:bcc6:0:b0:36e:35c8:3dc4 with SMTP id
 38308e7fff4ca-374c37fc6f8mr39619951fa.21.1759767070653; Mon, 06 Oct 2025
 09:11:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250924-gpio-shared-v1-0-775e7efeb1a3@linaro.org>
 <hyzzrjn7jzo3tt3oyg7azijouawe3zopfjzq6zfhoo6e6z2m4t@ssl5vl4g557e> <zk4ea5cibrkp4vttuy4evrqybf76b3nop5lnyck4ws4nyf2yc4@ghj2eyswsoow>
In-Reply-To: <zk4ea5cibrkp4vttuy4evrqybf76b3nop5lnyck4ws4nyf2yc4@ghj2eyswsoow>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 6 Oct 2025 18:10:59 +0200
X-Gm-Features: AS18NWDSntYY-tS0LWjCm4WwdgxQdqQ5RgzeqJofTletfEADJXVbDbVNAU36cIY
Message-ID: <CAMRc=MdWmO4wvX6zpzN0-LZF1pF5Y2=sS8fBwr=CKMGWHg+shA@mail.gmail.com>
Subject: Re: [PATCH RFC 0/9] gpio: improve support for shared GPIOs
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Kees Cook <kees@kernel.org>, 
	Mika Westerberg <westeri@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Andy Shevchenko <andy@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Srinivas Kandagatla <srini@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sound@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 6, 2025 at 5:43=E2=80=AFPM Manivannan Sadhasivam <mani@kernel.o=
rg> wrote:
>
> On Wed, Sep 24, 2025 at 11:25:12AM -0700, Dmitry Torokhov wrote:
> > Hi Bartosz,
> >
> > >
> > > The practical use-case for this are the powerdown GPIOs shared by
> > > speakers on Qualcomm db845c platform, however I have also extensively
> > > tested it using gpio-virtuser on arm64 qemu with various DT
> > > configurations.
> >
> > How is this different from the existing gpio-backed regulator/supply?
> > IMO GPIOs are naturally exclusive-use resources (in cases when you need
> > to control them, not simply read their state), and when there is a need
> > to share them there are more appropriate abstractions that are built on
> > top of GPIOs...
> >
>
> Not always... For something like shared reset line, consumers request the=
 line
> as GPIO and expect gpiolib to do resource manangement.
>

They could use the reset API and it would implicitly create a virtual
device that requests the reset GPIO and controls its enable count.
Except that some devices also do a specific reset sequence with delays
etc. That would require some additional logic in reset-gpio.

Bart

