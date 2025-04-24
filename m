Return-Path: <linux-kernel+bounces-617873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 138CEA9A71E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Apr 2025 10:57:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DE0C165609
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Apr 2025 08:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B63DA21CA12;
	Thu, 24 Apr 2025 08:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UoWjm6t/"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4522921C160
	for <linux-kernel@vger.kernel.org>; Thu, 24 Apr 2025 08:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745484764; cv=none; b=f+x/1FN2wnzbUG71XOFLj8vWXjRjqePW2hX1xw+9kcLR6a/isWTbXj/7HRBQzd42lV9IdQI0e8cVzuCoZEMtZZ7T/AXv1/oSKzpjOgyZp/uJGoLKPaB7X3dkM7jcQj3QYJcgWM6x25cZjH0CvyzJNTo5QFqwcDl1tz3ep1RlR70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745484764; c=relaxed/simple;
	bh=Pi6I9/2PW0WKwJeejN5o1HPNrvvIUYugrgLnZZJ7Pu4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rg3zi55ehmTKUaRioFYUWCEDMKNyvu8qd5zui1jzEdfXy9RCUp2O6VkusjmdM80mnSUF/8xOjhnyQ+uQckhSxLIycpWtDL01MeN2kjFsXAo4gr55mn2kiy4x379MnDShA1icbbaMLZZjuChgr190moE3QTu3Q3eGzUh3MnZAee0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UoWjm6t/; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-30bfca745c7so7457431fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Apr 2025 01:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745484760; x=1746089560; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pi6I9/2PW0WKwJeejN5o1HPNrvvIUYugrgLnZZJ7Pu4=;
        b=UoWjm6t/7GFcSlKFXXVAASTECkjbjSWxVKDre+llaetfJy3w0ECIm235ucR3XvunVe
         hqm2Qr+Jm15HA0RcwhY/ZwqfOwWxo+SantdGnm2Mz0LnDdeH08hksMWfzo3M0PangW6u
         7fHSVCajeZXO/ZnFKyoz1eM8xQkhlYhXywe47Nf7ApBcpRtnBx0X8udLf9NiGBU1x7oR
         GvKNdCoKNcGTB4cbsoQz6gweTl4gJc3e9NhRj/Xkn5FRuK9jaOcn/F8roItWBX+cs0iz
         D6ECAnlVPtSN4lMjF7DuLAm7bi6eyJ/CwhFSskHne87mo40vlYMB/W7vlSCiAF7qle42
         xv9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745484760; x=1746089560;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pi6I9/2PW0WKwJeejN5o1HPNrvvIUYugrgLnZZJ7Pu4=;
        b=OXfIVqweBoK7bH+0A9gq7kpFpRDH1biMssSYYMm+GqeTxXVp+/0TcTZWQrm8SP3QLF
         U0KfpwufIvOt+cP74BF9zA0zK3S6HjrMOPHJlMxJxwOUhWESaKYbC9bLOi3m6dCXmPsX
         n5lJPmzaKQ/q7dQSmCpUSngs63iQi8vW5+QUs5SbX2LmrJnPTNSWESCs5au02B/sPog+
         N+NtD+w47BjX+N3shKPP8HzvqT96rIfbKBd3ok9r6ucy8LfWD+2VCYK7zMqlyH99571z
         O/ohmaoOS05UK219NZB74tzb9x0w54VUNq3xdwq62P7Tc1x5qIXrBafSzrFPrEx4Hxn8
         qfzQ==
X-Forwarded-Encrypted: i=1; AJvYcCVUROjGHIVcrQ2agkEHuHoilKnFubcdrmcWQVbjqx2uli7nCqceFqVd9gtPXg6IhrLrL0El+L3BvuZYdk0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSRZcSW2LwFSsYhKnBw+lLPRW341vZdd28iAXVfrXE/RqGwb6p
	+P4BkNEn5vZLInSINJD3P4Q73ZCe4aquZfOz3259k+V37vn0XPA9Lp7djmmj7p6pQEr5yVgU0Mc
	DUPJuivGeXxF1Iv7ryPvXNTgHtR//JxCGBJ3jpw==
X-Gm-Gg: ASbGncvvyzIS1GODy5BWdXzPHuvIjcV2XGQouI01+DR8C8gVlcZ1oHJfrRROMmcqSU6
	xlGpSCkcLxwQXp1UH4UVtTTlAQRZYXvyOae28FCqS4ts/er2aFSgTReyCL8leuImfpBTSn+fgSq
	9y/7d0lZrO5lA/yFoSV07L4EpnAeQVXSET
X-Google-Smtp-Source: AGHT+IHAB9LWhYEooDYo0NS7+cNeVroUrJMiu/TtDGjCg2QMPYKVyjyzVDKPg2dN18XgA6c11bYigJex/WlKFNej81k=
X-Received: by 2002:a05:651c:241:b0:30b:d022:2fd4 with SMTP id
 38308e7fff4ca-3179febbfeamr7382591fa.30.1745484760431; Thu, 24 Apr 2025
 01:52:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250408-gpiochip-set-rv-video-v1-1-200ea4d24a29@linaro.org>
In-Reply-To: <20250408-gpiochip-set-rv-video-v1-1-200ea4d24a29@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 24 Apr 2025 10:52:29 +0200
X-Gm-Features: ATxdqUGMaYSVPrnrhvuCdxBcM9tsozWah8p2gB0BcCstcebhaxaVqziqhHfQoJY
Message-ID: <CACRpkdY0d_a8qzN2bJD+yzZ0P_twwPM21yV771YoABuVQzXAUg@mail.gmail.com>
Subject: Re: [PATCH] fbdev: via: use new GPIO line value setter callbacks
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, Helge Deller <deller@gmx.de>, linux-fbdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 8, 2025 at 9:43=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.pl> =
wrote:

> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> struct gpio_chip now has callbacks for setting line values that return
> an integer, allowing to indicate failures. Convert the driver to using
> them.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

