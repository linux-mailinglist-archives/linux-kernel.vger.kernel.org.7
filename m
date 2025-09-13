Return-Path: <linux-kernel+bounces-815325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20D46B562B8
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 21:20:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 080B63A16D6
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 19:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B99042494F8;
	Sat, 13 Sep 2025 19:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L5Z2E37w"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0711E23D7E7;
	Sat, 13 Sep 2025 19:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757791192; cv=none; b=qqdmWUXoohetHFQvfgsKg+9IRq9AJ/EtRrrsiYB5HcOq2/mN4No348lIqbGBXdafdbI48NgOtLLelCIvvMAsE2UWjhLZBJhksNDEc+yy6yiGx4X0292cq8cLRHHgO1CmmKSer61QQCu+AiE+g9TF7J3WMkMWr+adr6+L0uehI5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757791192; c=relaxed/simple;
	bh=GqkoZ7KBwzs7dRpuLzIvS/Z61jcctzBt4EJ6Zi6zhmc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J4G2kmv6SUdLTXme4bB4WsBzMwE0lE9HMO/cXT3BaqC37BJljauxJMDj8PdBjr8ZgRzMJSnr/NvsjrrULSsqZPXP9eD7dM9+WzkqaNWXnABwta7LnWT04EqYt8MvcpShAWIX7zCqwIfjx5NKR5XYiPDBXqLUbjw9HcnB///rzI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L5Z2E37w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A0F5DC4CEFF;
	Sat, 13 Sep 2025 19:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757791191;
	bh=GqkoZ7KBwzs7dRpuLzIvS/Z61jcctzBt4EJ6Zi6zhmc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=L5Z2E37woXfN3bjSp3w0H6wMYr6Opo7pCqy70FBz6TrYIXVfXSNZwrTo4faP8Boli
	 QV1YyF4LY4RMfbGZGsADpP808f+8BZ8cvUJCXadgNjSqQghaeFe++SbzGscfYRaE4c
	 EXplkfcvDTfXP7pO4XRSb6n3CCXUNeoEUrQr6YY88Ln3P+gRTN7CHIJzghrk4e1cpm
	 dMLFaSJzVZihCAOFsMYakAYa9FRVvGPBEM+sQOzRPKRhoAtNRpiRXb9wXsSO1vnbbb
	 dp1Nqji5g/+/hCORgtfQGe8M3N3aceaGBbT7avppvHHgGgGRQVolNMVnGSn1X6clMa
	 WqhZl5rInaLMw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99699CAC594;
	Sat, 13 Sep 2025 19:19:51 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Sat, 13 Sep 2025 21:19:49 +0200
Subject: [PATCH v6 3/3] dt-bindings: display: panel: Add Novatek NT35596S
 panel bindings
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250913-nt35596s-v6-3-b5deb05e04af@ixit.cz>
References: <20250913-nt35596s-v6-0-b5deb05e04af@ixit.cz>
In-Reply-To: <20250913-nt35596s-v6-0-b5deb05e04af@ixit.cz>
To: Sumit Semwal <sumit.semwal@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jessica.zhang@oss.qualcomm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Molly Sophia <mollysophia379@gmail.com>, 
 Arnaud Ferraris <arnaud.ferraris@collabora.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1713; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=lFoP3Jmjexe60vWrVFSdH2SLqrIeKo/VFBht7BKKVLc=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBoxcPWenKVF1BK8oEurKoF2JGZ9fs17xjEBq+ad
 nLmW22lVKGJAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCaMXD1gAKCRBgAj/E00kg
 ckPSD/0apPokMVlQ7NkcKcqNNKRt7eEHs4tDWTXJIK7FXwLs0StRKtIg70lfdXdy3JCMhEOogEM
 OMZXA3Cyts0ez2Jg392TkgFk6P7Xaux4ia8v/1LzS/ckjqNRgQtbdHiAlXkCtcm0PnO+mTlUBUX
 PQPuJx8kSnYnKv4TDWRKKj1KpV2ACOPAYaaaY9wC60D6EgIrq6Qt/97jZPNRptlZpjNLmGD8B0f
 hn+U1OAGucge0s1O/z/xMyFpEwL8P5T26vfykwxuzmaaGw3qFNELC+WPmiH80ZljZtzHTy3UGi+
 4sWruE8Y5JO2xrLCzSKffjyJ1ciBageAJudf8bC6MUsTkojpnnY0hhKuNAynL6Z0LltT7iZe/S4
 u63Uwb4yeiVMIsb1ireT1O7a8PxFzgYcPIJcSYhwMnMZA/abeIE5PU7gzBrvg0eoYdbN37fs8We
 lZSBaQ+sLKgO+VQfW4kB2Df3E2AFWC+oU5SweY3XDkpY9s95i7u4Drs0YTVLQDG4qCcegLj/e7b
 wAk3pvbSFdulrYISf1p84hyXwbHT+rcQwpUgqZ3Dltmrvb8sfrMx4lmrjm8Y0kGw/kOJwMQN/tY
 pAck29CBBWV4/MygzCDUUXUET2qFzxBIs9iJy9MwFFBecpVDS5UK0190SMaLOmqDS4jtZlgLpWx
 uiJR9/I7KgdKqFg==
X-Developer-Key: i=david@ixit.cz; a=openpgp;
 fpr=D77A09CFEEDC2BBD53A7047460023FC4D3492072
X-Endpoint-Received: by B4 Relay for david@ixit.cz/default with auth_id=355
X-Original-From: David Heidelberg <david@ixit.cz>
Reply-To: david@ixit.cz

From: Molly Sophia <mollysophia379@gmail.com>

Add documentation for "novatek,nt35596s" panel.

Signed-off-by: Molly Sophia <mollysophia379@gmail.com>
Signed-off-by: Arnaud Ferraris <arnaud.ferraris@collabora.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/display/panel/novatek,nt36672a.yaml    | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/panel/novatek,nt36672a.yaml b/Documentation/devicetree/bindings/display/panel/novatek,nt36672a.yaml
index 800a2f0a4dad98954ef60c3bb04d8eb2243cae7a..d7036ab46382f7b6200cc263ba7e93856386919f 100644
--- a/Documentation/devicetree/bindings/display/panel/novatek,nt36672a.yaml
+++ b/Documentation/devicetree/bindings/display/panel/novatek,nt36672a.yaml
@@ -20,14 +20,21 @@ allOf:
 
 properties:
   compatible:
-    items:
-      - enum:
-          - tianma,fhd-video
-      - const: novatek,nt36672a
+    oneOf:
+      - items:
+          - enum:
+              - jdi,fhd-nt35596s
+          - const: novatek,nt35596s
+
+      - items:
+          - enum:
+              - tianma,fhd-video
+          - const: novatek,nt36672a
+
     description: This indicates the panel manufacturer of the panel that is
-      in turn using the NT36672A panel driver. This compatible string
-      determines how the NT36672A panel driver is configured for the indicated
-      panel. The novatek,nt36672a compatible shall always be provided as a fallback.
+      in turn using the NT36672A or the NT35596S panel driver. This compatible
+      string determines how the panel driver is configured for the indicated
+      panel.
 
   reg:
     maxItems: 1

-- 
2.51.0



