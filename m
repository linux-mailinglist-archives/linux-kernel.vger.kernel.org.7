Return-Path: <linux-kernel+bounces-815696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DD1CB569F5
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 16:57:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A34253B9616
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 14:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED0D92586CE;
	Sun, 14 Sep 2025 14:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OvZ8pmIA"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56841258EED
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 14:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757861771; cv=none; b=aeBCQqYcalZI+lR1n/SNgI1Y8xW6QMeAqj6YyUaPW6UsSmCyAS990i5X+4dM5kVmx86LGNhnPOQWygXqFpZFTSHqEsUuk5w8LeHz5/KgzBj8VRbEczsub68fpc+a6IOSQaljKfrCHGIg/Edfr6H/bkVQ5hOtSLynFNXOFJqnZJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757861771; c=relaxed/simple;
	bh=DmOsX7Vf/ilavkrwxUtj9QNM909CJQfFtlFDgRHasuw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f9H0RxIGcHmfLAnguptJk48gVGDHCZh8SESlMNzdYtbAFe+0eR7JsoFCbgCmxCbdhURSticXncO6uCifva+HJ5MnHMLxOynpGgPAXP+lPDCo6l3v+eyBhTXZr7YFzGLh6EJa+E190w9zp4UAycrmeErIgsgd2P/KSYCRx9PSon4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OvZ8pmIA; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45b9a856dc2so21062975e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 07:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757861768; x=1758466568; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WLnk4ZbyfQe9FhVo0Iaf0C5FfaSInQx1UG35rxo35j0=;
        b=OvZ8pmIAEwMzEhOFajgfPj3NDMK60UunkabtZBVnArGBeH+tHc316Dt3KL4Em3zYh5
         bd0zAS8O0BggJkH7sE+i2Y0YFTk4j8Hw4U1u4KSVMhy9iaMwl4SxnfVEqWwDY5QAKsQ7
         SHLKN61EeT/4OAoE59lKLi9BFcmNd3nIi2GukqQFFui7CcmTqw6j4l5aTJLk/Xo9eWSW
         GvIiFk9gC/dwNh5ojDizp5BCUFo2edvzpv/97PMSnIV9Cmlfra7kyOc0Ow2T148JOizV
         hydUCB86z809yOuaYtfNCApoDuc7DSx4BsQwgXtuTBWArQPolIOZKZ4vLpkvlwf+8RUO
         ugTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757861768; x=1758466568;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WLnk4ZbyfQe9FhVo0Iaf0C5FfaSInQx1UG35rxo35j0=;
        b=q4+fXtFthRYdaH6Xg9+9Qce9oY13ddw0ib4oOxfG8QB78bBy0C+viTfniMlWFcMLvQ
         ZlKBLV0wd4++DOpAKJikWsJXkiYw1Cd+OTmKfxIS6HWKVxACcVFtXaqueI14rrgQDdnn
         PuILLx7YESp0mYPABIj/trPVSU+DdvL9zBnndQQp5q/yossBZqSrtReXCxlfvOejgvKh
         bg+kItyLXYYEknXBleBJgWCIL+f6kurtEhjbe3zSx5H/v7oA/NqlOiUWvBLaggKD9N0R
         MPIvfy56rC7k7TAn/mF8rdtSqft3clRKvsFwmCelpaPIO+OrqUqGA/aiod5enuBRit/S
         AhKQ==
X-Forwarded-Encrypted: i=1; AJvYcCWS9P3/+ZC/C94BydLp1N7X1IjhTmVVVnCnBU6MfSUKmKEyV7eKDHsy652pHxtBTkItFLeuUXS4tH5jel0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdQ08ov2u9mXtZlhwcG3NtDfa3f8vN6UvdO1GWblK8a5L9zjtV
	2JfzDOzZ2XJ0XP6thknrHMtqOqEgvYGENrC1OZvQxCALu6bEMfaUDvcN
X-Gm-Gg: ASbGncs5VyZYFQ7YWAsvgl47ES4iLdb03m1g7tazc9CLUc3kfjPj4zg8CBDuAKd25KQ
	vi4TB3vsNiQRWtwYVGiqzFn5rxmtJmCpyiekRCgbYNYTa6JD+4cq2Qa2Kv3os4a9zwRTWka8a3t
	r2NPxSW8mBgdbZjd0msTpXrYVmAJrOEtIetFkzR4PFhHVkfe4q9tCiG6rMR6asd4vONWMWWuISI
	rvdU4z99sWFsEEhcT9WNDYhrnpHp//kdeWdlyOWbYp4gEAY1PkAVIzPM9l8X3ZCiSQMOvJcsS1o
	qUlJxm6ds0NOmdQGpeMMN4ynUw2KxnMBPzVRdMzn+S+Cq1HdhkR3BH5kH0AN6SVUKq9MJSvSdlR
	D+0ul94WuqSboJ/QiI49ZnouAgwDdeANurtDKF/QeJolnjw2/mrgmeS5OWnuW9FTihDDD3aVNdj
	gthuu0a6e+
X-Google-Smtp-Source: AGHT+IGA9P0DPlT3qLVqItOCiBENzd7lo8jFqFbJSSw4qh0mrbF1bC17C9VB8+t7dwhrkHYrwMRVbg==
X-Received: by 2002:a05:600c:1c96:b0:45b:4282:7b60 with SMTP id 5b1f17b1804b1-45f211fb7c4mr77463375e9.34.1757861767382;
        Sun, 14 Sep 2025 07:56:07 -0700 (PDT)
Received: from ivaylo-T580.. (91-139-201-119.stz.ddns.bulsat.com. [91.139.201.119])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e037d62besm136303475e9.21.2025.09.14.07.56.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Sep 2025 07:56:07 -0700 (PDT)
From: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc: linux-samsung-soc@vger.kernel.org,
	linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: phy: samsung,usb3-drd-phy: add exynos8890 support
Date: Sun, 14 Sep 2025 17:55:54 +0300
Message-ID: <20250914145555.2631595-2-ivo.ivanov.ivanov1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250914145555.2631595-1-ivo.ivanov.ivanov1@gmail.com>
References: <20250914145555.2631595-1-ivo.ivanov.ivanov1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The exynos8890 SoC features two dwc3 controllers with one USBDRD and
one USBHOST controller. Document compatible for the USBDRD one.

Signed-off-by: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
---
 .../bindings/phy/samsung,usb3-drd-phy.yaml    | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/samsung,usb3-drd-phy.yaml b/Documentation/devicetree/bindings/phy/samsung,usb3-drd-phy.yaml
index e90640320..2b1544baf 100644
--- a/Documentation/devicetree/bindings/phy/samsung,usb3-drd-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/samsung,usb3-drd-phy.yaml
@@ -33,6 +33,7 @@ properties:
       - samsung,exynos7-usbdrd-phy
       - samsung,exynos7870-usbdrd-phy
       - samsung,exynos850-usbdrd-phy
+      - samsung,exynos8890-usbdrd-phy
       - samsung,exynos990-usbdrd-phy
 
   clocks:
@@ -209,6 +210,30 @@ allOf:
         reg-names:
           maxItems: 1
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - samsung,exynos8890-usbdrd-phy
+    then:
+      properties:
+        clocks:
+          minItems: 3
+          maxItems: 3
+
+        clock-names:
+          items:
+            - const: phy
+            - const: ref
+            - const: pipe
+
+        reg:
+          maxItems: 1
+
+        reg-names:
+          maxItems: 1
+
   - if:
       properties:
         compatible:
-- 
2.43.0


