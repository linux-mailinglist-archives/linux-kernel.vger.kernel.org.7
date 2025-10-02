Return-Path: <linux-kernel+bounces-840312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F076EBB4134
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 15:41:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A28901C1425
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 13:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD0903126B2;
	Thu,  2 Oct 2025 13:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="J4uIi8PG"
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6973231196B
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 13:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759412477; cv=none; b=dpmbDwizNhBybJj2jojr7hRwdx5BfwnOAIKQPlCWwd8N8dXn6kpc/PK5Tquwz0gfa3ftvTEU6vNzMschJXly6l2sJXrZ7jIwTePrw6VnSJfT7M73HcTISYx+IzWdZp83r/eFGIToxwV0076ttERhwfRHW+L5O/phbJYZQTv+MGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759412477; c=relaxed/simple;
	bh=VCUZW3Nvj0PlHse4ZIyPzDgY02LRnAE4zmy76PVnWfw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qe5nb74lhIe3Ink57hhIC4i0+uHus13Un5acwrPsd74BZp7aX9xyt6uzAaB8rUFDWBiIrOEk4BiuiEyBPqDDNEmJZfkwBm/bNtUmHwKasdRCrepsUmjgz6nOHxdLyDdwRz1i0crPbHDf8erwUQD/mgfYAuNA9TkU1IVAaYJ42nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=J4uIi8PG; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-43f86ddb3f4so432301b6e.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 06:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1759412474; x=1760017274; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PmaKBvWqIjSyu9OcOIOXhZlZKkkawFeVoff3riiQ5Jg=;
        b=J4uIi8PGoXpzhmZL9es8IQ1vRkNmLC3GhISaekyOQx0yeuo98S9syBcOI3AeYOgbey
         Izt+Chobwizx2/8TA3odOnZMc8F0E+8OEhrbcQykOUVn1UGItRK03Kgyl+himahtp4tr
         NndmI99xXq5GmSlSQon6mznPsQKYW5XTMJaK55LTlykUkG8gq5VNa3sJdb9TuFZuwXSV
         CwDL1/02JHYI8EadXgGaKVy/5aFv16j9/Xus54VF4v1CYrCIeu887fYXJGYatO+qfFG6
         +W6T2sq/f+TQn6hRBJ7GrfaE1c1k0ZJgqPEgTwa1gvfB5+KDJtu4MiyB9Uc1GT3gGc6m
         j74g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759412474; x=1760017274;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PmaKBvWqIjSyu9OcOIOXhZlZKkkawFeVoff3riiQ5Jg=;
        b=Z1bNcggOYJ3tTXV9QIDNi/pny5xfoklrFPVlinQ9ryd+kU9lgcs7JOjYD2n1xlHE4b
         2eElAxOBbiJn6nLyvWqFAQ5PYgGQx3KNy4O5ROMHMeBeRVh31xqpIKZnRMR5kcKnIXRc
         FmSLD4CUNhq+bOIlPhhIIUZ/y8+5J2UmG3vbyJVQVp9BnhAbIMbOh5ZHpM9LN7gpdnjj
         KoKiGIwzOuISAW8dkLJoS65kLeTcYuWde1fR/y9VvZruk5ub5AxeGFrrgEhV3/lOtXXj
         w9x3cm9z/eRDRuQjoznfs2hSHH72HpGcYX0MbdLKsP3O6DhYLg0FZ1zXMseVq6JIyCdg
         3IuQ==
X-Forwarded-Encrypted: i=1; AJvYcCVbs8/okbDESQVIXgvZtETzSWh2NcC9zHr8WTtGK022Am7JQUY498HytiPIbtnybahydZTQRNvxfnn3LbI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTmOUp2hAoQ/ZQeMfP+H76Q0AGT0JMOeExJdKbv7vGSOVgSm4E
	ncsxLvjUpKAthUw4kZI5ygJGOP0jMRXFnuh0xs67VloYrvh50x5SCOgpAzav5squVuk=
X-Gm-Gg: ASbGncujHkgxxG7UTAboxOrVDL5IdN/F4OFtQA+jO8b2UdD9IPNB39SFsPng9zXZOHM
	Fr24c6yZjMmDgZrnhw+GN4hdvDUnbtJxu6N4D8mv7XvgIkg4KUbKBu6MK/33MeAfsB4GivAR+Pj
	K6TssL1FJwfaAa0Ku24MNqFeXFpsVjc7EsFxk4poKw1S6CPiYZe1YmVzsKgGu6aXGskbuftgF9I
	Kmap0Guo2TUU93OHYLLr9jtoQA/nQcF/MhmiSf5AkBgsb0O8Iu84vBPjGLocvAr9+n/ObqV5Bgd
	Klgcs/VlxXy6n5rIU2jPXriKhVQ3gpbeG3JEsBt25oCfHkXh9iCGfvreu2Kbw1XINEqMTPFCHcF
	IVJKPEk997RGoutx+ksMo
