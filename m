Return-Path: <linux-kernel+bounces-856340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A1BBE3E94
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 16:30:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1BDDA4F45A2
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 14:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96350340D8D;
	Thu, 16 Oct 2025 14:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="A7SnySTK"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D0F33A005
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 14:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760625028; cv=none; b=cnqvtGNG4gX9tO7T3ht59KQ6Lna+LoM/Xatd6NdhQyQ6qBlbxdlWqfwuPJUjHFIVnSQ7CkzrJEVyFAJIEk0syhO/u4Naktl5mDKrRdgORVeQmrbzuu37kEkQ5sit9uVTqzG9HGV+1SX4qs2V3e4oyfsqmQLJ2DBv+TiKNkLTDr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760625028; c=relaxed/simple;
	bh=T0IcD58X1Kbm9j/Mmnqjb35nYoD5ZL5E/cjiyrGur2c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DoMCPH84SEuPCtLUBR6517pZagDbdI89KddeqPhEUN7vhbKpuzHBIVDOxFBRk7fxdPvyV8MfZ1pp9bBhDUGEHbrvk18VN7Pv+wUiYPo2jZ0/HHoeukabWm+fnzyS0ohsLqObep2QaoS69kGvvCbyIysIVcE0XoEZj1WIrqhw/A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=A7SnySTK; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-470ffbf2150so10975725e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 07:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1760625024; x=1761229824; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=64Z2itRYroa1p/U2gj/hs15ONohF5cg9NpwZeAottIE=;
        b=A7SnySTKeiPFyqPEhqm/eoQhv1G8kH667sm44GSGkAxPPA+AlI4k6XPKNgDiLiu7Bv
         E9xdkVUo+DojngyxeVyFXA+Cx5x2K3XPysh5vQlE18ezXzWXYv0skh6BdCoLdnPXGxIg
         qsMfD12KjY44fEpbbcgEeokVY3ONS5hbyJYo+TqYtGBf2NGwgIA9ll66YotDzWJQS0bE
         +yCrlXSkInjwTTUTHJLUhZ5B0B6/NqtxhZ5VCIAJ4lY0OwRyupoPDfgXTpV/zrwFkROs
         XvdF58j6e3pgFGdJKMr0C+ASSYIvfQuMVgGpa4BKqWhgJdkKfGC1+kXGh8yz4TWcSM19
         ufcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760625024; x=1761229824;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=64Z2itRYroa1p/U2gj/hs15ONohF5cg9NpwZeAottIE=;
        b=s5VhFn11dlP36+4FFzbt6glMlcUMkuYKNnJ8xctM5pDo+E+YSr4N/BE/ZZ77zZw0l+
         tcZwnn9jQH/jm3L3nvz9cAtV13mk9X9Oylz25uUQkog1LqyxH2TR0iYSWGVUG2x2gc9S
         xooRgugWPnuXX+lUEYvj0icvvtD+z7zMHdKE3lPHGM0WqVhmWquQhKnctc0RLW92a67G
         Y8H25KpwvUAJ9XQXo2TbWRV0WmzJ0UvGl0y0/d5O4x21ezeuSQj/DOiC625dHw4ntEwR
         K/0OjkYRullSmHz5dFaVZC+rJr4l8cuHLAKhtiARgNyKp/2AU1sJhTL3w9uI1q/ioS/b
         Fgqg==
X-Forwarded-Encrypted: i=1; AJvYcCVkcB2sIRUDQR2iNQpEOoRh2fAnUCzlqY1T/lpNEZPbChTp9Rt4dRbwbW8gdZcCdFD1ll4t9JL4MNSeU3I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVZU2RoIWvu7tMGQ+MyaOztrQBrniURvNJKbpmXhM95gC06/4v
	cU3whiRWOCpA5znrxKGXxyy8Q2V0onc+hGd8Cql21BlnUssWvfTFkQt4YggHicLks3s=
X-Gm-Gg: ASbGnctyaJbfjM25j2YJdXaAbGvIsXFor/5hd9h1CgKP8SI2I8X3rIU7vG+XN54FPYM
	GIXJv6BF+QiG9hCXmH18C0azu2TUv8eRisSpQkdvPoMNoSIoTlmi1/tYJUTATdCeBhWHD3fT23V
	XhlXfw+8gz7AsgWqWBljX3q4/ivwJu+rwfWjkqvMmcL7OHbfQxNd5FVQIUqruvOapUClkuKf9pC
	NsbLji3Cprrvx2SWAXNZVqF88HoqPt954PIprGe6HjHutB4jmbHx4r86EzHgW3bNg9o+DzpMW8k
	ZgOKSI0npEYGJW6VxUeD6uDo4XtjCRbv996/6FegKTNcXv14hm5vFAds83OFXKFeB4EjhXRk5kI
	tGPEZUHYsHx5IDCK1bCzbRcon/9mtxRN0t3PrBXC9WfTqEHOwo1U0VEOzzzG6jIpk4G4UnDlpRZ
	gQV7YjVlBCAEU=
X-Google-Smtp-Source: AGHT+IGq3NRRypW29ee0XCD9JMY2kHnXLbqeGs8o31qrq9QzhF2mvpDXcOW40RfB5yhA9DpJg0uqCA==
X-Received: by 2002:a05:600c:4793:b0:471:ea1:a460 with SMTP id 5b1f17b1804b1-4710ea1a4e3mr12346405e9.11.1760625024040;
        Thu, 16 Oct 2025 07:30:24 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:ef97:57cb:86cb:f7c4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-471144d1765sm41639815e9.17.2025.10.16.07.30.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 07:30:23 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Francesco Lavra <flavra@baylibre.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH] gpio: pca953x: enable latch only on edge-triggered inputs
Date: Thu, 16 Oct 2025 16:30:21 +0200
Message-ID: <176062495388.120857.13832123622797460794.b4-ty@linaro.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251008104309.794273-1-flavra@baylibre.com>
References: <20251008104309.794273-1-flavra@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Wed, 08 Oct 2025 12:43:09 +0200, Francesco Lavra wrote:
> The latched input feature of the pca953x GPIO controller is useful
> when an input is configured to trigger interrupts on rising or
> falling edges, because it allows retrieving which edge type caused
> a given interrupt even if the pin state changes again before the
> interrupt handler has a chance to run. But for level-triggered
> interrupts, reading the latched input state can cause an active
> interrupt condition to be missed, e.g. if an active-low signal (for
> which an IRQ_TYPE_LEVEL_LOW interrupt has been configured) triggers
> an interrupt when switching to the inactive state, but then becomes
> active again before the interrupt handler has a chance to run: in
> this case, if the interrupt handler reads the latched input state,
> it will wrongly assume that the interrupt is not pending.
> Fix the above issue by enabling the latch only on edge-triggered
> inputs, instead of all interrupt-enabled inputs.
> 
> [...]

Due to the potential impact, I will not send it for fixes just yet but
I'm willing to give it a spin in linux-next and see if anyone complains.

I've queued it for v6.19.

[1/1] gpio: pca953x: enable latch only on edge-triggered inputs
      https://git.kernel.org/brgl/linux/c/9f0fa1801fe4503eb119a4523a59a494768fda5d

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

