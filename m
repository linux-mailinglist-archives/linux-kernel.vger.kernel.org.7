Return-Path: <linux-kernel+bounces-726840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BAC3B011D3
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 05:59:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58E44648214
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 03:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4855D1A0BF3;
	Fri, 11 Jul 2025 03:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fm/GZpf2"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6A93B29E;
	Fri, 11 Jul 2025 03:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752206336; cv=none; b=MeWVjtNyAtnjVsCdVcBo6KVl1EVaZyYPTe0y6J50etuJhvU5EV9OlqbBLB9VRAC9ZuC+8ARMYxmz4YjkBI4l1Zb/rqpkFv2uq6/rcUjqQ9yFKj20kUm95U/LfoGt79wxb5fQXbYWrhz8YGFDmtbzTC/vPAend4TfGrSx+TCOy3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752206336; c=relaxed/simple;
	bh=qYVF5nrefqk8ZKCPwYrgT19os3rsqUvuedsH6yMaRYs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ODCPKjjB4f2QSIkBilcnPSo1kLiQOFrDWhyZHpkHgA+wkL19S8KVkEQp2ols1U5rRsIBxTDGtbAfzpk514aiN/iYLjzTzfgaz+vp8w+UjQpF83e/X+hRK7o0i2QR1Ydw1/1KA9yhB01Gui3XsR3ClLvGm9FaDuEDVtXbqxJmvFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fm/GZpf2; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-32cdc9544ceso14554341fa.0;
        Thu, 10 Jul 2025 20:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752206333; x=1752811133; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=//d0bJWkNr8qRs213bW7gb4xunennUE1PJsDFQia6Eo=;
        b=fm/GZpf2Hy2PzuqpvhjpWmP8r5qP538Z1KexcBU2j4bKK6IabF6pPMyUAOV8/4qy5S
         vnh7ivc3rFOlS4VaRyzFHSp4n8k8GmSnqZ8tNvGpHnNKZNkdXfRJdI/Ly1+i+m5pKdOb
         DSWroqZVN0gC8E1YQFjs4KuJC8tECWRc3+knp/LQzKRy01PoThNeYmiLNQoLuw1fwtGw
         wTDfntHr4T9r9iIkdNTNHCTokEn7lfoSGzfRJgqEXKDGnFvEDsS6Y3FW0MGyk8vCEnAA
         k+XqfE0rIT+4tsZIKbvBCp9wMh9BngPGp3CV0OCpExhbRDmBFjal6jsVp18l+u7/zZgy
         109g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752206333; x=1752811133;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=//d0bJWkNr8qRs213bW7gb4xunennUE1PJsDFQia6Eo=;
        b=SCeeNspgxfN6Ea46DKqHh3WwDkv7dmpZEpEJ/0s/oHxEMD/RfSf08ubGNikefdmYlP
         EQcNKzq+p3RVoPMPPEFzaR5bHQsapSocAEQDn6vOWGcmf9yf0+qwI/tgE1RCtw7w6Ith
         iwcUAp2yymM5mOWiPJmuiHxPdr1AeiPz70ZF7xzTDlg8a7hAdJtyl1mgQqrbenIIGDd3
         dlOFgpqD5osiEpsAl6rN/9HyGYphrkD9NNbXbXSkVSRHClD0TjMM9tNNF2cg82J7MuZQ
         jECEzMGjFjZ7NaP55xNv0gSHiFFj99vm5aRrVpBtrj1FVjQ1VnQt3Mlcq8aLUfrCGL8M
         PJAw==
