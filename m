Return-Path: <linux-kernel+bounces-747488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D03FB1346D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 07:57:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16E23176DCC
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 05:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 142AD22F76C;
	Mon, 28 Jul 2025 05:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dr/uZw7N"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE69227EB9;
	Mon, 28 Jul 2025 05:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753682191; cv=none; b=MBfnj6SGyxTwIod/5FfSPMUCscPEyJtyCLokcw8Thks9xVIa1AjX9phpw2iKNrbxnjNcbz0g+aTSDtSzhUTTsFs0+3wDWHplY284mgGvKOmZWNDDNw6Tcr47MBk9m4oDuTQdyQVFw/6qJjoXi1Oc5bmtRY2u7TQoWvzJj6JIVZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753682191; c=relaxed/simple;
	bh=g5BoCecVOMUaVVpGbz4N4gunTjGRSViUp7srcZuLeYg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=czP3JQ2RCJsL7rG8cWHIHMP+l5FXNwaBBmbiPXPo9k90TuWm6atFcOGOdZpCSXVtzRUWM1ynKr80mSkYhW9xe35yaSXcn4S3bKHA+77pKmLQ9M7MLeZRh62h2ZS+LeqFUKN0DbQs0N7aivmIBipncjqErlErUAuyzmXZMjbzqus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dr/uZw7N; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-24049d1643aso152385ad.3;
        Sun, 27 Jul 2025 22:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753682189; x=1754286989; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mL3WUAt/E/JB7U4/txK3K9d2bFPzk59C+WVfG91tte0=;
        b=dr/uZw7Nr2+UyQpRxrTQiD60R54RScgXhc+rYwNwtEjjC4xulxHutdo1yz5GYCIfNo
         BDRqA9w2kJDUkceD6Z6A3bdeI37jpDEv6ncE+eZY7eTjp02ua/MfdmmLk0aeyTdwNoBu
         aH5tvzqwyLB3VhMxVrGhvZPq5zH2EYsy+tb5laEzSRSiCoGdvYrhWxqHael4cKMQEZbm
         ABOyNqm+loknzHoHlDbXtBJrIpfplZEDKJng4TD7d/WTrrd4d1CiCITP8qPnS7/4WnhZ
         LwFcWTKZ4m/AzLLziKbYwQEBS7ItrKJ28OY0Sv84KkUYOwI267XxWRP/UIoCjOwwPxqa
         9FYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753682189; x=1754286989;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mL3WUAt/E/JB7U4/txK3K9d2bFPzk59C+WVfG91tte0=;
        b=jlF+UOrtfuPuC4MosoOHM6UmQEikQZo0sEeumoE9/eOVyJREzggmICCQYpGUSbW5O+
         zKx0DpMgT2qI2KsNW4yELZ2fT36yigouHtrZ4wuSpvvIMIVnamqP3HwPM0erXzD3C5Zb
         gd2B3ymXN14UF8mMxAppBCTeb6DqVOkvT0GNe9rh9fe1fMOM71GdLcpn6sLTs1GA59cd
         46nFJsx3iSB2tNJ7RQmWmvYVoquNZxVA+Sr+J/X1bqn2bkc4nUCTj/uV/p1Jp0YW+OKj
         C/H4Flh36rUZzLWeOHfVdi1zRlr3VUHqqBYhoovtLg89c34r7a+Vex46yatHzB1OSjRR
         Bgjw==
X-Forwarded-Encrypted: i=1; AJvYcCUz74O4/WvMicRoA7WWgUHVhrIVWRjKuwpKuQILfJPgrktvA/dhdnCCnncg2vEjhXTuzYhEqKb+MbPID92r@vger.kernel.org, AJvYcCVjSZe9BejvxFCyqx0fDkGWe5I3piek9FIlxpeW+RxOazJ0DP6YG4AO/Vo+U0cVNWw7iUkJYsuaOSH6@vger.kernel.org
X-Gm-Message-State: AOJu0YzZbIhs1Vh+AJKnkGE78ISsjZtehEWdBXXfwMu3XiOaeva97yJC
	k+Ag3gMe6QjTj5fK9+BAIwLXA6p8tR0vYL4rDWyI3oiUjh7uSr3NdPzw+I2l3rYX
