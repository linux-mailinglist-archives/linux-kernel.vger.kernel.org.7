Return-Path: <linux-kernel+bounces-877822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 56FCDC1F26D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 09:57:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A2F418999FD
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 08:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF74C33FE0F;
	Thu, 30 Oct 2025 08:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h8MAx9Sg"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A84322C88
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 08:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761814272; cv=none; b=Vsjp2tQuX19Aa0ExeSdAgo950TErwB9V3Wo7AG2Ij9VML9gRhupG+8goQFYjioKVoqoACHxe3iC29/Mlhar+AvtpAcx5smhYg3+m0hYVqDumYrLgvos1vLhIrSQsjZXNd1t45RiQXYXuiV93yB9rM+w1R2L494HOQ6nvTCrPZP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761814272; c=relaxed/simple;
	bh=UnjXcV99SvWkoomQOs3r0Y0I0AunpUUaV5PFC6B7+o0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ifuoE11Vciblz+sO2RASq9EM8Osr2VgS/jvUhoXC3S45ooOZTff8NG6tJUWkadi8ruyCQYXpb78ktYHU4DpLfxpxEiTH/nSspJ4gHpH8c6J7uEzkgZSuGHtQPvLZGFMFrtrqRG2wkSJLEZo2AitID1eodFpCf/OC6MvN3h7VhMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=h8MAx9Sg; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b3f5a6e114dso14878466b.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 01:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761814268; x=1762419068; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0/swht44pfZHk2nX88R5C4csGgGV80gpv8aGt6ox/pU=;
        b=h8MAx9SgtWI90FcqVZj6WiFivagLNTbeIcW4BN/6C/scYBLnXIGAXiEXryUTIfRrrJ
         eMOF6bGvv3tdFPhVzu3IS3ZDAB/GCmdiAu+z1khevGWPKjphnvaDpsNZWksyBXT9c/La
         txvokatlaphrOYZDEJx2cLFadQj41Qv3WVL73FFntZl9KrJPh/YaTjQ1sUSfKvOxImtv
         39zkjC0Vkp/Q/GX/ZeLFBbJIXKbadCKPQECh6Qw0cgRXIEkonkrLJGo78YDcfg3NEVKC
         jS6kZqB5E5BNpKruLpdPGBizV1jUXWkXAmSzlq/FqULtj6DS+ZswdEMGQSbBKUHSrZNP
         jWVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761814268; x=1762419068;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0/swht44pfZHk2nX88R5C4csGgGV80gpv8aGt6ox/pU=;
        b=A/MDs49/KlnQOV0MjHOj2GXxVNkGwAOmA3BHCsNnjA1+CXa3gVGgI9H7Nhn4ZODa1x
         x9wzrdwZqdc8nCIaB1T1CFkTfxqbvJ2WhGilqfORSxzYcTgrwuBOsrqv8kPc1v1cvXFV
         gAQUQF7k5MMcha9wIYJK8sV4cUH/lTVldte631fWejQ3QBjhTPAwbuW6+42knj/Jgx6N
         5Kuc/ZLPSxdrsYCawBTUDyNFWbcRPMO0va5eAU12YeHLrSw1gG/y8v35Xq9aXujBLt3W
         tmsVAvZ8jRV4/v3h8qMN7qMz/nw18QCL7TTenZTQ6NFua/Cl+OwQnvNS58y25k+0pHEM
         P+Lg==
X-Forwarded-Encrypted: i=1; AJvYcCXyYzF3Nu0u72a4f6GePrE2T6YM1uTm/2BblJcceIwsoBnZb94MOGdRs5PkzfFh6AVzLFbIX7n4zCluMbo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjG2R5pv/uHFCJ+0wz8aypTt0H767MJ7gTpJoZ1TQP5muL2ckF
	SPFgxY1/c5ynzfjKbxS2yJGAV+E3hEeUSVcRmqE+kMibtMornqMulKfBvhEVRgZ5FXw=
