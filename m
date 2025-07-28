Return-Path: <linux-kernel+bounces-747327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 170C1B13296
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 02:03:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61ED53B6283
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 00:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B91EAA944;
	Mon, 28 Jul 2025 00:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tahomasoft.com header.i=@tahomasoft.com header.b="gGpvm/7L"
Received: from chumsalmon.baetis.net (chumsalmon.baetis.net [209.222.21.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACBBF2E36F1;
	Mon, 28 Jul 2025 00:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.222.21.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753661011; cv=none; b=c0eUkQBZgMtw37QhjrKBtkwG4c5Fo5vzniv0OqeDIKeV0vUXem9f10czExP66ANMFvizUljMqyJpJVwt8we9AQN/ngngWUddduSUxDjEcHM/uXzkQeF5MjEerboojQsiYCPjklok4HhIvATrGprMLEk6kiZAC9lQbxq+G1q0Dcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753661011; c=relaxed/simple;
	bh=oODfbwD2M9LRfRSx+G6gwNJz5Pq3D3zQJ6ch91Hwclo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Paw8t4k3F0MoOI5f8vary/2wyc2moJxfn5Wuw1BqB01Yu3Qj4QGdMEOzG6+T292WBVTnR4ssh2WR3EXamkx7FcS6zgNP60+gg1/u3uQ42HadREizsFxS/QhUGh+ZF7iYYqegVLly243lnyBsyO0VJQMMqNwsvs7J35PSArAb53g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tahomasoft.com; spf=pass smtp.mailfrom=tahomasoft.com; dkim=pass (2048-bit key) header.d=tahomasoft.com header.i=@tahomasoft.com header.b=gGpvm/7L; arc=none smtp.client-ip=209.222.21.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tahomasoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tahomasoft.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tahomasoft.com;
	s=default; t=1753661002;
	bh=oODfbwD2M9LRfRSx+G6gwNJz5Pq3D3zQJ6ch91Hwclo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=gGpvm/7LrQ8RaFTeyu9E95mixZcVTrVDUye1AvXNwWR3cJ/S/ezgI/Yri0OsJDbZf
	 gpvafuZKzfHNqq4q9pjSachzleCa6rygOr+k+fIXj/T7WNrM3veFKyw6S/zz6YVVqR
	 r/jvQWlv5aiu6l+JdSSG5/m57/MwOFeq2vJ246t0Mc5DoFLzldKKJKmarOUvowDkLc
	 GXrhfogXk8xb8jkSIPukK7pS53LNqqGVu2dIeTyhb545HRV4FwsUIOGfasLbwaqjNj
	 biJivnQAv3UuQfnS0tJvkLwQTICVrs/uI1g6eJ7zPZ5YV1NoyxCncPzUNwkqAo+EvP
	 nRfrCQLfWtQew==
Received: from localhost (unknown [IPv6:2600:4040:50b7:b604:6c1:3a28:af02:372c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by chumsalmon.baetis.net (Postfix) with ESMTPSA id B7CB627E83A;
	Mon, 28 Jul 2025 00:03:22 +0000 (UTC)
From: Erik Beck <xunil@tahomasoft.com>
Date: Sun, 27 Jul 2025 20:03:19 -0400
Subject: [PATCH v4 1/2] dt-bindings: arm: rockchip: add
 LinkStar-H68k-1432v1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250727-linkstarpatch_v4_6-16-rc1-v4-1-0dfa7aa06ec9@tahomasoft.com>
References: <20250727-linkstarpatch_v4_6-16-rc1-v4-0-0dfa7aa06ec9@tahomasoft.com>
In-Reply-To: <20250727-linkstarpatch_v4_6-16-rc1-v4-0-0dfa7aa06ec9@tahomasoft.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Erik Beck <xunil@tahomasoft.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753661001; l=1378;
 i=xunil@tahomasoft.com; s=20250724; h=from:subject:message-id;
 bh=oODfbwD2M9LRfRSx+G6gwNJz5Pq3D3zQJ6ch91Hwclo=;
 b=NYgTz1WgCDVt8YO6RJjV7v/Sk8tQAajRAXFx9G5Z4PduehuDyW+obAO12lzrsx9CKYEvTziqf
 mTXlKnwdQxfAGLEOOjqKsmx/m1wuPP7neewknIfeFdKIGL5g2GY7RCc
X-Developer-Key: i=xunil@tahomasoft.com; a=ed25519;
 pk=FTZVGUexvkWb4j8v0wbtm7CtJLijIAaa5x0XV72WWC0=

Add device tree bindings.

This device:
  - Has not been supported previously in the mainline Linux kernel;
  - Is a single board travel router made by Seeed, using an rk3568;
  - Has four ethernet ports;
  - Has four USB ports;
  - Has WiFi (MediaTek MT7921e);
  - Has a real-time clock (rk809)

Base commit:
  - commit 19272b37aa4f83ca52bdf9c16d5d81bdd1354494 ("tag: v6.16-rc1");

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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


