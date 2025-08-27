Return-Path: <linux-kernel+bounces-788354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EFD3B38362
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 15:09:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26C0A7A6C2B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 13:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69A0C1C8630;
	Wed, 27 Aug 2025 13:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CHkYUpoV"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20A633F9
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 13:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756299785; cv=none; b=H/Njr9AL/Hc2W9Pt3/wgTE9il+fX4Fa9XTBQXEhseB40uaK22Vphu1OsBQwdRsCnz28NLfGXbAS+83m4qN2LpcgjjGKAZ/wlk+tqZBRcGqCYWMKoQjTaLHiWZbZ92xVCZIr3+gBQ7RlkH0VjI0EUoIymPSiPLStMawLZ1xuUbmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756299785; c=relaxed/simple;
	bh=zx+GRYFooWpW9uCN18EKoluPmanyFaOpZIsBIGuITSM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=HhnWRLBYHgPpQHrIqXCS1TMQ/GHNqURz+beTYzNjyA3jb0ki+ucjvcXRuDGJYG2UjRbE80m25sY11ZCKw/RCukzxRnuXwOIg/jzCnfSLUDwrPFoXj0xcqev74wp5Ybh+Nljlk2i+zCt9/edCReF+90EroxTh4iAzHPFyXKUp/Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CHkYUpoV; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-45a1b0d231eso41433105e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 06:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756299781; x=1756904581; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JUBjHWZmJuNWePIdzQ6iJakPqEcAcCVwVw61Wzl+bZs=;
        b=CHkYUpoVHLht957ycyKcEN7Yv6nPFIrPyYX5rRhgpz+DmxJwnn4iVH+KKgkOIn7Yrk
         Yjgzl/kvAQXKAi84mLrbce87Wf/P9xBIeSt3mi1U9RZi83xo+5Yz+4C75fDOCip5lh0Q
         sxiC5ccsYlx/cYZauBK+HBBgcXP0BcU+me4HZxVYCiJW/x7+GykIkMiEG3uuqBOsjud3
         zUzawj9btwejzvTNCqfZ2L7tFOKoA5znZyT77n9GK1YcbjO8KXiR8mb4hU8JOZ5rywho
         URAC+WRgL8/AG4TrjacLOa8JsSL2agSpod9uMW3FgN8GPvv2OHhwSsPF6R9V0WJjx6ZX
         08zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756299781; x=1756904581;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JUBjHWZmJuNWePIdzQ6iJakPqEcAcCVwVw61Wzl+bZs=;
        b=D9YDUJDi/BdatI5jsrMZl1RhrwDAUNRbYJqLOQEPVGPutb1lGV2LIXDR6GPyWB4OmG
         +rCGT0bElEplPgUNnvUQAv4tVQ0h1t53ap0TdVycjyS6LPy4Y2ub74+NL2VoqFta7nF7
         6IaR63Nf9obQvWCzJdFThu20zGGzz5S4SohWa7Pf9bqkl+JmLTwxeeeYhNC7e8bq6PZZ
         dIg9LcAhitLKw+CKiBAwVmYG0M4ehs2QvlY2X7/bGf6G7Kv7Rv3QEEHJyoW5Ck4lLMtW
         1+wMLHZypq8bocB86DbStHE9S8nffTjoQFPcOyrrQ/TRK8tmvb88+2xVGZrbpHM0xtRU
         n/gA==
X-Forwarded-Encrypted: i=1; AJvYcCXpV4K8rVC9opHIiQKqwGaSMi6m3u4LZ299JcrGdti4C4SqCdvau6IPNnIar1jFOssg0Kmgjb5lcNGL668=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4bpZFkgJMBbwtF5KTzevZGTmri0J8Ns1M1K8zVHXxDPXbw6h+
	953c+nC0hkpZhieNz+jLS9vCUJLLkANsybkLDHOfg5ZuLs369hKGtrk/g4CAYLXjDZs=
X-Gm-Gg: ASbGncuFFm76+oaXpqfk0e7/OZoyKP0EDVsDBbvmUG4bDXTjrA3x4BlO8gILKQaeGIN
	aNp5Zmr2mb28b3iGCFpkr++obAxG2GttYhacMiRH0S3ym0E/NFIWzZ9cp50i94CA4jr7eIDDma5
	AwrQPDcwBiMzgQUsByWnr7BjJ9KKy9BEumvG4lNyrR1Id9/v/mDNcAAp2e7E2vnTWD6B0+pvAKJ
	1izaDxlQ6y4yEwK8XV+DF4UyUkF5T/cvpDR5XymAcQLe/mXAa1LBHM77LM8jmKcS4DgR3KUt/7p
	9q5jKl1JVqtHchuEfBPXoKyYjGGoxJw5kFib1mBnp7gI1TvXgxOR3IrpYdDddjs/TBYqmzIwapX
	H+9m8RYTKuOfS39dcLTkHmgP0MDc=
X-Google-Smtp-Source: AGHT+IELT6sCRdQHPl6oXE1cEnsudIW2S/Fsa1FNb4czZPQVDcQfdTiLtbkuS1heqEyBiDapqSdVYA==
X-Received: by 2002:a05:600c:4f8b:b0:459:dbb5:399d with SMTP id 5b1f17b1804b1-45b517c2fcfmr155117835e9.19.1756299781217;
        Wed, 27 Aug 2025 06:03:01 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3c711211bd7sm21044448f8f.38.2025.08.27.06.03.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 06:03:00 -0700 (PDT)
Date: Wed, 27 Aug 2025 16:02:57 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Jai Luthra <jai.luthra@ideasonboard.com>
Cc: Jai Luthra <jai.luthra@linux.dev>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH next] media: ti: j721e-csi2rx: Fix NULL vs IS_ERR() bug in
 ti_csi2rx_request_max_ppc()
Message-ID: <aK8CATf4EdcYcTe-@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The media_entity_remote_source_pad_unique() function never returns NULL,
it returns error pointers.  Change this check from a NULL check to an
IS_ERR() check.

Fixes: 31f91c5224cd ("media: ti: j721e-csi2rx: Support multiple pixels per clock")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c b/drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c
index 3992f8b754b7..b75aa363d1bf 100644
--- a/drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c
+++ b/drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c
@@ -497,7 +497,7 @@ static void ti_csi2rx_request_max_ppc(struct ti_csi2rx_dev *csi)
 	int ret;
 
 	pad = media_entity_remote_source_pad_unique(&csi->vdev.entity);
-	if (!pad)
+	if (IS_ERR(pad))
 		return;
 
 	ret = cdns_csi2rx_negotiate_ppc(csi->source, pad->index, &ppc);
-- 
2.47.2


