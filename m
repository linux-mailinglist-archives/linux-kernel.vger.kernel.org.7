Return-Path: <linux-kernel+bounces-726447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07C86B00D2D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 22:33:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B60AB43F30
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 20:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EEAC301129;
	Thu, 10 Jul 2025 20:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="XS80n9VP"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311052FF488
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 20:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.215.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752179438; cv=none; b=RvnHtCA3eARiP3zDzmsTElTaAMxUBYvpX3+vNP7/vAP0S/ZWBy1NRZkZPV4WN/dJTMAX0lsTZUEcGG/ovB50FiD8nyAOzTVm2ROGVHyd1WWdMDqx/yQ3Ahza/qeSHEtc1X+JcO8FpF4YnvgMyHA2FxU66KKOQSbzfPZJa3ZNQis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752179438; c=relaxed/simple;
	bh=holUeJkPXzBBlMnINF4UKZGJ2i2JbROaLz1D6qU2VbA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rjN/tLfAkOOlLZSog6kkRZUFf9yn2xM/glcx5PIuA7y2038cOaDYksJfL3+E/q/cUpHlC66kjvEFCy7AHGG6LY1kdcXM0H0RxinSTMxc/0q0FNmPY/DJunF5gR5oa/VsTrZYPvcKD+S7Mwng9XrR1d2IAja7brRWc6w07ZfPvb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=XS80n9VP; arc=none smtp.client-ip=149.28.215.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1752179436; bh=I7hcGT9PAvJJH158i34Hno+3Z32x18bujg7jOoDu7YY=;
 b=XS80n9VPTYuuiUj2RX+YDc4sMYq14Z1PHaVp29INshZCvbf13qyVHV61Ayh3O5rG0SPsAkiol
 M8TGLMFvd5FK3wa5Qkio0nV0RW6Rsw07eNegj+xkB17g9aLZ2amCBoTlUBtGhpDwHQiVj0btpML
 ttzuDujR5HqZlm3R3Zqg1eZ6c4bWf7hZemRHydRr1zgAABQNE8P2MPQ+3Ekd8ySf3UMCQ7/WNzW
 t5vNu1KhOknRvTONcEMKs2VIxUZeLRVTHKoOGFqjrIhRnQneM42dhO91ueSH8On8hAZZxLm/3Lz
 KEVLlZbn7WYNPHBqzMO00g4yE9B8fuHdFg4GAwsT3/lg==
X-Forward-Email-ID: 687022e35dd88a88be4f4e94
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
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
Subject: [PATCH v2 5/6] dt-bindings: arm: rockchip: Add FriendlyElec NanoPi Zero2
Date: Thu, 10 Jul 2025 20:29:44 +0000
Message-ID: <20250710202958.3717181-6-jonas@kwiboo.se>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250710202958.3717181-1-jonas@kwiboo.se>
References: <20250710202958.3717181-1-jonas@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The NanoPi Zero2 is small single board computer developed by
FriendlyElec, based on the Rockchip RK3528A SoC.

Add devicetree binding documentation for the FriendlyElec NanoPi Zero2
board.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v2: No change
---
 Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index 43f6403ecad6..e3d3d483de4a 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -325,6 +325,11 @@ properties:
               - friendlyarm,nanopi-r6s
           - const: rockchip,rk3588s
 
+      - description: FriendlyElec NanoPi Zero2
+        items:
+          - const: friendlyarm,nanopi-zero2
+          - const: rockchip,rk3528
+
       - description: FriendlyElec NanoPC T6 series boards
         items:
           - enum:
-- 
2.49.0


