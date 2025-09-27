Return-Path: <linux-kernel+bounces-834927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 58F27BA5D9C
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 12:21:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 219CE4E1BEE
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 10:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 645252DFA25;
	Sat, 27 Sep 2025 10:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LcR4V6GQ"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3CB2DE70B
	for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 10:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758968402; cv=none; b=dLMflD0NOW9syFOhL3EEk/IbVFhfzqRfQ4+KvQfohK6MCfCimyoBLYo3Rd5ryLeanILKqmnr4YDhBnZV1MbhokPi+b1xvNytAimwd6Noo++IGc+sDK/EuktYx3uOpscMQFbaHAMCV3UpeGy46ndnIWlQSSli0JlWQrF0OzTNQ3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758968402; c=relaxed/simple;
	bh=gnOswjnbXmBMi405dgP0uHVoleNWn/lcXZxumvVI8g0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fmkv0mcjIB/oPc64VjOlwzESWqcKzCnTogzVZFfNxeFPdc1nYwL8kJLOUR4Eq1jp34QWkpbtntJX82DZA42mIBsqGVcTHCmDA7Nk6+pOh9b08Z9OlR/4LG37sEGnoe2RDMoSmhlGmDKKR/Lm7e1rHaklk1pMzLIpHaOZpNfPjPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LcR4V6GQ; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-46e34052bb7so30413815e9.2
        for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 03:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758968398; x=1759573198; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uocL+F5w2WClnJd2wZcawwJDtccp4StZfUc4QhYk9C0=;
        b=LcR4V6GQoKe83eph8G2njkD1GuVDqlzFQXraTj4z95DcsUi1YldCVgkdQbk1wD9xpR
         JgWWBFYrjKkzk3hwRhVaPQEMhPpWCcbfX7CL7H1LQbWYdXDYUFfHn+xPt/3V4jD2P3js
         gNz6FpGd11raz87G8NbZ+ofyJyP2lDrJBAcdXaubxkIOUsZgopWvdpr0UFdVGsQACo9s
         4j4gOPGHcMip85WSgcUI+CXmxL+2p0aLw8TTJTJArhXvpyXfbBJ6wBL41DoWWD0N0wXY
         4kWkNw2hFTgIY0sXZTOPp/ACLJa5eOVUS9oOV/khhOBtDPum3bQQFXCpSZzyCu2fUWUW
         jb0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758968398; x=1759573198;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uocL+F5w2WClnJd2wZcawwJDtccp4StZfUc4QhYk9C0=;
        b=vO+ajoa6YFZjVfiRL0N3u84JwoEoQ8ko2pvbn8SwQ49arPMTpJarVB5y8EqC4jMgRl
         Im4AEonMTpaSeCBsQiTWBwiTclNABu71TQZTFFysQKs31dkDRIOXGKm2jPKqd8RE2GPL
         Im+nerzEohrpJtozd0zQxq10JZkhwPZEtVW3Cp3wMv+4/S6rA4d481XHYfH5kD9wKg/O
         k/bVVvbTn9JcPDXTe3pFoqDnbY+LN/GenPZsX6QQWgPcmMnTtuRTKv8k6GGqRUTUTxPx
         PEdwKM7GeRk+Ez19WNGf6uN11lMp+H4rv66E6wgf05PHHzQwnDZUP7S5AOnYqcolkXco
         Cdjg==
X-Forwarded-Encrypted: i=1; AJvYcCUYrZHjf+fA9JIlLKMdiJ6tgfBjoacsCG0KeRk9vL+NDLvqCGgcBHByiHvKAFZ1+Jab/jb9yNw/hs3XvYk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6dV2PNNyvnFd95JpxMdjheCzEQPp2oFd1qWAjwCn/K253X0gD
	OqHSqQgLDT3aqjG+sRlaNdH6k0ENV6viHqe0voNFfSyzRFlr7Ys1SMay
X-Gm-Gg: ASbGncvOn48aP1EtGLopqHhuJEhgrNldd8EMxLtejhDws0ut1TQ+kWciwPNEeHqHoEY
	T/8/ZlzhEnxYIICRA3Im5BFaDTGZH3vQHFQ47t1BTPgIzPuaet4K6pMJITnddGPfBQBty8wRN6d
	IfncNyWhw9FdXIeYcqZPxrNnquOP7Aq6ewlDtKM8aQCI1k1mo0ZvJOGcfWjr5kJ6kUva91bU9I/
	YX/H8Uo2wiMueGyjMhBwoY7dqqiUssglniASxeiMXK1xvWWMYISdydODanRo+7EjpweyCC/OCFO
	dhV064PcKT8yIAD8mmL/JvFDOMEwo5T+2bFJAjEHO02T3mUFIkgLXLHTjbQO+4xaxSaeCeto7zm
	so4JsCtD1O7TbK9Ihransy68eHIEZjCFvB6cB
