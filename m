Return-Path: <linux-kernel+bounces-812316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F391EB53619
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 16:46:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96E444858D7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 14:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 353813431FD;
	Thu, 11 Sep 2025 14:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iCAi32+m"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD2031353F
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 14:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757601951; cv=none; b=r17hESN5itXLoopoq2QKOalv7WFzbVooYHOdfgvm0VN56OiKkVP/vzmrFijwE9QIl1S+zND5MJJaghmre2DOTASQ1OQ5RuC4Mw5/85mfMh+gvaKi9q2imTmQn4eTrvmmqB299a7yR1keIueA/3ZX4OFOHwlI/ftqxanpJAdwF8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757601951; c=relaxed/simple;
	bh=prBRws9AKyD86wZTW+eWIKYLz5knWj5rzAD98i9R9I0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g1YbcZOQqAVQX8ZPujmfheyvtu7jDk1LdXacB3+3wBd9iJfBkJaW9L7tTWzdJEpka9rgPAjELxJkVaFTIVSoBRK8RdIZxlteCsjWuEc5viNihRb3TUU2UyLhQIqmbbH2OTDnVWKXCiFOTmUZqwpzuUigFShS3JuUhbBn1MMjuFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iCAi32+m; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-afcb7a16441so124929866b.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 07:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757601948; x=1758206748; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZvfZ8Qsgh+4iuPHesI9UycLWEQBcekeYQGNlzH84XAw=;
        b=iCAi32+m6hlKIZMXZujhlcfVaCuyNVbLvU7dXIFdbasBsPImAHLDPoQMWp686rIpks
         1D7ts7dFA+pjLm41wuQFb1sxkusmk892joqeOp7nWDCjwblBUDbFPghosneOLURJcVHJ
         t08qtXfcr0viEynvtQaiBMGiV6FbEM19tCrByVhQ3J/Oec7Yj9XrEWgZYQ2CMEP+H5pO
         X5w+PraxAJoGj3ufPzm/9NdVUbaSs6gXahA28V9lUeaGJssNm/8Stch9eMXj874P9OqV
         yE1hAj5sThoQrxsRIxRxDYaFkorqY5KzXnIMonWfaEJzFMG6zEPqALf3BqyS8YDyWgwp
         qypA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757601948; x=1758206748;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZvfZ8Qsgh+4iuPHesI9UycLWEQBcekeYQGNlzH84XAw=;
        b=ZmZJCR3gn/JlAcgDgwRKFs9f3hMTap1yYWQaoG8UFlDf/5TKeKZwF387BP1ebmcNaC
         K2XZOE9YyPetYTCdq0kSuK2lJbiNLZ58tWSx0rr8CzNbqsBmpDv3Z/wvV+pT1hAij98s
         Bvh+Jnt06XGL14QgyT78TE2o1RySkAZZQeV9k0Q7+J8QI0+YrrHZ7WefTOv1pN7Xag5j
         vHFakXnfs3V1ZhL+3aY9S5U8uDM29mVdIIdk63tYd9x2uV6f8jmKVIUCzRLT4DyqcBR0
         AL3PTjAo5nKWceO1ubsg6jhE0bpesaKZFuEwDavmabiCYp9As6huMSKQiMvupoTlrniA
         6XwQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYPfKvGMGJ44qYBN+cMbxd4qQFlMhQNwxkrGl0JRsghRADmcSVCezGAukri8PVdttpA7VDejQq0o3smpE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxyngvca6Kn5jB20ceMmCY1zwbExQ58RskTvGCAg1UkVT8JwM+x
	/qZ3jvlsHZYJhxwg3n15Sr3qccXjH7rTQ5Tj9uJ/kchzG0/hFWiLOFeEtwNTtvvIkG4=
X-Gm-Gg: ASbGncvnx3hbXJ4Dw+9b6MqYBna68fYmnPdumkNUbr72sOUnrza5qzaU6bXO5Qg1vjH
	0n4aXtt++8jVnB86NQQtAR7SQjA1x2lJjoX4gM27cLGhM5SCUA1NNMKKEQ8EF1LSOZQB1jOOyNT
	erpUlQm5eDnNh9aEGwB9ZPF79WkkL7We/wqNZwxvVo2wbbVsGDLxt2ViK+IbqT6nxiKAu+ka7Hv
	dqnH2qKqM1PviQvTCBUP3zHNBOlgcKYQIsL8lRoPulg7Q82qh0FRaCro6aUDtEz+Ip3swf0eAXO
	3BCSU/MRETVoWmSMiyy+471ZCPy+JMHFHG6XSHBsPsF4lkKXNBi5U+nVz3PZM/PVUgZ2vJeSepz
	KjsVIifVAfe/EQ+7I28D4V/Q=
