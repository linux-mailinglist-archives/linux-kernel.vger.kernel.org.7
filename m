Return-Path: <linux-kernel+bounces-856528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60AFBBE464E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 17:59:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6690454306E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 15:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6954D350D66;
	Thu, 16 Oct 2025 15:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kWa5Fh5i"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80BDB1FC110
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 15:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760630328; cv=none; b=rE/JYKj+wKtaxSs2LlXCBUgNA22oYzdg4XpKrsUEB0afwkQI1EnNEWNspim/NSysebm0CFBRNqGxUn27Tcqh6QHcYhJhXvVcsPFzU08oqsKeOwjgRNGtTnNtNYfBy+SY+D/JoPZmpzsI43LiXAaPuVtk5BuKMTdkr3BU0f2uvbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760630328; c=relaxed/simple;
	bh=yje7DjsIFhOq220Z+6NhYIgkw1TYq5z3ouqumPOvySU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GqsHupA2Qmqw08iduMpI3i2VJOdGA4JTjfXWyifqdyTJhLdsrXPP4CphnPuVg1RZJybDsecKJtgPFcg7VRuIRH+AeEd0K01X947OA+Xr5vj4u82tlmraD9Sji6M14xr5XjzvXe/KrfCmLj/ZizdXGav0s2Hrwc9pOtUai2PqAdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kWa5Fh5i; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b3e9d633b78so209625566b.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 08:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760630325; x=1761235125; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aAQW91aNDUliYu6xIPIKkGd7wbQwulcJzXF5XdkzCOM=;
        b=kWa5Fh5iqCVVisGk55+kRkRpO+QVtSajcoeVjSM+ewvKv1RMhn8AXYZMmsMlm6Cec4
         JH0hN12NFv3HOoE3ndfyepw/atH1kOCxvIMfFEoF2QwOxGyMH7vO7yhOWF5cJpjWBrEP
         06iG5hkg3zFchiCidUKOBNz1lXhjhq7DxVuuQ5hhxjS5tPzSwFSqrPpYuKdYCMHIZbQC
         zjsL0HNzxx/1sKxdtz2ji88ByNBaDCe++RVBEB+1NSBw7p9Y936IV5/0oMoF/v3pgjKu
         s2pM/cxdrACRp0oOmLNp8vHQxoIEw2s9a3xBGyWSyBfJL7qMT1boPHsifDVYVhnPTEWL
         7WtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760630325; x=1761235125;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aAQW91aNDUliYu6xIPIKkGd7wbQwulcJzXF5XdkzCOM=;
        b=Tw/RDBUvXBfitvS+96l+ZM4StVS4NItMlDAU1tgCNpbMET/Z8RM4JLE2TfhkpOPB8T
         KkvRX2Z2Ck/Pr8TmXbYXsUsXOmE+NgCQOupIVz13EtTJECoMDljdbps06u9a6GHi11yX
         /og6qS3yAK5WShLybNoeBtQr5G6uaRB3NfFoztGdPRXdMxo3BEIqZfXBeKZxiYrJTUg2
         TgMogXXHbMlsjvDnwIzen1HxyEyM7DJWM6H8dqNKKoimgcSn4ddgHOm1dLWRLEZU61KU
         cedpwh08CYRDIaAcpbNu0FCmW96sB0/9FI29j+a1Pb+afzuxwcg9ptI/8P2FhF9T2Wik
         ZNPw==
X-Forwarded-Encrypted: i=1; AJvYcCVqSxt9X1i36KOyL5dpTC1RS++o6QsJpBHDjX0GhRE1D/ibqVSBaGRg5vIFCHFxwkEM6QlTASyiW/ONkbo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8Qbt+YI0iNH/bq7tfJJGvM4vvx68tPFqs+3I9KGlU6te34n28
	KVqeOPI7DEQMCLqvq2yCh/4k26JLRlRcnFiSS6BA5eiFsXgYpe44v1Mbtap7bl+s/I4=
X-Gm-Gg: ASbGnct689toAnWOI96K6RKHsF829qlX2xhCJ67jCUt6wpB2fxCGCKPceaarc1YpTv2
	caEoRWNBhAkI67uU8P+OO/OQo6yDyLUEo5o6opWdeesKLA9i52Nz21nCG7iHiVnQlUB8KHIe0jH
	b0jcx5QwAaIw3vFmJLzakaSl2Wgend8ZdT9XkaQ0eAKJiOZGF8MYmJejn5Br88k/YYN6FHpJ8bW
	4oG3qPyrI9SkSDrW/gu4NDhApNC1S52EmFQOFmuVc5QogTmnZx7EU3XpOWV0DgS/vu7p6yotNTJ
	Myhg+zNlIkvvGBpsBrgl/6jVwO5Z5M1UwepbFa99QVwl881fkHmOhXv3bxVw55oYbnJXkCwUJIT
	JtSRpgC2dFCKd7BeybAWvCPmvg5SyFi/XY8h3lcvq1O6CxJRAjxOjqqN8pX8kQaegGrKZJjxAhh
	pzteXvPSy/fZ0R/Tmpxh4HS8sZtdJjlbrk1SYmUPYheOS3gJGXNPYr+3PE3gPsJXrYbA2Y3j0=
