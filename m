Return-Path: <linux-kernel+bounces-805708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F700B48C84
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 13:49:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A72991B25F88
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 11:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03CBB2FDC3E;
	Mon,  8 Sep 2025 11:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ctffyfju"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028EF2F3C1A;
	Mon,  8 Sep 2025 11:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757332138; cv=none; b=aQtJ8Ge+IMufLPJfIQQFx2JouF3Uh7WAHfnNn2lrx+R6ROwsWo3uzbElqZcOAk8JF1sm/7qQ/ou5ePYZawLrACGs9xPOTyFmJxuGbh5QmekCqbvkq0UCpY+9hGWa3QKnfZ9IUpw8KhScA1IpiNhMcK8fCgtUlIwETGtqcB2zGdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757332138; c=relaxed/simple;
	bh=TAnyCLRfE3EQgtrPFVJVltgt/YNxdMV/5FZ7fdcJlJA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HtpvFFV4efMV86ORFQ+Wa1tVAWMlix4IBVDgoa8HQVWTr5wDRkxrIJC13ow0tecJT2C6yuhWJY1nfWwxo1Kz9n1KqUnzDZB0sdhc53kRP0ExVLr2sZ+RgJF5UwSDfiK3yYUDSio6v/vQXu0tiA6diDpEkB6ePu29CdkmkoBu3h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=ctffyfju; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1757332137; x=1788868137;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TAnyCLRfE3EQgtrPFVJVltgt/YNxdMV/5FZ7fdcJlJA=;
  b=ctffyfjuk9Y1v3anx8QgMqME2WCEEsB1oLItvBk1WrU/4WjQ+//J+2tI
   fZ6d7YQciV8wpysboFg3Mml1zxEq7/3DdDM18vMBDgCe2PRVYN0CH0TVH
   y2xOseH2rExLR+xZ3MGmuPVDzR9EE0MNI1sEUVIiPTWjesDoyV6JXu17c
   gvABFPmnin7NH6VPX41ey79I46KzBLZgwg6S0Ob3qQb4fo1VmjDGjqx0S
   ZaRKU7ke7sptyF5aX+gmjJb5DE/kISpgcvPkXRkvZ0c5FCsRnThqafedM
   d8RQtM5dugzLY4LbCh7VCd0uN3ortd2WIDAKox70HcJJNivqBj1Qwoa27
   g==;
X-CSE-ConnectionGUID: vDOPHTnsQiaqmkXt9yltVw==
X-CSE-MsgGUID: sPF5+K31RUOwNeF05RSj0w==
X-IronPort-AV: E=Sophos;i="6.18,248,1751266800"; 
   d="scan'208";a="45634881"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Sep 2025 04:48:55 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Mon, 8 Sep 2025 04:48:48 -0700
Received: from valentina.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Mon, 8 Sep 2025 04:48:46 -0700
From: Valentina Fernandez <valentina.fernandezalanis@microchip.com>
To: <conor.dooley@microchip.com>, <daire.mcnamara@microchip.com>,
	<paul.walmsley@sifive.com>, <palmer@dabbelt.com>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <aou@eecs.berkeley.edu>, <alex@ghiti.fr>,
	<valentina.fernandezalanis@microchip.com>
CC: <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>
Subject: [PATCH v3 5/6] dt-bindings: riscv: microchip: document Discovery Kit
Date: Mon, 8 Sep 2025 12:57:31 +0100
Message-ID: <20250908115732.31092-6-valentina.fernandezalanis@microchip.com>
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


