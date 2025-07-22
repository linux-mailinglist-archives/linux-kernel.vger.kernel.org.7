Return-Path: <linux-kernel+bounces-741106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 059DFB0E024
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 17:15:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0C111C20025
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 15:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D19872EBDD8;
	Tue, 22 Jul 2025 15:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eh/ay8Vm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2893628A1D7;
	Tue, 22 Jul 2025 15:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753196949; cv=none; b=iCtIajG6V0YiBepVYSoT6LgO38wdoNk4Q+BuraIGoeJbECux9E+uQ+n8v32TrsOONwxDCBph4miANe0kl3roQZrF4/X66Zpi1XR02HpK15O4PkwUkeTjwn7tUXj+zkk/C9R+Dd919755EVyF3fVvwIx/sExiluZE4F1yqUCQxak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753196949; c=relaxed/simple;
	bh=CLMpKrTrD+1F6YeWwuDcqlirxHopHnUHK3PKeL3Qewc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eWfQyXmS4pViDvqh+a+Y8ZMdepCUivFXDhYMjKHYeOgeQ8o3HSr2izpFIFeZldA705PE7MAinw1aL1idyyK+r2SWkz5cgUfI4PgPbqs7wJP61u69o3kU912xkhG2LHVux4xh6ZsMx0U4YnBP2wXpWR/ETid1tHwFf/RzcQaWCrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eh/ay8Vm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BD9C1C4CEF9;
	Tue, 22 Jul 2025 15:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753196948;
	bh=CLMpKrTrD+1F6YeWwuDcqlirxHopHnUHK3PKeL3Qewc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=eh/ay8VmDClXb6knEPquAy5/Krjf4p0QvRmg6gQWzoFFgn90iy7e1TgMU+nDTMose
	 jYqnWrTQW2rWrVOKeene5q4/VOhfm3VdtvChfP0HGoVoZmaPA/bo2AvYP8izJ6mwao
	 +POfVAqdW9k0TRweRXP8//VPc0vnFx8SBm7hxZTHENZlFI1IZHFERFwbG5S5laPhcF
	 bPR7LNyUUX+t3sGEQZCDdIPc63FNu9kPUu0jcCp/+d0PBAkPEWRDHf/eYGFAHmcEyz
	 G3BkhIvBsSVHAMQpJa51eVIM/bcku0V6lYX0Z/hCVvAr22YzAJoEJ13OGoKA20lHgw
	 q5OlZHUfNB04w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD74CC83F34;
	Tue, 22 Jul 2025 15:09:08 +0000 (UTC)
From: Mahesh Rao via B4 Relay <devnull+mahesh.rao.altera.com@kernel.org>
Date: Tue, 22 Jul 2025 23:07:51 +0800
Subject: [PATCH 1/4] dt-bindings: firmware: Add interrupt specification for
 Intel Stratix 10 Service Layer.
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250722-sip_svc_irq-v1-1-c5b9e02c1ce6@altera.com>
References: <20250722-sip_svc_irq-v1-0-c5b9e02c1ce6@altera.com>
In-Reply-To: <20250722-sip_svc_irq-v1-0-c5b9e02c1ce6@altera.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Dinh Nguyen <dinguyen@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mahesh Rao <mahesh.rao@altera.com>, 
 Matthew Gerlach <matthew.gerlach@altera.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753196946; l=1851;
 i=mahesh.rao@altera.com; s=20250107; h=from:subject:message-id;
 bh=AOemBCgdL+N65O4/Not6GZwfFLWHmbGOTOms8z2w2Jo=;
 b=NbU81/Kx0NOw/5Nc2eINlzrxJM3M1WUTSRcu0kjIxI++A2pZ/D2r/TRDQFRk5X8JvxWgphsvx
 jjqdKA8jlVHDEmxYRykg2/bon2PxkSVwbCA5WDvj2kvvAPE/+2yytdN
X-Developer-Key: i=mahesh.rao@altera.com; a=ed25519;
 pk=tQiFUzoKxHrQLDtWeEeaeTeJTl/UfclUHWZy1fjSiyg=
X-Endpoint-Received: by B4 Relay for mahesh.rao@altera.com/20250107 with
 auth_id=337
X-Original-From: Mahesh Rao <mahesh.rao@altera.com>
Reply-To: mahesh.rao@altera.com

From: Mahesh Rao <mahesh.rao@altera.com>

Add interrupt specification for Intel Stratix10 Service
layer for asynchronous communication.

Reviewed-by: Matthew Gerlach <matthew.gerlach@altera.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Mahesh Rao <mahesh.rao@altera.com>
---
 .../devicetree/bindings/firmware/intel,stratix10-svc.yaml      | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/firmware/intel,stratix10-svc.yaml b/Documentation/devicetree/bindings/firmware/intel,stratix10-svc.yaml
index fac1e955852e4f9b966c991dcfac56222c5f7315..656cc50fd08217f270f95ae39010152423315ed1 100644
--- a/Documentation/devicetree/bindings/firmware/intel,stratix10-svc.yaml
+++ b/Documentation/devicetree/bindings/firmware/intel,stratix10-svc.yaml
@@ -54,6 +54,12 @@ properties:
       reserved memory region for the service layer driver to
       communicate with the secure device manager.
 
+  interrupts:
+    maxItems: 1
+    description:
+      This interrupt is used by the Secure Device Manager (SDM) to signal
+      completion of an asynchronous operation to service layer driver.
+
   fpga-mgr:
     $ref: /schemas/fpga/intel,stratix10-soc-fpga-mgr.yaml
     description: Optional child node for fpga manager to perform fabric configuration.
@@ -67,6 +73,8 @@ additionalProperties: false
 
 examples:
   - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
     reserved-memory {
       #address-cells = <2>;
       #size-cells = <2>;
@@ -84,6 +92,8 @@ examples:
         compatible = "intel,stratix10-svc";
         method = "smc";
         memory-region = <&service_reserved>;
+        interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-parent = <&intc0>;
 
         fpga-mgr {
           compatible = "intel,stratix10-soc-fpga-mgr";

-- 
2.35.3



