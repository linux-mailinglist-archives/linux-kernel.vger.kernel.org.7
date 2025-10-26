Return-Path: <linux-kernel+bounces-870235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 50BF9C0A3F0
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 07:51:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B22744E311C
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 06:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 497C7274FD0;
	Sun, 26 Oct 2025 06:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=reznichenko.net header.i=@reznichenko.net header.b="NJSGOybT"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2563822156C
	for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 06:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761461464; cv=none; b=JQ4JhE3VaiJ3+D4nXOlSEqtvB19vVD2DES6JQnJUa8L2FMZGwPrV3VQ7r8Zew6D+YU++s8WPZtlk+MY25HDO/Q3zARojNcAEWCsdUI3vWLaaQuR3bhNh7EIQgSiRxRKN3PNSP/a/hhILZZXrBRVjTkfCS/QPLlNtV4+VIDgOSTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761461464; c=relaxed/simple;
	bh=91eutbdiqidC/G4kon+Q++aT9/9DTzorL8tQ+hqakE4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lcRO4F5cy6N50yZY95+4/0qwTvLwx6H/lsQdkL6HXt+TjVXgG7DcbvAOTK02NTVgy++qAUtwoQIWhrwDLEE0zZSU9TYCiMRUFtaVROCssih+jtpd8GwM5YCbVZa+zJsSxPYoY3ugvzS+QcH6Pk1ljlxYEWvv7/iu9a00GXlJQEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=reznichenko.net; spf=none smtp.mailfrom=dpplabs.com; dkim=pass (2048-bit key) header.d=reznichenko.net header.i=@reznichenko.net header.b=NJSGOybT; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=reznichenko.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dpplabs.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b4755f37c3eso2917610a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 23:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=reznichenko.net; s=google; t=1761461461; x=1762066261; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dz7xWRpvEc8yOS8Ty/nPJaqOcnmga2XcXY7rl8nMBM4=;
        b=NJSGOybTdhQytV5T5cTzLXX1PHHiP0Xcfd0dExykrGIhpI0ItSrs+5k/8TWCwxQktE
         FQa/xSjNpde2yqTQ27j9X5GP6pGzT9VE4189t9HkSC4eT9Yrc07UYfPAGZ64LqFV9BzE
         XENPapCqv1Zd9NsiQDHC11Kd5MZZabpEyHQlN+NA3/izBsTSeLKW6l0XWaGtyIwD7Pa2
         z5IaCs40xwlMOuhCkqpNzBlZPVJ6mDfVaY30skxr/T+Dl4euV2pYYoFM5g781nDB/hXz
         QIO51Xiz87uM2nGrowua3tX61YEfEUw3uWCriQx7f5jV1NjMj8PA2v7uTzwVwIGArgZS
         RB5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761461461; x=1762066261;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dz7xWRpvEc8yOS8Ty/nPJaqOcnmga2XcXY7rl8nMBM4=;
        b=TNkKrkBJvwojJ6iJGbWs7RXuQzgRiz4EfByv9uMmolrw6eoRwgP9gY4CYm+O5NWN4S
         hzKfjocS1ecfDiuUuTlK12xjwJXlZfDwc31Xgzu3QKt3A7yylmqMABTUxPaDzFYvV1Z0
         YtsPsOA2xlbutldULI2FLw9/dzLwnLIvEKGtN5MwzsWu4rPmNw8zi1WQRh7OzApS3onc
         BXDE0nDTmq8JF1TcQY7DTat7s6q6R3VAgKq3e0vCakfvX3Ai8EKrJ2j0WTlWajYISlDS
         KWs9GKlGYyEK7zJ7R0Dq8xs46QifRLoVdDen3xIxEhHmSWpf2jobcg26MGaOzAztBCL0
         Mc7w==
