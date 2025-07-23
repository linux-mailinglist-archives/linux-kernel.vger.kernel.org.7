Return-Path: <linux-kernel+bounces-742135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E598B0EDCD
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 10:57:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 635C3176A0B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 08:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F3B52836BF;
	Wed, 23 Jul 2025 08:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="P1gTSUfY"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE782836A3
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 08:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=121.127.44.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753261033; cv=none; b=W3Eh9ZA5fdnaJ/QnobnS2LEZyFCAWluUXPdHF3bZaCQQUL27a2rbDvhSn+3Zcpkjws4nzLQ+AY/L4+u1T5I0nmZCQauISmQV48fNIqT6IA703YvESmQYZKXKktsd4hqRPlOC1bylqBIZc6ti5kTpaJMlyTM1l8MWb/t/M8QawTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753261033; c=relaxed/simple;
	bh=ahvkPKaO4i/+m4F3BpUyyg5xYGEuC/2OHC2FUN1ndj0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FKsXwYETfu9rmS5sMcphOqT9o7q2bkXt8VYezrOk3w9S8nWBEQ4iHgfu+GTWjg7cgaSe/H7aygrB6Mcos/zkfZl5R8N3JAOk2dWJJc03xlnTOyNrxw27FV9gy9+VU+PRx66uv4mI2VsZJD3c8z+XKEe+6clR3us/E9q4axCV09w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=P1gTSUfY; arc=none smtp.client-ip=121.127.44.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1753261029; bh=ojRNLV8OGHzHzDmR9JJH6f4y0n4OGFprTOnH0ezBpQs=;
 b=P1gTSUfY+gnyyPI8hw2D0PFJsWpnjPySpLKxuA5sEgN+W8y0uQnWZwkjgIION6PBm6nTSgwnC
 aD23efkHa5h0mWQthBcK3dRj30Dxys9GHKYnLgI+G3b31n7bd+BpAaii1AYu56jiW6tF2XIkFSG
 JjRUOLNRFC997RICjIEea1JfH5na9aiCvvo3dByCfOWQv8W++KHI5mGSkzWwjnLLQdNtnKJ6kXk
 LPqOKZN6dr6tjpo0DlQ9OUZjhs706+h9fHjr3qKcwI4Ezqq3V5TIPr208ENCP/IrHMeA3NPHl8u
 s3LzXMNnwcl2cenq8jyrFNQQ7QXdf2DN9qtbayzF5N/A==
X-Forward-Email-ID: 6880a3e4144dc4a5e5baee1b
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
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
	Andi Shyti <andi.shyti@kernel.org>
Cc: Yao Zi <ziyao@disroot.org>,
	Chukun Pan <amadeus@jmu.edu.cn>,
	devicetree@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jonas Karlman <jonas@kwiboo.se>,
	linux-i2c@vger.kernel.org
Subject: [PATCH v2 2/5] dt-bindings: i2c: i2c-rk3x: Allow use of a power-domain
Date: Wed, 23 Jul 2025 08:56:44 +0000
Message-ID: <20250723085654.2273324-3-jonas@kwiboo.se>
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

The I2C controllers in most Rockchip SoCs are part of power domains that
are always powered on, i.e. PD_BUS or PD_PMU. These always powered
on power domains have typically not been described in the device tree.

Because these power domains have been left out of the device tree there
has not been any real need to properly describe the I2C controllers
power domain.

On RK3528 the I2C controllers are spread out among the described
PD_RKVENC, PD_VO and PD_VPU power domains. However, one I2C controller
belong to an undescribed always powered on power domain.

Add support to describe an optional power-domains for the I2C
controllers in Rockchip SoCs.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v2: Update commit message
---
 Documentation/devicetree/bindings/i2c/i2c-rk3x.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-rk3x.yaml b/Documentation/devicetree/bindings/i2c/i2c-rk3x.yaml
index 2f1e97969c3f..4ac5a40a3886 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-rk3x.yaml
+++ b/Documentation/devicetree/bindings/i2c/i2c-rk3x.yaml
@@ -105,6 +105,9 @@ properties:
       (t(f) in the I2C specification). If not specified we will use the SCL
       value since they are the same in nearly all cases.
 
+  power-domains:
+    maxItems: 1
+
 required:
   - compatible
   - reg
-- 
2.50.1


