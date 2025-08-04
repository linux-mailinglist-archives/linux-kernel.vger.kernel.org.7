Return-Path: <linux-kernel+bounces-755154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CF2EB1A23E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 14:53:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9FE357AFDD1
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 12:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F094026B96A;
	Mon,  4 Aug 2025 12:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BkWpFUan"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35C226B2AC;
	Mon,  4 Aug 2025 12:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754311722; cv=none; b=alPbUCDbdOGIuiRBT4n6XYzF1CGySJBc7jcxMC4sJADcn0h4g1VnbeGJYgjHvtMasNNXtu9zpkWznH9rwv50oPPHvd1FPHvdSGdGeT3ucZp96MV5q7Hz0LHcEnq9/RZsvQGX87wFFeduf6DjtFQ8hADou8IvXqT8rFc2XgQzEL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754311722; c=relaxed/simple;
	bh=LM2JATXycWcn453vZ0PO0eNU6HQcpBS9QxXv/40pZJk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MFYL9WFQcGHW7+P8xusGL9KtnFnp7gbAUAsC5k/NPAINSslaxUP1ilXGjPvhh7qKjCSwjumEamHs1WtegHo/MezOuVIUjIqIgaKEYT54iUmQhLNPM9hGRct3fZaBUYLw56wXg/ZjLDQ14nLumEn4aKkgRiY5P5BWqOIGIcdE/A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BkWpFUan; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-76bc68cc9e4so3533572b3a.2;
        Mon, 04 Aug 2025 05:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754311720; x=1754916520; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ay8W8bMF+0tlA+yVz8LXEmFleZShrCq5N3euX/qtVoc=;
        b=BkWpFUanLCqDg7HuQrZliqrqAMTXSA01fUX/mIKzuIogrVnwJj30GouvRRo3P39/mE
         69C6xnlgcZJNSe5HDgTetKKKB3KCw3Sn88aqbrN2eBzJLyrqVBiNjjrrbKaoDZW58BWb
         pjk/yF4UlAtXSjhbM31+BdjuLA74EYCmlZ0ZYerbIId2pcdmrcBk+X1Mic6w25Y8AtXI
         VE6V3S/pcqZijCbWr+cvfdEg7JbLWsgVP4hJW6kAdrPqxcmRNIf6bovFs+Cg7OvHbkJk
         9qSPzpxctF5DAn+xCNlgns4nmMFgqcCwJKGjr8yTYOrqeuT33S8eIDJq+8NHiNM9IhFg
         4YLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754311720; x=1754916520;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ay8W8bMF+0tlA+yVz8LXEmFleZShrCq5N3euX/qtVoc=;
        b=Gwo01T98MCKlThqt8yAGDInL1RD4AzOAFVGUd9WOWC4wCm8A/BBT4MerUwJfUGeiVH
         bvIdQOMWA0h0FjcNgd9DUI6ibPz4s07wLBniOclVbvh943OoZ1UjJEwxhiquJmNyS/p2
         Lfu7778Ix4NntH5f10Y+AnjCaG0qIEgPryCCo54aZqIxL/AYBwub30/7f2NM470Ln/+W
         Wf+bqHUy2zEQsvVaMd6H70RmcDLslFzZRRCPbnSOP8Fx04bnDYXdJzo174Ym8QGFx013
         ANlc61eEMWhJo+95aBij1Vz9R6900edYjP6Y8VnVxoMBJaEYHMYesMNnF7dNxX2Pewfz
         3qag==
X-Forwarded-Encrypted: i=1; AJvYcCVKEnaRSefwxPuoffsjyorowWfk+St3bPcavcyQdgnHmdXgoN60gMNZhD/xuGAXQyFtE1bbj6A6Lc4Y@vger.kernel.org, AJvYcCWkerPpOY3IqGVDwXfpWF7sbDoT+X0y2zGWdYHsaKTDI6NR7eZGH3bbinEdHv+bwPuLT9M/kC0wVHSNsAzn@vger.kernel.org, AJvYcCXER4QvGToMHuvg8ipdanHqm9Nowcihf7ycY2aBF8wLEywliv1oI0tiKJKB2g85LvmkxcD9mhq83lPJ@vger.kernel.org
X-Gm-Message-State: AOJu0YwqrJCjTce0V/6buWd9DdBRBlVwN8utbdESUmsOWGF2sNSgNzcD
	B9EgwwPRk5F53Fq8taBGvU60Iq8UBOIaYlz2SulX08UgchNLtuz9/pIgKvin2g==
