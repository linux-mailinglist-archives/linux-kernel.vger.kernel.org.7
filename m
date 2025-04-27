Return-Path: <linux-kernel+bounces-621751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CF85A9DDB1
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Apr 2025 00:53:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DF355A39CD
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Apr 2025 22:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CA2520487E;
	Sat, 26 Apr 2025 22:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kUavhUVN"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EED8200127
	for <linux-kernel@vger.kernel.org>; Sat, 26 Apr 2025 22:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745707976; cv=none; b=Zcm2YjVRDvH8IIiI9FrTKl9dwJ/prcjY+NHiDF9CnAYt18igwfI8dcYIABzrrY0OlQEZPk0hDBYEbKubu0h9/pGZDmN6gfjUd15K4LxcCQtz+/dP1W4HDZtFDUzJaoRM782dOI3IFhvNzN898VeYfaQXKsBXGY2RnKy1GYvLznA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745707976; c=relaxed/simple;
	bh=wcxEeIG/nILR9pbCjMso9yZS3cwzR9yIu9oGH3Xl5mg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DM7wG3uz8c0fc9BguVGek3PLVZebLfNFQ6oIEbzYSycfg7SSG8ohv7hlPtIaIt/yhp+YDn086VHQgDiMoQgcLs9jR9hUWw/XtuYc6iPQgoOTWyBxZyXo1BCLrQhiFblGkAeHZN5IjcgN09gDbA2IIojm3IBhm4rC6v6vu2wivu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kUavhUVN; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43cef035a3bso24429895e9.1
        for <linux-kernel@vger.kernel.org>; Sat, 26 Apr 2025 15:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745707973; x=1746312773; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HAQCWAaBVBZ9L8/5seSjJb98H17XEO01YnL9fUDtsAc=;
        b=kUavhUVNFCunb+/ArDVqhVNs9clfIDx47XOGqEzLLWi3IloOxq3inIGKhci1Fg0851
         ONaTK/9YUdQ+MHnQTCysix4xQKgn1u+et82ZGfGhAj5WFEidb7AdKEn6IN4aDzVaQVRR
         f9PsqDp/ycuBkNcAFVbTobQFEyzF2RvDcMPZU9kybVXqcroI4wQGLCfGiPmgwd+oUa73
         NQvks6GzQNX3z+QrB4iAASp22+Vaty7djUXrLPFz0LxIK+fkZs0KMPI6kQqSd++ACX7W
         HIJEWmwdVDMcEBkdcCW2a8V3gnaVpIEg0LMAXzFZUVolxjMOJsuX5WrYVevwbcXVuoln
         erlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745707973; x=1746312773;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HAQCWAaBVBZ9L8/5seSjJb98H17XEO01YnL9fUDtsAc=;
        b=wBXpowJA60uA3LH8bRN//Inf13v+gKUCQVM0jvNeCBJcnvJ1Dd4zl2AgodJ+BMovaf
         9x77VrXwgcGuW8PYGTKEQ3684eX4rPZeMCX2RDazoGe21jVtHorgYPodkARoK8IJEBUq
         Tfr2n0tETHm3BZpwkleUNiAl1qNr/p5SnJoAhyWLuHDKKKFXZ2xx5BjZJ9gdXJwYn2bV
         1fnm4pUbj+CaYJfCyerfE5HhBKPQF5y8r4Lxb0+WoZOt5n5yh4d7E8TxuI8MChEA8H8f
         hXw8NFUtgShYNdRm43adohORbf/ReiTOefZhxtHlWOkW5rlVAOQkYL9jt2iSotyjOEBv
         fZtg==
X-Forwarded-Encrypted: i=1; AJvYcCWGs6Mc5ySb/6mZSO83UqHhl6HJnjLFp8mevnkg/btz2Wfw01c4F2uCwDuCDrmcfh1tF4dz671Tqpd7m3s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzljU/ydqreWdGpWauQWuAq2LrS9Er5FFBpCDKffFqpBVpt8jGh
	1kuorpB0J2oaMpQv15c8OkwKHinyQ2FjLwglUkQFLfwfbEMTurzo7EVCQxmfj1I=
