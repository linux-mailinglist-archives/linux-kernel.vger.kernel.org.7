Return-Path: <linux-kernel+bounces-864278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6F66BFA5D2
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 08:56:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E546C19A16EA
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 06:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 401862F25F7;
	Wed, 22 Oct 2025 06:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KRm6jnI7"
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25782F2916
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 06:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761116158; cv=none; b=fz564bkMyTEmgNWrspqRbFV5XIz4RSLl1ITqskhRoCbWFTC2QnID2l3Df0yMyV0h3IhiGq6RJOkgoD7/XttAntheWNhlstYNn+6Hgv9XYU8h/31A1UsizgsqHK6EvO0QgBSEM3JIk0pvDGnNs+pdM033PaIxnxzWoe2EiTwR14w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761116158; c=relaxed/simple;
	bh=WkDEzB5N4V8tlJFRXR5ysA8N/DAcuP7R5T1XoyuKbJE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wa17iMccoFNPX6YtgVtBP2BcstZFUcEZC+p7BkNEozArKQRLXWA9KY2mLGl/IUHCVbQrNkip+Alx0oKFRwIio1ARPkEygWmlJr+A1ZwNhqF3HBeW/gX3tny7yjGX7tSWnI8IMhl6L/7vrUJXhpY+bbDUlPGvkqoRRbK/9m3C5os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KRm6jnI7; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-3799fc8ada6so1618623fac.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 23:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761116155; x=1761720955; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=T+geXNLPoYT+g7n3ssTeMIPZBREGJuzg2Y1yRpcxjwI=;
        b=KRm6jnI7vvLFmAuj/rRP4uicZRWQYt7BKFYx3TAzNT7bHcAmJCzw2WZrJwd4dOHRC0
         9hIu7/hC9pgFhulagq6z/8pzMABp8a8zW63aHg9Yd3HLoc0j/A1Fo9YVAAwbvqGZhXFg
         vFZCT0K0wu+2pNukzBDIS7WpPdw7BUFo6Qfu5GLrH4uoqGIvWD5qCb9UdzbsHAaOsbjT
         paCdtDTWYa0gcEla2FBKD0NU9a5BCE4b/A6SfTlMW5vmKgcK33WzWhgIO2HA/4WwEypA
         GIyFmOhX7XP639gNKAKgMhxXDgFOg8F0Kjv70wM9zsarIacYm8pfE4hAqEE1tx4suaww
         oxgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761116155; x=1761720955;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T+geXNLPoYT+g7n3ssTeMIPZBREGJuzg2Y1yRpcxjwI=;
        b=o3048r1v5ebxcjgHW7vP4Xg56pSURv+XEDdJmA0BFovyy1Qnx1b9IoBUjXEIGXG7MY
         t2C/sCZsAkr9ixPTyBX3kN5OGgpSAXGuG0NBJ2vjrBh3g2/zR9ye4OLA3LzH7F5YY/iH
         +stZbY/j6oBm7bWLc+eABHv9hHVzvYdV3C/iGcLfQpi5Grtz8Mlszetc3zwWmF0Au0ze
         0osqZzhzUIW9U5p9cYQ7zPo/FnuNBBrrB6ltohk84qeFsuWInph56irahBU4hYfHyLgs
         Himc2BbGudK6LRcRWh53zdWdmPrMdchB03q245zCr/Ep126uUDzZfGqaW/mDJFVpS1i/
         CzKA==
X-Forwarded-Encrypted: i=1; AJvYcCV56pjvgNcJCSgbFOZbd5zBcEgB92dCPOkCxn0A+g+GWtv5+ZfwI3M+3xMYJBjLFBqFUoALoC/rtKa7NOM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDHhDWjxOGJOzhSjRgrgmiEeWBHxxc3JAoP3BeGbfUW4hkzN6j
	3b2/FVEp3tOoDOfpETozBHjQ5JdK2dVxLJ33aCvEeCqvd6oCw9h57BhPbFngWPZe7IqR4Qch0M7
	Cs5obIm7C+M+9PnR4hFo4CgZn62H2gPQ=
X-Gm-Gg: ASbGncvPQVN/E2yB7eODyF0Xja+G5BCVI0OZYEOURyZFYpohQRA04wT0+IVNz9OhGxR
	IeRmFYnFfG3ymWqHATYw4m0kKf47+8yWu31Yy1iETGXoUwy/9yQZ3aT1y6swTG46ZuaJtb2NQsM
	GBlCgoyy/4zFKjjAeRZC1KQXxetbP880GB96yvEQoOVKMZ/sNfqmtB6lMe8ZCOLKwQNF69VuQmx
	aW9WKVHvhfkcJUVGQQd/KuJfwWxkV45H9KB/k02TNH1kmj2r/bxMeqk2+2hB35pvHvHvg==
