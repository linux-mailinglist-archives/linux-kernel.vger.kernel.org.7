Return-Path: <linux-kernel+bounces-862476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA558BF5643
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 11:01:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6574918C6F46
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 09:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23339328B6E;
	Tue, 21 Oct 2025 09:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="xx/dlBX4"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF81827AC28
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 09:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761037310; cv=none; b=R3CWoBVjqPuDQRwur9/YrwljKugqPaBY2rPrA7celFSDJIO89J7FResiNh/c1sTdC2IU6eZJ223JyBZC7spLcplTDmyPafQgE60G+165VEacRBYhl6hgezvHw2TsP4E2ShEjumlIEGUpnvrcv5NyZUnTcPIDHASIbBiuy0MUNyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761037310; c=relaxed/simple;
	bh=zo7FMMU21d+H8nlfETeUkJqvTYT9a1KWD14ezWk03WY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bclcPoY+hmRSmaNsiawoCHuan1ifKc9DjaXT0V8l/wPRINR6H5I2nnSFkfyyX6v1xk+EZFYJ7/rOKmYue7P/7KRKW9gn7LjeDrMIQ8VA+8dkQCZIZC7oHlrkRMAUJA+m6evnzzutK7yBLZuO9LNFPzrEApbR4d0VmoRBiGsniEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=xx/dlBX4; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-47109187c32so25487085e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 02:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1761037307; x=1761642107; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a7hM7uckFcu+8xOxYahCnfJuF1kzdKDORaIviV98zX4=;
        b=xx/dlBX4YBy/SLGIC5Nfkyd54TppNFFjzoJQMIzdaShSUZJzBZKLO3RP/l/ksSjUYe
         tgBsAxJV4EGJ1CcIrvQajhosZ5dlOkX12NBgY10xa2j2dix+SGShc3wnL1473YlRmAVR
         AaMq+dPqYYautYYSMQIaf/WUwQ7arGpou5moIrjQX2deVIbkdOMyBkIjlFTIelCzgmj7
         GN0wn8dc2zcymka1fU/lBcGunuJlpOK1p3X65+4iONUdf/DQ3QpCuZvwHvCLN9vxed53
         ikb+Vh3TBxfJzZooLCuFKXlJGthbGEABcivyXB8MhOhSnVU6WW7EqDztkmgZLO0/r/rX
         Je7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761037307; x=1761642107;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a7hM7uckFcu+8xOxYahCnfJuF1kzdKDORaIviV98zX4=;
        b=RIde/vBobF5To9IwreBNHUM5fJMXm8YxB24/B2fbnbibGEPobAk1C0nxzD9zULG+Ax
         iGCA8pv5fUxHvlsG9s4YYPyI4nvtUXfYd1QlcgIYZC1W8XeCChnEHng+u40z2eRh5sNG
         hOxxXPbP9xS7jbSbr3wKPLVRmSeU7TMkqFUwBY47byLOAJR4v2xZ6eG0uSuf560k+mhF
         1S9nnkT+1dPpcBHOkWTHPneMKY9rFMWsOdrz3L0x0TbGRFj0IP1DoP9rqfO0uv4edQtW
         Oq3MLxi3bCGPCWXGusT/CmT+Go0rdztTx7KHanJrr2/eA61Nfynw5R47m9yuVtSWfzJ/
         DzTA==
X-Forwarded-Encrypted: i=1; AJvYcCW0nCv3HMi1V5pHkWjoQ+LRhqEhi66EEy8kThCvb+Vmt32uzyXIxUM01lL5f4ewGp3On566qQib/qYvM0s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkUJN7Lm8KjPZsQz5tElJygZAaBeQN4rtcRUC/qHJSNZitjGiY
	ezO69NtX/Qiycs9YifhS051gPO+FzG3P3rWCf4TPAygbI2yHRCqCjO0hgY5MEtlyx0g=
X-Gm-Gg: ASbGncsvwvQ2ou/mStSt6wrWLNf4JFoDxn/CuMm78FsqWBKQ8b6i3OGVpwmPod5e3fO
	LlMFJQgfQ8pi+ujPBL9jm5rY5IHVtsmqUNM3AG0FdktwL+MC+DMw9Cd6Tqa6pWg5PB0GTSuL9xf
	xHD/tD77RJVPiONfisGfKeEF3yFPXe+B7mW3nOO+/y5CFox8M14FnpDHFIxAR4ytScyhxBjp5Rl
	j+ARa/URs7749urjC8cXmqu3FQtatTrcFxK3FFoaZtGdy+pDsEQI1P6aqI0C8RmBHdczHvOa+hK
	14lZ3glm2OVxe+tb41050uWyuBBoRhz3pX6Ja+VXCcBpOHDsOPTGLqFE5joX7vhN3y3ePJsYCJS
	3an0roDEYz9QrDjLZW4EhVVpyhpbZGQksFQ4Y5zja3YPwfLe0OH4W+9nodYyLf85kUWC1Lb5ZSF
	3jng==
X-Google-Smtp-Source: AGHT+IFwaSBjtILyooiRtf1Ykxp9UxcePTyTy4SgHykASPLMYxBKsOoz1/6AxkfVyxkle8GOQXe6Qw==
X-Received: by 2002:a05:600c:3b22:b0:46e:4704:b01e with SMTP id 5b1f17b1804b1-471178767f4mr119724175e9.8.1761037307000;
        Tue, 21 Oct 2025 02:01:47 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:2979:9ff9:6677:97c6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4715257d972sm191369065e9.1.2025.10.21.02.01.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 02:01:46 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Kent Gibson <warthog618@gmail.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] gpio: aspeed: remove the "gpiolib.h" include
Date: Tue, 21 Oct 2025 11:01:42 +0200
Message-ID: <176103730245.11215.16894410168920796474.b4-ty@linaro.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251016-aspeed-gpiolib-include-v1-0-31201c06d124@linaro.org>
References: <20251016-aspeed-gpiolib-include-v1-0-31201c06d124@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Thu, 16 Oct 2025 11:09:24 +0200, Bartosz Golaszewski wrote:
> gpiolib.h is a header internal to the GPIO core. Drivers should not
> include them. gpio-aspeed only needs to be able to determine the
> hardware offset of the GPIO given the descriptor. Expose the relevant
> symbol in the consumer header which allows us to stop pulling in the
> private one.
> 
> 
> [...]

Applied, thanks!

[1/3] gpio: rename gpio_chip_hwgpio() to gpiod_hwgpio()
      https://git.kernel.org/brgl/linux/c/df900536e85819f6168783d5f6b3908d47811fdd
[2/3] gpio: export gpiod_hwgpio()
      https://git.kernel.org/brgl/linux/c/d19f6451c6feefd6537b97efa5f3859681f243cb
[3/3] gpio: aspeed: remove unneeded include
      https://git.kernel.org/brgl/linux/c/0efa5b2ca6fa7baab4c523b34cfb9495ec143d61

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

