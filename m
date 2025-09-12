Return-Path: <linux-kernel+bounces-813339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9F5BB543D4
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 09:27:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 810BF1C8739F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 07:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FBF62C08CB;
	Fri, 12 Sep 2025 07:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="BoX7T3mu"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D1D2BF016
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 07:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757662024; cv=none; b=gU/Yh0kA8BAxw83DQFiDont62a4JSXM9oE7NTYdGdXQMyVWCaFRDkFh1F0nCkoA9jBkWQmuXwzpv3TAHJczDYdxBVPg2NYpGv80y2YPl/v/AriHLHB8+xfwWfRaETojvuBbyIdLyAKVpf5Unzh6HpBfV7dFS851tAH0RDbZRWkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757662024; c=relaxed/simple;
	bh=xdcRbwNQYyPOvei/iOTBM/TyZ63L1Uwke68lF4T6tVM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lHDH368eGIBfWxheYTQM8JiDdYJNsOwS/OYUdAeWhdRFtHQ3iwsVrzbPyescGPNulJZjE2crXfJaCH22Y99FjvCGSDPNDHt55cEO+aRUhHtLfznzaPkqXv/yOFQ2NHOnlxoHwdbDiJWVrjgLGQKkzVblX+ZgpglZ2TcE9YCxCHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=BoX7T3mu; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45b9853e630so13758535e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 00:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1757662021; x=1758266821; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j3tI11OAkSN7RqNGcTXf8rRvtsdFAfZUpl45jMI60AM=;
        b=BoX7T3muxiexNp0SKN0shYggkpN4K0Bx8AJ+P5P4iMwVsJ4UXJKe04CN2fBzLrqdRw
         IzsRayg3+KTaN0IJd94lCsA+xO9EgdjUiu9yMatMUhQIBqMvKxSyukFF9vnLGDht4j0t
         Ctlr51XQdfoY8XXmK5+vfehuajHmOzXYRZMrm0ofZsaln7Uc3L6/IMliEe6TnW+Q8l6e
         YscVvejNTgjJyyfVBRq11jhOE8d/gE+yBi/Dj54QQpBNUa1g1vxn1nrtUyZBWWzZeTE5
         lpEJbASip1Xk2zxd/ZOXoNFGp/GV1pSb1Vs5s86iUUP/boUWDO6bg2w6B6Nv4U8nyEkN
         p2wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757662021; x=1758266821;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j3tI11OAkSN7RqNGcTXf8rRvtsdFAfZUpl45jMI60AM=;
        b=bVPMbHsS3WMyIElMlpaG48zluxm/F07E6DbtX4proSPipFRiDgVHerMc4gtBRTzHyb
         zmVYUcK9heEWHesLGo6KRWAdnL6VgTOKM0/xJKtaDQWmDi4xQdv5LtaWrci7z5dbiBxf
         jh2bkJIPlB+vyJJGlA2pdBA1zNn8gabN2WG/pUtDIiAMWu5/JmJhMruzgVPt9a3AqRVj
         W4dwfH6AAJcr+CdIaNxwQLz7ZzHy72F+HhbikbzOggrijpWDn8sWCUdb+HYnjO7lEwo0
         Q9Y++XkESgZkc+IGqxUE3a+dm5bvAr/4nIgGAfq0qsM5BRykU675+DUP+PcK/At6Vqd4
         VFBA==
X-Forwarded-Encrypted: i=1; AJvYcCW7TndCCWuHD5+dXph+1YUkF3pyDa4WbWnP00/kHMqg6cufaxNmau9uY5xQYw7WTGKvzD4KHY2HPqPjBNo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyI+/IsTngbtM+yBpVtvoiEIEKONuAMKCp2P35Y+O30VkFEtrG0
	W1OVpLIjc482sah0zH2MC5pIRJL7DNfF89R/6/zZ09x1UlZdYZgGTqpDYkrrQK0UQLU=
X-Gm-Gg: ASbGncvcJYIW2b5PF3eFcfybV0OeT4gcgEPWdv+xvUK1P9Es+JrjdZwH3vRvuVfIAwy
	uu+v05nlcWwKz6ZLGj3MqZUk7uim5v/PWI1HaQlm1paQXvEOZOLMVwoylHamxz33oHcgIDwRZK7
	ojW82aryi5wakwoY1o7qAulprLuocyRuslKNUWMQp2Rc4WEWrg+8VS1w5PjBTM9ruzcHQek+qu4
	5G7DIc0KPpiQQUYWXbiCT/2mYqVqakOfX+yqjMgbJSRhcwKmhL7wNR4eZlrkxkmwZlQfGfsWdAT
	nt442No6rjznYkTk+fxniiOSB4/1eJGJvdqSXURdOumtnVwaYScZDccaO4CgFndHzamidfLjevb
	0tJS5iCNWJFcS2nuu/fKh97I=
X-Google-Smtp-Source: AGHT+IGXpoEAuIYw6/UluyUVnBbgfJgpGf6NHBYCv+YqFkoz5Fkn4jAGq9fRMx7AKxy66hsY9dDhlg==
X-Received: by 2002:a7b:c04b:0:b0:45b:81b4:1917 with SMTP id 5b1f17b1804b1-45f211d5d6fmr14759865e9.10.1757662020614;
        Fri, 12 Sep 2025 00:27:00 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:b6ab:4211:ebab:762])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e774a3fb5bsm730202f8f.58.2025.09.12.00.26.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 00:27:00 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Lee Jones <lee@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Avi Fishman <avifishman70@gmail.com>,
	Tomer Maimon <tmaimon77@gmail.com>,
	Tali Perry <tali.perry1@gmail.com>,
	Patrick Venture <venture@google.com>,
	Nancy Yuen <yuenn@google.com>,
	Benjamin Fair <benjaminfair@google.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	=?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
	=?UTF-8?q?Cl=C3=A9ment=20Le=20Goffic?= <legoffic.clement@gmail.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	James Cowgill <james.cowgill@blaize.com>,
	Matt Redfearn <matt.redfearn@blaize.com>,
	Neil Jones <neil.jones@blaize.com>,
	Nikolaos Pasaloukos <nikolaos.pasaloukos@blaize.com>,
	Hoan Tran <hoan@os.amperecomputing.com>,
	Yang Shen <shenyang39@huawei.com>,
	Imre Kaloz <kaloz@openwrt.org>,
	Yinbo Zhu <zhuyinbo@loongson.cn>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	openbmc@lists.ozlabs.org,
	linux-gpio@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	imx@lists.linux.dev,
	linux-unisoc@lists.infradead.org
Subject: Re: (subset) [PATCH 0/3] gpio/pinctrl/mfd: use more common syntax for compound literals
Date: Fri, 12 Sep 2025 09:26:54 +0200
Message-ID: <175766186357.9646.17039178132060352918.b4-ty@linaro.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250910-make-compound-literals-normal-again-v1-0-076ee7738a0b@linaro.org>
References: <20250910-make-compound-literals-normal-again-v1-0-076ee7738a0b@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Wed, 10 Sep 2025 09:25:44 +0200, Bartosz Golaszewski wrote:
> As discussed[1] with Andy: it's probably better to use a more common
> syntax for compound literals so fix the commits that converted GPIO
> chips to using the new generic GPIO chip API and make them explicitly
> spell out the type they're initializing.
> 
> Each commit in this series can go directly into its respective tree:
> MFD, pinctrl and GPIO.
> 
> [...]

Applied, thanks!

[3/3] gpio: use more common syntax for compound literals
      https://git.kernel.org/brgl/linux/c/7eee64e8be51f9ff0393b5bd0752a6e8f9252bf9

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

