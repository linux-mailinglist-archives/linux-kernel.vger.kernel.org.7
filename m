Return-Path: <linux-kernel+bounces-726273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F21CCB00AE1
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 19:55:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D8537BF0F4
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 17:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 517622F5337;
	Thu, 10 Jul 2025 17:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="ozX2/iuD"
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F073E2F5C2D
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 17:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752169885; cv=none; b=sIFPHjyfJVrf97dsc0/r42VR7HjbWSd59119qC57TLFNTC5nN8wcpPvXJBqVnjx50OE0GW+/K7/f/nhVNilV61zT/Sts9+dpMEvlNmwCY/PZ/L9GWDRKfm0ahCOCH5PeB7ysWh8SzKMNrpW4lffS7SQAsHiA37X9/Wjc29zCC2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752169885; c=relaxed/simple;
	bh=WGruvn+Gqs/wHzBEiTs0RVm377PpbfSqb1Lgjf4ooI8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iOlaa1aHTpqDKCjI+6Bc9t2oGxD68P7bC7Uyx0M0iiZ6dgWxjqaHGNwdxaAoxi7ryAolfLHRau9+jTFE1L0dbQNLjyfLZ5R+K1u5QCdX5z43stNxPZJwcTbkRdM1bZT7UC//mtoNdSAvA7b+QoOTbJI4piLAf6QUt3u82fKZbD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=ozX2/iuD; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7d3f192a64eso128486485a.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 10:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1752169883; x=1752774683; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ihUO+G2zPvFD7djd8+4VxSPuuLI+GNqieXaQtnBxio4=;
        b=ozX2/iuDyCuB+v5l0BCwyVlnRu8gv9qCQxXNMGRIDSUoMrml+KZdeGKPq8F67fCQMe
         3Ojk/yKCAZFLNmj9f0P4tHDkiAHfxRhryI9pzUDoC2j7aCaPXHg14Raphd6ixY2kSREY
         moRSkncj14rpddVXYBFcsro+77BmwC9OkbRDB5fVSwQWOtKmmoYL6BgH6pi2k8b4TSSe
         0AQOh0Jfx2yFyQ8RXLOqznejjMyHZAD9S8uW2fW9DmQuBGLoCyrEOORiaSMVHTtPupnB
         XwAT4T+EweeDSfLdMCaa+HInmgVMhVIJZgoTrOMCurST/ge8Yvs8P3IVIMcjvU1ENJOe
         A/ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752169883; x=1752774683;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ihUO+G2zPvFD7djd8+4VxSPuuLI+GNqieXaQtnBxio4=;
        b=TPUxv3Si3VvoHdqwiR/QN5hH65EPIjWHn63NHUF91K+pmKbhxrs+VDG/lXUr6U57wk
         uFfSSuDReO6EX09yS1UcCFFXMJF0ZiOvJ4s8Q1fWm0IuodUtDzXIVUxQxgdLUPkv/R9t
         3InGudTYGAeMqU+q6DyqUASr/BdJbxSWC0vXQS+YHaXwSobPpbMH1jWwlxtM2d8t79MU
         vw9pqLM9llwqoWzRlEOE7fhG0SIQziTo+Xje+ARdIR0hJWPvxaP60CsoBm9xwOocRFl/
         4LvenKskx8qxQaLJMkpSQ7115xB/b0VcdcTo5Gb5TqLYfNI7Sug3Ig3aLB6j6KXAXcuB
         HXbA==
X-Forwarded-Encrypted: i=1; AJvYcCVb2LVsMEa67HZeYZV58U0SmZwbHuswOX/17eqFGLnNFeThRe0DUk4CAyY/fY7sPzzfYKsCgB08w+WZvj4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyF9yeU/rtDfOS7xOOFQQfDnvykrBp/vFLJrtyglOHw2aikpkvb
	6Vo8yW1N3UtWgda9FFnwMwxaVGwu5O/hAcYfRgrkndNiHvrdmVbt9Ho6krruPYtK8ZQ=
