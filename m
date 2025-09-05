Return-Path: <linux-kernel+bounces-802794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51157B4570F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 13:59:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 100F6A45B33
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 11:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3C3E34DCEF;
	Fri,  5 Sep 2025 11:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EV4xk3Ky"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A8034AAFF;
	Fri,  5 Sep 2025 11:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757073560; cv=none; b=Q6zkkAAzLDvDENMcye94IQ+p2mctGi2ahG2kRZKMdnZlUZeAedg5l013iULr+FWJn9A3jBuCrVQdsk6zD2on0pDF2DYMjiN7iMVD5727tTQlt5D1OsLBBgi3K8j4Z3bSPZ0ZRjEF5Ss85oQv99CM1h+ph9QHXYTalhySQPf3+L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757073560; c=relaxed/simple;
	bh=RBPoRigzqu0L7M6cQF7ct9tvshkzhxLz2FyeartmczM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m8eRj0Rgao45SlTCkbeYMz52YDb0LB1XRP/wQBNo/VZN4MSEQZLS6lZqkHVL/GN2wp+Ltjl5OCSXkayarsHgOzbpuBdrgaipXiyEYMh38r8K/JiYIZH9DGZ66OXsL/reEnkYdSEkU5R31HW7ikuWEm2zTThq6waS2yuCl6+9d6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EV4xk3Ky; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-772301f8ae2so1727230b3a.0;
        Fri, 05 Sep 2025 04:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757073558; x=1757678358; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SQRvt9uBTFMXXvpgLZGSa1xJHygjeYjUVBoxX6iZKhU=;
        b=EV4xk3KyO2c/LC8eZqq1h7W+/V2jphTuG4/B6Tc0RhdKGcMzmLNf4o9YQ7DRfyXhXP
         5WAQOmxoE5gOkc7DLssXWXhoRJoGeK+Ydc8AGvnm9FruOdBUSI6IxyaRygbYLkSQhbAk
         HvB0OZVsMBeFQZQHmlFTpmFpjhWwqO/KkR4SwSjAPpLPW16PeasklApPUXZrvmDMHgzG
         mivHNeV27BIUXo2ZD0kEmiFWdc3MGqaITqrIACXQjOxdFV2nkVBco+vmI2ZcIlXXKnlI
         9qExFc7i3jpYPfQdMwqgoUHIP8ztyEDNARGDkKZmMZXF6b5ptmTT3z7q3Y3zPp5qHqug
         eFow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757073558; x=1757678358;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SQRvt9uBTFMXXvpgLZGSa1xJHygjeYjUVBoxX6iZKhU=;
        b=P92hgHX5vHWmKOPBy5KqpQLd6oV4XwJZscZ1H8JltBNeLuCf9BeHu5UWwBj7idrKDi
         2TDE3omZYIS+g921QebX60hDSW6dec/nR+G19BY0de5jbDjil3EK4YGOo5tuUvd/n1NC
         WVm7ahdaMQWc8FA7bvI9O06mDysAofQ6b5Syhp7PgC93I0h9UzCUGXHob32a72zxAu2G
         KoADAqNUS5L/HSayoJV0R/favP7kkeAGxWDqiJM0hLfNaoWF/7Gj5KpXWHb3K9O4R3n7
         N5jWnxATWprdqcFSY7tI4njbj0bvVV5ybF71pHoia8ogz+9X04bOaU3pX8zpS7f3EMkd
         SKUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQAcfUiIHZJ8yjjjrVCMOcEWm1g+j1QSBX689sT52fhI5Dix+PLAZ3+eUqBZr2CHUpZmgV41Dgyk8q@vger.kernel.org, AJvYcCWvBVnSyFsJJH5WWjBo7WxkzPNPYw46CAfco8Uma3OVaCDGuI5vP++c5iEEIgRDialdjbkcn9/wEqafqP1m@vger.kernel.org
X-Gm-Message-State: AOJu0Yya20GmxgD1T5+aV6ykG37EdKx9xlNOSB3DBAnXoVCKfxio279d
	41H9kx8+t77xHrtX2D8P2OfY205jEWAhmDGvAmsgHjxl6NhregyNg4mD
