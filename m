Return-Path: <linux-kernel+bounces-852307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D753BD8AA3
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 12:08:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6D473A64AF
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 10:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AAC42C2347;
	Tue, 14 Oct 2025 10:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Yxdma8ai"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE872FE049
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 10:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760436181; cv=none; b=hIIBhwsQXO3nvx7Kam37wA4eWjhKQgB4ZiWnvwgQ9Xpab7WVM4Gun0/ZUixVRecJmrlxyKxnLshqKo1vCtccD5AATNn2zPUcVtmhxmIB0Z8fv09TCcyfZ+9IXRTxtTFVsdeHPofOiKtpPbc7g1mMmuihbup2WTBfCOdosafGzN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760436181; c=relaxed/simple;
	bh=S/KD30P8NP0mNcehUP8pNGC81/R9glKXIgh5wrx2AKc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IpaCbhZxPdY/EQr3sGM/iAXaD5HCIkIj3RMPEYNhLk4BeieGe+DyYlIXsLugygEo/K2wuyTPtJ4MjZEi2pKG5IKBYYpc1n1oO+C13UtdNIyoTfyAdKxxTLMM9EClHZ0i1EwUWq/uxe6V+5s0aZh1s8QhDl2fbekrBa0usWcO9ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Yxdma8ai; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-46b303f755aso44617335e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 03:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760436177; x=1761040977; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vaS07fRAp2KaqILcMQz5dgQ+s6oWbriezT3s15GrHVk=;
        b=Yxdma8aiLQ93OFxDCuGOp+G+5fdfAdevdgwyJbx/MFxCZSkSSHpb3S5XJECnvak8qe
         FPQ/YoSNalIXS4P12iAeOtwF6JP11r4LC+4L9qLmZqcBmPfL0lPbB8NBxvO8t44hO4/a
         N4xJj/xJNUHX9Juk7+WB1Xg2hGxt9n3GYlZzJSchReup72sICnV8BFtnpbus6b+Cv8OM
         UqlebTnScMmcpXZz5GsMnnljWzK0sh1tCm5aX7NTAbUr2hxvRBj3xpOuTG5RmjHSZ4EJ
         vjt9YrtBYoAjYUDrKnIN4bMyDqKTABZi6jNELqpOM0jVPHPoX8hw9unbo+VveUTSoxGE
         tpmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760436177; x=1761040977;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vaS07fRAp2KaqILcMQz5dgQ+s6oWbriezT3s15GrHVk=;
        b=cz8sH2XrFOqvgXGRQ05+z+x9tG50KJftG/qwlrHpS1pbktV4oB8s6SBQ/SNouB8R46
         ILKrHDGpOu7ooTR+iSusgXyG6H68c904q4jMB/+DCv4w/MsILgGXh4I814iCM8MRnqQG
         7Ip06RN3zg/9c2QKMSsOTq9jf2ijHy3WW73k5y28oOKSWmJ7DmT1uDeHmU6SAi+ITOr7
         Mwjkc07nZE4pW6na9wzWEPc8S/3KYeKFXrLF75lE2F0cPmDoMqk4qLYg3Ie13GWu8jSY
         W1zf2rifgPvMlwONGuPw/0RPxBORnDNbfowXttO3qBZILvu4q/VKfa7xOH5VmhfPrm7x
         QDAA==
X-Forwarded-Encrypted: i=1; AJvYcCW9j272hShBqGMv8bplJUFsgEjoEkw+55ds4q4YRjV4V52n4zJ9PtUXBACrjCXXrBLhrEzvsILF6DXquSk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkvljzG27JVwDAm2UoAVOf6R1dUGG97hAFQw8LW0FGa1fLa4vx
	FBmPQeVQhr6JGci870g82tBWHvsps0zTJS6wd43JdqnrhGm0q38h1cAl7OrvjOexH6E=
