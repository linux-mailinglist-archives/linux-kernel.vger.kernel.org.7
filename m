Return-Path: <linux-kernel+bounces-816325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0CC2B57274
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 10:05:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 917454405A4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 08:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13DE52F0C48;
	Mon, 15 Sep 2025 08:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GRhIkQZ8"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9567D2EA15C
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 08:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757923361; cv=none; b=PPstu84A3AH1t78h95mFOVPOekMoXtJQsb6d84hVYLW9VoZ9TKxxl2j+d411ZeMCHybaHT2qsOvfF/Se/TVtSgAUzZL5b1l0XhdnqWinfjKO/3knL6Hzg8Krs3tuWo6oq98odQHybDSvlRrIomDA26Y/VH5ETvZks0FHiQeAEdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757923361; c=relaxed/simple;
	bh=B4GtJKJBH9yFTatMG63gRF6gGdMXdBZOsjLfxiQMoh0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nsm7lfVLWao4tERcQPT1b2aamsIk4OU1RO6L7gKptRjQ5BaVaYyJqJn2mzT+TMhxPz0opF6pWweo89hs2CXk1A2ZSkYaR8Tqp7vkSXEKoHsPEs7FNuUrC0GjcPBy9Lcbc3iq4EldsrW11Jyxhn7xjD0qDvne1qOSrijD7EAXwEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GRhIkQZ8; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-55f6b0049fbso4441917e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 01:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757923357; x=1758528157; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fiS/YOa0S583TqGV9YqRvORe5l4bhLwLn8JjJheNcUo=;
        b=GRhIkQZ8uuVK9O3QHTpsQCbgJr0cQmcJkaoTAft5RTSRRoKNEfBidg8f9uMzxJsDAV
         HsHCUiwLa4NX8J6ngY5SVrBwQdpvHWbq5kGE5J2F2bdp2zJjlSdA7i98RTYlrUI4NMe2
         SzEE3RpMRmZ0f4pailEh/eJmtYZ8ZITnGXzmJGe6He5f7GVL+4WkSCyiDJfKvkLZpQqo
         zYmt65dKs3ApNrpEM1sliXjuv4rsbDdoA9k2QiPaqktCRpovS7pRf5MeTIUvuKS6ULjd
         CZqKDDJ38yyI1okayYBC90Hnp8VeRgvI9kh+YsNzXqQFlSljLUSFpwYW5xmR9nR0At6h
         zkXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757923357; x=1758528157;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fiS/YOa0S583TqGV9YqRvORe5l4bhLwLn8JjJheNcUo=;
        b=cfWj/Ph0KWEhOaBKLkbL+fHxdWyw0Or3ZLWojaoVQ3YP+1re1xlcatlnsQPtek+ng3
         V4HTKNtxqoROowP4QXxsaFzjEkAGasC1w7b6UEpGL/F0IhyehpvCTWjOktUhxpl+X/69
         k0cWPiszVtXH5eVQB01N815t6gnqHHQC8QN03wuTGPEfaMUmNa4R2C+XbKOY4ZcdQ1B7
         QfdkyJSBJZiUMcpm3A0J/ICle+64Iuz8EQ+tkE/uJ7tD5jDHjp7R6DDsfNKxiZTML5ON
         e3Xdx6dOywnO2CtQfBnV8Mt76vQHH8dBXCLA9F9Q/3lhbzSnzh2wkUmSq9rIDV6YpLsj
         9ufg==
X-Gm-Message-State: AOJu0YwcwlGsDQKshZyHS7IQGCtRu3Sshq5qOcfrieP3IEAewL0L1QKu
	0+0DxJI5TbpXNkC7BROcWla5T8kg8jZuX61uGn8zxTWcwQrDmP8JkHfr
X-Gm-Gg: ASbGncsaxGnAYYOwPvJ+Qauti1AQP3ET7dVxoF6ljAEKCeG8v2jRCMeyuFpj0+H0hbn
	YXXF3eGP43Ln+I7jM5tZF69XAiwb9PcuPEgmywbuacxmKBf3Piych4K2gCYb/LFfrJR0lx7WWWW
	KC8oGFKOMUVQGMwjk5JDuIKeIa+WdFbctG+8Xd0GoD6f4N3Kw+4gaQQjKoe/UPNHp8SosZXYGcA
	suwmRUmJZR7GZqhXMzyoZK+aKMHAfaHSZNhRN/pzgrbJYZIwo3hW9s6NmuxLkA8LKilVRUn+LXk
	+PK0/KqOSUVrIX8WwewEfXSb0ibG5xk1ifQkDfjnGPH63vJeUiBk78IyQlFoSEcfBUrvoXVkzub
	Xm6ep4Qa4wDOo+g==
X-Google-Smtp-Source: AGHT+IE+5sSGPH4rlFHoNVcXJtfPfdaGh32XS3N4z2KPM735+7UyzmLj5bDMEXfZtAVl5BWR4mXUTQ==
X-Received: by 2002:a05:6512:2311:b0:562:d04d:fa06 with SMTP id 2adb3069b0e04-5704f99c572mr3714704e87.32.1757923356547;
        Mon, 15 Sep 2025 01:02:36 -0700 (PDT)
Received: from xeon.. ([188.163.112.70])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-56e6460dec4sm3392381e87.103.2025.09.15.01.02.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 01:02:36 -0700 (PDT)
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
Subject: [PATCH v3 11/11] ARM: tegra: add DC interconnections for Tegra114
Date: Mon, 15 Sep 2025 11:01:57 +0300
Message-ID: <20250915080157.28195-12-clamor95@gmail.com>
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

Add DC interconnections to Tegra114 device tree to reflect connections
between MC, EMC and DC.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 arch/arm/boot/dts/nvidia/tegra114.dtsi | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm/boot/dts/nvidia/tegra114.dtsi b/arch/arm/boot/dts/nvidia/tegra114.dtsi
index e2bc8c2cc73c..63214109ec00 100644
--- a/arch/arm/boot/dts/nvidia/tegra114.dtsi
+++ b/arch/arm/boot/dts/nvidia/tegra114.dtsi
@@ -86,6 +86,17 @@ dc@54200000 {
 
 			nvidia,head = <0>;
 
+			interconnects = <&mc TEGRA114_MC_DISPLAY0A &emc>,
+					<&mc TEGRA114_MC_DISPLAY0B &emc>,
+					<&mc TEGRA114_MC_DISPLAY1B &emc>,
+					<&mc TEGRA114_MC_DISPLAY0C &emc>,
+					<&mc TEGRA114_MC_DISPLAYHC &emc>;
+			interconnect-names = "wina",
+					     "winb",
+					     "winb-vfilter",
+					     "winc",
+					     "cursor";
+
 			rgb {
 				status = "disabled";
 			};
@@ -105,6 +116,17 @@ dc@54240000 {
 
 			nvidia,head = <1>;
 
+			interconnects = <&mc TEGRA114_MC_DISPLAY0AB &emc>,
+					<&mc TEGRA114_MC_DISPLAY0BB &emc>,
+					<&mc TEGRA114_MC_DISPLAY1BB &emc>,
+					<&mc TEGRA114_MC_DISPLAY0CB &emc>,
+					<&mc TEGRA114_MC_DISPLAYHCB &emc>;
+			interconnect-names = "wina",
+					     "winb",
+					     "winb-vfilter",
+					     "winc",
+					     "cursor";
+
 			rgb {
 				status = "disabled";
 			};
-- 
2.48.1


