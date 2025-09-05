Return-Path: <linux-kernel+bounces-803347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0028B45DEE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 18:22:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F5B01CC2ED6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 16:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAA24313292;
	Fri,  5 Sep 2025 16:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="EMdwUvBG"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96644537F8
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 16:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.215.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757089231; cv=none; b=ItEkGXM5aRo9AJJpG4Lswf1+msSfM9YDpf4N3LvwrQ3mcXMom+tx2/V1glsAXvfS5r/HWVvajF8ftd4jkXn/gJmtFFjMgcJBw0xCUUa0OVS0IuRoGftWP2Nvc1OoutPBvmMtt596RHbg1c4sPxIsIaArNeRJ92bg+iVAe+DO/GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757089231; c=relaxed/simple;
	bh=Bnh5seKQMsR1G1oydvoy0Dphjh0rgS7UNNg68MYXUj8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FMTKx1C5FYrUSJ392zhhmMjYpjehiwkBV824WF5K8fJwPaHDxLDZxrei8IEv6RlZrujsaMRWuhPtgni6HSq1gEPhRK1cAlpmxcaDew4ZMEq9pjIdKmWDpSSp1WbSsgphQMEoAQkTqHjI2liKeE0NFzFmSMN9uPkopIG5t1vKJj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=EMdwUvBG; arc=none smtp.client-ip=149.28.215.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1757089228; bh=vPBR/G1y7xyavSQpDAIp0nog4SwQ2XUBPu6qeNurwdE=;
 b=EMdwUvBGlqquSXurotr2f1DmW+x8178y7oB3eCM2yCUQH0I6gug7dfd9UxTNSYHotETINMjKe
 ufAkWkgMYlDIs3zClMipVosL2mJ4UO2i6StkTF6sHDMNPvptn6csNhlEsF9BJlbV9G0Z+GhJltY
 Zky+v9z3Ex9dGhHJ2cqcb1Aobn+HPmtm8baVqwL20AySI8Ybc7ZHI3ebyB14oj1GbgQdZTTJ9mH
 lrg6TaP4NaO3luQNV6o7jVNWh7RtmoVFXP6/szOJaymszbESp+SxVM0mDbifGX8syJZYAoH55WG
 WuMweJQmC8gv0tZNfBh9ESJl2rIPis+/P0PhcIGVmcMA==
X-Forward-Email-ID: 68bb0dc690d039a4fd84d704
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.2.13
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
	linux-media@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jonas Karlman <jonas@kwiboo.se>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v3 6/7] media: dt-bindings: rockchip,vdec: Add RK3288 compatible
Date: Fri,  5 Sep 2025 16:19:24 +0000
Message-ID: <20250905161942.3759717-7-jonas@kwiboo.se>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250905161942.3759717-1-jonas@kwiboo.se>
References: <20250905161942.3759717-1-jonas@kwiboo.se>
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
Changes in v3:
- No change

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
2.51.0


