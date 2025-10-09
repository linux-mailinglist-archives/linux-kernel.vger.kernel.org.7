Return-Path: <linux-kernel+bounces-847057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64D2EBC9C72
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 17:27:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96F8F3AD645
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 15:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CBC31EF363;
	Thu,  9 Oct 2025 15:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z2p6zsSp"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51B81EA7EC
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 15:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760023512; cv=none; b=R/GDHAa9Y0bzQttSzkZqZeUFo4+Db1djVWLOVKVZ6lHB606VnE1Qg9DLIvbAOZmPddehxdybWgx/ih/GUnM2bNy/JlzLFJpMUPWodez/0dNAXxt4fSLWyxBAPz2qlFoMC/EebEpsf40XMN0W70GKXnO7AjBMwniuB2Vh/bfAigg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760023512; c=relaxed/simple;
	bh=pveWC0dGG+QrmADRkCYghiuV6e2N7PQNMtP4GgXIjZI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cnLHYSNAD+HoG53sszHR+KtBzBOD9yiOwYtXKY3CVoCfhldt5VvY8jPpxNjVD7j9SjXVhD4SpjDrvZ4oKUsDG/HQ7pF0/QGBcHLYzAdRy/ZozePu2FlPAqbeMA/O3ZBQMsoBQ+EtU3Y0dp0ORL8aw7ThjTrV8E0pQUL3GMNS6U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Z2p6zsSp; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b3b3a6f4dd4so201487466b.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 08:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760023507; x=1760628307; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gIgGfpMab5d5IHvagQ8PqT9KdQ+uz2nglD6fw13G62A=;
        b=Z2p6zsSpQeMb+HUmmfzPT43PfrJslnlMcJyrPDQcpFhcwij6eHJLCOL+3aADB4hioG
         1QSswKRT3SUI7aDSO7bwyuumLQXDWXNcwWCybbhXmj+N98dtlep1epGgwTMGDQIiAaLK
         bl/olTUmndDfiO5f5jAJ4H/TbNG3il6ow0iGkQ/54Mq1Vrc5gOsh7nGJTifatK47fK5P
         XLxJvl/zYCoKAwN1tduWYCjnEljfio503JzhitCFZLy/FmXb4cS6n5be5cIDM39O9RjA
         0tY35QmVtat0G8PjbRnx6U7UuBonTgncLrtC9DEsWBp78xyavSW8LyOEQUX3WvNkHjKH
         +Pxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760023507; x=1760628307;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gIgGfpMab5d5IHvagQ8PqT9KdQ+uz2nglD6fw13G62A=;
        b=GypGvrRvn6EN8NGVxHfYcwmHZIFExbvz17npJ7OmB3yV08OLhY/kF2bYdp9qVMj6lk
         jdU5Vgf166oseGQ1w0cnGQDtaops9hLDUDqCR5UM6jqxCzdqnLPN3tSUMmtyKewgT99U
         XT0dxj+nEvWFycRQHietCjnnasyKZ6ogLWfsoBykcTZqTE3RC93SJmlLNthbQsc5N2mh
         ZeYgh3usyGooEw6kmQgnMel4QltTWwiG4xvuyhkYbScT2jZx9UgXtYPWKTlqO6I4x2QD
         pB4kjCUJUB60rv1m+ukmsSSZ13jiAnyo7XSRXo2vpMG8GkGwki31dkGbKDzRc8dZYtiG
         jhgw==
X-Forwarded-Encrypted: i=1; AJvYcCXIRg10sa0qILZQGD/5f8QYoyROVJE8q0yn3RJvSWh7xtdU1G3foQM/RWgPsIEntq0BFIQ3f4lLKCOIy0o=@vger.kernel.org
X-Gm-Message-State: AOJu0YylO+jSCKEg42oSkPLf/BSfdZJy2kfJQRkG7boSbX3L686gIYRu
	qGYREwiTP1CAHmcFOPr2ONTWR1Y7CUfT1pVr00RDN+/UcYj9KaQ/v8OHvN5yFRNhT1s=
X-Gm-Gg: ASbGncs+JOXd1h01Q9jo1PaY/3g3D40jZo/BN5tJ1JkYqwILLrCLXgETgecgntcvxwN
	e9ZGWRE96MRLfgh31Sc1bLpcjmflgi2lioD8Svxd+6fgrJikIe4gRPf9NMcxaE5UL4e3li3NRoU
	owxmolaVRgI9waf2k13GxPqnfbbM/EP/n2iTu2XifR52bIQE1vNnMRuls5yvxKMCdU8E4SszvRg
	5yjs07rq21wwYdqPZgwTnNMixtZs+ScZvTz/lgN6PbQq2KFKLNFHQKWNQKBqTunM4gQwpOGUlWF
	ZefxchewouldOjg8dminHXpton3rqmbP8n9rNMMGfWv8dQLMCoT3bL03A7sa3p3K8ZxtZzT8UN/
	9pSRHCW3aEZGQD5PBsM0dRFHGc6WmMabcc+eOI3U4wixjBN6cjQmCWl4Xcb9k0sK2/vdTlh0Q/i
	DId2nlCek44TzVka93Q5IrvautDKovvzbvwTnMjxIjrmzY3ejNdX8=
X-Google-Smtp-Source: AGHT+IGg04+IzEonQvFpIX4DqWAql+P+1rz1MPHdkVXRbACm/2BjXy8iSlJQRXa1j6vBNQqyTJPeWw==
X-Received: by 2002:a17:906:c14c:b0:b3c:a161:684c with SMTP id a640c23a62f3a-b50aa49025cmr842742566b.2.1760023506601;
        Thu, 09 Oct 2025 08:25:06 -0700 (PDT)
Received: from puffmais2.c.googlers.com (224.138.204.35.bc.googleusercontent.com. [35.204.138.224])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b486970b36fsm1908967566b.62.2025.10.09.08.25.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 08:25:06 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Thu, 09 Oct 2025 16:25:05 +0100
Subject: [PATCH v2 03/10] dt-bindings: soc: samsung: gs101-pmu: allow power
 domains as children
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251009-gs101-pd-v2-3-3f4a6db2af39@linaro.org>
References: <20251009-gs101-pd-v2-0-3f4a6db2af39@linaro.org>
In-Reply-To: <20251009-gs101-pd-v2-0-3f4a6db2af39@linaro.org>
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
---
 .../bindings/soc/google/google,gs101-pmu.yaml      | 42 +++++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/soc/google/google,gs101-pmu.yaml b/Documentation/devicetree/bindings/soc/google/google,gs101-pmu.yaml
index 209ee2f80d449c3eec568188898b3c6f7ae0ddd4..d18a351b649c0736662e67bb64de46afa01e399a 100644
--- a/Documentation/devicetree/bindings/soc/google/google,gs101-pmu.yaml
+++ b/Documentation/devicetree/bindings/soc/google/google,gs101-pmu.yaml
@@ -27,6 +27,14 @@ properties:
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
@@ -50,18 +58,50 @@ properties:
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
 
-unevaluatedProperties: false
+additionalProperties: false
 
 examples:
   - |
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
2.51.0.710.ga91ca5db03-goog


