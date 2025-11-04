Return-Path: <linux-kernel+bounces-883874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E57C2E9E8
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 01:33:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F34A189A0DE
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 00:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5523D2116E9;
	Tue,  4 Nov 2025 00:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=reznichenko.net header.i=@reznichenko.net header.b="obyEU/IY"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2268115530C
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 00:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762216407; cv=none; b=Vdb4R2aGerPWg5ujozsw3LtI857AkBfJTIb0gjuYmAqhKG3HRcvIme80pR4VcE+aPSAmQkR6lrb7WoSX+lQwWWDKKpDU1FwYH3m/btfT4SpLcDRJLGJ0C85BPcUY8VoEZZMagMgRq+yWFzmVDMzDjZhVhzphRGGP9pxNAUDWRSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762216407; c=relaxed/simple;
	bh=jmST4cbclzkiAEDiwG2BErRGZct5eZ5VJ+6Q/QlBDqs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XFWPeFlzaMhHl2Ca7ktJgWVJtX6YHh6bDLVeqwdmdOCNb24nrJvGFM4qplByHyst6wXujyyRr/BrSY3MkUIpBCVVWrfMtAbNzPZAvh+zJM7AG7LKiv1nRvLJBCqSyJs1/M0FcV5q5PHIc23aUFbmjSPjcviEjPUq7HU35KQfWQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=reznichenko.net; spf=none smtp.mailfrom=dpplabs.com; dkim=pass (2048-bit key) header.d=reznichenko.net header.i=@reznichenko.net header.b=obyEU/IY; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=reznichenko.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dpplabs.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7ad1cd0db3bso46491b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 16:33:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=reznichenko.net; s=google; t=1762216405; x=1762821205; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kowxeIsoBsM6IJaG5YMYXb1ynonjUIpE7aGx2hbnyfI=;
        b=obyEU/IY+FKe4TUfKRMQLRnLkRFx+e4EgyNgU1O+n62ZVTyR76BhrWuWMQu8ngU5ro
         JiyO35kcJW5nq3DdvIu381gfjbCbigzaDcjkeGQu6Cf6W7Mw/t1BULGVZgoA0nCNT8p+
         oWnO837uTI7UqfIGHEC5FgmEUTw2UmQVFloZ64o26VvlDBY4ob8mWcEplbl1OfvKeCtI
         EC3MLZ+CNvZtnWF6uA7E5yt91WS7nEKUCS6nuOvmvdnrUQvha+9Qv0A6jcmL5wWOSzKO
         IgJAq10u1KJG1mVWGe2djXy6tiUPQ9SvMnAXA2mPt+O8/HToEtZ41v7S0qZ+uaACulcI
         7g7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762216405; x=1762821205;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kowxeIsoBsM6IJaG5YMYXb1ynonjUIpE7aGx2hbnyfI=;
        b=mDybF46TYJDEskq//AMpWURwzTubWaHY7r9V1oUT5rGR+/AvUbLfq/0SH1yr0KuIo1
         01tciQCIXzFeIfUIKm/xUbD9oHM4PWQp8JHIa0MdXZoR9orEKePeFreLDyLydvzCuBv9
         F1Qh2CKrnME9RW9YPoIoXN5Y8ud1HzXZiOVw6DNiBv11qj0oMRch85K8eJNXECVEdbgd
         trPJXdLvM+flDGwaicU+2dKStw17eNBAnPzwHQOktpmzYrvM1DGeALC84/GzTElJ0/HA
         /HFKcGVGJMSi2Z1aZ5zi0Z5Rh2XwHS5qAQ1+cim+PZ+O2hkbsqVpOs/u6tKQkNS+zpGQ
         aC2w==
X-Forwarded-Encrypted: i=1; AJvYcCW0OiMXeG3h1m/lMFS4HyJXES8xwJZ2IIOPcFVBTwoV4e7N9j73fF6WttroZ0mGcr8ZTm1lz2V2hGxQtN8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSGJUkTYLfaxZlFtr7/xZsDaM1nAye/Nb1+vvMLr3fGxCE1AsE
	e2FYcvSm0Een3XK7PG/krAI4VwfKCRcbjdE3h0TG5kohb5wkRA+CCejf9KUddzyxC/k=
