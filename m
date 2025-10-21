Return-Path: <linux-kernel+bounces-863233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68B30BF74D7
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 17:24:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD2C319A129A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 15:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A481D3451B5;
	Tue, 21 Oct 2025 15:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="khth4l1I"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D1A3446C8
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 15:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761060197; cv=none; b=YjjyxqgGsugGJHOF33P/VJgmgJ3OM8yrUoCDDE0HT0UalINTiDkRlRiKL5gq3zWby3QNzjb4y2GJvOvcACY4ZQ9eMj4YbqMuIa/Gl3BWL1PjemoGg9OKDhObRPKi4aeU18/HkGb7zmQMP3UCc1fSMpMTNH8en/FRxgNhqabvJdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761060197; c=relaxed/simple;
	bh=Zt5q4iLPeiXhv3xhlSGQMsTacmCAuBuHa4mMAKTae8E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CHZSFgLwqq47kl+SlTuUTOTSkAIdvsChjCfeBpwrUPoxFYhRlEns3sZKoVH3sXpeFFZ9SVJYt156f4dnN88TkBxJFKUwL9EGJpMSJDyjWNGPq/LlQfZg7rNA1HswaEzuyx46hSpUuM0SN9cJ9HerjrJgcu1CC1ZS15uXeIouajE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=khth4l1I; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b626a4cd9d6so1147454566b.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 08:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761060193; x=1761664993; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JF1Khuy4nqLiE2y1n9lovRhx5obbKE7xwKO+d5/rlWI=;
        b=khth4l1I1jXUTHCCy3zsgCyIXuDj8yQM3azBsg0HFmOdTOqRTvapr05eA6f5HzVZsY
         jalkjLJF2B1FwNJsU8XNB+mmECn0s6D5AMoelzgqY9iYizObnXqbuubojkEYN5o3vDkt
         KuGFRrvkSBiqtXWE0MA9SnfjbsN9M01R3wwSJ11NSLxb/89aXfHCm8cOZ7NhsabOvdYN
         w+c6otsk/siG/WHOtXQae3ZmBN3o/T2q6reZAXjCK9nv8yC10UZ3R0jj5jcRAoe8BG5m
         Xktp2hXjOOHdNPEcsa6z/c8IJEL5hzsFd2oE/SvMJKgWPYzepJlcBdAMxLMLf0AotB5f
         1uKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761060193; x=1761664993;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JF1Khuy4nqLiE2y1n9lovRhx5obbKE7xwKO+d5/rlWI=;
        b=cDrt6aTrScl4Nct30d3lMSH0gqCz7GpO8YAWtpSsKZkVlJ4JDwYrO6o/ssLyRhpMeR
         mILlPCwI5Qn9CGPw6j3R6uirmx8gkHWapdsrdxKqD2LDbl4wrF1bJEkabNFOjX7YLp5R
         PInT6B87OFaLJm/tUyMvllV+mooKL0UjipPswBerZAQAL0WIv4ifC5TE+EJk5Bnznlk2
         8uxwbBIdhU62hf1YbqD7vUFiCGIIHj/wyF9WsGyxsVauW+LwUHcj6K0hVYPctrp3zo5f
         b2jVSojmtyd2N6ecN9/g6ZFaP10gdpvZy9vbhhbmvS3q+lNBX7w7RoOJib/QHnDWSOks
         p9kw==
X-Forwarded-Encrypted: i=1; AJvYcCW3YSKy+OAD13v79+Zah9+c1FQxmp+WqK4cvjfVPrMbhzCcQYvOjHM5lpLbEmnQCr+B4IjZAAHSA5UFOYc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiAEgIBRRi097dbKQhBy3HVdp3WkHkAo1dYFCflOxbeXYQrXEh
	wjiwO4QB5wmB60HN6rdiNG4/vK8UgNQ/4Cz74BZT+ZsRvBpuUZG9sZsk
