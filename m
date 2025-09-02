Return-Path: <linux-kernel+bounces-795634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65DA6B3F5A2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 08:36:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F1F8485882
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 06:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E76A521D3E6;
	Tue,  2 Sep 2025 06:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Gc7zpXVE"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5A42E4278
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 06:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756794947; cv=none; b=hdpmdjr+OLzftjTkWR+3A3bNN3SyO153NLBfB59F1iw4cxdyaNZ2k9svCAhxcwkIaiY286Xnt+TUY9Cj6reXMfxAXpKGrEOi/3ighUYsUVUrz5l51dZZ/xUy97oqmlQET2Z7PXOLnpqICn79lEBoyXj+QZwuOJG6IGlQvn+zDso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756794947; c=relaxed/simple;
	bh=3XCFeTo1QooiKS5/4iHk0SqtVwnWNCRnwlawWc24QQA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=m78RIQ9l9XES0u8XV98pY9NuB+2OvsbCmn5Y0bnc92aceLRjh5eEyvqZOrOa7D5wDar+Yx02cSLFNLElYkMFcl/+aaodTJlCUSNFUBvKGrkq/T8SZJUshGp4D7BAV/1ChW22mpx3KaSSQS16AwChehBRlb9TI4QKkLISGwYz1KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Gc7zpXVE; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45b8e28b3c5so9103735e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 23:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756794944; x=1757399744; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o6dRSOg31Mko9p5tril5Cb2sG6ftwSr6FMGcLX9f2c8=;
        b=Gc7zpXVEVtLLoVJUiV6wMcHJDRyj6wshqVg4MlFC2FCXwMIgMkyACyne9BeCRVSlzp
         sNIuOR2VZ3tIxIbfCh/x2tt9hz4gdRLAV6RQxm6tF0wJV59hw/MZXBB3yXrqyUVbzhPk
         D9eWg+g8LTioo+taKOSd3i3fyY26KU/fhoOur5qR74HmZK2mBtSl+nAhamHFHk+S//xt
         Ly6aoBax4gfCzbmhvoPX7tAF4JFtKiZVtuAxPhgI8GZUMhhNE11ZdMbF9yhPcbvUKPNb
         joZ9QojDniH4ji1LpXEBk021nJopHVMFDBB/OZaJjBpcte5LoQicQ8lKCmNB4tAqg/Mx
         CLvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756794944; x=1757399744;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o6dRSOg31Mko9p5tril5Cb2sG6ftwSr6FMGcLX9f2c8=;
        b=QNVsRz2MfJ/mcGqlnWbWXJoBZ+0/H12mipvFdTcqn4P7YmwjUn7HkfUjnbhmM+g1OS
         JAvNfGEH04CzWtfbgQHnXaThTWk5S3NmdgsC2GXEgDfd/TyNcQYU/yZYfCV9FVHWJ3aU
         Bn9XCu/dO5P5mkyzAWy39uU99UfsPPvppdo33D/n4J2zWugjLTkXIt7Tf3rENeINPYLg
         IuMep8e22nbsrrsz4+PDHUJzMSs0t5a6FdXCtmcFmNw0fh9rBR3rnDm6uErvSB0tjEyd
         Z+bR8AtDaENCo7c63GDn65Xibwm687N304Ivt+1iDyC1ujHEHbqbGfLMNjJQHfzyzcPU
         n8Og==
X-Forwarded-Encrypted: i=1; AJvYcCUbpK61k5q2lH9yuXbBZJzESIw5MydC0ZSwrjwo3zwHZXe6xVjB4OZQnecHOyZ2NfA7Zt7ZS2q2xKmbfnI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9h8GoJTc9hgidEfd5/bjpql1Ay+vbLx9yyAq8vyHyhw2PtT1c
	TO8VV4aibkXAQhDsLkflMGJpaSxeHwKOKmCwJQhHscmwbABBVc5iXDmvexyoMR7dsPM=
X-Gm-Gg: ASbGncsfb31WQrtaA2a1E5tS/AGjtrBJNgH5I15srsNMkz8wV5naStudnwktp+3OlBd
	HsXh1kzUq1xVlyIRHbFIH2dvInPPCjBAqotIpZ2jePOAkUn1k3yrrGkm3sLo9USkyf4zwetjJ6j
	/cn3+RzHG4EuaNwxE09smWg14d74IRloLDVS0RxW/9vDZxyQ7c8gQMGjlVNK5i7Yek1ZPowCsqK
	mxIPCuEoABtAhGqIKa+FjZXAbewZCcyqUKt7oDVnzfU/SkH9FYDslaboYY+NGJNORsAGCWSQMcI
	figeoFxqsBzG/Um8riaZCTAAd7hJBr0QLavnAs80KwIiNL2uvxfREC+XLLUdy/ZUOU7a6sNSPmT
	mRd42viSbiiWQZwzmo6u54eJFY0M=
X-Google-Smtp-Source: AGHT+IEnfjMtfmIxXQ+PI1ax+u6+bozcWFK3bQPZnYJtBudvpfl6k6o2nsV602G8vQ758YC6q09N3Q==
X-Received: by 2002:a05:600c:a30c:b0:459:e002:8b1e with SMTP id 5b1f17b1804b1-45b8c05a036mr43636325e9.13.1756794943784;
        Mon, 01 Sep 2025 23:35:43 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45b87abc740sm117736355e9.7.2025.09.01.23.35.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 23:35:43 -0700 (PDT)
Date: Tue, 2 Sep 2025 09:35:39 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Ben Skeggs <bskeggs@redhat.com>
Cc: Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Gourav Samaiya <gsamaiya@nvidia.com>,
	dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] drm/nouveau/acr/ga102: fix NULL vs IS_ERR() check in
 ga102_acr_wpr_parse()
Message-ID: <aLaQO-dpTsHJ-oH9@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The nvkm_acr_lsfw_add() function never returns NULL, it returns error
pointers.  Update the check to match.

Fixes: 4b569ded09fd ("drm/nouveau/acr/ga102: initial support")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/gpu/drm/nouveau/nvkm/subdev/acr/ga102.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/acr/ga102.c b/drivers/gpu/drm/nouveau/nvkm/subdev/acr/ga102.c
index c7d38609bb7e..aae96a94acee 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/acr/ga102.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/acr/ga102.c
@@ -218,11 +218,13 @@ static int
 ga102_acr_wpr_parse(struct nvkm_acr *acr)
 {
 	const struct wpr_header_v2 *hdr = (void *)acr->wpr_fw->data;
+	struct nvkm_acr_lsfw *lsfw;
 
 	while (hdr->wpr.falcon_id != WPR_HEADER_V1_FALCON_ID_INVALID) {
 		wpr_header_v2_dump(&acr->subdev, hdr);
-		if (!nvkm_acr_lsfw_add(NULL, acr, NULL, (hdr++)->wpr.falcon_id))
-			return -ENOMEM;
+		lsfw = nvkm_acr_lsfw_add(NULL, acr, NULL, (hdr++)->wpr.falcon_id);
+		if (IS_ERR(lsfw))
+			return PTR_ERR(lsfw);
 	}
 
 	return 0;
-- 
2.47.2


