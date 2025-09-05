Return-Path: <linux-kernel+bounces-802799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2548AB4571B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 14:01:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4374188D33C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 12:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B53D34A32A;
	Fri,  5 Sep 2025 11:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dzPTYwir"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C4034A32F;
	Fri,  5 Sep 2025 11:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757073590; cv=none; b=Xe/A+LC6db3/zo9ol8Zx+eIiRjVh4RtSO8NsxPnd6aG8K0u1gvTb7R9vn2fk5ij+Agx2SXh4DzXkPezqKrv/HHqQe0gkBrkocYLQ6dz2nO3lExS6/QU70VOid24EWN9ro6YBqlMcNmFGUPbvVqEFXyxMOJ3vp3yREibiG275IaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757073590; c=relaxed/simple;
	bh=2jcuAoog76kRgO31UwW6tnig0Q+AbLz8iT0OkxR1UIw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XKug0umt/V42gPdd7pKA73hTLhgHbfA7E2o9o8nyHwcFrU2yJRqS9ocrvYF5K4ybBsnIR9JezPEtVTfvYgBEehUirA6ka63k/eg7j9r+qP55It/vTLmpzBGJu/Vaot4T95VbU2CbuUXsNajlBGNOz751srtubdGir3US4SxIuT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dzPTYwir; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-32b590d819aso1675198a91.3;
        Fri, 05 Sep 2025 04:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757073588; x=1757678388; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xOEcXeUcizfvnu5+T09Xo7eSsAfydjLjWPzQfaUOV+s=;
        b=dzPTYwir0XRbbyHfgbe9nmYt2w7qTZOX8XYps8f87EBpPFi7HNY0eJcyYPu0KyETL/
         8ENOAsMoyN97NNF6T2LehmyaNQKeuCMUYDLzMcmGRMPotCylM+SRdTT7TSPOMOVbDUlI
         oL7io0vd509BDpy0qW6YVjnD5QKgrLKigNEtQPPC77eH0YYQhxgdDdzOXX4nTN1EnJlL
         QPoHU53QtD5C/V4mnuqMtinohKqo9fSzRRA46RCr9EM6srzsGa5qJkk2hSI3DzV4JCFU
         IB8NWqzfKZYEuij59EkDvluFzHwKhtO03U21eGljH7Vb/nQ6iCK+VVdjEbtAQCQzfoW6
         fFrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757073588; x=1757678388;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xOEcXeUcizfvnu5+T09Xo7eSsAfydjLjWPzQfaUOV+s=;
        b=iHbTG2EdY4BhJtvDiT67CgO4/WMBnroArYrAeeI1gyV0Q8rfpTDa2KAwj90sq/FKol
         Bd3gMqwvPxHeE8nTh9zcUtLB5y3SU+UjCrdK35RkD+GZNOsIUm7FwLKcTtrGoM8epdVX
         0HwJa+saIsgBkATNJIv7W4KL2ZRlTcs5Y/TPgrghM0ErjbzXUGBEkk0MKdhdaNKerydV
         STddKV1msZ7unZ1Or1i4wobotyUwChaiAOI8zkHeLD/vMC6swj7PHHcpUpGjFqTP9xXi
         4L3xs3X9jwMFDD0h8HPh/VlIehyoeSRgaEjHEkbj3pufVRySFQ33tLo9l/JL29/Pbj64
         StWw==
X-Forwarded-Encrypted: i=1; AJvYcCUWa/OeHRlKyl+fk/DxmOhVpYTve4J6tjRr2bIo0V3Sn/5QtjeFT1AJP+X+57Q59gMzWpcbkWZ1IcFxZxYK@vger.kernel.org, AJvYcCW1vZmXmKAGKilnMPZrh8O1pEq3SJkS+J2yoX7QSjth3scJPj6yOty4Pbb86TX1WVz/gRv39bSkHe32@vger.kernel.org
X-Gm-Message-State: AOJu0YwCHUlUH/udE4mHiFMzanTzC+O9VAvhvxdfIRSt1qLib+rslQWK
	c+kptRgnUNX0U0r/ApqZ/z5YCB69vvCiNXvkPp+x7NBRtXrP7WfBjgmm
X-Gm-Gg: ASbGncuRKHZQxTqCXzwzK7ZD9zajfloE/Cy/t/lmS1khJqL8w++J7xPbIUkakvW4lYz
	uKZSGShgOvqAfxTCXMWhs1F98YvwWh1bI/COAzKXj81L9FuABc1OvGkLM0rTnICqgcnmyLZevoZ
	diGsx0i47YuNwiYZgV+cVKKjBcNe0zDfNsdXvV4SyZz/zq8RMt0cQb6HMph7o5tuJwg6ttrJjhv
	GXVD61bP+STYjIY0bu7GXugdj4do0WrjNeTcTzrYQWlhVPZjHGt5XYjKcrNt38d+c6ID+7f2Nl5
	RTFbrpkbcqAdE7XEJYbpKmzdZIjfUUMoGUpgWQVQiYXi/0QlfxyBMomr8Fpd/D8fSB8ZdsEEtaM
	NzHAdK2zAf7qInZn/1eijkdWk2GDjJy1zQCgZPQaRzw==
X-Google-Smtp-Source: AGHT+IGSnGXMPfX2ToymDA+CKxfOFGpRs2YxaEW93/3sIQasItb8q0Va6j5MszBF7XBKNfyU+srCKg==
X-Received: by 2002:a17:90b:3c12:b0:321:2b89:957c with SMTP id 98e67ed59e1d1-328156e29eamr29316101a91.27.1757073588211;
        Fri, 05 Sep 2025 04:59:48 -0700 (PDT)
Received: from rockpi-5b ([45.112.0.216])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-772396d2b97sm19633049b3a.67.2025.09.05.04.59.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 04:59:47 -0700 (PDT)
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
Subject: [PATCH v3 08/11] arm64: dts: amlogic: Add cache information to the Amlogic C3 SoC
Date: Fri,  5 Sep 2025 17:27:39 +0530
Message-ID: <20250905115836.7549-9-linux.amoon@gmail.com>
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

As per C3 datasheet add missing cache information to the Amlogic C3 SoC.

- Each Cortex-A53 core has 32KB of L1 instruction cache available and
	32KB of L1 data cache available.
- Along with 512KB Unified L2 cache.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi | 23 +++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi b/arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi
index cb9ea3ca6ee0f..ee0b1ffa947e3 100644
--- a/arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi
+++ b/arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi
@@ -23,6 +23,13 @@ cpu0: cpu@0 {
 			compatible = "arm,cortex-a35";
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
@@ -30,6 +37,22 @@ cpu1: cpu@1 {
 			compatible = "arm,cortex-a35";
 			reg = <0x0 0x1>;
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
+			cache-size = <0x7d000>; /* L2. 512 KB */
+			cache-line-size = <64>;
+			cache-sets = <512>;
 		};
 	};
 
-- 
2.50.1


