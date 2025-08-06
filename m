Return-Path: <linux-kernel+bounces-757503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12DDBB1C2DF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 11:07:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A31373A6774
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 09:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D2BD28A41C;
	Wed,  6 Aug 2025 09:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P1zSpn3k"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E880E28A1EA;
	Wed,  6 Aug 2025 09:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754471168; cv=none; b=TiChFK4TUKccgaHDo8MbpC0/EeHA0JGX2Qz+UI8v0LCHT/3Al9zyGE0ph0I4n/NJtpOvMFOy/qhipurzlm3U6TyEez0H7Iogj7dGidnXFQsahhirRJx1fOIZoFDd8zrywupieADzsPyy4Zry8ewX4/WBAOb+I7YD52qqgxpgXcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754471168; c=relaxed/simple;
	bh=Ql6ugviBMrRn2Jki9AiqpQUa8C9VR1NQomKZHOWqAio=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IfcwiOmHnb/zvQOyEXy0FLIaUNY3OO3WLmyBl60eo/KA2AY8NH2eeo7T40dz2x6s8TkS9/aYdme3f6SuIvx72hIEaS8QocIxUEqNLN3lY9A5m9kirJmTvIiXCG2NiOmklp4XQrikfIlAsHrC86yYrsk6yBFFbgOSqby6zlAdLJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P1zSpn3k; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-3325cb38a78so31162251fa.3;
        Wed, 06 Aug 2025 02:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754471165; x=1755075965; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Qkylg8c+Vm8Og/kqbuMD24rtUr9muU2ntVmVz7XAj0=;
        b=P1zSpn3kJ63c+10R296zZNd8HDOfSdFUd6rgNGyUaO9Aln4ni+DziqE7qrmuF7PK4H
         u7MuSwuLLBvk3hTSX/guYsb42HT1NTawo2OX4JLwZb5IJgr5BpaFUrONDm5T+rmLATEq
         xrPI/XaOcGpwIBk9J8mtRUiSFKYgw/YWGJNxWvewcAD4JSG2DTx72q0u/VSBUWun+emm
         fLlbgFEWGlWA6TsnCmvX+o4D+u8M9DcPCt9WPv7mnbrLlpslimo3Atfqg4W9EkFedao8
         g5XJJrqIwJdv2iZUuALGzoVa91nJzJ6RQyP2Y+WZR5/tzKaTofnPa08Wtl86LQiFWxEV
         iXqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754471165; x=1755075965;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Qkylg8c+Vm8Og/kqbuMD24rtUr9muU2ntVmVz7XAj0=;
        b=U6p3viSspL12aNBscqYYPO1FuZXO4bAma45GhTEcyAPwACat3ygZ/nsOAlmvExmdjw
         yfGCfD4CUhCh2bvDqRWwW0p5fAafWIoH7oaOj9DIil19QNjZzIRe84HUd3eBAspQAbp2
         EsFvfC7OG0G+C4LIeTvM5muKYwCnzVsf/8i0MO5lwS0Rfo0TSL137NIiiwX89daXr5KZ
         MCn86IsalmEOWCwPssTX+ORTnTwZgBBz5bi3xCvokw2VA1rifTVi98+xl+oAMxJUKW5q
         2NF4xD3VtZTr3JGLDwa+rKEj4FItn00TmYnGDCHRNRV8A1sVsdez1U3cDQXHdLmSmdQV
         7+Og==
X-Forwarded-Encrypted: i=1; AJvYcCVeS2l6H75gaus9lN9a+T9fiQECy/Q8SSYN79rxiw75g4PALEXa4OkevQUJfHnzahON1l3i7vtt0skWSzA=@vger.kernel.org, AJvYcCWYu0IxBszCwd8knKcKNa3Oz1N6Ku3Ia7GHkvRsCQVzHZHkxGDuwp0DugzuJn8vOijH/2fwXnsUAs+UZVs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7kFj+L3iFpmCD4Q9bcPKAPq1YpAfpLg0v9zxoj16VJ+njWdaO
	E4oCcc8vYwGz2VdtdtGS8wJv1qqUf/cCK+SEh3QhZMtroCH8RPQUXEsM5vH+Kr7auaxzrw==
X-Gm-Gg: ASbGncukkVHzRIDt1GaYnmfhgaLkS0EaBQBeG0FdjSGKg4gCHh62HlV8l7cDzLkG6Kh
	v0h4JekdE//xjWRK2+nYByCBwccy3uNbHwyZllyGq/XfOI0vDR+zpyK6JdwamsbMcuspzt9EWEJ
	2J6iMP/l13XlBQIyG+gpx0tFvCmwBlV2GPlTSCbgpleHsHuvZy9TxCvzU75u4oTqp7eBgsc/vLi
	wxyjk7n9Ybesjgvx/429MHntrH6PPxb3GsSeeNUBR1wBwhAPkXHhnlFvB0HAbBwkMTb7S/101ZE
	vi7TzgWvcnBuWu6fOAnLE1Q0Nzb9u0mWaLrghxAslDaIpyarEA8+ALAhFIp09QBvAoos4Drr2ac
	pkjyH+lDr1jhJ