X-Gm-Gg: ASbGncvcojAhgu1Q0l9PT42oL7r88h8WN0dZhX7NydFmz0sBNuWcUsTMebwkpr5beEH
	pHrURnwzP2aTyZBCDl8Sjp2JM5dLm4L4/bMmUYgAIbfL6OIFy0alTdrSm66d7M57GSUSLGdVicv
	etw25qDbmj1DU/PEaPJCb6rSviquZV5QXlrzJWtK7WU7H6imbBivG7HSxnCKA6El2aenXk4KkNd
	SzwMQc43bHuOlzacyBF7gnaU5l+X5z582BBvU0RaQuKRzuMUoFQxAgMTKby08FiGehRDVxR0wf5
	rQxXTrIqhuRhvkHEXamDcsjGWU8VDM9PgRg53nqv9z5kfo/P2Ajav31XbsE/WOvhpLGCCohQSL2
	uyyonnAuUlO/HQZCEBhoCMm4lKNTvfF/WVBH0tEFql41CggFyWbvlEuFZ7WFoq/B4wHAmWkVs2T
	nAaKQIuyeAA6ZYKOnuaRZe3zOCdi1ge2v329SWAA==
X-Google-Smtp-Source: AGHT+IG8ZMx/3IH1gWXA/kMHWe4Ced895g7GfNQEjLkqqPoqoeKq+HY9fH6rztVBxeqVkVrZOdbVkg==
X-Received: by 2002:a17:906:794e:b0:ad5:d597:561e with SMTP id a640c23a62f3a-b6475708a50mr2149204266b.56.1761060193479;
        Tue, 21 Oct 2025 08:23:13 -0700 (PDT)
Received: from tearch (pc142.ds2-s.us.edu.pl. [155.158.56.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65e8581780sm1082737866b.31.2025.10.21.08.23.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 08:23:13 -0700 (PDT)
From: muhammed.efecetin.67@gmail.com
X-Google-Original-From: muhammed.efecetin67@gmail.com
To: linux-rockchip@lists.infradead.org
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	heiko@sntech.de,
	neil.armstrong@linaro.org,
	lee@kernel.org,
	rafael@kernel.org,
	efectn@protonmail.com,
	daniel.lezcano@linaro.org
Subject: [PATCH v3 5/5] arm64: dts: rockchip: add Khadas MCU and fan control nodes
Date: Tue, 21 Oct 2025 17:22:45 +0200
Message-ID: <611deaaa0e408eb042db7faf215b85370569edeb.1761059314.git.efectn@protonmail.com>
X-Mailer: git-send-email 2.51.1.dirty
In-Reply-To: <cover.1761059314.git.efectn@protonmail.com>
References: <cover.1761059314.git.efectn@protonmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Muhammed Efe Cetin <efectn@protonmail.com>

Add Khadas MCU fan control to Khadas Edge 2 with 4 fan control levels.

Signed-off-by: Muhammed Efe Cetin <efectn@protonmail.com>
---
 .../dts/rockchip/rk3588s-khadas-edge2.dts     | 58 +++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts b/arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts
index 2c22abaf40a82..ed5168d50e182 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts
@@ -271,12 +271,70 @@ hym8563: rtc@51 {
 		clock-output-names = "hym8563";
 		wakeup-source;
 	};
+
+	khadas_mcu: system-controller@18 {
+		compatible = "khadas,mcu-edge2";
+		reg = <0x18>;
+		#cooling-cells = <2>;
+	};
 };
 
 &i2s5_8ch {
 	status = "okay";
 };
 
+&package_thermal {
+	polling-delay = <2000>;
+
+	trips {
+		package_fan0: package-fan0 {
+			temperature = <50000>;
+			hysteresis = <5000>;
+			type = "active";
+		};
+
+		package_fan1: package-fan1 {
+			temperature = <60000>;
+			hysteresis = <5000>;
+			type = "active";
+		};
+
+		package_fan2: package-fan2 {
+			temperature = <65000>;
+			hysteresis = <5000>;
+			type = "active";
+		};
+
+		package_fan3: package-fan3 {
+			temperature = <75000>;
+			hysteresis = <5000>;
+			type = "active";
+		};
+	};
+
+	cooling-maps {
+		map0 {
+			trip = <&package_fan0>;
+			cooling-device = <&khadas_mcu THERMAL_NO_LIMIT 50>;
+		};
+
+		map1 {
+			trip = <&package_fan1>;
+			cooling-device = <&khadas_mcu 50 72>;
+		};
+
+		map2 {
+			trip = <&package_fan2>;
+			cooling-device = <&khadas_mcu 72 100>;
+		};
+
+		map3 {
+			trip = <&package_fan3>;
+			cooling-device = <&khadas_mcu 100 THERMAL_NO_LIMIT>;
+		};
+	};
+};
+
 &pd_gpu {
 	domain-supply = <&vdd_gpu_s0>;
 };
-- 
2.51.1.dirty


