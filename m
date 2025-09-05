Return-Path: <linux-kernel+bounces-801923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 55602B44BAC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 04:40:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8784118937E8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 02:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBD3D22172D;
	Fri,  5 Sep 2025 02:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eMTvEqGX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30BC83BB44;
	Fri,  5 Sep 2025 02:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757039985; cv=none; b=TkunIchZx0EJHBZrO7USuX8CAdKck7dileUTw3zqMujfYc1coW2vybqAyUxCJhsuSqv3DQjwfykxypKKY/dAQsZvkYXT8i4ICyTx53BmdX8JhYUHDT0xyLynhc6CTeRiU2akWgG7BxTmqfdHva8+GwdXF1Xkm5sG+TN3jLctbkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757039985; c=relaxed/simple;
	bh=vgB5QZkxWhbewoikjI6YlorQ3Jl1QsSR04mb3VV44V8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=M73HMLcz71cxTZ927dcHRcK7i8C6x/rGAk9u/NWb0KXN41C2HgCci82QgEKmHEpeVsSKOLuMcTdTNxQPxG/Bh5c7W7TCi5CnDY/15W0DMMeLo8nclZTQkiN3/ZdPSRMwWgTBl6qn/SdGSxoQyI8qrCZswhF8Vuvvt47DNTo1TVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eMTvEqGX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7BE59C4CEF1;
	Fri,  5 Sep 2025 02:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757039984;
	bh=vgB5QZkxWhbewoikjI6YlorQ3Jl1QsSR04mb3VV44V8=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=eMTvEqGXGoR6YQrwZt+tkOQ0eQYZa9PoBZUU94Ay+9FkCcID/1LLUMe1d0msrC28T
	 57RImBnbcWSHfZIJvuejCfGHoFzQ0WusuYqQ5nZMbmL3c7Lekb1KOVn60Mgy48UJ4e
	 l5i72wzJ2PRooAx5kaiDhwTDDKoqi26Lg/txfRaqJQimmJUpNAGz0dCV5+Rc4WnPij
	 5SmTtE6IUPBcIALXOdoQ4P6T5p+CgQsRCszAHu6CCxNlCX7FJ9QBWrtoiWyMWB+oIo
	 EcznNPUehdmlfovq/CswdwOuwy3CzeX1MRp5OpWZTQuquL/GWyZnOQXhZhw/u0w9Li
	 kRlXNz0iBJF1A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64D47CA1013;
	Fri,  5 Sep 2025 02:39:44 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Date: Fri, 05 Sep 2025 10:39:40 +0800
Subject: [PATCH] dt-bindings: power: keep alphabetical order
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250905-pm-fix-order-v1-1-3596e03d66e6@amlogic.com>
X-B4-Tracking: v=1; b=H4sIAGtNumgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDSwNT3YJc3bTMCt38opTUIl3TRDPLpDQTM0MjE3MloJaColSgJNi46Nj
 aWgA2dWuCXgAAAA==
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Jianxin Pan <jianxin.pan@amlogic.com>, Ulf Hansson <ulf.hansson@linaro.org>, 
 "hongyu.chen1" <hongyu.chen1@amlogic.com>
Cc: Conor Dooley <conor.dooley@microchip.com>, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Xianwei Zhao <xianwei.zhao@amlogic.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757039980; l=1166;
 i=xianwei.zhao@amlogic.com; s=20231208; h=from:subject:message-id;
 bh=v+dUEzn1Vq7pqlYwSYypI3RmFlt816zF2fbTkSK6CaI=;
 b=0NIo6ncVhxzcSBYsUPwwNstjwwmTebpSb7P86Z3fS5sMjjo8uiUE2k4Q2oiWF1Ym+XQVj4maz
 rorfr+gR0aNBFnqYjT9M3EUghIpXGKaFqKI+kHsytLqcqv892pudIQQ
X-Developer-Key: i=xianwei.zhao@amlogic.com; a=ed25519;
 pk=o4fDH8ZXL6xQg5h17eNzRljf6pwZHWWjqcOSsj3dW24=
X-Endpoint-Received: by B4 Relay for xianwei.zhao@amlogic.com/20231208 with
 auth_id=107
X-Original-From: Xianwei Zhao <xianwei.zhao@amlogic.com>
Reply-To: xianwei.zhao@amlogic.com

From: Xianwei Zhao <xianwei.zhao@amlogic.com>

Keep the order of compatible property for amlogic sec power.

Fixes: 9428fff44f0c ("dt-bindings: power: add Amlogic S6 S7 S7D power domains")
Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
Keep alphabetical order.
---
 Documentation/devicetree/bindings/power/amlogic,meson-sec-pwrc.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/power/amlogic,meson-sec-pwrc.yaml b/Documentation/devicetree/bindings/power/amlogic,meson-sec-pwrc.yaml
index 12b71688dd34..7b843e9f51c7 100644
--- a/Documentation/devicetree/bindings/power/amlogic,meson-sec-pwrc.yaml
+++ b/Documentation/devicetree/bindings/power/amlogic,meson-sec-pwrc.yaml
@@ -23,10 +23,10 @@ properties:
       - amlogic,a4-pwrc
       - amlogic,a5-pwrc
       - amlogic,c3-pwrc
-      - amlogic,t7-pwrc
       - amlogic,s6-pwrc
       - amlogic,s7-pwrc
       - amlogic,s7d-pwrc
+      - amlogic,t7-pwrc
 
   "#power-domain-cells":
     const: 1

---
base-commit: b283b70967c0553b66e924f40e1c35b68fa8a1f7
change-id: 20250905-pm-fix-order-5a69bf461247

Best regards,
-- 
Xianwei Zhao <xianwei.zhao@amlogic.com>



