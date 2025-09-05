Return-Path: <linux-kernel+bounces-802909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9CE8B45847
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 14:55:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 447303AA0A0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 12:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE4DC350D60;
	Fri,  5 Sep 2025 12:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i2ajrAYq"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6900350D43;
	Fri,  5 Sep 2025 12:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757076884; cv=none; b=gSsqwTvwyu9c4n3XYTWtoQs5ZSW9NIpEX4kVgceWOWHBUju//qMREi1Lw2tDNNFAzhLEKZ2SLFQ4gTyDLVKmxth1ni5lCOaai4SGRPA/3NcduCRz5JWyIPinl/ICWLUBYn37YUcqAZbKq6QCbBHDvEmEQLm5uumhSuDbgfbePqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757076884; c=relaxed/simple;
	bh=Ev/I6v5PMA3NHy83O6zsh2kbyy8+z4IGnWL1Yt+FYLs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DRQiEBlbVqUxA8m9KEiRo/c5fvGespVlZ7Y3XV5xyZwjP0plbiKwRAMR9mVwQdQFzhoKDDCTCGtkRjmr7j2gGkP61na+6f3RXTpjhDWGT1SL0pqaFwcPigia4g76HsIYqQhaoSUqsFFe+szgbAAGndNrkd26TBMKO3uCZUKsEFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i2ajrAYq; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-329b760080fso2023241a91.1;
        Fri, 05 Sep 2025 05:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757076882; x=1757681682; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pzt7qrENbx/8j/QYtoZElmLzncNQBAh6Evzi2YZaWyc=;
        b=i2ajrAYqyYWTH63Gsz+9ZNko+/wGVwujxHuRtk+bvRXc/RC1Xr2gca30xF7K1Syvls
         PB+hPE5KfDuSEjvHDTa4UBipegLIb8l8l16+rvpKl3nlwisM7EkiP3bSTwiWvshy7z1z
         kXXn2LTU3cxBhJeQCz0R0yXuWGqGxpazB4XlDub0JHuacMsmhPCMWDJLX7/oytbYv765
         r18B6OcGErenrgzBKMLNjEDlC8pv96sYUfS2O9N9gv0nHyf1rxOIere7kEVrP4VkFtxh
         9p8Rqlj5VI8Wy4IlzN0ptDg9hW7VOk9pPOcH5k26Piw3H3bcD5fP8LGTkv4Vl2pfBdZv
         Wwvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757076882; x=1757681682;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pzt7qrENbx/8j/QYtoZElmLzncNQBAh6Evzi2YZaWyc=;
        b=l9E69R6X/Et2LZgIz/uaifwpjxDuiu3jyozYmLkJOvAAlgpgROxa3Ky9DSPf0KPexT
         6qi0q4ASodjp1v5qenQmZb1sx+KgKmgj/xEtS9ZI+QfDsf4LXE/m6qGeZsojXfcegCkO
         qs1ScDeOY2hi87MGdEID+uI4JV5+gQcCdBx2eqMrAjlwp9cwS3Vdt4y597qp8Cuzop+S
         v4YA/yxcN16I7DS4iBmW54ILDmU52kyz3flURV+L3Z5Uk01wtw6Tp14E3R/+YxnjDDhw
         HgRrpknFIXDgdbqqCfvFyFfZYmWm6QYZ16o5764sPVV0KhSDWde6nRruHPeE82ezDzTa
         tpiQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQa6WUtRIAQgxghuK7r7EmMwmEJU9CPgDScjLBhGEGmk5YG8/nTl80RkSJoQDUm9mgkvr2pNYvezWY@vger.kernel.org, AJvYcCWOzizCdjsttz8QYgI3TSjZS0ed7GTaxzUmGxZaEmqiVR0hMg9Nd5H1I7wtxnP8OB1IQbGVM4qdr7jFUfjs@vger.kernel.org
X-Gm-Message-State: AOJu0YzNu3q1evRqrEqUJcLL2CdKC83Zx2V91RWghg6S/zl48lpJOFQz
	BNEnbu1uAyNazPRp2ZuYrXFb+/bFuP5otZd9ejrE01P2e+SAFEsn8fx5
X-Gm-Gg: ASbGncvd3QP9eUH3AsudTtUQ3ASFbsx1pdxgLR+ESheybfOLNVBSroJ0x9hEjiqamDi
	s5x1NcVI4M2oe1e1dNBZiWRW8eRUGUPNZ09/SaEAs4YUGHGsVfoWZuR2BuJNn8a86KY06PTsy8/
	HD/L2Z3RW6DNfYwBN9xS6bWzlM6OFztmoSoCqT6BDD7yRVDbrJbYUubdSUBeBV1RPpjuCyMzstg
	A6/MarqwiD1dNciNACwgg07o14bzwfjHh0W7PY9XsqC7y062ZeCOGLa3kg8CmgRNWqV7Tcin30q
	okt36t0vxwr24BV955B0zBiIO6d5B1wmEVHcTV00tPQYgdIvebKhNMfw5bXIru8RoNpWhg9xZUK
	M0KbsyeXWLL9+vpnFO6jD17Lm9sIHuSj1
X-Google-Smtp-Source: AGHT+IGwaXpMS2RTd/sFuAtY1Bq+6bu9GKob5Mqjz6hbplf9JNkChNQZjJMmG8KUui+rta/1CzzCVA==
X-Received: by 2002:a17:90b:5865:b0:313:1c7b:fc62 with SMTP id 98e67ed59e1d1-328156c62c2mr25634481a91.22.1757076881888;
        Fri, 05 Sep 2025 05:54:41 -0700 (PDT)
Received: from localhost.localdomain ([2401:ce20:10::d4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4fb98f9f6asm4992305a12.8.2025.09.05.05.54.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 05:54:41 -0700 (PDT)
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
Subject: [PATCH v1 2/4] arm64: dts: rockchip: Add USB2.0 PHY for RK3368
Date: Fri,  5 Sep 2025 20:53:15 +0800
Message-ID: <20250905125318.7956-3-cn.liweihao@gmail.com>
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

RK3368 has one USB2.0 PHY with two ports, This adds device tree node for
it.

Signed-off-by: WeiHao Li <cn.liweihao@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3368.dtsi | 29 ++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3368.dtsi b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
index 1b21787269..b09e431a64 100644
--- a/arch/arm64/boot/dts/rockchip/rk3368.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
@@ -766,11 +766,40 @@ cru: clock-controller@ff760000 {
 	grf: syscon@ff770000 {
 		compatible = "rockchip,rk3368-grf", "syscon", "simple-mfd";
 		reg = <0x0 0xff770000 0x0 0x1000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
 
 		io_domains: io-domains {
 			compatible = "rockchip,rk3368-io-voltage-domain";
 			status = "disabled";
 		};
+
+		u2phy: usb2-phy@700 {
+			compatible = "rockchip,rk3368-usb2phy";
+			reg = <0x700 0x2c>;
+			clocks = <&cru SCLK_OTGPHY0>;
+			clock-names = "phyclk";
+			clock-output-names = "usb480m_phy";
+			#clock-cells = <0>;
+			status = "disabled";
+
+			u2phy_otg: otg-port {
+				interrupts = <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 93 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-names = "otg-bvalid", "otg-id",
+						  "linestate";
+				#phy-cells = <0>;
+				status = "disabled";
+			};
+
+			u2phy_host: host-port {
+				interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-names = "linestate";
+				#phy-cells = <0>;
+				status = "disabled";
+			};
+		};
 	};
 
 	wdt: watchdog@ff800000 {
-- 
2.39.5


