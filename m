Return-Path: <linux-kernel+bounces-877827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6993FC1F298
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 09:59:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03AC119C79DF
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 08:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AFCD3446CC;
	Thu, 30 Oct 2025 08:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ugu+Torb"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57AE033F392
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 08:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761814279; cv=none; b=Iac7OUJFCWmxxe84mF67GqCRABKuSVTvPMm9oDL+dgu/lpn0bYg2PW568zatKHuijp/vucM6/ME6jiDr3jfeo6bC5yd9o4JDMCGhor0OZFvDS67uD1Ld2gjbetb31aXX0k/LqRS8r0aeCvmdmBLRnF7HMfcx+9NEBS2tTqPAU+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761814279; c=relaxed/simple;
	bh=1ZQHY6JpkRKcQKK9PJI2DS8+9+Ft5mGT/4HkAsIsEZM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gFV8io5CmopJ6ifsD+8SyGnoFGVH12gWJKbcYNjhyfhaGHG9oXvw+gHyYx7kqyxT0wsAOYrGaR8OPSJOLGzEeyzujiARV6PHWIl06NSk9kOMFvAQ0G6odC1dOLRE5dkv6YDmgS3TUePIlN4OOnReIHWz7KkhEd9QhakfpRijCXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ugu+Torb; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b6dc4bba386so14038066b.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 01:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761814275; x=1762419075; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UvmpSsd6jI6Q+bHe8qcAmRmuD83LAnf77r0YzUltAZc=;
        b=ugu+TorbS56RxB3B0ENr8Yi50yXFiOYbfNF4/k4qVdIXf/TZNxXu6mLSCyqUo1TL5/
         YpPDktSoMgvE68pFuYt3ObzRnaIbjMhFSsRbzHiBnHz5q3QYudtnPdvGLU7zMoZgp4wR
         HqzQNaGOvam6i08lIidqZnwr8cuyYMJeptrVMyeI7sC7vHQBw8Cdjp0vBaBwroIaPTt+
         KMbUHH+NHjrMj6qVYIubqmaVe9SJUxGlo5ZhU4DLb1umCpxyitcTMDg73vSA21ByFpkc
         ZHhdqSzd0TQmllT63ocAOL3LN8+ee9JDCfRLUoQpZw8SLDwwPaszD3lXynwNJuitw41I
         83/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761814275; x=1762419075;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UvmpSsd6jI6Q+bHe8qcAmRmuD83LAnf77r0YzUltAZc=;
        b=LRVUjS8Fe3fkMYy34ILkVFTJMT1x7m7QVW/6A8LW7twrF4mpqqj7dtbQ1LDOmgcqPj
         83a4RLkL690AdTyvzsdPoLI3rJ+OP7fR6RRGY2mADBBqDrbyg/FQoW/G6YsU4sw4EL2M
         R7bHOJKcoZuMmJIcJqufegsECt3as42i32Vt8gKWXSr8+iceQVAQcVrxwvagTj5J8ns2
         21k75pRHVKGjrxfbMGKmQu1uUoD8UzNkiiF/ezgbVarymY40KhPrJZ+Wh5UM/Aqchg0L
         f/9MmxuMmhtpKnucILlO6sybdrnp390a//CBDEmrX5aQvRuZFYm3dC0YmpL3/6u35Eh9
         Jv8w==
X-Forwarded-Encrypted: i=1; AJvYcCXHHsE5V/8okpTTcP6gUw1oXTKfeSX96EVGUnffDaTD645eUsmL6rwah8yA71byFV/+jzMv9sFq5gl7254=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKXAm4HmmbHPq9O+tSN3CQ2CrnpJa/9ELbYobnOxN75kDa70HQ
	xy3f6RHohtaeeifQ2AiD07Ocp6wo4nZzlA3FWxYH3Rgg+UvqO78BY+2xno6qUP6WxTM=
X-Gm-Gg: ASbGncu1x14+jx6xbumwrs3UQlpJIRSujcjgkK61SYAITYWrOorI5mMZ3Z8nk1szib5
	UW2NzQ8IdVnpdheM19lLEWQQ4ygV6K5SdTlndTaCT4m89LVmdqloqR8Vc5+vVVIsHeXwBaBOowR
	HFW7qnFuoPXtTiG3N69z0LyoV7NqkiSNkP6wcNRYRtf8znqnEJ4Oc8c3FRpcK1+f7F5m4hH6KOb
	usNEz2iYXDNH5M4p03FVSTn53RgbA007j5od8ZqRNdi/DFJFDm8W5VGosDMRlQyoes6BtBcZWGZ
	xjbkdNL1I7FZnYgVZDji/Xkl9c2J1gVmD+YjtYIczJETBKTw//EGa0u0un5Sc7fzFA2eKj4ZB2t
	N5IZ6d65cGjDJfKaxdwE4u+s4C/SvckherMj9bh23IBjA9mJDltkH2YqYuLMHlWSqci/0urmyyE
	J4FfOthvjChrGORiwN
