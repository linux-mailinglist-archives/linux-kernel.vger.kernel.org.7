Return-Path: <linux-kernel+bounces-816322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 985B5B5725F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 10:04:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10A47189FE95
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 08:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF2872EE274;
	Mon, 15 Sep 2025 08:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c+fuKF7w"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359252ECE8A
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 08:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757923358; cv=none; b=J9nnbCn8rrqdkY6UT3rC4bGdPIrp5I6BFH9kv4gH05BSzheisfddyF/AuEASKoaHUSkyUvRAlNkR/UVl1oIIua8o20k+2kce8aNB5wUuLMxwk8zToOERiyraRIMmMJziE77mVEvzZ3+gps+CuV3p80IyL5K+ZrohuEQPLKkOOf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757923358; c=relaxed/simple;
	bh=ZP8BJdLxVhqepTeoAprsQQoaHGTUWulf0MMPVFLawG0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j2jEWRlWicNkYIT6sf/HtnNQtPeZ+qNaB8IiYhYjKjnDsMebZ9luBeix9J3X1Lw78tBR9kxRTVBG+I6dzeuXX61yOjoC5ncHDYieKnbM4rR9++WBwVZj9e/qfsuiXZ1HL01OUyppeuHQlT1nZiUKhKviU+UbCmu+9AAQ1010HAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c+fuKF7w; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-55f6017004dso3929899e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 01:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757923354; x=1758528154; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Q6qzvg9zj4AYnHkCVKkeQvxjf2xeDhmuMq00LQsCh0=;
        b=c+fuKF7wx+JJzb6++e9BxCG9/jzPP4EM0AjgBnzHrrJRbzLoI8iLp3tPeqOIOkbb+s
         kTxvpg9VrJ9xxdG1QjKGO/7Fx02F6cUD1Nbv43OtAM6pan3MzQ8J79G/QnzAGDZXSRK6
         4iOV8pfFmFF9CiYmZzfmgKIH76hFrmmj71cQq71kbzjhWLaOM1Yq2+GHCZxoqRwZOckz
         cIWJLDxCKnPx/3ymuIq309nW17SmKX6smQSCphfpmvqFeOvewHfQT6pl2VJR4p8roFE0
         ByWmcmwzmG5dDs82qVPS6Y1b8l7hdZerHCkjh4hC/0KxRYoJudeaknz0Td2JmkW4vAOh
         dCTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757923354; x=1758528154;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Q6qzvg9zj4AYnHkCVKkeQvxjf2xeDhmuMq00LQsCh0=;
        b=DQOjwAWxqAVLudncxctN/vMZh2Ogcg/lE1OcOhBGuEQs5CakW7wYm3JipIKsWN42TI
         u5DSXy9a4hQ/DVkiC1DNub1v7wP9ypOSdbnyBTlei591IyoPYbF8q4w7RLfki4/xQ5n2
         ct/hFnhSlezwK4b9Agfp8H+sazGkF2+z02hbkjOqFDRrK+J1ic8YTpZe3OZN9oVbvlOV
         DcyJTUAmGMWTGLgtxMz+5MxHFFYvTnikjCG93ZsnedrLxStNu4tY6nvqLFAGHsOO/Fnk
         ZbAco+MGUcsO578UID9iYvGys7opKPZDAIji+/Y4DEPN07rqBTeHDdWPMW0TsBZ991cr
         9aZA==
X-Gm-Message-State: AOJu0YzmS69TCdJDOvo0tfA1VhbRI9C4U0xCPIayMooyMu1F7o+2Nz35
	jgg7pkKjw6bsRzhU4J1zfTg7fj0N4gHLIPgXWNUGheNDEAnsjJYg/LDw
X-Gm-Gg: ASbGnctMNTvwmJHrPV5BMdJRM2vFDfr3PF7ZNn1ENhND9Q+ZsSsggkhAvp7Sbh8Ir1H
	dpLATDRC+h67Y28pOFLV2hUqpPNPBxuOJtE2hpL0T+5dc5PhktNeMr7tooBP4KDZi9Ay7U4ZxeA
	Yint/hoIblLq+NlJDJwWmYeSL+rQFpGrCGHSVaejk7QiS5TFouHgwJSM+ZsjgnFuwr/f0De3Yvl
	KX4hNW8hrRymk/TvcwgKNpQTaXMflBsMGPYPaNZapZnJrJLZKxaeHyFtznol/osMGxHlCVKOm7w
	A8rA/yf/SCYfYDtnUH6+3Ynb6kPC4kF6xXHr8Rcf7TyiaE5sZE2v5IHUi4bar/Vyoh8wcMV7mXF
	YJKLZNJlG8YmhfjNpEOhT9gJP
X-Google-Smtp-Source: AGHT+IFZHs9D3Q3V6b7uZxWsk/CxcN0Yj5+tr/3CYQ3DU6NoLaQn7oKgyUGIpmZVSIsX3gAHlFow2w==
X-Received: by 2002:a05:6512:79a:b0:55f:536f:e89b with SMTP id 2adb3069b0e04-5704fd772d9mr2486863e87.53.1757923353985;
        Mon, 15 Sep 2025 01:02:33 -0700 (PDT)
Received: from xeon.. ([188.163.112.70])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-56e6460dec4sm3392381e87.103.2025.09.15.01.02.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 01:02:33 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <treding@nvidia.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Prashant Gaikwad <pgaikwad@nvidia.com>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Dmitry Osipenko <digetx@gmail.com>,
	MyungJoo Ham <myungjoo.ham@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v3 09/11] ARM: tegra: Add External Memory Controller node on Tegra114
Date: Mon, 15 Sep 2025 11:01:55 +0300
Message-ID: <20250915080157.28195-10-clamor95@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250915080157.28195-1-clamor95@gmail.com>
References: <20250915080157.28195-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add External Memory Controller node to the device-tree.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 arch/arm/boot/dts/nvidia/tegra114.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/nvidia/tegra114.dtsi b/arch/arm/boot/dts/nvidia/tegra114.dtsi
index 08f81a3d11de..e386425c3fdf 100644
--- a/arch/arm/boot/dts/nvidia/tegra114.dtsi
+++ b/arch/arm/boot/dts/nvidia/tegra114.dtsi
@@ -195,6 +195,8 @@ tegra_car: clock@60006000 {
 		reg = <0x60006000 0x1000>;
 		#clock-cells = <1>;
 		#reset-cells = <1>;
+
+		nvidia,external-memory-controller = <&emc>;
 	};
 
 	flow-controller@60007000 {
@@ -591,6 +593,16 @@ mc: memory-controller@70019000 {
 		#iommu-cells = <1>;
 	};
 
+	emc: external-memory-controller@7001b000 {
+		compatible = "nvidia,tegra114-emc";
+		reg = <0x7001b000 0x1000>;
+		interrupts = <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&tegra_car TEGRA114_CLK_EMC>;
+		clock-names = "emc";
+
+		nvidia,memory-controller = <&mc>;
+	};
+
 	hda@70030000 {
 		compatible = "nvidia,tegra114-hda", "nvidia,tegra30-hda";
 		reg = <0x70030000 0x10000>;
-- 
2.48.1


