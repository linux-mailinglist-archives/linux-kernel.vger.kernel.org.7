Return-Path: <linux-kernel+bounces-876558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F3EC1BBDF
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 16:43:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDD30189CCDE
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 15:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA44C34CFD9;
	Wed, 29 Oct 2025 15:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PAF42/R9"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310E83451CD
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 15:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761752476; cv=none; b=NLu1t4r5EBZkNbuqwmTEvEobhadm8Gji4JqF5FLxRm/ZZJQEidBkmdn1kRFB2l+Z9Myyzl6YCUHB/KN/9Wf4ZdGCwHJUPrskLg1Y7TSxNc/hHIGipJ8N61Rd3ghvUuN9Aoj/RThv6NPayiQalmAsl6fk6s3bVoOzUdKp8SpaAvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761752476; c=relaxed/simple;
	bh=E7zm8LMUS4vFyvqJmFvBbABlKzv6uaKHgJ+Ct/P6Zvw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HvvU7NXeJxhRxaJivp0LxNShrBPNV67E3HQAvgC9yPl8yMuU4TYKE5YLegMwg7NjkrZFeLvxgbJfZYwYSnT2JUlF6vUXuPvE7XraUqx0kUT6RJ8PH7vUbxrx50ql6WWQJ3chD2qyOhUdkQ47ekw757vHoWCb8mwnIQq9dmfP+p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PAF42/R9; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4769bb77eb9so3107515e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 08:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761752471; x=1762357271; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZQYPWoWkhW3jZedodS9/BAUyUvxIUEKkb3KJ3ANSZ4o=;
        b=PAF42/R9ufiKOeI95Zbn8T8wQALcQ85nEBGTd8GxeOv/YuiYAtW1/lESqCy9G7f91l
         QTWSA9ELgzTsR88wrES8wBwughqy8Twh53CebPNhkl9oSled2L+UQxEMLIXqCivjN475
         u7DvjuUhlT8+aoF5c4JN/+yleozA0q0j1DXB+LAacpMcmWSzI7DlGM+xu0+Jw4ibpDG7
         zZe4GJg/UCDGA5PMDELrd4+H/OZ/qJG4MNIHr59DfnzXuNRCHt5p/fMgQC+/d0ft1uj8
         ILs7dyXq4ns3wBgKEtNqpOUyAm0xAb/J2k6g8L27/NQrdM9u8RR5UtUenctw/satIfP6
         gpEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761752471; x=1762357271;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZQYPWoWkhW3jZedodS9/BAUyUvxIUEKkb3KJ3ANSZ4o=;
        b=d3/ORChxP72riVhybJ7VkkBtTVtwNICLPLuNKOOwUUNFAlwx+RdamgDXDbMBEfjRT6
         OXTePrO0ODK4ExpEXWPg1uBzVMIasOXT96/cZOCOD7QiX/r2aMfUvbN3U/pq/WxKP6uf
         b8Z6Y9YUEwWHuBWN0b6Q7l3GdCL543aHgwKls+MUQ0it4TVd8plCk8by/Fv0QP7yt6ph
         AO0HllGO6iyLWtp67Dv24vg6V7+M0o74TKzz+eXu3fTbN/DOnOHDqaxdgo5/JuveOmkf
         g/zJg9ZVOCEGbfYaG9ryJJX3dmWckUHYCCsNhTWddwM/2I/ehsWxkKdYOYhPfiRsQlU7
         NiaQ==
X-Forwarded-Encrypted: i=1; AJvYcCWPC/I/8nChiXRJ4pnM8MDWRfvChNkjtTRrdmf5rqsZLYMI1tYZ009y9LTvC7iLhVoMOu0ZczAHrRNeKhc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOPeFOhcNVWtzBnGdtK5wVcDuFS8tiF6DYSTPW0YZI1pXW0wK/
	ydKnqPNqpvlClC8Zqx+U3Zmu5GQyjSUcdzLm/pRmBQdB+EUy1Fens+j6UE3y+HZlkbU=
