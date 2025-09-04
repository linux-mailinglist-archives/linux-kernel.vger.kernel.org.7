Return-Path: <linux-kernel+bounces-800116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 217ACB4338F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 09:18:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A577F16A3B5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 07:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E08D29AB15;
	Thu,  4 Sep 2025 07:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XuUsVUdj"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FABE29A32D
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 07:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756970280; cv=none; b=UMX4VPUGJpn3poPphu1ALELJcNgv0PFcp2KoqwGJgrn0xTwgUx7mcB2jAq/5DDGIbPCSKUkOVE/V8Dc3LuJJ+KR5k9TsvdNnBOElYdLPwf0b97gF9KL+zp02oe8jzt04A7rS0JzUcq5qas6wvqfHz8wwgJDr7kDnXiaPM7MfrF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756970280; c=relaxed/simple;
	bh=W+kfG1opgTYiuSbM1ynJeC3MtjJuAFRHGYLJzeN0Lks=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BWI/pWn8Vv801ApPbumjgH1PFd2jIiNhbpxVBmvPCT2F2U782uKUgDhQZoB5ePN1ZJiAt8CFGK7UM0NPxmUId5XTYLaG64Slp+hqB28VbguFbMRotSZNcSI3tHypa0kTNfP0RUfJO/catRnjbSUzFa1fAxAf/PR8y1ps65vzw/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XuUsVUdj; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b042cc3962aso107482366b.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 00:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756970277; x=1757575077; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LSCPkDHsEcxmpOj6VbQwTWZYShwT8gUAJwxZ5jykxvs=;
        b=XuUsVUdj2Kehfy1sOQQMiWGN4JADHUO2Vd8wTwzPi6fthG7jzRw2EvNwbVy9rlDxuT
         DYlcn8MB3PPROiWL3Ag5WL4Ktk1W1QG9AA3QXh60lOqYh/O85SJ4xyzTFUBf1WZKi5Fe
         IndD5vPGtr823JQdYVRmD3kPdfkFcmT7F6uCD0BKqGfXg+tcJEjGwm+Up4kOKloB3LEv
         p3Ods5tWfz5mQxdaBJxuhD6fr/bigLCg9mdLZ1Hm/Tyz67Ffy2LBfWVz2VUbD/i7o5YU
         OJRSIjyzDkQ0thQrgpTBNQNeHiCH2zvMKoI9BaaIENzycXAK+3HnnEF4B7p0wtwj5V2m
         zbcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756970277; x=1757575077;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LSCPkDHsEcxmpOj6VbQwTWZYShwT8gUAJwxZ5jykxvs=;
        b=fxS8nmMn049qRUSAiYcw2iMGfxhYfsfYBczj7M6J8Pv/hQSboEnRGWspR1EYxx436s
         GIbr6YX+E9HrICWGUA8v87KDkDtdY7OxgyRoje9FqHcd5mwDxawKhiUClDBgejt2XH7H
         O/EG/HQeLpW6qE4zPPBYTVSP0ORtorAjl0/zBvubcFsE58yRHTylRCtUxVGL2ILa+4kr
         DPk4QMqBMlynGSARitZQDyxBdGYK162Wo6osbr7LF/K8t2sg7s8SiFgJ6Kg/maU02VfV
         UNUivmXvgAiXJG8JaVYei1A+Cg9E0NWGkr8/ya5rJ4y2a6fZP2pNxfoX37OFClTVLhp3
         K3vQ==
X-Forwarded-Encrypted: i=1; AJvYcCVgVIMPpRdRSm2kDMuj/o2/e6hoX+0PqzX0vjVoAh19yflMzNi1l7MDK0+t5jFAvZSyyLgIup3Y6wRrkrg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEPvg9OZZ+apuzxbH6rgpvgOWzRncQp5qOxCimPayqRUX0Y96+
	6JRjWNWhDd/dxLYgDF4iVcSIXDEVo4Zg3JnYQk9crDl8ym9vEHFAitDvMJd2rV+MOdijn8b5OH8
	LADZxCzpWNDYJ9sAwBKYMD046q2AA2I7nqWhqSr7UB9l+QF5wOmpmDWI=
X-Gm-Gg: ASbGnctOEnA6X6dzDrVmfmr1EUuIwqf4KNfeZDOiSNnxhc+cRpp3E7WcNntFDAf0IpF
	v6HaY3+nIdPf4GqSPVem0KGgeaMV9O/rVyk8uSv/iD3lf8WCx11wuhnvjxOt6N0308/OB490JEZ
	7PdrVBGjvD/t9sTUEPmozEIdiJwaFkpl129KT81fcad/4ZGL0QI+gSM529RzQbNkd/fF2qUqaun
	CBfdj1ft7n1IesShx8wb/v8XRcjomIjwNFjqA==
X-Google-Smtp-Source: AGHT+IHnU2tk5eG7O2PgVrjb2HzIr4PTSJ4VHsEZcdbhADM6XksqxivxCaBQUAUhKnd0CQ4ZYon7QtZ6SkUdMUpZKLY=
X-Received: by 2002:a17:907:724c:b0:afe:764d:6b22 with SMTP id
 a640c23a62f3a-b01d8a32756mr1542758166b.9.1756970276788; Thu, 04 Sep 2025
 00:17:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250904154122.63acc45c@canb.auug.org.au> <20250904063043.GE2764654@google.com>
