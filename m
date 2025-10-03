Return-Path: <linux-kernel+bounces-841077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE4FBBB6354
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 10:03:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79F643C64C3
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 08:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 666402641F9;
	Fri,  3 Oct 2025 08:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="anGi7FIe"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE52B14D283
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 08:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759478612; cv=none; b=RoZH73ntF1OXpqRsE3VnEpKEm72RhsEUldyZRpGwyTqJ4zXY9CE+6yo0Ig92+AN97ndZptJUflOQRtyfIgQHj+Fl6gYMVKc55fIDapvejp10ultP/wgrnZKM++CYnyJ0Cq5ImvqOv2oqeBrEi9sI/28I5cfHkZyNfDUVg52h9Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759478612; c=relaxed/simple;
	bh=Tn6OdQEr8XVdAqEx3+HNvbieAPgE9iCGbOGXxcvqocc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kkVlgvIS0moes8T54dMDTgUUqAGbaPHRT8UZ9HgA4pvCkjtfe+L/TEiOBF1BCuPiFyDFA1bQbZ4XpCmIoNBUffTcTl0BJ3sduqq4Oe+UVwijpM4GMdqBmIogte07vFQOwoOdMGLzJX5pciDLcoXw55VdZieBIdobobFaO3iXo+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=anGi7FIe; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-373a1ab2081so16215211fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 01:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1759478609; x=1760083409; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tn6OdQEr8XVdAqEx3+HNvbieAPgE9iCGbOGXxcvqocc=;
        b=anGi7FIeHk3rhZ/71lHGwH6BHBNm2Mr9ymqRKp3iSsnzYKi+4Hx6524fKGjCtupHHr
         9v2+KbJge8rndvU4sT6zMcIgrqMevaGlA577wK++Siyb546laVFqq6xRd9OfWeslwAZq
         6expFd7kzFGzvBgnlfbu+eiT6QrQ1SuQ+HdNojiWHp3OZlkLPnYba8qG+K8ZBB71XOSE
         cUh1MYzD+uxwCJ4tZY/aI+IxylWDA/auEPGiqQqfQ+ybkLmY+aAcGkxweyMrClMF4Ohu
         YCB9WpPFzAmA6KHvYxYjeyOAGKgCtfjsI5Nn8Chi3zfCrYJyM4b8MTon1oNKBlhRhFBw
         7JDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759478609; x=1760083409;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tn6OdQEr8XVdAqEx3+HNvbieAPgE9iCGbOGXxcvqocc=;
        b=ja0jUoPi3K4kcIjqDfXVAgtM7ipl0fLhgNH+grn175kaKAEErv1fccRozcRJXvm0oW
         nT/Ik+5ZoilHMfYj7DSFKtkp3Wurebiq8lkgDOdlh4MfN8aLCPxwyFxSp3CyCkwaBO6e
         QnC+NRDD3GBfrjDJv5YiWgINvgZZJErE4uOJAuokl3wnayS6mHZQR/9Ujrmfn0J1YCcS
         4dxPfrrMkqBrkalZBxlPrGDZGynEZymtc47KYr5ieIp8Zzk53n1ZlXZjuMsg5IucECpZ
         5m55C8Njvxh/2PKIs/FwYYXMwX24wlCu5ow8EcfY5keUa1l37j+/U536S3TazRpr1DiU
         JbFw==
X-Forwarded-Encrypted: i=1; AJvYcCWk9GKITDsfRX42S3QG5KSSp4obWIxKeqWNpwUByrNPm0J34Oapfqts3bxBtF3zpse+haE0c2vOMKB2iRE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjG3/ixzkKPbQFcxgOLQ29+OrDev/E0sx12OhwBr+TzOU4iE7O
	er4F+6PTqw28mhjHOycp2ZzAvS4AIxQwDTILSZ+zcmaY3Rv3X/TnpMJXfm24+90qnbTOkHz6RKN
	5AuYdDNUj5cMGC/BohyXMeqQqdXoXjfF8jiUJ5MGpAw==
X-Gm-Gg: ASbGncsc7sVkn7j1E9WNkWIG+vHTwoYOUHjYdnArc2sz7Mgdk3Rjc010HozSsvgs7gH
	0kA7G7eNIH7OJdvixJu0/ix/Z1C6gYXmHe8zaAt6Gk+LXpt5rwe1K/rMq4aBWRK5TMhmDy3x4im
	y9y1TKZLWzlVNF94r0t12WgWn33UFwQNIRQKQYEvZbQbQIBZhNeoCwNddjH19vtD6lUt6ipuJGP
	LrVSjEO9FieYqRyj97ZCaJfLym1dclToo94uKgN4WhEA8pJoc5BOPEDGdnQdAiFDM6g50gj
X-Google-Smtp-Source: AGHT+IFyQ5SUlbaZKyC2n/giNpyOPrAzduQsXL67RzSc+/XD7ohW54+y3L1jWlwiS/5sdocrcIvEn67wqltom/d/bVU=
X-Received: by 2002:a2e:bc8c:0:b0:337:e5fc:d2d with SMTP id
 38308e7fff4ca-374c37eb3f8mr6316451fa.24.1759478608652; Fri, 03 Oct 2025
 01:03:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251002215759.1836706-1-markus.probst@posteo.de>
In-Reply-To: <20251002215759.1836706-1-markus.probst@posteo.de>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 3 Oct 2025 10:03:16 +0200
X-Gm-Features: AS18NWAb_UicKSU3Hkbg1b38gS-dxjPWCSbdeYjPWZM22VcaOTqo95Y1mZFMQ6U
Message-ID: <CAMRc=Me3VLbmRksbrHmOdw8NxN7sxXjeuNFb9=6DzE=uLn0oAA@mail.gmail.com>
Subject: Re: [PATCH] gpio: of: make it possible to reference gpios probed in
 acpi in device tree
To: Markus Probst <markus.probst@posteo.de>
Cc: Linus Walleij <linus.walleij@linaro.org>, Mika Westerberg <westeri@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-gpio@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 2, 2025 at 11:58=E2=80=AFPM Markus Probst <markus.probst@posteo=
.de> wrote:
>
> sometimes it is necessary to use both acpi and device tree to declare

This is a rather controversial change so "sometimes" is not convincing
me. I would like to see a user of this added in upstream to consider
it.

> devices. Not every gpio device driver which has an acpi_match_table has
> an of_match table (e.g. amd-pinctrl). Furthermore gpio is an device which

What is the use-case here because I'm unable to wrap my head around
it? Referencing devices described in ACPI from DT? How would the
associated DT source look like?

Bart

> can't be easily disabled in acpi and then redeclared in device tree, as
> it often gets used by other devices declared in acpi (e.g. via GpioInt or
> GpioIo). Thus a disable of acpi and migration to device tree is not alway=
s
> possible or very time consuming, while acpi by itself is very limited and
> not always sufficient. This won't affect most configurations, as most of
> the time either CONFIG_ACPI or CONFIG_OF gets enabled, not both.
>
> Signed-off-by: Markus Probst <markus.probst@posteo.de>
> ---

