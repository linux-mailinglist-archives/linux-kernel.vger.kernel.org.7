Return-Path: <linux-kernel+bounces-741973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 423FEB0EB8A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 09:14:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0EE3188636A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 07:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FA6A272E42;
	Wed, 23 Jul 2025 07:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="ckyEgRp8"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01852586EB
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 07:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753254889; cv=none; b=AjWuI/94JGZv6S+HynvbuXnwWZ/2mvuPQVBBhutRIRsxtUIyQAPQikOHFLp+hA12cWwgChZiJFGFUynKmq77kfLpxd5bmqfMzHQetXljhDQ57ARfc8msf8rycHjZV+pWW72rK8ap+dGRVh4J5vFkWHw/RqADIzuv3olLyy+9C+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753254889; c=relaxed/simple;
	bh=mI3eOP0Qv/SWk/IoD2/DKt5erOKKXZgTjawchOE/wRk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Vvy4qhMQTPoHPRgOxlOX7HGhIrWKSsRMBjlhd7vhu5hWsGQrquJtGj9IDtXwyhaEOUN1zl9ZizuSGBHtkTJQkhVtTZ/rKWEcDtseqMR995Ougfx2OmujxBY9RAxfSBIo4oRjQ5GNVoaJn0Rtrdzb53DMXEdvvATAFz6/7ssipPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=ckyEgRp8; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ae9be1697easo122529166b.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 00:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1753254886; x=1753859686; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9zsnQoYlGAtPfOsdm2IE5TQWxuSL8YKpwWHSnuH75p8=;
        b=ckyEgRp8qwvzf4kOZB6ipyJO5ybWCaE15us5CdqlttkOYgd9OalWGHP/lnW51UotAC
         O0NHyEc9rX69AzRXArO1WUvUauz1/A61ECTtadLjeFhkeuwNPjVlItyA/XfV+0R82PmV
         EoY+GWTNFcCimZpP4EPQb1UOiJMQkRQhtG3SM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753254886; x=1753859686;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9zsnQoYlGAtPfOsdm2IE5TQWxuSL8YKpwWHSnuH75p8=;
        b=MnqFQhOPCcsCrWJEv4H8IZ42eryVRye5mpP1MsYI3Hva4zEHyJWQCZn/TXYqnan/OQ
         ZLu4gwd1LTp78SHFLDF1k4vxnQfacxvG3f6Mnt+CTMHhD6kCNHTmF6AjgrJRF1z7XTgQ
         bA8TgVvhpV2Wv3SwePAS+mcnTTkZvv8HG+hqLqyeCxpg9mBuRjS2JYjwRIpripJqK7II
         Aq5+QXjOCtAZYtwrDwcPxL+AhGGiZQGmDMf4ecTrzjwGZKh/z0Ghfq7ICZv/UxIztC8e
         CWgOw56IAynqXEFs5buP0HqnXux4jqboAKMQeGvtRAIc74cDI3CnCYLFhsanxelaN5nr
         NV3g==
X-Gm-Message-State: AOJu0YxLohjv0KGGrBbTg5Fa3sqArVCmNP5RieT8m1Ow5HQCdSi3pZ9P
	UnKAQFZIa0bJ4UjTVqo9/WlBm8rGlkNUm/CkP7UmA6uKKUPODfkinwgMPw6X9WA0WrvhJdovpYo
	WT2F0
X-Gm-Gg: ASbGnct2ykcK1+0ZociyOj8+hR/FYVV3EtLbM94AHDOp/7wFuEcpd6YBtsO34lBXUSd
	6DjHErIYJ9ZOaJiT/XmKCSYjAy1n1dvEwy5gxAALGy0dNqVvkSGtyU5OleCmzaWqMAUQ1I0pAgS
	lw/mNAOv+wrvp7WpuLOT5OIzhWtf1zi5j/GhaJzb1nTJ8cu9EKIxLTespiPl+/uaxFxhkowMiH8
	CJooe+cubUs/rgbkIMpOhcLMA3b4vmfZ/xxYamxk/w5USUepeTQy2Gbf5VAXHZcNjrzpL+OYx3N
	nZevK+sf360g4RLEotLnFq5sHqJ57R4NVjDVXDVc3kXo9cQ+aDujd8EuwqYY/8qyO+SIE5vLBTr
	KqogvUesaFznYNGxRvk+pBxHiCDnjtDosa7ndgGN0j4U5xT7PKMsjXakmVl98KIHB5hV9pN5GCO
	9d3+EGl8QTR+Bvjg4K4yKduEKOn2mA7eyxT1R/AMB6m4xWOqw/WfgTXSSvoW9zgDS3
X-Google-Smtp-Source: AGHT+IHXPN5Tuqtpbz2c82B4GJgt/27zMO5flrScxbOfd0W5i6tJDzdfZGk1pNa38lNrnnbEsvlhKQ==
X-Received: by 2002:a17:907:c2a:b0:aec:6701:b4ef with SMTP id a640c23a62f3a-af15484cc84mr638526466b.16.1753254885856;
        Wed, 23 Jul 2025 00:14:45 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-87-15-176-33.retail.telecomitalia.it. [87.15.176.33])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec6c7d524asm999334466b.45.2025.07.23.00.14.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 00:14:45 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-input@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org