X-Gm-Gg: ASbGncuXUpN1Lb9gQnU+EEEvZlEb0DMdj0isRCjLwsPcyAF6AfR11eZb7gBMjLKRI5Z
	tCEeXGlhBNGE6Om5l8vMKfQmi3fqYlRG2XN57VbCaiz7jrSYYxupPY2Y/4CpHwBrcByofR62blK
	xjfWU5wfbmY7FlSgDJ8KunQtHTAuJPkyO0tZCkw5MCNinZZSnmkdqCZCDOFqmEqeqzBIuQrHXxu
	ijACB89s2xm929XXb/vaDr7iJ1lvNJaBBJ3/Yak3tdQC5t7ablqdUJF0ZqY2gdd9pAPJC2QAODh
	qdm+qe5l/FfcpT/hkc85B04AI8SzYmuMC5LOX/8hh+A1sinDKb6lTjingvTBlKrGmh61RP6H25A
	rRp5+dFaOdVW460MpjRxEro4OSh4OK4uB6JwzF7ejBXWFY5UVHxhY8hM0w9nZu01PxBqR5080rq
	PQjFAykOA=
X-Google-Smtp-Source: AGHT+IF6jBEqF/K1rFWpUdO/4n5CzvXD7wSlx3y/GfJ3/hPIhcB/9JlN2vidVDOfKgXPHi1uz2MAXg==
X-Received: by 2002:a05:6a00:1907:b0:76b:c5bd:aec7 with SMTP id d2e1a72fcca58-76bec30aa51mr11499490b3a.8.1754311719994;
        Mon, 04 Aug 2025 05:48:39 -0700 (PDT)
Received: from CNTWS00427A.itotolink.net (111-242-101-165.dynamic-ip.hinet.net. [111.242.101.165])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bccfbd656sm10566612b3a.72.2025.08.04.05.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 05:48:39 -0700 (PDT)
From: ChiShih Tsai <tomtsai764@gmail.com>
To: linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: jdelvare@suse.com,
	linux@roeck-us.net,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	corbet@lwn.net,
	t630619@gmail.com,
	ChiShih Tsai <tomtsai764@gmail.com>
Subject: [PATCH 1/2] dt-bindings: hwmon: adm1275: add sq24905c support
Date: Mon,  4 Aug 2025 20:48:04 +0800
Message-ID: <20250804124806.540-2-tomtsai764@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250804124806.540-1-tomtsai764@gmail.com>
References: <20250804124806.540-1-tomtsai764@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for sq24905c Hot-Swap Controller and Digital Power Monitor.

Signed-off-by: ChiShih Tsai <tomtsai764@gmail.com>
---
 .../bindings/hwmon/adi,adm1275.yaml           | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/Documentation/devicetree/bindings/hwmon/adi,adm1275.yaml b/Documentation/devicetree/bindings/hwmon/adi,adm1275.yaml
index ddb72857c846..6aa300086c84 100644
--- a/Documentation/devicetree/bindings/hwmon/adi,adm1275.yaml
+++ b/Documentation/devicetree/bindings/hwmon/adi,adm1275.yaml
@@ -30,6 +30,7 @@ properties:
       - adi,adm1281
       - adi,adm1293
       - adi,adm1294
+      - silergy,sq24905c
 
   reg:
     maxItems: 1
@@ -46,6 +47,18 @@ properties:
     $ref: /schemas/types.yaml#/definitions/uint32
     enum: [1, 2, 4, 8, 16, 32, 64, 128]
 
+  silergy,volt-curr-sample-average:
+    description: |
+      Number of samples to be used to report voltage and current values.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [1, 2, 4, 8, 16, 32, 64, 128]
+
+  silergy,power-sample-average:
+    description: |
+      Number of samples to be used to report power values.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [1, 2, 4, 8, 16, 32, 64, 128]
+
 allOf:
   - $ref: hwmon-common.yaml#
   - if:
@@ -96,12 +109,17 @@ allOf:
               - adi,adm1281
               - adi,adm1293
               - adi,adm1294
+              - silergy,sq24905c
     then:
       properties:
         adi,volt-curr-sample-average:
           default: 128
         adi,power-sample-average:
           default: 1
+        silergy,volt-curr-sample-average:
+          default: 128
+        silergy,power-sample-average:
+          default: 1
 
 required:
   - compatible
@@ -121,5 +139,7 @@ examples:
             shunt-resistor-micro-ohms = <500>;
             adi,volt-curr-sample-average = <128>;
             adi,power-sample-average = <128>;
+            silergy,volt-curr-sample-average = <128>;
+            silergy,power-sample-average = <1>;
         };
     };
-- 
2.43.0


