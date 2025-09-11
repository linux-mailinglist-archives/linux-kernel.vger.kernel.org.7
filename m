Return-Path: <linux-kernel+bounces-812313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51233B53612
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 16:45:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0253B3B2208
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 14:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A33E6343D77;
	Thu, 11 Sep 2025 14:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DoEW4ybT"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBAE234166F
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 14:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757601945; cv=none; b=syG/ukeSojzTXbeHd5NXltYTuEp0vcfulw/I7uDupLBmHlJ+t84zIPkacspihPkxjtVGmrR7aH1Shb1jFRbbRSf1UGf2hj3PE190sZYa4gOVa7ckTovn0F65V7CHpe483kZkD+l9eH5IZPPJAJuRRavDxqtS/KwapQxkfKzdWEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757601945; c=relaxed/simple;
	bh=1ZGtzrU3exJTnHu/Nyew1wGp2xjCeiCIpG3JNd0FD54=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ElrO1V8K0SD1MogTqxAileOlYrkFS9pd30VuGTNk09ZCk+ml2kWUE9OFqL5SEpd4PefcPYZH8BnkSmw4XZ/8ukfvNit4VPHtmrs3dTVUlM4x/pbSXYvPE+GeZaEH0SuRSJKVBwXFsWgFyvVhosQFTDj0LaRPFLQ7/QUaHk+aE/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DoEW4ybT; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-afcb7322da8so157442666b.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 07:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757601942; x=1758206742; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=103cGBp+Ee6AQsaTfOa0MxZHuXIIb4UOJLdbajeRtrQ=;
        b=DoEW4ybTfDNWL6HzZJjCoSWn5HM3NIixB7PHxxCrPRJqj+g5hKnegQNgUb825khit2
         vk33W03FKH0d1P9iEUlRDcG1A69Ff2PaQfYRwVqZ8ju4ODN1Hz2uK8oCdTYbsQV73mkc
         yWR9hC/o2T3c3EjHYWBTDdnKllpRRbkqF5rOCjc17ECM51SWJiZoRyawnkdA1WTHizJT
         JU3OxdggWW1EPZrXludAMWfr39246uCiacilUeunDOkgSl9kPFD6jrPCJUXmnOzI/1Rn
         4ULIiQuujh0r0gOE6uSOZWg7zyq08hifmo+0Hl/EYf0ZmdZChBCilIRiNvXVV7oeSlDp
         BMng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757601942; x=1758206742;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=103cGBp+Ee6AQsaTfOa0MxZHuXIIb4UOJLdbajeRtrQ=;
        b=XdRqWJv5WD4+j70Z3XnR7rE/bnkzzElhvxSYMOcesVNbD+PH0F4Suph4UHL7sHsAT+
         AxUV/Gqxg/SNnDg+kcgZs+mUG/OumGgP3RPo3IS9Ul2NC04a6typfcjnMEIQhptlxiEg
         gpvaAvFrwDopSvIZmXxPYn1Oz2WkgTNw2gRH1cFvEwVnqAMK6x+g1scPkzLG0GGJTT47
         oJovVIK5bvEkVwxTmHsMdd3RHiN5GAPy1ZB1w3MHKMCmDw2qc2T0+ZXU9fTNmCMUKmIM
         IdGssl14jpy4Ny/7jRcVlAnuc8k/m9gZojPp5XYwHdiVGy/zjxWb3687Z64Txaq3YRZ0
         H1WA==
X-Forwarded-Encrypted: i=1; AJvYcCWooeeb7B4scq4KaUUNRQ0JyId9KfZATdqhKdfIS1J0J9p1akVWq3YGMqaKu4nGYugjoGkJfnai2CEwlkw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5/D5UZ7beU1P3ZuZQzefe3V43OLs8jevTXG8Nv4m6YS5I9Vl7
	GGSSqIaZvBMbra58qPYtdz1e/eaHnhycTd6wXDVuw8NDZK+uScHPGS3NKZTSoyE4eHjIvRTu5sm
	DN+zd
X-Gm-Gg: ASbGncsbLBjuWAk0s3kdJKxiVTHHmrgoVG/mb7hPth1BoUW7+1vWLUcv7HVi/f3tq0m
	474vqX2C+0u1C05v/mcW31DnZ/wNIpHyYmSgNf+4bFz0TiSiSI6ppOyvUCisjkTIkckvrWy8BqE
	AbIfgUHrrRpXBKlZzn8SBZ6jqwP5LiBHbpGS0tD2PifXoUNiM9OgUMdnKtgzKjbScZBK/TXrDjn
	Ji9BRSSOcSd4Q7PZblSwlcy9kztB/9tFt/Xvm5rYwaNekCvQafljCqoBh80PplTWkklU6W8ospm
	XaplXbeFG7FQJ3bK6XQhJNW5pO9W7Jlp834ptluoSKVpbw1xfuZMwku6LMRCwKtb+8dt1+jTx0z
	fVWLxgZvLloyRLe2Edb7PDhc=
