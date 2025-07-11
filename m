Return-Path: <linux-kernel+bounces-727336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BA97B018AB
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 11:47:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98AE95A7555
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 09:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BDC327C875;
	Fri, 11 Jul 2025 09:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aCDcpx3H"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B9927C854
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 09:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752227245; cv=none; b=lDIkXoX2wAuH3ulF9WndlCLS68b6avBMfTDoiq+ElsmtmMK7V+leVzJGiMIASw2LQhfnoAcNXsYixx1OPJZa5p0Vy35W57+Z1DenE1ziB+gEESC8HsLd0zrTKcuEVSYaDExmuZ68YwapW1MLB4l5KNgz1b/NeZ0iBvBdCRNYsrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752227245; c=relaxed/simple;
	bh=Gb51m78T9qrVWbZJ3QXRA1Tk0MynxIUdlHhQ/7nHR/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=myeSI3U6TMj5+goGBctJxaLoyMnn+YrRWCa5fXH/K6ODClgZK4QfD+4wZlCrVS75HXZG/LRA0l94SgsDf4veH66YijvZY/OOW3FQ4uZahqU7Ab3gYfB3+ofB/YJ7uVkQQyq6GbYw2sXq9Mg5PNpLK9bUuQDWx+WXl3t4xgeMXK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aCDcpx3H; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752227241; x=1783763241;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Gb51m78T9qrVWbZJ3QXRA1Tk0MynxIUdlHhQ/7nHR/g=;
  b=aCDcpx3H6ifminfj3q/1BkDYcssLlzPh7kmUdqRO4xw1rmphBuGQtAXs
   8U1pJVWu/10wjZV5peJ3zjevkVDfgiU5qpiOvmpKYZ8aWDIc6COX6XUih
   Tlwlth94ylbVpZvODPIaeexS9HVOaEvFhuB/3zfoa9UdA9w4RUV8D7MeD
   cZngDNsWfJEnxMZonCSL5nsVFGbqpliQxrNf1L2fpITZFmKYmh0B23bJI
   6xJrMia7R2LVpAAK2IltA+39fOr4ugSWzfGwtlitxWK118195/dUbQRpF
   ahiNZJbtDxcTJMgyf+c9kqveVX5sGL38px1dAHv629WUqAqwEPY/TSqjd
   Q==;
X-CSE-ConnectionGUID: nq9YgflRRVWFptPcEyNs+g==
X-CSE-MsgGUID: 53fyfYbVSUesX78OnvTcug==
X-IronPort-AV: E=McAfee;i="6800,10657,11490"; a="58186631"
X-IronPort-AV: E=Sophos;i="6.16,303,1744095600"; 
   d="scan'208";a="58186631"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 02:47:20 -0700
X-CSE-ConnectionGUID: fMcSz0UfT2+UL3c5vuT+eA==
X-CSE-MsgGUID: HMQ+lu30RxiKwixeo5acQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,303,1744095600"; 
   d="scan'208";a="157052706"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa010.fm.intel.com with ESMTP; 11 Jul 2025 02:47:19 -0700
Date: Fri, 11 Jul 2025 17:38:56 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, "will@kernel.org" <will@kernel.org>,
	"aneesh.kumar@kernel.org" <aneesh.kumar@kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"shuah@kernel.org" <shuah@kernel.org>,
	"nicolinc@nvidia.com" <nicolinc@nvidia.com>,
	"aik@amd.com" <aik@amd.com>,
	"Williams, Dan J" <dan.j.williams@intel.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"Xu, Yilun" <yilun.xu@intel.com>
Subject: Re: [PATCH v4 3/7] iommufd: Add a pre_destroy() op for objects
Message-ID: <aHDbsFvzHl1UnQiZ@yilunxu-OptiPlex-7050>
References: <20250709040234.1773573-1-yilun.xu@linux.intel.com>
 <20250709040234.1773573-4-yilun.xu@linux.intel.com>
 <BN9PR11MB5276CA77E378CB3173CA76888C48A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20250710171515.GS1599700@nvidia.com>
 <BN9PR11MB5276F53F46F054F93C0271318C4BA@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276F53F46F054F93C0271318C4BA@BN9PR11MB5276.namprd11.prod.outlook.com>

On Fri, Jul 11, 2025 at 03:16:38AM +0000, Tian, Kevin wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Friday, July 11, 2025 1:15 AM
> > 
> > On Thu, Jul 10, 2025 at 07:40:58AM +0000, Tian, Kevin wrote:
> > > > From: Xu Yilun <yilun.xu@linux.intel.com>
> > > > Sent: Wednesday, July 9, 2025 12:03 PM
> > > >
> > > > Add a pre_destroy() op which gives objects a chance to clear their
> > > > short term users references before destruction. This op is intended for
> > > > external driver created objects (e.g. idev) which does deterministic
> > > > destruction.
> > > >
> > > > In order to manage the lifecycle of interrelated objects as well as the
> > > > deterministic destruction (e.g. vdev can't outlive idev, and idev
> > > > destruction can't fail), short term users references are allowed to
> > > > live out of an ioctl execution. An immediate use case is, vdev holds
> > > > idev's short term user reference until vdev destruction completes, idev
> > > > leverages existing wait_shortterm mechanism to ensure it is destroyed
> > > > after vdev.
> > > >
> > > > This extended usage makes the referenced object unable to just wait for
> > > > its reference gone. It needs to actively trigger the reference removal,
> > > > as well as prevent new references before wait. Should implement these
> > > > work in pre_destroy().
> > > >
> > > > Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> > > > Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
> > >
> > > Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> > >
> > > btw is it clearer to rename 'shortterm_users' as 'wait_cnt', as the
> > > meaning now is beyond shortterm and is really about the need of
> > > waiting?
> > 
> > Probably so, as a followup change would be fine if we don't need a v5

We have some comments to quick fix. Let me make a v5 and include this
change.

> > 
> > /*
> >  * Destroy will sleep and wait for wait_cnt to go to zero. This
> >  * allows concurrent users of the ID to reliably avoid causing a
> >  * spurious destroy failure. Incrementing this count should either be
> >  * short lived or be revoked and blocked during pre_destroy
> >  */
> > refcount_t wait_cnt;
> > 
> > ?
> 
> Looks good

