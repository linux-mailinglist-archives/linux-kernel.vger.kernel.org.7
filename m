Return-Path: <linux-kernel+bounces-892664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27200C45936
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 10:16:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 036C33B62AA
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 09:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8F873009F8;
	Mon, 10 Nov 2025 09:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jxKDIytR"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518A12FF659
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 09:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762766131; cv=none; b=WIbuvwO1pDe6kD3i4GVNC20VhvHsN3tp7YtUb6C64DPOcYp75XZOSzswwpiPBMB4vUcd+GRnnGtJUdqZ7kptHBXSxFdPAAuA21wpJIow92HreZjq/wr0tGifZX178sHTKrGI7geiMrTEYriAVf9Lt8JDmclmmbK94mPzRuN3xFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762766131; c=relaxed/simple;
	bh=o0ADLZP20Gf+RaCUCo73PsEebUZu5lyI6twUNiTxrps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zo8dXta9exOfZdZmEYdB4vwYeKAVfAZsD1nRvO2bnYgmf6OqYHMGqH0Zsm3kwa3OY5Z9yre0M+NhGswAl/sW1pIYF8QLDiGeB8E09Oa23gw0fnQWl8FHBWzyce8SE1gSzGvQNwmFcg/vR0fQE9IyLrj78JX+MupLzXg7MnWb2Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jxKDIytR; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5943b7bdc37so2557140e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 01:15:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762766127; x=1763370927; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CS1qvZ66jY4Y+/VjejeV3GAhiKWhtdvuL8aLYEGuxs0=;
        b=jxKDIytRPDugAQZqX2/1YEkQKz5ndm64a9UOrKEytDeoZ0cO58XY92GMvropUaVmJk
         hGcTavO0IY/glgNYnryp4PhF/70sch3zZqSdcgvfJUHHyFwuLWuxYCWsypQxeXCxhaB7
         kn85IfIjScyI7g8ftSjh8pf0PMKuSFF2P4SpUxNniKickmhn7VXbI2G7aTC0bbywb6W7
         /UAzcIr3Ai2WMMn2sCXHvilRHGKGj+vmsR4KZL8CWNTh/WwV+x4DjXtMqQC2nZSTv2HP
         al5qifP3PjUQUS6/I9zApAQqbnlmvFtxj+FoP84Y3s4wc83s86U31626s6/sHY2P9BJM
         A3rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762766127; x=1763370927;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CS1qvZ66jY4Y+/VjejeV3GAhiKWhtdvuL8aLYEGuxs0=;
        b=qM51lEUwFYnAFs5xqLRJuWeR3s/at2jRMCbUsynfd1C4CoJOY/6S7J7NfmDIHMHxRq
         ZhXUIOU5NO0oFAJ6TWXx5AU+sZsruYaUAHGfllwLInzf44LtdWqNXYTMlUUZo1lTyDFc
         by3wdFl4HOZSGqYgf8YAVUx4G2bFHaBfA3eJ5B4xZE700Cf22NIpbY7fSm0J2XVts9Bq
         Ezx+6s2DBHmSBnteSJdxHQghkLYmJF0iIdnMtdYib+dfO4KNXVK9sHfaG+nbo4K4HYej
         ruB1j6Rvs5rydfM7KF1c7bzBYX1EkVnm2qEQhV5PAlT5sI+6AnCVCeTjBrAKNBc0umFT
         FocQ==
X-Forwarded-Encrypted: i=1; AJvYcCX7QLKzNNb3ZyT25EOB0RJg579TJsvdeXzvcmz2Ev19RY0kJhIjIYKkCyTE88PGpUCcU985QhPrIFpfBj4=@vger.kernel.org
X-Gm-Message-State: AOJu0YykOB1bPEg7eYq82jKQ+Mz9BgXB6+C5YpGJmtRvMoc1M7FZHqY5
	RcR3Y2zvwW7OPfjBmtvhTJzG7nhb5Sn66KwrA3xNs5WtnI2nCX/Ql51Q
X-Gm-Gg: ASbGnct03yYa4I5hlZQG5ytTJGuFhjLdXJYAZi/Kk5nCuA5ejtDgO1oc7dv/otK+0LS
	Jiv/zRuhSl+y5accvE8KjUmsZYTa6tsn0OxmTtKOf2qt7/90q4CjJwLHu3g7RVbehlkpB6WNVdl
	H7hIOjEhi7iHDfGmE5W73JjPV1ITC9nKsJwRx0/kKLswbUdgj1l8zcUp5xe5eHItEVnL5FaSJxj
	J/zuXOBpMTKXGhUhSYHp3HmKvyIQ5piOmyD5IzIJ/9h/hqJAmXHB7TWu/oPbsYDEQOHlbOJV04v
	XiKbuhTJR28bwYqpZBNSmI64W1PGn9L7lIT9xhI7IIpnOlNp22HQ45y8kQV15I1Bn4bNAPzwG2c
	K/Vwf3BDdTqh46Tx4jpLHWdL4kZE+6AxKqVT+czqCrXt/umQHfysRWSbOFM04UGCw
X-Google-Smtp-Source: AGHT+IGg01NCiIGQo9N2wxV8aW1VWsEBMMCQPFsF2STXbWMO8Vd4nbT/5Lwb6SNxAC57s9F/DHJ/cQ==
X-Received: by 2002:a05:6512:224d:b0:594:511f:f1f1 with SMTP id 2adb3069b0e04-594599999d3mr3496080e87.11.1762766127093;
        Mon, 10 Nov 2025 01:15:27 -0800 (PST)
Received: from xeon ([188.163.112.74])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5944a0b76f4sm3852006e87.73.2025.11.10.01.15.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 01:15:26 -0800 (PST)
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
Subject: [PATCH v3 3/7 RESEND] ARM: tn7: adjust panel node
Date: Mon, 10 Nov 2025 11:14:33 +0200
Message-ID: <20251110091440.5251-4-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251110091440.5251-1-clamor95@gmail.com>
References: <20251110091440.5251-1-clamor95@gmail.com>
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


