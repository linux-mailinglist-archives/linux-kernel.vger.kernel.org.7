Return-Path: <linux-kernel+bounces-839057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BF2DBB0B97
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 16:35:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 999D11921ADC
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 14:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 807E9260583;
	Wed,  1 Oct 2025 14:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="PPmL9fMV"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10587257827
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 14:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759329319; cv=none; b=HTUxghbysuWh6USyzCwvoRcf8RtdbGqKyEHemPVRAWBDOcNjzP51V+8vc3H+RKiN9QDQYMKIQlRML1sEuZa0InEYqxYbUNXh56go6L/9dbArUO85P1CNIwM6z0cs68GZ1vph1OYedsJ9XAcjk29lF5SO+Px/bbew2oyWh20vrRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759329319; c=relaxed/simple;
	bh=CD8jS3mi5l0ptE5mloshmhyPStp+3Ujo5r6yvkMZV70=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KfdzUwt2DOSzftzphk1Wln5iQtcLLIEunI4FtzE3BiPfYJMxFrGzzVSKafnLM39lYQiusn6ofNeujCW4rZVR1ZC26pIc4UiNLdebW1tH5IDO/iHbKMblp4ArPDd1A3CwEZOmVH92o7UF7lc2bpyGxSMLKoBZDQqv90VnJHjp4q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=PPmL9fMV; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b0418f6fc27so1082644666b.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 07:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1759329316; x=1759934116; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qKLAYC4j9KDlgpKElsaQCZMFHUJovZT20hAAdQtCFec=;
        b=PPmL9fMVQ8vokFsk+/iGTtPqKPTGV5ooCcFI7zY086Mmi7tNxCKKqvBwF2IHvUJB4O
         zA7d71ZzRp+RKbKsgXs2YdeRf+DlNil7yEDLXHBP2+omCjNlu/u+Gpw8MEngJ6QzE7pU
         TusnMtV+kf7y9IkGm+mCi8ouaMlV9PeHl1hvk5HPubs6kkk6W2M23y9WredQb6jE61cC
         OaaQE/FDXh2v37+V864UW6P5nidDyX3LGb/lYlvfHipZoBT8AN21sLIVdWNx6icWaRxc
         1LeA/k9QD7v/9+LaYcZWGC3iaz4+34BB6cHppaNhDReJGgnXj0iKXEbtAM0gKQLN3Dmb
         ANIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759329316; x=1759934116;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qKLAYC4j9KDlgpKElsaQCZMFHUJovZT20hAAdQtCFec=;
        b=EtHp3NKF5i6qjHgyqi/uo7uwTSVMfVw3iQWO0/F2gIh/9SnUtArATPQxJu3nfHpZRa
         yWcmG0Hz4y6uv9EH/VDAXxyTO188wtFv8fYJIIsVB/iiNuSmgZv6eUG0kk4l8lS0Sxvm
         DYaWHpEy1Qh1QeBFZ/zkHgW/9iPsBOIlDcGT/x0SW6tyBChnnQpTkceYaYbokUoWWpH5
         sLrRUx1lrwisziXHc9axZEy3OHhn1md/+m+0ke67/b32vuG/WMsRNsbc6LQ4RRF/adpC
         s+W/lPENtg9vKtYHNduP9UukI3ZcRMxeYzqSBVhQ7h7M2SQa65Th+IzL7Fqpcx+a+uv0
         6rSQ==
X-Forwarded-Encrypted: i=1; AJvYcCXkTp6uoF8YKw+TsS+w3PA6+4IsHGIm1mX1sFJeDlAsFCPnnpH5ArOmZpnikKx/RkfOcpOhYmTGQpSbP3o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfO7k/akfZwCiRQjvocSP5nKYLRSfglySUSrFzPr4r4Spt49uz
	pSeBVXOcxTgm1jUDywONQKOohzZ6FItSjJ1gHTafPWJ1wgYoeWF6srAr0s/sLFUJVDs=
X-Gm-Gg: ASbGncun7aBIwrxfpYeQ+zl5a+ghfUga74wmXa7vYnYS/b40iWLf1e8t/LYGZfanjCQ
	Kd+9senMXjzvU7eNWWxGbEv9gr2ZQu545rexJg7oYSSjz4UUfins6+qtWxd8TMIpJRR0k7c7fGc
	2fZd7Lv4yn7PyZov+SlIujhj1NePanrxRYJy1vS+olqsHU1Skk0ZWaV0T8h8WkWlqPyG68U8Tx3
	Gtbg1j6JxBoKhaD4FRbXRCr7Rdc4hphcZ2zp30viDtS3I6oMIFzhvxok+xZ7kgSvW83ZCJiQwpx
	EOct6xEZtGsyRH78tCwHTgAD0zdpSF4SXaZdvmF1hNipFfENIupbS3aXGUdkOAJ8Cgpew7aGPu0
	vBzwAO/UozlZA0cqbS+U7u6bHxmmoJ3jyK9VS9wErNqU7
X-Google-Smtp-Source: AGHT+IEYEURijCwuhDP0G34PhcYmv4fOEgcLLFjlM+TFZMLirjS7EIEOqa9JbLLvv3rtWABWVxPKzA==
X-Received: by 2002:a17:907:96a2:b0:b3b:9931:3aaf with SMTP id a640c23a62f3a-b46e22419f7mr453073866b.28.1759329315788;
        Wed, 01 Oct 2025 07:35:15 -0700 (PDT)
Received: from localhost ([2001:4090:a245:8496:49da:2c07:5e9a:7fb9])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-634ce748d4dsm8879086a12.29.2025.10.01.07.35.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 07:35:14 -0700 (PDT)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Wed, 01 Oct 2025 16:34:13 +0200
Subject: [PATCH v3 1/6] arm64: dts: ti: k3-am62: Define possible system
 states
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251001-topic-am62-dt-partialio-v6-15-v3-1-7095fe263ece@baylibre.com>
References: <20251001-topic-am62-dt-partialio-v6-15-v3-0-7095fe263ece@baylibre.com>
In-Reply-To: <20251001-topic-am62-dt-partialio-v6-15-v3-0-7095fe263ece@baylibre.com>
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
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhoy71l/2FPTNi1pzafNt2ZnqfP9lZyevVxbz2VLwpvu62
 bJwVWP2jlIWBjEuBlkxRZbOxNC0//I7jyUvWrYZZg4rE8gQBi5OAZhIgQHDP81V6QbP/35ulzAs
 UC8/t8rzW8fzmy/9Z7mue8o8/fbyBQsYGW4vDF3BIZfN7cMXpZMqFc8Sanm0pWLW9lrRZX8mcoR
 p8gIA
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


