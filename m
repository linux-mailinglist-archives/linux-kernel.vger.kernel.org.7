Return-Path: <linux-kernel+bounces-855681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BC4DDBE1F66
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 09:43:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BF0284F609E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 07:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B29D2FF652;
	Thu, 16 Oct 2025 07:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mLCFyX/C"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66032FB97B
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 07:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760600547; cv=none; b=r8tW0STb1bpQtKmiYnnhxgbCp8JrxcuglH6v0y6Dx5c5XMBVJjXvh7eeSRCOpnbqSIZcOIbldTxJvLANVy8QtJJYfks2OK9pdfHRQnxk3UaodOyI31NzapL7WvkeIs39kzz8VGf1m+WLgGk7/Y/wpgBhxJ3JiJwcgkA+GSk1+ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760600547; c=relaxed/simple;
	bh=xB0LZwMzhZT5j2b0jjsQ2KFZrgTIo41/jiusVXvcdes=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MS0h3MxxCrpItF8U565TCgRzTFo1ifPF2iwfLsr3tisxfYFFG93nfmXB0gnLAuXnTV/a+Qcf2OSbfXnIYQzPelD5RYM53ZQRpU95MJGWFFjJC6e6nKpWVZrv8aohZyU6aZ9iDnAHLuzBc4JZI90K1vFR8GLFErjbNqicXhfENYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mLCFyX/C; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-36453927ffaso3516801fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 00:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760600544; x=1761205344; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GtovmNeUjM/Ta3qpNFjKfyT/fym1ZwzATHtxvDM0Z+Q=;
        b=mLCFyX/CvWF7iJbpNR6LtsGMSmXNsBXtOP0rToZOH0SXChJFoAfLVxME6t6GbaCEVl
         gDwBk80VKRnF1UgPc9jBqYviHWL1Mo/F7gkNphuszXUklAjhv5+O32vBvg/WpXjHJiXa
         fo+R27mRzUlGOXOxitFMz5nQ2y4WvWwk60ticGe1+CbVzmyb95XszSJBsji06/NX1MwL
         J18+Eo7vK7Me4y6vZacJiM8Q/c5hHwSxFVSVKZ0K1TPy6vy0VPek/mdB7FwEluU3FnjR
         wf2EybZfjYg/0gvJuw35NPO88E032vUZ32GyVIYX6Ca1HVSyjmnp5mH+x8i+ce4CIigS
         U16A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760600544; x=1761205344;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GtovmNeUjM/Ta3qpNFjKfyT/fym1ZwzATHtxvDM0Z+Q=;
        b=WUcmodIjOZhBeGY8pjjscFVa35dQHf2NOoa+gDC2nNchsP/1cQMH+3wRt7+CtTOyrQ
         FZKtzybariFN84WN4Ik+jdSTD5sp4B//FTo2W7PiRlsbrTfQWCc7qfnBNkG0J7Ckmlmm
         1kl/Jvonzxxcd9ilNltcn2dHyrjbGsmrh5xKrHzx/x+ummu8XEDVDC/+xbGqMu+/lovO
         uqEh5Hsc4ek4pl0vqOYiFOa/Vwob/nvRrQ7uEg5xMqioJW0VpuiMxiCw58+t+aqqTGGN
         VZJ9veDQpe3iYF2RsTwjsSa3Kp94HHtzAP4xT6c6sm8NdTi5DmHE/h4Jzop7BF9KTkBC
         ab8A==
X-Forwarded-Encrypted: i=1; AJvYcCVslr/+TY/axGXk/FhqTCpvG4npPbVp0SU+JxtxRYGYHl1sjK7tNsKATtKY4129wLQQotCfQPljPbvQri8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEdev5sD/0t5if2n9HRxt1UouCnwp/McnAj1N2+/GsJru2CQev
	4rYhabE/IumNF2KXdk9ooT99C4sO1MRs9oOmGCHt06Bcn/Z2Wn0/Rwtj
X-Gm-Gg: ASbGncv7K0+n/M7vc3bbOgzq9QKA7WVpnsp+AD3YtdhN8Qxh9NFg+qsAydoeIfYFsZL
	XBOx4B32DHONDkPBhn77k3YkzgTL8foZaM9OALbj3DnEsSBB8tzEpL0AdbHff4Zqi/G+LzMHzN+
	+HjDZKV8KBH/2GKIiW8r1A4shp5KQzfeTzb1qN+6kNgKfFqSQNJW2P5sXpTojktz/X/J/vXF6bt
	ua+UUigbyBTfIIWIZUtDzqKMtd/riXvdN78vgc2Cisk2JqcM0s35ST7/oYE88FJfzCl1edEI8os
	jcuTRpnirDQ0+6D1xlDDWmU3RDSEIvFDq+fLU1ornPC6qXIXtafSJAP38RpEimi6pcSt4clyk2o
	Og0bxFIYlCjn9KrnPXwE7uxeNssm98lCF182zqa5twJuepQFrPla9slJMlPDbAt5GJUU=
