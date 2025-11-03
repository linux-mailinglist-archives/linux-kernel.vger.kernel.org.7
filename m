Return-Path: <linux-kernel+bounces-883050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id EE9D9C2C594
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 15:14:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9C85534A588
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 14:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF27C30103F;
	Mon,  3 Nov 2025 14:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="0MmbxGZi"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680CA18C933
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 14:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762179261; cv=none; b=WSWea51OXVOAbKjSFKXXW2ew0FYKJOBQCQC5CsKCuA99K2U5sSfu5oYV946DeMT9Jfwb3cXXZZwNawMOinLXpTTZwBUaNKcSuk8ZOJzvdxt1BndhzaMOkvQQYDEtA7168EhV34LvxJ1VkRtsY9+8sOgu/KgJOuiCFeDP4WoUawo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762179261; c=relaxed/simple;
	bh=qNpCvuLCPjVhSPOY/TTr8xx/nFAJiYYYEoTJa8eEaaI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p74LACI8Ng+aEe31G4ksPDsJKrew7ElSv/6WuTQccIWLgBJGz9psTgpPt/1TRT4rNcXOyKx7RehQY0EWMb3Xw+pzdozL2I1ogVROxVmqN4EbsVcyZfi9qx6/+A+Huq4myqVEHA5yaDOvaM043rSMuZf/dTpLHTjQhqGH8sKKCNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=0MmbxGZi; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-474975af41dso33493305e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 06:14:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1762179257; x=1762784057; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EoMAIDiy80JlZ2DMoz5nEEW7dOP5ZblOtmfc/TQFMxo=;
        b=0MmbxGZi13Xt0Gijo4wZKWclxbyoLYC+/bfMtIgewcYC3H3i1Pu0fhPprY5+wPBwyE
         Q1Sw+Ot18WOUk8PKIgJ/Wv4JDKoStxltKBRHR9KxKuagbcP0pchNeiI7odxE1KFRL+Gz
         rTEOuqa2YCz/J+OX70vPRv1CEbYS5oUZ6uKNU4C6jEaf1to5W9Hj2LXgxQ1bYDYQDcIe
         yFq3ZYHIfai2lZiMWWkRCsO7rEP5mOzzyuap0FT3FNuYhVJqMpXArdqAoQXbk6GECMyl
         qMURQMP4x/NZK4DWe6k5fp4GVDbtYbm6sYee8RtcPYnR9Bu0xWRa5cjcaZw2IQ87kANM
         g4ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762179257; x=1762784057;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EoMAIDiy80JlZ2DMoz5nEEW7dOP5ZblOtmfc/TQFMxo=;
        b=PQ3SGFZsvtz9YheJCXspIzLToTIjz1RRmkzeYaqiIkg2lTfGsJxYzzsmwXHnCypXpz
         jExIMDrogdzu8fRyIVu80gbSgDxWJbRiUskBlIOefYFLNFAUXDmQdPJeQ99va4Ce+mk7
         CVx3JCm2Zy2F3afz/sQcB3NT/eUFuCyMsMy+qAfm/ZR46p9AI8lkV25OoWYcwffe+k3m
         416cuqtBazVpd3VENzgBdlgHDFgBT7mifokNuW2jYnwjAKg2zgdXlY8/H2tUEmlGiQyX
         Y1zPrI85mYbK1t+Zd1BvpiCWylzjFMhy2pneOgmuE3OTx1hKohlF5ga0AjQVs+fHVUBp
         L8dA==
X-Forwarded-Encrypted: i=1; AJvYcCXVORDmS45Kdoh/2Cep377v9QY6Ofa9Po/qMfHUAWE8baLdlVnPBkDMyN94ES/ZQ2TIgjRAiqcOP/I9iio=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsXlDsvbDWJJJsQBrsU5hVm+um8+V9f2WisBwbuTl8xKguZeFH
	2vB5H8d+b/JsHSeComvix4vz/OZUHh8RZZM26PUV9Gusm7Jegx1XSOqzFumMOvtdz2A=
X-Gm-Gg: ASbGncvQezLkUrsP1JER9bHDt2WaA9TWk8CpL4bHeqAM/jGhe//mc7jVrphdPRQ04z4
	yHQIiA8XWJKK1lQAKkOvOtGfOGV5F4pOWw2OPVC7jahxJYqGrC5AclndzylqkFFyu/z1THYt9tw
	4rjTXcXksqgeyxfpo1nUTehu0UGuytEyevvyZWBGWvMKD5+OeqDhhGp47qLeIvXwaNjbMVfZvK9
	JgLXH6vnicVBnTa2NxTaUxqOcAf7N1rYs8ERRw/sI9f32/xQ9w0bJBM1nlcSJepyAhc4/Wiq53v
	/GkqQbCsobFFOMeuZ16cdot+VdNOSdAotItPcDVn8RHT3/kfhWKU//cuCsPCVGWV+8yDM5dCj4J
	Eg94ihtwB18/ByNskILy4D4SZgPiZqUGb/oBrRXoyAT3nDzxIUBwJVoCzaZ25nP5l7l2FwQ==
X-Google-Smtp-Source: AGHT+IHLTxJUWh2BXzgbxjWcAhT+fbvRofGiksQw6Mxx2/kQAdhUW2RWaozukFUQgF4dPtsxkYVg5w==
X-Received: by 2002:a05:600c:3548:b0:477:171f:65f with SMTP id 5b1f17b1804b1-477308aa6a1mr118209365e9.38.1762179256644;
        Mon, 03 Nov 2025 06:14:16 -0800 (PST)
Received: from brgl-uxlite ([2a01:cb1d:dc:7e00:e6eb:2a19:143f:b127])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4772fc52378sm86531405e9.6.2025.11.03.06.14.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 06:14:16 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: Re: (subset) [PATCH v4 00/10] reset: rework reset-gpios handling
Date: Mon,  3 Nov 2025 15:14:12 +0100
Message-ID: <176217924320.53912.4328025839514313502.b4-ty@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251103-reset-gpios-swnodes-v4-0-6461800b6775@linaro.org>
References: <20251103-reset-gpios-swnodes-v4-0-6461800b6775@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Mon, 03 Nov 2025 10:35:20 +0100, Bartosz Golaszewski wrote:
> Software node maintainers: if this versions is good to go, can you leave
> your Acks under patches 1-3 and allow Philipp to take it through the
> reset tree, provided he creates an immutable branch you can pull from
> for v6.19?
> 
> Machine GPIO lookup is a nice, if a bit clunky, mechanism when we have
> absolutely no idea what the GPIO provider is or when it will be created.
> However in the case of reset-gpios, we not only know if the chip is
> there - we also already hold a reference to its firmware node.
> 
> [...]

Applied, thanks!

[04/10] gpio: swnode: don't use the swnode's name as the key for GPIO lookup
        https://git.kernel.org/brgl/linux/c/e5d527be7e6984882306b49c067f1fec18920735

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

