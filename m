Return-Path: <linux-kernel+bounces-836512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87EC9BA9E67
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 17:57:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C9C33A4A35
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 15:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DF9030C0F6;
	Mon, 29 Sep 2025 15:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="l7vjLTTZ"
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21FCA25228C
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 15:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759161447; cv=none; b=hk6Dwap+PHY4q3/CBllRagAhY8Sa5S/WW0M6JFY1LNG9QilW5ws1OLPnRPwBgpqCefg/D6MqI9A0IHjKvQnChv4EqVldbjgitrU//ZwYMO1tYjYzJsubv/LALwXexsXM6LGbkGuaPWb1GZkWkDzlfFNa/ZugxefUWK0fviDBp+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759161447; c=relaxed/simple;
	bh=7QbCbDrd6B4VUX/ig7npD513FdOAo1ndXjpy9P0UES0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k/9NKleS3TgR3kcnORMmtX28UmL0WBtKYVrk5+mj4W6UjerE/3kdEzuKcicRGvIA72DJlh5QIDOxZV2LWmUQ4KVyCWSeaaR/dCr6FpoNlh0+NZHAQeBrlXS+IWweAGIqzVMrH1VnkzOGQEDztvypNfUgjV7itvrvOJuxAAQsqOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=l7vjLTTZ; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-862cbf9e0c0so287432285a.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 08:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1759161445; x=1759766245; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rae0hraJRZQjoYrQUcng1cfyBx+zL1Bo8BbPQlyO8G4=;
        b=l7vjLTTZ42rhcyHMthojdbvpL5Fo9jdP16UBnKTa2ISw8pkfvk7API/cTGXfKowgLc
         Od440AGm+sRtMeE4aGULE9Pef3cdipUdjpcIg4YQWQ4kU1AZHkROyoMy0kMMWbpoo8FH
         9fviIg5h6p9oYUa3AmO+hs1iJA+HAOgPDVFfrB0EQ0sB5zG6yZoZfEMugS19vwWlz9OO
         UCaIV4YBWq2XE/ZBOS5mOCdXe35YM2MlCQMUX2ldHb5qewxbaC6+EchKza/9Ei0uKEyE
         Xnfzw4RoMwuLtaJVDt8JmSOc4HVljQwnPitNmflQrXi85PhfAEVOapU/o5cAWyWe62BY
         4rCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759161445; x=1759766245;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rae0hraJRZQjoYrQUcng1cfyBx+zL1Bo8BbPQlyO8G4=;
        b=wIWtCm4tGaeshkYd6Ek8UeA0Qmped4F4QMATLDLRbLaU6nt1jESjEnYltW6+SS6OJ6
         q4Y1bOz5bB2NilYOWRzYgSzkMuAqhLgMUi50ryJ3pmYpu7gFPVxeaTZnJToeuv9/maUx
         qjw3/IAyIKCq9gXOUEhyh2NNuLvJ0z9JReHxxLaEuWTDJCaEUYG1+j9kTr7EtZqw+6Gr
         S6BvY1ZWGmhZ2Q8s4YjoV/ojNWGfGXcgefYQa1xSrW/Et0xI658nWuLJpbHZtUkT4V/0
         MRTGY3Ag6UXnuEm9LQA/1uZSIEMmBaWP2dkdi9KErKKG9g9gaLeQd6lqa8xjmaq2ZeCv
         b8UA==
X-Forwarded-Encrypted: i=1; AJvYcCXMI6hsts1RNxUvrNmaCkU8+eph1bqNkcA40tcNinkdgj0Sq0NwMjP28N+durpAME3niJmRYAYzzli3yAs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOyf2dMH8uPELE0JgAyr16lsrYKf3Mk19bqfZO0kPHsaAO4PKr
	aqSzGFU5epAvdL57XAE/x72jYVclhNrUhbddo8hFOLIJfTSKhmJ3JxzxacfvWg3QADk=
