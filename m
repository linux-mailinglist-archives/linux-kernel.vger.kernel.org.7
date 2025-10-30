Return-Path: <linux-kernel+bounces-877825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C114C1F1CD
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 09:53:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 118673481ED
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 08:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10EB734402D;
	Thu, 30 Oct 2025 08:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pwqvokk6"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735C4340280
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 08:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761814278; cv=none; b=iesmoba3tBxet6FzVSLSsTo9FNKOfdxsLBce3iDt9hmryeo3YYRQGHsljMwwdeFYHNEb8tv6tRuRs6+8V3wBA5Rzs28XiQFOlhnvyk+q86aYuFUa9XeFiMf/9W7COO1vp+Dh6JMrbvDxo+cX6LYH/3Ywd+ADu3Pk6iGWXcabT+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761814278; c=relaxed/simple;
	bh=CNLlhBwuYpBvzzRU0Iy0xfaJ7C6izC/UNkN1Iz1WyaI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NOd6pA4OJpQEhQ160DSTEKoOeV+8X1dmfqjplyoIhqg7yXKPzRF7yPVTYNT6AA2doOzUEb8vdGmzP48UyA1nnqbpQ6g8L8nhdU5/Qg1nbP0rd7NxrTLufmN43wEMe5gfQkSnPSdW3mMPskxaRDoNLqNltFnOQktx0v+4OxS5Gek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pwqvokk6; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b6d4eb89facso13490166b.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 01:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761814272; x=1762419072; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D28EfOOxWYrdaefT1gXIR0iUkSzZ7BDb5koGblp5Wl4=;
        b=pwqvokk6pQOd1rSYrof2E7/+qAq+t9W8CMH2+oxx3yL2FSgpejn6d4qDt060vx4f6w
         3lyZks/8P41I4hvJC8mv2C32ZLlJqNJK63SDB30Sbz0r+xsKZoFvD2nNJssvdASA8V4n
         m2oQg7tQFwJ8xxBlqmHO3nTKEKPEHV/OY/KA9CGQYPRlS2t0LrFBMJED4067c6i8lbAM
         Cy+tS+78kpnz8tkfMJFiCc/neeYTr/MVl/U0eO+/Z0SNVEsHtftMypgGOnoWI6HhY6bL
         cFhq0GOFdRdXFmxtZjzPj7fXPDcLi+NV+LiXalYr8+BBZYGv4K0ewXgbdSoTsHCS/vw9
         y0pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761814272; x=1762419072;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D28EfOOxWYrdaefT1gXIR0iUkSzZ7BDb5koGblp5Wl4=;
        b=bxRSWK/yp2WVRAjU3d3if276CUmy4K8vfTNf6E6Bb+vGgwiOp+XvPO+6YTO/CRPkrG
         +EDYzkiOuunf5c2qteD3Qg+jTz9BkZXTsYjMuV2H7tCPf8G11qgicLrOMrIAUcuEjfOY
         6kp4LXA2SJXFvA4Xmx+1jtkKX9MXB4VsEXA9lnNigADZxWQBdxfwCNNxrPLHrpWcMm+7
         qe9gubHfbTzWvHTnPXmG3+6VdB7KZ8Xx9z7IDapFaiHtNFb3/GeKWwdME+0rMy95jCzo
         h4ew+5oJcgw1D9DPfAJ7Z5KvBS78b/c/BXoQqWzPe6kR263n1To/yxF5KqkURQZavopq
         usUQ==
X-Forwarded-Encrypted: i=1; AJvYcCWyGZzrF0CLggVvdO10E+JojRirl0baAp62RJF8p6ywxCOv92+C0D9bgfCqzad5fAuD32RWoSEp8TSWnbc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMs9vZ7z5Q9SRF6WL2cK0uq11ZTUp5tr78yWUzickPZ9NNbmBp
	Ij4L7tcfXX1muEIiu3yEDKy9yEIxu5UIRBAf0F3lMLEbK5QvYm4usdP81h42MnC5nj0=
