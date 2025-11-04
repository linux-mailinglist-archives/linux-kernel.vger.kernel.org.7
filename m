Return-Path: <linux-kernel+bounces-885166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BD98C32299
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 17:55:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BF59F4EBF70
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 16:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97143337B8D;
	Tue,  4 Nov 2025 16:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RfY4IcWp"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F79E33710D
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 16:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762275298; cv=none; b=aLWQIx6M6BmYa37ka94bkcRnv2QoY5WOeSlotlnBezNMHEYoE8dSbK/Vidv4ZLK6+5Ivm96SnXXTwO4tHVKke6kaN0dZB3ajxjxfWVRjkEKAPNHtVi07kXG/z+fdan/q4WvB6XTWkGkP5KvMxjQZY25/wBneNQM7qvLDYa1zfh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762275298; c=relaxed/simple;
	bh=izwlWJtwmWiVudAGPCKbSPz0D0cfYBWGNCGgGzVUkps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qto8uv4NT0h2l6nl/GhuPlbNo9U9EHozzLgUoijlF/0YOUoEQQL7tZs2LnqPANCtAvoqnbKIBWHARJuaAtMd4bcWebC6o3sBTbeQYIvUDys/8kTjGUg5zJKlfR9OHFdlQExwdBszjA/iQEdPYh4LNUytiEwl6NS3ayiz6yJSa6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RfY4IcWp; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762275297; x=1793811297;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=izwlWJtwmWiVudAGPCKbSPz0D0cfYBWGNCGgGzVUkps=;
  b=RfY4IcWpGCFZbHmdxhWRn0BgwjZzPHPcuwjMB6Y/yQIhTMioSWUdqk1d
   o5g41p1wHEmzpS5hUDqMta5Fb6sCrM7AYu/LKlb8EYkslY2zDQNelMrEo
   HtQ1N6HYHtcvyeaBnDul9Q0DfB/d488zfKFdzcot4CMYaJLKdicEK4H0C
   s6XRFvhdFhGSKj3OLYklp+yLpq3pBKFE0mrf8v4MiKWxK3yxUAItWTkzC
   in357/dDQZzkur3SpKpoY7bt+Bx2uhPE6FVdn1ekAGpoR2oHs40yYPnyv
   5zQewSTSgpbIkYXrBSajNSpQZfu+kVklth/2Sg/aZHQ7uJG8aUkxEZxAe
   g==;
X-CSE-ConnectionGUID: otTM4H/sRHKh1dpoZ/Hr5w==
X-CSE-MsgGUID: 1xYuUU8KTKScY17D6rKJuw==
X-IronPort-AV: E=McAfee;i="6800,10657,11603"; a="64407759"
X-IronPort-AV: E=Sophos;i="6.19,279,1754982000"; 
   d="scan'208";a="64407759"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2025 08:54:56 -0800
X-CSE-ConnectionGUID: 0aUucrjFSbqEYm57TAJD9Q==
X-CSE-MsgGUID: vNgKcNVqRgSMYLFyxiWQRQ==
X-ExtLoop1: 1
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.245.146])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2025 08:54:54 -0800
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1vGKJ1-00000005WCz-2awh;
	Tue, 04 Nov 2025 18:54:51 +0200
Date: Tue, 4 Nov 2025 18:54:51 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: regulator branch mess
Message-ID: <aQov22j_S8LRzIdm@smile.fi.intel.com>
References: <aQoZ22aT27wHBpbI@smile.fi.intel.com>
 <aQocq1eRjOOjiRdY@finisterre.sirena.org.uk>
 <aQogTFANK1fMtloW@smile.fi.intel.com>
 <aQojdTvP94aYVW4l@finisterre.sirena.org.uk>
 <aQolne8AKHXdJw0-@smile.fi.intel.com>
 <aQonVNgqJI56nspA@smile.fi.intel.com>
 <aQoqPqVeQiHJ2tiF@finisterre.sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQoqPqVeQiHJ2tiF@finisterre.sirena.org.uk>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Nov 04, 2025 at 04:30:54PM +0000, Mark Brown wrote:
> On Tue, Nov 04, 2025 at 06:18:28PM +0200, Andy Shevchenko wrote:
> > On Tue, Nov 04, 2025 at 06:11:09PM +0200, Andy Shevchenko wrote:
> 
> > > The merge in your regulator tree for-6.19 branch which is
> 
> > >   commit 9de2057bbdfb58f4d9bb1476135317cd3fe6aa52 (patch)
> > >   tree 97c34e939fd59891ab122d191ebbe8837a0010d3
> > > 
> > >   regulator: pf9453: optimize PMIC PF9453 driver
> 
> > Because "base" keyword in the series points out to the 
> 
> >   commit 98bd8b16ae57e8f25c95d496fcde3dfdd8223d41 (tag: next-20251031)
> > 	Author: Stephen Rothwell <sfr@canb.auug.org.au>
> > 	Date:   Fri Oct 31 20:35:57 2025 +1100
> > 
> >   Add linux-next specific files for 20251031
> > 
> >   Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> 
> > And that merge did it. If you are going to send this to Linus, I believe it
> > will become a trouble.
> 
> No, that merge very much did not do that.  As you can tell with git log
> and from the diffstat I posted previously that linux-next commit does
> not appear in the history of the above commit.  You can also see this
> with git cherry:
> 
> $ git cherry origin/master regulator/for-6.19
> + 6277a486a7faaa6c87f4bf1d59a2de233a093248
> + 433e294c3c5b5d2020085a0e36c1cb47b694690a
> + 835dfb12fc389f36eb007657f163bd1c539dcd45
> + 1356c98ef911e14ccfaf374800840ce5bdcb3bbd
> + 6a8cdef7dc2a4c0dbde3f7d7100b3d99712a766b
> + 65efe5404d151767653c7b7dd39bd2e7ad532c2d
> + fb25114cd760c13cf177d9ac37837fafcc9657b5
> + f76dbe127f1b5910e37dfe307d2de5c13d61ed89
> + d054cc3a2ccfb19484f3b54d69b6e416832dc8f4
> + 01313661b248c5ba586acae09bff57077dbec0a5
> + 86df0030b71d7172317d957df17524a7fd6232d4
> + 4c33cef58965eb655a0ac8e243aa323581ec025f
> + 28039efa4d8e8bbf98b066133a906bd4e307d496
> + 252abf2d07d33b1c70a59ba1c9395ba42bbd793e
> + a2d4691b3fec6a2360e4ec953d06819ea055c3e7
> + 0144a2b29d95af8523c308116de65d398d6e935b
> + 2ecc8c089802e033d2e5204d21a9f467e2517df9
> 
> That is the full list of commits in the for-6.19 that do not already
> appear in mainline.

Yes, because this merge brings also rc3-rc4 bump:

$ git merge-base origin/master reg/for-6.19
6146a0f1dfae5d37442a9ddcba012add260bceb0

$ git describe 6146a0f1dfae5d37442a9ddcba012add260bceb0
v6.18-rc4

$ git merge-base origin/master reg/for-6.19^
dcb6fa37fd7bc9c3d2b066329b0d27dedf8becaa

$ git describe dcb6fa37fd7bc9c3d2b066329b0d27dedf8becaa
v6.18-rc3

Now I see the source of those 3kLoCs in the merge commit on GitWeb.

$ git diff --stat v6.18-rc3..v6.18-rc4
...
252 files changed, 2022 insertions(+), 854 deletions(-)

+ the changes on top that you mentioned above.

-- 
With Best Regards,
Andy Shevchenko



