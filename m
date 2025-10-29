Return-Path: <linux-kernel+bounces-876550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B77FC1C13E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 17:30:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 195726436BB
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 15:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E47733385BE;
	Wed, 29 Oct 2025 15:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qHyrw++X"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6783385A9
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 15:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761752462; cv=none; b=XqiQUUTRNXSHm1oE/jafo7+W+5qrh3xNs0krPnSjQqHbDBbF6zmCL34uVKzYbNjTMEfeQLbp+lzyruaw49iDsqnW480MIQJ1A3RHlaHf1ul65fxnX2NNWJ2PBjqh5tOBekW09WwkLuLbc+S0uhj0Ljvng+xKhphVHRY2xr3Ebns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761752462; c=relaxed/simple;
	bh=1fAek205tjxe5bC3Mw7smKT9uC0qrrvPds/niowbYos=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XvBG+Wun/Tc7InuEfotrd8HY7225HmpSLtOyMyoM82OXARFJu2zxHHRZAOZRMQ3vwU7NCKdIubAA/fgP1BuGRHyFhDkuyoTEdd4BklyVRrxR43pwhSUiPySBuancp1WRLzTVJvdLlCVj5WXSUv1CLqJyymdN5v+isp79mdg/1ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qHyrw++X; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4710c507f47so2472015e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 08:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761752458; x=1762357258; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+/6aENKKR4exftbn8p/Al7BzTNTqTeJ3DDqHbxdA5OM=;
        b=qHyrw++X2egnsJCcr+Y6WSq/TjRbhlnjirkekdTXoV+hNbfOP7mfARs4WupuVrTLte
         n82Wf0oXpFj+umdOL8r4HPqo7wZYailbxIXpEfBsKzKEje0I9GBeo2p+dd0mrbNJ5uJ0
         y+D0BIsjOTqqP6xFiorpVgVu8WbDXdlSufhsKkYghtZaM50BAp9NskYSxoWu8iPi6hoP
         u0P1aNqsLCDQsfrwEycRtEbYxLAEF1DlCz8pSb+p/hvuikjIabLo2zHljv1+DyDg7T6g
         8vabXi32mtHGmTyKZ8xing5qP7hUVxLF2f/SuY0SwHDTSwUR/OZXWoA6aLnY2Zz9XasO
         6OPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761752458; x=1762357258;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+/6aENKKR4exftbn8p/Al7BzTNTqTeJ3DDqHbxdA5OM=;
        b=If7c4SAIM2Cim5hjcRDDCEcmonrcUDWmFssRUDFk0tJ/RMiiG/rC+1xg0Zig+Yexho
         MzAjaBrPyzmzfJrMgyNu3PV53Oa6Rb6sWWnKeb5g3U2kp6qrAg2SksquFwyE/Aqv5Ozk
         rvWcf2kto2i7oGiWbTU4xkB/KmAUbGUICeBReQoc4BMc9gwkL9bKOchEldcuWyUr2oUl
         jX5fNm9JA9YayjilI7ogDNO708yENWVR8+PjFD3Ud1cUoS4iPpXGi8osBxnM4F7F+8FN
         5VyrlExZ4Sdk7XlDIExTLukJIJyc7pVsWPI+xWWJRPBq+8t3ppoSRbnwmrwshKqJBWwz
         wwPg==
X-Forwarded-Encrypted: i=1; AJvYcCVR4yFTvOyDPSD1Fz5KaDv1vR94lr5Zb9R15SjBrPNU9pypIGPyhIuDF6fcV6HB8CoiUSeQZimoJ8F2WRQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdPQIfeRFZ2FXQ8XRygHFvGi3D4DXuTRe3GKd9zbvAhqeTb2y+
	O09wQ9jdpSkNbY+EqmnYR4K9at+89VzV0Rx2SZiDBk8NOfYTlVYHfzhWXMmAJ3zD6Rc=
