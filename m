Return-Path: <linux-kernel+bounces-719390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5ACFAFAD87
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 09:46:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECE653A6E5B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 07:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B85F928A1DB;
	Mon,  7 Jul 2025 07:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="0eU2vdzO"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E79279DC4
	for <linux-kernel@vger.kernel.org>; Mon,  7 Jul 2025 07:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751874381; cv=none; b=bZYb51gd+yuIt32ZMLbY8SDGiUpUnJbsURwk8WLrTD/jSiRtHiFs7TWxt2qTqFoIkH9O0A2qtCdJfCe5zpPN63rlOScD69vHwQoFkLndT25S9vDqkOLfM7uFTAzpmva3IYnEKUPEkPPyEMsiAS2d+aWxcL3B5VaBbl85ab1FLVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751874381; c=relaxed/simple;
	bh=o64n8HoG1i9o095L4gEk8V0ocOswj4uaUVhng4InqrE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QknN64cAKr9HqeBL9Kh0Wwd0p2rPly7UHYsRp6dcJ1UXxi0x1D1zeUjFOTixcJXQ/3zSzgPwBVg3THNPigdnfJt95IwgrM08f/HOvSMMwVMK9rowrLy4nVIOT0y21+jKkSWdZfL9yWzypwRM02ryAbkZKOKDthD4E0iF+svlm1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=0eU2vdzO; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45348bff79fso30062595e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jul 2025 00:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1751874378; x=1752479178; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RZ+2wJfPgdP5WPc++dQKTvMgEl9z5w1HH5OLhshcQSs=;
        b=0eU2vdzOQ0Wl2S9F2s6jEqFb/ol7G3W02l7CyhpQmr8Yd/3wSstVJhMCQOrH13aJZz
         ZV3x5nTD50082GLbcHPJnx0weq71Z0kO4tWqw88JI/3Nkn+blGVpRfreNz5qOEAP1sIO
         mbtLV7wxinbCETjzY4i/4gsrvY3iezJlN+pe/xDmhRPc2oTiMVRMua2p1QCGyI15irNh
         BsPgwrOu0BipmGOBR7jfFUf5wA1+WGmegWReGStO22Sk3nXE+cVyC/Ig+AsOBlaCTgQJ
         gZ+XNxaL16WgBcsThoYlD8wkH94rr5JpuIIHw21u6f/oPPhoNweIJ/+DMjQN9K+z7TpD
         q37Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751874378; x=1752479178;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RZ+2wJfPgdP5WPc++dQKTvMgEl9z5w1HH5OLhshcQSs=;
        b=IW3A6nO9758Ls5N/eR9a+h+K0JXmaiDay6nlGNyITM7srfwbZDZ7dOwjSkZS70IjIO
         DjJnxWuZb1iD5yTj8VKQB50RWnAkZOCCRp3aeD2H8+UZgGqux1+ylRXN12+iuPdKTbGO
         ZCZFpJaEyBxsMunS6oEiwLmpebvHGMbk3a0ZAf51jCalx63tFODk+3A3agvrYNz9qX3K
         Pd2o7zN4Ke2U55UMBmovUVHpvGdNeac/Wx9V+4AAAd+Tz0dhPH1NIYG0p9k/ntTePn/H
         XXCF5sYKzyT2RaZXX4cPKxExnAj+Iuracq23ODskZToxQotccsQHFy22gtyn95dOqOY2
         erKA==
X-Forwarded-Encrypted: i=1; AJvYcCXS3gYy6Cs42xEwRX3lI2/XPCBf1NYwgfzFXgmBoQusEp56IsUeFNa9yrT1B6cwlos/wzmY2tFXcGxGo+U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMfGC3+Bj7Qv1P426ME5NglQf+SP8UQMW7fIfdZUOzYDg48YD1
	zry1JNrTFOul6sCbuswNlFSMVj15vs6lJGx9mnopHxNhmXY/HR4sKCkRQSWHTBrtnVM=
X-Gm-Gg: ASbGncuOIrIav5jl0cV9F/ZRgXc2BYoPhp/tXipl2UzNyeuuFpAlRxFk7BROLa/Uwrw
	Ju99jgclu457lWJ906XEF6XIY36X39ExMFwElbUgaJ3BiEuvGKxxr8mb9NEXagNoBau4J7YYiV0
	XBn2XRfKJUb21XLhcY4fv0X2yRK+SSJGXmB6ICkJPqqCl+L3Ku4ALzvsu6akOt9U0b89OYRvfjm
	XvFIo7VITeprakhdSoJYqrVCoElvoa2k36y0K3C42WwGhz1gucrDFJhQKHZCyhPuLcpRRRUzNr/
	ckoLbpjATSZzFK8QvdP1DoNVqChRerakjc2qOpo7pL3VZdMPsPR87RknS0r6erE=
