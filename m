Return-Path: <linux-kernel+bounces-864133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0056BF9FDF
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 06:48:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 753B656467C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 04:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B35D2D8774;
	Wed, 22 Oct 2025 04:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=reznichenko.net header.i=@reznichenko.net header.b="j4d9Ouqh"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A932D97A0
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 04:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761108439; cv=none; b=Wv7sPlDTGEUT6Ys4Gj0Flj3MOLfFLuewdH0rhu4hrlfCY4ZW4GRI0vAOP7c5xpTov8VCRz4jLbLbJ42GiugRUJw4JhZEw5u2xwgx3kgzxF1jh4TShDlL76AaVwytNAaZhtRQ+PRp3pp5wUv7G1ZlYXnWqf5OmPLhhD7iwpBJ0rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761108439; c=relaxed/simple;
	bh=tRmg0nM0yOi19ddPpyllwAng8EhI2p+zBWRtANG9g3k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JhbeSLqXwu0HUVmNb8M4+KZu46XOL9K5vm5Kwq5OWgZp6unhHLTz/rYrsbFiOcOrgJGYW/eQEgV8PFX8gbiggkwbW1zVEnwph+Ke0HCCDXS3W5eRHnvcFkk+ei1Y2sS1+TnO/7EY8po6mW3gYlul/5RAAuh9dm3mENp36RHUh/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=reznichenko.net; spf=none smtp.mailfrom=dpplabs.com; dkim=pass (2048-bit key) header.d=reznichenko.net header.i=@reznichenko.net header.b=j4d9Ouqh; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=reznichenko.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dpplabs.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-33d7589774fso3986589a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 21:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=reznichenko.net; s=google; t=1761108436; x=1761713236; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+g3w2/WDXSoRhXJMMBp8Ljyd85I3LbiCuNCDyo4g5rM=;
        b=j4d9OuqhMHAUkHo181/Gg+2LpYBMjVOn+EjuqLI6WnAJ4m/nNctyqVRH8sYABxkuP5
         puLk0Ajaz9HJSG0Ra2VoOO4AC+MaW2CYBm2PDWBkrLt6YhXvBPnthMW+Gop0hhqtrlj3
         gQ6vJ4CNYmvAg9Ys7n1zL0KirVbzmtVnD+R+2sLCeHM3aJxgnjjEttHrQXdhS1u/TzVy
         T5xmxh4E5/N3zIh6JuFl+YVKkxz+5c3FIAqfBgOdNVZcuPhRD3iu6PCYCDEOE81YmZoy
         yd3vbhQAMQKGJYhjf72jyVBWhyRtg2gAnmdxkO+Vx65QInG1jfeidKqU3Vr/xqaGWzNo
         x0WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761108436; x=1761713236;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+g3w2/WDXSoRhXJMMBp8Ljyd85I3LbiCuNCDyo4g5rM=;
        b=Vu50BUst8n9NZxZyjBd/qmsGSMBrcP61i2JKCM1ejus7d6bYEfBX4A7Un5x6Cs/Gsd
         ZJz2KG6oxgbaMZKdXCwGy7dhuo1FHG1Z5mWE88F+D8mibTBhnUs2bEQCS8OJMOSQbpyH
         Wp+aEdoaYjhybf1OXhcPH/0No9OhS7JfGEW5XhkGM4/6bYzD1bVTM8M7TnpejNl3ALcX
         ruyda6BSJr+FzA8ePboLWJ9WuU+C+mfS3pFj3AnBsPQ7rQPBbSySfVlgrgO7W46ELO2G
         mCbtFLCetxgDDF5s2mVWxaMKODzv+FW5IoucLErmpf7AoR6gInHNP+H4YQwEZMrj9VT5
         k4Mw==