X-Google-Smtp-Source: AGHT+IFxDIQM42E8wYDD/YlbjZwi8VbGSBiQY2HlW12G+z0jmgjkeEufW1JtpOZFmbmeO3fGFnaKgQ==
X-Received: by 2002:a05:6808:d54:b0:437:f573:b175 with SMTP id 5614622812f47-43fa41be418mr4594199b6e.31.1759412474306;
        Thu, 02 Oct 2025 06:41:14 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3ab59bda0c5sm778082fac.0.2025.10.02.06.41.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 06:41:13 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1v4JYW-0000000DiFO-1CwW;
	Thu, 02 Oct 2025 10:41:12 -0300
Date: Thu, 2 Oct 2025 10:41:12 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, iommu@lists.linux.dev,
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
Message-ID: <20251002134112.GD3195829@ziepe.ca>
References: <20250928190624.3735830-1-skhawaja@google.com>
 <20250928190624.3735830-14-skhawaja@google.com>
 <20250929160034.GG2695987@ziepe.ca>
 <CA+CK2bDqDz3k0gXamJEbKUL7RPBLVjaA5=Jum=CF84wR+50izA@mail.gmail.com>
 <20250930135916.GN2695987@ziepe.ca>
 <CAAywjhRGrGjZK3jQptieVWmdzvjfNtTYrp2ChTZJSmFyrBaRqw@mail.gmail.com>
 <20250930210504.GU2695987@ziepe.ca>
 <CAAywjhRQONuHsxTGQZ5R=EJbOHUD+xOF_CYjkNRbUyCQkORwig@mail.gmail.com>
 <20251001114742.GV2695987@ziepe.ca>
 <CAAywjhRKvZBShj7KAXew2v_uGjn3HhvO=sFrZ=bVfMJ8ye-Vyw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAywjhRKvZBShj7KAXew2v_uGjn3HhvO=sFrZ=bVfMJ8ye-Vyw@mail.gmail.com>

On Wed, Oct 01, 2025 at 06:00:58PM -0700, Samiullah Khawaja wrote:
> > No, finish should never do anything on the restore path, IMHO. User
> > should directly attach the newly created HWPT when it is ready.
> 
> Makes sense. But if the user never replaces the restored iommu_domain
> with a new HWPT, we will have to discard the old (restored) domain on
> finish since it doesn't have any associated HWPT. I see you already
> hinted at this below. This needs to be handled carefully considering
> the vfio cdev FD state also. Discussed further below.

I think the simplest thing is the domain exists forever until
userspace attaches an iommufd, takes ownership of it and frees it.
Nothing to do with finish.

While the domain is attached iommu_device_use_default_domain() will
fail.

> This is the part that I was concerned about since I was looking into
> the auto_domain. Users that attach to ioas directly and use
> auto_domain would not be able to restore the mappings before attaching
> to the device.

IMHO luo users need to be sophisticated enough to avoid auto_domain.

> That's a good point. But it might be tricky since the ownership of the
> device is with the vfio cdev FD. So if vfio cdev FD is never
> restored/reclaimed the device can be FLR'd. iommufd will follow along
> and discard the domain.

Honestly, I keep wanting things to be kept as simple as possible with
as few exception flows as necessary.

If we make it so that iommu_device_claim_dma_owner() is aware of luo
and the only way vfio can get ownership is if it is also restoring the
luo session then that sounds perfect.

Attaching a non-luo VFIO would be blocked by the kernel so we never
get these inconsistencies.

> The more interesting case might be where cdev is restored and bound to
> iommufd but the user never recreates and hotswaps a new HWPT. In this
> case we can discard the restored iommu_domain and replace it with the
> blocking domain as it should have been if the device was not
> preserved.

Maybe the HWPT has to be auto-created inside the iommufd as soon as it
is attached. The "restore" ioctl would just return back the ID of this
already created HWPT.

Again, this seems to avoid special cases as once we exit the special
luo mode of iommu_device_claim_dma_owner() iommufd is always
responsible for the iommu_domain.

Jason

