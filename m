Return-Path: <linux-kernel+bounces-795737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E78FB3F737
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 09:58:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3E4A1A8792D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 07:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB7772E92AB;
	Tue,  2 Sep 2025 07:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="lzDUE8u6"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6007B2E8DF1;
	Tue,  2 Sep 2025 07:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756799808; cv=none; b=gd2TbDC7GlOavSjeDCg7kKHfwk5Q9sbzKBbyLs18MefOOTbRxgKpXGN0vO34PNqnHO/TbWlgDJscmtpJZWKwqeKyurcZTTLqOtzG/Mv4637fcFVKDqJwvu9qKTsJJ+oC/aCnVOIvusDlau1T+/0X3m4IKOjS+BF22WoJR5rAmhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756799808; c=relaxed/simple;
	bh=TAnyCLRfE3EQgtrPFVJVltgt/YNxdMV/5FZ7fdcJlJA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iQxWe4lCBbD7D/PjzJiznAqahr5jwLHo0X/T/VpIWDeNm3JsfIpBvVkIYGIM2D2ci+C4fQHnNEe26vdW9yMY6cHnmUIDXlVLwcxt4iSajekJ4WrFn5MSTHwU74LQojhDz0hSqZT8tEsGI+8Jd8u2sOUNFlgZaimuMDZzx4YpyDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=lzDUE8u6; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1756799808; x=1788335808;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TAnyCLRfE3EQgtrPFVJVltgt/YNxdMV/5FZ7fdcJlJA=;
  b=lzDUE8u6cQyJLdYwCtaJrNcDuLS8yMQ2yG9K0YY5egqY4CaidbvgFsLM
   zgIb9yiQFlo3svAK6kXTu3ikiiuyoY92KrJ7wV8q8vlbW4pWYxBvDN6M/
   UWSyyjswnBOGvL+nmAJn+QvxtsXevouE0QeYdtEg8voBZREhFEOdguYps
   BAtckLIOvGIHksdYTCTzRUIKVXCXZNdu//IkyfOEhblBqHR9VsxRrdzCy
   4RK+u3vPZ/kuR2Dzo+tGlLSHqdX2HLs2J9beNWZErpbGOD4WyR2I+6TTT
   sgUyqO7AckTnvpleaHAQYLR4Z4CzZXc9eYTp8GSY5R+RpLftB2Lffzk+6
   g==;
X-CSE-ConnectionGUID: I0e7JmeXSliqGe+ljgjh1Q==
X-CSE-MsgGUID: JWvEiZzbTJ67xuX5JzQCRg==
X-IronPort-AV: E=Sophos;i="6.18,230,1751266800"; 
   d="scan'208";a="45916749"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Sep 2025 00:56:45 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 2 Sep 2025 00:56:19 -0700
Received: from valentina.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Tue, 2 Sep 2025 00:56:16 -0700
From: Valentina Fernandez <valentina.fernandezalanis@microchip.com>
To: <conor.dooley@microchip.com>, <daire.mcnamara@microchip.com>,
	<paul.walmsley@sifive.com>, <palmer@dabbelt.com>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <aou@eecs.berkeley.edu>, <alex@ghiti.fr>,
	<valentina.fernandezalanis@microchip.com>
CC: <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>
Subject: [PATCH v2 4/5] dt-bindings: riscv: microchip: document Discovery Kit
Date: Tue, 2 Sep 2025 08:55:47 +0100
Message-ID: <20250902075548.1967613-5-valentina.fernandezalanis@microchip.com>
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


