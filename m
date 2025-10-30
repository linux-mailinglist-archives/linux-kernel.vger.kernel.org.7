Return-Path: <linux-kernel+bounces-877821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86EA0C1F25D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 09:57:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B8C71895CC6
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 08:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A90C33F362;
	Thu, 30 Oct 2025 08:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IPN2B2RW"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7590D338936
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 08:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761814270; cv=none; b=Nm39skKC30DbaXCdfDPv22vMzs0ILRdu0sP008xiT21u0T9++JdLi6IcYi0IXe26lcdkXNTq0MO3G4zJLiPBkoSc+/hC3oNMpzU6alTu748CRXqFNlx5a1GlcD0H/O+BVQNkbhR9RHom8TN2wzuG1xTq6S3yyzWqJg0dhZq982s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761814270; c=relaxed/simple;
	bh=rpjdsC8YDAR4ce9DkX3G6WOQjqex1hTpcjV1pmb+6FQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BySr4IMdwE5CS2sj2RPHxZ2OeK5M8QFXEKhqEUn/BgcvYo34wX7g+560zmpmU0GF6vgbGAaIF0fJLSUA1C4eCr3OULePr7t6Wbs3XW4quFQIBqtAvtiAUGxjsqO8zFA4Sp5jecjzN4I1Gm3MTNkc0k5wkiYZ7ot35PMP6by3inM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IPN2B2RW; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b6d676a512eso13249666b.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 01:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761814267; x=1762419067; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HeZHkr4YD9H0TDPFAU8SBi/+IlGQLxtOdn7QyZP9pFg=;
        b=IPN2B2RWR1Du4Ggu02p+DhAOnm6HVqJo9XvTxmsFlRsCNJ0HrZMDsajeQ64I6KbkLC
         I9hFjp6sJ0axUhP/DYYt3xwQB0njuQ561eKeYVvKAK0S0hKgy/4Pejbneu7ZzZGw8s4s
         ahlJfJu4hWe3iHODptBoWNJN4XF9Sar2g7rosjLdZQg6LB+RBF/FpWlRYFHgtqr6b94e
         KKHgXQ6frtKmOtk19toapMyF7i7kMMccqc8FYn4HSVzV/HNJXRMQRcvXbIMTmZT3J2Lk
         0zc2W4DEBeP7yB5PHZXiWAvt3Gd+DaDsJQVQUtfvrKFAfDX7+rNo9nU1k/QNV/8S59MC
         rp2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761814267; x=1762419067;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HeZHkr4YD9H0TDPFAU8SBi/+IlGQLxtOdn7QyZP9pFg=;
        b=CSgW/IW8M6JzVAfTIuUGA1uzFbGZQkZ6K93vigdhAG8tIpBJmW1I8Wyv4t/gQzCY0E
         rVDXeLo/nxuNy19hvX0wnXE4emcWeIz+zyxrDe8npJsN26PK6Wsu+RLaQCY6Kt9/gDNA
         yDKVkDk1yuqdKmnA3g564rNaALx3e1F6+2+LWqQtZEuexj5gRvGkXjK2Ytnuoj1+jYXV
         3lXONSCHbQf0KFA1t1yXVrTAp8yZ+zdypSSCvtQoyYTcvimzC7mEyReKrQ29vDa17uiH
         Fn+vtxiVADvYsG/Dm5yL6W8NZvfuZ/W3CvPEgK72Mu0g+uvFUAmmSknu3Iyk/8pZZ18+
         C6Tw==
X-Forwarded-Encrypted: i=1; AJvYcCU+16NbV61zBfI2mtDNKBxGyMFbjNa75YBUiTDYtlL+1e7/b3P51WO7TT6YsWXZkJza1lajekKSpPNbhKQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YykhG7cQmvXdwHc+dKWFIz4kOpjPQdwtrwBjKhVgGZbBagCj9eK
	CKf5Sp9T9RqZnckWebdgtwwNhhLKbaWea04HEmkDE/bJ4HpgtDPROxzCG3uxzoTRByE=
