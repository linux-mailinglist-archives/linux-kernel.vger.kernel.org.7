Return-Path: <linux-kernel+bounces-762706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6D24B20A0D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 15:24:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1BA22A3474
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 13:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A88432DE703;
	Mon, 11 Aug 2025 13:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mIHe//iC"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2AC02DEA6A
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 13:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754918643; cv=none; b=aqN8OT3aj3Q5z6BNqiDHiuXJ39MpuRfsOJg7mU22BpcWqGp9RCV3d2iYdNSfDBkq92H9WsJVnTQiuCu2+z/3m9+hAYYI+6zKN/TbBgvA20bn8qDBYtFd8AB8vPPgIQdi+8jGfP74HRtAGyrDa1cSHo1MpA/pbCKuTQWDUTxFP/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754918643; c=relaxed/simple;
	bh=2oCV/tmLOmqpVoLuapfOXm7nB9elHE+IX51xIxOKNj0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jvf5VrEekyB2ACi6hTcNrJqz6HHFMzIp4w7OTL2+xVWtyR8MxFhbpExW8r764V7cTIpG6Xz9zXe2WwUZAtL2QM4HIk/wTCASsqJowxHguSbga3Jm60N8wrlcsxhWm6FyyUrGuiX/Wj+iNqBhnpORmAJ7uMYtYUveIRA9lSdI6z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mIHe//iC; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754918642; x=1786454642;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2oCV/tmLOmqpVoLuapfOXm7nB9elHE+IX51xIxOKNj0=;
  b=mIHe//iC8JwZifB5qC/kHce9cEZMb8aAsqb0SZbL8SrBHW5bkUxL8pIA
   Gd+K7yk8A3/F8XMLlvI7O7KtYP60y4nf5RHCCKuqXdalVSVqNVScss9RF
   fjZSnSbx7FWm+VCbenMPXYpCZS90GsmzI+iIysqsL3cT+t+poLWK5QXeS
   fNddpCsxkDBwcOmxyyFdgoQdZE4hRpNqXNEhXib35fLCq348kVpDvCDg1
   wZh+kspiHOrq1YZ8Uf8U2RevyF/SM/7ddLY0FiLu2+7ZS7NxUynwh1HS5
   aBC71pQJeBh1Ztl1onN+XjQ+t+Y2XTOlGu8iNONaA5jvyYZOgeDAk4ZAO
   w==;
X-CSE-ConnectionGUID: FI74toueSaqbzl879nRpNw==
X-CSE-MsgGUID: Ol1/n+J2TuOb2yJnZkVlwA==
X-IronPort-AV: E=McAfee;i="6800,10657,11518"; a="57127334"
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="57127334"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2025 06:24:01 -0700
X-CSE-ConnectionGUID: yEVNJJocTWmCGdRdxv2DKw==
X-CSE-MsgGUID: aCSCCXqQSZOqkLlXfeilog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="165912266"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa007.jf.intel.com with ESMTP; 11 Aug 2025 06:24:01 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 0074994; Mon, 11 Aug 2025 15:23:58 +0200 (CEST)
Date: Mon, 11 Aug 2025 15:23:58 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 6.17-rc1
Message-ID: <aJnu7jW-ZHdaFjmx@black.igk.intel.com>
References: <CAHk-=wgb=B_pGPSTw9y4Fw82y5V_mvzJp_0XcWanz7YRR5vkXA@mail.gmail.com>
 <aJnuQXzFxiFPkk6T@black.igk.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJnuQXzFxiFPkk6T@black.igk.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Aug 11, 2025 at 03:21:05PM +0200, Andy Shevchenko wrote:
> On Sun, Aug 10, 2025 at 08:08:47PM +0300, Linus Torvalds wrote:

...

> > Please do get started testing and fixing,
> 
> FWIW, it's broken in c couple of places for `make W=1` builds, details below.

Should have mentioned that my configuration is based on default x86 (32- and
64-bit ones) with a few drivers added.

> ext4:
> commit 261a2abe20b0 ("ext4: fix unused variable warning in ext4_init_new_dir")
> in Linux Next, but missed rc1
> 
> timers, etc (clang only):
> discussion and partial fix is here
> https://lore.kernel.org/all/aIo18KZpmKuR4hVZ@black.igk.intel.com/
> https://lore.kernel.org/lkml/20250804220955.1453135-1-dan.j.williams@intel.com/
> 
> (haven't tested full allyesconfig and allmodconfig, though)

-- 
With Best Regards,
Andy Shevchenko



