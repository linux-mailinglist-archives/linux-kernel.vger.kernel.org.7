Return-Path: <linux-kernel+bounces-838997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF89BB098B
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 16:01:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C273D7AFFE9
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 13:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10CDC302750;
	Wed,  1 Oct 2025 14:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AwhFhsDY"
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A511830214F
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 14:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759327268; cv=none; b=jFrBzc6VywkVLYWEPwxsnGhLe+edih2myHPGp6gRdu0qFS9KnfzsEjlWFUgkxhlOoUvBrT39vMAD+ki5OmokkyE6jwTalAc+4gl+GZ+u0HX1JIDZWCh6jBWLQD7upQprzw4UIDpsoioafCJE3ZsLDaEox3Dpocfkbd+lhVwLFWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759327268; c=relaxed/simple;
	bh=hfGk7uQVjLThG3ECHgakMM62Hu2CceaDtMXfIaJebeY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JQXjI3w9fJAmoRY63xQntfqc8FG9OAUNuA2rm7Kl8VE+f3Ck3YvCIK3T332LAaRmb9sCBP330Eev/Epmcb4IFYL+wqoZngPI4BHVakVI9vR41L9yWN7tj/UxiJFEdfm2enDP6vqo7nJd6JZmUzPC44fuKh7rRZyFkXQZKIjwpVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AwhFhsDY; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-46e2e363118so69761985e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 07:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759327265; x=1759932065; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fsszsfqn6nKhuQ5ZGb0FQ/doPY/Ih/TU5I38riDkDPQ=;
        b=AwhFhsDY3JE1nCeRaJAIyzSDW63Nn4YFOdHobpmO0CU/DPyyTxysRzPzdabLgRNVy/
         oNR8NhgCC4YNJhbG6AJViizCULdW5qtPo2pqyg1vFTYzDD4PmRM9ptwg2ob4W14Eg51+
         0mN+X4Vimxnqm0fvtXxBGU+S2zvSyZiY66o/llf1qaplUxTMWGz2fu71bIV7F59s88zg
         /3k4oBhS8ao1Va22jZ5f+jvUMz3HqhCn8B2YuQcEKaeGOkwBsbsHLHIPO1GNNR8k1xlE
         4GGw85VCiG48elOOpMDh70l72k7Flq8LwK7OPLzh1tAVoXw22rLaNJIimNLwZdIEfHG/
         HTGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759327265; x=1759932065;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fsszsfqn6nKhuQ5ZGb0FQ/doPY/Ih/TU5I38riDkDPQ=;
        b=kp9offNBqDI/r0O89U1k5iG41kWrWI0f+UTE9Ab52KS0Pw2R/FYHhjcXbbXBlSnVvr
         dS8cKGqAmm0+FIzOdrzPIm57Sc/C8IlHy2SVJQwZMRBq+YeGQ3Zm7HXhY0Vw8zx3Qrkb
         VXvt/1wRF7ciVNib9OcIN4K4OIR+2+vLu/tH89kOhjkoe9RUBnIvkyoSeG+RB67iBD/E
         5hMQoMkKwXg2BGuBy+p3x1Xg0NjPM81IFgaM7kUEwNX6wO10lsmvsMiYY138TC54MHlu
         xg4y04JtixdWei28F67/c0C+fkUaC+n13In/A+XA0dwwOTOe8abP6gxKl1diDWCFtFCv
         0bWA==
X-Forwarded-Encrypted: i=1; AJvYcCW6a3jttontV3zSKRNMvw+vOJI9gSW4Sqzocf12zDw0DPUItOcXvKXM2eeDWMYAet44vrfTMjonVHHUUB8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7H37JcjtbPsY1qE09d9scYzV7P8o75Lv985du4wLL8fZUqxSP
	HSlDf7Q3Qc+rSytCH6PKN+I+m4jkGFYPaBHm15ETFTzVh+LQ7Wl8dtAB
