Return-Path: <linux-kernel+bounces-776674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C12F2B2D04D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 01:45:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABA2C52541C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 23:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71DB0274FD3;
	Tue, 19 Aug 2025 23:45:12 +0000 (UTC)
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E78202983
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 23:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755647112; cv=none; b=oIk0SdxnriABCtFSfKD1bjGTli8PH4pDb9dthbvZ3/l6a4H0dMiPf5kSyEE2De91nft+V6Cm42tgaKbVS/yOhqDYmj8lN5YA0O4vzl323yPNCYy6UVmlrgV9fU1JQXUWmpDQm1nAa8Bz95uS/U2DBfz4rb2U3eKbnl6vGaWF2o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755647112; c=relaxed/simple;
	bh=/5Qtbn84a3q2G22OYT50NIOuv5L248mFrhlqJeRA2dk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KZ/DZpNsUOEV659ApCtx+HYwY/maYDm2A9OYLTaeKEbpjSx2BEfwwXWPt7PsUJtJTT7ZlyZMcgP/1KKHjfaKdqq1gcVzsgIX3Xpr2PgxMsOUxGkqRmXkrKv658IDFfbY+2kuT5Yx5O+fptDRO90eq9YnM2g1sV0QmshF3MIoyGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=watter.com; spf=pass smtp.mailfrom=linux.dev; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=watter.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ben Collins <bcollins@watter.com>
Date: Tue, 19 Aug 2025 19:44:42 -0400
Subject: [PATCH v7 1/5] dt-bindings: iio: mcp9600: Set default 3 for
 thermocouple-type
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250819-upstream-changes-v7-1-88a33aa78f6a@watter.com>
References: <20250819-upstream-changes-v7-0-88a33aa78f6a@watter.com>
In-Reply-To: <20250819-upstream-changes-v7-0-88a33aa78f6a@watter.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Andrew Hepp <andrew.hepp@ahepp.dev>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Ben Collins <bcollins@watter.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Migadu-Flow: FLOW_OUT

As is already documented in this file, Type-K is the default, so make
that explicit in the dt-bindings.

Signed-off-by: Ben Collins <bcollins@watter.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/iio/temperature/microchip,mcp9600.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iio/temperature/microchip,mcp9600.yaml b/Documentation/devicetree/bindings/iio/temperature/microchip,mcp9600.yaml
index d2cafa38a544..57b387a1accc 100644
--- a/Documentation/devicetree/bindings/iio/temperature/microchip,mcp9600.yaml
+++ b/Documentation/devicetree/bindings/iio/temperature/microchip,mcp9600.yaml
@@ -37,6 +37,7 @@ properties:
 
   thermocouple-type:
     $ref: /schemas/types.yaml#/definitions/uint32
+    default: 3
     description:
       Type of thermocouple (THERMOCOUPLE_TYPE_K if omitted).
       Use defines in dt-bindings/iio/temperature/thermocouple.h.

-- 
2.39.5


