Return-Path: <linux-kernel+bounces-825324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC963B8B8E1
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 00:47:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC68017EDD5
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 22:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A670F2D77E6;
	Fri, 19 Sep 2025 22:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AKL4e6fV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40B232A3CA;
	Fri, 19 Sep 2025 22:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758321289; cv=none; b=bjyn3zS/+gy+3KUXH8koCCTqmjvfgOxkEXu+KNE9FdKKq+e5eUyeokHjrld7eT/HjRTLvlRph43qu2Em1V2o3dGnDLwSYgmw263HQneI6/fOttCpjF9OZucn4X8yzAKv5JC4GGGx4jqmgG8eH0Jd5eZVvMlIBZ7+OemiumJavHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758321289; c=relaxed/simple;
	bh=pYLoNgMidqoPA+pyKlpkhsB3Kchs1+7arq7vkX+0Me8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d5/1xFUJpRcpcK0Y3dpdwLftymw0e7nTAGLgUX0pXlVHBe0rP8Ku1JBDLK0xYKXM3tZzLOhLyrcOTLegaOxRq0/pFZYki1zvckrqb6wmIw18JsoBU2Yrt1bIHgTkvnTtcB5AJTfSo3PXhRlV/diPwajhJTs47L3YWt+fh/5gEqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AKL4e6fV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EF56C4CEF0;
	Fri, 19 Sep 2025 22:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758321287;
	bh=pYLoNgMidqoPA+pyKlpkhsB3Kchs1+7arq7vkX+0Me8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AKL4e6fV7jVmx/dekM+t7N6BmieZNrfI16Uv6QOw6+YRnZwNHtf/vvFjIbQx9efUH
	 drTd8sERPEF1eqkGeIMfD7l05ULNZetNIGFZSPgnqsP7UXOmZzPv5gC14o8scHK9Kg
	 ZoUMniXQ15dDRmk6Tj33Dn69Xx3+b+tn1WlAk3H8rUVjfmKgqysYtNkzs30XXJX7Az
	 eJeorRsLwo16Z9QjuNgJkUz+wKhELlRUI5A0KJb/ZRBAihlC6vcnNw7EdXNH3GWK4m
	 NVenv0GURdajvaCxeAwUcyX4eGfb6z3OukRLKRJUToqkpBY5Xd6SzRv9D81Az9gY39
	 c0bJZX1WImCqg==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Mathias Nyman <mathias.nyman@intel.com>
Cc: linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] dt-bindings: usb: xhci: Add "generic-xhci" compatible for Marvell Armada 37xx/8k
Date: Fri, 19 Sep 2025 17:34:32 -0500
Message-ID: <20250919223433.2399927-2-robh@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250919223433.2399927-1-robh@kernel.org>
References: <20250919223433.2399927-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Marvell Armada 37xx and 8k platforms compatible property don't
match the binding schema. They are compatible with the "generic-xhci"
compatible. The 37xx does have a quirk for "reset on resume", but that's
probably not required to function in all situations.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 Documentation/devicetree/bindings/usb/generic-xhci.yaml | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/generic-xhci.yaml b/Documentation/devicetree/bindings/usb/generic-xhci.yaml
index 8875911b43cc..62678abd74b5 100644
--- a/Documentation/devicetree/bindings/usb/generic-xhci.yaml
+++ b/Documentation/devicetree/bindings/usb/generic-xhci.yaml
@@ -14,12 +14,15 @@ properties:
     oneOf:
       - description: Generic xHCI device
         const: generic-xhci
-      - description: Armada 37xx/375/38x/8k SoCs
+      - description: Armada 375/38x SoCs
         items:
           - enum:
-              - marvell,armada3700-xhci
               - marvell,armada-375-xhci
               - marvell,armada-380-xhci
+      - description: Armada 37xx/8k SoCs
+        items:
+          - enum:
+              - marvell,armada3700-xhci
               - marvell,armada-8k-xhci
           - const: generic-xhci
       - description: Broadcom SoCs with power domains
-- 
2.51.0


