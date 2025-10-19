Return-Path: <linux-kernel+bounces-859856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E74CBEEC6A
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 22:53:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5693F3B26F4
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 20:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4459D22D7B6;
	Sun, 19 Oct 2025 20:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ABTacBYu"
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A431222126C
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 20:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760907228; cv=none; b=IWTbUPCWF/RLPWEGh2QVColkdRS0ftyJE9AAJZtFcxdAZF29FYq44fipYYVCJ3sLlFN0+1yadDodxPlA69P4hpYde8B4QIF5qIbADpAkTZe9/310vviySt0IwLByvjHMtA5vwLR/0OJFzgr/qg8pXjG33hP+ePVe7jaII7QViaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760907228; c=relaxed/simple;
	bh=O2zfE4vf4ah1dibiRpvsd3NnhgM9Vr10uy3t41JeKRI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ht3YDROBRRV769ONjv28acA8+JlJzxmpK2uq5sVNlLFSz8F6iJ7JAsUsJuda91DUtkqdVrLvo6chFR2qR8ZEXjvbDyNdz4+dVT0si98MiOAFk9KIfdHC8+gxbkTz2b+0Up5jp++odyNgatFQgbCRGyYKR/B7SFAaShJYBqQVHFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ABTacBYu; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-7849f01e56eso2835167b3.0
        for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 13:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760907225; x=1761512025; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bLIclD2aF84lUbWy0CIM8XnSXp6AC1BEWNN7dbQyLN4=;
        b=ABTacBYuhPvnzWu4OtghliDgZGKXPT2miCS4VSLkBaizIwEsmYpkZ0aLIblBDjBKZ3
         lfKOA+/R/C16MdrumYsJFws/cRfQlq2+gDETwDhxXntuRtkbFdir+mKl2McpAYs3l2y2
         pZYVqBdMw2ukaEC/GOh0E+u2hmWbefXPK5OQvR5fg7kNCIvEEuUBJ95GbpFnwx/gIwR/
         3ZPphUA7b5lh08vMlXxRuNRZB9fJ2tRxncBS4e2ZmXtx0bBP5JiUmb+xmDYjdKKdhsi1
         teCpwTGIQpgr2rLassZZrZ9loRMic8ujW4eccBFhYQQrVzQqGSJ2SvAmUx8LNXaJphIB
         YAWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760907225; x=1761512025;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bLIclD2aF84lUbWy0CIM8XnSXp6AC1BEWNN7dbQyLN4=;
        b=MRQrfGq8ms8HCv2T42QHcoIGNkGA9a8WDnE+B5/X4LdNFRWA4ZoeHrGu7Y/uzksyd8
         KQYQCHvEoXdfv6Oeny9F+w/j+tmV2cxWwE4VnLznZ8WRYyGLk13oD/F7JlYknfsdiKOa
         COwZ5PFMbgNOWeALjUpdgbs3oBNTNT7P+Boh7hyxZK/t8ABOuZqFLCqRtBBA5v/uEUxT
         R+H1FxIVCGpwnKJ12yRG740L8nukR4GPJQ6VERawhUZtgIyGn6DNRzkaM7hDDrMP/wK5
         FNOSqPvtGLKoH4i8yd7RWMT7h8x+8TU9kUN03kh5esytlT6P3MCbQMvGX5sljqyKGIWq
         4Uww==
X-Gm-Message-State: AOJu0YwghazRDuSdXnflRg578mqq/PH6u907VX+kMhssEsp99VoPTDm5
	Qj5PNlmNbG0gmnYvhNiu3n1HDMOscQf/glnz0hlNM/ifF0/r+1gtYalCWWcQ2MR2KzlT7QSpUtL
	fPjGqLrq3fd4SZKySXYRW1utNF/xKyuc=
