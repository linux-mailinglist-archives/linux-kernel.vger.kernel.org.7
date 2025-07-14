Return-Path: <linux-kernel+bounces-730533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34B4AB045DF
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 18:51:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6D387B272A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 16:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47BD812BF24;
	Mon, 14 Jul 2025 16:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="It4XFCWa"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0FA27470
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 16:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752511759; cv=none; b=iA9R24tDmCszCCg0lyj01kw13bQLiYxXjaJ1NocZDR+rUDyuJF1m6c86U/H60amkzCYxjWwx4a2i9NO/AZEAVBlsVK6rMq2ermQYETckUsb1mW4MNlWe3q/XlxhtkTzhxrJCzm24JNB+8xnI6NJS7t0VrqRAgybdGsAMO42SYm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752511759; c=relaxed/simple;
	bh=ZKklvWnPprKlA8D9y/tuQKyfcSMhRYF2C26HtSEJzOs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=patL2WS0hvVh1HeFzwvPTJ8xo3Q06A4WgrjZnTYaJyIm4KQKKhHovQkO2ZykLqbGYF4JQAI7/5U8KlnD24zse7OlNSuQV0jmhKuv4wIyR1/GKkuWP9AItL9WLjDFhBViKc63kBBGSxLBZeL/sDMFkzGu4DJXpjX6GTZOmbKU3yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=It4XFCWa; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752511756; x=1784047756;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZKklvWnPprKlA8D9y/tuQKyfcSMhRYF2C26HtSEJzOs=;
  b=It4XFCWaS9If2mScrCUyY/gI8l1VFgNgvMxkiXd6g2yNsbeq3/2y+1OR
   vCe/ECV3bSHb1+s9mRM8DB5tTOwNdIdfkF1nX1EgyVFxMMY6Yqqqwvu7o
   7C3lPxMKKfFcXc94n4YrSfSpoZ90hFWd5Xr5COo6JD+DR/Rg0AlZMthkC
   F4cxFhbnns2ERRkoxVJ3U36XuU3+pSTmYFLZlEDBBzruugOQIQgnAJajF
   N2mhpVwroKQ3Dx0/m/WR1OEtlXu2J1Jo9IiuI/zkJ6CKJV/hCUeASHi7T
   yszWl44AMajh7CIW/84NVPtHEGj9xsp0s6EynCzdFa5nkvoxBw1lT82ha
   w==;
X-CSE-ConnectionGUID: M9+2+HofSvK1QAgJSO74Dw==
X-CSE-MsgGUID: u3PwFYNFQG+3nukJYD/EHA==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="54800543"
X-IronPort-AV: E=Sophos;i="6.16,311,1744095600"; 
   d="scan'208";a="54800543"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2025 09:49:16 -0700
X-CSE-ConnectionGUID: Se3QjoiYS+eSULbS439/SQ==
X-CSE-MsgGUID: LKC/plXWTKKc9a9ppBOmCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,311,1744095600"; 
   d="scan'208";a="160995646"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa003.fm.intel.com with ESMTP; 14 Jul 2025 09:49:13 -0700
Date: Tue, 15 Jul 2025 00:40:40 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: jgg@nvidia.com, jgg@ziepe.ca, kevin.tian@intel.com, will@kernel.org,
	aneesh.kumar@kernel.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, joro@8bytes.org, robin.murphy@arm.com,
	shuah@kernel.org, aik@amd.com, dan.j.williams@intel.com,
	baolu.lu@linux.intel.com, yilun.xu@intel.com
Subject: Re: [PATCH v4 4/7] iommufd: Destroy vdevice on idevice destroy
Message-ID: <aHUzCAM8NKuFYbj3@yilunxu-OptiPlex-7050>
References: <20250709040234.1773573-1-yilun.xu@linux.intel.com>
 <20250709040234.1773573-5-yilun.xu@linux.intel.com>
 <aHHG/H6IT9lvYy8x@Asurada-Nvidia>
 <aHKfwQ41x28bNWAL@yilunxu-OptiPlex-7050>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aHKfwQ41x28bNWAL@yilunxu-OptiPlex-7050>

