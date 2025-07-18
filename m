Return-Path: <linux-kernel+bounces-737304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F12A5B0AA87
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 21:07:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A40F2AA5454
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 19:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 443F420101D;
	Fri, 18 Jul 2025 19:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=criticallink.com header.i=@criticallink.com header.b="eQjkb3a1"
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1361F4C9F
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 19:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752865658; cv=none; b=R9t/SGNgBMClSxL5AAivzRWI4DM+cbwsnpon3kh0WyFmkDdCX86VdGgmCT3uocbGupqNwp8PuK9OjDNl5UkGCjoN4PI4oraEvZDnq6dAJxAfYDV2xufDu+JiVXtmwaS0+ilhBsWFklEIR7E0wyw5HOyavQzryK7WbzP8j3O0vXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752865658; c=relaxed/simple;
	bh=gKMAOL4E57ZrKNppROw+hMC5sdw+R+Db64LcCmKnZpw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nlMFU6sV8pTDdZsezG2kLyIGiJLVdy4xNEnRSlcEhWGE8P87qAWXVRIhghhZqYVgzBIcoDaFaY0ZkkCc0o+HA9su8oApOgJAkT2kjVCCA7fcGH4tK5V1T2iPt+A5Ihomi8TKEOnjdeleP/mWLyuSU8Xkc+52y2zt5xSJ8OS6Rrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=criticallink.com; spf=pass smtp.mailfrom=criticallink.com; dkim=pass (2048-bit key) header.d=criticallink.com header.i=@criticallink.com header.b=eQjkb3a1; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=criticallink.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=criticallink.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-718409593b9so26739767b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 12:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=criticallink.com; s=google; t=1752865656; x=1753470456; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v1R+bTONl5hHgbwB0kA7IlpGtYJMtSz84Mc+5SeI9Qk=;
        b=eQjkb3a1Uuqyc+c2/wrLRa1AEaxlXBUVYSs/LymUkid80XcSJg8p9uqlW96rsbvRjv
         rOfgpJE0g70CEkopF8Lv9FwIfVPf1O0D5u027rId15C063vU+Jzy/Mic+YfvPpGQ6UIN
         7oqzeVlh+AvRyFsfASW/Zn6kok7ps8Y5u3yvLEAygrlpmNbX82RA6w9Kq5YVWb72Gl7e
         F/0SETGpJ2h2inwrp1hmSbFfwPi2TULmI82gwoWbWehf8BaNmpQthtv/NP2zv36prJYD
         EMgblzdnb+kXzhnzdkm7MQx3pXKYi1FNSMDl+xdjv59A5/T54d4T5kfXmmdXCjua1FT6
         Izlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752865656; x=1753470456;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v1R+bTONl5hHgbwB0kA7IlpGtYJMtSz84Mc+5SeI9Qk=;
        b=NyjRWkkda2ll5b6Ukhsn91zyx6lc2QSxlQfdZqlVYWeuWKu1QUEc3pXVGtuLZhqvTE
         ZVFBLw2kr/HI4n1Z9naStYl5xVAC+K9tyhTn8TCr0T0YaL4ChJDSbzKssmDY+8ccSPde
         RjVRTt6+1HzPlG+MZ3hcIFNQlCeH+2oBEcEWb6POi9zfFtIakVjll8Fgw+xv9zGsOw6S
         nwWHxWxwLpBNVhk19PYtb19ztdxe4JX15Tiq9t5r2eXVbKNvch5eZVujpNZbzZs0vRC9
         T7ILX53flytFyVTAtHahOo8iD6mBhN+iZZ0KyRksZTqRoO3OSydBaLytdcRl5nkVQT34
         XTuw==
X-Forwarded-Encrypted: i=1; AJvYcCWJevSGNqwtNXOGoE6/VzkF5xyiPe0uhiHM0fLCCuYG2uh616wwbi+6U2Rd77gHN+YLlD43XcaHw1k+XwI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYBiRhCUhIfJvJJKNvfs4MKKfF8nW6CjhWz1rQ1WvS+WkShueg
	3jkyWrv1IRU5v/GMG1pHGgZZC7tn6DMpHd+Owq7am0GVCXMf3Vnc5A52FrfRbMJW8fMFqY0lZIX
	IBPwJMQ0fGdNuKAsGGo5JYsW+/M/PqWKjrZGkwIOc
