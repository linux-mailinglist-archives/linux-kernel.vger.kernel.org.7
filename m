Return-Path: <linux-kernel+bounces-834988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47737BA5F9C
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 15:22:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 616D5189C2D9
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 13:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6F9B2E0B68;
	Sat, 27 Sep 2025 13:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vinarskis.com header.i=@vinarskis.com header.b="XOQQpray"
Received: from mail-106111.protonmail.ch (mail-106111.protonmail.ch [79.135.106.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783902DAFA1
	for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 13:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758979351; cv=none; b=K0jVzXqMro5c8GgmfuNIFevPnTUPhd2goobZVUYLLJT89nlXrn4lV+rl62ZiFFbm/pknrjy5mELVYtkkfBL5S9fbwM+5K3wZx/klwZAfKT7zoZ3vNA6xnoATkquL38vHV+MQkcEeurjNz9tO1L6bZop+DdDdu71gn3oJFhFevjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758979351; c=relaxed/simple;
	bh=GKjlsxqTbxpyt3VuCV/objdV70KuxpUpntpWDXhpIhg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V4g2OYm0oLgxJH/8vJ/5OqtvDtGhBW0u0/9Gd/zEQBhLNEYcZzOxCPqSVz3zZT4hypcK6tcvLBxCv3xcJ2ssS6SeGfXbJxMXfDjlMeOsyiMpPhCQKIgjDN0R7H7sCz+QqbYyi6HOGxV6taYohlMpUDhaNzPQo6TvX4m/mE3aeOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vinarskis.com; spf=pass smtp.mailfrom=vinarskis.com; dkim=pass (2048-bit key) header.d=vinarskis.com header.i=@vinarskis.com header.b=XOQQpray; arc=none smtp.client-ip=79.135.106.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vinarskis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vinarskis.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vinarskis.com;
	s=protonmail; t=1758979341; x=1759238541;
	bh=b+4eBFLXfgLqWLJemhO/UCi3kOey2BMAl5UTN1g2g4w=;
	h=From:Date:Subject:Message-Id:References:In-Reply-To:To:Cc:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=XOQQprayUke9Y/LkWcgvIskMAPuiSlAsFAOtfZXJM2YEvkc+oi9iWxbIPNbG3n4Me
	 692LHrtYDn/8U9OwL8NNH9lLNrmIGyrxupdQX3begXyJ65Vu9uOqbvuf/tunZhRz7Y
	 g/BbSQnJjLuGy1Vvl7OX+bci72chUl5u4bIcz31tfbIbp07/NgeB6s2aew5EGqXkio
	 44yQgpHuFOORD6SOujKZ73LsrbQeiki+xTLnFr07fnu8HUXjeXOIsBODcIYdyivjkE
	 FjKi2VvRK3rtRmm8P/jDDi8JvyLBQYMJumBwh0Td3pW0DQe2wLbBSbwP8JYvYlDRqI
	 Psulqj0LwwsOw==
X-Pm-Submission-Id: 4cYp5k4gspz1DF4L
From: Aleksandrs Vinarskis <alex@vinarskis.com>
Date: Sat, 27 Sep 2025 15:21:35 +0200
Subject: [PATCH v3 1/3] dt-bindings: arm: qcom: Add Asus Zenbook A14
 UX3407QA LCD/OLED variants
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250927-zenbook-improvements-v3-1-d46c7368dc70@vinarskis.com>
References: <20250927-zenbook-improvements-v3-0-d46c7368dc70@vinarskis.com>
In-Reply-To: <20250927-zenbook-improvements-v3-0-d46c7368dc70@vinarskis.com>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Jens Glathe <jens.glathe@oldschoolsolutions.biz>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1385; i=alex@vinarskis.com;
 h=from:subject:message-id; bh=GKjlsxqTbxpyt3VuCV/objdV70KuxpUpntpWDXhpIhg=;
 b=owGbwMvMwCX2dl3hIv4AZgHG02pJDBnXn7K15Qmwsf5Ta2p3vOq/RXP+XWFfk0V/drwp3X2+W
 eu4qFFnRykLgxgXg6yYIkv3n69pXYvmrmW4rvENZg4rE8gQBi5OAZjIYwmG3yxnLS/dWLZrjl7m
 42Unf0funfrIsqjLwZrZT55l8kShqJeMDCffLLXkW/tCceHGtIez57ltfcRdnX1+jVAEIyM/L+e
 3v0wA
X-Developer-Key: i=alex@vinarskis.com; a=openpgp;
 fpr=8E21FAE2D2967BB123303E8C684FD4BA28133815

X1/X1 Plus variant of the said device comes in either FHD+ OLED or FHD+
LCD panel, and shares the same model number UX3407QA. It appears LCD
panel's brightness adjustment is PWM backlight controlled, so a
dedicated device-tree is required. Introduce dedicated compatibles with
fallback to 'asus,zenbook-a14-ux3407qa' as they are otherwise the same.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Aleksandrs Vinarskis <alex@vinarskis.com>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 18b5ed044f9fcc4d12f4e3baa001099b6e154af7..abdc39c025aae0ca5cdf77c58ab0e3cbe47c5108 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -1083,7 +1083,13 @@ properties:
 
       - items:
           - enum:
-              - asus,zenbook-a14-ux3407qa
+              - asus,zenbook-a14-ux3407qa-lcd
+              - asus,zenbook-a14-ux3407qa-oled
+          - const: asus,zenbook-a14-ux3407qa
+          - const: qcom,x1p42100
+
+      - items:
+          - enum:
               - hp,omnibook-x14-fe1
               - lenovo,thinkbook-16
               - qcom,x1p42100-crd

-- 
2.51.0


