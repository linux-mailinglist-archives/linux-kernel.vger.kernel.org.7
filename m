Return-Path: <linux-kernel+bounces-847810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3779DBCBC97
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 08:29:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF90D3C56F9
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 06:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 182022459F3;
	Fri, 10 Oct 2025 06:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GMdUieqE"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDCCB227EAA
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 06:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760077746; cv=none; b=rt43p7p9nWbRhAk8Ek11KLkL6IygNbhGeW3l1E4xQ+8zyVGM5/pRW6lPFc7OcX/x2AHCWHfS6f635TEI3zY8FWaXA01L3aG+u38emv+UD6QsvQt0ZigB8Va27skV+VmzbQ5XgILQDX+EQq/ZAXWStBSKXOO6GnRTWZTtAULof6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760077746; c=relaxed/simple;
	bh=kySh9NG87grNL5z+EmRBxiIrYlsYRYH05crLoGgqga8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Yzasm+iB8TtVN6STCWP/yawAMf8O+hcW0mnxTVQfRXVt3p6JRKenx6o22NayeSOUcXNcRb3lMcLbwxYVuKuHxehcrT4l11YgYiCP7xBMcJwGKaDjGX0KnqhWxVogfGEPZGm6MWxVd+hQ9J2M0JSN7taujE/rBk8oTEq7ziWG2EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GMdUieqE; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-afcb7ae31caso296513666b.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 23:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760077742; x=1760682542; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yUUNHiuEgnPPKqI5m8ivJnCwrgRBbv9ROPeU9S0a/7A=;
        b=GMdUieqE6ytVvIchw5Ewx+ve4tEvbh+tFNVxNRXhWkssapGHM/QtC2DZ+B8od9jmrl
         HodTpAKN715Kd3bAUXSxSnn6xoDE7r7nfkH/bg9dBVxOqEgnP2Vlt26smFmh5zzRHb2h
         nEf6J9O5Y1G+NcdzOCW6XGmVI0YG3vOFMoEjHYkehycEz0JIo3HzfziIQvEpRU1I53Dp
         0r564twa5Uh2KSxw4EWlJmtTgJmCk5eZEZYnZDimGd/VXAXjnJ8ph2INRYUDZXyZC2og
         44ur0uzB9Pd+LjlQSuHqHzJOWrJM62K/nCFUnw4hfdWMaiufx1OLy8xtVbPFvvbtYaOT
         Guyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760077742; x=1760682542;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yUUNHiuEgnPPKqI5m8ivJnCwrgRBbv9ROPeU9S0a/7A=;
        b=w5eW246jUFrvbacqZzajAGSvtzP2hhIm2BmCja7ZG1MHD41TVN81GCcDNjyuzkNE+g
         gqAFgwElYXOWTv7T9VhxtXNz629zYEr5zuZQ7JQe+2EGGLPfnchrmatx4J9+KGAQjTlW
         sfZD+vQ7YUuxFl4+5BjdHGwBigpETkqDEQAK1ChqYcBx4qxJfm87fOhRlUAQbWs2tU1b
         qYk+kccRAFh5U2BedvvG4dpSOTKskNkssSWcoieBYTQ7Ek+e0ahlaB6ycX0uSO3mE5ui
         JJQAnXQQCOODmedHvbFFCQtPm0VWDg2mrMylA+/7m2EYrGuvR7GGA7ANBB/trat+XPCv
         gL4g==
X-Forwarded-Encrypted: i=1; AJvYcCUbN2tehv7t6sNLI2LC7l3TFGZUxYcClYx75uJLagMfDmVf1iKD6Z3C/gHnA9/YrcXbJ4SmnE5WQZgVRyE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEgYFFDLfmtZgpawqTxtRXJSAuqQAq41tQIO1HC3dm+g7ksnJ+
	Zu8vDWpqRtUR6+005k/nOQILpGGsE5Qzop+ce600YmCob4FF4fIqd4edhTe/B7NSeCo=
