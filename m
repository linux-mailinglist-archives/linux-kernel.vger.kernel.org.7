Return-Path: <linux-kernel+bounces-815622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 377E9B56914
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 15:03:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 18D594E12C8
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 13:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8355625B69F;
	Sun, 14 Sep 2025 13:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cGs7srcd"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02FD01DE4CA
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 13:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757854980; cv=none; b=oJSeldyFWjVOAu/F88PSDu7pRxr/r+YSJqKfD9TLPrn4y6az9aheJ5g2vDLkRsVDZdZHlCD5SmGJ8XUiVUfWj/yhcWJibwE1Bedy2hhk6tmqE76fbqkRnMPnHZzE3et/MVgrm6RjxOqvqpQCyolWx2RKnwdGIjuKVrVlJWZnOu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757854980; c=relaxed/simple;
	bh=a4ZBBjK/WU5GHiCatrh9aDbJ8ucH3NgYg6flBlGjFPY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FBD+SX/bL4RSpYmczvZzUpfrxE1sBqOtA8h8DLRFic2+WpVZl6d7IpEBzIA14CAelmxaEGl6Pjxzp1AuOKFRRyYvk7HpSPlrC7RTJDKhPImhl5zzjxqBGDXb8viGUijgQOcRkHS7G+h3laPnnQHaCnPxCNijj+lvS2dg4BPKJdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cGs7srcd; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45decc9e83eso34194255e9.3
        for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 06:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757854977; x=1758459777; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3oAhxTMJPNeQLUIHyuzOPHBbaUvEyaoQkiLHIc86Fe0=;
        b=cGs7srcdtQ6wCPD4+7kb6IYdX5KyDNosbjU94EEGYvgQysJ2wybFsH76Ee0ea5LNW8
         IQFe/POp38LpLewFomSOEExRLv40KjfNiZ9dCYkj/k69y1LXAFDRdbd6LtRMz4M3wCB9
         wQyGhwmoHbYj0qG9shQTTv+UNLqfsJg3FUEoywTeIsCl2lL564zyytHJl9uKNED/Oulv
         0F27YihE/fTj1KepIM7E2JzNHeJyAQC1bA8C7zZJN6osv/2Fc+/KnRcp27XhACNIJRAP
         qENzmE+XwwaIivWGxKWY8A+baGdupTMVQiiIRbJamB1gD+9/aXQ5AXsc6ormQUm35CeY
         qztw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757854977; x=1758459777;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3oAhxTMJPNeQLUIHyuzOPHBbaUvEyaoQkiLHIc86Fe0=;
        b=H6Z+PM3VdG9zqrPe5qKw/2nJDrkCynFSh+nTbQxx4BeirkBqjJUpv2VXXsGb5gpD9+
         69LZO3XN53oc22b9M14Ew2u7qXvGxPwnTIRVDt75tHbSj7Bk/+W+mC5/L+drx/OoXIx5
         BHAU7Py+gMmJafEu2C0+xVCev1dqpr6fIVe4yx1a7DwovyI13GLwsDDtPckqsuYDzlKc
         9zjL2Oqc/p1nGxRO6+h/OswZGm0g4FP3Ju9U8b9cuOLjX53QSrD2gtf44BagEonA4zEl
         gNmNgYSgLh10k/zB28Zjmwpa/PRbrDFTasWYXGo8rdApJM0/DFi3ufPd91MMQ1B8NTOB
         vieQ==
X-Forwarded-Encrypted: i=1; AJvYcCVguHHFdfWzT2qeF9wdp/ZbpF8NUpRrP3q8cjVfNLzvygms8UQg4rfARJVMHVPoZX6L4temrunmHT3Q8AA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZNmYwAnIJ5KV7lgkQBUNcJO/acR/ey+wYpnA1aYW5xrNULJ+g
	bLnrZ9+kez/zg/ffJUoYmu0E/z45E0FAn670gHnVxEiJG8eNqjVfk05X
