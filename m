Return-Path: <linux-kernel+bounces-884978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33FADC31A67
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 15:56:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CFE03B6350
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 14:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC12432F75B;
	Tue,  4 Nov 2025 14:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="zU/v75GC"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE09F32E73E;
	Tue,  4 Nov 2025 14:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762267978; cv=none; b=RGOZLCkN9fkUrfGcrf1luS91vbrDGBwivAKbVw1nda7KVa6cUDUO+q4pbkZo34NNP5nTMS1S0sJQQ9lgENEDVD0p/1zi3RYgUujGBm7IlwHaw5dEKxzl0KGo/eO7OPigVWm/Xu9ZRnApFsxZh+mkY5NLqewYaaK+d/Waja5dSjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762267978; c=relaxed/simple;
	bh=U8bGMlnkguwx5qplqn4uiFJmynb7PO3Q59AqeWNfY1c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q23dCE5NnqIdqZa7OBMHgqbpc1g7CALkXIHzmF8z/ItlRypr/pE9gswiMER6Q+rfkEUPgBZ3Qr1YQpYEvmYeKzuHIS1iVgEdIECSG9oahh0GOazYe7l0DKW4cMaiB7NC0AvKhqE/I/VdiKoVDzn/cnDkJ0ggQ6ZtTyy3XOCHkaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=zU/v75GC; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb.corp.toradex.com (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch [83.173.201.248])
	by mail11.truemail.it (Postfix) with ESMTPA id 590521F8C1;
	Tue,  4 Nov 2025 15:52:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1762267973;
	bh=Nz03hoH+v5IpDCASP5NMSrf3ufzt2WmP9y5Ixf4/Cso=; h=From:To:Subject;
	b=zU/v75GCHC1izVCeM3Twfug1Y3HyU/nuJyaOrzeeTzAOoj0yISkW6WrYLULYYCkkM
	 /JEStHKZKMhbZcUW1CduXHhyZQoGAbmWHB7fiZcBzjt5iL2Z3uCvu3FbSI5Eqs1gS4
	 MwWQpO/n7YxTqCSencuSzvkA6dQOEV9YOoNc2wthVLk9i8wpX6kEfhxY248gBgc0g9
	 yX59Vw4V7+5WfPSP9rqsWOKaalr1WgZtZZO4KxLwBLqcDZkWiUUPthUrm0wpgFXh1f
	 PjWsabaCBX6GNmUSO/5A5UtN14D2zkVCm42ZlwCy6eAmvbcU8ow5ZDWLycl1orHZ+6
	 tpSePJzsWpYWQ==
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
	Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: [PATCH v1 1/3] dt-bindings: arm: ti: add Toradex Aquila AM69
Date: Tue,  4 Nov 2025 15:52:35 +0100
Message-ID: <20251104145240.61219-1-francesco@dolcini.it>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251104144915.60445-1-francesco@dolcini.it>
References: <20251104144915.60445-1-francesco@dolcini.it>
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


