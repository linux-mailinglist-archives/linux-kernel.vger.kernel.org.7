Return-Path: <linux-kernel+bounces-876555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 776CAC1BDBD
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 16:58:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F02765C2529
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 15:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4C2B346E41;
	Wed, 29 Oct 2025 15:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Zk+YGaOD"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7A53469F1
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 15:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761752471; cv=none; b=eAoJYWcCX3Zo+rMCGYSM6ifqXCUjmpKpm5H3GLhYcL3cZkdKrNzOGpSskVnme4JlW1YW/cFh3ivZV7kxPRfW1nUAlTumMga2plGNmU1FWj00ViVcV70wvL8qO3EQkafKND7dS5LrdYm4CuOZv7mTQ+T1Hm0RJ2ORpX9135Ea8sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761752471; c=relaxed/simple;
	bh=gcObtR8O5ZMp1fMjuAEDOYmMY8vzvFQgHaemqAfEjN0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FQRj4FxrJ5nVKoXZzOsNYHogqYsk3jaqe8oSqsECrsYiIm6Q3eS/G6GbmrvncCbkGLx9h33PFmUHDcthh0KiotrcrRliLz5Fqluf4ByjGwppiyxiT4vRAOXt/oJpK5Uff+ZHeSIa6goai60kcTKjAe6xZ7T/TOkhE+ivfJ0H4ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Zk+YGaOD; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-426ff579fbeso896915f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 08:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761752465; x=1762357265; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TNRZvMLh19JYUSBdaaySWh/yUqTck826cyg9+QX0TII=;
        b=Zk+YGaODo5WErRkupFok9ypdEBU0iPKOCExjZtQImwCFQyxlY2aAagkLjHFFl0257b
         LcQnmPXMTNzsAr2oL5ci8qWySBFtpCxMGD+j0Vp8MQI+1fqjbY1TmNErPPhf/Xqm7kB/
         2C5QRCKL4XSRfrulBKVsA5QeSX6M+YnSUYX/VpHzbHihMuYEHl9kcByxPdcT0hHYWC72
         j05g3352+O32gdKYHKMOMBHTactjmMys6vJDi7XZLMJW4XU9JDp8GAIfDcV4kLtMAevb
         INlxXu+BRdZq3f2qiGzmsZ1UnDOgoU8B3ynqLsQ6790YOc1hxYi+tvMEOLSDgCVvSvLL
         CBcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761752465; x=1762357265;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TNRZvMLh19JYUSBdaaySWh/yUqTck826cyg9+QX0TII=;
        b=Ly0dRKKNhWJlG45dybqjCRZQbyVxlK/C+LqVHIpO2MAVSxbAsnpcjeWqXqoGhxx3CU
         1TyEko2GO2uADCLVSKx7isbGLNNv1i6NkVImgXSeTFjfeL9wBjqqgwWOIMpbZ4CQBMrr
         rjbBZrZEiRdQabe9l0E2WRlwJi01dLyz99ozRHFpoBbguipUCZQE5EUmlOI1IzXNVxWk
         ZWQcniaIZXj6ccoThsiCvF1bkidC4D4zmJluiBhk2NjUvsKlUB4eVP5qIwOFvpzqCyML
         ueU9Nl0hPalYUGf+hmmEYCA5r1SNFjwPECZ6npIVJLWk0WmJIUcHhSYTSMQl1eus5o3n
         SklQ==
X-Forwarded-Encrypted: i=1; AJvYcCWg240San9SxB5QkwCN1x79ED/2h1qynuepo99ICiiz+gRJ2qKc50hTF1mahmGbpNmd1hKFBff4N6XLSkY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDvoBVXQmz8c4mhKeXJRknjAxDM2Zu5XYBEDy5SxsmUlnbNwG9
	bMcjCZz588s3DsRF8Fn4kvFqKxJwv/If5lYz4X8OL4iZwOtQbLhqRphLIOa6o3Hk21M=
