Return-Path: <linux-kernel+bounces-805705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 154A1B48C7E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 13:49:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20B0F1B25E36
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 11:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BF792F83BE;
	Mon,  8 Sep 2025 11:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="uphocejZ"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC2C229B1F;
	Mon,  8 Sep 2025 11:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757332136; cv=none; b=WU+b7nOptCwD3MMES0ghuqoDpoTk5OW34zaJ9Xbgo0+OBkn/dyLKQyf5R3IotPFrkN+7ZQSU0ljpRBRVjws1Tjwe5zT/7HzaUEapo2iJFIsTeG73BiHoqGLPFnX6pjBr7LWLWz8d1yd4/7DwErNn2hH4mbOWCYE8XEfwM6QHDaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757332136; c=relaxed/simple;
	bh=Pkx8x1NkgVeuO4YFWXM02HHwwX1ANgOv0kGU1edmzoE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LmOWzyHnNS8X1ErMgXNZWWkJE5hS/aunyBhhcKZcNJmiTL9Y2op8bWMoH+fnrv6Tv4bPZKt7JUH44YA9/iq/Jd0Io4kAGPSMC90UzLc/2ZQ3JzaW3jEAEfQAVD+m1dRREOtaGH0+kh3oAcyztm3DfMp6BHXFLGLuQoLPhdDzEWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=uphocejZ; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1757332135; x=1788868135;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Pkx8x1NkgVeuO4YFWXM02HHwwX1ANgOv0kGU1edmzoE=;
  b=uphocejZxd3nqv1sTOJ5TpCKXvFRBzVqUVoOWnZptT1KW7xMC6BtHtTz
   ZdrVzftjYmbxzPzo5XdWHmZvlEqOFUsyD4r+zDgPQisu+lSxwH/684EmP
   9fCsJOg2lezk9CbuMt46TNBcFHG8R23V7bsSolhwqSWREIWodciQai1Xo
   f/SGcEEykdgm3ZIHpWHOQVDey1qLwd3OWKrwOP+cgU54hPlTUjnR2v4Mf
   Mq1649qBTTDBm98IdUqY8VOGwT686etImr43rqZ2W+XwIo9pgpGdOPN+C
   xdrHDIjs2XcDKzJDS8a4nkN6ELnolVOjoPjw5ewBXVFkAods0N1i1eZgQ
   w==;
X-CSE-ConnectionGUID: vDOPHTnsQiaqmkXt9yltVw==
X-CSE-MsgGUID: 0R7GstWqQE6E+l/S+UyVDg==
X-IronPort-AV: E=Sophos;i="6.18,248,1751266800"; 
   d="scan'208";a="45634877"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Sep 2025 04:48:53 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Mon, 8 Sep 2025 04:48:40 -0700
Received: from valentina.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Mon, 8 Sep 2025 04:48:37 -0700
From: Valentina Fernandez <valentina.fernandezalanis@microchip.com>
To: <conor.dooley@microchip.com>, <daire.mcnamara@microchip.com>,
	<paul.walmsley@sifive.com>, <palmer@dabbelt.com>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <aou@eecs.berkeley.edu>, <alex@ghiti.fr>,
	<valentina.fernandezalanis@microchip.com>
CC: <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>
Subject: [PATCH v3 2/6] dt-bindings: riscv: microchip: document icicle kit with production device
Date: Mon, 8 Sep 2025 12:57:28 +0100
Message-ID: <20250908115732.31092-3-valentina.fernandezalanis@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250908115732.31092-1-valentina.fernandezalanis@microchip.com>
References: <20250908115732.31092-1-valentina.fernandezalanis@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

With the introduction of the Icicle Kit using the production MPFS250T
device, it's necessary to distinguish it from the engineering sample
(-es) variant. Engineering samples cannot write to flash from the MSS,
as noted in the PolarFire SoC FPGA ES errata.

Add specific compatibles for the Icicle Kit with Production device
(MPFS250T) and Icicle Kit with Engineering Sample (MPFS250T_ES).

The icicle kit reference designs in the v2025.07 release include the
Mi-V IHC IP v2, used to send/receive data between clusters when
using Asymmetric Multiprocessing (AMP) mode.

In reference design releases prior to v2025.07, the MI-V IHC subsystem
was included as a proof of concept in the design prior to becoming an
IP available in the Libero catalog.

Among other improvements, the new Mi-V IHC IP v2 includes some
changes to the register map. For this reason, make use of a new
reference design compatible to denote that v2025.07 reference design
releases are not backwards compatible.

Signed-off-by: Valentina Fernandez <valentina.fernandezalanis@microchip.com>
---
 Documentation/devicetree/bindings/riscv/microchip.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/microchip.yaml b/Documentation/devicetree/bindings/riscv/microchip.yaml
index 78ce76ae1b6d..8ddc5c02973e 100644
--- a/Documentation/devicetree/bindings/riscv/microchip.yaml
+++ b/Documentation/devicetree/bindings/riscv/microchip.yaml
@@ -18,10 +18,18 @@ properties:
     const: '/'
   compatible:
     oneOf:
+      - items:
+          - const: microchip,mpfs-icicle-prod-reference-rtl-v2507
+          - const: microchip,mpfs-icicle-kit-prod
+          - const: microchip,mpfs-icicle-kit
+          - const: microchip,mpfs-prod
+          - const: microchip,mpfs
+
       - items:
           - enum:
               - microchip,mpfs-icicle-reference-rtlv2203
               - microchip,mpfs-icicle-reference-rtlv2210
+              - microchip,mpfs-icicle-es-reference-rtl-v2507
           - const: microchip,mpfs-icicle-kit
           - const: microchip,mpfs
 
-- 
2.34.1


