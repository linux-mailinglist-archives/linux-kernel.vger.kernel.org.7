Return-Path: <linux-kernel+bounces-831930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29F7FB9DEC7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 09:53:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0772383959
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 07:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF5D925C821;
	Thu, 25 Sep 2025 07:53:40 +0000 (UTC)
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71EE81A4F12
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 07:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758786820; cv=none; b=sgVDz5xI5rknmiL8OFX4gmr1xp2iqfiEX7ZQyfGxV0LJYpY2MLGyKrjwRs3BZuZCwm11AvunA3X7Wj9/cOZvSG4Renzd4mKHbb9qF6SyUB0BkJE5kMHcSzWmRE/dxa2p36lgvCdUUwscVWC/UT0RR/1wonZTB+K8fPWZNlB2azQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758786820; c=relaxed/simple;
	bh=8MOOlgpt3OudDO28qQr2MAUrM06asLJeVuzzvJ7Tovs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hSHMkIvzbUAXJxiAIKGeNnjf28sol7geucJv+el3N4Zp5BuqOLm7iKoA65+2bSiEOQW7rO3GoHR8UyLGZXhW77EpomyweSBvytLlpYK3vSD+WOSzqz0VMA1VUWXdYPkqGwu6tB+MYXuBQtL57nodb2XhUhNbt9cgALLuJi+AjPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-4248b34fc8eso6299365ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 00:53:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758786816; x=1759391616;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9fvGyyGJ8hFx3nYrMkZDfGE5Winq5taN5wWeFI0QZNc=;
        b=QELfkYns3FOY60U+5sXfmPv4NN7SpWNAf/LidIG5zjxtbPHcNpxtypB+kOpIDOihPv
         aq2ufFeDroTFGgzNu6d6aXZyq43hp6PSLKA/9V0iZAa67TMpV+Max2QK9VYXy+ncY7yt
         aCKkipLiMyubp5o/pLSCg3gbbAnzzrKiVTG2a157CkvmitRn5LA1Y2oHyUsfSsHI2XM4
         cNfxbkN1zPZDaBz7BN+RDmBgbLnTRUMKUyVNrUQ+Fm0QRK/SGMY2JEw7w7C8/cXFa5T+
         W190kQBYk/8wO16wNS0u3MhLeeQiduIWrWwV6omvvFI5IjQq3cqxLnhpcvfvvxry1op3
         tt3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUT/It2sbjMWCJasqTkUfunu3e4vJAyg2KS8RBo7/19iljl4i19PUa9YNhZs9u4T17Id/SrVXJskOXeYOI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxAupQBH/zCxXPAgFHKaRJwCddk1UQm9pfMs1hlKguOierG+bk
	hPGOfL7bMLKTXStMnhJNGfXom+L34O0Iu1hkLQh0+kuaoHuKY/oh2NafNiQkjdyz
X-Gm-Gg: ASbGncuFOie9GBILVH0CW6S8TTgnKcPz/Y6DDJr4qiEcPhzovuFVNHk2zpVdjtDdMiR
	PL2G/M8vbVexMjBq8omEtP0LVN8lLp5BhUmbOMwEWT2pyGADZeovZ7/wTHAR8TqbEIAtzhhtfCh
	nrHqIKWedrxvCqqWMcMT5vj34Zg7Zggico6TmDE//C8UQd5s52tFlhmQO7z0kT8Gz4v4xDEyaeJ
	cf57QTcsLn2uyLidQTNRt3+eT+3g/DV2AxDCre04W4e8ESw+EidKUIbQ+3f9ZlTr55EfzlCchOr
	Gx+nN4okdimoBiSZsxDfUDKOnXbd5x7cEWlALF9Q/dPDHjFzDt6I9U1ae7Ppo0ArhoKislROP7n
	jwkL/soCPWTd7hm0pHnSv8EZg0y1Bk2JedaSoEHtp7sii9xWdMddwmq/qHRGK
