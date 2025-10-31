Return-Path: <linux-kernel+bounces-879633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EA6C5C239F0
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 08:56:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 844874E5E7C
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 07:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 077883203A7;
	Fri, 31 Oct 2025 07:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d8QXgVVQ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C957B2E9EDD
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 07:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761897388; cv=none; b=V1X2g2edM8OjnSq4rt8cMrAgnRLzJAqGf67lhKJfF3KjAzfPynmiqBG+l/FLOyjr0GrRVLBP2u8auwMaEWevuk/Si3ngTHQt9TsOEhVg9klZyQO6D885a0Z2cBnVp3aQ+POJe2Ul1tHQsdgwPjWHYGVQ/1d1mcelu6NEuN4IwrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761897388; c=relaxed/simple;
	bh=cMecjH4l+x2d5vkMhP5e5864jM62b8N2i00kz8C0rm8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VJzup2bcy1R1MXfOt7FGwTuqv6+WxgjWUdka7duQ7anpHaQF2sdDVBBkg4xONHREe3UTo402XN7/BiCZtkDhKB6leq0RtGfykgot7f6beYw9TubnV//G0sP2Ts9dvF+eYfnGGfNX/6VNaXJPHYNfHWpphv9QV6sparT5x9I5p/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d8QXgVVQ; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761897387; x=1793433387;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cMecjH4l+x2d5vkMhP5e5864jM62b8N2i00kz8C0rm8=;
  b=d8QXgVVQR+dZncmPSrq9dWqgzli+8S3gEtjPimja///UYFuDlhYuk8i/
   vCxZ+UMGxzMxSBkDaK2SY5IDwOUmwh9l/K7vIZoN+GP6D0NCTgm/EMGZD
   0UIqRrk1b0ABc1u/KMLaK6tCbcIqNO3eNqEnbOvGV1/dQN4jms08G6ARZ
   k649cA3J1e4cWLh3bhqZm/HC3zIcb37oy+xd29UGDI5GyGKtufD5TyjrZ
   7+UbjHJfylf73f8x5QN4IXgJ310MctIvB6yWynEafO43H99Ofyh5GhyeK
   6GqPbSUitMPmm/MsLo4mW73lxU174CdnJ1E90yfW8fBwwfBZOKS2xVc8b
   g==;
X-CSE-ConnectionGUID: 3EzNXCD+QLSmpKUNNTUHAg==
X-CSE-MsgGUID: TxYQ62ToSB+cFaI16AvjKw==
X-IronPort-AV: E=McAfee;i="6800,10657,11598"; a="67912394"
X-IronPort-AV: E=Sophos;i="6.19,268,1754982000"; 
   d="scan'208";a="67912394"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 00:56:26 -0700
X-CSE-ConnectionGUID: jBaMj+KJQaWH77uWQfKtrg==
X-CSE-MsgGUID: kz4ZGTgJSvSf+lUmx6LS/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,268,1754982000"; 
   d="scan'208";a="186108491"
Received: from mgoodin-mobl3.amr.corp.intel.com (HELO ashevche-desk.local) ([10.124.220.66])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 00:56:25 -0700
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1vEjzg-00000004CUs-2pWn;
	Fri, 31 Oct 2025 09:56:20 +0200
Date: Fri, 31 Oct 2025 09:56:19 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Petr Mladek <pmladek@suse.com>
Cc: Feng Tang <feng.tang@linux.alibaba.com>, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v3 0/6] panic: sys_info: Refactor and fix a potential
 issue
Message-ID: <aQRro_R33ZBp7jPC@smile.fi.intel.com>
References: <20251030132007.3742368-1-andriy.shevchenko@linux.intel.com>
 <aQNxM40aDIrpfE0K@smile.fi.intel.com>
 <aQOIs5ZuSHhnOwuS@pathway.suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQOIs5ZuSHhnOwuS@pathway.suse.cz>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Oct 30, 2025 at 04:48:03PM +0100, Petr Mladek wrote:
> On Thu 2025-10-30 16:07:47, Andy Shevchenko wrote:
> > On Thu, Oct 30, 2025 at 12:44:16PM +0100, Andy Shevchenko wrote:
> > 
> > +Cc: Petr, sorry, forgot to add you to the Cc list.
> 
> Thank you for Cc-ing me.
> 
> > > While targeting the compilation issue due to dangling variable,
> > > I have noticed more opportunities for refactoring that helps to
> > > avoid above mentioned compilation issue in a cleaner way and
> > > also fixes a potential problem with global variable access.
> > > Please, give it a try.
> > > 
> > > Changelog v3:
> > > - addressed an issue with empty parameter returned (Feng)
> > > - gathered tags (Feng)
> 
> I like all the changes and do not see any problem there.
> For the entire patchset, feel free to use:
> 
> Reviewed-by: Petr Mladek <pmladek@suse.com>

Thank you!

-- 
With Best Regards,
Andy Shevchenko



