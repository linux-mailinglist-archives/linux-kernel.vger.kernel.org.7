Return-Path: <linux-kernel+bounces-833105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A57A2BA13B5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 21:39:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6232A7B2CE4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 19:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFF0231E8B9;
	Thu, 25 Sep 2025 19:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KxJUjo5Y"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E4331DD90
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 19:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758829130; cv=none; b=S4Ee2JRdy/xuY2cClJNQsItJzKsOzgFm5z4wENpmLV+b1LXp85YuTBbXiyIpS752iIArlicFHeYhwQK3te5WhdMOXGVWXKEL63A9Vq/u39AVzIDWhYPmuKi48b3G40MFZgb+4xuJBAAbFJPXfPixcTzmAhF7jaaQMf7prUJNDbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758829130; c=relaxed/simple;
	bh=MKlBR2dClXHDuRj+BGr45XY8mOHthTppSW/DIxzl1Xc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HV6hwxUis9ya/FTK2Wbv6/3QCo1PX4WGPxpOjA4E8h+hjG5E4roGnpFe19odwh+0bNt13pdgAE6yRa7Ca9tMikQbzfMW+u9+/aiWeKxYNqVM5D2QwMOCPd8dXLZIoifJGKLttyfGn1NO+q46hf3Tqta7hGlP7p5+G6b+QlSnYGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KxJUjo5Y; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b2ac72dbf48so253326366b.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 12:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758829127; x=1759433927; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vlX+6+mh/UPamy3i37VKA4DH1qcwrv7NT10uSfZTwWo=;
        b=KxJUjo5YOaFaclz4QximcdTMbD75WmId1k6t7ku7lnaK9njVA50sEusISUPnZ/mmRL
         N2UXBI86LUKpbFckV5gu73BQVIZAhJyk7PS5xFsmIZZBUxgeP6FS/K8uzbgDFE5CNy0+
         nXjNn7k5OSAvGnnJ45gjWbe4YrRT/YRPKbuHKbtZxK6lYJC5goQpRQDdCh/UXNEOj54L
         W+5uRrr8CTlM40/MYXbgG3aTx2IXEXtN/zx0TS9Ci5XSB87jhCz66SesxQtdlghPSbPU
         1UvONWyuyUItWhMbnH+1yZx9QTmPwh993U3AfLcPNjQr2Bb93KOQwRF40+/pdKlPWgfs
         Qn6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758829127; x=1759433927;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vlX+6+mh/UPamy3i37VKA4DH1qcwrv7NT10uSfZTwWo=;
        b=nkLo5LkhAwRB8uwgi47XJ/tdHTqt2R1TPNNrTCWSME79LlfxnaoUzU4LbwAaFFDF79
         bnr000Um8JaMqPnXMAyyvEHDJdaWKhzgeDn4076L04SKM6fW3S9f/n8b/B54N8o71MkO
         OxwJRAY/BsFiZFnkBSvKpB+DaRxWl0o/snq85TP7j7E5u1gNyaMuM7Mx1HEbu6M7n+Dj
         nF60B0KH/PTm/Maw0y3ca43wXqAvzpjMBn5hiuwS0q+/vBUD7gnHHRvNBjdjHNw/xeJb
         G/66l/4sapl09FwvROt34mx5svGvLKSGTgw7Hd06WoJ5hmdNIiIbE6O+OwVUOzez+BDl
         timA==
X-Gm-Message-State: AOJu0YwxbdabYN4qG75CPrsQRpt7EyeXIa7v+iJiUOe1+cuI4x//Khyr
	8+GD91dYFA9rq0te4A07/XHs15gExdcvqO9zCdaYXdxuYwbpSM0N+ZLC
