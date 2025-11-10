Return-Path: <linux-kernel+bounces-892922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C793FC4621E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 12:09:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87B8A1895621
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 11:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 914143081DC;
	Mon, 10 Nov 2025 11:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="RnLbc+Sa"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D79C30596D;
	Mon, 10 Nov 2025 11:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762772874; cv=none; b=a+5IUCKhj9shMMOR12zNAJJfHtu308PiF7AFNLcwuvCA5eWKSgK9d8F+ike9zlQxvC9wYfhccGzI2mnR8WD4a899tkNeEbvbcOgwynWpJe8waEHtdeK7cIqV+F+0ZjLC19pRz+1rZ3JQVpglEIUsSRZG4/CgY5vCuSEzU+ByCM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762772874; c=relaxed/simple;
	bh=SKw8CC1n2UF3Pi49EJY3Kpovsl0gwIppiQVUNgYN7ms=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oDlrp7eHoqd+JoLej84GWVQXRLCbPu4B1k/1FCY4A905PvCGye1lzeyHOsAsn0i3YRlJ/izS1+EvSNXVZ+eIGYWZjwcFfrlvGX3j1g/3Ek7dGYH+u3xZ8vjywKWuQW0aNFm6rVC3Rcp+tP9G/8y8xBzLGU5tuyL2Lmqv3ScUWbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=RnLbc+Sa; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1762772872; x=1794308872;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SKw8CC1n2UF3Pi49EJY3Kpovsl0gwIppiQVUNgYN7ms=;
  b=RnLbc+SaOegthGrC0G2o1auHyQaoFoPf3bC+ZhWWNEQO4H4ahAqtBgiu
   oTe9ELpvJlM08vZk6sbiNf4nOZue+Ew6MJ+hrTaix1HelQOhrx39N606C
   kGIizla8jj9djAfWknx32+sctaBFX6IM0L736wUARNcQAoWZ+9lziU8Da
   bbrq5vF26fCDLXdfNnn+gIJxHUZwQuj94heSRocXR63lKQflGnwHUfcVT
   gOaaxpI5NGojskHxsB5h2eV2Lli9Afqqs9i1jo06z3eyL/klRhdFfY+O+
   7adAoa2TsnJ9xUOkWiTDfvTouMaVawsawiySxXZMLyY2HLqRgpIiq4SsG
   w==;
X-CSE-ConnectionGUID: 8SH01HuiQpObZsvMkVgz3A==
X-CSE-MsgGUID: 46V5nKipS9ywXMWXczz15w==
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; 
   d="scan'208";a="55314297"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Nov 2025 04:07:45 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Mon, 10 Nov 2025 04:07:28 -0700
Received: from DEN-DL-M31836.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Mon, 10 Nov 2025 04:07:26 -0700
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: <vkoul@kernel.org>, <kishon@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Horatiu Vultur <horatiu.vultur@microchip.com>
Subject: [PATCH 2/2] dt-bindings: phy: lan966x: Add optional microchip,sx-tx/rx-inverted
Date: Mon, 10 Nov 2025 12:05:36 +0100
Message-ID: <20251110110536.2596490-3-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251110110536.2596490-1-horatiu.vultur@microchip.com>
References: <20251110110536.2596490-1-horatiu.vultur@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

This allows to invert the N and P signals of the RX and TX Serdes
signals. This option allows the board designer to trace their signals
easier on the boards.

Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 .../phy/microchip,lan966x-serdes.yaml         | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/microchip,lan966x-serdes.yaml b/Documentation/devicetree/bindings/phy/microchip,lan966x-serdes.yaml
index 6e914fbbac567..21b19e06a75aa 100644
--- a/Documentation/devicetree/bindings/phy/microchip,lan966x-serdes.yaml
+++ b/Documentation/devicetree/bindings/phy/microchip,lan966x-serdes.yaml
@@ -41,6 +41,30 @@ properties:
       - The macro to be used. The macros are defined in
         dt-bindings/phy/phy-lan966x-serdes.
 
+  microchip,s0-tx-inverted:
+    type: boolean
+    description: Invert the TX N and P signals for Serdes 0
+
+  microchip,s1-tx-inverted:
+    type: boolean
+    description: Invert the TX N and P signals for Serdes 1
+
+  microchip,s2-tx-inverted:
+    type: boolean
+    description: Invert the TX N and P signals for Serdes 2
+
+  microchip,s0-rx-inverted:
+    type: boolean
+    description: Invert the RX N and P signals for Serdes 0
+
+  microchip,s1-rx-inverted:
+    type: boolean
+    description: Invert the RX N and P signals for Serdes 1
+
+  microchip,s2-rx-inverted:
+    type: boolean
+    description: Invert the RX N and P signals for Serdes 2
+
 required:
   - compatible
   - reg
-- 
2.34.1