X-Gm-Gg: ASbGncsqyGhHoP9rM+xZXor6yR0BshzOMZFRrygsf/Sl7QnMSX9xBa1JLSK1R6H3uQu
	BwPzTALunDbrRsghxFeiVU847ZXCBE5FcZ1+90V2wHG2hNCl9lcWpSwfgYSCjIf9F6ApbZ7YwMK
	SD1VZa/k9lICjFQ+LoORbgaaeH0JSZWTjzyiR7dMT3FJzx18DXqmR4Ku2acStEMo9UXe99m504d
	YkffJVgXZt/Umkco5NHOUccurZqRj5ghxo3xPBBbs49tjSsxTt0rwx72galjBlzfSULIURtqiOH
	HMvBLQdsGnIbk64Ow2AC9df4klHvcLmTVeLAnaEmSdaFJI7fQ5XNFbOrGGLe9eq3W6v56D83OwD
	NEDsgHWkR6H+9OGdqlahZ6sfTTEkZyWKPM21e9YnSZA6h7iI4jqOT5WqGpSDjy/5ptBhdw8x0Re
	qFbTtmMbIStdx23+1m
X-Google-Smtp-Source: AGHT+IFx4TelI+GrNXm/w2tTDA32IzJmyD7uC/kjRQlzUbLtCTfWDCgAcAVXbD7GZ4re56J7E8ocOw==
X-Received: by 2002:a17:907:3f87:b0:b41:873d:e215 with SMTP id a640c23a62f3a-b703d2b2ce8mr290352266b.1.1761814272428;
        Thu, 30 Oct 2025 01:51:12 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d85ba3798sm1691789366b.39.2025.10.30.01.51.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 01:51:11 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 30 Oct 2025 09:50:49 +0100
Subject: [PATCH v2 6/9] dt-bindings: PCI: qcom,pcie-sm8350: Add missing
 required power-domains and resets
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251030-dt-bindings-pci-qcom-fixes-power-domains-v2-6-28c1f11599fe@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1088;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=CNLlhBwuYpBvzzRU0Iy0xfaJ7C6izC/UNkN1Iz1WyaI=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpAyby8/J5iVMIuTmuZt6le060uzimF01oYn8Wv
 LGUVH2MNZyJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaQMm8gAKCRDBN2bmhouD
 1+/DD/48Kef+j6tupHzMNU34kgv6dutDHj8uLyepSBKdQgQcOPmwAr7eZDv388C9Oc3L4Nh50TI
 sErtby7muwDfjDnNWmYunVt6adxYTIpM0TmfVchHjz61k7ZTzeJRzw0X/4tmICke3G+zKx9FUhG
 ciQbffG8afv+t8rSDlm6asoWxuR9n2aL69tFVNsnrcXaufEQLvq+PUmUIfxYxIeuVE7X7tBEdi9
 NLumO3kPl3/Z2VvOKCTLKhLLBjuAdmsVYwbqhXuR4BsJRNxTSuqGO5pcDyV8YpDHB56zE3YB688
 RvPMnx5bwWu6ZOnkPviI/rBIrO7vNPZ/f6FRQqGOhR2dft7doy/DDFwL5/hOnvOevql7RQaXr98
 2/nanaG3loYui7huQJhD8EXYmjqRTlIicAVVfnFyCUSTP1u4kDwRpm2pRhoEa8FpWwhsaUds05k
 T/qjLVs8MhL5EwQR5/woPhfjkryaCO2IU6L8UoMpSYbpkrqyW2XqLtTzkiTMbHlALEAmwDcHGi2
 43VghVruiEVzticWXJpM6QEsMrISdhAGzzxQEog6pZt1PuedCvuxxh8ZnyTTFK23NHK8yaW3tCh
 XVGDF9swwdXAsuqr9CUlYLZae5aa+02k08DpgmSptaw4jayiiEOCklDl9NUOmxFqR3wL3K81Bj5
 IIzetD/Iv8wb2Sw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Commit 2278b8b54773 ("dt-bindings: PCI: qcom,pcie-sm8350: Move SM8350 to
dedicated schema") move the device schema to separate file, but it
missed a "if:not:...then:" clause in the original binding which was
requiring power-domains and resets for this particular chip.

Cc: <stable@vger.kernel.org>
Fixes: 2278b8b54773 ("dt-bindings: PCI: qcom,pcie-sm8350: Move SM8350 to dedicated schema")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/pci/qcom,pcie-sm8350.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-sm8350.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-sm8350.yaml
index dde3079adbb3..299473af51d1 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie-sm8350.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-sm8350.yaml
@@ -73,6 +73,11 @@ properties:
     items:
       - const: pci
 
+required:
+  - power-domains
+  - resets
+  - reset-names
+
 allOf:
   - $ref: qcom,pcie-common.yaml#
 

-- 
2.48.1


