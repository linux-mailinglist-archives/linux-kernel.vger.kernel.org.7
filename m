Return-Path: <linux-kernel+bounces-785182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33566B34716
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 18:22:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 441E82A57ED
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 16:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B876301461;
	Mon, 25 Aug 2025 16:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="qBa5mxQp"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C4E2FFDE2;
	Mon, 25 Aug 2025 16:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756138882; cv=none; b=b5z0Lji8EVIHiqtqd9L3zrCUEpmSNDsX8Ow8IbRo+R2ZapdP8tmngbISeuAJV16oqQijyCy8htz+sUdwuzSVm7kG64cDyNz+sI0gqQSNIU+lLlXUqfMYbRxHmHYGAhy4CxKRHUxf+6Er15MMCGH8wPiX0hQtDiEdiGKniAz79Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756138882; c=relaxed/simple;
	bh=Pkx8x1NkgVeuO4YFWXM02HHwwX1ANgOv0kGU1edmzoE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l1fV24phJSX9cI3ZbYz4bn1kPKF9J6SfvW31s+cB4f3bRROKdikwbmmBgySap7LDPHsZkyXxY3cmRJhx3Xje9d9UwV6+mg+3HzhCEeqZyhHaQ4Ki3U6YRuE8tXwNmpQDtGhmPGuseJJqiR2bdw4SCBScLjVN83wfQtsEdNhp79g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=qBa5mxQp; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1756138881; x=1787674881;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Pkx8x1NkgVeuO4YFWXM02HHwwX1ANgOv0kGU1edmzoE=;
  b=qBa5mxQpPwmagwosL7aPA6VnaT16tx2O5S2wnZxFQw1T8f+ufxPrgaNq
   sECR95IwG57aOvg+SIi13m8sXPgK9uLHDQ57pn7tYGGQjl0rOtee1JFE+
   sRs8zIPk1BkAairfKV6txMAr3o5nTswIvKfoFXfj6dqLsBFCJYpvcjtI/
   uenCF/SdcNsvTu+5PaPWAgedIqPeyeLOm6+kGR7WPgXQOek738sv8YdF6
   saAjnD3xgC/gc07MkgtrJsAaVL4STwF09RvGUg1ty6Kjjlt6t5HcWEnIO
   QnzgNkQPfq3KmxfAqPlAYola+6sOzE40Ght0xiqU2ap2aMpS99e85RP7c
   w==;
X-CSE-ConnectionGUID: JXhS0w1nR7uesDFk/Gs8Fw==
X-CSE-MsgGUID: hUigM83LSoqoq/BOygZSTw==
X-IronPort-AV: E=Sophos;i="6.18,213,1751266800"; 
   d="scan'208";a="45617325"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Aug 2025 09:21:20 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 25 Aug 2025 09:20:47 -0700
Received: from valentina.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Mon, 25 Aug 2025 09:20:45 -0700
From: Valentina Fernandez <valentina.fernandezalanis@microchip.com>
To: <conor.dooley@microchip.com>, <daire.mcnamara@microchip.com>,
	<paul.walmsley@sifive.com>, <palmer@dabbelt.com>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <aou@eecs.berkeley.edu>, <alex@ghiti.fr>,
	<valentina.fernandezalanis@microchip.com>
CC: <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>
Subject: [PATCH v1 2/5] dt-bindings: riscv: microchip: document icicle kit with production device
Date: Mon, 25 Aug 2025 17:19:49 +0100
Message-ID: <20250825161952.3902672-3-valentina.fernandezalanis@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250825161952.3902672-1-valentina.fernandezalanis@microchip.com>
References: <20250825161952.3902672-1-valentina.fernandezalanis@microchip.com>
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