X-Forwarded-Encrypted: i=1; AJvYcCU1qgQLy9zUC/0vbN5F23XAj7B+hzSljU9LaopqRTGT+mEbCdCaYZ8w+Y1+7iuhZBKhn5qyyfMmnCdu@vger.kernel.org, AJvYcCX7uZnGZ0/MUUyq0062VQF8t7Nej31RecZHOHj1Y3yruOlqNN/yASGRTzmyloDLI+FM633X0GaY7HqG4d6A@vger.kernel.org
X-Gm-Message-State: AOJu0YxrtdsC1d5H0W4mMLiS/0giITelC4QWzYVRqmjAjBt6FjtayuUf
	+yO0ZnKccaTCHLsmhjUbEDkD2p/3SCC7Pjtd0IO/6gbKs7JQwIkokhuS
X-Gm-Gg: ASbGncsJqxADsKsOUQTWosFKg3Pz6PUwQ3CjxVhg4TLRWpyrl+BgLPz2UKA/W9/zZpO
	6UI+swi4UCZYEWA0S7neyQnHNQ4XmdoEk0MKzcAcafR5goFxqtap654I0HvgTlDaIvxi9pdVErg
	32xoETCAhwDGG/Xq0aXsaogCXso/EFzFlSpX+zyTG9minDOGO7cl40+gusJpATa+/cjMBdHZ41r
	R23Lr7DMEsWiMoY+Cdqj/JGpSY9RCYLsFEXJzczW7HtHkSWuvlZMSp2pUTWWh71nITJDEpwrd4v
	jGeBX5b+1XerP0DC3RUGPB+NYtMzy+xFcrX3uMXuHy12v/CGtA2q7/kZGtMaoxc/l0SHh69avA0
	ZMHkbXlr4JQ0=
X-Google-Smtp-Source: AGHT+IGkeSBXm/EW3UWMspIGCG+IQIIuepjGaDlwWyIf9NR5Xr+PDLCyR3s4y1gsKiBc5fqAWrIf5A==
X-Received: by 2002:a2e:be0e:0:b0:32a:8297:54e3 with SMTP id 38308e7fff4ca-33053293f75mr4620471fa.6.1752206332869;
        Thu, 10 Jul 2025 20:58:52 -0700 (PDT)
Received: from junAIR ([212.192.12.80])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-32fa2943d46sm4971191fa.40.2025.07.10.20.58.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 20:58:52 -0700 (PDT)
From: iuncuim <iuncuim@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.or>
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev
Subject: [PATCH v2 2/3] arm64: dts: allwinner: a523: add Mali GPU node
Date: Fri, 11 Jul 2025 11:57:28 +0800
Message-ID: <20250711035730.17507-3-iuncuim@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250711035730.17507-1-iuncuim@gmail.com>
References: <20250711035730.17507-1-iuncuim@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Mikhail Kalashnikov <iuncuim@gmail.com>

The Allwinner A523 SoC features the Mali-G57 MC1 GPU, which belongs
to the Mali Valhall (v9) family. There is a power domain specifically
for this GPU that needs to be enabled to utilize it.

To enable in a specific device, we need to enable the gpu node and specify
the “mali-supply” regulator additionally in the device tree.

Signed-off-by: Mikhail Kalashnikov <iuncuim@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi b/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi
index dd6fa22f9..d3528d498 100644
--- a/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi
@@ -108,6 +108,21 @@ soc {
 		#size-cells = <1>;
 		ranges = <0x0 0x0 0x0 0x40000000>;
 
+		gpu: gpu@1800000 {
+			compatible = "allwinner,sun55i-a523-mali",
+				     "arm,mali-valhall-jm";
+			reg = <0x1800000 0x10000>;
+			interrupts = <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "job", "mmu", "gpu";
+			clocks = <&ccu CLK_GPU>, <&ccu CLK_BUS_GPU>;
+			clock-names = "core", "bus";
+			power-domains = <&pck600 PD_GPU>;
+			resets = <&ccu RST_BUS_GPU>;
+			status = "disabled";
+		};
+
 		pio: pinctrl@2000000 {
 			compatible = "allwinner,sun55i-a523-pinctrl";
 			reg = <0x2000000 0x800>;
-- 
2.50.0


