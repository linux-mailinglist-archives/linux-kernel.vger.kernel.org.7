Return-Path: <linux-kernel+bounces-773584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 189CBB2A1BD
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 14:39:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A47DA7AB808
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 12:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5FDF3218DA;
	Mon, 18 Aug 2025 12:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F7M1+jlz"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DFFC3218AF
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 12:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755520739; cv=none; b=lRW7ZmkUYfPopb4evptFXPTDiK304VCHl/VbiXWtgyEJ4BrOi6aipoJfDpqrFc3xcLmwDXQ4qk4RdNTpgbtR9kqQ0idWSMcebNfW2XkFdPZdLu5dZQt32Gahxkw03cImQqsAGCiV9KDkgHItf/zv7LhUINeY19iaHT+p094kiOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755520739; c=relaxed/simple;
	bh=NNd+UhxgFiLUKQUDeL+TcsKdGr1tcHid7dcDNUh0G8A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=roJup7kxAZBjVInHdGkvnimKoNI6OjbqYP6MRT56MPg46/woECYVMNy1e7MD/iajueq9Lanur9gzw3g+2U27Koh5xRenTUrc47I5CUm31k1cHQ013XQqFI+7eecq5Y63mzOFc7nWEiPXuYgYNkWkj9BLBVMK4L9OwORzI8D40DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=F7M1+jlz; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-afcb7a96309so50789066b.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 05:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755520735; x=1756125535; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eVidIAFOQ1pNMOop8iUArlRul1tpgG751/FDNho3w3s=;
        b=F7M1+jlzXfUEmjg5x258E7bgy7boqDvREUiPiuHlIIkipjmSgfEt5Ow6BvzRXTgK6N
         7XHADhnPkDRgyyAPzBLvjPGXj+lmQkFl1n0ILZEEOe+8peyeOe0nFOZ+S91PAmvLWHIL
         evY61cXcYgiZYGXOKZ9PPFuSpUkigEEbYPZh9L2NRIeYLiHXal673yvhFlND+fAahLYC
         0uiVBtbIabBqBeFtAEH8F13nrCVKLRVg8+X1WPhkFcHhWHdE7liTjWHCjB40B0Hvj+5P
         Anyv76J9QcWhSwKsuXPAC1/S0fvGJzBUAzidDrPcfkUskBUpGYzMQ6xoAf9X1fdL1KSw
         4puA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755520735; x=1756125535;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eVidIAFOQ1pNMOop8iUArlRul1tpgG751/FDNho3w3s=;
        b=JnVSkKMzuqsRcePVyu7/q45phomVmImVCPDuVDVtnmjOuEhyTgP87WnHA8S+EYeOz+
         6Zyqy3/+L8XsUxqvfCaM2qQhJcJbuk8fuigiI+cQPR6D/wB71C/UddWtizrL0deelBBR
         o8BmxeWK2ezaOeKGIdFeTsv/cu2tjccQVaOWo/vw37kOlR3cFd/y5VX8ccqOdvBwXw+F
         dbjixUe59mOwnyD44Yi5D9zgmfpB0TPf7idJOEq51yVuaTq1Hd3u47LHcKQ1tkyLu/jp
         noggNvn9Ao18qHB+9NemGf9CP/uO8tUu7mR0CClnrfujDYi3wUVD95azCD44Tvo7l0H7
         ilMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUaLp33yOq2/5PchnMfgPX7BBsN5dtMCm6qV2pVzBQNuPbLExgS2EpbB3GnZ1mWyKxCcB7FBtyYPOaAtMQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzs7Kp3owijpDK/Mn0vM28+Ga/TtLbML8F7T4yrFrRe1DWbvnZI
	ujItVDNfCpdXbLVn5ptgeRLHMiq6aMK35Px1jhCZV/hq9a70wY+Hg+RsVH0ixpU4lM4=
X-Gm-Gg: ASbGnct+CMA2rymLoqKtN2hiQOZgPVaWdPSf3kJqVbIz1Bae9RQ41/DmyEWZMlc+WOc
	7yR/LpoFV2Bmw6p9XRZqsYa8Oc2927OJrA/WukWDRfxo8SOnY1U9PG3+6f318ZF/cjIT8wozrRN
	uF6Orx6rQZV6NPemwmfjAXIEj5cL5IWzgaH773BHWwjNPPBgtVZvBBriPEs+FZS7SeBSTHPZDKV
	wN5DHZ98RG5nOWKx8B2bOyTl7+SMCQuzA92VfEvPTqM41B6xk/aSd8hKP5z08lyZbt0ndpVUVl2
	+njWOXnlEVxDmPiMCu+fmEdB/dZZmUVF/Frq0JseJDE8e5EnW9k0xLe+aZ3axQQ438BtMU0S5xL
	YPpUW9pxFHh+8r9TkRUB6bgRDu1CObJXuVw==
