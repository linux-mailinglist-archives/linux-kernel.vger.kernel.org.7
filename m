Return-Path: <linux-kernel+bounces-880214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4CB9C251E8
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 13:56:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5ECC3464D80
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 12:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDE7534B188;
	Fri, 31 Oct 2025 12:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g6qbk92i"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA29347BB1
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 12:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761915367; cv=none; b=fx7lnQixWaUn30ORCMvWQ35D+Poi66Ljt7MxwiAMbNgrlBjz7ob7Gr8ULZP7CMdIkwFwzMaNEn9+v1XbLXh/xN8TqBSLE5YtQauiRe0ul8Ay1hjU8edqIfbg2q5toSogb0WFc91lMnfSYVtyU5zMhRZeFOsACFSe4ygf7jyOlWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761915367; c=relaxed/simple;
	bh=52mHw6aKRd81AmHkFdwI5f2O5qzG7/nRl12+OyMNuEs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ks9VJbRhpUf6rOGkWJujYF91CCU4XvgIly01U2eg+C7ph0hmrfkW4NecFwjrUUSpziRaikN+6tDNXhHcM3OgOb9PE2TMZf79qO9hvlrvUaI8JLxQwmIbsYgWCIz3g0c6SFo2B3fMi2eIVma+7NqaYOBZIfo+wPuvM2tIPWVzWhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=g6qbk92i; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4710022571cso23678715e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 05:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761915364; x=1762520164; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w81C8PO6GyjajvSZnVcib72PAdJ1z5nHo14vlKsXejI=;
        b=g6qbk92iiErU3uxKfLfXvLrkzgZputVtL26LTsivzUDsADma4Ty9cDeW4tEzKEzVZq
         zLgVJAEi1zPzgMFvAsea3qw6eQb3tPSz/61rIVZt1/IYQZGwQMv1/IwHwFYiwZY9Pi3K
         HYaPuj7B2o0i8P9QNO0HabpHQmq6fRKH9KUCy3t4JmZLiC1VUFTtVRhLYQ3AlcCwyGGl
         0s5YHn24eUkYZz7OE+hxfHZ+yDPsP3i4Oxcel7vnEr/qzPoIvFOHjl8GIrQgF+WZz0bK
         czQ8DgMYXxNcu484EWrM+pNS7M42IVBhcpgMm61smy5nTuEm7ZYk2UUQzdzJZPwASakn
         R3iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761915364; x=1762520164;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w81C8PO6GyjajvSZnVcib72PAdJ1z5nHo14vlKsXejI=;
        b=dpvqATU5vqPLfU0a8xSh/O4YiQCGDoYqYlG9FwjwXlqYdusG6hZF+wgdgSTVaEEliD
         n8Fccq3MSuufjei2tjCBiGjOeI89/ktuza06YaJ5TJ31Pcs+zCYKTcj2FsNEQdop9c2x
         BvWBE7wpmLWxuRRBYbnVezXsZMEorkzHgKTFiRgnv3SKPwhRLGg85v8Db3+ete3Hv4L1
         wou2BKn0sxn2Pk0cVmnQNykHXJ/9x2PNYjVGtZrbbWUA5f/s9uMR34VVVCRxYipX4dED
         HGw5NsVc+zpP4Oz+TFg584fI/oxuKPiU8tP9oKc2nPu6z+VMyPDtiDBkCJbwQ8PhOogh
         HsQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWuX7nQ4Ro0G9OBqBH091rDp3nSgoewFm62BmmyliysZY1UXUyl3fO+hOWsCRv+Ys9BcVYh6VGGv4/o6oY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxqxh6+rWrOG8Lz7TpNBvrfJ1DMLBCIR3WYilQZaKQ9JlcMASxM
	XOz1KdnRE9KFQSeKUDll+pGFjdzEU51BY7nUplOUZswqTu8WOt7TDqeAcFXbICznF0M=
X-Gm-Gg: ASbGnctBsKgv36NkIqQ4NEK98jL4tO6xAmNotpiTfh/ljoSDCm02wkKS+sd0Tsygd4J
	GtZeWKb7n9Pa2NohqS9U1O68786A5V3CZKoB0eSF+gZSmnv1A3bApA3ko8w+Gj1ZHOXCCHDJwIz
	m6PaL7AAIk8YYrtgAcatPAVfF3eSDjeJR/JAs9ZWBie9q1usNUGpFzpAqrNph95SD2btLuXzM2W
	lg/j2PMKUW7znyQrNR374OwnionLDdobzhNjDsAcYEOglToXNN9Ch7jK/NG1AxMHr3iQaD6zmqM
	daoot32EKjXM8h+HWbBIBURKKSdl2EWTEMvBwwxwTD22ip8laafVp0TQtmyBWW8QHMoxa9kFUWE
	Fw2yXWCKvynIFj4D9ivArTloNsQ6/HW6o0OjdUyAeqFcQK6Yb9EFacvWWMqyK0heg7ehLl7Fw1y
	dvZ//GriCC1cMlnaOa+DAa7JpwSkMB9cS2Z9cA7sVDhSK6TW5s76x0ftI4bpQdFTQ=
