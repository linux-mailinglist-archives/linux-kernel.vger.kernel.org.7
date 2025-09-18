Return-Path: <linux-kernel+bounces-767289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49145B25266
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 19:49:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0F3E1C27C3C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 17:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B8EB299A85;
	Wed, 13 Aug 2025 17:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="QZAmmWeL"
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2232C284B37
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 17:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755107267; cv=none; b=gm2S7UokTUO4vaLaHEE4r7xOsQDGmZmNjXks9q1dhtzdawKlzSSY+9m4JQkQVFmzPpAryakyLC61WJwyUs36OUNpo2MxNj8s4FXL1Q5kzvXLgcXK7VtRka6IJcnJX2NOTRAXuTWB8Sy/Fp00EQ6P2ayhXhux2Zw/X1OL+AJ412c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755107267; c=relaxed/simple;
	bh=gPMtN6w+Ex6/DTpmDnipaDUce4Mx3+FsbyqPZQrCYoI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XkMm4n3IbF49WxyKJ44F/W9O6k4ipGcIe+EeSv0pW8Sco6A+YY4QcIpkJ1dcsAgUGX9MbCOuNoI2h/E6+Kogh1Jcv+/2EPacycekUB+4oJ+heTJf8twzQ9Av7sXteWhprWqfBaUirhkJspzNYm/Mrq+NL/gzp33jyV9kceazJzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=QZAmmWeL; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7e870689dedso4240185a.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 10:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1755107264; x=1755712064; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BOqtWGRnguTuSIsC5EGTanl0XgtE1XRc/qnGhyYka2w=;
        b=QZAmmWeLRLMQhIuqHu/KvJDEJNjLk1Uhjp9KNU6Rv48HTqXR9Gi19PZdaAXnUSCUnd
         7nFtowisJIqJ/XLwX4ozYgLg/AS3OvJFFct8eTAPJIBvcy+kLgSwSKARMITt1GuRzOsE
         9gMEfS8p0PbnGIBvapoZMPO4IeDf2iDCvNs3zZ0G9FxVvIbL/EnE2JMCwMZhgcDqUNli
         VkepSqY5ARwJS9Ev9IbMI62wlC8Wd29ao7jcFAkulBHCA3cIoxRrDEwe8dAG72wh5KTX
         VpTkmOjUfXsoaYHn0xGWTVTe+k/HfAuyikK1SqdX0xgq0Ts/Ss/a3V0ikJpyzN6QTyMt
         W6iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755107264; x=1755712064;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BOqtWGRnguTuSIsC5EGTanl0XgtE1XRc/qnGhyYka2w=;
        b=O2NNqUuTFGjcajavg+bzfB1kx+g2PywB0eidpc9VBRH/rpF9m5tsgQjNj81KeEKzV/
         3ZdOqN2GBciKfk157eHqRkCU8ahN8p1/lQz7v7ekgCWgVrFMlieztsCaBOQ5pghPmUOs
         B/jI8k2MociomkVPzB58W3XFeJE1CJ4cZ8uTwXBuZcijdRFlDFu7nRdkknQO0ju4X2QF
         lymGVsuusUi4F5iczbkOG5er8eL17FeVhG8HI3aeVH1EWZA37lvNcWpCIdpk6NFrUcvI
         0Qdw+LP/JniY+Ufb2CeK14nJ4bhW98zBBCHecjw3DkUnIzpOzb7kG8LaBIHZ9grMK4oP
         BrIw==
X-Forwarded-Encrypted: i=1; AJvYcCUYUCyWTQ8CaoBpX5kDf0kmyR4FMnzVobRK/QclQZJfxF8/FW0hKVB3E3cQkFAaeVdzi+tDdD2Ecmceo1w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSfwj7da07nExk/1PQpd4+ZWbSXJqkL9IUfhcoV6UoaTYSdOBS
	7P5Uc8dVzEhLiGvU3yl3MgTmsya1Y09kyTXnmoBqDmAc1W/WmQ2a1WmLyqTiZUtSfDI=
X-Gm-Gg: ASbGnctnBghit2CA+oOqR82vH3weR/yWzWPBSMm4aEEUuvxH6PL7QxPHO80auXxBGon
	GbhKvwkoNtrxLrw3eoXMPutzCVvfEQg423c7TDLo5jlELmENu/+gQeWcYgeGZMlCUXxtEodZJBH
	PXdV99S326aRNHgFjzN20Cjt1ws5Zgxdwx0JQPct60AFfpvjqbzYYP7YOqXVH0PWZNMKaJCluzj
	RMOuYdtfhW7lsrtLXH4nnTJYpg+Cq2fHLvACL0SOjTbBGE/cfPSr6KIlEMhjf2aGoQbUxlKDfOE
	NlfwXe2ytWysJ0+UVxIQn0jC1ua+0ks1yOM3YrvSTKV7qrOU9fNnKNx2ZNrYca1OXCRM/BOB5w8
	zAiMut+snkUubIK4zwwF3LYvIeFfG8kqYwGUWu2nQaQ==
X-Google-Smtp-Source: AGHT+IHM8gqvwU0dp99AsCx2aJSW6E+YiETEDgm//P8elY9qJZZswfVzec82j6i0ynh7rzsSjnHxBQ==
X-Received: by 2002:a05:620a:31a:b0:7e8:20cc:64a2 with SMTP id af79cd13be357-7e87035636bmr30883285a.26.1755107264026;
        Wed, 13 Aug 2025 10:47:44 -0700 (PDT)
Received: from fedora (d-zg2-251.globalnet.hr. [213.149.37.251])
        by smtp.googlemail.com with ESMTPSA id af79cd13be357-7e7fa87e7d0sm1627122385a.82.2025.08.13.10.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 10:47:43 -0700 (PDT)
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
Subject: [PATCH v9 3/9] arm64: lan969x: Add support for Microchip LAN969x SoC
Date: Wed, 13 Aug 2025 19:44:39 +0200
Message-ID: <20250813174720.540015-4-robert.marko@sartura.hr>
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

This adds support for the Microchip LAN969x ARMv8-based SoC switch family.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
Changes in v9:
* Select ARCH_MICROCHIP when ARCH_LAN969X is selected as its now hidden

Changes in v8:
* Place LAN969x under ARCH_MICROCHIP as suggested by Arnd and drop review
tags due to this

 arch/arm64/Kconfig.platforms | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index bfea380100a6..31bddd1a17de 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -177,6 +177,21 @@ menu "Microchip SoC support"
 config ARCH_MICROCHIP
 	bool
 
+config ARCH_LAN969X
+	bool "Microchip LAN969X SoC family"
+	select PINCTRL
+	select DW_APB_TIMER_OF
+	select ARCH_MICROCHIP
+	help
+	  This enables support for the Microchip LAN969X ARMv8-based
+	  SoC family of TSN-capable gigabit switches.
+
+	  The LAN969X Ethernet switch family provides a rich set of
+	  switching features such as advanced TCAM-based VLAN and QoS
+	  processing enabling delivery of differentiated services, and
+	  security through TCAM-based frame processing using versatile
+	  content aware processor (VCAP).
+
 config ARCH_SPARX5
 	bool "Microchip Sparx5 SoC family"
 	select PINCTRL
-- 
2.50.1