X-Google-Smtp-Source: AGHT+IHI4MsNX6U7yd3HYoHJOuomoEwI9/ElYgPM8nXP6Yp+KZHZ1xiK18Y8gwgZTPkHgL5uhxR+Rg==
X-Received: by 2002:a17:907:6eab:b0:b04:274a:fc87 with SMTP id a640c23a62f3a-b04b13fe46bmr2015424066b.4.1757601942113;
        Thu, 11 Sep 2025 07:45:42 -0700 (PDT)
Received: from hackbox.lan ([86.121.170.194])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b31282e7sm147196266b.23.2025.09.11.07.45.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 07:45:41 -0700 (PDT)
From: Abel Vesa <abel.vesa@linaro.org>
Subject: [PATCH v3 0/4] phy: qcom: edp: Add support for Glymur platform
Date: Thu, 11 Sep 2025 17:45:21 +0300
Message-Id: <20250911-phy-qcom-edp-add-glymur-support-v3-0-1c8514313a16@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIHgwmgC/4XNTQ6CMBCG4auQrh3TH5DWlfcwLgqt0ARobaGRE
 O5uITHRFct3Mnm+BQXtjQ7omi3I62iCsUMKdspQ3cqh0WBUakQxLbDADFw7w6u2PWjlQCoFTTf
 3k4cwOWf9CFRyQkolaMUFSorz+mne+8L9kbo1YbR+3gcj2a5fOz+0IwEMmrP6UglJ8qK6dWaQ3
 p6tb9CGR/oLimOQJjA9F4xxovNS/YHrun4AN9TtnSABAAA=
X-Change-ID: 20250903-phy-qcom-edp-add-glymur-support-2a8117d92b89
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Dmitry Baryshkov <lumag@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: Johan Hovold <johan@kernel.org>, linux-arm-msm@vger.kernel.org, 
 linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-dedf8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1655; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=1ZGtzrU3exJTnHu/Nyew1wGp2xjCeiCIpG3JNd0FD54=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBowuCJiXBuPUgcuSwM5NgfCaGKyFmkIR1JzF7l9
 J1aW12ScEyJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCaMLgiQAKCRAbX0TJAJUV
 VvidD/wNlB+W7BH7/9suRcthkLqdB11uXaVveTh2clqqGHpAZ+o1vOzPaXuzEnjMXiU3oULZ/Ps
 MLKftVkROjkTLi8d8tmmGieUQ6qg2cjRaBAKAiZwGAgWgAMeTpuoD4xwHGCIbvTiNwMz5DjAdkH
 iqvyxHcI9nBt7NnnMu4xKNjO4Phk8O/rymnGC005bX0rPS/clJLVRZpXxDivuZD3cCjGQ4Rei/g
 dlk2OKJOf8ZzU3F2ZKKcctM4/mp5Mx5pzeZYm+3MWA30L038G/Mu1oG7cNmjTT3GpnPiWyBoOZu
 nfyVVcOREaf/7tCZE2oooew7ZnDINR9+lHM2K2PmDzTzqJW0ZguQxPL0omB1GWCy9RJXsbYmeth
 lX2PeILK0ZiBXEexSDR6XuBxM0VYtw0THBTnmh/lJlLTN1VfjsY7trnWfX7w0Q8cbWPfqgOXbtz
 tAe1pIZDblSniNAj/gP55TRbxM3j9Ac+nVoCukRpTKzVPDDlfcNw4/ulwB/6k3HxQoKPy1Jlfam
 mnK5yma0SO5GAvBuEyeCnrjzUwDM3fAIKkWRAoCDNoC5b0rot/DjoySgasbt7esJYtNu0yBGLxy
 cZgWTOhUZQH6Azssz+l32KClMXwZ+tW09oFOjcJkxagpfLy0tz7YrAWz8c+jJKgwl6yqmvu49QB
 gfsyIsAHMhJCIcw==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

The Glymur platform implements the eDP/DP PHY version 8.
Add the necessary registers, rework the driver to accommodate
this new version and add the Glymur specific configuration data.

This patchset depends on:
https://lore.kernel.org/all/20250909-phy-qcom-edp-add-missing-refclk-v3-0-4ec55a0512ab@linaro.org/

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
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
 drivers/phy/qualcomm/phy-qcom-edp.c                | 242 ++++++++++++++++++++-
 .../phy/qualcomm/phy-qcom-qmp-dp-qserdes-com-v8.h  |  52 +++++
 3 files changed, 289 insertions(+), 7 deletions(-)
---
base-commit: 8128ba77e80a40f545381f1b31267f2f204380fe
change-id: 20250903-phy-qcom-edp-add-glymur-support-2a8117d92b89

Best regards,
-- 
Abel Vesa <abel.vesa@linaro.org>


