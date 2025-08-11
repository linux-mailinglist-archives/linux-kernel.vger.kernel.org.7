Return-Path: <linux-kernel+bounces-762757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3C2DB20AA5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 15:48:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13BD6427D6C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 13:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFE851898F8;
	Mon, 11 Aug 2025 13:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="1wmiJ1RT"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904D7188713
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 13:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754920094; cv=none; b=moYN2gNrQNYzLV5xoSgKs7qReQGB83a6itIiA6YEG9ImSqDg/b6mszCEzd8n5mTaHfoGEXpCLmZlHPWmlG2ys517gU3LnyYnym8DKbkKqYyMzR/vmm/vZwPePeyqiArzwVowGCXbU/KmYrAmCpCXx3hF7vVcCiAC1yHSxgz1AxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754920094; c=relaxed/simple;
	bh=bVX0v89UAUdnlBPHEZSVVlNvOwpGXSx6cfiZ8LKvlF4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pz0cEb2onAQHAwt+fvBa1TVgDlDgNbNfhDeprsoQKDm8F77J2DYHulWHLZ6C6oSY12D9O5EDUrVWTRSqDKfBu1RXetDabKWz5idU1OVuYYnFD472fxMDequjGI7jMGwnIZxGcyNIX99u9i7bED+ylZ+jrvPNN6YsdSez79Ou0Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=1wmiJ1RT; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3b78310b296so2345170f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 06:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1754920090; x=1755524890; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AQbmbUuIO/FixqY/FscMGC9UsXtq4qbXi7Jq+h158Fk=;
        b=1wmiJ1RTPygsbLfiLHXj0okugYCiXJvQuzSQ69FEUWU62KQUvBSQZW+9OfnvHxPQXP
         lp6U7kp52F1tGp8ubS4thCJfvC2SGlfIwVjT914DBBhhCE9sqf789SYLzEQk74XqSJxO
         CR1senOhxEK3j4AIc11wWobL0aIZlYcwzTCUA6VZJBleBGfgna000lN4n2ezhcbv1XyP
         kiOzUauMBUSpKqJd2ZA1KKIOH2crRrXQDXbgPEJYol0SKZxVjGPeBupSu+f4jdBZ8Bs1
         SalRk7jwd95xdnWKYV6+HZjGF3GkPdGrTs+53lEkmTwnUUnpgYMIyxnVmFf7pe56VBHZ
         B90A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754920090; x=1755524890;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AQbmbUuIO/FixqY/FscMGC9UsXtq4qbXi7Jq+h158Fk=;
        b=vuXZSITwaytTWwi0I74+5RuAHlETEmCqsAVl/MHIzfrM2IGZaUdKllVaRfUyDO7+YS
         gDyVuL/hynn9nH+525XCmKczDXkgUyllEldWyFJSDRBx2kWIaw74oOPRy5hSUpvSwTxK
         ebG4WS2l3+H66rl4lJY4H4zf7ZOgnixDKGj6RFaInhiztldeyLTLqbXSSeEy+6oV7wFe
         G2E8lGHZ97ER4mvmNxsKY/aVVSrhbrM8h21TKiODAKrGnMdyCpT4KPhsm/27TIfvzyWV
         51SStumGjrJs5SrukbBrShtlVydezFM+fbxyk6vKCfq/Tmi88tH0UudphBKlcp/8hPjU
         fh1A==
X-Forwarded-Encrypted: i=1; AJvYcCUH3pU7tc/X/Lap+GR8GHm7XZXeKEP5zYCjn0FhzlHsv8qKHdwdL/fkagcfqzEgl+IhxhUoZOO6HbNnH9g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZtjoPWusBam0Bhwa+l04cM4RgRquzxTt3/jutCO/9cMFY6v28
	hGlhbLgesLxRBwlajA5JHg/aws+wPaQ9j5JXu4xDxVAS8Pjljpk4xcXBcxUWQyizdTw=