X-Forwarded-Encrypted: i=1; AJvYcCW8WwDSwq9CPT7+mJrGrJvKNGdKCpJA8mhgGe2pLje0DVUx66irt9vj/J1OPrcM3W9vrv8ph2PBdMJwwM8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+xJq1O4VU3F/bpZw8RO5Y8mchhV8AcCYI3eDdTuLfSwT0kFYC
	KlW+8TtMZAbURZA76EzVs8re7+HzUxc6zF/NRYlfnd/g59DDC1OiYQ5AiqDJzT+5IX4=
X-Gm-Gg: ASbGncvkEkGTI2dHP72UKMtS3Oz2ZAXHmmYBry/rWH32ZI2MpNzoJ2BCW98I++i7TLa
	l5r7nFYcyVysA2fgUnGV3NXoLRVMmqab3cxUf6KzcXMhuUp4L/tYohDgkfDW6giZqI0g0ujwM1I
	VToenoPBFGUPEVk9yKYtiZbHcPAvslIoWJqSZr7U2SwKI8Yhmpa9uWGuR1KCifrmrVjRf/iYku4
	W6BePumX9YlV9yViWYJFG+vOH1pmzxi/IAg1xLvikMYTUBKWSYmEC+Q4b5uFvLTOq68MVPBF5Am
	Xnkzn5SVu5QwWVBE/5UVCpYsLARcowUyUFWjNK1blyIMWr/KZ1OYcYIzUSxW1i9DJDoEK2vlrn4
	NSbf79uUHYTYfTEk55lWf9DzLW8bx6a4hG6+bm4eOCQYfUb3LQSp6Pj/ZkVgPYw/Ac/1rCxU59s
	BynJE0OgWs5bVAPdoJ
X-Google-Smtp-Source: AGHT+IGUfSpO1SH+sIklCLC7sSxmHonNYEFcnwWc8ZIBDaDFBHRdSpDdt7EYFZ3pJ8lJ0K6h8hWNag==
X-Received: by 2002:a17:902:ec87:b0:24b:24dc:91a7 with SMTP id d9443c01a7336-290cb65c5a6mr393908385ad.45.1761461461459;
        Sat, 25 Oct 2025 23:51:01 -0700 (PDT)
Received: from z440.. ([2601:1c0:4502:2d00:640c:95e5:94c3:cc2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d4288asm43184905ad.84.2025.10.25.23.51.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Oct 2025 23:51:01 -0700 (PDT)
From: Igor Reznichenko <igor@reznichenko.net>
To: linux-hwmon@vger.kernel.org
Cc: conor+dt@kernel.org,
	corbet@lwn.net,
	david.hunter.linux@gmail.com,
	devicetree@vger.kernel.org,
	krzk+dt@kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux@roeck-us.net,
	robh@kernel.org,
	skhan@linuxfoundation.org
Subject: [PATCH v2 1/2] dt-bindings: hwmon: Add support for ST TSC1641 power monitor
Date: Sat, 25 Oct 2025 23:50:56 -0700
Message-ID: <20251026065057.627276-2-igor@reznichenko.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251026065057.627276-1-igor@reznichenko.net>
References: <20251022044708.314287-1-igor@reznichenko.net>
 <20251026065057.627276-1-igor@reznichenko.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a devicetree binding for the TSC1641 I2C power monitor.

Signed-off-by: Igor Reznichenko <igor@reznichenko.net>
---
 .../devicetree/bindings/hwmon/st,tsc1641.yaml | 59 +++++++++++++++++++
 1 file changed, 59 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/st,tsc1641.yaml

diff --git a/Documentation/devicetree/bindings/hwmon/st,tsc1641.yaml b/Documentation/devicetree/bindings/hwmon/st,tsc1641.yaml
new file mode 100644
index 000000000000..cfa0e2cca869
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/st,tsc1641.yaml
@@ -0,0 +1,59 @@
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
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        power-sensor@40 {
+            compatible = "st,tsc1641";
+            reg = <0x40>;
+            shunt-resistor-micro-ohms = <1000>;
+            st,alert-polarity-active-high;
+        };
+    };
-- 
2.43.0


