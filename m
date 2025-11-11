Return-Path: <linux-kernel+bounces-895168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85314C4D1C1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 11:40:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFC82189DE72
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 10:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7DA534EF1C;
	Tue, 11 Nov 2025 10:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rX39NeN2"
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA0042EC55A
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 10:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762857591; cv=none; b=bdSv02hVeGiOVVkFBGoVbdZIsTDMUB4ShT1JuCySELamu2UeRgvPOlFabX7LTDCy57mUL8Iwx6MZkE99hjB/aFrBGBaOgDb2qRpg9M1zeyZB1ThUNgQmZMo/WgJT4+BAvv8Ex8NbTBbacsqXKgiSfOrqYxyC8tk6lgUESvn8iDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762857591; c=relaxed/simple;
	bh=uQN8C80XsI1DNcTbyZlxKBoQDlYbpinBS57HXqp89to=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nsMB9V90KHkDp8ie8Ljl63AUBI36KF3SlSAKMrVY3LFvGmhMipiKl8fjW1OYfAEiA74FdcrSPLpnNKl9q2vQpaf5snm1iaGCO2oFxy/so0+nfHyztPtRjU1UL6osAShA0AZbO8OipLeZeL/Tzv1ZNrHeLlVQ9/vsvqiz6ndbyTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rX39NeN2; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-786d1658793so36159167b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 02:39:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762857588; x=1763462388; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uQN8C80XsI1DNcTbyZlxKBoQDlYbpinBS57HXqp89to=;
        b=rX39NeN2PL/TgYFEBoIA2sPMSLu4q60y1Sa+C9R/8ZPxW6qJe0Dzx95viWXQz7cGgr
         PH0grH2HrymuRTq8svDjQdovq93ZJ4mLlaKgcSTll7KfAhiiROr2GfO1+b7/MxlRgnT/
         5YYNdrwHyqf9vhIur4rcrsQGCfCUZtDfSce/YCJs1a00tA3kOprneBPS8RHUzjtOc9JR
         cbyc3eGbrRXkS8Pm716k0+wpv7u5F7YYgh0Wt+QbcWACSlaIIGEVZEEkS3sG8fQ8I96V
         awB/NynSphoHhND6wLUZqoKVhqOJexO9Wq0NCuwitk89qlEDHzJLxIpdBsDcwTaHYejd
         Y+4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762857588; x=1763462388;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uQN8C80XsI1DNcTbyZlxKBoQDlYbpinBS57HXqp89to=;
        b=rDMeKLTULhk/ob8FgHx+c76B/+IaV1ZTFntFsUecW/DrXts/n8Cfrj44LEbaocOF7k
         YLF7SkVeRFLEOlTMBq53TGHcOPwuXYjjh94hqksOqArnnelYjYbykMb+WGb6CDj2URvR
         EMQyjJPo/yDl6tQRx7f5S957gascb0GYou491CAvtGY3Nb5LDrqy5bop5MgvpIqGOFus
         SpUYV/QFJedBgPZDDNEg/MUJAc5rsM0bKXMap/wT1fXmvicXeTlj+/RpS66VyMGRxXwD
         q2XLTa9FQzEt3UCUR408v6kfbSD0CeGYaLEitKbpB8J/qa/YohpBd2Gi1JZIv0yfZwpk
         4zDQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0N55ovA84sw7ahwFwgOJ+METQL4WlaVJpfVDl5E8weNPdCvYDtqk+Ij6dXCtgdvnFmBbHu7EhQep1UKw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUcVxRsUb4H+STxuVfWFT1/ctbO1vJ6sFdu2DDEAG/l+/+0jN5
	T4aOAPdNRW3OpzIH9I5UmEwdL7zcIU+MD9l+thq7BYwZr3JkFLcQdxeONdik5Jm2a/o653ik0Ot
	6S6uK1aftk3GQjbEGUTnh7cnRtOsm5xur1QFVw5egWg==
X-Gm-Gg: ASbGnct6fYPwETVUlprLowHXOyG+m7mO8CODIJzJAgxacteMNlgP8XyRYWoyolZQ4z8
	aKDzmpxAWEHJGn/S8fj5FW3I1El02LgV+Rz3u7ee7AdWLf0rHqbRnd60a/nd4MLtDcAqFFAHVr+
	Qg6uZE1c/CfWmOaIrecgOY+u65TUMKmxUl6J+9ahY1sGViU9Lc650NYwfL4ovZfmsWDNsYqOoZZ
	jhNPHyJCC+4L4cqcAUebrxV3Mx0pPgXSsmgqCYDXmVZ9aZvkQVuhP3XRiO7knGolVqvOfb2roX6
	h4M+Fg==
X-Google-Smtp-Source: AGHT+IGdKr3biW2aMZhYy7DvL1RF+7Uz2kpvCtGXfJ2OgvOVwI6zfxqRAu2DSnJi2xHuqa0EQrFVKg9nUpOsh5XjgKI=
X-Received: by 2002:a05:690c:55c2:10b0:787:deea:1ba8 with SMTP id
 00721157ae682-787deea2334mr150764527b3.50.1762857587612; Tue, 11 Nov 2025
 02:39:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029-gpio-shared-v3-0-71c568acf47c@linaro.org> <20251029-gpio-shared-v3-2-71c568acf47c@linaro.org>
In-Reply-To: <20251029-gpio-shared-v3-2-71c568acf47c@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 11 Nov 2025 11:39:30 +0100
X-Gm-Features: AWmQ_bk198TBC3PdqVd9Oowwqb_fFWVruyMz7Lubn4P_lvSkb0elFliKm8IlGq8
Message-ID: <CACRpkdYRzuumaCv=a5UL_G8StQj10kBiRfkfrpWCk05zVfGYsA@mail.gmail.com>
Subject: Re: [PATCH v3 02/10] gpiolib: define GPIOD_FLAG_SHARED
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Kees Cook <kees@kernel.org>, Mika Westerberg <westeri@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Andy Shevchenko <andy@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Srinivas Kandagatla <srini@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Alexey Klimov <alexey.klimov@linaro.org>, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sound@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 12:21=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl=
> wrote:

> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> Define a new GPIO descriptor flag for marking pins that are shared by
> multiple consumer. This flag will be used in several places so we need
> to do it in advance and separately from other changes.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

