Return-Path: <linux-kernel+bounces-761604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20FF2B1FC69
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 23:27:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16871189850A
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 21:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A96AE28750E;
	Sun, 10 Aug 2025 21:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="MgjkuWpb"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C931D5ABA
	for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 21:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=121.127.44.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754861173; cv=none; b=Ht3CmBlHDuAlLAMELeO4dNZbfM/oPhGaAB10JE0jGXQsdbQcgIl7DOEzSFL0nR9bmotE58HDhdJ1gxHibcg2awfxZGLwo7ftm/XI+qJ/PmuJiJjQ/fWUpQJZy8Xn4SIF/wQfdBmgMYrlymkNjfcjypFjRJXziDS2SoBZ8dipozg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754861173; c=relaxed/simple;
	bh=B97o6FrHK1xslxVHw0WLUvmxL7U8P6Hy89OqnlVzKTY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AdyEGG+NTxf9h60BN499ZyK5BrnQF4QxyRpFgIVMONvrgZhRRbijAYp1z/rsIyM8JN/E+iV8f8ujBhfeyotMJ5BJe9MDjvfertC9py6cvt414D6WVcyVLIfzBAUWKAjUFLCLojFHwQ7LOIc66ICM3HOicGmAX/mgF5oqDE4OZV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=MgjkuWpb; arc=none smtp.client-ip=121.127.44.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1754861170; bh=dhuwCZmH8EoRCECnmC3TQDpoh6EUZFY4ECh5j02bOWc=;
 b=MgjkuWpb5CcmJFiA3lHyliSIjYvoNIeYw+ptr4F/akPZwUXe1uYYkcHnxqNoV9tq/2KrEB6//
 BPoWJbzASnOBCIxFoZ3Zv24gh4TR32jUahjVzWydKWwTiqdjdwebBTjLQ5zGsga73C6DR5Rz/Rn
 +s1+jXY/aw0yWvZoYFjMkaqtr9RUu21a1Xm9TOXdOhBYvKUmaFLyp2utJGbbqF+H5CotBloz960
 y7hS0403ZL49G2trHHBJT801O4BIIi0Jfj+ZFedJJl2ISysMQLwp8tkhUxXT6MqRsfzcOl5TV8x
 iCP/VHXGoIuvn09clccIDyz7NI7pOxGALjwcr76SlVEg==
X-Forward-Email-ID: 68990e70797ab89627792477
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 1.2.4
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
	Detlev Casanova <detlev.casanova@collabora.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>
Cc: Alex Bee <knaerzche@gmail.com>,
	Nicolas Dufresne <nicolas.dufresne@collabora.com>,
	Sebastian Fricke <sebastian.fricke@collabora.com>,
	linux-media@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jonas Karlman <jonas@kwiboo.se>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v2 6/7] media: dt-bindings: rockchip,vdec: Add RK3288 compatible
Date: Sun, 10 Aug 2025 21:24:36 +0000
Message-ID: <20250810212454.3237486-7-jonas@kwiboo.se>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250810212454.3237486-1-jonas@kwiboo.se>
References: <20250810212454.3237486-1-jonas@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a RK3288 compatible for a version of the Rockchip VDEC IP that only
support HEVC decoding.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
Changes in v2:
- Collect a-b tag
---
 Documentation/devicetree/bindings/media/rockchip,vdec.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/media/rockchip,vdec.yaml b/Documentation/devicetree/bindings/media/rockchip,vdec.yaml
index 96b6c8938768..809fda45b3bd 100644
--- a/Documentation/devicetree/bindings/media/rockchip,vdec.yaml
+++ b/Documentation/devicetree/bindings/media/rockchip,vdec.yaml
@@ -16,6 +16,7 @@ description: |-
 properties:
   compatible:
     oneOf:
+      - const: rockchip,rk3288-vdec
       - const: rockchip,rk3399-vdec
       - const: rockchip,rk3576-vdec
       - const: rockchip,rk3588-vdec
-- 
2.50.1


