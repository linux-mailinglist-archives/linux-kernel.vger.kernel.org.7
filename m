Return-Path: <linux-kernel+bounces-775811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6917FB2C54C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 15:22:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B76FC196406E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 13:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7F1A33CE8A;
	Tue, 19 Aug 2025 13:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rESsUOet"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F01279DC0
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 13:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755609423; cv=none; b=fCxjNQaOC6lHoXurx9w2jhY1JTmtR4lv0/1okz1P6yZZkoiQzBR3N8xNeCcAVAGlbzO5gjubjgpgOtiK42qJ4RGZQtwTHVPnYjS+gEMnSnK2sMfQ7AMaUmPPvedo+KBXnVxolqJaWg51uYDFEmoGzB/yzZN8RhvQEAHZLbok2Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755609423; c=relaxed/simple;
	bh=+VLxqH0ESqnHDuk3E8kCPOtSdGHTD/8yFJeuZ9BiCYs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WVCshDGkAVmwexb5rcBixAvK/DkMLuXeeQ8hNXSjaeP/8He9PrGi2Tatdwy5qjPJfyOPmcnxHF8rVBjqpNPNaYL7md2mbieCjfpq5MTM25S/RmKETBameG2PfAAJeiYbjmnCcsnW6DAFkTsO0HI5tkzxR3FqvzITgBMU8bGCfhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rESsUOet; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-afcb74bef86so95618566b.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 06:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755609420; x=1756214220; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qESptQ/dmYUlk6re8+r+sev9Qhuuz0N3hfWZa+wWogk=;
        b=rESsUOetlTKYUMTap3LQaHi0BeKDzt6tMbLeLwxG91MOgdZA0DOhNof/J/LCMQ42KS
         9tcqmwp5L3Tx7y/oO5+kJQZwAqzHX4kwGDHhjKEWzJk8r6tABn5e2TH7oTJLd2v7zqLi
         GEYL9LCAhWxJu3k+ocT4UmiXSv6l0wq+8GDoksXvXtzp4DJlgRXfmeczzJQY0ZVyBSr5
         wK0806TMywOFQH6OhLe8xywHA9fLhp5ODSxxJa51GxITKpSoirv2D6Q/XfSZmO3BAM7y
         06r0muJB9z6L5EJ3TBUSoCob9OfXQhXe9jlp6fJsF9HXUYo6UctDW+rqQ3zeQmJ6K3eI
         1zxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755609420; x=1756214220;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qESptQ/dmYUlk6re8+r+sev9Qhuuz0N3hfWZa+wWogk=;
        b=OAxfZraKLW52g7v5eEyCdoknkG8NTDEW+hO9uTLY+n24c//rBAZScp+V/irPhOnPn5
         9Kl5wbcBTdK70SLXr20/zzoSC2joq5kB95aRD1mbeNOD99kfappYhx3vLGh+mD6z8frR
         n0gGbtRHpwefuoTI9Hdo11FAdaqt9rxw+yembtps5cCz80YVPOz4kuvHeHnD8M769kTn
         wbozm/q/juV13pYXZB+InZ2fQxsCjRiYQ73eoa4c2Y2VpvZYbN016cllu97zGgaV4H7P
         8yq86V0tUB/HxAJ5t5pPJrk5P8f4IIwvIQ8JXaHl5wZU2ZWjj0CtjE5DYUrKNh+EC+TH
         Cesw==
X-Forwarded-Encrypted: i=1; AJvYcCUeQx9GIH1qyqmWjIWXumutxQNE3gDww/g2dFVq5by/cm0c/D2JVSGL8lbEhPslcQ5J80v8zsRObHM6Fp4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXovqxeWYDMxsPYZCIpAR+TYzaydcMuP7q+wwPibT/S6AmrNgG
	ZwekZQAMCuFbrk9jbN3Ec4Ecp3SW3CS6HTAviLcXvOa3iQ2JPSo42rLRQWZ7sRcLwss=
X-Gm-Gg: ASbGncvoyHWdkdMs508el7Y2SwW/GPczkCxoofMXEQCt/9w8fUAGsE/G98Ikhy64Oee
	Fn86tG0M8TQBklsjKdf+WhMMjYo0sX1CpX3nksOzzVREqPPOOEkg3kSBBcUe6qAZ9A1hbjFXPmA
	rs0u4GUk+PXUOFH2qzbp1EPLegwjgmpTdIDO6jMY4an1O5ugc4bcdG58zNPc15ZmYDVGWvHqp7R
	kAvmNM45RLTZ4INI17/508rpIrkyUZojlWyw7hsEY8mj1WEU2V9n7+iVkZDVXXTM2sE2N9btOSg
	tE55G0sdMyujBebW7jao1UJCVrr3hufxH8Er4+1wacxCXObh+TtbFjMtEQDz01rGPpetG7WMbJu
	MD7CBctQCCfDwRF36EfNPBPqeEjdy0RMkxA==
