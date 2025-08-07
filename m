Return-Path: <linux-kernel+bounces-759140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26DC6B1D911
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 15:29:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3494E584ED5
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 13:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E064A25C81F;
	Thu,  7 Aug 2025 13:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wl8h/3jS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B3D25B2FA;
	Thu,  7 Aug 2025 13:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754573347; cv=none; b=D1BhI7bAG11heARwcO3XvTDzcRlEbSacWdlYNLCUfHPU5B76okCdNUsmoCZIPnt7fJ/PO0w5H9//wkPe7azXw+FUrVESePOKO4GbgNgwXb4Y/ZHeMA+VIwmnuCyvvun+OM0VarXIIonqt4d+otWeEIsuayEjsOuJ49PFxuZmjBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754573347; c=relaxed/simple;
	bh=1VQ4CEYYvmVtvSuzcssa91RQvPgNCUSDeA69SoGr7Ds=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WOv+8YWEw1UFP6zw3Z2HDRo4nLScNp/sinfVQPfMyPijxjUqRoj49C7UjahgtLWe2IKik/WpkJziW1+InGzwCaXC9M0aAtKM0i3P6uUuc3lUkAHkF3XmnwyfKcGDN9XzB3EvVFJ6XkdO2bi+D6jp6ZalM26U03Ey3DeeAn5zMi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wl8h/3jS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72BCCC4CEEB;
	Thu,  7 Aug 2025 13:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754573346;
	bh=1VQ4CEYYvmVtvSuzcssa91RQvPgNCUSDeA69SoGr7Ds=;
	h=From:To:Cc:Subject:Date:From;
	b=Wl8h/3jSD4YRguyd//yDPsjdV6kNSuDDUKJ5SfvtAJWCBJhkiE4QSNjMLu0MnWC1y
	 vMv4m852bgEVvnxbYtV2fLcZwEZB1pardhns//wJcH6XgzgCo/Ii0aVcQmQXpYnFzM
	 vQxVaZU3fbt/hY1p8+lm4KYYBgvcuL1SJkF2ohQhH7tcMYP90pnv/Hv3EyWIXILp+i
	 NgzbkISs+NzJ75baFVEHXjRzeDJVQtrQjzP4OpMG9NrWq6fCxDMjoFTRE/wKwEUfjQ
	 hbH2B8klSdMxyBsIx5oQ4p5f1th1cbJqjs7bykynKcBt2Op9EOzcfhyAjm14Q7DwvN
	 jq9+oS/MStvEA==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Corey Minyard <corey@minyard.net>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Andrew Jeffery <andrew@aj.id.au>,
	openipmi-developer@lists.sourceforge.net,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: ipmi: aspeed,ast2400-kcs-bmc: Add missing "clocks" property
Date: Thu,  7 Aug 2025 08:28:51 -0500
Message-ID: <20250807132852.3291305-1-robh@kernel.org>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ASpeed kcs-bmc nodes have a "clocks" property which isn't
documented. It looks like all the LPC child devices have the same clock
source and some of the drivers manage their clock. Perhaps it is the
parent device that should have the clock, but it's too late for that.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../devicetree/bindings/ipmi/aspeed,ast2400-kcs-bmc.yaml       | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/ipmi/aspeed,ast2400-kcs-bmc.yaml b/Documentation/devicetree/bindings/ipmi/aspeed,ast2400-kcs-bmc.yaml
index 129e32c4c774..610c79863208 100644
--- a/Documentation/devicetree/bindings/ipmi/aspeed,ast2400-kcs-bmc.yaml
+++ b/Documentation/devicetree/bindings/ipmi/aspeed,ast2400-kcs-bmc.yaml
@@ -40,6 +40,9 @@ properties:
       - description: ODR register
       - description: STR register
 
+  clocks:
+    maxItems: 1
+
   aspeed,lpc-io-reg:
     $ref: /schemas/types.yaml#/definitions/uint32-array
     minItems: 1
-- 
2.47.2


