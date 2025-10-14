Return-Path: <linux-kernel+bounces-852305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45473BD8A91
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 12:07:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75E27544AC1
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 10:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4864F2FDC56;
	Tue, 14 Oct 2025 10:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SO4egynB"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F752EBDD0
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 10:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760436178; cv=none; b=A5blHdQa9zcMRPtPntk6+IXYTOllv2yafIhIep/GQYrthBU2jcL4+qaT4uVF2GTGd6CCu7HSxrJlUNNg2WvD1k7WDW5LaTMVp7rPQNLtkjBFgsEc/CGFO9Z6d6C4ulgAmhByTo8X9QW5E9ni5gAvVO3uhvvRZtGJn+cTBTnMBxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760436178; c=relaxed/simple;
	bh=SVtMO7VUBLSAh8tqnEqoTPss3ef9mx54zpbAairZ8UQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=VPynNK5sEdaFU6VhNcTWi9GzqZm6j6bCmZvYdX+TjunrtMSXQOKd1jWDUAaBpkqSJdTRbZeRZ3cqRxwB/B5XsSIqLz8/5MleM670y0wdlkMwoEnAjMNWow0KHtB+J8keItQBH83+Q3v6AaEHRgLLGB0tJLihb+b6jjYGn12eg+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SO4egynB; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-46b303f7469so33500115e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 03:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760436173; x=1761040973; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1c6b+GqeawN6AugUtZw8SvN92PfqxV890zC2ujYfseM=;
        b=SO4egynBNsI7pVx3JIPcQb6FqMyNtjDKDwMTFVmsHYvGM+Bu1PX/YufamEkA2tM7fm
         h8y6ta//VeMVdf30KsoOS7+IONJZIoVU8EzWx5EM30QpGyT9utNcF3Cg1TcmVWrUPZf5
         yAZ2gmcpJtmdJSji+qjniy/A0smxLw4TVOQSckHQJ1NsFaI6QRdfu98de71u7Z9iVuug
         ZFf67PUU+Um9YtBfsV6ERShlNqVhOUMqNylPW4xREY+znVAuhRpyqNAxQk/LNUe05n1V
         +uwe+pRkNiI/4MFAfadDksktc1qRn7Jnx0yOn2Rnnm+r5m5Vk31SLXM43V372GipZZmm
         Ng+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760436173; x=1761040973;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1c6b+GqeawN6AugUtZw8SvN92PfqxV890zC2ujYfseM=;
        b=nllQmJe6FfChrojgLapNFDdDmIubBXVhUdjI72mXXP0rRMEoT4vBfKuFWUAA6mkxGG
         97NpQP4grwpqVchFduQRs4Z0QyzanjOFTIl1FMPC/X46q7IwJwv8CKnYCjD7uwYiTLe6
         YKsgoxpINt23ljlhacjIdlKn8GUXGruN97u8h/omaKp2LK5KIuZmIPjPxsl/AZteiXgO
         Ov1uqCNVYnB2MRzGvNLzNO3Ap2JRtohlHI7mDwxDSursnoapo7idpixFIDwgjU2vzK4Y
         dKjThsgtXfVDa//BCbGz85//PvnidMWDCyA4lQUVeJFnK/n38NAUuURkpMcINCQxdqb7
         Q0EQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9VDK6zK5iw6k7koKwfKHREYgn56toMPV2md6XBI0dkn/C2P9hDxXDXHxxjyFoQAiHisQp5UusEPp4ZZ8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yypwi6bz9ercA13x4uGeTbRMWnX5BBK7BD8TL4zRVJtHViaPKbp
	olStH4L9uuD2Y4Zmj5ixZhG0oZLKHV5NpMvLxD8y3bIcihGQn/dHfF5JFMpWBxWnnhg=
X-Gm-Gg: ASbGncuR71+v7ZrVUK5ja5R7yk9mKVQVqASzq2GkEn1x2rNeNssuR0RopLClOs5wmHR
	6zj3X8y6S7rM93E4xmR2fCVRG7XLx+l8n1B0tvAc2x4AcS3KIl0UIwJvKRBZZ1f3cspWR/YTbkc
	nIO/tOY/SVXqOOyss38U8TKPHGB1H16Kvu5VnBb7K2llYdYg5eR0XQQebGCkitr+V1k+mM2xCqD
	ye/rQjjsAVw88qfJMKkKx2Otm+YOdE1f7uP/SPsA6yuaqL/HoumxDOYwtr+D/7BhMoaRES3qQmG
	XY5AfyxqMJvR89O5B5Fe+uXH8niNaP0zGYSZKBxxIsYzzJEKAKvGsa7/Nerg+mnHR58jx/WYNBR
	EfA+O3eiJDz4+cE/CGh2BBZTPSSzBYo+On3rb5Ngx4NoDjpvD6s9xkg==
X-Google-Smtp-Source: AGHT+IFeF879+ZVKEsJpJII/6YXJBFFuE25hKrVz1ilfZmhvgCYyYIsyl9axbuskS/eO0lovEnBZtQ==
X-Received: by 2002:a05:600c:502c:b0:46e:1f86:aeba with SMTP id 5b1f17b1804b1-46fa9af014cmr155783425e9.17.1760436172814;
        Tue, 14 Oct 2025 03:02:52 -0700 (PDT)
