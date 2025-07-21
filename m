Return-Path: <linux-kernel+bounces-739814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB557B0CB61
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 22:12:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A3331AA4B58
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 20:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96C42239E8F;
	Mon, 21 Jul 2025 20:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=tahomasoft.com header.i=@tahomasoft.com header.b="GqMl7YqU"
Received: from chumsalmon.baetis.net (chumsalmon.baetis.net [209.222.21.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA462AD0F;
	Mon, 21 Jul 2025 20:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.222.21.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753128729; cv=none; b=A832BPT3S3gPhilkIQWjmhcCXK69DGC1Jxs1G8q/z1a2eANN7MgRE/pXbVtaLDs3bNvmxDO+nXG7i7uilZxviKnLS1/rqIUd7NeZCNd6OgqTMNg9KzVzftOf1MUKfeqoazCMVCRrf7zigqY8XF4PQNUO8XknJJWVCwYIZo8yc90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753128729; c=relaxed/simple;
	bh=lbNJOuD5DxygxivCxcXM0GtHg4S7UZs0gYbcGcYNsx8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f6hrP81L8MBUJ9ic8kJVCfJxE/M3m5pGEnGfgK9tg5OipuM09LpoilEdLlcJ5nmKtleVoqcVVbdtXX5jct0kfr3h6cDaUsLCnfHGum2vR+tgB1l3Qktf4VfhwAl8xXM6kTvzD5ZldwBzLh8mJk0QQpiDwfivi4NIMjmZWvWZAhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tahomasoft.com; spf=pass smtp.mailfrom=tahomasoft.com; dkim=fail (0-bit key) header.d=tahomasoft.com header.i=@tahomasoft.com header.b=GqMl7YqU reason="key not found in DNS"; arc=none smtp.client-ip=209.222.21.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tahomasoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tahomasoft.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tahomasoft.com;
	s=default; t=1753128726;
	bh=lbNJOuD5DxygxivCxcXM0GtHg4S7UZs0gYbcGcYNsx8=;
	h=From:To:Cc:Subject:Date:From;
	b=GqMl7YqUwr2bMcVWnRstt9EW0dKJ7mD8r+MjRBxppJfSs+2S032nqdTHxnIm+u9sc
	 bTkycMMfp52xCDw9eZY//cxZgAMl4Mb1sDboQB+Oy+Sc6qkm4+oy3SCTxU8gCZ843c
	 S6eqSSq4JqcRgInWYc/VxI0HVryZQpEcGOYkR07NvHUa0QnNZo000Ujfy6TVKqfEfS
	 Fi9Z6kJA9KC2KzY8LMiT4kcwky9oYptA9bTYIvpI3Yab/gCcLTHzzLPJITrAgo57it
	 3mpjOxi67pMbtKKWynnYGcSHWX4NDfAFkMOHKVt192O/jKiGQIhbmY1DmrgkMnJYpe
	 n+p5EZT+iZHMg==
Received: from localhost (unknown [IPv6:2600:4040:50b7:b604:da10:58b0:4f02:7df4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by chumsalmon.baetis.net (Postfix) with ESMTPSA id 48A0E27E5BC;
	Mon, 21 Jul 2025 20:12:06 +0000 (UTC)
From: Erik Beck <xunil@tahomasoft.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>
Cc: Erik Beck <xunil@tahomasoft.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2 v2]: New board support,LinkStar-H68k-1432v1 (RK3568)
Date: Mon, 21 Jul 2025 16:11:56 -0400
Message-ID: <20250721201157.233237-1-xunil@tahomasoft.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Erik Beck <xunil@tahomasoft.com>
---
 Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index 5772d905f390..7f3904b69293 100644
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


