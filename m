Return-Path: <linux-kernel+bounces-861854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76EF0BF3D45
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 00:09:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3ACFE18C3D4E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 22:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E998A2EFDA0;
	Mon, 20 Oct 2025 22:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XCIWYTUS"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD39C2EE263
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 22:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760998152; cv=none; b=D0lNn69yxWCP6e1CdWXo7HEbGNxRC9W/yERZwRCry2MdeYDWvK8TFXAyXYlbxetF27eBsgWf5GScraY1ZFZhakXRuzH1XMpLCzAZzn3OQcZAVwiU7jrrIfKwVJaJM31MJW3QLbLQaNmxMcVc/Si3wrk63orCf/1cfngqxp6TrJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760998152; c=relaxed/simple;
	bh=9fY7BHIO6l8fZDHvCr6Qw6TTiKtPAE9sfEY9svRB3Mk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cPiZ3DApAudiF7yzC6SxUBvLBJw0XVnQlMP7sC4RFOoHRUYNtKU4dkotd7h3/j2NxDwTraQWX/+1vaDncNiNorRcpfFq8adRV4T80paPGRs6fhId402WK04zfpcy3Ds1N8/Im7NkPAzDu/FlaGG0rMDW5MqSfG0AWsA7m9/nsu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XCIWYTUS; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-3737d09d123so46551901fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 15:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760998145; x=1761602945; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jou7wl1+eFLqh56mhBKzbuquNRGf4+Mstk8GHncGjYM=;
        b=XCIWYTUSzm1/OCpBwSBDmX0mcKFNX4QqsxqG9lDNX8iDuUNN+hIuMrFZSZP/75MAh3
         opDWscjuKde+7NOfDBmRucQRbJqWB3CNCPZy3t4D6I7EUElis/0WoUOhHk2pWMq+2SPi
         RAhypgPDjyJRxfkyaQ1/99/f6bsduShg4tGIS43IzkTVkD9Cx+eOJ3JVaKLKLocx5ixK
         WEYIregCr3tVZMJ+W1OpMy0SvDfz+CrNYlukGItxD7WS1INtGaftlSCC5BllbK23tVr9
         aMl6dy8Slr2ttvpfqSd2M7olAezvGhTzYbLTw2vmbXLOzlvUIMzz1K0Ye1JxRbWFXCGf
         Jvkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760998145; x=1761602945;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jou7wl1+eFLqh56mhBKzbuquNRGf4+Mstk8GHncGjYM=;
        b=NPSpKuqSPwNgrxr4m9B6c2p9MyLWhOk5i4i4myF8cI0QbzVYCe6vbpvOfJ6ZZH84Ii
         FGHVCXqdgcSrZGvo+omICfBhxf3bPBYznq64e7ED29Y/a7si+L6BpkzZ51DRxnYkjzKC
         bMoKLa+hwbv9IzxV62jVEwudihJ0+8dVNbXo0RUXx1M960tbGYnmgpxxALOefEbPdnRf
         YjapBqDatwtyE/DpCiOMUkBGkqHD5/RyTq2KCFNS7N7v9E8aEGkuFkpU1A8aUdaQhfQU
         BROC0khlJRROfnGvdQzI2BXmebbKhcoJboFn8wjGeNbgFPmv68u8D0XlFRGA3AWy8jVp
         AS2Q==
X-Forwarded-Encrypted: i=1; AJvYcCVxRDUk3RNWlBbE2KRK5oLxgInhJQQ0Fd58NX673wIf25OVegWTg45XlQfn5qPFXJAyfG1MsMXF0vbYTmU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzisL20iDJ2c2UwfDW+yNtsa8C21f49ZKw+yTfR7LCL+kISGeCi
	iL4qOqevG0rOB9Kc25vXGSrZo18DaTUUmqip9biZwSf8qGrprTfZfDmz8AAOB6kmQUFh1sMgOg5
	h0IlJp3XBEhiI4p2EGUQf3fahdPVmMMl6uKMbo4FoAg==
X-Gm-Gg: ASbGncs9wA5/pGeWf5fVQhCQOQPSIiUBc3D7qK+V9BSNzNMNiDuUNbFE2x6yPK4qrpq
	A+4tr0bEai2CoBwwGbUMb1BuF0tYBgQ/w/JG/HTP5PvF9HR243SgpOXK9A89YzwvUlpEAyTZ5r6
	z4BxfnhYXiihK6twWDEkmJAx8bSxdhYCJWYm/jkZWuHkNlcG85LxUZcLYYMtQigdXupOowa1w5r
	UZGFBTYNVqzjOdIkFkvlulzLyB/QHa2j1WDYDIU4f1vQaSuPr4hNUmC629su/PE7ifpvMM=
X-Google-Smtp-Source: AGHT+IHndeIzowFKyGV77xJrwW3PbYRom9TRTnbQmCDghJkjbT3tIKvOTzTzPAFp9D2embhKwkVO+r8Cc1SJcrX3RR4=
X-Received: by 2002:a2e:a9a8:0:b0:36a:cdb0:c1f3 with SMTP id
 38308e7fff4ca-37797a143b5mr45120621fa.29.1760998144941; Mon, 20 Oct 2025
 15:09:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251014140451.1009969-1-antonio.borneo@foss.st.com>
 <20251014140451.1009969-10-antonio.borneo@foss.st.com> <20251014-affection-voltage-8b1764273a06@spud>
 <b4eca95eaa0e6f27fc07479d5eab2131d20eb270.camel@foss.st.com>
 <20251015-headstand-impulse-95aa736e7633@spud> <0826a055f6b2e3e6b50a5961e60d1b57d1d596c6.camel@foss.st.com>
In-Reply-To: <0826a055f6b2e3e6b50a5961e60d1b57d1d596c6.camel@foss.st.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 21 Oct 2025 00:08:53 +0200
X-Gm-Features: AS18NWB0sT7rk733pb0JBmXxWZ3rsESep7Jo9zTjJKG7duLHdqwxNHX29WRzGYA
Message-ID: <CACRpkdbeaiNGfOFfVfDNZ=u=4yhCykcdSdHUv-td_DVyr3aWaQ@mail.gmail.com>
Subject: Re: [PATCH v3 09/10] dt-bindings: pinctrl: stm32: Support I/O
 synchronization parameters
To: Antonio Borneo <antonio.borneo@foss.st.com>
Cc: Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, 
	Christophe Roullier <christophe.roullier@foss.st.com>, 
	Fabien Dessenne <fabien.dessenne@foss.st.com>, Valentin Caron <valentin.caron@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 20, 2025 at 5:09=E2=80=AFPM Antonio Borneo
<antonio.borneo@foss.st.com> wrote:

> pinconf-generic only accepts positive numeric values for
> both generic and custom properties in struct pinconf_generic_params.

Do you need it to support negative values?
Patches welcome!

> Plus, I haven't found any existing driver that mixes pinconf-generic with
> custom string values.

Maybe I misunderstand, but pinconf_generic_parse_dt_config()
looks at  pctldev->desc->custom_params and
pctldev->desc->num_custom_params found in
struct pinctrl_desc in
include/linux/pinctrl/pinctrl.h

$ git grep custom_params drivers/pinctrl/
gives you a list of all drivers using this.

Yours,
Linus Walleij

