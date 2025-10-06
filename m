Return-Path: <linux-kernel+bounces-842653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22C35BBD3C3
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 09:43:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8158D3B7899
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 07:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69832257AC2;
	Mon,  6 Oct 2025 07:43:08 +0000 (UTC)
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794D8243371
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 07:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759736588; cv=none; b=qdRrKAZ1A7/1yTv98q2wB0EXY1ZnYzrEZazUYfoMEZtugkLSQ4NlPSIcJpuz2v2Cu+TMthbvI3OtcjkpPmz8C5/obySSVGWqn+wnFgHdOkd00UZQOlsTDqqdxWm2BxlekiDSZftfLOJ70ISjZWDLLauLGCHKxSW2Hglt1FCJdYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759736588; c=relaxed/simple;
	bh=pVKMTpF6+U+ZoP/Y81+0qoZ+8X6E/LpIbihs4F6b4IA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fm/o0hnbQIxWKEgBpEOFTCXGzfJUOcyd0207FfMdgkKk6A7221/Jd5gZgsg6aW+FvQ1yK+SfAxjT21SnbxSwq8/QR8YdOsSivw1Py0r1ahjnD1zC/ksF12p48IyPbbK1D6ZMptWsKshMdkZM/T3xTXmfznLiApxsupx6veEQXvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-5523142df73so3372513e0c.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 00:43:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759736585; x=1760341385;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dJD5WTfC4zHtLBL0+xlBq7/WOc1dhepTNHh9UIDDvZM=;
        b=Dhxu3waAZ7VRDzjNmtWyztnvEJzffSlmwNbqvth/7otLDBcYxluK7M0xEDKEu5J6sa
         +6E8zbNZZRr7bcvcuQMx5j3zuA6Wh4bmu4yMh5RI72BnsopiqWXC7Jf/hTbZdnj5Lh6D
         sQUANSA1MmUyxI0UZvEHoOnWB7V/AHX+FaSaUDl1QR6+fofkcmoX6uSJGREL0UTbqv8w
         IsbMfmn1ei5YfZvzgxkpA0WH//Mqgsd5QHnPNAjMwsObhqeT6cW9B3yuKdwCLMfVKKne
         A2LXLjFFvpUXdwXJnB5Sr7e8NsCUX044FZ88Iu7OhwWBg55d2ixS2seybLVuCAVPSyq4
         n3SQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYG+byvH/rKCSpYVHmo0AaM+8FgJ+p4JKa+6HON62Kd5TLzEQ49jgvc58GG1IJ7AZZ5MUAqIfvVen7RB8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/1DeKT3WNIyLmsXDEaC8wbTrStJLPT8oJ0KqvCl4D+PfRzapZ
	XbsHaoqKMWO/WtwOosd76Gya4nKAjaRHswDwF6llQfYuf4eSybzQeIJL6lHMwU4+
X-Gm-Gg: ASbGnctFX0FyObOb+W1NwZrXIWv2WAiSR+3BvBz1zQqsXYUKQYQoLL1VW9ElVyAm8kV
	C8UwZBdaKgrMk2CgRRioOs4f09PY1zUabaFgxFqaDRWcMwNVYERFc3NZaKD0mV6XIA6zm3yfWZ5
	5Tp9JA59zu660/YyqLAZRtEG6Mzg/8aV8M+Y6kYYZIlHz+umFsO8WK7LrMCpmBzUZMqZXDnM9sx
	ydfUN+vPJzoGrVoXxp0nvG+zqdM+tpAFvp3XL/yTZoRgrfSdnjFIgpH5jfSrRpthHdysCzCYrew
	vi3tHTULr8yFTOgnatUWqJmGKJvP8JawUfjx5HH3nVLG5Dg7nAtrOhnW00wiKl4fdXJaMhfvaTy
	A6JEyq82phmntIHdYFnd1vIeU9Rk3+QdctbiGztLjvlcJrRDL39ePzseXrbRJetkFvjF0j8nhVe
	kITD/Yx87Pdjrb5gFxBnU=
