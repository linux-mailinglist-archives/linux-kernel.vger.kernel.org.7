Return-Path: <linux-kernel+bounces-767292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A7C7B25272
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 19:50:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAE291C25E5A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 17:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E60B29B8F0;
	Wed, 13 Aug 2025 17:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="YbS57CMR"
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E4C29BD93
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 17:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755107279; cv=none; b=ExF8UhAJFW4Mfv0AtU3wdprczJ9FYY705NwYZIx2pX3ZRRYop3bx/a/kvlY0/mILuPf2Zcch+8ZrKwDlwZsId6QW9hcc+KIbmEz97mw6+72IzPgQ2uiKFejSi97A8mRqO9ypIMckdyZ0EOhAEttZ1yp0v0mlnI/JMfM1wZJsMgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755107279; c=relaxed/simple;
	bh=QybKy29Ct2YiEDYuui7hJlz/0jLfGcDQxytYrS02m+c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u6HzJy+gqn2QYV1rbHWUqK9L1d4S8hrN0aog2ieqTzy/FydHFqZRxaufzGeG8huyv/AhE6HHtOBCRqjLI/w+BiJkrwz9deaXdC4EXczNd3tAX8kfDLvTZCdCb1ktqZFTNbROq3C3DnrcIemDP/XAJftw2JakM9jNRp1L4m8D0H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=YbS57CMR; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7e8706491ecso8029985a.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 10:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1755107276; x=1755712076; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aikCCzA4JV8uW58QUohJldBg0J+53SfENsyjedVm5m4=;
        b=YbS57CMR18b+LaQ/349rUeuLORIqWyYCBiNaUxmyPAe2kJmv74oEyzD7eUQ8gcpGlU
         nkKDAxdLMCURsZ2G10y4R2bSRHGUv1u+7j2x3bmKx13scTNjmEk9aH2KP8EL/UVOsPrF
         OMhUqGSpbctUVkMvHULzpLvLNnZZxw5KlSQTFga1y7V8d47iI+ZwjR2YoLqds5HBpv7/
         KH+9ggyq8YKwZn0yz8cH4yfSYw5KCLpQCiNdHkfnYVvxswBoXGKXkFDC3vb7/R1h6wct
         7nQJAi0Ll6O4pcBmcYv4oJbb7hn65hq2THBB0JUABzbX2XZ6bq0SsxoGGYsKJ2x6pTxe
         PKIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755107276; x=1755712076;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aikCCzA4JV8uW58QUohJldBg0J+53SfENsyjedVm5m4=;
        b=DVmeb9HI5uZM5uH6lnzD6K/FBdhOnluXURXSOxNJqI5CKd7x5eTpf085Nm6dkeIDDd
         3nqjPHXGzLl+VIkYpIPEQuG+A46wTkCnynrvYcB5UQBITPjDXLdLe/IKZrr5u9NwN3Ch
         c/X1aT//tW5hKIr4t7QvWB8Jc7ZzPf/7lvWK46jnmc9fmZKq7ysVN7lzU35Vg8z1gKn4
         2L/1WSb4uPL8ObSVNOgYJw5KbFm5nEyCTcRLtjDwCRVsRCcwFRXr+9YVPEmq341trRqC
         77Cbpn5nKEES22EGyIqbCsDfMt/ktyb8Z5usxV/oPlkmdvuh0HHZuRJhynrZ4qydjJMh
         puQg==
X-Forwarded-Encrypted: i=1; AJvYcCWesJrlTWEFD3GnjdCpHGf3R4zni2gkcneq7AFtK2FxodqbMg4mJrIdYJ7avrV58sqSKRHPgLegYVe7C7E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfPkPILIq5dxVqDJxzBCo/yhtb/3dfxfGAqYcFQJ3pzAFLXzWD
	grX3iWGAh6WbySPaBuotkmFGlavn7jWJRbpMe8s5CJJo207AIgZQvZf4svTiAHEcyGo=
X-Gm-Gg: ASbGncubC27744zsdxxEAfofwIajePHHvFu6o/Z3QwZ0k3WlV4K9bOnuRui7/nUyFKA
	j+/K6uVT5x9xPtqZc3mTxEM2iplGVOjUtqHd24/QjyorxF3hJj1/RAn8AGF9KdOIGYVYFejws0O
	kyGb18lmT6692PDSMw4LzMyXjI16SczD2OvY0u+dsDMRgwoR7Z+G8gmBWoy5elmbcrrsU2PS0Ap
	FXcnMsN1ovb/c53lKy+QhKxMR9gstyeoSjgBOY8VpwlDJmEdXs5Hggdn/Jo/DWxemoNJB2PVDOe
	Q6diuK2ZVDDc6pR1J8tUstZJecTdFGgWaNHti0QI9fPdFTqcq3VSQIaAjWEj9h++Yh1WIX9f4qP
	+RpxoEl4YRlIuwWwnmybihFuA7rrpKjGRKFIA84A+URBYG7GA9sPa
X-Google-Smtp-Source: AGHT+IEg3SSFyFBuMzj7VtB0BXbM4b6FpFJkYNn6QJWw/Ig9p6dazfZbmEC4UpkoJX3lIwDtCnuVhw==
X-Received: by 2002:a05:620a:201d:b0:7e8:6a84:e82e with SMTP id af79cd13be357-7e8705753c2mr21068085a.32.1755107276240;
        Wed, 13 Aug 2025 10:47:56 -0700 (PDT)
Received: from fedora (d-zg2-251.globalnet.hr. [213.149.37.251])
        by smtp.googlemail.com with ESMTPSA id af79cd13be357-7e7fa87e7d0sm1627122385a.82.2025.08.13.10.47.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 10:47:55 -0700 (PDT)
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
Subject: [PATCH v9 6/9] spi: atmel: make it selectable for ARCH_MICROCHIP
Date: Wed, 13 Aug 2025 19:44:42 +0200
Message-ID: <20250813174720.540015-7-robert.marko@sartura.hr>
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

LAN969x uses the Atmel SPI, so make it selectable for ARCH_MICROCHIP to
avoid needing to update depends in future if other Microchip SoC-s use it
as well.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
Changes in v8:
* Use ARCH_MICROCHIP for depends as its now selected by both ARM and ARM64
Microchip SoC-s

 drivers/spi/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 891729c9c564..320b23e92cbd 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -154,7 +154,7 @@ config SPI_ASPEED_SMC
 
 config SPI_ATMEL
 	tristate "Atmel SPI Controller"
-	depends on ARCH_AT91 || COMPILE_TEST
+	depends on ARCH_MICROCHIP || COMPILE_TEST
 	depends on OF
 	help
 	  This selects a driver for the Atmel SPI Controller, present on
-- 
2.50.1


