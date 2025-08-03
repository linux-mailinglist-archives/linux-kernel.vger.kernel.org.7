Return-Path: <linux-kernel+bounces-754267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A86A1B191A7
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 04:59:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D02A7177EE6
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 02:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F7E01EA7CF;
	Sun,  3 Aug 2025 02:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="y6Qn/Bvm"
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A14F1DF26B
	for <linux-kernel@vger.kernel.org>; Sun,  3 Aug 2025 02:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754189910; cv=none; b=RrUs/bw60XGPTNfK3USFZLNG+Dk3WecVj7BRqW2Q23HsF6iPIj7dixdJmiI1XYlMWJpaY5eOS6mBj9G/Qb7HLJwW4NjxSj1RgC8CA0jzw3AMD0rJx7E343iwzbQTN/ZET6G0WLu5fhW2nXTdl6HpCGPppu3HxmI6aTdkKfbSk7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754189910; c=relaxed/simple;
	bh=4MkO0yPVEXokF7BKWo63wkxjH8l6ox9Iw2xywkWl/sg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FBf9VJttuU/DSZojROSpN5x5LzQbuBc7cd4H+18kZfFnl/4s/gSzDsYbUjSVfJWz4pJnhBgmr+AVOd5517L0aCwvv1qb+J7EWC2e0VzZD7frGii7jZ0ZMlHVSOTItmWrJIMp+2n8mUamUPnWaw/1gGbK0HXWH99QLsFgFSTSwZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=y6Qn/Bvm; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3e3f1e69090so8124525ab.0
        for <linux-kernel@vger.kernel.org>; Sat, 02 Aug 2025 19:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1754189908; x=1754794708; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TzbsCOAJDq8e6tJqb71PLkWE7SOSqQYLq4powgsnVhU=;
        b=y6Qn/Bvm7zFtGniKursimz4TE7Pz3fffi44w8VYNvfkJhmW3X3uvkubL8AcwfXTc2w
         2Ivg8hZwL4MaGc1wMpU9Gsj3NeDfsDCJgIbjYzErCWsoZcgRI4R255ioGr/FYn5qfgUR
         QjIHEvqP1X9xERn1WyxAbYY7TqZHb01huH25j7ULTtPKIAPoH2XyMnfdmi8SoJRT1Bkb
         5CydB/XHpyXquG/4rUhduSnftfCmjyvHm2U4mYt8dKBtJgphs2M+gv8ePtDcqXoeE37g
         VqoHJEICYywhyFJwFLoxcS5N5Jsg6/3hu7KmzEKukRvXuPL8Ewr96cCEHxQ9PtGI94fu
         1duw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754189908; x=1754794708;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TzbsCOAJDq8e6tJqb71PLkWE7SOSqQYLq4powgsnVhU=;
        b=fdIyYkqXskg4u1HH32tJoI3SIT2d3e+YLcQhU1pPXdErciunWk4Mq8wlbqqj4YVUGz
         k2lxAzmVs9CPHxlw+QqOeO09qR2rTKG2m/upZ1zfRDTRenTDtlj3neL2I1pIjWXpfsUc
         yO1cxCxkZtvmWUj7VFCtRq6ksXx0tVzJSXyaSQfq+Jw8ER2q/0iP0ur+vwbXseU5dBdy
         l/p5TcFIULXEdf4ram/9vqdA8IBLPXlVNdY0EkS8dQPNc3WMr66BbdHU/Y6iXgBrloaI
         rdnRgEfDxzHMbBEhq/3q+bMr9JjwkhkHCquW/hYrUhabRr3EZrEMZLw4FuWhrFx67L4p
         8/RA==
X-Forwarded-Encrypted: i=1; AJvYcCW6S/QHN/EXbrvRxr0owSv2Bhd2Oe9KbEwHJu1ZVo0P/JoWu3GYvGEZkui0ssXevELsxdvqc9/UwmocWBQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkqAs7YvCrelUHtcc141LZJrjZP5BvbmFYJ0fCKrqszq5TRcTF
	o8ez99gb+SuUc/rDXXmb8c03CKOO0YOyW6WAVKSdWlgPlK2C3R7xKI1dN5mWTYd0Exw=
X-Gm-Gg: ASbGncvZ/lfOXq3KpbvH15Uoj/Iu7gxdjh+u1nm7NXUqM+a5EJR+KJjer7tz6eeRpst
	dg19dH8tQ9ecrY4jzIFl+OxMSG7RnvjZ0yWaDOZvhoc6fXbSAE0fjXszXch0NV+M8T8DL51Cy2M
	pLb4DvS6YteULrClL7haOtPKwU2fBUigrRgFYc8Dqg76J3AW2j/trE4KeweD/ZWP6Lc6Q9ZYA/s
	qdcAe4fufpcZe0VJb6wZwlJkXAOiA/J3nXXlIQohnAz4dg4BNyrGjzxZ5zssRjeiSxO0BbtGYmZ
	5l2JAmDQLPCZMGe8RdCxfIhyVe0xSNwPcwXsHXtSJjIXnogdBc40FaUHgR+oLYhhQDB0nmZrGI5
	O78DDSgDYNc2s5lJgjpVCgw14NfVgbLeuxOqSPfDy//2p5eFP5LDQdGXLGkAy0wdmHw==
X-Google-Smtp-Source: AGHT+IFa00F5/dr/4CJjlueOFIA5pV3OJea5UsZuFhaXiwjw86cfQMhRrHQfFtqyDPs6JBYJR5sLdg==
X-Received: by 2002:a05:6e02:b:b0:3e2:aafc:a7f with SMTP id e9e14a558f8ab-3e416122d83mr105791125ab.7.1754189908398;
        Sat, 02 Aug 2025 19:58:28 -0700 (PDT)
Received: from zippy.localdomain (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50a55b1ac2esm2251906173.1.2025.08.02.19.58.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Aug 2025 19:58:27 -0700 (PDT)
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
Subject: [PATCH v11 6/7] riscv: dts: spacemit: define fixed regulators
Date: Sat,  2 Aug 2025 21:58:10 -0500
Message-ID: <20250803025812.373029-7-elder@riscstar.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250803025812.373029-1-elder@riscstar.com>
References: <20250803025812.373029-1-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Define the DC power input and the 4v power as fixed supplies in the
Banana Pi BPI-F3.

Signed-off-by: Alex Elder <elder@riscstar.com>
---
 .../boot/dts/spacemit/k1-bananapi-f3.dts      | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts b/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
index ae9409fe398b2..a11a60b9f369b 100644
--- a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
+++ b/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
@@ -28,6 +28,25 @@ led1 {
 			default-state = "on";
 		};
 	};
+
+	reg_dc_in: dc-in-12v {
+		compatible = "regulator-fixed";
+		regulator-name = "dc_in_12v";
+		regulator-min-microvolt = <12000000>;
+		regulator-max-microvolt = <12000000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
+
+	reg_vcc_4v: vcc-4v {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc_4v";
+		regulator-min-microvolt = <4000000>;
+		regulator-max-microvolt = <4000000>;
+		regulator-boot-on;
+		regulator-always-on;
+		vin-supply = <&reg_dc_in>;
+	};
 };
 
 &emmc {
-- 
2.48.1


