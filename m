Return-Path: <linux-kernel+bounces-877828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B21CC1F1EC
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 09:54:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D28433450C9
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 08:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6669C33B961;
	Thu, 30 Oct 2025 08:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cPIkGlWi"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CFB8341AC0
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 08:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761814282; cv=none; b=hGt38bnBzcPA0o7KShbdxEdq9dr7Jo5STfbJ6gU3pBIxhrKLjh7OdzNBDnH0LqJ5q/EpALbya9dH86VdSsEeXuqdqjI3bCuGd32+wwr5DaT7Doi6zdVk8onWfaM9NywEOJa9Y4P9vNV3xrF0n4QnKegO9UMOdpAUvOZIlhkK6Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761814282; c=relaxed/simple;
	bh=tOFcZ+EoVU36Gcas8ByUgbu9yWXwAq4SdMIRPuEe4Hw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Sl8FFNiZlkjlywYzTB1vDPCoQP20i0gv2Ezej3ga3UYMFJYNegJwuacftuXH6mCJYvocWL6L0BpEN9dYvs7nAclGbPvrnKhokvfMX6zJdzcDjvV0yhu0/Tdpn2OnUmfgmU6zbUv1o8RmJsez2ojL/2A4y5hMLeHcZMwRu7ZcFDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cPIkGlWi; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b6d4e877915so11197266b.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 01:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761814276; x=1762419076; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dyElttd76tnImw2rKaTu1EJufTIHlBuUN2ebZk19A2A=;
        b=cPIkGlWiSTS1/VqEYMoYSjKQfquhSglZBwF7gLOA7bC1NPWjitE/G+llnML65KsspP
         Cnzbdn6BIkJZRIt1co3jvHW74XGWoeTzYPVxn21qUyMScMcjR/J59L9RUZJOtf5umskU
         5Fl+l7tckf8wzE2010yAlNh+DMsLgeptATmNz+Y9gN8TdKDK7f8Ji12Dema3ohiZIOlI
         5KIMw8p+NcT2Qd+HrAeJk2xIcSLlfad7NGWgoDdkrhFJ3S6MdTPNo2CZ9vaJH6AQ0SIe
         P5N642L6/iPRCtNG51pNcK9rjYOulop8gHJ5nlL4CzSQABJrEHyc0rrV91g7VMLlak8p
         56BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761814276; x=1762419076;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dyElttd76tnImw2rKaTu1EJufTIHlBuUN2ebZk19A2A=;
        b=Wdh1VKAUJLUZP9QZgEoQPh17ffhv4V62zMeoXjZdLiDzyPzI5MNKOUssYtLG7qUEQE
         1Txh6cRMb9E2VV12NyI9mn3TbacR4CNIeXCzHGjrNJGAJBbDRjLCVOuPEJBPiz28CEea
         5fIulcC/W8O6aL0tUaUTWuw/NCZnvG0CGEtYd5s3cAUtXpAOD6UqXL2f/zfpCBdayWpY
         DPbMnB9gTCyrVvqGlBRhUfBcZOK9AgkN4oUMWLkpWZcBNwrlA7mE4DQYkM8nn37RH+0v
         tVDkmvNUs2/VrW40qiBg63JtWGqNaDjvs8OHYVO9rOCeI6ktZ+vYuLHyke9FGeR0w3pe
         c2lg==
X-Forwarded-Encrypted: i=1; AJvYcCXVYj65n11Z4PR11GuMK+Z/4D26R2B4hAzWZFi8239yvyGzv8cr79aTopWNS4GRgbVL6UfEMP5VcAzV+tw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYi0qPw3Dq8wcJ+AzSdQn6j/haSXRPgf5x07ChHnBZrcMXY1hs
	nnztUNoPA1jeNI5JrdL1RtpqIPofMJfzvX9v8fJLiHj46nB3AgDBTxPLrMJtXAvhBUT4bMdNZSa
	1YyvU
