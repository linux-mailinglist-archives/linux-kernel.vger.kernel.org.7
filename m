Return-Path: <linux-kernel+bounces-778834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B37C9B2EBC9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 05:15:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32D4A1C87E4D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 03:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E06B2D877F;
	Thu, 21 Aug 2025 03:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="amfP20CX"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F64299ABD
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 03:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755746129; cv=none; b=lNZDYizVjSSvHjPwe8It8sI/fjf3juCnznJf4Zchz/FmmPMZhqbEbWvZg+Wu3+4G+o1E3U3dpKVlh1ASioCNcxeUvFAQXfUQnAYMin/uERVFP5m8viOZYLUu3uMJrLAYbRzE5kVP+JGGL4lJscJ3cEUh1+nlbZUpb2QLpxBL5/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755746129; c=relaxed/simple;
	bh=xK/uY5dPDT/WYt2ovB3Su03oSdypjzmDFfJL7Y6Aluo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ejyns+5M+JpOGOxOG4ByWA2nwNdxwtC9t1gXZEH5w3ep6p+1VO914541DOEFbla4tuVhZuSLYAHtNXeNp4Dk/AJ2gfi9Yglc9z0orDOacJOFXTQNHar1hCetmesPqCv3orSYEplDl/u/pOKCt8lFzHtAkYQLV5uGOAJK2IvzBmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=amfP20CX; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2449978aceaso3656825ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 20:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1755746127; x=1756350927; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CtqV3HNShNm2ULsU/XG89WUNwV7hWFWih/MmNNnjuJk=;
        b=amfP20CX9yzLrJsRK0B+oGG7RJOUgxJ4KbTwjq3i1U/V4Qh3CmHkE1E04hvCglp4lQ
         0kqM4aA2PFDz10bt+HBm+nTtc9zYhrCf/QWCK3DLHdqtP6CU38MDRvGEjdrYNDC3Md1s
         0cC282Y4lBPsuO5KaMvmfwGBWkw7vA8tJax7fYVpL1jK/RY03K5zfkDWBg4onXurSf7A
         GJ+Rpq7395O8fooXsYGf0S6Jp4VcamZDK33GZRbh51B8hSTWBxgUV8vJFO6Hm0O0udLn
         uSbwisP69hCNU8x1VQWfToV9qhHgfAwfbGwPQrHYxRs8GJh3Qg6EAnPtHISHLPaMzXfj
         OQLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755746127; x=1756350927;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CtqV3HNShNm2ULsU/XG89WUNwV7hWFWih/MmNNnjuJk=;
        b=lEOePgJOe0UqavpTqzyNk6E2ir+AMTiK8SA+ubiFF8Lw6aYgQqnadgoDG1iMYFETlD
         4A9rWHXnBvFXMjI9WCr0iZPHu1XqPZh3mfyBFee5DzKRZhtRyve8MIYYEtd0st/D5lh6
         z6tTLY4kfuveGMN28ZRWkSYpZXHliSWS2qIi9HGidZzkflrtSLwJBKoIaaNmfCWGzVx7
         H1Glaw6DKunbAh42da+J2niZkigAie+IWp6wSu5+ADNTObtAbkH7+38ECGanX+oX3lsF
         t6AXToMxmETvfw5AsvMOR/nY6UMLOY7gF+WwdjO/DaHjfYUu4X60/1gP24fPqgsvRCfS
         2chA==
X-Forwarded-Encrypted: i=1; AJvYcCWp/s6wxR/K3kKJCkQ5yrFEc0DN1ZD/e/MD+E0HLCugi5cdtbwNp/UxFomXtiHPrFolGTByX+7QrouSMO0=@vger.kernel.org
X-Gm-Message-State: AOJu0YypRD5/H8TIp0dU02e/RVo4G2yNojtRpJParOEbObyQvj2vylG+
	2DZ3tZdV4DZG1VKpPnjHPs1U1sw4uoHveekkaQXOzuWiEIFjCo3b0Cihm7FVt0DBX+0=
