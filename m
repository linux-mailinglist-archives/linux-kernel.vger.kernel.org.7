Return-Path: <linux-kernel+bounces-644821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E383AB44E4
	for <lists+linux-kernel@lfdr.de>; Mon, 12 May 2025 21:30:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C125086841A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 May 2025 19:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B866E298CBE;
	Mon, 12 May 2025 19:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="HvALpEzk"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F881298C0B;
	Mon, 12 May 2025 19:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747078188; cv=none; b=SJPA0uJwg12ocewM7hWdLJk83naV4W+W050h76GnfqOZgfDNJnhPhjfVSJrink8qB9TTQb3BSaexoO9HB0FIPZtnDnPiepkqJXQb8RsZEblTJbmsP24j9DB9d7++IrxhEYxXV/0OhD6SVwpQxxK730lTFLbYey76N1u7FUWY0YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747078188; c=relaxed/simple;
	bh=Uk6gMNlH4FiuwQmFLiKNXCHoWc0Q7toe1h2KyD5NpP8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZyXAOQaAYd9AWdfIcTfwMRsWuPUMFcB/Hss8uZCB2O2FCfKULHfUx52q5SY1QxAjPFWHcrwamEggy0sL9FZjbWfuOwfGN451GyNWx9ot1cL3jdkkRQo2GuWxtngeRgskbdJl3hhjCH3FNdyxQZdy/Dj8F7YKyRVR5hX1FJBjisE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=HvALpEzk; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1747078186; x=1778614186;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Uk6gMNlH4FiuwQmFLiKNXCHoWc0Q7toe1h2KyD5NpP8=;
  b=HvALpEzkLKyt5eUnjBrTSZwswqGtESuH2SfkLvQXznXnu8q8Cdh2uUaq
   k2VgDS5GiCyjELYVmtJzrWWBMoYj+smZk/i2Ok4jxu+DVEP/Aff8DJvgC
   BoDh5Fy1q3grj4vNXxd10UmcrgN4FY0Jw/LyBCMsLPBEZnSaHJ9EhfI46
   WnYbXKrVHO/P1IA0hDte8mxGH8EZjaCwngYSX9t5siHlOwpgEoHp2wLoA
   qcoiyFMpbine3l3hZgwMBFOeV1j0Wa6HDjm+wUYLU0Nxzyg+jkL4S2as5
   EwYrGJ5MMoX4k8ldhHuwpjqeEiX3ma3duDmEeUCyzRhkEwI6VJTxYBkLD
   Q==;
X-CSE-ConnectionGUID: hYKpzzHaRPOvLPNNOvU8gw==
X-CSE-MsgGUID: lV4VSQu2TQ2dJND9A8h/Lg==
X-IronPort-AV: E=Sophos;i="6.15,283,1739862000"; 
   d="scan'208";a="209006609"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 May 2025 12:29:37 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 12 May 2025 12:28:56 -0700
Received: from ryan-Precision-3630-Tower.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Mon, 12 May 2025 12:28:56 -0700
From: <Ryan.Wanner@microchip.com>
To: <herbert@gondor.apana.org.au>, <davem@davemloft.net>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<olivia@selenic.com>
CC: <linux-crypto@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>, "Ryan
 Wanner" <Ryan.Wanner@microchip.com>
Subject: [PATCH 3/9] dt-bindings: crypto: add sama7d65 in Atmel TDES
Date: Mon, 12 May 2025 12:27:29 -0700
Message-ID: <ea33a6222dda7c60fd404a4b0e9c4824e19ee1bf.1747077616.git.Ryan.Wanner@microchip.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1747077616.git.Ryan.Wanner@microchip.com>
References: <cover.1747077616.git.Ryan.Wanner@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Ryan Wanner <Ryan.Wanner@microchip.com>

Add DT bindings for SAMA7D65 SoC Atmel TDES.

Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
---
 .../devicetree/bindings/crypto/atmel,at91sam9g46-tdes.yaml    | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-tdes.yaml b/Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-tdes.yaml
index 6a441f79efea..337f5cac0f59 100644
--- a/Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-tdes.yaml
+++ b/Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-tdes.yaml
@@ -15,7 +15,9 @@ properties:
     oneOf:
       - const: atmel,at91sam9g46-tdes
       - items:
-          - const: microchip,sam9x7-tdes
+          - enum:
+            - microchip,sam9x7-tdes
+            - microchip,sama7d65-tdes
           - const: atmel,at91sam9g46-tdes
 
   reg:
-- 
2.43.0


