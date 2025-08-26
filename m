Return-Path: <linux-kernel+bounces-786594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 83A16B35ED4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 14:10:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B09B11B276DB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 12:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECFA5307AE8;
	Tue, 26 Aug 2025 12:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jVaePLG3"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF0D322530;
	Tue, 26 Aug 2025 12:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756210192; cv=none; b=emW7ZhQ9/8jKfSUa1nSFiaeaFuPM9loc9XqTtqOFVbxs4L4qsv3pAQjeY0LU83rmFsKRRonuqrWpEMlcAHUyCrhPplfiA8feYO6RGMD+Att3NfH6CVdsGE7JS8HwmIYo1X5vaEDMVsJ2yNFAf+X/iitaPY1tvvDKjx4ir2NMwx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756210192; c=relaxed/simple;
	bh=QAiPwZypg/VMlrPIBhr0fWYCSyBf5BBQP9eNNCiNfG4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=spEwor6xBwftbB1+/aAO3IK49RQFkRcNBj6PhQN47XWjITTGd8evfGRFbMgpXR9+YV/WkMuMBmvIBQV/6KuSHvn5gyDfMvBkdr9AbsHpd19+3uUpaNdGB3cmI55czwl49+5gV+aGTg+WIHQKNSapuIKqFzzOFn9oEUWERmynlCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jVaePLG3; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2445806df50so41905635ad.1;
        Tue, 26 Aug 2025 05:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756210190; x=1756814990; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=myWZ5KKugg0r3Iz22gx0u77eYst6AR+R8GzbR5T+YNo=;
        b=jVaePLG3TYtTvx4aNW+V4Py71VlB7ofgSvYkfVSeqgxl2qWGOpE3VYKNwxGBAgT8GE
         b2TTM9Sc0jnmbbP4/Mjoaxo7MVAvSoizO/xgD+L8F74Yu2xzyssZ0iZP7rRKvLKFHJ5E
         NRgJnTgRwCzVhTLIvhnGRXHsp/lQM4sFMbbimKXQ5F4+D8nr/xjGpRsP9AqM++xU2UWF
         xFwJZu+jem2sL4WiFIZ8Bq1OiSvByCMpmG9O+MFcM5Kpuve8XpLI6ftqi6f05eb2qsOf
         RruF6MxrgcLb38cu9Wby8UzK7qQsMR2NKZ8WIJhhSRvUxnWVnqoGL3NC6W3qIsItAZa4
         z1og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756210190; x=1756814990;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=myWZ5KKugg0r3Iz22gx0u77eYst6AR+R8GzbR5T+YNo=;
        b=ltUtm4n4mJxqT7GIzkKGPwNrSWO+Kx0e9u3v23Ty2CrZi0kuWtOXJ9pHADH4m7RnwU
         g6TrkcuscKvwFoKHGlqz48GZ0TDd/rrQIzX9LCMLlN4hW+RU7/AxmK1qkgiJ1Lwed140
         k8pTz1z3lHBXscGSmgc4Bb3tPzrHkrvbL81x5L3YrBDARy5Jfqm9bHUQsu5WF0nQywiT
         4jAueCBZO4A4T2vW4fMjy7g/1Ug93ajs2v3IGFnX0lTrNbT/pWUfCoirhmtofvhm2/wX
         EBLdoAHfv2woKifMpO280QaSMlOHDOSMybRgVuMgQi4R4sp8z0WH34LCPZ3FNKLm1GyL
         VDRQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYSKHUR8s9JvW+Es7gJRMI1mtRqcXVdq7r94piSX+aeopJgGMNH2keL1MXyJU+L9Gul6vsiyynJe5R@vger.kernel.org, AJvYcCVuUNjDzCqPQhOMz+PquPSHigHBLe44c6H0MglvETATIsEskntR+Gqudjq1352r78Qx3UjyCCEtBePXze8C@vger.kernel.org
X-Gm-Message-State: AOJu0YwgSqWdQa1W1dxjyyOhESMtA22vXMVDPFhGSvg6BygbhkwFRoHE
	j81+LQ06ncFfhpJlwCkDdDa7qB78h2+ELc/Iq3pYiCJd1VX3GcsOVLlRdPc82J0j
X-Gm-Gg: ASbGncvw1DNmZ/A/LaahdtbVgxYOltRokADNylz/meTe/GqqZkmyWmAYanG78qK6Z4O
	C4D8wAEt2WH6pnAFL4D/HnMyTMalLEKBDbq33fwG28wYNfPQ3Twefv3ikaCctmzR2KovlXujlUl
	vS15QhUUzkdq0jEApMXwN7R7qqlM4xVaOh9nBTRu2ComUCbbAtRNwY4Nx2z08FCnS4v6EiCuNY+
	o87Weftq+zQDTm7xZ516VJ7bv5eiT+SuZ/KTF9BJ3VZP64CV5sOiIc7tjCu0YJXt1Lz0/zCh8JJ
	hhJ1oE8Qv4XHQ5Xo2UEKYnt6Gbxj+b9+w3tIyr9uW3JsUsgeOyMt5+pcRtgC2NgbZHvENKUOku7
	22JocB/mHeZ8lAXY30HeiOJ115Vc=