X-Gm-Gg: ASbGnctdfPzMbLN7q6kkGmdP4n5nJQIngF1nncYxH2FMv5CU7uOTGZ9m4rQvVyu3jzr
	EKWJAnvd+J7kZRpHGVW0V4XLWa8EA4E5WNkbbVpQuHw9bLK29Jys/j3pea45D2DBmCTYnhfaXkj
	vtc3BGFgpYl41hD5PfboOChxC9Ds5vsb+bxHC7qwHw85gg+NaYYpwYJ5zp53N8+MxwAbDKhpQMm
	kP7/poJBBEtKrQzFK6MMCse06X9uY4LYwLinis4WsI+ckOk3J9PbAJCHGnUf9Ybqnn/eYGQWyYS
	v7lnbz+Z7azsaHSkElDCpAMUKYMJGv5M+9TWSbbSwdUBVOkGjLneYpX577yls4AvTVcpn2wDjUH
	gPoV6irJVK72AiepvBjYraKlBGs2HEXTs+YVMDH6YHm7DyA1bKyATPr/FMEa6SevWqMJSrJJyYq
	Mn8//nZubypTBYlQD4
X-Google-Smtp-Source: AGHT+IEHcEqR1OdvqLT7eFSnCpgoJm/oJzx813KuGyGeIP7ewwn6rKls9lXlsuPVl0vgZ/Ia/84viw==
X-Received: by 2002:a05:6000:402b:b0:3f7:f02b:d7a with SMTP id ffacd0b85a97d-429aefc0267mr1328492f8f.5.1761752465432;
        Wed, 29 Oct 2025 08:41:05 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952df5c9sm27006875f8f.41.2025.10.29.08.41.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 08:41:04 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 29 Oct 2025 16:40:43 +0100
Subject: [PATCH 6/9] dt-bindings: PCI: qcom,pcie-sm8350: Add missing
 required power-domains
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-dt-bindings-pci-qcom-fixes-power-domains-v1-6-da7ac2c477f4@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1043;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=gcObtR8O5ZMp1fMjuAEDOYmMY8vzvFQgHaemqAfEjN0=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpAjWDrYP9a0vChuYXfR8Ab+MtJdkra9hCmwFbM
 hzimW88JWiJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaQI1gwAKCRDBN2bmhouD
 1+uiD/9tc10crzvcSVVVTGJrGwZDo3ymggZeqB4dpQkQO9qW8TCegY4ChY4YPON2MO9QNcu/JnD
 U+QbXdTAEVo/TpjL92VL+0fsP5JpRNzvmv0FZwDekHwEp/9W3ux0TO0F3d+tOsufXVozh41LfTp
 1AhW8FuNoR9vpmDPd9dwGF3Y3HG8HAVAc1LzHkRDiEJ27YTRCoYQU6UlvlWIbYzuUo/uS9jm3dd
 duyOvzEoQ2nrpU2GnSVov78qUt6BGm677yXo0ewX4xvdp2lPRVZmnP36tdo411qH6BxjKp3OElL
 AsluU39AGhioV6p0GHUazID4dQRkYiqi+e/bQ1KAOioP0lbENtdaIuqs8CvHgPiZ5A9Az4IlksJ
 1vqOEddg71wF4yR0N5OMGwhi2whCJ7VBhdL1jcHBKrePUlj15T54U4mJ7NM0d6QQQ6FcDV9O5t1
 VUTlB+tWJDXxWAe5ULAxacFC20hWnCPVI2cJk1PKG1HOp96J1HISP+sBX/4qcTGAtpvlnZZVieQ
 g802C1XbIapQ3zMYCToGJMqdpHxm0u5I7Zwnbe2K3TOqSKXGWQYpVarZN2izM6s4kw/1JC7LIyq
 btx5E8eh/MUfCUF33cleNN/A5uAKloctJeXae/VKXehVKoLcl+qvslGBp5S3+twTaXnaNC2MUYX
 4VB8Ql1gQkJqL0A==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Commit 2278b8b54773 ("dt-bindings: PCI: qcom,pcie-sm8350: Move SM8350 to
dedicated schema") move the device schema to separate file, but it
missed a "if:not:...then:" clause in the original binding which was
requiring power-domains for this particular chip.

Cc: <stable@vger.kernel.org>
Fixes: 2278b8b54773 ("dt-bindings: PCI: qcom,pcie-sm8350: Move SM8350 to dedicated schema")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/pci/qcom,pcie-sm8350.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-sm8350.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-sm8350.yaml
index dde3079adbb3..7106ff08da6c 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie-sm8350.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-sm8350.yaml
@@ -73,6 +73,9 @@ properties:
     items:
       - const: pci
 
+required:
+  - power-domains
+
 allOf:
   - $ref: qcom,pcie-common.yaml#
 

-- 
2.48.1


