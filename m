Return-Path: <linux-kernel+bounces-767287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 45B9CB25251
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 19:47:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2BD9D4E20AF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 17:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 635C81DB375;
	Wed, 13 Aug 2025 17:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="lsWU4LcE"
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23512303C85
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 17:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755107260; cv=none; b=YblaonPYDTCdjjZH81wHBKA70+EL0LqXvSAUNKGCkoFrjljsOskk1QxWz2Z41IN0XEem4KQpJheCafKKsGKcNiJ4yRMt0Rjaky/WGDJbLJWftNSFw2pZwYl2ZDa7gA62Ms+NSWzu15/QX2F/dNs/+pOW8w07ySwKIZz+K1U0rRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755107260; c=relaxed/simple;
	bh=nisRlxMdlxNBw0kJu7miBzfQrgmKYtOuzeITlICZH2g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KluV93Pg8lp4ww4pUXJlZVR6B9lPXmNdWfH5kA18kqkIMu4p63v77iiVHEj+VA4KpiMgXuvRlWhJK3gwuZ2q6wljov3KJyUzmZMwUMHBxJrveFiGtY72bH9PZb7IS6bp3sLmR5zoDEuzqNkDopMtnkNfBNEWX6L6ntPxB/tNDOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=lsWU4LcE; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7e8706c880eso6134585a.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 10:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1755107256; x=1755712056; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TB7OCoBKq4sEt4VQQvcl3aOmJkQhrsxuhQkNyl7xRNw=;
        b=lsWU4LcE3tyz9SS0aasoM8PuG4+iIDidI4UAAow4D6K8+3iib4hXh/PfQMrkCbMBsx
         +VWHz2piy4F/K8zOyjL4PPSM4PjBH+GjokhrvzXGXAwzKO8L+SYo14Q++jSH2/VRrcj/
         M8JZjQ94RAqmJYpgNa5PM3SJk1T36V/MGjqI6cmX6rW/0c3dpWZdJXILFAxP7xSdf5RR
         ZbusLUke962yAgHFgcn8oMTQN4gJ5znPcja1IwgGVpedcTFKICuk7SyUCrXDKXAbF0yK
         oVEK3IDXKt+mjqBe/V0rUkzY2n/TUkDiYbgjQhUQmYlqX6k1Qm86jIbzW5Y1yNBDgQYr
         ukpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755107256; x=1755712056;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TB7OCoBKq4sEt4VQQvcl3aOmJkQhrsxuhQkNyl7xRNw=;
        b=BfMT9CD/d2JQu8lVOuRCAOXhdPDUdN1IZ9bUQYLQSaDrJngWGQrZ76t3p7aa7gtpOD
         J/QhkXeBRLT7klTiyqxkAGkhC5Ac7Qa5ivx6CFnR8Jy93KvI68Mqo/t/iwiBsw1yvz1D
         BiiUYvMy/Qjl7FeBraVc87JYJKBiHgTrNOoaZ0o6mFkuLFWU6UgYMYCut97cmNrTPwSe
         fCTC0igrDylzZ9EkB/G6GQZYg0Db6IvxHXNvamYZFG23cvWPPEpvctCwdF+CTkpM55yi
         o6CyA09xVkjfLzxGF6w2RI0euQAh9Ji4f1SZA7EA6DJhl9qy2TlEKdKcOEqdFhP1UUFg
         j+ag==
X-Forwarded-Encrypted: i=1; AJvYcCXEOpU6QWzn+20bEJCvNf0QcP5M3lGVVLsnT/jc+5yZvVVz0fI5rnjfI2Hagpxx127X66kVOWW6CfVXWR8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyL7YpIJ8jsDBiOBnG1U+iG7sKObn5XAPJ5slYkl0fyTi7QeE7C
	H9n9P+ahixj3rhVo6e+Y2Nm3mVj2FlHyGUk+Q8XPtMbxj8r/NYQ1rru8h4MH+TWDn08=
