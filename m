Return-Path: <linux-kernel+bounces-778148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17123B2E1F5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 18:10:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30588601D4B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 16:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1692525FA0E;
	Wed, 20 Aug 2025 16:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lxLUdCM8"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B56B32276A
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 16:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755705764; cv=none; b=clPa3Om1+yJlsk9KOXhbcXbaFNjIz/dtiuxo4qeJX4GZmPgWnLWwvleL78Vs1kjdN9PQ+zSKqnc+wedmxh7MBwaG4VhnUfs+MK/S3KZVtpsFLPtayVvoNjSIZ1h/oFCpDNgMvF2IcOZjHUl7dw5eorLEq5zLUB5iXtGwjmiPftk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755705764; c=relaxed/simple;
	bh=AuE9xsSC85xnCqMl1lnmYWUzXXJoeJtib/kNkW715Qg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h998UU74+SenyKcFWLmflahsjFOYq6d1YC2KKd8s791QZZxfjnd+tqBUbAKDNH4wgWfJznnZmJBFpwfaBRIzTvQ9EN2RWV76uKsvj0sBUrq7jKtWgDRx/KTEJHdphvfK5TXnlUmReYl2nOB7VUBBbq5PPjhFgRLET0ZI+wYmbAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lxLUdCM8; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3c380aa1ad0so52957f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 09:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755705761; x=1756310561; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ShZhIijPGclQUKdObNofvMry47iIISxjqJO+kVsJ9ug=;
        b=lxLUdCM8TxTAu4kSLD+bBZxm3ckdeok0ee3jOkAzD9AJWyL4Cvf57SVrQaifRrPUZb
         APEW4XhGAxq77IE6c4P6mYn0tCkJJyxgsWFELA+4Ush2uYaWcutTge0V2dE8/Svrzi2f
         pBF7dexwSmuVv8sMM4uvUSS5M1hqyqeJPG34hmkQsk4g+K9DMfDtyDhl4MoOIy6ObttE
         Ym8v0O/aRN0pN8/7NEzbp6w3Lvc1eZ+ilx2NCCkMcB9Ptihi2HOVmxof9WagpCHS6keQ
         PzAuJWodVGdDQfqCDiis3uRArTlTnhLPtSB/fb95gcJp+aVT9rstemfm+/aC2N50Zpwc
         fodA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755705761; x=1756310561;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ShZhIijPGclQUKdObNofvMry47iIISxjqJO+kVsJ9ug=;
        b=PjHQdIOPwcd7NnfM1IPTBjTYLLi26xfmL/GlDgTkry/SWaN/mmXZgosKvmS7vR7iSH
         FWbJlnFdQWpEW6LNGoL8ALjsA0cf7HaO6VEJpGvDz045S/6nub1GvqbDAFYe0AeOQeaU
         CxhvUZKlizprFSxr3J1RAgnTRIxmSARIUtZh1+5Urk4+fymPd5FTYbk8et2v6EH+J0dt
         m421LiCyQ1sGRorIk45tPDFB6eKaYm5vlNsjivbavNUOJaUoiMoP3aAcTd7sWfkiMafR
         +YSifGxE97NdyNQqfPr2QIx3GX3w8XLUP3ITNBKALaTqQg4b2Hd4HZoLL4trA8CgMoIm
         +Vyw==
X-Forwarded-Encrypted: i=1; AJvYcCU5gNCbzLv4bFzS75//LtN69hA742Dad0SU5Dx80I4Ezb+IVNd/LdeubuUoBe/5YEFa+vxigUfg0gyP9qo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmgLgEqXV+5X2DH1N+c6p5lEWRFYela/UdydbDFU+shxw8ZHMR
	pjPbJo6s6od8EgGw43/n3Fw4KfNU+n5WKM3QGxr1FJgQxaGj+Z+sO80I5QS8w5YidFc=
