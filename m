Return-Path: <linux-kernel+bounces-767295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F03AEB25268
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 19:49:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52F537A9E2E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 17:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 983272BE7BC;
	Wed, 13 Aug 2025 17:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="uCEjxzL9"
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA2E2BDC31
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 17:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755107292; cv=none; b=BVAP5XC8RtRPeXtKjdOA3Fh9zM7vo34tkgJbEaTifPmkrGq+pcYDGwK2zm2NUrYg/9418XjQe7WvFpDW1ZvnKQXqKCi8+ZMtTNnVdbvz7rFfG+7Z/fRt2y86o1WzhnM/MTBr3ker4DafFAEwDw39bI/svKnwy5uF69envjTvUr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755107292; c=relaxed/simple;
	bh=wVsDz7PLWcqLuNDyAizM/2yV2YynzKGFnsWWEvqGeqg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jtdvFnx2+++5DVUTgFAn1AdgtOffoV3Q1/z8uqE5A+AH/uOX82OgufsaqcOzWx1/KjxdcQgUmNUA5sTtBMiBrGzErifMDhwdmgJ9daPZDTBXAXTrtd9eYPS5nqCOa0EFS6wZNHdmxO6AFznStbMy1guN0qZi+3YHjKh3vMakdGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=uCEjxzL9; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7e87061d120so6278085a.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 10:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1755107288; x=1755712088; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NR9O5hej1zVdBrSrvTEY2n8cN8r/rUR8l5graqaiob8=;
        b=uCEjxzL9d6OxCyOhmQi3vdf6Zth+dnpTgzkFmF62rxI5lmbr9a7I3BT+Aqjv0s6LUV
         U9DBnlwEVGCAp/MeK/dxdFk1den0Y1v99dvqjj1SN+h1nI7sWIoVXEVfUNysmXYHEEiK
         fNLCmV5VNMAeiuRdQwa41npfs5rCwwEgsK5qqWlA30Kz4rvpyVWvqUgeNELha7yacjbq
         L2I/M3nup5RK+UmDwy5nsMUiczXNqhWxVz/yBQE2AySs8JD0jsnD1lMR24wMQDsdyedN
         pazjC5kLX5m1eILw5+jAU3+e+g6pW+2vy3F3PMPrZ+gaznpdDOQAyEdU3pLTcvYy4NcM
         5nPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755107288; x=1755712088;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NR9O5hej1zVdBrSrvTEY2n8cN8r/rUR8l5graqaiob8=;
        b=JYjr/qxQvPpkRmZ6d//E9EGLsUOykm4j3Jmef3BCF4zfINYrqZ2fDFbrYsRaiQYUzI
         y56Lw0CHR7WQ/c/3bJKxO1Jk9/30v5xoBAZ39Stt5jxOOll0TUy2e2z9Ls1knYf4hp2R
         UW7cFbEE1layMpA5w/U1l7uyKIB7ApHSW//x6Mt4bKF6O8iafpYhax1XENGwffEocbn4
         0jkTujTfQHiBL5uSZPDbhHVU3kxNcH25qJAttZRl691vEVq6t2BZrnWeCqV/x22HXiib
         c0d/rqLVpicOReXTssb+F0cBjbgP853vYY9w39xu1Sve2q24VBPgqSXGJPt4sp9DuTAI
         1Z8g==
X-Forwarded-Encrypted: i=1; AJvYcCVurw7yR5b3BuII/bUHPytXCrgyvfcDFJAgEYiQIYwQwUxxit9yDRi0+mDN+SWN1cp+2RP05OLYkIWh4Fk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdYmRUz5q25Sn8ryvdBrgJXm8Cacy2pRo3vttRQevL3bukft9R
	AhU2PcxWl0KbXcnqnLmkHFrmO2NRUwXgCMbts5uMT7Ne9FBHYJpHbKefigh3x4I+u+AL1GJaU9N
	SOLn0vOs=
X-Gm-Gg: ASbGnctt2ISMKV9Y8t7RSix/Zoh9MXn8w3N0dR8zkf0KOE1Cs+1C759YJz6MyGKLd8U
	dTQ2ATpcFCL0duIWzyOzt1hZ4ohpZCocKNTFXNs/yT8/m2uE+3MrSiEsKr6RM8OYfZOUg9QJPJE
	fjI1aXoxopHPdB7As/nqEStfSnCtai2wnngNl+Ud7vap0SR6LiYEP6aV5OG4bn1lVsFiEYkZCRC
	JbE28j/qhf8w+MDxCzIsVCpLKMWVYc5ANn81V560vn9WYAs3aIcy2FETQO+yjMOKOxkcjn+nsdz
	0r+28XquPvUT03KU5ztMBEmOklzVZjMAmGxwaQiA6jqNUD8pepsFWbvrvX56aPWy5lcYaKOMSbo
	+LiCCxQkACZOsciBlpnA/JBtNp43vS4SOnl9yzywBnA==
X-Google-Smtp-Source: AGHT+IFRs83sDqTRyEN7DfReHLOYn68Vpzc0LCiQZFoDgh8bJ2M9bgboNPmgbUyMB+oLX7FeYNZzXA==
X-Received: by 2002:a05:620a:1724:b0:7e7:12c1:8f93 with SMTP id af79cd13be357-7e870600b91mr33016285a.63.1755107288221;
        Wed, 13 Aug 2025 10:48:08 -0700 (PDT)
Received: from fedora (d-zg2-251.globalnet.hr. [213.149.37.251])
        by smtp.googlemail.com with ESMTPSA id af79cd13be357-7e7fa87e7d0sm1627122385a.82.2025.08.13.10.48.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 10:48:07 -0700 (PDT)
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
Subject: [PATCH v9 9/9] crypto: atmel-aes: make it selectable for ARCH_MICROCHIP
Date: Wed, 13 Aug 2025 19:44:45 +0200
Message-ID: <20250813174720.540015-10-robert.marko@sartura.hr>
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

LAN969x uses the Atmel crypto, so make it selectable for ARCH_MICROCHIP to
avoid needing to update depends in future if other Microchip SoC-s use it
as well.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
Changes in v8:
* Use ARCH_MICROCHIP for depends as its now selected by both ARM and ARM64
Microchip SoC-s

 drivers/crypto/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/Kconfig b/drivers/crypto/Kconfig
index 04b4c43b6bae..7c1717c35b76 100644
--- a/drivers/crypto/Kconfig
+++ b/drivers/crypto/Kconfig
@@ -439,7 +439,7 @@ config CRYPTO_DEV_ATMEL_AUTHENC
 
 config CRYPTO_DEV_ATMEL_AES
 	tristate "Support for Atmel AES hw accelerator"
-	depends on ARCH_AT91 || COMPILE_TEST
+	depends on ARCH_MICROCHIP || COMPILE_TEST
 	select CRYPTO_AES
 	select CRYPTO_AEAD
 	select CRYPTO_SKCIPHER
-- 
2.50.1


