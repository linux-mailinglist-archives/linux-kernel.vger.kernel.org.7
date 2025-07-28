Return-Path: <linux-kernel+bounces-747487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 367FBB1346B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 07:57:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C747318975FC
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 05:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48708229B2A;
	Mon, 28 Jul 2025 05:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OWDqo3vo"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD1B81ACA;
	Mon, 28 Jul 2025 05:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753682189; cv=none; b=L1ll63qg1mM3eGy74Sb23/cbC/7V215iu4rQdhNrlFuk+Jxa3FLHoFAhfxg/uDCoy4JbA1IDmN92s5GgW0DfLwe14jhVSWN0tKxnd+OqPPEpVWFB6ga9yJXXt9eNzPUg0n/fAOUm4OUIlUy4HoJAS6fM709lN/xv2Mi6RJNLk8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753682189; c=relaxed/simple;
	bh=Oi+irW8yhOKSNPXhRyvE6x1nV60h49NHzhkfU1wwPcg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I8R/ZVuL52urYr52/wBO4jUstZoZch0ysZQsB8I22UgwCPrtLUx+elh5ZlxF9RHvrPvdp1olj6FBYhmDpHEaZMoTeLm0EdVJSi8dU0M/+HPogLhz/gPnFvBlTmQ1K4t0JZR+L5w/Qz/scmPkjh4QX2HySbNXIT2ENV1LdqfyDCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OWDqo3vo; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-23636167b30so36423725ad.1;
        Sun, 27 Jul 2025 22:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753682187; x=1754286987; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ao8eoPOSjBo1pqHWYqmxG6F29BfmtszTrihrIa5aqow=;
        b=OWDqo3vobFFl3IMAmfCXwLO4KDjhtMG5j1n86w45W8a1oAYfaA2k9EOTUHboKIqseE
         C2zoj4bV9eu/mDWMYn9gp/VJQ9cxyq4x5HqN3XyWklfZn1/Tvy4nor0K5yy+3aQfiwbT
         SFgT25O5d/n6rwuzZHoxXH2iSL2D1uMUFLXNyCnHLHZb4c3QFcOtA4i9ReKzMTKWe++m
         PmvLxR45CadZz3Y5IMI/oOA9eN5QbGgP0/S6qUdkrtzGt6CkYgLxLyPL9SIcM8Dan1NP
         xi8Ju7lkYxbQIjgPhgXF8jQPCEOrtdi1d/BhQXK4fHXftSHDkzd+pd9l4Jr6X8p+f+nz
         uzpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753682187; x=1754286987;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ao8eoPOSjBo1pqHWYqmxG6F29BfmtszTrihrIa5aqow=;
        b=cxMrhYQuFb7IzHjhgCilGsvR0z/OvSt0WkdKu6SIbJQp8I/GL3wC1Vz9x2OWxRLaHG
         ZlJyVVt/3wWWYoy0ZnuLQVdAVvf6LsWzg1ksWL97sMUhRgCt+6s01Oi1YaqMAad2uRbR
         ZihsiWFT6A3TKw9xe1L/yKhFHTEg6SQ+mN6+tDwRTiE4oyhGZ0Mncx0CTtq/d5I9yclE
         023EhvCjrWkQZjhZTtc/dZl1gPTTKAqeZvlu2vds7Pi44TWu/DkWvJJ8nNRPtbxOqL/k
         PmobIhxHIXc9iNd9oW9lvw2Q27p4w7E/VR95H8tL66YVKqCqx+/t1nbTXf3csbbr0ToG
         NhvQ==
X-Forwarded-Encrypted: i=1; AJvYcCWdJTJ1JU2fj7AvLrR+gvp24Wt+FUPeyYnbCVQYt+qHpL+RsYiOCKbIMzbWDQ/lvjirzBX++5vekSso@vger.kernel.org, AJvYcCWlQSqwTGk7jPMvuIQ3aNV9P6VxBxZdYg+uXINbCSn8KChsC9q9jC6PgBN6d1jWoIX2AlNOtW/t+JP3XjhG@vger.kernel.org
X-Gm-Message-State: AOJu0YwnsKTDysW7DaPMicCADYd+6fYj7WWBajncZr0xYWtcir43FzPL
	MLbv4QAXcrgEE3UXTTgGKd+ej9enFDpThAm+VvxK/Csdxcgii613+ig2
