Return-Path: <linux-kernel+bounces-762756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0888FB20AA2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 15:47:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32E5018C06CC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 13:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D1AD1FECAD;
	Mon, 11 Aug 2025 13:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g1JT99KX"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDECA1BCA1C
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 13:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754920030; cv=none; b=V0ttxXvvi1h0/bSotlWOlaL2phTi2whYKblqpJak+1m28HmbpFdl3cr2MobA46eId9UTEb7IxEcIr1ewA0Tl0MR1SdcviwwBSOffm0YDQ6iaYvytBGYOhc0uFkL4HdaRx3IXddleIXYdu+DLDaXXjgDGpVSJ4fRZXwGSb0Tmh38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754920030; c=relaxed/simple;
	bh=qNq2IA4q9eVODe9Ak5qcJ7g5u90O2A2dHTjVJv6bwQc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dqQz5t+cNLYcEJj606NwrNmoPtpWv07j4IcW7bD/f6SOMoF9aer3kWRtncACpC82xY+ebkQvDhVjCoKoUQoMGEVz2XrDoPdpoG3DpwG6k5OK/mOv7Fy8y65s+uOuCZhG9NrhrJ0VO1dNIxgL8sVJmoLLc3OdQmb4WNIIwAkuQgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=g1JT99KX; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-af99942ba4cso56939066b.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 06:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754920027; x=1755524827; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OHmSb6G/GAZ/olIZ2TdPEzaA8vTp4NnJiB8D/HCSvxs=;
        b=g1JT99KXQdIkkosPwBtaRxPOk3ZuUJgm0kLj08pB+i3t+oc6vF5extqGpT78XxslP2
         5/AO/oMiqrSwO+ExBS1HtSaoJDPodIKHGgSRACBStJphc9qT+DIxB/eXtxz4J7s94F3N
         oc5Q4nY8UtNsOOPLmjtbEsSgtME6bxOmOIcuRFdc3V0fpyzpVfHWqMpNR9YZlsxLRIFa
         f2JtW0UwVOpQYRrzEf8rWnVy2s7JcJj/qQQKGzIhHBOz2vQMwl/STQpxWztiD9kdsNMM
         h62h7bo4QAVh66gAH5L6wz6FDIMARmQx30xVO2HPvPt3uCOUHWyvXQj/SGDEUy0eQSfY
         horw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754920027; x=1755524827;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OHmSb6G/GAZ/olIZ2TdPEzaA8vTp4NnJiB8D/HCSvxs=;
        b=YC4FBidBGG0hSjVqS7AuCoucIvnykMCLA/TE6BZFetg2jMY83K1Wtl/mVLf8Qpqgu1
         jZnPgtXiO3Q6p4gUtQjdXRUlOlpFYNZFHpynx3+1YmEoPFTQWJcb1apoHB9Ljy4aXTep
         bjhBMnR8B/g1AXz2DcvEsa3GB2uXcvoNZGbPQm0KLQI3Hxu5rXkv7L0BeM7DvP//pO7J
         AUJYbxCoL0eMcVZzkp4yOg0asuEwgsfCbvPoK8I1/fDp5i4eE06ZcGJARJm9J9lyQSeR
         f9YuLC9eML7SLoI16HYn2UrY0jMBYM8gyu7YMX02EcWJSgcjMNcD5X73xPVBMiIegCFk
         Etgg==
X-Forwarded-Encrypted: i=1; AJvYcCUjmJMlHiYU536rcyz+5qmSApjEs+9XLyZwX3/WcMBOW+JSqBBU+xJVxugUHyjFca/4uuqmW9woCUfPHa0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywq4lBW4orX9bAZM6MJsIVIGZLozlSpjtb62c9crisdix9lU6Oh
	cpkZ8Jx9X2rgS2kV7vhY3gdkZxrZL52RKuZ16o0GiyySIJxCt9OM/wqeh5Hkb11rpPE=
X-Gm-Gg: ASbGncvgerCmyN1Tb1zwtngt/487Doy4cEJzri006kTos5oNiZ+FUeOKhjDfJL+ZCGs
	DL11svSsSiOTCxbYUFoLo25Dx6LkYkaWxoTOVlnwezVEon/w5DWFiW5FIYX3Z7ppImmXZGGsae1
	3IW4jn6Egs5nVnpps6Rt6ADISIp3BQEWpaE+SOqish0lNtqfyMQ5edXCdA8hi2h7JkkJno41MLD
	Ab7sNOoLb9+Xjrp7LWV+Fv38/4DZOjTmQv+bG0HyO0fGE5+pyPzJIFrQy36eHmurthjd+fjyrfE
	4soJy8ttVGpVj7uiajho7w67089NZ6PQ8XQHyS0u2Jz+s3zDOh06YS6ZoW6r3n+kpN0BIbtnwm3
	VMKLWOSqyX58tAElAItFX2oF2BNiGsxNuTYSFI5LEhLdd
