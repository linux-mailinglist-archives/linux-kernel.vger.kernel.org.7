Return-Path: <linux-kernel+bounces-778150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D58BB2E1F7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 18:11:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFA6560218B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 16:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29962326D56;
	Wed, 20 Aug 2025 16:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Nk2aej5+"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E519322A06
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 16:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755705765; cv=none; b=HREEEMUiYZ6yez8Cx6yIsnpFhEO6Bf+lb+8nNg3EpTSruZYF5OxRGEegwGlXkfWSmxvK3KA58WNtKgEHn/PGg+oSeqWcbiCZa8bUMeW3F9xxKPio40EX4SY2DTnDibU6+3JQzDr8qscg3512cJ0IxK2lhedI+e/R8fXMdC9LbtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755705765; c=relaxed/simple;
	bh=J9tk26b5d9valUn3AJ23BPP4CY9PZS2upYUI2TK7QI0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RjTLOA59rauztVCuatzNcILiBQJxQAB093AbfVn3v000DQgMtyMTeYkYXcUleu04bQreI+KSqbpfL5wbhRmcJ9yIzPo5zqYLKEW1J01glO1wzDaVvOAClR4MIPaHujsMLZn2Vv/fz4AZy1dl53VyIJbhgI6gdEqfg+I0LfKqHhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Nk2aej5+; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-45a1b0cbbbaso109015e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 09:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755705762; x=1756310562; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SDa/L/vLfvl5Q/JDuMqiafLyaLhOcwaxXf7Kgn9DrQA=;
        b=Nk2aej5+FL3m6VlEtkGxF9S8CjsFj2ivRw3PpaLk6Xot2jdIcq4WShB55LesLwb9F8
         tiPiBHVoaW3hlTs6YHHr57zJLoDTJpppgxywGXTCtRUXNugHu2hD5ZFn1M5xgY+eN4oB
         HQs4+LHbToBJv5cQDX4y4eqszCBG1SxdQBSanGg5iMHwI7QKZwkMFHnlExayYHLLQr7l
         Ccfse6M+iFy9KCU/03dF2+qUNi8ZVhzgSMxqtQb1dx+UH3RltjCKJRiaHhrSPj5CrJZT
         GTsenxk2BFOkTJebB12DqfUgMBCzqmMjHLt3Pw8Zmi4xGeHuU0WBY4mfNlfYI5993mS5
         FBXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755705762; x=1756310562;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SDa/L/vLfvl5Q/JDuMqiafLyaLhOcwaxXf7Kgn9DrQA=;
        b=jnLewg+4KOJ9ol2o0V0QAhcqYopw6CeykeWWSWHZ3GrIO5EBONCEf1s2XnRxFsBbLS
         ugsDYm2WfxhbPI6cAYBevNxdjkJ7WqHOhNyO9zhtOux0wQQpqAd6J1Ocz/tVE3vSTZkY
         Fd2jsDnwT8+w+pSt4Qh1VLC+KlAzd8BLoy3S2O3ZxEoyQVy7qTeBBfvEpbP5q9neoP4k
         2TCyutM2gtkgfeQhvZypCTirA7q4k6uepHLg4FR2rg+ejtoVQFp9Ll/QUru3SiJmVtXV
         H60DCBy+9J5SfxEln22zS3wvEA/vWdolGoCQuqAikXx4bWVa8BOK9M4cr24edOAwOy+Y
         Da4w==
X-Forwarded-Encrypted: i=1; AJvYcCUdtVAVR5pjajWFw4wjx3ah/VApFE0OlXl2JC/vC9jc+snQUjZHD+n5bYZT3HK7qUkSBh78OiR13xYAE8g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz13fio+BjcFksQJ39DnnDCfL1bczLKetlhYfTq90HgmLCTmsEP
	73Z7xngAvMrMmbcH1e5pK77MvrY3qTQkQVXtO6KQMtPRA8k68PURYtRY9XrAgO46f8M=
X-Gm-Gg: ASbGncu+sV6NCbVTTV+S6Znmkdu3UeKbPPme39Fvghzb99S6sfJJ7Bid44mLjbl7EA+
	uO+Q4/zaJQ5QGjZh7rbnKaj/ds75ti3MCkag0VNiz0NmHNZegqYGs4yiA8Tdg/eylHS+044wzLt
	PkxYenYRD81JAQwkaDG5MxTW9Gv15k6RaOmApcPGabvqK7VbGMoy4UM87Fex6YPzPOw+EOXYZIb
	XAKJrkZaMdyI6A4Jdrjq2lpo6GOIFyaDctc4qZPRvgJdry3wrD4Y1PCKPlBZvbY1JgKDfbOwFwX
	h03gmCeOfR4/Eiu41mtqZ3hNVXT431Lx/5QUf3EwxiyaRj+6G2K5ODl7xe41b4/bdScJ1HELDkG
	c2c7X6JImshwCMgBtXwKy+D7/5qphRFQQelqy
X-Google-Smtp-Source: AGHT+IEGtQPDjtGEux8eJN642OMcw5qEtkm8AZN7DXfDDbrt3JlPYakLqgOYzRpBWVMGssyGGPAxFg==
X-Received: by 2002:a5d:62c8:0:b0:3b9:7bea:149e with SMTP id ffacd0b85a97d-3c32c52bb7dmr1711279f8f.8.1755705761522;
        Wed, 20 Aug 2025 09:02:41 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2454:ff21:ef41:f5f2:96b:fcb7:af4b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c074d43956sm8364628f8f.19.2025.08.20.09.02.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 09:02:41 -0700 (PDT)
From: Stephan Gerhold <stephan.gerhold@linaro.org>
Date: Wed, 20 Aug 2025 18:02:34 +0200
Subject: [PATCH v2 2/4] remoteproc: qcom_q6v5: Avoid handling handover
 twice
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250820-rproc-qcom-q6v5-fixes-v2-2-910b1a3aff71@linaro.org>
References: <20250820-rproc-qcom-q6v5-fixes-v2-0-910b1a3aff71@linaro.org>
In-Reply-To: <20250820-rproc-qcom-q6v5-fixes-v2-0-910b1a3aff71@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Sibi Sankar <quic_sibis@quicinc.com>, Abel Vesa <abel.vesa@linaro.org>, 
 linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Konrad Dybcio <konradybcio@kernel.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.2

A remoteproc could theoretically signal handover twice. This is unexpected
and would break the reference counting for the handover resources (power
domains, clocks, regulators, etc), so add a check to prevent that from
happening.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
---
 drivers/remoteproc/qcom_q6v5.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/remoteproc/qcom_q6v5.c b/drivers/remoteproc/qcom_q6v5.c
index 769c6d6d6a731672eca9f960b05c68f6d4d77af2..58d5b85e58cdadabdd3e23d39c06a39196c3a194 100644
--- a/drivers/remoteproc/qcom_q6v5.c
+++ b/drivers/remoteproc/qcom_q6v5.c
@@ -164,6 +164,11 @@ static irqreturn_t q6v5_handover_interrupt(int irq, void *data)
 {
 	struct qcom_q6v5 *q6v5 = data;
 
+	if (q6v5->handover_issued) {
+		dev_err(q6v5->dev, "Handover signaled, but it already happened\n");
+		return IRQ_HANDLED;
+	}
+
 	if (q6v5->handover)
 		q6v5->handover(q6v5);
 

-- 
2.50.1