X-Google-Smtp-Source: AGHT+IFwFoVlzrd3EzfRgwjFNULDxybArmFxvRw3PQFLU4BEOlEa5CBeY9fanhhp1MvTHV/cP8fhDg==
X-Received: by 2002:a17:907:3992:b0:b40:c49b:709 with SMTP id a640c23a62f3a-b605249d84dmr571454166b.8.1760630324759;
        Thu, 16 Oct 2025 08:58:44 -0700 (PDT)
Received: from puffmais2.c.googlers.com (254.48.34.34.bc.googleusercontent.com. [34.34.48.254])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b5ccccb4811sm549021666b.56.2025.10.16.08.58.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 08:58:44 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Thu, 16 Oct 2025 16:58:36 +0100
Subject: [PATCH v3 03/10] dt-bindings: soc: samsung: gs101-pmu: allow power
 domains as children
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251016-gs101-pd-v3-3-7b30797396e7@linaro.org>
References: <20251016-gs101-pd-v3-0-7b30797396e7@linaro.org>
In-Reply-To: <20251016-gs101-pd-v3-0-7b30797396e7@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Ulf Hansson <ulf.hansson@linaro.org>, 
 Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.14.2

The power domains are a property of / implemented in the PMU. As such,
they should be modelled as child nodes of the PMU.

Signed-off-by: André Draszik <andre.draszik@linaro.org>

---
Note: Ideally, the newly added properties (ranges, etc.) should only be
'required' if "^power-domain@[0-9a-f]+$" exists as a patternProperty,
as they're needed only in that case. As-is, this patch now causes
warnings for existing DTs as they don't specify the new properties (and
they shouldn't need to). Only if DTs are updated to include
power-domains, such an update should also add the new properties.

I've not been able to come up with the correct schema syntax to achieve
that. dependencies, dependentRequired, and dependentSchemas don't seem
to support patterns. Similarly,
  - if:
      required:
        - ...
    then:
      required:
        - ...

doesn't allow patterns in the 'if' block (or I didn't get the syntax
right).

Rob said in
https://lore.kernel.org/all/20251010141357.GA219719-robh@kernel.org/
that this is a known limitation in json-schema.
---
 .../bindings/soc/google/google,gs101-pmu.yaml      | 40 ++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/google/google,gs101-pmu.yaml b/Documentation/devicetree/bindings/soc/google/google,gs101-pmu.yaml
index f7119e7a39a3fe0a0a23d1faa251d356f83ba501..a24390f6d2a54afe1aa84935e03f719a62f4fc8e 100644
--- a/Documentation/devicetree/bindings/soc/google/google,gs101-pmu.yaml
+++ b/Documentation/devicetree/bindings/soc/google/google,gs101-pmu.yaml
@@ -26,6 +26,14 @@ properties:
   reg:
     maxItems: 1
 
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 1
+
+  ranges: true
+
   reboot-mode:
     $ref: /schemas/power/reset/syscon-reboot-mode.yaml
     type: object
@@ -49,9 +57,23 @@ properties:
     description:
       Phandle to PMU interrupt generation interface.
 
+patternProperties:
+  "^power-domain@[0-9a-f]+$":
+    type: object
+    description: Child node describing one power domain within the PMU
+
+    additionalProperties: true
+
+    properties:
+      compatible:
+        const: google,gs101-pd
+
 required:
   - compatible
   - reg
+  - '#address-cells'
+  - '#size-cells'
+  - ranges
   - google,pmu-intr-gen-syscon
 
 additionalProperties: false
@@ -61,6 +83,24 @@ examples:
     system-controller@17460000 {
         compatible = "google,gs101-pmu", "syscon";
         reg = <0x17460000 0x10000>;
+        #address-cells = <1>;
+        #size-cells = <1>;
+        ranges;
 
         google,pmu-intr-gen-syscon = <&pmu_intr_gen>;
+
+        pd_g3d: power-domain@1e00 {
+            compatible = "google,gs101-pd";
+            reg = <0x1e00 0x80>;
+            #power-domain-cells = <0>;
+            label = "g3d";
+        };
+
+        power-domain@2000 {
+            compatible = "google,gs101-pd";
+            reg = <0x2000 0x80>;
+            #power-domain-cells = <0>;
+            power-domains = <&pd_g3d>;
+            label = "embedded_g3d";
+        };
     };

-- 
2.51.0.788.g6d19910ace-goog


