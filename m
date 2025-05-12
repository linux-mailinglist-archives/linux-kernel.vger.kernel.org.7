Return-Path: <linux-kernel+bounces-643615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17550AB2F66
	for <lists+linux-kernel@lfdr.de>; Mon, 12 May 2025 08:15:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D2DD7A8422
	for <lists+linux-kernel@lfdr.de>; Mon, 12 May 2025 06:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30C5D255E37;
	Mon, 12 May 2025 06:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SHafz06P"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0636255E31;
	Mon, 12 May 2025 06:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747030504; cv=none; b=gNSvL0O+DL/xA3i/TW8SdOqDKDokA1bUeE93UheJ/qC2oXzqnYTIRJUC6SGseSnRnf5YOA4p5dmacmiUkkwFxcKh9kh5oqGxDJJQMHWlQgAW/M4BnMS5yeU7Xi/UGiUs6CUseaKATYGjyImGOdzvgHKZ4mSGE54qz7zJsAUJ+mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747030504; c=relaxed/simple;
	bh=EKooAhtiHoAdagaXrnTxzsRLYeyjI1K+szXTpWSueog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qnq+Wafu1vEBjwtya4LyH+eayL9SZcFirPa5bX4JxzX6QnLdFygdTpEk7CAxmKb9xn0ksL70wZ5zORIDq60Mhw8oU5G56IP65llVEDHpVhbxH8oxkbMvIWROnlv95/3VqQU/R0b/Uoq0t9VZ+SMWFHKGelNdQGIztbPU8SPhFek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SHafz06P; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747030503; x=1778566503;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EKooAhtiHoAdagaXrnTxzsRLYeyjI1K+szXTpWSueog=;
  b=SHafz06PfQqo25hXe1WoQirQ7DqYXaLZwAYq1Wi2HdMdu06NDF8rMNtB
   CQy8cu8WONS2lMYMspa5XvZ945zjRZ7rNpVS+13fsQ32YDvpCtjanbJjp
   nE0mt+Iq3nWTOuF2W8XdgIafplOzvFwcsqXPQj0BJZkRDUwlaQDVVXghF
   5Y21/5DYGauje24SryNjslhbQrQWSYiyJEOGBQBLsjoptvLRwGPSlVD8+
   OauJJDntX2Ow4LEA9mxs7bOuUOHHo7S4CnRh8yZA4Beot7ZwSr7JSQpr7
   tWIY8p0Oh9fpXojADhUwDdu8iMqdlUGNy/w1vThN78fSYNyut5hKaQBqd
   A==;
X-CSE-ConnectionGUID: 9Qlyr9LxSzW/eky7v95Vdg==
X-CSE-MsgGUID: skn284UrQueum6WDOmYl6Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11430"; a="48963861"
X-IronPort-AV: E=Sophos;i="6.15,281,1739865600"; 
   d="scan'208";a="48963861"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2025 23:15:02 -0700
X-CSE-ConnectionGUID: RuIH5MOIQwOXiOJET7kgrA==
X-CSE-MsgGUID: 4LQsgkggQIiMuXFNqyoKyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,281,1739865600"; 
   d="scan'208";a="137203318"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2025 23:14:59 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1uEMRE-00000000pO8-2Q94;
	Mon, 12 May 2025 09:14:56 +0300
Date: Mon, 12 May 2025 09:14:56 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, corbet@lwn.net,
	linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
	linux@treblig.org, viro@zeniv.linux.org.uk,
	Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] relay: Remove unused relay_late_setup_files
Message-ID: <aCGR4EOcWRK6Rgfv@smile.fi.intel.com>
References: <CAL+tcoCVjihJc=exL4hJDaLFr=CrMx=2JgYO_F_m12-LP9Lc-A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL+tcoCVjihJc=exL4hJDaLFr=CrMx=2JgYO_F_m12-LP9Lc-A@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, May 12, 2025 at 09:12:56AM +0800, Jason Xing wrote:
> Hi All,
> 
> I noticed this patch "relay: Remove unused relay_late_setup_files"
> appears in the mm branch already[1], which I totally missed. Sorry for
> joining the party late.
> 
> I have a different opinion on this. For me, I'm very cautious about
> what those so-called legacy interfaces are and how they can work in
> different cases and what the use case might be... There are still a
> small number of out-of-tree users like me heavily relying on relayfs
> mechanism. So my humble opinion is that if you want to remove
> so-called dead code, probably clearly state why it cannot be used
> anymore in the future.
> 
> Dr. David, I appreciate your patch, but please do not simply do the
> random cleanup work __here__. If you take a deep look at the relayfs,
> you may find there are other interfaces/functions no one uses in the
> kernel tree.
> 
> I'm now checking this kind of patch in relayfs one by one to avoid
> such a thing happening. I'm trying to maintain it as much as possible
> since we internally use it in the networking area to output useful
> information in the hot paths, a little bit like blktrace. BTW, relayfs
> is really a wonderful one that helps kernel modules communicate with
> userspace very efficiently. I'm trying to revive it if I can.

Jason, with all of the respect, if you are interested in keeping things going
on, please add yourself to the MAINTAINERS. It will makes the users of the
legacy code, Andrew and others, who are doing maintainer's/reviewer's job,
and you happy.

Also note, we usually do not care about the out-of-tree users. The main Q here
why are they out-of-tree for so long time?

> [1]: https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/commit/?h=mm-everything&id=46aa76118ee365c25911806e34d28fc2aa5ef997

-- 
With Best Regards,
Andy Shevchenko