X-Google-Smtp-Source: AGHT+IFbllf5hFrxaT2o/OaVZ8Ngh/7DhF2hoeMDKN0lK28m8mzh79yF6GtziaC1JfPDf0mmnNoccg==
X-Received: by 2002:a05:651c:35cc:b0:36a:a8bb:9b81 with SMTP id 38308e7fff4ca-37609cea827mr90279441fa.5.1760600543533;
        Thu, 16 Oct 2025 00:42:23 -0700 (PDT)
Received: from xeon.. ([188.163.112.70])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3762ea14d46sm53226121fa.34.2025.10.16.00.42.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 00:42:23 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <treding@nvidia.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: devicetree@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 3/4 RESEND] ARM: tegra124: add missing HOST1X device nodes
Date: Thu, 16 Oct 2025 10:41:51 +0300
Message-ID: <20251016074152.8759-4-clamor95@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251016074152.8759-1-clamor95@gmail.com>
References: <20251016074152.8759-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add nodes for devices on the HOST1X bus: VI, ISP, ISPB, MSENC and TSEC.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Reviewed-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 arch/arm/boot/dts/nvidia/tegra124.dtsi | 64 ++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/arch/arm/boot/dts/nvidia/tegra124.dtsi b/arch/arm/boot/dts/nvidia/tegra124.dtsi
index ec4f0e346b2b..ce4efa1de509 100644
--- a/arch/arm/boot/dts/nvidia/tegra124.dtsi
+++ b/arch/arm/boot/dts/nvidia/tegra124.dtsi
@@ -103,6 +103,45 @@ host1x@50000000 {
 
 		ranges = <0 0x54000000 0 0x54000000 0 0x01000000>;
 
+		vi@54080000 {
+			compatible = "nvidia,tegra124-vi";
+			reg = <0x0 0x54080000 0x0 0x00040000>;
+			interrupts = <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&tegra_car TEGRA124_CLK_VI>;
+			resets = <&tegra_car 20>;
+			reset-names = "vi";
+
+			iommus = <&mc TEGRA_SWGROUP_VI>;
+
+			status = "disabled";
+		};
+
+		isp@54600000 {
+			compatible = "nvidia,tegra124-isp";
+			reg = <0x0 0x54600000 0x0 0x00040000>;
+			interrupts = <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&tegra_car TEGRA124_CLK_ISP>;
+			resets = <&tegra_car TEGRA124_CLK_ISP>;
+			reset-names = "isp";
+
+			iommus = <&mc TEGRA_SWGROUP_ISP2>;
+
+			status = "disabled";
+		};
+
+		isp@54680000 {
+			compatible = "nvidia,tegra124-isp";
+			reg = <0x0 0x54680000 0x0 0x00040000>;
+			interrupts = <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&tegra_car TEGRA124_CLK_ISPB>;
+			resets = <&tegra_car TEGRA124_CLK_ISPB>;
+			reset-names = "isp";
+
+			iommus = <&mc TEGRA_SWGROUP_ISP2B>;
+
+			status = "disabled";
+		};
+
 		dc@54200000 {
 			compatible = "nvidia,tegra124-dc";
 			reg = <0x0 0x54200000 0x0 0x00040000>;
@@ -209,6 +248,31 @@ dsib: dsi@54400000 {
 			#size-cells = <0>;
 		};
 
+		msenc@544c0000 {
+			compatible = "nvidia,tegra124-msenc";
+			reg = <0x0 0x544c0000 0x0 0x00040000>;
+			interrupts = <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&tegra_car TEGRA124_CLK_MSENC>;
+			resets = <&tegra_car TEGRA124_CLK_MSENC>;
+			reset-names = "mpe";
+
+			iommus = <&mc TEGRA_SWGROUP_MSENC>;
+
+			status = "disabled";
+		};
+
+		tsec@54500000 {
+			compatible = "nvidia,tegra124-tsec";
+			reg = <0x0 0x54500000 0x0 0x00040000>;
+			interrupts = <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&tegra_car TEGRA124_CLK_TSEC>;
+			resets = <&tegra_car TEGRA124_CLK_TSEC>;
+
+			iommus = <&mc TEGRA_SWGROUP_TSEC>;
+
+			status = "disabled";
+		};
+
 		sor@54540000 {
 			compatible = "nvidia,tegra124-sor";
 			reg = <0x0 0x54540000 0x0 0x00040000>;
-- 
2.48.1


