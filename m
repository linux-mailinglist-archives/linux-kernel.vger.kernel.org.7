Return-Path: <linux-kernel+bounces-784935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70395B343A5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 16:27:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F94418847AE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 14:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAE1B2EC57B;
	Mon, 25 Aug 2025 14:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="2nNnH5j5"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114CF214A9E
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 14:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756131848; cv=none; b=p2kQK/GSSW2B6PnhIT81mgBpI19TaXhFin8LAo2xqKtZvkLnywwGtdt5+aDwI5iC83fhW0HOere+1gZRqqIpathKraGrSed7jNmFlvyX2H+1LiPqq4de42iydVJ12ximKPeBnRbiaHU+HyIDz9fGPc6x6LwnC5MzesNskvIhbCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756131848; c=relaxed/simple;
	bh=s06fqTq+YfYXicRNQXR0vJ8lPx1YzUOlSirSDylfWLY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CA+vA9L91L5jRe9dXvWbP/YVlnrtaCS3Kth+rGJ9im1j36jvRNX4Ljt3LfA/W/1PdzvAtYFc1ytAfeRSkpfwRICIvOCJITz9rCG0JK1Oqj3aN46JwkVgPyu+kryI73hHbzwLScZb7raa9RbF1V+JSymUpwHSVm8jwabHGRtlNHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=2nNnH5j5; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-45a1b00797dso35578315e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 07:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1756131843; x=1756736643; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TX1MLqEO3vQC6DvB+MyawqjwGBkSm4vl1UzIKpr4u+4=;
        b=2nNnH5j5sBivnVj+KZaCUzt4aHUMt0+o/hTixKmFjvmgVafLYL7+pRu7FolBENAzC0
         LT5t5maoB9EvCqmzDb+ACDn9p5Cx1Y1BBRb7UwKOiPdQU3eLElawyIqzXE7CS2KLPoyU
         A8msDcD8+WWRMWVewj9+0R0aD2rtjFU2QuAWnnBZx0AOTSCrGPDcIccjBkgHkJ2j4be7
         qoNEHL3G5rzs6veoYrFpDM3zbbzX5HBJNO0mCbJIC8btvy4PCK8pRX+houeF6ru5Sf0+
         KhrC5TzSqBkOGFzb5TUFxBnZuw2HVCkgxTli3UqAFXFdqQDwU7pZf0ukNii/+my+120R
         vLlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756131843; x=1756736643;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TX1MLqEO3vQC6DvB+MyawqjwGBkSm4vl1UzIKpr4u+4=;
        b=F1s1hNllLUyGBDQlrIXCFRrwKa5PF5ZcaxNKTdbjjH8AtpnFPsn66DIG83JIejeakl
         U+Q1SqHFYxUacGTGv4TrMVJe7BQCz6wduHyW6cXhDqFua8hZD/VGWCVyTjhdk6H8m7V1
         quxRdARBUUc15i6rj/d5NiBJ9D5mdy9J5a6YXaunflp0bwhTF5ldSxV3tAWimRnoCX8T
         ZwhAhplC6ZdhjLjo3Dlx3vkZ+mkk0oJNBygZg+mZTDASfVbRTx3inyUOogZBjqtxw42g
         hZq0KD8nBJ8+hrLb4dE4aWAjQIxdcFx3VFq51ow0pQUdDTBpuF7vlIsU48+SHVY7D6hB
         JTuw==
X-Forwarded-Encrypted: i=1; AJvYcCXAv8Y/rijkR0/BiIiEWrKiUVRg3fiDKM5p3iwMd1NzF86k+J8gurpgG/mIPuslYd8NB0BAvoVNTbLzL+I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy23+g02H+qAnGIlBFAuUKFR8Gzq4OF0Ep/WwlGJzBcIBu2LVPS
	KiqqbrZzukcrTfephO1wGtSMH4es2q3NIf1U3Yl1DtkUXjADD5hVjBPK9YRGMzQFl+g=
