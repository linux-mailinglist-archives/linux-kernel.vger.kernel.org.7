Return-Path: <linux-kernel+bounces-877820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id DF6DBC1F18B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 09:51:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0C58734AD38
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 08:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FE4B33DEC4;
	Thu, 30 Oct 2025 08:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Pj8S9j+s"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD930337681
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 08:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761814269; cv=none; b=mQ0rKbwaKjPbajqTlfiDyqWZTKbtXojCJaZaoh7CPrV7F2o93XITgZ4xaIi8BnbNDIgkYItxzl0dFETwCDmzfqsbu88YtTSIhiUIiUxU9eZqQN8GPdoHCJNu84cTpDbXAgCNypvHEsQvhBVv0vQQ+tBkPKIYkLFxsZnUxsMaanQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761814269; c=relaxed/simple;
	bh=rXq1QELCgTi/4niCTS0uLONUwSjnukkVWCz4Maq8s8U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JPea174DE5ULGRzT1yNwXpVbbX1RfSEHl6Iq4lSZCB0J3Ul4KKJCWxninZEKSwPm1J5XJW76VO/xWZyLfHUf+ziQ8j0KS4DgYEwBa9pQmvLII4a6r1NgpxzQcaN73B66NDL3NK7mTrHI3Z7RefcwMFE9CdrnQ8BNX8VwOZtePD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Pj8S9j+s; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b6d5f323fbcso16781266b.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 01:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761814265; x=1762419065; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OG7PpDsVAE9tQ612HrRzhxoXJQE6UwfDyZazvJz6U6A=;
        b=Pj8S9j+sJU16ltLrouhED1Z0QtZlR9BDV4kzu3SyFH2PcN26Ib/xZHHmeEc00DYVXK
         1W85vjvD7XdY/A5gDiEQ8ECFLAwYFQHvoXF1npaKrklJ/C5I9grcfNMu1z31CYZTwjgI
         zqDV0xm5FQYhwZdM5f2dklhZ7U5nUexK8bmCqvWDvGclwpqoTyhjUMC56++PQEn9pH+8
         AWVCU5zaq4ZzZo/mO9P685+OgM0XyyTOeyXqrgIOU1WKncQB7+oPM8qNVTjMwT+Ft8q8
         58uDn9MK2ooTxMSC/gd43B7+XV/2oLFeWH6KEjQyw1OM1ReVOPpHaFVb4EJBZVPjatJz
         SpTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761814265; x=1762419065;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OG7PpDsVAE9tQ612HrRzhxoXJQE6UwfDyZazvJz6U6A=;
        b=LujipmgxbbhD6cNck01ndudchyQOXLRhWQXZVr2Mo+5ak7bHaUPAtVHEJV4b5O4JNh
         sHnKK8ihe787AU0EkOFtmBiI1LpkS98Zl3v1MvvzzrECOrltu8bnCY65QOg0kSVQa1Dz
         rGoNw+uRNIfLhRxmIqSrDOpKydf9B+vNQIpkAwNqZIt/3CAIKx1ASdHMN5JV7JJQ2a6J
         y9vnhjxrPGkj9jrLKeOjOukN81ot9G7pULdrk4BmEXzZaOK+nJVTm8aowxct1ZHYWrqA
         CdQZe7oCKEmAMSbt97JTyuBg5paiv3KGCIAFKZFYGraN5wGD5DpfZn3VBoLK7NkW48/O
         zo2Q==
X-Forwarded-Encrypted: i=1; AJvYcCU72wX5UTm8Z/7X+2jxeIOPeUN2bQUPz95lPtSPxI9QRVwp5WEUuu6OzPZ2gCkEKAncqGktW256NiYg64A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzokluhSXZkhv4HSZE9T0H4tSEstrs6rJo7AwH4vu++Zk1o+rSh
	ANmkIn4Lm2il8eKDpr87A4RIDhYH3jvXPA1XIfMT3aHR629lqsOM/ldUHVWa1GAd35k=