X-Gm-Gg: ASbGncuXJQuhzH5dKolTttACzwmmbHTtwpduP1zgm61fapNrzXTfl++2yPfzYz58mQ1
	no3NjW1TpCOq6PZCJXl4eDqeCv+HsHgNYLSZVjryDsT8F1sAG709Hxl3NrXrb9jUHg2qZBUC2LV
	kitDq83z+bicn/HalzgvV+yQTwwOUwF83F+QDGYXZZo5XnG/SjXEvf10A2ky/pUr5ABlXtnmAE8
	u4emV0EmCC/QVqJYTrJd3E07Oj85IS01JgJq6X8TaM5NRP/CPhOQpmp3SK1mMcBrC+bsqCMSLev
	sdDJrEFR6rN6poLOsJRk3aX59koGRwlFpJBxO7AAO7ZzsDukpDPHcF8L/7ljCkWWTfKiXHvpXfr
	r7Zn5Zzoq4M0Nb+FQKNtElPPz
X-Google-Smtp-Source: AGHT+IEGLWnHTsgY+DQSPIbj10ccfo7+PIuZIGDyIiH0rtT1Xh+G6PRvNotxenNW93+TG3JyihzV1w==
X-Received: by 2002:a05:6000:22c8:b0:3b7:99d4:c967 with SMTP id ffacd0b85a97d-3b900b50d93mr11418569f8f.40.1754920089833;
        Mon, 11 Aug 2025 06:48:09 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:6841:8926:4410:c880])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459d712c386sm339621115e9.23.2025.08.11.06.48.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 06:48:08 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Kees Cook <kees@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Thomas Richard <thomas.richard@bootlin.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com,
	DanieleCleri@aaeon.eu,
	GaryWang@aaeon.com.tw,
	linux-hardening@vger.kernel.org
Subject: Re: (subset) [PATCH v9 00/10] Add pinctrl support for the AAEON UP board FPGA
Date: Mon, 11 Aug 2025 15:48:05 +0200
Message-ID: <175492007083.69870.1998290411416656246.b4-ty@linaro.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250811-aaeon-up-board-pinctrl-support-v9-0-29f0cbbdfb30@bootlin.com>
References: <20250811-aaeon-up-board-pinctrl-support-v9-0-29f0cbbdfb30@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Mon, 11 Aug 2025 15:25:43 +0200, Thomas Richard wrote:
> This is the nineth version of this series. I rebased it on v6.17-rc1 (the
> only one conflict was in gpio-aggregator due to set() callback migration)
> and added AB from Linus.
> 
> Best Regards,
> 
> Thomas
> 
> [...]

Applied, thanks!

[01/10] gpiolib: add support to register sparse pin range
        https://git.kernel.org/brgl/linux/c/181fe022ecf8a8e85def0e94852c631c59a8b3f6
[02/10] gpio: aggregator: move GPIO forwarder allocation in a dedicated function
        https://git.kernel.org/brgl/linux/c/871c7cd54830c0bda15513238ea9d46fc1cae991
[03/10] gpio: aggregator: refactor the code to add GPIO desc in the forwarder
        https://git.kernel.org/brgl/linux/c/c44ce91b8ada680074aa976e61fcef5633e6f086
[04/10] gpio: aggregator: refactor the forwarder registration part
        https://git.kernel.org/brgl/linux/c/10d022efe2c4bb2020a07b2e4d94b658ce30aca4
[05/10] gpio: aggregator: update gpiochip_fwd_setup_delay_line() parameters
        https://git.kernel.org/brgl/linux/c/b94cf35db606453c64e5da13c56cc6f8cabc6a33
[06/10] gpio: aggregator: export symbols of the GPIO forwarder library
        https://git.kernel.org/brgl/linux/c/6e986f8852f56cf9214ea2ec02b4b432e201d02c
[07/10] gpio: aggregator: handle runtime registration of gpio_desc in gpiochip_fwd
        https://git.kernel.org/brgl/linux/c/b31c68fd851e74526ad963362ea205eb97b9a710
[08/10] gpio: aggregator: add possibility to attach data to the forwarder
        https://git.kernel.org/brgl/linux/c/60e92c1009c7c6abd4a9d0caf33a8cba5d09f67c
[09/10] lib/string_choices: Add str_input_output() helper
        https://git.kernel.org/brgl/linux/c/53ec9169db1345f04174febb90f88a871fc28d9e

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

