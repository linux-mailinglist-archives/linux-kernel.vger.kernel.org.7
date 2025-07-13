Return-Path: <linux-kernel+bounces-728957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0883CB02F9A
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 10:09:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62737188C6A3
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 08:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 640CA21CA1F;
	Sun, 13 Jul 2025 08:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="rhCmBe63"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5AD1F9406
	for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 08:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752394049; cv=none; b=gJ3Sj5PLsBB9ZdMw1td54H8akxilcTO8mhfcAaHE59dMeb2kfnFVACJHZpWrWHRss+ODm0lMuAk7qDbMO1TCWGt0183ekgn54Y9mUFkKMdjCr/Lnm8RaRp9e/gbDrScmaSof8vP42FUuUiYFDIWJDY7UuK+B3QQAIAy/iLC+ags=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752394049; c=relaxed/simple;
	bh=cmEjmUIEwJdszNuha6SGlHW2o0fXW5xz6+LSWPvZsgg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NSuAkQPPGGBEHDEdT/YABzilPwghztrTLlZMiczP+oeX9+ZEtisECXimB80fVin+VcAl7iNMsKMzixaR4906hI3BFeQMqEMV65saqgCvqG84P1jfpUxk1NeEsMX8VUXIpy6H4pZCkX7Yu1iCgpO/Jl6EF0mzCYdTEJeDF90r1T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=rhCmBe63; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-45610582d07so3280125e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 01:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1752394046; x=1752998846; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HAOuh0e5PjdM5Thiks9XcjQnZt1mrG00zqw/b7U8tlE=;
        b=rhCmBe63rQcKHBXGf5EHrUzC/Dzyy9df2hTQQco/McWi33I6jERrxoswYpCVq2pMTC
         ioz623171BTrfBfPuxeDTQ4qfIaJdwe4lsh9T3T8rmCQABJNUXM3h4bKudmxtnUNDgpO
         ndepDwaMbhlRVJ3HuGgYVhkv2a9qjK6AlTyayqWKELm9gL+Yc2jI+9K4VuEZesA06kIy
         wtKhOFDARDhqQeRqWcq1QTBiwYrDM4bGd7RAfNUIvPKMg9jEc+IvNuQGsvDx4tZmSYA8
         olHDRBckQIXEE8VOzPFrg/jYLWJgIRNERXYePXJfRdocIWgm02CD66ZYZzyBEbDOFZNG
         5ULA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752394046; x=1752998846;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HAOuh0e5PjdM5Thiks9XcjQnZt1mrG00zqw/b7U8tlE=;
        b=QkPzSQtLiMgqQhPsvBCwCNFdV2t/ncU06shzWnZoaZBXgFYkE8ykChG85fLETcM4XV
         X2F8rZNw90UDhiLevynoKB2yk/BxuP1ouTtT7kT5iBZbs6y7GgMDoKE7wojT5FdxCcOD
         eqar0mgbO0h0AaqtsJKNElf36tjV0lPdkw4Jb9wD207WfjU7Qbo+KW4i8f4mYt8JSHbX
         riW3dlD8EuKacsvjK0bUwcxMuS4h/PunJeP0rVIhzypTmnLnBYESKoixMYEtEorkwrH9
         iOBg+zsR4iVpUGKeMLVnARXjZL+yUjEg4JR9J3Oi62ZwzX09zx3QQ9QcPydnJgT6Gala
         KfDw==
X-Forwarded-Encrypted: i=1; AJvYcCX5RlMR0wYauxJn/t5QuQaF3fyTh/MLiBSO0mO6QlfN9omwiVpnGSuJ0snI68fCKxhMCqzEuId2/q72yKg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBsmGupM+4FQct9e9puPJ28e2vi1dhi7pNJ/s5+pnXkrMAjWA1
	Ws7l7MzC4Wcm/34G77rcAmsL/gVhHeb7zypA4wIre4RQpX2/0/isThmhIsQ4iH0Nz3E=