X-Gm-Gg: ASbGncszoCnHDU5un+zOD+4gZViX4pqm5XpvVXg6OV9+xy1AL8fgX2aqkB+55EXIyQV
	/ORtTU0FP3p91Xv/z7tgpdkp85JbQya4YfGjxI5GyA9dbBGMUU4Uo2zrzsGDl4A+J0q9/4H9zQQ
	jtDv4N+Lgeksl8BjUAoIOgYBiuklKOjtfdokdnHLC0JUlVPU9PaLLtABTyQvZfTVzJEYBWNSpqJ
	DDEnw==
X-Google-Smtp-Source: AGHT+IHdu2N0EBK/ErljdlLwrx3ILsLU6lMRBT2UTCrZLdQTvYgxzsQ0wmvhUzUAASF16uNQPk7dLkoRYW4KxZBs8fs=
X-Received: by 2002:a05:690c:6207:b0:718:38bd:bee4 with SMTP id
 00721157ae682-7195235cd63mr51739027b3.40.1752865655992; Fri, 18 Jul 2025
 12:07:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250520-linux-stable-tps6594-pwrbutton-v1-0-0cc5c6e0415c@criticallink.com>
 <20250520-linux-stable-tps6594-pwrbutton-v1-1-0cc5c6e0415c@criticallink.com>
 <20250521-wandering-tested-porpoise-acbef7@kuoka> <CAKMwjwTP=xSsX3UuK02sKbXWaU7y-ErytNYCL_P0UveDytQW2A@mail.gmail.com>
 <20250529-wise-tremendous-stork-a7d091@kuoka> <CAKMwjwQOBE651A-5VVjwcv5TspO2eNZfgwWzMpTTWxhR3nGKUw@mail.gmail.com>
 <0fb4b411-1b27-43fc-8d48-e5220fc85478@kernel.org> <CAKMwjwSZEhXav2U-bd+JNyVDK3JdJoN1kJjnxpfKXBKsW2XxdQ@mail.gmail.com>
 <DBEDT0OKPYAC.EX6HDQCKUWIS@walle.cc>
In-Reply-To: <DBEDT0OKPYAC.EX6HDQCKUWIS@walle.cc>
From: Jon Cormier <jcormier@criticallink.com>
Date: Fri, 18 Jul 2025 15:07:23 -0400
X-Gm-Features: Ac12FXy7q3q6U50Dg6MYZU_77NgvzE3OW9vAVUYRGRaaMpzgf6mgFEVPfckFZic
Message-ID: <CADL8D3bpVVrswNUvS5nSeQYuZbyPOfMoMFG_JrPSFb9YkNEKdg@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: mfd: Add power-button option for TI
 TPS6594 PMIC
To: Michael Walle <michael@walle.cc>
Cc: Job Sava <jsava@criticallink.com>, Krzysztof Kozlowski <krzk@kernel.org>, Lee Jones <lee@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Julien Panis <jpanis@baylibre.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-input@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 17, 2025 at 9:58=E2=80=AFAM Michael Walle <michael@walle.cc> wr=
ote:
>
> Hi,
>
> > > Someone knowing the device should come with arguments whether
> > > other states for this are useful at all. Or not useful and then argum=
ent
> > > that in commit msg for example.
> > The other states are not useful for the kernel. Only the push button
> > has a need for an interrupt handler. The other states the PMIC handles
> > on its own.
> >
> > What exactly do you want me to change?
>
> Because the driver isn't setting the configuration anyway, wouldn't
> it be possible to read the config bits (Register 0x3c, bits 7-6) to
> figure out whether the pin is configured as power-button instead of
> having this property?
>
> I mean, the correct config is likely stored in the NVM anyway, and
> reconfiguring it to another value seems unlikely.
Currently, the TPS MFD driver only loads the power button driver if
the flag is set.  We could put that discovery code in the MFD driver,
but what if the system designer doesn't want the power button driver?
I'm not sure auto detecting it makes sense.

We are basing this on the other TI PMIC drivers and how they are
configured. I'm not sure I want to reinvent the wheel, so to speak.
>
> -michael




--
Jonathan Cormier
Senior Software Engineer

Voice:  315.425.4045 x222

http://www.CriticalLink.com
6712 Brooklawn Parkway, Syracuse, NY 13211

