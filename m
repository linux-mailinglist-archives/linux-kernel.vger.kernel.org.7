Return-Path: <linux-kernel+bounces-790400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24082B3A68F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 18:40:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C3BC1889D27
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 16:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E546932C30D;
	Thu, 28 Aug 2025 16:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F+vNHOAI"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08C5322C89;
	Thu, 28 Aug 2025 16:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756398909; cv=none; b=LdsFk+fkGUXImJrtvx6qVqyevWbAo0CXsnQ6K3ENSs/bBCAyC854ezSTvBKXMhu5GU6sFhFidMdBXfctQJxtl2mg54mrI4GqdCk5Jco5ssUfC0OwzEd5+WTwtImLuBXqv3Sj0BCazQDYlrh9owTSmVzOatVUbrn1uDlODjGXQsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756398909; c=relaxed/simple;
	bh=bS4L1PKhv0i/jNUiUgHI1hHlj1jlqL4YZVVWfFOTjlg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XJ9o85ebeiuKCjN8z7Zq9pllF58qu0Gkq8IlCZg/Ob7Ovd4cx76zcWARFYqipkH5bEHdSbn7YaOizJdh5kS4E1JGBsr/E9r9U+UjxtxbPAdKcn/ktSsHtjziCslfw3yL0H8Yl+3yRhcGrUfx9k2vctGxpYWMopOcpnM1MZmjIqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F+vNHOAI; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-45b4d89217aso7388525e9.2;
        Thu, 28 Aug 2025 09:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756398906; x=1757003706; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JfYQ5wQeWPqj3q6NX8K9M3CLRkWa1reIgFJFV3niqMA=;
        b=F+vNHOAIrrgkcvorhUtI1MmHaNN5IkC/eYYl8+aUfD5+t4FdK1UV9Q9StCtxYI9MyU
         dHu2+MvnEyTiu9XNfjx4iAqMb3nAggVwRUpGerMWIMV2iUilXTzyGScHUEicdG/dTxt8
         sO+E0xE56xjExjMYgou33g24XoOBfdVSmV34q8YrqafMxsHQoKreXsg/tkjX123BBrzE
         88B7B8korFchrdqB2Otx8H2hOAA+jsjVnfN5zFBZr0chLmLjwr066OkMHRkmxqNtYNRp
         qlUZkwOPM/ZTFu8qzbmZLniaLFU87MkKOmbuaMcw/Zf+8sTG2Gqh6RkMAowruQghEgRw
         QVLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756398906; x=1757003706;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JfYQ5wQeWPqj3q6NX8K9M3CLRkWa1reIgFJFV3niqMA=;
        b=gFxck6bXRrlHwEKG1ZWIChJQ+Jq/0ercQrmZGgCPivbvbnPaYM81JWANzOUM4lCax4
         8PwZXVF3/hjxj1iBxKrYAzSTBwib57tBFcrKICg+rBbADrW9hu9Dhrn8vXdV2BqvXUVj
         Sraf78Mo3nVKJ0b+Uc4UylqHXo0Rz//78LqMRsCMSwTeUpv68TBPxKF8BWBJhSXinYZU
         QnFl9cYZdcIBoQc+FAlmX8reUMJ8Phxa+d0JSEcKq8kjd2zfpgdeIIrYKtwr0o4pzH7i
         P7grLFZn3SR82zRDe8iKMmZLSFeOjRqQIe+RX6yoHodLtT6fx7zFO9rrKZv484A4cQPc
         gzXg==
X-Forwarded-Encrypted: i=1; AJvYcCU6DldoCN9eDac1vBx5cQBoL6z2dnqnGfOiHUK9Ro5sLWwcSxO65W5x7zpl4q7bGI4WiaCFBOhrLhQWIrzW@vger.kernel.org, AJvYcCV3TE7f/Ag2P36/KjsrJXCnazyQHR9pA0VUDHjyJXFXwEhXyzsmPCeJJCeF9TP73rznsgwCmLub3gop@vger.kernel.org
X-Gm-Message-State: AOJu0YynYDgIcUUPuJBpkqtFyqkUpWNZHJKVWOI7J8RJBAJGIItA//t+
	eMn72QS813Ke5OZ/iLL8wIcW81Gq6HH5kI9GN6brFuopaQWBUUWVeUF8
X-Gm-Gg: ASbGncv9rPpvVm/aAFd2wze/4zwqVUvvaQfZXJNiDgn/eSSsYa0f2a9ifCLwlXpiU+m
	cHvFDguGT9HFXQTHgpSViG8ACD3qC5gXxkQcT6qZW1vraRxonlprhvrQLHVDSR/nlKHmAKkHyyN
	aAT9kDLW3cQzQPSumvEL80FiLc/UrtK8RYM8WDBKevECOKiz3Bcqkhp8p3ysnv2/f9/TiOeRodo
	0Y23mMAO4vrxzfuHjEp/4dXk63Gye3dNXFCOpawyXzTilA6useZnPinAVXXHuh/imvP1pA1QnbU
	4Yt7AfWKNYvPtSk99Ye7NpASDNEoSfjeHWde0zBgSh2XWxzXPxmGdk1bUxsvBkZ9VtwfWmNcidy
	qEjq9llpCI7/QVoyc4IycMNKwRXlN3sTMgH02Ww==
X-Google-Smtp-Source: AGHT+IHTw1bI2QA56HfNvV10B5zkkRdlJjRVGOQb4dNonItwDze8Jpvoj6Zs4dslyNbDt2NCzDeisQ==
X-Received: by 2002:a05:600c:3583:b0:45b:7e68:c6a3 with SMTP id 5b1f17b1804b1-45b7e68c7admr2936725e9.16.1756398905752;
        Thu, 28 Aug 2025 09:35:05 -0700 (PDT)
Received: from toolbox.. ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b66c383b1sm61069365e9.3.2025.08.28.09.35.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 09:35:05 -0700 (PDT)
From: Christian Hewitt <christianshewitt@gmail.com>
To: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Alex Bee <knaerzche@gmail.com>
Subject: [PATCH] ARM: dts: rockchip: add HDMI audio to rk3288-miqi
Date: Thu, 28 Aug 2025 16:35:01 +0000
Message-Id: <20250828163501.3829226-1-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alex Bee <knaerzche@gmail.com>

Add the sound and i2s nodes to enable HDMI audio output on
the MiQi board.

Signed-off-by: Alex Bee <knaerzche@gmail.com>
Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 arch/arm/boot/dts/rockchip/rk3288-miqi.dts | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/rockchip/rk3288-miqi.dts b/arch/arm/boot/dts/rockchip/rk3288-miqi.dts
index dd42f8d31f70..20df626547bd 100644
--- a/arch/arm/boot/dts/rockchip/rk3288-miqi.dts
+++ b/arch/arm/boot/dts/rockchip/rk3288-miqi.dts
@@ -78,6 +78,21 @@ vcc_sys: regulator-vsys {
 		regulator-always-on;
 		regulator-boot-on;
 	};
+
+	sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,format = "i2s";
+		simple-audio-card,name = "HDMI";
+		simple-audio-card,mclk-fs = <512>;
+
+		simple-audio-card,codec {
+			sound-dai = <&hdmi>;
+		};
+
+		simple-audio-card,cpu {
+			sound-dai = <&i2s>;
+		};
+	};
 };
 
 &cpu0 {
@@ -283,6 +298,11 @@ &i2c5 {
 	status = "okay";
 };
 
+&i2s {
+	#sound-dai-cells = <0>;
+	status = "okay";
+};
+
 &io_domains {
 	status = "okay";
 
-- 
2.34.1


