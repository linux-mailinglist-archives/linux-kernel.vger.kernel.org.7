Return-Path: <linux-kernel+bounces-740843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5877FB0D9E1
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 14:40:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C8C51894C85
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 12:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C86F72E9EAA;
	Tue, 22 Jul 2025 12:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eaAM1AU+"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768D12E9ED6;
	Tue, 22 Jul 2025 12:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753187971; cv=none; b=n67kgpYAnfCrLlZ8RLeXf8VgpZ9CKSNfMXoJ6sT4z1WsvdS6C+RNjufEK9zN1VUmRfJtKDW82i4dXj9LI6101IdtSQbTdgrufuBGdylyMNSEGtYv2blDlurNf3eyGkYrmoM+lnv/cpEEIGveyf5usxuKFujJK9lUoc5m9SqzkJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753187971; c=relaxed/simple;
	bh=h1i5d/o0sGu/0M88il3A3ZgIzUmNyYbj7vvQvwk/xco=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=njHP+7wwdOr1wY6pC7KKTq1f0s2s5JkusWCivKShM3kqbQgFqJ9hXhZpwCt4DBfvQ78fB/EstgDbw1iahpEeurrrn4SX1TBQmtPB0NwCKZTUnoFq8KMfIKOwU2a8qkodzAhn/LG2RKUPxoo8mEYdyQagpupu8VUuL1rsv/4IgD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eaAM1AU+; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3b611665b96so3064039f8f.2;
        Tue, 22 Jul 2025 05:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753187968; x=1753792768; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1VY1KO4QAZzZFGNRNm4f5tC1BzdVHx6jlB4mstLlz1o=;
        b=eaAM1AU+OWCLCvFXx3javTbEMfqpK+dxCuZ/daqvznaWuCScgTtjsxM2FQ4R/ajN4I
         /waWLREC6INauzB21EER/2EBjrKQeDq9gaO/EbmlO6SxR161vTEWwgswcbZvKt1VzKef
         807JqlL52e3ZWpNHJ3MZu2E9ao0EoIHWHzg2Ee7Tsy5gXoatqStvLbCbUweEa4iggA1J
         NB8ad1LwgTaLdjrSHidyZk3CdDmUfChPt//Cxfsn+xEZLRB44zRc/KuElH+/hsW0n+WC
         xlvcRpyI7TqxWmyNuAw+DqxBONqLriHSnkH3EmzEg20yGBj7WFraoAOLwq0AbGL1HWv+
         P+Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753187968; x=1753792768;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1VY1KO4QAZzZFGNRNm4f5tC1BzdVHx6jlB4mstLlz1o=;
        b=Qg+awZOSNH3ya9MFe3tJkUC39JEIcCFl68QD9snkdDBunGPWoyc0HXLEV+gzhlhIrs
         +XP/T2ItLgP+E8UJKVJQzc9PtqTstY8hLNgLAAgtZURZ5sJPapYFRzeRkLzZLD8cQGeg
         pruaziaYNmqrXbCjYff5upwsnTZ0aCHDnVxXbvYkxh23gkzUEjBggDi+nwANC9e4+Z1g
         5y6PWtPPy1AtkAD8x6OPejrd3QFgwzddlC5v9q+YXLzuRTlrESh9oDqs7T/3xm9OWN7i
         yoVCyhfgPcj0rmWJ18occk5drBwFVn0oea+RXdEMFhSZSiLYOjZSpB5Mwaip8hd55Ag6
         pHWg==
X-Forwarded-Encrypted: i=1; AJvYcCXW57Avy/q6NCkGUS95hXThTTXobu7NBn4GHGl12bX40CqOyTLU4eYElqZFTQvVvbnxvi/7inBxVMahaXI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoEMi6rq0exhYv3qkCkU1djMXYaQMBvm1QuL7nnoXilbvhUc6z
	OHRKKwTfrahJcJnW4EqplA7Dfrv/uVyZaAuHal7CL+2fTF2K0ZLH6DD0
X-Gm-Gg: ASbGncsWb456LYbFGrsegft7Qr91Q5VJvhWmufjywi2CbugIGXjgvKrsU9DvsjVEW5D
	+vrgOUlCOa9MXLuXv5mNgkyFY/tDygBGwteAI8UzXxiJ7GwzuxI+dzwNSEZMAFSQY+akox4f5jr
	53jZjrBiF1/TRfuLBnXnAynwmfmLIEVMABdhR+TON6C/eXnB0on+rfQO+mrs2GXf9MJI5GrEuzO
	te76FcgWKd0JikhypFf/0uuTcLYDL6AR8QMrIEzn9DzEak00BGkkj+6Jh6byQCgOIDsp9jS+I/t
	rCggRScU5Q5+VBdhmD33qj4VmpBFae9RBEvska19arthoLKl5gEWCa29ULifGMYwDJb7xHbLWPp
	D97/zhuOe5v6vhrC3ENTkjTtEYf0=
X-Google-Smtp-Source: AGHT+IGsyl5w75I2qFaIzkSqXqTnjmKpHDiAq/bQSwW3RqWK1nxdztJM9kKX9bkY9kK7dSxs0XmxjA==
X-Received: by 2002:a05:6000:1a85:b0:3b5:e6f3:ac9b with SMTP id ffacd0b85a97d-3b60e4c47fdmr20541975f8f.5.1753187967431;
        Tue, 22 Jul 2025 05:39:27 -0700 (PDT)
Received: from tearch ([46.104.48.188])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca48c40sm13525197f8f.58.2025.07.22.05.39.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 05:39:26 -0700 (PDT)
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
Subject: [PATCH v2 5/5] arm64: dts: rockchip: add Khadas MCU and fan control nodes
Date: Tue, 22 Jul 2025 15:38:15 +0300
Message-ID: <1e4a191ff94098a5b086a83d14b37944351242ab.1753179491.git.efectn@protonmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1753179491.git.efectn@protonmail.com>
References: <cover.1753179491.git.efectn@protonmail.com>
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
index 2c22abaf4..b51b64732 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts
@@ -271,12 +271,70 @@ hym8563: rtc@51 {
 		clock-output-names = "hym8563";
 		wakeup-source;
 	};
+
+	khadas_mcu: system-controller@18 {
+		compatible = "khadas,mcu-v2";
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
2.50.1


