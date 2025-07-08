Return-Path: <linux-kernel+bounces-722498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB90DAFDB54
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 00:50:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD47B1C251B9
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 22:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8850E235345;
	Tue,  8 Jul 2025 22:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="Hg5cPYOy"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF75229B2A
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 22:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.215.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752014998; cv=none; b=CwjhfQL98OSw3yWZaBbdumZp//1+fjDgimh9wpQPiW/r6h6ncuKvQ80uX6yNOh+LqfXin7uKVK0Nq8epHZCNKZh9nOQUlE8+QCMScIuPJWVepkTPK6Yxp2xTFJ2qwevJ2hMExNTTnYHGZ+P6oC7x/SM9rPOVVqsAsOGkwt8z5Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752014998; c=relaxed/simple;
	bh=GZq+3L9sFoVFK9gIPxTEn0Bo4tQPkWIJdrAJQlI/Dxo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DONHOE61bcUZPjXX0ioCH7NukrJzwril+iKavVsdhM6SJv3iwHBnXCnqBkOzXsIAdqvHO0XaF2tUqbpDT80vN3XtGoo+iuhMB4vJOsQx9WTaVaXNDydSjqZwIfyPQDw9zUmbgczdljElcM77mVAX2NXQ8YluOpwcnNWYZqulCmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=Hg5cPYOy; arc=none smtp.client-ip=149.28.215.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1752014990; bh=yT3e1bZwMzdIvb+LiFYh2YJIHOV5XQefyQ7IFbmOpAg=;
 b=Hg5cPYOycf3ZXQYIriquNADjjkYlRXrx/nIWRaBnHf9gLP8n0FPBxgjl1D1TTXKnMK0cAUA7C
 GNaLLt4m9oX1/2It4eCKvw9tXbPInbjs6t/YSjnki4v/EaDmGwMoyw3HDLFEhzFF3C8Q/4pYBXU
 CqWUL4uNzMR6g2/Nb3eWIpEPPif5Vyj0gkctM14OsEDrfHxHxP602PfZWLtbTnRYcOmP1xHXV3W
 LkWEQ7t5T3MZZoUTG/FmL548uV5i1CSj7qPzGiO4rGAvatKXwTcJxuOx0V56zZ12cvvdWIGz/R7
 2IeJN3XZiKqXedKXjjD2YaCFXBhmHU7EDKfCg8dp8nAQ==
X-Forward-Email-ID: 686da08975317ad3cfdad3fc
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
Subject: [PATCH 3/6] dt-bindings: arm: rockchip: Add ArmSoM Sige1
Date: Tue,  8 Jul 2025 22:48:53 +0000
Message-ID: <20250708224921.2254116-4-jonas@kwiboo.se>
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

The Sige1 is a single board computer developed by ArmSoM, based on the
Rockchip RK3528A SoC.

Add devicetree binding documentation for the ArmSoM Sige1 board.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index 6636f98561e7..e955e3334e35 100644
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


