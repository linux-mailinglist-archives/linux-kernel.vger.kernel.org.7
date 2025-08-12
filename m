Return-Path: <linux-kernel+bounces-764416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9C0BB222CC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 11:20:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EDCA50124E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 09:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6C8C2E8DFA;
	Tue, 12 Aug 2025 09:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="aNeRnowJ"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7FA2E92C1
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 09:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754990199; cv=none; b=cjQNq8lNKGuWrzYpCqDYIz8dxYeClq9EPkHmv3UtypCohp8Aki0LTpkvRAbIdTeGDxVpUrqiHT+Vy8mTBKkJVGlC5GB3xoRhsDvx37YPObWm4pDyfwPdvbmd6qtoGdQ2o7AD/XTdYXoEXCWAHe4nPmS71JzAk78tm2vV3/0xpG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754990199; c=relaxed/simple;
	bh=NQ0W2prGrb5FYMdevsZCsW42+VX/kA5sT9snVK2MjKU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H3AzfuWiZ7Vj4DWmVoo9cfyV+8w/j6a+Y19CVD8ekbpHnApq1ef8i/0zO+1RwmWvd2ByTnXpEIhdYGK9Y9gP8m8ucP9U+MsuPWfkTmLZ1YhInykG39auFuUKFXUYnHHTUkfBfpIAkueL+MavoDduP+aAvOJUyQDbUN4Z43hSWng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=aNeRnowJ; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-afa15bc3651so206108166b.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 02:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1754990195; x=1755594995; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VdmQiv6cMD0TtqYMo1t5mZtX9ofrz+6RM04gqc41y1M=;
        b=aNeRnowJ44Fvr+xVFzby6AszBoL+m+d6KKJvRf8AOSdqhnt3iR48aLUinzG6V0SPDh
         iZ3No3o7gr3VDtxiRcfzKF1J4jNtNYHuraRE2dzjmLsds8e6/6tpH2LGQjaVZuXMU9Tb
         gEbu0KJDNruH4rqfg8GsLMhdmvbBd8i8Ye6lN2DqsoJMkAmRowrSiyaUxRl+FBv27rjQ
         wJrE6prEKdFE9Bmw8a7K+zrDQ7CMUyZ2Vv7BPdlbA94ZeIbtbmrVNUYwbwyQptWbuKLp
         YUtGJoIp8ZlJ3JD1SRCg7DcMXGveGjM3JNkIkgYTV0dRq9S5Iy6l7JzoV2uS5TgQJ6JA
         aynQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754990195; x=1755594995;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VdmQiv6cMD0TtqYMo1t5mZtX9ofrz+6RM04gqc41y1M=;
        b=mcBobC5brMedZt+jKxCu6EY3cMs+k0fnDGYD+5ZYMG7SWOHhZhNlBOeXmYPEAI8gQK
         pangUrW2Hn1g7I6/jPxzYIopwi18hVJurqgP3znGV2tlfQoo/8Lj069z+wAt8OBW8gWM
         uugBP1ggrgAOouUSmpiMBNItiBcgm2GGTg5HS5V7onD+g2OR1cIMetfK24Msix3tCSAx
         c90YhGGM3eptHiCEmk6izP0NX/LJ05U3sihqZ+X4zElgxELdLUYFLWTTGQ+OZInjrMij
         GcNgtkIM1xtmZUaSKPqIlrX44j4a/Tcrt5+QvfZnujh+zGPKifN7VEWFDK5BVg994RFA
         YZiA==
X-Forwarded-Encrypted: i=1; AJvYcCVcLOpSrAaRIwxQmQO6nnWMXgCK1a2Izx+59zNKo8SdKgZVMtj+KGJqvVnUfsSMe7y3lCAclOaqM5xvYmM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmXMUhBjUfOqq9NTyqVAcQ6w4QhoCPQ3IkYGlQ1WSEz002v3Ap
	NX8ds5WwmZwwkxtKd4xjERHwLBtfIGbIk5qIzWt3EUqhkOOALvCVbcvLZnFtSbfytjk=