X-Gm-Gg: ASbGncu3HOYLrWo+lApz66beUr4cJEzNi7IbdVdTb/d50Dd+pEV5ygaGIvP4NoQK9ZC
	/r7fXahpvLgDyn8LMil2PyYqkUHC2TpSUyGwAi/XN2ymcgzrLiF4gWCU2G/JMEIbfiLAA9wO0+N
	e7FMT6WI5VggfC6+m9PlxmLuCFvIfPYCEvPeYBGLpiIroMp+EzWy2tklwOopSs4pz36QHWC9tFp
	gFnLrbmsz2yBM64NcncaIhkDD2LVpnJ9N4mEELZjj6xvQJ38biljiwlvZs3JH9PzZUmLLwA6sAQ
	x7ildV2+dZcMn2epIQRAfb0mptIASuYPwYIcowQ5UtCVbNWnx2jorSGjAVcDqOMlWTiF5rYfJII
	VD73KyYjFFRwOXnBD3zpLASguxR4eMcWhlZFOBmOhoMW6Hrmcd6bUGcOEx+3I2cH1Z/XKxN2Tyf
	w=
X-Google-Smtp-Source: AGHT+IHaS05eV6o8vv06se/fDbSOemG5P7tT7lHJSRm7a5+F+76GtfyNY3WoBVTNDjM4ynNXLyA3xw==
X-Received: by 2002:a17:903:15cf:b0:234:c549:da0e with SMTP id d9443c01a7336-23fb3129f72mr148697115ad.47.1753682187515;
        Sun, 27 Jul 2025 22:56:27 -0700 (PDT)
Received: from localhost.localdomain (c-76-133-73-115.hsd1.ca.comcast.net. [76.133.73.115])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fbe514b59sm45091795ad.128.2025.07.27.22.56.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jul 2025 22:56:27 -0700 (PDT)
From: rentao.bupt@gmail.com
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>,
	Tao Ren <taoren@meta.com>
Cc: Tao Ren <rentao.bupt@gmail.com>
Subject: [PATCH v4 03/13] ARM: dts: aspeed: Fix DTB warnings in ast2600-facebook-netbmc-common.dtsi
Date: Sun, 27 Jul 2025 22:56:05 -0700
Message-ID: <20250728055618.61616-4-rentao.bupt@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250728055618.61616-1-rentao.bupt@gmail.com>
References: <20250728055618.61616-1-rentao.bupt@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tao Ren <rentao.bupt@gmail.com>

Fix deprecated spi-gpio properties in ast2600-facebook-netbmc-common.dtsi.

Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
---
Changes in v4:
  - None.
Changes in v3:
  - None.
Changes in v2:
  - None (the patch is introduced in v2).

 .../dts/aspeed/ast2600-facebook-netbmc-common.dtsi     | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/ast2600-facebook-netbmc-common.dtsi b/arch/arm/boot/dts/aspeed/ast2600-facebook-netbmc-common.dtsi
index 00e5887c926f..208cf6567ed4 100644
--- a/arch/arm/boot/dts/aspeed/ast2600-facebook-netbmc-common.dtsi
+++ b/arch/arm/boot/dts/aspeed/ast2600-facebook-netbmc-common.dtsi
@@ -31,9 +31,13 @@ spi_gpio: spi {
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		gpio-sck = <&gpio0 ASPEED_GPIO(X, 3) GPIO_ACTIVE_HIGH>;
-		gpio-mosi = <&gpio0 ASPEED_GPIO(X, 4) GPIO_ACTIVE_HIGH>;
-		gpio-miso = <&gpio0 ASPEED_GPIO(X, 5) GPIO_ACTIVE_HIGH>;
+		/*
+		 * chipselect pins are defined in platform .dts files
+		 * separately.
+		 */
+		sck-gpios = <&gpio0 ASPEED_GPIO(X, 3) GPIO_ACTIVE_HIGH>;
+		mosi-gpios = <&gpio0 ASPEED_GPIO(X, 4) GPIO_ACTIVE_HIGH>;
+		miso-gpios = <&gpio0 ASPEED_GPIO(X, 5) GPIO_ACTIVE_HIGH>;
 
 		tpm@0 {
 			compatible = "infineon,slb9670", "tcg,tpm_tis-spi";
-- 
2.47.3