X-Gm-Gg: ASbGncurILQcdN4wqiVR6WeD8eYh/UkLUGdK9jZNnCRq/U/eqzePSfqgsQRhRZsKvz+
	d6uu+zN1xPDzqJvO1O/Euj+JTit2e8Z+ePDo6LrE1CrPKpVhZs4SshuNyIVdQJpOgR1C0D2UO8s
	u+6m79j8FjpqaLtD2O2FLpoKQ/2MQxIZS1kz3XksLcBOyQEtC+MyDH/41PXxCZm57okSgJL2n1u
	d+8xc0QhqUaZUy8W6++vAk2ehjjwT+21fcV4KXb9CkNqtgdUfhfzga+ywpP9D3KhTQPSbKOGkF1
	oWjf5PMBMeYcobAz9RLLu7PVzUaOFD2JMNOmK6jaqpJ/6Nuu6++foC0iqXojK4WWfafo48kOSmX
	7c4/OQQ5tZEw/gCAfHAJ0WQ==
X-Google-Smtp-Source: AGHT+IG665adddV7h7nRXLf9qXuGymCKsQp6Ggi3wDBYyM1BI7uUJAuXYAK8KhQ26MMLhlt0ERVkaA==
X-Received: by 2002:a05:600c:c87:b0:456:f1e:205c with SMTP id 5b1f17b1804b1-45b5179f338mr103267265e9.4.1756131843347;
        Mon, 25 Aug 2025 07:24:03 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:b261:baab:ed3d:3cb6])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3c7116e1478sm11805438f8f.46.2025.08.25.07.24.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 07:24:02 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Michael Turquette <mturquette@baylibre.com>,  Stephen Boyd
 <sboyd@kernel.org>,  Kevin Hilman <khilman@baylibre.com>,  Martin
 Blumenstingl <martin.blumenstingl@googlemail.com>,
  linux-amlogic@lists.infradead.org,  linux-clk@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/26] clk: amlogic: clock controllers clean-up and
 factorisation
