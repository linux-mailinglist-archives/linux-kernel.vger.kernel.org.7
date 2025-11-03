Return-Path: <linux-kernel+bounces-883595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id CF47EC2DD67
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 20:15:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5372E34BE29
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 19:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B34531C56A;
	Mon,  3 Nov 2025 19:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xTSzM+oh"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F092B31D392
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 19:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762197291; cv=none; b=LCEup5ehuH9GEl6x53zBump+0SASonvExBCNjefGKk/KJwdURpggm+neAXAyJnM2sVulJrx5KT8iwgpa5GZBsunbVrfjutjIdvF9yLAbPFrsHhk9SbE5KrG8++WthM3lc265RsWJ7Y1/D2O9t3NXWLdWOffliDGRnjpb091znHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762197291; c=relaxed/simple;
	bh=9sAYfR8Q8tXsUci19b2cN9NhG0oDMU3Ts7x6dco4kts=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Decn0Hlp9PunuZTiCsCUS/RocaTNyNq0M6Vimyz4j7shru2+32t4WacxZXHl2NizZyzM3rZoJD3bKLVV6uMdrE1CvAbye5Ks99aB+WkcA6V+talRQlGZcYcMTmhv5MmW3zlyo4KGDmO4HAs9s1Ls7O7bAis6KbhxpDkWrh8awzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xTSzM+oh; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b715064bed6so111975166b.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 11:14:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762197286; x=1762802086; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XdqXlFzErV3w1gdAJhq9NKzHgWAXrtoJ/uLRhjCa4XA=;
        b=xTSzM+ohMEYLjVTErqnIh7FvLpoFU6entX9fKnuGIB3QKjQDIPeD/FOH2LJaiH0ZaV
         BCux4aahXTLnOCBQt/93ERoC/s9Zk0VP9aGOGmDVlGXABkVnG7XXCC++EIeefrqwucIf
         TXB/E9eMqslKThkgftdm9PpZXt3Zq+5KyWabpY8+8ymEIubaYqGm/i9R09EHe2KAkHsf
         ga7foCJjjKxh5PST+Xs9Qydb6ltes6pUTZXEXUuDV01rxxhmLlRmvWxmUwxJQmEXAje+
         rRtN5ULJfrfZVA0rjt2mYnhTTlIqNvvk/+ZL3bFiPK2YQlBTNWTm0DX+if3ePi9fBMHW
         yDVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762197286; x=1762802086;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XdqXlFzErV3w1gdAJhq9NKzHgWAXrtoJ/uLRhjCa4XA=;
        b=tQarskAj/2glyha1JNboXocJeCG/tFlDHJdbPJy8elPXCvhcv6gMwcFuiwxloGLkLg
         hd7qIfQkSThSd2eNV5Dk/qikAjRvhL6ez2Pm33hGVXVO3ePabe+x7pB6rNCUao42j5qS
         7Kwj2k6tJj+WmgtSPoaH2q86S+mJm5IMxbQrYGICVvuyyLrLyqJhuRAhiFvrS/J813R4
         QUqm9T/RBz6vv4ZoPtH9qbFj/3xzO4f3gSJywR3oIF/NkXa5M68mUZgR9jWEmuSgDu/z
         DKy4dfhgpHi9JnCgIO9zQIeQgo98jNAqt02LdWIOcqZ4htJfHjo7TyDoLUnMu4COD25j
         37Ig==
X-Forwarded-Encrypted: i=1; AJvYcCW7quhuQsTnAClgzWx0Vv1pTGGFs3+HvrAbEnCQV4Kf1UXv0pBZ5RIQZJHg1NU7PctvxBjNTEhrJMmhduo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv3eqyrfa0KEFynjNcMVaq/RmCqkgsK67fN23k/EuTQSFMdK/+
	yuWoKuFncPk4B98SWxi9AdVx3xRIgeci+vkTHZB6QjdxUMzvZm8oLH0rz5zrInVNmOA=
X-Gm-Gg: ASbGncvTm2BGP2NBppCdy3rj59jbyW3HoKX3tRwAkr0nayCkrqura/F+Ogq7dAuTzR9
	pLzUrLD+Sf8rqE5oViJCcjjqMbpiFcEAfRb443/tA6GOYMI+vzDEf0N7n+taVo0xzhCTzs/efog
	7D1nkZ60MfHJSJCYnJ6CQRvl+cJW0mlfIpplQdmsyGm2uOH9mnt+zZZsHVPh7lYIygtuFDQJqwi
	Ai2S9kFgK2ef9TXJbyq/TNUc7oJvTkNxmYq1ynI4eA+kmhP7ijRN/aOq2G+4y1tqeyeyls4rfdL
	QdClMnmdBZMGxz+zA7EJnS/zIzjxutGcOWk95/puw/4cxKaM5Ru/gZIDE2HbA62vVA4QewPDnKH
	xNZVHjXjSSiC13vp92+nyLfoyUFDaasRYVOpNORY0mXG1Xb9oP1pZ+RitqSG4sq/7iD5rM3Hxyd
	P+t+tnseDv9AKDwWqPIqMh3uhaYw3ivdpDXL9LzIQ/okln8fP/IhYvPU4VhC6m9vNmgrNWtwk=