X-Gm-Gg: ASbGnctps2X3Noo4EeatZstG5O9IAlAfBIZOrb4WveAJ8q52VEwhkie5yoxsrmY/OcD
	rQoGez4opf23fQisRXUMJRQIUfC+QffocgQRmODeGAJMSAV/ptd1cbxWP46SvsyggFGjHQq+LxA
	PkTMUfflXtX5qN1pg44hMp5Wd9I952NUw3Khf8gR3gJmQ1pNCrccUAnKxTe9hTJxJdN4OG2pQzx
	XHx5GPGL0NqcS1Fk5TDTHLuSKHCrQgz/SuACj+K0xrSHfO8yDeyBkB8xVUw38PsiAVBnpphCqSB
	3Ar8ixbXaIRuyWhy8g60sxf3mrdlWoS/CdBdHnQUiDrQt/yLe2dN4CmCu3gZLGB3fqu+kciIQXX
	Bx1i+RxAwH3UNCHvSzhaIrGZYbFPRnB87VDAYOtigZv1YtMpI4B8W2IPsVc1ZuOuu3fjL8tjwu8
	NilyeSjQPPyB0D8NrI
X-Google-Smtp-Source: AGHT+IFQVdw8/tPXlVf5rqd+6iy/3RoBW5tavJDgwS71+TwJTiu7nX0lLlocIq3NyDrw50g8MOfctQ==
X-Received: by 2002:a17:907:d88:b0:b38:7f08:8478 with SMTP id a640c23a62f3a-b703d06512fmr354167266b.0.1761814276487;
        Thu, 30 Oct 2025 01:51:16 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d85ba3798sm1691789366b.39.2025.10.30.01.51.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 01:51:16 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 30 Oct 2025 09:50:52 +0100
Subject: [PATCH v2 9/9] dt-bindings: PCI: qcom,pcie-x1e80100: Add missing
 required power-domains and resets
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251030-dt-bindings-pci-qcom-fixes-power-domains-v2-9-28c1f11599fe@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=941;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=tOFcZ+EoVU36Gcas8ByUgbu9yWXwAq4SdMIRPuEe4Hw=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpAyb1rCWm0in41RGHAdfE4Lvka2FoeFs/clIRk
 ZoaP88Ig9uJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaQMm9QAKCRDBN2bmhouD
 1x4pEACVJrEw54/5DQoRujMfwdvo23l7nZ6vMLdhg1RXGPqYk+73XH+lCnIRfHgpNEJqgRZ0mbY
 I5e5+Xq9n8s7veUbg3QrpRrUU3xiK3u3s8jJsu7ftW15VfiK/P9ZMITmOd0Xlc6Be22uWadVLZf
 JFPwNNZO1AjNx5i8bEw+qIlTE0qk1hxFg6Pmd9DAIma/MuyCD4zPjI3Sy0aBT28j3SgHBJHNsrN
 +LztllD/ZpueKn221+PPIeCh/saDbqYcMvqjBBUHuoC0K5p17FT23LmsoEeBn50/krzGN72+gfM
 n0XzHYRrlhNXoYdFr6nCLzd6kRkBPXz8QEI/kX268mzmxShzvru5VbxhSAPuhv6v4lmTbWXKHdC
 DWW0eicXLN6JJXEa2CMJgc/ht0WLmWA35/LS9ntgICyTePgMuc3TUVWH0+BeRfzS8VxreXWCWSv
 FLr0hnpuLghg2O814EtOUv0pPIL0+5GNgLaDiCLsmY7nwSepKF6frj4N7I39dbQVCeEqgkt+f9a
 x+tOrJesH3stJtOYT+XV83vpW4FGHdCqsgaWFG8RWj5QfNYkS/kZdorC+DRwLOoOEq60RJo3YYG
 xLMdrPsZTToeWPl69nLxP3/vzUQ++yV2EV5MbISbVY797NVnErl6f39LCnMVI+GrVJFEp9qXI29
 P+q9qVJGbBVpkkg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Power domains and resets should be required for PCI, so the proper SoC
supplies are turned on.

Fixes: 692eadd51698 ("dt-bindings: PCI: qcom: Document the X1E80100 PCIe Controller")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/pci/qcom,pcie-x1e80100.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-x1e80100.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-x1e80100.yaml
index 61581ffbfb24..83e35543b233 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie-x1e80100.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-x1e80100.yaml
@@ -73,6 +73,11 @@ properties:
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