Received: from hackbox.lan ([86.121.7.169])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fb489197dsm239615305e9.10.2025.10.14.03.02.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 03:02:51 -0700 (PDT)
From: Abel Vesa <abel.vesa@linaro.org>
Subject: [PATCH v3 0/4] phy: qcom: edp: Add support for Glymur platform
Date: Tue, 14 Oct 2025 13:02:26 +0300
Message-Id: <20251014-phy-qcom-edp-add-glymur-support-v3-0-2772837032ef@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALIf7mgC/4XNTQ6CMBCG4auQrh3TH5DWlfcwLgqt0ARobaGRE
 O5uITHRFct3Mnm+BQXtjQ7omi3I62iCsUMKdspQ3cqh0WBUakQxLbDADFw7w6u2PWjlQCoFTTf
 3k4cwOWf9CFRyQkolaMUFSorz+mne+8L9kbo1YbR+3gcj2a5fOz+0IwEMmrP6UglJ8qK6dWaQ3
 p6tb9CGR/oLimOQJjA9F4xxovNS/YHrun4AN9TtnSABAAA=
X-Change-ID: 20250903-phy-qcom-edp-add-glymur-support-2a8117d92b89
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>
Cc: Dmitry Baryshkov <lumag@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, linux-arm-msm@vger.kernel.org, 
 linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-dedf8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1831; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=SVtMO7VUBLSAh8tqnEqoTPss3ef9mx54zpbAairZ8UQ=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBo7h+83gSTsRn9fQ8mn3dvjXIkW9tI8b06P5FCJ
 a90fnDYkB6JAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCaO4fvAAKCRAbX0TJAJUV
 VoTyD/wLoSKlk6qM/kYRJn3q2sUnNKCGjNvMO4l1wD77dL6VELuCYerCQ1iqRE9M2vqXsmHU0Kb
 9LYILHrsywic2wK1SZvJ1FKfGx7dvreGXljDLjqx34ANm5bwu1ZforYQonfw7ngEkThuGQl0T1V
 XyVcqDy/zkAvoJ0nU0PCaH3DlWj3H81shqWEwiJtQIPLaO5xrmbrW75yC/v78cNjKIVR8HC9xFf
 EjbPbCXZY1n9UIuewFuQbK+dYTOxeA3Ze0V6BWWeRYiFWdbXfH1grqXzrBiiMcaSxer6z/ZL6P0
 UJWSSCFqNbA96c0scoRuM0fjDNhLnsilrYuBYEfBkaSNczAOWTzU0Lb5o0I0OyrCmwU4/k2t/Ff
 Uj4dnrYYXRDVmt2Sse97ZJLLvijcmC0v7avLMCOxJQBQIQ2V/4qg/I6QP/tONMHYn1Qs8qBwkuS
 ryIsn7/Hzg0AwloJLq+dxZhPAI6fyqOX7TmFTQSFxs2w0PCu6lPfMo/W+WYMOHFaxI3pGh4PV0Z
 hdct7EEVRw3ivOwmPqvL7y6FeZT9UJqflZitZB75V2vWl6AjUyVbg5kPSkpP/SeRzYttUL2jJqR
 KULGBIJMsm7fxfe5SKeaJrcapOFh41xwHdTne44Ylb1Kk8NRmcOde4Zk3ciYoG2Ncn7X9Z9iJpB
 c5ZZQjFbfS1j2Qg==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

The Glymur platform implements the eDP/DP PHY version 8.
Add the necessary registers, rework the driver to accommodate
this new version and add the Glymur specific configuration data.

This patchset depends on:
https://lore.kernel.org/all/20250909-phy-qcom-edp-add-missing-refclk-v3-0-4ec55a0512ab@linaro.org/

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
Changes in v4:
- Force fallthrough for 5400 and 8100 link rates in qcom_edp_com_configure_pll_v8,
  as they use the same values.
- Picked up Rob's and Konrad's R-b tags.

Changes in v3:
- Split the DP_AUX_CFG_SIZE change into as separate patch, as per
  Konrad's request.
- Re-worded the dt-bindings commit, as per Krzysztof's request.
- Link to v2: https://lore.kernel.org/r/20250909-phy-qcom-edp-add-glymur-support-v2-0-02553381e47d@linaro.org

Changes in v2:
- Sorted alphabetically the both the compatible and v8 specific
  configuration.
- Prefixed the new offsets with DP in order differentiate from PCIe ones
- Link to v1: https://lore.kernel.org/r/20250904-phy-qcom-edp-add-glymur-support-v1-0-e83c6b9a145b@linaro.org

---
Abel Vesa (4):
      dt-bindings: phy: Add DP PHY compatible for Glymur
      phy: qcom: edp: Fix the DP_PHY_AUX_CFG registers count
      phy: qcom-qmp: qserdes-com: Add v8 DP-specific qserdes register offsets
      phy: qcom: edp: Add Glymur platform support

 .../devicetree/bindings/phy/qcom,edp-phy.yaml      |   2 +
 drivers/phy/qualcomm/phy-qcom-edp.c                | 232 ++++++++++++++++++++-
 .../phy/qualcomm/phy-qcom-qmp-dp-qserdes-com-v8.h  |  52 +++++
 3 files changed, 279 insertions(+), 7 deletions(-)
---
base-commit: b529e9498b7948df2be579282cbf0d5a9a3b7f9a
change-id: 20250903-phy-qcom-edp-add-glymur-support-2a8117d92b89

Best regards,
-- 
Abel Vesa <abel.vesa@linaro.org>


