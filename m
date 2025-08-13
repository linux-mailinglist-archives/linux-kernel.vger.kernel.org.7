Return-Path: <linux-kernel+bounces-767291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D41BB2526F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 19:50:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71EC41C80D52
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 17:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7DC3241679;
	Wed, 13 Aug 2025 17:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="kFW7/Cap"
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B21299947
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 17:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755107276; cv=none; b=hr3OfRBoByrpYAjVuITkljQ6TxylDgQBFMhoVUyHNMLgEcOlcf/QIp0Bnw/5Q1QJy4X8gEZa6PYlnRFsvx/zpgYjTDqamZh/648+PIcaz7JZTG54Z1eX7FIrMFXzgBhES91QC8BHsFQpyf674rjV0bMToLYq99KV9HK+M/WBMA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755107276; c=relaxed/simple;
	bh=/+oZqZHI1h9WgghpCqBvJzy9LGRR42vTOm/KVnlDk38=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kgYeHJ2N137wDEQYA7Drv/3W6Yxd3rGXBoGhwTP9z1sjkoJq2raNP2afX8cuxHPpnHMQELrHmb9BAX0Zcbi6tQEuKPa3dp268Y3gz8TIHQrPvNC8/KfnUy1GV8+aiQ3ubSR/VmJEZaqvzzocqvjyVOPgY1KP8MHwjnVo1xAHBws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=kFW7/Cap; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7e8706491ecso8017785a.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 10:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1755107272; x=1755712072; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KHeBX+bcrAsO9afYXWyPr7+HVV+gOxB4ZyOYt9ZHb8s=;
        b=kFW7/CapgBjqXy0radKy0GWHUNIVOiivw2/rsDNMRsE3FQ8/ZQsZgmwWXPi+eTFNES
         x659WxQMaAe1C6C7XMajkIdnQEU8QWR/cR++KYKluRQxkNqwpR3PxG2WFSLzDsdphcP7
         6jxGxViOSo7w0vwxP3U+GEjPpK1m0NfSD/0huhESrALNBYcLgAmp5DRelfFTwVp4VwsX
         dUsrv6C52NWSNFQjopefpKwbANhUU4nzRUmnyOu0XlmWV6BQYqQGmuYDGwykI3VKOcWU
         uJzqCWcGbGnZQ94hNMtn8+8cetmvqgMPKJEX+yCX4Ftt/SUxA1RFdsbDEklI4ILZ3nQZ
         eP0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755107272; x=1755712072;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KHeBX+bcrAsO9afYXWyPr7+HVV+gOxB4ZyOYt9ZHb8s=;
        b=bQ7PlxOv7vBngtfegyonMoZX+UGo6zd4YdzpDuRSv+L/il6bteEc91izhOnTykzwLY
         Y8K7dzzb2MepBl2Hx9OvdnUyXYI8pA4F20ZraIGXEq9EoFk23MFZRlcyws63xIct1+2q
         6SenX5McwlP4Z+8U5SnfNXJT+6JC1JVkuiPQiu+BHT/TituzRshvEvv/tK5V5yCp155S
         Lat7QZa+XmfkFCygGUAvo0NHF9eVeMcKA3QUbtl5IasFS8AKp5lNjgl/1Pmp/p5k48Ag
         4fHboOojeS4syhQ8skccKdJZ8PlAra/Omhp+QZjWmeESBZfqUy+GDQmgmyTusv0mc7pf
         p4Yg==
X-Forwarded-Encrypted: i=1; AJvYcCXp7MejTHXDJNPzd0a0qd3j4q2xtEZLszstrUrL0bBKPPrYSc9HqCIqFc7pE5e9bAVlZ5EVOgJBkH1zi+4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLSXuJpFeDglqBs+liZMSgzan574jOtzYsroc8OVpRftavWM6i
	6hesdXeTSMPORaMj/X9o0YaRg4++JDAYdx0R3TeCri9sgdeycECLRV14n6aG4bp2Yk4=
X-Gm-Gg: ASbGncsqOig4HYkKxCKvUR6faCrfkWlqZoiS1KqfzJ09a64CYtqQQ1DCSH6OSRJPeM7
	s3MlXi348dCPpCGBuXcmyXe8LuQcXVAcdBPnTb3X/J5TRUnflDm6RMwZeXkQ6vn1aLFuNRNwbxG
	ZTQYqKyTw/YGxIyH/u8lkJU5JunasCvo8N9w2BIt4gairFPwf9lGTGF+FJVM44nuYIm9CTXU385
	xAAAdnT+nH/XUHDIKdRdxGsTfqlt30RH0RdUNms/d8IQ4OI0pscJZH3XnberdSg0AWPooTL6vUB
	DKYzVT9RMv6YJ4GVbQhWU6sEQh+L2dwa87IMAPkCP4IjDxABXiSQ8NEUYFWAuBO1fYFdLGwcS9d
	fowQ6XQ1JayO/ULH6d4NoySJ9X3CgpCnH34cFhA5Hsf60FkoT8rk15JmhyOhfRyk=
X-Google-Smtp-Source: AGHT+IFBbRD05COD+4uOC97ucvpHyx0jBQqfnQDIsz8+GmCzNdE1TPU770o9CrOuegUdmCbSDq2ITA==
X-Received: by 2002:a37:f50d:0:b0:7e6:5ef5:c7e4 with SMTP id af79cd13be357-7e8705d2e04mr26126585a.64.1755107272247;
        Wed, 13 Aug 2025 10:47:52 -0700 (PDT)
Received: from fedora (d-zg2-251.globalnet.hr. [213.149.37.251])
        by smtp.googlemail.com with ESMTPSA id af79cd13be357-7e7fa87e7d0sm1627122385a.82.2025.08.13.10.47.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 10:47:51 -0700 (PDT)
From: Robert Marko <robert.marko@sartura.hr>
To: linux@armlinux.org.uk,
	nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev,
	catalin.marinas@arm.com,
	will@kernel.org,
	olivia@selenic.com,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	andi.shyti@kernel.org,
	lee@kernel.org,
	broonie@kernel.org,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	arnd@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-spi@vger.kernel.org,
	linux-serial@vger.kernel.org,
	o.rempel@pengutronix.de,
	daniel.machon@microchip.com
Cc: luka.perkov@sartura.hr,
	Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH v9 5/9] tty: serial: atmel: make it selectable for ARCH_MICROCHIP
Date: Wed, 13 Aug 2025 19:44:41 +0200
Message-ID: <20250813174720.540015-6-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250813174720.540015-1-robert.marko@sartura.hr>
References: <20250813174720.540015-1-robert.marko@sartura.hr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

LAN969x uses the Atmel USART serial, so make it selectable for
ARCH_MICROCHIP to avoid needing to update depends in future if other
Microchip SoC-s use it as well.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 drivers/tty/serial/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 44427415a80d..724ad4f3cbee 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -128,7 +128,7 @@ config SERIAL_SB1250_DUART_CONSOLE
 config SERIAL_ATMEL
 	bool "AT91 on-chip serial port support"
 	depends on COMMON_CLK
-	depends on ARCH_AT91 || ARCH_LAN969X || COMPILE_TEST
+	depends on ARCH_MICROCHIP || COMPILE_TEST
 	select SERIAL_CORE
 	select SERIAL_MCTRL_GPIO if GPIOLIB
 	select MFD_AT91_USART
-- 
2.50.1