X-Gm-Gg: ASbGncsXDdlwalyHUxzxTVCCeRVJYp4O45qBklwXORcT7BZeuzChdoMXv5cGguvwoB3
	6aekzlv8JlUxBmPLfketEjepsLSXCpFY9fV5DrFAjt7Gs2igBwLLv3P6cLCyY4pXV4Ohfv/tanq
	n8y0GWOIHElTAaoJvWHqRXiPAc713U3VrFjw4Qqwg+si2U3eagNtRRsJoat/7flk21Ap4WtAPnU
	pUV8XJ/pebGttLwALA7/ZxrBo6/GzdXXjnTYqYi1Ay2T9zIblUo2T5EHu3ria5JkcN3G8XVP9ui
	4Ls4Rw4ihgUJkPj8fP4ZtWtYZ0cWKeHFuSKZuxsuwLxLgT6KHVS+xRviTrmoSzQRzpTS8ahONCG
	taf0QZkEVO002WfgpQN4R1u7V1LooLGr1ZoCyMb79azq/1BsLO6PtmGtngPGiPAigRYOvLqX6lq
	qvshz/TAS6alBG8OOZ
X-Google-Smtp-Source: AGHT+IGa2ZrCMJ941md/YaGSeVQ3cz4WZFg2TaBoGEFTfFX7GrykK6ynC7BBGxsj4Kqgr42s5r1Irg==
X-Received: by 2002:a17:907:7255:b0:b46:b8a9:ea6 with SMTP id a640c23a62f3a-b703d568818mr370592666b.9.1761814266546;
        Thu, 30 Oct 2025 01:51:06 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d85ba3798sm1691789366b.39.2025.10.30.01.51.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 01:51:06 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 30 Oct 2025 09:50:45 +0100
Subject: [PATCH v2 2/9] dt-bindings: PCI: qcom,pcie-sc7280: Add missing
 required power-domains and resets
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251030-dt-bindings-pci-qcom-fixes-power-domains-v2-2-28c1f11599fe@linaro.org>
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
 bh=rpjdsC8YDAR4ce9DkX3G6WOQjqex1hTpcjV1pmb+6FQ=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpAybvXntta9FsaICcpfmprRUQ8u2uaIde10GCc
 2STDIF0KwmJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaQMm7wAKCRDBN2bmhouD
 1xNYD/46QXqnYkaIGSMZZXc3CCIa5r8QA8x6uVCG8deex5AnM0Cv6cpu8/OLgT6PqgPjYdUpLIx
 j8LQodj1MeEEMOjmqZrIfAVq9/onEuPEfSGZMni7Ltf8uw82Wt4rqF11IHXiBg7hScSAop2VXIp
 8Tp8+8vacfoDLLdJ1iXu2dgZo/tjQW1IECcIBUSMd0lNsuH9TEnqrazOk/ZikVV5tOtnbVMdIwJ
 AM4rxtHheqEnH4Z1cXc8f5aivkuMOQ8JKwHvAMTOkh/QBoTiAV89LbkHyhZcPOvpwgAc08tA6L3
 MZxYoI2SEfhrJcX9ZfrElJxXpGeAavzw64nZji8uKYJAZm+4gZ7SpFjC1FsNhR+Hm2l1zausrYd
 MZmkPsRYjm7DfDGKa0/7rHhgcf9yemb5G0aQNd6ILASUDyeKWye/Te1/dGdVpJS0qx3gNuog5Er
 rtpsjVLum+hMgKJEL/rJTDsYLQWXjSwEtNlDbvVTSK/OOAkK5BP933vqZ34xFOz+xgcD5MNy+88
 wcnRGFsM1cT8lcFeDAbUPBG9FLGqKeg8nSo0vMMlD5jD+XTdiSISPeDcLUpCv8mVA6jhYyFuQOT
 9s38CAF9I04uf0KUzEUttomHR/5dJmu0X5GZN4iSZVTPfOYIjakMCgzsjJzsF395tQ50w9IMUmD
 u0VKS/Tz9oi7ViA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Commit 756485bfbb85 ("dt-bindings: PCI: qcom,pcie-sc7280: Move SC7280 to
dedicated schema") move the device schema to separate file, but it
missed a "if:not:...then:" clause in the original binding which was
requiring power-domains and resets for this particular chip.

Cc: <stable@vger.kernel.org>
Fixes: 756485bfbb85 ("dt-bindings: PCI: qcom,pcie-sc7280: Move SC7280 to dedicated schema")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/pci/qcom,pcie-sc7280.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-sc7280.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-sc7280.yaml
index 4d0a91556603..f760807b5feb 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie-sc7280.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-sc7280.yaml
@@ -76,6 +76,11 @@ properties:
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