X-Gm-Gg: ASbGncvQ/tLkpg4FX8abzP+sMtD7Cr4T8ch1KtChwD9LnhohCF/Gs1aON6x1WANolja
	nZF1pdXUzKPPnmBRR3S+kGhizyk+i7kj6s4D9bsNQyPv+SjuXmJIr3lhPerdasWwk9LLhNdtG2h
	M4vkq0QgPQeWd6rf5Xn/r32THIRbWamddex/66toUZ5hwsYRRoKsYf5l8RR/bdIkdOh4EH2Sz7g
	V2bfceoZA7Pt7m1eIjNAJq0D3Nm9H3qcUgjAQqNeCL9Z6mCcOVBtVK/5L0teF1Tx/ssvx5lW3fS
	9nYXCppD8CnuYqCpLNJE+Hco8jnp/TJkNGc2NwQqPT6rq+t3RM7MEcESolZTeQ6UEUUuXeo26ok
	KWE1qb0eLMufuqayVpD4psGx8sJ/gRgstaPJ3R0TGNQh0j+8u89cBEKiX9lC2X4io1oMMaZn9C9
	JG+aF6Nq/bPLfGdq+1+3S2O/KYwq2xueJ5Cbm06m40ByfHWw==
X-Google-Smtp-Source: AGHT+IEn4M2YqhFbmRC2ndhdI24yjeQJVlUILDD3ySBiu6pkd6BQr4bN8V7llojmXDE9gUYXL+O6Dw==
X-Received: by 2002:a17:907:86aa:b0:b3d:73e1:d810 with SMTP id a640c23a62f3a-b50ac4da07bmr1000402066b.49.1760077742044;
        Thu, 09 Oct 2025 23:29:02 -0700 (PDT)
Received: from puffmais2.c.googlers.com (224.138.204.35.bc.googleusercontent.com. [35.204.138.224])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d2a76499sm160895566b.0.2025.10.09.23.29.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 23:29:01 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Fri, 10 Oct 2025 07:29:01 +0100
Subject: [PATCH v2] dt-bindings: soc: samsung: exynos-sysreg: add
 power-domains
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251010-power-domains-dt-bindings-soc-samsung-exynos-sysreg-v2-1-552f5787a3f3@linaro.org>
X-B4-Tracking: v=1; b=H4sIAKyn6GgC/52OQQ6CMBBFr0K6dgytIOLKexgWpR3LJNKSDiKEc
 HcriRdw+d7iv78KxkjI4pqtIuJETMEnUIdMmE57h0A2sVC5KmWeVzCEN0awodfkGewILXlL3jF
 wMMC655d3gPPiQ1ILR3RQWnsq6lqqNjciLQ8RHzTv1XuTuCMeQ1z2E5P82l/v8ldvkiBBt4U0p
 awsmvPtSV7HcAzRiWbbtg8bw49M9wAAAA==
X-Change-ID: 20251007-power-domains-dt-bindings-soc-samsung-exynos-sysreg-5dd349912b0c
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.14.2

On gs101 only, sysreg can be part of a power domain, so we need to
allow the relevant property 'power-domains' for the relevant
compatibles google,gs101-*-sysreg.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
Changes in v2:
- limit to gs101 only (Krzysztof)
- Link to v1: https://lore.kernel.org/r/20251008-power-domains-dt-bindings-soc-samsung-exynos-sysreg-v1-1-ab41c517dec6@linaro.org
---
 .../bindings/soc/samsung/samsung,exynos-sysreg.yaml         | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/samsung/samsung,exynos-sysreg.yaml b/Documentation/devicetree/bindings/soc/samsung/samsung,exynos-sysreg.yaml
index d8b302f975474a87e4886006cf0b21cf758e4479..62bce63a1557cf425a651de8864f350b0c46b1ad 100644
--- a/Documentation/devicetree/bindings/soc/samsung/samsung,exynos-sysreg.yaml
+++ b/Documentation/devicetree/bindings/soc/samsung/samsung,exynos-sysreg.yaml
@@ -73,6 +73,9 @@ properties:
   clocks:
     maxItems: 1
 
+  power-domains:
+    maxItems: 1
+
 required:
   - compatible
   - reg
@@ -100,6 +103,16 @@ allOf:
       properties:
         clocks: false
 
+  - if:
+      properties:
+        compatible:
+          not:
+            contains:
+              pattern: "^google,gs101-[^-]+-sysreg$"
+    then:
+      properties:
+        power-domains: false
+
 additionalProperties: false
 
 examples:

---
base-commit: 3b9b1f8df454caa453c7fb07689064edb2eda90a
change-id: 20251007-power-domains-dt-bindings-soc-samsung-exynos-sysreg-5dd349912b0c

Best regards,
-- 
André Draszik <andre.draszik@linaro.org>


