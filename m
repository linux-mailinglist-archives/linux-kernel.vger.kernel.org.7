Return-Path: <linux-kernel+bounces-744933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B5C3B112B9
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 22:56:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43A267B14EC
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 20:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AB5F2E9EA6;
	Thu, 24 Jul 2025 20:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iG98kHGv"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF1D257AC6
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 20:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753390558; cv=none; b=IqqeBSr18zwxLc36zmplJH7I4gLjVm0SeKz1yuXFU8AX13pCBv+uQerUCZFNA+0wpOepMWjJuiq3qCU1k4Q/PQYqDlz/d3zq0WbQsbOJ6UckZ4Vw2Fa5/IY+BcjmRXqt/BJDKpnRIAHhCH0ifo8iFycPl8yISlgTomQlnsZ1JR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753390558; c=relaxed/simple;
	bh=WVnPqwTo77Pc+iMCvphoAqe39pYBfadoUM7KubCgV6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tKq9klFJcOeA2agade4AM2+KtwJpi9W53TzTJyAezQbICNbRB+yYvDrQvaPWXS/imROFkDSrUVJEq4rtmoR26fxcf9Awe3ygctIbSx/twDNclE8ZxKogG+ys4hnn0mz2oE5QtHsRtcpKrU+RWU1xx/KI6hjaELvrbzPmdT8nneM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iG98kHGv; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-23dd9ae5aacso21155ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 13:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753390556; x=1753995356; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gTENdrjrQjKdf4LTtk0rNbYwdganBE87alZpnHbaQAo=;
        b=iG98kHGv+4soZt94pLIU6HJWV0pOIzRqBCBpxZc3N4mZG3fb1UC9x+jI7jWRkr/qDu
         C2nJ1No/RBjSn75j2MVsVldqXIdCaWKEWYv9Rjn+Vnlnyu3khKgl4uN3qgnURbEBHTqW
         9Glf5V47VzVpOWaVYumv4Umvdgz3usZyFaA+DCc0wk1FO5Y4re7nDs8LWtzpQ04IMSAg
         /dkr+pIsOuWMNz6ekW5U3jPbl4Uh4vrd+OTzVPQ+QCnOYnBoJXDsu4+9dPir52yLK2Ss
         m8Vy9QIEuyk4bJmfTu0pWtgMQgUKVMs0beWmNH10ka46KiulBJdGpoS5K/sVhBLjYsKL
         ZT/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753390556; x=1753995356;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gTENdrjrQjKdf4LTtk0rNbYwdganBE87alZpnHbaQAo=;
        b=F+L0OD+I9BgOPa/IVqkYfKb8HtOJNB+GswZBJ94sMN+1E9iStu29MN7SFIgdD4BzMv
         cXetiG4ESEAz0KlXsyF/4dd90rSA/Zb/4Fzo2mCO8y4Hle1625GSeJodKFzV5fHh4Wbw
         j+YQgG6Phw+ouQ7HyYnJXxBSHjGlHoU7juz5sSm8+KQmWSoGbUQ3UtQbCg2khWkDeqH4
         +Eu3m8RoOwJzkpE7Qs55CzXTWz8z2EaHs4J2feIb6B7V3tRxZv+6jBKOf6yCHGyROGrR
         c1l0y3UdomRNjQSCcp9E7Hb2DwSHZFMONO7XTMyJQD+Lsle2rwgBiyngSMgPHf/3XEcP
         wR2g==
X-Forwarded-Encrypted: i=1; AJvYcCX9gcQxLZPlPtJ7jEtGuf42mZ4aznrg9guczMUPshyJNlsgILhOd63R6jRxSJ9NIhmfqDvGiLKFk0dJInY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQq6+q+YFjKSfczEVI4bsyyQe12KBsb89FSigwxxrwnPvbGRIz
	uLisuCd6jta46NfLj7jEnhGqvEP1JJ983/rs9OXFDErVxnfZyPSKr84pntTUPUmyZw==
X-Gm-Gg: ASbGnctsIIoSDPNe2GDvVHK6w7gAPprY2ipeDUE8m6ELthjCUm7ZmNyK0e9PNK+wn3z
	gbMuMxBc7EGB+LbvPKzgTpedX/Vlvs9kHxgGE2MrQswjl9bIPRbvHsuGCBsB2mzniNm23Y+mn48
	u30gW5dOMn0Ht0TeAduKEGfHgZ8ARQqjlS9dOrF3A1b43gPFxEXrVyhaBQ1b8/e3M4K2NwlYHMT
	BYmCuak04tEab4DttrkhgDp/toF51aSPS0geMACHtK92S0XBm44AxVaPVdMYbH7ulXCo/OM7K/c
	1Gyicwa7A7+s4YAXpQfgCYFb24ZwQwsnG37hwTuBMsNQ620HzJBsftzqieox5aq1adHli8xPBkU
	b7oOWDrXIKGZxjbu8BzqidRiOQXIblmZKPtxf/vhzd22SSsT/s+yQmLQY