X-Google-Smtp-Source: AGHT+IEg8a2b47NedlvviLuwG8st+X2x0l+Y/YjWI2l2AzTIN3x0F4/UgFHHn1iSDfVurcfwrHIMew==
X-Received: by 2002:a17:907:2dac:b0:ad8:8e05:e5e9 with SMTP id a640c23a62f3a-afddcb7f48fmr110735966b.2.1755609419572;
        Tue, 19 Aug 2025 06:16:59 -0700 (PDT)
Received: from kuoka.. ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afcdcfccea7sm1005948066b.67.2025.08.19.06.16.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 06:16:58 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Tony Lindgren <tony@atomide.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	linux-omap@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/4] ARM: dts: omap: dm814x: Split 'reg' per entry
Date: Tue, 19 Aug 2025 15:16:52 +0200
Message-ID: <20250819131651.86569-5-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=980; i=krzysztof.kozlowski@linaro.org;
 h=from:subject; bh=+VLxqH0ESqnHDuk3E8kCPOtSdGHTD/8yFJeuZ9BiCYs=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBopHlDEWYdXbyxtFtlpDztgTjcbe3aHp61Er42M
 sDr4UPxApaJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaKR5QwAKCRDBN2bmhouD
 11jVD/9UYLfz5ELR6Fcra1tWfRFifgZ5ZybkjRh8OL+71XNyumO9EegMvfET0kkKjxUkuY4uT+U
 fCZsJMPevZYPepjPp+yuaWGL0EI8o+jxrOBKshhFfvl+Y6DTQ/FaNgMkrNWztTV6olKaZOVWTXw
 f+r2lj2mfZFsIP5LgfVsOdhuJAkYGZptmHb2hOTHbW3VPWjD6hHxbHBSOV/ENzWEl0T8/Gb++Uu
 IdbbFyDNR81ouf4Ff23mvNjZc73zVt54vwUgZKZWPCtEVWjCbBWe2S1FxgpSqZaW4gpbtXNgg68
 soBWg43YrHaT1TLCzjdpnlht5Mih0Y3EnHaLZTtWAvX4n+JW8gs6s7KuHzflipQqRqycNryh2Ua
 4BijL9irYBIvIIOqEj0NKdRxciMJOEhbebiv9GLfqH4+UiBdUmYNBgZzg3rberIORc9lPQ3iHRr
 s0EadnuYQ7iIID1oIUD1ZElMN4iPJbctQl4rJmfRR09P83zOMcQp2spkwU/qqoEVx2uowOowHs/
 cJMDIRB37EnSpL+rHdyb8F1tFa1X945OECQupe3I3WRH6MLo34pDpN//wE1C8n7+0ZF2BB+zeTd
 FMUOWWgwBQ0CB6caKMfL7BJ69MiQiB3hA33MreO26vremnzLj5X0QQfwcf5UURmNT2b8E/rzieq wuCoQDSCL4jLtkA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit

Multiple entries in 'reg' should be encoded in separate <>.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/ti/omap/dm814x.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/ti/omap/dm814x.dtsi b/arch/arm/boot/dts/ti/omap/dm814x.dtsi
index a8cd724ce4bc..27d1f35a31fd 100644
--- a/arch/arm/boot/dts/ti/omap/dm814x.dtsi
+++ b/arch/arm/boot/dts/ti/omap/dm814x.dtsi
@@ -155,10 +155,10 @@ &cppi41dma 26 1 &cppi41dma 27 1
 
 			cppi41dma: dma-controller@47402000 {
 				compatible = "ti,am3359-cppi41";
-				reg =  <0x47400000 0x1000
-					0x47402000 0x1000
-					0x47403000 0x1000
-					0x47404000 0x4000>;
+				reg = <0x47400000 0x1000>,
+				      <0x47402000 0x1000>,
+				      <0x47403000 0x1000>,
+				      <0x47404000 0x4000>;
 				reg-names = "glue", "controller", "scheduler", "queuemgr";
 				interrupts = <17>;
 				interrupt-names = "glue";
-- 
2.48.1


