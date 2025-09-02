Return-Path: <linux-kernel+bounces-795958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD0BFB3F9F8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 11:15:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73D2A3ADA11
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 09:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EE9927146D;
	Tue,  2 Sep 2025 09:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dFIK/AQg"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA8719D06B
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 09:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756804542; cv=none; b=bbIIXMn46XWQWMewuVcrHcSsHgGjX81SupUbl6fAmzmcjGUeuD/rZhD4ejecwx/S0x5gWiKwh26DulsEgFRkbtmZbidDNqy0MM148eYJMJemIpV3ZAaufT11Xqu6bsYgkj9dT2ZMBsMXaitQ5T2loq0MBSEzDBkCe98S80fuEv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756804542; c=relaxed/simple;
	bh=omOLYYYjh3z0DVh1O46NQbX5aRk5HswOved29mAUMag=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tpTVL9SeXHIeVbYcLgxoamh66GsG198uiyuNBFwknITkGGRu56k1d2Nx4U/9Xns2BHIUVv1FXo8LSVvYzq8ZKqrHCQHSmB6zDOxjB4FC0QbDwOp8/PoyTSuoIvSPCSe0OKoZr5uqhtEbusevifFB/eV6hEYOVGG5wLDmTK3e0YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dFIK/AQg; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b041b155a6dso23198366b.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 02:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756804540; x=1757409340; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=m/8bnMdkcwBrzdormqUmLTK3k80g92+lN3p1s60KZ+k=;
        b=dFIK/AQgLm7+RhvU01FSTZ87yUpnZpvR3a4PbrcQtUjFxiOnxNvCPv5VATP8qpUNdS
         9+Pgkl2IJK08lDRWovSnq5KkWAGkZQucyhOMEb+5ux34ooFo9pjI0bAxzYMyNRGFuqCo
         HxuLXlxfG1xuNd9s1EDVtyr36jLqJ7WDG3V33PyNXV0t/FHwxzXN2QL1ZJKiZ1vf9zNp
         8F4H0VuVHeZFawqz/uO9BWko1CgXJIrtqCAEikjBvqpQISKmZDUZFXFZ8Z01oB2GVn/V
         x5c5TuJfcFvdobQcqyu8kntFp8JzU5BGC23A+m8Fsx1wKJZK6SWITknua2jwMZMYWrsR
         eCTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756804540; x=1757409340;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m/8bnMdkcwBrzdormqUmLTK3k80g92+lN3p1s60KZ+k=;
        b=oqzoLzUjr0NzIzX6aq+7OxbKpZlxJD6WWjgJfAl0VDr0ZQbZ7uOFU1STL7KQNmsQqH
         opQvO3BB+tkvxxFZWhxbtoiaiAHzLAz8xJBxIubt2Igq5IqKr8D+ypjxMuylm2kreowq
         kjWvCQ6l93f8OqvMTpoFXbh1sgpQT/ijca5VwLhHS3fbUsVz7Um7sPbEmmx2dStU7OoX
         98fTTG0v/GMTHsOjccG6QAVzQcCMrHDy/FinDEFUrT5fMxIYi95ZKpQhxY3yodGWJ67n
         Vc3eqnWLHFCLVbaccbOj7gggywHZ3Tu4F4QnfeDWSK4B44FNrkJc+21Lnvth+n0+Tmek
         ByfA==
X-Forwarded-Encrypted: i=1; AJvYcCWiK/wXdeGrNmQotmAr/cxZ9qKxFUI7Fk6B5ga/Ly1rZYMjqlOoRyQXIUcHbUJ6+3g2Wes0nK4PkrKEMUw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOCSFSVzDhXUzOlL6rpT9NwIiZgtgaOZ+eY6xZooneTmKD6E4t
	veqhFjLj5EbRDdv1DECqu1XHxww79OcOohcHl3rKd/MVnORZi0/pHNAFomhdUPTM5eQ=
