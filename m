Return-Path: <linux-kernel+bounces-749517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 588ACB14F65
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 16:40:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89788178DDE
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 14:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AF1C1E5734;
	Tue, 29 Jul 2025 14:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tahomasoft.com header.i=@tahomasoft.com header.b="e7f+1gF0"
Received: from chumsalmon.baetis.net (chumsalmon.baetis.net [209.222.21.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433BD1C3BFC;
	Tue, 29 Jul 2025 14:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.222.21.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753800009; cv=none; b=jZHMbbXPsNLrvH7l8zDogq/14GcOhu2A6DC2dxYCvsNCnS11ej2K9V6UXXJvpnmVu0khBI/aNh+6ETSvMXh4CCuEo00C0+HQyJ6LVXB4NMXOisNIYUnEMhG9hQocP0o8X/bAzzH1+viY2Kf871JMZ87+F0s0ItQ/noa2LMUaj4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753800009; c=relaxed/simple;
	bh=uvTHoWDfs2EDKcTU/ctS/fdFesLbnoOsjLa1+Mgz95M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N3ZKY5vfitjapdp8sZ97ALdV+NtAAW4ANlyG34asii6Om5nVqE2BhqdRiVqolMfsQyoWINHrS7X3sdqeopKivpv0jYNI0AmUInzY1nTeVLMXbIlnSwqD/KYfncpt0AKXpklyqqW+PpXpcVx7HGW2+A8CHTyQv7A6gUcc41+1v+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tahomasoft.com; spf=pass smtp.mailfrom=tahomasoft.com; dkim=pass (2048-bit key) header.d=tahomasoft.com header.i=@tahomasoft.com header.b=e7f+1gF0; arc=none smtp.client-ip=209.222.21.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tahomasoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tahomasoft.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tahomasoft.com;
	s=default; t=1753800007;
	bh=uvTHoWDfs2EDKcTU/ctS/fdFesLbnoOsjLa1+Mgz95M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=e7f+1gF04EPCJtMjvzWXTovDsLqaG/DQcATOpq/FxVfZdzpC4TPRztqcuxnF6B+5V
	 V/vQRlY2FySRnjldujy/hfBKpFMERlRxDz+HERA3hnyZoaPFMIPd1ae8GDvIZ79uCF
	 4uKheQUkp4/LE5Zj70QHptIjzlzaPYTky70IrGnZ9FZGXkXmEexnpyr1d/4K3NmH42
	 FoJGNgoGCgnG2OkErsYoKVk1RJKFVspnma4bog3+HIDPu4hbYRzkjYpYc4Zum0HWce
	 Ljh+eI9rXA9TSoT+868HlPxJTtDuK8MOX2x0OgIPGOnmlbxXIfcEMiYgqyIWi3qxWP
	 Hs92GuGq2CgXw==
Received: from localhost (unknown [IPv6:2600:4040:50b7:b604:f717:c76f:99e7:4a24])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by chumsalmon.baetis.net (Postfix) with ESMTPSA id 4F31527E5BC;
	Tue, 29 Jul 2025 14:40:07 +0000 (UTC)
From: Erik Beck <xunil@tahomasoft.com>
Date: Tue, 29 Jul 2025 10:39:51 -0400
Subject: [PATCH v6 1/2] dt-bindings: arm: rockchip: add
 LinkStar-H68k-1432v1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250729-linkstar-6-16-rc1-v6-v6-1-92307f465835@tahomasoft.com>
References: <20250729-linkstar-6-16-rc1-v6-v6-0-92307f465835@tahomasoft.com>
In-Reply-To: <20250729-linkstar-6-16-rc1-v6-v6-0-92307f465835@tahomasoft.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Erik Beck <xunil@tahomasoft.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753800001; l=1156;
 i=xunil@tahomasoft.com; s=20250724; h=from:subject:message-id;
 bh=uvTHoWDfs2EDKcTU/ctS/fdFesLbnoOsjLa1+Mgz95M=;
 b=V6/m2tlOfsIWk2cC8KTlKZI6zh95Fkkghwoqhv0WwiCwkWxYvYNiFntnkOW9Oi4b3MdqJaiF0
 olwkg0MatQDA/0FPJIfXoHRYl+G0XsL6DvUB025YzEgXGDGobevhjqL
X-Developer-Key: i=xunil@tahomasoft.com; a=ed25519;
 pk=FTZVGUexvkWb4j8v0wbtm7CtJLijIAaa5x0XV72WWC0=

Add device tree bindings.

This device:
  - Is a single board travel router made by Seeed, using an rk3568;
  - Has four ethernet ports;
  - Has four USB ports;
  - Has WiFi (MediaTek MT7921e);
  - Has a real-time clock (rk809)

Signed-off-by: Erik Beck <xunil@tahomasoft.com>
---
 Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index 5772d905f390e53b44f9093d32b869a7e0655db6..7f3904b69293f31fdd4f6080fab5ce054c1abee2 100644
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