X-Google-Smtp-Source: AGHT+IGl5k22XEtZ0k33mu0NCbb4izNeDFKhn4yf7lsjV+I4es/iwHtGOxVjAGcmXSs3Rk+NQ8Er+Q==
X-Received: by 2002:a2e:a00f:0:b0:32b:7811:d48d with SMTP id 38308e7fff4ca-33381231618mr3734311fa.4.1754471164415;
        Wed, 06 Aug 2025 02:06:04 -0700 (PDT)
Received: from mmk-tp ([139.179.215.86])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-33238272e3asm22512691fa.2.2025.08.06.02.06.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 02:06:03 -0700 (PDT)
From: Mahdi Khosravi <mmk1776@gmail.com>
To: devicetree@vger.kernel.org
Cc: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mahdi Khosravi <mmk1776@gmail.com>
Subject: [PATCH v2] ASoC: dt-bindings: realtek,alc5623: convert binding to YAML
Date: Wed,  6 Aug 2025 12:05:10 +0300
Message-ID: <20250806090510.105731-1-mmk1776@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250730093713.104003-1-mmk1776@gmail.com>
References: <20250730093713.104003-1-mmk1776@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I converted the alc5623 audio codec binding from text to DT schema.
This is my first try and I used make dt_binding_check & make dtbs_check to verify
without getting any errors.

Changes since v1:
- Add dai-common ref
- switch add-ctrl/jack-det-ctrl to allOf uint32
- use unevaluatedProperties
- fix example compatible

Signed-off-by: Mahdi Khosravi <mmk1776@gmail.com>
---
 .../devicetree/bindings/sound/alc5623.txt     | 25 ---------
 .../bindings/sound/realtek,alc5623.yaml       | 54 +++++++++++++++++++
 2 files changed, 54 insertions(+), 25 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/alc5623.txt
 create mode 100644 Documentation/devicetree/bindings/sound/realtek,alc5623.yaml

diff --git a/Documentation/devicetree/bindings/sound/alc5623.txt b/Documentation/devicetree/bindings/sound/alc5623.txt
deleted file mode 100644
index 26c86c98d671..000000000000
--- a/Documentation/devicetree/bindings/sound/alc5623.txt
+++ /dev/null
@@ -1,25 +0,0 @@
-ALC5621/ALC5622/ALC5623 audio Codec
-
-Required properties:
-
- - compatible:	"realtek,alc5623"
- - reg:		the I2C address of the device.
-
-Optional properties:
-
- - add-ctrl:	  Default register value for Reg-40h, Additional Control
-		  Register. If absent or has the value of 0, the
-		  register is untouched.
-
- - jack-det-ctrl: Default register value for Reg-5Ah, Jack Detect
-		  Control Register. If absent or has value 0, the
-		  register is untouched.
-
-Example:
-
-	alc5621: alc5621@1a {
-		compatible = "alc5621";
-		reg = <0x1a>;
-		add-ctrl = <0x3700>;
-		jack-det-ctrl = <0x4810>;
-	};
diff --git a/Documentation/devicetree/bindings/sound/realtek,alc5623.yaml b/Documentation/devicetree/bindings/sound/realtek,alc5623.yaml
new file mode 100644
index 000000000000..0b9dc324f04d
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/realtek,alc5623.yaml
@@ -0,0 +1,54 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/realtek,alc5623.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ALC5621/ALC5622/ALC5623 Audio Codec
+
+maintainers:
+  - Mahdi Khosravi <mmk1776@gmail.com>
+
+allOf:
+  - $ref: dai-common.yaml#
+
+properties:
+  compatible:
+    const: realtek,alc5623
+
+  reg:
+    maxItems: 1
+
+  add-ctrl:
+    description: >
+      Default register value for Reg-40h, Additional Control Register.
+      If absent or zero, the register is left untouched.
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+
+  jack-det-ctrl:
+    description: >
+      Default register value for Reg-5Ah, Jack Detect Control Register.
+      If absent or zero, the register is left untouched.
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        codec@1a {
+            compatible = "realtek,alc5623";
+            reg = <0x1a>;
+            add-ctrl = <0x3700>;
+            jack-det-ctrl = <0x4810>;
+        };
+    };
-- 
2.50.1


