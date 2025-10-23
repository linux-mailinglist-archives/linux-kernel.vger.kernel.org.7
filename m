Return-Path: <linux-kernel+bounces-866529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B3268C0005D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 10:52:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09661189C76E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 08:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2C33303A17;
	Thu, 23 Oct 2025 08:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LnsrGEJI"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582CA302CBF
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 08:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761209500; cv=none; b=oMgBjBpEn5N8cogvRoduvHgR6zQnW9xxp6Dl6oFe0FDKaomIrfzZMwunwkzc0LQfg68CuJPxGiDKFqepbwknY5ssHTsW5cloOX09n19nL49wDguvhmqcowDT6PMJ5DNp0fNtQwdKt4xNCdPx+lWUsbmmP3X9gesfVPnLDyIqUIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761209500; c=relaxed/simple;
	bh=DDnSH/Xl/eEqSLCM1xx3PvDAnw1+CyVxeRHl9bcVN3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KMmJat6DinPVnsyU95nPJV4uupk96GHF+Luw0SQ69g4PHsS12IdpTerBv2zdZqGhdBzZWqcdPpQmh4hLn+Q54zoIoUlKBQyGEhB0+yQvh8ETXa/vvE27Z5NgW04+z5AjdJtIQ8/AbIXBq8Gk419FLmSAFC+4NjAOql6qfG27/Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LnsrGEJI; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761209499; x=1792745499;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DDnSH/Xl/eEqSLCM1xx3PvDAnw1+CyVxeRHl9bcVN3A=;
  b=LnsrGEJIA8+NT3zDZsSLz+tnQZNFixyA5QIEB/CENzJeR4ljYV2qFbAM
   vo7f0/kwIX4AmGaQP4QAXK93PkZR4brsVW0igARxp5W5+7TGDj5nQYoLU
   tPKpz+rPH6H2M7l0foHGeQltx9K/0TXbqcC0aY/pYQSxGGZiAFXpTNNkO
   +CGcYOFA9qXx+3Ojorzyq3N95Y9ZSZol772GCBDsArEOWHvvyrnaQQbkG
   O+VDYfSQik7qxRJblC8FMg7J0g83hcNAmgkxznjd2n+TTpEu9vpgwudm7
   FO3lZa6cNYVt3wxuKU8Y13mifOK+2lKy64FUP4LSsX65M0OnwqOTg6fZ0
   w==;
X-CSE-ConnectionGUID: qd9pBwSWSgqqEeHLT31Ckw==
X-CSE-MsgGUID: Wab1ILdJQB6CuKgCm0/WMQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="63295208"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="63295208"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2025 01:51:26 -0700
X-CSE-ConnectionGUID: 0M5WN0cdRXCJg+1EcjAeHw==
X-CSE-MsgGUID: s9cMFAzoSn+URYnnOhyaUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,249,1754982000"; 
   d="scan'208";a="188500437"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.244.163])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2025 01:51:21 -0700
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1vBr2U-00000001tmQ-3OJx;
	Thu, 23 Oct 2025 11:51:18 +0300
Date: Thu, 23 Oct 2025 11:51:18 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Szuying Chen <chensiying21@gmail.com>
Cc: akpm@linux-foundation.org, dan.j.williams@intel.com, gourry@gourry.net,
	jhubbard@nvidia.com, akinobu.mita@gmail.com, sumanthk@linux.ibm.com,
	peterz@infradead.org, huang.ying.caritas@gmail.com,
	linux-kernel@vger.kernel.org, Andrew_Su@asmedia.com.tw,
	Yd_Tseng@asmedia.com.tw, Ed_Huang@asmedia.com.tw,
	Cindy1_Hsu@asmedia.com.tw, Jesse1_Chang@asmedia.com.tw,
	Richard_Hsu@asmedia.com.tw, Chloe_Chen@asmedia.com.tw
Subject: Re: [PATCH] kernel: resourse: Add conditional handling for ACPI
 device
Message-ID: <aPnshvGceDWVmtze@smile.fi.intel.com>
References: <aPPlVmJXKcMYmjXp@ashevche-desk.local>
 <20251023080455.19443-1-Chloe_Chen@asmedia.com.tw>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251023080455.19443-1-Chloe_Chen@asmedia.com.tw>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Oct 23, 2025 at 04:04:55PM +0800, Szuying Chen wrote:
> On Sun, Oct 19, 2025 at 03:07AM, Andy Shevchenko wrote:
> > On Fri, Oct 17, 2025 at 10:35:31AM +0800, Szuying Chen wrote:
> > > To avoid address conflicts and related errors, specific checks for
> > > the ACPI device "AMDIF031" should be bypassed.
> > 
> > TL;DR: NAK.
> > 
> > No, this is not how we should do the quirks (besides the use of CamelCase).
> > Also, please provide more info why firmware may not be fixed properly at
> > the same time, so we won't need this on an updated version?
> 
> The ACPI device AMDIF031 is a virtual (non-PCI) device located on the PCI
> upstream port. Its memory resource is assigned by the BIOS within the bridge
> windows of the PCI upstream port.
> 
> When the kernel creates ACPI/AMDIF031 and verifies memory resources, it may
> detect an address conflict between AMDIF031 and the PCI upstream port. The
> kernel then attempts to reassign resources for the PCI upstream port tree,
> causing AMDIF031's memory resource to fall outside the bridge windows. This
> makes the device inaccessible.
> 
> To prevent this and allow AMDIF031 to use the BIOS-assigned memory range,
> skip resource reallocation when an address conflict is detected for this 
> device.

We have such devices in many platforms, older ones use MFD framework with
specific flag set, you may check how it's done there. But for this change is
definitely NAK, take your time to find proper solution (see above for the
hint).

-- 
With Best Regards,
Andy Shevchenko



