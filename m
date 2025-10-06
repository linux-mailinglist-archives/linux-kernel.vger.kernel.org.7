Return-Path: <linux-kernel+bounces-843290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A8E01BBED97
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 19:49:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9157C4E9788
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 17:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE9EB28AAEE;
	Mon,  6 Oct 2025 17:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jQcuQxXz"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50FD922B8C5
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 17:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759772954; cv=none; b=fLCcVBpZv0+IokS7Gx+w6uZJzNn2P/bDQbWVy4/IIKWoFYN7OwEVI+2Q66sMf3XsJGgU6DuWX0pD4bc6c02BWbH2pxChOh51rMNaRK8gbJ/mTBq8UVgCwvD+UdCV5OElV8AdTcbshoiMMLAd+x48zNTKXHm+Cx+HZ48Obm7wq/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759772954; c=relaxed/simple;
	bh=9liKc4BbGdH2BqNfuyI7ywSHs4F/AVAdTe90sltBfv0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DjGbNxm2rLtU0vWJ1gI1Tfv2tsMxu1zXdTY9gK2ZQUQHOyNcNW24lOfXrx9K7nTaymMtgC+thc0jymA4J/tb364XtJO34ysvhzzNd9YzmYazOmTtPqT4tipSraxLERzncJGtWHIvVJfLx4BZf8Gt1tMeZMfwhNS+kxd5wBQRo0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jQcuQxXz; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-46b303f755aso40711695e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 10:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759772950; x=1760377750; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=duPio0RPtDjdOCnFYeiJ23Ow5gw9QiPbk3qi6TQ0F40=;
        b=jQcuQxXzGCPRtdSuCjDLDKDUZSKgP1MlzFfXduMcGcXnxqofT2WnAvxkV9k46s7woJ
         vPHBAAmCNTi7RrnpbryDuCdd2Qi0SodxT48vmZWXkLY6POMYAE1OKn0zzG6S3IzUES/b
         brMQid5PjwIdmKlrLJAxWZ/VTxdHZcAgoE+gZZ643mskMyC5kDIWod6Ax6zmPUCgJn5P
         WCk8wadYHPkRP7fceqrd+y42UG9Mfv2qNYvOlEIJI1i2VTPkYqyOB3uCdFhyOLySBFK4
         se3BnbR6OzeURJF6EHWA4BSKewSs+usBi1h+Z4iZD6QcFsUmW1lhaxUn7CaoFK0CMZUS
         TuOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759772950; x=1760377750;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=duPio0RPtDjdOCnFYeiJ23Ow5gw9QiPbk3qi6TQ0F40=;
        b=cSHMFSyjjUmKA3aLxYHgOLOLipPNH8mYBbc3d/Qjo50Vj9r9Wy6qtqa3+hRd6AD/HX
         XxWmm8fwrl5gQ2+5qQmwuUYfgdbkMf6RNcIUnIg/U13t3nocGp9dv4HRz4p7CS/oSKjP
         XT/8V7QH32O0YXsu/uYju6/CmOW0VGvOfA8y4NtbxiBQhIY6yTph3ANSIKkw0ggViijX
         jc6udwdkcxoNXYNIWmF6uNr1/h+VopV7vVa5JlJdM2catPsmC1gBbOeR/niGbamHs7Bn
         BJfOeDPNAPZQIlOHWhk5mUe2zNYEYu4eqGpJn81MpNm8hZVHFx/vdH1EEz23j0GtC1rb
         mTfw==
X-Gm-Message-State: AOJu0Yz5iFCqYxNIbJ8XlKz4PLrbXkZXtGLXqFT3ZMkI+Y+kxuy5hG1O
	rqA9YarIuNgA8y8sectqLLjBjBBPx07ULrAwHCed++e/tnXpC52D3vHm
X-Gm-Gg: ASbGncteyEtf/HZOW7IPe+h5Jb6cbF8t640KiCfSarEaX/2IKgdDzHoEdBUi+5OPpxf
	bc9Ro+IbTV7dlhqT6QOyPb9goFT+85a089S/U51nZ2RVoV1zTVIgGM8fkVEpcIS9qJc9nl4htVe
	TA8Dj9BbgDmoVWuga/iud+JAQVrH79HEdhtjB8W7mYPKjKQnAauMfmCwoqy+hQOrwFWn/E268Uq
	DKsJd/AArjv+IR0IeHE8JQ4OHw5okoOJbyXw6A0yWf0z2OK3eRLElcpoMZdIk1UR0hK6Epid7iN
	68iXwDjt5epSa9/48Gl5CIrTx6j4tmdXtomuO46TjNyc1dsl84EHOKQ7eDQ4Mf99FPd/G6p3hgP
	6hEnSuLg6F7oeAh7m9lPERCQ4I29L2SQ9ldCeUnHPmCYtu5N9+dMTXZBuODClB6MYM5RbWvDkay
	u4ZkWeVq37bBQQqMjp+W3V89gBYBJuz/KscA==
X-Google-Smtp-Source: AGHT+IHkSj9MNsUJw9ZpyQogvi/IDNzd+bwC8lC7GyQvo3xrlRnEdWW+dT6LIGRmyJoozLw5MWRCWw==
X-Received: by 2002:a05:600c:a14:b0:46e:3403:63df with SMTP id 5b1f17b1804b1-46e711043a5mr98333235e9.8.1759772950265;
        Mon, 06 Oct 2025 10:49:10 -0700 (PDT)
Received: from ipedrosa-thinkpadx1carbongen12.rmtes.csb ([5.225.139.156])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e723431f5sm165583805e9.2.2025.10.06.10.49.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 10:49:09 -0700 (PDT)
From: Iker Pedrosa <ikerpedrosam@gmail.com>
Date: Mon, 06 Oct 2025 19:48:53 +0200
Subject: [PATCH v3 1/3] dt-bindings: display: sitronix,st7920: Add DT
 schema
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251006-st7920-v3-1-4f89d656fa03@gmail.com>
References: <20251006-st7920-v3-0-4f89d656fa03@gmail.com>
In-Reply-To: <20251006-st7920-v3-0-4f89d656fa03@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Javier Martinez Canillas <javierm@redhat.com>, 
 Iker Pedrosa <ikerpedrosam@gmail.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org
X-Mailer: b4 0.14.2

Add binding for Sitronix ST7920 display.

Signed-off-by: Iker Pedrosa <ikerpedrosam@gmail.com>
---
 .../bindings/display/sitronix,st7920.yaml          | 50 ++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/sitronix,st7920.yaml b/Documentation/devicetree/bindings/display/sitronix,st7920.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..b4c16825f254f1b8345a2532271042350e3a5e26
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/sitronix,st7920.yaml
@@ -0,0 +1,50 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/sitronix,st7920.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sitronix ST7920 LCD Display Controllers
+
+maintainers:
+  - Iker Pedrosa <ikerpedrosam@gmail.com>
+
+description:
+  The Sitronix ST7920 is a controller for monochrome dot-matrix graphical LCDs,
+  most commonly used for 128x64 pixel displays.
+
+properties:
+  compatible:
+    const: sitronix,st7920
+
+  reg:
+    maxItems: 1
+
+  spi-max-frequency:
+    maximum: 600000
+
+required:
+  - compatible
+  - reg
+  - spi-max-frequency
+
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        display@0 {
+            compatible = "sitronix,st7920";
+            reg = <0>;
+            spi-max-frequency = <600000>;
+            spi-cs-high;
+        };
+    };

-- 
2.51.0