X-Google-Smtp-Source: AGHT+IFJNB1YnXIA6DaT/oftIg0udvRoRTtgLaHUtqkmHwXn2Wsor9BX1Tu5O8UsLfvzmD7MdJepzg==
X-Received: by 2002:a05:6122:1e0d:b0:543:e262:ade2 with SMTP id 71dfb90a1353d-5524ea6b0e4mr3861771e0c.12.1759736584995;
        Mon, 06 Oct 2025 00:43:04 -0700 (PDT)
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com. [209.85.222.45])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-55497ee3001sm571480e0c.6.2025.10.06.00.43.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Oct 2025 00:43:04 -0700 (PDT)
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-890190d9f89so3330928241.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 00:43:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV7gHv0dnLBU93jwrqM5kBwLE22VnCkieD/Ck5MAYejLwwo7nsSbRpMg5YtgdcgYbfDfAKTe0vdZgu1X9s=@vger.kernel.org
X-Received: by 2002:a05:6102:418d:b0:53a:fb09:5eb1 with SMTP id
 ada2fe7eead31-5d41cfddfe2mr4109690137.13.1759736583985; Mon, 06 Oct 2025
 00:43:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250929-gpio-aggregator-fix-set-config-callback-v1-1-39046e1da609@bootlin.com>
 <CAMuHMdX5HXx2HSAHP-H1EEKO-csBku_cMm-OaacE7GZLXwBxOg@mail.gmail.com>
 <4db46e2b-47c4-4c81-a36f-8b195b090d2f@bootlin.com> <7a35f0b5-5cb3-4ab1-81b5-394d2b794f77@bootlin.com>
In-Reply-To: <7a35f0b5-5cb3-4ab1-81b5-394d2b794f77@bootlin.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 6 Oct 2025 09:42:52 +0200
X-Gmail-Original-Message-ID: <CAMuHMdU_3Wfzq_qc9odGYtSAsMMOgww90qyH+GN4eQ7cxJMG+g@mail.gmail.com>
X-Gm-Features: AS18NWCUwanWut82t7whepCrvS8LVETXS3TYLFcSdnH-4b6DqTdpBWXabuN-KkM
Message-ID: <CAMuHMdU_3Wfzq_qc9odGYtSAsMMOgww90qyH+GN4eQ7cxJMG+g@mail.gmail.com>
Subject: Re: [PATCH] gpio: aggregator: restore the set_config operation
To: Thomas Richard <thomas.richard@bootlin.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel test robot <oliver.sang@intel.com>
Content-Type: text/plain; charset="UTF-8"

Hi Thomas,

On Fri, 3 Oct 2025 at 16:30, Thomas Richard <thomas.richard@bootlin.com> wrote:
> On 10/3/25 3:59 PM, Thomas Richard wrote:
> >> Is there any specific reason why you are doing this unconditionally,
> >> instead of only when any of its parents support .set_config(), like
> >> was done before?
> >>
> > My idea was: it will be handled by the core, so the if statement is not
> > needed. But if we conditionally add the operation we can save some time
> > in case there is no chip supporting set_config().
>
> I just remembered the true reason why I'm doing this unconditionally.
>
> The user of the forwarder can override GPIO operations like I do in the
> pinctrl-upboard driver [1].
> And now we can add/remove GPIO desc at runtime, if set_config() is set
> conditionally in gpiochip_fwd_desc_add() it will override the custom
> set_config() operation.
> So the only solution is to set the set_config() operation
> unconditionally in devm_gpiochip_fwd_alloc().

OK, that makes sense, so
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

I do find this overriding a bit fragile.
And in theory, such a driver could override chip->can_sleep to false,
which might be overwritten again by gpiochip_fwd_desc_add()...

> [1]
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pinctrl/pinctrl-upboard.c#n1044

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

