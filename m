Return-Path: <linux-kernel+bounces-714003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F9A0AF617F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jul 2025 20:40:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7B111C2820F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jul 2025 18:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3AB52F4321;
	Wed,  2 Jul 2025 18:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="GhLtnOfv"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C224931550C
	for <linux-kernel@vger.kernel.org>; Wed,  2 Jul 2025 18:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751481568; cv=none; b=R8CoiU5BZYzwWnAvW2kU9whaGxLbP+l1BRMuY+8JRUBXxABtwy39cG1OuLuVWdN21Hd4lvcdx5dk+qnAkUBlUKoWgsNDfdenuop7xLHu8/qNRccaxD7q/kxmJZp1/bIfJFiFNlH/B9ck65iLkW1l5MWHnpCwCHSSm8ZqOmKZz8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751481568; c=relaxed/simple;
	bh=pWc/eD8EhDRsDdlnhyulEE6WLssNw7EFTkXiniULJX0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n9nbSBFCGBaVxgC3beHUTtH5YgJQWH1cDqOxqxK4VhmlESKHb5Hx8rcCgpgqkrIPGJBTezO0qsqtZp156sZRV9LKnTOFBJ/9JxvSqX8cikAL206uTEmox9HIGiCgQuIx26f7aJODPyb0D5dmpEriTLnCfmg0fyAX7W4zaQFk+Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=GhLtnOfv; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-235f9e87f78so49254285ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jul 2025 11:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1751481566; x=1752086366; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NZyb0UMcbDIGOtSibbw+mdySBJCf7k9AVSTNZQQyRng=;
        b=GhLtnOfvNZLfbHR5QS+Vwm1vvaC+govuXOeE92Xd2wE32ADB1kD1rvcM662lwzHbC8
         Y76IljoRQYOoGp1vtFSBR5saKfQFJZuQ0t/YLBgGKGrlHdGWT8Ex1JTdIweJfXHDBLXu
         ntK7ktCyGWjYmkleXtsGQvvL5E06SOD8dw171T0JkWKzievyYLwRYKT4zr8M+Wdx7uiz
         wuv4Yi45xw8tlpHPoIOoi1raEyfn1rnVqymHt6caR3F4uH2h3o7iQLCxqgx6XqI4Qi5F
         S92xP1MEA884K2SySSyPsb3mvKWo2Jo/WgFG7NO+8VajzDCjzqCwDWJorr7ePoCIh1iC
         M6sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751481566; x=1752086366;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NZyb0UMcbDIGOtSibbw+mdySBJCf7k9AVSTNZQQyRng=;
        b=FepmdiihET5M4wdolPtM8FPDWi5cXxN5jEIdBdT5DGH5F2bffrAsYbIrnCjCX5GZpk
         P7h4O3trv6TdCWadAsmxVxgVaxWgbya7HJdY4UhYa/6d2yNkeFpmF5ozI6z1L4eFqD8C
         tphfK3SttN4XIyb2XhWRuJwRVILbbd7Dbo1JQ/bvDN1EKSuU8Zx4CI1D9i03KuXm+SeB
         2waWPvgMNKonXTEwY85anMn7UatasZ95wYq6mB+VYffKImlhK1MOeRQ0QKcQEWc6eTsk
         hx6LBULpRybFPLDdtje2rzzgftQdMb9re9OZPZ2WXgNE2h2229cUeJhI7RudRmJx1zKX
         Sn3A==
X-Forwarded-Encrypted: i=1; AJvYcCW6T0NcNwIdtcMMaHWoy6fOL9KtKppnPTI/5LO8W6QK0gF3/e6my1XQWCg978/aQ0q38ukN1IKY7w10uLw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjYQXXvyz7bM7Ho+uG/8BS5boceu7X7X7kE6xqvMk5A6pd3DHx
	Q0DLkEb+zj8BrcvULX+L59rdLDXwHCn4hai6m6wpHfyENslNozbTILJtCtbqBaX+0FQ=
X-Gm-Gg: ASbGncsk7/2xlaWba5RHxrYql+pyWs0XYNyZCLa6S9Md4MBmxkqbfHEw8PW9Jx6BilN
	fyydYTE8pbFeh7BNqn844a6qGQInEP8+ZhsnDjC9jdZMoeXr/yt/Ym39X0ZVFHFSXXXZ2g8MjEI
	Pye6d7BbjUsaDUeGlUpx8uMISHo4gG5ezHC6UbN2Lhpb+Ysazg4hP29EoSeIQhC3K5rpGUzWCHc
	TFaduPIfx0CzUfzhCbzbzjT1Lj+a83k2WWlRY4/T55BjYUBKs/ZICAR+EMC/N6ahQTFzXdArEe2
	UdipuTXVOXACL5JBIUq/nJU30ij2BbShLQeOeIG80/UwUJKFVhn8NBXAp1/b3dHUDoNOb5jHgJV
	tSkYD8uOJyvheIjLur+vnj1Q=
X-Google-Smtp-Source: AGHT+IHRiK65iyeejNhxV2BsQ0zei81m23wsBqj5xXwWoUN5V5PxEC+r38Kfp0CXgbxe6/9g9H5UFg==
X-Received: by 2002:a17:903:46cf:b0:235:eefe:68f4 with SMTP id d9443c01a7336-23c79692071mr5155225ad.29.1751481565983;
        Wed, 02 Jul 2025 11:39:25 -0700 (PDT)
Received: from fedora (cpe-94-253-164-144.zg.cable.xnet.hr. [94.253.164.144])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-23acb2f39bdsm143034195ad.80.2025.07.02.11.39.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 11:39:25 -0700 (PDT)
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
	vkoul@kernel.org,
	andi.shyti@kernel.org,
	lee@kernel.org,
	broonie@kernel.org,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	arnd@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	dmaengine@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-spi@vger.kernel.org,
	linux-serial@vger.kernel.org,
	o.rempel@pengutronix.de,
	daniel.machon@microchip.com
Cc: luka.perkov@sartura.hr,
	Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH v8 02/10] ARM: at91: select ARCH_MICROCHIP
Date: Wed,  2 Jul 2025 20:36:00 +0200
Message-ID: <20250702183856.1727275-3-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250702183856.1727275-1-robert.marko@sartura.hr>
References: <20250702183856.1727275-1-robert.marko@sartura.hr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Like with the ARM64 Microchip platforms, lets add a generic ARCH_MICROCHIP
symbol and select it so that drivers that are reused for multiple product
generation or lines, can just depend on it instead of adding each SoC
symbol as their dependencies.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 arch/arm/mach-at91/Kconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
index 04bd91c72521..c5ef27e3cd8f 100644
--- a/arch/arm/mach-at91/Kconfig
+++ b/arch/arm/mach-at91/Kconfig
@@ -1,4 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
+config ARCH_MICROCHIP
+	bool
+
 menuconfig ARCH_AT91
 	bool "AT91/Microchip SoCs"
 	depends on (CPU_LITTLE_ENDIAN && (ARCH_MULTI_V4T || ARCH_MULTI_V5)) || \
@@ -8,6 +11,7 @@ menuconfig ARCH_AT91
 	select GPIOLIB
 	select PINCTRL
 	select SOC_BUS
+	select ARCH_MICROCHIP
 
 if ARCH_AT91
 config SOC_SAMV7
-- 
2.50.0