X-Google-Smtp-Source: AGHT+IHXYdPtY1MDFkC22yLVUpu+WB8sPm6OdmB0qkvl3/Jlp9B/FVBmvXmSnUDcwl7JZMcG0Z1xJA==
X-Received: by 2002:a17:907:3f90:b0:af9:5903:3696 with SMTP id a640c23a62f3a-afcdbe7be35mr491927266b.2.1755520735432;
        Mon, 18 Aug 2025 05:38:55 -0700 (PDT)
Received: from kuoka.. ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afcdce53dd5sm786600266b.5.2025.08.18.05.38.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 05:38:54 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH v3] soc: qcom: icc-bwmon: Fix handling dev_pm_opp_find_bw_*() errors
Date: Mon, 18 Aug 2025 14:38:52 +0200
Message-ID: <20250818123851.111326-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1913; i=krzysztof.kozlowski@linaro.org;
 h=from:subject; bh=NNd+UhxgFiLUKQUDeL+TcsKdGr1tcHid7dcDNUh0G8A=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBoox7bkcKP6BHpCB3hJNSehZPEnE/cAIc1+e8fc
 nXJFPNIyO6JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaKMe2wAKCRDBN2bmhouD
 17XWD/9Zk77HtVCcEOHh0wTT8Vzbetf+z4DWBIjVrAv0xplZ8veRVqhc+G39eIDi3tDvW0oVSPg
 0kkKoVzwKDScptyI3Mr/ce0NQohxj3YZK5y6zqe7NcaBwXFZKI9QokTMPD8Xa7M9GK+tXg8HFzu
 K8zoZEOy8mVYqsR22x8NQMMUueIWLclshHZPuJnpAdA6tjWwLeR5oFtUUF93YwreAQ052r2WlXP
 K3vAY4INYsMBWi5VBJRW9x955TK2nAlLOWZkHYsKxpaYU/vB+gp4LF7D3Eo/RPp0IZ0wKfif//r
 j8V05z54SRgx2tjq6ro/GZxCzAdTaNWY9ME973WFyGuj/sauiI77GKHpizNF1YXZ+RESBl1ruIm
 9hLA00toCc3RCsvRIIZC4DnNAps4KXZ9iVMOSq4iVgYitlMN1M2OHbFdPZy1mjEA0CxT38U5K3u
 Fe3PMC5KBvdb9vQnf26bQlaUc3bcTi6s9HFYuydKYdMsXpzBaKTZN0QsjM2Lz4Cu1hAdOGTKa6S
 4EK3zaFoSNjy6pc0AHOfo0IPoqi1eQbb00fZuP0DxIy+hxd0Jwcg+ci4Mt4YaX5BeaDvtDq/zEx
 BbYZ3sI1rWdvSplWPTYVebxnrwtksTMDZRq7Gq3vcfp3WuRK6xG/CZLGOEuom3kIarmB4vxROnm b4E/eETCaXtHoOQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit

The ISR calls dev_pm_opp_find_bw_ceil(), which can return EINVAL, ERANGE
or ENODEV, and if that one fails with ERANGE, then it tries again with
floor dev_pm_opp_find_bw_floor().

In theory, following error paths are possible:
1. First dev_pm_opp_find_bw_ceil() failed with an error different than
   ERANGE,
2. Any error from second dev_pm_opp_find_bw_floor().

However in practice this would mean that there are no suitable OPPs at
all, which is already being checked in the drivers probe() function.
This is impossible condition.

Relying however in the interrupt handler bwmon_intr_thread() on
preconditions checked in probe() is not easy to follow from code
readability and is very difficult to handle in static analysis, thus
let's make the code just obvious to silence warning reported by Smatch:

  icc-bwmon.c:693 bwmon_intr_thread() error: 'target_opp' dereferencing possible ERR_PTR()

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/r/aJTNEQsRFjrFknG9@stanley.mountain/
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes in v3:
1. Grammar commit msg fixes
2. Drop duplicated reported by smatch

Changes in v2:
1. Rephrase commit msg (Konrad)
2. Drop Fixes and cc-stable as this is impossible to trigger
---
 drivers/soc/qcom/icc-bwmon.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/soc/qcom/icc-bwmon.c b/drivers/soc/qcom/icc-bwmon.c
index 3dfa448bf8cf..597f9025e422 100644
--- a/drivers/soc/qcom/icc-bwmon.c
+++ b/drivers/soc/qcom/icc-bwmon.c
@@ -656,6 +656,9 @@ static irqreturn_t bwmon_intr_thread(int irq, void *dev_id)
 	if (IS_ERR(target_opp) && PTR_ERR(target_opp) == -ERANGE)
 		target_opp = dev_pm_opp_find_bw_floor(bwmon->dev, &bw_kbps, 0);
 
+	if (IS_ERR(target_opp))
+		return IRQ_HANDLED;
+
 	bwmon->target_kbps = bw_kbps;
 
 	bw_kbps--;
-- 
2.48.1


