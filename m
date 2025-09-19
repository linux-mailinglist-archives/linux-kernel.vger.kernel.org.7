Return-Path: <linux-kernel+bounces-825325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C81BB8B8ED
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 00:48:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39CA15848EF
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 22:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 080282DC342;
	Fri, 19 Sep 2025 22:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J30bSFg3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DAB9274FEF;
	Fri, 19 Sep 2025 22:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758321340; cv=none; b=oVjV+uOrozt4mRkBAp9tCoYR6wTHWouX22qOudQ380v/frzPUcpHVycr1Yptd7VCzGeLDN4PJNG+LX5unhFMJXT52+TIadA4+eT9Gey/ncIH5/6o81m2CSRy9gK082T2ebEn0YhOz2SGxV2wMF195WPtJkqPp5o8wMwIBGKfYCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758321340; c=relaxed/simple;
	bh=6iQk1TtqMRnZxTDnUsr/4j1QRzY2aHmtxH2BaQcgA7o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VsIBbpxK/VpMk0/FFQ6rJGSzH2w4ElF6vNKnfoR8gkmzwREFgTeglJnU8RWdW5CFy/G0A7EG+e1ZnDeUBCorQ4mgVLu9LuqM/Q/aDYPQNwC0s74RM6IAT7QRp48pY+et7OUJQW2QLfw5/31wKlc1w0/SohmStDpMyCK5XzLB+cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J30bSFg3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69BF6C4CEF0;
	Fri, 19 Sep 2025 22:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758321339;
	bh=6iQk1TtqMRnZxTDnUsr/4j1QRzY2aHmtxH2BaQcgA7o=;
	h=From:To:Cc:Subject:Date:From;
	b=J30bSFg3lEWjYKAzl21JfmrrvhZGn7M1cbR0NkpePEr+T4/Cj5xf5Kyy6ghNYpLcP
	 9mxg1ZmTzNW9e+b991IqeAdGFKuW6ahHAPJKwfr+WTDbJXEtgJ2aIPCrSAA/rFCxna
	 ph7xYmrcezcHsV6EsTmhGoF+h3bOCotX+DtHMd3bf38RPN3XGCOCXdZD66YaHY9I3/
	 uvjLFGa6lW7x52/ihcl5kuUF2CwtIACObokJh8DZJmK3/kmSVjZtJhGSZFSkNNknfJ
	 4sHidVVrSKAnRMuExccBFdsQMtZToKwWVFq+xoVyP0zs4VanP+pK9OBLLcj1cJzWqC
	 OC3JY7S/fhkBg==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-ide@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: ata: apm,xgene-ahci: Add apm,xgene-ahci-v2 support
Date: Fri, 19 Sep 2025 17:35:31 -0500
Message-ID: <20250919223532.2401223-1-robh@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The "apm,xgene-ahci-v2" compatible has been in use for a long time, but
was undocumented. It doesn't require clocks or phys.

Remove the "apm,xgene-ahci-pcie" compatible which isn't used anywhere
while we're here.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../bindings/ata/apm,xgene-ahci.yaml          | 21 ++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/ata/apm,xgene-ahci.yaml b/Documentation/devicetree/bindings/ata/apm,xgene-ahci.yaml
index 7dc942808656..dc631381f9e1 100644
--- a/Documentation/devicetree/bindings/ata/apm,xgene-ahci.yaml
+++ b/Documentation/devicetree/bindings/ata/apm,xgene-ahci.yaml
@@ -9,14 +9,11 @@ title: APM X-Gene 6.0 Gb/s SATA host controller
 maintainers:
   - Rob Herring <robh@kernel.org>
 
-allOf:
-  - $ref: ahci-common.yaml#
-
 properties:
   compatible:
     enum:
       - apm,xgene-ahci
-      - apm,xgene-ahci-pcie
+      - apm,xgene-ahci-v2
 
   reg:
     minItems: 4
@@ -35,12 +32,22 @@ properties:
 
 required:
   - compatible
-  - clocks
-  - phys
-  - phy-names
 
 unevaluatedProperties: false
 
+allOf:
+  - $ref: ahci-common.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: apm,xgene-ahci
+    then:
+      required:
+        - clocks
+        - phys
+        - phy-names
+
 examples:
   - |
     sata@1a400000 {
-- 
2.51.0


