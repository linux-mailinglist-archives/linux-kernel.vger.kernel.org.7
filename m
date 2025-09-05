Return-Path: <linux-kernel+bounces-801955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D88ECB44C08
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 04:58:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D1B51C23DEF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 02:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 709E72749F0;
	Fri,  5 Sep 2025 02:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e9w66pAF"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4DB26FA5E;
	Fri,  5 Sep 2025 02:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757041053; cv=none; b=fxOMuSwIyGfFyS3zBNuIDIYdlMKrg1UMXScHBwaFGSXjzxNJJB+MkVcjQ9DHaAlcbrqPWIDcvN3o3JEynGTzw9Gpf1EtD2GhSryGVxVnMghnDTxwGbMkk78LsKJ0ytudgdwB5WhEmtOgTIOvXaCOsWcloGainGVrrZjzexOt1Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757041053; c=relaxed/simple;
	bh=81a6IJDOlVW8UyAd0Qblza8kTb778XH0yAUuFOu1WnA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Zh1pU2kF3IZWKVtbjzGyU1M3gevq8cV7RaCV4rvsfVx20X4glzc1bwvAhzic1VO1xL6d+Q6ZCJGC+vYntwAseFJtS9eQkjhV2JZzKIjesbEdArI5XfFKaF66w0qbdhoqXTTgaBCMgypyXMu7lrDZtoSEP1dqQjt1g9w1mAOjR74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e9w66pAF; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-32326e09f58so1866124a91.2;
        Thu, 04 Sep 2025 19:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757041051; x=1757645851; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A8EcrVIZwNopsNZSwOydQsgN/ufJO3CjXbEARxDEpAw=;
        b=e9w66pAF6JThbGQxz8ZvlIcmDjB1NZU03763yQjTu0etF3pt5heaCz5jVZRLephC1r
         d819ker+fvaIQdmQKU2KE9l0DGiSEgwLX7W+fWenLBKsvVkDz2sKObDXvCDDsRHX2tv/
         duUJBv6kdPgFoiG2ypQAwEWD5ZPLqlhITAIx+f+TR8yxZyWTavB0hxxkkOV/yEugjX8i
         7VSAbYnk2OFI71PUfljKgt5FWsolecHpcb37WzyLGAtbU6jIRTXXfG5D+C4LL6aZNIBE
         HwB5aInTU5VJsvq+OLEAW9j6yKE6SVkVpy+DzwRlXZ0CvaOi8VGOnOBDIF62zGDiJycR
         lsZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757041051; x=1757645851;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A8EcrVIZwNopsNZSwOydQsgN/ufJO3CjXbEARxDEpAw=;
        b=fKsoEd8Zz3NuE8b0d42Fnqem4c23k+m6Nl7QLUqp8IAHNMBVFK/qs1d9a07rJpUDRH
         OFkKxlZxf+67BuMDw0KN8+0Daca2WyYao4XYA8LutADvHgDHslr+FPvN0XmqXa37Mh/y
         gGwsYDyZKqx/g12P6SVih266zHmHWhKvHUvWMzTkfTnA+7XH5i530T4kawiHcChhFO/v
         vfzuE3Pj/S9a120x6T7A0KGpdQjrObkZZs/N742j4zUe8uqACyXs0vBiBt6LtHHu1MeH
         ccEtqSy+dV/ZKGkKAo9FzJxl6iFyzmgqwj6hmKADQ8lPnwXnJ5MWQHg/5glTjAdZ0qLQ
         eTTw==
X-Forwarded-Encrypted: i=1; AJvYcCUSjFhbVNITYqHTLHFYNMOI0cTGf1vyPv6Mjm3DP4h2VAjXZovYTlyo91RUB/78DGBnFCjtbHkyKghD@vger.kernel.org, AJvYcCVSOAWCbE6qoUhKPVeyx0ow6PavQeDwE+bN0mEk6xjRAGJE0BgK4EMb/Hb8tzxvZKOdKseX/zIcmXmp@vger.kernel.org, AJvYcCWEF+Iw+KcvfXqkcY3pN/TLAOsIXqola9wy8qxwAlfSSUCw9/6LaSL6ocg+VjyHJNaqW2Gr2KOz+dt0un8V@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt02m+G6iM3vbOlYcyE3QwOWGh/ptUp0KnhTfyVZD6jSunikax
	uH/DK87oRQqqzx9ZGnQzANxgwbBsJUV3V2dz/1KgKh/OQqdUcS6uJ7Y0