X-Gm-Gg: ASbGncumoO9q8vU7Lr8A7q2+ilnb5XXCUn3OZYb9aP67D0jhpIg7jj7TFs50KJdKCaj
	cwUOjY3vdTxPhMGVsVdxDM0NSiBBSCWWJqNuYA9dIF7lEUeUPTfXFmjdtgwXoVH8bSj6gH56Jbo
	szqQrJjnHg8FfIgw0CQrd+Z+8eKTmbEoE3pAtVZcRsy7SdMPN+AgXKbW3nkUx8mYlJIYPynPbxa
	vBPRom8EZO9pHQvCxFGcFaXzykumDa3L0pKyUSNCrXfpWj3QG1UVpcVk3ShJsd6nUnZaeZ/n5na
	Ja7K7Nuibp1LPl69k1QaTR9o91KxWNpkR/9VZfCpapoB/AxaXa9jJegaZJX/E/XqdZ93b8TqyuC
	G4VKYOFFet9TxDe4pSmHej3+aqhHFYovBMcxb
X-Google-Smtp-Source: AGHT+IHNat+zEG/luHBNIINd5V8v6XlcBVNxebQV2Q9VeRLv4kxzRp8ULT+stMytttEuuhYWEbWuVw==
X-Received: by 2002:a05:6000:2086:b0:3a5:67d5:a400 with SMTP id ffacd0b85a97d-3b5f18b3eaemr8361545f8f.33.1752394046075;
        Sun, 13 Jul 2025 01:07:26 -0700 (PDT)
Received: from [192.168.224.50] ([213.208.155.167])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8dc22a8sm9386608f8f.34.2025.07.13.01.07.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jul 2025 01:07:25 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Sun, 13 Jul 2025 10:05:31 +0200
Subject: [PATCH v2 09/15] dt-bindings: dma: qcom,gpi: document the Milos
 GPI DMA Engine
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250713-sm7635-fp6-initial-v2-9-e8f9a789505b@fairphone.com>
References: <20250713-sm7635-fp6-initial-v2-0-e8f9a789505b@fairphone.com>
In-Reply-To: <20250713-sm7635-fp6-initial-v2-0-e8f9a789505b@fairphone.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Herbert Xu <herbert@gondor.apana.org.au>, 
 "David S. Miller" <davem@davemloft.net>, Vinod Koul <vkoul@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Robert Marko <robimarko@gmail.com>, 
 Das Srinagesh <quic_gurus@quicinc.com>, 
 Thomas Gleixner <tglx@linutronix.de>, Jassi Brar <jassisinghbrar@gmail.com>, 
 Amit Kucheria <amitk@kernel.org>, Thara Gopinath <thara.gopinath@gmail.com>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-crypto@vger.kernel.org, dmaengine@vger.kernel.org, 
 linux-mmc@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752393945; l=809;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=cmEjmUIEwJdszNuha6SGlHW2o0fXW5xz6+LSWPvZsgg=;
 b=PdARDzzFMZy7Ut6DdJtISA7htSoj0AT2jFnSpJ6mCPR7xKdPfXUdr9NJCuHBaBjbgQNs+Hcav
 9Qi/8P7T+qNBz/thYmFy0Bn74Jp3O9N12GTa6rI4xDYY/rk8g6EpebR
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Document the GPI DMA Engine on the Milos SoC.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 Documentation/devicetree/bindings/dma/qcom,gpi.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/dma/qcom,gpi.yaml b/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
index 7052468b15c87430bb98fd10bc972cbe6307a866..1655f21a4f64c588851c48381a18965c946e2df0 100644
--- a/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
+++ b/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
@@ -24,6 +24,7 @@ properties:
           - qcom,sm6350-gpi-dma
       - items:
           - enum:
+              - qcom,milos-gpi-dma
               - qcom,qcm2290-gpi-dma
               - qcom,qcs8300-gpi-dma
               - qcom,qdu1000-gpi-dma

-- 
2.50.1