X-Gm-Gg: ASbGncvXhmRjs5Gh7gebJvwu/XAkb7xifNzUV0oL65SujUT6NNHS7Bgf4g1nMFhaM8f
	v4mku6E8D9ariVLv0eE3DBDJ/wpRC4n8ysckHmtjI5Lz8nO9McdXQbqzMboTrkaZdZn0FsAbpxs
	TrYuxLZVLzABAeXN7QcyqMQ+4LjyQVfwKqVm9vtUPnUqV00EMVlXoEY+/Osi14FJpkBv7dZCLN5
	wWBe3EQwdH74KhKEjg3HHy1IFiYasPV+5FGEej0VbJREixiLaGjeGqPm1pZKV5pAqJ84D2ShWSx
	eJzXTc4YcQMVJ8sx4HONTx66pJejVtZYnmIK8B0WIP6fSmRbRjrPF7mRBxQgHL6MQvX73jJJaXR
	iNvoOxJR2aCXVsm9G/0L4sqeSqlRNVIvdfV6EUfKhlzN8B0SuRIf0wvzz3FyqXQvjsG1qGYZBop
	YB01mpNoHxa3npE9xh
X-Google-Smtp-Source: AGHT+IGxW3odD9bKs2JH0UPH/rsbekE2UxHroNcnfod1SMd4HhITjZ3xfahpFYg85ZGnnq00ntsjJg==
X-Received: by 2002:a05:600c:5251:b0:471:161b:4244 with SMTP id 5b1f17b1804b1-4771e1e3c66mr18069325e9.5.1761752470575;
        Wed, 29 Oct 2025 08:41:10 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952df5c9sm27006875f8f.41.2025.10.29.08.41.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 08:41:09 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 29 Oct 2025 16:40:46 +0100
Subject: [PATCH 9/9] dt-bindings: PCI: qcom,pcie-x1e80100: Add missing
 required power-domains
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-dt-bindings-pci-qcom-fixes-power-domains-v1-9-da7ac2c477f4@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=926;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=E7zm8LMUS4vFyvqJmFvBbABlKzv6uaKHgJ+Ct/P6Zvw=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpAjWGxi8GSE6oS/W3aIZpLT+jPqgq6MLYpuwko
 bOSOWzIEpyJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaQI1hgAKCRDBN2bmhouD
 1xfED/4luD7q1dM8zsxzQlOn4BPacWjc9sRfxc1vkX8XrU1KLXlgOkbYi39rm8cRf1A0ksFa/jy
 Cu7YB5cbq1iRttjeW+osqs6tLSTm9Ut6IT86VQelkVbXzpHuZ0F1qEFIoTXG53W6MQQdBmehr5q
 qg3USdiGZlRfMRGnZGd3OJfCmCBvQxktzWnbm2Cn9qMfArW+MZjZaM+2FlVQdipnBJSYotgNJQv
 v0WfEaLhG140GruTHcj6+pSVdIN/ylBdbRKOvgOYuc9pU7BKloIOJE/vdqtQZfBOPt5ZR8zBm+1
 lTT5TKqhTMz4+7ODUq3XR4zU6qjvoKroDMFe66zTTZL45MdCYlFpoC2bGqP8qYh60QozMlVva4s
 Tq0porbp+9MOtqmaJES+NlviYPtTUwz2MBogc6Ec4/qlSrbUcHRdT25iSEZiKG60pR5xpaKKnSq
 rk3ZySauG+AIlGW1wqNj2alpCGJieKGEiPKdgc8TLnRy3uO16zen9O7PshAy4+LLCrvTWFXs7k1
 7sYJpgCcM9w7Wv9TpLDq7qj73yAcLRgd1AxHN+bcza4eD6JyihG31/vVplDMxCCudXMWioja9J0
 CfIM5nNMKu2X8O1BD8NrMu7S4iXibNTNdyxZqnT3hOh/nNb+JlxUZLEGDOlV2I+T+JbSNXM5L8d
 U2JCB2/Khir2LxQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Power domains should be required for PCI, so the proper SoC supplies are
turned on.

Cc: <stable@vger.kernel.org>
Fixes: 692eadd51698 ("dt-bindings: PCI: qcom: Document the X1E80100 PCIe Controller")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/pci/qcom,pcie-x1e80100.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-x1e80100.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-x1e80100.yaml
index 61581ffbfb24..277337c51b49 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie-x1e80100.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-x1e80100.yaml
@@ -73,6 +73,9 @@ properties:
       - const: pci # PCIe core reset
       - const: link_down # PCIe link down reset
 
+required:
+  - power-domains
+
 allOf:
   - $ref: qcom,pcie-common.yaml#
 

-- 
2.48.1


