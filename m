Return-Path: <linux-kernel+bounces-882891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 40EA3C2BC2E
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 13:44:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 58547341F70
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 12:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34C7F3128A3;
	Mon,  3 Nov 2025 12:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="JUKQlON/"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967D6306B00
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 12:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762173617; cv=none; b=d3HfV3XltrX12W/LnOZz8rXo1RLZVgjVFr5VKecethi9UWJBMpo6K6ySJ3JcXwa61pnGhM4TCGYUUucF5raLztCRYWlfhVpMGcoRBhHSGXdK/z1OoTx4d7Y//aJlVHLQ7bm4Ch/Om2n2KN+Vita6cuOBWW7V7Eh5DAsvSZZ/aUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762173617; c=relaxed/simple;
	bh=ewnVTjrK+RQoWcZSJk3a3VufQN4Z70DOdAXgMXn6M70=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A1ozR8kN8NVnF2S5m/vBeRzckxHXc0Og32xN+svgh98fqqoKoXt2Th1ul/JKKH8GTHinTpPF5WduKjJkhMQcwWi3Yjq6dkUtBXIpx51zOY0dfD1LxAqTBAyncPBqcmD1AcaNzuGrCWc98jv4eeaLH0r/sT11JxklFIz8bfodN9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=JUKQlON/; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-640a503fbe8so2630530a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 04:40:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1762173614; x=1762778414; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KA4oUZwX0z4qIkAync1NbIUw+gj3BAYqhFw1et34T6w=;
        b=JUKQlON/huo7g3drJ44XFwl+WtdQD15uI5PwXV3ljgF8ejA2PCNFZBabegs/ZKfFQ5
         u0RPT3tXG09kxFMuqXJ0RD61jNqHKIzFE9HmCM08W29RSOf0WQQ6re9ethjqkLtIQC1o
         PDQu2B61SqU4S5fNbKto+SKkoe5rgBd12wiFuc5QsPuQdgZeQfEEmVgtdBokXNztOlaM
         d/VMbUp5PqBUX9DFTaSDYQgvvO8X/JyaEFe5wqE1sUNohPokHM1GzRisDlkUx//tQVb+
         lcenEL1yr72o7yME29G1jnpY6i7VdUeVsIZRnh3TubKCVzlS611Q+qZTO5twT8BcaWNb
         8JZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762173614; x=1762778414;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KA4oUZwX0z4qIkAync1NbIUw+gj3BAYqhFw1et34T6w=;
        b=JsUjFEyBpiQLcBbYmgBv2lB3T4QX2eqdNM3JUc85D4Pf+TqOXPoXtyuwV5tbh+XPmG
         OfV93KxorCXn/CZ0v1bE7jxk2CbuMj+Nqr6h/LRNyQoSD7Zb0gmngblLI8S3HZOKLZOx
         3O7a59UKr/iMI5qjJ086hBzMGDq4Rk+dxiasHKnFbuwxo1ZOKSqY1HnB5Wk7gJwQ0WEv
         QXrF0Did6rceCUqgledS1W6atrepRSh3P51eZIqGOPiwzIzPsxbHGYU6yJ1F6qNIiW09
         86bYxM45Aj4edlOyxqmEgRbVftz/wjNzAIJEF04KmDM7M7cyKawoCvJy+EsSaasGC/VF
         zOKA==
X-Forwarded-Encrypted: i=1; AJvYcCXAMe/9jOX1fzBaefYWqdoVu/wrkej0Fk97WvBp11FMwGCvxBVhBzU9EIu2yNQVXUDz1N7Dl6sQzQUUVM0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8pLo9+K2Ir3i5qhl7ZFP9rAYKmCMVzbmkDKU9f8LgHLlRSfMD
	avt2EpExNuYex5XEe9itSIjFvzAUulN55rAaNRbCZGVzg6GjbIfMr34IGwrnVXrVXro=
