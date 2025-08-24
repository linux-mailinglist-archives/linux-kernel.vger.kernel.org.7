Return-Path: <linux-kernel+bounces-783592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21B95B32F68
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 13:25:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 791F54443AC
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 11:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 967792D6E75;
	Sun, 24 Aug 2025 11:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KdDmJn/E"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09EC32D661D;
	Sun, 24 Aug 2025 11:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756034685; cv=none; b=uZE8X9MnyohCc9PwuGGn3nAB59B4rJwGXuUpyhxpZ9sfsX/twnssKSCcf7MT68fnKzYCp9CeqMtJy7/1zf+dTSjFJqughXqEywo+YuHzr7LdCeytYDEHMhl6ndN+RaaS+7tO4i9MrQ4Umq8tGOPrMJt20j3lS6edHboLUP8IwuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756034685; c=relaxed/simple;
	bh=JzaYmdJJ9+zRuZnV+SkJjx8L9Hx4k/y/E/aeHTXWLP4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nsmL+JR7j4hQtm7n0ofVAv+OJ2a3D+sBQbN5Ap6SNpoH6jKc3yxdvBkWXDpjlmpMc+WUXKaqdq5QUNq+3pwjLkRFE1grCwgSl4g2yDbBxQsduuxKBj1BJM1CjxxW8qUbyUFmYSD5ThAW27jzKAKQplJIOlgAhSJccoDp3z0/yn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KdDmJn/E; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-45a1b065d59so18228175e9.1;
        Sun, 24 Aug 2025 04:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756034681; x=1756639481; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EHPA5tjVk2zdLIqcXLPSn/Y4+EPXKCEA2EPipaqi8gc=;
        b=KdDmJn/E0rB1qiWm6asLitym50zaFdf/hOa/UQCB4IieLs9D9Kedw7mfzC7Ok1uDS/
         +AXUgLU7GcMl7jmk3rcNUIxEBmfFvRoda5gqXQnS7IhAyFI+CHfXOjZPez6CQepS9XZ3
         jqaKIscS8V87teTCg+hTHrvxsf5N2pZGc1bt3JmdWHL2WiH6uTcr9/ymD1ludHeZbG/A
         mSOdb0ZQlDJ1AxTUl2+yU8MqWsd+Qy87qjLpHh1DI+hz1CVOA2vHmiDkmKUrYZj+PcVY
         QmoyaiLzlCiDSfR3Ab6rsrqbPY5Cp0rLQNJCdY7dExCXrEgH+/sGR5LY+CdXywA3ydXU
         FzBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756034681; x=1756639481;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EHPA5tjVk2zdLIqcXLPSn/Y4+EPXKCEA2EPipaqi8gc=;
        b=YYm7iJqwpiVZ68keX2h5LYOSMvYT3nWA9ZopIKWNzVUafhN+tAI1f4ON1jEtIRFd9m
         PnCTOqEWI/ez2ij3e8r7zrYyLgXegcfRJhcmaJfArvi0jV4n82hwGJ+3/SuiMnjw0NO/
         ApA/BgCW8aujHoKs3FC3IrmxtpADYeZLw5RoxntDNgnhaHOFfdRF7zauqN/DKp6WBY/z
         zdiRU/grsySM/TtNTSugOd44g87iSo89/DTjIh9ZkLPMAMuJ+Hzk6U8ZGWlpLS52al7W
         LbPeOW38LH7BMgm+gC+MX7IWU6vN1nBtM9zi2k2p4Gkb6r7yISwnM7KdNt/Pkfgzjqre
         3aog==
X-Forwarded-Encrypted: i=1; AJvYcCVlrOnnkxpSNzTA4ggmxjnD78ppBZbTCsOL1ToSVmbcZQOviErOHn3lFLb2jakCdDjrQaIduPciiQNYorUZ@vger.kernel.org, AJvYcCVsEH29iI1o322R2pAJbMgYy1TmlL/dHPqSIYtzW/77hPhQ69kUG5AMPD01w4S8fnOtOCkVFY5hu/Cb@vger.kernel.org, AJvYcCWekIWOIn4NW9jARsw4qGvhOIrqFFMdtiHXWVclWBIugiDUIpfBG76URJTV5SvTTC5Mmx2AnmNi4MhN@vger.kernel.org
X-Gm-Message-State: AOJu0YxQjLMpf8VBSbVgA+kQ3O+PbjAjtOVHMs9EInebzCTVRUVTM4pW
	6JCvxlPfyEJMLnOmG4Ik4TgU00GWL0wqgiEI9mIjDGXs3GCrhNX2AIc=
X-Gm-Gg: ASbGncu5TEX+ck2h5dAXL5Q+tvSUpmYhbyU/T/BSq7Kg6JFBk0OWena6pNJEoxk0min
	OmSFDH4LNZipR5PVEyYVbej6bAPS9EJwmX67dXiI7GiJbPxRq5aYcsFSG4Ks4FLgVvKwpOP3cw8
	Xs0DbkRcWlXEnLAqhRdIqAnJsKFVtfOthV5nZydRzRRw7vF/LxbQQiTVVHzR3FPb8+MdP8vSita
	trWTAziFJj+DQLC9EXeCfOZCUZQd1vgQNOkLHW80NKIQtClZFX2mAl+My751zLz0q5IXPDN9tCc
	IMCbFSto/tuvrpfZGyvoqH0lxrnV/6X4FPEiUq2EPLqoOA/ezRfIvz/PLWb51+AuNZsw8G+thME
	qqWW4AOgj+FN1luWjnoDG83ip3bcVAZwcVIklYx4QxA==
