Return-Path: <linux-kernel+bounces-802911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CFA2AB4584B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 14:56:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CA0B3BFC2B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 12:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABD4E35208E;
	Fri,  5 Sep 2025 12:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WUM5s/Se"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A523438DDB;
	Fri,  5 Sep 2025 12:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757076894; cv=none; b=DNr43f+jq8j2IicQc1Zm3lMf0lWqrKNN7J9Iiuhd7YMdeOiCepb3BCyHd52CgRo7/kqVmrMpOAuF8zpUeoPPxbf531SlF+QoPdNgTJTkpiaelYPKjM8dPojLQlh+jrFktvtPV+HZwjZ2Xx/pzwvtv30Hus1R2LlWz2TlAyje4Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757076894; c=relaxed/simple;
	bh=eamEJceWSxTAppXE5o09addt++oNyXlI0Ksv99L0jLE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q1yCSripEpHJttBUkwrQaFm9dIMibds4SieyLMOKjW8e/7FW7AV4jEgJjlQA+zxqvD8PiGhblKVuC58PHj9AUZk59kUtbiXFENmMI4P/fYTADU6ALiIU3cpQMg67eqyXE2wnTszUVT2bmJDAbSANXKzHeGZjZV6ZSysbcNo1y6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WUM5s/Se; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b4d4881897cso1425522a12.0;
        Fri, 05 Sep 2025 05:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757076891; x=1757681691; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AuuQ7S4ybXTFvfChB1I/Sfk/dWMuL7wWCdzzVYhLuhg=;
        b=WUM5s/Se9T5UKrAn0528AzDrDXze4aU6NsudK6Ns39mqqXYJfT7LFgCHwczyTMpz9r
         dEIFwgmx5i0F5ZfqeYzZkEywRUGPaz2mdJqw/rGtuSnH9wXL4KsW6ro1OPIBp8zVXBWH
         +1uo8LiYXwOPPYIOsA53nYU9oghZVUE50bFFHz1leo+Q3csLxwmQ650tcB/V7Vtz5vyM
         9HBG86L30tF8I67LJOvsbjRHf769VPQxYXIKAP6IJ3P9gM1NF+QNulC0fUjazpV9Xlvz
         O0ENIcWID56E4wWzCzODFT25u9H+tA47v3j6PI6D46OmWEYOcwwKm0q0BqQPhxxLqIbI
         B0SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757076891; x=1757681691;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AuuQ7S4ybXTFvfChB1I/Sfk/dWMuL7wWCdzzVYhLuhg=;
        b=WM0pWyHKAGUkYy3iQ28SrbKa7eTf/5cR2s52Ljo7hG8u7IcRgehrIPxcdetzF8SNco
         MnxDQJXbrQ9CreiJP2f/PlGlGCLiBhBnwSlFVsgGistNG6N5ez01PK/pnHUkuBSWN4h3
         DnCxlAQ2pF2W+oaH0oiGCfgzUgF8maiuKTZO6Rv+mSn2Lb3WfK2U4gU0Ytl+6ES9sgXg
         2X5GrX+pLdhgVgKMTgFJkA3KlOE/KE+ora7IzSJqXOMxbJXtjrmQpFDHlT2d1RL+nLpS
         AvjvHN+V+vRO9NZkrNBiZ9SRHmdMMSlz7E5GgGFskmnpOZrwAPw7kdhMSvpdPCB0+EXW
         xm9A==
X-Forwarded-Encrypted: i=1; AJvYcCVJH9ocUwCqFwlDiW/K9U+a4/4qiCW7JNZhEUFh1L1Y2+be0Dj1wCOKWThk82bupL1/6yg2VS3VFDv9@vger.kernel.org, AJvYcCWnSV+e4RhTEdIHMKbEQdgZfiGajCGcMJtSZT+E9CF1mZuRGPq/qyzvuStWmnt32Tqi+/GhESBWXe74CrFS@vger.kernel.org
X-Gm-Message-State: AOJu0YwbrU+PAtxYGrY+byMk3TBbiNRPHz9bQ015YrWTnEuUgiU9NMW6
	Xi9yyCMgT9OkjsbJeiRty6rITX3lcXSwNWwt4iFmrqwfOxmZrpNQQXlx
X-Gm-Gg: ASbGncu6pGbNwxVl0g7Kt8PAv5t4UbyIsyDzYZoErMJbAkSxPmix+EavLTLOxg6wKYn
	t5vsDs4DQCbTJm40ByVlTiWg78+7kfggkosvoDku/CopP30n0tqJOXudoPbHKtNH/jCRr+Xg9kc
	wg7fSEa4o3rgqIhK7InxYLglvXSUnDj2oUPo4qcg9qKNZ61A4ECQqRp7E3oj+/1MzMMuuUv8B3/
	oaRqLsaWo+0q2m5ItIX3fovMRkdolTwjcOrXrGizQDslZTd9/vGDbfJ92ez/kO1QOWgS2P3nLAe
	uC1oldYVl5PYTFDQI+a0pPKC7k0VGMYrK6gm76V5TgFjdbKSEgAyUf3a4jXwArs0vJfDGV70Ccv
	3mF2AzuKC6Eg=
X-Google-Smtp-Source: AGHT+IEtbVAubtisL0GupY9TFnD4SDR91Dvehih/Ojj5VLnQlx0AokWcZERj3KwO9OcTwoM0fMvPXw==
X-Received: by 2002:a17:903:1b6e:b0:246:648f:80a3 with SMTP id d9443c01a7336-24944b5734amr277215935ad.50.1757076891018;
        Fri, 05 Sep 2025 05:54:51 -0700 (PDT)
Received: from localhost.localdomain ([2401:ce20:10::d4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4fb98f9f6asm4992305a12.8.2025.09.05.05.54.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 05:54:50 -0700 (PDT)
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
Subject: [PATCH v1 4/4] arm64: dts: rockchip: Add phys attribute of USB host node for RK3368
Date: Fri,  5 Sep 2025 20:53:17 +0800
Message-ID: <20250905125318.7956-5-cn.liweihao@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250905125318.7956-1-cn.liweihao@gmail.com>
References: <20250905125318.7956-1-cn.liweihao@gmail.com>
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
2.39.5


