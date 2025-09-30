Return-Path: <linux-kernel+bounces-837642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65345BACD18
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 14:26:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CC2E188C929
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 12:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34BF52F9D8E;
	Tue, 30 Sep 2025 12:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oyO8/tl9"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF4A2F9C2A
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 12:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759235159; cv=none; b=ItpDg5ImQdcnGMCpmh+q/RKhspxyQgm70MtjqHBy8CbHUO25cT2ebUvTFpDfOce4gHP3POsklokotNEQBfS0che/fehQwNaqap0apCoLMRrFdYzEKdwuMn6R/uYxRHWr/SCm8jXsVQxqOP+BI3WYbbzOiqw42qcjWDTEGzAm3gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759235159; c=relaxed/simple;
	bh=yDrAqvbEaiFHI18jN+gtlF8I9zQtJDkqQPohZZEUvSo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=BpLM5Q14Dcw4qG+2fC0z+tTFe2wj6l03hHtmjB8nH/ixD5F9qsB4nA7VUtzpEPdj8VM9fFzhc3NhMsbdAwSvePrZZyJ6db3Cnqzl2SCoY9l8c8g1lL+9l+Je4WS0/wm5Yj6liblglDMYPimSyTXDnyJsnry70E8MrvI7Xbs2jJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oyO8/tl9; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-46e42deffa8so50200965e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 05:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759235156; x=1759839956; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GvPVBBH5vGqV3kuJKhWbZIWETLbBu5VFdtdFk49yg78=;
        b=oyO8/tl9vKUkgVEgBUNW+Bl9TTUl6tpOiXKGqrK8/e1QqNs8OAT8BlhbcoHRXQLkOk
         u/nrOxjg0QjX8aLWLXqv61Ppo9udbQ3mRXLmLtazlFONsj4JmY2PuKLZ+KEKb1ZdQdKi
         NdBdbQ9NDYyIZvIppeDZ2SPouOhekSI78MbNAVwTXQebfW7h3s5p7owcQjkkqE5paJ5D
         yozW2tsUggrHrdteCE8QWMcCHYJ+tJOuOgHvilaCGjcwlPtQ7Aq6xMxKPxOVU9nJF4nd
         gU/8NfUBmWFshNNgGIu2Np20v8kCTeT4cJoRVTk3JORvYmZgn6aoq31mO2AkDlw5BWaI
         ci7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759235156; x=1759839956;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GvPVBBH5vGqV3kuJKhWbZIWETLbBu5VFdtdFk49yg78=;
        b=TwjAXSu/ifvpxKQou0W1Gp9fToVxS4JlX5hXPYUtikDMZg26X7NaJBw5Yz1FOWKdSn
         vkUdVN4nKZn/qFlgc/2POxwBiWkpG0apSO3how6kDpJ8yRQs5ZBw2sJi0OH9OlvmxgM8
         EHUeL2u/sQE43y7Y94m1uTzGIeXobSjT5uI931pmgo5HZorDw2vWdk/K+MlTJSGW+VjO
         9emY3hPxi2i6x5gRYv9UTNM+b8icQVraiUWNscIZcyQGpvVXKs4KBZk2uyYP0FWdcJEj
         qG6uMegU5uSphrsmwT1CmwKWM07Oldlh36wxNPjEkTHpjMDkrP43MHYA6S/okYMLGqcl
         imtQ==
X-Forwarded-Encrypted: i=1; AJvYcCWuQK1cVOoZn+7/wiXw6b6GnBMdl2nGwcQH78oimPdNTzY0nRLO+sWq74PzJ8A6ytN2171+SI2M9IG/DzM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDR5ZDN1Zfio3xN0CI+nLU0BZjs4x1kBpXuvtwnv80xv+wU+aF
	kE+Xt/OR4Kd9zmk7Dsoa4u/ViWWMEdiV4fMA2w8Ftn6M1iR/9qZhEhPeEUKagn3VcqI=
X-Gm-Gg: ASbGncsjdFb7UIzlhIktPHs+ul/HDzPNUOG5ocTjdXkV+JggJIXw25z1zpCh9pWqq5u
	uX7JlVz5Y9WztMSKB9eQL21FFLj5wNgfHyZOFyhQxtkIR+xZee1JPo4L5UQsp74g3WphZUtv5rC
	qjHpaWXNBAYPQ1mVnIwlgtpBtJWagEr1dQ+u+xkQvSv2Mx1mccp5LG52Md5njirNO+RI+Rif3rM
	BfRaID4LQbUrFjG1o9KPoPkaa5hTWSBVXWi4XlHYOr0KFiBEyY3iHoajcg6mFnsBlKI5ODCR2JS
	LOE39IQxH9jOC3sctlKwa4G4O7HLaDa5aANsM+nYn8WhtBQNDT8TOuG7CTG9/FhoIReYqMA1/W0
	2QBHDNc5JReg98Npbl1xWU3w1VwsoXjZviIoRteey7t2ZkxaUVdlMAqii+tSFQeQ=
X-Google-Smtp-Source: AGHT+IHCMMkMmxX3p2DLBXTZhpA/m4X3bu/Jppin+k2ZScUSiWq4++pq+g8zHiUCjWlwdc3Xc6EA7w==
X-Received: by 2002:a05:600c:4512:b0:45f:28d2:bd38 with SMTP id 5b1f17b1804b1-46e329f9b5amr223551295e9.18.1759235156187;
        Tue, 30 Sep 2025 05:25:56 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-46e56f3dab0sm54160645e9.1.2025.09.30.05.25.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 05:25:55 -0700 (PDT)
Date: Tue, 30 Sep 2025 15:25:52 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Lu Baolu <baolu.lu@linux.intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH next] iommufd: Fix error code in iommu_device_register_bus()
Message-ID: <aNvMULgt6s7-3ceR@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

This error path accidentally returns success.  Return
PTR_ERR(iommu->fwnode) instead.

Fixes: 885add2e6be6 ("iommufd: Register iommufd mock devices with fwspec")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/iommu/iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index ddf398d8bcf9..59244c744eab 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -330,7 +330,7 @@ int iommu_device_register_bus(struct iommu_device *iommu,
 	iommu->fwnode = fwnode_create_software_node(NULL, NULL);
 	if (IS_ERR(iommu->fwnode)) {
 		bus_unregister_notifier(bus, nb);
-		return err;
+		return PTR_ERR(iommu->fwnode);
 	}
 
 	spin_lock(&iommu_device_lock);
-- 
2.51.0


