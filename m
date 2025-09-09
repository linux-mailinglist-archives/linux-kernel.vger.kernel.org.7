Return-Path: <linux-kernel+bounces-808268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 031D6B4FD56
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 15:36:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7758F5E3D0E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 13:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B5EB340DA6;
	Tue,  9 Sep 2025 13:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FGGJOp4J"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97FA2341653;
	Tue,  9 Sep 2025 13:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757424694; cv=none; b=nfjupo6yR3zf24r7AqHRytpwDsdYWqJlOjAqNSJGsFq7YnRrKrlGA3EG3TkC/a5LwOoFjEyU+PY6R23oDL5ll9IwKfYJz35L5k3nLGegv7taOElJ4slRsMe71sBMbY+PURP+7T10c35gieqacn8/kGqgiVcXN/K0O216L56Ynmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757424694; c=relaxed/simple;
	bh=EFaSWLlqCQFtM9g9Cg2x2HgnpsgConLUMd8fvLW4Wlw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aytBy5are1nO4c3//C6NfuHwGBu62k0ijybPBOeZb/RqhmQnOgGH5TRZbf5lVjzUY7LRF4mjhS3QEOtVufN54G+oOSyBhCR9VI0c+1NEFB85Wpyw3pFPtak2ZLqibVmi+3WFMNkNetbwO5OyZB++/3Ljv8ibJcl3gNPghlLExvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FGGJOp4J; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b49b56a3f27so3434485a12.1;
        Tue, 09 Sep 2025 06:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757424692; x=1758029492; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vf227nmbBVr78eoCmY1YIfO+zmAzbc+5L95fUaWK5oM=;
        b=FGGJOp4J3rTYSv8+g+h+rGlgDnnhyXUqPYGczZRi4qGcUHSSpiEZy2+EsQxJR7tLnh
         4KMDb0x8bvkol7c2xpOJbtSzwz5UM9WNrQSJYIJhMDgesCUR8fQDl841RLnZUORvNKmD
         1feC1PpDX+zhkmBLMxho0vfvc17lXGu3VXYubl9uyOpuX/4RRBoDw8WigriZRu6WGW2+
         3gpPos7q3ILbWBx4nHo3E+oZTIg1iuoDnduRfSQ29hJS/wOrgXElp9rCqLENBgfHTu1z
         weDzJPOHpQ9RtlDBkjhZdbOOrZfDCEtQRX8oDlDngQDQ7gFoFNSU7xq256/da3fzVjtp
         8ISQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757424692; x=1758029492;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vf227nmbBVr78eoCmY1YIfO+zmAzbc+5L95fUaWK5oM=;
        b=WqewpiNwi1vi/h8aDxrEWWUnWuS274pi5le1tXC38HOBPA24S4Vj9eY0WRcKquIRgR
         ykV669PexmcSOuZlX+8+haK9wU5RIVB2tDHNV+K3oa3fX+DsiFpqrYD5gJtnvlEhHSuM
         mcXBoUERvDxyjWy5g8dCEmy7U7KMwwLMzwkFzZr+B56kwyVTVDIMrFq9vyG1Ia2lQD6A
         MbJA5tmoEipf1uYySkVX6hVxK3K/YZxO6PPiDDSyMHVgOz9qPDUkJ6ZJfguXVh+XYEtZ
         C2CKMDjfdWNUDyHrumfrmkst/fetzHfZE9OHMluJTYCtjU6+TdHlrImwKf2DKQmKoShm
         DfAw==
X-Forwarded-Encrypted: i=1; AJvYcCVByBVcBIhqX+zPKhRIgpgHWA3NkscmM7vxFEnwqGQz4Gob63i0HB5yB4QhwHxbel1qvAEJO/Efr/yWOIlY@vger.kernel.org, AJvYcCVElgViFtH+OEuIRrXz48LZ61+c9D/wPt1BUaZczjcwDOVizF65MzHAblH7z15YYTk7tUj9jLvfmpFn@vger.kernel.org
X-Gm-Message-State: AOJu0YyU3JE7uVdAKO9eVE5NKDGG5tL2j9b8wNImV+TlslgQIvyemxgo
	+/FctG+wdk2EEEmVDTuiUHAMlZj1AMSY4sWbt+63ouEGRTBpmJhmA1mi