X-Gm-Gg: ASbGncuI/Qokx5P19KMTF46p2IMzSWgbo5eStl7IKDgMofxLuiPNvOm2yhgz3cg7l40
	b6mEGQQvGvqUUhDXFzMkozVbElO2WAbJ0cJJM6sr2UERV5ZS/nSm8pOUeOm5HKg805lrl+Vzzjj
	ZwNaEULHDpHAPE3tTefU+2TMyeIjcA+4vyEPs+tzlxsYoS5+wi98RECYz6hjkDRFyviDY525ELC
	bQTTC7XnexQ38w8zKVm6sCZPRO8ETFvj0tbQIlgIxyehIGdKCvnW/M47OoWZK28NJUqaHyi664e
	rlpvOQTh9SL6i11Zo3Y5qBtBsm84zhZnPomOb52PPFKRt3yCtRxzx4WXPSbWQsv/SJqwB3/PRMG
	9+7RjSg==
X-Google-Smtp-Source: AGHT+IF1Asy0853DyQQ9p4VHU/AtjevRBJ+r0Z+2rcSHTVtDv8isvqLYBjAZhzTgjqdud5T8mcm1tw==
X-Received: by 2002:a05:600c:1c96:b0:43c:fb36:d296 with SMTP id 5b1f17b1804b1-440ab845facmr27097195e9.25.1745707972717;
        Sat, 26 Apr 2025 15:52:52 -0700 (PDT)
Received: from [192.168.0.34] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-440a53044besm75268915e9.14.2025.04.26.15.52.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Apr 2025 15:52:52 -0700 (PDT)
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Date: Sat, 26 Apr 2025 23:52:48 +0100
Subject: [PATCH v3 1/2] dt-bindings: media: qcom,x1e80100-camss: Fixup
 csiphy supply names
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250426-b4-media-committers-25-04-25-camss-supplies-v3-1-19e5e72ffc3e@linaro.org>
References: <20250426-b4-media-committers-25-04-25-camss-supplies-v3-0-19e5e72ffc3e@linaro.org>
In-Reply-To: <20250426-b4-media-committers-25-04-25-camss-supplies-v3-0-19e5e72ffc3e@linaro.org>
To: Robert Foss <rfoss@kernel.org>, Todor Tomov <todor.too@gmail.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: dmitry.baryshkov@oss.qualcomm.com, loic.poulain@oss.qualcomm.com, 
 vladimir.zapolskiy@linaro.org, krzk@kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3102;
 i=bryan.odonoghue@linaro.org; h=from:subject:message-id;
 bh=wcxEeIG/nILR9pbCjMso9yZS3cwzR9yIu9oGH3Xl5mg=;
 b=owEBbQKS/ZANAwAIASJxO7Ohjcg6AcsmYgBoDWPBzGEZSJqfm4ZbNjN/QS7q1pKZyOgCWXXda
 M0/FqOxwHiJAjMEAAEIAB0WIQTmk/sqq6Nt4Rerb7QicTuzoY3IOgUCaA1jwQAKCRAicTuzoY3I
 OjVZD/9yC+3Vj7UdQNC9B4RnJTA7QRFfdvRDQY2w5JFlb2Gk7MdKBz2z+PgDekROQdp7hMGDyAa
 OGnb0fNIQaW0AGnis5K71lV4WsFS3TMwYcYc6Q35P+qCZfQjBYOhxDrWFAx+FXINNPu/TWXH4ys
 0Bp773ZGBwucBFhbxVCxgU05t8CP5a+7A/qGLfMMLlKHI4djLRWi1q6BIN0RhDeoozbFNkmm3J1
 Tq8wpBDDXI3k0ICLL9641o/hk0bdNoFNwrNY3ORTghc8c2XH/Gcbn4r8DmZzFuSzkQoNnMxLlE9
 lJ2VkMM/2OubHVjYYF7m5PaelWhSQbEFfJ9t+l9xRzb8Z64A1Xd/Bb4WdmNqBYN/JOqIX66iBwM
 eR7wievt7EEr0RChq3l8yegtRpzo8LzttWuXf1dP/8rCUHKNhIszFl2KAquVN095kf5D4e5MX94
 vdAMEtLYZukcUjNFIRP6w1bvdox6ivM6yxYFs6imUYOYBouc7etvjuX7PyUZz6qtKH1IkRYrsW/
 SXivT8vKba4sfRf0gg0lHJt9qa4uMuSvjTLuMfSKvKqge5Z8HsQjDuhzhmHNy4At2Iaow2Ot0FV
 hMWt39D14yBxFAx9Li/Zb/hlPsURcDJ9rDQRRtMYloCJkcx375YngsvR9myRZ8nBrpzx0L5a1ac
 g0554o3qeiHFMDg==
