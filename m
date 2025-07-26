Return-Path: <linux-kernel+bounces-746740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D3FBB12AAC
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 15:12:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B69E53BADE8
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 13:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FB46254845;
	Sat, 26 Jul 2025 13:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="MIgG3OiW"
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1CC253355
	for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 13:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753535427; cv=none; b=tDhjjUerIamazB9SJaAFfByqVYHyl+lKBQmlNAHw7Mzzgd10OXYk+u6x0pz5vRZ9oPpp1T8aUUTP/Tu8IY1t94EbqLOcxTenP4cEjhEFVr+irI6GGibg8cgM4+58H9gDi/TxyX2rRI0q5bUzfghz5kkIEVcADk2XqNsPZngt25g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753535427; c=relaxed/simple;
	bh=D00Agu9o5lMwHglRF8JEmN9Mz2SwGM8gIpQ2brQAJHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YDWwnXDM2wcwbhiZz037H68FuXl1aMyVvnZ8HQiZfLVJaIsq+T7nPMnqzF1U5HDuaVInWeKYzctrJD9bk+6cW/E+MX7lA/TF+aaXuvJpFwepno9Vz4bEgI24+rc+bUan7u/e6sCjEguY/iTJM+GQA+zxbaH8o0E8xlxrwG0tHaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=MIgG3OiW; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-87c0bb1ee4eso66810739f.2
        for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 06:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1753535424; x=1754140224; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RmHcfUIrXFFWAxyqlPf+YQqXo4C+Q0QbA66Hg5xFlzs=;
        b=MIgG3OiWocH0+YrJu0UW2sfZ02Qu5DeqnDLOyS1orbwuxEfznU6OWLHP4tjSVHwNgk
         c3kx5dj7SipUwFbb/6whTDp/sB0SWyTOGesoc6uKcKwXHt6wE+pZuCNy4t+xUeyYlxo8
         6LeDmk2Xk2CXiFP1UJTm2m6LEtX9PRPEyPXp8xNPw7G3FkKcWron/KA72a87pSlwiyPT
         SKSsDTWG0G02DHRlInTT3a+eION9aHpLyIETznKyyaamm1XB6pqFE4Oad9ZqPDkTAn/J
         pGCD09obhs/iBYIXdHGQ43dsDXmwvFkoPl4p09to+rqj+qbmVyn4xNyN+SoqidB3nxa5
         5uyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753535424; x=1754140224;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RmHcfUIrXFFWAxyqlPf+YQqXo4C+Q0QbA66Hg5xFlzs=;
        b=etxKah3x/0W2r896s49tzoOmKU/C/VRH4CBjZ0CGQYjqCpzvuWGVFCcJcaoc0zrymb
         WPKR4v2B2ySegnorSV8RX1Qb+ZKzsei0991ELPEVaZJHndEhj1XJIwyBccAeOIxR53o8
         DCsuajz3qL4XSaGJd1h1/MvzXRS08OyW8IXn94jtGaGCAogwUbW7uhjRxMi0z4x3dr/I
         g324/HzxQVjRV2SYrhtrFGaBKRGQll6mVJdPQkNQvnkNJ9iML5NEjfDTDGfplr3GkiwB
         AfOFOlky+oyV3/rUE6lh3hgLr+V5sOx0KVSGdX7sAQy2+rErB9uXnU4vheoPzW2B8Qkn
         BC6g==
X-Forwarded-Encrypted: i=1; AJvYcCVr4eApyx6aBe4vCSVB9IWVslRjlY4mUBk9OTYYuJ6n40SmEin4CPfAS7jxkTmPOfFriJ0HPUNLsJMr3XU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx192JvBLm936vOVujshK1I+5ztmFzOkP0dTVQdY8E+nddt2Dcs
	JvzEGf4IAn7lAPEgsvgdExEgVj1k32kktTyrOROGLqZ8AadzuxNfIWXKGU0sOscpSK4=
