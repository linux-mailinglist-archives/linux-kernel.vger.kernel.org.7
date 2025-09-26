Return-Path: <linux-kernel+bounces-833542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1E1BBA2461
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 05:02:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D3E4561BB5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 03:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E663D1E98F3;
	Fri, 26 Sep 2025 03:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZoPJTP0w"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E222125B2
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 03:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758855752; cv=none; b=DgU2b91LbFsA/xyRQC5CHERTl45uvHru7ZnCJuNsxN4NoEs68171coK7dAjbGcI2ynQwjqGfgo15tg2G0ubioBkKdNCbZZRHuys7Rul/7pX4q5tLK+UXohq2VgpsslQaJAYSblOl9aaFgZiOK95tsaoL8adaxHz4+tD6c3KfTOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758855752; c=relaxed/simple;
	bh=/i1PUEL7a+XYHJACeYGuykMAQoVl91tAtO2Y8t/8+ak=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CmJoGiPRbvSdZXRkN1T9yJEa/mPKxd8iLPXDdSWJD0E+as1dEuULMXiNkM2nHeR926mw8Vd3vRS1O3XpodrtKL8yxQnZACujxQaqTHwJaYd9BQRErFhMxGyKIW5X8nAHOD/aKOBfHbZXr/wfanLeuZB+KSELX5sW2O87/O5HewU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZoPJTP0w; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7811a02316bso24243b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 20:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758855749; x=1759460549; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oAJYYsubH767ZAAG6Ssy/u0Z9S4icmj/JgueQ+Oc+lI=;
        b=ZoPJTP0wEwBCWqid0UFVgybhaGcOYCP6OEsKhXE6gknyUR0q4WjkD98jg0YN5jrPvs
         XuzzJdYJ8CIvN0/nRJe1cG1bqtREjaT3nMgrS858tFpph3xrlocb8BcwVZY8o8PlaQ6D
         jvAUzJS4XQxxJCuRI/IVVj0d1R0rQqkP0h/7x4860RSDalZyFlRIoLbseEiaSEaZ2IzB
         +Gb4dd9HtEo24TzwSYRjg1nqcLvPkEkIZzDLYqCoUsSxEvSdLgZQhDX76bARCBt4pr99
         b0edDC2fFjuCO/Q6K+589bkC6Vrf8Ef7XXyRJof3L4fZAAFPaL1f3lbhPqBHeaRBDOIp
         mwXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758855749; x=1759460549;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oAJYYsubH767ZAAG6Ssy/u0Z9S4icmj/JgueQ+Oc+lI=;
        b=Y5loXXMTQiTlVxDLSWfrKLxGjBIyzyndE509fTqaN3nZklsk9u5o7goiqcexhq3kJn
         fM37yTrUIaeDCil2mbVszVx5vsMGzC2NFiKjKdQH4U825LoxhrpMWGhREWu8mqq7DZh+
         Cphc4oFzpjmBwIMPGTwznWI53CI7tuzxPdQE35UgAet1Yfj8ovDdoTTT2i6iX0jGEAnt
         uCVc5v+V+NsORYqmPIWS5RyBP61n4gzOmRWmPmokWvexXK/AvCEjwQoIEy9xq6ysIX8E
         wiDDQD/+rZ52OSlm2ytoJhwc288Jzh6P6nzK2rhAbGeTf6LUDNmOZoiW2x0eSXur9rke
         HOPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUcepDHgI1ocPjjK1zY1zmlzDXcHMSij9iH/p8zOjznQkV53LMHsRIgNP3uSOIQ4vehAWmYVqYwWi5Lv9E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo0TBmbylTg8awCooyQJTes1lzus1RRZ442u2+km7x5qQzniAC
	2HrMTPPIT0xdTLGcjBYqqQorpnrtopShBRGkh7RFDvrVwL9psNZxXogj
X-Gm-Gg: ASbGnctqMaVakgI0WFCOLVHKoLwc8gDUB3G30lk2oqAzGgJQzQuqEa822wgmxBmfHl6
	JMam2I80vMrY3je7FsMf8pleFrzdT8L8mfwUuoQP9ofCErmntWBgs5plzZyJUFU20H6VJsF9lEW
	bimgsJGx0HjV8G2atIxzXrWwt/gj5bTQDLLzTKeEPVQABtzzRxT8wbSrid/+SLG2Jm7+/KSsA96
	fLs0PnGEPMDKVxLm+ZwIBUxXPAAeW54rZkZkR+fw6tIhR6yruZb+Un5BIiOtGr2Qgpd09mwn37i
	W4xAPXQu2WFa0eD5yXpquvIBpBuFDVu0IrFdl4y6V5ZD4hSJwb20ncmJ23hyiq7BQVRNdm4qp57
	1jl3WqieqL5cHV1yuX55u0uqUtb6AEg78W9DZ0niVAgn9/ACPMgWR1FHVFdtcWpiMaLkUpxFgY+
	GyxJFUhgmU8sBWIX42eA==
X-Google-Smtp-Source: AGHT+IGVVE0b3+ap6KgQf8MQgQkYuBpIvq9eSH0KSUWAfnMr6DmONE0rdbX167dWHQYcpP6jeWd61w==
X-Received: by 2002:a05:6a00:1ac6:b0:781:15d0:8848 with SMTP id d2e1a72fcca58-78115d09690mr1084933b3a.13.1758855749399;
        Thu, 25 Sep 2025 20:02:29 -0700 (PDT)
Received: from bu9-daniel.dhcpserver.bu9bmc.local (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7810238c1e8sm3225384b3a.12.2025.09.25.20.02.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 20:02:28 -0700 (PDT)
From: Daniel Hsu <d486250@gmail.com>
X-Google-Original-From: Daniel Hsu <Daniel-Hsu@quantatw.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	joel@jms.id.au,
	andrew@codeconstruct.com.au
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Daniel Hsu <Daniel-Hsu@quantatw.com>
Subject: [PATCH v1] ARM: dts: aspeed: harma: Add MCTP I2C controller node
Date: Fri, 26 Sep 2025 10:59:52 +0800
Message-ID: <20250926025952.3098933-1-Daniel-Hsu@quantatw.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Facebook Harma BMC uses I2C1 as an MCTP (Management Component
Transport Protocol) bus. This patch enables the controller by
adding the `mctp-i2c-controller` node under I2C1, with multi-master
support.

Signed-off-by: Daniel Hsu <Daniel-Hsu@quantatw.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
index b9a93f23bd0a..2b7019c55eb6 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
@@ -242,6 +242,14 @@ gpio@12 {
 &i2c1 {
 	status = "okay";
 
+	mctp-controller;
+	multi-master;
+
+	mctp@10 {
+		compatible = "mctp-i2c-controller";
+		reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
+	};
+
 	temperature-sensor@4b {
 		compatible = "ti,tmp75";
 		reg = <0x4b>;
-- 
2.43.0


