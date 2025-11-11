Return-Path: <linux-kernel+bounces-894465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CF8BC4B004
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 02:52:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A4E63BB6A1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 01:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38CE630BF77;
	Tue, 11 Nov 2025 01:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pegatron-corp-partner-google-com.20230601.gappssmtp.com header.i=@pegatron-corp-partner-google-com.20230601.gappssmtp.com header.b="XanAVJYj"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D559130C63B
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 01:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762824911; cv=none; b=LROOP8PpSwlwQQwB0p8UXjRrqr7A86p8hlEIOcS/fv809QC7L3+sNcX9vav40bdDauEDHyeqyLa+aq4Gtg5ZEphzqPxNkpJJtIU5NhQbE3X8OZ7qSFrHJrn3+Fy2qNoJEwtPXe9p1S5QLf1WG/Y+jJbNwzgghn1vo4ox4QidqOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762824911; c=relaxed/simple;
	bh=EEpirpK/l6Pxsdp58Zy1SYZgMnffAi4qGVL80OHpxDk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=C2PGtRHMSXwvxVfIaeZ5VE1OLRbeOlmEJ5+aTtujvv4TqWBVilVFrrx8vsIb1dbsTvd7rfEZAVr+6OPn2lXaBS0XMfEhmeeGeV4gW2LvgaRH0OYaCa1A79C2e4dZrUUQsKX47k4Uk57p+HtEcInlG7qJOk+i6AkH1wViUBOh2aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pegatron.corp-partner.google.com; spf=pass smtp.mailfrom=pegatron.corp-partner.google.com; dkim=pass (2048-bit key) header.d=pegatron-corp-partner-google-com.20230601.gappssmtp.com header.i=@pegatron-corp-partner-google-com.20230601.gappssmtp.com header.b=XanAVJYj; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pegatron.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pegatron.corp-partner.google.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b98a619f020so3222973a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 17:35:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pegatron-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1762824906; x=1763429706; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dCRUjyzQWysqM14npqbWdyxPUdu80BrwtIvFA0r4EOU=;
        b=XanAVJYjW0gAdoRqJZEl7JyLoJ8O3xWmeDoZUS3vFWqAKbw5kBxjSelvaVWpCMozLR
         H6nZeGIb4Tl/EIBvn/uyvTjCqKcwStzarji+NRokwfcJKMEcjV/Fggbrf6TLsjMNerFE
         oPy/UoO3wfYQpw2JpagfJRqod9btzNR3C9UZ8rUVRk8/wo8ri4v3IcyOZew5EgPL+Lxj
         4Q9Bbpq2chFF/hhBy1b9480EUGYrgzFb7fKHBTtHXlN9+umLtnXZ46oWagvC/FhBOO82
         CUwoPAzpHR7xOJgXjrZ79RU+nyXivNRTFNz1tALpDBvWhC+QA5bv1PQVxhoUDSuYk3U5
         XjOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762824906; x=1763429706;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dCRUjyzQWysqM14npqbWdyxPUdu80BrwtIvFA0r4EOU=;
        b=MTzVwH2TsaiaCCFmnc1V1uhKpUtqzgUH1WaVRhM9nGOv98BPB8ewsIgs3DoXOKMNTd
         B1wNKUe1lVBUZlxpeB28xh2APLFpnrRphGTbkrB+eMYfDGFeyg+d3TVJsWgqjXgsCcSQ
         mrqKTsrmniFELXBRpEhQYecEhq4uRf9hbORFjYKr3ouOXOcQ31pEsB2UKUh7tzg8KwVg
         pabskg0a87fIFHJpODyDkPTo/hULQpHCsFskBfduYOm6NTrTjjiu1rquyl2Pd624TdKD
         sQXBCl2uAeNXH+t5W9qi7cF7COLhtG0HXLsugzA3pQbKHNwxMLl52nkVkLpOTfMZU5hB
         FgVg==
X-Gm-Message-State: AOJu0YzpFzSoAF7l1fBEeZVDxjj5up9vHCOWKAV+OMX4Bdy2dryBXgsL
	v6XH9g7ihFUUjyFhy54WhEq8IK4APb3eoJP6veqWcC4locCIs7+IoQkKRzeb6+CViw==
