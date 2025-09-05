Return-Path: <linux-kernel+bounces-801953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AA9EB44C07
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 04:58:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CF86A484D8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 02:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A07C255E40;
	Fri,  5 Sep 2025 02:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rxj08zMF"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6335927054C;
	Fri,  5 Sep 2025 02:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757041042; cv=none; b=kMaXPhQAnRXeK+I/aYJ0WRxhQmd2+qzd/MIrEz+OmeCWfYZqcWujag2ZeTIMKp8DCbl4Ot8fU4TKFZumKDiiqa8uyzdE65CB6dAfyY/EyYNSYCD4qRJODdnVmAfkPhQPmtmgeANqXN34IxPWgm7xmULLP5rirO/kveVRJu9+spk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757041042; c=relaxed/simple;
	bh=l7Hm/F4RdXMTOMZqOrUTt6xr0ZSvFMzOH8Wy5f/f3UU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C/xSEsKhbt9OK4/R8DtxCf7Ch9P2SJlbrX6QL2X/3DSAXm14iVQr6l7gsvSmD3nE2m2c2dMUH9BDdQXE3SnT34NY0WGyusKwxTk1cARW4C5qV2WmNkPDjbO6RIqiZtnV9kx7EEGzx/V1X26MKh5Y7zq9YAtJe3PHRoX3vyZrOHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rxj08zMF; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-32326e20aadso1836679a91.2;
        Thu, 04 Sep 2025 19:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757041041; x=1757645841; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uvy4ABtAopbpacYZeTigpVnife8xFc0KLtur08dDo2Q=;
        b=Rxj08zMFxsJB80kecOR64onDxmyXFsUsvAC8UGtP1i1jHo29pLcLUabnmK5WG8DmPC
         thAucACNiQiDmBTZERhNA49PcoHIoCHOYm4IKYSFYjB39uCUmXqFbIlHSPNqFgxSb8zg
         jFVcDhSfVSQzzQ/oGGGJuYECKHPZ2eq8VqO1CrMLi8kbos8Jfad7Kr9M1jE+bJm6TkBg
         4lp/zjTr9aQ9s8dglwyikZ1vrF75DbaycSqiMYinDBEdU8ru/3SySlaK9qu10Gr5t7cT
         1yO7oTULRmy1iCNxlNBpvb3jtpY8mRd8ny11mnZy8K1q3k4dRBY4BtH88xvgxIztJjQ2
         NdyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757041041; x=1757645841;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uvy4ABtAopbpacYZeTigpVnife8xFc0KLtur08dDo2Q=;
        b=WXHLG7vgmpggrEtpaD+tL9xWiITuRhD/d4m0dYujZ4I51AysP4sbBaEPBkpt1bllxF
         KOc8/bY7xyjm8vMkFSy7e/bjNOFeeVBaMqfZ+oZsy+KTN16qWaJcSRQ6T8t0EvkPQxhx
         XsQ+PbcznIRGdMQH711jFRbE8TOIWREHCyqnNImvC9lG77uBmuhRHCzHo+aeY7b9IDwO
         BxgUL5YmZ8qTSxikCnF+1EzPlnrDSl1or3rQs/JgEkKmC+hOOMbv8OZrtsaGhuHm9gy9
         7ZBRPF9PMvhLLYY5NWjppVw/9v5xV1jijAqswipwAp0sioFYpd+UVGuooUtJW9gl8Odz
         3AoQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/Wlr6dnJlZ+frC3eCVuEz9JckwpkONxir3iejoMX/64Fm072BueUGv4QBQKMLGLB/GmcnGScYJo2b@vger.kernel.org, AJvYcCVoBjzPBLcxIYH7Uj7g5ZAoRXxvb3OFWy/nOuURmG3o/0AftfvuI1u/PkbQ+enmC2qVmfjV/1yl6y2jPJkp@vger.kernel.org, AJvYcCWP1KCxZEah+DUIQh3lpnmLI1LTib/4Ly/u6m0pu+lEFmpC1XgDFEnIt33UmqexIGxSABJNwyP+6Ml3@vger.kernel.org
