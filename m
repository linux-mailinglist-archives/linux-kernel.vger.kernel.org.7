Return-Path: <linux-kernel+bounces-836634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63087BAA341
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 19:43:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0ED471653EC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 17:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FCB3220F2C;
	Mon, 29 Sep 2025 17:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="NDXrUnVy"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF4F19F13F
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 17:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759167794; cv=none; b=t7xNLp7tZebCYyYaIIEV3e3B6G+Y1pMcNbyNXYoSVu9x8tPhs4RkmP8Asr7YY/yVxHMeTnQtgllp2UfwlXcRp3uVrlbOphepMa7JrM+RjcJDI9ospJjBncXFLG/rQ9Fmd2p9kN1G+LELpUJQkhGT5rchEpkwfOaTN1rTeqDgWhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759167794; c=relaxed/simple;
	bh=3JVKtBMAMZZBZ5zOL9O8wIoDC8qOntu82iaKyXHAYrE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lBXAcYZC3TE7XRepjuVA3widlEct2ZgT11ACHXdRBs2sDSW4Rpd/B01qF75w8SgrkIWcYzgbQ/JaVbFqbmS63WJUPedzlnV4nAWgrsEc8VDb/ghSxz1XfkUB/SLKYodJcC+jEUsJ/fKfKOFAtSdjMGJ8Bcsf2R+a8h32RK8Eg4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=NDXrUnVy; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4db0b56f6e7so42748251cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 10:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1759167792; x=1759772592; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hTb85gQ4f+/WEhJAyT+/KrdoEgjCXeB2waAEe62R8S0=;
        b=NDXrUnVyHCLTQhjnntReJTCXKjb0tR15zbltEKFrHwRlOzIyqg57FD+XaLy1EDvMnM
         sgeCMUd6rHEwHgJw2PT1RL0zpn9V2/28AVKzGdNhE3Zb/3rvOufYSC+gROM16131MKBI
         71xxpYPZgNIl04hB/Gxvkg/gPo3PBBvG6HPhyCCpckKZgDd8wZz1eKh0S2AXG+am8zRx
         tgrNBPTJQbFlPewtj/T0wgn3f/uPJe5R56rZau7iZy50nSiTOWbGUuyBMWa6MYzQfZnT
         xo61lILL9CWUtSL4N1VFFMD4dSEoiTF6UHcCprOZeqZ6mfxHMgPKeMIrThH/5P9RJVgS
         PJmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759167792; x=1759772592;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hTb85gQ4f+/WEhJAyT+/KrdoEgjCXeB2waAEe62R8S0=;
        b=FB5qngmsozISiUFGa3Q1rG5M8LuvQqn/fSMLawKJD34DzoDO0iL6CSxXHRh6wg3t5y
         VT6C5xk5qivztnqqmGqu3utTOyC5ApmYv8Y2O6nNjH02SVVB2NQXKkKyxxZrPBvanv+p
         f41HUWSoi445pNzU3s4lqFvYNNtU76Q5oHMA5UXzRcSWcvGJ+carcyFe0Fbt4MrVOMfO
         SZ6WHi2Gnz7zSNEQQ3bvHjc5Mvl/RpGoxa6FqFZsCGDKItgfA0dNLn+EL2tMgk+ERNn8
         UdmSvIw+z2UUHzS9NpgTcLjTaoZRWjl6B+/o7+4+R9wpdlPb4BDQDP6b5ClQI5aeGHB8
         DNeg==
X-Forwarded-Encrypted: i=1; AJvYcCWZXPHOYiY7npqMVAGaPPy61p2WX+OQNQRAcSjhTjz02qStPf/pgGxd+txVf1tfSi9vOhkVG8aWcsn4w7o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxO2ygIqK7azILIe88CV5m6D0X5HsDHWu9Fl3/AOu3bTqhwA7W3
	Q+VXWSD7Rg4cLKgeDLKk8wnsqgVpw+haosjP4R9wZNAjULMCsfVCd30OENuehZVT0lw=
