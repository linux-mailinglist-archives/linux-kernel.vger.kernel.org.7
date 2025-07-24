Return-Path: <linux-kernel+bounces-744977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 181C6B11335
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 23:38:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C5601CC8402
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 21:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B0BE23A99D;
	Thu, 24 Jul 2025 21:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=tahomasoft.com header.i=@tahomasoft.com header.b="HvvIfrmY"
Received: from chumsalmon.baetis.net (chumsalmon.baetis.net [209.222.21.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C98239E7E;
	Thu, 24 Jul 2025 21:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.222.21.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753393100; cv=none; b=YRtMt71n6Gl/G89H8VkAOHcFYhPGRsWylbNrKzuTgxR83/T0eZvruQX1Wk2wqIAdeZkMivjb1m5xu8NJ+nBvoOFQkJUsjfjnzC6IqXRB10gi+IJ336brR+nnRBZxyLfpnglAiMFFKnaQfEcTrd/l9dyH144mVZUz9aSdQNm+yXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753393100; c=relaxed/simple;
	bh=WmdTK/AB2VM5/OZjks9WgJ5l/8tXDjMaW1u8BvINtFg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lUqwr1a+4FwsDzWmlNPhQFibHeFO5PXFbkYv6Q0ewwNteBVhGcPPtnjpafz49wldG9gWQZufVy6JSBjHOFlu85pz4aRP9zbn52heSwwLHUTv+efCG9Spkp5v8ahvjR226yi2pbTrHZjNCEvUEtoYZrHVOFxzqGhxZSTh2z8muVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tahomasoft.com; spf=pass smtp.mailfrom=tahomasoft.com; dkim=fail (0-bit key) header.d=tahomasoft.com header.i=@tahomasoft.com header.b=HvvIfrmY reason="key not found in DNS"; arc=none smtp.client-ip=209.222.21.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tahomasoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tahomasoft.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tahomasoft.com;
	s=default; t=1753393092;
	bh=WmdTK/AB2VM5/OZjks9WgJ5l/8tXDjMaW1u8BvINtFg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=HvvIfrmYoYlH9yoieEQofHj7TsHjb8v4HtFBh30ZiegwSbYbnIBKvVYwopvjAnSiZ
	 dbpDkM6aFYhodRsaLFJT3BRaPlB3l/mKsFaECpNTa/s3FTd+jmQKohV0SNE2Jmzj01
	 AghKNwLQxA2HXfVX1aUzG2N+NdW8CIq8CTMOsRnfs1TQu+oeYzniGXrFluNOMVfAvC
	 b/hCfw95U/kpPuAY7DxRui00LzFVfIgRQIw6/8og7vZjus2TL81vGWHJOIuFZiPzXP
	 J47x0tNmllcJcLYrhivFxQ7vgsGG3eyiKzXGXaptMBCL4CR9hLmas6aVbn1eAWL5SB
	 P2RgvKy0212lQ==
Received: from localhost (unknown [IPv6:2600:4040:50b7:b604:ee41:bd43:23a9:712b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by chumsalmon.baetis.net (Postfix) with ESMTPSA id B61F927E484;
	Thu, 24 Jul 2025 21:38:12 +0000 (UTC)
From: Erik Beck <xunil@tahomasoft.com>
Date: Thu, 24 Jul 2025 17:37:58 -0400
Subject: [PATCH v3 1/2] dt-bindings: arm: rockchip: add
 LinkStar-H68k-1432v1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250724-linkstar-h68k-patchv3-v3-1-b9f87b7306e5@tahomasoft.com>
References: <20250724-linkstar-h68k-patchv3-v3-0-b9f87b7306e5@tahomasoft.com>
In-Reply-To: <20250724-linkstar-h68k-patchv3-v3-0-b9f87b7306e5@tahomasoft.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Erik Beck <xunil@tahomasoft.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753393091; l=1069;
 i=xunil@tahomasoft.com; s=20250724; h=from:subject:message-id;
 bh=WmdTK/AB2VM5/OZjks9WgJ5l/8tXDjMaW1u8BvINtFg=;
 b=2gEi+SQPPYMw9OaZLtSzmV5+H3ashzJ1sh/xmsOhkEz0UvWtQsyH2QFFrlvysBeZLVa4cJUxk
 W1afdC/2m+FBeb+psyC50MqviraxT/XgQITDIUWG2zppp5NV3Unilu3
X-Developer-Key: i=xunil@tahomasoft.com; a=ed25519;
 pk=FTZVGUexvkWb4j8v0wbtm7CtJLijIAaa5x0XV72WWC0=

This patch adds a section for the LinkStar-H68K-1432v1 board to
dt-bindings.

The Seeed LinkStar-H68K-1432v1 is a travel router using an rk3568.

Signed-off-by: Erik Beck <xunil@tahomasoft.com>
---
 Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index 5772d905f390e53b44f9093d32b869a7e0655db6..7f3904b69293f31fdd4f6080fab5ce054c1abee2 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -1109,6 +1109,11 @@ properties:
           - const: rockchip,rk3588-toybrick-x0
           - const: rockchip,rk3588
 
+      - description: Seeed LinkStar H68K-1432v1 RK3568
+        items:
+          - const: seeed,rk3568-linkstar-h68k-1432v1
+          - const: rockchip,rk3568
+
       - description: Sinovoip RK3308 Banana Pi P2 Pro
         items:
           - const: sinovoip,rk3308-bpi-p2pro

-- 
2.43.0


