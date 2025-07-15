Return-Path: <linux-kernel+bounces-731702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D0D86B0586B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 13:06:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D9C01894372
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 11:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B1672DCF40;
	Tue, 15 Jul 2025 11:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AAqEyWc/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D812DCF6F
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 11:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752577505; cv=none; b=AmDfsYNCj3rpVB0hKZY/fFnvLeR1NEG959KsQ1h+CAsKh9J/8gP7Es7ErvsM8gO4kqNhnhIbC8etVjpsRNvfBUsM2VGgohNMNBsEt95DeJfYGr8QJzzQhSt7KgVFN5yGuubrOaTHdNGTRt4jdYmMcvQwqWtIQVVxqCECx0rGTWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752577505; c=relaxed/simple;
	bh=2WLJKOVAuaJt4QnmoXL1k44Atj4Pe1QbpaUPyStODjM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VFuyro/WGLV6gmb2SaG+rMaNVSvJvQNinoQeRMWJHScxlrOOmFUVSWurLdtQBa3aZnjw68NNBEAnbm9faCoWuvtsmRCDZYvhTVP+N22SIWxrUPqV4H8fhl2nMaskrBC/pvSKaCFM1Lg/+c1CN/AR+uZ4jCaAw5n0bqi4fPttbE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AAqEyWc/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752577502;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UXL9y7xBlAhc4AXFCXGCZMpy7EHZFtBhXWeACly5wqo=;
	b=AAqEyWc/H96YMs1SmLtBI9l/OSoI6zJYVS5KCncsuUJ4TD9BFm8fdkLkljhOJwKgNfS2EJ
	x4nbb6LOJlr/gtPeKYb9bMMOXI4N3xK7Mr2IIYUOnQM3aN1Atpvr6ybhokB9C6xCZjMH3q
	3A8ZVtRT++rMsIylcBFlFIcNWTdFITw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-zkUScSCENxGlU059sTqKRg-1; Tue, 15 Jul 2025 07:05:01 -0400
X-MC-Unique: zkUScSCENxGlU059sTqKRg-1
X-Mimecast-MFC-AGG-ID: zkUScSCENxGlU059sTqKRg_1752577500
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-455f79a2a16so30555405e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 04:05:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752577499; x=1753182299;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UXL9y7xBlAhc4AXFCXGCZMpy7EHZFtBhXWeACly5wqo=;
        b=Xanuna8qShEMIPQxEg61BSd/zVOamD9OkbrdknhH6zzM/PR+Qx6eXX9lR4N60+X7/0
         d/z7Zbl0v9+xBE4qxH2MqNIHmsasbv/soXR2JkjJneODXAHDbWsQvA1ZbP6bqtGSgP4v
         GD5YPqpL6qWjWS47NVPNhacJ4VNG3ezIyfpFBEodSR1MGtwFZUW8FejVBQCBry7gSWX/
         xzVrg6P7AONhYlDJt3uRUTvi/xPEUbcV0rm3A0cDo0OeYYFxDSh4Lol0XAqgn8SkL/uD
         +h7jENlNsgRsU5VXWtxu3wFzuPOukOZRYWvp74rPPZrKyHg2423/nN5WJKIrX2dzhUL3
         s6rw==
X-Gm-Message-State: AOJu0YwAuNkvj19h/HarGXZkHFthLvJKEQFtwrxZIbXdKcsZjLT4/jOJ
	wbVqCefPzye/tHL5qZv+mYA5CudQl72gvyFI62KdA8C65Nc7s7V1rFRtSiJ3DG/RNXEI6xiyCRR
	2WagxukRN1FaouiZkSJBcgAj+epbpC+zxM0bOH7LVTWb2rXdcCXHWD0BIa5wP1M8zXiCae9MRDE
	2OULLs5v8b5iUN/Vs7wH4JdkQVclOrySwHuF4eTAZIM4Pa7zII
