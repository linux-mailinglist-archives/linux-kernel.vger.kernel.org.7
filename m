Return-Path: <linux-kernel+bounces-877824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E596C1F280
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 09:58:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 752F819C2975
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 08:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8499B342144;
	Thu, 30 Oct 2025 08:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qxg9LkTi"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8F433F8C9
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 08:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761814275; cv=none; b=jeJCUZCN6MTgBTW1TgDXVsAPSQkOo7CjxA3vtDNustVSY38quYxcE9f6iYs2xSedVwpkG7AZlssK4f/oHRgLlWxDAXwvF5ogfPrst/w4xw/vINPupQpXGdrVN+i3pGB/hCVNSh10tMuND6AlsCl5/14Fl4ZujsMp+rSFpLOtqq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761814275; c=relaxed/simple;
	bh=4pGm/GG46vHLJGZFoG9Oyw8WYggRSTiaiD5DNxchMzw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gJ8AxyOrU5L6yWGD95bYbx2f7WEpchMg3dcgPFWw1H4AVLxthtvaW6/H1U2ZGrWZSq1Ry/dgbMkPb3YJAxMi1XS+x/LIGUspCnWh6DqOYmMhEGighyVUtP6+roPdgOrqmkr4NXkKgcyEU5o+DdowVNK5MRcx7sxaqVIEgi5moVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Qxg9LkTi; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b6d6027158eso16096266b.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 01:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761814271; x=1762419071; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MB8wr4Z46fipvIRWrp5R+KCN9mXNpfUi8ky4i/rQTXg=;
        b=Qxg9LkTiCjhi1VHNvuQyF+82u4KKXS+u/Nb60uhA9uiCGSg0u5vd5h+rhmhB8ixDdt
         8Jtguz4lmRIZzUFsXDKfDiUgh1bEkElQv5cNFFftVdJLKuhsZL2B6LPEQtjyjK46q+/Z
         I0H1cmdnkLeqAD3j6fP9lOF7Oyys3Na5gKZS5L6C0AvmFEd9V4Pzw16UeP0niPIuhuAV
         oCOPUlftPK0VK3PMbbOZOj0zdLDdTW/nNXd/OVL87JZ1gMYauaKEJ8rsBGT4wY6le6yI
         cAQ6mMDVKNpSCuVboMAqrK2Z9IsepL8w0LGZDS9x44iKScJe6kqZ83cUtMVuGCNQr9xS
         wlcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761814271; x=1762419071;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MB8wr4Z46fipvIRWrp5R+KCN9mXNpfUi8ky4i/rQTXg=;
        b=mmNLTOSlvQH0RckGL0Eb9ZoKNifIoh4Dp09pUitX6PN2Uw0kPDInAFd77cZH/Bb+aV
         IVZpjL7vpG6SHinQG7Sfei20cK8MifR5E31QCft9qK6+7FgAEsTiaERZSviTpK/vEFaA
         CaHzuktnXFjkjdz7zhV4FRn3hphbsspmd1/J8/Z3BwIF32dwb8CQ4AG/lTEzDvv4qab3
         uq0Upydl8854Z3SX5jMk4ggECmdzFAgr1dSKYfk9JdHOdY55r84jGYoN0SgViwGdh2Uw
         FLIT7zUjI6EdRKRtQQPblA92JAhmg+wYp3a9e1Esr1aH0e2/iNyMzZX0FO2LGp6ecVbf
         U51g==
X-Forwarded-Encrypted: i=1; AJvYcCX46Pd7eEgReLIinuhgS6Cz3nWqzGxVXM89cbSHI9K+6nCA3Izb6JCKZLZzRLE2D2a2EuBv0M7Vlq9lHQc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5I59zAeiNBKSSzp8bc1IZVdOOFBMORpVAavTnsOJZ/jPOztP4
	P2sc8su9GdpLPYO6BFqcBXVsADr4yqyfA2D8q1pDAIgZr4BlN0F5mYUHUitE5wXj3A8=
