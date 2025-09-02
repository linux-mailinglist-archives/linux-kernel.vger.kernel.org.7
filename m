Return-Path: <linux-kernel+bounces-795735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEFA5B3F730
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 09:57:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FC16485E92
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 07:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93C202E8B92;
	Tue,  2 Sep 2025 07:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="CHof0X15"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB552E8B93;
	Tue,  2 Sep 2025 07:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756799806; cv=none; b=THSy99+cstWZTIq1p1IwH5X+lz++6lookuKaACY+t8D7GQWUq8GaA3TcA0B+VUY3uo4QUfSsj7Sm4QolzAn+QQ/iDmjRsO/OQ+yqzEUKWno9JbHhN0M69XSqrno+sO1561DYUKJKMZZzmCuRC5iEssfCvsz+lPZqvzu3hh7woJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756799806; c=relaxed/simple;
	bh=Pkx8x1NkgVeuO4YFWXM02HHwwX1ANgOv0kGU1edmzoE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MJuLogAHKLdP3GGfeOgmkjSkpdcK7HgaEUqZYR4PPhgYlxEvu2goj7ubMaizWcBjmWPN/64+M1c4a2vuorIS9MoW5aLR9ffkoCpv7VmkSzwAJd5JvpSxdTTUTBr6jjm/FAbF/a6QHt08mlyzom3CS6OHRaLeuvT37RK0EdpxG/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=CHof0X15; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1756799806; x=1788335806;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Pkx8x1NkgVeuO4YFWXM02HHwwX1ANgOv0kGU1edmzoE=;
  b=CHof0X15Ew0TCofGthVH4yun1nGq15mPK3G+cvh/RAbOaN/er8ykkl+W
   xvKCWpZM/VGIfayaNGb0BfrfVpz+Z7Kgq8eSTEEE1oy49ZAC3qW2+L0ge
   O/xoteTzggn/cLIFm9CDGB8dMx3R3HMFdQk00akk5mGJi2A1oljPZ+2D3
   Pt6ZTAAFTm4hvBpsUVChNJ8oX43dB+ufY+uuwo2hNCCHYDq+nr4mqvd7Z
   hfB/34cNEhJnvsSjRnh/L1SPdJm7X67Yf/tvEUGwQkENJPLNFBQuBQlUG
   XRp39SnjPzeNBRwcAHNf1IudXwExAMbRP85QS9CTZNb6diols1x7boVBl
   g==;
X-CSE-ConnectionGUID: I0e7JmeXSliqGe+ljgjh1Q==
X-CSE-MsgGUID: 67nz6IXDQCmfVro4rUwmeA==
X-IronPort-AV: E=Sophos;i="6.18,230,1751266800"; 
   d="scan'208";a="45916747"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Sep 2025 00:56:45 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 2 Sep 2025 00:56:14 -0700
Received: from valentina.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Tue, 2 Sep 2025 00:56:11 -0700
From: Valentina Fernandez <valentina.fernandezalanis@microchip.com>
To: <conor.dooley@microchip.com>, <daire.mcnamara@microchip.com>,
	<paul.walmsley@sifive.com>, <palmer@dabbelt.com>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <aou@eecs.berkeley.edu>, <alex@ghiti.fr>,
	<valentina.fernandezalanis@microchip.com>
CC: <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>
Subject: [PATCH v2 2/5] dt-bindings: riscv: microchip: document icicle kit with production device
Date: Tue, 2 Sep 2025 08:55:45 +0100
Message-ID: <20250902075548.1967613-3-valentina.fernandezalanis@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250902075548.1967613-1-valentina.fernandezalanis@microchip.com>
References: <20250902075548.1967613-1-valentina.fernandezalanis@microchip.com>
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


