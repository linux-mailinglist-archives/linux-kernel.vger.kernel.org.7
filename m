Return-Path: <linux-kernel+bounces-802798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FF07B4571A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 14:01:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CF131C869AF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 12:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D685350840;
	Fri,  5 Sep 2025 11:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pq+VnWzC"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7232634AAFD;
	Fri,  5 Sep 2025 11:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757073582; cv=none; b=btozj8IMl0g+Vw7K/Ukr3woc6swy+GFb1ASaUSGbCNBzBobA4M3HJEPCNfGMVn8zbjNxvIgtarRl0X1IVbwAKYKlbaYE8OyYamPw+qISrLsYd6g5kk6nfHDTok5Pyw8kMNX2BWTo+yZjVxnbrGOKJHpBkRrrXU7t6yqyIWitX/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757073582; c=relaxed/simple;
	bh=DguBEiQsYWFDhrLnesFndx4m3uklMpioQ9wv5xHBPEs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fYG94r0PeZahcGLMzFHjNUn0TqbXYEN8CjITyufaP2PGsSODGTn+oNzjEhJimq6fx+7RrAzUhtWuPnLAU4Zr/i2JlW6xaRZls80ox3FlHNQQ+Q2xvQ3hJBJIDjPu5QNK/tbIHHuLyo7Zj4FE5sQyA1e4s7cSpmOIXOzYaN2ypA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pq+VnWzC; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7723f0924a3so2809654b3a.2;
        Fri, 05 Sep 2025 04:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757073581; x=1757678381; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yfusC6FdHMxDdfI3s8bgNXW0JeeMt/mO+ot1XvJ8c04=;
        b=Pq+VnWzCcPMsM5wA7RYSg4G4qJFeirXpQPw6KabNXKbTuG5SK5vzF8xvgJe5+4kOBB
         aQdASghkmiiOkAnN2h618NQs3qlBu742ov2HFjMj3UoMmXqnDj7nMD1Uk5vOvNQIuGUf
         5tD56ursHv3O+h2CoGjU2mJLkaY7MM7hlEfnZ27SpQJWseSR+in/TXcelGYlAPG53evO
         lM81lC4asPxg7EYo3SflNQqDrcKjKHo7DjhC68Daehvc3B7hy0fHXDNGdF0JHp4Xs4P/
         grvXXGBJ4EdHcPy7JAJV7c/6pavIG3YdKQVtDLmMrKQDitV3GHdyoJas8lM5Rlx/5PH/
         uI/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757073581; x=1757678381;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yfusC6FdHMxDdfI3s8bgNXW0JeeMt/mO+ot1XvJ8c04=;
        b=vWETfUiNsllRjjWbdhUTUDRduEsYxT2uMjNMZWYfuNEqJWj5qXFmgjIZ6oXKO7iy4x
         fPjLVPe9HcpdHEVWCGlq3cO9IE4UQ0sWUdrZF1RbpiLRIHhX9ZL4cDNzDYXGBJAWipGw
         TDitStIH3WZU2C0dQoCbigSYNTTKdwfjfr60LTBVozpeyWANjrCdWvcGsBr3PFVTHhxf
         4x9QWIb5JMpfHIFmpbS6sSxo5trMsLcu31irB5Q67k/QLkPjDmauV6yyWCSP4zsKA+Zj
         ZwXczB5zvvNuD1G2jxhsJcgzQ/WzOHwNslImZnYIkyiQe/For8gTHd0USnfLfS7sJiXe
         du8w==
X-Forwarded-Encrypted: i=1; AJvYcCX66Ne9mishvYwtf24nyUYCod79HPWKXNa7J2kFihb3OTRdR7BXffGqSiXa6uvvJ/dnDVnZXg/mWQhC@vger.kernel.org, AJvYcCX6FRucWCouxmnZSKwieYAHVCldrrrDz2eRc+I/yxRMHtnmMtnMQkQ1m0oXyqsCKuHExXIi8YaHt7ocLlGo@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9hsOWP6XhmP1eBG3K/djjX0LzqaXikUt6BzaWr80IvvIgdgZw
	cFiR+r5xdZFxrUIhBTSp02Fs+9vwjn8ssMyyDeGuQFps1Lcvl5OiMnAt