X-Gm-Gg: ASbGncsUUq/XJyFKq8d0CYK+wzWaEixKwedqiZFqhEBpRuF5rCeZ+qIKOf4ebtjDVkX
	yYOwTnoO/V/W8cNe5xCJktxgg7DyiR+81DbvKcbgofLcPhtzYJd2mSKoOtXRs7kOl7LSC1F+eT9
	pWiXUQcLneB9HGcOjRYfGJhnCGXiuCFCKkU12JXiXSTKfpnGIyfu6smExv5VDyLf8f3eBPtfCrq
	QiaDT+zF6O4gDYd+iCykwipktvEqLDeALIS+0Wxk9oC+FX+JhvYjtyM5LLNlwhW747rUwdRHvbd
	qm91k+0fDWR67yiH6nEdqWbnmJmEycZY/wZR2rkwki6aHoGNO45X9EGErrbNiBed49808VfG2Z5
	C/9MRqIQTYNStHwyYdhoeZRH3KDNFBzowrplKDnqUfBREJ7BkPyyRF7jnudAf9+RnEOMGir3nMn
	3JSiDRgur5s2q0x0w+
X-Google-Smtp-Source: AGHT+IEWvPX4pKMIN2tcv6fUOmne0vn4eS23qQK+t86LVfx9e8vdXXysoyxx7cpwZCeitbzhAe2Qeg==
X-Received: by 2002:a17:907:3f87:b0:b41:873d:e215 with SMTP id a640c23a62f3a-b703d2b2ce8mr290349266b.1.1761814271032;
        Thu, 30 Oct 2025 01:51:11 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d85ba3798sm1691789366b.39.2025.10.30.01.51.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 01:51:10 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 30 Oct 2025 09:50:48 +0100
Subject: [PATCH v2 5/9] dt-bindings: PCI: qcom,pcie-sm8250: Add missing
 required power-domains and resets
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251030-dt-bindings-pci-qcom-fixes-power-domains-v2-5-28c1f11599fe@linaro.org>
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
 bh=4pGm/GG46vHLJGZFoG9Oyw8WYggRSTiaiD5DNxchMzw=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpAybxfIhbtaeqrQNtMrV2jCyqpx0Ii2cFSN2gS
 I/ZVtkk18KJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaQMm8QAKCRDBN2bmhouD
 1yOaD/9qnpCE+oz4X9bDF2ucBepgDoKTO1BwXb99YJ1t2BZinsDqbM2fEGqzknWzoo9Pk4/x84C
 W8LyPjiDIc0jG2++/XJUIG9B1x94LgrZUDbDLNSNvw1uwA3l9bgPubCYuU2YtNso+8Ev21DNikR
 r1InFFmcNhzVoZTGy83nTa0a2pKCpBovygaGvDqY5jQtbIKbR77VT8TBHsAxzxyC1IMvwnY4J9L
 O0cdE1MSQbVlsgYGEDOq2hLWOkx4uXncN+xwRsDpqMc0Xtm3sn7jShAKhT0fXVEFJWZFHpicB48
 Ghy2OBudY6lB8TKsJiQI5OW0qx2wGq/vlV+xfhicMb9ozZXTAha3ugEPFfSLwZpy8G4ZDo+dCEs
 guU/R4GirzcGX/Y6OYoWtUrP65xvmH/vnIQb+KfvpG15sb2WleB0vgByTDiwINuX8XyVqipAd7n
 /nF89GWwRdh/Pqx80tMCCLzaZlpEBNEWSXx0+KEGR33kveZJ75vzCr82ImCxSrPAAdfXXVAKLSv
 eMv1kgJOiEa5OQujwlV+7A0+u0KTS+IsTZMRsIcSkWbGkyaxn8MOFUXW0LMl/eL/b8SF3p4Gesg
 U4X8ECt8Do9O+T7b3QQFkJCgmtjCMDIDyK1sBLnGj6Xkd+4+3t/bLjUaNm7O4QFzUZymBz3d8EK
 0i2rL9dNc81+U1Q==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Commit 4891b66185c1 ("dt-bindings: PCI: qcom,pcie-sm8250: Move SM8250 to
dedicated schema") move the device schema to separate file, but it
missed a "if:not:...then:" clause in the original binding which was
requiring power-domains and resets for this particular chip.

Cc: <stable@vger.kernel.org>
Fixes: 4891b66185c1 ("dt-bindings: PCI: qcom,pcie-sm8250: Move SM8250 to dedicated schema")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/pci/qcom,pcie-sm8250.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-sm8250.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-sm8250.yaml
index af4dae68d508..591f1a1eddde 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie-sm8250.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-sm8250.yaml
@@ -83,6 +83,11 @@ properties:
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


