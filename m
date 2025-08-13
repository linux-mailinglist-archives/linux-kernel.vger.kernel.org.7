Return-Path: <linux-kernel+bounces-767290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2D3EB25262
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 19:49:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD6C85A4A28
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 17:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67E9229ACC2;
	Wed, 13 Aug 2025 17:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="mNv1D5ob"
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5350528B3E7
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 17:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755107270; cv=none; b=hRDWh29qeeo+CDLe8AueBEJQoKq7ei0hqWbGXl8Sgi0k/qG42FkK8EZCu4fh0IGn73ReyN4wF96VigZ5GZeRPUvflpHVAfV9dc2Pyj8SnHokKVEQ1ASiYb0Xv8oITnmI3she5+fGkvR0loaCuNYYpeTlQNZvnIPDvfgbUjYqHr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755107270; c=relaxed/simple;
	bh=NjkCLYlKNtoy8P9olWmXk+TqDYwsdfQMHQyLM1GRmZo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GjRDxCrCqXAN7oZbWLq94AOZbfhRLVKKtSDsMRYQoQ4Mz4BupWz184KP0pGt6cNReD0m6FbZtD8FN4xcgBPRgjiKVCUqYgRKtsFzTZy9kNFJYncWSMz79zSYWuGZSqdcS94S0w83lcn1kh1WPyZFmGTlTpKACh8zE3D3VT3lSvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=mNv1D5ob; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7e8702fd3b2so8444085a.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 10:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1755107268; x=1755712068; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=89Z3Tvde06t5dQQQh9zIDgC5mMNPPytOaR1RQ792KEo=;
        b=mNv1D5obEG4SaFdPd9z4BvIddwABLZHkEmCbZ4IN6bo+cbYp5uHVe4+c5aYjeiYYo3
         3ir1V3M2Thdw2yOXoiol56knnhK8z3sTnqI9mLJKKHHx888cQhFq8OkHEpTW9iR8f9VQ
         fOQ5fLu/XqduHBxrqruun3UUkmVzBbWdedZZLo50fI3XTChwNcKhrLgX8/cjez7aWpb8
         c8SYkLQ3Xl470U3DPQOizAxK/6JjixekndsdsUHLdfpJzvnVXjwEOLCkYjdBqby1764F
         x+qN8zNzF5GHdVmAJQySlXwjXMM9Qv+DlhN64VxJcqqZj0GMdGvHQFeGsZtIDfiGwuvU
         YPeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755107268; x=1755712068;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=89Z3Tvde06t5dQQQh9zIDgC5mMNPPytOaR1RQ792KEo=;
        b=Je4XHmt2jRiByXbDwnHxFsG0vz67B6TDVrL1kVLLMewX86HAQXk1q0vRrZfifTU8rd
         c4H4jsttqbfYEkV7hlROI2C7S2C5+fzzNEOEw2iBjlrSz6fxC4Qw5h5JBiNUhus52mRo
         Tqu2t7/4kfgpV6s3t1F6nYxAO7Aa4CLNAH1anFDaJT6Wd/3BDZXJq3/C8eaHTOvAJBbm
         vLxVa+YRDyeg/Z3S2qNfcHDVx/qCd53vosaIstf6HXvo7sH3GabcTbXyhqsRgkfOCoyz
         0ZXpsDwWABresPMlKClOV0V0dT27kLEk2pj20p5+jxjGySlKI3KkaqP16S/WrO5YcyNP
         G2Vg==
X-Forwarded-Encrypted: i=1; AJvYcCX5uxskYHwKJmcrRo4Adw1FuiYm18Vg66ZA5OWhoYtb36VWJBcEwbKGZRz6wkyAzLvsJmtUVXKLmX7Notw=@vger.kernel.org
X-Gm-Message-State: AOJu0YynL62gZ/ldZUaPiKXlIPRPIvDBR2SkELd+58Du3aNSNOD9eRot
	9yYKv0EPnoRJBv4COGkC49Ckv11zOcvmwBFTP7gnCQc5qbCfDTRiQb9c6gF1zT2GQSA=
X-Gm-Gg: ASbGncuAuk44qlg1gsT92BjriuNV+Js5ed8g1NepCX0ZGxOOQVNtppzhSp4N0EKeGYQ
	rYedhtVSlvLVnCL5izET2gbZIPL+UbyUSn/NjxfjKeES3avExSk+xPYwook8oecBpTFtQ7RivWt
	YqajmhKVgZuNvB1ShyJyGALke3Xz6y0/791FZia6s7N5PMUBZtFmFTfb+Yq4EmI8v1FCtzQ25/r
	9q9s0tMwN3TVbfqirBPeF53OYedMV6d9FSQ7byC3MOY3/ry6kjaj0iLU4dZH6h4v6tBBgUpZzsU
	YUvWeYpqNuDo0LQ6zKS5lB9I/9cuMWeRASFH0lai02VZtYX92fBfmAJ03nDUyfmSGrs+zB1kKCT
	C76SwUQNuk8vu4j9aKzPJEfEeMPQYKo5ZfW3QRQ0gUQ==
X-Google-Smtp-Source: AGHT+IGsrPLNHuA2IU7WyavWdRjRrE/0nv7LFlmwkMJjixgV0JmRbdVoxVuLJtki1CHgdv8HoJD2vg==
X-Received: by 2002:a05:620a:470e:b0:7e8:66b9:f337 with SMTP id af79cd13be357-7e87031d036mr36261785a.26.1755107268237;
        Wed, 13 Aug 2025 10:47:48 -0700 (PDT)
Received: from fedora (d-zg2-251.globalnet.hr. [213.149.37.251])
        by smtp.googlemail.com with ESMTPSA id af79cd13be357-7e7fa87e7d0sm1627122385a.82.2025.08.13.10.47.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 10:47:47 -0700 (PDT)
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
Subject: [PATCH v9 4/9] mfd: at91-usart: Make it selectable for ARCH_MICROCHIP
Date: Wed, 13 Aug 2025 19:44:40 +0200
Message-ID: <20250813174720.540015-5-robert.marko@sartura.hr>
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

LAN969x uses the Atmel USART, so make it selectable for ARCH_MICROCHIP to
avoid needing to update depends in future if other Microchip SoC-s use it
as well.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 drivers/mfd/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 425c5fba6cb1..8f11b2df1470 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -138,7 +138,7 @@ config MFD_AAT2870_CORE
 config MFD_AT91_USART
 	tristate "AT91 USART Driver"
 	select MFD_CORE
-	depends on ARCH_AT91 || ARCH_LAN969X || COMPILE_TEST
+	depends on ARCH_MICROCHIP || COMPILE_TEST
 	help
 	  Select this to get support for AT91 USART IP. This is a wrapper
 	  over at91-usart-serial driver and usart-spi-driver. Only one function
-- 
2.50.1


