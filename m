Return-Path: <linux-kernel+bounces-811553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B5B0B52AC4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 09:57:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D4EB17B590
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 07:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCABE2C158E;
	Thu, 11 Sep 2025 07:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="3ETJqR4v"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F00F2C1590
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 07:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757577404; cv=none; b=DQvTIrWMbynqrpdIW3jn4mRiteBaVaYFMqE/zm5lhIAuKq33JZOUPztPq1R2zocPEha6CGRye8+jyzt0UFMveUm0Myc9mpv4w4SybpW65So9ToGiZvRFlIC5RyrAKBJYlwSDwWCZZn+vgFHlERQW8KQgFn+D1plnLoOz78zBAYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757577404; c=relaxed/simple;
	bh=9XrvhsWNNRvcRClDoeF6Jt3/A7wdBGZCuSPlcTCRTrc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nB2X86ngzcS7uAOvLi4MFP8X1ldpm5a1O2/FLNOJv58bl4Ug0vSzCKcefqagXc63nBvbPUeA4iu6l2ub7BF0FL5Ef94EMx25ISy8sjpYrCclzXE2nZoN+S3ZMHhTfHFe8C2l4mRN6Ihm4eUlN/0lzYbavOJ01L0i28hicMr24G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=3ETJqR4v; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-55f716e25d9so383579e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 00:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1757577401; x=1758182201; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bep7Xid77Fho0BbSmSLtdgFH7ZgtGYRYV4JpO6GqPMo=;
        b=3ETJqR4vgoMaMqt+KEy7Te/f85X46tzQudrlEpUFN2LPx9p9UCLIERH8L24fjT0cJE
         JF6mO8kJXP9n38SxR9kfsYWiSHUxhP/xvV1JXW7v1S38hsSo+j1jw+eHvKd/UgyKD5h/
         vXUq/PMlMdm81/xpQ1cuxlWS8vTV2z6fdRDfaknIIsnHd+YPE2rLXFHPOA/6jbIE0rbc
         aSS9o6d1xFR/hnlaFV9e2Kj3mzYtxYuPR24Hdbo3A/PUUdzppNcFcMeGXHR1hqLf7BtT
         EIvkzzxyuXPzBzcvapeMgXNXaK9WecfSAvYoOBK2Q5+EvNiZtmALQFI7sb3yAagJf9FO
         tw6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757577401; x=1758182201;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bep7Xid77Fho0BbSmSLtdgFH7ZgtGYRYV4JpO6GqPMo=;
        b=RiuTlSggPj4aLg17tZPAB1io9nHkoRm1pbaQ5HODCy71YclHoTyM6/jQoeb/IR4ZMw
         MIvjTvL3M/3ja9/jZNio/gu5ELD1bvGHF7Z1W4uY5NZdJkngCzDw//RhDgcKKrYJrv1S
         TY3xS4E0XH8Iv5vtiUWd4u0txvxrZNmEYHBRs2miN77dGtk1g+YpY+IjNOixTPdT6I+N
         x++vY7f7WOqDFMtQe0Bz7EBGBizOA00joIQuxKIX3x5y4UUR0oQIdc89VjZM9PhyxD65
         t/Jo4bB/W/xFt8scjy/qa9Oid7e9nbaH42lUhWiWOrthym/wqMs041UTTb8V8/L8HNbZ
         zzUA==
X-Forwarded-Encrypted: i=1; AJvYcCXunyBM+m7QLg5J+74S9ulG2bIOXM2lJfQVeaDjV9Cfk0wIlTXqhziABkglnzeu0PO+rNec39/rRnrEXMk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOlADki9BYpvPKVMtPiRdmIlstPaU5oiOl16rIzECK5kjoD0L+
	qJOOy2j+ovGYipC1RAnPcf8tmT6pfgaZU3JDECnBCB9shmO2JYxOxrRCol74O0i14cf0gyvJX4j
	1NnGO57yYwpzJMRJG1QXhQxfGCDqd0iD8Ut9UxeQgPw==
X-Gm-Gg: ASbGncv17a6rlMb8JvoYiXPrI0D6basbpNrxvZwiMjyVgCOU2QFWW8KtY5bNL/rfdOQ
	yhGQFQ19k6FEsLOdBtmfr96iYwPjNC1Mnn1u/4ILA/60mOePRWHFLhs3nf9uAjrkzvGZaZdAfZr
	VAv5uzyb/YvMDBFipgpxvmYNHAuDW+QNhHTz3/Hlf0lhqLXJv/18PlbXj6/jAbmiYb1QLgKYvHW
	qSABCF2q8gm1x2DL5BD3GYHl9WycVLeDWIzWvQ=
X-Google-Smtp-Source: AGHT+IFSDgCLPJndg4TOxS4/+K2sQKL3XaKKbJwpYxrHeNncRVK3PIq5fLt3S1TrCjsBx8V+oC1pdTue83tyCk/M6OM=
X-Received: by 2002:a05:6512:3e23:b0:568:25d0:f843 with SMTP id
 2adb3069b0e04-56825d1df24mr3328322e87.4.1757577400507; Thu, 11 Sep 2025
 00:56:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910-gpio-mmio-gpio-conv-part4-v2-0-f3d1a4c57124@linaro.org>
 <20250910-gpio-mmio-gpio-conv-part4-v2-7-f3d1a4c57124@linaro.org> <e0941449-7a62-4bbb-8790-616f393f2cc8@gmail.com>
In-Reply-To: <e0941449-7a62-4bbb-8790-616f393f2cc8@gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 11 Sep 2025 09:56:28 +0200
X-Gm-Features: Ac12FXzR1a5xkbJIh_yEzUr3Ha0h6_elTIUATVbDxWcMjvS8AEDuwvbJ1IToPQE
Message-ID: <CAMRc=MfZ5ss8Gd_TTPV8EYSv04ENp_C26b3=wukO+UTy_boXUA@mail.gmail.com>
Subject: Re: [PATCH v2 07/15] gpio: brcmstb: use new generic GPIO chip API
To: Doug Berger <opendmb@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Keguang Zhang <keguang.zhang@gmail.com>, 
	Alban Bedel <albeu@free.fr>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Samuel Holland <samuel.holland@sifive.com>, 
	Yixun Lan <dlan@gentoo.org>, Andy Shevchenko <andy@kernel.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11, 2025 at 2:11=E2=80=AFAM Doug Berger <opendmb@gmail.com> wro=
te:
>
> >
> > @@ -700,7 +707,8 @@ static int brcmstb_gpio_probe(struct platform_devic=
e *pdev)
> >                * be retained from S5 cold boot
> >                */
> >               need_wakeup_event |=3D !!__brcmstb_gpio_get_active_irqs(b=
ank);
> > -             gc->write_reg(reg_base + GIO_MASK(bank->id), 0);
> > +             gpio_generic_write_reg(&bank->chip,
> > +                                    reg_base + GIO_MASK(bank->id), 0);
> >
> >               err =3D gpiochip_add_data(gc, bank);
> >               if (err) {
> >
> I suppose I'm OK with all of this, but I'm just curious about the longer
> term plans for the member accesses. Is there an intent to have helpers
> for things like?:
> chip.gc.offset
> chip.gc.ngpio

I don't think so. It would require an enormous effort and these fields
in struct gpio_chip are pretty stable so there's no real reason for
it.

Bart