X-Gm-Gg: ASbGncso2PpHWMkAViboCNxZPSpLaJzZ1+3DZT2ykKn6WpLJr/O4iofQ89SrI8RSQxC
	eceVQf+QruEBjpHJoqarkzaQCaheO6ym0zz1Jv7qzQ5S64K9o38vf50cDWTcVWaaH90NwEEUxGv
	CF04/4OaEadaI3rW4A9cvdXY32EoAWPz90NL/zHQlLq0HrEFAaDGxRQORnUSTHyOLVfmz4jr1Xi
	5ygBFRXCHSQPtQ9aWn9ah9ZPF7XxsHLkzol9OHRJ09ogCkuMpmzfB75qXVX4MMagZ+YSOG7Ac2U
	yryee1ixUlbC0xMKeYfnuByfmr5sL/p2J9xhgEGA/SH1xxDwq1aMpb9e6qcpVuBlinEzGlXxBMY
	2f0RydQ+0I/MrkYpMSRTk9w1zlI65UQTMfOtlEkRy9QshH7latoWwbi1jIosr4peWauOS9rn3Jg
	==
X-Google-Smtp-Source: AGHT+IFH0J7++zpYZUA+Z1NkSGmTdds/qaGaHNjbECc3qbgcVLSHKSOo9xfYKAK2+jJQWK3yvOFXag==
X-Received: by 2002:a05:600c:b51:b0:45b:86ee:415f with SMTP id 5b1f17b1804b1-45f211ccceamr67997095e9.6.1757854977246;
        Sun, 14 Sep 2025 06:02:57 -0700 (PDT)
Received: from ivaylo-T580.. (91-139-201-119.stz.ddns.bulsat.com. [91.139.201.119])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e0187f0a7sm77060965e9.3.2025.09.14.06.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Sep 2025 06:02:56 -0700 (PDT)
From: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>
Cc: linux-samsung-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/2] dt-bindings: regulator: document max77838 pmic
Date: Sun, 14 Sep 2025 16:02:29 +0300
Message-ID: <20250914130230.2622030-2-ivo.ivanov.ivanov1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250914130230.2622030-1-ivo.ivanov.ivanov1@gmail.com>
References: <20250914130230.2622030-1-ivo.ivanov.ivanov1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The max77838 is a pmic, containing a BUCK regulator and 4 LDOs. It's
primarily used in the Samsung Galaxy S7 lineup and is accessed over I2C.
Document it.

Signed-off-by: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
---
 .../bindings/regulator/maxim,max77838.yaml    | 68 +++++++++++++++++++
 MAINTAINERS                                   |  6 ++
 2 files changed, 74 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/maxim,max77838.yaml

diff --git a/Documentation/devicetree/bindings/regulator/maxim,max77838.yaml b/Documentation/devicetree/bindings/regulator/maxim,max77838.yaml
new file mode 100644
index 000000000..bed36af54
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/maxim,max77838.yaml
@@ -0,0 +1,68 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/maxim,max77838.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Maxim Integrated MAX77838 PMIC
+
+maintainers:
+  - Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
+
+properties:
+  $nodename:
+    pattern: "pmic@[0-9a-f]{1,2}"
+  compatible:
+    enum:
+      - maxim,max77838
+
+  reg:
+    maxItems: 1
+
+  regulators:
+    type: object
+    $ref: regulator.yaml#
+    description: |
+      list of regulators provided by this controller, must be named
+      after their hardware counterparts ldo[1-4] and buck
+
+    properties:
+      buck:
+        type: object
+        $ref: regulator.yaml#
+        unevaluatedProperties: false
+
+    patternProperties:
+      "^ldo([1-4])$":
+        type: object
+        $ref: regulator.yaml#
+        unevaluatedProperties: false
+
+    additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - regulators
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        pmic@60 {
+            compatible = "maxim,max77838";
+            reg = <0x60>;
+
+            regulators {
+                ldo2 {
+                    regulator-min-microvolt = <1800000>;
+                    regulator-max-microvolt = <1800000>;
+                };
+            };
+       };
+     };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index fed6cd812..a4916a178 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15061,6 +15061,12 @@ F:	Documentation/devicetree/bindings/*/*max77802.yaml
 F:	drivers/regulator/max77802-regulator.c
 F:	include/dt-bindings/*/*max77802.h
 
+MAXIM MAX77838 PMIC REGULATOR DEVICE DRIVER
+M:	Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
+L:	linux-kernel@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/regulator/maxim,max77838.yaml
+
 MAXIM MAX77976 BATTERY CHARGER
 M:	Luca Ceresoli <luca@lucaceresoli.net>
 S:	Supported
-- 
2.43.0


