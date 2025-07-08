Return-Path: <linux-kernel+bounces-722495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C239CAFDB4F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 00:50:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 490B77ADBAD
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 22:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 855B222D786;
	Tue,  8 Jul 2025 22:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="U/Wx4eOD"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF84622578C
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 22:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=121.127.44.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752014983; cv=none; b=Rwe0YwwpBMh8JNjx5xUJ5gTR33JFU3J1BG8WUS2BTd04jQ1jalfM6N2ica5+i9Hz9CCi/YabwfgOJ5YOwcwaQCRJbK/C1gaLNHbQqyDDQhPopNm+ABQT1dFmqcPlLMocCemHgD8Ijo0hSKjdRGPVeXDpMRK+a7SC+PSz1r0QWpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752014983; c=relaxed/simple;
	bh=5J0VHQQPIukmhLAtfNaOxgRodqKnOMQJ2hLhEG1OPTU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ID339T0ZC9R587KKKol4B/bZjMdqzZHBgndB9nPzoDTBEMgukg7LNbbco1KaI1yA4vhJwMICa5tAV8n5ZSbgcY7ZLbunOtdgyZLfhRpxRHBZnjoa4XAmyOZbPtqo0SP7F1anTjy/935MF5ubooostu1WOf00sPtYewbi6H+ymZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=U/Wx4eOD; arc=none smtp.client-ip=121.127.44.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1752014974; bh=BmqNJa1An8REJ9AUcRdzNVNiR2hfr+EH12RkNn7sOKw=;
 b=U/Wx4eODl5lnsxHEISjQg5x02Q5PtnGaac4RNmCq+j4Enzs1I9S7QqtPlRfI06CcFQv+1w8W/
 Zp71t9YCOaO38u806uirBcn5+tNtJ7T7THCTxsAT7EreyVWf5oRacypc16oJb25gxgCYGEChUFo
 K/IagAIryv++zCy/dwb09Nv9tYEsZiazzMx5DW8D6EhOLhug2L06dny7WXKDvTLurnJjTMokyao
 16eSmpNe9BEUUHSmrLQXNuEpF50ooDCNWPIeqFCGPUMTKm224e2lfN97BR0TwKD/LEybNEycnyC
 bdpWYgrkmYiqqLymD7BDBAu3NfupoogoLxj71ijLM0ag==
X-Forward-Email-ID: 686da07b75317ad3cfdad3b7
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 1.1.3
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Heiko Stuebner <heiko@sntech.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Yao Zi <ziyao@disroot.org>,
	Chukun Pan <amadeus@jmu.edu.cn>,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 1/6] dt-bindings: arm: rockchip: Add Radxa ROCK 2A/2F
Date: Tue,  8 Jul 2025 22:48:51 +0000
Message-ID: <20250708224921.2254116-2-jonas@kwiboo.se>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250708224921.2254116-1-jonas@kwiboo.se>
References: <20250708224921.2254116-1-jonas@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ROCK 2A and ROCK 2F is a high-performance single board computer
developed by Radxa, based on the Rockchip RK3528A SoC.

Add devicetree binding documentation for the Radxa ROCK 2A and ROCK 2F
boards.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 Documentation/devicetree/bindings/arm/rockchip.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index 58b9312c6c73..6636f98561e7 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -875,6 +875,13 @@ properties:
           - const: radxa,rock
           - const: rockchip,rk3188
 
+      - description: Radxa ROCK 2A/2F
+        items:
+          - enum:
+              - radxa,rock-2a
+              - radxa,rock-2f
+          - const: rockchip,rk3528
+
       - description: Radxa ROCK Pi 4A/A+/B/B+/C
         items:
           - enum:
-- 
2.49.0