X-Gm-Gg: ASbGncvkSyQfLzJ2tqjZrlhRthGcC3suxfYoDhF2UPPx4qPAEjTg/yNpYyMF1hBoUcr
	Rxn1E5F+jb+3W7AMWmuDCvU9+6PdpsSbW3I6KZONk+D4T2TKzrjBV3tGEaeA4r1f4Lx++dQIHZG
	vFaU5auWqbZhFociyi+H99ANKZJDLWtsJqRc7SU6Uwp/hUIrnrvg8wFmvcYccz0oWbuHhHtCfdY
	89SgrHYRkrKE9ikP3F/0RTYAkRXRH6k5XPQhJrUk89LDZrv3kNb4MkrT5nQ3/TmIIwS424itBF/
	RKSFtQixo013+VsAxQPb2/iku+tAZhZFcuK05XL7ECjNXy6nskFSpVOo2G3p9yrV6pSjePawAxR
	dSdfyqB4uf9yjWRjl9zG3YXTJB57M02QuB2Enei8+RY/1GkgR9MBfMhFVX8vOUkxSK3vgdgxwYf
	OM7Hp2zNgwJ398caKT7/cy6Nd/5vk=
X-Google-Smtp-Source: AGHT+IGFLZS8GxF6MeLiN8EwoMl4nYDKEwyD7OXcUHBvM/zIfmGm/ta5BWBNREoMfdCnaAAicyJZYw==
X-Received: by 2002:a17:907:7e92:b0:b46:6718:3f1f with SMTP id a640c23a62f3a-b703d586658mr351894166b.7.1761814265126;
        Thu, 30 Oct 2025 01:51:05 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d85ba3798sm1691789366b.39.2025.10.30.01.51.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 01:51:04 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 30 Oct 2025 09:50:44 +0100
Subject: [PATCH v2 1/9] dt-bindings: PCI: qcom,pcie-sa8775p: Add missing
 required power-domains and resets
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251030-dt-bindings-pci-qcom-fixes-power-domains-v2-1-28c1f11599fe@linaro.org>
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
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1069;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=rXq1QELCgTi/4niCTS0uLONUwSjnukkVWCz4Maq8s8U=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpAybu2D1GdGoCurOh2ok8fMYpMdVXdtvTMQIHF
 CIjvg8fh4uJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaQMm7gAKCRDBN2bmhouD
 160eD/0S/f4g3I34lZxDFRmvUnDit4hDTpsAETkFlIoGC/R+d8I52YI77Y2J8MiiQwe+kiBDPdX
 AseaW7+jWxpEE+ucJPOdDXKiIItt15hkKzuPwjZG2wn+RMSwxMdr9edhNPWO8kM63XO5ZqoBimn
 M//1FX8amSzIGOYqUKO0XVa4QXB2kDQqGRGVNEPt/Nzqw2fop9phljeYAtBQlwFM8hl8VySPkp6
 t16LbNBjj7NAvyKwe7ujVjbxqkgUFAMBSGvZGF4sKB+KdOLT7P2vJMO9PkL6GxW13uFrjTBUfRh
 CqcAzGkaRRrC+EM+3sqXFfsCP6bvawuS+rGwWySCJjz/9jxcFn7TPvcT1nl7tHJGzP/HT7v9SG9
 9GRirQIeBOwPnI3iIn/zvrZFqDaMYTypKcdyvdtQT6eB3uC8lRgAZPL2JcBr3WqcB3ovuc2GeUf
 ey7G558vcRkvBwu2DaIim8JZ+Y+3YiiH5eTgTrXmHMkX2tLVmbYL8Tsy+PfsZWvvRSoKuTSdn3p
 ZRXrLq/NxFKVbyKCB76iZLkc26DOVz2nzApJzmgz5qunvXyGsQjN0HmP8Dkx55B3wtw61vSJzfD
 Fd5I2LR6hu5nUXdObHNLQGvOwMZaqDKmc7uXsAmW82igbXtNL07n5cKBBdzCw2JBobzE4BaXF/h
 3LCi7xdkKYxOQRw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Commit 544e8f96efc0 ("dt-bindings: PCI: qcom,pcie-sa8775p: Move SA8775p
to dedicated schema") move the device schema to separate file, but it
missed a "if:not:...then:" clause in the original binding which was
requiring power-domains and resets for this particular chip.

Fixes: 544e8f96efc0 ("dt-bindings: PCI: qcom,pcie-sa8775p: Move SA8775p to dedicated schema")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/pci/qcom,pcie-sa8775p.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-sa8775p.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-sa8775p.yaml
index 19afe2a03409..f854c809ae37 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie-sa8775p.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-sa8775p.yaml
@@ -78,6 +78,9 @@ properties:
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


