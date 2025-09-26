Return-Path: <linux-kernel+bounces-834675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A60BA53E2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 23:47:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10FEB7A760A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 21:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6471C28B400;
	Fri, 26 Sep 2025 21:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="biekYPST"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD091A2C11;
	Fri, 26 Sep 2025 21:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758923264; cv=none; b=aVAEgcJSTIcdVDAo5ehWHnzOovJkCizkgg4JMwWZmJ45UR5yzZZIwJOM4NM8Or0j6bnt/SN0tONBz9i7uiAXfTCbBdyTsf+Q/+BZCAGDAYgS5Tdu3rfN5e2oqZqefCxffMZw25HIEqdxcg542J7gZlrem0mRNdqQzX1meqxvjpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758923264; c=relaxed/simple;
	bh=HxA4FWs1OVb9xwYCnwSfOJqJ121/RwPpT+3Ri5D0jU8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C6WT3z6q2nAPm2Te3UbCajDmSsSAPn+DILQld3g45nu69csAWgo4gYzArYNRIFhlsUpPUESTB2XiZghYe8ORcDqTAcMT1HKW5NswI6Lsg2kYLu1vmWRajOAyf3NHfkUc7vFEN+Yf8syLzGoXONmkF8NRjHNCye23ow+bNyJatOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=biekYPST; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26EB2C4CEF4;
	Fri, 26 Sep 2025 21:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758923264;
	bh=HxA4FWs1OVb9xwYCnwSfOJqJ121/RwPpT+3Ri5D0jU8=;
	h=From:To:Cc:Subject:Date:From;
	b=biekYPSTQA/QwRF8LwegMBnFtdAvJ4AOLx21C5we6QfW77y5R8SO0VMSlqnfWnj76
	 JHnus3EZDzUfSTs6iVkgUKz2Ey/eF0V+Nz5lcvJ32r097m/H7E+EWz/31WEdae4gN8
	 pHze25lRxGNsh8TcOhS+htFc+3zgSG1yef5neG0Wqg0TYJYf7zhrBTo2yrrGDOtoGg
	 mWsKYcMmfKWraFiHL5CXqeIZEa6eZ8n7YNezbMtJiFZlTIjO3E1Bj0bRTNKMneAIRT
	 NeYmqYEZ695eGn8Bc7ckkZ8M+/s+u4njI5kZHWY4Y8AoBrR4b/qSRx6Uzq4GtX2uzd
	 SF3NkZ039JZgw==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthew Gerlach <matthew.gerlach@altera.com>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: arm: altera: Drop socfpga-sdram-edac.txt
Date: Fri, 26 Sep 2025 16:47:37 -0500
Message-ID: <20250926214738.1791368-1-robh@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The contents of arm/altera/socfpga-sdram-edac.txt are already covered by
edac/altr,socfpga-ecc-manager.yaml except for the "altr,sdram-edac"
compatible string. Add the compatible and drop the old .txt binding doc.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../bindings/arm/altera/socfpga-sdram-edac.txt    | 15 ---------------
 .../bindings/edac/altr,socfpga-ecc-manager.yaml   |  1 +
 2 files changed, 1 insertion(+), 15 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/altera/socfpga-sdram-edac.txt

diff --git a/Documentation/devicetree/bindings/arm/altera/socfpga-sdram-edac.txt b/Documentation/devicetree/bindings/arm/altera/socfpga-sdram-edac.txt
deleted file mode 100644
index f5ad0ff69fae..000000000000
--- a/Documentation/devicetree/bindings/arm/altera/socfpga-sdram-edac.txt
+++ /dev/null
@@ -1,15 +0,0 @@
-Altera SOCFPGA SDRAM Error Detection & Correction [EDAC]
-The EDAC accesses a range of registers in the SDRAM controller.
-
-Required properties:
-- compatible : should contain "altr,sdram-edac" or "altr,sdram-edac-a10"
-- altr,sdr-syscon : phandle of the sdr module
-- interrupts : Should contain the SDRAM ECC IRQ in the
-	appropriate format for the IRQ controller.
-
-Example:
-	sdramedac {
-		compatible = "altr,sdram-edac";
-		altr,sdr-syscon = <&sdr>;
-		interrupts = <0 39 4>;
-	};
diff --git a/Documentation/devicetree/bindings/edac/altr,socfpga-ecc-manager.yaml b/Documentation/devicetree/bindings/edac/altr,socfpga-ecc-manager.yaml
index ec4634c5fa89..3d787dea0f14 100644
--- a/Documentation/devicetree/bindings/edac/altr,socfpga-ecc-manager.yaml
+++ b/Documentation/devicetree/bindings/edac/altr,socfpga-ecc-manager.yaml
@@ -53,6 +53,7 @@ properties:
     properties:
       compatible:
         enum:
+          - altr,sdram-edac
           - altr,sdram-edac-a10
           - altr,sdram-edac-s10
 
-- 
2.51.0


