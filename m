Return-Path: <linux-kernel+bounces-766958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C63CFB24D27
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 17:20:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F265316062E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 15:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BF7B1F12E0;
	Wed, 13 Aug 2025 15:17:00 +0000 (UTC)
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5230A930
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 15:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755098219; cv=none; b=iWQ/1jI9jBZIjxOfXhOllEfeyV58+deV1wrsyebdHvr7OcZtMIL8hXBRUH62WfyFXX3RitlkonV/Io2Nyjq9GdEMu6v0Jh+43xRz/mBdjdupcfMA7myM3sKbDcBYpiWFfJlr+6Wa+3hUJuyG8QTkbBIOxzqKi59eCPQ7CAG/In0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755098219; c=relaxed/simple;
	bh=oKp2lZiQ3oJCMCm9FxULdr589AuLvdQ0SykmCkbL7OI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P5AoQp/MBXzz52fKFE0F6ngL2v+F4dZzKoTxe8dEdOsKTbwdMP64Y2V4nShip91aTWWbPnZU4YRHGB5jjEfrmcA8mnfYnHroz9KhD15sAhiHPst6B0eMiLe4bDFuuX2BbSZEq1G3ed4uxT6MdC5QDiZMGeSzy/nE9u/juIYGVn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=watter.com; spf=pass smtp.mailfrom=linux.dev; arc=none smtp.client-ip=91.218.175.183
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
Subject: [PATCH v2 1/5] dt-bindings: iio: mcp9600: Add compatible for microchip,mcp9601
Date: Wed, 13 Aug 2025 15:15:51 +0000
Message-ID: <20250813151614.12098-2-bcollins@watter.com>
In-Reply-To: <20250813151614.12098-1-bcollins@watter.com>
References: <20250813151614.12098-1-bcollins@watter.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

MCP9601 is a superset of MCP9600 and is supported by the driver.

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


