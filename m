Return-Path: <linux-kernel+bounces-886184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BCD28C34F15
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 10:49:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0F81A4F8B76
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 09:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86ABB30B515;
	Wed,  5 Nov 2025 09:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OxXl4s77"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4123009C3;
	Wed,  5 Nov 2025 09:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762336005; cv=none; b=Pq7HJKQlF2o8/TMi5Lf8NNrJmQI3x2/hemLMwiOR2ro1BjHQsGgn6dg2xqxef6kcKB9UkLoOXPIT5AfgZRZo5dlQbZzKJ1n75P9l4GmCiQUxcJYzG0irhPVxzBjsm+icN0S3adqxmwdV7gjSOSNh2ZaZsNDa83BSyWi7eBL+mAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762336005; c=relaxed/simple;
	bh=1PRYLpOD36+osgL6UNYLPpQ+cRE+N+trAv+XBTq1YhM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=of2pi7WjRdHGjCTAQ9kUhZEU+ZPgGwZBfzf4ncACtoqTt4Hp3f89xaheinvE9XDjPbLvQG7nRQUKKJ4H7FOoATe3kaOckmqzjThnHo0twQYrGXInKSQj6bIG3io2hv/AQ9cmDj2rqJ1c26txl0wA76Y16LrVbGacxN/UbhAbbYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OxXl4s77; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 73C67C4CEFB;
	Wed,  5 Nov 2025 09:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762336005;
	bh=1PRYLpOD36+osgL6UNYLPpQ+cRE+N+trAv+XBTq1YhM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=OxXl4s77+zDQisoebp8e1hNBq1I7htPStHvsBtuAxiJpwbv837n1OQgOEmlQIJT+/
	 VfhxA7SgJdCiO0ryFOnlMUis7PD4CQyalwn0QOiwRQxKR7V8sJetPjSKB/xrIDMIeN
	 uHTopbvBAIg2q8pdab/GCs9jlRvbXtOwC3/KdowakHcspAZ5MoD0hT/KinyqDs5P/D
	 8BPeUao1fPf5gcIEoDn7Iwr/R4ALJsXp+OaKNr7KUwNsCWrgmh0mBZL9el7OFRwKO1
	 Pc5FeI3nblEwQnM2iC8Kp0bXH+6dL3vadlLoC+1yXvNUJMXkwsYlHjhyGkGd4V6WnD
	 PXoup1kybFQhw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67673CCFA07;
	Wed,  5 Nov 2025 09:46:45 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Date: Wed, 05 Nov 2025 17:45:32 +0800
Subject: [PATCH 1/5] dt-bindings: interrupt-controller: Add support for
 Amlogic S6 S7 and S7D SoCs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251105-irqchip-gpio-s6-s7-s7d-v1-1-b4d1fe4781c1@amlogic.com>
References: <20251105-irqchip-gpio-s6-s7-s7d-v1-0-b4d1fe4781c1@amlogic.com>
In-Reply-To: <20251105-irqchip-gpio-s6-s7-s7d-v1-0-b4d1fe4781c1@amlogic.com>
To: Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Heiner Kallweit <hkallweit1@gmail.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
 Xianwei Zhao <xianwei.zhao@amlogic.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762336003; l=1048;
 i=xianwei.zhao@amlogic.com; s=20231208; h=from:subject:message-id;
 bh=P95W9L3DXzWgmu3DvSM7acqbbjZPHAZ7SEai9ZgGXgQ=;
 b=doXrU4qLxxUcLZ0b6f1xAhEm7WtM6bSso8PEa2qebHzTzMiW3Kg8zad34VDAJ8Dwf/WOBVLNL
 /JIc9w2Zx37Dryj3gC3Fn+cEr/2OybhlhCA12VvedXLC4n5i9UeThmB
X-Developer-Key: i=xianwei.zhao@amlogic.com; a=ed25519;
 pk=o4fDH8ZXL6xQg5h17eNzRljf6pwZHWWjqcOSsj3dW24=
X-Endpoint-Received: by B4 Relay for xianwei.zhao@amlogic.com/20231208 with
 auth_id=107
X-Original-From: Xianwei Zhao <xianwei.zhao@amlogic.com>
Reply-To: xianwei.zhao@amlogic.com

From: Xianwei Zhao <xianwei.zhao@amlogic.com>

Update dt-binding document for GPIO interrupt controller
of Amlogic S6 S7 and S7D SoCs.

Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
 .../bindings/interrupt-controller/amlogic,meson-gpio-intc.yaml         | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/amlogic,meson-gpio-intc.yaml b/Documentation/devicetree/bindings/interrupt-controller/amlogic,meson-gpio-intc.yaml
index 3d60d9e9e208..d0fad930de9d 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/amlogic,meson-gpio-intc.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/amlogic,meson-gpio-intc.yaml
@@ -39,6 +39,9 @@ properties:
               - amlogic,a4-gpio-ao-intc
               - amlogic,a5-gpio-intc
               - amlogic,c3-gpio-intc
+              - amlogic,s6-gpio-intc
+              - amlogic,s7-gpio-intc
+              - amlogic,s7d-gpio-intc
               - amlogic,t7-gpio-intc
           - const: amlogic,meson-gpio-intc
 

-- 
2.37.1



