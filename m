Return-Path: <linux-kernel+bounces-720391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F20AEAFBB09
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 20:45:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B058189E287
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 18:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FC86265281;
	Mon,  7 Jul 2025 18:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=netcube.li header.i=@netcube.li header.b="G7i+/20f"
Received: from mail.netcube.li (mail.netcube.li [173.249.15.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCCFD265631;
	Mon,  7 Jul 2025 18:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.249.15.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751913894; cv=none; b=GRG7CgLEUOn1NQ7S0z9Om99ndcEnp09RGoX9TdqR+bqurMfqcT+ml7IFfrD/OAoKlLylBS6gBO9n7/Ak1snkV4dodIBim9CSf5P5L5EcJrmG/wR6CabmRoa+ycDwSzK6PQxQXxuXHhEtqNkT7kR+5qfOEdjK9FE2RktU0EsQAOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751913894; c=relaxed/simple;
	bh=LiItecIz2CKXaIRb8e9S2YFmXeiRt9ltTALDdhpunqo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ESwVIY1wj3PxEJw565F/uACdaxGfIsF3Wiy+xa6ZszwLvKoTSkZKrrIbS2uwiKCBEKO+UGq8ZG5cOgZinR1a7yiRikzw979kgUMkSXmF5FgEpowsXfFJN6ETW3x9L90e9gSieSsQNwUSRvkucSj7hc9BecBRq+UqvyvPiHY46EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=netcube.li; spf=pass smtp.mailfrom=netcube.li; dkim=pass (1024-bit key) header.d=netcube.li header.i=@netcube.li header.b=G7i+/20f; arc=none smtp.client-ip=173.249.15.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=netcube.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netcube.li
dkim-signature: v=1; a=rsa-sha256; d=netcube.li; s=s1;
	c=relaxed/relaxed; q=dns/txt; h=From:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Transfer-Encoding:In-Reply-To:References;
	bh=YDfXJU8fIVQMbHdyhBrUiSya/JtiQ768dcd2UAeGU6M=;
	b=G7i+/20fh1lQeZ9sxZiq10ZRqXvh2uGL4Yk7hQFsw+++QqXwSM/O1bZEFhOywNP4SrHlqYUZKeU2Z+YxvPtV5WGTF20Fhxw/gdfYEjHq34iCDet8c7ufqmtvM30mdAV4wJkfDX6+HqvTiYEsGLwiHEjRL+XZRgF9NbJ9dcwOsUc=
Received: from lukas-hpz440workstation.lan.sk100508.local (cm70-231.liwest.at [212.241.70.231])
	by mail.netcube.li with ESMTPA
	; Mon, 7 Jul 2025 20:44:43 +0200
From: Lukas Schmid <lukas.schmid@netcube.li>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Maxime Ripard <mripard@kernel.org>
Cc: Lukas Schmid <lukas.schmid@netcube.li>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH v3 1/5] dt-bindings: arm: sunxi: Add NetCube Systems Nagami SoM and carrier board bindings
Date: Mon,  7 Jul 2025 20:44:13 +0200
Message-Id: <20250707184420.275991-2-lukas.schmid@netcube.li>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250707184420.275991-1-lukas.schmid@netcube.li>
References: <20250707184420.275991-1-lukas.schmid@netcube.li>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The NetCube Systems Nagami is an System on Module base on the Allwinner
T113s SoC. It is intended to be used in low cost devices which require
simple layouts and low BOM cost.

The NetCube Systems Nagami Basic Carrier Board is a simple carrier for the
Nagami SoM. It is intended to serve as a simple reference design for a
custom implementation or just evaluating the module with other peripherals

The NetCube Systems Nagami Keypad Carrier is a custom board intended to
fit a standard Ritto Intercom enclosure and provides a Keypad, NFC-Reader
and Status-LED all controllable over Ethernet with PoE support.

Signed-off-by: Lukas Schmid <lukas.schmid@netcube.li>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/arm/sunxi.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/sunxi.yaml b/Documentation/devicetree/bindings/arm/sunxi.yaml
index 7807ea613..50f08d8d2 100644
--- a/Documentation/devicetree/bindings/arm/sunxi.yaml
+++ b/Documentation/devicetree/bindings/arm/sunxi.yaml
@@ -599,6 +599,14 @@ properties:
           - const: netcube,kumquat
           - const: allwinner,sun8i-v3s
 
+      - description: NetCube Systems Nagami SoM based boards
+        items:
+          - enum:
+              - netcube,nagami-basic-carrier
+              - netcube,nagami-keypad-carrier
+          - const: netcube,nagami
+          - const: allwinner,sun8i-t113s
+
       - description: NextThing Co. CHIP
         items:
           - const: nextthing,chip
-- 
2.39.5