X-Gm-Gg: ASbGncsWotZhSGnHs5hToR4aa6O9NNbCtS8K1zhwhsT4ISX0XJNI1OTo1lk+q9561Fk
	iAyFTxxXzsNzUqwXPpXIzO5BFPJhVSJuuRIadhuehoEg3PNvD6C6PNeqgtJCJ6rSzSHGop0y5Z+
	rFGP1oOpiADtWbBH+BWyVVGFi9k4phc0nwQAtAMucKbVh8Jjw9Y99//5y+fLXW86XYnU/hMEIM6
	zDpLe8eBpp700C29vYqbwdDapImBuOIS9poGssr6QMo4arSG43la3eUfTnmdY5F3UzlvmrOZFUi
	LE1mQLZQdv0H9DiLIPnLLkQIMTJTdPmnH7uyDcWBbXNtdHrUq6fuNaeRTL4FLgLNcXs36OiqqJb
	WP10rkL+OzRdG1+MbRPbfZTCDgK18EnO1F7KI1Rwq+K7TgcK6oYGjf40ZuJNppv+983V/RW4Zuk
	PlQ4AKR0cYKQmi/qUws/0OApYCIfId6cxQtxU95lq1cIyByOx5s0Ph/WIrnrA9jr7nG6EmDpJPJ
	iHxX3c6uv2HL8MXhpO3XzBNTAMYHZVtKAZzQ7+8VP1vW2DIkLjDlfV9HyZbT3mQT4u36A==
X-Google-Smtp-Source: AGHT+IGRoXVLZ7agvfhSDaP/AeheoEMsIJIdYyiaZZNnoHcNgq2mN8gZOGSrD/OnhlDdhDdOfevBZQ==
X-Received: by 2002:a17:902:ec82:b0:295:4d62:61a9 with SMTP id d9443c01a7336-297e56aef0fmr135124385ad.38.1762824905979;
        Mon, 10 Nov 2025 17:35:05 -0800 (PST)
Received: from sw-TUF-Gaming-FX505GU-FX505GU.. (2001-b400-e2ac-65d6-0959-d540-843d-31d2.emome-ip6.hinet.net. [2001:b400:e2ac:65d6:959:d540:843d:31d2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651c740b5sm163666485ad.70.2025.11.10.17.35.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 17:35:05 -0800 (PST)
From: daniel_peng@pegatron.corp-partner.google.com
X-Google-Original-From: Daniel_Peng@pegatron.corp-partner.google.com
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	Daniel Peng <Daniel_Peng@pegatron.corp-partner.google.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	devicetree@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: HID: i2c-hid: elan: Introduce FocalTech FT8112
Date: Tue, 11 Nov 2025 09:34:57 +0800
Message-Id: <20251111093426.1.I76ee34ac45e1469dbeb11de0d1e47d794af7dc88@changeid>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Daniel Peng <Daniel_Peng@pegatron.corp-partner.google.com>

The FocalTech FT8112 touch screen chip same as Ilitek ili2901 controller
has a reset gpio. The difference is that they have different
post_gpio_reset_on_delay_ms.
FocalTech FT8112 also uses 3.3V power supply.

Signed-off-by: Daniel Peng <Daniel_Peng@pegatron.corp-partner.google.com>
---

 .../bindings/input/focaltech,ft8112.yaml      | 66 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 67 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/focaltech,ft8112.yaml

diff --git a/Documentation/devicetree/bindings/input/focaltech,ft8112.yaml b/Documentation/devicetree/bindings/input/focaltech,ft8112.yaml
new file mode 100644
index 000000000000..391825b24fcb
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/focaltech,ft8112.yaml
@@ -0,0 +1,66 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/focaltech,ft8112.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: FocalTech FT8112 touchscreen controller
+
+maintainers:
+  - Dmitry Torokhov <dmitry.torokhov@gmail.com>
+
+description:
+  Supports the FocalTech FT8112 touchscreen controller.
+  This touchscreen controller uses the i2c-hid protocol with a reset GPIO.
+
+allOf:
+  - $ref: /schemas/input/touchscreen/touchscreen.yaml#
+
+properties:
+  compatible:
+    enum:
+      - focaltech,ft8112
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  panel: true
+
+  reset-gpios:
+    maxItems: 1
+
+  vcc33-supply: true
+
+  vccio-supply: true
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - vcc33-supply
+
+additionalProperties: false
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
+      touchscreen@38 {
+        compatible = "focaltech,ft8112";
+        reg = <0x38>;
+
+        interrupt-parent = <&pio>;
+        interrupts = <15 IRQ_TYPE_LEVEL_LOW>>;
+
+        reset-gpios = <&pio 126 GPIO_ACTIVE_LOW>;
+        vcc33-supply = <&pp3300_tchscr_x>;
+      };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index ddecf1ef3bed..69f54515fe98 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12326,6 +12326,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git
 F:	Documentation/devicetree/bindings/input/
 F:	Documentation/devicetree/bindings/serio/
 F:	Documentation/input/
+F:	drivers/hid/
 F:	drivers/input/
 F:	include/dt-bindings/input/
 F:	include/linux/gameport.h
-- 
2.34.1


