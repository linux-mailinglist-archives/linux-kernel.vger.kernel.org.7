Return-Path: <linux-kernel+bounces-764841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BF60B227A4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 15:02:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 610A67AA54F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 13:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3DC91D6AA;
	Tue, 12 Aug 2025 13:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W2nsH1WC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E3128000A;
	Tue, 12 Aug 2025 13:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755003641; cv=none; b=TtKpZsKGpggBfRLTQ9MsMjXyMSSkvVdzNklz2LqkL3JEOH0xk8NNGMQxWDbfjyyf4FO40xudnRq88fLf71VjZ/v0eEXOKCsHj2bzdXrwn85a15u0ksYDf/Ue1jpVmexLWTmzx0twt2ppcxDcLutzhSAP8dCjDGWZ65979KfvIek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755003641; c=relaxed/simple;
	bh=CLMpKrTrD+1F6YeWwuDcqlirxHopHnUHK3PKeL3Qewc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=olFLDZ8tzrOiJj9e9cyjNNG+bQxWM0qVTCW4KNa0YUL8Mhb0lqfruLBWMVTuTqKFpt/6XNr9bLnwyY06umOu+MF0HDzxSHmQzDgVkuX7JbQxgM9bKjbZu64PZ2W2sQCxaQ584UDOrEcc9K3Nv7YIuVs3r2j0Wa3A8vl/XF8wh9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W2nsH1WC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B1642C4CEF5;
	Tue, 12 Aug 2025 13:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755003640;
	bh=CLMpKrTrD+1F6YeWwuDcqlirxHopHnUHK3PKeL3Qewc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=W2nsH1WCoOPpcG6BwZm4jJN+VcO6lsXEhCDY4IoKaxTkhXHXelTVNMmBaqwmBgEFT
	 ZBpr8HxnNtK9G9qUIFAls4ode9JvMX9bXewdlEk3d08VFxhi/gRB+P0ZlQF2Ff5q7k
	 mnhA9PHO4umklFRo/vbWR1YmdY3EVbo+GsdYT7eP9DUGD7liFKctuIRPoJoy1m/x24
	 MwU0tkufJEDuWOitKVPXMzJnxZe/VLQ2oojPOkDeAUyoWO/2gN5eRURvzotzrcjTvK
	 BlCfAqwKpTsLFuMuOF8COZSUSyCb9W3AAf0+cB7f2+vH+WUiz6Q5JMbGrO3rC8VKXm
	 mpvGZrta68aRg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A48F3C87FCB;
	Tue, 12 Aug 2025 13:00:40 +0000 (UTC)
From: Mahesh Rao via B4 Relay <devnull+mahesh.rao.altera.com@kernel.org>
Date: Tue, 12 Aug 2025 20:59:24 +0800
Subject: [PATCH RESEND v2 1/4] dt-bindings: firmware: Add interrupt
 specification for Intel Stratix 10 Service Layer.
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250812-sip_svc_irq-v2-1-53098e11705a@altera.com>
References: <20250812-sip_svc_irq-v2-0-53098e11705a@altera.com>
In-Reply-To: <20250812-sip_svc_irq-v2-0-53098e11705a@altera.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Dinh Nguyen <dinguyen@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mahesh Rao <mahesh.rao@altera.com>, 
 Matthew Gerlach <matthew.gerlach@altera.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755003637; l=1851;
 i=mahesh.rao@altera.com; s=20250107; h=from:subject:message-id;
 bh=AOemBCgdL+N65O4/Not6GZwfFLWHmbGOTOms8z2w2Jo=;
 b=8S0XDud7rGHq5nBFQ8JWiz7ndCiGBA16NH2g3aA2nzxZLjooQTJ6gmSdIAd+o++rn8nS4hQGw
 eaxZtK7NPAYDdJu+vNaAqdulhgQA/H6DRbYbMKyjmD7jk6oaMVER+3d
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



