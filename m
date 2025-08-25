Return-Path: <linux-kernel+bounces-784117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F701B336EE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 08:55:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDBCB3A5BB1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 06:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9071D2882CE;
	Mon, 25 Aug 2025 06:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="arhw7OK/"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E0B285CAD;
	Mon, 25 Aug 2025 06:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756104838; cv=none; b=WYFvwq45G3w/ZyOhnstZ2fcZ6yCujPO2RrBCYgZSAOxK2F1J4xflwDPACUMfzS4MsLPJzCDt9HLioYeWjEpl65R3Dh4hJ9ShW0qci1MVdEvDx0/oUJvYYwY8zCWInkfNiXHAKsYflkassh+LD2PVJ38hQLlVX1Y8ic1rvPf7jyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756104838; c=relaxed/simple;
	bh=U2QPDtzzoHNbc+CeY//g2qFfHMHiX03MFwlyPlEnZCU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hgh9bzH+XjayMQjSePGbk6gpf3JgHYINm0JZpWekWE7yl1E3CEn0WCuBg+BkP8EGqSLnVKr8qMnSU7sCAKKw06hcZq14s5n+ifCJnZyxpqcyl74cGPQBDc6dBQ/tosNMizlGdjiYBd4twRcmg2DjjOXershDo9D4nAJvLUzAc6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=arhw7OK/; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-76e2eb20a64so4513555b3a.3;
        Sun, 24 Aug 2025 23:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756104836; x=1756709636; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UxRfEcPcIN87oF3LCTOkdejufy+FFvG5+gjxZ5CrTbM=;
        b=arhw7OK/KbYrHCqWfGlDzuLYxRflNCgh/SldvU1qsEtWrOt4GC2nzbY9IKWRcHJzNX
         k1G0+f/BUce62CZrpWXEYaVhEGDc/1yCGrqH7O4cbJLNxZlFRa1tqwP1NgOTmxfKYFnE
         Cq27uoYR6CG6TQEJE3FNIoCeMX/ObdEv5XvWm34XTql2pNLjlsP7dIiMRnhUorQqipjc
         VmoiT8boFPXAP9E5ZdfsrxWkStnVd27YHoY/PdhOmsAqutNoJL6Xs2AmO3QaaOI7ryiY
         Bl0yyl5pXOUYf6h6mo3SR8iRlhA8eNyXcHCjh3PfKWWnRz63uPdMrIv3FAA6rAwFFDBO
         +RNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756104836; x=1756709636;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UxRfEcPcIN87oF3LCTOkdejufy+FFvG5+gjxZ5CrTbM=;
        b=qoH1DWidQWBmavZ9hVrNRZQBpREG+Fnc9ofs8jc5LZQWTFqfR+rpz3Cpc5105k9X1i
         sQDenxQbZTdpSaL7Xp+agZ9reeCPreuhPRvOgyiLhgJvF0qrgN/z0UkANZH5hOtqvpr9
         yAmiaLuvcCDy5LN0Bpbh7nQDWlIP1WKxXaD6Y1F6DMYNqgHqwzkOBfyfjMt0DTHBTC8D
         k5mdSv7d4Bk9wjn30ddbz6mhW9q7uOyjzv+62f6wQSMbk0EW7nQfOVwtCfARyuPeZQKK
         wsTDChv1A28QClSRRV2oHoqh+k0Rf1TYziWCHMaYAUEcuJ47TqoUPAITtYWmfTYdCgXv
         QqCA==
X-Forwarded-Encrypted: i=1; AJvYcCUO9Xh8H6CqsQgBg7+yLB44FyUy8GjhD56x2Rx/Wx67WwpobHLxkaBLor0qYFlstatL2O63SYMv6Y7r@vger.kernel.org, AJvYcCXXX2kkVvAG+As9g+DTHsQhVzrCpUmF67va2CT3hz4OiB3LvNY9lCvLawDGTkMx00RfJB4sSVyES9OD0SkY@vger.kernel.org
X-Gm-Message-State: AOJu0YwUy19gd8bdYhR+hTZzpaZdehTKYvokTZRmYCB4eV68WIa5ERXc
	iqj3e7etRrhbwFKfh8EDfiEaEUyflhCjXD+Vu+xnZDmeaH6Vl59JW4Ev
X-Gm-Gg: ASbGnctp8AACr3Oth0hVIgieRohyBn0zKWBfp/g1PXzQzIrf1i8EhX2uJvxr0aNwjwg
	Lr8vyuhXEL6chJB8PISioOYooOOHUnkIp3Inc+dfiB9YJY8OFjv1dAuMnFQEL+aLG1JdLOjP96A
	vZoZSSrlhp/Ou/UDQjxeQqtvBomjoNe7dAWFGMD+jgOQhjLrL1ald4gR6v/rYeQDTx8gtV2diC5
	LkD30RDgPA7FI3ZIMJQsSXzShKsNSuEEcq+het8FkydP2kcaog6hIOXRQSTTWY1K0TozwB7t66N
	leZohPrbm+c3hfmE0vaDMWNlXfBDroP2YRpAFVDBXw+Z6WpuVn6w494kFnS5Sm3fKdiAM9seSwS
	502iCnHdbr/qWz+//JxVU
X-Google-Smtp-Source: AGHT+IGx65vo/k+uU4ptdKOZZVOFUAizGlTJrjDMLm40OnK0Yn4YQiR778Z1RRh6I85L04R72QoA9g==
X-Received: by 2002:a05:6a00:2286:b0:736:2a73:6756 with SMTP id d2e1a72fcca58-7702faaf0abmr13315850b3a.21.1756104836565;
        Sun, 24 Aug 2025 23:53:56 -0700 (PDT)
Received: from rockpi-5b ([45.112.0.216])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-770401ecc51sm6604072b3a.75.2025.08.24.23.53.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Aug 2025 23:53:55 -0700 (PDT)
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
Subject: [PATCH v2 09/11] arm64: dts: amlogic: Add cache information to the Amlogic S7 SoC
Date: Mon, 25 Aug 2025 12:21:49 +0530
Message-ID: <20250825065240.22577-10-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250825065240.22577-1-linux.amoon@gmail.com>
References: <20250825065240.22577-1-linux.amoon@gmail.com>
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

Cache memory significantly reduces the time it takes for the CPU
to access data and instructions, leading to faster program execution
and overall system responsiveness.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 arch/arm64/boot/dts/amlogic/amlogic-s7.dtsi | 36 +++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/amlogic-s7.dtsi b/arch/arm64/boot/dts/amlogic/amlogic-s7.dtsi
index 260918b37b9a..d262c0b66e4b 100644
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


