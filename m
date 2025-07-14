Return-Path: <linux-kernel+bounces-729832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BB2BB03C28
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 12:45:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5028A189C5C7
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 10:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 951692472A8;
	Mon, 14 Jul 2025 10:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N3juzJ8w"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6093E24728B
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 10:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752489891; cv=none; b=MmSQNQw/OTbuuROp5BEZvmEir4QQswOjUFAarOSS2b61Nnqz6sbGc3lx1h+hTFKADn+8Gr63HEX6dB/CqRBebRI2t9iHSfStupKEIl1qPJjyBuqDd0+KS5OS5ktbbdUiQJl5iQBWNZk48FpObgiWOW79vFD7Z9OfqRbKG4xZKjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752489891; c=relaxed/simple;
	bh=2WLJKOVAuaJt4QnmoXL1k44Atj4Pe1QbpaUPyStODjM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dzhI4Xut+b7aToOmpS+SVKicWvbVnLoTx1DxHerobY1gG95pPVEAZlFd4/CizxI4GlwpK7Gf1FAB34jewElUE3fWioPZYrsDkUdVqp/vm1OgZO/nCOuWmH84a9wEZbkmv6Ih8eMDXXEuXt9bnvy+yYnUuhjY234lxu2BE+b8GB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N3juzJ8w; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752489889;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UXL9y7xBlAhc4AXFCXGCZMpy7EHZFtBhXWeACly5wqo=;
	b=N3juzJ8wmQIidWod65p7pIvgM5xULcO86BO+GP7h+x+Ylk3AxZBC58gEM0sST/7idc88np
	dpnzWWNYzPX1hsv7pG379LP9r9eZA0X0eMlawix7/ytXy7cBM+KcyGNxH6QD64HLIuoYx7
	xubAlUZ4jyVrFq4ya2UAo0kw+gc/MfY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-372-0_TLK5nLPLiIwvcTLeQ-Zw-1; Mon, 14 Jul 2025 06:44:48 -0400
X-MC-Unique: 0_TLK5nLPLiIwvcTLeQ-Zw-1
X-Mimecast-MFC-AGG-ID: 0_TLK5nLPLiIwvcTLeQ-Zw_1752489887
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3af3c860ed7so1830053f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 03:44:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752489886; x=1753094686;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UXL9y7xBlAhc4AXFCXGCZMpy7EHZFtBhXWeACly5wqo=;
        b=glQDhC0aCN45Iav2rmjBx2K+cjrSW+VzaGm+/qI6bCJZft1OQKnJ92KXjWl4DynzuP
         9XlJov2iPomcET9cmwEh6OBUx6ikSNZCBBILx0dtUrW8zM+h08zJXTlA8qnRY+TPK5oH
         9+1ZMY3cxYQEvK/f8s3Zw+J/9DjgmlnLLcjNRy8iq20bvVs0ulrKDSTWMak6S+Dcr44+
         WgbCxRNrcgIxKcH4eePh6JBqIXRRdnK8ss3Kkb6FdI//eu6+MLsnrfnJIGOWbodSLQYH
         UupbuFs3L2CfoOHV6UU8kJB3x31DR2tw98zOacJSNLZSY47dzIViGrvHTghY6mKL+XTH
         MCAA==
X-Gm-Message-State: AOJu0YzCFG1QfjdY0JA3HjdhW7VY9XhxQQrul1i5TI+SR3Jm5IYnC1B6
	VYp8B+S1rd3mA/PPW26WlpIvMUqOL85ue1BIBr3bqDBJqa3pz0uHwpArxxeJsEUMOAfhq/on47L
	RQn+YF6/IaNlRX39snJr7CNldpr39lWArtMzae6zQ8QLo67RT8xWRNpTWTspKju52xxPuolvl7r
	BxyoQa+I3Hi1txSBo/Yc1XPFw3j907A/Q+Ce1qvv7FuqG8Mf2G
X-Gm-Gg: ASbGncvNFYb8ctT9sIlHM+qiu1YqkQFN6fyHXjyn/CS3Idwkt1XpXZm6UDe4JIzw/FN
	NRCIs6Bryj6B9tesJ4LSdcrZldN/Q0knzmo0r8IQHQAYoiLN4YebLnbJ2NgtB9aX3fXJ3WCrjbs
	LQ5R8dsO6sbXFlgbQlSAcRL/tTd/ZaehXZ4dKT4z9PtJltnhdCVCbJ07tmCsPFVhy8Lx51G+bX+
	LUqwqS2yVeIL3G43I4BueRpnf1TOzIlziNAzSqHUYSHVSpmGCJJaJAnFNG2Asq9uYzKhGnVUhbh
	Ti3M6HM/vJVJkESRpcVf4onu8d/IGYY+
X-Received: by 2002:a5d:64ec:0:b0:3a4:f6ba:51da with SMTP id ffacd0b85a97d-3b5f2dc2868mr9964335f8f.15.1752489886452;
        Mon, 14 Jul 2025 03:44:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHgeEBunGgrYdyyx1Q7dxCaPxvUeX/pPehKrFaYxcQS3TFsh9G8Baoie8ftqyWxl1dIxeb+qQ==
X-Received: by 2002:a5d:64ec:0:b0:3a4:f6ba:51da with SMTP id ffacd0b85a97d-3b5f2dc2868mr9964292f8f.15.1752489885942;
        Mon, 14 Jul 2025 03:44:45 -0700 (PDT)
Received: from localhost ([89.128.88.54])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8bd1792sm12294623f8f.13.2025.07.14.03.44.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 03:44:44 -0700 (PDT)
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
Subject: [PATCH v2 4/5] dt-bindings: display: Add Sitronix ST7567 LCD Controller
Date: Mon, 14 Jul 2025 12:44:03 +0200
Message-ID: <20250714104421.323753-5-javierm@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250714104421.323753-1-javierm@redhat.com>
References: <20250714104421.323753-1-javierm@redhat.com>
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


