Return-Path: <linux-kernel+bounces-725463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FB50AFFF6C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 12:39:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 804E93B74FB
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 10:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 764CE2D9782;
	Thu, 10 Jul 2025 10:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xgp00xFu"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A67246788
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 10:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752143941; cv=none; b=Ot+Y1CEsB/WU48zNSYXtCSoko5q7HYvL4TJrUqRHzRd2lPKxeFuzCLoPwuDxE4Gbjs3+g2tcSCVxAlyn3pGHz/Gkzn94LA4KtO63O4qwW3qLyXrxJjOHnmbdobcW555XN/NfErtJg8imY/77ZKHkLVzAH37Z7ZtLZnId6MzR9V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752143941; c=relaxed/simple;
	bh=bOq1S86mddNs1t3c+GIE+flM47EO6XwLKrs4d+t/1vU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=md5EnhasFjxuS/QnrLWUGETpW8ZfEk4Qzs7QdYhYVB+TatmGrFfFnA+xDW9YTpDzaYmfsNmHVpXoOupsB8AXON3lcLnA8GMr+UnCvtd7EUFi/bJaJ9ezWFRduCa5rahpbwGRDM4F8lec5+sb6cY8gqjgphJ85qAXXmDvk8Hpp6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xgp00xFu; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b2c2c762a89so753590a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 03:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752143940; x=1752748740; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MLPDqWFr7HY4ZL0X+/Ee2b+5Y/FPW1cep7YKLBKdVvo=;
        b=xgp00xFu7hbqxoNQkpYksbUlgScyAS0MlAhki8i5W/RgtIfm6SgiD5A+kqMIP2H8k5
         BsEOP1AEm+GCglG5hdIivQmkIRxPwJ3guCMOUcbxEK57CeG0aWYAKsbFusg6miXivmgK
         BTSl5uhA7OwyQFeTISjH6/E6vzJ2c+P5T0KqpEX8Ylxev6Ah/Axoj2Ijr7uS5R9TMIS4
         30v8hIGrHeup0fM5lNkOAqjY9TBaCXjJlxwZ6oI//wt36Mhc5NHUqtN1fRFsbhqmEIqD
         YtZhbysTRc5mnmtguTfc4C8i0BVpUlBxTqO+fd1gaWmi65KOnMwFxEFFoKPaJ5FjWbkl
         bG2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752143940; x=1752748740;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MLPDqWFr7HY4ZL0X+/Ee2b+5Y/FPW1cep7YKLBKdVvo=;
        b=qh2FhoT/A4k9AZQ2cXnUuHQ4vC0ilg2CzDUXiW/73n5LX7h98FNxJkru1423GR56fy
         3i+4SeeA0Ena1w6vVZzQ5hNkG6OyAmbk/fEdxSAqqj3Qn/SgsGovArWlvA/xRcXq/BmP
         Chz6BOQwr8QC/tZ0x2Ikyx7jTYLGBECuc9XfwRimtDFuZlZqCn0y8ccBkhDMB3bFbiBt
         E4SROY1+wQKNZV4tl9d+srHpjczE/BFnnpgRikoeMWmYHZpQUagtDinW6EUBVNOf7GYj
         MMinzleHqF/wnAoTqExsV3bjAj7DSk5iyt/nVSpdA+p4l8cem2P8wBRqaA9Hxqu4f2HC
         dkrg==
X-Gm-Message-State: AOJu0YxSBri5lAKTPw3ljYIKfNfIkuSrz/jB0lCPPIM1xcnGptScTiDb
	0XsXYixvijJLLvAQme6CazivtIQog74qhL+youyP2Kmp/5Y8vIfIhsk5Rk2JEt/7h9do33gKiOe
	0li5beDmZBASGo/3pgQJzelsdkAg310x8CI1Pj7zZZw==
X-Gm-Gg: ASbGncvuxvMuHkjXgLQ6Vv0BNLh72b1ND6Y+mergYJIkYVJTKzdnMdrN2Gu4zad6db/
	lMqHl67rdatKcSQXobiJ2rqabUzMr/NCQeRTGw6LBzEOwjD/dmW5YK/axd3mxzqOepzl2A8RGz3
	VesbQEUGt9ZZEBw5P2rRZib06za1ec7n1QewrqJFSBtKvKr8a/8gM/wmJYDDF87OZBQZColL6RU
	F92
X-Google-Smtp-Source: AGHT+IF9HrmL73KmCwDT1MWVIrgb9v//Mn1nJ3PtCEIP384xvWi3eMjx3HlKX4Pj8a+SRL4ABwL4m3N71r4QX1de5KM=
X-Received: by 2002:a17:90b:4d01:b0:311:d258:3473 with SMTP id
 98e67ed59e1d1-31c2fcffda2mr9114226a91.13.1752143939684; Thu, 10 Jul 2025
 03:38:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+G9fYvif6kDDFar5ZK4Dff3XThSrhaZaJundjQYujaJW978yg@mail.gmail.com>
 <20250709002521.GB1599700@nvidia.com> <CA+G9fYtOZLYe7yN7EdaEHLyJgVypgKFO2R6POoiEZv7PcLw+3A@mail.gmail.com>
 <20250709162609.GD1599700@nvidia.com>
In-Reply-To: <20250709162609.GD1599700@nvidia.com>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 10 Jul 2025 16:08:48 +0530
X-Gm-Features: Ac12FXx5xt6u8jalX3Lvwlf9RAo_uOe7364GnM5xmt0PiJa5mXcltsuEN5V11ag
Message-ID: <CA+G9fYti-72RmdttPNsSzBAxVyt-Oci37mOwCE=YGUR83hEa6A@mail.gmail.com>
Subject: Re: next-20250702 WARNING iommu io-pgtable-arm.c at
 arm_lpae_map_pages qcom_iommu_map
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: open list <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev, 
	lkft-triage@lists.linaro.org, Linux Regressions <regressions@lists.linux.dev>, 
	Nicolin Chen <nicolinc@nvidia.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>, 
	Anders Roxell <anders.roxell@linaro.org>, Ben Copeland <benjamin.copeland@linaro.org>, 
	Arnd Bergmann <arnd@arndb.de>, Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 9 Jul 2025 at 21:56, Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> On Wed, Jul 09, 2025 at 04:14:26PM +0530, Naresh Kamboju wrote:
> > I have tested this patch on top of Linux next-20250702 tag,
> > and found kernel warning,
>
> Oh, yeah, I guess that hacky fix is not going to work.
>
> Then this is probably good enough (against linux-next):
>
> --- a/drivers/iommu/arm/arm-smmu/qcom_iommu.c
> +++ b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
> @@ -335,7 +335,7 @@ static struct iommu_domain *qcom_iommu_domain_alloc_paging(struct device *dev)
>
>         mutex_init(&qcom_domain->init_mutex);
>         spin_lock_init(&qcom_domain->pgtbl_lock);
> -       qcom_domain->domain.pgsize_bitmap = SZ_4K | SZ_64K | SZ_1M | SZ_16M;
> +       qcom_domain->domain.pgsize_bitmap = SZ_4K | SZ_2M;
>
>         return &qcom_domain->domain;
>  }

I have tested the above patch and it fixes the reported issue.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

* https://lkft.validation.linaro.org/scheduler/job/8351756#L2565

--
Linaro LKFT
https://lkft.linaro.org

