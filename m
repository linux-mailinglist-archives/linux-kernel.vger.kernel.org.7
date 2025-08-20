Return-Path: <linux-kernel+bounces-778152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 104FEB2E1F2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 18:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B86E41C86B0F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 16:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 684DA327794;
	Wed, 20 Aug 2025 16:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AXICg8kl"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5954D322C84
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 16:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755705767; cv=none; b=NLNU1AliXcP2rURV6tEbjcDTHdgsRZMqsJCUiR4RWdb9AiDrx9JofITHvZKONdzaEIdToD6YowB/J8tUuNi0aOBvX8nGfw20rcccw/Kfv7qFe8F/jLxPbbqs5QaJiieKH2LulkHlLhr1IsF5S7/PS5NW/6jcqiYPJYgThScV+xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755705767; c=relaxed/simple;
	bh=ceYKT3vSfgejeLJSxkGS10wrJuDMf2QLAgi1+YybTuo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nAPKVvEsOghZn/Bvp+pVN47gsS4z7oH4gvVXg5PwAeL1xgy4bWqf0+mVa8ukBbrRv7r8UOzSrlP239i78oiuUBmWlnANxGNvtkI/rvlnLNCrxu9Tk2+lZDj0Eb/h7SXSmYsBzBmcGl0Cfl1ChHeo3e+BB7ot6hmcgsh9Jj7mLTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AXICg8kl; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3b9e4147690so37104f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 09:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755705764; x=1756310564; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tjfVhv9eLkbIqBEE7fXFjARPFm2eJB57FpMUozSdD4M=;
        b=AXICg8klDQtptdu2WXQUS6lLMhl+jfNMcldtF2JtnPfZM1OCRCFGgQJRJCh+AnlqGP
         demvMr8uOMpO0nQklbriS+DltyQ0d6iVFIj3TKp072qU1aeKy5C51UwL71nSjALFs7Ts
         noJXVVraYsEnwo++CDDyAr1urdle8Mb1QxQPzBIMqTkNxhdURCrCL9+epjFYVpSx2iHa
         mQKwS9ujO9ujFf8+pE5yuR1I3R8L0/ZdJ0BqP0kKBzfpLCAvrM64nMu34J1V2dJhYTYX
         CKt5DtIpk2PNUru/IrrEsfzu8YQNYPiKZhgsKfMcVOstiwpKhOhJGnliVDLXHaXGHRU5
         AAVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755705764; x=1756310564;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tjfVhv9eLkbIqBEE7fXFjARPFm2eJB57FpMUozSdD4M=;
        b=wEknN4jGXBM3GLibxmIAZ2qf86V1sloz1AVGh1AQpy/KBKn95fd1v6LC1oEdS/xCqw
         +OQuMuFOhuLg2Wvq+ukQqjybH35DBLkYoqrrvgIMDmyXu9m7wxRH+NF8KZSJi9DT0wkh
         YtDYNMXgSlvOdb33/CxvtDBVyeeZoY3Gf+IdhDXWgeQj9JtajuX35/+Ing7CMg8DwpMP
         OwsVHzG+WtVSatwN9HMRM5G4atvUsUtTEckmwi7K5Go5cMl5Zt8jv7rbk0aqECcuFg0v
         q8RSU/r0O/QaDLYUuBgzUstJFfN9DnE5cwrd0yjQgVyClfC8gwn1mf2jotLN3owW9DBi
         itHw==
X-Forwarded-Encrypted: i=1; AJvYcCXQZWysVQZkE+C8mPU04CD2Tk9Smsr1+QOcyx/dYuoe6zo6fYNUh2KMazzc+SvIHtWwC4ZBkaAIydPI/Wc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxT8N4JwFq0Cv2SUyNOiFVXbWb6fjlGAwLKd8SIa7uyYnUREsfs
	RigH6+lsT5hiHCJtQ+4v0KlQLDQjJORpsJ4JmLUgeDh056A4xrQYmOlqHlTzMCqxy6c=
X-Gm-Gg: ASbGnctOnQY5w/opVtF6apO1Vjj4x3HGU34NycEvsoep1zKhkRBUbH9utdXqS1qyg2V
	Q3YUpCtRvnt1qrKhQ0hVZ5d3YGrSzKXrIKlejn1Bt8BzXaCA33nRSPWNtBkoCk6BSTLlCXhHx83
	jHMZd0NYy7DbJwSGGT177sIIl5uh1HuVQ5gfk5Wv1xNgtITCTW6XQ/V7Mi4FgiqqcREnmEbHLY2
	cksHmhvceW69x65FPR9KZyNuGOf1z3aLRKzUqr9A8xP/AK8g+opFQ/sx5aJkBjLuekAwkKDAeRs
	w/Ij6gOC0LtKuntsw9B/MhRtKPNRc3T9nPiW66120KsEnJwmGsy13DD8yaSx34MYJCmFVbnt+6F
	MbRcS3lYBPM8xTTMjwE7qouE8SHh9tW2i3Ffn
X-Google-Smtp-Source: AGHT+IFhMcKbAMu0PvVDiGeVBMEhgCK2n9Gg7XUc2NrwrVFxoYM9mheSAsCoD/kyMWNfHdDuo2ptCA==
X-Received: by 2002:a05:6000:4313:b0:3b7:8fcd:d145 with SMTP id ffacd0b85a97d-3c32be67bdbmr2961716f8f.5.1755705763407;
        Wed, 20 Aug 2025 09:02:43 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2454:ff21:ef41:f5f2:96b:fcb7:af4b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c074d43956sm8364628f8f.19.2025.08.20.09.02.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 09:02:43 -0700 (PDT)
From: Stephan Gerhold <stephan.gerhold@linaro.org>
Date: Wed, 20 Aug 2025 18:02:36 +0200
Subject: [PATCH v2 4/4] remoteproc: qcom_q6v5_pas: Drop redundant
 assignment to ret
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250820-rproc-qcom-q6v5-fixes-v2-4-910b1a3aff71@linaro.org>
References: <20250820-rproc-qcom-q6v5-fixes-v2-0-910b1a3aff71@linaro.org>
In-Reply-To: <20250820-rproc-qcom-q6v5-fixes-v2-0-910b1a3aff71@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Sibi Sankar <quic_sibis@quicinc.com>, Abel Vesa <abel.vesa@linaro.org>, 
 linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Konrad Dybcio <konradybcio@kernel.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.2

We don't have a way to detect if the lite firmware is actually running yet,
so we should ignore the return status of qcom_scm_pas_shutdown() for now.
The assignment to "ret" is not used anywhere, so just drop it.

Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
---
 drivers/remoteproc/qcom_q6v5_pas.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
index f3ec5b06261e8bafe8a8d2378b60285d0855674a..6faedae8d32ef6c3c2071975f2f1e37a9ffd8abe 100644
--- a/drivers/remoteproc/qcom_q6v5_pas.c
+++ b/drivers/remoteproc/qcom_q6v5_pas.c
@@ -227,7 +227,7 @@ static int qcom_pas_load(struct rproc *rproc, const struct firmware *fw)
 	pas->firmware = fw;
 
 	if (pas->lite_pas_id)
-		ret = qcom_scm_pas_shutdown(pas->lite_pas_id);
+		qcom_scm_pas_shutdown(pas->lite_pas_id);
 	if (pas->lite_dtb_pas_id)
 		qcom_scm_pas_shutdown(pas->lite_dtb_pas_id);
 

-- 
2.50.1