X-Gm-Gg: ASbGncuBPjUU7gRus1lOBGlHx67XHUNdJ6vRaIFhBRyF4xT0t0wLK/YQJlnCDDyWwi/
	Z1YfOTObrcY16gwWFtvrT1/lEBnG2a9eSvew75eTj6vx8yAB1cbaogqSI/ztiNFHl0ERF6cENNh
	Hw68NL1lRI4bFN6T2IbS36l2Z6FUCjIhieA5VwLJzRHVtziArtB6btOXcfQmmXIc3VTfZNSMYz/
	Voz+n9CxOZJ1fvfqBma4/0qzRJ8Pio1dy711fZDDEY3zFfHR71FWX9TmBIuq0YJi1HVTYVq4Jv2
	4BXIDCEBkch6aheEoOuVOkZfFDTg2bq8+/AZy6H+pdQXyPQCJUqUySS9SI8Vn95tw/uf0l1ueig
	P4M/cdgcYPDY=
X-Google-Smtp-Source: AGHT+IFkUZ/awaS6F+2idIA8T3dfM+RISVps6w8uss4iQ4826z031WYJJfT7U4nhTTSqsApsI52Duw==
X-Received: by 2002:a17:90b:1e12:b0:31e:cc6b:320f with SMTP id 98e67ed59e1d1-32815412adcmr22646678a91.5.1757041051319;
        Thu, 04 Sep 2025 19:57:31 -0700 (PDT)
Received: from localhost.localdomain ([2401:ce20:10::d4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-329e1c8e07bsm9428588a91.4.2025.09.04.19.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 19:57:30 -0700 (PDT)
From: WeiHao Li <cn.liweihao@gmail.com>
To: heiko@sntech.de,
	robh@kernel.org
Cc: hjc@rock-chips.com,
	andy.yan@rock-chips.com,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	WeiHao Li <cn.liweihao@gmail.com>
Subject: [PATCH v2 7/8] arm64: dts: rockchip: Add DSI for RK3368
Date: Fri,  5 Sep 2025 10:56:31 +0800
Message-Id: <20250905025632.222422-8-cn.liweihao@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250905025632.222422-1-cn.liweihao@gmail.com>
References: <20250905025632.222422-1-cn.liweihao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the Designware MIPI DSI controller and it's port nodes.

Signed-off-by: WeiHao Li <cn.liweihao@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3368.dtsi | 40 ++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3368.dtsi b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
index 60e982a3d..1b2178726 100644
--- a/arch/arm64/boot/dts/rockchip/rk3368.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
@@ -869,6 +869,11 @@ vop: vop@ff930000 {
 		vop_out: port {
 			#address-cells = <1>;
 			#size-cells = <0>;
+
+			vop_out_dsi: endpoint@0 {
+				reg = <0>;
+				remote-endpoint = <&dsi_in_vop>;
+			};
 		};
 	};
 
@@ -883,6 +888,41 @@ vop_mmu: iommu@ff930300 {
 		status = "disabled";
 	};
 
+	mipi_dsi: dsi@ff960000 {
+		compatible = "rockchip,rk3368-mipi-dsi", "snps,dw-mipi-dsi";
+		reg = <0x0 0xff960000 0x0 0x4000>;
+		interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru PCLK_MIPI_DSI0>;
+		clock-names = "pclk";
+		phys = <&dphy>;
+		phy-names = "dphy";
+		resets = <&cru SRST_MIPIDSI0>;
+		reset-names = "apb";
+		rockchip,grf = <&grf>;
+		status = "disabled";
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			mipi_in: port@0 {
+				reg = <0>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				dsi_in_vop: endpoint@0 {
+					reg = <0>;
+					remote-endpoint = <&vop_out_dsi>;
+				};
+			};
+
+			mipi_out: port@1 {
+				reg = <1>;
+			};
+
+		};
+	};
+
 	dphy: phy@ff968000 {
 		compatible = "rockchip,rk3368-dsi-dphy";
 		reg = <0x0 0xff968000 0x0 0x4000>;
-- 
2.39.5