Subject: [PATCH] dt-bindings: touchscreen: drop any reference to touchscreen.txt
Date: Wed, 23 Jul 2025 09:14:20 +0200
Message-ID: <20250723071442.3456665-1-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With commit 1d6204e2f51f ("dt-bindings: touchscreen: Add touchscreen
schema") touchscreen.txt is no longer needed. Remove the file and
replace every reference to it with the corresponding YAML schema.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

 .../devicetree/bindings/input/touchscreen/bu21013.txt  |  2 +-
 .../devicetree/bindings/input/touchscreen/eeti.txt     |  2 +-
 .../input/touchscreen/raspberrypi,firmware-ts.txt      | 10 +++++-----
 .../bindings/input/touchscreen/touchscreen.txt         |  1 -
 .../devicetree/bindings/input/touchscreen/zet6223.txt  | 10 +++++-----
 5 files changed, 12 insertions(+), 13 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/input/touchscreen/touchscreen.txt

diff --git a/Documentation/devicetree/bindings/input/touchscreen/bu21013.txt b/Documentation/devicetree/bindings/input/touchscreen/bu21013.txt
index da4c9d8b99b1..9f1a6d03c4da 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/bu21013.txt
+++ b/Documentation/devicetree/bindings/input/touchscreen/bu21013.txt
@@ -17,7 +17,7 @@ Optional properties:
  - touchscreen-swapped-x-y : General touchscreen binding, see [1].
 
 [1] All general touchscreen properties are described in
-    Documentation/devicetree/bindings/input/touchscreen/touchscreen.txt.
+    Documentation/devicetree/bindings/input/touchscreen/touchscreen.yaml.
 
 Deprecated properties:
  - rohm,touch-max-x        : Maximum outward permitted limit in the X axis
diff --git a/Documentation/devicetree/bindings/input/touchscreen/eeti.txt b/Documentation/devicetree/bindings/input/touchscreen/eeti.txt
index 32b3712c916e..1230b0fd153f 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/eeti.txt
+++ b/Documentation/devicetree/bindings/input/touchscreen/eeti.txt
@@ -10,7 +10,7 @@ Optional properties:
 		latched. This is necessary for platforms that lack
 		support for level-triggered IRQs.
 
-The following optional properties described in touchscreen.txt are
+The following optional properties described in touchscreen.yaml are
 also supported:
 
 - touchscreen-inverted-x
diff --git a/Documentation/devicetree/bindings/input/touchscreen/raspberrypi,firmware-ts.txt b/Documentation/devicetree/bindings/input/touchscreen/raspberrypi,firmware-ts.txt
index 2a1af240ccc3..c554c89b4e55 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/raspberrypi,firmware-ts.txt
+++ b/Documentation/devicetree/bindings/input/touchscreen/raspberrypi,firmware-ts.txt
@@ -6,11 +6,11 @@ Required properties:
 
 Optional properties:
  - firmware: Reference to RPi's firmware device node
- - touchscreen-size-x: See touchscreen.txt
- - touchscreen-size-y: See touchscreen.txt
- - touchscreen-inverted-x: See touchscreen.txt
- - touchscreen-inverted-y: See touchscreen.txt
- - touchscreen-swapped-x-y: See touchscreen.txt
+ - touchscreen-size-x: See touchscreen.yaml
+ - touchscreen-size-y: See touchscreen.yaml
+ - touchscreen-inverted-x: See touchscreen.yaml
+ - touchscreen-inverted-y: See touchscreen.yaml
+ - touchscreen-swapped-x-y: See touchscreen.yaml
 
 Example:
 
diff --git a/Documentation/devicetree/bindings/input/touchscreen/touchscreen.txt b/Documentation/devicetree/bindings/input/touchscreen/touchscreen.txt
deleted file mode 100644
index e1adb902d503..000000000000
--- a/Documentation/devicetree/bindings/input/touchscreen/touchscreen.txt
+++ /dev/null
@@ -1 +0,0 @@
-See touchscreen.yaml
diff --git a/Documentation/devicetree/bindings/input/touchscreen/zet6223.txt b/Documentation/devicetree/bindings/input/touchscreen/zet6223.txt
index 27d55a506f18..384eeb4a333e 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/zet6223.txt
+++ b/Documentation/devicetree/bindings/input/touchscreen/zet6223.txt
@@ -10,11 +10,11 @@ Optional properties:
 - vio-supply		  : Specification for VIO supply (1.8V or 3.3V,
 			    depending on system interface needs).
 - vcc-supply		  : Specification for 3.3V VCC supply.
-- touchscreen-size-x	  : See touchscreen.txt
-- touchscreen-size-y	  : See touchscreen.txt
-- touchscreen-inverted-x  : See touchscreen.txt
-- touchscreen-inverted-y  : See touchscreen.txt
-- touchscreen-swapped-x-y : See touchscreen.txt
+- touchscreen-size-x	  : See touchscreen.yaml
+- touchscreen-size-y	  : See touchscreen.yaml
+- touchscreen-inverted-x  : See touchscreen.yaml
+- touchscreen-inverted-y  : See touchscreen.yaml
+- touchscreen-swapped-x-y : See touchscreen.yaml
 
 Example:
 
-- 
2.43.0

base-commit: 89be9a83ccf1f88522317ce02f854f30d6115c41
branch: drop-touchscreen.txt

