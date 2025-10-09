Return-Path: <linux-kernel+bounces-847540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 00741BCB24D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 00:51:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 750934E438D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 22:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCA8B28724C;
	Thu,  9 Oct 2025 22:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="y25mSncA"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94148285CBC;
	Thu,  9 Oct 2025 22:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760050272; cv=none; b=BT3clwC8T4h+Jfxc+cWVbf2ZPWF5LL3z71CA5+EHwF6p0L6hPHNwmaoVQPxFP+8yKe+kTxeh6DJRMdgAwhXoNSVzW1K9uPgM2ncJK4KrPSSSYXp/u41/ltIjwZ6pCxqOVqybMdjPKwwi6JaPkUQWol3V8AmiQcM8NUOID+ry6ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760050272; c=relaxed/simple;
	bh=yetZRDOM30J/X6Gv1r/CAqCFFBOdjCy3r8Lt9KhU9DQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cK/rFnXHiQpVMGu+J1IpMOnlo9itOOCKCBBy+UN3QXCcbWwzPLwCG3sv23UOxRMhwwV86uhCMGYYCIC050qhmAXKpVcmdn4QJvTcob7FuY5YK/VSekgChl8dgf6diN2W94CjR8E3+U0EG6oH0KvV6qXxwejMbOXfePpFlXDZesI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=y25mSncA; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type;
	bh=xHcjTGHeFUn5M5ubUmRoUJaXj26i1Xu+TfXfxhkwXnk=; b=y25mSncAFQ/Y19TkctDzvC8gPr
	IbNA76rL9qiWYwjTh+AxgcV1Cdhy85aRcroC6UrTd+an1qix7JgFB+1BukTBc8kNG34NaiKj3Pd3m
	Emtz8ddtU5PAHq4UtfNkcKlsKK4LUMx/pxru1S/HV/R2Pd1A0gndf7IiPzi8y13HJIXpx+VaMpWY/
	rHFY1nV9Nck/JjY7nsxQ/ajFcrLluoQbTRyjcDn3FG6cGqsPnNU2Ps7LtjZep+dpm0cG97nmfdcpf
	kcFm9CymjspFAJwIBPgfLW6xzS1TAt/d1jESE/QeLrm5dRyccR5XFImbtdQNyVEgOfmJ9HPNY9+vV
	/C6Loo7A==;
Received: from i53875bdd.versanet.de ([83.135.91.221] helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1v6zTS-0007iZ-Ko; Fri, 10 Oct 2025 00:51:02 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: heiko@sntech.de
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	quentin.schulz@cherry.de,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	damon.ding@rock-chips.com,
	Heiko Stuebner <heiko.stuebner@cherry.de>
Subject: [PATCH v4 1/2] dt-bindings: arm: rockchip: add RK3588 DP carrier from Theobroma Systems
Date: Fri, 10 Oct 2025 00:50:49 +0200
Message-ID: <20251009225050.88192-2-heiko@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20251009225050.88192-1-heiko@sntech.de>
References: <20251009225050.88192-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Heiko Stuebner <heiko.stuebner@cherry.de>

The DisplayPort carrier is a very simple baseboard only providing serial,
ethernet and a displayport output.

But its main functionality is that it routes the Analogix eDP controller
to this DisplayPort output, which allows to test that controller simply
by hooking it up to a suitable monitor.

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
Acked-by: "Rob Herring (Arm)" <robh@kernel.org>
Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
Link: https://lore.kernel.org/r/20250723190904.37792-2-heiko@sntech.de
---
 Documentation/devicetree/bindings/arm/rockchip.yaml | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index 6aceaa8acbb2..1bf459890c64 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -1221,9 +1221,11 @@ properties:
           - const: tsd,rk3588-jaguar
           - const: rockchip,rk3588
 
-      - description: Theobroma Systems RK3588-Q7 with Haikou baseboard
+      - description: Theobroma Systems RK3588-Q7 with baseboards
         items:
-          - const: tsd,rk3588-tiger-haikou
+          - enum:
+              - tsd,rk3588-tiger-displayport-carrier
+              - tsd,rk3588-tiger-haikou
           - const: tsd,rk3588-tiger
           - const: rockchip,rk3588
 
-- 
2.47.2


