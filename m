Return-Path: <linux-kernel+bounces-792896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE00B3CA1D
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 12:20:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD1D83A3B0D
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 10:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDC43274B39;
	Sat, 30 Aug 2025 10:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Vro7Wlxd"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45711277038
	for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 10:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756549156; cv=none; b=lVzwVocjl5AJXUQ3AXkzQifK9sQ5gEVujL9/5F4jPefXJXcXW63S5ulEwpJhbUhcDqNPy6SoHV7XELjhLMrD+qnMi97MW0BHC0Ml5WGaAiziRDN4Bs0E1c5V3A/wDRnABmsIAHE6F4m9FjreRcvdCKUZX0cYbq/RW590GjBh0Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756549156; c=relaxed/simple;
	bh=X4WEqjDsxEfbxQW5piC8N1hdhc/VRxO6TIqCp9uqtgU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Bsx4dCfLygOG5AAwgtvffOIJ+I4yEoLpBlYcZ7gUiWql5vO8keN5y1u9ElIWBXhQF7nmqMhJ/4+PgGRSu6Umc1UgRPvouN4a/QInJ4rW2oJN1fRTOcq0OM73Bc0XdNf4efYMvKpOIat/bTjQKQgY3MXpfHzhW+MG8hiTK6hOzkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Vro7Wlxd; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3cea1388486so140141f8f.1
        for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 03:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756549152; x=1757153952; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xXv42D6IasHB/AaS0CVhCn6HxB1qNyKePPGDfeN311k=;
        b=Vro7WlxdmfgHmRtEZMFT0Aq9xSCGQVJsdi+MOV03urHytjOgioR9nB9rvUb31lqv43
         e1ZdgmS61SSbdi8NJfb7BUkAxWBmTX4G7rHQAQgpQBt0uaAqxlj8v8cum50Q/4Lwo3yD
         m4Hyq8SgXuHS9jiEwJtcA1HkDZLxUJDXsXRGweStgnBXYxahd3M1DsvaQ4yIVT+9qRI3
         929rXs86HaUGToD8JzZeTotNsbRBgegXHTy2VZMh/5N7LCFx04SaoPs47KEpiEYZKs1D
         6QrH7XbebwEp54UwRUNtqNPU2Ms4LCSSAWhalwA69iU/uF7nuGYNrcmnn+OgJo3nk5Lv
         JhGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756549152; x=1757153952;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xXv42D6IasHB/AaS0CVhCn6HxB1qNyKePPGDfeN311k=;
        b=aZuR/6++D+U5NyrVXni4ueb5Qv0qWBkIHrkez0kZ238deC2zY95x4m650snFad+lkl
         fodVgplFv3dGSqnRzyMJ00Eni27IfUcE7W4xIO8Hu43QNqlKwx7csDhLN0myHdw5vhN+
         eWQzhWLfXcOOfBzrbEJlUZE4mpfltmgNjej9s8Kw4tJNWSDpR2p7olnO6+zV6rDceSOs
         YuGounG2vzN26ctBcSdnX5IuLaY0lgVQVEaHqNE4dlCuwkM9wPshQk4e4JzoYQvNHb04
         l0+tgri55dA3uYIfrFL/71YPCYzWZ2x0Qy15Nlqw4UPvcWz4BK0gCCA0Be/U4JKNeVOp
         Gv5A==
X-Forwarded-Encrypted: i=1; AJvYcCWLhYdtykNMuxQcpgwGOvbw5F/D68UbRFwG4NsB/kaQb4iT4+uOrn3FN46lH3fK5eRGZql6Vn/BgKVHe6A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3l+RW9BMVq+aaHO4rcjIX8v9bF+Xd/k0y0trPgiQFH9IMc9ot
	MHbNP5yYLXFY9fxKLzfZDdN0F+ahn4uZxZra1YLLL8UMf0bjKJ+IdGhQU3FzvRBXrMg=
X-Gm-Gg: ASbGncu8W49mRvtImU23tmAHGWPd4USwcxjWlH96SViA5Q3OsMc9xrZtepJoA1IzRRJ
	CkfiCWFs/IpcEof7/C6fFC9t2fhvO3Y4PuemNKfLjo5p47S9Xa2jmnY8K+YUjIURLOsZ12kBMzp
	cBUi79CDOapDwGnYQY6FPdKGFcs72PiIeWobVufLGpIY2mrP6KHMuKhh5/ab1nhgdscAena4toH
	Aydf6icBsVWboJauto88yHPacBiBYCrcoJtH3v1xuG0/hVgvINjebJohvXUNkcX8XTPB1GqA4aR
	+BCs4pXS26UtORN1ONqAhmoNw6dGy4VAid8XDYoXEpLM4J6rWt6yEpzVLiJcbEYJ8EN5a862FZB
	zbRG73kdh875NSkoEEaQGI7w4UvZkiB3biARkI0c0SF135ib2Ww==
X-Google-Smtp-Source: AGHT+IFLBqkvSILcmyvRV7c8Yxt6Oeamg/J6CxZ30pz6zRS3XCq3IAwZdXSdCt7ZFipQzams4ailVQ==
X-Received: by 2002:a05:600c:3ba6:b0:439:88bb:d00b with SMTP id 5b1f17b1804b1-45b81f23df6mr19954015e9.5.1756549151588;
        Sat, 30 Aug 2025 03:19:11 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf276c8eccsm6547492f8f.20.2025.08.30.03.19.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Aug 2025 03:19:11 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Sat, 30 Aug 2025 12:19:00 +0200
