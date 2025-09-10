Return-Path: <linux-kernel+bounces-809571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 951D3B50F3E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 09:26:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 485CA189138D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 07:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 394BE309EFB;
	Wed, 10 Sep 2025 07:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="eQTHW4NR"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF40030ACFD
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 07:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757489157; cv=none; b=sDMW/aVGaUVkXi1DVCb5LIbHLisivMDlXhKNZNJfe6dR9TyymBc+bkmi0hVOP1/Q7yaeG0GayHQXK7S47+/lJWRbTKgA5F+Vi5qRDwPE4Y+CC6U1hQokk2vPQ50olNsLVDbWJlgvgg3ckGKbYS5KZjF7HFdcOebwW7ADv2uW8GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757489157; c=relaxed/simple;
	bh=OyfxzmIVdlqu/N33hp9H+6rXN65Nb5R46kDG4x3DQPc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j4fCHxnO2KlnRCWgb+4pJgnkE+uQGG0N3LcsEiexC3tiWX8TQB7+HY7W89hdZ7EjzYSbAEv3dKxcYgGIrAxg13c5yD2isDl3riOh9qsDr/F3fadkJKVOIHciJINc+DOQLpgGhhmuuWrRWswlCMgLC0x14qJ5Q4aGxJsBqYCqfPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=eQTHW4NR; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3dae49b117bso5683349f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 00:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1757489153; x=1758093953; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gl5EvZZ7qePjJl2BaNjHQ+dzPz2TAyeCpTwHy9T9Wfo=;
        b=eQTHW4NRXpnLOgtCpTiJ+ydGli14Rcc/nU85fLkHEUt9j/ESXrOtvEqeKMDPNoGcg+
         xn5YCBxyqJCs/61OyMVGRMkXLmZNEjto4IaW8g2U8ZQLlXWacSEUeBgY4yS84bXWV33Q
         ir9D6LI139SyeOLbvzlmSR9zDZdqBNMfv0o9IKeJVaPGbEu/xNghb4o1HE347JxuHqkY
         3tHztI/ndyyxj3kUk4M8Zwws9GNcMRAFKsrtv6E6qFvnXwNZVVitmXhlBUdTNv5p6Pnl
         2OOtr4rjR3Ywkx10Ij9afhppbTJ48ToSHI3lL7PulEiijNEALZHEtsDl6bEDVKbzV/q3
         iKXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757489153; x=1758093953;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gl5EvZZ7qePjJl2BaNjHQ+dzPz2TAyeCpTwHy9T9Wfo=;
        b=CmlSo3zjc+jQ+oSNx4aP8Qp+8YLvMf+Ad4JimuTBOIGqeYJQMFVofXFPVwFIMRaZVp
         Ir2AWnBEayWjCMc0YSz4ipRJCSooxmBGxt86H4h+Ljf/1Q6qCDHCBEPSBK1h1h1msAvR
         dCaFFMP11G4msD0gma9gKUpRCOBEVmsb4NCHC9vvTIgw/iJphEelwZM/dYFdelAPBv3i
         i+D9o7lvImCfoasvDvHqLUAK0x0K1vDauJFF5ichEhjAsHRz+hQkDmMY2Q/NRsZRrDcX
         BmpkvW68IPDpaNwxBaeBRDPh6qNdwRXwpGbvS6N8bo+BfhYP5EzOOCw39RwP88e7FQEY
         PKEw==
X-Forwarded-Encrypted: i=1; AJvYcCXl6qJjxs3WBb4vNTmXnplehRujTmqXA2779PCdVIE4visWUn8qW02X1e5dQizRogoemmK08FompW5vpec=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKRE/KpPYzvKLyX+yF1TyQQQrGG3mYC/E+1zLgolIIjGSqo/C2
	7U358zeQnKFLc2AJI5tMRDyW1EGfNyUFGgfO6XBZExPM+2iGPfLasO+W34lXABWTajw=
X-Gm-Gg: ASbGncsFo7KquCktmBdHlCFbkbwh5eSwcooiE1KsVB+xBqSL3KbpKZD855oSUF+pBlq
	Fm2uv6tr035MfnldJjAQHfhuTQ6WBsu+aR8hF2BhbOQY3ehUJtbzYO8ZVT4T8BMvTbrTHgh1HMQ
	WRg7Z7S5eTLsVGtt+AMQv3b3BfAJO8aQO12y2P/B5a4nlr2y5qEZLoH4AlUytm95V5Kzk8jL5kR
	4rFr1aR+XgbMRt24zOSspXp7N0j8spt8vizDQQIZXVc7KcCGAHW2eWqy+8Wox2LSfegzGrXBXhr
	8VH5IasGXhVIZM1H1yo1mZ2OvASbVWjO/dDpYdkglwBciYuPGUyYV30CPFhIh6p4SzDAM144JXL
	rm3r/znQjI+dWGUt6RTmVqRAFh/ZmKsff0DLp+bo=
