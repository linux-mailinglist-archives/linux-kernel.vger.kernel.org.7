Return-Path: <linux-kernel+bounces-726443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05B50B00D24
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 22:31:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60A1B1C83980
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 20:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B67A2FE366;
	Thu, 10 Jul 2025 20:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="AJhHkeTh"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A372FD594
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 20:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=121.127.44.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752179415; cv=none; b=NoJAMytZe2NmKjh6jhk7uSsOzbz113B5xh7lip+K4rcNZbAh1FUfsg/2NJPw84G+7s2/Jel+hl5O3NmOuTBHOa7xXozXQRhGNqDsGBcnQQ+ZMO4owN3xr79nOkhZl0RJdaJgfgeHXAjSYxlGgge61IfV86kPFXqaJ2Q6DA42sTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752179415; c=relaxed/simple;
	bh=FqFX8bkUWMkFVTk0hU6fCdMHPAdixvRqKNEF4nicaOk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NVORC91+TDXp0Y1iyFAP4dOOhECV5+GjFLhG09GFPyUrfy6JQJDfd2fOaHwUtKa+L3feTAOYfVf5iS5iI9Jdamnm2KTKQu+RaB5D0VTZOcW+QNhfqpPSVKPESZu3t6e08lNW/PTr4fBZyzz/YKIyCD+NIsyRlkQLK6W3KyIXJ7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=AJhHkeTh; arc=none smtp.client-ip=121.127.44.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1752179412; bh=GQyPTyaMdzjot5Jenk6eOQc0UNxfrnd2eaBptVXTamg=;
 b=AJhHkeTh8y1hShq2CFsvL+NP4RCxaxtu5VxwCcZHkDztSCNVE4WpKOX6cwbAe/ROC9sZXCcCf
 DjAarv4dwOF4CFsHn0Olc1fMRqqpx0Yy+wVjqyyow8bDFF8/X8Lj4wXTJOGxSoKPO0Zd/FIil87
 5TUECxioMqXkW+cvWY/Dq23ROWplwm+8qqURMYmJbZKUFqfWQNv58o++26a61An9/Dzd60zP57G
 BAheLkySz4s63BB85uANMxIZl3scX/UsE0eTFJVUnCSxHEl/kZJLP3afcrJaMf4f9e3Qgs05yD8
 Pr/h30v7MhMXArh1jzl4O4AMJqM0MLschY8VhaIX4r8g==
X-Forward-Email-ID: 687022d05dd88a88be4f4e40
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
Subject: [PATCH v2 1/6] dt-bindings: arm: rockchip: Add Radxa ROCK 2A/2F
Date: Thu, 10 Jul 2025 20:29:40 +0000
Message-ID: <20250710202958.3717181-2-jonas@kwiboo.se>
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

The ROCK 2A and ROCK 2F is a high-performance single board computer
developed by Radxa, based on the Rockchip RK3528A SoC.

Add devicetree binding documentation for the Radxa ROCK 2A and ROCK 2F
boards.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v2: No change
---
 Documentation/devicetree/bindings/arm/rockchip.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index 28db6bd6aa5b..c5690098f2ed 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -881,6 +881,13 @@ properties:
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