X-Gm-Gg: ASbGncs4kmNdnF3+RAUQUi/xZwAeVD6L1UpYeV+vTYZkXw5W/AHRKx7sXueeF3RadUy
	lL0BJRxrGa8xfuSAs0u/7m8sXbGcDC5+FDZ82rJEEi/ILVQAYk7SSTmFaD0S4fyC9KJyJLJQZEs
	d5sAR1QavgAFqKEtK6+GY/E/tnyzg6XPPPplP5kyaR3n20S/ry2nWRuCG5UFMeUc2mVP11owFuY
	oL5amIgBX1ZT9qccl6gHX/cDmJW1QhR/KChR+OGewDgCoNGLADv5BGAiUTVRHmAUjsiTHzLYmoZ
	DMfaUi5gTLg8HK7GZlwzCcybikb03DdG0v1GGfMNRcuqhm0H6bSWoKa/JY4ruObeKOXfsdwJYtZ
	fFFx6ovkFb2thtDcKf2PnSsi0koBxdCQThPJftPVjXbUmaQ==
X-Google-Smtp-Source: AGHT+IEoaJ/MKPD+CK7o2MydxVCmaO05jGvY7/XoDfctFPCiw8+3wLCGeJ2afHZxnC3BYh2lChbupQ==
X-Received: by 2002:a05:620a:4450:b0:7d6:f801:ed52 with SMTP id af79cd13be357-7dde9b5ef8amr61941285a.2.1752169882818;
        Thu, 10 Jul 2025 10:51:22 -0700 (PDT)
Received: from localhost.localdomain (c-73-228-159-35.hsd1.mn.comcast.net. [73.228.159.35])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a9edeee300sm11165941cf.73.2025.07.10.10.51.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 10:51:22 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: lee@kernel.org,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	alexandre.belloni@bootlin.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: mat.jonczyk@o2.pl,
	dlan@gentoo.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	troymitchell988@gmail.com,
	guodong@riscstar.com,
	linux-rtc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v8 8/8] riscv: dts: spacemit: define regulator constraints
Date: Thu, 10 Jul 2025 12:51:06 -0500
Message-ID: <20250710175107.1280221-9-elder@riscstar.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250710175107.1280221-1-elder@riscstar.com>
References: <20250710175107.1280221-1-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Define basic constraints for the regulators in the SpacemiT P1 PMIC,
as implemented in the Banana Pi BPI-F3.

Signed-off-by: Alex Elder <elder@riscstar.com>
---
 .../boot/dts/spacemit/k1-bananapi-f3.dts      | 104 ++++++++++++++++++
 1 file changed, 104 insertions(+)

diff --git a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts b/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
index a1c184b814262..83907cc1d5ccf 100644
--- a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
+++ b/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
@@ -70,7 +70,111 @@ pmic@41 {
 		compatible = "spacemit,p1";
 		reg = <0x41>;
 		interrupts = <64>;
+		vin-supply = <&reg_vcc_4v>;
 		status = "okay";
+
+		regulators {
+			buck1 {
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <3450000>;
+				regulator-ramp-delay = <5000>;
+				regulator-always-on;
+			};
+
+			buck2 {
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <3450000>;
+				regulator-ramp-delay = <5000>;
+				regulator-always-on;
+			};
+
+			buck3 {
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-ramp-delay = <5000>;
+				regulator-always-on;
+			};
+
+			buck4 {
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-ramp-delay = <5000>;
+				regulator-always-on;
+			};
+
+			buck5 {
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <3450000>;
+				regulator-ramp-delay = <5000>;
+				regulator-always-on;
+			};
+
+			buck6 {
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <3450000>;
+				regulator-ramp-delay = <5000>;
+				regulator-always-on;
+			};
+
+			aldo1 {
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <3400000>;
+				regulator-boot-on;
+			};
+
+			aldo2 {
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <3400000>;
+			};
+
+			aldo3 {
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <3400000>;
+			};
+
+			aldo4 {
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <3400000>;
+			};
+
+			dldo1 {
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <3400000>;
+				regulator-boot-on;
+			};
+
+			dldo2 {
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <3400000>;
+			};
+
+			dldo3 {
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <3400000>;
+			};
+
+			dldo4 {
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <3400000>;
+				regulator-always-on;
+			};
+
+			dldo5 {
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <3400000>;
+			};
+
+			dldo6 {
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <3400000>;
+				regulator-always-on;
+			};
+
+			dldo7 {
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <3400000>;
+			};
+		};
 	};
 };
 
-- 
2.45.2