X-Google-Smtp-Source: AGHT+IHGnXEifVquqv/KZPf9m6Jh8pdEXvXherPbOAmrvLY1GZz5C+RIz5Z2dfGTZ2NzWEPIu90quA==
X-Received: by 2002:a17:907:72d2:b0:b04:24b1:83ed with SMTP id a640c23a62f3a-b04b14e274amr2268211266b.27.1757601945489;
        Thu, 11 Sep 2025 07:45:45 -0700 (PDT)
Received: from hackbox.lan ([86.121.170.194])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b31282e7sm147196266b.23.2025.09.11.07.45.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 07:45:44 -0700 (PDT)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Thu, 11 Sep 2025 17:45:23 +0300
Subject: [PATCH v3 2/4] phy: qcom: edp: Fix the DP_PHY_AUX_CFG registers
 count
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250911-phy-qcom-edp-add-glymur-support-v3-2-1c8514313a16@linaro.org>
References: <20250911-phy-qcom-edp-add-glymur-support-v3-0-1c8514313a16@linaro.org>
In-Reply-To: <20250911-phy-qcom-edp-add-glymur-support-v3-0-1c8514313a16@linaro.org>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Dmitry Baryshkov <lumag@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: Johan Hovold <johan@kernel.org>, linux-arm-msm@vger.kernel.org, 
 linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.15-dev-dedf8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1186; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=prBRws9AKyD86wZTW+eWIKYLz5knWj5rzAD98i9R9I0=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBowuCQPM+Rd9X5/h99qNDUNk50u0Miuhv61KVFv
 qAuYfAscYKJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCaMLgkAAKCRAbX0TJAJUV
 VsYLD/wJga5xVmz5zQrZUWdEoATC/hv+sJzmIYC/96casS6hAXEDgHBUZ9WLkH0d6YWBGz7JGWW
 XfcFOuOvQl2qQkIsR4/p0VdBut4EQJGaPvtIIJdZfjOgytjdTmOsFFACZ4SZQJQhqtG1/qjBe2g
 wYp9VgjSeAaJVrAXsCf9qzkLnLQdDxZcKFWUk40nSZ+/GbMpld7tyEhYRK4015eTCZiC0mZhRAG
 /Aw3sWUg4g6fZpH5pT4dSqNKyiUPtEJiZ/9Sjz20WpMPr8b9DejLyXM7rnpVQaItSfjkgEGDAlC
 jMdlgd7pi+cxtpUcxAXBkYVGu3njNGJpc3ujtZlGIJ8yx/4OE4XScyT0E1YFeFFATIYB0r1K0al
 J/SjVtP5slJlIVw1V0n+G8gpzU2424qemAsOpX6s6O6yn6AxrbCw9KFfDJN9UEAGvEogmTgkNWT
 9uxUR0YLa/2SDRYjKDPQNxzUMnZSYGfbBx/fNxIMbTywLyZVQ/KU1LNy2QTKRIypezjNa43rTPA
 4QaZwZ8kDolfJZuoEEdyFOXPxDxQa8pjHj3D2CAMV5qOwBxEkSbCRhfnTvUbkyhLjHiBA+VDs2Y
 6G2zx+MY+Uzn/8GJBKC0L40TUcyj2bYSB2ygZp1GBuGgL2HiIjoFQOGY+oXv0f6ehOK6GZ3lnd9
 rQ9MWOt4zShBoLg==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

On all platforms supported by this driver, there are 13 DP_PHY_AUX_CFGx
registers. This hasn't been an issue so far on currently supported
platforms, because the init sequence never spanned beyond DP_PHY_AUX_CFG9.

However, on the new upcoming Glymur platform, these are updated along
with the rest of the init sequence.

So update the size of the array holding the config to 13.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 drivers/phy/qualcomm/phy-qcom-edp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-edp.c b/drivers/phy/qualcomm/phy-qcom-edp.c
index ca9bb9d70e29e1a132bd499fb9f74b5837acf45b..7b642742412e63149442e4befeb095307ec38173 100644
--- a/drivers/phy/qualcomm/phy-qcom-edp.c
+++ b/drivers/phy/qualcomm/phy-qcom-edp.c
@@ -32,7 +32,7 @@
 #define DP_PHY_PD_CTL                           0x001c
 #define DP_PHY_MODE                             0x0020
 
-#define DP_AUX_CFG_SIZE                         10
+#define DP_AUX_CFG_SIZE                         13
 #define DP_PHY_AUX_CFG(n)                       (0x24 + (0x04 * (n)))
 
 #define DP_PHY_AUX_INTERRUPT_MASK		0x0058

-- 
2.45.2


