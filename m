Return-Path: <linux-kernel+bounces-743100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C50BB0FA91
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 20:58:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96E217A10BF
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 18:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A277C223328;
	Wed, 23 Jul 2025 18:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EvHoQ0OK"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB072253A9
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 18:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753297108; cv=none; b=BKhmhfZPrCCjw/BOGp8crlEhxuGkfxL+L8vTH0oyaFW8XHX3m8et+4l2G21w/BVn+Ij/d35535UaIEb9blM+uwVgUsDfnP6t3fOqfvg6hosPUnxoKqQtzEPHklQGFjBnkUAwX4bGoLtyHDpQBV/0lGN3FHvAdep1JKREv2/cKn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753297108; c=relaxed/simple;
	bh=mmzQsMhl6rfhBdXQys7xatXOBT6V9yF5g+naRmfEqMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eKZcS5cp2gidMzl2yI1j6u8auGDSUeJpLqbOJKNmuxZm5V31K/L58O9aQoiCN6NCAum5NZgO1MinGQnI1ytRm1/Uvhs0qymkNobrlBwZsid0OYdZQeNSuApMHpJGvL+6HtAGjVgOb23A+I+MNwegSTq+CiQlf5HOU3Zd7HfaBlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EvHoQ0OK; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2357c61cda7so20095ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 11:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753297106; x=1753901906; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tgyxBCBooV+1URrR0k+S4ytxsHSs18Tgj8DW+tHKzAo=;
        b=EvHoQ0OK0Cda5iUy1S5gE5XhTRvQt+/qJjlvlF3UxMn6Y1JPn94Zl4/vZQGWMbQXav
         +kp7wNsbZYWVTK9V6UX8USy9aLNn8CIf+u4H6SEdoO0cJalYWPefEruszZ5oGppzdCdL
         1KNJSdYc3zq2kpYaLgU2LTTKlzKndWdi97m9jeDdIRCx94re5vAC1VdC3zW2ZARqOwmo
         EEgZ1w2Go+RGvCCHbuGrgdgtrHX7XlW+LqGnjX9bSZwySD8fdAHnr/B3EPDFiybnkPI6
         sUsGHbmrEJv8gIDo+PAd/h9KuC4bnuFVebeUXMyOsEjj4GImf7gdQAPbEeCISAtAaQey
         FIgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753297106; x=1753901906;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tgyxBCBooV+1URrR0k+S4ytxsHSs18Tgj8DW+tHKzAo=;
        b=LHG6YzWaTBA7nIPvVT4WbrxAHr47pb+rmpf8wLDGr/O7W9kmpDHCGSOMI+9Jy3bsJD
         sBTDuwKV1kDzsCQUlRokFbNs04MfnNv3Loq8W9qE6XR7cZz58i8OlNuy7/T04Vzbnkxk
         4KEGon/dbv+0lC1js84rBMl6o0xAVk3+WqgZFUwMJgZKfMsZ0wpFa5bumQoSvxOpEZqU
         aNc2dMYB0/QnE4YrR7zPyPrLzqGVpzJH96pAEiC9mb8j6y+sH6bvNcYMTCeuSaWhQPRj
         Ce5O0eAhXLo0mMW+r/gUSFOlTtLRBkA8ZZsw80hi9bs8uJsftOffRLaUm9zf8wMin6fU
         eIMw==
X-Forwarded-Encrypted: i=1; AJvYcCWCGrT26ANjc665FnuNSTBMfyMJnQgFh+RTjDmSkyedsLipT8zOorzH6sEBC6ew+g8F6/q8DB0YZFYZXDM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhJPfbJGvNhsSJ/zoQ5/1AEv+FjuQdY0JrWH7Tj0wHFz1OAeJw
	c7i2WlAVbRatkSkSIIkB3zjSLoBrYq9aJnnZ3QxlRT6TiJywKzwELpvowV9rqSxlLA==