Subject: [PATCH 4/4] dt-bindings: watchdog: samsung-wdt: Split if:then: and
 constrain more
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250830-watchdog-s3c-cleanup-v1-4-837ae94a21b5@linaro.org>
References: <20250830-watchdog-s3c-cleanup-v1-0-837ae94a21b5@linaro.org>
In-Reply-To: <20250830-watchdog-s3c-cleanup-v1-0-837ae94a21b5@linaro.org>
To: Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, linux-watchdog@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3834;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=X4WEqjDsxEfbxQW5piC8N1hdhc/VRxO6TIqCp9uqtgU=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBostAW/yJv5XJd7fLze1+/dmluWrrNtXl9d1W6K
 Jo9u6soSDeJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaLLQFgAKCRDBN2bmhouD
 1/LxD/wLNsNpbl5CvNPmAKy0p6N2E3ZHvQjlbWti4Bu+yHut5d2rMIMj9iGBSrXxgY9UE1876Lr
 ci6HXpPWV6XIG+OJfat4fqZghFLEkxUFuI95WgCe3rUmYy33aSu8h4S8+qN83lfcJJXLMZHKbNI
 dUs2vV/UIMfVeRmtfkbWRK4SVazimfKQ++VXW8LYAGiE1/XY8fcSdmal0PJheh64hxZe4OLMJQ3
 TBTpTA65Dyx+/xbQ/Lyi855tgaRyyWOfsXCwavGOCqkKFJ7kXPEuY0/sI85Q19jclnaTlnig60v
 gz3CI0H0+BO5ErKSiGh3xBiY1BY0YLZ5laPwUZs3puPoDRP+ENANFa3DTMiaHnEN6P4uEIDsvDg
 o2+xStp/Nic+nSNM9fQ2Cpp4sJpxQbDL8iS9hSO4vmTRrO39xwNK9guyH1g0WfVducgPT1VhNad
 SiyGvEeUXA6/9X5PSxW0AFuMLPVNEYGsskrpeUZNELfQUokKtVQOmgg5EHDVUfp4OIxExrNcR2g
 5WQqTyPc3WFEQfYbkiOI7cGPW/yqdRXmp4CbsPGiqO16xhZtq64e1qBbQmTVY1MWfwZQoBc9WuV
 OSZmIVWjdTqRYROZxNKLxjeFVT7xT0e1s1dFzt5TeAQvbcqdQ70S/JDjL+K/GEqGrMsxReLOJSE
 noQXO3qWK6Re3jg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Binding defined two if:then: blocks covering different conditions but
not fully constraining the properties per each variant:
1. "if:" to require samsung,syscon-phandle,
2. "if:" with "else:" to narrow number of clocks and require or disallow
   samsung,cluster-index.

This still did not cover following cases:
1. Disallow samsung,syscon-phandle when not applicable,
2. Narrow samsung,cluster-index to [0, 1], for SoCs with only two
   clusters.

Solving this in current format would lead to spaghetti code, so re-write
entire "if:then:" approach into mutually exclusive cases so each SoC
appears only in one "if:" block.  This allows to forbid
samsung,syscon-phandle for S3C6410, and narrow samsung,cluster-index
to [0, 1].

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/watchdog/samsung-wdt.yaml  | 70 ++++++++++++++++------
 1 file changed, 52 insertions(+), 18 deletions(-)

diff --git a/Documentation/devicetree/bindings/watchdog/samsung-wdt.yaml b/Documentation/devicetree/bindings/watchdog/samsung-wdt.yaml
index 51e597ba7db2615da41f5d3b6dc4e70f6bb72bb6..41aee1655b0c22a6dce212a63fa4849089253f09 100644
--- a/Documentation/devicetree/bindings/watchdog/samsung-wdt.yaml
+++ b/Documentation/devicetree/bindings/watchdog/samsung-wdt.yaml
@@ -74,24 +74,7 @@ allOf:
           contains:
             enum:
               - google,gs101-wdt
-              - samsung,exynos5250-wdt
-              - samsung,exynos5420-wdt
-              - samsung,exynos7-wdt
               - samsung,exynos850-wdt
-              - samsung,exynos990-wdt
-              - samsung,exynosautov9-wdt
-              - samsung,exynosautov920-wdt
-    then:
-      required:
-        - samsung,syscon-phandle
-  - if:
-      properties:
-        compatible:
-          contains:
-            enum:
-              - google,gs101-wdt
-              - samsung,exynos850-wdt
-              - samsung,exynos990-wdt
               - samsung,exynosautov9-wdt
               - samsung,exynosautov920-wdt
     then:
@@ -104,9 +87,41 @@ allOf:
           items:
             - const: watchdog
             - const: watchdog_src
+        samsung,cluster-index:
+          enum: [0, 1]
       required:
         - samsung,cluster-index
-    else:
+        - samsung,syscon-phandle
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - samsung,exynos990-wdt
+    then:
+      properties:
+        clocks:
+          items:
+            - description: Bus clock, used for register interface
+            - description: Source clock (driving watchdog counter)
+        clock-names:
+          items:
+            - const: watchdog
+            - const: watchdog_src
+      required:
+        - samsung,cluster-index
+        - samsung,syscon-phandle
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - samsung,exynos5250-wdt
+              - samsung,exynos5420-wdt
+              - samsung,exynos7-wdt
+    then:
       properties:
         clocks:
           items:
@@ -115,6 +130,25 @@ allOf:
           items:
             - const: watchdog
         samsung,cluster-index: false
+      required:
+        - samsung,syscon-phandle
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - samsung,s3c6410-wdt
+    then:
+      properties:
+        clocks:
+          items:
+            - description: Bus clock, which is also a source clock
+        clock-names:
+          items:
+            - const: watchdog
+        samsung,cluster-index: false
+        samsung,syscon-phandle: false
 
 unevaluatedProperties: false
 

-- 
2.48.1