X-Google-Smtp-Source: AGHT+IHclgdtV1uDsfGuUcwPrRCIxl9xPHteVOU4tXngK3Zyx/wOSbVCBZtl6qbOcWI1F2xiRNExRA==
X-Received: by 2002:a17:907:3d10:b0:b55:c30d:c9fc with SMTP id a640c23a62f3a-b70700ad6cbmr1282704366b.11.1762197285873;
        Mon, 03 Nov 2025 11:14:45 -0800 (PST)
Received: from puffmais2.c.googlers.com (254.48.34.34.bc.googleusercontent.com. [34.34.48.254])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b70b9f29c8asm466765066b.8.2025.11.03.11.14.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 11:14:45 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Mon, 03 Nov 2025 19:14:44 +0000
Subject: [PATCH v3 05/20] dt-bindings: mfd: samsung,s2mpg10: Link
 s2mpg10-pmic to its regulators
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251103-s2mpg1x-regulators-v3-5-b8b96b79e058@linaro.org>
References: <20251103-s2mpg1x-regulators-v3-0-b8b96b79e058@linaro.org>
In-Reply-To: <20251103-s2mpg1x-regulators-v3-0-b8b96b79e058@linaro.org>
To: Tudor Ambarus <tudor.ambarus@linaro.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Lee Jones <lee@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
 linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.14.2

Update the regulators node to link to the correct and expected
samsung,s2mpg10-pmic regulators binding, in order to describe the
regulators available on this PMIC.

Additionally, describe the supply inputs of the regulator rails, with
the supply names matching the datasheet.

Note 1: S2MPG10 is typically used as the main-PMIC together with an
S2MPG11 PMIC in a main/sub configuration, hence the datasheet and the
binding both suffix the supplies with an 'm'.

Note 2: The changes are done within an allOf: / if: match, because the
intention is to add the S2MPG11 PMIC to this binding as well, and doing
it this way avoids additional churn in those follow-up patches.

Signed-off-by: André Draszik <andre.draszik@linaro.org>

---
v3:
- move to new samsung,s2mpg10.yaml file
- move all patternProperties to top-level
---
 .../devicetree/bindings/mfd/samsung,s2mpg10.yaml   | 37 ++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/samsung,s2mpg10.yaml b/Documentation/devicetree/bindings/mfd/samsung,s2mpg10.yaml
index 841b7c8ab556bc6a3d4cc8d5a0c811814d4176be..dc06333a4050af69297ac3cae0628a0fffc3fcc9 100644
--- a/Documentation/devicetree/bindings/mfd/samsung,s2mpg10.yaml
+++ b/Documentation/devicetree/bindings/mfd/samsung,s2mpg10.yaml
@@ -38,9 +38,46 @@ properties:
 
   wakeup-source: true
 
+patternProperties:
+  "^vinb([1-9]|10)m-supply$":
+    description:
+      Phandle to the power supply for each buck rail of this PMIC. There is a
+      1:1 mapping of supply to rail, e.g. vinb1m-supply supplies buck1m.
+
+  "^vinl([1-9]|1[0-5])m-supply$":
+    description: |
+      Phandle to the power supply for one or multiple LDO rails of this PMIC.
+      The mapping of supply to rail(s) is as follows:
+        vinl1m - ldo13m
+        vinl2m - ldo15m
+        vinl3m - ldo1m, ldo5m, ldo7m
+        vinl4m - ldo3m, ldo8m
+        vinl5m - ldo16m
+        vinl6m - ldo17m
+        vinl7m - ldo6m, ldo11m, ldo24m, ldo28m
+        vinl8m - ldo12m
+        vinl9m - ldo2m, ldo4m
+        vinl10m - ldo9m, ldo14m, ldo18m, 19m, ldo20m, ldo25m
+        vinl11m - ldo23m, ldo31m
+        vinl12m - ldo29m
+        vinl13m - ldo30m
+        vinl14m - ldo21m
+        vinl15m - ldo10m, ldo22m, ldo26m, ldo27m
+
 required:
   - compatible
   - interrupts
   - regulators
 
 additionalProperties: false
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: samsung,s2mpg10-pmic
+    then:
+      properties:
+        regulators:
+          $ref: /schemas/regulator/samsung,s2mpg10-regulator.yaml

-- 
2.51.2.997.g839fc31de9-goog


