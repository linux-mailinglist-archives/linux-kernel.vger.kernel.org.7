Return-Path: <linux-kernel+bounces-798617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25EBBB4206E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 15:08:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2829A682077
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 13:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0894430102E;
	Wed,  3 Sep 2025 13:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="PDVxDmUr"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9957301016
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 13:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756904764; cv=none; b=FiuQN3HM8v+Jz8ysFR8yKt8D3IE7qb8AC/RI1nB6OfIMPMidVq8KrUcq/9hm6Vwal5B0hjqA6G50glbkjxz+PfFaI4sQzhw2D5ZS+gq+i3JTmYYC9jzQmM8/6lQstjVIsMJ+aYynfQ0WiIi6jX1CDDA4mKNcMBwOcLLg9Tub7p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756904764; c=relaxed/simple;
	bh=opK+eoV/7ps1WaBTTGCDe+X41cv1kkgjod7U/GTxNmw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p68FlgZDmk6AnHHfHO93SLh4VDGnbtdXBEtOTsx/u29QPwoSh13ZwDZm2RPnCo0heIMGVEYLBis7nZAq9TorvP6ymPH4M+9SAPywSxCtqyewvS6tHp+zl8KJ28Pwbj9yUiXIl4gjH+IxE25L35F1B2XheRAtgAt8YuFOcpf90NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=PDVxDmUr; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-55f6f434c96so4311663e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 06:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1756904761; x=1757509561; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TceoMbVPyrzcVBNVbAOHGzxGRGxrO0zSw59TjOdJc7U=;
        b=PDVxDmUrO2ardprfNDxPl6E56Ek5dGP6yifeFdTnxOYL3/W1FRs2+NxfcBb0hMpt1R
         tHCUCAtgjsPZYKncnZumEG2QTGRALsCv32lr4tasPhAeQ7n3DUSDdMx3ksbA/LmlPvfn
         PJXEa57RchLe+bxvrtKapnyjnmfMtyCC90VkjVF8WV2G6PO9K3yD0NDgbWzmrqwBx1om
         xuJjGebhyWFAFdijDZcUFX8nWDoKYB7DaIzMo87oRlI3b5mw4bOm8qxVdaA9kxRf2+ok
         12L4rBHsctkY2wrbchP6EC0/8EF6cM4oIMTyJEL/B69SybspPTnTdLZeGOUPnrdOcOSg
         2P3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756904761; x=1757509561;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TceoMbVPyrzcVBNVbAOHGzxGRGxrO0zSw59TjOdJc7U=;
        b=utbU8YBCFvQpvoex+i10yFOhf12gToNXyG/Sbh4woRMeWI7Q7YMzA2ba8oIE0UgA1a
         lPbxpQOObRWXX1LmmhmlUaOMruLX4Mwlhvkjhp6IagTzgtbtMJCBgh6K0oEXr8H0XIFq
         9qmdYvyPnDd/B8X30pivCLqtZPY9YGwwuVwfpXe/pOfJ3eY0AllXwMzqQJrsDiK9tkMr
         Ur6Yn6/DpEub/GzMsXvd+TJbjnxl+1jWPr53PBsCCExPFyKnh8NXvL1zUqxElPLBXDoA
         f1PEmrJIaXmK80ZRW5O6J9mo3JXdwaP/LDHZjr4QdZwXYG+5hMkn0pi3bZcxSUazQ4ON
         jNag==
X-Forwarded-Encrypted: i=1; AJvYcCVPpvuiYbWEbtc4mdQFocrDEsMOtm74xniOH9h0c1lhjFqA6i9leDBvPU5vkFwQBRWQwT7/Jb86TJXqSls=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8aBZN7J/+6My/gWLmC/qdgq7Jv5Do6MqW5gD3v9h8Y0bbB3+4
	5To3YgVU4zbF8vyBFdX31aZ/PfF4h+z2Xy+f2BlwjrJ8kom9SbQQF7Moy7JiRN7UsHQm4ppmpvG
	Cj/5JGcsx+VMfIaEzHrORIQrrvUSGErz9uUzuiD2myA==
X-Gm-Gg: ASbGncvpu+mE/JxADXukYR9fE7Av25G4GdvCEh8MLn9Oa7pm4FvR41i5JMYNgpuRUhY
	sA8HZJuDAT+p3sv7vLueKY5qyBpvUH5CAVDK2af5+MXdKKoRokwQaobmHcx02afMtL5cgTMfm8B
	4DP02h/WDDUkd33hgHwNXltKH/jFECjvZuxHPMPBlxtiv8cxS7PcuG0H13zSe9H6BBn/F7AbHFt
	6dOXedfh9AHlpgOS5QG28s72Q4J/T582CUnzyOiitCdvKfaRVAd2muxO9cd
X-Google-Smtp-Source: AGHT+IFWW9Hzk4QvmFEIuxTuSzFqwAls1HtiU6FKjjOhdyOYjenmw3Gr/l6kYIu5clusIxlO2SHNIG7AoIrDQKR+nnE=
X-Received: by 2002:a05:6512:6812:b0:55f:43ba:93f2 with SMTP id
 2adb3069b0e04-55f708b5457mr3760512e87.18.1756904760711; Wed, 03 Sep 2025
 06:06:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250811-gpio-mmio-mfd-conv-v1-0-68c5c958cf80@linaro.org>
 <20250903090922.GE2163762@google.com> <20250903125524.GP2163762@google.com>
In-Reply-To: <20250903125524.GP2163762@google.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 3 Sep 2025 15:05:49 +0200
X-Gm-Features: Ac12FXy3NMzM2aB5ePiUft0RXfVSx9L7KjPMSrAtYJCok4KyCrb9wj58C2zdW0k
Message-ID: <CAMRc=Mfn-F+99EmwUABOy8=qh7W+ixL6hoEKvnmXd=EiW6QiaQ@mail.gmail.com>
Subject: Re: [GIT PULL v2] Immutable branch between MFD and GPIO due for the
 v6.18 merge window
To: Lee Jones <lee@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Liviu Dudau <liviu.dudau@arm.com>, 
	Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Pawel Moll <pawel.moll@arm.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 3, 2025 at 2:55=E2=80=AFPM Lee Jones <lee@kernel.org> wrote:
>
> This time with the correct commits!
>
> The following changes since commit 8f5ae30d69d7543eee0d70083daf4de8fe15d5=
85:
>
>   Linux 6.17-rc1 (2025-08-10 19:41:16 +0300)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git ib-mfd-gpio-v=
6.18
>
> for you to fetch changes up to 9b33bbc084accb4ebde3c6888758b31e3bdf1c57:
>
>   mfd: vexpress-sysreg: Use new generic GPIO chip API (2025-09-03 12:45:3=
3 +0100)
>
> ----------------------------------------------------------------
> Immutable branch between MFD and GPIO due for the v6.18 merge window
>
> ----------------------------------------------------------------
> Bartosz Golaszewski (2):
>       mfd: vexpress-sysreg: Check the return value of devm_gpiochip_add_d=
ata()
>       mfd: vexpress-sysreg: Use new generic GPIO chip API
>
>  drivers/mfd/vexpress-sysreg.c | 25 ++++++++++++++++++++-----
>  1 file changed, 20 insertions(+), 5 deletions(-)
>
> --
> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]

Thanks! Pulled.

Bartosz