X-Gm-Gg: ASbGncvCni3nDp7MvfgDi7thvS7SDMbbKHZGEM9cX2QbxJTA8QPibbNqWcqWhsa45cl
	lHjM2XLpcdEnO95WOT+TAxRbzE4OIJTvWxiuPN0xyMqVfQIIe5m+wsSNda4XU77Qsg1utvcl7fB
	0SXdFzxtTf8+J/sL13B0PnFtXAUCwTskf+cuT/jX6zj1kKdEUVD4GpyRZ0Q4Y02PzqYtsdWMQeW
	bHt4fSLnDuDtIsvzqL6HoNoVhJ+CM2mNJzcVpR2dv+tn5sy/hfGag172xJne/Xc7g7hrKLnnKB0
	JR7l6n+OP4NzOZBR1rze60370ghUNSm6ik7xjG1D9WGafdi2aqHYYQaSS8+FLF4cpL5YZIUGw9v
	yMyd6jFMsn2R4JVUSSv4/3vqlGNkddH6h9tvG95Kukw==
X-Google-Smtp-Source: AGHT+IEToP13G1zvLikrKvReC+w/kXfMQkt8g35fYQ5sGrJ+PpG+DgIXPbBl9bQ7Qc9/37ctzeq7lQ==
X-Received: by 2002:a05:620a:5e14:b0:7d4:4a26:4065 with SMTP id af79cd13be357-7e870496376mr26868585a.58.1755107255712;
        Wed, 13 Aug 2025 10:47:35 -0700 (PDT)
Received: from fedora (d-zg2-251.globalnet.hr. [213.149.37.251])
        by smtp.googlemail.com with ESMTPSA id af79cd13be357-7e7fa87e7d0sm1627122385a.82.2025.08.13.10.47.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 10:47:35 -0700 (PDT)
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
Subject: [PATCH v9 1/9] arm64: Add config for Microchip SoC platforms
Date: Wed, 13 Aug 2025 19:44:37 +0200
Message-ID: <20250813174720.540015-2-robert.marko@sartura.hr>
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

Currently, Microchip SparX-5 SoC is supported and it has its own symbol.

However, this means that new Microchip platforms that share drivers need
to constantly keep updating depends on various drivers.

So, to try and reduce this lets add ARCH_MICROCHIP symbol that drivers
could instead depend on.

LAN969x is being worked on and it will be added under ARCH_MICROCHIP.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
Changes in v9:
* Make ARCH_MICROCHIP hidden symbol that is selected by SparX-5 directly,
this avoids breaking existing configs with ARCH_SPARX5

 arch/arm64/Kconfig.platforms | 36 ++++++++++++++++++++++--------------
 1 file changed, 22 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index a88f5ad9328c..bfea380100a6 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -131,20 +131,6 @@ config ARCH_EXYNOS
 	help
 	  This enables support for ARMv8 based Samsung Exynos SoC family.
 
-config ARCH_SPARX5
-	bool "Microchip Sparx5 SoC family"
-	select PINCTRL
-	select DW_APB_TIMER_OF
-	help
-	  This enables support for the Microchip Sparx5 ARMv8-based
-	  SoC family of TSN-capable gigabit switches.
-
-	  The SparX-5 Ethernet switch family provides a rich set of
-	  switching features such as advanced TCAM-based VLAN and QoS
-	  processing enabling delivery of differentiated services, and
-	  security through TCAM-based frame processing using versatile
-	  content aware processor (VCAP).
-
 config ARCH_K3
 	bool "Texas Instruments Inc. K3 multicore SoC architecture"
 	select SOC_TI
@@ -186,6 +172,28 @@ config ARCH_MESON
 	  This enables support for the arm64 based Amlogic SoCs
 	  such as the s905, S905X/D, S912, A113X/D or S905X/D2
 
+menu "Microchip SoC support"
+
+config ARCH_MICROCHIP
+	bool
+
+config ARCH_SPARX5
+	bool "Microchip Sparx5 SoC family"
+	select PINCTRL
+	select DW_APB_TIMER_OF
+	select ARCH_MICROCHIP
+	help
+	  This enables support for the Microchip Sparx5 ARMv8-based
+	  SoC family of TSN-capable gigabit switches.
+
+	  The SparX-5 Ethernet switch family provides a rich set of
+	  switching features such as advanced TCAM-based VLAN and QoS
+	  processing enabling delivery of differentiated services, and
+	  security through TCAM-based frame processing using versatile
+	  content aware processor (VCAP).
+
+endmenu
+
 config ARCH_MMP
 	bool "Marvell MMP SoC Family"
 	select PINCTRL
-- 
2.50.1


