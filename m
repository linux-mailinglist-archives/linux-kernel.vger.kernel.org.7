Return-Path: <linux-kernel+bounces-724140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 819B2AFEF27
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 18:50:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4CFF188599B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 16:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5229022687C;
	Wed,  9 Jul 2025 16:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kzo37hbI"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C992223338;
	Wed,  9 Jul 2025 16:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752079721; cv=none; b=DdrTjiitaDlK2iFotqfGPf5VEotlV7U0g+2KylbnnGwykX47vRDTX1nbyQSeVY357Z6g9UieSk2mOl/nAWMQg/vPOZHWtl1NNE17uZYX6VxRMgosGfPU+kuifywotzFaW701TfYqBPg9GVGPsN5uTFBqLKl5CRVyGny4Pwdj3YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752079721; c=relaxed/simple;
	bh=RxNYHRjvRwbxissHn18e450qA3JeC6FShWF2D/8oXRc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gXwoDmruWs/cGh4VaXXPPdRj2BwyX+Fau6nrO0VXsEo9KMlet81mJCEVsl6yfOH2f5bKlylG7arMzeiL0yLFA+9Wmf2/tGLdrdoQ1S7H4SZUc/Ej32Ka5pCk11CIiQ6RRK7eXMd89qPSjZB1sxmL5Hjtwf3nB8uivl7pFLvAAnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kzo37hbI; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-451d54214adso471875e9.3;
        Wed, 09 Jul 2025 09:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752079718; x=1752684518; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aW+6pvesmNnQet8sOGIglZFbJFOJ9GWYSbg9Z1nNP3U=;
        b=kzo37hbI7TwzsHQy/uGC036cd528dgJBkXaFHtlD3av2coC/v1qVCRPPodLbLUtlzo
         3l3wJfPdAShhPm7187kwsI7ZOQshzk7eQWd2yb3YAZfdrAfCTt8qZyP8EBCefiF/Oh4U
         t2PtjjhnAeBqMXwS744IHrQuTPDU0YS4SupvAq6qd/I284BfL4mLJCM9RZO8Zu8TShGz
         moTnHFm6n/FZIG4IKg/KgMIQ/3+/I6Me8cscxD70fHxYganxCYCS91MTJO52T9uanZOY
         e2za6uENwlG1pAjiw9Ue03dDOCjClNc+Y8m3HQD8A2Zy9BcTcItFDeAv3OVmX7gr1l53
         TlCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752079718; x=1752684518;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aW+6pvesmNnQet8sOGIglZFbJFOJ9GWYSbg9Z1nNP3U=;
        b=HoeDr9dcqLRQ0ziKHqP/2plj96NE69QrfuJPYgIUmmfuUTrRsplPBSOXYjCIpunoCb
         CAaOXPmQLLJv6QL1gpMOdSgo6v9kc9QeJAG0FzN2+0KYYWJoqAmpGMa21FHUdJft6zsC
         xRhWNVhlVXJMaoZksbsy9pSzYODgWD/QJLPtaW31qaNAR8HC/uow4+mNifCk/EsMRFcd
         hKGo92lEWabu2wg3qfXpdMTb2Dy2oTv7BneNLJjGXEoMrv5aXEACLf0PQSTJt3et9HML
         jqrXaZ9TlhxwTK7/5hB4Sl2exCa3w6y9QisZMHixP7F1WVPCYedhNT3nvZfJjdk7Q8az
         V41w==
X-Forwarded-Encrypted: i=1; AJvYcCWQ6RsW0KflZbFi3rJRb0lzoju/OcKcOJg8d/DIc349zLdpcCAa4WaERN7SOHbYjr+3vsn9X+0K9bTh@vger.kernel.org, AJvYcCXNS0JhH3GQLzI5nylGpxx3E1m/glDEFEskbnPgzh+LbZNSnLs3UImy7uUU7geIjG/Lmb1Nu9M88dFu7zE=@vger.kernel.org, AJvYcCXWtFHrF06YAsx7Im3eblCBjP8+0ttzbdeCKAwpzM4Qh2ufL4cnRJtIuJJHQOcXxImohqKSPpsI+xeM@vger.kernel.org, AJvYcCXa04e6urGQKxFb2Gl3Q8Wa7BEfZjT/69XGxzdyuMkICajAAUp8HMhPhRSHxH1RXcftQsuWPFILYkgNl4H2@vger.kernel.org
X-Gm-Message-State: AOJu0YxOONRoR1bS5YCmVgZ4g2nB6hG3bguzwHA/dgewCoFdV0NqlBXZ
	y1IP6VPrBNVXFd5D4DefFyTkgUFCs7FKqe0h2BE4qtH2IFGP4FD7MfgR