X-Gm-Gg: ASbGncva24gjbqD6Nj4fCVPkQPMl7rG0mFFGQP6gBgbHI2ybqrAkYBLZLCy5Ztuc2/V
	nEqwyaTTOlH1T39U2A6zKA4hMJr9f4ZTU4YpbMRwZUrMcF51Tjzp+r9gzF0w49PzbZcN9soMpyj
	J7+w/M3C1QAfOCNRb/HxVHcrj+TLz+MVZy0+WaLR+kIDEXr1H7mBuWVzLV9lnbIy50EuSCij0yD
	IUS1Nh9OWFWUbcJpss/Cv/jeD0hGfUEB7nDQrrbQ3myOW5t4aYQ8403RblJPgOdHqpDS2AVUzRP
	6M4mWq0TRtYZXQh2zuDQ8m/kCB9jKT8ro4YhoshiLGGbI4+dPzcceA2LVvS67jlrw5td0ov1W20
	XoMx5As33KF2vsifvPJXtADxnZ+uGDbov8XLRAtvRQToDZwe5wXcDsFepPzcAvv3odXSyiGaTza
	0=
X-Google-Smtp-Source: AGHT+IFYSrKh0tfdTWTrBVWNM0zAsQJS4EjDsjvUY58SNitCxSLezcS2f29GrbOUsvr7sviStuxoDA==
X-Received: by 2002:a17:903:1a08:b0:237:ed8e:51d4 with SMTP id d9443c01a7336-23fb30b3205mr188991885ad.24.1753682189146;
        Sun, 27 Jul 2025 22:56:29 -0700 (PDT)
Received: from localhost.localdomain (c-76-133-73-115.hsd1.ca.comcast.net. [76.133.73.115])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fbe514b59sm45091795ad.128.2025.07.27.22.56.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jul 2025 22:56:28 -0700 (PDT)
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
Subject: [PATCH v4 04/13] ARM: dts: aspeed: Move eMMC out of ast2600-facebook-netbmc-common.dtsi
Date: Sun, 27 Jul 2025 22:56:06 -0700
Message-ID: <20250728055618.61616-5-rentao.bupt@gmail.com>
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

Move eMMC entries from ast2600-facebook-netbmc-common.dtsi to each
platform because eMMC is removed from future Meta/Facebook AST2600
Network BMC platforms.

Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
---
Changes in v4:
  - None.
Changes in v3:
  - None.
Changes in v2:
  - The 3 emmc-related patches in v1 are squashed into this patch.

 .../boot/dts/aspeed/aspeed-bmc-facebook-elbert.dts   | 12 ++++++++++++
 .../arm/boot/dts/aspeed/aspeed-bmc-facebook-fuji.dts | 12 ++++++++++++
 .../dts/aspeed/ast2600-facebook-netbmc-common.dtsi   | 12 ------------
 3 files changed, 24 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-elbert.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-elbert.dts
index 74f3c67e0eff..ff1009ea1c49 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-elbert.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-elbert.dts
@@ -201,3 +201,15 @@ fixed-link {
 		full-duplex;
 	};
 };
+
+&emmc_controller {
+	status = "okay";
+};
+
+&emmc {
+	status = "okay";
+
+	non-removable;
+	max-frequency = <25000000>;
+	bus-width = <4>;
+};
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-fuji.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-fuji.dts
index 840d19d6b1d4..d0331980d082 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-fuji.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-fuji.dts
@@ -1243,3 +1243,15 @@ &mac3 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_rgmii4_default>;
 };
+
+&emmc_controller {
+	status = "okay";
+};
+
+&emmc {
+	status = "okay";
+
+	non-removable;
+	max-frequency = <25000000>;
+	bus-width = <4>;
+};
diff --git a/arch/arm/boot/dts/aspeed/ast2600-facebook-netbmc-common.dtsi b/arch/arm/boot/dts/aspeed/ast2600-facebook-netbmc-common.dtsi
index 208cf6567ed4..0ef225acddfc 100644
--- a/arch/arm/boot/dts/aspeed/ast2600-facebook-netbmc-common.dtsi
+++ b/arch/arm/boot/dts/aspeed/ast2600-facebook-netbmc-common.dtsi
@@ -156,18 +156,6 @@ &vhub {
 	status = "okay";
 };
 
-&emmc_controller {
-	status = "okay";
-};
-
-&emmc {
-	status = "okay";
-
-	non-removable;
-	max-frequency = <25000000>;
-	bus-width = <4>;
-};
-
 &rtc {
 	status = "okay";
 };
-- 
2.47.3


