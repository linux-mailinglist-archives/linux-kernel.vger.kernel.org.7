Return-Path: <linux-kernel+bounces-812986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 78569B53F49
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 01:52:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15FE47B2E8C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 23:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A4E02E9735;
	Thu, 11 Sep 2025 23:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rl/zhTvO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90222D2489;
	Thu, 11 Sep 2025 23:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757634732; cv=none; b=U9uUxQ3ZPuKa4+UBaQQcbAXY14VHsryMQIacM2LIY6KogHAjVzx53pNu7DWK+1RTum0260d2hc8mDJroaGg/E8+OTR+OX7Z3YieaGdF/FZW1mLptvBf3CHjK3ONl5A2oRzICjHLac5Em7cjqTu0/PpyHQFBQf9LgJh5LQhdwnaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757634732; c=relaxed/simple;
	bh=4LFV1aHLarA4np76ZFMKJQ2eFSAdju8E2jQoi5tSsOM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dt+CRuDquFqv/Ozs0bIB2R6BP1P08/bShJDSBUWeHVMfnE4jtShFoJa1c6KlntCGxEIr4Rzy2bkP3Kni/MjwagpzYeTs4DlziP8TYq+AuJ3KL8XgSChurqxkGj3/3YPaHhAHpi762R6nouebFLgQVCntsb/AKu59SOxrsbJdFJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rl/zhTvO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6C675C4CEF0;
	Thu, 11 Sep 2025 23:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757634732;
	bh=4LFV1aHLarA4np76ZFMKJQ2eFSAdju8E2jQoi5tSsOM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=rl/zhTvOOB/4ps9TniOup8Gsd0MohfhWY281Tg98+TXikzsMDvjfzU00KnnDPK+br
	 uioT+n4Ztk+cQ2TaB6td62jWd+e29tYiaS1GZluCF+abarEdH0xp1/PeWdyLrs9whD
	 JvR2lDIWqWfKcmpuuguuGty/KmZm9FBgDl5s4nmJQkjqBSQ0tX8NFmKAux60T79g67
	 7dpzPgLWNvCUdU7d6bUzmpFC2T81kubFJ2oDR50YF5HB4cTOLAKJIsQ/et/OOj0s8H
	 hiawAZSPa97+zq71b3eycj4/gP1l29uMLJuX+EidUt0A6HVhNZ2WoUJDFrInufszaV
	 Jh42PTNpBtLzw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C931CAC58E;
	Thu, 11 Sep 2025 23:52:12 +0000 (UTC)
From: =?utf-8?q?J=2E_Neusch=C3=A4fer_via_B4_Relay?= <devnull+j.ne.posteo.net@kernel.org>
Date: Fri, 12 Sep 2025 01:52:09 +0200
Subject: [PATCH 1/2] dt-bindings: arm: sunxi: Add Amediatech X96Q
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250912-x96q-v1-1-8471daaf39db@posteo.net>
References: <20250912-x96q-v1-0-8471daaf39db@posteo.net>
In-Reply-To: <20250912-x96q-v1-0-8471daaf39db@posteo.net>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Maxime Ripard <mripard@kernel.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757634731; l=1100;
 i=j.ne@posteo.net; s=20240329; h=from:subject:message-id;
 bh=4vwduiIPx4gIZNv7o5hxBa5Uq0ID3f0a+4J6CQ7VeRs=;
 b=u4hR9YAItZhZw9wjTyrYUtnXOHA5ksrnXQXlt/qdfsKd6Q58sNeQQfGFd8zR+5MJLO2FunhNn
 5dxn69HNd10CN720fFMNoytLp+8zyr0dhTndceuRPrFAzulIRKeB2aV
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

Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
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