X-Google-Smtp-Source: AGHT+IHAKLnuNj4dfO0gvzhHyjc+lG/rACu6++zv+Qt1qddir1QwuV7zgtdYIfUhlyrA+12IZWRoQw==
X-Received: by 2002:a17:902:ef48:b0:223:ff93:322f with SMTP id d9443c01a7336-23fada587f0mr920885ad.2.1753390556054;
        Thu, 24 Jul 2025 13:55:56 -0700 (PDT)
Received: from google.com (232.98.126.34.bc.googleusercontent.com. [34.126.98.232])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fa475deafsm22232285ad.11.2025.07.24.13.55.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 13:55:55 -0700 (PDT)
Date: Thu, 24 Jul 2025 20:55:50 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: jgg@nvidia.com, will@kernel.org, joro@8bytes.org, robin.murphy@arm.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v3 2/2] iommu/arm-smmu-v3: Replace vsmmu_size/type with
 get_viommu_size
Message-ID: <aIKd1owebUNQeN1-@google.com>
References: <20250721200444.1740461-1-nicolinc@nvidia.com>
 <20250721200444.1740461-3-nicolinc@nvidia.com>
 <aIDlsUvF2Xbdelvx@google.com>
 <aIEkZoTOSlQ0nMKd@Asurada-Nvidia>
 <aIEwzM7mKUI8-h9U@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aIEwzM7mKUI8-h9U@google.com>

On Wed, Jul 23, 2025 at 06:58:20PM +0000, Pranjal Shrivastava wrote:
> On Wed, Jul 23, 2025 at 11:05:26AM -0700, Nicolin Chen wrote:
> > On Wed, Jul 23, 2025 at 01:37:53PM +0000, Pranjal Shrivastava wrote:
> > > On Mon, Jul 21, 2025 at 01:04:44PM -0700, Nicolin Chen wrote:
> > > > @@ -1273,6 +1279,10 @@ tegra241_cmdqv_init_vintf_user(struct arm_vsmmu *vsmmu,
> > > >  	phys_addr_t page0_base;
> > > >  	int ret;
> > > >  
> > > > +	/* Unsupported type was rejected in tegra241_cmdqv_get_vintf_size() */

Sorry, if this wasn't clear in the previous comment. I meant this
comment must be updated, the "unsupported type" wasn't rejected in
vintf_size, rather the type got corrupted which brought us here. Had the
vintf_size rejected it, we wouldn't be calling the init op.

Thanks,
Praan

> > > > +	if (WARN_ON(vsmmu->core.type != IOMMU_VIOMMU_TYPE_TEGRA241_CMDQV))
> > > > +		return -EOPNOTSUPP;
> > > > +
> > > 
> > > Nit: I don't think we'd expect a call to this if the vintf_size returned
> > > 0? I see that in iommufd_viommu_alloc_ioctl, we already have a check:
> > 
> > It's added in the previous patch where I explained that this is
> > to detect data corruption. When something like that happens, it
> > would be often illogical.
> > 
> 
> Right.. I got mis-led by the comment, my point is that if an
> "unsupported type" was rejected in _get_vintf_size, we wouldn't be here
> calling viommu_init since we error out based on the check in
> iommufd_viommu_alloc_ioctl.. but yes, if there was some data corruption
> that changed the viommu type between these calls, I guess it makes sense
> to check and error out here.
> 
> > > And call ops->viommu_init only when the above isn't met. Thus,
> > > if we still end up calling ops->viommu_init, shouldn't we BUG_ON() it?
> > > I'd rather have the core code handle such things (since the driver is
> > > simply implementing the ops) and BUG_ON() something that's terribly
> > > wrong..
> > 
> > BUG_ON is discouraged following the coding style:
> > https://docs.kernel.org/process/coding-style.html#use-warn-rather-than-bug
> > 
> 
> Noted. Thanks.
> 
> > > I can't see any ops->viommu_init being called elsewhere atm, let me
> > > know if there's a different path that I missed..
> > 
> > I see it as a precaution that should never get triggered. But in
> > case that it happens, I don't want it to proceed further wasting
> > precious HW resource given that this function allocates a VINTF.
> > 
> 
> Agreed.
> 
> > Nicolin
> 
> Praan

