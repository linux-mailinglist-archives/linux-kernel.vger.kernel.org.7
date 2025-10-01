Return-Path: <linux-kernel+bounces-838911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D6A8BB0682
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 15:05:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BB882A03C6
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 13:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D0021FBEA8;
	Wed,  1 Oct 2025 13:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="YUX3EtsG"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652CC1EEA3C
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 13:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759323897; cv=none; b=ZM3gQG1SXvbm1cc8AfqN6YxAbxYY330fiCUSJUjos2Q2iW11QlqNgvBDjTTteZEoWOJL2BFJoH+8S2z3aUhF+GS4s9mm+zD4dFMkvU5qWU77oyy5tCrAXoaUaoo6YGy28iPA9c1yTkYzJrT+IRi503Ry1YJPCGZoSnFvZ/8CIzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759323897; c=relaxed/simple;
	bh=Sd6yCdxS3n5TE903KsbIcaO2lzqa35LHjefQZurCtJE=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gbf0cRCmqB9ElbG1LcyekUuNDIvQ056DgOuMSzNID4TSZtjUp40kp1Kf7GFXl6j9Coo84ZILmP9pFYsuG0hnvc3QVQTV1IZf7GpjcAvAeOjtL6KOIJYb6VJ9ZO+hKwZ5csdBGLYFuFmQCFbLBz6RxqbDL+QKO4s1dkaM4S5b1Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=YUX3EtsG; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-27eceb38eb1so85672035ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 06:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1759323895; x=1759928695; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:references
         :mime-version:in-reply-to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FHbqmA3oKpic6IfyRvOOe8x31ZYEYEaGDwcq5aemMoY=;
        b=YUX3EtsGULfgO3jbr/yyY0xXUjnKvm9KSHwMEvLR29i5AfD8NVcNmxHTaeoWkXqDa2
         +fz7+eZhD0b7REf1FTf57q0trH7Fvmn8i+Xz00LgxDJXUuhmAld99SIhADKnl6XNvefv
         foMuvVWk25cc3qnCJUKOBHJbQXYj0+SFsQipoCqOHKAr6HEpG3RkjEyS0jPcF8Aj77/v
         fUgqNyEzFEiNyF3LKX2KgK10Eq3WxKqM++EwxhtZlYWYCh7/vpK8faKdCXEQTy++eMKW
         IrRhfYSTq2wcv9ODuCIAawLGSAt/tVpfJzXdlo+mJpRjJHQrJpKKvgZ151CeiY0k0Lkg
         jpoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759323895; x=1759928695;
        h=content-transfer-encoding:cc:to:subject:message-id:date:references
         :mime-version:in-reply-to:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FHbqmA3oKpic6IfyRvOOe8x31ZYEYEaGDwcq5aemMoY=;
        b=xOSLeDDWeHGGBJLkGLazyQMDJ7oO1GjabYIQNMsL5nSTty201UuPuFrig1HOZgwFJp
         75npC+4B4DawoF9S3XGyE8v7dTAXO6O7h/FOvZm8giIekEt3KECM213n9FLvWfgod7qX
         RbpOwgpzYfhnSkXIncRsnI/tgdcxavQv1bw/w+5Gfh7MEMuN2d2Ffa9aZ8KPAXWWF1gx
         5cVSPKCAWpOTZ/HyYAg9pU8gmHOOT54qeNff3uQ3bqEIEUQLsRTPHEyuBYcQsOH0RrLa
         uLJa/n2KQxlTucCPkJWFzKzmLkLCAhjt65yT4V5u6J8dryYlvgK3qnLwspnzAGDuhC61
         0aEg==
X-Forwarded-Encrypted: i=1; AJvYcCVP5tDyCMGV1r/ONGgLNu6DN9vYXaQ37OkC49TpEwo/ahTjplZv0uxawPALoVtySUy68N/Aq7Un/tsmxSM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhEYHh/LwXmzqB9Rsjt0iAkivmEH+XQtq88Vd3l4d7kASMAOwC
	BGzlnVQPc83ZvRMTwYL+ajvl1WBjqcMQSDCM4dkocIpkwRSiUsAcq6CG8EuUGjJj2AMQytkL3q8
	3mAAWepR/FifzOSrK3E2kd3JRZRTRLMMaCF7tZXEfIQ==