X-Google-Smtp-Source: AGHT+IE5HT8zyhO+x64QxgSYjKr7L7F+qcefl5D+0FWEsp9ZQtU+HT7k2Pn+gFUE7dvYr1UxapCqpw==
X-Received: by 2002:a05:600c:19d1:b0:471:747:2116 with SMTP id 5b1f17b1804b1-477308b943dmr32724215e9.41.1761915364051;
        Fri, 31 Oct 2025 05:56:04 -0700 (PDT)
Received: from ta2.c.googlers.com (213.53.77.34.bc.googleusercontent.com. [34.77.53.213])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47732fe1075sm31814585e9.11.2025.10.31.05.56.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 05:56:03 -0700 (PDT)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Fri, 31 Oct 2025 12:56:00 +0000
Subject: [PATCH 01/11] dt-bindings: hwinfo: samsung,exynos-chipid: add
 google,gs101 compatible
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251031-gs101-chipid-v1-1-d78d1076b210@linaro.org>
References: <20251031-gs101-chipid-v1-0-d78d1076b210@linaro.org>
In-Reply-To: <20251031-gs101-chipid-v1-0-d78d1076b210@linaro.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, semen.protsenko@linaro.org, 
 willmcvicker@google.com, kernel-team@android.com, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Tudor Ambarus <tudor.ambarus@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761915362; l=2586;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=52mHw6aKRd81AmHkFdwI5f2O5qzG7/nRl12+OyMNuEs=;
 b=vpkvnaAKzBlUYUyJicoR7s8ZIonwBdHpBvPXSHqnML9kKehWnWDt6lXVGE1gK30tPNuHSi6tz
 tYeAfPhVfVCDtbiE6EMzCUWvpiA6l7oT7wpXfT4MIUlK7O4ZKhTeT4t
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=

Google GS101 Chip ID references the nvmem cells from the OTP controller,
it doesn't need a reg space. Add the google,gs101-chipid compatible.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 .../bindings/hwinfo/samsung,exynos-chipid.yaml     | 51 +++++++++++++++++++++-
 1 file changed, 50 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/hwinfo/samsung,exynos-chipid.yaml b/Documentation/devicetree/bindings/hwinfo/samsung,exynos-chipid.yaml
index b9cdfe52b62ff3a365d61368c39db21facff6565..6d6260be02d47712ebf1e4d31973802e8340cdfe 100644
--- a/Documentation/devicetree/bindings/hwinfo/samsung,exynos-chipid.yaml
+++ b/Documentation/devicetree/bindings/hwinfo/samsung,exynos-chipid.yaml
@@ -33,6 +33,16 @@ properties:
               - samsung,exynosautov9-chipid
               - samsung,exynosautov920-chipid
           - const: samsung,exynos850-chipid
+      - items:
+          - const: google,gs101-chipid
+
+  nvmem-cells:
+    maxItems: 2
+
+  nvmem-cell-names:
+    items:
+      - const: product-id
+      - const: chip-id
 
   reg:
     maxItems: 1
@@ -47,7 +57,46 @@ properties:
 
 required:
   - compatible
-  - reg
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            oneOf:
+              - enum:
+                  - samsung,exynos4210-chipid
+                  - samsung,exynos850-chipid
+              - items:
+                  - enum:
+                      - samsung,exynos5433-chipid
+                      - samsung,exynos7-chipid
+                      - samsung,exynos7870-chipid
+                      - samsung,exynos8890-chipid
+                  - const: samsung,exynos4210-chipid
+              - items:
+                  - enum:
+                      - samsung,exynos2200-chipid
+                      - samsung,exynos7885-chipid
+                      - samsung,exynos8895-chipid
+                      - samsung,exynos9610-chipid
+                      - samsung,exynos9810-chipid
+                      - samsung,exynos990-chipid
+                      - samsung,exynosautov9-chipid
+                      - samsung,exynosautov920-chipid
+                  - const: samsung,exynos850-chipid
+    then:
+      required:
+        - reg
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: google,gs101-chipid
+    then:
+      required:
+        - nvmem-cells
+        - nvmem-cell-names
 
 additionalProperties: false
 

-- 
2.51.1.930.gacf6e81ea2-goog


