Return-Path: <linux-kernel+bounces-871327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BE2D7C0CEFB
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 11:22:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6919F4EA6C8
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 10:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 049ED2E972C;
	Mon, 27 Oct 2025 10:22:17 +0000 (UTC)
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8C019E7E2
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 10:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761560536; cv=none; b=HUnof83VEUZhP5mruxdN7f+1Xkxn7J8uLR52bh+CnP9TRGAAS/f3zGLX8y/dOWV9VplGsF+pn0QLScooW9bFA5UzGvJCcMVi2oVQY/PddklPGiLg4JSa4TRg35pdlPtSNjdUR+6ub5nEb6czd4beRDMyhovFgqSV7AO+VjC/oYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761560536; c=relaxed/simple;
	bh=hA4Y5y9eyPbbNJjw3lWOGza4GJyLBBv2tFQmIILKANU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BR+VuoUbHwcjWALHeFOF1cDmWpNO8nJUPsK38uE1nk/6uoLzr4el8HpIqj8Tk5T8wIZwN092fGOTLkDDEOYgWOJow4zI4k0ich5RzwJothsl2J4x9pCzAdkpZJNjggkeV3LHyXi+8TUYwcx8a3jawd37vQwtC9PhrUZjWmtSr9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-932dfe14b2eso3778183241.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 03:22:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761560533; x=1762165333;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VpRhztl5yGUADah2U0CZ74pjALefcmDaH74Bx7Y9Njk=;
        b=UIrsuDKGG8EBI+QxYOs4iBtI37WG0K4IybKZZk5t5lyzxVB4aPv2PUH6mqP2K/6UfN
         FTI4YmG+Sw2NyB98VJdi9iK7+l9bgTH3h6GNzXM9C4BhVx1FiA1SiyknngNbAdvqB51h
         plft0A7MHMD8KtTK8neAO0JufFavq+Zwo8VxzQtZmqYSapCc+MhTShCwCPhTEIvZ3ZcK
         2gtfy7nxPW4aHZVFwmG7WTL3Qly4vtKgC/kN7hr7S0GyAn5SRd/pAxtsWvRjW8DHOYCQ
         C/qr/DoBgPIPxLP4kYCH8a5Dpi+1f8piBYP7gC6uPhq/76Zfc2Ymy+X4lJqzC3WCRTlf
         akBQ==
X-Forwarded-Encrypted: i=1; AJvYcCV93Fy3gDK+Abs5je9p+JovZ9B8+M4iNwMmBxNpbd7UalC9ooVu70e3R7IuvGq0c0fA39qbGyiWz+dLX90=@vger.kernel.org
X-Gm-Message-State: AOJu0YyV208iFCaBPsvOfFwKZTXMZNgNW3DYxUqCajvc8MhlQ3z1whuJ
	RMf2CVjrzfnQ9u6y+HNZkD41bJZ+VTdZS5c9JDzdsLwZSSts8j7IzYq4jLq1NCXf
X-Gm-Gg: ASbGnctHvm7nL1qsGbU01+BSGXhb6neicXkq6WkzxV1wCUsiVl3EXZ8mYajFw8MUSj/
	2sIR852Y9yJQGyoND4PwVXv2++EIwuuwct8KTbQYXfGKmXeqnUa7WS293QjU0LobwLKj3IOh3Hy
	ImJpoX/F7F6vHVYI0bDVoly1656HjDJYlhPPCRMWDYjaStOPMgjrMs9oOGkOgyzlOuVlzMNXrpn
	WSN8W5Gcd4RtOMEzWyix4XI0yYb1TxLs7MfRjAhRP41EzYchM6EVtiISgJ+fKCWmW+ZB6NHzfSv
	KeQhb3jmwqP1xdPlkezNqRPiwaQ564BX5E/WnsX+JdARrMoU1N0lrkbfyhkrTj3Hy+RLAQNe6Rl
	yfqRnTauTpyw4tItEcrexaK1ZTMuccuY0Mq4MZYhMi8pp8eGtLofaYpbjhiihizU4fVLuHYnjHn
	xatS8i9lwU3ez+4Yye8EAmnbZg31EdCB2phKoPBvw82eC0HmmD