X-Gm-Gg: ASbGnctquvoQLA8hJ5KAGc/A0zrG0U2xecXvrfiVdd7Wspc+rY7kE/sNY3CDKHM8nnE
	cFDXdZMg//f3mDiHnPQlZVLIxJ2Vq37o+VF91dNkvQ/dGeCCFWXYtNjQrpTSl3mfJc7vNA568SX
	obvfjh8K/qhrGAtW1B+V+2r9sOC2+laNUCov/aLFzLjDmYXE+2XjokJ2mVBRJEACyZ0mMXUeGrH
	fi1ZYXNreArKlIyGTDtIR2Ij4BPC6pY+s4RxDPRGn54bDJW88VsJwQUT+UO1Ek=
X-Google-Smtp-Source: AGHT+IHIX0BnzV5QR3ZUNafIRXxWw+fJ+TE74iOPYTO055yiV9YQx881LMKJ8ntEhbIPyMH/yj9fWYf3xbX9jssRLhM=
X-Received: by 2002:a17:903:15cc:b0:26c:e270:6dad with SMTP id
 d9443c01a7336-28e7f43f288mr40560635ad.60.1759323893974; Wed, 01 Oct 2025
 06:04:53 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 1 Oct 2025 06:04:51 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 1 Oct 2025 06:04:51 -0700
From: Bartosz Golaszewski <brgl@bgdev.pl>
In-Reply-To: <CACRpkda-ZvrAC4bNLnA+ao0Y8-Nd_-b89N6HU10hhEdaOUYAjw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250924-gpio-shared-v1-0-775e7efeb1a3@linaro.org>
 <CACRpkdYcVtJjRHRJ8GgeU7rZDuyaJKu0vgcknb7DsHPjZGKGuA@mail.gmail.com> <CACRpkda-ZvrAC4bNLnA+ao0Y8-Nd_-b89N6HU10hhEdaOUYAjw@mail.gmail.com>
Date: Wed, 1 Oct 2025 06:04:51 -0700
X-Gm-Features: AS18NWB4-ek2de5G39SVs91_zyxyHsKkPvhufhJXGysoQ2YUW53Yv6YTbFeN0M4
Message-ID: <CAMRc=Mdb_cUG+hKq8GyfUP1SYBh0p19J+4dFG7G3JSuZTr4n8Q@mail.gmail.com>
Subject: Re: [PATCH RFC 0/9] gpio: improve support for shared GPIOs
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Kees Cook <kees@kernel.org>, Mika Westerberg <westeri@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Andy Shevchenko <andy@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Srinivas Kandagatla <srini@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sound@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 1 Oct 2025 12:53:07 +0200, Linus Walleij
<linus.walleij@linaro.org> said:
> Replying to self so Bartosz don't have to tell me off...
>
> On Wed, Oct 1, 2025 at 10:49=E2=80=AFAM Linus Walleij <linus.walleij@lina=
ro.org> wrote:
>
>> and every GPIO access on every system will be proxied
>> and then this better be fast.
>
> What about I read the code before I talk :/
>
> Inspecting patch 4/9 it is clear that only GPIOs that actually
> need to be proxied are proxied.
>
>> Two things come to mind, and I bet you have thought of
>> them already:
>>
>> 1. Footprint: all systems using regulators will now have
>>    to compile in all this code as well.
>
> This still holds. It could be a concern if it's a lot of code.

It depends on how we implement this. If we just rip out the enable counting
from regulator core entirely, then it would be transparent from the
regulator's point of view and each platform could still select the new opti=
on
as required.

However there's the issue of regulator consumers who need to know when
something changes on a regulator and to that end subscribe to the regulator
notifer. Regulator core knows then it actually changes the GPIO so it emits
the event. There are several ways to approach it but the best one seems to
be: allow to subscribe for a per-descriptor event notifier (implementation
details may include: only actually creating the notifier for shared GPIOs),
and be notified about an actual change in value and then propagate it to
regulator users. This would still be transparent and allow us to select
HAVE_SHARED_GPIOS on a per-arch basis.

Bartosz

>
>> 2. Performance, I didn't quite get it if every GPIO on the
>>   system will be proxied through a layer of indirection
>>   if you select HAVE_SHARED_GPIOS
>>   but that would not be good, since some users are in
>>   fastpath such as IRQ handlers, and the old way of
>>   sharing GPIOs would just affect pins that are actually
>>   shared.
>
> It is clear from patch 4/9 that this only affects GPIOs
> that are actually shared, and those tend to not be
> performance-critical so this concern is moot.
>
> Yours,
> Linus Walleij
>