X-Gm-Gg: ASbGncsXSNelqFFqSKQaIQXQ98EwUObCDS3X2TO3ETw+HkRQ2T4ByGLigGzG71DLqTA
	FHEQ/BWpge54csm+FBw3D3xlcV9frFuXD0RrOCuWBnndgFv/cyK0ORDy9MEjDklnun7VLY0Hh8b
	osTzUjX2/iUIp5GAhrXAiDNpPBEtLrYEyH0JFcpgBPGFSVkQkL8gOU2Eg8zQB4UeLure7SSSNPt
	idRY8GWG67RrLOm8xJt2v8nWE7Q+B052dF5zgIZBsvG4HWJcE3l6hhA82q8Ot4KdhDcMoNuJM/w
	4orx97392iR2aLtN7f8T+lujho0Nj6Z1899jJ1B8mgflvZ0130xZCHQynVg15VERgfCjAq3ZSq6
	E5PlPve2QExRD6oefYceAzo4CnQUitw2ppyDAU7pjU5CpvzwHOsHXtFB9iWQ/y68=
X-Google-Smtp-Source: AGHT+IHPW4nSqrMdmS43S2i2mtnBvt8UJAQyIY46BMAdgXyyUAUKk6tePIGQqYWemQlnRednj5ONfQ==
X-Received: by 2002:a05:6000:4023:b0:3a4:e387:c0bb with SMTP id ffacd0b85a97d-3b5e455b399mr2535466f8f.59.1752079718115;
        Wed, 09 Jul 2025 09:48:38 -0700 (PDT)
Received: from skynet.lan (2a02-9142-4580-2e00-0000-0000-0000-0008.red-2a02-914.customerbaf.ipv6.rima-tde.net. [2a02:9142:4580:2e00::8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454d50df125sm30634915e9.19.2025.07.09.09.48.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 09:48:36 -0700 (PDT)
From: =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>
To: jdelvare@suse.com,
	linux@roeck-us.net,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	corbet@lwn.net,
	linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>
Subject: [PATCH v3 2/3] dt-bindings: hwmon: Add Microchip EMC2101 support
Date: Wed,  9 Jul 2025 18:48:28 +0200
Message-Id: <20250709164829.3072944-3-noltari@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250709164829.3072944-1-noltari@gmail.com>
References: <20250709164829.3072944-1-noltari@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Introduce yaml schema for Microchip emc2101 pwm fan controller with
temperature monitoring.

Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
---
 .../bindings/hwmon/microchip,emc2101.yaml     | 59 +++++++++++++++++++
 1 file changed, 59 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/microchip,emc2101.yaml

 v3: fix errors, remove patternProperties and drop emc2101-r.

 v2: add missing properties.

diff --git a/Documentation/devicetree/bindings/hwmon/microchip,emc2101.yaml b/Documentation/devicetree/bindings/hwmon/microchip,emc2101.yaml
new file mode 100644
index 000000000000..10167747f748
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/microchip,emc2101.yaml
@@ -0,0 +1,59 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/hwmon/microchip,emc2101.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microchip EMC2101 SMBus compliant PWM fan controller
+
+maintainers:
+  - Álvaro Fernández Rojas <noltari@gmail.com>
+
+description:
+  Microchip EMC2101 pwm controller which supports up to 1 fan, 1 internal
+  temperature sensor, 1 external temperature sensor and an 8 entry look
+  up table to create a programmable temperature response.
+
+properties:
+  compatible:
+    enum:
+      - microchip,emc2101
+
+  reg:
+    maxItems: 1
+
+  fan:
+    $ref: fan-common.yaml#
+    unevaluatedProperties: false
+
+  '#pwm-cells':
+    const: 2
+    description: |
+      Number of cells in a PWM specifier.
+      - cell 0: The PWM frequency
+      - cell 1: The PWM polarity: 0 or PWM_POLARITY_INVERTED
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        fan_controller: fan-controller@4c {
+            compatible = "microchip,emc2101";
+            reg = <0x4c>;
+
+            #pwm-cells = <2>;
+
+            fan {
+                pwms = <&fan_controller 5806 0>;
+            };
+        };
+    };
+...
-- 
2.39.5


