Return-Path: <linux-kernel+bounces-836518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6D73BA9EAA
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 18:01:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 234863B08A5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 16:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0456A1FBC91;
	Mon, 29 Sep 2025 16:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="YfpxSTIg"
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6BE91F5847
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 16:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759161648; cv=none; b=JJn/jBa/elQCsE8oLmjyx0JqzZMY3IwwJp4lWyE9fORop/ETmtQk0fC+GglE+ELVB4JxQ6wqbrTmDg3i9iCVJFXsjWw5sjCSclw/btucmnYWa5kyLadW/0PhSz10IubkBYJaGrt7P8pNEkBK00hXg2clGS+i/x7R2pxihOq8BU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759161648; c=relaxed/simple;
	bh=U6AnvjRGp3O1qm/RyZLo8C0gFo1427DERoRZSdj0BTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tcnUWtN7gNhde77WLvXTBZ9m60dCNByTRQhG1QYUwmwSL6yGlfYPEVmbxXrtcGL0R07uKabF848nYbEz0/KHpSi6STTIJfc0kYTJanqGnSMjmU8lZXR/cEeaPi+DnDh5TFx+CWv7SJ/udwmhmvrEpzjG+JuL1lLDqy0eCS2GnUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=YfpxSTIg; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-795be3a3644so27156926d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 09:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1759161646; x=1759766446; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xLG2JR9bcUzJhF49OBS0iB78RdPUmnc4lDRxtw6BiAE=;
        b=YfpxSTIgfeW4cyM8j6rSAtvg8dvuwLs5l+rexwB+m3NINdSmzZoKLKyxwUX4Ejo9qj
         +isw4hYl9uxOlN1SHowM8PK0fKG5pY4amNPzM921GDKNlozm+eTi+CcRgbpL97f21ncc
         TNc6ljKutISHqdHAzzyXCP9KAtFGZnonwP1FTq1ZHuOdutp65z+zfjY+oj962C/hoRe2
         nbqe3t2u9u4zZD+qsPg2p7Cpk31TCqRA19PzHDD57iy+SUU2o7keHukwxbnoxVSkEjqN
         y8RCG1VFk9xOAvs+1xL4UmyVE26n7mcaU/UWhL7MVp8H1TaQbDw88p4/pPOsCUL2Usyl
         cdzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759161646; x=1759766446;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xLG2JR9bcUzJhF49OBS0iB78RdPUmnc4lDRxtw6BiAE=;
        b=Hd6xpU12AefVNaUdxDkDE+KkWT9dcxQifRlRt40f7+wQYIUmEWH94R9b/wsU2UBqfh
         widKDvb9suX3vHLYLdRprpvCjZL06MtX0lsPYMQDoTXf8TvYV6AHS0yVOK8pKBUVwDBe
         KsUo4McHIKZx+NWvYWWnJeRuUQPueWUhCkS/D+4K5A3M8sgs7fkrpifjgxerZxbOy2+l
         acM/vgA0rQTPbOqQoWfC1uDSofsrJy4aPMqEwHjq0xp90jCN4i/7H6R+3JCtJXDqcpyy
         NE+ceYdrQRLwgTQ+z59NyoCq1e2JpVwxDRMPah7GJjIWPWtNgVHmJ+hXFVl2mizaLRRl
         aYlw==
X-Forwarded-Encrypted: i=1; AJvYcCUOT2534yKFNk+1W7zhFZLmGHYod+Uf1yX1ZVe327xB4RWQDvpa/7A2BuEFyJedhNkj/O6xMcaL/6n0ekA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvvPjCs1WdMBjZS6Ci+bNkKzAy2H2ohfVHHgK74OgDBMXJNo6h
	cAFAKexnk4Mo8yyQQOL1rPcZAKeFauUx71K58/aQ6rXANfGTmZLVNlYEdUZpHZTzAxQ=
X-Gm-Gg: ASbGncsIJBbObfHOSx7QRSoGQPloCsExFqASQr5fYtf6FTyCqi/LLa2IJy6w2Md2brw
	4FmG/v9USakQuN2QzvjGhAY87zweNAlsQRdpv8yypEg3rrIzVbYGWdZ/cAoKLkqULPFrWr5gXGh
	SSpNrl3MYTgzyY5i0WuIA3Xla2T9pSRUSKNqcrxCOJaPb6phatIZsj3ZULleJOL2+QA6m8igCfa
	fAN4Y7fm3L/Ei7bb4A+gGKw1yk4wfFCK6uDv090dUeup292EQ2kO9FUbUJwcQ15GYz8nuK3IgRR
	Be25tbMHfQt9RHYUclYvNuchr/1oCwU7Gfq3fgZeWHhSCxX41/U8NxyTSEJ1zWRL/qa0Bxwicfg
	Kpsq4dYM=
X-Google-Smtp-Source: AGHT+IHz2Vje0PqzhbQ26O+lHr4KWI+mNgBaMfoJbiwF/Viar3gDMaG7u6LkyDnLmmdBy1asKxIVKw==
X-Received: by 2002:ad4:5dc3:0:b0:7f7:ee24:9048 with SMTP id 6a1803df08f44-7fc2b7661ffmr266870906d6.16.1759161636381;
        Mon, 29 Sep 2025 09:00:36 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8016ce9a3c0sm76267316d6.53.2025.09.29.09.00.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 09:00:35 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1v3GIl-0000000CM7I-00iD;
	Mon, 29 Sep 2025 13:00:35 -0300
Date: Mon, 29 Sep 2025 13:00:34 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>, iommu@lists.linux.dev,
	YiFei Zhu <zhuyifei@google.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Kevin Tian <kevin.tian@intel.com>, linux-kernel@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Parav Pandit <parav@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>,
	Vipin Sharma <vipinsh@google.com>, dmatlack@google.com,
	Chris Li <chrisl@kernel.org>, praan@google.com
Subject: Re: [RFC PATCH 13/15] iommufd: Persist iommu domains for live update
Message-ID: <20250929160034.GG2695987@ziepe.ca>
References: <20250928190624.3735830-1-skhawaja@google.com>
 <20250928190624.3735830-14-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250928190624.3735830-14-skhawaja@google.com>

On Sun, Sep 28, 2025 at 07:06:21PM +0000, Samiullah Khawaja wrote:
> +static int iommufd_save_ioas(struct iommufd_ctx *ictx,
> +			     struct iommufd_lu *iommufd_lu)
> +{
> +	struct iommufd_hwpt_paging *hwpt_paging;
> +	struct iommufd_ioas *ioas = NULL;
> +	struct iommufd_object *obj;
> +	unsigned long index;
> +	int rc;
> +
> +	/* Iterate each ioas. */
> +	xa_for_each(&ictx->objects, index, obj) {
> +		if (obj->type != IOMMUFD_OBJ_IOAS)
> +			continue;

Wrong locking

> +
> +		ioas = (struct iommufd_ioas *)obj;
> +		mutex_lock(&ioas->mutex);
> +
> +		/*
> +		 * TODO: Iterate over each device of this iommufd and only save
> +		 * hwpt/domain if the device is persisted.
> +		 */
> +		list_for_each_entry(hwpt_paging, &ioas->hwpt_list, hwpt_item) {
> +			if (!hwpt_paging->common.domain)
> +				continue;

I don't think this should be automatic. The user should directly
serialize/unserialize HWPTs by ID.

Jason

