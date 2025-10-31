Return-Path: <linux-kernel+bounces-879900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E63CC245AB
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 11:07:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44A523A4E18
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 10:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE990334371;
	Fri, 31 Oct 2025 10:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="oiA28OQJ"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4814D333738
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 10:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761905102; cv=none; b=fKvL5tbbz/1dIGrVCVLE10Q6qQgjKWSQZBY0zfzvJBdyWxxXI3eShYMSLORZgaxPnTeijN7sNxjyySAEvj7YiRyGsTze9kXSlKt7G3DjoKjKMDUKTmJLRTFJWT6SQrcIsFO1Rrxy9utsNQY86esN9L5XXj7n+5m8vt4SjidJfWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761905102; c=relaxed/simple;
	bh=cOGZkbrRMxKu50HDv+kW0yjsry3zgsYnkitHwHRZ+CM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k0su4t1ObitU4OMzRci6iLRnzJpFJndq8RhOVRTN465+pQTaTrqzsW3XBkeR/fL7+T2Jp8ks0CJm5JwYPgSlzb2L/KNRQ9oqGsMdjhT0bpiHPzJdIl70bXidIbAatGBoyN5KSlG1B63sU0VzPKA9sToGoBnuyzr1Xrn5trHGwUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=oiA28OQJ; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-781010ff051so1635709b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 03:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1761905099; x=1762509899; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GEMeTinKcUP58E4lvnW9PGrRCCfS2qn6jCMWx5eJs2c=;
        b=oiA28OQJcSEhU1vZzGGGmONeLv1wMy/tdHIoijnHNXC7noQxQGe7+0ci5fBWiOq+Ch
         BZiX2jkgtd7erw4CC2m9Dr/Y0UHr+0J/NP/Q3Ngze+KimvNyzERDxKmLuRkF1Idtsfaw
         tMoQEQalw+45U71zeiYxm4OT73+TTeDiEL4+AbRXNRYRXDW5I2g16pMdgmyhMjszsY65
         VMerd+4yISmKyAtbXj6tq6rxOtTKHnVRcSbl6Q7kpmtLHUlb27nX0m9QzRlulBMRFxNH
         lJXETDJZf1UfsHJPQljSSromU131TB5Sq/NBf/1k93UhfJpi7vpYLXfT2WbPHcYImTcr
         CNhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761905099; x=1762509899;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GEMeTinKcUP58E4lvnW9PGrRCCfS2qn6jCMWx5eJs2c=;
        b=MiIjAzZNxIHlZmv3JV6SqbiASCM52AwsiLsU6irbTlrGvbeTypFfeJPcOy51gyxHN6
         lGmW4ElSaaPTch5t8uyk4E0Y55vtwT82/biLRHJMRy9jDh0rJ/0uM8fU3jDE/E7qeEVU
         ChxbKQqdkfR0AkxzJyaZgPp0lbAiV7g+KBP1STSzXj5K1xcxm5xzNvKvFnA38+V80osb
         4TshtAlA0XFDZH5YZcakqOwl/u+jAjZgTuLyF4dxynjYrNEw+aBwnXzdLZyLWKp2Rfbm
         JJ9DfX8OWaTa3lRumqana7LA/p8EYduKCiPs3bDuSn9c+4eTiCSHwv/UxTYt3dxCTMOR
         ZiUA==
X-Forwarded-Encrypted: i=1; AJvYcCUeHJf0URYg3oQu6vv37Um/JEanYVTNk+Vcz1nY/cVDEm6gD2FX7o3+PBzsJATthcfii5PP0osITbapE2g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSULii112/S4vaRdy8sCCkl5HXRLbcm+wJSN6bycHd9TUCN7pj
	TgPRvdN54DlGcWscMm+nFOaVk7WhxwpJHrYI/NJXPjMf9cujz2FEH1pPM8cacgxY1Lc=