X-Gm-Gg: ASbGncuGUCilc4JKH9ThpVALghXdrBOBvmTt8zMmiorauPIqdQLcyJLT7j53zeO2ac/
	IM0Hfs9LlumstciDqn2FGFnhE5q4o/C3siJ93uk3K2Zli84SyV0P1a9uIonRRirfql64PUMzoqy
	qkSsqkpFJvzEqpJkAt1jlYHMBCoOGyvuMxBsvi+DkFBRQpN8yBrt5/Aai1tc3+W/KpMHPtUtVOq
	2I7KXCExQUjCW90FSXeaVhod0Nvrw3h8j0ke3qDH/KN0JW/Vq5GVnSRIRtWI+ooLM8/JRWNy9Pq
	GCIlOsq9SP7lLeyCiPZs7fJVpgtRTY6RVjmKM3jnbcXWs+40RIyOulVmL2Yurfh94dXLRVhp2hL
	VVDtqgwUIfEzwQzE0YQ9yY1YKSN7tOBkVf0P8shS4JoFd6QeGxfDKpTeF3y5LlVpGLa0BJijS11
	V0UFer5Q==
X-Google-Smtp-Source: AGHT+IHM8II1RjmfRp3m6g6zyZfuVqzhb0A84HhlWB31HdynPLlNw/TLxPho405hZpT+l0bh6Rwnig==
X-Received: by 2002:a05:6402:3511:b0:640:b99c:de83 with SMTP id 4fb4d7f45d1cf-640b99ce63bmr3446992a12.17.1762173613890;
        Mon, 03 Nov 2025 04:40:13 -0800 (PST)
Received: from localhost ([2001:4090:a247:830a:fe22:a8:f29a:a5c3])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-640b39f0d2esm4667335a12.33.2025.11.03.04.40.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 04:40:12 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Mon, 03 Nov 2025 13:39:29 +0100
Subject: [PATCH v5 2/6] arm64: dts: ti: k3-am62a: Define possible system
 states
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251103-topic-am62-dt-partialio-v6-15-v5-2-b8d9ff5f2742@baylibre.com>
References: <20251103-topic-am62-dt-partialio-v6-15-v5-0-b8d9ff5f2742@baylibre.com>
In-Reply-To: <20251103-topic-am62-dt-partialio-v6-15-v5-0-b8d9ff5f2742@baylibre.com>
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Tero Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Vishal Mahaveer <vishalm@ti.com>, 
 Kevin Hilman <khilman@baylibre.com>, Dhruva Gole <d-gole@ti.com>, 
 Sebin Francis <sebin.francis@ti.com>, Kendall Willis <k-willis@ti.com>, 
 Akashdeep Kaur <a-kaur@ti.com>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1357; i=msp@baylibre.com;
 h=from:subject:message-id; bh=ewnVTjrK+RQoWcZSJk3a3VufQN4Z70DOdAXgMXn6M70=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhkyORf2PxOV9ZQs7ZnCe8TyenLq7VNJSa7p96SWjnHelp
 w8t5VnWUcrCIMbFICumyNKZGJr2X37nseRFyzbDzGFlAhnCwMUpABPxz2P4Xz/rsdhE/b22cfP+
 3fxudkVg4tQj6h4h974tvTX39t3VlxoYGbr79q9fOrcsUjFngtUXlU0mpgzFETIzN90SsNup2G3
 owAsA
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41

Add the system states that are available on TI AM62A SoCs.

Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
---
 arch/arm64/boot/dts/ti/k3-am62a.dtsi | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62a.dtsi b/arch/arm64/boot/dts/ti/k3-am62a.dtsi
index 4d79b3e9486af18b8813a8980a57937669ff6095..31b2de035f0f748e34b8919f90251aa0551d9b32 100644
--- a/arch/arm64/boot/dts/ti/k3-am62a.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62a.dtsi
@@ -46,6 +46,33 @@ pmu: pmu {
 		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH>;
 	};
 
+	system-idle-states {
+		system_partial_io: system-partial-io {
+			compatible = "system-idle-state";
+			idle-state-name = "off-wake";
+		};
+
+		system_io_ddr: system-io-ddr {
+			compatible = "system-idle-state";
+			idle-state-name = "mem-deep";
+		};
+
+		system_deep_sleep: system-deep-sleep {
+			compatible = "system-idle-state";
+			idle-state-name = "mem";
+		};
+
+		system_mcu_only: system-mcu-only {
+			compatible = "system-idle-state";
+			idle-state-name = "mem-mcu-active";
+		};
+
+		system_standby: system-standby {
+			compatible = "system-idle-state";
+			idle-state-name = "standby";
+		};
+	};
+
 	cbass_main: bus@f0000 {
 		compatible = "simple-bus";
 		#address-cells = <2>;

-- 
2.51.0


