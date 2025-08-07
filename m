Return-Path: <linux-kernel+bounces-759260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A5B6B1DB23
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 17:58:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E436584B02
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 15:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD476266B52;
	Thu,  7 Aug 2025 15:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I8canp1+"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8994D264A97
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 15:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754582311; cv=none; b=SF5NbHniycBpRwYhhmCdlSfcbN/cjiTfVNqDDNsYcT013k1YCnNA/Xw4H9Rm+Bx11eMQIOOzrVytpEuCf6RE1eVrj6g+pMW5TDTfi3/4H/IhRDymlo1AUxpJqtUKapPpg4UtrsCZfL13WY9OBFL4YqYG0K123+M1+rSLSRJOS8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754582311; c=relaxed/simple;
	bh=UebwSTgEBGX45jSwaqppv1MZDgNUsTmKmv0RDSYtYBM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=oemQTXXwsMic4rXj0Vw2GpT9LJAeXmgcblxfs8Zxb8y8cW+qkJcYtE4sozUCaLI1oVjkRr0Wn0FDJk1JVKfe9zxIm47bxJVtiGuTxf4EhHXlJmKwjhFeFh6zbU9yjWRngQEFtP9Bviz5QOhgkBdNDcPmS/boH//O65RAajgdkx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=I8canp1+; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-458b885d6eeso7457165e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 08:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754582308; x=1755187108; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ujGGaXLwvEaTDaelriMZ69/JBFsXGLBD07Z/REYyW1I=;
        b=I8canp1+HIYdWbmOTJfwAl3ic72csHSF9VQgrOjEGHQ4l8y4evhhxJ4ABC9uKGqKDK
         d3rGH4+lVZWpqlVguEXobU/mIpenQlinoV0jBumjFPSrcp6Sh2O414XnOrfwwY5pebp/
         Ml3SA/ZrCBYl+E/TcqcDK7nXtxmZO1uPgT+/HESLH1XMkscvtaqOKjNZR4G62c3UXpH6
         VPGlL0gkcaCFW8a2fAeUd/F4U8bhf/JWZoLlCv+A+E8d5UEXbLTGh5GNF0d7/Moi8tFr
         N4e2VQQepTLAOG1WCzXVe7ZPhJc2gVjdKnRdw/FuYdJeas6d4AXmIKYam9mTFqXDbP//
         Lbog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754582308; x=1755187108;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ujGGaXLwvEaTDaelriMZ69/JBFsXGLBD07Z/REYyW1I=;
        b=NRd/mc/2euDdcubOc95u17dKEnOZg+xrITw41KLt/qHqKYFkLaNtsZI/I289u5lMgQ
         DVOqGQJlkmU5dBLV3+FQVR68XkpIk4KGs8omQhDat3f/vpDnNdQ6hlMF17daVwM0vQFn
         2WMxcyGVMq/X13dv+3TUa1qeMog+HV9WbFIVX3uppEZ0LG8S7NOmc/wzG6gGMhbLLbLi
         iGMi1/il91w+csfAXOWqns9knB1Xinug4MvGTyFn9jRz262zs3un1k3l0mOr6PIPerjL
         Y8dYTWE/8SUav8xuzE5R4TxR69j1nL55rdrNwTC2Aq4+vSXXcVUw4pkCgbNJVuZRiRgD
         vCUA==
X-Forwarded-Encrypted: i=1; AJvYcCXPFlDwMufjbkt6j5eDRL+yo0sNybVKQnXOKDRp5C7itk7eO43vwyXdnQZyisTUxl9fr2td8WAIFtSUb38=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+mQRxqJx0xx8Ts1x2geqOKprmYEfl7LO16kVXciyxSqSsHQAZ
	TcrNQ4sdW3yjAGuTlT+odokaZLPAF0ZoTRCykEdRF/FcbMDQUHY7PkelZkTKZV0Cqq8=
X-Gm-Gg: ASbGnctyasEkWvfqBiHB7QHUvpyjk6SV+3mrdD1PYdzOxw94phti6S8Vau7eRwjHUa2
	4yVP/nSQvj8XcMj5ykjv1mfHSAItRoyAOLT9GLgcHPuvwU5dpSxrvWsLkedtLe1LeF4Znk5FxOS
	ZCftuKwQ25sAyCu1FxgRNzet9OLAe4coYAcmU0gEcW5VxRfOPReHDgZ/nQdt27lIDoU9Osfhelb
	q2nQh5+tmxhK+7Y0ETTgBIjf5PAttmB8OQ1yeOU1hpA9st5DOq4YcR4914mHRz6FQNlhm/PLysm
	wB2lPoggnL1Npcy1KXsCYAlhyCtx9ru2hKZ4ub5+/N6iV5LhdMJpqVFOMk/+KzVOIglKQTt/qwM
	B76mBbRoywvcFCTGkhOk/2RqYi+M=
X-Google-Smtp-Source: AGHT+IEQAtbjB5WuaftcfISb7loqx9lFVpOAzAnPzXuHW243UbLgIM9IVwryPWI9EYIwJTEBgNYAhA==
X-Received: by 2002:a05:600c:154e:b0:456:1a69:94fd with SMTP id 5b1f17b1804b1-459f431f845mr2720525e9.0.1754582307874;
        Thu, 07 Aug 2025 08:58:27 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-459e587e154sm108933495e9.27.2025.08.07.08.58.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 08:58:27 -0700 (PDT)
Date: Thu, 7 Aug 2025 18:58:23 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Matthias Brugger <matthias.bgg@gmail.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] PM / devfreq: mtk-cci: Fix potential error pointer
 dereference in probe()
Message-ID: <aJTNHz8kk8s6Q2os@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The drv->sram_reg pointer could be set to ERR_PTR(-EPROBE_DEFER) which
would lead to a error pointer dereference.  Use IS_ERR_OR_NULL() to check
that the pointer is valid.

Fixes: e09bd5757b52 ("PM / devfreq: mtk-cci: Handle sram regulator probe deferral")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/devfreq/mtk-cci-devfreq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/devfreq/mtk-cci-devfreq.c b/drivers/devfreq/mtk-cci-devfreq.c
index 22fe9e631f8a..5730076846e1 100644
--- a/drivers/devfreq/mtk-cci-devfreq.c
+++ b/drivers/devfreq/mtk-cci-devfreq.c
@@ -386,7 +386,8 @@ static int mtk_ccifreq_probe(struct platform_device *pdev)
 out_free_resources:
 	if (regulator_is_enabled(drv->proc_reg))
 		regulator_disable(drv->proc_reg);
-	if (drv->sram_reg && regulator_is_enabled(drv->sram_reg))
+	if (!IS_ERR_OR_NULL(drv->sram_reg) &&
+	    regulator_is_enabled(drv->sram_reg))
 		regulator_disable(drv->sram_reg);
 
 	return ret;
-- 
2.47.2