X-Gm-Gg: ASbGncseYlWHBGKUokbMnp7gONLvKEHpgbZW3tIPnCn+k0EG9VJ6mXDvjjqYfIW6qb+
	H0MYo+F++1te2lcgo1AXJskP3gKecVbiTD9v9kda0uB5HXBB6zmuKWuBYR/Zbn8KTHklQS6IikP
	1w9UYh0RKPW83K3cjZZi3F3wPBbrlTD/wCk1lRof+2O5wXjhkLWeT8BnCmzhZ+T0CACgimPAYJV
	xXnAF8oxZT1I9q+yDLuCzj2pD0yb26ERGEK6s+mUSeirGAWQMIUQhldQWEBtfB81FRBQ4tSkkxc
	z6pP
X-Google-Smtp-Source: AGHT+IG+VnVg4eeqtni24th+c8XSTz9bZ4o+eo5ggxBTkXyndw/uiD4XSbKqdvbqo7rPEXjxfr8g73d/jXS/Qyg3a7c=
X-Received: by 2002:a05:690e:4091:b0:63e:3c2a:c33a with SMTP id
 956f58d0204a3-63e3c2ad83fmr192995d50.12.1760907225531; Sun, 19 Oct 2025
 13:53:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251019191519.3898095-1-aurelien@aurel32.net> <20251019191519.3898095-2-aurelien@aurel32.net>
In-Reply-To: <20251019191519.3898095-2-aurelien@aurel32.net>
From: Emil Renner Berthing <emil.renner.berthing@gmail.com>
Date: Sun, 19 Oct 2025 22:53:34 +0200
X-Gm-Features: AS18NWC8mas1vOpzBcYTdN6WQn4JlQUKb553pLiF9PjWnggz16K-ukTapFmx2g8
Message-ID: <CANBLGczi3GeaC4aWECV8NS-zqSHgRa-5onynz9fGsZeN8qgysg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] driver: reset: spacemit-p1: add driver for poweroff/reboot
To: Aurelien Jarno <aurelien@aurel32.net>
Cc: linux-kernel@vger.kernel.org, Lee Jones <lee@kernel.org>, 
	Sebastian Reichel <sre@kernel.org>, Troy Mitchell <troy.mitchell@linux.spacemit.com>, 
	Yixun Lan <dlan@gentoo.org>, Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	"open list:RISC-V ARCHITECTURE:Keyword:riscv" <linux-riscv@lists.infradead.org>, 
	"open list:RISC-V SPACEMIT SoC Support:Keyword:spacemit" <spacemit@lists.linux.dev>, 
	"open list:SYSTEM RESET/SHUTDOWN DRIVERS" <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sun, 19 Oct 2025 at 22:34, Aurelien Jarno <aurelien@aurel32.net> wrote:
>
> This driver implements poweroff/reboot support for the SpacemiT P1 PMIC
> chip, which is commonly paired with the SpacemiT K1 SoC.
>
> The SpacemiT P1 support is implemented as a MFD driver, so the access is
> done directly through the regmap interface. Reboot or poweroff is
> triggered by setting a specific bit in a control register, which is
> automatically cleared by the hardware afterwards.
>
> Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
> Acked-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
> Tested-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
> ---
> v2:
>  - Rebase onto v6.18-rc1
>  - Use dev_err_probe() to simplify the code
>  - Fix indentation of patch 1
>  - Collect Acked-by and Tested-by
>
>  drivers/power/reset/Kconfig              |  9 +++
>  drivers/power/reset/Makefile             |  1 +
>  drivers/power/reset/spacemit-p1-reboot.c | 88 ++++++++++++++++++++++++
>  3 files changed, 98 insertions(+)
>  create mode 100644 drivers/power/reset/spacemit-p1-reboot.c
>
> diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
> index 8248895ca9038..063202923d95d 100644
> --- a/drivers/power/reset/Kconfig
> +++ b/drivers/power/reset/Kconfig
> @@ -283,6 +283,15 @@ config POWER_RESET_KEYSTONE
>         help
>           Reboot support for the KEYSTONE SoCs.
>
> +config POWER_RESET_SPACEMIT_P1
> +       bool "SpacemiT P1 poweroff and reset driver"

The driver code looks to be written to work as a module, but here it
says "bool" not "tristate".

> +       depends on ARCH_SPACEMIT || COMPILE_TEST
> +       select MFD_SPACEMIT_P1
> +       default ARCH_SPACEMIT

If it does work as a module I'd prefer "default m" here.

/Emil

