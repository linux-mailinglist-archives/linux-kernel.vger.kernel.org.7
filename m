Return-Path: <linux-kernel+bounces-877875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94DB7C1F3FE
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 10:21:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 391F0189BB90
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 09:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AF46341674;
	Thu, 30 Oct 2025 09:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="iKZiFrgA"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E563633CE95
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 09:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761815947; cv=none; b=kFYHxW3jrfjHd01S0++lC3xD8gusPbf8RRScT2CNtURSjvZqu7lIz+gYPC5X7YNBQMKOV0+8KXzOrGDYq9mmyYztQGyKX3gS1pYC5OG/QznsSjiyLue2n1v7+35dE4VYOltSc2N5f+T/T5LKiTruJjtU2VJel4aRiK+1r7aaRHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761815947; c=relaxed/simple;
	bh=ewnVTjrK+RQoWcZSJk3a3VufQN4Z70DOdAXgMXn6M70=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KrUhpp9ovg6QHesJ24id/g0VvqnU/wR+vu8v/b+89hugl/LzA2w+wBA02ndDBF4+Mo/5ppG7YV7/iykXGcAXJ+FnbtOoSSxp+mByaHl3kBSJsnUMnlyE3W80WxaRbfziFr0v4hrJcFZH3T9shRBjOrBoglD3kJ2ZaAOKg9kx3y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=iKZiFrgA; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4770c34ca8eso6918125e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 02:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1761815944; x=1762420744; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KA4oUZwX0z4qIkAync1NbIUw+gj3BAYqhFw1et34T6w=;
        b=iKZiFrgAhjjSGVmhfDnJqY2DMPy2Ux0ORw0Izmmo34+iuc758zVgi5wcm0s9wFEW27
         dbtXu1q1DWslQEufFE4txOPUa+WxvQ7NlMXEkEcT47lC6s2myAQSVtIqNyW+MryVIKjC
         ZjbbcChqRaPkkG+dqxJwWxGltYHlq3tAMBMsmET0ISXDTQUJ8FrUuyvIzMKIQ9ydi7G+
         BAlqaQmiWLBVnj52jiiAuCbqTpFcStXOgJKRxosh13ebRuhrLPNO/AY5l+iTjf+zMT78
         6qg/TTOLbHxshzZysxL6/sr51vZC6jB+nmBvXa04vyvuFgiXBMvY6L86crUQnsmDbYpc
         OcAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761815944; x=1762420744;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KA4oUZwX0z4qIkAync1NbIUw+gj3BAYqhFw1et34T6w=;
        b=AC8qFx5KmN58PXogdMVrgyKw4B43NzJkfjp8DntyRSgfBkE+5kjcqzsw1MeEomR8l+
         nzof1jtFnK47ExxoOzSjGczDxeGiIL1/hRNaxRSa2uMO0BMksNFdbBxQL0EmzVNCt3vx
         veviCQptTJneRbbzmE1o91stq+PEfHhcUlauAhfjtAWXmbJBioNoHUIhFkOI/xI4I5in
         i9r2hrXWQ189JtvhBcADWeC4zCgEkGJ3ca6s/osLge7y6gr7Q2yHNHAmHJVfxqMPRn2G
         3O+SWg1Jpsmly/H7R1eAyON9pDpwJrIQaY2DeVXH9JfekMvRdu+LmX6PNBOgNGXTTQEE
         bMxw==
X-Forwarded-Encrypted: i=1; AJvYcCUQfLPdsjTpYEOzR0Du0M+/woqkVBmOosIjUYhHHvkGwjgPs300pv4ozmP8DOdBbwvPWHqdxVCmpUAf5xM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyU1HYqP71ar6J3rVSCG1GRNBkxQ6mSkIYL7q4128q6QK/4UMB
	gxMFydSWD6igbCtubKUeEyPoTwPCar/eWwvOxVyNaZ/WKdy+NLfwdMzRDOPz4fB9JDY=
X-Gm-Gg: ASbGncviXTqEbBW1hiNvzSRq2VCBWRDG6V4nuDbNleAN5OjxDbPTRD7S5nbkoIx/3it
	Pb0+16Qo3EWvV1CsNigeRVQn2z+SH4MRI0Daq+0PJoAGWROJsthv56igRmN8X9fsSbOtYw70EX3
	sRfJu6I+4uHhS65LyNkhiGgqqNkAHrRJ2QTGqmahjxBEldnPVxY7nV9ir4VIfaAJvvWh4dbTW/D
	5CRHSBlLOWmXL9aqL1bKxFsbSRnJLxGE6jOOvwLAk55ht6Sodx5IbEDvOvl1aCBw6cOqYHPBDPJ
	cRamTrCjB0rdvsux/UTKXucjDJTvwXcZHlYp2GQ43jKVRpyY3GP8/M+TivwvLqv4nvMgtnhjuwm
	TJL72OiqL1N/tsBO7UyByu55Ew+pllHM9YM63lCwmTL1nS49beY+saDaf7ZXCQWJ0vdrlellA2l
	IoO+AnNrlo
X-Google-Smtp-Source: AGHT+IFhGrgcbFfOulX+iDaGdlSnxfTr1i99B+BANP4h++UJmhUQbypXcv48n75+Y9SSCx3IGH+2gw==
X-Received: by 2002:a05:600c:190d:b0:46e:59bd:f7d3 with SMTP id 5b1f17b1804b1-4771e3a88c0mr46479125e9.20.1761815944052;
        Thu, 30 Oct 2025 02:19:04 -0700 (PDT)
Received: from localhost ([2001:4090:a245:8496:49da:2c07:5e9a:7fb9])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-47718ffa42bsm63685265e9.4.2025.10.30.02.19.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 02:19:03 -0700 (PDT)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Thu, 30 Oct 2025 10:17:24 +0100
Subject: [PATCH v4 2/6] arm64: dts: ti: k3-am62a: Define possible system
 states
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251030-topic-am62-dt-partialio-v6-15-v4-2-6b520dfa8591@baylibre.com>
References: <20251030-topic-am62-dt-partialio-v6-15-v4-0-6b520dfa8591@baylibre.com>
In-Reply-To: <20251030-topic-am62-dt-partialio-v6-15-v4-0-6b520dfa8591@baylibre.com>
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
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhkxm3fjTuhfSU+bwXd13/oSqtOSUEHnf3AAOreJFvwSZ/
 rj1nVraUcrCIMbFICumyNKZGJr2X37nseRFyzbDzGFlAhnCwMUpABPZ+YiR4dZmWQmXJb7fUkw5
 Al26XJlijr9assB+1ffed52VO+Se8zAydD4s+r7BMfuOj7FvimzBsae7ZPevyX/Ye2Xt+Ye75sc
 v4QAA
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