X-Gm-Gg: ASbGnctZ40FZQ6dBI06U30UccshCg/kXd7HtrR+eNR5rK/aQ5IfUhT3iacQVQKt8smO
	G07cX8sNzlrl34IJAYZM6MYEBkboNKMLiEl6Z28mAQW19adKAmzo33udBG5xIsYUz7KeZF+Lv1f
	zdo3fRZYy2dr1b51J8UKwDm6P0nqFJhtrMFEwqkzV0fogs53xmhGZuQzg8YkMCu7xpx4NxBH1Hq
	WlGzdcnAZ+/GKz6XCfFDiNPhz5ni+RU51ssDTERYSx49kcitNgceO3EIwfTBxfGwo2ClsXb42Aj
	cxRJpp2p0pRVzkGupg0lcT3gvL6GQ/bx1HheRBhaP8F4hF0JvvvhUbv8mWRLFTitEuBXX9zcw4/
	yb4aYA2krQxXE/IxnSHv3hHAMzDTT84NofiHTpav9RwvWWEmK88NDCS62ulofTOj3EcFbYlm2An
	by6dgfN1WdGxwXdj9abzu90zJ/M3cni+ypmuEU80s7knB9Y1AfZnkwVIxz2w==
X-Google-Smtp-Source: AGHT+IG6rUfkolNN1CRK86/13whfqnSQY7wkh3zlIQBrSCO05TTNTykamCuKrPtjYsc8MEhWLvUtqA==
X-Received: by 2002:a05:6a00:1886:b0:781:1b5a:959b with SMTP id d2e1a72fcca58-7a779eeccadmr3551694b3a.30.1761905099181;
        Fri, 31 Oct 2025 03:04:59 -0700 (PDT)
Received: from dgp100339560-01.huaqin.com ([103.117.77.121])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a7d8982117sm1644352b3a.15.2025.10.31.03.04.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 03:04:58 -0700 (PDT)
From: Langyan Ye <yelangyan@huaqin.corp-partner.google.com>
To: neil.armstrong@linaro.org,
	airlied@gmail.com,
	simona@ffwll.ch,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	dianders@chromium.org
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Langyan Ye <yelangyan@huaqin.corp-partner.google.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v5 1/2] dt-bindings: display: panel: Add Tianma TL121BVMS07-00 panel
Date: Fri, 31 Oct 2025 18:04:46 +0800
Message-Id: <20251031100447.253164-2-yelangyan@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251031100447.253164-1-yelangyan@huaqin.corp-partner.google.com>
References: <20251031100447.253164-1-yelangyan@huaqin.corp-partner.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add device tree bindings for the Tianma TL121BVMS07-00 12.1-inch
MIPI-DSI TFT LCD panel. The panel is based on the Ilitek IL79900A
controller.

Signed-off-by: Langyan Ye <yelangyan@huaqin.corp-partner.google.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../display/panel/ilitek,il79900a.yaml        | 68 +++++++++++++++++++
 1 file changed, 68 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/ilitek,il79900a.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/ilitek,il79900a.yaml b/Documentation/devicetree/bindings/display/panel/ilitek,il79900a.yaml
new file mode 100644
index 000000000000..02f7fb1f16dc
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/ilitek,il79900a.yaml
@@ -0,0 +1,68 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/ilitek,il79900a.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Ilitek IL79900a based MIPI-DSI panels
+
+maintainers:
+  - Langyan Ye <yelangyan@huaqin.corp-partner.google.com>
+
+allOf:
+  - $ref: panel-common.yaml#
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - tianma,tl121bvms07-00
+      - const: ilitek,il79900a
+
+  reg:
+    maxItems: 1
+    description: DSI virtual channel used by the panel
+
+  enable-gpios:
+    maxItems: 1
+    description: GPIO specifier for the enable pin
+
+  avdd-supply:
+    description: Positive analog voltage supply (AVDD)
+
+  avee-supply:
+    description: Negative analog voltage supply (AVEE)
+
+  pp1800-supply:
+    description: 1.8V logic voltage supply
+
+  backlight: true
+
+required:
+  - compatible
+  - reg
+  - enable-gpios
+  - avdd-supply
+  - avee-supply
+  - pp1800-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    dsi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        panel@0 {
+            compatible = "tianma,tl121bvms07-00", "ilitek,il79900a";
+            reg = <0>;
+            enable-gpios = <&pio 25 0>;
+            avdd-supply = <&reg_avdd>;
+            avee-supply = <&reg_avee>;
+            pp1800-supply = <&reg_pp1800>;
+            backlight = <&backlight>;
+        };
+    };
+
+...
-- 
2.34.1