X-Gm-Gg: ASbGncv6QAy06TgDh4i3Lo7MVIAlqSsu5ODifRmCFHwQRcr1/dj5LR15V+XNGXX0Nrk
	Ri8ExUupq5Z+TihlUzZCpsP1GHOsYLnm9D7CmqfWQaDP2xVY84yfjhBLnyaPeOyleMhGbvDBrb/
	3asWgarsjLzPnvZTtCQ6GG+dPiyfHrsrSJDYYFVoNbl6hEdL7ifZfJVVpJe4Qf6zcSlyI5qEU4R
	AAUUJRODUHFkCCrpMTtlimLH8wPYM+Uws0VHzQTFk/cesRbYsIaA5v29HzM+fzvSAsaC+xnbvHi
	QfU6iGp5ztaAKNBdhI8n78jwXAsiyJDQolz/Tf3myafCEBjJajiI9O451AvD1hUH0/ylfPrxS6W
	7tBOeUy+lvRR35oqaWMkovAGOP/aiE+M4XwBxw2fS8DwnGyu70hkIZgNr
X-Google-Smtp-Source: AGHT+IHUkgfjZ7uajnt2ygxd4BiWFzqlf8/UuEEurXoZ/+uZ0jw37E8kKbO1K9MhbyfBxy1R4DSPBQ==
X-Received: by 2002:a17:903:124f:b0:22e:1858:fc25 with SMTP id d9443c01a7336-23fa2ef97efmr184175ad.9.1753297105524;
        Wed, 23 Jul 2025 11:58:25 -0700 (PDT)
Received: from google.com (232.98.126.34.bc.googleusercontent.com. [34.126.98.232])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759cbd66eecsm10238885b3a.142.2025.07.23.11.58.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 11:58:25 -0700 (PDT)
Date: Wed, 23 Jul 2025 18:58:20 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: jgg@nvidia.com, will@kernel.org, joro@8bytes.org, robin.murphy@arm.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v3 2/2] iommu/arm-smmu-v3: Replace vsmmu_size/type with
 get_viommu_size
Message-ID: <aIEwzM7mKUI8-h9U@google.com>
References: <20250721200444.1740461-1-nicolinc@nvidia.com>
 <20250721200444.1740461-3-nicolinc@nvidia.com>
 <aIDlsUvF2Xbdelvx@google.com>
 <aIEkZoTOSlQ0nMKd@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aIEkZoTOSlQ0nMKd@Asurada-Nvidia>

On Wed, Jul 23, 2025 at 11:05:26AM -0700, Nicolin Chen wrote:
> On Wed, Jul 23, 2025 at 01:37:53PM +0000, Pranjal Shrivastava wrote:
> > On Mon, Jul 21, 2025 at 01:04:44PM -0700, Nicolin Chen wrote:
> > > @@ -1273,6 +1279,10 @@ tegra241_cmdqv_init_vintf_user(struct arm_vsmmu *vsmmu,
> > >  	phys_addr_t page0_base;
> > >  	int ret;
> > >  
> > > +	/* Unsupported type was rejected in tegra241_cmdqv_get_vintf_size() */
> > > +	if (WARN_ON(vsmmu->core.type != IOMMU_VIOMMU_TYPE_TEGRA241_CMDQV))
> > > +		return -EOPNOTSUPP;
> > > +
> > 
> > Nit: I don't think we'd expect a call to this if the vintf_size returned
> > 0? I see that in iommufd_viommu_alloc_ioctl, we already have a check:
> 
> It's added in the previous patch where I explained that this is
> to detect data corruption. When something like that happens, it
> would be often illogical.
> 

Right.. I got mis-led by the comment, my point is that if an
"unsupported type" was rejected in _get_vintf_size, we wouldn't be here
calling viommu_init since we error out based on the check in
iommufd_viommu_alloc_ioctl.. but yes, if there was some data corruption
that changed the viommu type between these calls, I guess it makes sense
to check and error out here.

> > And call ops->viommu_init only when the above isn't met. Thus,
> > if we still end up calling ops->viommu_init, shouldn't we BUG_ON() it?
> > I'd rather have the core code handle such things (since the driver is
> > simply implementing the ops) and BUG_ON() something that's terribly
> > wrong..
> 
> BUG_ON is discouraged following the coding style:
> https://docs.kernel.org/process/coding-style.html#use-warn-rather-than-bug
> 

Noted. Thanks.

> > I can't see any ops->viommu_init being called elsewhere atm, let me
> > know if there's a different path that I missed..
> 
> I see it as a precaution that should never get triggered. But in
> case that it happens, I don't want it to proceed further wasting
> precious HW resource given that this function allocates a VINTF.
> 

Agreed.

> Nicolin

Praan

