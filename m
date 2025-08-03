Return-Path: <linux-kernel+bounces-754268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0ABAB191AA
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 05:00:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13BBB3BC0EC
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 03:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C6D81F30BB;
	Sun,  3 Aug 2025 02:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="sFD5XxsF"
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1220F1EDA2A
	for <linux-kernel@vger.kernel.org>; Sun,  3 Aug 2025 02:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754189913; cv=none; b=lmxPjHjWaCGZqLm/5/aXFGsCneL4QrHFUxlaJHmkAePMYs1X8cTKe3uymyK4QhOCLumyA0MgrtD6Mh3dQl4xfu8mu4QMpvp2kzANu/BpTnUWKCtxO27NnK6j9p7WRdtBXFhnkdD3EgwWPSFN1MTPuXpbqAo2VgJWw+Ps83EjuvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754189913; c=relaxed/simple;
	bh=D00Agu9o5lMwHglRF8JEmN9Mz2SwGM8gIpQ2brQAJHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jm18DjFj9by4IEKEeKzM/z5FfS4ZjtTSsoFHfr1B3Xotl0WLCoWAtEG/y1Dxium4OVKy5wi9s6OxWo/OOj9MYHuiSC2pRBsd2ULNk6NyYcOId7VvtLIS+kTYAd/bezsWGW0cQOXagV1Am+Jo9b7/3evNimxZjXcLT+Q4P+UEegM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=sFD5XxsF; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3e3ff43383fso24443665ab.0
        for <linux-kernel@vger.kernel.org>; Sat, 02 Aug 2025 19:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1754189910; x=1754794710; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RmHcfUIrXFFWAxyqlPf+YQqXo4C+Q0QbA66Hg5xFlzs=;
        b=sFD5XxsFKxmWjE+uyL6WNh/FBqGg2Rga1WnnDeMjvZvQ87Qz0jn1S3UScBbBGGP6m4
         lVet5W1vZKghiHySyX84g7nXeesBdwTi3xVWihz1kBOTPUfVZ3fmZYIxR0ixqqz4mAng
         oAcCi/U0juxHyHuYn/2i+gzNRdp5Lj6bcIfMgYsVLImWsx63N7M4gsFlcbxXALZ/hXpR
         /XHtxvDAh7OTZjzI4KcWQ+keg67ZNH/ATSNOoRZSrU9X1TvFEKdBB/mgVtC+m7BoZGz5
         6Ny2I+Gjg97LM0jHcVUGJDOa6yfXQhLKLBcIhIPcysJOEoD7QGFCNcFhXjHa1JYfi+7Y
         d1zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754189910; x=1754794710;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RmHcfUIrXFFWAxyqlPf+YQqXo4C+Q0QbA66Hg5xFlzs=;
        b=FeYU4qL083FtDjh5PZPx8hK61Ma796Nhh/mgNWA84+pd9HOhUhBsAk6togsadetTM3
         boocE8HtuXW5B7IpVr+ANjwGKeKP/SYuxeStPSOb9oX4dmFAwsw+IszO6PJXr575jXn2
         Md+1ARtboThUIm2HtsQ0yWmOao0ezYSOJqmVLMlALQOZ6kuJ+AG9eyAN8MuVpSiiWbyJ
         2C/ruCX7c5Vt/vg9WyTd3rEaRrHhU5yZbkwB7duLbaBp5jm4oQXKx7KBbBoCeO8YOG/3
         nCloc5fSkDHwv5AWL4HcKLZDc8Hvc8V1n4tsiYgeCh5HPBA1cs/dHevF0gK7CZ4qWnVV
         FcwA==
X-Forwarded-Encrypted: i=1; AJvYcCX/SOS0g0DSVLaY4j17TlM2URRbQR7/Oq93mjaP8YSi6+kA9xQQJnDCX1e6QqJUoCAfw4OUgWqziOduf4w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+6qh6vUPjEV5hbjyN97uS0D8Xzs25sDUvgT3BuXtKii7MaTNH
	hGm8gvI+fV1zbp8OWa9YI39J88Yll0W2NxSqLib2sQOoXEYnrmdrS45rDk4JN/g8/pE=
X-Gm-Gg: ASbGncuMWx+HYNPHWsMmLsptwUCf6MhAXsumFXm1Ne1HVL9AtOMUIiaHqlkGnCmnCDl
	mKzz3227I+XD3+lPFnc4qsOYnH2Twxogz9iVlwd8otmeRcfaU+uSNsZ4p8YdEv7up++ECCMiCY9
	Xz3VmHWR/NEFjRrPKDaDkEEhnAAysctkFKgzNXxNtzI7kk2E2XTUuU1nlpGoAQ38uaDSd3CvUXC
	qNwng89zDP4d8j1cUxXD37s9dgNFb9HELY83/IKoEGhhXz+gczp3Au7PM26CVbqajcbQxk87pWc
	eZneQ1ge2Ql5IDs67KxiCnV0rn7PIpVdD2XkwwMiV7GCbje5RHCsQKE+vsf8PIstk5XFWTRnhHz
	gJUBgUww8zw55mqXFmtq62ScAfBGvQlVwunPOU8OvXHHBS4gEf5SGuvMsH2PFGkHg3Q==
X-Google-Smtp-Source: AGHT+IF+PU1Ww8JQGqYmDAP1BywlMvxMvsGkL0JMtzACHATEhfoG3q29UZAUTYQ4U26WEgaiO5kgRg==
X-Received: by 2002:a05:6e02:32c1:b0:3e2:a749:252e with SMTP id e9e14a558f8ab-3e416109acdmr88472255ab.4.1754189910159;
        Sat, 02 Aug 2025 19:58:30 -0700 (PDT)
Received: from zippy.localdomain (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50a55b1ac2esm2251906173.1.2025.08.02.19.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Aug 2025 19:58:29 -0700 (PDT)
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
Subject: [PATCH v11 7/7] riscv: dts: spacemit: define regulator constraints
Date: Sat,  2 Aug 2025 21:58:11 -0500
Message-ID: <20250803025812.373029-8-elder@riscstar.com>
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


