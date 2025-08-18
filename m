Return-Path: <linux-kernel+bounces-773989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA0E9B2AD40
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 17:50:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C99E58209A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 15:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ADE93203B4;
	Mon, 18 Aug 2025 15:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pAgOcfzu"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6359C2036FA
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 15:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755531968; cv=none; b=rxCmPb35KG2Lkegoqy/MP9dte+RmUYdQv+0s6IbhCrySCWtazF5yhnMm0n54KA0Swyby0lpMF/f9pLor/zZZqplER8fuSxO1kh8rVm6qHSqS6me5Ua+45OEyVA/SAW8B8K0oR6IVPTpyGFJOrY53fqQ6QsPhzlDScfnfSW4nXKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755531968; c=relaxed/simple;
	bh=V9A8nqHTup9ZR91fdAkDX3/VWJ7GOgH3IYdlBgF2tus=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D/3QgfA6wBPjWK4NTcLBt6ozEWy/l8MtAjUbk05Lfy1impZsUMGmxqRtdXq6RTYeWoqFYRzzh1TQ1wzaQ1ugscG/MCTzm6BMO7DkAJoN7bh5rhU8jxk98sPUSfeZ9obF0aGavhwu15/9fVf02Ci0zV7Wb7KMiA4mwQjAoMx3Y/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pAgOcfzu; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-333f929adb3so36401441fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 08:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755531963; x=1756136763; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=51DTC+MITTH703qrd2I1XRJ94G7+1YiQ7tYFyiKxmzY=;
        b=pAgOcfzuZdNXo1QLi+fdQv34MCOtqrpMynZ0eBD00VmnEmvuGzoMFEH7DDj0x43JzN
         vq5kx7nXJtGxc+upulCbwaOfSSvcH6avZ1FpAIDz03rUvwVYgacupaJbHyKbmenvNdKJ
         VcxHX/WM6FAtodKfDyerntyX/JZN3ki6UGW7STWzUwTisrlA8xZ8Q0ZlIvm2WkySeXYC
         ZzRiK9tTX5KRPDeHP7l4sALiLbQZpuOuYXbvqpSHBvoA7rb7BBJP/XDxhV509A10uWvK
         aq4eWbJvlFDf5Eu+JxUI/TaW3cb6arhmOxtsXeqVgHiXnr5DwKqCU5M9Igm5NGtcsb36
         pkbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755531963; x=1756136763;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=51DTC+MITTH703qrd2I1XRJ94G7+1YiQ7tYFyiKxmzY=;
        b=GH/snCP/GCRV9mdGRbiKl2CYZNr2SNv89H2XZ/lrnM7NKny7pRPL4LbAKj9Fkt89Yk
         okE36h3RXH1xzMqSSXNi+MHGbF3yoAqxO/I/7/utugZwdCZpd6x7IuI+fPbWc3DFf6sl
         /38SIV/plxoan7vuTwUHUP1WXn2Iw3Od5poisSQU/JkuS3TMn9kRvorJCRlMyZF1cydo
         GSnhimjkMZ3phSKxUnQI4+W6eEo/MJopbrGp673+gJBNDcSxbqD2gwMGlokLcUBw2k2Q
         sLDFTlstcm38Am8UyBENAwS/jyava7/4eTiAEVCJFsp4T69FhddYGFBaeOpeEtgkcxec
         K2Sg==
X-Forwarded-Encrypted: i=1; AJvYcCUt7FmTQ8e+E1eNeluFi8sckct6Awqgro+gzv4DaFptFMxdayl7j+y18mFfr2OuckSwHjRYaIp7a7Ss/lw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoS3QALvOFlS441gBZ2cFn3fWbbNM2y5mq4JZMb11q3ZNMjtC/
	cFFth/KZ3O0f8gFMR3CKukQ6XG4s9Udf7PccRQ3/JnKUjLZjWmH10ihGMBswcj1pbo03yPWKLBu
	MwSC5/ghA1GqzlLr4HHAVuaXAeCFprwJJ9yO0mbccqw==
X-Gm-Gg: ASbGncuUasCCeOjxPD18UjAqYoY6nID+nlmRVXzTnVmBpturyEBxhuqxFsLytodkmGH
	LqYxnkppTOqPaJn1J3aczfDYL5O+jSHZE/W/cahhClL0tmA/GlzQ0mU0UaJ/Gms0+rI2iEbMbzl
	FSnpxEkBBS6W1n/91g4AHV8WFtWceibRXiSqC/AW9WVHovxGGzOrvkQzq+DhUFIGdbe5DUkz2rn
	JMGVwuL2Lw6
X-Google-Smtp-Source: AGHT+IHwmWtaGT/XklYdjGHxL0ZkWBsslCIIfDul9Sr0lAl+wS4aHTOEpnoQAPHxKPwDMb6Ei8e0PuqlGjO+zjkpvos=
X-Received: by 2002:a05:651c:510:b0:333:f3e6:9f2d with SMTP id
 38308e7fff4ca-334097ca050mr27791091fa.6.1755531963498; Mon, 18 Aug 2025
 08:46:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250811-aaeon-up-board-pinctrl-support-v9-0-29f0cbbdfb30@bootlin.com>
 <20250811-aaeon-up-board-pinctrl-support-v9-10-29f0cbbdfb30@bootlin.com>
In-Reply-To: <20250811-aaeon-up-board-pinctrl-support-v9-10-29f0cbbdfb30@bootlin.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 18 Aug 2025 17:45:49 +0200
X-Gm-Features: Ac12FXw-f5f96UXYk89oFAKTC8GUPUN3mfWKfLNKZL2BLwooNi64tGeRuwAt8AM
Message-ID: <CACRpkdb6XjX0unh70Gwq1dmLdGjo=19W39fziDd0L8vT3g39hA@mail.gmail.com>
Subject: Re: [PATCH v9 10/10] pinctrl: Add pin controller driver for AAEON UP boards
To: Thomas Richard <thomas.richard@bootlin.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Kees Cook <kees@kernel.org>, 
	Andy Shevchenko <andy@kernel.org>, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	thomas.petazzoni@bootlin.com, DanieleCleri@aaeon.eu, GaryWang@aaeon.com.tw, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 11, 2025 at 3:25=E2=80=AFPM Thomas Richard
<thomas.richard@bootlin.com> wrote:

> This enables the pin control support of the onboard FPGA on AAEON UP
> boards.
>
> This FPGA acts as a level shifter between the Intel SoC pins and the pin
> header, and also as a mux or switch.
>
> +---------+          +--------------+             +---+
>           |          |              |             |   |
>           | PWM0     |       \      |             | H |
>           |----------|------  \-----|-------------| E |
>           | I2C0_SDA |              |             | A |
> Intel SoC |----------|------\       |             | D |
>           | GPIO0    |       \------|-------------| E |
>           |----------|------        |             | R |
>           |          |     FPGA     |             |   |
> ----------+          +--------------+             +---+
>
> For most of the pins, the FPGA opens/closes a switch to enable/disable
> the access to the SoC pin from a pin header.
> Each switch, has a direction flag that is set depending the status of the
> SoC pin.
>
> For some other pins, the FPGA acts as a mux, and routes one pin (or the
> other one) to the header.
>
> The driver also provides a GPIO chip. It requests SoC pins in GPIO mode,
> and drives them in tandem with FPGA pins (switch/mux direction).
>
> This commit adds support only for UP Squared board.
>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>

This patch applied on top of the pile I pulled in from Bartosz!

Yours,
Linus Walleij

