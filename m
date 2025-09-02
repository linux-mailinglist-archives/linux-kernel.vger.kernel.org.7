Return-Path: <linux-kernel+bounces-796973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DCBA3B40A2D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 18:10:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CECD5630CC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 16:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E84C3376BA;
	Tue,  2 Sep 2025 16:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V2muBdCO"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E3132A81A
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 16:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756829410; cv=none; b=Krs9L4Sp3lcSSTNh2nF6mAL+KjBO5VawwEfkhfM5j1H+QhCieKdS/5CTtY+nSnyuLNaMBIhLBBabSiNOuo8x4aKth5upT36bJWsuzMa8qM+vQ/J844a2h8d1HV3YRZ1qpoUN6kLTvBOizAddRsqP1voSR6tMyaYPl92d5DGu4CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756829410; c=relaxed/simple;
	bh=f0aScQ/J03XLZhKUQrnrs4HuyH7xtridjeGuO9Do+Fk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=XKJQlHDHanvFsKQVBgGJIY7oKuXAcEJ9RojTTHjQJZkssI2aC4cHWiky+03XwMkNHiVdpohTjssxxnjsjTlXMxgcvRziy7LEvBYYe5nhUC8pwX9ImcBupjOTJGKBLRSJGgXAdPTye0RWxZZD1pyhd6ffCvA7r0RHn5Xps5cby48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=V2muBdCO; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-45b9c35bc0aso5099395e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 09:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756829407; x=1757434207; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bfhmZPSi1KHWXKJTbzEPGUiLR9+Cog8BCQqxFPGA9f8=;
        b=V2muBdCOeWAujbR42ukQCIn6rmANzQJ9wdC6yxAcpcIPKLtu95q1qB5jOTqiIahVah
         vqw76+G4rs3VSQWe76x0aoWB/ClsSff0L/tsn7KYuIEmppKLs/AgfUSJMoLFeTF4YV6M
         2uK0vvHXC4WqA0/rzJXtnpY94ZTBzwhDJGDd3Wew/bowg40+2ucjrrbyrCDKrZsLdMG6
         qqZa/NdAdDRVUc/vhyMURnTj9TIAm0W5I1HQy7AnlQNxGoVRmv0GbVAiVBjMW1QtCHVe
         s34dSKQvAjxem+5eWBnQ0eRqAaT6KDxmgkhD7ZLV+9EOhFjVczK5ofK+bSeBKZRfB4UD
         f/tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756829407; x=1757434207;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bfhmZPSi1KHWXKJTbzEPGUiLR9+Cog8BCQqxFPGA9f8=;
        b=hLJyFDeEK/vxN6jEZDpznV87QLWwDhRT0nEbfzGlzZv/GDtbAopwVk/AiETHMS52wc
         WI+L7sOWet5UUXZBPasFBX0O8ZKloqIolePAkB9NiTs68jnd5F9X9fHyfpky2/jdOFHX
         8QMXIxCU+masOXKcjoGURC2LqlNGcztiV/ptQxGsBmMRYV6SRQUCQ/JGElso+HPiWAip
         M419E4GCiMa5mOFEDeOrgPkogwq1bmI1CIruxioVN5ACapPj6RAEdr2K5OqOuyyQAyvo
         sJQXxDmTE3Xr/TQATQ33MU2zPldF6jQyDRyZVYUhTZO8DV4VE3YNnYYHpd+2Y5yhid0B
         aBjA==
X-Forwarded-Encrypted: i=1; AJvYcCWY0gG8auuCnVv0Y9diNyOBVPOpONz8FL7c19RBQJqrFZjo+EtsvmmMeJvl5vZ72aUi8QTBm1EGeLEi6jc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1qx9ji2jvecAYVzEAf9sSWBtBkYptVAmftaWP7utGlW8do2wb
	kFJTaMREVBsWaaSVXxZ34Bi4oPMkUkpWV6XObNNGLuVpwA4WzDwpCYck11iggt6bq9s=
X-Gm-Gg: ASbGncvM7EkVHzO9i4L+6bj69t3FqdsXkUg5UcuEISE9AP4oxAyhS9l/N4Pek+p9hAm
	U4WKRVRUE4ldF2ZCrDsrb1IkhYUkSh3ekDvqOUPY7LhZrMVnw0Ql7oVd7UwKENvJTXbrQDuNjV0
	WgZeo+drTOQ3krW5iOLAnGBB7eFmwPR2hFbIN/+sLGOguUrTk1GgrmQVia67mbCKsFMlyTlJmhT
	pJ1j45OwhV5MVRR5MNqluM6L+0YXdITgUZJspqwCEk9OM/jkrUkOFTaqmUPcix2nrQmEDurxlYi
	WvOO8uT0NZnQJtmf8BdjtQ3sxlrRo5A9ZOTxXvoOWaPOCEPfCasGeqIig0tIulfp6Vd/b3W8iHg
	tg09M42n+g18pH+7GY23KKs+J8muZqhHVAmDLuFAauoulj8uTmSlNaw==
