Return-Path: <linux-kernel+bounces-785180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 995B2B34710
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 18:21:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7424B7A8937
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 16:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA3193009EA;
	Mon, 25 Aug 2025 16:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="UbtCt5ZX"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03E52E7F39;
	Mon, 25 Aug 2025 16:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756138874; cv=none; b=RulttCd0oBhKqGZmlEIoFF207kW9lguwcRERLdXQOoZ5oFOGEjE33kgQLRQcyIyG1IwLy11nxJ0NsYN41Qorz5SaMyfsHpai7Wdsy7TVZJP9csR4pIrcPcnoHCux6aUbSYj08CYohZg091NIe1RzuaOSjY9y0LKQUEDT5MCaQ6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756138874; c=relaxed/simple;
	bh=TAnyCLRfE3EQgtrPFVJVltgt/YNxdMV/5FZ7fdcJlJA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hWlDSJvZPkW6EwmjxzOWRN7ssjcyEiMeHdn8fU5URXVC7ISVnAx+HClnbpblcFp9l76P0Q9RkY8lQHNOswLGEHBbOYXzIJ117LSryMJprqFsYd3n2SC1rtybRMEGxmH3krTmyl6lYmERk06+EdDB3CrsQ25hV0o/6lubd41EZsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=UbtCt5ZX; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1756138872; x=1787674872;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TAnyCLRfE3EQgtrPFVJVltgt/YNxdMV/5FZ7fdcJlJA=;
  b=UbtCt5ZXcHLfypjoX5v6e4kCZ98yT7mQqkvm6Xv+ju4/sKpqBwGjL5lb
   D8zUzeq5x96X6bp4yLmT+qCx2IFgf9qs0YWxTRjCbatIQpaLhdiKaIhAd
   vKGgW747bk4M4db5gnHT7usM5zqXzAvxsW2A+7/HGTJbwzLL4gjN+L6iP
   BrHHZCRPquNtri+tEEeerW4U7AhTtfhI0F1byBDffvawQrw2igcwmHO4W
   UpJjyo+hDUcMr/rFqPSEx+toqfTldOOxQWiWAbznsP+FmpIEfcGkl6lgL
   LWRCV2nvRUg+D4846FY7NpCiwD35LUa483vw/ZKaFNRcSZLcCUkA2VP0z
   Q==;
X-CSE-ConnectionGUID: aOjtNZFgQlqEbp9cjaRbcw==
X-CSE-MsgGUID: /KQ3Pb1bTmigdZ4WLoj/cw==
X-IronPort-AV: E=Sophos;i="6.18,213,1751266800"; 
   d="scan'208";a="45617317"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Aug 2025 09:21:10 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 25 Aug 2025 09:20:52 -0700
Received: from valentina.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Mon, 25 Aug 2025 09:20:50 -0700
From: Valentina Fernandez <valentina.fernandezalanis@microchip.com>
To: <conor.dooley@microchip.com>, <daire.mcnamara@microchip.com>,
	<paul.walmsley@sifive.com>, <palmer@dabbelt.com>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <aou@eecs.berkeley.edu>, <alex@ghiti.fr>,
	<valentina.fernandezalanis@microchip.com>
CC: <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>
Subject: [PATCH v1 4/5] dt-bindings: riscv: microchip: document Discovery Kit
Date: Mon, 25 Aug 2025 17:19:51 +0100
Message-ID: <20250825161952.3902672-5-valentina.fernandezalanis@microchip.com>
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

The Discovery Kit (MPFS-DISCO-KIT) is a development board featuring
a Microchip PolarFire SoC MPFS095T.

Link: https://www.microchip.com/en-us/development-tool/mpfs-disco-kit
Signed-off-by: Valentina Fernandez <valentina.fernandezalanis@microchip.com>
---
 Documentation/devicetree/bindings/riscv/microchip.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/microchip.yaml b/Documentation/devicetree/bindings/riscv/microchip.yaml
index 8ddc5c02973e..381d6eb6672e 100644
--- a/Documentation/devicetree/bindings/riscv/microchip.yaml
+++ b/Documentation/devicetree/bindings/riscv/microchip.yaml
@@ -33,6 +33,11 @@ properties:
           - const: microchip,mpfs-icicle-kit
           - const: microchip,mpfs
 
+      - items:
+          - const: microchip,mpfs-disco-kit-reference-rtl-v2507
+          - const: microchip,mpfs-disco-kit
+          - const: microchip,mpfs
+
       - items:
           - enum:
               - aldec,tysom-m-mpfs250t-rev2
-- 
2.34.1


