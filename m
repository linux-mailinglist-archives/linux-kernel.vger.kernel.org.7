Return-Path: <linux-kernel+bounces-876557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E90CC1BBD9
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 16:42:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FA89188ED70
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 15:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE6733491F5;
	Wed, 29 Oct 2025 15:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ckYAIvlU"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7946033B6D8
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 15:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761752474; cv=none; b=eYwsr5OhaKChamk2Vl/IO/m+cv/DtFnNcnCMFW4IOGUnhyegdNrQdh9HLiVC2bx5X1F3jG/WRhojUwyfFbMaEJg25ESSm3SgoSxJeqnqwff/65WXagxmMZSkDNDFKUxc+E3X0aJ4JfhU2FONLuWwX2O8W6NY6KJ38pyfJz0Z4KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761752474; c=relaxed/simple;
	bh=53sgLXqYhZpvxE9VfPFYnKGG+WSNBhfa1Et5HeyqvGc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qzeSjYooc3lLp0QJ2oNjUyTUIgC9T9uCvKx1PGqlt4K9WM2p6jtGMaSY/HZKrAJ6KO5hn41ythktZ2OdMyLWGXObhWIOOLg2/J4dxxFzTQzfRIKA/bxd08duGhRPZjMgwl1fhlHLAuGzq7ACbwpuIm143usH9x36kLvLZFFHRGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ckYAIvlU; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-4270a072a0bso809f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 08:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761752468; x=1762357268; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O8hNdW1UdVGs0q+9m0OQtp3GCp/eHhN3q36QZRJjw/U=;
        b=ckYAIvlUE7x1sEsyA9G8nnRyItFWnaqfZVfkTPNVcwGikW8HwabfQ+g+3UGytpwioR
         YTS6z7GMtyMjYQn4TOUZTcTyJ8LZCKcNywX3Q1tk3t9hols1QK+Ci7JdHtK05sP6Q2Rx
         G4/VfLNikXRgvG987q5mnWttx5jU1pHbDFWnXmQegOre1Indjl7osZ0KAo7mTV4tNwJV
         GHUBVvN/TtOMaukaK1PUm/ZulrYMYa2eeqUaM1On78w5R9qET4DOzdhn7EZroCjPGQlT
         I78oULXXrYX4VO6h9pTXNVXS0yN6ZI9nnF/ql3wrCHzLvSMq5O9oC5jaJ+pNFq3BAig+
         FwFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761752468; x=1762357268;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O8hNdW1UdVGs0q+9m0OQtp3GCp/eHhN3q36QZRJjw/U=;
        b=JXAHGcf8hj5lcRax7vx2ql33uA9HklCkTwFPumRgC2IA+hvkZ+coaige57e2+kHaWw
         9Ep3DWFnfU0XJQjY3ZhFYp+bcSOMDS7Y8k1o/NK6/0TaCy21f/AD+NINsvTy6KtNXujm
         jsBrDAJS05TUQhUp2pbQwNow2d/jW4AEeMOFICTngLSApOT1b+q4sm2abpCXX+WFGGaU
         pJp2tJtjBquTXQOxWUjrohKgss/B9tCvZv1JH5VJPWj0UQb28IgYPi3XHK6WHdGVn+3z
         Yad4h5+/F0OPHLEEEbJIaG87jIwMrx5euqR5KZayU0JL4JQgEbhOz4zif55dnQ/8gZ8e
         nPwg==
X-Forwarded-Encrypted: i=1; AJvYcCWfCI0pCtYgkU1tD3cAtEzgrncBfM0o18VQUNrd+OLZmDMBxXGPqrQx1BNUyX6ESkjIrvwpFUTPCcQ9M9I=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt/6UwxhZtTvq4xXtu40KXfJQ1429U+x0WSDXRnRLnqKZPtHca
	WXguYsrbfXaHniPrxPv7MIfdl7aNP3+BfjgAezY9RdAFVjlarQCc7KCVf93wbi2t7S4=
X-Gm-Gg: ASbGncv3bmwIddeRxXv3r5rJWQjN0vO7lIUMGjkcr80gMRvw8OdlsOiJkim8GSKjTV2
	z0OeS7N8tcR6sxGT+B9yqz0MTAME0azqdv+J4d3xi4sMdcyEcuVejvSEOuHpqgNHjHp6goYeUAS
	flhugLy4jw4g88VfDk+T1MnMC205TNRg5RbpkQVAdvTRxS8lLo5wTpFXPMdfuJMAbNmNRiYgiQs
	3uwuTtdyTEcUnP40ifD9JGDG/7qzqsLgqi2r4w5010cJQms0kQ0rMv/uevr08DXajz9FAPGkP76
	ERpjEplcJxdK92fXkgpR9bXImbQd08t4rhEGxVbHlNGvwJyEnVJ3UA6jUGZFxOZ8jLJ2/ejpr0D
	wgtP051X+PGr65Bx+YgQafJLG2WZU03J/Eo7G/bJp/bG4oIxQ9/fU+h7p8OGEWWPjC9eFFPZK+j
	hDuoQjZxNbQ/rQDVmv