X-Gm-Gg: ASbGnctbDewUW45EpyOkQKTa51vVBEPJrMI+14BwnogHPCOW4oTaRzYAVv0UH0CHl5a
	O1mQViqPJ24Q26zvgT8t6G3TAkrCCDfFybCJA0HIShQZ8yi+Tm5qKiC/zwng16qirWl1IuSDIsH
	cRJag3Cea32CuhCq8kpaCAWDpYVxFjZE7XWBmqVlvEIqiloFxoULcuoVcf0UpefAaFx0kvOgugW
	a9Kk0BM8RC7EP908WyDNmZqH6r+pZYmLAXu2la8bhSRHcbEFxEPNeDrIqhwPCz+qJJQJh2IDZMO
	4QmDmx/w+7Y4BvlRZg6jiT2IyBlI1Ui28flSZHRelRvMbZzwdd3qn2NK8VKTDXi++eKSgdph/Bw
	LN2E97Hfo8x/yg/3uW2fq8BaSPEVgKKIn0FuglA+GGlIPbiOP2HxzDQ==
X-Google-Smtp-Source: AGHT+IFl2VtEUnOc7K7cnKyCXWZQmxxjgC+HM/RYs8PRHoUIntYpayCUFq/QGa3L5ZN0P6heHafASA==
X-Received: by 2002:a05:600c:1d1a:b0:46e:4a78:dea9 with SMTP id 5b1f17b1804b1-46fa9af17d4mr168450155e9.17.1760436177412;
        Tue, 14 Oct 2025 03:02:57 -0700 (PDT)
Received: from hackbox.lan ([86.121.7.169])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fb489197dsm239615305e9.10.2025.10.14.03.02.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 03:02:56 -0700 (PDT)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Tue, 14 Oct 2025 13:02:28 +0300
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
Message-Id: <20251014-phy-qcom-edp-add-glymur-support-v3-2-2772837032ef@linaro.org>
References: <20251014-phy-qcom-edp-add-glymur-support-v3-0-2772837032ef@linaro.org>
In-Reply-To: <20251014-phy-qcom-edp-add-glymur-support-v3-0-2772837032ef@linaro.org>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>
Cc: Dmitry Baryshkov <lumag@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, linux-arm-msm@vger.kernel.org, 
 linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-dedf8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1247; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=S/KD30P8NP0mNcehUP8pNGC81/R9glKXIgh5wrx2AKc=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBo7h/Chm3XpAOoZ+7P1ptsAjAqkDalQY4X3MdGn
 QpOsnA+z8iJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCaO4fwgAKCRAbX0TJAJUV
 Vt/EEADIKuOmzt2Kab1SDBpuRUMisq3zDdHGoozaSKWUjDdjzmyUsli4WK+J726o7f+wz/nl35c
 p/kuytzWM6WmVhNy2uKr3bTBevx3TTZ/khpJOTvjXJD88U0nkiJKFKSw7OtjbRDsPfHNVMRckEI
 XmOO5XxbfoXMDIA9zzEL85yyhcVCvSwMxm4Jl90kloBBBIQxQbfQoeSQtvSVtGxSAE6LW30lW3+
 K59yh/TgbMvl6RCnVS6DJPdiHMvJAk0Zt3fW73KrH1m34+c06n0M0495ABtxd9noT7yP5milXcb
 GP6dGequX+u4P/yA3tM9vyd6GgTPHb3TBnQQ7bDQkIPyEe1F4o/vcW9q2q4G1bmFVNKKw+pnvqp
 DSOPcGQ9W/P8RpEoBDU7b4hrVm4LjeNT2IQvjjH8OVXQPzaMDJ3zvAWvYJsJbiXLSak1LyfIXxi
 ryttjR+DDMutxAj5gh/8PLigLof3N8WYn5Caauk361g5UyeS1y1xRkL9QQyeB+/TrRPuXnqy5DH
 6O1uIIO6JmbCQEqTMEaZ7lSouhkkmKaS5QFZQgo8rT7UqNQGenxFOkqEUc5tvnDup5hsF3YGDoM
 DWtAWrgFO65A/6Guiq6jnkc+Y5YXtji5LchjQCmvHYyCQXiCTCL+11Q+GG6JEJeiTg5ITXHTkSb
 sYesTJCzcqS3h9A==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

On all platforms supported by this driver, there are 13 DP_PHY_AUX_CFGx
registers. This hasn't been an issue so far on currently supported
platforms, because the init sequence never spanned beyond DP_PHY_AUX_CFG9.

However, on the new upcoming Glymur platform, these are updated along
with the rest of the init sequence.

So update the size of the array holding the config to 13.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
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
2.48.1


