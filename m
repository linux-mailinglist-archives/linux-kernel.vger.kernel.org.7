Return-Path: <linux-kernel+bounces-878841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB6F9C21963
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 18:56:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FF091AA0BFE
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 17:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D0EE36C256;
	Thu, 30 Oct 2025 17:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GUoK0DHw"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E8636CA78
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 17:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761846934; cv=none; b=VXyMGUsuCHnRkn0GunXHijVHKq/WSMZNgBiM7jn5ZpeL+z+ND7Zv0sFn/cTgSA418GW9TnRMoWOGnRMkBT0pLWtvyOYqg7JGjHrwZg5NhtY+88nPYGfr9xk2KAZAqSofBYJCF2XcCAGQLTYsAKEyJHwysKRlBp8AIv03MHuwZFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761846934; c=relaxed/simple;
	bh=3z2mhzRxyfQNv1R0hi7ZTnOWImB9S2k6FugjQXRhwUY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jc9oUiElHKkNQH7sy6ZFmRIqc127UtSvW6w4U5rjA3/9/rlwgYYbOOUwpRHgr4ZE2nwgvqw7xs4OpC/nUeeXFeEiqnavygrDM3vi/FOVesH42W5MKqWI2EXBxte6PdOECxtPWuh5tpw/doBJhBHqUiQP8PguUe4vMTDxBakNjLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GUoK0DHw; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-426fc536b5dso901133f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 10:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761846929; x=1762451729; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m8YnOhLYa4+B1Ekt7MbimeIIDg/J8LnZDYbx9DRe05Y=;
        b=GUoK0DHwVAUvfYncsyPHQ72jouRM6y4QLN89pB/okT/41amSnBd+vsfTFaw8vbp/gV
         QCxmrN1Tj67ZnkHnXfXzfju2lPdWJFXhyJKaAsoCJmGXqlAa6hwK30H9mf3wovxQDyEM
         QSrl0oVmomV8DWZgmsDSHSIFZ+u1s9uLXZiyEi4Ai1JiwjfoSR7hveCuKCU31d/dEJMR
         TjPZjqQDo9UH60X5fFZ+o6cHQ9u8VGB5zSsfKvFhadggIBuck1qIpmTRYWNfn0PG54ED
         CoxtcI9TY2Gt6lXSN607U+UsyO/wdJR5S/jbYcmGEjSwx9Uxgls/sdWNAAtPUtjsSndp
         LO0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761846929; x=1762451729;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m8YnOhLYa4+B1Ekt7MbimeIIDg/J8LnZDYbx9DRe05Y=;
        b=sffiJst20iQH23YxE5o+s1f14do+4w3WeA3exJlSoXh/Zkw0midvUdBUnrRAAECP+Q
         xrFIjAMPizZETzNu7saKRm0O2WIrxk17kdetoWDmfb9IYGCeh61os7K9yxtsVYhDxtvM
         tz2RPh1UswbQrWqMhx46+Epn7rc/bcYp+5/ka39zIsLUrYWY4US2w9MoMj7Bg9ziN9D/
         NB5cKAZn0UW7KfOtkYXaCKzDu6TMD9H8LXrpCrhT9uATlHzcZLXEZ5L9ji5j/J7SbutB
         3dM2JQhlWDc2mh4Y0XGqzRFUYPyPcdxGxW2Bl7TdZ+NKa0aP3/lQU3XdMk/Ep5CGueBO
         tLCw==
X-Forwarded-Encrypted: i=1; AJvYcCXJzAMM62nh08bAU2yqZUVUiS7NgKyAnKLT1g2mTqUBnPppDzlY8B9S0UTmpWW7QirYP43JtOV81cIV0h0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtGu5gVxI/fYHeKX+GyiZ8rUeE/LgIcIZfBnCvPrwqEMfx3e8s
	1vmLW+eYUkzwzdkNLBRzv7oyO/B3ZUQcw61N2Nppz/cpJ4ORASpVXL9JCLX0L7km
X-Gm-Gg: ASbGncvtEH8j9Y+xR57KzxZriVNe4VogC8FwcivHhbcvqBeaP0icUYEiYIAndD2GjYZ
	s9cZg+4DUndF8D7JDGi49fWfjOA2KRfgDlvpa7DvLYFr1LPwTbqIualQU2hFzM/g2jiN+kcMwGu
	JV7YXaJs4d3gnT/Vkqa9u22K1q2g9KlGeDhZOTjxOIAQpWxIf75yC1sfgU/HFgWMyxXoLI7tgwB
	Ecm7elqS5vIlAgEdej+bpVh3YxgWtaAQ8Q1hm9a5jNP/6nlQuIz7EiPYfqAyi5DuPWkIsXw92xV
	bZk2GwGZQXeWwa5Fl/DXU6oBnYHHHMw9PQlXbQkpALATeH8MuF2CndRDIGJDaZPAc+rYyAm5PKn
	pEurWhuisAh/RZIMyJFijxYtoSdSr3TRA6m2NdIYZ9cXmkTiDRsVZUF5wlJ+3EC56w1Pjal5ewF
	3Faxk2tsqT+pUK8mquzoyIWD8xcqpk8i7b8HdBnEi70VpFUVlLDpSI4q6dPrl/