X-Google-Smtp-Source: AGHT+IF7S7DRzUMwx3T6jIfKvU8dLj6BHsCMLybaYpgdQtV9HXeN/7R3NV96ZFiFl5Ucrl5iQJmwnQ==
X-Received: by 2002:a05:600c:4f41:b0:456:fc1:c26d with SMTP id 5b1f17b1804b1-45b5179557fmr64273595e9.2.1756034681241;
        Sun, 24 Aug 2025 04:24:41 -0700 (PDT)
Received: from localhost.localdomain ([37.169.16.203])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b57487c55sm67879755e9.16.2025.08.24.04.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Aug 2025 04:24:40 -0700 (PDT)
From: Jihed Chaibi <jihed.chaibi.dev@gmail.com>
To: krzk+dt@kernel.org
Cc: gregkh@linuxfoundation.org,
	robh@kernel.org,
	conor+dt@kernel.org,
	peter.ujfalusi@gmail.com,
	devicetree@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	shuah@kernel.org,
	jihed.chaibi.dev@gmail.com
Subject: [PATCH v7 2/2] usb: dt-bindings: ti,twl6030-usb: convert to DT schema
Date: Sun, 24 Aug 2025 13:23:38 +0200
Message-ID: <20250824112338.64953-3-jihed.chaibi.dev@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250824112338.64953-1-jihed.chaibi.dev@gmail.com>
References: <20250824112338.64953-1-jihed.chaibi.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the legacy TXT binding for the TWL6030 USB module
to the modern YAML DT schema format. This adds formal validation
and improves documentation using a conditional schema.

The legacy twlxxxx-usb.txt file is no longer needed and is removed.

Signed-off-by: Jihed Chaibi <jihed.chaibi.dev@gmail.com>

---
Changes in v7:
 - At this point the obsolete .txt binding file only contains
   twl6030 related information, therefore it is deleted.

Changes in v6:
 - Reworked 'interrupts' property to use a list of items with
   descriptions per reviewer feedback.

Changes in v5:
 - Split combined twlxxxx-usb binding into a dedicated file for
   twl6030-usb per maintainer feedback.
 - Used more accurate header for interrupt macros.
 - Improved formatting in the examples.
 - This patch also removes the old .txt file.

Changes in v4:
 - This patch is split from larger series per maintainer feedback.
 - v3 link:
    https://lore.kernel.org/all/20250816021523.167049-1-jihed.chaibi.dev@gmail.com/
 - Removed i2c node as it wasn't required by the old binding file.
 - Updated node names to 'usb' and 'usb-phy' in the examples to follow
   generic naming conventions per the Device Tree specification.
 - Replaced raw interrupt values with standard defines for clarity.
 - Improved formatting in the examples for clarity and consistency.

Changes in v3:
 - No changes.

Changes in v2:
 - Added '#phy-cells' property to support PHY framework integration.
---
 .../bindings/usb/ti,twl6030-usb.yaml          | 48 +++++++++++++++++++
 .../devicetree/bindings/usb/twlxxxx-usb.txt   | 21 --------
 2 files changed, 48 insertions(+), 21 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/usb/ti,twl6030-usb.yaml
 delete mode 100644 Documentation/devicetree/bindings/usb/twlxxxx-usb.txt

diff --git a/Documentation/devicetree/bindings/usb/ti,twl6030-usb.yaml b/Documentation/devicetree/bindings/usb/ti,twl6030-usb.yaml
new file mode 100644
index 000000000000..33b6da50660a
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/ti,twl6030-usb.yaml
@@ -0,0 +1,48 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/usb/ti,twl6030-usb.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments TWL6030 USB Comparator
+
+maintainers:
+  - Peter Ujfalusi <peter.ujfalusi@gmail.com>
+
+description:
+  Bindings for the USB comparator module found within the TWL6030
+  family of companion chips.
+
+properties:
+  compatible:
+    const: ti,twl6030-usb
+
+  interrupts:
+    items:
+      - description: OTG for ID events in host mode
+      - description: USB device mode for VBUS events
+
+  usb-supply:
+    description:
+      Phandle to the VUSB regulator. For TWL6030, this should be the 'vusb'
+      regulator. For TWL6032 subclass, it should be the 'ldousb' regulator.
+
+required:
+  - compatible
+  - interrupts
+  - usb-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    usb {
+        compatible = "ti,twl6030-usb";
+
+        interrupts = <4 IRQ_TYPE_LEVEL_HIGH>, <10 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-parent = <&gic>;
+
+        usb-supply = <&reg_vusb>;
+    };
diff --git a/Documentation/devicetree/bindings/usb/twlxxxx-usb.txt b/Documentation/devicetree/bindings/usb/twlxxxx-usb.txt
deleted file mode 100644
index 7194c9504b28..000000000000
--- a/Documentation/devicetree/bindings/usb/twlxxxx-usb.txt
+++ /dev/null
@@ -1,21 +0,0 @@
-USB COMPARATOR OF TWL CHIPS
-
-TWL6030 USB COMPARATOR
- - compatible : Should be "ti,twl6030-usb"
- - interrupts : Two interrupt numbers to the cpu should be specified. First
-   interrupt number is the otg interrupt number that raises ID interrupts when
-   the controller has to act as host and the second interrupt number is the
-   usb interrupt number that raises VBUS interrupts when the controller has to
-   act as device
- - usb-supply : phandle to the regulator device tree node. It should be vusb
-   if it is twl6030 or ldousb if it is twl6032 subclass.
-
-twl6030-usb {
-	compatible = "ti,twl6030-usb";
-	interrupts = < 4 10 >;
-};
-
-Board specific device node entry
-&twl6030-usb {
-	usb-supply = <&vusb>;
-};
-- 
2.47.2