X-Google-Smtp-Source: AGHT+IGwWUfJwaZxrSmSqwuOc1uIOsgsZY0s0HRs122BLbIZBBj56tnMVXEMMc5Eyr21rdDe3zOExr3hezrVk3Px2gw=
X-Received: by 2002:a05:6870:4e8c:b0:30b:cd02:297c with SMTP id
 586e51a60fabf-3c98d17dc37mr8955692fac.35.1761116155546; Tue, 21 Oct 2025
 23:55:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022030840.956589-1-Wenhua.Lin@unisoc.com>
In-Reply-To: <20251022030840.956589-1-Wenhua.Lin@unisoc.com>
From: Chunyan Zhang <zhang.lyra@gmail.com>
Date: Wed, 22 Oct 2025 14:55:17 +0800
X-Gm-Features: AS18NWBdi_EIGFjDegtPbIDhcO6RDB-JPNHUp1fKzjacRS6sWcnJcGCwsuuLi3E
Message-ID: <CAAfSe-uq6GszSLgtM+UBuwJ6V1Bt0_1Ard8cb6e9MMCsdpJPqw@mail.gmail.com>
Subject: Re: [PATCH] serial: sprd: Return -EPROBE_DEFER when uart clock is not ready
To: Wenhua Lin <Wenhua.Lin@unisoc.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Orson Zhai <orsonzhai@gmail.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Cixi Geng <cixi.geng@linux.dev>, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, wenhua lin <wenhua.lin1994@gmail.com>, 
	Xiongpeng Wu <xiongpeng.wu@unisoc.com>, Zhaochen Su <Zhaochen.Su@unisoc.com>, 
	Zhirong Qiu <Zhirong.Qiu@unisoc.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 22 Oct 2025 at 11:09, Wenhua Lin <Wenhua.Lin@unisoc.com> wrote:
>
> In sprd_clk_init(), when devm_clk_get() returns -EPROBE_DEFER
> for either uart or source clock, we should propagate the
> error instead of just warning and continuing with NULL clocks.
>
> Currently the driver only emits a warning when clock acquisition
> fails and proceeds with NULL clock pointers. This can lead to
> issues later when the clocks are actually needed. More importantly,
> when the clock provider is not ready yet and returns -EPROBE_DEFER,
> we should return this error to allow deferred probing.
>
> This change adds explicit checks for -EPROBE_DEFER after both:
> 1. devm_clk_get(uport->dev, uart)
> 2. devm_clk_get(uport->dev, source)
>
> When -EPROBE_DEFER is encountered, the function now returns
> -EPROBE_DEFER to let the driver framework retry probing
> later when the clock dependencies are resolved.
>
> Signed-off-by: Wenhua Lin <Wenhua.Lin@unisoc.com>
> ---
>  drivers/tty/serial/sprd_serial.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/tty/serial/sprd_serial.c b/drivers/tty/serial/sprd_serial.c
> index 8c9366321f8e..092755f35683 100644
> --- a/drivers/tty/serial/sprd_serial.c
> +++ b/drivers/tty/serial/sprd_serial.c
> @@ -1133,6 +1133,9 @@ static int sprd_clk_init(struct uart_port *uport)
>
>         clk_uart = devm_clk_get(uport->dev, "uart");
>         if (IS_ERR(clk_uart)) {
> +               if (PTR_ERR(clk_uart) == -EPROBE_DEFER)
> +                       return -EPROBE_DEFER;
> +

You are making this clock mandatory, sprd_serial driver could work as
serial ports for logs output without this "uart" clock.

>                 dev_warn(uport->dev, "uart%d can't get uart clock\n",
>                          uport->line);
>                 clk_uart = NULL;
> @@ -1140,6 +1143,9 @@ static int sprd_clk_init(struct uart_port *uport)
>
>         clk_parent = devm_clk_get(uport->dev, "source");
>         if (IS_ERR(clk_parent)) {
> +               if (PTR_ERR(clk_parent) == -EPROBE_DEFER)
> +                       return -EPROBE_DEFER;
> +
>                 dev_warn(uport->dev, "uart%d can't get source clock\n",
>                          uport->line);
>                 clk_parent = NULL;
> --
> 2.34.1
>