X-Forwarded-Encrypted: i=1; AJvYcCU76KIfxQipvSrO9Nd2b5/d/UnTVMGJMbr+bdG91noZTiegV1X5b7w+5vz+rmpYaDtlisFT60AAuQHM1IE=@vger.kernel.org
X-Gm-Message-State: AOJu0YydNNbHOlb54Ukip1iAEjROejxFF76dzVm/FfCxPTrsw3llyNzE
	/TJNZMkHpaPs4J4bbezoX7Y8TmeqQ/I1ybl5K7afbbpOq9X4nV36RHCA4PWZ1aPZm0I=
X-Gm-Gg: ASbGncusKu4eHAJVnmPd3LOKbHOzR3f+oleef6zjN7sUOuvpxiFI9TD21vm1zsO+rxY
	QhUrB7Wf8OJoXnk9PQHYbNMn6tvPMuqOKMpE+XJ2jhG5TK7LkB3BduaUfak8enL1YdoyLrFK8lk
	lgRwalDJagu3WbcwL5mUIt7+Achq5juTucFvWKvbKpfHx7IEyZp5qD0wiFyHHG5EBibbeGeU8kS
	R1CuwqrIm28HxJ+a8QEdwJwPobbCgOzsdVYw3hMordzQ4z9x6nGfaCpXPzzI/zd+E4yE/rr1QAm
	gxjpyaMJDeMQK+shvn0MApMaP98kYRqMr76swC9Nx2b54W7IJUU876SJQbQ/6h/mBaDHTOPL+I2
	cvvdcSk7d3w/NzjrEHeZl7ARDoix17m6/ppi7wCiwJQ7sjOYaIYmiB1+S5/Uxc2vPbeDtP8aZp0
	Y9/gld
X-Google-Smtp-Source: AGHT+IFW1zF3iL/OYtMt8e8D26V/k4CY22GYL4vfqmAbUGpIaxRLd5gEXU0u21nkZey/eOJ5HimP6w==
X-Received: by 2002:a17:90b:2d8b:b0:336:bfce:13c9 with SMTP id 98e67ed59e1d1-33bcf8e3d37mr25973339a91.20.1761108436088;
        Tue, 21 Oct 2025 21:47:16 -0700 (PDT)
Received: from z440.. ([2601:1c0:4502:2d00:8004:e310:f3d:dd0])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33e223dd9d6sm1257413a91.7.2025.10.21.21.47.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 21:47:15 -0700 (PDT)
From: Igor Reznichenko <igor@reznichenko.net>
To: linux@roeck-us.net,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com
Cc: linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH 5/5] Documentation/devicetree/bindings/hwmon: Add TSC1641 binding
Date: Tue, 21 Oct 2025 21:47:08 -0700
Message-ID: <20251022044708.314287-6-igor@reznichenko.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251022044708.314287-1-igor@reznichenko.net>
References: <20251022044708.314287-1-igor@reznichenko.net>
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
 .../devicetree/bindings/hwmon/st,tsc1641.yaml | 54 +++++++++++++++++++
 1 file changed, 54 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/st,tsc1641.yaml

diff --git a/Documentation/devicetree/bindings/hwmon/st,tsc1641.yaml b/Documentation/devicetree/bindings/hwmon/st,tsc1641.yaml
new file mode 100644
index 000000000000..e79f6dab4a87
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/st,tsc1641.yaml
@@ -0,0 +1,54 @@
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
+  TSC1641 is a 60 V, 16-bit high-precision power monitor with I2C and MIPI I3C interface
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
+  shunt-resistor:
+    description:
+      Shunt resistor value in micro-ohms.
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  st,alert-polarity-active-high:
+    description: Default value is 0 which configures the normal polarity of the ALERT pin, being active low open-drain.
+      Setting this to 1 configures the polarity of the ALERT pin to be inverted and active high open-drain.
+      Specify this property to set the alert polarity to active-high.
+    $ref: /schemas/types.yaml#/definitions/flag
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
+            shunt-resistor = <5000>;
+            st,alert-polarity-active-high;
+        };
+    };
-- 
2.43.0


