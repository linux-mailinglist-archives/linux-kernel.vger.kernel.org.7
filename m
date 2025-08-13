Return-Path: <linux-kernel+bounces-767293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C16E0B25275
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 19:51:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A1CC1C25FAE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 17:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB4C22BCF41;
	Wed, 13 Aug 2025 17:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="wIPtCnnk"
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD06A29BD93
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 17:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755107284; cv=none; b=NmqwR7SGXtxWffZ2ppk1yLz3BS5bDHkR9aKDOugJXD6Hgxnp4Rq6Ak3fk6NMbSguiq04h9HERI3ED74PjTiEt9OT3q99cul0QvtVhA4kjioKKyr+8DgsaCoY1LyGHe6PFPpWB47tX1rWSALdmB8wwruxfDueQa941NCd6LDVR1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755107284; c=relaxed/simple;
	bh=ONd4Qs9MdmtR2emzr2R9EQwalmRVkxN82kEJbRPVoKc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EhzbNmf1twhkBK7q0NaXZVgXXpVT/l4OecEP5mm7HiGT0xBW2olAL5j9Sq6K3heDGZyoxPg7ajtq5JMOE5D21LJgP7FcQIXXGYm71FeIzg9rzW297hXLXVP11teW3LlHrei7U+WtgaQ9IibSrJf9C/3FJFnekDTMzhXyoV0MALU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=wIPtCnnk; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7e8704cdc76so7747485a.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 10:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1755107282; x=1755712082; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bLNf+0ZsNl67A+boQNElFMCPPvbgNyj3cPEZ0b5ZYx0=;
        b=wIPtCnnkEUUmR+VH+sDQDBPd2/gUB5zJXi75S8PzgOvuWnwtG2GU6iomw2SQODirai
         F90NC2HeSghm0IshjSOciSWFsevdb4SCrDOSPfifAEqwuuC8urWkvok0PG7x8EGrUdQn
         3PjnS8DpTdi3ZLc2ltk2WWSkPWchyYSNSWWX+BHiiAI6+jV3Hk5DRhkT/DItSkSp2fQp
         D4NtCVKyAUUO5TM0lRXMxA3/3qszjaRf0wDTpUrcMMAOF/w4M4FWtDdlPFH0bHlsGaav
         VzwrPMnXuA5mabYi4BvT+viDDwm4L13qVZ+163ehBCDSI3vcdawPAEVmSPpwD6kW2CPa
         Y1HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755107282; x=1755712082;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bLNf+0ZsNl67A+boQNElFMCPPvbgNyj3cPEZ0b5ZYx0=;
        b=AGe/xjzUUpYMNUaxYxxYUaqj7KACecVD68DciYfME5T7NGDCMZSSCbOn65JqTu49Qk
         UXp1hgHOo5SAGvv5fTB2Adj+iFRkgLdYht7EXnUaPICEuDkxZL2KQ7iW25S27fapV2BY
         2t3uFIV2/3dwSmMYSpxnsh/VacHzQ93fEZ/hrmuNt+gmdu1mOGSikrFtyhwr4JD6fT6z
         bMQnsESfStFX3pDAxMvMrBrvQ7y5xj7y0RyBiG/CHfqVIclBqFW7TCxn4dhkLHSmvMWA
         aULSe8z3JWPfUxbyWAwFS5G3RKqMfxFz2GJ/MzTZ1gT+/TcJd0NeF4xZ0yPJfSeSaVY0
         12dw==
X-Forwarded-Encrypted: i=1; AJvYcCX+G4MYNYjnR4+bNxej57DWr86TNv07Tsz3zDHuTz8a8ERSIsOz64QoIculoN+JfA831RHgr6uzoFVPkso=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzYtTqugYD++AmpA2fyBwPeYo7Ae/YHDu6G8fD+jHpDQ8tsMnS
	nxI/vA+kU/dTcm89FBEXZoUEh8T84Hg06p0L7TQOZe1jUQWyrWYyIgPiJysYb20Q2I8=
X-Gm-Gg: ASbGnctabYbrAgLAQDpFbzBEaVNSq6h/I8zl9dQlN4uDI52TeTarP2oIVjeV+EbiZud
	KiIMDnNhcdn+fspdCcYw2UdEtXSe0NdXBIHIJ8xgtOIRHQaPXE2J/2vVMIFWGF59K6vDT7/M3g8
	D4WkbqsB8NrOnj1KSoTLZKQlK10dQIwHij84x3i5Yn6KiU/vT2ZNHilKYFATiuawSvLheBdwa2l
	9K4FIzUI67Y0FDtSTrm1Fkr9Z7GQV3PykxokgLTfmHgPorx+USKDZpFmaLvR8tAqoi5wYAOnq4x
	rFgtV+TE/PeK9yNZjq4oVpGuOKng7id9ri91gsyz2D0bsYYExAiKHDvoxW19WHIIzvOSKi2ltfo
	294/nM6FL3KDLvNNqf47wtgQOwAZUY6kYECUUOfjmZw==
X-Google-Smtp-Source: AGHT+IG/snJ5W/RG0E/erOkIvUu/WH4PIM7qXx4xAitymXiD3NRL3HZn1ijMkWxa/MDJZoHs07TE8A==
X-Received: by 2002:a05:620a:270b:b0:7e6:9a4f:a299 with SMTP id af79cd13be357-7e87041fe25mr33631785a.16.1755107280240;
        Wed, 13 Aug 2025 10:48:00 -0700 (PDT)
Received: from fedora (d-zg2-251.globalnet.hr. [213.149.37.251])
        by smtp.googlemail.com with ESMTPSA id af79cd13be357-7e7fa87e7d0sm1627122385a.82.2025.08.13.10.47.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 10:47:59 -0700 (PDT)
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
Subject: [PATCH v9 7/9] i2c: at91: make it selectable for ARCH_MICROCHIP
Date: Wed, 13 Aug 2025 19:44:43 +0200
Message-ID: <20250813174720.540015-8-robert.marko@sartura.hr>
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

LAN969x uses the Atmel TWI I2C, so make it selectable for ARCH_MICROCHIP to
avoid needing to update depends in future if other Microchip SoC-s use it
as well.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
Changes in v8:
* Use ARCH_MICROCHIP for depends as its now selected by both ARM and ARM64
Microchip SoC-s

 drivers/i2c/busses/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 070d014fdc5d..c0aea0920f61 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -414,7 +414,7 @@ config I2C_ASPEED
 
 config I2C_AT91
 	tristate "Atmel AT91 I2C Two-Wire interface (TWI)"
-	depends on ARCH_AT91 || COMPILE_TEST
+	depends on ARCH_MICROCHIP || COMPILE_TEST
 	help
 	  This supports the use of the I2C interface on Atmel AT91
 	  processors.
-- 
2.50.1


