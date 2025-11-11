Return-Path: <linux-kernel+bounces-895944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85098C4F55D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 18:55:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34321189A4B2
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 17:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2E333A1D02;
	Tue, 11 Nov 2025 17:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="kp1Ewgr9"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C49C2DEA79;
	Tue, 11 Nov 2025 17:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762883725; cv=none; b=He7T/sz4gF598Bz1wWI6KllHROZChswm8eofnNWq0pv0qVFND01kF/x/Od2NhwTS8SoG94Yi697DYyAnqQz5feY2FIv5O1sEojK6ltr+trdhM4Y5EnzYKg/vEikBWfz0UyjxAmNqrumZI4qvyLTxla4uAclf/zAEjl8PRqLEqhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762883725; c=relaxed/simple;
	bh=sccEkvsrP08tsolU2dqChqaJahI2j7W3BR6Qr2t4IJY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dQ5QEIt/0DN6YFW6x03VUhxLRld+szLzc10qLVTuKL4W4t3MedxtkPFXfi/Z2Gqq5G5ePOjuumTQch4pvWSi9zxr3NeSuv8h2Y4GkInTC+RViB4yrE1kSECjJgfBLoGM+mH+snYlXAHMKxtERBFczrUbDB2YCq5lfdXLJF5306s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=kp1Ewgr9; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from localhost.localdomain (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id EFAE41FE49;
	Tue, 11 Nov 2025 18:55:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1762883721;
	bh=Lc4prR/NRmqGKWAu+uVdSjtexRWIrS4oe1SpF5Crh2Q=; h=From:To:Subject;
	b=kp1Ewgr9MmL+UCnCFdMl3c6gW86+uQrCbK/AM7Henkbe/haZMpGJBHaqsXiETkqKY
	 mbKzfaigcq4/iSqH6oinnGtzCq+Bki/Tv7jtajtvgzqmOzvLWmQn7DoSx7GuzYx86i
	 h+HCl4Mb4hDLSIXyJN3ecbds76iI/IsV3/r7N49gcTrF9tXu1VdCBuJNmYZaSerDRD
	 PC62EVPnmsM1hZhwOnUWay4bdJ36xUaihoJFz3gMg70qma+x3M/bQmDDu/XCOH3bQq
	 suZU0vsphlXt8WDcdu9Zc6Oq17jqwIqtu6BFgy5aBljQ3sGl/0hH24XtHgYRsAGTGx
	 69jDxLyAOzITw==
From: Francesco Dolcini <francesco@dolcini.it>
To: Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v2 1/3] dt-bindings: arm: ti: add Toradex Aquila AM69
Date: Tue, 11 Nov 2025 18:54:57 +0100
Message-ID: <20251111175502.8847-2-francesco@dolcini.it>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251111175502.8847-1-francesco@dolcini.it>
References: <20251111175502.8847-1-francesco@dolcini.it>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: João Paulo Gonçalves <joao.goncalves@toradex.com>

Add DT compatible strings for the Toradex Aquila AM69 SoM and its
supported carrier boards: the Aquila Development Board and the Clover
carrier board.

Link: https://www.toradex.com/computer-on-modules/aquila-arm-family/ti-am69
Link: https://www.toradex.com/products/carrier-board/aquila-development-board-kit
Link: https://www.toradex.com/products/carrier-board/clover
Signed-off-by: João Paulo Gonçalves <joao.goncalves@toradex.com>
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
v2: add conor acked-by
---
 Documentation/devicetree/bindings/arm/ti/k3.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/ti/k3.yaml b/Documentation/devicetree/bindings/arm/ti/k3.yaml
index 2e15029dbc67..c6eb72462bef 100644
--- a/Documentation/devicetree/bindings/arm/ti/k3.yaml
+++ b/Documentation/devicetree/bindings/arm/ti/k3.yaml
@@ -158,6 +158,14 @@ properties:
               - ti,am654-evm
           - const: ti,am654
 
+      - description: K3 AM69 SoC Toradex Aquila Modules and Carrier Boards
+        items:
+          - enum:
+              - toradex,aquila-am69-clover   # Aquila AM69 Module on Clover Board
+              - toradex,aquila-am69-dev      # Aquila AM69 Module on Aquila Development Board
+          - const: toradex,aquila-am69       # Aquila AM69 Module
+          - const: ti,j784s4
+
       - description: K3 J7200 SoC
         oneOf:
           - const: ti,j7200
-- 
2.47.3