X-Google-Smtp-Source: AGHT+IFCs+0+QPpGE5rod3ewcQ6LEfg1s385+SmIISqW/6UyVrO7Bz46rSAw1PuBDWqjvwCmypo/2A==
X-Received: by 2002:a17:902:d4c6:b0:246:eaec:2994 with SMTP id d9443c01a7336-246eaec2c7bmr90916255ad.49.1756210189659;
        Tue, 26 Aug 2025 05:09:49 -0700 (PDT)
Received: from [127.0.1.1] ([59.188.211.98])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-327565d3924sm619966a91.13.2025.08.26.05.09.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 05:09:49 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Tue, 26 Aug 2025 20:09:12 +0800
Subject: [PATCH v5 1/4] dt-bindings: nvme: apple,nvme-ans: Add Apple A11
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250826-t8015-nvme-v5-1-caee6ab00144@gmail.com>
References: <20250826-t8015-nvme-v5-0-caee6ab00144@gmail.com>
In-Reply-To: <20250826-t8015-nvme-v5-0-caee6ab00144@gmail.com>
To: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Neal Gompa <neal@gompa.dev>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Keith Busch <kbusch@kernel.org>, 
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-nvme@lists.infradead.org, Nick Chan <towinchenmi@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1377; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=QAiPwZypg/VMlrPIBhr0fWYCSyBf5BBQP9eNNCiNfG4=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBoraQDfcGlhRdbNX8kCRUtLsCfOQJIqHlyC4YjU
 BwPiF6XsVuJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaK2kAwAKCRABygi3psUI
 JGGFD/94mzTsBZpIQi24EhnHzwccGc0LDw8hGHIljz4WJYYwVsLfVquxUWdYAB08y6fm2eTVo0T
 MNh3t5Gt4Lh3wL2DcI3SFCG/3IVipT+XGVbX/r0RpHiDos8ZCg0QVtF1/on4amZn3T7qwmGqdSF
 +ySBYE7E4a0CpSNlC6GGgPOfGwrMeUVshCdM2liaghAVcPF69QMylAeYPUIc2eDlBbRZT0l/A5J
 vERkbULAJPwxT3bW0dV3fnqj0X00lXQdSiL7sxiZwb01qxR1zX+XGjyGfP2nm31y7vJNTt3Pb1g
 yyZVEoS2SE9lU44S1PBS1NZyMbrWu8KHWJ3NtkDJve5EQBcqJe4kJCvqWEuBZudmGTaPnbYx+bv
 se1nOzWouaav74L8nOGYFxS+CPCAxCzaZ1BcUYEdZ9DQ3EAMXaC61OOkWbPZQ+ZPFZydGk1kQ/o
 VOBAQTqno65pINclM5H73eZNQIy3rWDQF476WxLpc6hGY5fY2s5OYcFgBw9lFfXUzHYB5WeoXct
 h9Tv0rP6qPkmlAqsa7tDZGnLAilKIN5d9kHLtdB04LSzG0vSTzfFnzTdsLrIaQ39oKlEV7YkQRP
 vGpOy8z2Jdc97Qrtgt3Ue+iVUHC83WYvyGsh/r1HGcMkOBqEBADXHbNEPJvu1Aa3YSRgvJaqy+E
 OLsg8E+SBMa0Ktw==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Add ANS2 NVMe bindings for Apple A11 SoC.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 .../devicetree/bindings/nvme/apple,nvme-ans.yaml          | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/nvme/apple,nvme-ans.yaml b/Documentation/devicetree/bindings/nvme/apple,nvme-ans.yaml
index fc6555724e1858e8a16f6750302ff0ad9c4e5b88..4127d7b0a0f066fd0e144b32d1b676e3406b9d5a 100644
--- a/Documentation/devicetree/bindings/nvme/apple,nvme-ans.yaml
+++ b/Documentation/devicetree/bindings/nvme/apple,nvme-ans.yaml
@@ -11,12 +11,14 @@ maintainers:
 
 properties:
   compatible:
-    items:
-      - enum:
-          - apple,t8103-nvme-ans2
-          - apple,t8112-nvme-ans2
-          - apple,t6000-nvme-ans2
-      - const: apple,nvme-ans2
+    oneOf:
+      - const: apple,t8015-nvme-ans2
+      - items:
+          - enum:
+              - apple,t8103-nvme-ans2
+              - apple,t8112-nvme-ans2
+              - apple,t6000-nvme-ans2
+          - const: apple,nvme-ans2
 
   reg:
     items:
@@ -67,6 +69,7 @@ if:
     compatible:
       contains:
         enum:
+          - apple,t8015-nvme-ans2
           - apple,t8103-nvme-ans2
           - apple,t8112-nvme-ans2
 then:

-- 
2.51.0


