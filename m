Return-Path: <linux-kernel+bounces-808266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76337B4FD45
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 15:35:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E12231C627A4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 13:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5DCD34F465;
	Tue,  9 Sep 2025 13:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AJGECuCc"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E52342CA7;
	Tue,  9 Sep 2025 13:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757424678; cv=none; b=iBbZDDOEQiFtPKJQ2UjGl0V0JlO7Mz4va7lmzBWVzr8UKqluQNZHzAihXM+AvDnAqHG+nV5JXMZSjidJPG3+vwzQUZfvoxYx0yJkrctOcd+lwec3vaejattz3GIYqE8lx+qufNK+pzDyZCVabeQNdIDy1N/Bl+5KTmqWmrEJO4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757424678; c=relaxed/simple;
	bh=t+lEMLnAe4KaXBYKooSQaU25IKQdqorJ1Be3/gYEwu4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q8eZx9mylLz+R+5+qdzRXEjXktqJRydS1v5W56YbPUojomGVkRbgiUZK1ekrE4yapKljdOAjpGFJh0nPDmTXCfyvBAJYuVT+NRAdcw9cT6O8QD2vIZ4ynCTxB6RTMtIQcqq0JxDt9hGJ9/w5U9Q98KxvsBi3dT85mNMQs34xBKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AJGECuCc; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-77264a94031so3858691b3a.2;
        Tue, 09 Sep 2025 06:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757424676; x=1758029476; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KdyjQVerHnCtQC9pVNT1b72KD6sF3r9Hbrbb+1r/mbI=;
        b=AJGECuCc1f5iXatNKcM6htB+Qo+OIurzLruYA8jmQ/o184bVhQ4Tqptu1d8d8Ms5Ll
         255BwF1gVXSdeaqPO60UXpJ2zJl9y7VL4yH9wCzKnYYScj7MsVjn8iLK4Jc2OJsj9shr
         sAYpsexzRPn+sbap47VY+CevhUdYk5K03/ML3MpgJ5pFJEe0qw4NGYtjY5qSqhjRb3KJ
         iVmH/CFl85EdPr+KZK8KQOV6Uwsw/fNAttYPe6EJXisHRuvDsfF6Exki2v3+fFl4BguE
         kKxLRgTktbQEbEH01iZjuK6Rp7YqoFNoZbNbLJKDsca40CmVbqbRzuAHwVqE9QdVM/vY
         Lx8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757424676; x=1758029476;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KdyjQVerHnCtQC9pVNT1b72KD6sF3r9Hbrbb+1r/mbI=;
        b=mMJo8QJBVTTnIh4c47tOMyzZo8hGtRCjD+Aw6FGs12RiD8/+B3LwOYylmxqYJtFGq1
         tDG5qTcbOK6gIvjHbgBKaUy04u73UdjmVr1/aAw0AuhKIef1l22SMTfP5py7vD9mtblt
         kbD7oq65RYzw9rd/WLp/eEdbqNCvjq3W7KnzPahJdOZcvNlqRuzhdHzD/xRqDyPg1hlX
         aRatXGQBw3mxevqtiV1+GgcwclNAC+zTM+KYOJsdM4T8keWsqt0iDMc+GaxZoJoKV6X+
         Yzyfpi0Q5g3qjjiwTxF6m1cH5refadYjanoLNE22A0Jgtj+D+I/eMbry7AMwzzmMO+QS
         T3Dw==
X-Forwarded-Encrypted: i=1; AJvYcCUun4dyEyEvKXAKLu6gtIIjN1vi8JPim4yz4zuVr6E2qgwccwOIXsAe5nBt8UnDmwD9WXgyQ4WiAi/A2bE+@vger.kernel.org, AJvYcCXcakWl4gG+2RWvDHGsVkQ6xJY1Vn/DX0aLUSR127CIzEHvCZRB4bkH2Z+HFiOxzcA3/AGJdHgvtbj3@vger.kernel.org
X-Gm-Message-State: AOJu0YymZY2bjiDAQxMoVM9wYGbMfoYfU3Cv0kLJywLD/C85UxF0Uwu2
	EXzCCRrGyN5DROwhJdAcjJE39gh5M10S933od/f588kH6kVNCfLAuoUd
X-Gm-Gg: ASbGnctcuWsaVD+RSNCz0yFgwtcfRd1fshz0evq26/QnpZGCwA+/W6G3+h2PRZs6ILH
	UWLmHtxu8tkSjerPV/IsN8cS4BjbPC1vEAyv3QVOxxQb/ziGEmWVtexPyhXpP79eP+02uMsUuo7
	FSz1A80I9PGBSDGEZKVoBUTOZN5BHU27GfbkLy87NfNunbfOW8QIHr98sB1nhJNhvBLQYG7XsdP
	ko5E/8KR2IWOyT5da25sZBhb7+KA6pNbqqT8Ed9/jHmBX4omUB7TeCrodIj0uUqFcrJQDd5ozzZ
	n1BP02Jpva0LibJeMs6M8X+YAbX2Dz2Zs7DZbmadqO4PyyXKxXom5VJTVSc2MJoI8fAt7K6+8ah
	nWz4bgMFftrAzT1v2kNRrMs2KaYUEdrQZZ5c9OsKn
X-Google-Smtp-Source: AGHT+IHwBbZsks9DdQ6XHABej9H6sI60c64zySW2Wkkud1SiiDf3inSmEJ4jwNop9RIJz+LR1AwSRQ==
X-Received: by 2002:a05:6a20:734a:b0:24c:1f78:1811 with SMTP id adf61e73a8af0-25343c5f206mr15647342637.37.1757424675720;
        Tue, 09 Sep 2025 06:31:15 -0700 (PDT)
Received: from localhost.localdomain ([240e:3a6:1c4b:13c0:db95:4539:1490:64d2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32dab173060sm810778a91.5.2025.09.09.06.31.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 06:31:15 -0700 (PDT)
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
Subject: [PATCH v2 2/4] arm64: dts: rockchip: Add USB2.0 PHY for RK3368
Date: Tue,  9 Sep 2025 21:29:56 +0800
Message-ID: <20250909132958.26423-3-cn.liweihao@gmail.com>
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
2.47.2


