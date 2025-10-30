Return-Path: <linux-kernel+bounces-877758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B04DC1EF22
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 09:19:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 624DD19C1B05
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 08:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6344430E0EA;
	Thu, 30 Oct 2025 08:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZBDNnwCN"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10511184
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 08:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761812349; cv=none; b=QG1/zhdLtkSyy8qNnw8XBmnBQxq52rjtpHI+5/Jp3vDwjEfhvxzG3gL+QJlQMv6+gx2OqUeDJaVPpLefLDHGH1y7kRaMHj/kK+b/yJMMdeQvCWjdERKqJDnXVPxke1PnLW62H4zBAkRQPpqeuPUKGFaB4at5m2iv+bUeBHknAO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761812349; c=relaxed/simple;
	bh=n8kXk/u9Pag8wMhc1UkF9e4Fd9yQ8hjWefqsOJiE1/0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XoYGDf3z8II0bwLLKIp2m9B1iSvWjC97mI/gW1GsjdMlFi4ex89mQDwvjwSmljGrgHL3ZJwFQs0igey6LpwXm6MkB7dd9kh7CaaszJmbrGUwObQfW4j5sqlJ4ypz1hiGphRgfT24X2P+tcgUT4PbmSk2MT0UvS1YuBeoDkZ+JMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZBDNnwCN; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-592f600acb3so1050021e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 01:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761812346; x=1762417146; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZZSc3Yfohy0GneZpcaYTXUsRgt/OPg+2FZgItitcnEM=;
        b=ZBDNnwCNdrmmy8aVPkq1J3OySFNH6vAFXT300RWTafZ/K6HdwIXuKI9lU0ORhIkOdJ
         jkxEIStPPVfbLN7B8XQJueayL64B2ivySkf6AC1WL6Im6VDx6shgXwfY3vpzxrnYPBgf
         dOflMieqXbZleAJ/sPc81GU+0BeXx2sxIh9U0zSETCIAl+IYqO0PXT80ZF7sjIcquMlg
         WKI9PMdMiBNdqcbE4vTkGbQJXDY2LMdhvSj/4BJNRexa+gyUC+ONvJUtX+eyP/bBItPo
         1u33ftYWkUlbiq6tRiwzKVLf6jH6phFzLKjQKcESC+lkFuHkL0XMEeRrlbvWVNidEhEO
         s/SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761812346; x=1762417146;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZZSc3Yfohy0GneZpcaYTXUsRgt/OPg+2FZgItitcnEM=;
        b=qGsE9HmaE0zhE7y/qBpUatSv161rzNFgMFAptnVyuJJ7bzEoyEG3QmTBMyBngnD1bi
         QoCTMWEV92Dq6Hq+nE8lS/lW6PMWzu+wErdc5HO7jjMqQNRw2MGhk5mXU0PWeShbAvV4
         c0JVCXajF81wxbmuZLPl80YkCXGRgxE4SYRqSQWQk7gwuqFapdyHWgDcBO4xjuSdWLzC
         6wwIqozojmIMMPT9W6/jmY6tWtWnD9atD0uB7jPAE5LeJwXOgcC2xhCz4mrVJHZuRVcq
         ZD9TojXD28RA9uYj9AXpuYfoZu0o4IsblH9uzmLZtM/4htEGuMa6lzbIsAqcVfpYabD4
         q07A==
X-Forwarded-Encrypted: i=1; AJvYcCViKCL1YLWIlLBmdUJr4Pjo3gg96WsJPPjTHD9loAjhByWPkP5oYWaLwmtqtz4TNvC4oPJ+ubgupwWAy9s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDM8utG7HEOe1udPygs1iCx+wkkshZdMiUi6r4/w697Mc7O0iu
	Uko8EomOVmmdJdti8oYCLbsgirx1SGaCkJOYGRxhOWjBZ5dL3Gjgf+KFhfojsX0X1VqihW/VE7a
	TvHFno/Bv9QkijjF4QZOv/waUKzZ72PVK4ECaATm9kA==
X-Gm-Gg: ASbGnct2OgAVSixLzOuhtZ/nrJqNEflVOMssFSOZBxgQBf2shUHsVNj03THFG7v7BwQ
	DMtsmzLr/nHLvKc3epFKFGrt5367aA62wNr02i9Y9hm3en0QryOuA6CIiifTg2s6wxtrKFknaOE
	MAPbq5IvANpEqwujb7nvGVqeNkNjG7K/affkpAgtC3dj+7AV4MddQvqh1ZuQ/9DxoKnQvDKOkP5
	AZWAsnPoKCvZQiDiZSivraU2SZKDMwJcpPPL+agz5gqsIUgpmI8uXehDpOw
X-Google-Smtp-Source: AGHT+IFpU5SfD5f6aYsrY94jW2ThyTJxMXRujbccn17De50s7ThAJI6lRpfdtUVW5umqLgWUYZ7hiZL74+1ScUCScAU=
X-Received: by 2002:a05:6512:3989:b0:590:9a11:9c2f with SMTP id
 2adb3069b0e04-59412c4d006mr1997751e87.50.1761812346100; Thu, 30 Oct 2025
 01:19:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029-isolation-shield-b66aea79a9a4@spud>
In-Reply-To: <20251029-isolation-shield-b66aea79a9a4@spud>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 30 Oct 2025 09:18:55 +0100
X-Gm-Features: AWmQ_bl-lBgjTxJAyqBuCSaVQyLLToyI0K2Q3rw5bzF0J-trmHFQhxiymB76HMM
Message-ID: <CACRpkdaEwa_HMTQ9gOyKh+i+gU1oAqGrPwV7VKF3+W58BMbNZA@mail.gmail.com>
Subject: Re: [PATCH v1] pinctrl: mpfs-iomux0: fix compile-time constant
 warning for LLVM prior to 17
To: Conor Dooley <conor@kernel.org>
Cc: linux-gpio@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>, 
	Nathan Chancellor <nathan@kernel.org>, Daire McNamara <daire.mcnamara@microchip.com>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 4:30=E2=80=AFPM Conor Dooley <conor@kernel.org> wro=
te:

> From: Conor Dooley <conor.dooley@microchip.com>
>
> With LLVM prior to 17.0.0:
>
> drivers/pinctrl/pinctrl-mpfs-iomux0.c:89:2: error: initializer element is=
 not a compile-time constant
>         MPFS_IOMUX0_GROUP(spi0),
>         ^~~~~~~~~~~~~~~~~~~~~~~
> drivers/pinctrl/pinctrl-mpfs-iomux0.c:79:10: note: expanded from macro 'M=
PFS_IOMUX0_GROUP'
>         .mask =3D BIT(mpfs_iomux0_##_name##_pins[0]),     \
>                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> include/vdso/bits.h:7:19: note: expanded from macro 'BIT'
> \#define BIT(nr)                 (UL(1) << (nr))
>                                 ^~~~~~~~~~~~~~~
>
> This is a constant, but LLVM prior to a change from Nick to match the
> gcc behaviour did not allow this. The macro isn't really all that much
> of an idiot-proofing, just change it to the same sort that's in the
> gpio2 driver, where a second argument provides the mask/setting.
>
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Link: https://github.com/ClangBuiltLinux/linux/issues/2140
> Fixes: 46397274da22 ("pinctrl: add polarfire soc iomux0 pinmux driver")
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>

Patch applied!

Yours,
Linus Walleij