X-Gm-Gg: ASbGnctRgzfpHkFbdXXZCBIrXVOYnGmGaPD3+OnlQoTAB/ZQGZGZ02ATGCb72PFSwOA
	mNUR84J2Xg0A+SfDih0idP552X7Xls0vGaaqGHnN4ekN05k1MtZhn+K2Ei2QCxoS0kcn7m2IHRG
	4Kwe0c9jNUtPNjlnnDOXq58QKLC4nCl6hsNBd6tEYnDmQcLzb+xL1O52L7+I9ylpvsu9mBuu6qt
	GnKdh8QgOIjm4u3kzzAp0/ZMoI8k0PZiBx/QJh26Rn1FccEaZ/wQG1V3xUcjJbP2uGZr8XtnC+W
	J5HaKrf4ksTMUbkrwEeo3q7M3U1REfVy3hD8cZDX9F6QoPQ0fpihoxvwvpLW4OanFHUBnKgjm05
	gBrKAL3/n5YfR92G/f7JN8d8OTTkjgHj5Qaco7tIxNlXcfhDIIUCHYtOL5exVQpcwOC1rHQ==
X-Google-Smtp-Source: AGHT+IF+UOh47xwCxLPPcHRa7zc66TOfiikkAYATLHWVDpLtA6g22wxOpRgfhU+bncrwFyy4s4nCTQ==
X-Received: by 2002:a17:903:124c:b0:224:10a2:cae7 with SMTP id d9443c01a7336-245fedcad87mr13708355ad.40.1755746126670;
        Wed, 20 Aug 2025 20:15:26 -0700 (PDT)
Received: from dgp100339560-01.huaqin.com ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245ed51b3d3sm40285415ad.147.2025.08.20.20.15.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 20:15:26 -0700 (PDT)
From: Langyan Ye <yelangyan@huaqin.corp-partner.google.com>
To: dmitry.torokhov@gmail.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	jikos@kernel.org,
	bentiss@kernel.org
Cc: dianders@chromium.org,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Langyan Ye <yelangyan@huaqin.corp-partner.google.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v2 1/2] dt-bindings: input: Add Parade TC3408 touchscreen controller
Date: Thu, 21 Aug 2025 11:15:13 +0800
Message-Id: <20250821031514.49497-2-yelangyan@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250821031514.49497-1-yelangyan@huaqin.corp-partner.google.com>
References: <20250821031514.49497-1-yelangyan@huaqin.corp-partner.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The tc3408 touch screen chip same as Elan eKTH6915 controller
has a reset gpio. The difference is that they have different
post_power_delay_ms.

Signed-off-by: Langyan Ye <yelangyan@huaqin.corp-partner.google.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../bindings/input/parade,tc3408.yaml         | 68 +++++++++++++++++++
 1 file changed, 68 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/parade,tc3408.yaml

diff --git a/Documentation/devicetree/bindings/input/parade,tc3408.yaml b/Documentation/devicetree/bindings/input/parade,tc3408.yaml
new file mode 100644
index 000000000000..30ffefb96c68
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/parade,tc3408.yaml
@@ -0,0 +1,68 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/parade,tc3408.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Parade TC3408 touchscreen controller
+
+maintainers:
+  - Langyan Ye <yelangyan@huaqin.corp-partner.google.com>
+
+description: |
+  Parade TC3408 is a touchscreen controller supporting the I2C-HID protocol.
+  It requires a reset GPIO and two power supplies (3.3V and 1.8V).
+
+allOf:
+  - $ref: /schemas/input/touchscreen/touchscreen.yaml#
+
+properties:
+  compatible:
+    const: parade,tc3408
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  reset-gpios:
+    maxItems: 1
+
+  vcc33-supply:
+    description: The 3.3V supply to the touchscreen.
+
+  vccio-supply:
+    description: The 1.8V supply to the touchscreen.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - reset-gpios
+  - vcc33-supply
+  - vccio-supply
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      touchscreen: touchscreen@24 {
+        compatible = "parade,tc3408";
+        reg = <0x24>;
+
+        interrupt-parent = <&pio>;
+        interrupts = <15 IRQ_TYPE_LEVEL_LOW>;
+
+        reset-gpios = <&pio 126 GPIO_ACTIVE_LOW>;
+        vcc33-supply = <&pp3300_tchscr_x>;
+        vccio-supply = <&pp1800_tchscr_report_disable>;
+      };
+    };
-- 
2.34.1


