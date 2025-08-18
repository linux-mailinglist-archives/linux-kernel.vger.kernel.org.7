Return-Path: <linux-kernel+bounces-773963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF07CB2ACEB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 17:39:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06D1F566993
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 15:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9392125F98B;
	Mon, 18 Aug 2025 15:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Tu1frsJp"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52EDB225D7
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 15:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755531444; cv=none; b=tY+gIpWIXpSG8s00IoRAu2gsC6ORLhjMzQjxpjF+z5Wtt85fr5ychySc6jzfEECMJGsPeT6JhrvsAn2h0wlKh9dMOwp/QWO5Qx9A1UAMxqNUhFiJ6IqpndjI84MUJxEEv1j8+jiF9vOjvfmeZjT/JrB37y/q722ZelKg+3wbolA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755531444; c=relaxed/simple;
	bh=zUAzaEIJ5VMfDRyaLBauOj1IcucT6KEg1btGJxZi1MA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qWVcwTIN4j0ox4vmmBDB6j5fh83S4ZEs/fweYoTxG5jB+VVzjWu3vZ0ewwnkf1VH5EOIHQp78dqz9CnnWGsYHF8TJBvNeX+Mir25cdGObInCn48FQhw8os9VKoC2bHXxmLkVZd3gq08zvy2leiR48ZksNhdDonsjGhMxKrbJ46U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Tu1frsJp; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-333f8d387d6so29108801fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 08:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755531440; x=1756136240; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zUAzaEIJ5VMfDRyaLBauOj1IcucT6KEg1btGJxZi1MA=;
        b=Tu1frsJpFKIuD2HBPbWhMEcBedXII/ApZ3TmPnE0BcG5ACP0VmvGkaSu864s/MLxuC
         S+dNANnCZGRgFBY0H/GLTamBYCzuxLui2B4VW9ygUzb8bwN5Vinvn0RZX5Fyt2Mc9fzs
         3UY8m3tT9A5cDx9OlzkZxyuJuH8zQn4v3hJtTGDhW1p2w9P14q9qe+H4G6pUE8BKvcvG
         0iVtTzj/3fTMvP9S6LzgBWaSt7im54nvWMSBrmIew+FardCLSiXeKyE6xLg8Tu7zkKaG
         aJWSTNtz2ulEHNwTkxDLKSwWJUtRS3hyZmSDN4rbUfTL5sx8bFWXQl47RbV9lqb1ffH5
         Ghig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755531440; x=1756136240;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zUAzaEIJ5VMfDRyaLBauOj1IcucT6KEg1btGJxZi1MA=;
        b=OodonK05kJm9OPe5o1ayY/SW3IRIPrklWfxlK11vwpT0yq/3RqYRvmsfqKUHrn9jSG
         IHUsT2PeojYybW9zQimvV3Op/7k0WyoEkvLj3wxVyA/0KPzv9KH25hgzLPQKk9PHAZ7a
         LVfG4sFIfYxKg4xcHy8NSI+4twtgYZo+2BvgYDIN2hORx7r2j1pHYNJrTYGbSuXLn6z/
         ZbqBgIYNtqgKf/sHH9ijsgP92kOC95bGCeqy4vMMokrLOGZqlcZyfb774DMv/SJMIOEl
         LBUsdlHuKyKck/A/izrf2dowcIRfPA8AEq5H8B2JqAZ5rWYfuXvsruAMZ0mLoZ6HIan4
         2wyA==
X-Forwarded-Encrypted: i=1; AJvYcCXi2GssK0IXoPGJyF6QbdSh6xo5+k0Yfy1arrE68IQniceQEjE0IXO8+MR6poZH9PoodSUdVCmdW7wQnLk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKZ9flOMjNPSw/qvZ3yb/ERdIX5d4J/z1w27VcEv4WPfzYLtAQ
	bADoVFa0NS8PFhR2hNPcK2wrGQfI+w6hvO2QrBBd4YUr4Vx4IMAZWjqP7BbiVLSKD+Wklkf4sHK
	FV0FxkJPBBZlycc0jndChhRmm9I5oyXkJGu7J2LenVw==
X-Gm-Gg: ASbGnctxddKiBl5EfuHYZhoHOE9YPNPgxD20U+cKNLrsJ83WidfL8ldMqJ29SgKmRnN
	aYLfdhBfk6V/6WTWWWveyKzezUDwhI4lhBzVhcdyMD3pyUyZ/8731h0FfeumPlohT9IrTy87NJU
	lCnz+BglIjc3KGLkbxteRsHeY9UB1kaW2Jlbsrmi5qKaGjl2QjiTuLjsqMUuY8XSHR9bgRwmKQN
	wfc08E=
X-Google-Smtp-Source: AGHT+IG+GVJK4tzT6ecV7Ro8lqSck4UpyGZZpSEzRFsmZpSpnYahkHkhTdkt4MWZBGxnnEyxsT/xMtxcYazU23WLelg=
X-Received: by 2002:a05:651c:1503:b0:332:1c24:d33a with SMTP id
 38308e7fff4ca-33412b8af4amr28525231fa.3.1755531440277; Mon, 18 Aug 2025
 08:37:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250808151822.536879-1-arnd@kernel.org> <20250808151822.536879-11-arnd@kernel.org>
In-Reply-To: <20250808151822.536879-11-arnd@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 18 Aug 2025 17:37:08 +0200
X-Gm-Features: Ac12FXyuxmUcXP36pNiGdk8Vf7slpD6KEC6V4qN7-65Nz5kxvlVVKGMXuopzvk0
Message-ID: <CACRpkdZS1uOMsT3h-kyNQVrVW0R+1mmmOB=EAmqcHQSpo4qAYQ@mail.gmail.com>
Subject: Re: [PATCH 10/21] leds: gpio: make legacy gpiolib interface optional
To: Arnd Bergmann <arnd@kernel.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, linux-gpio@vger.kernel.org, Lee Jones <lee@kernel.org>, 
	Pavel Machek <pavel@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Javier Carrasco <javier.carrasco.cruz@gmail.com>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Kees Cook <kees@kernel.org>, Anish Kumar <yesanishhere@gmail.com>, 
	Mukesh Ojha <quic_mojha@quicinc.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Dmitry Rokosov <ddrokosov@salutedevices.com>, linux-leds@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 8, 2025 at 5:22=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> wrot=
e:

> From: Arnd Bergmann <arnd@arndb.de>
>
> There are still a handful of ancient mips/armv5/sh boards that use the
> gpio_led:gpio member to pass an old-style gpio number, but all modern
> users have been converted to gpio descriptors.
>
> Make the code that deals with this optional so the legacy interfaces
> can be left out for all normal builds.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

I like this, it cleans up things for current systems so they do not need
to carry around so much legacy.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

