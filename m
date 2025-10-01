Return-Path: <linux-kernel+bounces-839059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F071BB0BAE
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 16:36:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF4794A4AD6
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 14:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14441256C7E;
	Wed,  1 Oct 2025 14:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="cxgOmmgm"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7260425784A
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 14:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759329322; cv=none; b=EdmXqXJCTgx8XDGTpQ5unrkTFv+mz9oFsGYR6Tabou2BoLIM8GlKIdkoRx8JR5bcpFoIJvPw1Wal1PvWI3oT0r1BSs7Thw8SiZ/wVofNZQpYg5VhPrmRYD2xtKNLIkMNvYGf6UX7zltA4D5ocD8vT8QqQzuOC+Oh/tQp4T3QysQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759329322; c=relaxed/simple;
	bh=6hGcnBOkrSMQIKieC/McV84XZyXymXT7FDaWvZWNWbs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J3YQzccUOooyxUM843A66cbotZ/2ddTI9Z28eo97LmOv/3uRIpByQSdSlt9Ih+Cm87sum9T0i2DymPIbiGIm++46G88swMVYS5betU3HZ66bY6tB88xlN4w3Go6qVwY0c8fHRRxtJevcbGc12HI9cINbuXM/GPjFKvTBXgqNfD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=cxgOmmgm; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-62105d21297so14412244a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 07:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1759329319; x=1759934119; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wJeAn8jSSo6/JIcJaohDppo/oGstUTXUuYjdPwTMcs0=;
        b=cxgOmmgmiCCNLqUW26Luv82cx20E/ZMz9qh5uUrp/2QeDf9zaJUfDpLvgYes/ZlUoR
         FKi45jsCtMFaHXZkznsEdCqn2fZOGr538tvdfZyPkEIlKnhnDk5OH7IEIpNc6NAnPnRO
         jXncvwT8sutehUvaAj82TwTg0yW3mOGrSWCs3adTXt50H84I+oxUj3TPgKePewCf1KEJ
         jYBCRTXlettLROi/dbh/pUiu/vk1NBRAThoAM1pcCGrWU9d84w4Yp05xsEMhRi9CeL8Y
         pdFy2YdAmkDcVele4Tt4t8gAg1TvxhYmxeoKK0ujfbnYLJmmv/4ym9qs9AOCsGNCAySH
         kcUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759329319; x=1759934119;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wJeAn8jSSo6/JIcJaohDppo/oGstUTXUuYjdPwTMcs0=;
        b=S9Mo/yhgYK5Fi4IIw0Breduj50Xz3NshD0kWlV46ipgHefSA/GUj+CBJ8E+tESgmTK
         XdTslAR3ug9LN+s0ZLzgvVw+pltCYnvjwkvdKIwHo1Y5efbls4/au4/rYEJ8vPNg5p86
         Cj5NhfUAd38vorkywbFWlAiWWJE+OBtLveRGrwV6Ok6aeupit4wBqEmc4DmWK8BoFJPr
         3jzz07U7X7RU8x+l/Ybi41fDwwa4MXCN3Vzi2v7JYEvG9yvbEyFb8/Wvx/z2r++5CpYe
         CuKfT06txk6cVyJyXukTds0IvbGc/SqSBmurr9LbuiZ/vbAslWY2s2+ca4HWjjRTFCYu
         GiIA==
X-Forwarded-Encrypted: i=1; AJvYcCX7xtp0AGv4Pauloub/0Uq1lUJZ+yFtnCUW9JdvQZuJpUyJAcOdNh4TIGWfX0rM1N81Lgw2E2YXCgFsPiU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBS4HAFk04huaaAPrgCcgjldxhE9YliRYY/er8dpPbsf6bzJeu
	Zw1xyBNBakvX5+Ekdbdqsrg02kFjR/n4L84gPygxxTowg7K9LgKOF3OKibcF61FZayI=
X-Gm-Gg: ASbGncv6AmqJUpHdW37IoTBb/eIHmZ4Fes6W6gpSAZW0hN7yP8gUwwl3xR8/mvammZb
	eunzf/LxYFIQ+LwDnh0a+bjMi0lm8/VgIWDGzAtxqGfS2LuRRFTq25dBgaxFpnueTgOdoJ6xn5m
	ztUTncMKll2iC+BYJEOdDd2zknHW+PGiHXBvQjHh/80lgymIjzj9zux6sdlNj4Qe/Q9+1vBSA7H
	NDVeapKbda+RNe4Ha37zKWpRV9vsNzdDejJ33ttwIx8lLAdinxUasNFI8Ip9n6KUU0Q7v5QpQTT
	5amrOFT9oXbtlthzPK3dxer4oeJRkY0QZ8b+f3jMKWbke9eeN0B8Ra9dY33TLHoYfx3p4gHPxVd
	X4FuhE5Tk6UCK6fDvP1xI3n5UtLWBGQtLbgCerBr1jXl/
X-Google-Smtp-Source: AGHT+IEzvHyBc92HNqPVs3GdFrOt6YeTSsFc4xFWvIA6c2/HM9PJxT6oIh991UA0FNDgVEprf2xa1w==
X-Received: by 2002:a05:6402:2355:b0:636:7c68:6e31 with SMTP id 4fb4d7f45d1cf-6367c6870cfmr3014070a12.4.1759329318650;
        Wed, 01 Oct 2025 07:35:18 -0700 (PDT)
Received: from localhost ([2001:4090:a245:8496:49da:2c07:5e9a:7fb9])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-634c065a67csm9859870a12.36.2025.10.01.07.35.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 07:35:18 -0700 (PDT)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Wed, 01 Oct 2025 16:34:15 +0200
Subject: [PATCH v3 3/6] arm64: dts: ti: k3-am62p: Define possible system
 states
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251001-topic-am62-dt-partialio-v6-15-v3-3-7095fe263ece@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1357; i=msp@baylibre.com;
 h=from:subject:message-id; bh=6hGcnBOkrSMQIKieC/McV84XZyXymXT7FDaWvZWNWbs=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhoy7NkxHbT9olx58ocZ7ZNFJlrrwVAtJLcEQRY6Sctb4x
 L1Bn491lLIwiHExyIopsnQmhqb9l995LHnRss0wc1iZQIYwcHEKwER+VzEyLLrcOd9DfLtaZLf/
 brFtlpz/WZfK/v9YV2Uyxf3kqhqeLQz/czNyeVWmFewsmXDs/nt525hzHgy5i9s7Nq4UvBlydvV
 FLgA=
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41

Add the system states that are available on TI AM62P SoCs.

Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
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
2.51.0


