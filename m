Return-Path: <linux-kernel+bounces-769747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 891CAB2733C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 01:53:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DED921C84252
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 23:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 793EE2882B9;
	Thu, 14 Aug 2025 23:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=adomerle.pw header.i=@adomerle.pw header.b="jDz/gcSW";
	dkim=permerror (0-bit key) header.d=adomerle.pw header.i=@adomerle.pw header.b="b0xDyqN0"
Received: from mail.adomerle.pw (mail.adomerle.pw [185.125.100.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7AE1F582E;
	Thu, 14 Aug 2025 23:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.100.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755215608; cv=none; b=LnFxwyiVxikALaKDZx2BLhjgaPv9ZJ++/cdSnURWMIs+J1iC2vVpAIvd7/xGWPlonq9iXuxvTzI8U5pqpw25Fa7hUmZ68c2hkbo3YI3OT0G51Y2qeOyZ9cwKVandlxmVJijVFdhel9ZqRKpXDE4Yw7NCQuDR8LhOeNUYbVnPfRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755215608; c=relaxed/simple;
	bh=YM2sR/jwfeRUVd6J4tdr6x2v8dfofp+oWbWPY2oD0Oc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=teQdVCuaCm6F8cuFJl68PbniF+q1aNyy//bhCLqbvQKHGPzgQPr3KVi7GMi6aiUwRzD4imTiWBIzbm4tlEKBdRW5diZZwMGqJhQ67iTW9BN7rcQ8vdhkDBVT+PMq4CtnjLFXxOpsmGWr4twugjQmixZ/cOtF1xvCTMDz7Doyufw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=adomerle.pw; spf=pass smtp.mailfrom=adomerle.pw; dkim=pass (2048-bit key) header.d=adomerle.pw header.i=@adomerle.pw header.b=jDz/gcSW; dkim=permerror (0-bit key) header.d=adomerle.pw header.i=@adomerle.pw header.b=b0xDyqN0; arc=none smtp.client-ip=185.125.100.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=adomerle.pw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=adomerle.pw
DKIM-Signature: v=1; a=rsa-sha256; s=202506r; d=adomerle.pw; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1755215447; bh=ZU7DlddONCSaTAwvN0Nlr6n
	ijKVsujzk2ZmafXKcnks=; b=jDz/gcSW8C/DhshiaRXiFF4zrTkwcfb+ca7dl3YJOcXQRhNBBw
	s/f8z5WRUhBw/QgpM4qXomJa9/1oRBhZE35DLf8PqfXMnbDJBQMmLVbNUc1ZZnrp7VPqFYeu+in
	tbE4a7qFlvcK6p+iKsKd+xgKoz+bLuFEdCUvBVhRnikaghqJWBvNeuiekTlwY7HBOpEeLAPjylT
	b6T2HLQ7z3HxDlp4qmihOdZ2AJvHjSDiNw01HPlHDKBL4Y7dKjTPk2Dl4bWcOQlcET6Nsg3EO/i
	J9bc7AV7kvkcJQI9kFzVUu6eQv57/YMAIKBnbV7VJSTGIpO1ONAgbyxRbbrSMGKSwrg==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202506e; d=adomerle.pw; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1755215447; bh=ZU7DlddONCSaTAwvN0Nlr6n
	ijKVsujzk2ZmafXKcnks=; b=b0xDyqN04Gn9TRjAZcFlnGiMh7qJzyw7ls2Ho3EqxIGHzi8MP4
	AgwwMO8N0YHx+zVep74SMhrMoB3nTUcUOxDQ==;
From: Arseniy Velikanov <me@adomerle.pw>
To: Chunfeng Yun <chunfeng.yun@mediatek.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	~postmarketos/upstreaming@lists.sr.ht,
	Arseniy Velikanov <me@adomerle.pw>
Subject: [PATCH v1 1/2] dt-bindings: phy: mtk-tphy: add property for software role switch
Date: Fri, 15 Aug 2025 03:48:24 +0400
Message-ID: <20250814234825.810-1-me@adomerle.pw>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a boolean property to enable software control of the PHY mode
switching.

Signed-off-by: Arseniy Velikanov <me@adomerle.pw>
---
 Documentation/devicetree/bindings/phy/mediatek,tphy.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/mediatek,tphy.yaml b/Documentation/devicetree/bindings/phy/mediatek,tphy.yaml
index b2218c151939..a90890d4a86f 100644
--- a/Documentation/devicetree/bindings/phy/mediatek,tphy.yaml
+++ b/Documentation/devicetree/bindings/phy/mediatek,tphy.yaml
@@ -255,6 +255,12 @@ patternProperties:
           use the property "mediatek,syscon-type" for newer SoCs that support it.
         type: boolean
 
+      mediatek,software-role-switch:
+        description:
+          Forcibly sets the phy mode. In dual-role mode, it polls
+          role switcher and manually changes mode accordingly.
+          PHY port must be linked with the role switcher via device tree graphs.
+
       mediatek,syscon-type:
         $ref: /schemas/types.yaml#/definitions/phandle-array
         maxItems: 1
-- 
2.50.1