X-Gm-Gg: ASbGncu3kUypIgCmO1yndyR9QexrTy6Oy6qGfWRPPNPq8JiZqGucsVOwT3qOEZN4BPt
	OMcrs1gWyMPqi6p8GaVLvAZavf89nslA30SJ+IQc1k85tm8INh9U6MBUlp5I189VfhohAZzCxxw
	SHOlRoOMPjrpD0cAE9fMFqSrH4GpVwGbpEu4Chm6fHcfFCr0p8kEixo+LfYFYBBFmYUuKL+Iy2Z
	kjreWOShNZKnXdejGAc9hzhdq0chXZi30+LbOe7i8cgTf89s2NaQ/XiTKBMNMyPOcoH40pY9oYY
	gKZeFDc3VUXYXFxzGZRCN8zCu/SgXPXOF/guEMvaepu6RX3bMB1hYEJy7SRgSgd+7QGwqRci4E8
	JUdtXnTi3+MGSBzoi+3oY9kv6sIVT5DlfhWQdH3+pguJa/9HI7YzGpT2HyKbXViY2CA==
X-Google-Smtp-Source: AGHT+IHnZ5VxjnvnLu84xJpltA7xsi0CvkodJCb16fAczrWGpj/N0ZZOz3kKEjYSRbp1bBk68OHmvg==
X-Received: by 2002:a05:6602:2dd0:b0:867:6680:cfd with SMTP id ca18e2360f4ac-8800f0e76f4mr1007709139f.1.1753535424237;
        Sat, 26 Jul 2025 06:10:24 -0700 (PDT)
Received: from zippy.localdomain (c-73-228-159-35.hsd1.mn.comcast.net. [73.228.159.35])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-880f7a4ee9fsm49551439f.33.2025.07.26.06.10.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Jul 2025 06:10:23 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: lee@kernel.org,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	alexandre.belloni@bootlin.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: mat.jonczyk@o2.pl,
	dlan@gentoo.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	linux.amoon@gmail.com,
	troymitchell988@gmail.com,
	guodong@riscstar.com,
	linux-rtc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v10 8/8] riscv: dts: spacemit: define regulator constraints
Date: Sat, 26 Jul 2025 08:10:02 -0500
Message-ID: <20250726131003.3137282-9-elder@riscstar.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250726131003.3137282-1-elder@riscstar.com>
References: <20250726131003.3137282-1-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Define basic constraints for the regulators in the SpacemiT P1 PMIC,
as implemented in the Banana Pi BPI-F3.

Signed-off-by: Alex Elder <elder@riscstar.com>
---
 .../boot/dts/spacemit/k1-bananapi-f3.dts      | 104 ++++++++++++++++++
 1 file changed, 104 insertions(+)

diff --git a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts b/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
index a11a60b9f369b..a9a2596a94e89 100644
--- a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
+++ b/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
@@ -68,6 +68,110 @@ pmic@41 {
 		compatible = "spacemit,p1";
 		reg = <0x41>;
 		interrupts = <64>;
+		vin-supply = <&reg_vcc_4v>;
+
+		regulators {
+			buck1 {
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <3450000>;
+				regulator-ramp-delay = <5000>;
+				regulator-always-on;
+			};
+
+			buck2 {
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <3450000>;
+				regulator-ramp-delay = <5000>;
+				regulator-always-on;
+			};
+
+			buck3 {
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-ramp-delay = <5000>;
+				regulator-always-on;
+			};
+
+			buck4 {
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-ramp-delay = <5000>;
+				regulator-always-on;
+			};
+
+			buck5 {
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <3450000>;
+				regulator-ramp-delay = <5000>;
+				regulator-always-on;
+			};
+
+			buck6 {
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <3450000>;
+				regulator-ramp-delay = <5000>;
+				regulator-always-on;
+			};
+
+			aldo1 {
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <3400000>;
+				regulator-boot-on;
+			};
+
+			aldo2 {
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <3400000>;
+			};
+
+			aldo3 {
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <3400000>;
+			};
+
+			aldo4 {
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <3400000>;
+			};
+
+			dldo1 {
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <3400000>;
+				regulator-boot-on;
+			};
+
+			dldo2 {
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <3400000>;
+			};
+
+			dldo3 {
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <3400000>;
+			};
+
+			dldo4 {
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <3400000>;
+				regulator-always-on;
+			};
+
+			dldo5 {
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <3400000>;
+			};
+
+			dldo6 {
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <3400000>;
+				regulator-always-on;
+			};
+
+			dldo7 {
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <3400000>;
+			};
+		};
 	};
 };
 
-- 
2.48.1