X-Developer-Key: i=bryan.odonoghue@linaro.org; a=openpgp;
 fpr=E693FB2AABA36DE117AB6FB422713BB3A18DC83A

Declare a CSIPHY regulator pair 0p8 and 1p2 for each CSIPHY.

Name the inputs based on the voltage so as to have a consistent naming of
these rails across SoCs and PCBs.

There are no upstream users of this yaml definition yet so this change is
safe to make.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 .../bindings/media/qcom,x1e80100-camss.yaml        | 52 +++++++++++++++++-----
 1 file changed, 40 insertions(+), 12 deletions(-)

diff --git a/Documentation/devicetree/bindings/media/qcom,x1e80100-camss.yaml b/Documentation/devicetree/bindings/media/qcom,x1e80100-camss.yaml
index 113565cf2a991a8dcbc20889090e177e8bcadaac..dc7c1a9394c3b547f5e0885bf501ed42dfbeba88 100644
--- a/Documentation/devicetree/bindings/media/qcom,x1e80100-camss.yaml
+++ b/Documentation/devicetree/bindings/media/qcom,x1e80100-camss.yaml
@@ -118,14 +118,6 @@ properties:
       - const: ife1
       - const: top
 
-  vdd-csiphy-0p8-supply:
-    description:
-      Phandle to a 0.8V regulator supply to a PHY.
-
-  vdd-csiphy-1p2-supply:
-    description:
-      Phandle to 1.8V regulator supply to a PHY.
-
   ports:
     $ref: /schemas/graph.yaml#/properties/ports
 
@@ -157,6 +149,30 @@ properties:
               - clock-lanes
               - data-lanes
 
+  vdd-csiphy0-0p8-supply:
+    description: Phandle to a 0.8V regulator supply to csiphy0.
+
+  vdd-csiphy0-1p2-supply:
+    description: Phandle to a 1.2V regulator supply to csiphy0.
+
+  vdd-csiphy1-0p8-supply:
+    description: Phandle to a 0.8V regulator supply to csiphy1.
+
+  vdd-csiphy1-1p2-supply:
+    description: Phandle to a 1.2V regulator supply to csiphy1.
+
+  vdd-csiphy2-0p8-supply:
+    description: Phandle to a 0.8V regulator supply to csiphy2.
+
+  vdd-csiphy2-1p2-supply:
+    description: Phandle to a 1.2V regulator supply to csiphy2.
+
+  vdd-csiphy4-0p8-supply:
+    description: Phandle to a 0.8V regulator supply to csiphy4.
+
+  vdd-csiphy4-1p2-supply:
+    description: Phandle to a 1.2V regulator supply to csiphy4.
+
 required:
   - compatible
   - reg
@@ -170,10 +186,22 @@ required:
   - iommus
   - power-domains
   - power-domain-names
-  - vdd-csiphy-0p8-supply
-  - vdd-csiphy-1p2-supply
   - ports
 
+anyOf:
+  - required:
+      - vdd-csiphy0-0p8-supply
+      - vdd-csiphy0-1p2-supply
+  - required:
+      - vdd-csiphy1-0p8-supply
+      - vdd-csiphy1-1p2-supply
+  - required:
+      - vdd-csiphy2-0p8-supply
+      - vdd-csiphy2-1p2-supply
+  - required:
+      - vdd-csiphy4-0p8-supply
+      - vdd-csiphy4-1p2-supply
+
 additionalProperties: false
 
 examples:
@@ -347,8 +375,8 @@ examples:
                                  "ife1",
                                  "top";
 
-            vdd-csiphy-0p8-supply = <&csiphy_0p8_supply>;
-            vdd-csiphy-1p2-supply = <&csiphy_1p2_supply>;
+            vdd-csiphy0-0p8-supply = <&csiphy_0p8_supply>;
+            vdd-csiphy0-1p2-supply = <&csiphy_1p2_supply>;
 
             ports {
                 #address-cells = <1>;

-- 
2.49.0


