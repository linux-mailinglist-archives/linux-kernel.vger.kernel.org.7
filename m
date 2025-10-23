Return-Path: <linux-kernel+bounces-866986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 43E4CC0144E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 15:09:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CCC0C358EFE
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 13:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BD61314A82;
	Thu, 23 Oct 2025 13:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EDAYAnGI"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1172DAFDE
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 13:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761224991; cv=none; b=NsYDvDledP6pb1UC/jmWNkkh8zN4cyHNRTBcUuxZ3YnuXiRd4hZyyGqpDm+KniNNqIwQYUUEu3iaKqeNjKZnjWi6zgBNfq5Bvz5D2aTPP3LwRPFDu51Sch6lGiE7CMYa7xges7DKAhVhVY7NI+c/9f2cRbxR+Up6c/R2oNi368E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761224991; c=relaxed/simple;
	bh=3VOKHanMGBVG5EectAgKfBwncGmDpanrYJiBJXHMrvA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jJ6W2RX+RReAtO0lFGTgGEGLH69taQBZBf5IYKH4MMdrnfOWzn5/VFpYAboCfiqHqZbyZQVGA1nF/ejc9ZMkL/UBN6yO53eoFg9qn+3IQbUizwlhwlS0BI9pQXqb6Yqd6NQDXHJlS2gBX6ZMNLj/wQ6XbZ9mJrpvnahejFtHWio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EDAYAnGI; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-378d50162e0so10752201fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 06:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761224987; x=1761829787; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3VOKHanMGBVG5EectAgKfBwncGmDpanrYJiBJXHMrvA=;
        b=EDAYAnGIHXQZo1QIbgFMSCRS9FzlNx1JTYHPo/RVTCX4ZZSAiFq27wIPG0EY+9E5i9
         2z9PMv7ZJJx+DSfJUTnygH+3dYuCpItHLerW3tVi1hOwCmQrHXFlL/6gwYjl2lRxEvJJ
         M8Jr878bJey16eylZytDq05rLHxEIJbdPf8vkwPKuXR5YUAiwNUzQQz6gg6r3avSMwX9
         eLcmIj0+BA1t4okrLwFuceZVe6QC2ChG43kLgBY1+EyURJHCitkDSDcsaBIqZSKwgVmm
         T21fMy9OHvjmXJxkuADZkGnwRHdDeA9msJxftnqV5MlGHwhY5I9j6+FD9dXKqM6GaGSe
         zvPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761224987; x=1761829787;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3VOKHanMGBVG5EectAgKfBwncGmDpanrYJiBJXHMrvA=;
        b=U8pSROeCAgZT+Z+APPAnahGZiOHLEyPAVoKZ/eoUeQ5UpDydfxnw9sq5G7MtS3F3sw
         6vjWnwM7wgELJ3nCzBp5kNY+rC5PWaLLwQfCpRMo4aML1QYxKU78BOwi7nrSpO5ok6Al
         UrSvu3kziap1WAQwh3aqN5x5n0iyfaukXCbMnveouNbHprBSfjRpbuPObIkBGQ4L8YYL
         HgjTktBelyZDvHhiIA6/3HN+E9hTuvXMKi7OXAZ2PcfTuUeByEAfy52iH8tlhBe5HkD9
         XFYTbkDUB349YYLc+AefTV7zfM8Swu2GpYeJJLiWV3gn8q48e4bdNwQWIf9YKIMQZlWn
         Gr4A==
X-Forwarded-Encrypted: i=1; AJvYcCW9tChx2le04aPoNnGSgZhz10RIGZ+0hlWl5lfsU9XUjJV5eQPaCtxsgYDbZO+o4oyrlg4nuvZigik4984=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXf7LSKHufEegTkIj1i4i+0J8ErCzbSZD6TsnrMqRe2hEP/mnN
	M7iLMQQdI9DDcPkUduSYDLU50ckKMhj/04BPvorbdcfHXrgShFrZPSpv2YLEGPowopDnlcurD5s
	k9MoGXyhkmWUpQFtdapq63fqdyGt8H5AU12jxEgrP5w==
X-Gm-Gg: ASbGncvssTbbPEdYvRmAtIQbF+E4O6MENkeUAln/NwUX95/QsqTAjJ+IDVnl3wW1pf9
	ep6fxuttfFtz9k6l0kK4uxe70vwpYZmXGg/DSdzENAwO3IEmZEQvDScATUfQHKF+UkqqVfoZ/8v
	qLEWNq69jLqhWyeCeYm4iOm3XwsUMyYyGwTWQX8s7Oa//xeWVU4KjitJekhc4TXAsB8ZWi6VafD
	mWQfUsUZMlgS8PXrwvfjVtwL6cyliavoTpZbdydTQILX7zI679BeEavA6vyF4btieJGkgY=
X-Google-Smtp-Source: AGHT+IHKsI4LroHvhQiOiv8v+WYGX8R2Y315enlFZPb5agXLsESD3RNWJ226Muyk6TOvybUbaca071F3ZyIWXLl5t9U=
X-Received: by 2002:a2e:a803:0:b0:360:e364:bb3d with SMTP id
 38308e7fff4ca-37797637a81mr78566931fa.0.1761224986643; Thu, 23 Oct 2025
 06:09:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251023075530.14739-1-eleanor.lin@realtek.com>
In-Reply-To: <20251023075530.14739-1-eleanor.lin@realtek.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 23 Oct 2025 15:09:35 +0200
X-Gm-Features: AS18NWAYmnic6oWf5iboMbws3izQcHCwwcYOf4b4ibKRPNKkPwxuWQCPvfPC3fA
Message-ID: <CACRpkdafo2Uyvu0L+MJx5D6X+BX_efac0oTLjoba+HsCFjgnQQ@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: realtek: Select REGMAP_MMIO for RTD driver
To: Yu-Chun Lin <eleanor.lin@realtek.com>
Cc: tychang@realtek.com, linux-gpio@vger.kernel.org.org, 
	linux-kernel@vger.kernel.org, cy.huang@realtek.com, stanley_chang@realtek.com, 
	james.tai@realtek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 9:55=E2=80=AFAM Yu-Chun Lin <eleanor.lin@realtek.co=
m> wrote:

> The pinctrl-rtd driver uses 'devm_regmap_init_mmio', which requires
> 'REGMAP_MMIO' to be enabled.
>
> Without this selection, the build fails with an undefined reference:
> aarch64-none-linux-gnu-ld: drivers/pinctrl/realtek/pinctrl-rtd.o: in
> function rtd_pinctrl_probe': pinctrl-rtd.c:(.text+0x5a0): undefined
> reference to __devm_regmap_init_mmio_clk'
>
> Fix this by selecting 'REGMAP_MMIO' in the Kconfig.
>
> Fixes: e99ce78030db ("pinctrl: realtek: Add common pinctrl driver for Rea=
ltek DHC RTD SoCs")
> Signed-off-by: Yu-Chun Lin <eleanor.lin@realtek.com>

Right!
Patch applied for fixes.

Yours,
Linus Walleij

