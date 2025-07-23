Return-Path: <linux-kernel+bounces-743354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ADB9B0FD9C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 01:31:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24166AA6B5B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 23:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB7442741CF;
	Wed, 23 Jul 2025 23:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jtt9WR4W"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55FA273817;
	Wed, 23 Jul 2025 23:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753313427; cv=none; b=pyigN7AaWdvji212uHZax7U0PNmY92x21OvK1jvz3KzlOPipz3WDVWxiyRG2J0uLMFWekeqkWc3VWwEbKtsS3WP8AveM/dnpEC1roFBv3nmeaHzyzOl7ZHIGTFcY0ebpqT952IcDD0vsw+svbtXEeTal6+0FTXm2dnNxh3Ynu2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753313427; c=relaxed/simple;
	bh=GfYWs/R0+rcewDkLVXCC5SDhMnM7D9a/I1092RugNII=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F5Hi2CkYI4lOkW5JJ6zWhUaf14uf05Am0JMBFi1CznhW2EZiratl6JtYmi/PlDFDz41eM1cSzkuw3+IMGUGVux6afYr8eDUrOwSSg5ymoa218ouoKFBnf7+ic8uyc0pr5qz8DNaExC64WjqKD+93MQGMKc4ieA00BbgTvDO6ia8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jtt9WR4W; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-235d6de331fso4436235ad.3;
        Wed, 23 Jul 2025 16:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753313425; x=1753918225; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hexKS3OBdUuka6mz2tsiA5AZ62DQZfbT13EVs55U9NQ=;
        b=jtt9WR4WecIPgdDyMDkrLFbg9GuaCPZU3ZsXWkCF1bUyqylQbkJuVWUemyLHOz3J+7
         1Ci97eFCxu1sbFjtbKYZSDm1AU95Xpdly+QXsMAnwGJR2pWQh8kCR2lFs/8jgqOwDgrG
         OzbjfLMYrkg+HMVvYj1432F5iWG8P1sk0OsOGAlFZetMu7giSf4FjQjN1sUS5nsrnPcb
         ATK5+loROhKqnUjPXkyzhgQ/mM3DD4TTC3rmFTYKsr6VS9/urC+j/gNJxFGV4zgL3aov
         uJ5ZFdJS6jzKopsw2tCpLvFnLGZSk/Xpr4s1LP+qi+/4Pmf86WKKrXwh0LZnoKw/g5pQ
         jyCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753313425; x=1753918225;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hexKS3OBdUuka6mz2tsiA5AZ62DQZfbT13EVs55U9NQ=;
        b=rHgbMGdv9xJOO0e+C9mjcFtp3TEQsqTc0KJp5gpBzEolQsK/thKZxcSCeiYvfP7kIp
         1C7nVFqnboLdv9Qs+6IxwCLO6LepL1ozJzA9bmG5jQYlp7oSTTu5cPrIszF6vECbSr9h
         CeWb7NXYVodPBfR/a8s5FUUmGEuIvkjFmcolLmtGBGnfdOSKKm+I3TNN/h9UDs5/WnM0
         Mtfr52dyIB5yNPwUw3a3RS1u/vu/kpGLatTG3bbKDDIGn6opZXv5uTypgMmmvvYQ2NYD
         /PJCzHz2m/+w5YqVSsHAtRwkuVckfDlWsPKEibGpIIUbdwXhW1lTlWuKalncx5Sz/AXy
         xZ8w==
X-Forwarded-Encrypted: i=1; AJvYcCWNirt6+6DPPYo89O48/9RnKoF99AvschoGgp/AhEsjsPPhTJtZQbY2kcrV4cdcAhYlqC8Fd1P9bFZS9ca3@vger.kernel.org, AJvYcCX2BxHBvZs5sgVANiCXEK34JSnbrWNLHDYsnwXeu19WfQgdgEKm99pCMDb2rejb7yDV8fY3L8OtkZfX@vger.kernel.org
X-Gm-Message-State: AOJu0YzvaKW93Xiyk8i9DBEOMj1yNjhZdR/17tSyGW3/iALoYY5rDL3Q
	boIXUV1lFp9Otep7P1ZPW5eoc63lHvTxWeaXJU1W8TKEyBlmYrovOFGf
X-Gm-Gg: ASbGncvLkgACdvsdB/RPgfPx6W5h9zK9D5AXpa2PPBYKMRdavs/633Bo2q1cl6+Jpwd
	pisWnDY1btSFhomE+mVG1TS5dnm+7T4TlzuOONUCqzNFJ+0G8aWlfBt5yjeU8D04m6+mFvSsSTV
	khRPY66nsglXdJcJEEnlAwlQdKynGFFvsON0VFahL0Dg1KazC2/mCiimgRx6jvmXidax6b6t7RZ
	mHD/uo8UI4Vn6d5uFBMX63FrNJfi6trGesepgHZD5Uj36APeJ/oqNHXzF5BE4KdkcuC3fFy1Uuq
	M8VYeOGFTC0Yz3QQVYyo1OiYRoJYBA58mcxUG4ZTlkGXsPlFxx6WrpbRP3bOb362maB76U+d2wf
	cnE1LcNguGdlFOK0DOgchx91HgUbzJTGppMrGY67kEDJe0TFNQCdtbzHB1BAx0ZpEM3j8bLFIuz
	w=
X-Google-Smtp-Source: AGHT+IGI7TnYck3w9Hntb7EBGOSxlq7HH1YPFTWNRaeivNj40fXsheG0i19dTMp3Dq/70CdQsBEbvQ==
X-Received: by 2002:a17:902:ce11:b0:21f:617a:f1b2 with SMTP id d9443c01a7336-23f981da200mr67178985ad.46.1753313424830;
        Wed, 23 Jul 2025 16:30:24 -0700 (PDT)
Received: from localhost.localdomain (c-76-133-73-115.hsd1.ca.comcast.net. [76.133.73.115])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fa48bc6fbsm1260765ad.120.2025.07.23.16.30.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 16:30:24 -0700 (PDT)
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
Subject: [PATCH v3 03/13] ARM: dts: aspeed: Fix DTB warnings in ast2600-facebook-netbmc-common.dtsi
Date: Wed, 23 Jul 2025 16:29:59 -0700
Message-ID: <20250723233013.142337-4-rentao.bupt@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250723233013.142337-1-rentao.bupt@gmail.com>
References: <20250723233013.142337-1-rentao.bupt@gmail.com>
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


