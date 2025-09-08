Return-Path: <linux-kernel+bounces-806326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E80D3B49516
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 18:22:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A862B3AFC2B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 16:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D24D30FF39;
	Mon,  8 Sep 2025 16:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="DnNBF3xV"
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D179030F955;
	Mon,  8 Sep 2025 16:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757348476; cv=none; b=pSXbS3FqcVUVWGFynwAi3xEtSt7tRwMsMPbuA6dq20lwuOzhX41Rv+j+kx3mnpiRtnT9XiIW0WuZVA0VQ5M/7/VGegE7Bs7rxvtGIfMmXnyN8WC9Hjp+HbWQMBp84Tc9ygql6N14uK7vpjApV/KbB2KFFDfAj/Eunmtmier+xY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757348476; c=relaxed/simple;
	bh=Jw6IsKNrpsMFU9GuROwZE4X6mjU5ZWFBpwrLBHpZx/A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rns+rivnZHzxTfwv4kuwhqAtu60flqv+DifLoAJ0QlOSYbFrm2IF+jSL2FvTXesQqSjHho43uMQS3apoN1tp3oT9DRMjBeJAq7UuaLWOQrtC2uCnnxwvdJal7Rx56WnfliRlWKFGzfrhfj1RjXdgcJxsf+080C328N4NKzbKPUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=DnNBF3xV; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 458D34E40BFA;
	Mon,  8 Sep 2025 16:21:13 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 19A466061A;
	Mon,  8 Sep 2025 16:21:13 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8A0D3102F27D2;
	Mon,  8 Sep 2025 18:21:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1757348472; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=5dU3nNv2GWlrx7YqQ55TmDyusvkJ/gsQeOjrPzRly/w=;
	b=DnNBF3xVGwHt20SRUkCHpBQmkGuIGVl806i28wavQMSl6Fovl1qSBpU55ifXHF7celZtsB
	gOgJlq9X+3Sm6Oa6EUlJpVvmEF/X16LCQE5Lfhbm/E5ien45rqMrMS33JGDdoMWz+YHXPa
	c8WF3YypvcwOxoSZxDA6pM1BDJj6BK0EI14UHBaAJTndUz8XdsnwkS9od7FkQLbYazYXIu
	cyB6DUyxf7PWMUt+XOCh/H1SwMyERhnEqlmwK4vpNP8cQF5v945/llvarN8XyAgINZ1+Z3
	HO0x9ddDXrmqvYqTapTcJgxYi8koyYM6w2MQQIMZ847HD9jlG4BvuBPTBESbQA==
From: Richard Genoud <richard.genoud@bootlin.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc: Aswath Govindraju <a-govindraju@ti.com>,
	linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Richard Genoud <richard.genoud@bootlin.com>
Subject: [PATCH 1/2] dt-bindings: usb/ti,am62-usb.yaml: Add ti,lane-reverse property
Date: Mon,  8 Sep 2025 18:20:51 +0200
Message-ID: <20250908162052.355341-2-richard.genoud@bootlin.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250908162052.355341-1-richard.genoud@bootlin.com>
References: <20250908162052.355341-1-richard.genoud@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

On some designs, the D+ and D- lines are swapped (on purpose or not).
The PHY can handle that with the LANE_REVERSE bit.

Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>
---
 Documentation/devicetree/bindings/usb/ti,am62-usb.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/ti,am62-usb.yaml b/Documentation/devicetree/bindings/usb/ti,am62-usb.yaml
index f6e6d084d1c5..ba894d610af0 100644
--- a/Documentation/devicetree/bindings/usb/ti,am62-usb.yaml
+++ b/Documentation/devicetree/bindings/usb/ti,am62-usb.yaml
@@ -36,6 +36,11 @@ properties:
     items:
       - const: ref
 
+  ti,lane-reverse:
+    description:
+      Should be present if D+ and D- lanes have to be swapped.
+    type: boolean
+
   ti,vbus-divider:
     description:
       Should be present if USB VBUS line is connected to the

