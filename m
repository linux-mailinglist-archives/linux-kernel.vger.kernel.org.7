Return-Path: <linux-kernel+bounces-726445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B8CB00D26
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 22:32:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9DFA5A6372
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 20:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1737F2FEE2C;
	Thu, 10 Jul 2025 20:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="rNbkp3CD"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F732FEE1E
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 20:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=121.127.44.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752179425; cv=none; b=N6zvK3vgD6mH3b3ksf7/lO+ajJOt38wR7jI0eImCiIFmXy858Ki8anW6E/Gj4XZoCX3QUaquJkS9WwYUsr0M6iemLqQWHgLHxXNMMSQmUfcAZ44dSaClpSorGcJn2Y06wG1clD/8PfGq66hg56bViWSqOPN41C5J7/3VLwwklUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752179425; c=relaxed/simple;
	bh=9Io9SxChmRIK6BDp5/KTzPukX4KX6YUzjfMcGu9UAmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UtFJWPQnI5NdgjaqylfiyLkthBBsDf4LFyCrcmUNQqaFQCw4vE6N8bcFBYgPDWtJonIH+DmAhgX4kspitIPz4XprsCnczQizqG9/uUK6jd7GgeGE9ZsVqOoWHzacwFOX0xyX4+7elKcnmFjTh2kreOPIaLWU9vXlgSJrAGbhjOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=rNbkp3CD; arc=none smtp.client-ip=121.127.44.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1752179422; bh=WD//4ca9G2tXNShsHLnYO/KgTJJNX0yPu5juCOgHQC8=;
 b=rNbkp3CDkwDarfBLI9pXn4A+JWKsOk5RQ9QBITNdZrQDe00v6ArUMyrvHh7ej06hWExdytodn
 hXVvl7wncj2SEtY3sIPlt5QYAbCbxk3LnKs0zwQZQ95HNh0ocneiNsji1XJjdnWWw65K6gMn0Ox
 FbEXmj1c6eSXiNZGEKgrHUq24pUCaJPvtInmH5y7S68UADCBQxrP9LbdF+xQwOngfOjAormbsEL
 fB+/4Bh/gaiBNMXzlv3cVbnFbP5BqD3peOMptAQpx1FJoEG0bXMgti5RtwX3EC8OFC4JJc3RsLG
 wI5pvoMoCPkXAULaf8llyOHTutVqnM3SEmlGjTBzepGw==
X-Forward-Email-ID: 687022da5dd88a88be4f4e6a
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
Subject: [PATCH v2 3/6] dt-bindings: arm: rockchip: Add ArmSoM Sige1
Date: Thu, 10 Jul 2025 20:29:42 +0000
Message-ID: <20250710202958.3717181-4-jonas@kwiboo.se>
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

The Sige1 is a single board computer developed by ArmSoM, based on the
Rockchip RK3528A SoC.

Add devicetree binding documentation for the ArmSoM Sige1 board.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v2: No change
---
 Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index c5690098f2ed..43f6403ecad6 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -54,6 +54,11 @@ properties:
           - const: ariaboard,photonicat
           - const: rockchip,rk3568
 
+      - description: ArmSoM Sige1 board
+        items:
+          - const: armsom,sige1
+          - const: rockchip,rk3528
+
       - description: ArmSoM Sige5 board
         items:
           - const: armsom,sige5
-- 
2.49.0