X-Gm-Gg: ASbGncuyppegwFcJE762eUCgqKiH+XYW9hBnL+DIdsvfkx1mP8nrqwBiPP2jz6x6KBc
	PXqF6k53Y+ulGPwt30iESd2J9K5RoC6Kx2DU3O+KvsKpjWdI9WFyS6PVOiPCRzXuqoBiZZ5TWWz
	lxy58f7ulLt+ui3znZzP1d4B7VV6eYhVp2qDgEq+PzwHOnX4KZxNrazqnFsG9E7hHMKWLlDUUAo
	crGKKnllD760qw6PZeJ/LjMmQpVxoXEebl+hR/XY61YaEaR6E98uSVyFOXJNwMw9Kl5xHpCreLw
	DqgvJmAU7eAyXMAHSGf3R9TNq7o7NFy+cq4yhsrFoOb4nfOXbQrR6uZ1yc1nwP3wQ+FenXS2pRW
	WOyk0XpR5rPjw8LvLXUjgd1DzKEkA8txH+ZBh+kDYNx+77Z6b8TV88yeTIjvCrqhFcNucikt/VX
	QrfNCyjOhNlUiEIj9SUFOqyDWRfdRLtvQ1Txb1oIw4S671PZ+MpZAdGw==
X-Google-Smtp-Source: AGHT+IGfdA3CFMOqzDfdHGv3iprZDyUerHzmhklMNsvWYGm9CmujeeYnsM2kSToIaaRJkR9fFhfaSg==
X-Received: by 2002:a05:6000:18a7:b0:3ee:154e:4f9 with SMTP id ffacd0b85a97d-425577f31e3mr2814568f8f.20.1759327264519;
        Wed, 01 Oct 2025 07:01:04 -0700 (PDT)
Received: from LAPTOP-AMJDAUEJ.soton.ac.uk (globalprotect-nat-extbord.soton.ac.uk. [152.78.0.24])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fb89065b5sm27029828f8f.17.2025.10.01.07.00.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 07:01:04 -0700 (PDT)
From: Junjie Cao <caojunjie650@gmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Rob Clark <robin.clark@oss.qualcomm.com>,
	Dmitry Baryshkov <lumag@kernel.org>,
	Abhinav Kumar <abhinav.kumar@linux.dev>,
	Sean Paul <sean@poorly.run>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	Antonino Maniscalco <antomani103@gmail.com>,
	Jonathan Marek <jonathan@marek.ca>,
	Eugene Lepshy <fekz115@gmail.com>,
	Jun Nie <jun.nie@linaro.org>
Cc: Junjie Cao <caojunjie650@gmail.com>,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	freedreno@lists.freedesktop.org
Subject: [PATCH 1/3] dt-bindings: display: panel: Add Novatek NT36532
Date: Wed,  1 Oct 2025 21:59:12 +0800
Message-ID: <20251001135914.13754-2-caojunjie650@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251001135914.13754-1-caojunjie650@gmail.com>
References: <20251001135914.13754-1-caojunjie650@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

NT36532 is a driver IC used to drive MIPI-DSI panels. It is found
in OnePlus Pad 2 tablets with CSOT panels.

Signed-off-by: Junjie Cao <caojunjie650@gmail.com>
---
 .../display/panel/novatek,nt36532.yaml        | 83 +++++++++++++++++++
 1 file changed, 83 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/novatek,nt36532.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/novatek,nt36532.yaml b/Documentation/devicetree/bindings/display/panel/novatek,nt36532.yaml
new file mode 100644
index 000000000000..ca4b16459a72
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/novatek,nt36532.yaml
@@ -0,0 +1,83 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/novatek,nt36532.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Novatek NT36532 based DSI display Panels
+
+maintainers:
+  - Junjie Cao <caojunjie650@gmail.com>
+
+description: |
+  The NT36532 IC from Novatek is a Driver IC used to drive MIPI-DSI panels.
+
+allOf:
+  - $ref: panel-common-dual.yaml#
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - csot,ppc100hb1-1
+      - const: novatek,nt36532
+
+  reg:
+    maxItems: 1
+
+  reset-gpios:
+    maxItems: 1
+    description: phandle of gpio for reset line - This should be 8mA
+
+  vddio-supply:
+    description: regulator that supplies the I/O voltage
+
+  ports: true
+
+required:
+  - compatible
+  - reg
+  - vddio-supply
+  - reset-gpios
+  - ports
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    dsi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        panel@0 {
+            compatible = "csot,ppc100hb1-1", "novatek,nt36532";
+            reg = <0>;
+
+            reset-gpios = <&tlmm 133 GPIO_ACTIVE_LOW>;
+
+            vddio-supply = <&vreg_l12b_1p8>;
+
+            ports {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                port@0 {
+                    reg = <0>;
+                    panel_in_0: endpoint {
+                        remote-endpoint = <&dsi0_out>;
+                    };
+                };
+
+                port@1 {
+                    reg = <1>;
+                    panel_in_1: endpoint {
+                        remote-endpoint = <&dsi1_out>;
+                    };
+                };
+            };
+        };
+    };
+
+...
-- 
2.48.1


