Return-Path: <linux-kernel+bounces-827022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 285ADB8FE9B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 12:07:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A2D6422778
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 10:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FA272FFDCE;
	Mon, 22 Sep 2025 10:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TVgSXbQC"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01FA2FE56F
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 10:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758535588; cv=none; b=tCDVfOcj7sentzugkn6VHFRDThDoBoVNGgpm1Q5hwIhq/yu3IvWKDYlrGwPe3FbHH+8uI5Odq5Ad+//g+mQu7QcsktgsXHWnTW5VJaM6xy21D6yXfZBJQYkNZqGLXWysGoWSg21zjtEQ18Ow5HR/dKMvK4cDlh+ZYLY8opkG+/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758535588; c=relaxed/simple;
	bh=1ehExbLkMmNgsVXFhI/3vAuhpWWLmzmhuVgV7QDcaGQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FDNYXqt2PTdDQOdZxce449gkh030pmptltenYEhGBDNOv8UOPfwLaCflaV3ehvYU/vIihtC6ouzg8o43pIO90p+wDgXlit5hLRx2LEvxH27gW4S+TfDjDZcVspHaiOp5xLeNsyzplOBg7iMWKADPEXvB1r6KFGyRp612VYAhTe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TVgSXbQC; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-45e03730f83so17229565e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 03:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758535585; x=1759140385; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bsYAjCVZTAgTbKUVHs9DAPmJO/mDOJAtaWrMK8+sbis=;
        b=TVgSXbQCa5k0aYm3TJvqmUPfEHAnB1wrN3x7203z3YMM2WBg8CLXVV5DddHNLM9/vQ
         IAEFYF71EkLKp7t+4cydkN43ZiSjMaKzwlSHxUhfa4odg6ZOdVtLhdCarg3AR3RtRT0c
         ZftXQsScdqhXBFYDG/d+bAto9jhjwVkJJDFjoI81G1ju/OsriXn4Tn0q5fPeggKBMM4x
         p5L/MFxnOy4xemgP9PNkw/+6p7WV3HR2HIYyRYqgY0mrIQzCGY0AMjyDf/qULVUStRn1
         UWgzZFgwfs7tHYm4Lsuyn867IyQZTZQXIiy2eQ98SCN+/hm9sfm4XD+0RoObDzvDTObP
         4Eww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758535585; x=1759140385;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bsYAjCVZTAgTbKUVHs9DAPmJO/mDOJAtaWrMK8+sbis=;
        b=o6+y8tRI17htMknw/Wui4ztXr7/ASg3EzaVoFIZl9YucL3U6DeZcxmyuxqPMc4hlfG
         O7pIDlNlmv6Vj/5YJN4GyxRiQM19UX55DSgBRzKQk0tpICPDORY9yrZiXsOy7z53MCXh
         ju9MFAoz3c7LWntMZPrRKeyVEavEY0BQtI8YZRHyrpq3SACCNlVYqtWQQDvMM+GD6z6O
         hXnRVU7sVZoq1qu8ks8yWgJQ6qBUuzlPtFggZ8W0WAJuiuBlGBAfNr3LbTFbWw/gE1m3
         MF+Zp/9Beh4beGcskGMputkeSZeIUDFsjCsL7OMbqN94olR4wM8XwASoHMskvKKMQYwh
         MmPA==
X-Gm-Message-State: AOJu0YytVrItmV+dHn1qiNHOhIN0JWktVxDf49EpPJwPmFjEcFneL43F
	CGTm+tZHl9eCkhQ12RFJIW2nqwK6Eej7leGViRGHcRE+ZM6huTKe7Go6
X-Gm-Gg: ASbGncvkZjjgys+lRGI1+YjETWOqLjwyP/cX5VQTnx7os51bHHG2BBAD28QXXRTHPaE
	TEhV1uvv42Xkg2StQNHejKP2R68tpGkYc+E6aLKEf1MmkR0nS9mBux0AeoY/mf/T9+6JC9Xi9Xk
	Ab2XxajAspxeMIj9ChKqDN9ripkjQsQPQlmHHQ0rNa60XxKu9PRGER/OkygZaGme0m8OqotJorX
	Zu0lcIRmtst0nhNiwuamo0hdvIBtTwxDZ8YewtyqEn5vwuXf7P1mqvzBFt5vqg3aq6NnEJ8mHF7
	+Jp9w+NiQQWpIyHWcAqOUfplXaA0PmiVSa3NhzdH5Wz8es3Y+zQX0oYJ6nZet8p3dVHsKhcTMHB
	HnWHTg7Cc9oLU4pVAGNIpR2gWhC9lIjdQyV5JqJSB2SVX24kumAnRcKlv88OSqIFYkLlYSryJmB
	44hwlpzpu31JJpvmQnpG8aZGMi2y0=
X-Google-Smtp-Source: AGHT+IH/nuiP33vxdi6haBkztRav20FFYyckleFU6YyLjEkl9KoqVa24kjV3Z8p0lBzYdX5BRmqpMA==
X-Received: by 2002:a05:600c:3585:b0:459:d451:3364 with SMTP id 5b1f17b1804b1-467efb044a8mr139254985e9.24.1758535585151;
        Mon, 22 Sep 2025 03:06:25 -0700 (PDT)
Received: from localhost (2a02-8440-750d-3377-171e-75f8-f2d4-2af8.rev.sfr.net. [2a02:8440:750d:3377:171e:75f8:f2d4:2af8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-461391232e7sm233177835e9.6.2025.09.22.03.06.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 03:06:24 -0700 (PDT)
From: =?utf-8?q?Cl=C3=A9ment_Le_Goffic?= <legoffic.clement@gmail.com>
Date: Mon, 22 Sep 2025 12:06:17 +0200
Subject: [PATCH v7 4/7] dt-binding: memory: add DDR4 channel compatible
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250922-b4-ddr-bindings-v7-4-b3dd20e54db6@gmail.com>
References: <20250922-b4-ddr-bindings-v7-0-b3dd20e54db6@gmail.com>
In-Reply-To: <20250922-b4-ddr-bindings-v7-0-b3dd20e54db6@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Julius Werner <jwerner@chromium.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, 
 =?utf-8?q?Cl=C3=A9ment_Le_Goffic?= <legoffic.clement@gmail.com>, 
 =?utf-8?q?Cl=C3=A9ment_Le_Goffic?= <clement.legoffic@foss.st.com>
X-Mailer: b4 0.15-dev-0dae4

From: Clément Le Goffic <clement.legoffic@foss.st.com>

Add in the memory channel binding the DDR4 compatible to support DDR4
memory channel.

Signed-off-by: Clément Le Goffic <clement.legoffic@foss.st.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Clément Le Goffic <legoffic.clement@gmail.com>
---
 .../bindings/memory-controllers/ddr/jedec,sdram-channel.yaml   | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,sdram-channel.yaml b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,sdram-channel.yaml
index 9892da520fe4..866af40b654d 100644
--- a/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,sdram-channel.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,sdram-channel.yaml
@@ -19,6 +19,7 @@ maintainers:
 properties:
   compatible:
     enum:
+      - jedec,ddr4-channel
       - jedec,lpddr2-channel
       - jedec,lpddr3-channel
       - jedec,lpddr4-channel
@@ -61,6 +62,15 @@ patternProperties:
       - reg
 
 allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: jedec,ddr4-channel
+    then:
+      patternProperties:
+        "^rank@[0-9]+$":
+          $ref: /schemas/memory-controllers/ddr/jedec,ddr4.yaml#
   - if:
       properties:
         compatible:

-- 
2.43.0