X-Google-Smtp-Source: AGHT+IFXaNemRhjUlBI3AY5N3uGdFzmFNXkwcWH6z7UUMcNztg5i/+lo+g57u2TzONqyJBlnZLC9Tg==
X-Received: by 2002:a05:6e02:471c:b0:425:7539:bc39 with SMTP id e9e14a558f8ab-425955ed6f4mr31914915ab.10.1758786816329;
        Thu, 25 Sep 2025 00:53:36 -0700 (PDT)
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com. [209.85.166.48])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-56a65b2a946sm577685173.34.2025.09.25.00.53.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 00:53:36 -0700 (PDT)
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-8a936b682b3so61175639f.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 00:53:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUgZnHaUABxQxniWs1OCBgnHXGJFS49xk81iLQzgvkeOzqD3R9FRryUQrcae9iOgHasUX+whCq6GP7Sqls=@vger.kernel.org
X-Received: by 2002:a05:6102:510d:b0:529:fc9e:84a0 with SMTP id
 ada2fe7eead31-5acd36bc5d5mr955558137.32.1758786509499; Thu, 25 Sep 2025
 00:48:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910-make-compound-literals-normal-again-v1-0-076ee7738a0b@linaro.org>
 <20250910-make-compound-literals-normal-again-v1-2-076ee7738a0b@linaro.org>
In-Reply-To: <20250910-make-compound-literals-normal-again-v1-2-076ee7738a0b@linaro.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 25 Sep 2025 09:48:17 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWoEXLTPyQL4kt1OPVbrDDcBdBigqUM7EbNZjZUsSmRHQ@mail.gmail.com>
X-Gm-Features: AS18NWAlEwAE5FC0AW6Wq0ip31mrrj6gmcRezsp6GMYcQa-YSc4N16xdaxhcVw8
Message-ID: <CAMuHMdWoEXLTPyQL4kt1OPVbrDDcBdBigqUM7EbNZjZUsSmRHQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] pinctrl: use more common syntax for compound literals
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Lee Jones <lee@kernel.org>, Andy Shevchenko <andriy.shevchenko@intel.com>, 
	Liviu Dudau <liviu.dudau@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Avi Fishman <avifishman70@gmail.com>, 
	Tomer Maimon <tmaimon77@gmail.com>, Tali Perry <tali.perry1@gmail.com>, 
	Patrick Venture <venture@google.com>, Nancy Yuen <yuenn@google.com>, 
	Benjamin Fair <benjaminfair@google.com>, Linus Walleij <linus.walleij@linaro.org>, 
	=?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>, 
	=?UTF-8?Q?Cl=C3=A9ment_Le_Goffic?= <legoffic.clement@gmail.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	James Cowgill <james.cowgill@blaize.com>, Matt Redfearn <matt.redfearn@blaize.com>, 
	Neil Jones <neil.jones@blaize.com>, 
	Nikolaos Pasaloukos <nikolaos.pasaloukos@blaize.com>, Hoan Tran <hoan@os.amperecomputing.com>, 
	Yang Shen <shenyang39@huawei.com>, Imre Kaloz <kaloz@openwrt.org>, 
	Yinbo Zhu <zhuyinbo@loongson.cn>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Manivannan Sadhasivam <mani@kernel.org>, 
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>, Ray Jui <rjui@broadcom.com>, 
	Scott Branden <sbranden@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	openbmc@lists.ozlabs.org, linux-gpio@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, imx@lists.linux.dev, 
	linux-unisoc@lists.infradead.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"

Hi Bartosz,

On Thu, 11 Sept 2025 at 12:02, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> The (typeof(foo)) construct is unusual in the kernel, use a more typical
> syntax by explicitly spelling out the type.

Thanks for your patch, which is now commit da3a88e9656c17a3 ("pinctrl:
use more common syntax for compound literals") in pinctrl/for-next

> Link: https://lore.kernel.org/all/20250909-gpio-mmio-gpio-conv-part4-v1-13-9f723dc3524a@linaro.org/

Looks like you (slightly) missed your target. The correct link is:

    Link: https://lore.kernel.org/aMAP9hAWars0T83r@smile.fi.intel.com

> Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

