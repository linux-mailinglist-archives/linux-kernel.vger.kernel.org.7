Return-Path: <linux-kernel+bounces-826847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8B34B8F7BE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 10:25:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A10122A00A1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 08:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 964AA522F;
	Mon, 22 Sep 2025 08:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Tqte4F4C"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5533E2FDC4F
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 08:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758529504; cv=none; b=qYs9IWusP1FNMIG1D5VPvbxkpnGSNxuwoiUwWQHnfN5fqhT7UKnKLEM0eyDj9GVY2AMntHBQwGACDElMV474a2zEiPo/shIyvsOSm1VHc8x3LX0u/SJKvnA+iEBwq+Nth361z7aDYbSxQTkLYgSttG0BDCLiI86VC66SpBi4A3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758529504; c=relaxed/simple;
	bh=FI+DYlQeMCnVCtyvCkdDPT1bCDTDmrXBPgGdRm2ofEc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=mlPLv4bvbTEJuepcKfNC2c5jBnBFQ8D46ap2sLZQuSa2CYgFg+odUgXLSuWUyO28RGjZbnGMp3jIpdGZF2dcW6E9u8K1AlCZ9CpEyDhOY7VS+x4iAvUeGwqQhbX0cWpCC4Bx66Cd0OeLB2trhtrffB6hGjR9X9ZsBIY0z+3WbjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Tqte4F4C; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-36bf096b092so3801151fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 01:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758529500; x=1759134300; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=z8vx204SZWcSKU5Lh/a3VR6IC2ZtKNAfPJgRIQob+wo=;
        b=Tqte4F4CSznfxMR2B5FSW/woltlVfWYQ/rzegnV6Ar4zpnC3x+6H+zAny8rHDep2PF
         LHbPoSrXsuMF+4wURWG9lgSFF9AE3d7zUbyzKSFkjeHMz4Fp+4GZgjWYBHq6YtNyBCVR
         LqB+nftlszE60XAmXCUQ1wtXM+LuCcUATjmUDAzUiY0rnaFiel+vF26S4cF5gBcuoFvJ
         mWzEJkccbjgLF3k3FdkayGS4hIU02VfEgmCen3KZCL/KhqltcK3HIyRrZrRTln8Nsw9C
         Fo358G6NRQ2P61AKZuBextBLG6c39zioaudhX5FajadGk4f1JGXSzVW6KnzQlLrDlEMT
         33vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758529500; x=1759134300;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z8vx204SZWcSKU5Lh/a3VR6IC2ZtKNAfPJgRIQob+wo=;
        b=CNi+BaTT1DSNGzqkUrW+pDtZvEYZJGJeuxfQEdo8cQHISaGYZw2MAZuI1IJMoRZLUg
         zopGEWapX6iGTc9ci5PiOpGKTKVHwd/bmh6BWaQ8qak/Vtu+UWPuBwa3GWEJ5lKdlpXO
         BGoWpC5/fN0bJvZ/ivl7kCcZABMOTdWxIJBI6c4jhxai8SWOQYFVbVXEMb08chw8B9+a
         hPOGg3PWh2BiX9YfD1tinWr1eYFWVppmCYawXzPX07Bkkj7bI+dfNCugO9JnyM3BTxN8
         CyAy8YU1mjwMP1JxGFgd0mfnQAasN/KUmP/j8s3BlCzB/44z+SjtBnwrwu3lIAzsrRil
         uOeQ==
X-Forwarded-Encrypted: i=1; AJvYcCVl36J06MI2/aHGDPVJxvx4AnQFotKPwvYpY0LSifSCZjV5pdIHLzKdaDyUA6PoSyYJ5YjBTNjnaDVV1AM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3yjbx/4PUvyNqbWdML/UPlVaKkn996PHozTlUPFc8SFvxe47h
	lXbobs5LsjZaZS8lZU49aRibuPLiCRUUvbWrdG1UxqUWmwE3kTusQdzM+y3ipYz5gFrFS9KDG3l
	Pw2MS/2lct0vBmJ8o9xVG8175a/bjR2YV4UJXKQmc5g==
X-Gm-Gg: ASbGncsiiyaRAvuRGST/D0rEXXJEoGxZgWanAuPf4bC2yALtPhJfhMz5r1b3F9jlB76
	xv6mREkA1+DpGkj04dyjveObCaXI/+v5Bb8KgJ7QtdTE4IdBoxGLa3Nk30Me4pqrFRevGpo9xJY
	qK3V/Z+jFRwRj93LJB3yaMLZTSSVIzFh6yHyrSx1ICjlxW/abtsPusZFGgRcVfWHak0l2EpYV4o
	LrAKbKqVWLpktkJ4w==
X-Google-Smtp-Source: AGHT+IHOLIPWnUusHHlSms67BlSXcHKiGUu89SIAIoeowSC9Fe8u0MrYAaOSGnZlhAqeChyO1xMSuRaRysiP29McDfM=
X-Received: by 2002:a05:651c:1501:b0:336:bcfc:a422 with SMTP id
 38308e7fff4ca-3641afb75a9mr42439151fa.26.1758529500441; Mon, 22 Sep 2025
 01:25:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 22 Sep 2025 10:24:49 +0200
X-Gm-Features: AS18NWDYeUjgy-jqzWPWzQmyQ8AQMjpuT9A_9VkG_l_vN7XRtNSQvzsMFhRnhe4
Message-ID: <CACRpkdaY7qoN0r9zx4uKS8U3LS8-Zt2=omH8RhmcHV9F+jM1XQ@mail.gmail.com>
Subject: [GIT PULL] late pin control fixes for v6.17
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, 
	Ansuel Smith <ansuelsmth@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

here are two late pin control fixes.

Both for the Airhoa driver (routers, OpenWrt).

Please pull them in!

Yours,
Linus Walleij

The following changes since commit 76eeb9b8de9880ca38696b2fb56ac45ac0a25c6c:

  Linux 6.17-rc5 (2025-09-07 14:22:57 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git
tags/pinctrl-v6.17-3

for you to fetch changes up to a061e739d36220c002da8b2429d5f16f637eb59a:

  pinctrl: airoha: fix wrong MDIO function bitmaks (2025-09-08 23:01:19 +0200)

----------------------------------------------------------------
Pin control fixes for v6.17:

These are two small driver fixes for the Airhoa driver.

- Correct a PHY LED mux value so the PHY LED will
  blink as it should.

- Fix the MDIO function bitmasks, working around a
  HW bug to force-enable the MDIO pins.

----------------------------------------------------------------
Christian Marangi (2):
      pinctrl: airoha: fix wrong PHY LED mux value for LED1 GPIO46
      pinctrl: airoha: fix wrong MDIO function bitmaks

 drivers/pinctrl/mediatek/pinctrl-airoha.c | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