On Sun, Jul 13, 2025 at 01:47:45AM +0800, Xu Yilun wrote:
> > [..]
> > 
> > >  out_put_idev:
> > > -	iommufd_put_object(ucmd->ictx, &idev->obj);
> > > +	if (rc)
> > > +		iommufd_put_object(ucmd->ictx, &idev->obj);
> > 
> > So, this actually holds both the short term user and (covertly)
> > the regular user too.
> > 
> > Though it doesn't hurt to do that, holding the regular one seems
> > to be useless, because its refcount check is way behind this new
> > pre_destroy op:
> > 
> > 183         if (flags & REMOVE_WAIT_SHORTTERM) {                                                                                                                                                                                                                                                                                                             
> > 184                 ret = iommufd_object_dec_wait_shortterm(ictx, to_destroy);
> > ==>			/* pre_destroy op */
> > ...
> > 214         if (!refcount_dec_if_one(&obj->users)) {
> > 215                 ret = -EBUSY;
> > 216                 goto err_xa;
> > 217         }
> > 
> > So, I think we could just do, exactly reflecting the comments:
> > +	vdev->idev = idev;
> > +	refcount_inc(&idev->obj.shortterm_users);
> 
> I think this makes things more clear, we have 3 types of refcounts:
> 
> 1. shortterm_users + 1, users + 1, temporary refcount, can't be
>    revoked by referenced object.
> 2. users + 1, long term refcount, can't be revoked either.
> 3. shortterm_users + 1, can be revoked by referenced object.
> 
> > 
> > Then, keep the exit patch unchanged.
> > out_put_idev:
> > 	iommufd_put_object(ucmd->ictx, &idev->obj);
> 
> Yeah, this is the part I like the most.

Sorry, I feel the actual coding is not as good as I image, the

  refcount_dec(&idev->obj.shortterm_users)

can't be called in iommufd_vdevice_abort() cause it may lead to idev
free but we will then do

  mutex_unlock(idev->igroup->lock)

I think the following change makes things more complex...


diff --git a/drivers/iommu/iommufd/viommu.c b/drivers/iommu/iommufd/viommu.c
index 702ae248df17..bdd5a5227cbf 100644
--- a/drivers/iommu/iommufd/viommu.c
+++ b/drivers/iommu/iommufd/viommu.c
@@ -128,7 +128,8 @@ void iommufd_vdevice_destroy(struct iommufd_object *obj)
        mutex_lock(&idev->igroup->lock);
        iommufd_vdevice_abort(obj);
        mutex_unlock(&idev->igroup->lock);
-       iommufd_put_object(idev->ictx, &idev->obj);
+       refcount_dec(&idev->obj.shortterm_users);
+       wake_up_interruptible_all(&vdev->viommu->ictx->destroy_wait);
 }

 int iommufd_vdevice_alloc_ioctl(struct iommufd_ucmd *ucmd)
@@ -185,6 +186,7 @@ int iommufd_vdevice_alloc_ioctl(struct iommufd_ucmd *ucmd)
         * idev real destruction.
         */
        vdev->idev = idev;
+       refcount_inc(&idev->obj.shortterm_users);

        /*
         * iommufd_device_destroy() delays until idev->vdev is NULL before
@@ -207,12 +209,12 @@ int iommufd_vdevice_alloc_ioctl(struct iommufd_ucmd *ucmd)
        goto out_unlock_igroup;

 out_abort:
+       refcount_dec(&idev->obj.shortterm_users);
        iommufd_object_abort_and_destroy(ucmd->ictx, &vdev->obj);
 out_unlock_igroup:
        mutex_unlock(&idev->igroup->lock);
 out_put_idev:
-       if (rc)
-               iommufd_put_object(ucmd->ictx, &idev->obj);
+       iommufd_put_object(ucmd->ictx, &idev->obj);
 out_put_viommu:
        iommufd_put_object(ucmd->ictx, &viommu->obj);
        return rc;


Thanks,
Yilun

