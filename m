Return-Path: <linux-kernel+bounces-849986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CCC64BD18C7
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 07:56:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F1CBF4E3EBA
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 05:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8C222E267D;
	Mon, 13 Oct 2025 05:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kBsroXvx"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7CB2DF706
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 05:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760334980; cv=none; b=fdgV1QLNOEv8gKSTysY59o06i+3q4sVnOw6daYQjPDkgHYMETsxVN9PFi0VSTJztpgx8nUs4KtUkeYOlTqnst7gWkafEFN60ArRFkAno3O8GR92aH1AFXlkuvGTWwxCv6M3EpxhbG7sOo68dea14BQyGioDBaEeXR3SC82zzLKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760334980; c=relaxed/simple;
	bh=o0ADLZP20Gf+RaCUCo73PsEebUZu5lyI6twUNiTxrps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ek8wfZ/0f38gXjiIlsVyytF8WKUHtu2uNdFXeQzOsnCB3flNinzkzV9OLnZxnWLMlpQ4Zhv5WouNYxBW6IjB1WDOd6SW8t5FiNZs6wcPllqmiaOnIKE5c3WJEh7+cBqijztKLArQX1d5VPzIfISp7FFiBVNGhXleNM2tSbJfBEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kBsroXvx; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-639e34ffa69so5910921a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 22:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760334976; x=1760939776; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CS1qvZ66jY4Y+/VjejeV3GAhiKWhtdvuL8aLYEGuxs0=;
        b=kBsroXvxeCmdzntD7FOSdYUKwLtc0m2wex3t9tnGX+nGl/4FZiIRlN452Npm+g/cWk
         kUDny9ndTQvlFBO662h7W1gjtjEO3XMDB7XqilQ/tyen/6Z6RldJE6W4A5sjNjYb0hOY
         tJivoGLYGStUT0k1asjE1dWa5KjlorPkvNDd2eoIytgSW6e4R6qAekPKeJHZWrlwCv9F
         b4I+8k/5un1iUYwp0xSxR2DWhKIyVj/u2BYCpqZYI1wvwUDwLFfEY/0Vs6Lhq92idySA
         QzT6JDqNDYadawa7Iru4l077Mwz6m4cHPtRyN8x3Stm6zgUIcKGkOPVDWCTQB4yu4CUG
         gCtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760334976; x=1760939776;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CS1qvZ66jY4Y+/VjejeV3GAhiKWhtdvuL8aLYEGuxs0=;
        b=xQvaj7VE1uQMIlYa6I7cFK09w1WEpJElsxdRXqZZWRWfTnDb87myRwcYvOGfC0RJS0
         2zMOMECG5xNwTyYB8HT+Y5TNI6IdHrfG/iZmm2lLigVk+vi9u7aPGmm9rausWDzjsiLV
         b0KCjCJrlmg/3uAW3mf7pLil/eFkaqcKl7RxAMylAPoE33uNydNO8H+/a8jRSAecPS65
         kKHfbUA5BSvvcF0OrdI9RBjp8zd/ZjpjC7czL9kc8iMSkQ5qv5WWY5qCD69O3DaeCRVZ
         J+qWdcyFPLTQ03FQPji/eDhC7/Q+FIPDZ5kUf7vbtlY01BG5Du9Q92lccmo2y3IrLvsy
         xhSg==
X-Forwarded-Encrypted: i=1; AJvYcCWjp2yw/NnLOC9+xbHbvQ6zORmP9RMcIWQy+07VwYTUIGtKqAM0jQDA3gHzil5qsYu1czAbujG/wiJdctE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZg193J1N+tUiR7RBBk9tarw8q4+VEnlCDnubygqSf0YOoH6u2
	yCyC/7NCzlEkucIxcsuA1FAY3bKiGgLXTVIhnfXhBPRNDqMmtZDsC2Pv
X-Gm-Gg: ASbGnctDsteXOXOoCDTUVmE/Y4VSHlVLEYtEYFx2CxLeSb8Ibo64DotgZo9pTNmxOXb
	HlQpSjRmBw+1fN8JEYt1FlwrJDbH5oVLrJfoV/+qD6d9OMwduuUIPvU8sYsi5wJGImiPSpmn/fA
	v+cwiVzM8eFiV3+65sa2TIoFXYqGKZjcUkShy++Yw3MOSAJjZzzOvzA1EHZSOVkF4R+CW/Ku7pd
	e2TyYcMgmqGR2bTcrUBYsmWb8G7YfjK5WL/BfAwhRYr/ZP/BnjegvbQORL9fUZbOVySEMI8xNnr
	9fXU41ScnwcbIaoTdBDmzl75W5arsNGzd+FCNEnHDn+p51WUTYIxJ291oRBqiaVLOC8NljSMaxH
	ufP1Mi8xinEhZiYGmG2J+VpFo+Rv0yRBGb05HJ9Gejlw=
X-Google-Smtp-Source: AGHT+IFXa8F9X+NAFTriZ5+fmvjgs8tTGl0KStDHQpx5xiYIKYYvA73do/5d5TYquynvGTa1Mbv2pg==
X-Received: by 2002:a17:906:7313:b0:b40:8deb:9cbe with SMTP id a640c23a62f3a-b50aa793004mr2095378166b.2.1760334976145;
        Sun, 12 Oct 2025 22:56:16 -0700 (PDT)
Received: from xeon.. ([188.163.112.70])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d63c9a3csm860912566b.23.2025.10.12.22.56.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Oct 2025 22:56:15 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Douglas Anderson <dianders@chromium.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	Sam Ravnborg <sam@ravnborg.org>
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: [PATCH v3 3/7] ARM: tn7: adjust panel node
Date: Mon, 13 Oct 2025 08:55:38 +0300
Message-ID: <20251013055543.43185-4-clamor95@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251013055543.43185-1-clamor95@gmail.com>
References: <20251013055543.43185-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adjust panel node in Tegra Note 7 according to the updated schema.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 arch/arm/boot/dts/nvidia/tegra114-tn7.dts | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/nvidia/tegra114-tn7.dts b/arch/arm/boot/dts/nvidia/tegra114-tn7.dts
index bfbdb345575a..75fbafb4a872 100644
--- a/arch/arm/boot/dts/nvidia/tegra114-tn7.dts
+++ b/arch/arm/boot/dts/nvidia/tegra114-tn7.dts
@@ -43,7 +43,9 @@ panel@0 {
 				compatible = "lg,ld070wx3-sl01";
 				reg = <0>;
 
-				power-supply = <&vdd_lcd>;
+				vdd-supply = <&avdd_lcd>;
+				vcc-supply = <&dvdd_lcd>;
+
 				backlight = <&backlight>;
 			};
 		};
@@ -101,11 +103,10 @@ smps45 {
 						regulator-boot-on;
 					};
 
-					smps6 {
+					avdd_lcd: smps6 {
 						regulator-name = "va-lcd-hv";
-						regulator-min-microvolt = <3000000>;
-						regulator-max-microvolt = <3000000>;
-						regulator-always-on;
+						regulator-min-microvolt = <3160000>;
+						regulator-max-microvolt = <3160000>;
 						regulator-boot-on;
 					};
 
@@ -325,7 +326,7 @@ lcd_bl_en: regulator-lcden {
 		regulator-boot-on;
 	};
 
-	vdd_lcd: regulator-lcd {
+	dvdd_lcd: regulator-lcd {
 		compatible = "regulator-fixed";
 		regulator-name = "VD_LCD_1V8";
 		regulator-min-microvolt = <1800000>;
-- 
2.48.1


