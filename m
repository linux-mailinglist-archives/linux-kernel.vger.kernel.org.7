Return-Path: <linux-kernel+bounces-830644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06DD2B9A353
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 16:21:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98A921704ED
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 14:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93A8B3064AE;
	Wed, 24 Sep 2025 14:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Rk+uV1zo"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A668303C88
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 14:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758723686; cv=none; b=swVLH8vt4abJOvlj4EYMkcwxbDQWpmFiwc5Q+VYJyC1AKYpmS4JKCX+LseIC6CqQRrQA8jYWLR/2KixJ2H7qDNPcqDmqxPV0zWqaM+KqpYf2OuTLHD5kMPN6fB+TISuQcu3MDpXx2rO0a6YZ2tO2BvEiQbCYgv7GqZMiLk3AnpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758723686; c=relaxed/simple;
	bh=8Bd9BNziqvvbY4+frkt1YLGnyHQ7qyi67mb9YIWosgk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ufXGyzVMwHkC/IFUmXL+jtcWbGSvn8psyf5zv9bN1F2UHQ3/tCn6ynfh3fXHxqr+IF2HgWnifC+MYNcnjkBj0/pQdB2X6QUPRr8LvQX6bC1R8VyMKbiVbkSEsvW7B3mVWDgimsOC/Zg9SH2niUDK8lnaGfyTQ9YvT6okq8Mb3iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Rk+uV1zo; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-45df7dc1b98so43437395e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 07:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758723682; x=1759328482; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZUOwXMuTBpB5Fy7yoIxpDSUv9vUppjY8hnmiw8isNgs=;
        b=Rk+uV1zoCA9XTCXfPx3u63Nx+n5BmWFBDhdWMb2om6n6KkGt1VN8ZBoHTgaXGsMCGc
         L4JXBhHdtdqIPAXFjGOfmX8MCSw1uP/tQP0THTV9omNr29EIcnF2Dmeu7vHy+a79K8xy
         MRv9peIRpgTGXf1UC6txpfJnQ4tCHDdbzQdDDz3KGevQyGY4U7OB5BDVY5oohTEasyeQ
         PQvhDhkOtCDOzCe+usuEVcfHygWUC+0xfSQ1jMWsJ0xN9xKN1l6DMMr5GREdAhCVvWy6
         zFBb5t4CIUxGx1W7nS6dwy+YeAmDLVyz6yVrtD4EdlJX+Njdxfh1yA0m/L2wpIQOv1UY
         +oGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758723682; x=1759328482;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZUOwXMuTBpB5Fy7yoIxpDSUv9vUppjY8hnmiw8isNgs=;
        b=CVkJIpWoQb2mtoJBXK4iUHwhAeLv5Z+h22Ps2e24Xgbw3ZeAHVsBX8bmn+7Byvyifu
         mCH19V61iGzdFYT3ir4vyI2U9oFngItYI1YZcpFVSySW2VmTX9NTjjCgCHVtIcfGqc1i
         Q9x5WcvlDQSsTKfOof4tXl6NDiF386pERg6h/0H7y953k8a+USw+TMDbC+L9JXNXh5Gw
         xntTR9PMtAsMbx/M9AcEzuxJritrSy7Oz8p0T3B5dM/y6IqsgNfdN/KzRo5EbBWETgVI
         Ce/kQ4vMsV2wMMfvjuucbxMkuqXajHZnF3FXNnK/c7QaNYyXd8PXcGBEHLZRxI8biSlh
         9m2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUCf1WFoiYy9KUTsvUkqZKVvoUXdCUcIZ21tobRCmGiSv8Ebr0/kWx5eoVzp/e55QkquRpIYQKDmRsxGoE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrdLKw8eTRs0qPD6Iqs7rSj0JbG81bv+QrjnOQh2xlRl4+XIPd
	f7rljaEgts0UYv1LxSEkmzGVK3t4g7XLnkxO64yHRsDGc1vmKnVpEtJIZcNpEe2OaAw=
X-Gm-Gg: ASbGncttvKrCycAE5VNW1z9W7PVKdCgHRRPMpEdF3pPP6rBMSBr52fO3NiFdEE/inZF
	jiDHZkxcNoFkZLa1B3dX+SlUAQoG2kYZq2mw6gOICWpMzh5bzdnfNfnAdWyoXyZAkEDL1lsHOAD
	aVIYiL3fPXyMxCM7T182a6tdJpT0YJxEBUU+c7of9Dd/7rQBCcDTKfuYlQVflzsCa6qhoVFhLSa
	A3FrIuDk++kXdjSm+3sL3kiId2sP//fU4neJcIaf49kXoIgpE49pUmczZi7kpRqIs5liwE7Iu/h
	vOMRIWLbnwL5URCkTWf790ADeYOZ9gU7pWRcntSWZO54lhitNiSePuFmdhw00ZYqEBOOqCu+Sod
	bNveLvn6l7NdZOQljlatuSQe7Ic76
X-Google-Smtp-Source: AGHT+IG55pmdfKl6TOSmeMM1pq2EjePpFbf+bYc0kIwlIBb4cj5o/va5cZMOtuDRcr/jCbXXpn9noA==
X-Received: by 2002:a05:600c:19d0:b0:468:9e79:bee0 with SMTP id 5b1f17b1804b1-46e3292ea3emr1209375e9.0.1758723682187;
        Wed, 24 Sep 2025 07:21:22 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-46e2ab31f1dsm33992125e9.13.2025.09.24.07.21.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 07:21:21 -0700 (PDT)
Date: Wed, 24 Sep 2025 17:21:17 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Julian Ruess <julianr@linux.ibm.com>
Cc: Alexandra Winter <wintera@linux.ibm.com>,
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH net-next] dibs: Check correct variable in dibs_init()
Message-ID: <aNP-XcrjSUjZAu4a@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

There is a typo in this code.  It should check "dibs_class" instead of
"&dibs_class".  Remove the &.

Fixes: 804737349813 ("dibs: Create class dibs")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/dibs/dibs_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dibs/dibs_main.c b/drivers/dibs/dibs_main.c
index 5425238d5a42..0374f8350ff7 100644
--- a/drivers/dibs/dibs_main.c
+++ b/drivers/dibs/dibs_main.c
@@ -258,8 +258,8 @@ static int __init dibs_init(void)
 	max_client = 0;
 
 	dibs_class = class_create("dibs");
-	if (IS_ERR(&dibs_class))
-		return PTR_ERR(&dibs_class);
+	if (IS_ERR(dibs_class))
+		return PTR_ERR(dibs_class);
 
 	rc = dibs_loopback_init();
 	if (rc)
-- 
2.51.0


