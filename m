Return-Path: <linux-kernel+bounces-733127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6257B07088
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 10:28:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22483565E7C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 08:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AED172EAB63;
	Wed, 16 Jul 2025 08:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="2gR2/TTE"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459912EA470
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 08:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752654524; cv=none; b=lCM6YVLRS8Ymzq2Xi8cOCzyDkUDyp8kNxJy0acejeN7Th5cQuJ8GXwF9qrnJ1vA/E+GrP2q8j35iIOs5oegilZ51y4JmtCWJVNtX34Tx91IhsNuGoOk/ZLDEu4iTeD0aThyFDLdBzBoUjGi3Ksmo6Qly6NCRHqXsOl5SYzRHVGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752654524; c=relaxed/simple;
	bh=/eS43zPTVU7kHR+7qzHI7EdyqUla/GWuAieX+WfoSBs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZcFQCmjQK+4eSEE7oiSc4Wmg3lGvGAxay9DBQyzzb64PT/ecWSfL9fNRlNQVyl5VDkT8/sNk45SpDsFHwDrbZ5SlwGiE/9hx7gznIu0zrc9LPl+dc+YCHWyh7dqZZYJsPvF5tffz11Ywxdo1EU3nLLwph4IMqlCkV2K2sWPiCS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=2gR2/TTE; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3a54690d369so5097681f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 01:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1752654520; x=1753259320; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kfjRAzPW9E6ZzAIhpjTHhDTWkNr0yduVMvkM9EQ/mhQ=;
        b=2gR2/TTEZTU0c94kkTbro2Pf/pCbn33zrL2OwDpMZ2dKA+a4NqEJxZZPHnqg1NYFLA
         henup0rE/RAnL/aoP78ybm7rUoR8wI5L3AINZSsWdV0N/ca6MyFYXwYKbZ0sjd6A6qYF
         hrEyAxVHQyTmk4ETly+IxxVjR/yL/gg/JUeUBI/jqkVeyYn78wkWWvr4iQD3+hgdXVzX
         Vyxcb8ssH8rhQAfz/40ZJVzFa2qLLFGL1uDnY876VfBpuFhKQM+28z3gPkVII1LNvEzM
         Nj5XrhoeM0abSRkjWwtC0AeWmsAt6i1oKJHgDU5VysNCgg/nGII4ug11rVGuASDc1Abf
         7cMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752654520; x=1753259320;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kfjRAzPW9E6ZzAIhpjTHhDTWkNr0yduVMvkM9EQ/mhQ=;
        b=Au1KjjPh5xrUfTmQ3HG9SGPp3qw5ClxHqdejg2+PykgE4x560sGKvKSx50jq43sMBv
         xnQRDaqcxJCu0wcprMIEdJ96gUkIUlEWAbn99AoadVIKpADGy2eLlbrxSsh1d57idp2w
         oCjTTlscoUtAa83MXPztZljkp4wEH+1HUTAdYxY82cPTrxQrJkSq8V3s2nJYiF6L2Xc1
         J0PotzuIdICqj51+1sM89vu9apvppdgB2IWgSMIW+f0fb+aWnbVC+PG94MNkqrMyCWUg
         vXZzzUVpehE/K4AZ+ndu3d7KxDdUfQdk0VYqFU3sWXEUOrrGiBSSGrFMgEfVanR+7yb+
         /GJQ==
X-Forwarded-Encrypted: i=1; AJvYcCXxm3AmHwGpNbSnjpGQ1eP79m+jj2YxH0A+0/W4ahK+XFweJ7Lb5LCFZZtsUUWJcjV41yLE0tgI5jt71s4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz89WtKuumI0qoWTAhZoKBJy5wOWeX5EBibKlNYRzUbplMije9H
	qKIvRZVRq631jbYBgtEaMxuru3Ha8BObo35vS1FOtElWH2XctKGWLQ8bWjuQh41V7Lk=
X-Gm-Gg: ASbGncvJc5vY+uOoXPXsRv+LhfrkBGqT0NcxEXQe1ZkpHU9njnBjQUnCcNx6VMgWdW+
	vEi4Z4Fd/nt1V7nH2WDA+/zQBd2m45gh122E9tgz7Ix8ddA8iVGUczns1mlnYk9nNZ7AY8lnw7N
	7JbM0XNKQ9J+doi32U/5gQ89tI0MX7RBjX89rHbAta0qQ8N8/ba5F2E4afMlwAa4RHxNVPna33U
	em+dVBguMTkY3kDIAgLEk3HQbZktRGHLdb7rJvvdVDpTPkbNgpADshH8W/18GNcuXTniyq3LrpY
	CyUzNmYPRQ0X4piC1/qlL3MKgWNM+zK5e2zglcbXvRad2nStw0KfVfOhCCIxMZm+f4GGiRNMtI1
	gXbQG2qgSQCHHAL4LncjV6Q==
X-Google-Smtp-Source: AGHT+IE68/qlmGIX56IlXOlLxml610TZz8F68E9PZ++hLHDc9P1ZDNaMmnQ1tVZnFt0XKa62knHQCA==
X-Received: by 2002:a05:6000:430b:b0:3a5:26fd:d450 with SMTP id ffacd0b85a97d-3b60e50ff9fmr1062721f8f.47.1752654520388;
        Wed, 16 Jul 2025 01:28:40 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:e8b9:11d7:19c9:41b2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e14e82sm17287901f8f.71.2025.07.16.01.28.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 01:28:40 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Andy Shevchenko <andy@kernel.org>,
	Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>,
	Srinivas Neeli <srinivas.neeli@amd.com>,
	Michal Simek <michal.simek@amd.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	patches@opensource.cirrus.com,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 0/2] gpio: use new GPIO line value setter callbacks in remaining drivers
Date: Wed, 16 Jul 2025 10:28:37 +0200
Message-ID: <175265451580.10877.15532708023266392185.b4-ty@linaro.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250715-gpiochip-set-rv-gpio-remaining-v2-0-072b4cf06330@linaro.org>
References: <20250715-gpiochip-set-rv-gpio-remaining-v2-0-072b4cf06330@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Tue, 15 Jul 2025 10:19:43 +0200, Bartosz Golaszewski wrote:
> Commit 98ce1eb1fd87e ("gpiolib: introduce gpio_chip setters that return
> values") added new line setter callbacks to struct gpio_chip. They allow
> to indicate failures to callers. We're in the process of converting all
> GPIO controllers to using them before removing the old ones. This series
> converts the remaining GPIO drivers.
> 
> 
> [...]

Applied, thanks!

[1/2] gpio: wcove: use regmap_assign_bits() in .set()
      https://git.kernel.org/brgl/linux/c/03d4bd5729f3adb3dbf923ab08affb5bad262d53
[2/2] gpio: wcove: use new GPIO line value setter callbacks
      https://git.kernel.org/brgl/linux/c/26b6443826d98ac1f5c780788549b8df30e12fa2

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

