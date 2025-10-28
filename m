Return-Path: <linux-kernel+bounces-873771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A6814C14AB9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 13:40:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E6821AA324E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 12:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E452232E728;
	Tue, 28 Oct 2025 12:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z0IqJFet"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AFE12DAFD2
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 12:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761655109; cv=none; b=IqsXscVHcmfMJIvI6voxYvlHpVuFXadIVeN2H8A5qWBkoe2qV6iFV0XBea3YjmhIRnN64bloqVP/cY4TrYgBk3KgHaSQtT4fIXQRVgOzvDXrCucfZZmkf68DfhRLuXWbAeWKJF56thP1NqDIKNb/KzHWQAaq6cL3FfYjZzL5tHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761655109; c=relaxed/simple;
	bh=Mf8h+h03L2bzW9mDWJu5js5WAT5mXmT3aoXz60/jCXA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=LPiHHdgTWuzF4vufc80d9jjul3adP3CjxPvLn+pJJJ5tfmHjMUubE5drFWkPAy37GpjuxTumf8QHhuXX+x0VakUaqmrE+w1Gxk9wu66UtW85EhkK2Ml9AIin61qNc3JwqlZCDsF4PdJlXkSmUrqBPt0vD/QcblOdP7fMyESGrTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Z0IqJFet; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-47719ad0c7dso7039705e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 05:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761655105; x=1762259905; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+HQWTTzmS8TT5Tb3R6tEELAasWZz7XbENUTZplMJ86A=;
        b=Z0IqJFetPGGFPuwImtjEtxkeTZPhmVRBtAq9cVoxxsQhess3dVoIVNhcH6inPJlZMJ
         5nwjjzCB2xsf0K3EUNq3cX314YgiuwFnIpW87Kt+m9bMzXIlVvF6KRVzSUpfmHYfZLzN
         bTJDudOANt5w/Yc8QeBznKjbpP4OC1OUbtIzLuLJn+h1ryoD6WlRz+GPdr+bzb/xLfHa
         A5jXDvzAzJ1Z/quBT80vX0ylv4njbEPPWMTqkOS0TvTEsuBfmeSEf2KMTthrFkw3543x
         ZVkb8bp7/GJnROnPqMvmsbGLTrhYYIEsHhjJJwlnGNNTcQqSJd8soDBZe/KqCdDCSmB8
         MKWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761655105; x=1762259905;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+HQWTTzmS8TT5Tb3R6tEELAasWZz7XbENUTZplMJ86A=;
        b=BiNa12Re2talXH6TXmP7Zoi/ugacp9HabY7CmVG8ePHRYSXZjtACua6eX//5FJhH//
         06VMD6+ZBsWYzTwtf0LYW2TiKhXx66ihtAlkpfD2WO+HcFhkvf6c5alf06RNOqA2QISh
         qKAZDbtTbb5tWeR1bNZdR7b+H/DuYMtMqu7FKlrWvqmD5d++hFXYJPh7vtTKlmdBJ5jp
         PFvtV7ZcqzMl9ixAlJyJFqKoqNUHAvDl4nbnlyMbxpSkVMAhxtek4tR6XVE2uyJvFt+b
         a64ejOgQd6+kW0RIb3Ba/fA1bxaGv/KdMiIa4NRVuGj3N/z9O+tNWJJ7dayLQOTqWPko
         lQ8w==
X-Forwarded-Encrypted: i=1; AJvYcCXv+D7P1arzsFdN//OD++bWoivzI4UT2iGd2lC4KxJg/+AsU+e/heGRCrrJXKLr8c0IXduVB10sDv4CEZg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzViWt8n/xrAyM4gOjKZnY7seBvcNTwt4ajPB06TQ9HM8mbK13
	2wyOn2TSGeqEJc+T1dYapzku5buUyQRlIp4LVzbZWxmL44QvArMdabDy69FCC3jhyz4=
X-Gm-Gg: ASbGnctxKtrhgntKC6kt84vrzGPPOl1aBRz/34DWkezMVxQ82yycuZkSRRORO7DCr29
	PruQlKmTcIy0b5dFJIDWnKyrV+LAQ0RfFujf0cj8k4n/voanmJ5EWcKIU90AhnUEBpyzghbq2FQ
	HJM8Keslim4TGPlaPXtdyynwEeK2fhNabSyqTZXTnE8bTRbJQIRvrUfsLjEblhexY4K4Y5t/TOn
	a25OdURF7qCPpB1RHupK1/OUyAS3XRND5W0QmE1D7i7rS+jMrg7iswN6kJElHZ7raUhdBPuihbH
	NgdrKihb0vWnP1oy0x+B36FQ7sXojbgF8O4aNfP7AAQPnl7sa/uQK8L/tBl4b1UowO7C4fW0+j4
	TG5xMfaOBZVvlJrQSyEEexi1vNsLBpvBjrX+M0iRnAoEr82rBW+MZQA+NfuGN3c6xszLbkUxq7w
	==
