Return-Path: <linux-kernel+bounces-822599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2944CB843F2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 12:59:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D79F61BC2C77
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 10:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E434B3002A0;
	Thu, 18 Sep 2025 10:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G8s7hZmY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429CE18A6DB;
	Thu, 18 Sep 2025 10:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758193138; cv=none; b=tEIrglz+jFuAwd3ko0E8X9Zv1v9uxObIdPBA5v5Nc88sWsph1fYM+kjy73tCGn2Hx8+QeQfsWXxaRMnfia8qrnjKuk9RSci6Fb1imyGrpAWWnbMomWtTUwwi/xnOnzGla9COKfP44D4ZIJTcEsbWPXh9vd0M4lfaVVZpqyD71rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758193138; c=relaxed/simple;
	bh=JfXbLoAYPx2pAIs4oJkUHnbn8HvPZWOeNhod4g901PI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DlLw+VyDgOde6hSnVQfD21GOM8ASHhyxDdVjfeOi0cMQVPsMfiRv8XxkExVz+eUZTYEPHQA1SOnorecU49LGaQXi+N0GhB3ZLUdgZSZGX51uXTJejLWG+RCGlqm0VvqxAVyUnnYixdWS3uFvkIrovb8gdxmqhz1A/rhxjkSXfRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G8s7hZmY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D853DC4CEEB;
	Thu, 18 Sep 2025 10:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758193137;
	bh=JfXbLoAYPx2pAIs4oJkUHnbn8HvPZWOeNhod4g901PI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=G8s7hZmYRBl/oX5E5GiAt5vgrOdiDJz8LYbP/1T3fQp6qOOMLI83oZjDoRVr1Qrsj
	 K6Z2GwGj9FWzIUNNMUo4qFz2NSi9DXNaJkRnbGvjFYypusZ/T6/1fSrylCYOeqCh2O
	 gUubEuysEzu5FeVMJIbBBlOzUbNcvolj7igVqo5Exb66+wbLQceKPVwyVM1kKw7mPD
	 F3cJ3lh0cjJmSOU2hWKQB5PAVPL9xiA86pnyjskI7UUGk/iSo++8Hn5gNtQnmRNiCx
	 3eAIyS2CSC1prjxxrOZY8S+7hp7sKllxH/hU1O6hGfi5dFZDmO05jEhsAw5NJeNt1Z
	 96Gq6MZzIikMA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6FC5CAC59A;
	Thu, 18 Sep 2025 10:58:57 +0000 (UTC)
From: =?utf-8?q?J=2E_Neusch=C3=A4fer_via_B4_Relay?= <devnull+j.ne.posteo.net@kernel.org>
Date: Thu, 18 Sep 2025 12:58:43 +0200
Subject: [PATCH v2 1/2] dt-bindings: arm: sunxi: Add Amediatech X96Q
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250918-x96q-v2-1-51bd39928806@posteo.net>
References: <20250918-x96q-v2-0-51bd39928806@posteo.net>
In-Reply-To: <20250918-x96q-v2-0-51bd39928806@posteo.net>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Maxime Ripard <mripard@kernel.org>, 
 Andre Przywara <andre.przywara@arm.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758193136; l=1236;
 i=j.ne@posteo.net; s=20240329; h=from:subject:message-id;
 bh=GxXI6NJW9t/fO0BoT9gBld9sqiI4uwUuxiCCn6jsYZ8=;
 b=7ViBDRCcbfuuKW0xOEmrt/a3RTnfDNy5KfIEfIkmiwQTwlnz8y5ogApOKM6L9sH60C93kaQCU
 Qu0Q5bIUhynB6wV8+AZk3SLm/48afNXFvMtvd94CZUdA2fvn8owAmPN
X-Developer-Key: i=j.ne@posteo.net; a=ed25519;
 pk=NIe0bK42wNaX/C4bi6ezm7NJK0IQE+8MKBm7igFMIS4=
X-Endpoint-Received: by B4 Relay for j.ne@posteo.net/20240329 with
 auth_id=156
X-Original-From: =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
Reply-To: j.ne@posteo.net

From: "J. Neuschäfer" <j.ne@posteo.net>

The X96Q is a set-top box with an H313 SoC, AXP305 PMIC, 1 or 2 GiB RAM,
8 or 16 GiB eMMC flash, 2x USB A, Micro-SD, HDMI, Ethernet, audio/video
output, and infrared input.

  https://x96mini.com/products/x96q-tv-box-android-10-set-top-box

Reviewed-by: Andre Przywara <andre.przywara@arm.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
---

v2:
- add review/ack tags
---
 Documentation/devicetree/bindings/arm/sunxi.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/sunxi.yaml b/Documentation/devicetree/bindings/arm/sunxi.yaml
index c25a22fe4d25cbd8a8132689f1326548f7f43f2c..c9940b44bc888f7ab81ace671040bd663556c113 100644
--- a/Documentation/devicetree/bindings/arm/sunxi.yaml
+++ b/Documentation/devicetree/bindings/arm/sunxi.yaml
@@ -963,6 +963,11 @@ properties:
           - const: hechuang,x96-mate
           - const: allwinner,sun50i-h616
 
+      - description: X96Q
+        items:
+          - const: amediatech,x96q
+          - const: allwinner,sun50i-h616
+
       - description: X96Q Pro+
         items:
           - const: amediatech,x96q-pro-plus

-- 
2.48.0.rc1.219.gb6b6757d772