X-Google-Smtp-Source: AGHT+IFwc9rIFO7apqC3XmXhkXUpx2h1S3c6wGBMHk4QlRiJ5KyIleWF8cbqLDTxKoIV//tw2zW3AQ==
X-Received: by 2002:a5d:5846:0:b0:3fb:9950:b9eb with SMTP id ffacd0b85a97d-429bd683f6cmr459520f8f.28.1761846929243;
        Thu, 30 Oct 2025 10:55:29 -0700 (PDT)
Received: from biju.lan (host86-162-200-138.range86-162.btcentralplus.com. [86.162.200.138])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952de5f9sm33384041f8f.38.2025.10.30.10.55.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 10:55:29 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Biju Das <biju.das.au@gmail.com>
Subject: [PATCH v2 01/13] dt-bindings: serial: renesas,rsci: Document RZ/G3E support
Date: Thu, 30 Oct 2025 17:55:05 +0000
Message-ID: <20251030175526.607006-2-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251030175526.607006-1-biju.das.jz@bp.renesas.com>
References: <20251030175526.607006-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

Add documentation for the serial communication interface (RSCI) found on
the Renesas RZ/G3E (R9A09G047) SoC. The RSCI IP on this SoC is identical
to that on the RZ/T2H (R9A09G077) SoC, but it has a 32-stage FIFO compared
to 16 on RZ/T2H. It supports both FIFO and non-FIFO mode operation. RZ/G3E
has 6 clocks(5 module clocks + 1 external clock) compared to 3 clocks
(2 module clocks + 1 external clock) on RZ/T2H, and it has multiple resets.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v1->v2:
 * Updated commit message
 * Added resets:false for non RZ/G3E SoCs.
---
 .../bindings/serial/renesas,rsci.yaml         | 85 ++++++++++++++++---
 1 file changed, 74 insertions(+), 11 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/renesas,rsci.yaml b/Documentation/devicetree/bindings/serial/renesas,rsci.yaml
index 6b1f827a335b..1c2ed4cd58fd 100644
--- a/Documentation/devicetree/bindings/serial/renesas,rsci.yaml
+++ b/Documentation/devicetree/bindings/serial/renesas,rsci.yaml
@@ -10,17 +10,16 @@ maintainers:
   - Geert Uytterhoeven <geert+renesas@glider.be>
   - Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
 
-allOf:
-  - $ref: serial.yaml#
-
 properties:
   compatible:
     oneOf:
-      - items:
-          - const: renesas,r9a09g087-rsci # RZ/N2H
-          - const: renesas,r9a09g077-rsci # RZ/T2H
+      - enum:
+          - renesas,r9a09g047-rsci # RZ/G3E non FIFO mode
+          - renesas,r9a09g047-rscif # RZ/G3E FIFO mode
+          - renesas,r9a09g077-rsci # RZ/T2H
 
       - items:
+          - const: renesas,r9a09g087-rsci # RZ/N2H
           - const: renesas,r9a09g077-rsci # RZ/T2H
 
   reg:
@@ -42,14 +41,40 @@ properties:
 
   clocks:
     minItems: 2
-    maxItems: 3
+    maxItems: 6
 
   clock-names:
-    minItems: 2
+    oneOf:
+      - items:
+          - const: operation
+          - const: bus
+      - items:
+          - const: operation
+          - const: bus
+          - const: sck # optional external clock input
+      - items:
+          - const: bus
+          - const: tclk
+          - const: tclk_div64
+          - const: tclk_div16
+          - const: tclk_div4
+      - items:
+          - const: bus
+          - const: tclk
+          - const: tclk_div64
+          - const: tclk_div16
+          - const: tclk_div4
+          - const: sck # optional external clock input
+
+  resets:
+    items:
+      - description: Input for resetting the APB clock
+      - description: Input for resetting TCLK
+
+  reset-names:
     items:
-      - const: operation
-      - const: bus
-      - const: sck # optional external clock input
+      - const: presetn
+      - const: tresetn
 
   power-domains:
     maxItems: 1
@@ -62,6 +87,44 @@ required:
   - clock-names
   - power-domains
 
+allOf:
+  - $ref: serial.yaml#
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: renesas,r9a09g077-rsci
+    then:
+      properties:
+        clocks:
+          maxItems: 3
+
+        clock-names:
+          maxItems: 3
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - renesas,r9a09g047-rsci
+              - renesas,r9a09g047-rscif
+    then:
+      properties:
+        clocks:
+          minItems: 5
+
+        clock-names:
+          minItems: 5
+
+      required:
+        - resets
+        - reset-names
+    else:
+      properties:
+        resets: false
+
 unevaluatedProperties: false
 
 examples:
-- 
2.43.0


