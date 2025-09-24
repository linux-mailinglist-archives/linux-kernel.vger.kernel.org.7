Return-Path: <linux-kernel+bounces-830257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B91B9937B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 11:45:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8D7718907AA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 09:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 339C62DA765;
	Wed, 24 Sep 2025 09:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UYvH2jul"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872892D8DC0
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 09:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758707096; cv=none; b=EmGcx0AsCRVJUe4a5e7BCiPdTwXvEx7zDFIvY0qxZtSO2rVQvq/JqsUrCOUPq+7oMIq+7rsNbT7BVfjeN8gtqUCsLe2K8d35mte+okFgEA0IoK+t/EIrNTvdB4Te8k8OzWuim1iV3Vnuv+HMVdit5CdRHjcP9tqxlN+I0qqFQEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758707096; c=relaxed/simple;
	bh=2cljBbctUpov7EPp9dHLO/NTrzVDPxTc08Ag9XJ0xdk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WCkBtGUu4//oCrg6o6WJWA3Tf0THFWkUvZa2p5DvcfJJ0vlQrxzYy+6TtgMvTFv9d7WkaWecxKWuLkP65wDueP01yds6BChhMXOixjtKyOuxfx6a58JVAdXG2mGDeNq0utqotiFg41XsXW+Fx+YXINimqNrBG/KQCnw0BWz//o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UYvH2jul; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3ee64bc6b85so4939776f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 02:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758707089; x=1759311889; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8htGACZZYE1dIEbtDAUA+3P97IrmED7ZD9WcIPqTfx4=;
        b=UYvH2julEtiVLHK5cq3xe1ZDrFicw+myAajPVWZSgqRPu7nbZcPbxrASYkrKMg/2ao
         +tyXlZcSqUCL0jeVk2+PzgmwVq7ty9JnLVqJGAsFGFpMmTPZ9kVsjaPCtF4W/6UseHI8
         lvnpXYibMv5KK0NYroHDZLnPE9FSu990CuLK0veA3huexyAGtkBW3M5SFuY9Y6c9KWwD
         pi6BXTEqUtCUSMQ8UhTtPQMMSmFWMyCdQEolTAvkzTsiqzsw8ztPj01qIzQtLJfq7wYe
         7zoM446lJV6Xmgyg3XqoOObCYvIebemVkfH2b8v0z29yEM7B5KKSBNEudP1l4p1YiCW6
         qqUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758707089; x=1759311889;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8htGACZZYE1dIEbtDAUA+3P97IrmED7ZD9WcIPqTfx4=;
        b=fX4CLn97PlFScnh2sllOGRKPB9s75q9KR+WwVAqlPy3h95E5ADzZeb+KauhdXv29vC
         3gmsmCQfl+CTGuYZfbpmxdTpTAIAl7/NaMJs3pCRvrKwst6ra56++1uWoN+kwnYE7w/w
         gwxLX/hcaKc0P2RJZ0KE6bu3AF55sTYDTlcDNxVSNV6Nrwu2X5MK06g0bzSkuAejmIMg
         DK6qq42g6aivNU+3hvdzC0isi5wLX630xxEvjT912eZCY3aED+Mf9itzxRSTrptWV6E0
         iZzWkPiMVcYevaaJD7fnpv1xNFnFkrbCImQwW+7Z0glzT7pKXahA1eVDRJvPFYIiZaoJ
         lj/w==
X-Forwarded-Encrypted: i=1; AJvYcCUd+j1vVyuiDmVOagAE0wVMlO68EyKfts9DAEPNK38Pl9Wgsh4/2ZWxaqoNDKqO7mVhWaUqBJUEhcPvoZ0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yywkp7GYBhbCEZ0mSO2lKC2G0hVCR32HcX2D5AltC7SPv/8ZuD8
	ddpOh2N1UtSeQ+aUs0om0TKSstJqwhGgUffUiWbqkYhrCIvSGhlI6v6h