X-Gm-Gg: ASbGncsMGk9L93yQalnY9FXoyeVe3bLl/Yp2zCl2ivzAYlHeKPf6fPr6eWfz/Rjz5NU
	PuHYblrubbENO4P4XuneyY0P+wmiNYlt+eTmTGpUl3jYsFlh8IBMMvrjfF7tYz2EdG1NiLYpUtH
	KvfglvE2ID08Q1qVj2d6VoppYCkUGCqKKXiOrrGMmUr1b4HEjms4NcxVEIlmwX0oe6qZJZYnvTW
	mp1uX0BeLhI1auB8NXeeveaXwmhblMA8C0iriJ5IG397FzzvgKtgevKjFcCymoYsXDAlB+m5ZaG
	50iZT2wyzz7652jnAd0/r4j1QlgF5lIoPQKNx0WxZ11zDqo0vAP1sxelnLpyMqwVca90wk8bLcC
	XVLyn114xFWPXQoDT35sGlXgeAOHMEbrsc/I3gHZEdu3SC+H/O83TPHe1CGL4b8eFvlc0kw6l9B
	yOut3fSMJMoxNJkVtZuQ==
X-Google-Smtp-Source: AGHT+IHVIWBSA0y1P83cw1L08AqwpYVRKzgFYZZwfU98ZbJAsIFB6Q3vOEOtHFbXZCtKTvVXIwNvag==
X-Received: by 2002:a05:6a21:3394:b0:334:8f40:d6bf with SMTP id adf61e73a8af0-348cc2d2b76mr19149622637.42.1762216405308;
        Mon, 03 Nov 2025 16:33:25 -0800 (PST)
Received: from z440.. ([2601:1c0:4502:2d00:6127:c8ee:79ad:a4c2])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba1f9615c9dsm360123a12.36.2025.11.03.16.33.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 16:33:25 -0800 (PST)
From: Igor Reznichenko <igor@reznichenko.net>
To: linux@roeck-us.net,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	corbet@lwn.net
Cc: david.hunter.linux@gmail.com,
	devicetree@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org
Subject: [PATCH v3 1/2] dt-bindings: hwmon: ST TSC1641 power monitor
Date: Mon,  3 Nov 2025 16:33:19 -0800
Message-ID: <20251104003320.1120514-2-igor@reznichenko.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251104003320.1120514-1-igor@reznichenko.net>
References: <20251104003320.1120514-1-igor@reznichenko.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add binding for the TSC1641 I2C power monitor.

Signed-off-by: Igor Reznichenko <igor@reznichenko.net>
---
 .../devicetree/bindings/hwmon/st,tsc1641.yaml | 67 +++++++++++++++++++
 1 file changed, 67 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/st,tsc1641.yaml

diff --git a/Documentation/devicetree/bindings/hwmon/st,tsc1641.yaml b/Documentation/devicetree/bindings/hwmon/st,tsc1641.yaml
new file mode 100644
index 000000000000..cb4e41f0f99e
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/st,tsc1641.yaml
@@ -0,0 +1,67 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/hwmon/st,tsc1641.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ST Microelectronics TSC1641 I2C power monitor
+
+maintainers:
+  - Igor Reznichenko <igor@reznichenko.net>
+
+description: |
+  TSC1641 is a 60 V, 16-bit high-precision power monitor with I2C and
+  MIPI I3C interface
+
+  Datasheets:
+    https://www.st.com/resource/en/datasheet/tsc1641.pdf
+
+properties:
+  compatible:
+    const: st,tsc1641
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    description: Optional alert interrupt.
+    maxItems: 1
+
+  shunt-resistor-micro-ohms:
+    description: Shunt resistor value in micro-ohms. Since device has internal
+      16-bit RSHUNT register with 10 uOhm LSB, the maximum value is capped at
+      655.35 mOhm.
+    minimum: 100
+    default: 1000
+    maximum: 655350
+
+  st,alert-polarity-active-high:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description: Default value is 0 which configures the normal polarity of the
+      ALERT pin, being active low open-drain. Setting this to 1 configures the
+      polarity of the ALERT pin to be inverted and active high open-drain.
+      Specify this property to set the alert polarity to active-high.
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        power-sensor@40 {
+            compatible = "st,tsc1641";
+            reg = <0x40>;
+            interrupt-parent = <&gpio1>;
+            interrupts = <1 IRQ_TYPE_LEVEL_LOW>; /* Polarity board dependent */
+            shunt-resistor-micro-ohms = <1000>;
+            st,alert-polarity-active-high;
+        };
+    };
-- 
2.43.0


