Return-Path: <linux-kernel+bounces-728041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB59B022ED
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 19:43:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D68BC5A0DF7
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 17:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB5732EA480;
	Fri, 11 Jul 2025 17:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P5sALd14"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D4C2EF678
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 17:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752255809; cv=none; b=mKDS5C/jbEL2w7tSrrVi3uVkt9hvUSzLO5BIw0g5+vM/1naOfddyttRwA9Pa908rD4uHrgGst0yPweuSy/vaD6UPMvf0G180MFaPadC6tVID7QMuNMyiaV992YCg6FTC7aNsiBqsOLPurMKghmfI+nem+ESYNygDjl9MCJy3YEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752255809; c=relaxed/simple;
	bh=hBYyXUMBd+7KXf34imR2vb3TQVXmdkbzzqR23++a0to=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kvOej42u5eSBGj6BHY0AQcTwDlyqcJzTvzqikNvvu4MArtFf4/NC6crPiDjEXrbun+gwv7CT1Jo+1Swn8v3RFfg3eJndOBfsRrTsq+xQ1PaHzheORmF0uoK4C9IyAt8lqlCsJFjZzGZ7QZ5b5+ncFRTjrJsGCIEXci6q2mIqQbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=P5sALd14; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-32b7cf56cacso23582971fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 10:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752255806; x=1752860606; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hBYyXUMBd+7KXf34imR2vb3TQVXmdkbzzqR23++a0to=;
        b=P5sALd14XNbfOraaZippyyvvJXpbWOlAU5nO+afk7s7yLYJw24kSzsYAiuTPKvzQC8
         CBFmcM2RViUJbWO+LfxuJJTBgv/smsARjb4LSVbpMgnXAoJxaL7mzmB4lXDpFj4l7CBG
         0selz+dpObX6k5NV7Kljs7QrP9yPaalyHLvHIuKJ8mTbaGNKbGrOzNVGpcb3F11gG2KF
         A3b66LGQae8DqaQltjlee5iqvYvuUXWqOSxQ3bc//btiHsVXTrXNIM05aoDBH16Lk6Ur
         U97IQRhVw1W3i/gYXZM++gvKBYYfhIKwl8ybOmXcfbNIJXKSEB2nfBlgREXUJBBPzCWI
         vZYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752255806; x=1752860606;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hBYyXUMBd+7KXf34imR2vb3TQVXmdkbzzqR23++a0to=;
        b=UmOt+ztrCSb7qha/U0+YYXA7mu2qaa/WGelg4wBweSIPJ1MTjL9QGp60+pP3z55Mpt
         pb6Wi2Yuc4jGafHhKxwkRKD1kIkSc3TpMg8wJZwJ4EPzu9X8zFjmeS/8pgYbbJhMH7+r
         hAfpDxVn5cOPAfQJttHD8wtun6fWSW1CAveDIhMF8KN7VZsDJmhuCZ+RuuiW5kJtc/RR
         QyXcuvH/YgCzeV3es35dm6UkfK447+WPTmCfIHcT51DozWN//p4kiUKUKT1wCNb+xCEd
         f0E+WtEeYsHzATze4WIbsBd+/msSpvS4bashoIq/dxK6csL2ZYJHOXpiM7DMfN5/NqOk
         KYPQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0iqmGBVYS5YvnaG6K6qL0bW6kgjcNw6jQxOJbdQGkPKs1qTZpruZ2YTeFnZX667HxVQfmNO/kVi7CyZM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3aHzdjr6z95pl6UK1KQaqm8Cnrpq6usVxeI0C5oHtwfmjbGeU
	/ZjKHErnxkU3QZGqonc9RcRPp0YACIHjtTIi/cyG6XBf01X7rhDYcbIIrbSbRHj1v3r1tUa5kW4
	APXYjAId0Z0NfnXMneZAXo1UOTzex5Rw644mLggMdcg==
X-Gm-Gg: ASbGncvGCt1iCYTCEJFMZsRFdXLP53lLJAcMakD/RtsG36mU523wLUpsVDw25BdqY+f
	nk2AbC6pLC9RTAXLB3HeCqyMZhA7bF4iFf3eHN1mrNuPkgOVcTh3+QIj/RdHNjFr6hpYW3lbGU6
	U4tXoVjZGEkMIcNGPUL4VAxrEsFUV8b88JvWpaT2OkaXcm/Qe+UrU6GtUncXYbKwPxmW6yamJBJ
	dJTGTg=
X-Google-Smtp-Source: AGHT+IFf2G+BjhVwnAaVKOD3baeNQou99YqKL5bnStqK1N6hwpimUlctewJeISypbJUHXx97EBEN1zE4x7sNQYPxkrQ=
X-Received: by 2002:a05:651c:b24:b0:32b:82bf:cc53 with SMTP id
 38308e7fff4ca-33055085f43mr14251531fa.31.1752255805688; Fri, 11 Jul 2025
 10:43:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250709112658.1987608-1-ioana.ciornei@nxp.com>
 <20250709112658.1987608-5-ioana.ciornei@nxp.com> <0d0e9cee-2aaa-402d-a811-8c4704aadd74@lunn.ch>
In-Reply-To: <0d0e9cee-2aaa-402d-a811-8c4704aadd74@lunn.ch>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 11 Jul 2025 19:43:13 +0200
X-Gm-Features: Ac12FXy8ncwT9MizP5dA-KS5LUC-_phaq4FRA0TbkNqcyhAAKnTK7Oh5Ed2WmSo
Message-ID: <CACRpkdYDTXA7+YN2zRCsQxu2AKEAwbDVq8-m27ah5XTw9iRNPw@mail.gmail.com>
Subject: Re: [PATCH 4/9] gpio: regmap: add the .get_direction() callback
To: Andrew Lunn <andrew@lunn.ch>
Cc: Ioana Ciornei <ioana.ciornei@nxp.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Shawn Guo <shawnguo@kernel.org>, Michael Walle <mwalle@kernel.org>, 
	Lee Jones <lee@kernel.org>, Frank Li <Frank.Li@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 9, 2025 at 5:09=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:

> This is not my area, so i will deffer to the GPIO
> Maintainers. However, it is not clear to me what get_direction()
> should return.

This callback should return the current direction as set up
in the hardware.

A major usecase is that this is called when the gpiochip is
registered to read out all the current directions of the GPIO
lines, so the kernel has a clear idea of the state of the
hardware.

Calling this should ideally result in a read of the status from
a hardware register.

Yours,
Linus Walleij