X-Google-Smtp-Source: AGHT+IGEKHNzO+EkKJcRDPovudmV4d9G5gAvaY8VFzPoSod8ImQSADChmJzaBRdrRU7uDVh9y4i49Q==
X-Received: by 2002:a17:906:f58f:b0:b50:4c37:c460 with SMTP id a640c23a62f3a-b703d2c77e6mr363225866b.2.1761814275132;
        Thu, 30 Oct 2025 01:51:15 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d85ba3798sm1691789366b.39.2025.10.30.01.51.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 01:51:14 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 30 Oct 2025 09:50:51 +0100
Subject: [PATCH v2 8/9] dt-bindings: PCI: qcom,pcie-sm8550: Add missing
 required power-domains and resets
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251030-dt-bindings-pci-qcom-fixes-power-domains-v2-8-28c1f11599fe@linaro.org>
References: <20251030-dt-bindings-pci-qcom-fixes-power-domains-v2-0-28c1f11599fe@linaro.org>
In-Reply-To: <20251030-dt-bindings-pci-qcom-fixes-power-domains-v2-0-28c1f11599fe@linaro.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Abel Vesa <abel.vesa@linaro.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1143;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=1ZQHY6JpkRKcQKK9PJI2DS8+9+Ft5mGT/4HkAsIsEZM=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpAyb0lVcfJDTfj3ub4IRYrqA7Lt4NeMpgHPOtc
 iUTjmgU4nmJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaQMm9AAKCRDBN2bmhouD
 1xtvEACU29T2agLTiM7s4VjWS1ofBT4LPVa8T1udrbLmdGwi/F/zDI7D5TIzZuqbfeZw0l5mPP/
 1l6VgRIexo+6EXi9F2EGNCuV2bpGahqYtBqNxJR1/Y2fX3FO0kc07CZDTqcg1LgLNh/VApyFiJk
 G7Pk5PXHFfeQnUmcOOJgc2AERqq4+Xmr3T74kvFmBKFMuxg/bS3JRvtVkPiAtKQm5ra3H/6iXJd
 8V8vI6lhQRitYnOREEb3kBL4HDvdQO4aMIPwFLV9kvTyzEZWLTvCCngOjD/q+Np87gAhiZ/MuQv
 9g+y6GQnMFq+kMoT+7Kg+8liKhZaTLDVG8va9v9tsG3/jpOeEUZktFeFHIhBQTQMLiLJFyGD1ev
 L2EQNYaW8evRHHUu3OojG/m/gDHQVOViNJwBAoitGjyAPMlFhhHY9TDXbwNUSgx//QsWallsO46
 IBMRjpWchqPZWdJzP3HRalQ4LMbxZSw9MfOIdhxQfmdLoyJO/JvbtvApPDJPxSKHaA1qx+3qPHj
 Z658rPfcK7Isc9z6ztzP52R1lZRGnjVmuzUToIw3XKOu7I2PizDr05bMiY/mIRpyTwm+uWgqjYC
 RM3FLG+ICLlVDprQI78B35RYpfFlO4ZkY05JMSA6o2Hiy+94j4fx8I9bpXHM4AxI0jw8Mq51qUj
 UKt1a+eJX+q7IcQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Commit b8d3404058a6 ("dt-bindings: PCI: qcom,pcie-sm8550: Move SM8550 to
dedicated schema") move the device schema to separate file, but it
missed a "if:not:...then:" clause in the original binding which was
requiring power-domains and resets for this particular chip.

Cc: <stable@vger.kernel.org>
Fixes: b8d3404058a6 ("dt-bindings: PCI: qcom,pcie-sm8550: Move SM8550 to dedicated schema")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/pci/qcom,pcie-sm8550.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-sm8550.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-sm8550.yaml
index 8f02a2fa6d6e..4853bc0eaea0 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie-sm8550.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-sm8550.yaml
@@ -84,6 +84,11 @@ properties:
       - const: pci # PCIe core reset
       - const: link_down # PCIe link down reset
 
+required:
+  - power-domains
+  - resets
+  - reset-names
+
 allOf:
   - $ref: qcom,pcie-common.yaml#
 

-- 
2.48.1