X-Gm-Gg: ASbGncszTWvFwq5dyxKrWbRCJNgogyhY1Ata5qg7oNZl6ugccD3H7I+Km4lUNNlLM0e
	rVXtpqH5p5K8AVFS2LgQy7X/SpGZEYaD2t98syoPBtMrdmBJWF/0zU9rgQQSJbDFfXJ/PxdkkeP
	ooH/ANlR2MV2C1CH9hDsbHjqAn+iHBsHZ/vGvqsBmp2gPzsomMygXIRdCwS5NpzUnUqjcRXbyLx
	+C8K/m/g9AXAwZOj9K/3l2x8wBnvIfIcGzd5AxaE3YUeOAw5BkygR4Mu3e8NQ30eRw7GZDIdvyE
	X6lfsehRw+dJkCeUB4cpeWb2KhiCsPgfUzoe/ErIq67Y0d6CcCm4znvqWnitnwqYdIdYNiBE3zu
	t1VkDSizsucyntlrDwycrOrAjVkel/AM6iis5cnbtPpY6UAgPJ94NaFr5zvOO2kcLqbdPt7CxI5
	Tn/HxXDOpSXMk1oXFN
X-Google-Smtp-Source: AGHT+IHfKaYZ1HQVEJwiZd5CaEltxNq6MLDsn6VZqJqiUlpZB8rDZMMuaTYmJK+w6W+TB7slho+rZA==
X-Received: by 2002:a05:600c:474c:b0:477:c77:5168 with SMTP id 5b1f17b1804b1-4771e1d5941mr18801115e9.4.1761752458351;
        Wed, 29 Oct 2025 08:40:58 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952df5c9sm27006875f8f.41.2025.10.29.08.40.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 08:40:57 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 29 Oct 2025 16:40:38 +0100
Subject: [PATCH 1/9] dt-bindings: PCI: qcom,pcie-sa8775p: Add missing
 required power-domains
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-dt-bindings-pci-qcom-fixes-power-domains-v1-1-da7ac2c477f4@linaro.org>
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
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1024;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=1fAek205tjxe5bC3Mw7smKT9uC0qrrvPds/niowbYos=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpAjV/Iut8cp1XfNbhRIoY3aexq9lSuF4c5jd+x
 I9bX3XuJCGJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaQI1fwAKCRDBN2bmhouD
 1xQRD/4+KZKX1yXtfRZEoycIML7iGf1wlGzXfWH060lHIz2rl4M/3KKUZDryHgUHsa5fzCHMEG0
 LPCBboueBK/V7tE9y2Pp/nY192zBi5D8FGPDdZk4AHYANKSpmQxOPXD453OQ1PBS5sKIdpj7c0J
 gv72y503C0WCezI/clnVgsw+Lo3jcwK5VTJkh4/vrNEsbXBbCh9a3/+kqaBmMtdy7F1mjFT5BEz
 SwTNqR4o0CphLWMIfXpiK/r4GQ3VBSt9gRrdmB4+2sjzr7TQCDLIP76bJn5w7lqk+7r3Z1MyAeR
 /xn5pMMl6cdAK0C2ibeMoT+IwNRFBHydxNdx+I9fKe04/eMr5zNZgrk+5e29f1JxwiOZnnKCxUv
 TiyKpBEynjjkRrF+gMPJ/44Ea3gqDjHbhMxu+tNJINppTftREA1xbYYHIxCbABI8IxTGfLoBFBn
 G086SNOoajKZxD8WSARu33yEgyYP/rAbrS3nlAU7ecgYaRgefOqYutktAPB8YZZtk0g9NaMWf/d
 hC3KPgwobNMr/UW2H1OCwtdchyWfaD5LtF2NC9t2ljdNrzZl7ygAJiYUiBNB6ACc5SZXmNbr6wl
 0FBGWiA36q8aLiC3hz9Qkpa1n408/DEKDltO6ZCBci7XO1tPbApoWnJzoylMMbGDGc5kYSbiEXd
 lV09EDVLk1EdRdA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Commit 544e8f96efc0 ("dt-bindings: PCI: qcom,pcie-sa8775p: Move SA8775p
to dedicated schema") move the device schema to separate file, but it
missed a "if:not:...then:" clause in the original binding which was
requiring power-domains for this particular chip.

Fixes: 544e8f96efc0 ("dt-bindings: PCI: qcom,pcie-sa8775p: Move SA8775p to dedicated schema")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/pci/qcom,pcie-sa8775p.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-sa8775p.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-sa8775p.yaml
index 19afe2a03409..f3c54226a19d 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie-sa8775p.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-sa8775p.yaml
@@ -78,6 +78,7 @@ properties:
 required:
   - interconnects
   - interconnect-names
+  - power-domains
 
 allOf:
   - $ref: qcom,pcie-common.yaml#

-- 
2.48.1