X-Gm-Gg: ASbGncvtZFcmvpFU0KjvrBjTHDYSQdTcQ5n1lKJPjfFkfdOAkywtjHnP0tL1NtJgfq9
	vw7A1zSXrftBNcKlT/7+XzCw3EIsoxGc5L+f2IB/UfB8MVgcLdCDIV1pSaK09KbDVXz4/ZBrvWa
	immAQSlzOXoGx2GqfL1zs+pCidm2YqnyGpYGw3n8ySOjZ4ExW78g9CSi3TLtbK5Gl2tRLitiV34
	t0cEh9R4e2ZBK2XmhrJdtbgstshewFad9T57HsXFa259tcHJLsy4S5Ohus4hNb/C3TTSSUGT3Z1
	k+R/9WsyCy6SnK52b+bdpOxNaryvVJbEE84bhJIkicQa7Xjx+gko+CkCSliWBMtAzH6YK+V/VOK
	r9amiHDTY8hb8VL5cBDuz2mS4V2v0zA61aluW
X-Google-Smtp-Source: AGHT+IG5dx4R83R85oNexKaNvANypEQgTudqcO+VWF9RVGmv2uV7QlWml9pzFQ9+qhiHJ4Pwd4vwVA==
X-Received: by 2002:a05:6000:250a:b0:3b7:7c3b:1073 with SMTP id ffacd0b85a97d-3c32fe1a409mr2287696f8f.52.1755705760657;
        Wed, 20 Aug 2025 09:02:40 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2454:ff21:ef41:f5f2:96b:fcb7:af4b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c074d43956sm8364628f8f.19.2025.08.20.09.02.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 09:02:40 -0700 (PDT)
From: Stephan Gerhold <stephan.gerhold@linaro.org>
Date: Wed, 20 Aug 2025 18:02:33 +0200
Subject: [PATCH v2 1/4] remoteproc: qcom_q6v5: Avoid disabling handover IRQ
 twice
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250820-rproc-qcom-q6v5-fixes-v2-1-910b1a3aff71@linaro.org>
References: <20250820-rproc-qcom-q6v5-fixes-v2-0-910b1a3aff71@linaro.org>
In-Reply-To: <20250820-rproc-qcom-q6v5-fixes-v2-0-910b1a3aff71@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Sibi Sankar <quic_sibis@quicinc.com>, Abel Vesa <abel.vesa@linaro.org>, 
 linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Konrad Dybcio <konradybcio@kernel.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.2

enable_irq() and disable_irq() are reference counted, so we must make sure
that each enable_irq() is always paired with a single disable_irq(). If we
call disable_irq() twice followed by just a single enable_irq(), the IRQ
will remain disabled forever.

For the error handling path in qcom_q6v5_wait_for_start(), disable_irq()
will end up being called twice, because disable_irq() also happens in
qcom_q6v5_unprepare() when rolling back the call to qcom_q6v5_prepare().

Fix this by dropping disable_irq() in qcom_q6v5_wait_for_start(). Since
qcom_q6v5_prepare() is the function that calls enable_irq(), it makes more
sense to have the rollback handled always by qcom_q6v5_unprepare().

Fixes: 3b415c8fb263 ("remoteproc: q6v5: Extract common resource handling")
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
---
 drivers/remoteproc/qcom_q6v5.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/remoteproc/qcom_q6v5.c b/drivers/remoteproc/qcom_q6v5.c
index 4ee5e67a9f03f5f766f04396b9a3e45f77293764..769c6d6d6a731672eca9f960b05c68f6d4d77af2 100644
--- a/drivers/remoteproc/qcom_q6v5.c
+++ b/drivers/remoteproc/qcom_q6v5.c
@@ -156,9 +156,6 @@ int qcom_q6v5_wait_for_start(struct qcom_q6v5 *q6v5, int timeout)
 	int ret;
 
 	ret = wait_for_completion_timeout(&q6v5->start_done, timeout);
-	if (!ret)
-		disable_irq(q6v5->handover_irq);
-
 	return !ret ? -ETIMEDOUT : 0;
 }
 EXPORT_SYMBOL_GPL(qcom_q6v5_wait_for_start);

-- 
2.50.1