X-Google-Smtp-Source: AGHT+IEJUjFlaEGw+VKmxEaPlc20pzXwMVl23SfzDc4bl3GXEwr/gyjG1KZJDIYGj9ntjakD+YU4AQ==
X-Received: by 2002:a17:907:6ea6:b0:af9:3116:e10d with SMTP id a640c23a62f3a-af9e1d3d697mr348430966b.11.1754920027265;
        Mon, 11 Aug 2025 06:47:07 -0700 (PDT)
Received: from kuoka.. ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a078a11sm2067500566b.7.2025.08.11.06.47.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 06:47:06 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ninad Palsule <ninad@linux.ibm.com>,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Conor Dooley <conor.dooley@microchip.com>,
	Andrew Jeffery <andrew@codeconstruct.com.au>
Subject: [PATCH] regulator: dt-bindings: infineon,ir38060: Add maintainer from IBM
Date: Mon, 11 Aug 2025 15:47:04 +0200
Message-ID: <20250811134703.161941-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1622; i=krzysztof.kozlowski@linaro.org;
 h=from:subject; bh=qNq2IA4q9eVODe9Ak5qcJ7g5u90O2A2dHTjVJv6bwQc=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBomfRXHFk0PCv8z8o1gPR9QCVv3QzVxrbS8GBhN
 XjO5gynC9WJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaJn0VwAKCRDBN2bmhouD
 18cND/9Ry3EiTHFXI8RBs1gtx8r3b/kthrBNe9oLKdeBBvcAu4IyOSf08BoMgUDZin0mkuw/qT3
 yNhJ6gPVIvDcuu2rLCDG5jmpqqK8ZTWKd0RVPhN1tWbhEpHtWIA08ky/jz3ZMhUbQ3jp31Kqdr3
 m/HzUI2QifZDpZ31kNpfB1sJpZnUmd1bi1i+FD8EE2aMHQnQiszqRl0T7D4HAH+A3XQubfqgxrU
 AtDTU2ahEf8MjNY6ju7uyvCtBtqDQ9QZ00JcvGv+LZv45bAGMOKC9wPxGsCEfrfoHkVBGpfgO+v
 YRfnj1Ohe3Tjw20twk0/Hzdn9oqgllylFRWDjfIIspAEX8gmXzlNgP+QSly9vjLUajzypWZjV7n
 aV2uCpB8FnpaSHEPtdNKjIw4xiPR6DLtgWsVK3h3evHhTqJsBLZ9VMQPMz2AUCyFkEUfF24E+G/
 YaMNNnyzmQJynuROJKiPtcW8c45UM62PKzasydPdohEIK2xIr1PMBZe/zUPdsysqoL8xnzPW7v5
 yq44ZGhmeNCaAFOAQe4DpArbFbPMeYyzczslfNSQORahVoTks7d3pKCTO9kMIdXVfjN0m/XusB5
 Mc/8o7aoj5ldLd6JfbDIfQgvH+lhNa+52yRrg8Un5xnu/AdRgfVO72hrrbvNrXCNdheIGWvD5VQ Rqvc5a7x0dmX5DA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit

The infineon,ir38060 binding never got maintainer and fake "Not Me"
entry have been causing dt_binding_check warnings for 1.5 years now:

  regulator/infineon,ir38060.yaml: maintainers:0: 'Not Me.' does not match '@'

The devices are used on few Aspeed-based IBM BMCs, so maybe recent
contributor to these boards - Ninad Palsule - can help here in the
maintenance?

Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Conor Dooley <conor.dooley@microchip.com>
Cc: Andrew Jeffery <andrew@codeconstruct.com.au>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Ninad,
Can you confirm that you are ok with maintenance?

Alternatively, if there is still not dedicated maintainer for this
hardware, we should drop it along with the drvier. This will break
users' setups (e.g. IBM BMC boards), but maybe this will encourage them
to find someone to maintain this hardware?
---
 .../devicetree/bindings/regulator/infineon,ir38060.yaml         | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/regulator/infineon,ir38060.yaml b/Documentation/devicetree/bindings/regulator/infineon,ir38060.yaml
index e6ffbc2a2298..1267b68217bd 100644
--- a/Documentation/devicetree/bindings/regulator/infineon,ir38060.yaml
+++ b/Documentation/devicetree/bindings/regulator/infineon,ir38060.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Infineon Buck Regulators with PMBUS interfaces
 
 maintainers:
-  - Not Me.
+  - Ninad Palsule <ninad@linux.ibm.com>
 
 allOf:
   - $ref: regulator.yaml#
-- 
2.48.1


