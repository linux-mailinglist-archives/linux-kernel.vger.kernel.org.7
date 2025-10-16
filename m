Return-Path: <linux-kernel+bounces-857011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 175D0BE5A59
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 00:12:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96E2D19C50C2
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 22:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58D822E5B1B;
	Thu, 16 Oct 2025 22:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eOZnyuRT"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B082E3B16
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 22:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760652748; cv=none; b=Ycm0jHUF/sBN/vTIlB5l0/LnJy6XQhJdUUD/E/QNYFjvjSb2u5bsPFbtsskFWXydIzY949Kl1jdYFu7N6Dv8QtPQOdXSGmwshT+B1igdSXebM1eX1RTsg+Le6LZU73I2RUfsT1zcc7IETuo6dF+CbIWbMfkIB2mHRdlErtx92bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760652748; c=relaxed/simple;
	bh=mQg/ICgMWrNLJ+qVKDXr+wEji85IYihnhnnRuN0F69c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ahVBo2/IDZgR/+7zK8NsvTWQi5FLsYqsP7boapcktqHkVkXYA9qFgE2RphejH5lchT56YAC52zn6d/TG4u0YaoSLjWwVMKyETx+s5v208sv1IJr4UKVmNGYWVKJcuO4+plKwQ9PmuAa33a4x25RKSB+dKj+C1WNDm8mI884K7xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eOZnyuRT; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-3696f1d5102so10389371fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 15:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760652745; x=1761257545; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mQg/ICgMWrNLJ+qVKDXr+wEji85IYihnhnnRuN0F69c=;
        b=eOZnyuRTjvaSscSdThine8D4RUysMa/y4xxZ0nzfuSRe2qs/xf6tNsiBCd/VViTc+O
         y6lUR/Uibu7xA79mWeQL96jYOELf6Z8v8OKFQ1D/DCnrfkzRiezC71Isodu74Sg4ATqC
         Q8vevtAzxZwUj4p6ar3KIPsZkxn/REV+CQB+lL62dDfndxpn2Dy+05nlQn5SUVn79bOu
         cltZVqXEMgyJeOSXKd3Lf3kA0Q1SZ5rrvR+Ki+XOHESaQCSehJ94jWYxfPVNOWxUxDex
         7d6U96Wz5JCJaWUlIRxSZT8sDxIN+JCrWaIDp7pjuQsTYaK8z/VmsRKmtV+8yANEo507
         p87A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760652745; x=1761257545;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mQg/ICgMWrNLJ+qVKDXr+wEji85IYihnhnnRuN0F69c=;
        b=oR8pQ1vk3ks0ADZUv55z4C8dr+sG5YdWV3eupel+nUdfmwqHCD+APnjyZDXxNGZq3t
         m5RfJ66DaYU9P/cQ36J0g0BCFBjVU7Erl+75PG5szOnDGnfwDmXc7K+6Ndc0lFa/cYxX
         E6UvZknvbYlmb8w48jl18A0lPbGX/L0YixVFnFfDhFzMgLA/Zk1505+yc6XJfWt6Zy7M
         rtG0y7vNCGfBDh+VIhXSnvAF+r18RQL0aZ61nVF92NBk1BJyXJd7izVM32IIUfXTUy7Y
         HwXjsdKEbs24s+hUMwE9kqI1zKtW18FqWvU/Rps3KMUTte3CWqT2VtNYFo95lC9ogjCm
         cxug==
X-Forwarded-Encrypted: i=1; AJvYcCWwy5Km1SNpS7XSaJ6pA5QDEGeli7w2e5Usemajp0qKVIL1j8IKTvKDCen3CjsJsDllyggc4vlZvHwwW2Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwvrqMJAXCPT62xPj25CDoXvrrGoiD91W1kA4wVbLtPMYqXLq7
	5VJ6kUZ6mZPFz58/T8t7f+K9bcmsTi4K/cUCq/21jtRo8u3dturQEo7h+8cwCgCb/4Y5fQKYTsg
	1vKALoQWWxwukdreTGnB2BnRqhPh+ZwHyHtWDHDb+Ug==
X-Gm-Gg: ASbGncuSh6AX+11mDabjHM6DDkrKrwEqDjwbWsp9fnOfGERlXeq78p0NNBu/6NZrTDZ
	BvzZ+ZJqWNkbjPI+KYuwBoOMUhS2VfykW1gH0JfXQcLWOYJvgDYBU1/RqvCFjtxoe2i1MwkVUQ2
	sG/s3Dgnrt4FiAwFHwr0KfNsaSvEviWg+myZZDGDUJoT7EGQAyu1eHzoNh+on5M4bj/rV86sBGr
	N7cUZApuniU3sLhzIft8zT4l0mnutJn7EOMk40F2kuAjTHz81SM4mUNfiQ5PXmAn1DbvB4=
X-Google-Smtp-Source: AGHT+IETNEjPulnwiJEaZdRc0wH+lGlrNLWsrrUjpY6RycGygjNZ/Td0MfEPQ6uNRg6Pg81UriqqHMCpfUkXWgv3ujw=
X-Received: by 2002:a05:651c:1595:b0:36d:501:76d5 with SMTP id
 38308e7fff4ca-37797a0e6fdmr6276421fa.26.1760652745154; Thu, 16 Oct 2025
 15:12:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251009223501.570949-1-jelonek.jonas@gmail.com>
 <20251009223501.570949-3-jelonek.jonas@gmail.com> <CACRpkdbCw1Agnsy-aYPs+2PhQDFjj+=VjmGQBmxuCUfwRuWkfw@mail.gmail.com>
 <22a84772-0e54-4b99-9bc7-59e7e4633807@gmail.com>
In-Reply-To: <22a84772-0e54-4b99-9bc7-59e7e4633807@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 17 Oct 2025 00:12:14 +0200
X-Gm-Features: AS18NWCQeU3PRrgCI-45m0Qnjsaps5imw3vWqXQ6TlIlAkiw0OaRW5Kow6BCtE8
Message-ID: <CACRpkdZ_UjOBv2JU3VfWZYa41LcAhRmUzQCpni+pJViFRjvFTw@mail.gmail.com>
Subject: Re: [RFC PATCH v1 2/2] gpio: add gpio-split driver
To: Jonas Jelonek <jelonek.jonas@gmail.com>
Cc: Peter Rosin <peda@axentia.se>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-gpio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 16, 2025 at 5:37=E2=80=AFPM Jonas Jelonek <jelonek.jonas@gmail.=
com> wrote:

> I think this doesn't really simplify things her. As far as I can see the
> GPIO forwarder is more targeted toward 1-to-1 scenarios, requiring some
> (or even more?) "hackery" to fit to my 1-to-many.

I see hm OK you worked on it so you know better what
will be most elegant here, let's see what the others say.

I'm curious what v2 will look like!

Yours,
Linus Walleij

