Return-Path: <linux-kernel+bounces-802800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D855B4571E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 14:01:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D6741C253BF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 12:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B86CD34AB04;
	Fri,  5 Sep 2025 11:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tzu8hnMO"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F6034AB01;
	Fri,  5 Sep 2025 11:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757073598; cv=none; b=Fhh/VT8ChIe46J9xYPdDBFEOpKtN9qFAY+jUlg2LiWPjz/DzHrt7hJyU+cXHbB7jdmGgPOw5SoHJwwFxySUfMIsPwrdlqVWXhbcMcjx1rnXXppunMG+oF47m+XeYopTSWmh42E5mgOHzO8ZA7MAgK8LGr/9wR2lhBoXzvgzNtnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757073598; c=relaxed/simple;
	bh=P3ZT0SwEy2ErXGFxoQZ/NhyjJBQn4di3uS5AJsf5hk4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LZVb1Rk20+YEQuIxNSmMz/t4Jo4qoS3sJI7UgC01CZM04t903kFEDU47G5y+10boDKEfB/FRC/KcWpA306b6hpXOMsjCoiqgBigP6KIgrfQUR4ApT3hjxzW/tM91zUtp4NgMd5dNZF77udQ5zev3jE/8mJGSQqdjwu+krtGQFS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tzu8hnMO; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-772481b2329so2202958b3a.2;
        Fri, 05 Sep 2025 04:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757073596; x=1757678396; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e6lU5THDhGfH0NkCBr9PUmiRxUFviaMJiioV8NyaxaM=;
        b=Tzu8hnMOEBxxOxcx/MG0dt1mzT4fpthMeSHTDBm+ce2Oqoflsf0aIZJw/SY/HXB3vT
         8P9KHT/Yux1kZcW/r8/ZY463m2hsjV/WDbwk6klImhHQ9cpiZ9ddvGOAyiVlQbDU1xJ7
         gaYFWQpuf32vFumNssmyfcrTqix+P4yQrG2jzEcR1fIVBYd1AFplEmcpTXk3O3vStlsU
         BcJ32ElhBNzKz2qTPLe+DYD4w81ANH9FPtYK7gmQeSV/Crj3QnvIDPED9c1kZeDKRt1v
         TWBL+z32ajByBb6BL8MC+dh5xjG+OSiNqfPNiTLAwK2wdqI0FLYA4lmrUd5sfg3TxYlx
         a8pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757073596; x=1757678396;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e6lU5THDhGfH0NkCBr9PUmiRxUFviaMJiioV8NyaxaM=;
        b=D/dGR90EYaDVSiU55YUEorJ0JYFCPHeee1EaC5oLeH7xSVRyUFHlZrg8c514lx2D4s
         0Y+teGsbEtM1j9V51Ajgy1T6jIoGyTGpFgv/NN0ngThBwz6NzvrMuHCtSHpbxJK32/vy
         9ZplWo1YvilBzbKMa7eoJJU4U/l+S59XVwGZa/GJb9Gy5kJ8TPFcNBLe96WQXQS+NyxS
         MBqkz5cmCQJ1geAIZdGmMuMwqXrYI0VhHt+jftXqw84yYjQ1dM08R7ykzaZnGkGDL0Y6
         jRpDNPQeB/zuyt2u99Gwqj1pEO/kENdXo4xUKfh9KFxjwRCs+Zd6cQ81iVNaUg9ogDrk
         cobw==
X-Forwarded-Encrypted: i=1; AJvYcCW4wFkHuRXMWmCq+WKOEm7QLKH8I4nJo/5Ql5Rc0YhRME4it5WkDzCpBF6G6G7wp1kl+3DjktMmLsjMdPXc@vger.kernel.org, AJvYcCWmvMah4AGFVVzvgIKRNsA5o1KB76cHj0Mx35IQCY+zCzJ7v6cHhdkfu3NAi4Dv2nfDyBhwGICDu43Q@vger.kernel.org
X-Gm-Message-State: AOJu0YxaOEGVW6axRs9P6RVbVIJ5FfZr33mP90AieWxexZgVm73VyOZC
	BQodsEGXJBYkKzqH+OTVdz2dTjhy40Oviyd6/CJDFeROBL4912yhvwPZ
