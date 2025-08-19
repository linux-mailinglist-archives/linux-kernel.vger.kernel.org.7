Return-Path: <linux-kernel+bounces-775645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68470B2C2D8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 14:14:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DAC2686C9C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 12:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9029335BDB;
	Tue, 19 Aug 2025 12:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mHCNJYK9"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1BCC334707
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 12:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755605587; cv=none; b=rhHasckro5m/MzJXkYIhf1UC4crhc7XdFkq+j9jOqz9fVcQdpcbuUTi+U7kELr6+YWSHvOKv1k7JB+h46IYdAaEkPcsI9veFhRzCS1qkjaPeetVPEmNS6Soy7HxK9OH9Ex0Yv2Vpus4UyXmm3V2MVWdOMEpJ6qp5Tl8vLdLgvvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755605587; c=relaxed/simple;
	bh=pT7J7NlbzDj0BcguaBhEfkoD9p8GgWTOtMzLwvbVkTg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SI+7wn0wswCY9+CaG7EDxF792RsKNDIKFHMhasb9zpFPk1oIllwgH1m+X8VrzRExizMHLcvSRtR2Z947zZW29UMZQ2VlBAyd5EdbRbzulYZNsYz1NmNP0UG8PNJD7FSWvXEHIV3Fz4APqf1gWlVxXW2Lg7eLjb9I46M+ImknyjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mHCNJYK9; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-333f92a69d4so39678611fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 05:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755605583; x=1756210383; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pT7J7NlbzDj0BcguaBhEfkoD9p8GgWTOtMzLwvbVkTg=;
        b=mHCNJYK9mo3J7JRL7LLBKUB3sm+8n3Q3l8jiZz0sUCZjmNqgbzNaoPsvT95gz2usZG
         JIfDa9o6DJFez5SH8sGgAmLxZrczNj5p3AVY8CoYQ7Nkgv7wns6D0Im2lRp4SyrJoEqr
         /4MxH2lYVm+c7fBP+30ozGd8P+tsXRBG9sp3W99zB34rxxsZFdgVFQtgMmz6t4r9Gd55
         UjhuykSbX356y2He2eLaZR5aaY5CiChZn3IC09yPMo4DRli8aZ1HFyQGOycCk1Rpshd2
         GEZsSdsLtvYYEgKoserNhWOwVTjmiuQ7ej0l3Wak0CoXCZIH0irMRX3iHLppmvpcvvLh
         f78A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755605583; x=1756210383;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pT7J7NlbzDj0BcguaBhEfkoD9p8GgWTOtMzLwvbVkTg=;
        b=p7vOscXRaiA/IaVR8YRnRPYhlJuD5xOeH+w0tOImyHrYaq3q5/F4b7+1b4OCgctK+5
         WxrFqkqUiHY1rOHE4qwc9qdi8KLHOuqlcAgM8m3mXjajThKVqkxt8p6EvbyfO2tmAPc6
         FH1NqMCO/HZP2IMlz/fawALddme6edJkN8bNgGjkJLqgHEfkUlXzqZEnc4WWf65elJdu
         0zJnhnIOuQ1ReX76nhXimOFPU6gF4LPyvNvdiJFDHtOKJT8w0YSlm7pFgLTO7eo2jGlO
         MS6XKbse+aepMPQSOiCKzTIOj29iZws+4O5vOpGmj6KT1GdBy9BYCjud9Sgnqb6ut6Hs
         JT1Q==
X-Forwarded-Encrypted: i=1; AJvYcCUJkLvCLcaQsSvk//ErWOARkArCNJWTlVQZnJW+yFBf3Emjs0mgLdTsjOqJZyurarKSxBn0/Uj66cJmG9c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyW1bD364rjUNjZAUH2N62T+pBv+j97Y/4IptQS3/U4ikthvG6Q
	CD68l6g2QaOG99nJd3qzShp1ys842xrYZCbkKgb4Q+HOR4yI4SBdwx9tIlvfCNihXMM01obkosf
	d5gLFdtLjchTGIwEBX8PRlfDuo6PmecmzTkqKmjVIww==
X-Gm-Gg: ASbGncu2Ul+hz9JKJMWDEDOcMC7DGZadIC9ZjutceR8xgHYwzw98vVDMMKtwsO1EVr9
	rS0rPckjKcqrFbO8oLBhknmefNuzspuAWMjjiAdUTDq5xVrfa9UClYV8SWsIGRA9ynDGyoxWP6R
	UUtlO2ftydkAgn9hQfIv669nR/vq2LH6h4/cKUTK9ncBKqpA4BuD+Xq43bAiE67D8JCISf4KpQc
	i5ORHU=
X-Google-Smtp-Source: AGHT+IH+aPrIJY+DH1gxYk549l1vaPXfQI5WHK+rOHEK+EYvi2ju0qkAP63ibB4HjpirzJmCyfMVeLvlEsTbS+CROto=
X-Received: by 2002:a05:651c:3041:b0:32b:a961:803a with SMTP id
 38308e7fff4ca-335304ce141mr6002291fa.3.1755605583129; Tue, 19 Aug 2025
 05:13:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250814-ltc4283-support-v1-0-88b2cef773f2@analog.com> <20250814-ltc4283-support-v1-6-88b2cef773f2@analog.com>
In-Reply-To: <20250814-ltc4283-support-v1-6-88b2cef773f2@analog.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 19 Aug 2025 14:12:51 +0200
X-Gm-Features: Ac12FXx9DbzpmXtIaYcl4GeGqmQxe243v3rohATjse3LJ-Oaq4DA-z_79QbXSd0
Message-ID: <CACRpkdax9THwKRZmaAHVcKbnBdi1LxjgvibAFOUVnVQJBhBiwA@mail.gmail.com>
Subject: Re: [PATCH 6/6] gpio: gpio-ltc4283: Add support for the LTC4283 Swap Controller
To: nuno.sa@analog.com
Cc: linux-hwmon@vger.kernel.org, linux-gpio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, Jonathan Corbet <corbet@lwn.net>, 
	Bartosz Golaszewski <brgl@bgdev.pl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Nuno,

thanks for your patch!

On Thu, Aug 14, 2025 at 12:52=E2=80=AFPM Nuno S=C3=A1 via B4 Relay
<devnull+nuno.sa.analog.com@kernel.org> wrote:

> From: Nuno S=C3=A1 <nuno.sa@analog.com>
>
> The LTC4283 device has up to 8 pins that can be configured as GPIOs.
>
> Note that PGIO pins are not set as GPIOs by default so if they are
> configured to be used as GPIOs we need to make sure to initialize them
> to a sane default. They are set as inputs by default.
>
> Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
(...)

Can you check if you can use gpio-regmap.c helper?

select GPIO_REGMAP

git grep devm_gpio_regmap_register
for example drivers using this.

I think it can further cut down the code to very little.

Yours,
Linus Walleij