X-Gm-Gg: ASbGncvquzhruy3l9C52WosLbNefXjaTERrUTohRtt769bHLty7i587NoQW6oS6431k
	FtFTc/Cc39RhULuPWtYW2A/Iek62/oav7eZrxS+aaf/6rK0b4SgrVRBvwGRio0S8KoSDIuT/e2h
	+XF15A/iGEHaGhZWWxmrJTJmaWTIu2OHxr0FeTRq/bzp9Pb4CXeu9bowPlylCquApgpJag51adJ
	afx0fnolUj1Sf6udYqHSjMudLXcmqdc9XsI1tKPpzknIqLjBSZbCKPmYwkmN+Gon8xQKVGS5bLE
	gUx1A6oiCtqeDQvlgDEWteSYIOeIsmob7LpUSPSJefRLqY/1NxCybpIbyvPTUzybLu6wrx5+9cr
	SzxJ1OZD9v4YEs/VGkw==
X-Google-Smtp-Source: AGHT+IE/lSF9QPDKTg/7UPE6qm2SbqVvO5lbJE13BB6VOVUHEyhjrw4Mzk8zczsxQOEGqPcBNfspwQ==
X-Received: by 2002:a17:907:3f1b:b0:af9:a162:7fa8 with SMTP id a640c23a62f3a-afa1e1ecbfdmr208931866b.50.1754990195168;
        Tue, 12 Aug 2025 02:16:35 -0700 (PDT)
Received: from localhost ([2001:4090:a244:8691:4b7a:7bbd:bac:c56e])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-af91a21c050sm2165345766b.104.2025.08.12.02.16.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 02:16:34 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Date: Tue, 12 Aug 2025 11:15:23 +0200
Subject: [PATCH v2 4/7] arm64: dts: ti: k3-am62p: Define possible system
 states
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250812-topic-am62-dt-partialio-v6-15-v2-4-25352364a0ac@baylibre.com>
References: <20250812-topic-am62-dt-partialio-v6-15-v2-0-25352364a0ac@baylibre.com>
In-Reply-To: <20250812-topic-am62-dt-partialio-v6-15-v2-0-25352364a0ac@baylibre.com>
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Tero Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Vishal Mahaveer <vishalm@ti.com>, 
 Kevin Hilman <khilman@baylibre.com>, Dhruva Gole <d-gole@ti.com>, 
 Sebin Francis <sebin.francis@ti.com>, Kendall Willis <k-willis@ti.com>, 
 Akashdeep Kaur <a-kaur@ti.com>, 
 Markus Schneider-Pargmann <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1345; i=msp@baylibre.com;
 h=from:subject:message-id; bh=NQ0W2prGrb5FYMdevsZCsW42+VX/kA5sT9snVK2MjKU=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhozZbBGH7aZ+3HMy4fTC1QZs0a7zvAOTbBbMWPyrsHo35
 022eWeXdpSyMIhxMciKKbJ0Joam/ZffeSx50bLNMHNYmUCGMHBxCsBEQqUYGT6yvOwR/tv32ino
 n9IX9b7Y6zeD6mZNnBIcFMu3pcnAv5nhF/PNgJVtwQ98JB63R2gLPpW6s2LBz09Mu+2rw9PYN09
 OYgQA
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41

Add the system states that are available on am62p SoCs.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 arch/arm64/boot/dts/ti/k3-am62p.dtsi | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62p.dtsi b/arch/arm64/boot/dts/ti/k3-am62p.dtsi
index 75a15c368c11b068430362fe0b8d2d9ecc052588..c69e16f16c835489f2bc5cba158235ab955347e3 100644
--- a/arch/arm64/boot/dts/ti/k3-am62p.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62p.dtsi
@@ -44,6 +44,33 @@ pmu: pmu {
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
2.50.1