X-Gm-Gg: ASbGncuNeIo6ztAsy6O6Nd1zuaikx2E+r+M1z7TTgOyY1X4rAo+Vf/N6+W9CIyjUIHn
	Z29Xk4WkWadoV6IvTdY0WZiRYnWlKx5/O/2F+Urmn7TI1n+8pkT24S/1mWlmFWp47YrzZccnGYO
	+FzAcW1+hIURGgTVLh2aLo/gx+jYR7JNZJGGvYakwYD4L+zFEQv2AVv5JThtRyCy6/0t7tNzkY3
	+Tcqd84ZjJgUNzLJNimZTogJv9ijTfkeCnH4Tpuvq2FSSxmgcv+/mPg5LW+lPbCDWIwPSceXznH
	pONvuOyIJU2XqetlDKUPTjSr47hkea+gzjvCc8j0heUxGEiTZ3txIQiucn3/o9Toseejvvz4y5P
	I5RyfuGC2ZjRqTzhcfjkJNHx0pRdiDUk3GXF/IlmlAjST/jD+Lk/b7Ag=
X-Google-Smtp-Source: AGHT+IGsSFPfLqX1TSTY7vx9/w5ZifFk746DiQHROlsIAv27SMqvJyUuB9Px6z4DG9dMMXNer8ncTw==
X-Received: by 2002:a17:907:95a2:b0:b01:989f:46d0 with SMTP id a640c23a62f3a-b0198ae8b17mr566468666b.11.1756804539611;
        Tue, 02 Sep 2025 02:15:39 -0700 (PDT)
Received: from kuoka.. ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aff15fccb15sm877008866b.98.2025.09.02.02.15.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 02:15:38 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Matthew Gerlach <matthew.gerlach@altera.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Romain Gantois <romain.gantois@bootlin.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH net-next 1/2] dt-bindings: net: altr,socfpga-stmmac: Constrain interrupts
Date: Tue,  2 Sep 2025 11:15:27 +0200
Message-ID: <20250902091526.105905-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=912; i=krzysztof.kozlowski@linaro.org;
 h=from:subject; bh=omOLYYYjh3z0DVh1O46NQbX5aRk5HswOved29mAUMag=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBotrWu6Rq20SlnUGOaA358hH5nv1fnKm5T701YM
 YgxMdCPxreJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaLa1rgAKCRDBN2bmhouD
 100DD/9FY3aTCBs5BXmVSlnhJDkPZWHvDYOPI4Ae46T6toYdFe0oHBCT1ivV3pDoDGSKU73VZdG
 4E82JAx/MwQyjQ4F4iyK/iN6J1wXAQ6i61V+oYGoyKS+lR4eroU9Dx8odZXyXbdyVq3lU3sO+MG
 TDML8f+YKLY/tOdjh+vJcUU+n7Ipf9HjXQKFVmWNzWlcopnWLu+hCztmEm523MO/p1nwr7EbwzS
 AE+Q93zwfJEIQvKPuS9HS1E/MCAEVvrv+j8hvLkvmDxui+woZc/NUr111q/CmX1NgYQVyjmtExN
 /BwHQi0xOsvXemvA1ABLngFYG/dTIRx8KEfwl6pEKcqZj6MZrsUok0KLHgP0q0yP0RJEGikumsY
 mXQV/LE1skdf/aP0YwXf/b6CQ7zUG+u7gs7mGvZhYthkIhPxlmSbMsX/+TsZYDGTLu/qSfQYuT5
 WVsC78X2Hv5kVCE3+9mfwv4cuAU8quFWeKWOzdzIvNMX63WhjHv+91/WFpl17WfG6XXdGSlgztf
 R5hp2f+n5jEtt0OlSWeRqSWMezS3EsPt0fbsgR8Jub4XEpAM22Xh5X9nBqMYS2HEBd+j7hbvtib
 2d7ORY8wvGFU4MGzahiBEwPT0rO4qhj4XqcoWUECr78rM46doe2LQeEOP2JfNG/jl5b4jREKBwl 30tClks5II7F44g==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit

STMMAC on SoCFPGA uses exactly one interrupt in in-kernel DTS and common
snps,dwmac.yaml binding is flexible, so define precise constrain for
this device.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/net/altr,socfpga-stmmac.yaml       | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/altr,socfpga-stmmac.yaml b/Documentation/devicetree/bindings/net/altr,socfpga-stmmac.yaml
index 3a22d35db778..fc445ad5a1f1 100644
--- a/Documentation/devicetree/bindings/net/altr,socfpga-stmmac.yaml
+++ b/Documentation/devicetree/bindings/net/altr,socfpga-stmmac.yaml
@@ -62,6 +62,13 @@ properties:
       - const: stmmaceth
       - const: ptp_ref
 
+  interrupts:
+    maxItems: 1
+
+  interrupt-names:
+    items:
+      - const: macirq
+
   iommus:
     minItems: 1
     maxItems: 2
-- 
2.48.1


