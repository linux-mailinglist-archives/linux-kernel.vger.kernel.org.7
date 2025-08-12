Return-Path: <linux-kernel+bounces-764414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2451B222C5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 11:20:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7E78188835B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 09:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E3462E92D5;
	Tue, 12 Aug 2025 09:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="NgH+xMyR"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F0D2E8DF3
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 09:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754990196; cv=none; b=HTA3lX6Xz08btb32Yoz5gxhkh+GHw/JkpQlNybvDF9KtcSFsLh6iZLpsQ16yqhPfL2Ug+gIJ6Xm56LQBIUeHiN3g1zZiRXCGQJKeOcQuKiHlN/hN5M5MxwVW62JxfvpBuvIShvYMlk/rh8Z5NR4nc5rY+ec2/DE21/ps/vPj1lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754990196; c=relaxed/simple;
	bh=d441FgCmtsa7ZpzbwijgZYrCnzk6B/a5li42/hOla44=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FPb3h78BEWFADaieQt8C7hrmzPRRGqdi3873/ib7gXMgPLPjvnXO3B0jQFA2ZLpZ0MLktSC7xJ2QWfKnppI1jmhqwZGjbI6O96/LtT/KOtcqBRSPqVhAqrevMqxQr4aohJiuQ1CE+cuEI4NMmn2MhgpLXWDUfkUOSKqf5eJT3Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=NgH+xMyR; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-af93150f7c2so796400366b.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 02:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1754990193; x=1755594993; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dJsccVD+aJSM/xz8OFfe3UWNNHj44ZVnM7wk5giEoiU=;
        b=NgH+xMyRPQLF0QOO38W7LJk5dmTv9pQCpEdE/k4JGngy+mxvS4BDxAgl5GP+56l+++
         879mgYDe7ibxVin/VuU4jt2jVbkuz44MQ2SLYwIH9i83qwhXIeigeUoz4abKFTBzTdPF
         LPGShL11qu4NM91zmZ37nbP5xbtcLZZZ46Qiy3oGkeuYoF02tOQwO7UfgEW+C9yw7Tn8
         y8ojaF/KPBsZSkufjGQ+R7ORNKC1aKrohS86eLUbKt3pvWBe78OVGRnH36LQfBJYBmSw
         iUTUHeLtjtf3TrZ3HpOTt8gmcFJS3+3qzW2puq+zxT4fcBkv2iVM+15U1A+2xnGj7/Bu
         Sntw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754990193; x=1755594993;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dJsccVD+aJSM/xz8OFfe3UWNNHj44ZVnM7wk5giEoiU=;
        b=dufOoJEhtCsvR/IdwHEeLhiQsf8b5LGtBvDVTdJR7Xz8s++2I8HCbBj7kNadI0V+rh
         XxbyJZukR7KNI54ldvtbs3hPT1NeQOsPeTjMtvR2hQ0+/2VMLjg9Zca7ByMVJGA8HJEU
         JP9YnM+1tEO9c7BDd0TqoPbGRoQKSBRV7ak0UcH+zG6K7ntwkvMjEa+Asd1ZJowuO1ob
         olqo2/+MUOtCB6FEm3eGhHJ6wVY3HCycZJQ1qyRAmD31B8+0YxHlPyCRiaZIYFRw99HU
         LT/4Rn7pv1kQL9wtqTq+2KkBcg2tOdtb5A1DtT6eF7nEwTheUgrpp7aaxOzq0A8Jjoe1
         BwLg==
X-Forwarded-Encrypted: i=1; AJvYcCX/isEHVLY838DXra/j65KVtJ/l25XWLJS7hQHUvpm34HZ0hfwo1iXZiLZY0GR4yiVVx3EAxm+xRwOFIsQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxW3amoXw8ZtZnSCDCVvcOdBiSrPqFrwBAf6ymaGwhzmM4VYimA
	feugs4b+lUJFrux7zD2Vy4zXOg2XcNUJHFovFOXfb/p1BhELysYy50T3ZDgujKWJmiA=
X-Gm-Gg: ASbGncum8L1x58umc2FOYPYI1AZhcp0nFwhE9RnMZyJIwO56w98aImSA20Y/fIaQ1do
	FGjakxO1QsiHFNmp+wlEmPq1MW1F0O+XhsjpbK6qRou63aeMIr+D1q1ixBK6NmGbSjlf14uDShJ
	+w6nxkakdaII/p6OVwGNIED03G/Gdk6wUPY6c/aMT5RxsYuusg6dce/uhVGqllyWbYcw25p/L25
	kTzwgkjR1gdhFiXxrCng/6eNLftEsu1X3gHKc9kK374+SfaDTA3caabR+wxeQh8aJY984Vvbwwv
	g9HeuXJ80NmgwilGD/Ex/lGvHsyhvc6A2piVO0QTwJJvKfBrng9ATz3IjL2HeRrRfsa9DkWjZY4
	CIxF4tufG/3RpOjzJwQ==
X-Google-Smtp-Source: AGHT+IHvlAWtPFCu8ruDDoIMl9S+xsCpa1UFgIk76RM0V6av4fhNT+x/UHIr6WOtfg2QDY55SVGZlw==
X-Received: by 2002:a17:907:6d19:b0:af9:6c74:9612 with SMTP id a640c23a62f3a-afa1dff9230mr212706066b.8.1754990192821;
        Tue, 12 Aug 2025 02:16:32 -0700 (PDT)
Received: from localhost ([2001:4090:a244:8691:4b7a:7bbd:bac:c56e])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-af91a219ecfsm2165122366b.94.2025.08.12.02.16.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 02:16:32 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Date: Tue, 12 Aug 2025 11:15:21 +0200
Subject: [PATCH v2 2/7] arm64: dts: ti: k3-am62: Define possible system
 states
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250812-topic-am62-dt-partialio-v6-15-v2-2-25352364a0ac@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1205; i=msp@baylibre.com;
 h=from:subject:message-id; bh=d441FgCmtsa7ZpzbwijgZYrCnzk6B/a5li42/hOla44=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhozZbE4tHFf2+ExsFbAu8fe2EwiKseXpnSx3dKbSTOXou
 +d2/VjUUcrCIMbFICumyNKZGJr2X37nseRFyzbDzGFlAhnCwMUpABPx7mL4w8OmypD9yHaP7Z6a
 6tdGDjJL6jKy5ujMUrnEp6C04sU8f0aG5uivfkuP1e3fPCXAdu3RJYIKfavj9L3VbofN2W1y4rM
 WKwA=
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41

Add the system states that are available on am62 SoCs.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
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
2.50.1