X-Gm-Gg: ASbGncukifSOBuiobuQD7IrXupiSG0WSVUz4d+PiilG1KdjR15Xzf3u/Zzr5K5LZEmg
	V2WavTDh6AhGXJA4wJK60j9pSthy6A5QmbjKgn8sGyLGFxKAMidO0uTDFcd9VwF8J+bcVPrANkl
	IpCJiAr8649bj4cLBPoehaGH1koc6ZAf50qzvtxzZmatFpQ5WDmD80b+Zpw6oHpahOOylmxa2vr
	ZVY3xkrBNVJeVawf+EzVmDn7XzTtqt3hfl8Zdb2JWc3P9vOSEcdxZgkOnv0EfWEEPLPAB41N5h6
	SVau8xql5SC+xp9ywX9AT4hJbhOR1gjHG5FsJbyA2134x8H0Sz00KuVMnA/jpySOC8Lw7fGwF/K
	EF1fnPVd8FtJnEKQn5XO6ZQ4UeQk6EpI=
X-Google-Smtp-Source: AGHT+IGDRRzImt80hnKOwjC3oy3EHzVKBpOPyAHYFUXou++MQpCklyjW9Y8n+lPlMxc25VtzMQ+L+A==
X-Received: by 2002:a05:6a00:114b:b0:76b:42e5:fa84 with SMTP id d2e1a72fcca58-7723e21e9aamr25229563b3a.7.1757073595856;
        Fri, 05 Sep 2025 04:59:55 -0700 (PDT)
Received: from rockpi-5b ([45.112.0.216])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-772396d2b97sm19633049b3a.67.2025.09.05.04.59.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 04:59:55 -0700 (PDT)
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
Subject: [PATCH v3 09/11] arm64: dts: amlogic: Add cache information to the Amlogic S7 SoC
Date: Fri,  5 Sep 2025 17:27:40 +0530
Message-ID: <20250905115836.7549-10-linux.amoon@gmail.com>
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

As per S7 datasheet add missing cache information to the Amlogic S7 SoC.

 ARM Cortex-A55 CPU uses unified L2 cache.

- Each Cortex-A55 core has 32KB of L1 instruction cache available and
	32KB of L1 data cache available.
- Along with 256KB Unified L2 cache.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 arch/arm64/boot/dts/amlogic/amlogic-s7.dtsi | 36 +++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/amlogic-s7.dtsi b/arch/arm64/boot/dts/amlogic/amlogic-s7.dtsi
index 260918b37b9ae..d262c0b66e4b5 100644
--- a/arch/arm64/boot/dts/amlogic/amlogic-s7.dtsi
+++ b/arch/arm64/boot/dts/amlogic/amlogic-s7.dtsi
@@ -18,6 +18,13 @@ cpu0: cpu@0 {
 			compatible = "arm,cortex-a55";
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
 
 		cpu1: cpu@100 {
@@ -25,6 +32,13 @@ cpu1: cpu@100 {
 			compatible = "arm,cortex-a55";
 			reg = <0x0 0x100>;
 			enable-method = "psci";
+			d-cache-line-size = <32>;
+			d-cache-size = <0x8000>;
+			d-cache-sets = <32>;
+			i-cache-line-size = <32>;
+			i-cache-size = <0x8000>;
+			i-cache-sets = <32>;
+			next-level-cache = <&l2>;
 		};
 
 		cpu2: cpu@200 {
@@ -32,6 +46,13 @@ cpu2: cpu@200 {
 			compatible = "arm,cortex-a55";
 			reg = <0x0 0x200>;
 			enable-method = "psci";
+			d-cache-line-size = <32>;
+			d-cache-size = <0x8000>;
+			d-cache-sets = <32>;
+			i-cache-line-size = <32>;
+			i-cache-size = <0x8000>;
+			i-cache-sets = <32>;
+			next-level-cache = <&l2>;
 		};
 
 		cpu3: cpu@300 {
@@ -39,8 +60,23 @@ cpu3: cpu@300 {
 			compatible = "arm,cortex-a55";
 			reg = <0x0 0x300>;
 			enable-method = "psci";
+			d-cache-line-size = <32>;
+			d-cache-size = <0x8000>;
+			d-cache-sets = <32>;
+			i-cache-line-size = <32>;
+			i-cache-size = <0x8000>;
+			i-cache-sets = <32>;
+			next-level-cache = <&l2>;
 		};
 
+		l2: l2-cache0 {
+			compatible = "cache";
+			cache-level = <2>;
+			cache-unified;
+			cache-size = <0x40000>; /* L2. 256 KB */
+			cache-line-size = <64>;
+			cache-sets = <512>;
+		};
 	};
 
 	timer {
-- 
2.50.1


