Return-Path: <linux-kernel+bounces-767288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF1F4B25280
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 19:51:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D65B16286AE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 17:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E1DE292B5D;
	Wed, 13 Aug 2025 17:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="fw7/ZPTF"
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BDE2284B37
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 17:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755107262; cv=none; b=AgeXOdv62jJqUxfJ6y/s5EphGkmVnvajCUwAkYPX53PaJ/DBjB0WSnAtUOi5rJMlhCFx0HK2ghBch7N3/if693kbsxOZnLa/QVnSjZ2r0yyiqEaDwwxz6cynNFE3gDvwtPWsTgWUbpnZ5Y9a/TYdjkmFHp6wfzmK9gzg8qWC9Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755107262; c=relaxed/simple;
	bh=RL3Rsz0aJlOWFxlh2UakRKpVFid+fQ5BHQzpFq6zABI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r04TUQSuM0zg0mKMF9gwS56tmF6fvfQobkMFVjSEpilcLEmdpOLWx5M+cUwPD4D98f34NRtUhcApqRSu2v1R7IyYFJKrg7sGmA4yRUV1rWdPGUQlNPi2MMS7GZ/QIizPl3V0ef5tzNlTBMszduVkAVb7aMHfcvoOR/F+dV9zMcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=fw7/ZPTF; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7e8704c52b3so7586285a.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 10:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1755107260; x=1755712060; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mtMzSO7UPmjR47X20+ZqBD1uhyLdG+1s/Zrtcgs7erg=;
        b=fw7/ZPTF6jxg1uaCEZj4Aq29AqS+wxQkqaLK6z57NRPX2Jkxw6qzH8icX8ROKctnTO
         YHRR50dsGuEO1nkXZhGbWBFX5XoDqZXabtWFi7m6eKgl6a43mz5J5yHsMPvA2sRUOU2S
         tXblc2C4heR+M9IKeVxDBaljPVUYF7x/NYNpNl3HSGQISa9Xd7rVTbbMuoiGZzkI06Wr
         TEf2I0eP2jZ9CiRgIp/hmYufKsv9v/HeWlfCW27vFuPD4objIAhvi3ZJJ+LZyQKgLusb
         P2GwwiX9qeu4ZjYZrwIDEnjNb0CTR12lJr9bA+kqTfY9YJNykzYZSSe+NZPf5CDU57k8
         ctRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755107260; x=1755712060;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mtMzSO7UPmjR47X20+ZqBD1uhyLdG+1s/Zrtcgs7erg=;
        b=HN6J7Y4HE4z4RuVnKfFuQumcSaZ+dHWkyG9V9P1nz3oaWsS4exqKpyNw7D0rjVJwCy
         aIjYu9OjSyaPODSLOyg8RHYrQG21NLOw9uIi5NjjwWkej2Ot5nrH811xg09kvoADZJH7
         KOk1Hv5STHsCGxVCoslG6wFkDQDunxuPqpmtHIgH0o7L2pb7/Xv7/lQOeFWIVRm9QxA0
         dbDGscFaM4/iCWmZQ7LAizwTxLB8L+1haerOqXoTHB0C3dDfZw7PcnoPhyYav1iQwqSl
         3iEZbgxKe5ymrZceSIw3skuiEMd5/MYK9ra7T3RMY/iHupnpNr19E58r4WoGEDugK70F
         Yo5A==
X-Forwarded-Encrypted: i=1; AJvYcCUqtico3d7IWCK0tqDHyxU5HxSp2LzStv6ntaiUGBWcorUFWBjIZFq/NybqKYTHDLNLL4CM1h9gaA34Hn4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZGKU+kKLku0a8YY2QZ7ruB09Ed1xgg6jNbzacvkdJRVwVe4JN
	0b7uO/dwqHJUAkKuxP6nSHBe7eyUv0D7qZXaA54M7xegeKyBqMMNey1cIv04gZvnd7c=
X-Gm-Gg: ASbGncssVNCscKhgwHvjROyP4gO6u1Rv1TyBE9hN6W9v5Htgk35MAOufALjzx39jf3P
	2hNHvmdr+7vA+JRsZelYYNS7HY0kpaYTGWOgMaEoVEU/oB3/fXDaiTu8d+KDETfAfP4DxUvXcne
	ZlOH53wxAIIT6q+l7yszWy/MfDJiTYB/fOgFdH2ROKdnHOxUObLNRECOi1z17sgaDfdmwfOhvw3
	vPwaeA1O9zdQKsm8pJ8RCDU+VL0X8AH1ZUFHXkkcWIiNlAlKxOEPi1k5ObNqL1kZGU0qgw5KIec
	EJmCDDocC0YOlWh8PvoCNeQzP0fpT+GleF8OEruPXW78U20h3DaZshzfnBLP+xVjps2SKQZm3Z9
	MuNydjXUk6Zj6Fcl97u8f53nLQ/OQq5Ehgid8FXE0ZfRKaatsPpBf
X-Google-Smtp-Source: AGHT+IEOA4KVOCs5eFfidLnPllBwbdP8If2rCIZC+fPOPK1dPvbgpwik/9+siLqevJw3jKgUeh5nYA==
X-Received: by 2002:a05:620a:bc3:b0:7e3:60cf:c037 with SMTP id af79cd13be357-7e870593e0amr23464085a.34.1755107260046;
        Wed, 13 Aug 2025 10:47:40 -0700 (PDT)
Received: from fedora (d-zg2-251.globalnet.hr. [213.149.37.251])
        by smtp.googlemail.com with ESMTPSA id af79cd13be357-7e7fa87e7d0sm1627122385a.82.2025.08.13.10.47.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 10:47:39 -0700 (PDT)
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
Subject: [PATCH v9 2/9] ARM: at91: select ARCH_MICROCHIP
Date: Wed, 13 Aug 2025 19:44:38 +0200
Message-ID: <20250813174720.540015-3-robert.marko@sartura.hr>
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
2.50.1