X-Gm-Gg: ASbGncvaJSg2zI7f1Wm0qh+X7qkJrILEt4xTeyfeZRMbzBb2PH+cp3jdBryvyhknJqO
	ioUfrbZ1mPy+Cqx9k+a+pD3ezljZfcjO3pvhoo0yvJJdDQ/ug5xvVnwyZ7HdKO8PBSXomP7QfL7
	v370O3r5+XOOk74XAE/0fRK2tZykxNnfsJAtgtQ0whK3jrRrWNLUpl5HhUtTqGRfJc81cQL9gMe
	qaRLXzAk7fXzXH+Bhj6kUmCbczhlv7yKr8aWjKKxRM6aoFMyZCMHuiZaEaGc1BUvK/S0u4+jNVN
	+1aL2d01gaXDLkZBrrsYxTYqn4PE6Ytwh0Nz9Fig2k+0gNRzHA0oU8bTWOrw5tgqtAaKj9SJsMO
	o0jdUI0Ubfd+vnd5tgqHQ
X-Google-Smtp-Source: AGHT+IEA3O6qg8Al08yH+IcVx51Ms5/iMo7ps0M8H6/gioh1Dfty4GNJkVv3B6Xoq2XuN8YcK3anFw==
X-Received: by 2002:a05:6a20:7491:b0:24b:1a6d:298b with SMTP id adf61e73a8af0-24b1a6d2b96mr9339089637.34.1757073558057;
        Fri, 05 Sep 2025 04:59:18 -0700 (PDT)
Received: from rockpi-5b ([45.112.0.216])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-772396d2b97sm19633049b3a.67.2025.09.05.04.59.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 04:59:17 -0700 (PDT)
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
Subject: [PATCH v3 04/11] arm64: dts: amlogic: Add cache information to the Amlogic AXG SoCS
Date: Fri,  5 Sep 2025 17:27:35 +0530
Message-ID: <20250905115836.7549-5-linux.amoon@gmail.com>
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

As per the AXG datasheet add missing cache information to the Amlogic AXG
SoC.

- Each Cortex-A53 core has 32KB of L1 instruction cache available and
	32KB of L1 data cache available.
- Along with 512KB Unified L2 cache.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
index 2df143aa77ce3..04fb130ac7c6a 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
@@ -83,6 +83,12 @@ cpu1: cpu@1 {
 			compatible = "arm,cortex-a53";
 			reg = <0x0 0x1>;
 			enable-method = "psci";
+			d-cache-line-size = <32>;
+			d-cache-size = <0x8000>;
+			d-cache-sets = <32>;
+			i-cache-line-size = <32>;
+			i-cache-size = <0x8000>;
+			i-cache-sets = <32>;
 			next-level-cache = <&l2>;
 			clocks = <&scpi_dvfs 0>;
 			dynamic-power-coefficient = <140>;
@@ -94,6 +100,12 @@ cpu2: cpu@2 {
 			compatible = "arm,cortex-a53";
 			reg = <0x0 0x2>;
 			enable-method = "psci";
+			d-cache-line-size = <32>;
+			d-cache-size = <0x8000>;
+			d-cache-sets = <32>;
+			i-cache-line-size = <32>;
+			i-cache-size = <0x8000>;
+			i-cache-sets = <32>;
 			next-level-cache = <&l2>;
 			clocks = <&scpi_dvfs 0>;
 			dynamic-power-coefficient = <140>;
@@ -105,6 +117,12 @@ cpu3: cpu@3 {
 			compatible = "arm,cortex-a53";
 			reg = <0x0 0x3>;
 			enable-method = "psci";
+			d-cache-line-size = <32>;
+			d-cache-size = <0x8000>;
+			d-cache-sets = <32>;
+			i-cache-line-size = <32>;
+			i-cache-size = <0x8000>;
+			i-cache-sets = <32>;
 			next-level-cache = <&l2>;
 			clocks = <&scpi_dvfs 0>;
 			dynamic-power-coefficient = <140>;
@@ -115,6 +133,9 @@ l2: l2-cache0 {
 			compatible = "cache";
 			cache-level = <2>;
 			cache-unified;
+			cache-size = <0x80000>; /* L2. 512 KB */
+			cache-line-size = <64>;
+			cache-sets = <512>;
 		};
 	};
 
-- 
2.50.1