X-Gm-Message-State: AOJu0YzIz0azYxEaR/nQ8OyXOYcf6pwYTsLStYkuD+E3EYEGGG96oDYx
	OCnY8TrUvHN+suFyb9pocH5cIFpjY0Hkn9dKE93eYbpe/HMFf3JDq0DN
X-Gm-Gg: ASbGncvobhTap3deiEmAeXex2khrgX2RMcbZWQ1mfS0Amps41C3BsOBvfSa/iuleRnN
	25ZwK9YdqopOBJSYiKAZemHC16UAzBkaZ7qTiTbRoIsemC+mgJN905GBVN80AuDz/CFojVpvniL
	EyMeQtgJac9Rieth3LUJaBNvO9DYev3/qr5Re4z+XSTwqcX1sTkAU7RecQxSVFzEsn2OZui0J9O
	j3pHPbKQ/uwTf6UXgJZFl1vQ0axiZ5qako9jsUR8JcjPY7v0JZnUbsgIwu5hOsvUj8AlugLLxzr
	k0rJQQQp1UullsiUm1T60zaXSGHZBeSxs2cZFzBrMuhakR+RH6cQuu9AAaNvuxDbGvedRsA9M2s
	St36B+64ta1E=
X-Google-Smtp-Source: AGHT+IEiluV/7pSFUxZt7TPIrj6CV/ImWEQeYgPKO2eLTDMwSsAtaVcas/jhZsOVhMfNixsNGg7TvQ==
X-Received: by 2002:a17:90b:518f:b0:32b:a76d:4c56 with SMTP id 98e67ed59e1d1-32ba76d4e23mr3808565a91.31.1757041040628;
        Thu, 04 Sep 2025 19:57:20 -0700 (PDT)
Received: from localhost.localdomain ([2401:ce20:10::d4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-329e1c8e07bsm9428588a91.4.2025.09.04.19.57.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 19:57:20 -0700 (PDT)
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
Subject: [PATCH v2 5/8] arm64: dts: rockchip: Add display subsystem for RK3368
Date: Fri,  5 Sep 2025 10:56:29 +0800
Message-Id: <20250905025632.222422-6-cn.liweihao@gmail.com>
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

Add vop and display-subsystem nodes to RK3368's device tree.

Signed-off-by: WeiHao Li <cn.liweihao@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3368.dtsi | 25 ++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3368.dtsi b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
index 73618df7a..9761dfc88 100644
--- a/arch/arm64/boot/dts/rockchip/rk3368.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
@@ -140,6 +140,12 @@ cpu_b3: cpu@103 {
 		};
 	};
 
+	display_subsystem: display-subsystem {
+		compatible = "rockchip,display-subsystem";
+		ports = <&vop_out>;
+		status = "disabled";
+	};
+
 	arm-pmu {
 		compatible = "arm,cortex-a53-pmu";
 		interrupts = <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>,
@@ -847,6 +853,25 @@ isp_mmu: iommu@ff914000 {
 		status = "disabled";
 	};
 
+	vop: vop@ff930000 {
+		compatible = "rockchip,rk3368-vop";
+		reg = <0x0 0xff930000 0x0 0x2fc>, <0x0 0xff931000 0x0 0x400>;
+		interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
+		assigned-clocks = <&cru ACLK_VOP>, <&cru HCLK_VOP>;
+		assigned-clock-rates = <400000000>, <200000000>;
+		clocks = <&cru ACLK_VOP>, <&cru DCLK_VOP>, <&cru HCLK_VOP>;
+		clock-names = "aclk_vop", "dclk_vop", "hclk_vop";
+		iommus = <&vop_mmu>;
+		resets = <&cru SRST_LCDC0_AXI>, <&cru SRST_LCDC0_AHB>, <&cru SRST_LCDC0_DCLK>;
+		reset-names = "axi", "ahb", "dclk";
+		status = "disabled";
+
+		vop_out: port {
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+	};
+
 	vop_mmu: iommu@ff930300 {
 		compatible = "rockchip,iommu";
 		reg = <0x0 0xff930300 0x0 0x100>;
-- 
2.39.5