X-Google-Smtp-Source: AGHT+IET2Tr0s3n8VDek3rlo7bkHPvQJdlDvKrOgoXx4qdDl/ZQ+KDgju6tIIVWGP2X02sVMgrwrgA==
X-Received: by 2002:a05:600c:c176:b0:46e:32a5:bd8d with SMTP id 5b1f17b1804b1-46e32a5bdb6mr89196585e9.3.1758968398332;
        Sat, 27 Sep 2025 03:19:58 -0700 (PDT)
Received: from builder.. ([2001:9e8:f11a:4416:be24:11ff:fe30:5d85])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e32c31df7sm53416435e9.4.2025.09.27.03.19.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Sep 2025 03:19:58 -0700 (PDT)
From: Jonas Jelonek <jelonek.jonas@gmail.com>
To: Chris Packham <chris.packham@alliedtelesis.co.nz>,
	Andi Shyti <andi.shyti@kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-i2c@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Markus Stockhausen <markus.stockhausen@gmx.de>,
	Sven Eckelmann <sven@narfation.org>,
	Harshal Gohel <hg@simonwunderlich.de>,
	Jonas Jelonek <jelonek.jonas@gmail.com>
Subject: [PATCH v8 8/9] dt-bindings: i2c: realtek,rtl9301-i2c: extend for RTL9310 support
Date: Sat, 27 Sep 2025 10:19:30 +0000
Message-ID: <20250927101931.71575-9-jelonek.jonas@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250927101931.71575-1-jelonek.jonas@gmail.com>
References: <20250927101931.71575-1-jelonek.jonas@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adjust the regex for child-node address to account for the fact that
RTL9310 supports 12 instead of only 8 SDA lines. Also, narrow this per
variant.

Add a vendor-specific property to explicitly specify the SCL line number
of the defined I2C controller/master. This is required, in particular
for RTL9310, to operate on the correct SCL for each controller. Require
this property to be specified for RTL9310.

Add compatibles for known SoC variants RTL9311, RTL9312 and RTL9313.

Signed-off-by: Jonas Jelonek <jelonek.jonas@gmail.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
Tested-by: Markus Stockhausen <markus.stockhausen@gmx.de>
---
 .../bindings/i2c/realtek,rtl9301-i2c.yaml     | 39 ++++++++++++++++++-
 1 file changed, 37 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/i2c/realtek,rtl9301-i2c.yaml b/Documentation/devicetree/bindings/i2c/realtek,rtl9301-i2c.yaml
index 274e2ab8b612..17ce39c19ab1 100644
--- a/Documentation/devicetree/bindings/i2c/realtek,rtl9301-i2c.yaml
+++ b/Documentation/devicetree/bindings/i2c/realtek,rtl9301-i2c.yaml
@@ -13,6 +13,8 @@ description:
   RTL9300 SoCs have two I2C controllers. Each of these has an SCL line (which
   if not-used for SCL can be a GPIO). There are 8 common SDA lines that can be
   assigned to either I2C controller.
+  RTL9310 SoCs have equal capabilities but support 12 common SDA lines which
+  can be assigned to either I2C controller.
 
 properties:
   compatible:
@@ -23,7 +25,15 @@ properties:
               - realtek,rtl9302c-i2c
               - realtek,rtl9303-i2c
           - const: realtek,rtl9301-i2c
-      - const: realtek,rtl9301-i2c
+      - items:
+          - enum:
+              - realtek,rtl9311-i2c
+              - realtek,rtl9312-i2c
+              - realtek,rtl9313-i2c
+          - const: realtek,rtl9310-i2c
+      - enum:
+          - realtek,rtl9301-i2c
+          - realtek,rtl9310-i2c
 
   reg:
     items:
@@ -35,8 +45,14 @@ properties:
   "#size-cells":
     const: 0
 
+  realtek,scl:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      The SCL line number of this I2C controller.
+    enum: [ 0, 1 ]
+
 patternProperties:
-  '^i2c@[0-7]$':
+  '^i2c@[0-9ab]$':
     $ref: /schemas/i2c/i2c-controller.yaml
     unevaluatedProperties: false
 
@@ -48,6 +64,25 @@ patternProperties:
     required:
       - reg
 
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: realtek,rtl9310-i2c
+    then:
+      required:
+        - realtek,scl
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: realtek,rtl9301-i2c
+    then:
+      patternProperties:
+        '^i2c@[89ab]$': false
+
 required:
   - compatible
   - reg
-- 
2.48.1