X-Google-Smtp-Source: AGHT+IGTaLLGKNXhhZgLe2AjuiYxPCN/bEhBq84ie1Igf5JBLfyMw4WewC+BXOddVp59zT0kTEeIWg==
X-Received: by 2002:a05:600c:1c21:b0:43c:fcbc:9680 with SMTP id 5b1f17b1804b1-454b4eb8326mr94737935e9.25.1751874377684;
        Mon, 07 Jul 2025 00:46:17 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:3cf3:a61f:85ed:69db])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454b161e8fcsm105474075e9.7.2025.07.07.00.46.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 00:46:17 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Robert Richter <rric@kernel.org>,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>,
	Tony Lindgren <tony@atomide.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-omap@vger.kernel.org
Subject: Re: [PATCH 00/12] gpio: use new GPIO line value setter callbacks
Date: Mon,  7 Jul 2025 09:46:15 +0200
Message-ID: <175187437017.12064.15350480191939974588.b4-ty@linaro.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250702-gpiochip-set-rv-gpio-round3-v1-0-0d23be74f71d@linaro.org>
References: <20250702-gpiochip-set-rv-gpio-round3-v1-0-0d23be74f71d@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Wed, 02 Jul 2025 11:14:01 +0200, Bartosz Golaszewski wrote:
> Commit 98ce1eb1fd87e ("gpiolib: introduce gpio_chip setters that return
> values") added new line setter callbacks to struct gpio_chip. They allow
> to indicate failures to callers. We're in the process of converting all
> GPIO controllers to using them before removing the old ones. This series
> converts another round of GPIO drivers.
> 
> 
> [...]

Applied, thanks!

[01/12] gpio: tegra186: don't call the set() callback directly
        https://git.kernel.org/brgl/linux/c/47c228d9fc9fe7e3b6f0e7f88f40779f0bb96469
[02/12] gpio: tegra186: use new GPIO line value setter callbacks
        https://git.kernel.org/brgl/linux/c/871e1aee00298fccbda04eacd9e3bb5f46f446b9
[03/12] gpio: tegra: use new GPIO line value setter callbacks
        https://git.kernel.org/brgl/linux/c/8a81d128e1377a7662d0913bc5013eb8a90c3e33
[04/12] gpio: thunderx: use new GPIO line value setter callbacks
        https://git.kernel.org/brgl/linux/c/ecf0c0278f4799f6af245131f02dbb8587f87d29
[05/12] gpio: timberdale: use new GPIO line value setter callbacks
        https://git.kernel.org/brgl/linux/c/dd66f8862f8418d989a8e342ff7af26bf4a0ae8f
[06/12] gpio: tpic2810: remove unneeded callbacks
        https://git.kernel.org/brgl/linux/c/00c337cc68c34302fc0af2d9ac47be5c638d4a78
[07/12] gpio: tpic2810: use new GPIO line value setter callbacks
        https://git.kernel.org/brgl/linux/c/4ffdd9d8a37eaf4e25855e1038b9e1091401c252
[08/12] gpio: tps65086: use new GPIO line value setter callbacks
        https://git.kernel.org/brgl/linux/c/2a5be7a80b3b1036fba5dae13dd55c97fb7eabaa
[09/12] gpio: tps65218: remove unneeded callbacks
        https://git.kernel.org/brgl/linux/c/913cbf8a0d4b0554d66cdc608b231cdf2401a496
[10/12] gpio: tps65218: use new GPIO line value setter callbacks
        https://git.kernel.org/brgl/linux/c/4ca81a1f3a46603986cbdd11348433b0746ce483
[11/12] gpio: tps65219: use new GPIO line value setter callbacks
        https://git.kernel.org/brgl/linux/c/fc0e4091afa9b6c02f1cc2ddec75b248c25cefe6
[12/12] gpio: tps6586x: use new GPIO line value setter callbacks
        https://git.kernel.org/brgl/linux/c/e3ec7ad5ab139ad9e0ed8931ba562f95698c3b2f

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

