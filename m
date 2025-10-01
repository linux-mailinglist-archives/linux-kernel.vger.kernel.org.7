Return-Path: <linux-kernel+bounces-838808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BAC76BB0309
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 13:36:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5439B2A42E8
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 11:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AB5E2C0F83;
	Wed,  1 Oct 2025 11:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XWjRZgh6"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9D32D8766
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 11:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759318479; cv=none; b=rBB5ISRXobTMmP4FZyeMwUjxxZuiTv3JbQLiSZm7xTxYbOOc8z2tMrYWpYYZG36K0k/aRa1yD8AignUl1abHaqbpCstbSIGtiGZspyx6pKHx3mFLuZuegkjYnC4uobO3/NG6gGdJU9R0y6hGrs2cul72jfeD9/XB4+ynLA4dP18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759318479; c=relaxed/simple;
	bh=WNpBXHh1zwWhrKWvrvy86jONBZtsYTYo1DpEBtOgp5s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bt2b27rCEKaTEcaaC7xAtdqc5sl3Sdbz9/B/9NOCWi1kY6jcPhl4IrpqVw7x0ZnuPMReC4Cxom5Mrb1Xt8hN83iblkLFVZ9xjLo+0XBKDZZETfQkiEVo3Uam8bzUCrnT5DIUB56/udGFUy0uUgPjduUG8U7yyu/bSMCqbwcqHRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XWjRZgh6; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-36d77ae9de5so65080051fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 04:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759318476; x=1759923276; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ab9PlkF81fTilgeQLgjVXBGTX6LGhe7zzDg3KUeGvt4=;
        b=XWjRZgh6I9HTKrZiM9IqhApaoQNFUtG0x8Gx2nO8g/yIfsbbD0ZgSWKkN4i4Z21bSF
         nD06QB9Yn6fS39NIzu4T6e4wcDUOCQRBGYoUvCjr7Fbkht/Pac8ODn3pC7LI7BmJ6I3/
         VdMjrv0niMYQU9nu5OeSLwCgU6n2W3Q1Bu4TudtuQ06oBvBX/RbMsZ3iZ46QkGxOwVee
         xs8P+Ql3Uwy2jmSgX9gwKP3ATFxQsWcy7KKxs0+v8N2qUAi/dbu2jWmnoWwOrpl1qygb
         uNvgpvDsPDBfuRjLHUVNwbzOuNRz1U8p62SnoFfy1vLZZ+XsWLS6iigrGretJYMkfsUn
         XR8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759318476; x=1759923276;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ab9PlkF81fTilgeQLgjVXBGTX6LGhe7zzDg3KUeGvt4=;
        b=PPkDMS39Ks21GCndqhE1iDyomaYrCTHpcNZwEbe12KrHybQZPfpj8WJu909ozjAjNJ
         cJUY8XoZ1tEe8cagrqxrQ7zC15FMZF4dDCtlOdNdvSbwRK+PngoJMXVendUy9kSdwmSI
         +yUdEYDp8y3WTdBLxztsLxdhOqL7z+FqhmRLGtUAkmmC6yKLqQjWRAFhMKFiRxIZCcjR
         YarAF12IlmSW2r9JfNwFXfFhPVFfLNwNb0oTlSSMzkwBGPx5gb/hfUiFqSptNV5Me6PD
         UcA6O1CG47Z6zEFfCOu9mdZhkHTfgtBX6afKvErnf3mYVa7pig0xjMqRWBTKC3N1qO5N
         Unbg==
X-Forwarded-Encrypted: i=1; AJvYcCVr2JbCI61oDmOi5WiVcyFjhpEWgBv3sEzQYNcYs5BhBhnt59cn1Q/vX+5ZBPmHrYzVs/IOmIMXI3oH1RU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0Zu3Q9WyHnTyij7cQneXl+CSUzznPFc3Tqk2pJVFJ/zBAklQ2
	NbUQraH1a2h7kusvf3xmHY9ZidaUFpOSi63KU4FyCmMhjDJ7sSyM/iH6wjjEmPF3VnvYrUJnR11
	AtWLg/uGE8N9BdP1rhdvh2iHVIk+YkVHnXg5m95viUw==
X-Gm-Gg: ASbGnctI7t64Z9HV1bOquNzqab5DZFjGSUgLXBbbfTisfjxhkj6QADWjpuxCRs8a2jv
	WV70BsWGRSbovgZ0BRPIQGVUv+4qba5HOWIhTJilcX9Y6DCW0hUhFtLk7727NQh1eZmOYeY7Aup
	zJQnijm/6qGERty+GgXfhIKKpBQxwhc9aiKAq6sUSEGmvISOlAJ2GCfwXYMTwhRCJUw6tCcEpy7
	N9g7WhA67YmLkmXReZitorOVPM6NUs=
X-Google-Smtp-Source: AGHT+IGP2vuqK84XEqUB3/YBZvgWQuvqnzUP46OyqzDbIXx5IsYLhF3Kjcv7T2SMXTcgPNWF4YygZqINvVbsODfn46g=
X-Received: by 2002:a05:651c:2121:b0:370:7fc5:7e06 with SMTP id
 38308e7fff4ca-373a7394b33mr8623441fa.13.1759318476088; Wed, 01 Oct 2025
 04:34:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250926-manpower-glacial-e9756c82b427@spud> <20250926-unshackle-jury-79f701f97e94@spud>
In-Reply-To: <20250926-unshackle-jury-79f701f97e94@spud>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 1 Oct 2025 13:34:24 +0200
X-Gm-Features: AS18NWAJqeVZkj4FKdackrTbpQrFfNV0Xk66hhPzy0DGiPwaNOMELkJ3p_nkSbA
Message-ID: <CACRpkdZ5RCcaNJB_3ufAgpDtdJBKfOVrMbJVAQWaVSOkY0-XNQ@mail.gmail.com>
Subject: Re: [RFC 3/5] pinctrl: add polarfire soc iomux0 pinmux driver
To: Conor Dooley <conor@kernel.org>
Cc: Conor Dooley <conor.dooley@microchip.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 26, 2025 at 4:33=E2=80=AFPM Conor Dooley <conor@kernel.org> wro=
te:

> +static const struct pinctrl_pin_desc mpfs_iomux0_pinctrl_pins[] =3D {
> +       PINCTRL_PIN(0, "spi0"),
> +       PINCTRL_PIN(1, "spi1"),
> +       PINCTRL_PIN(2, "i2c0"),
> +       PINCTRL_PIN(3, "i2c1"),
> +       PINCTRL_PIN(4, "can0"),
> +       PINCTRL_PIN(5, "can1"),
> +       PINCTRL_PIN(6, "qspi"),
> +       PINCTRL_PIN(7, "uart0"),
> +       PINCTRL_PIN(8, "uart1"),
> +       PINCTRL_PIN(9, "uart2"),
> +       PINCTRL_PIN(10, "uart3"),
> +       PINCTRL_PIN(11, "uart4"),
> +       PINCTRL_PIN(12, "mdio0"),
> +       PINCTRL_PIN(13, "mdio1"),

This looks like it is abusing the API. These things do not look like
"pins" at all, rather these are all groups, right?

Yours,
Linus Walleij

