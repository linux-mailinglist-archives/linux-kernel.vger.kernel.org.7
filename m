Return-Path: <linux-kernel+bounces-742136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B996B0EDD1
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 10:57:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 142496C3001
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 08:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C0F528467D;
	Wed, 23 Jul 2025 08:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="E2clw4Ja"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAABB283FCE
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 08:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.215.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753261035; cv=none; b=LaX/hG5UakxWT8Kiqq5Q/lBvqmTdOmOK6AljlphR+RcEJ4PdG01QzH/9NeGHwwKCINPlqBk2qjDC8EDCvN2r/Tz4SPEJl3B4LWt6Y+fL3JDGrxBHLccwDhynJuabkUNnE4ZYXRu+3HvJpgrOc3/UZZhuVxfl25uX3sFsG1CSxYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753261035; c=relaxed/simple;
	bh=49hlALmvO3tf+FxtZgb/HogpsYZxbw25DjGIXxz7B+I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r1CsmpZJsItMH2ghQlERrnU3/5BE4ayM4B99WCbShRWmA6Au1Le4D+LrD/xiLmx5FhQ0eYhKUgL3mjW04LJ5Nlq20CjtDXfIYzs7aAkdQiIxLVtng67AP1Meq1J6uLCInEDUtsAYfRb7v/VBsNoGn92O35ainpE/XXrxx4RTLcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=E2clw4Ja; arc=none smtp.client-ip=149.28.215.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1753261033; bh=PKSo/fJwr04VNmGVrbdVZ+djNyZPEPotepO7Vigj2G0=;
 b=E2clw4JajGM3ZetV+GMrh2SEn31GszR3mqmlfvYXh+SUR1cUUayB4kBxK6vYauADQ4vopDvwH
 oh0Swpsq2Bp/wF0fM6i677G8uSppcco1Tu/ZVLI4OTnByUikIzZ4bAQTew9rX4c9afkgAEa2Raw
 VujcKNxedEJtSHkhqXFPlNR8PVogtJAFNG2j+oQ54YEi53Rws4KGQDvX/CLobtXpCbS58vTGmNQ
 QfBFegwapQK1L8WxaOb3RwDk0ORSLOSoxrI7nsVLQl22k2SeYtwqjstS6hamtGtpsG9caMUc8jh
 jDMfFof51cVfkaYBJ7jZMBOLJpOjc5hX0nBC/5xGL3JQ==
X-Forward-Email-ID: 6880a3e0144dc4a5e5baee04
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.1.6
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Heiko Stuebner <heiko@sntech.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Yao Zi <ziyao@disroot.org>,
	Chukun Pan <amadeus@jmu.edu.cn>,
	devicetree@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jonas Karlman <jonas@kwiboo.se>,
	linux-gpio@vger.kernel.org
Subject: [PATCH v2 1/5] dt-bindings: gpio: rockchip: Allow use of a power-domain
Date: Wed, 23 Jul 2025 08:56:43 +0000
Message-ID: <20250723085654.2273324-2-jonas@kwiboo.se>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250723085654.2273324-1-jonas@kwiboo.se>
References: <20250723085654.2273324-1-jonas@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The GPIO controllers in most Rockchip SoCs are part of power domains
that are always powered on, i.e. PD_BUS or PD_PMU. These always powered
on power domains have typically not been described in the device tree.

Because these power domains have been left out of the device tree there
has not been any real need to properly describe the GPIO controllers
power domain.

On RK3528 the GPIO controllers are spread out among the described
PD_RKVENC, PD_VO and PD_VPU power domains. However, one GPIO controller
belong to an undescribed always powered on power domain.

Add support to describe an optional power-domains for the GPIO
controllers in Rockchip SoCs.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v2: Update commit message
---
 Documentation/devicetree/bindings/gpio/rockchip,gpio-bank.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/gpio/rockchip,gpio-bank.yaml b/Documentation/devicetree/bindings/gpio/rockchip,gpio-bank.yaml
index d76987ce8e50..bdd83f42615c 100644
--- a/Documentation/devicetree/bindings/gpio/rockchip,gpio-bank.yaml
+++ b/Documentation/devicetree/bindings/gpio/rockchip,gpio-bank.yaml
@@ -41,6 +41,9 @@ properties:
   "#interrupt-cells":
     const: 2
 
+  power-domains:
+    maxItems: 1
+
 patternProperties:
   "^.+-hog(-[0-9]+)?$":
     type: object
-- 
2.50.1


