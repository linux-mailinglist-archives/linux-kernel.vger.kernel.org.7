Return-Path: <linux-kernel+bounces-865536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 71F8FBFD671
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 18:55:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F2BA2566961
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 16:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD7212C0F6E;
	Wed, 22 Oct 2025 16:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NjOQz/Jl"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8BA2C033C
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 16:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761151093; cv=none; b=nEKm13DGtuQh/4P4ARyLb0eODG6CBG8C1TLKLY7YiZDGredhBrTkGlgHFGWtr7TnP3CMzxMW/vQIjAdPWseddH3w6fKAVQd3kB2P4i0CC1KUIk7gR/3xE6RMzZJnHdOG6L3AACUs8Jrxp3wsxnwm8F5uCtFEhL9iw7KwQSZ2sX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761151093; c=relaxed/simple;
	bh=jd8PdGQoO6wTovaPAdg29/u29zMw+SHvYlnQa0aQ+7g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LGyoKN4kJEf3Ue5IXgtC1ZrCqF7++i3rlQmSh/bLyNVL8daaUiUefh5op7QT9tFZ3zY3JBGn+DOhoG3JX96dEeA+kC5Cn0juv5R6Gl2fPQHiNZMQ874uRW+20d8e4v5huIvrVnq4BU8Kr6Uk9hJaCeX7DqmPAPI2zxgouBKImd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NjOQz/Jl; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b626a4cd9d6so1401876366b.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 09:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761151089; x=1761755889; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wjxtDCCPNJq4IFLZpgA+ZFNOHtoqxbpot9L2X2MUg3M=;
        b=NjOQz/Jl8aMO4hJ8aw494qLUh/97MjGMDmzMeRrnyH7kkcARdqv3SD9LsOMRjZZqEN
         L+pq6V61Mm5ueAlKRsZGg8cJMSoH8eIg3HPIY3KMLTqvxyE/Zn2kolsPAe+6EJJtebc5
         bNRxDYulpkJTGg1GnZcZjslVAjgTZcLpbXIyQKZoKKMju471u/6zMTiM/nGKky0z74TG
         K/JL1k0YqTP2XmBm4n64vpgperOUb84bEvctdVo2JC6nZtVABN690A9KfGKkOpH9ovHo
         2jlYXT9lkpFomDebZ6MORoGtF/9sgTrLwVwWcjYtgkjyz9pSk54n2VHBrtUcwjdpey6m
         eXmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761151089; x=1761755889;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wjxtDCCPNJq4IFLZpgA+ZFNOHtoqxbpot9L2X2MUg3M=;
        b=RtGIgRBsjlfOJSk8+HH9zlcDU0OR+JU11TiE4ZMl/DLqtj/Rzr/sQxxn5K/JJPpPXa
         YsaUyPWlaVnw00HYrC6jMuf7u1TgxWJGIZDVGflN+ld83Rp8BDoRdYid3nPdjqAJY9xp
         zDSHxpTL5wuFoGiYNLLFVjRwUHsTN/+n0rseRlnc2VavAGo3ii2VrMVwKTi8Dy/Tts31
         wrOwtlqmABD6x5LGzqMG1XlfErF1fNgL9vHAGySa9FxeNU9wYJLYJpiwE8akK4KbSIjt
         abbukXTf4LPWvoJlL52X/Fy1Mx64zRdZVGljFIzaW+bT0syQcql/YCvgEC5Sav6WISe9
         /LKw==
X-Forwarded-Encrypted: i=1; AJvYcCXWlETACGy0ejm/Hva4yWlCXslyejUoo/fAHJ+gNRNfw7+gHf8gHg5LNgSj2Q8GQRhtABej2t8PS9MsQIA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmSB/f++zeY4bFOj5NuvDFXyUqVr/Z3Fftwz4fXgVmSmbZtbhN
	TWhlS9NheZHzHF1l6Wo/Bx4nyBKBKU/fr2ff/cYoQqFHojLTojVUjf1AW6Q15KN05tNrkWGKdcw
	Ea4AAZs5BgExXdyCLX6Ab4LtcbvC9Zepwu1vcyhs=
