Return-Path: <linux-kernel+bounces-836507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51BCCBA9E19
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 17:54:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EC933AADBF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 15:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D07330C0F2;
	Mon, 29 Sep 2025 15:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="eQhBEhJ5"
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1567A2FABF5
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 15:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759161275; cv=none; b=ZVwyxtzEXzSvLsdi5Tvo+yG6A1w1xvazyc8QBlLO7B2UFEBpyj+TpUMOdQ6CCByQrg4lrDa1GofLmLXJgy2OJghz1e3fUNMQY39j822kSrdoicOUriFiE/X33LHYrqNJXjo7pHg5Zo3dWFOM4R9vLmyUQtoBxX6AiQP9U/Etg/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759161275; c=relaxed/simple;
	bh=pxV7kBbXU2ByvzUZ1puidxSyC67U1iF/n3wQaH/iU00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=seHpUHBeWwBC47px2yDoLJqB43IrnAYSP3pnvwwfpqkOl2oNmWoSLJvOZxr0dCfqZU4ZrhCugymXR5zdHTGnB8a3H+GC6Ah8s6/8eAPGCHcvoBJuH8PEN8NjYdPqtMJ/n4jmjL6mY3WaIAvVeyzAykSzSoOU3XyTHhcR6icdtpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=eQhBEhJ5; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4de659d5a06so21552771cf.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 08:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1759161272; x=1759766072; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lc3yIVTCt7GESleGWEPj94fox63P9DXvd9ojEsera/Q=;
        b=eQhBEhJ54d00j1x/io5YL1iUM1PKxJqcZwBAW/i5jDUgmMOfsJVZN/s5ZD72YLWJrs
         5WPekmnC7PtV5vMGNtSImsCOUjnx+AAWk9jqpZdvzw/OBWNTo2kTbRUoofUsAEUla2ps
         tmqk9vQfAfhaoJvCaJKXbC0ZcTtggbFahLqC96vNjEY90K5yS0gBFGHY39YyqcwfsyXC
         2xis/Zjm97fQ+ss9aPoFy4+/FZo7MxCTdDFJ4CWii4eSkMdumrSW37HVCytlid+pzRUB
         08Ih50Xa5foCBAFwKKirBlhNLihbxDpgZXluxXk4a0Mrc8sk9zShkPoWuIjxURxCJ2Tp
         vIEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759161272; x=1759766072;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lc3yIVTCt7GESleGWEPj94fox63P9DXvd9ojEsera/Q=;
        b=V+olE9SiEvWZN465KCZotXEmcdOn5Rr4qXYjvE9Oe9xIVb6LsYilTnXjRt8wKFZpMN
         ZseZfKFGEL/jdunnay560aQU4iAcOWU5heMzpLiWyjXFKTAu6L07QAUj3y87ravRkYF7
         IwT0UCINp9ZM80ZgzfQdOmZ/RCYzuss2Vsp6pmI66cXnnW0FK5f/nj8Cas9rvnAdKAIj
         aPYXNFLAGMXmhu89Uw/yZWuKFFmtoqFp4XPmeI60qd8XLzwNPmKc/akk2igC1vK+unPx
         KtxxANjxVmzgj4ZP+XE157v//qWnT1YPu6yKttqYFOZfwmImhg8qEtjmV9tSSSnvXaiA
         KHjQ==
X-Forwarded-Encrypted: i=1; AJvYcCU91sKDOI5HalkjHeNe+7RV6In3a7XncO6DEqDNyOt5LeFu29vufRoLgmXaDMuV686LtO2mj5L2N7JW0U4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiznfL1+pmOJy2oJCDBjV3AKpgj6nAVnFJKpjZtjASQIQFI0QG
	p+kzfloFYCHbZzRGaB75BGHLcnhA2AKsWqIS3gO2jM5RI5xIsbPEQ9+CUPUfMl+fR2A=
X-Gm-Gg: ASbGncsdX23vA5Q9GmiQoi1tX9VFgyjUejS8v3HhoNV45VhV7pLBP6yb+6l5JFVnb2t
	xqnpUlXCgAYjM4+AVTb8suInD64s9FwPNERuBArn3qvoyyW3lZ8tdwitfnzqAfu/wJ1kbx1k+4o
	PtlLbTk3BY/94ErXcmpr2lAlYB0HC4b4cUwv0PBKtoaHgkLJR7XJJDEZzN3Vu1XZQE9IQI+9jah
	23qTUYvHwifxNOor+GMKgO23dt2RCPLy/rgo47SsGVU7M5hVNhnGoco4QqFSeVKyjv+KNW3Khhi
	jplugv7aqhxBxQTv8QI//cRhES6XUOfgewrpdoh094ybAl9RQZ+JBe3QgF8UvU1aF/bB+VK6I6E
	R051VDQ0=
X-Google-Smtp-Source: AGHT+IE73a8LyblCeUGV6w2tUddEWRBZht7Dzz/jDO6Cu/jrH8WHnHtrf2D16knXnBLwZow0GuMN6g==
X-Received: by 2002:a05:622a:13d0:b0:4b7:aa52:a710 with SMTP id d75a77b69052e-4da4d126930mr236668211cf.80.1759161271391;
        Mon, 29 Sep 2025 08:54:31 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4dfec096b98sm40112511cf.46.2025.09.29.08.54.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 08:54:30 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1v3GCs-0000000CM40-0CsH;
	Mon, 29 Sep 2025 12:54:30 -0300
Date: Mon, 29 Sep 2025 12:54:30 -0300
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
Subject: Re: [RFC PATCH 05/15] iommu: Introduce API to preserve iommu domain
Message-ID: <20250929155430.GD2695987@ziepe.ca>
References: <20250928190624.3735830-1-skhawaja@google.com>
 <20250928190624.3735830-6-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250928190624.3735830-6-skhawaja@google.com>

On Sun, Sep 28, 2025 at 07:06:13PM +0000, Samiullah Khawaja wrote:
> Add an API that can be called by the iommu users to preserve iommu
> domain. Currently it only marks the iommu_domain as preserved.

Merge it with the previous path

> +#ifdef CONFIG_LIVEUPDATE
> +	atomic_set(&domain->preserved, 0);
> +#endif

The memory is kzallocated, I don't think this is needed

> +int iommu_domain_preserve(struct iommu_domain *domain)
> +{

I expect this to accept some kind of luo pointer to signal what stream
the domain is part of.

Domains are linked to iommufd's which are linked to luo sessions. This
all needs to be carefully conveyed down to all the lower levels.

I also expect preserve to return some kind of handle that the caller
can hide away to deserialize.

> +	lockdep_assert_held(&liveupdate_state_rwsem);
> +	if (!domain->ops->preserve)
> +		return -EOPNOTSUPP;
> +
> +	ret = domain->ops->preserve(domain);
> +	if (!ret)
> +		atomic_set(&domain->preserved, 1);

And if we have a caller handle then there is probably no reason to
have this state tracking atomic.

Jason