In-Reply-To: <20250904063043.GE2764654@google.com>
From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date: Thu, 4 Sep 2025 09:17:45 +0200
X-Gm-Features: Ac12FXxAxk7z0xvnWkE-R2CKKYv7l5x2z2VrkIbotE1EotEkf36zoUeazbWjmVE
Message-ID: <CACMJSev63kfCBTzQnija6Q+PNm8KgD-LWVKeqRJ2kLBtT7Zh6A@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the mfd tree
To: Lee Jones <lee@kernel.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Alexander Stein <alexander.stein@ew.tq-group.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 4 Sept 2025 at 08:30, Lee Jones <lee@kernel.org> wrote:
>
> On Thu, 04 Sep 2025, Stephen Rothwell wrote:
>
> > Hi all,
> >
> > After merging the mfd tree, today's linux-next build (x86_64 allmodconfig)
> > failed like this:
> >
> > x86_64-linux-gnu-ld: vmlinux.o: in function `stmpe_gpio_get':
> > gpio-stmpe.c:(.text+0x21a7c29): undefined reference to `stmpe_reg_read'
> > x86_64-linux-gnu-ld: vmlinux.o: in function `stmpe_gpio_get_direction':
> > gpio-stmpe.c:(.text+0x21a7db2): undefined reference to `stmpe_reg_read'
> > x86_64-linux-gnu-ld: vmlinux.o: in function `stmpe_gpio_irq_sync_unlock':
> > gpio-stmpe.c:(.text+0x21a8166): undefined reference to `stmpe_reg_write'
> > x86_64-linux-gnu-ld: gpio-stmpe.c:(.text+0x21a82ef): undefined reference to `stmpe_reg_read'
> > x86_64-linux-gnu-ld: gpio-stmpe.c:(.text+0x21a8372): undefined reference to `stmpe_reg_read'
> > x86_64-linux-gnu-ld: vmlinux.o: in function `stmpe_gpio_irq':
> > gpio-stmpe.c:(.text+0x21a8c27): undefined reference to `stmpe_block_read'
> > x86_64-linux-gnu-ld: gpio-stmpe.c:(.text+0x21a8f05): undefined reference to `stmpe_reg_write'
> > x86_64-linux-gnu-ld: gpio-stmpe.c:(.text+0x21a8f89): undefined reference to `stmpe_reg_write'
> > x86_64-linux-gnu-ld: vmlinux.o: in function `stmpe_gpio_disable':
> > gpio-stmpe.c:(.text+0x21a91dc): undefined reference to `stmpe_disable'
> > x86_64-linux-gnu-ld: vmlinux.o: in function `stmpe_gpio_set':
> > gpio-stmpe.c:(.text+0x21a93a4): undefined reference to `stmpe_reg_write'
> > x86_64-linux-gnu-ld: gpio-stmpe.c:(.text+0x21a941e): undefined reference to `stmpe_set_bits'
> > x86_64-linux-gnu-ld: vmlinux.o: in function `stmpe_gpio_direction_output':
> > gpio-stmpe.c:(.text+0x21a95a4): undefined reference to `stmpe_set_bits'
> > x86_64-linux-gnu-ld: vmlinux.o: in function `stmpe_gpio_direction_input':
> > gpio-stmpe.c:(.text+0x21a9705): undefined reference to `stmpe_set_bits'
> > x86_64-linux-gnu-ld: vmlinux.o: in function `stmpe_gpio_request':
> > gpio-stmpe.c:(.text+0x21a983e): undefined reference to `stmpe_set_altfunc'
> > x86_64-linux-gnu-ld: vmlinux.o: in function `stmpe_dbg_show_one':
> > gpio-stmpe.c:(.text+0x21a99c0): undefined reference to `stmpe_reg_read'
> > x86_64-linux-gnu-ld: gpio-stmpe.c:(.text+0x21a9b8c): undefined reference to `stmpe_reg_read'
> > x86_64-linux-gnu-ld: gpio-stmpe.c:(.text+0x21a9bb1): undefined reference to `stmpe_reg_read'
> > x86_64-linux-gnu-ld: gpio-stmpe.c:(.text+0x21a9c61): undefined reference to `stmpe_reg_read'
> > x86_64-linux-gnu-ld: gpio-stmpe.c:(.text+0x21a9e6c): undefined reference to `stmpe_reg_read'
> > x86_64-linux-gnu-ld: vmlinux.o: in function `stmpe_gpio_probe':
> > gpio-stmpe.c:(.text+0x21aa5b2): undefined reference to `stmpe_enable'
> > x86_64-linux-gnu-ld: gpio-stmpe.c:(.text+0x21aa83e): undefined reference to `stmpe_disable'
> >
> > Presumably caused by commit
> >
> >   e160dd0ac8c3 ("mfd: stmpe: Allow building as module")
>
> Okay, I have removed this patch until it can be better tested.
>
> > I have used the mfd tree from next-20250903 for today.
> >
> > Note that commit
> >
> >  03db20aaa3ba ("gpio: stmpe: Allow to compile as a module")
> >
> > is in the gpio-brgl tree which has not been merged into linux-next at
> > this point.
>
> Okay, perhaps these need to go in together then.
>
> Thanks Stephen.
>

I can take it through the GPIO tree if you will and set up an
immutable branch for you. Or not if the potential conflict is minimal.

Bartosz

