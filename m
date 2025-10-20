Return-Path: <linux-kernel+bounces-860242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD86BEFA67
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 09:20:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8314E3AB9D2
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 07:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1AD32D876A;
	Mon, 20 Oct 2025 07:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="X2kiymqk"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D12A3A8F7
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 07:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760944840; cv=none; b=lHwc5EHZpaSAVj1HGPhk2OQyoVTTjiMnVqJvCoUKBhbZwNZ+t3iFplW+T4szr7kPHoXrTA6ssxZZEuFC5iY/FaKX7oWIjXcGtn0YZoBgKrhUiDhKlhTNM2QCdq/VV81w90kFBOOXmh0feOrz9K/YPg0JyWgXdv/3bzYk2Q7XI8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760944840; c=relaxed/simple;
	bh=dRVbV2L7hApMjcL19eJnOYMtttyWyDkFZZDL+3XBMfo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OAQ6nMdYj/GAhyUALgujOJkE6WRL35wElt7/+E6rd6av68lg+9ASZzUIDzZw3CZSBqdRht9uDJc4C038vNYoyhsT0SHBAaYXP+8Ge8UEswE9ecyam4BqfYQCJw/JbXrpTksYD+A4z9aY3/VUy831PDJcxB140GMtbaPBS1LvkZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=X2kiymqk; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-426ff4f3ad4so2274833f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 00:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1760944837; x=1761549637; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Qxt9UraI+fAR4bYyvyRARfla8s2oT5HtZcnk1ZCLs7c=;
        b=X2kiymqkax9GLUppaYVCepw+zbIdb1pF4FpLnIpPEi177svNdnftdIod7Evplg9q4R
         ng3pMFM+kNqzG6EUbDNmbtvoY/2dFwmvQ5MVFFexLbqNAcPDxi1KRGWJDfdgAdfZ39+U
         0oAo2AvmY9g3MmYBsKvBYKzKtyDWW4M8vz8MsiIV29arC5MszUtJc5n8FrknfQZzYQVe
         /QCT9AEo/LzrrsRiG4FPAX5E0mlHnFbGcfd7UID++jNX4/gaWoPC2VEEpRNywodhRFrE
         i22dbAM0AOidWmGCMv2zBw9XAeP1NlXz3hCrJztYAwBdC9fkUf0GIboT98rCIvQHP/nx
         COZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760944837; x=1761549637;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qxt9UraI+fAR4bYyvyRARfla8s2oT5HtZcnk1ZCLs7c=;
        b=vKDtK9kUQhMSGfDeGDvgN6CwH7OtxD8mQIVfcQsVdV8vLzxLnqcgEQDQ5ZZgz9lujN
         FZSKshCMjsFmmh796RyeCl4yVTZmkobu5H+M7nUhu5ToYar9mvtjd1f6ZirPfqnvfjvV
         IAa7dtFuseKAENwdMrzkOOKD4e8CyYZfpA3tGqH9gk6fXhXDRGc6PCXY16ZEc1O0nSH+
         bs0NvIUgsM2yTdRWNg7Mux8OzkGdrLLSmUr7CfNyiWXhlOsK4EdnwyjPTbtiNwf/DrgH
         5OCoeP4zNRY6ept4uSnrkaM9fR7sYL5iObqyYFf5lx3lrTby04dJNdJdAj7sqhN84mCI
         amHA==
X-Forwarded-Encrypted: i=1; AJvYcCUIxLxjjclkgnXG3jyepS95xxVMo1XmU5Ife5UdNof4UXrENmQz8x0Fa2QPV20fsyh36OlZ0A6ZpYMlPuc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzw6jhgz1PigLBy86U4m0A74WlLDzqe6fngoLE2scO8OajRrU7u
	OOpfzHNDZ0G0oHaTt7NtvflwEWlDAkKW3+A9gSLWg84AaNVAGC1egyD/c//EH+buv54=
X-Gm-Gg: ASbGncuLEHGIfkzB4gS10t0dfWN4yBMm5y47y6Y0Pb9GTA1x3BWlx5WHHgT5ptcahKH
	vvg4/sj1btcTav7fsXMN6ofVfAgKyb1I4wLK1eSssN7EZtev51t9e8BPqt55oFbDqDmRwCHLtz/
	L31ihn3/r9ZissqcwKYqfSZR/NaMAJsk4u7hfSFb6NzAuL6zi7xSRe4Au/EErWr3iKTKgTHh4no
	GohB3P7my77TjKM8oLh5r/eNgeqEIz+1+2PT8RdJzjT1PMrh6ItHOm24i8Q+Uhuu8XuluEl1OB+
	J8twRwI5OqzTtaYkfvKGx50kEoebK51IzkDadI3VN54LqzPaDFnnfAXNELbo5MB9RUZZA+HBGYF
	nMLGe+12GylcnhK/fggztk90oFmHRzAxVuBUbuxejHTMeV26TgFfSg7AVxZn2g7WQgq3l4IhopR
	R5j+pBfjM+G4ue
X-Google-Smtp-Source: AGHT+IGXw6gPUlPix/VJlMdLyXBhorguaaSj9OnlsN/E3XOQaDK4VB5Z6zX1AxUD6Erj1aLJX+B0XQ==
X-Received: by 2002:a5d:5f82:0:b0:426:fb28:7962 with SMTP id ffacd0b85a97d-42704dd3690mr8796225f8f.61.1760944836246;
        Mon, 20 Oct 2025 00:20:36 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:5b13:a549:df98:9c00])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f00ce3aesm13976636f8f.48.2025.10.20.00.20.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 00:20:35 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Frank Li <Frank.Li@nxp.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Michael Walle <mwalle@kernel.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH] gpio: qixis-fpga: add missing module description
Date: Mon, 20 Oct 2025 09:20:28 +0200
Message-ID: <20251020072028.21423-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

A kernel module must have a license and should have a description. Add
missing MODULE_LICENSE(), MODULE_DESCRIPTION() and throw in a
MODULE_AUTHOR() for good measure.

This fixes the following build issues:

ERROR: modpost: missing MODULE_LICENSE() in drivers/gpio/gpio-qixis-fpga.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/gpio/gpio-qixis-fpga.o

Reported-by: Mark Brown <broonie@kernel.org>
Closes: https://lore.kernel.org/all/aPJW8HIke5pj3doX@sirena.org.uk/
Fixes: e88500247dc3 ("gpio: add QIXIS FPGA GPIO controller")
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-qixis-fpga.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpio/gpio-qixis-fpga.c b/drivers/gpio/gpio-qixis-fpga.c
index 048a2cac4f0f..54c2c76822d5 100644
--- a/drivers/gpio/gpio-qixis-fpga.c
+++ b/drivers/gpio/gpio-qixis-fpga.c
@@ -105,3 +105,7 @@ static struct platform_driver qixis_cpld_gpio_driver = {
 	},
 };
 module_platform_driver(qixis_cpld_gpio_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Ioana Ciornei <ioana.ciornei@nxp.com>");
+MODULE_DESCRIPTION("Layerscape GPIO QIXIS FPGA driver");
-- 
2.48.1