X-Gm-Gg: ASbGnct2LABqeT+cUmv6TcFVIaKEptODgw2FBd+b0eONra/o1lPrr3Zw6MB9wXHnNhK
	eZDtSHaGaBazlptxN9t1QupL4ooeAGCtKg144KE68J4lLODZ2bY8BOW8FhqTTUzkKbxJuvc1Y+l
	D3Kdx/N9RHy3a9C+e72AkJn+vJeD7s1Eltdp9oC6YphdNKZ5e2cunswiSu3gsh+h4pUYttcdqBA
	eA9E+NqXELOjMFr0x/ShXVdcdb9siIheX8uQEOMPx+XmSXgP39FAIlKNg9ng95fzV8hsvC4o+wA
	FwKMt0mflkaUsiDg2CPK5CSYO/6Xib61/a/1VpnGHDUuGKRDsa/4QrNqiuIC/BktFdmCwmerYTZ
	6zdEM03iE9kMIlku9mPWk
X-Google-Smtp-Source: AGHT+IFoZYigQbwEW4Vr8mbtasCWDC6i9hDthzyIkXHkuRGQriltAlc6nbmtWMDmJtJfFGnb4kj3FQ==
X-Received: by 2002:aa7:88cb:0:b0:772:638e:5f72 with SMTP id d2e1a72fcca58-772638e6165mr21255920b3a.25.1757073580767;
        Fri, 05 Sep 2025 04:59:40 -0700 (PDT)
Received: from rockpi-5b ([45.112.0.216])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-772396d2b97sm19633049b3a.67.2025.09.05.04.59.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 04:59:40 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Amlogic Meson SoC support),
	linux-amlogic@lists.infradead.org (open list:ARM/Amlogic Meson SoC support),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Cc: Anand Moon <linux.amoon@gmail.com>
Subject: [PATCH v3 07/11] arm64: dts: amlogic: Add cache information to the Amlogic A4 SoC
Date: Fri,  5 Sep 2025 17:27:38 +0530
Message-ID: <20250905115836.7549-8-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250905115836.7549-1-linux.amoon@gmail.com>
References: <20250905115836.7549-1-linux.amoon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As per A4 datasheet add missing cache information to the Amlogic A4 SoC.

- Each Cortex-A53 core has 32KB of L1 instruction cache available and
	32KB of L1 data cache available.
- Along with 512KB Unified L2 cache.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 arch/arm64/boot/dts/amlogic/amlogic-a4.dtsi | 37 +++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/amlogic-a4.dtsi b/arch/arm64/boot/dts/amlogic/amlogic-a4.dtsi
index 563bc2e662fac..fce45933fa28b 100644
--- a/arch/arm64/boot/dts/amlogic/amlogic-a4.dtsi
+++ b/arch/arm64/boot/dts/amlogic/amlogic-a4.dtsi
@@ -17,6 +17,13 @@ cpu0: cpu@0 {
 			compatible = "arm,cortex-a53";
 			reg = <0x0 0x0>;
 			enable-method = "psci";
+			d-cache-line-size = <32>;
+			d-cache-size = <0x8000>;
+			d-cache-sets = <32>;
+			i-cache-line-size = <32>;
+			i-cache-size = <0x8000>;
+			i-cache-sets = <32>;
+			next-level-cache = <&l2>;
 		};
 
 		cpu1: cpu@1 {
@@ -24,6 +31,13 @@ cpu1: cpu@1 {
 			compatible = "arm,cortex-a53";
 			reg = <0x0 0x1>;
 			enable-method = "psci";
+			d-cache-line-size = <32>;
+			d-cache-size = <0x8000>;
+			d-cache-sets = <32>;
+			i-cache-line-size = <32>;
+			i-cache-size = <0x8000>;
+			i-cache-sets = <32>;
+			next-level-cache = <&l2>;
 		};
 
 		cpu2: cpu@2 {
@@ -31,6 +45,13 @@ cpu2: cpu@2 {
 			compatible = "arm,cortex-a53";
 			reg = <0x0 0x2>;
 			enable-method = "psci";
+			d-cache-line-size = <32>;
+			d-cache-size = <0x8000>;
+			d-cache-sets = <32>;
+			i-cache-line-size = <32>;
+			i-cache-size = <0x8000>;
+			i-cache-sets = <32>;
+			next-level-cache = <&l2>;
 		};
 
 		cpu3: cpu@3 {
@@ -38,6 +59,22 @@ cpu3: cpu@3 {
 			compatible = "arm,cortex-a53";
 			reg = <0x0 0x3>;
 			enable-method = "psci";
+			d-cache-line-size = <32>;
+			d-cache-size = <0x8000>;
+			d-cache-sets = <32>;
+			i-cache-line-size = <32>;
+			i-cache-size = <0x8000>;
+			i-cache-sets = <32>;
+			next-level-cache = <&l2>;
+		};
+
+		l2: l2-cache0 {
+			compatible = "cache";
+			cache-level = <2>;
+			cache-unified;
+			cache-size = <0x80000>; /* L2. 512 KB */
+			cache-line-size = <64>;
+			cache-sets = <512>;
 		};
 	};
 
-- 
2.50.1


