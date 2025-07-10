Return-Path: <linux-kernel+bounces-725442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2AD5AFFF31
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 12:26:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 483885A49D6
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 10:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EEBE2E0937;
	Thu, 10 Jul 2025 10:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SlIVAjZ0"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394622D8DDC
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 10:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752143154; cv=none; b=pwvvU+eOM0TMR7/Z3dMuaaGGLWmLiDvyGqRxTX6Dz7RNJPs+HmeBdzvO7nvrivW31dFVHebytzxUDBfhAt4krxGISC0ljERslvniLp9raN3ICWK+6kox1qKEy9trlDfsLc35i8uTcjFYlc36R84INdTPn4ExQimNgbjHwu2nKXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752143154; c=relaxed/simple;
	bh=1yxZXcnFA/Eh5Im1254+XIiXYLA1R1qqDv3celxIab8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RsIs5GX2aRBBiGgrqmUavSlTL9lUjblDhCiOtm3oc3xOWKIqPR6kn+1kJ6fyg6CgrnDIt0xrksEKsDbnqS5qT/8y5z/6cKamN3y2TgknPXqR1zj01Rwiqaqy1UwkD+9ngaaibkC7H7b+68HvKFUMlwVwKPu27KnIl0NTbqnvuoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SlIVAjZ0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752143152;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nUOjdgW24CAx0aqD+3zmRz0D1nbY1TritNaHwReu0ak=;
	b=SlIVAjZ0lcIh7x61lhytIP7qg81ClPPRB0o7AerUQh9ea/N+5afiC1+YVEEF9EAndjoZVf
	iDPFkhTmxiQ7xnx3UKT/HnZ7bHeU/7nlISB17+ZksCxdOlR53blz3bji+MF/do/q1QTTN0
	UFfsqz0etQhQrVsGDR4LNrHQ8hrEZIE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-107-ZeNkCnhEMpeT3DNXOVf1Qw-1; Thu, 10 Jul 2025 06:25:51 -0400
X-MC-Unique: ZeNkCnhEMpeT3DNXOVf1Qw-1
X-Mimecast-MFC-AGG-ID: ZeNkCnhEMpeT3DNXOVf1Qw_1752143150
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4538f375e86so6184785e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 03:25:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752143149; x=1752747949;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nUOjdgW24CAx0aqD+3zmRz0D1nbY1TritNaHwReu0ak=;
        b=fzDEG+tDr//7z1jUAWzm1Kire8gaxie3kKJQRojnfQYsVnrqYsxmwf8f6Bp3xpw53n
         rra4cINrb7u1g9JlTavfyPhvvE1AzQ0GWOs5GHkejTkR1p6PSe58z0r1J9Wsm/bz8iYE
         GErcEkrkJFHQNlJBcu3sMcDT6Yu+Az/3MbjVcFh8Q04NdHYv4YATZRS7nFQz3KwDrjPn
         HZ3yxangMVYT3/2Y23/8Y37VDit0BAKBCOaifCbtSl9D9KKgEAkwUmIAmCJFlo2EOZS0
         qaPayjACwVv3n15izw9b8/cN0yb54P6C3UwBZgr8m084nlLwPuaZusyK8wFLvdlcEPN6
         HP0A==
X-Gm-Message-State: AOJu0YxjJXKK/q4gYVdGhbOnpuGKzxSGCLevr9+IOZyVgW0ip5ysBlFs
	lcOAeV8bN09Q61L7ApkTTfzqJrZK8b+duIPI8RB5dYb1DRyiBg24OB9AyjuXigsNZapJ2V7SDlR
	TMI/K916FAWcdu0ujWD99LfKHFNcvkwoxST+XmwZYOT/SrnCc0Sw5LaIAt86+yOlx8fXjnDnkEx
	TizD1KKMYqrKQ7mGSkyaKYsY1m+IRsSZnLPiRGhqOnpiRooT/C
X-Gm-Gg: ASbGncvXn5vXmzB+eZCUNMEyOii5n32fkMjv4xTxLIuPmEDC93ITN3pKUtDSz2dTMxG
	sB0Mqiyogzv33N0D5TtWDvwk06pJna75NHFp/pv4am1kQ6QAkl+bsxQljgG1xlD6lXe/oFqkNrg
	MzUkDzOX3uKhzRrxNyXysOpmJ/lMzV0/bi5IDzbjtPwpmHlQ0SZPUVH0jAkyDIvX2iXlKSq+R6c
	gwoSi9gZ0bW7W0t8lsfxRNIcxILr7nMqb1yUFMU+jw8Zj83B4mND5bNCXrL1X8jUeMQZBTzFcK4
	xoYjuP0TkjOnsx4TX3xvcTsogH+M03fiey9kvmQlcAmkarc=
X-Received: by 2002:a05:600c:4f11:b0:450:cff7:62f9 with SMTP id 5b1f17b1804b1-454d53a0109mr54446195e9.22.1752143149162;
        Thu, 10 Jul 2025 03:25:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGe5pDfF1QGLabNBfFC8xpTYdo6m2Xcdy7HSICzHa9sm5ah3PthWEt+IQ0sKkzkTeFviyoUlg==
X-Received: by 2002:a05:600c:4f11:b0:450:cff7:62f9 with SMTP id 5b1f17b1804b1-454d53a0109mr54445795e9.22.1752143148641;
        Thu, 10 Jul 2025 03:25:48 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e0d70csm1504884f8f.62.2025.07.10.03.25.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 03:25:48 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: ipedrosa@redhat.com,
	Javier Martinez Canillas <javierm@redhat.com>,
	Conor Dooley <conor+dt@kernel.org>,
	David Airlie <airlied@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Marcus Folkesson <marcus.folkesson@gmail.com>,
	Maxime Ripard <mripard@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Simona Vetter <simona@ffwll.ch>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	devicetree@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH 1/3] dt-bindings: display: Add Sitronix ST7567 LCD Controller
Date: Thu, 10 Jul 2025 12:24:33 +0200
Message-ID: <20250710102453.101078-2-javierm@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250710102453.101078-1-javierm@redhat.com>
References: <20250710102453.101078-1-javierm@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sitronix ST7567 is a monochrome Dot Matrix LCD Controller.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

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