X-Gm-Gg: ASbGncv5gLYH/nljIwFR5xG5++zlhQgu9uj2kH+FhctN900VgODl9CcgD0Lu2KDug+Z
	EW/yrFMEGkPceb6houIyB+NiSijV/QRsgDmSXlrraaO3bSBEMdlM0VbvAi7pOUTMQhXL7gvt4UU
	0Ew5QEFRAmCx1DrsNi45OrU7SDRlVnoreYRxcFgkpdf/QwnK7b16qbgRPRS2Ob8ao4GuaEC1XM9
	fHOEcyVVxaE1i6sQhQphMiiVmZvr+InkHd0njXxwffdbdEa93rSRhB+j0IufDfofFvCnl687adO
	AtRoV58DtSSzyCAOImMMnAXS7SAq6o+Ku90GE5RqgfcrKv+xVxzXc8tIPA3oBwbNSsbT9YAyWEH
	/cbeZhnWWVmsxZUXya6f/5VblPcO1K1gsaCStxl6WjUpog9/nLJQ=
X-Google-Smtp-Source: AGHT+IEthdGhsisvIyGN1Z48pv9jWv3jpKaTdVzpsB9Py8tu3c9ndMxLN9nH0PnL8uY/ax5mYMCrtQ==
X-Received: by 2002:a17:90a:d403:b0:327:9345:7097 with SMTP id 98e67ed59e1d1-32d43f003bemr16178584a91.10.1757424690779;
        Tue, 09 Sep 2025 06:31:30 -0700 (PDT)
Received: from localhost.localdomain ([240e:3a6:1c4b:13c0:db95:4539:1490:64d2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32dab173060sm810778a91.5.2025.09.09.06.31.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 06:31:29 -0700 (PDT)
From: WeiHao Li <cn.liweihao@gmail.com>
To: heiko@sntech.de,
	robh@kernel.org
Cc: krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	WeiHao Li <cn.liweihao@gmail.com>
Subject: [PATCH v2 4/4] arm64: dts: rockchip: Add phys attribute of USB host node for RK3368
Date: Tue,  9 Sep 2025 21:29:58 +0800
Message-ID: <20250909132958.26423-5-cn.liweihao@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250909132958.26423-1-cn.liweihao@gmail.com>
References: <20250909132958.26423-1-cn.liweihao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RK3368 has a USB host controller and a OTG controller, both of them use
a extra phy, this add missing ohci node and add phys attribute for them.

Signed-off-by: WeiHao Li <cn.liweihao@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3368.dtsi | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3368.dtsi b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
index b09e431a64..cdcbc0a944 100644
--- a/arch/arm64/boot/dts/rockchip/rk3368.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
@@ -503,9 +503,21 @@ gmac: ethernet@ff290000 {
 
 	usb_host0_ehci: usb@ff500000 {
 		compatible = "generic-ehci";
-		reg = <0x0 0xff500000 0x0 0x100>;
+		reg = <0x0 0xff500000 0x0 0x20000>;
 		interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&cru HCLK_HOST0>;
+		clocks = <&cru HCLK_HOST0>, <&u2phy>;
+		phys = <&u2phy_host>;
+		phy-names = "usb";
+		status = "disabled";
+	};
+
+	usb_host0_ohci: usb@ff520000 {
+		compatible = "generic-ohci";
+		reg = <0x0 0xff520000 0x0 0x20000>;
+		interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru HCLK_HOST0>, <&u2phy>;
+		phys = <&u2phy_host>;
+		phy-names = "usb";
 		status = "disabled";
 	};
 
@@ -520,6 +532,8 @@ usb_otg: usb@ff580000 {
 		g-np-tx-fifo-size = <16>;
 		g-rx-fifo-size = <275>;
 		g-tx-fifo-size = <256 128 128 64 64 32>;
+		phys = <&u2phy_otg>;
+		phy-names = "usb2-phy";
 		status = "disabled";
 	};
 
-- 
2.47.2


