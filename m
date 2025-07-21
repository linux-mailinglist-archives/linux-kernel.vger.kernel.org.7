Return-Path: <linux-kernel+bounces-739826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4088EB0CB8E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 22:17:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7512C7B20DF
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 20:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BC1723B63F;
	Mon, 21 Jul 2025 20:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=tahomasoft.com header.i=@tahomasoft.com header.b="lir3akk+"
Received: from chumsalmon.baetis.net (chumsalmon.baetis.net [209.222.21.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C26F23AB9C;
	Mon, 21 Jul 2025 20:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.222.21.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753129011; cv=none; b=Os6v7P1AEEUnL7ecI74pzosiyM5+KrWuiY94yEHMjj2EqM63JASFLmPyPCxDVoMEk4zw6kjBreA28pdkj5hwpOZrnldOjMxsR0ESXKw/7RoRIpl9TLM/KGHHHiOB7wGzrobhad0ZGX8SEZiZVvrfzmeuGyVY7ezmUuvccPnsnZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753129011; c=relaxed/simple;
	bh=lbNJOuD5DxygxivCxcXM0GtHg4S7UZs0gYbcGcYNsx8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TMi40+cuiKtDT1rOWsxHlaZ12U+uRETMUdM9ETa0vUeLC+IPzj68FvujJaj6LwhLmUrycWwolSPOr3sZ4TXzaS9NFHKiBBNCJc8TuJ0ffpLtZDQErsI8lxtA03xg0bAUQq5SpqxNPgkRAkaek9pvny0sf5eSIux6jnrfJmM2NYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tahomasoft.com; spf=pass smtp.mailfrom=tahomasoft.com; dkim=fail (0-bit key) header.d=tahomasoft.com header.i=@tahomasoft.com header.b=lir3akk+ reason="key not found in DNS"; arc=none smtp.client-ip=209.222.21.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tahomasoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tahomasoft.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tahomasoft.com;
	s=default; t=1753129008;
	bh=lbNJOuD5DxygxivCxcXM0GtHg4S7UZs0gYbcGcYNsx8=;
	h=From:To:Cc:Subject:Date:From;
	b=lir3akk+MEcTMngiasVNYd3AiCRjP2vTJd9qMKlDuZVQvDswujN2eMfVZR6eWKBgi
	 RBjOntfG6lFahnqjFcpdDnV1kqtps6H/AW5QhA/whI2I0mxf3BzKAbxSlzsqNA51HA
	 lnrpSvB1MBPAFQvzRYKHidzz2r2hHPZ8cMq5VjDzEF10v21irwtAJwaIfiSBRJxDvM
	 85IC19yebpVHqP8lYzssEHX4T765jKGFJoyDVMCdprHvICdAp6RXS5vds6qAD4Xw91
	 VSCJyXduMOdgmswy7TXhUG/uz5j9AwICgrh1so9k24Xx/FBSEDK3XTelQS0LIj4daW
	 CGjJ+ZUPNx81Q==
Received: from localhost (unknown [IPv6:2600:4040:50b7:b604:da10:58b0:4f02:7df4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by chumsalmon.baetis.net (Postfix) with ESMTPSA id BD79127E5BC;
	Mon, 21 Jul 2025 20:16:48 +0000 (UTC)
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
Subject: [PATCH 1/2 v2a]: New board support,LinkStar-H68k-1432v1 (RK3568)
Date: Mon, 21 Jul 2025 16:16:37 -0400
Message-ID: <20250721201640.233818-1-xunil@tahomasoft.com>
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


