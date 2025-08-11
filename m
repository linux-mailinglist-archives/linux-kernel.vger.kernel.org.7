Return-Path: <linux-kernel+bounces-762697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B076DB209F4
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 15:21:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2103F7A3BBD
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 13:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6FD42DAFAE;
	Mon, 11 Aug 2025 13:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I2t8Vr4j"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A40B1F5820
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 13:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754918472; cv=none; b=mAeqTi+6Ur1GdiBWSldchErWSQlRxgXYQLeoOLO9LmJm/xgd8SqPe1UOA0yANM16sDvb+L5wjh2aAoOXhVgEjWZpvhFqrYoR9J43AXUPzH17LVTSUrI5FLs7Ky5baekroNd0yK4zLZZHnXuYdqu04HskZPv1au3lIRK1smvcpAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754918472; c=relaxed/simple;
	bh=A1TThLOoDEkiQlFyAVrtQhx629cMyOmSqpXLIw6U4yU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g8DD9cdP6xD6t9p+F35CuiMIcZbW8XUxuTyLasGG80n47ERVVvNuIAojGKMVWJVWESZAMctOwfM1ien10Ra0TFONV+RO0yQVdGPwCSG49VHAcWIUkHPqLuZfwomesOiNZFUfest9nrJvUYUJFDY2CVuQUVqrUpK/6+5YU9z62+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I2t8Vr4j; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754918470; x=1786454470;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=A1TThLOoDEkiQlFyAVrtQhx629cMyOmSqpXLIw6U4yU=;
  b=I2t8Vr4jd+jUEDpAVTr70ETogdcasThgcI77Xp+o0OR9y0EzTAF1DJqG
   8lTv4YXXwYqyc1fDqI3kj0h2BHfhcDlXrUqNZkNTetARuiT7oZIs7z4F/
   hQ8Vy16oCKKXsbkiZjiCreEBCyalFCCr+VewDdv6QRMX8T+qktLjooScU
   oDa4kYSTPEy/Df7LlbBnHAXjGt75d8/M3TdX/DEvWl/XpyIXJz3ZODOVP
   gnK2Nof4YxghTRZ+Nw7wkjJ3FUkSh92fcMkP3pplhAX1K7VrCqaya3qu9
   ydNsoZyfrtQ34mvPPrX2itkLgGhG9vyBuA3x1uuagGDavhE4S61wNzAjY
   A==;
X-CSE-ConnectionGUID: XQtHdnNGTMaquz6K4bEcKA==
X-CSE-MsgGUID: Y8ta1B4kSXCaj4ENTBCGWA==
X-IronPort-AV: E=McAfee;i="6800,10657,11518"; a="67439435"
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="67439435"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2025 06:21:08 -0700
X-CSE-ConnectionGUID: IB80K2C/R72kfq9K+MD+bQ==
X-CSE-MsgGUID: HTj0ihfSRey0qtxwcu9/Hg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="170032382"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa003.fm.intel.com with ESMTP; 11 Aug 2025 06:21:07 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id D699F94; Mon, 11 Aug 2025 15:21:05 +0200 (CEST)
Date: Mon, 11 Aug 2025 15:21:05 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 6.17-rc1
Message-ID: <aJnuQXzFxiFPkk6T@black.igk.intel.com>
References: <CAHk-=wgb=B_pGPSTw9y4Fw82y5V_mvzJp_0XcWanz7YRR5vkXA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgb=B_pGPSTw9y4Fw82y5V_mvzJp_0XcWanz7YRR5vkXA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sun, Aug 10, 2025 at 08:08:47PM +0300, Linus Torvalds wrote:
> So two weeks have passed, and depending on how you see it, rc1 is
> either earlier than usual (it's only Sunday morning back home in the
> usual timezone) or later than usual (because it's getting to be Sunday
> evening here in Finland where I'm cutting the release). I decided to
> basically split the difference on my usual "early Sunday afternoon"
> schedule.
> 
> Anyway, due to travels, I wanted to do most of the heavy lifting the
> first week, and I can happily report that that part worked out well. I
> wouldn't want to do this most merge windows, but the bulk of the work
> was done before travel, and that meant that the straggler pulls were
> manageable while traveling. Thanks to everybody who got their pulls in
> early - you know who you are.
> 
> And the late stragglers then got a slightly more annoyed Linus as a
> result. Sorry about that.
> 
> Anyway, the merge window did end up looking fairly healthy, despite me
> having to go through a couple of bisections for trouble spots (one
> during travels with a laptop - not optimal, but thankfully it was at
> least one of the "reliable symptoms that bisect right to the culprit"
> kind). The stats look pretty normal both in patch size and in number
> of commits. That number being large enough that - as always - you only
> get the mergelog below as a kind of "view from 10,000ft" of the
> development process this time around.
> 
> Please do get started testing and fixing,

FWIW, it's broken in c couple of places for `make W=1` builds, details below.

ext4:
commit 261a2abe20b0 ("ext4: fix unused variable warning in ext4_init_new_dir")
in Linux Next, but missed rc1

timers, etc (clang only):
discussion and partial fix is here
https://lore.kernel.org/all/aIo18KZpmKuR4hVZ@black.igk.intel.com/
https://lore.kernel.org/lkml/20250804220955.1453135-1-dan.j.williams@intel.com/

(haven't tested full allyesconfig and allmodconfig, though)

-- 
With Best Regards,
Andy Shevchenko