X-Google-Smtp-Source: AGHT+IGyxD6kxKArelGRFtmyoU+oQyoUCEToyxb454tLZ6do6Faoc5fje7htOPBCBaso+JeJcI0k3A==
X-Received: by 2002:a05:600c:548b:b0:46d:996b:828c with SMTP id 5b1f17b1804b1-47717dfa90dmr28285375e9.10.1761655105404;
        Tue, 28 Oct 2025 05:38:25 -0700 (PDT)
Received: from hackbox.lan ([86.121.7.169])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952d5c9dsm21087888f8f.26.2025.10.28.05.38.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 05:38:24 -0700 (PDT)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Tue, 28 Oct 2025 14:38:19 +0200
Subject: [PATCH] iommu/arm-smmu-qcom: Add Glymur MDSS compatible
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251028-iommu-arm-smmu-qcom-add-glymur-v1-1-73f8f884c9b4@linaro.org>
X-B4-Tracking: v=1; b=H4sIADq5AGkC/x2NQQqDMBAAvyJ77oKmDTb9SvEQklUXXNNuUCzi3
 xu9zVxmdsikTBle1Q5KK2dOc5HmVkEY/TwQciwOpja2qc0TOYks6FUwn/ANSdDHiMP0k0WxJWf
 vIT6s8w5K5KPU83YN3t1x/AE2YNXUcAAAAA==
X-Change-ID: 20251028-iommu-arm-smmu-qcom-add-glymur-7e953cd459a9
To: Rob Clark <robin.clark@oss.qualcomm.com>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.15-dev-dedf8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1242; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=Mf8h+h03L2bzW9mDWJu5js5WAT5mXmT3aoXz60/jCXA=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBpALk+kUF8P0aVK/w8f0AM9SlSRvIOPU68KBcGK
 PM7XHH7f1+JAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCaQC5PgAKCRAbX0TJAJUV
 VsnWD/9BDr2abdk3/NrmmBGMD8VxoWsJxnPo4WRfEjpZxhrNa0p0ISrW79FWqyUm35dCaVmQFvO
 wCiGBC3jHNfOYMIdWGnMCJAP7y9uttfzGyWW7j494avIDvuQKTa/IFQoUa+nqaHa0JdOklX+nPl
 OonLpbwdsJ/6tjmbnIyVG3lqeas14RPcZ0rKKS7SJADHJDxVjIKKpF1mgqpwPnr6DLQaqUxXW1K
 0SApilA0nJhYIT5fqkI3i2lBE+6FpcftOIYxyx5ce8PSRZz9zLE4QKCtuDhIVPZ752RHj4f3z86
 wAAsUkqK6tIk5n22bAY2awmTSp6eggnWs1EiHqgkjyohDOsqMSah8gQCnA8bl44tHEUkYooNJj2
 GrBCKGJEqdkiL1cBOgvSk6WPPGtaGAVq1PzyGeo7Rwzs21hEpTJZEbGChzpBjXoyUnIdf8878S/
 6Vfjl+nOB6ybpcRBLICWuQD0H7GxD61mJTWutk6NuBtjaB4DerA7dDbYk0IjNSkiaCsmoQnQoAI
 nCVyBHKU9BYfkb+raWMcy2rr5IBubLD4ZBqpVs+auH3UXE/dtTIzWhc+CsewgiMuJN1E+GRQmIP
 eBbJk2HseHGPuxVxtneYp4l45JDvFwng9ST9WfAZ/S1RISXMMJNwhXj1VtSmcfOcGQWm96QvGTl
 V2Hx3ejMmtlE/uQ==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

Add the Glymur DPU compatible to clients compatible list, as it needs
the workarounds.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
The compatible is documented here:
https://lore.kernel.org/r/20251027-glymur-display-v3-1-aa13055818ac@linaro.org
---
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index 57c097e87613084ffdfbe685d4406a236d3b4b74..c21a401c71ebe768115364bf282dd324f8222109 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -367,6 +367,7 @@ static int qcom_adreno_smmu_init_context(struct arm_smmu_domain *smmu_domain,
 static const struct of_device_id qcom_smmu_client_of_match[] __maybe_unused = {
 	{ .compatible = "qcom,adreno" },
 	{ .compatible = "qcom,adreno-gmu" },
+	{ .compatible = "qcom,glymur-mdss" },
 	{ .compatible = "qcom,mdp4" },
 	{ .compatible = "qcom,mdss" },
 	{ .compatible = "qcom,qcm2290-mdss" },

---
base-commit: f7d2388eeec24966fc4d5cf32d706f0514f29ac5
change-id: 20251028-iommu-arm-smmu-qcom-add-glymur-7e953cd459a9

Best regards,
-- 
Abel Vesa <abel.vesa@linaro.org>