X-Gm-Gg: ASbGncuu3raW7CBS2GfcGLOUTM70Z4Z+YumKO9fXsSG2eS9ZzYfXdrezfjoIZVeXWDN
	E9lH57B4Kfj/tCqEoMYbPUZhZScuFirbjphhBUOr8f2/Ce/uhUb1rh/EVQQ00QMs6rjYAjxvw7I
	iyhN8XLaex3ersk3fN9PguiHMRB2wntEj0yHLux0y2sNdmVwpyCgwox7oXwAI/j+a958mu+yjTl
	NRc8syL87hMZpLaVHZTqvgmkBMrXO8foIcrveIPR2isQi+hR0W1xtXkyBMD5lwcABXVb7Ok
X-Google-Smtp-Source: AGHT+IEQhlldZHkbkWIwjsiQOYHZwHY9bjnkrg5Qfxs+V+/uUM20EoHZr/oHelRYTZyLRY98uAb0GmKzUqC/ua22PeI=
X-Received: by 2002:a17:907:86a2:b0:b40:f7dd:f8ee with SMTP id
 a640c23a62f3a-b6473732c83mr2641304266b.28.1761151088562; Wed, 22 Oct 2025
 09:38:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925-ltm8054-driver-v2-0-bb61a401a0dc@bootlin.com>
 <20250925-ltm8054-driver-v2-5-bb61a401a0dc@bootlin.com> <3500149.e9J7NaK4W3@fw-rgant>
In-Reply-To: <3500149.e9J7NaK4W3@fw-rgant>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 22 Oct 2025 19:37:31 +0300
X-Gm-Features: AS18NWAmKA0qY-4_Rj927l4qjhXHin0NfP7SGgwOLqwGW9gM3-1uP_V8yDyCw2g
Message-ID: <CAHp75VciOagW2grjYNxsBLKtwrEqaJZa-mKmUQgW8L8X3mky7A@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] regulator: ltm8054: Support output current limit control
To: Romain Gantois <romain.gantois@bootlin.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Hans de Goede <hansg@kernel.org>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-iio@vger.kernel.org, 
	Herve Codina <herve.codina@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 22, 2025 at 11:06=E2=80=AFAM Romain Gantois
<romain.gantois@bootlin.com> wrote:

...

> I've encountered a lockdep splat while testing these callbacks. I've
> included a summary of the splat at the end of this email [1].
>
> After investigating, it seems like the issue lies with IIO callbacks in t=
he
> ad5592r driver being called with the LTM8054 regulator device lock held.
>
> The ad5592r callbacks themselves call into the regulator core to enable t=
he
> DAC's regulators, which might try the LTM8054 lock again in the same
> thread, causing a deadlock. This would only happen if the LTM8054 was
> supplying voltage to the ad5592r.
>
> There are two parts to this issue:
>
> 1. Making sure that the CTL IIO channel used by an LTM8054 device isn't
> supplied by the LTM8054 itself (or a consumer of the LTM8054). Solving th=
is
> removes the risk of an actual deadlock.
>
> 2. Silencing the lockdep splat. The splat seems to be triggered by the II=
O
> driver taking the general regulator ww_mutex context, which means it will
> still occur even if we've made sure that the IIO channel isn't a consumer
> of the LTM8054 regulator.
>
> For part 1., a potential solution would be to create a device link with t=
he
> LTM8054 device as a consumer and the CTL IIO channel as a supplier. IIUC
> device links do not tolerate cycles, so this should ensure that the IIO
> channel isn't a direct or indirect consumer of the LTM8054.
>
> However, the LTM8054 driver cannot access the IIO device struct to create=
 the
> link, so adding a new IIO consumer API function could be necessary.
>
> For part 2., I'm having more trouble finding a proper solution. One
> potential fix would be to put the IIO channel reads/writes in a LTM8054
> driver work item and have them run without the regulator lock held. This
> would incidentally also solve part 1., however it would make the current
> limit operations asynchronous, and it seems like a lot of unnecessary
> complexity.

Interesting that locking a single  regulator, there is no context and
hence the lock class is global. Hence whoever calls a regulator will
have the same lockdep splat, even when false positive. Basically the
solution for those cases (and I don't know if yours / this one falls
into the category) is to enable context for the single regulator
locking and set up a lockdep class (so the regulator core should call
lockdep_set_class() at mutex initialisation).

> Please tell me if you have any suggestions for solving this, I'll keep
> searching on my side in the meantime.

--
With Best Regards,
Andy Shevchenko

