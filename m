Return-Path: <linux-kernel+bounces-771221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC4ABB28443
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 18:52:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41C711CE34CA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 16:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFE91302770;
	Fri, 15 Aug 2025 16:47:21 +0000 (UTC)
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A870C257855
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 16:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755276441; cv=none; b=SoetKXNmQMbfJNx9MgNcTBZUzEJ+jQRhz17y2ADK/3P1mpyouH7EmQtoelFoX1CFoMtnLDcxCrFZsdg8kFlncF3q1RqAjthx16s6fhzwajPchHU4Ikg37CvnTArQ5CaBAkydQK6LbJFM9S6A5mZHYE2F2F0tNUfv1EVx2mGlnxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755276441; c=relaxed/simple;
	bh=j/9cuIbYu6W4c22f86c6VTEKRD+z+7bxqk9N2+RmlZE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SUgiqRYwwiUjZg511b/E0MKrYeMMUNtCnHx5K04m6nXHATyxjforzdP3XVYONCGSbBd3Fa4JjGaUPf1l0eS7y2zUE//xDJYzuni6sl2pZTdUa6g9GK/MQyO2FuwlY5bda9HvDPonqvw753xq069quvxPAw9u+5Ql7MQY4xnNae8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=watter.com; spf=pass smtp.mailfrom=linux.dev; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=watter.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ben Collins <bcollins@watter.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Hepp <andrew.hepp@ahepp.dev>
Cc: Ben Collins <bcollins@watter.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] dt-bindings: iio: mcp9600: Add compatible for microchip,mcp9601
Date: Fri, 15 Aug 2025 16:46:03 +0000
Message-ID: <20250815164627.22002-2-bcollins@watter.com>
In-Reply-To: <20250815164627.22002-1-bcollins@watter.com>
References: <20250815164627.22002-1-bcollins@watter.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The mcp9600 driver supports the mcp9601 chip, but complains about not
recognizing the device id on probe. A separate patch...

	iio: mcp9600: Recognize chip id for mcp9601

...addresses this. This patch updates the dt-bindings for this chip to
reflect the change to allow explicitly setting microchip,mcp9601 as
the expected chip type.

The mcp9601 also supports features not found on the mcp9600, so this
will also allow the driver to differentiate the support of these
features.

Signed-off-by: Ben Collins <bcollins@watter.com>
---
 .../bindings/iio/temperature/microchip,mcp9600.yaml         | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/temperature/microchip,mcp9600.yaml b/Documentation/devicetree/bindings/iio/temperature/microchip,mcp9600.yaml
index d2cafa38a5442..d8af0912ce886 100644
--- a/Documentation/devicetree/bindings/iio/temperature/microchip,mcp9600.yaml
+++ b/Documentation/devicetree/bindings/iio/temperature/microchip,mcp9600.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/iio/temperature/microchip,mcp9600.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Microchip MCP9600 thermocouple EMF converter
+title: Microchip MCP9600 and similar thermocouple EMF converters
 
 maintainers:
   - Andrew Hepp <andrew.hepp@ahepp.dev>
@@ -14,7 +14,9 @@ description:
 
 properties:
   compatible:
-    const: microchip,mcp9600
+    enum:
+      - microchip,mcp9600
+      - microchip,mcp9601
 
   reg:
     maxItems: 1
-- 
2.50.1