X-Google-Smtp-Source: AGHT+IEmDGjIT99dBf5Y5efmHb9M+rtVWgFUuAcBIeEvC/ECCVK5PuFBbIUP8J/HVUN2lOR/eqXiWA==
X-Received: by 2002:a05:6102:5a8d:b0:5db:37d4:1cb7 with SMTP id ada2fe7eead31-5db37d41ebcmr5230016137.32.1761560532836;
        Mon, 27 Oct 2025 03:22:12 -0700 (PDT)
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com. [209.85.222.52])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-934c3f40036sm2721342241.7.2025.10.27.03.22.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Oct 2025 03:22:12 -0700 (PDT)
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-934a3f11a44so4075114241.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 03:22:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUPkhbUomr3QbhYWCLNcHdsfN1CQEZEhQlLnbjJiyWU+LEbilm4oLx4ZSYgAp/jXfmEZyNmZFS+nuTUzQ4=@vger.kernel.org
X-Received: by 2002:a05:6102:4243:b0:5db:350f:2c69 with SMTP id
 ada2fe7eead31-5db350f2e78mr4456633137.10.1761560532379; Mon, 27 Oct 2025
 03:22:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202510240817.vt3eQ3qL-lkp@intel.com> <265B8FE9306198E5+0131c750-3995-4158-84e7-ad73792e6934@uniontech.com>
In-Reply-To: <265B8FE9306198E5+0131c750-3995-4158-84e7-ad73792e6934@uniontech.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 27 Oct 2025 11:22:01 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUeE3xQKkyLWDxoaA_E=cukZSz6UvvjJF0vsbRtt0fVgw@mail.gmail.com>
X-Gm-Features: AWmQ_bkGtOS6n5Tt95yA4b1F79G6tzC66mnufa9EUYGGpFJKzTdqD0y2RmwXxEM
Message-ID: <CAMuHMdUeE3xQKkyLWDxoaA_E=cukZSz6UvvjJF0vsbRtt0fVgw@mail.gmail.com>
Subject: Re: drivers/hwmon/gpd-fan.c:231:9: error: implicit declaration of
 function 'outb'
To: Cryolitia PukNgae <cryolitia@uniontech.com>
Cc: kernel test robot <lkp@intel.com>, oe-kbuild-all@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"

Hi Cryolitia,

On Sat, 25 Oct 2025 at 15:49, Cryolitia PukNgae <cryolitia@uniontech.com> wrote:
> > FYI, the error/warning still remains.
> >
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   266ee584e55eed108583ab4f45b5de734522502d
> > commit: 0ab88e2394392f475b8857ac82c0c987841217f8 hwmon: add GPD devices sensor driver
> > date:   6 weeks ago
> > config: i386-buildonly-randconfig-002-20251024 (https://download.01.org/0day-ci/archive/20251024/202510240817.vt3eQ3qL-lkp@intel.com/config)
> > compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
> > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251024/202510240817.vt3eQ3qL-lkp@intel.com/reproduce)
> >
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202510240817.vt3eQ3qL-lkp@intel.com/
> >
> > All errors (new ones prefixed by >>):
> >
> >    drivers/hwmon/gpd-fan.c: In function 'gpd_ecram_read':
> >>> drivers/hwmon/gpd-fan.c:231:9: error: implicit declaration of function 'outb' [-Wimplicit-function-declaration]
> >      231 |         outb(0x2E, addr_port);
> >          |         ^~~~
> >>> drivers/hwmon/gpd-fan.c:244:16: error: implicit declaration of function 'inb' [-Wimplicit-function-declaration]
> >      244 |         *val = inb(data_port);
> >          |                ^~~
> >
>
> I don't understand...... I have already added CONFIG_HAS_IOPORT to depends. If this is not enough, what else should I do?

Missing #include <linux/io.h>?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