X-Gm-Gg: ASbGncsgUG5yk1vqdbmBF5p9iA3Hkgrive+YFCiOpNSkNarpeYjrq1UPmdh/vU634tn
	svzKiqPa2fyNf2tvODmAe1yqg3H3EV7E2X9kyabuOGayhwN072RON0B8l/FmOqt8Jr8laiTRwla
	0+f4g7mtRyHmoWXnS5sZNkhtWiW+SaTowVLMnL5WYMr06JKRk1S4KtwFPHiCUi/6oD2UnYKn9HU
	A72I6aPbceey9kbL9mfeR47A91av0IWlezvFcHt3t6hA5RFdSIUiYvs9vr0hbqFbRQ3acQxyYIs
	ObO6PAWsmKrYmqM41sbrBIrKQRuQwEDgw7HBd1jW3mroP7kzH/efLV6rz+YB6E1/q9SsLGLkKZy
	Xf2bhloUG46gR7PGWCibQ99JbzOfbTMs=
X-Google-Smtp-Source: AGHT+IFfFBd/tgTpAyrafNZKQ1/PjUXY5Ha4wrVJC6PKi/5tOGX0Ed7VXD5cf/oZh2r/aUhJ8/tUHA==
X-Received: by 2002:a17:907:7f2a:b0:b30:ea06:af06 with SMTP id a640c23a62f3a-b34b80b30bcmr427286666b.24.1758829126244;
        Thu, 25 Sep 2025 12:38:46 -0700 (PDT)
Received: from [127.0.1.1] ([46.53.240.27])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-b353efa4c35sm222820766b.26.2025.09.25.12.38.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 12:38:45 -0700 (PDT)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Thu, 25 Sep 2025 22:38:39 +0300
Subject: [PATCH v4 3/3] dt-bindings: max77705: add interrupt-controller
 property
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250925-starqltechn-correct_max77705_nodes-v4-3-93b706bdda58@gmail.com>
References: <20250925-starqltechn-correct_max77705_nodes-v4-0-93b706bdda58@gmail.com>
In-Reply-To: <20250925-starqltechn-correct_max77705_nodes-v4-0-93b706bdda58@gmail.com>
To: Chanwoo Choi <cw00.choi@samsung.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, Lee Jones <lee@kernel.org>, 
 Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
 Dzmitry Sankouski <dsankouski@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758829121; l=1612;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=MKlBR2dClXHDuRj+BGr45XY8mOHthTppSW/DIxzl1Xc=;
 b=1UvcAjZOjFkI/v8zaSdhZgUc6plJ2IZ4WtEQH+Ev863H0hBbVjpgk3EsX9gXUnqJ9hr3iZlCf
 U1A/RRyyKwTDSjAJIBoQYbrFrmhymT5/urFOAu6IbjQLYHeGNp/+2mi
X-Developer-Key: i=dsankouski@gmail.com; a=ed25519;
 pk=YJcXFcN1EWrzBYuiE2yi5Mn6WLn6L1H71J+f7X8fMag=

Add interrupt-controller property, because max77705 has dedicated interrupt
source register to determine which sub device triggered an interrupt.

Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
---
Changes in v4:
- fix commit message: node -> property
- fix commit message: minor reword and punctuation
---
 Documentation/devicetree/bindings/mfd/maxim,max77705.yaml | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/maxim,max77705.yaml b/Documentation/devicetree/bindings/mfd/maxim,max77705.yaml
index 0ec89f0adc64..d265c8213a08 100644
--- a/Documentation/devicetree/bindings/mfd/maxim,max77705.yaml
+++ b/Documentation/devicetree/bindings/mfd/maxim,max77705.yaml
@@ -26,6 +26,18 @@ properties:
   interrupts:
     maxItems: 1
 
+  interrupt-controller:
+    description:
+      The driver implements an interrupt controller for the sub devices.
+      The interrupt number mapping is as follows
+      0 - charger
+      1 - topsys
+      2 - fuelgauge
+      3 - usb type-c management block.
+
+  '#interrupt-cells':
+    const: 1
+
   haptic:
     type: object
     additionalProperties: false
@@ -120,8 +132,10 @@ examples:
             reg = <0x66>;
             interrupt-parent = <&pm8998_gpios>;
             interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
+            interrupt-controller;
             pinctrl-0 = <&chg_int_default>;
             pinctrl-names = "default";
+            #interrupt-cells = <1>;
 
             leds {
                 compatible = "maxim,max77705-rgb";

-- 
2.39.5