In-Reply-To: <20250702-meson-clk-cleanup-24-v1-0-e163c9a1fc21@baylibre.com>
	(Jerome Brunet's message of "Wed, 02 Jul 2025 17:25:58 +0200")
References: <20250702-meson-clk-cleanup-24-v1-0-e163c9a1fc21@baylibre.com>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Mon, 25 Aug 2025 16:24:02 +0200
Message-ID: <1j4itv5vjx.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed 02 Jul 2025 at 17:25, Jerome Brunet <jbrunet@baylibre.com> wrote:

> The work on this patchset started with the submission of the Amlogic t7
> peripheral clock controller [1]. This controller is fairly similar to
> existing controllers. Once again, it redefines the peripheral clock macro,
> the probe function and composite clock helpers, even if it is almost the
> same as in other controllers. This code duplication trend has been going on
> for too long and now is the time to properly address the problem.
>
> There is clearly 4 parts in this patchset. These are sent together for v1
> to show why what the ugly first part is useful. If more versions are
> needed, the patchset will be split in 4.
>
> While all controllers are doing more or less the same things, tiny and
> often pointless differences have emerged between the controllers. This
> makes it harder to exploit SoC commonalities.
>
> The first part of this series deals with that problem and realign things
> up. There is nothing complicated going on there beside renaming. It is the
> ugly stuff, yet necessary, we have to go through to get to the interesting
> stuff afterwards. There is one change per controller for the review, with
> the intent to squash this into a single change on application.
>
> Second is the factorisation of the probe functions so those stop being
> copy/pasted in each clock controller drivers.
>
> Then the clean-up and factorisation for the PCLK macros, again to stop
> copy/paste but also the silent use CLK_IGNORE_UNUSED.
>
> Finally the introduction of macros for composite clock definitions. The
> same pattern as the for the PCLKs started to appear on s4, c3 and t7. Done
> properly, this could also help reduce the verbosity of the older
> controllers.
>
> With this, the c3-peripherals controller may be used as an example of what
> future similar controllers should look like.
>
> After this, there is still some house keeping to be done in the amlogic
> clock drivers:
> - Moving remaining reset drivers to the reset subsystem
> - Proper decoupling of clk-regmap from the clock controllers
> - Reduce verbosity of older controllers with the composite macros, where it
>   makes sense.
>
> [1]: https://lore.kernel.org/linux-clk/20250108094025.2664201-6-jian.hu@amlogic.com/
>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
> Jerome Brunet (26):
>       clk: amlogic: a1-peripherals: naming consistency alignment
>       clk: amlogic: a1-pll: naming consistency alignment
>       clk: amlogic: axg-ao: naming consistency alignment
>       clk: amlogic: axg: naming consistency alignment
>       clk: amlogic: c3-peripherals: naming consistency alignment
>       clk: amlogic: c3-pll: naming consistency alignment
>       clk: amlogic: g12a-ao: naming consistency alignment
>       clk: amlogic: g12a: naming consistency alignment
>       clk: amlogic: gxbb-ao: naming consistency alignment
>       clk: amlogic: gxbb: naming consistency alignment
>       clk: amlogic: meson8b: naming consistency alignment
>       clk: amlogic: s4-peripherals: naming consistency alignment
>       clk: amlogic: s4-pll: naming consistency alignment
>       clk: amlogic: meson8-ddr: naming consistency alignment

Applied and squashed the 14 changes above.

>       clk: amlogic: drop meson-clkcee
>       clk: amlogic: add probe helper for mmio based controllers
>       clk: amlogic: use probe helper in mmio based controllers
>       clk: amlogic: aoclk: use clkc-utils syscon probe
>       clk: amlogic: move PCLK definition to clkc-utils
>       clk: amlogic: drop CLK_SET_RATE_PARENT from peripheral clocks
>       clk: amlogic: pclk explicitly use CLK_IGNORE_UNUSED
>       clk: amlogic: introduce a common pclk definition
>       clk: amlogic: use the common pclk definition
>       clk: amlogic: add composite clock helpers
>       clk: amlogic: align s4 and c3 pwm clock descriptions
>       clk: amlogic: c3-peripherals: use helper for basic composite clocks
>
>  drivers/clk/meson/Kconfig            |   13 +-
>  drivers/clk/meson/Makefile           |    1 -
>  drivers/clk/meson/a1-peripherals.c   |  995 +++++-----
>  drivers/clk/meson/a1-pll.c           |  124 +-
>  drivers/clk/meson/axg-aoclk.c        |  153 +-
>  drivers/clk/meson/axg.c              |  237 +--
>  drivers/clk/meson/c3-peripherals.c   | 2055 ++++++---------------
>  drivers/clk/meson/c3-pll.c           |  245 ++-
>  drivers/clk/meson/clk-regmap.h       |   20 -
>  drivers/clk/meson/g12a-aoclk.c       |  238 +--
>  drivers/clk/meson/g12a.c             | 3316 +++++++++++++++++-----------------
>  drivers/clk/meson/gxbb-aoclk.c       |  123 +-
>  drivers/clk/meson/gxbb.c             |  611 ++++---
>  drivers/clk/meson/meson-aoclk.c      |   32 +-
>  drivers/clk/meson/meson-aoclk.h      |    2 +-
>  drivers/clk/meson/meson-clkc-utils.c |   89 +-
>  drivers/clk/meson/meson-clkc-utils.h |   89 +
>  drivers/clk/meson/meson-eeclk.c      |   60 -
>  drivers/clk/meson/meson-eeclk.h      |   24 -
>  drivers/clk/meson/meson8-ddr.c       |   62 +-
>  drivers/clk/meson/meson8b.c          |  746 ++++----
>  drivers/clk/meson/s4-peripherals.c   | 1160 ++++--------
>  drivers/clk/meson/s4-pll.c           |   82 +-
>  23 files changed, 4437 insertions(+), 6040 deletions(-)
> ---
> base-commit: 2c37e1c671428002519e7615d786b9b692261052
> change-id: 20241211-meson-clk-cleanup-24-41cbe1924619
>
> Best regards,

-- 
Jerome

