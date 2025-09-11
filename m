Return-Path: <linux-kernel+bounces-812101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 027FBB532EF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 14:59:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A746517E33F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 12:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 022FD322DC1;
	Thu, 11 Sep 2025 12:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NEd3t2N8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D9621C19D;
	Thu, 11 Sep 2025 12:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757595529; cv=none; b=TWuQSQMIBHBtwMSjTQ6+LP2XWs809IN9FKDNpeBWiZht8uU2RcpBGWa3mh2yX5ldnzzsr7Vso50lADAuIQ9pAPkjRj6FluIX64Qq2PYoZSanHHZRjONIchiHPo3Oi3LByRaDB95lGPZL2hNlGKTTM8exjuDrZy5ZEg9HjKGo4nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757595529; c=relaxed/simple;
	bh=vNvz0oHUFm5Tv/ZzBsnF5598LeY3d3ai/hYAKXAfgJc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Dwpmg/5xECTU32VkLjckIk1Znj7a8ZEEkw/rHP6ejMOz5zWY5Jf302nb9iQOijyxcAWhBRFddiPvk64ZjEr1yV69B1JDNyno32ziAgIgskK2xZmjdlPuJBIUaO6bPEehL+doX6DGt6VV/iZny0ElQdysPn7HgvMYwwD2tVWom4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NEd3t2N8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 064ABC4CEF7;
	Thu, 11 Sep 2025 12:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757595529;
	bh=vNvz0oHUFm5Tv/ZzBsnF5598LeY3d3ai/hYAKXAfgJc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=NEd3t2N8EBJr+MMaI+Z4Eh9SZThdKfW4qFHYCb+du4i2ZWHkR67pqlNkx6Z1fURaG
	 /CklzYtmU1tLakVvnrzzOcuUwBN00N/b02lNHG/xLe21YdCNUmJpAxlG8JwCYQANQX
	 F3MVxar9FbeLN4hCDUTLxTWQyTJ76H9JKqFagXa6B5o1Re/wnoDwnq4IBbczM/MrFA
	 oonsUiKjXz7/70EEvtvpV0VSGDlAViX5XZbJ+iYgkN/lTu4nBeV0tuzrFDeKnaooYZ
	 BgaZT9h6b7b4srt3vmPIHoZi3lDTtTWRjINpm9NwjIs193cGSzlxlup4OMxEF4tcys
	 R+Z+gBH4Tvfdw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA55ECAC58E;
	Thu, 11 Sep 2025 12:58:48 +0000 (UTC)
From: Alejandro Enrique via B4 Relay <devnull+alejandroe1.geotab.com@kernel.org>
Date: Thu, 11 Sep 2025 14:58:28 +0200
Subject: [PATCH v3 1/2] dt-bindings: gnss: u-blox: add "safeboot-gpios"
 binding
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250911-ubx-safeboot-v3-1-32fe6b882a3c@geotab.com>
References: <20250911-ubx-safeboot-v3-0-32fe6b882a3c@geotab.com>
In-Reply-To: <20250911-ubx-safeboot-v3-0-32fe6b882a3c@geotab.com>
To: Johan Hovold <johan@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Alejandro Enrique <alejandroe1@geotab.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757595528; l=1952;
 i=alejandroe1@geotab.com; s=20250514; h=from:subject:message-id;
 bh=1ldch3c4U2m2MqNI+Cr7cERTwlAa2OI1tnsluUcBNnI=;
 b=pFXFeRqnm3Od9CO9o83iea3ZVX1+/GHp5vN85DN49o/G5Ox9Yo4l1kn7qKQ03osft92s/8LHg
 bIyagquwKIPC3y2+ZJr6w2g1j6JZ6nUkTfcKCGwxs0LKbPT7j7qD5rt
X-Developer-Key: i=alejandroe1@geotab.com; a=ed25519;
 pk=xzHMPbqczL/tMsjXr26iLoHwIzLveHVnT+GIU4p1k38=
X-Endpoint-Received: by B4 Relay for alejandroe1@geotab.com/20250514 with
 auth_id=404
X-Original-From: Alejandro Enrique <alejandroe1@geotab.com>
Reply-To: alejandroe1@geotab.com

From: Alejandro Enrique <alejandroe1@geotab.com>

U-Blox 8/M8/M9 chip have a pin to start it in safeboot mode, to be
used to recover from situations where the flash content has become
corrupted and needs to be restored. Introduce a binding to support
this safeboot pin.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Alejandro Enrique <alejandroe1@geotab.com>
---
 .../devicetree/bindings/gnss/u-blox,neo-6m.yaml      | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/gnss/u-blox,neo-6m.yaml b/Documentation/devicetree/bindings/gnss/u-blox,neo-6m.yaml
index c0c2bfaa606fb01f7efee1ce7e5d30b1640783f3..44c9421cbe0b377661ef99a9e8c0dcebf3f9c894 100644
--- a/Documentation/devicetree/bindings/gnss/u-blox,neo-6m.yaml
+++ b/Documentation/devicetree/bindings/gnss/u-blox,neo-6m.yaml
@@ -6,10 +6,6 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: U-blox GNSS Receiver
 
-allOf:
-  - $ref: gnss-common.yaml#
-  - $ref: /schemas/serial/serial-peripheral-props.yaml#
-
 maintainers:
   - Johan Hovold <johan@kernel.org>
 
@@ -36,6 +32,9 @@ properties:
   reset-gpios:
     maxItems: 1
 
+  safeboot-gpios:
+    maxItems: 1
+
   vcc-supply:
     description: >
       Main voltage regulator
@@ -53,6 +52,18 @@ required:
   - compatible
   - vcc-supply
 
+allOf:
+  - $ref: gnss-common.yaml#
+  - $ref: /schemas/serial/serial-peripheral-props.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: u-blox,neo-6m
+    then:
+      properties:
+        safeboot-gpios: false
+
 unevaluatedProperties: false
 
 examples:
@@ -65,5 +76,6 @@ examples:
             v-bckp-supply = <&gnss_v_bckp_reg>;
             vcc-supply = <&gnss_vcc_reg>;
             reset-gpios = <&gpio 1 GPIO_ACTIVE_LOW>;
+            safeboot-gpios = <&gpio 2 GPIO_ACTIVE_LOW>;
         };
     };

-- 
2.34.1



