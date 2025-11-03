Return-Path: <linux-kernel+bounces-882890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A899C2BC28
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 13:44:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3F0D434AC09
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 12:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1A8C3126A8;
	Mon,  3 Nov 2025 12:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="XgykU/+C"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B2431197A
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 12:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762173616; cv=none; b=OGgD3DzIGVa58EkFA7FIluD2ytEeTPPWzKQ/1OUKtvtq77diSuRLgb8mhJRfyNVZf/uhobRIPTeYLOU4NonJxqYDOvkwCdqjkQoXFuLBGGJFgPouTF9hF/UBdZeleHycR2YUveWC6JJrmT5jbIUQ0dd1kwL7dt+OVvunymi9r6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762173616; c=relaxed/simple;
	bh=CD8jS3mi5l0ptE5mloshmhyPStp+3Ujo5r6yvkMZV70=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ITe4u4T2gto77LmjeQvqBPoOtEejhOihayNLo7p5aOGzMfpMH3ucsrysy2qprx4x/vnF7fX/5T9SZlpcAR+xjVeDG1L0Dpm5LfOD+sCg9KveGdIfl0dZW+w1Mb2IoXgQrwsEsZCLh0HqEhah0DV35BwJEBT1yrlPeo50V2IKKSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=XgykU/+C; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b6d855ca585so808752266b.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 04:40:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1762173612; x=1762778412; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qKLAYC4j9KDlgpKElsaQCZMFHUJovZT20hAAdQtCFec=;
        b=XgykU/+CD5Qwp1PhzYoPphmzCcSWqmhK/3/LQ26vf7A6fiJmbKWk+FcMgw6XYzhrXT
         PSfrDjyGECozGJv++a4D6B8CDa1b0N8BrcqfYGZkVb7KPHsROU+OehhmQe2rqEfcFxIY
         4YNs4XPU1a2qRvp88EN0LlT8t+upa2RnREqpboWeKV/KKUtWgTvxwcNb2iHVjkbv8iqi
         xlAch44sq9GE9Bqgci+cwPVzXaP1mloNtu7uHH9EQhMIm2xKi7gC/pZCodiO7k7KSFgs
         IMsWzWA01D2vMPYqg6RP2N+N8wMpAM3mpl9dknnpelKtm/bg3d5XVzwBaOpKcHjkFIQ2
         B+zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762173612; x=1762778412;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qKLAYC4j9KDlgpKElsaQCZMFHUJovZT20hAAdQtCFec=;
        b=I3H1GfcOZ5J6xngA7VicHI6scnbtb8pLqbOKb4ji4CKugOceYVbQdLeV4JIbdOEBAL
         Dp8lA3XEB2KHyL2uqREHNr2HEyzyLDKu+K/+xF2iuEzV/agTnBvRA4kkBkDWo1kgsvb4
         UCO5ihB/1P5YZO+blnvbPiW3+e/u74HA8LgVJDDsQSAPA3NzjNe1kmtGEf1jNqYGh8GL
         T226uspdLjX5IgcMiwiXFEqUqGwKbpWry/3GX1LsGqsO3NhMto5pL+9VtNHJeDhfjOq1
         R6nOEwQ+vwnMuK3aY5ce1zLFtMehilVmh0XaT7xPbDbu+rw7INcjLU2ldZuZpIxxr5ko
         ewkg==
X-Forwarded-Encrypted: i=1; AJvYcCU9N3wZPxEhiNWyq8a3WJQO75CijARlz2rUptn2UQ6mODEX63qAo7Bworf8xtsPke5UrvN7xwPKREdG1Xw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrxQ2YOMvsQ74TX/h0CTZvilqYIN7Or1rI5dSFYR3SUdSH94Ix
	fe/J1/ZMUp/xu2v/xr4JsQFXdLBKE3g2tjCyduwM7gYT42fEbtxBVj3Qj9Ek7T/PNoo=
X-Gm-Gg: ASbGncu09UJMfW/TdSzj8zE10dWJMR976TLV/IVMNNAV0WjlIvpRkq5SOsDVLaY+oGP
	tf8PaAeFjIkZ+Ga1NvZ3XHgzFecI9tGvnsGN9PDsRnayfD6BFQA9xyhhuU5XRcnRkiPSEhAn1Wa
	bQ/xaz8wJMvEvjqDGJzA4SGPs6Zq8op0vkotNw9dOi45KPbqTpzh+zb8vxiqUUw4Wd9+DAZdAxl
	fldbHAmZazR/5V92ENVSbRWQSJWWDhlOcLsqiW8lXFx6nfvpx2x3NhPvn9dyo9yWIzFU3c8QPai
	5b0W57/1EZ7JjriSmDNqfOYJM1i5opzVFOEVleAhrdSCbweTM97rr09qgNCoULSz0O/UXZ5+5cA
	kWNYRx85iIfCDiazc5Y2Qm6N4fVKztGQsnaFUdQ6d5ft2LUZSjPxLGdnkfZqgdb7M/tKTwuRNi8
	+Q1FZ3zw==
X-Google-Smtp-Source: AGHT+IEJLGHUCqJbKodNhVUSRCa7L5Wjlnz8ENzdksAajWD/eFBThYHb+p1nQw21ODRf5Sv8XEPCww==
X-Received: by 2002:a17:906:7952:b0:b70:df0d:e2e9 with SMTP id a640c23a62f3a-b70df0de647mr267854666b.44.1762173612081;
        Mon, 03 Nov 2025 04:40:12 -0800 (PST)
Received: from localhost ([2001:4090:a247:830a:fe22:a8:f29a:a5c3])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b70b91e44a8sm382716766b.33.2025.11.03.04.40.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 04:40:11 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Mon, 03 Nov 2025 13:39:28 +0100
Subject: [PATCH v5 1/6] arm64: dts: ti: k3-am62: Define possible system
 states
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251103-topic-am62-dt-partialio-v6-15-v5-1-b8d9ff5f2742@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1217; i=msp@baylibre.com;
 h=from:subject:message-id; bh=CD8jS3mi5l0ptE5mloshmhyPStp+3Ujo5r6yvkMZV70=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhkyORV0vpu16rjT3+a7vb0R3TszcFcrt92hu81YxJ38VX
 tdzoj+3dpSyMIhxMciKKbJ0Joam/ZffeSx50bLNMHNYmUCGMHBxCsBEYpwZGd5tfh/GeyTA/SrT
 yRlZ7d9XH5n25+zHmMeLmmTOTVwo+X8ZI8ODHdKH/mUcedG6ce2kdX26gkIFflmaHZyJM3ttpq7
 92scHAA==
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41

Add the system states that are available on TI AM62 SoCs.

Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
---
 arch/arm64/boot/dts/ti/k3-am62.dtsi | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62.dtsi b/arch/arm64/boot/dts/ti/k3-am62.dtsi
index 59f6dff552ed40e4ac0f9c7077aa25d68d3b5283..b08b7062060ca12ecae83917a831ee779f1a288f 100644
--- a/arch/arm64/boot/dts/ti/k3-am62.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62.dtsi
@@ -46,6 +46,28 @@ pmu: pmu {
 		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH>;
 	};
 
+	system-idle-states {
+		system_partial_io: system-partial-io {
+			compatible = "system-idle-state";
+			idle-state-name = "off-wake";
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
 		bootph-all;
 		compatible = "simple-bus";

-- 
2.51.0