X-Google-Smtp-Source: AGHT+IFKdWd/MOTTMywYPHVw5YIDU4ZG0NZ3VmH44f3IGf1C3HlllFBC2cfty+fO45t0VoMp0fb6YA==
X-Received: by 2002:a05:6000:1a8d:b0:3e3:f332:73f6 with SMTP id ffacd0b85a97d-3e646257abcmr9958246f8f.31.1757489153027;
        Wed, 10 Sep 2025 00:25:53 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:3936:709a:82c4:3e38])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45df8236428sm16729825e9.24.2025.09.10.00.25.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 00:25:52 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 10 Sep 2025 09:25:45 +0200
Subject: [PATCH 1/3] mfd: vexpress-sysreg: use more common syntax for
 compound literals
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250910-make-compound-literals-normal-again-v1-1-076ee7738a0b@linaro.org>
References: <20250910-make-compound-literals-normal-again-v1-0-076ee7738a0b@linaro.org>
In-Reply-To: <20250910-make-compound-literals-normal-again-v1-0-076ee7738a0b@linaro.org>
To: Lee Jones <lee@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@intel.com>, 
 Liviu Dudau <liviu.dudau@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 Avi Fishman <avifishman70@gmail.com>, Tomer Maimon <tmaimon77@gmail.com>, 
 Tali Perry <tali.perry1@gmail.com>, Patrick Venture <venture@google.com>, 
 Nancy Yuen <yuenn@google.com>, Benjamin Fair <benjaminfair@google.com>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 =?utf-8?q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>, 
 =?utf-8?q?Cl=C3=A9ment_Le_Goffic?= <legoffic.clement@gmail.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, 
 James Cowgill <james.cowgill@blaize.com>, 
 Matt Redfearn <matt.redfearn@blaize.com>, 
 Neil Jones <neil.jones@blaize.com>, 
 Nikolaos Pasaloukos <nikolaos.pasaloukos@blaize.com>, 
 Hoan Tran <hoan@os.amperecomputing.com>, Yang Shen <shenyang39@huawei.com>, 
 Imre Kaloz <kaloz@openwrt.org>, Yinbo Zhu <zhuyinbo@loongson.cn>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Manivannan Sadhasivam <mani@kernel.org>, 
 Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>, 
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 openbmc@lists.ozlabs.org, linux-gpio@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, imx@lists.linux.dev, 
 linux-unisoc@lists.infradead.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=979;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=2AiYFCloD/4RAraZbO+KeVDtX8xcEqWOa6di+UP2k+Y=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBowSf8VTnO9QVF1tR30IBvEZEbYU3RFZcMzjLBO
 2ZoExM1MEWJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaMEn/AAKCRARpy6gFHHX
 chgMEAC1UA+PKD6t6aGSJKb2WwHVdpLkaweVvLymwppdHKPAhq4e2ZXBwcfe2Xf21UCZiVRN5Pb
 sXKBL7TU2hsVJnh+nY1deWzVbeenzo8hfzM5je3+XttTa2Cd7DH6irICePcyIIAX9BlaWTAaKiP
 OzZfpmYjW0CygB3YYK5biWI3U5cbt8nLFSPKK/ST9iUNo1jaFukc6FipCfVUosMTABpdPQOqmxc
 EhVqSROfAU4VXT6X9L7y4z/srhtMFu2ufagfAW3sz0zMFPXiSOQcSirf7JyGZrRkwKN26VcH7XE
 SMpZQkhb/5/ccgPK9pObeHyNoII8VEhVuraYCkIOiW6C04U2HwPu6nfDQ0YdiITYx2gObHsjuKA
 dFyC1qARBLWkPpFha9B/WfdT4effL2+txlK5x8JKZY3ZYwbv+7kgyLjuwGt3fYKMneEXrd3GWwj
 Ob2IeaFzQUJplmbPWMbcU/LOW4JBy7aOXHImgg6G6fOJSUTexbqJflcFeQ6aqoJ+iMezbpCUVxX
 DaEUCGs/NEd4R7KcgIrmSebHGlPJot9MGekvnPntd4Xt/34GEdDUYMriQBIjB8jshF2MoPpqAbq
 MVDAbVmCWbgIP0Aljy2QDxkXCnS8MoTibWav6SmYomsrAUE1bXtWLPW/j4cOMWhP7q0xosfcc/0
 W2Qzs1Uc+uQvMHQ==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

The (typeof(foo)) construct is unusual in the kernel, use a more typical
syntax by explicitly spelling out the type.

Link: https://lore.kernel.org/all/20250909-gpio-mmio-gpio-conv-part4-v1-13-9f723dc3524a@linaro.org/
Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/mfd/vexpress-sysreg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/vexpress-sysreg.c b/drivers/mfd/vexpress-sysreg.c
index 9399eb850ca29b0a9d9be2173bee4bcf6888d10f..f49cee91f71cc2e6132cd3118dafd42a48821e0d 100644
--- a/drivers/mfd/vexpress-sysreg.c
+++ b/drivers/mfd/vexpress-sysreg.c
@@ -120,7 +120,7 @@ static int vexpress_sysreg_probe(struct platform_device *pdev)
 	if (!mmc_gpio_chip)
 		return -ENOMEM;
 
-	config = (typeof(config)){
+	config = (struct gpio_generic_chip_config) {
 		.dev = &pdev->dev,
 		.sz = 4,
 		.dat = base + SYS_MCI,

-- 
2.48.1