X-Gm-Gg: ASbGncs7OsrstWuyginHYG8PxPuojJke608vV321A4+U0OiACCU7fje21ieHrq53pfe
	o9TUCizyQby6H/Q+FCLs5jLhZbLhtcxMTnlqYbaHlEsvOZqkJElj+EntuHcUnNOOQhJZ8BUlJZW
	8cDroHIFFiX1u20IOV8G3Wsq66xKKXeOK/a+BMHkiZ7fLiejddm/nPpjZb67caX6Tnedo64MD0L
	9mwIzSJ4i5dOc9BK4YTQR9Cwhfv8jAa7WVHRcu0tu7a5ce2rVKTOC2ShGbiJ1R6/s/1VvovJwTa
	4uEDpqoKyhzpKuHRJmlTIUS8gtCLeXUUadMjNpM9Evw6++hnVyfg61EG1aUHRLGSClz8sJIn
X-Google-Smtp-Source: AGHT+IEwPUHI08JC6OI673GcS8cwi1tgSzL6koeiwALjAQD9ty06B2a251wKjNfOuyeMLizVY7Kz7A==
X-Received: by 2002:a05:620a:28d5:b0:866:a24e:2eaf with SMTP id af79cd13be357-866a24e3319mr985596285a.66.1759161444827;
        Mon, 29 Sep 2025 08:57:24 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-85c307acfb2sm830379085a.39.2025.09.29.08.57.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 08:57:24 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1v3GFf-0000000CM69-2XTb;
	Mon, 29 Sep 2025 12:57:23 -0300
Date: Mon, 29 Sep 2025 12:57:23 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>, iommu@lists.linux.dev,
	Robin Murphy <robin.murphy@arm.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Kevin Tian <kevin.tian@intel.com>, linux-kernel@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Parav Pandit <parav@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>,
	Vipin Sharma <vipinsh@google.com>, dmatlack@google.com,
	zhuyifei@google.com, Chris Li <chrisl@kernel.org>, praan@google.com
Subject: Re: [RFC PATCH 08/15] iommu/vt-d: Implement live update
 preserve_iommu_context
Message-ID: <20250929155723.GE2695987@ziepe.ca>
References: <20250928190624.3735830-1-skhawaja@google.com>
 <20250928190624.3735830-9-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250928190624.3735830-9-skhawaja@google.com>

On Sun, Sep 28, 2025 at 07:06:16PM +0000, Samiullah Khawaja wrote:
> +static int unpreserve_iommu_context(struct intel_iommu *iommu, int end)
> +{
> +	struct context_entry *context;
> +	int i;
> +
> +	if (end < 0)
> +		end = ROOT_ENTRY_NR;
> +
> +	for (i = 0; i < end; i++) {
> +		context = iommu_context_addr(iommu, i, 0, 0);
> +		if (context)
> +			WARN_ON_ONCE(kho_unpreserve_folio(virt_to_folio(context)));

Wrong function. IIRC all of these allocations came from iommu-pages.c
and have struct page metadata.

iommu-pages needs to participate in restoring them and put back it's
struct page information.

>  static int preserve_iommu_state(struct intel_iommu *iommu,
>  				struct iommu_unit_ser *ser)
>  {
> -	pr_warn("Not implemented\n");
> -	return 0;
> +	int ret;
> +
> +	spin_lock(&iommu->lock);
> +	ret = preserve_iommu_context(iommu);
> +	if (ret)
> +		goto error;
> +
> +	ret = kho_preserve_folio(virt_to_folio(iommu->root_entry));
> +	if (ret) {
> +		unpreserve_iommu_context(iommu, -1);
> +		goto error;
> +	}
> +
> +	ser->phys_addr = iommu->reg_phys;
> +	ser->root_table = __pa(iommu->root_entry);
> +	atomic_set(&iommu->preserved, 1);

Why all these atomics??

Also most probably this should all be flowing through the core code as
I think the core code has to genericall prevent attach/detach/probe
from happing once serialization has started.

Jason