X-Gm-Gg: ASbGnct+t9wUP3NeXcKHfn2+B5am1wGcZquS1aViSMRW2TAOEQxVSPcsLYI1f9Dwgje
	f/XmVZndESLjmjaVpeYeFuNnSrb0egvGtHFHFxIYQzwGkd0vGmn45QoySrflGiV6uD8BK5PYVzP
	7XaQ3+WqxVGJGLWHyQxcwRt/OunGTOMMqiJMHDDXZko1z4AIXP8Oi0TpROtHlAuWl8RMPJZGurg
	wMUpkXl00obdehpLU7YdRuJZvOlKaxJO9y7e/euEgINg/n3ZHOocVr5ZZCufu9LvK5D4IjnrVni
	H6easxgvjU+fnxNhlcKQk9zDz9F8w0XuC5JmFmjdPVamvqmcIP7fDXufO5ePEb4c1J9x9RDc
X-Google-Smtp-Source: AGHT+IFOpDHOnY9/ayuIhdieudSUU/wr+o55Uc1egUgLHoDjxTPuM7/x4vrcjFQx2LaetA0cp5o9Sw==
X-Received: by 2002:a05:6214:ac1:b0:796:e048:ee97 with SMTP id 6a1803df08f44-869973a161fmr20467686d6.19.1759167791682;
        Mon, 29 Sep 2025 10:43:11 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8013cdf31besm78947296d6.18.2025.09.29.10.43.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 10:43:10 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1v3Hu2-0000000CNjB-0ASr;
	Mon, 29 Sep 2025 14:43:10 -0300
Date: Mon, 29 Sep 2025 14:43:10 -0300
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
Message-ID: <20250929174310.GH2695987@ziepe.ca>
References: <20250928190624.3735830-1-skhawaja@google.com>
 <20250928190624.3735830-14-skhawaja@google.com>
 <20250929160034.GG2695987@ziepe.ca>
 <CAAywjhS+X5o3B60hKZiioTCqT_7cYThRTz09fHmi4WnSr3ceYA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAywjhS+X5o3B60hKZiioTCqT_7cYThRTz09fHmi4WnSr3ceYA@mail.gmail.com>

On Mon, Sep 29, 2025 at 10:32:22AM -0700, Samiullah Khawaja wrote:
> On Mon, Sep 29, 2025 at 9:00 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >
> > On Sun, Sep 28, 2025 at 07:06:21PM +0000, Samiullah Khawaja wrote:
> > > +static int iommufd_save_ioas(struct iommufd_ctx *ictx,
> > > +                          struct iommufd_lu *iommufd_lu)
> > > +{
> > > +     struct iommufd_hwpt_paging *hwpt_paging;
> > > +     struct iommufd_ioas *ioas = NULL;
> > > +     struct iommufd_object *obj;
> > > +     unsigned long index;
> > > +     int rc;
> > > +
> > > +     /* Iterate each ioas. */
> > > +     xa_for_each(&ictx->objects, index, obj) {
> > > +             if (obj->type != IOMMUFD_OBJ_IOAS)
> > > +                     continue;
> >
> > Wrong locking
> >
> > > +
> > > +             ioas = (struct iommufd_ioas *)obj;
> > > +             mutex_lock(&ioas->mutex);
> > > +
> > > +             /*
> > > +              * TODO: Iterate over each device of this iommufd and only save
> > > +              * hwpt/domain if the device is persisted.
> > > +              */
> > > +             list_for_each_entry(hwpt_paging, &ioas->hwpt_list, hwpt_item) {
> > > +                     if (!hwpt_paging->common.domain)
> > > +                             continue;
> >
> > I don't think this should be automatic. The user should directly
> > serialize/unserialize HWPTs by ID.
> Interesting. So the user should be able to serialize/unserialize HWPTs
> before the Live Update PREPARE event? But what if a device was marked
> for preservation but the user never serialized the attached HWPT,
> would that be considered an error during LUO PREPARE or should iommufd
> serialize the remaining HWPTs here?

yes that would be an error

I also think your patch series is a bit upside down, you should
present the iommufd and core pieces first, then come with a driver
implementation last.

It will be easier to understand the context that having a driver
implementation appear out of no where with no callers..

And everything should be driven by iommufd in this step, the iommu
driver should not be magically auto-preserving itself. Just preserve
the drivers linked to devices being preserved by iommufd.

Jason