X-Google-Smtp-Source: AGHT+IGTV1Z9pcCIuK2AabPU+xp/QKfF3KWNJoH4hjRtj5SjayytHPlZRtPhtNjeo75QTLBQSZHXow==
X-Received: by 2002:a05:6000:4304:b0:429:8c4e:6b99 with SMTP id ffacd0b85a97d-429aefccfd0mr1390712f8f.8.1761752468374;
        Wed, 29 Oct 2025 08:41:08 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952df5c9sm27006875f8f.41.2025.10.29.08.41.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 08:41:07 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 29 Oct 2025 16:40:45 +0100
Subject: [PATCH 8/9] dt-bindings: PCI: qcom,pcie-sm8550: Add missing
 required power-domains
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-dt-bindings-pci-qcom-fixes-power-domains-v1-8-da7ac2c477f4@linaro.org>
References: <20251029-dt-bindings-pci-qcom-fixes-power-domains-v1-0-da7ac2c477f4@linaro.org>
In-Reply-To: <20251029-dt-bindings-pci-qcom-fixes-power-domains-v1-0-da7ac2c477f4@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1098;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=53sgLXqYhZpvxE9VfPFYnKGG+WSNBhfa1Et5HeyqvGc=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpAjWF7Mo4MfJI4JwNrcznfev1cDVGoW79tEfqx
 s2lIvOOQUKJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaQI1hQAKCRDBN2bmhouD
 12b1D/95B/f2UeuWUWvHPgxRWE4/eakcA61t7sZNjR7GgPhnkndzlM6EajdhvCvgQidJkQf7TEx
 g54bi44zn8IEhq4PB0rJ1gByoVIBM6rcEZtHKXV0yDL0KqgUJ5Lf+SnVnzJH8w5GfBUMj+cZgkI
 WHzIenc6ks0meNYI8/9Q1EbqYh9hc6bOWcGksIVgQs6h3CCgNDmBUjFEly9E8be4DeC7kxdyUlo
 71DXdKYOdsodWx6nO29Cx561spNVZQl55sORbIzzns2cpQgkiwuZ1GejVR3vQBcsJDjroty7H4U
 DHKIUcVJtS9t0md16A2Clnhm5C+hk5jnUiIvbE5andpoudVK3WyiNL1yMGGKQdQcffvFnfMbgAC
 hCQQFuJSYp1JQ1y2dN+Gkrhlr1rXni1hfv2P32BgAfUpQ5SPByzqKNLWebwn1H9WxXkr70Q8yER
 zyZ9IFXReYT0O/m1Uhx3sg7mqR4BlACX7kiPM6byC8u/OiWQhjxucr3KQnjo5BHAVT9iMWA0yoq
 XGPKvUabMyMGGwqeRWDEhM+yP0AeDYntUoHrQfK5x/2IQuGwWxiWbPQ08z1++Z0YWTk2pgqRPq/
 Q+s3OETwVn4hI3PLhmUN7teMbVLBkJFzztKl290x4FNukKyVBJITr/wile/FjSoETilkNZeBN73
 D5w6GWOd9p9ZtyQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Commit b8d3404058a6 ("dt-bindings: PCI: qcom,pcie-sm8550: Move SM8550 to
dedicated schema") move the device schema to separate file, but it
missed a "if:not:...then:" clause in the original binding which was
requiring power-domains for this particular chip.

Cc: <stable@vger.kernel.org>
Fixes: b8d3404058a6 ("dt-bindings: PCI: qcom,pcie-sm8550: Move SM8550 to dedicated schema")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/pci/qcom,pcie-sm8550.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-sm8550.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-sm8550.yaml
index 8f02a2fa6d6e..849100269884 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie-sm8550.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-sm8550.yaml
@@ -84,6 +84,9 @@ properties:
       - const: pci # PCIe core reset
       - const: link_down # PCIe link down reset
 
+required:
+  - power-domains
+
 allOf:
   - $ref: qcom,pcie-common.yaml#
 

-- 
2.48.1