X-Gm-Gg: ASbGncveoUqv5s7JDuBDjt9imqK98yAJ2R9LotHHSM48FEwGIWMgpMJ7e0mkcuACQQE
	dOiuOwFNqfXNPmLEKVe05g0FDvrPEWA3/KO3w05H0XJ18syssQHI3KZyoad4GluEE1tb+PWyZnb
	fbVXysXoZMQtUuYsT2tCdjDmjSBsiK3m4nx/mj+TpokTuYcneeQHF58hNVCtBc4QUwogOWQt0+h
	vSePh+wNucPo1EVeNziaUMEhh/SBTixhLTt1n9Qk+efx5CFuu90ESOkbaUvo2Bph9VZma07utiz
	SB2tM1YD6FkMxnPTMkFhK8GtBw4rc6n9
X-Received: by 2002:a05:600c:3481:b0:456:1752:2b39 with SMTP id 5b1f17b1804b1-45627727ef0mr18693715e9.33.1752577499362;
        Tue, 15 Jul 2025 04:04:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHX6q3lHTErOrCKqaTuVDGblbpeMy+KjGYJg/6IvgcpsrwPUGu+4zqypinlqXvEhZwLlzkaZg==
X-Received: by 2002:a05:600c:3481:b0:456:1752:2b39 with SMTP id 5b1f17b1804b1-45627727ef0mr18693195e9.33.1752577498799;
        Tue, 15 Jul 2025 04:04:58 -0700 (PDT)
Received: from localhost ([89.128.88.54])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4560f22cd29sm87905185e9.34.2025.07.15.04.04.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 04:04:58 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: ipedrosa@redhat.com,
	Javier Martinez Canillas <javierm@redhat.com>,
	"Rob Herring (Arm)" <robh@kernel.org>,
	Marcus Folkesson <marcus.folkesson@gmail.com>,
	Conor Dooley <conor+dt@kernel.org>,
	David Airlie <airlied@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Simona Vetter <simona@ffwll.ch>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	devicetree@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH v3 4/5] dt-bindings: display: Add Sitronix ST7567 LCD Controller
Date: Tue, 15 Jul 2025 13:03:53 +0200
Message-ID: <20250715110411.448343-5-javierm@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250715110411.448343-1-javierm@redhat.com>
References: <20250715110411.448343-1-javierm@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sitronix ST7567 is a monochrome Dot Matrix LCD Controller.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---

(no changes since v1)

 .../bindings/display/sitronix,st7567.yaml     | 63 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 64 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/sitronix,st7567.yaml

diff --git a/Documentation/devicetree/bindings/display/sitronix,st7567.yaml b/Documentation/devicetree/bindings/display/sitronix,st7567.yaml
new file mode 100644
index 000000000000..e8a5b8ad18fe
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/sitronix,st7567.yaml
@@ -0,0 +1,63 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/sitronix,st7567.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sitronix ST7567 Display Controller
+
+maintainers:
+  - Javier Martinez Canillas <javierm@redhat.com>
+
+description:
+  Sitronix ST7567 is a driver and controller for monochrome
+  dot matrix LCD panels.
+
+allOf:
+  - $ref: panel/panel-common.yaml#
+
+properties:
+  compatible:
+    const: sitronix,st7567
+
+  reg:
+    maxItems: 1
+
+  width-mm: true
+  height-mm: true
+  panel-timing: true
+
+required:
+  - compatible
+  - reg
+  - width-mm
+  - height-mm
+  - panel-timing
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        display@3f {
+            compatible = "sitronix,st7567";
+            reg = <0x3f>;
+            width-mm = <37>;
+            height-mm = <27>;
+
+            panel-timing {
+                hactive = <128>;
+                vactive = <64>;
+                hback-porch = <0>;
+                vback-porch = <0>;
+                clock-frequency = <0>;
+                hfront-porch = <0>;
+                hsync-len = <0>;
+                vfront-porch = <0>;
+                vsync-len = <0>;
+            };
+          };
+     };
diff --git a/MAINTAINERS b/MAINTAINERS
index ee2ef9d9db2a..d97e091b1742 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7835,6 +7835,7 @@ F:	drivers/gpu/drm/sitronix/st7586.c
 DRM DRIVER FOR SITRONIX ST7571 PANELS
 M:	Marcus Folkesson <marcus.folkesson@gmail.com>
 S:	Maintained
+F:	Documentation/devicetree/bindings/display/sitronix,st7567.yaml
 F:	Documentation/devicetree/bindings/display/sitronix,st7571.yaml
 F:	drivers/gpu/drm/sitronix/st7571-i2c.c
 
-- 
2.49.0