X-Gm-Gg: ASbGncvWuSRA0UNPqFzWckofcZOVby4GmUAOsfQHtpPdmXBJGdnmiZ4z4n4qMEjsoIV
	/+77LCah9tkQdQ+Y+GOioKdjBKIjlFnDb+0z5vBdO/ZEyQNJSQRoo2O/T+VkmxpbHWobo1XnGp8
	EJyIp6qwIu67NoCAu7ozDg8y9vZ39IM42iOodc2ZPGQO2eSHaG3uGe/j7FIHN/H/XsORSNWZu9j
	zKsmM/jAaN867U9ZosDYdAyW4bM+6p5XimWNwlf/C07m+w8xBSLvvDCBfaYdIrw9bHAwCoPv6rk
	qHtT0jGq2skHnvB2Iu4ZGm+/qa9UvmLUK/eCiq8+1ie8/jGGzzZYk8ClFHbcw1OpalHu/67xhrR
	Ly20ZDplHN9BZwEaVq1XL4p5b1vzBB7jjHWPH+AKb7EpJdL7ttGBBvZ03FNWeexrqCfeGW9NLlw
	2+7JKJMx1XXy06CVhGlFWCGNnwKoo=
X-Google-Smtp-Source: AGHT+IH4Xpg+Im3DojMugmh1k4WQg6GSGitSimjc0UjEvJ67YG1OYfvfJB1hyyAWNNTXg3FuP1igOw==
X-Received: by 2002:a17:907:1c1a:b0:b29:8743:81ef with SMTP id a640c23a62f3a-b703d062d24mr328347066b.0.1761814267999;
        Thu, 30 Oct 2025 01:51:07 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d85ba3798sm1691789366b.39.2025.10.30.01.51.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 01:51:07 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 30 Oct 2025 09:50:46 +0100
Subject: [PATCH v2 3/9] dt-bindings: PCI: qcom,pcie-sc8280xp: Add missing
 required power-domains and resets
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251030-dt-bindings-pci-qcom-fixes-power-domains-v2-3-28c1f11599fe@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1108;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=UnjXcV99SvWkoomQOs3r0Y0I0AunpUUaV5PFC6B7+o0=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpAybwOMIy5w7bVl5laC1F4cjGoJzeCUfsuy9MV
 e27p5XJXNqJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaQMm8AAKCRDBN2bmhouD
 14njEACEAza30Q1dP29Vs6Eqa9pYTbA+URJVy6miVBTSavZAWXhlnPMMd9kpAP8wWwFsAnOShld
 on3rTD4/3IsP9vcg8vTYTS4TPbhNOLAOhdiBNx9Cw9Xu/keTxYG0wD3SIFr59ge40KF3bCmy9Kq
 iHQ9Parl8OKVn75at+yzA81l3tj3KQmE/jwi9W86vvdh5LuSuPBFVcAuOQQxAzq57vPCV6xAgbD
 8mCQ2ev9GdlvoqHpW9fN0IPYZAGYnqN9ODdkBvHvTgJ+OQKMDhEj3lRK6R45lTMT2XUKRheS0Y1
 0ylazyYeY2z3U+bu20ecS1zRB8cu6VpGnsGFAKn2TCcr5GVYEgorUItdfVeGh6umBpTEsLszu7g
 FAtBsYXk0u/Wc751GoXJMQFXsleMwDVoO4Sieodja+ktfIw38a6sxP5Ri8j4rdykDu2ca3OojEZ
 6mK68gvYsI6nhAa9siz25yReo7wAc5kCPPPeGxy8qGmHV2qfzHfEYsNJFndnoarD/B5+t4YWzbV
 beiULSkopGYdfofLXTdtZa7h+l5g3n+cO/P6EunojWpqKP1rTsWPstWXJslxIinRZM2msroFKS+
 jhojr/TNW/F29S0G0j7MAIEhIrOcGo9mvZlMw/dFgomgf7DVNLyzdEjRp3bE/BE6rw9PYeNRtiC
 RkP5/pc6FWZLBYA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Commit c007a5505504 ("dt-bindings: PCI: qcom,pcie-sc8280xp: Move
SC8280XP to dedicated schema") move the device schema to separate file,
but it missed a "if:not:...then:" clause in the original binding which
was requiring power-domains and resets for this particular chip.

Cc: <stable@vger.kernel.org>
Fixes: c007a5505504 ("dt-bindings: PCI: qcom,pcie-sc8280xp: Move SC8280XP to dedicated schema")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/pci/qcom,pcie-sc8280xp.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-sc8280xp.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-sc8280xp.yaml
index 15ba2385eb73..b6fb0e37cec5 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie-sc8280xp.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-sc8280xp.yaml
@@ -61,6 +61,9 @@ properties:
 required:
   - interconnects
   - interconnect-names
+  - power-domains
+  - resets
+  - reset-names
 
 allOf:
   - $ref: qcom,pcie-common.yaml#

-- 
2.48.1