X-Google-Smtp-Source: AGHT+IGyVF7oEpXMquEUvaM+UpeKMTllrx2t6qEOJfRIe99zcju47Lbg52A1eC99wf5MacESo4LYUg==
X-Received: by 2002:a05:600c:154a:b0:45b:8a20:5437 with SMTP id 5b1f17b1804b1-45b95fd646bmr34034435e9.31.1756829407005;
        Tue, 02 Sep 2025 09:10:07 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b9a6ecfafsm29858595e9.21.2025.09.02.09.10.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 09:10:06 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Tue, 02 Sep 2025 18:10:05 +0200
Subject: [PATCH] dt-bindings: phy: qcom,sc8280xp-qmp-usb43dp: do not
 reference whole usb-switch.yaml
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-topic-sm8x50-fix-qmp-usb43dp-usb-switch-v1-1-5b4a51c8c5a8@linaro.org>
X-B4-Tracking: v=1; b=H4sIANwWt2gC/x2NQQqDMBBFryKz7kCaJlJ7leJCk1FnoaYZrYLk7
 oasHg8e/18gFJkEPtUFkf4svC5Zno8K3NQtIyH77KCVtqpRGrc1sEOZ36dVOPCJvzngLr15+UK
 Ugzc3ofVD7U1j+s46yGshUq7L07dN6QY4qj7GeQAAAA==
X-Change-ID: 20250902-topic-sm8x50-fix-qmp-usb43dp-usb-switch-5df6d494ba5c
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, linux-arm-msm@vger.kernel.org, 
 linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1790;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=f0aScQ/J03XLZhKUQrnrs4HuyH7xtridjeGuO9Do+Fk=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBotxbdyYMqAfs8JqgNnyDZEviHhnQMD+Wp6Rh2YYKi
 Y7dimPqJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCaLcW3QAKCRB33NvayMhJ0R/nD/
 9V8ivt0sW9FlCcRXjqpYPaM5Gpt6cQXkgSVHSgAGLVjXCkyNCMac1qkhb0NbcxFopA4HLQFazMDNum
 OP+jYUdmi0xqgyCKVELcboDGB8QtPAXVpfzrBk6mAgmReJtIQwf7fAflwk9eLpKBz0fNKlv5HUnd4G
 CaxKP5T+cWFRGjaHVsJ3/00gWVaiPmeQFkCi2M5o1O+zZHBOHul+VELej+WZSFrm/NfAWcDnoUoFE/
 e3TYJY8ddMY6hJtpdCSdBxbVfFBWRwK8DDi89tQqAYJBX6WtKNsgJtwShnMgxxR1mv5QoLsZuBbRML
 eccsBbZEBQCd+Kxjj4mBQiE2skKcnotDtVSD3WbunVoV7hg9OjrGBfacsCRecbQDgoN4tOgerVkItw
 KMYPY8U3qaE00MXqO6/H8nXRDXdSyjCMapbpbfCS1rW78/jVqvbRNwoWQ+TK6amSqDMgUEP7o1NOMs
 w52lipoKuK+7NdhS3DuugIzhAHQVD09dAgUWJoW3VQ3ULxbV41eDGKEqFtFy4sh7fty5WSIxNiv9Vw
 ynGTZOQOcQmXHBNlArh9bkZHNz5c6AqzQcScJLjGOOMBwFe00TPz4kyZ6mNQV+QcZr0usUkBYge/C4
 DvQqapiH5EdUmhxb0TzOTEjZ5BSANqdwMVt6/vZddhDjom111mBiBDNzjlqA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Both bindings describe a different layout of the ports properties,
leading to errors when validating DT using this PHY bindings as
reported by Rob Herring.

Reported-by: Rob Herring <robh@kernel.org>
Closes: https://lore.kernel.org/all/175462129176.394940.16810637795278334342.robh@kernel.org/
Fixes: 3bad7fe22796 ("dt-bindings: phy: qcom,sc8280xp-qmp-usb43dp: Reference usb-switch.yaml to allow mode-switch")
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 .../devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml    | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml
index c8bc512df08b5694c8599f475de78679a4438449..5005514d7c3a1e4a8893883497fd204bc04e12be 100644
--- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml
@@ -73,8 +73,11 @@ properties:
     description:
       See include/dt-bindings/phy/phy-qcom-qmp.h
 
-  mode-switch: true
-  orientation-switch: true
+  mode-switch:
+    $ref: /schemas/usb/usb-switch.yaml#properties/mode-switch
+
+  orientation-switch:
+    $ref: /schemas/usb/usb-switch.yaml#properties/orientation-switch
 
   ports:
     $ref: /schemas/graph.yaml#/properties/ports
@@ -104,7 +107,6 @@ required:
   - "#phy-cells"
 
 allOf:
-  - $ref: /schemas/usb/usb-switch.yaml#
   - if:
       properties:
         compatible:

---
base-commit: 3db46a82d467bd23d9ebc473d872a865785299d8
change-id: 20250902-topic-sm8x50-fix-qmp-usb43dp-usb-switch-5df6d494ba5c

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>