X-Gm-Gg: ASbGncsr2eKHjvrRFIRHMAMEJVhNE1R03cBASvpoEHZ5ia20mje+0Z9jZFNzo2dxRwm
	kunjXat6U7BwloIfaAySuaVCjyOFFehAvXvTQzyb+esYNm6Csyg+AFhXeorg00PYvfPC+09wLJX
	3kTgwbuoidONMLLDDdZvd7CyrBouHCWuZsvXybvaBuxHkaZldZ88l4IBoE1PwsUp4fanpZO/oXA
	wJLIb5kdiAhiWxy3YiHCxe90b6ALaNs5BfP0soL6Yebs5xAPHaW4kTqVgh3zM2TqcomG8H9OAuk
	ELcCDkWWGtppzEAe2CspVq3PRGgmgf+mLT2Tyn/SRn+5TBlwhds4mel38j9hSu3UGbykiOp7nay
	/1gjNGgCvscehBxxiRNo7JsgHDrkB1NTyaKBoiSy9faG/YyveLctc58iw3rA2H1HT7FFPVsDAjf
	jjWMmwh8Yv/v1H0g==
X-Google-Smtp-Source: AGHT+IFDGC5gILr6xmz9HYWmbPGf7fv1JpRWluY5ULikXOKvBqLdmUKtTk3mYXekw57q/HwxxJNkVQ==
X-Received: by 2002:a05:6000:186c:b0:3f0:9bf0:a369 with SMTP id ffacd0b85a97d-405c6d1024dmr5131775f8f.14.1758707088783;
        Wed, 24 Sep 2025 02:44:48 -0700 (PDT)
Received: from localhost (2a02-8440-7503-805b-0076-f865-8f03-23d3.rev.sfr.net. [2a02:8440:7503:805b:76:f865:8f03:23d3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee141e9cf7sm27213765f8f.12.2025.09.24.02.44.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 02:44:48 -0700 (PDT)
From: =?utf-8?q?Cl=C3=A9ment_Le_Goffic?= <legoffic.clement@gmail.com>
Date: Wed, 24 Sep 2025 11:44:42 +0200
Subject: [PATCH v8 1/3] dt-bindings: stm32: stm32mp25: add
 `#access-controller-cells` property
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250924-b4-rcc-upstream-v8-1-b32d46f71a38@gmail.com>
References: <20250924-b4-rcc-upstream-v8-0-b32d46f71a38@gmail.com>
In-Reply-To: <20250924-b4-rcc-upstream-v8-0-b32d46f71a38@gmail.com>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Cl=C3=A9ment_Le_Goffic?= <legoffic.clement@gmail.com>, 
 =?utf-8?q?Cl=C3=A9ment_Le_Goffic?= <clement.legoffic@foss.st.com>
X-Mailer: b4 0.15-dev-0dae4

From: Clément Le Goffic <clement.legoffic@foss.st.com>

RCC is able to check the availability of a clock.
Allow to query the RCC with a firewall ID.

Signed-off-by: Clément Le Goffic <clement.legoffic@foss.st.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Clément Le Goffic <legoffic.clement@gmail.com>
---
 Documentation/devicetree/bindings/clock/st,stm32mp25-rcc.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/st,stm32mp25-rcc.yaml b/Documentation/devicetree/bindings/clock/st,stm32mp25-rcc.yaml
index 88e52f10d1ec..4d471e3d89bc 100644
--- a/Documentation/devicetree/bindings/clock/st,stm32mp25-rcc.yaml
+++ b/Documentation/devicetree/bindings/clock/st,stm32mp25-rcc.yaml
@@ -31,6 +31,11 @@ properties:
   '#reset-cells':
     const: 1
 
+  '#access-controller-cells':
+    const: 1
+    description:
+      Contains the firewall ID associated to the peripheral.
+
   clocks:
     items:
       - description: CK_SCMI_HSE High Speed External oscillator (8 to 48 MHz)
@@ -123,6 +128,7 @@ required:
   - reg
   - '#clock-cells'
   - '#reset-cells'
+  - '#access-controller-cells'
   - clocks
 
 additionalProperties: false
@@ -136,6 +142,7 @@ examples:
         reg = <0x44200000 0x10000>;
         #clock-cells = <1>;
         #reset-cells = <1>;
+        #access-controller-cells = <1>;
         clocks =  <&scmi_clk CK_SCMI_HSE>,
                   <&scmi_clk CK_SCMI_HSI>,
                   <&scmi_clk CK_SCMI_MSI>,

-- 
2.43.0


