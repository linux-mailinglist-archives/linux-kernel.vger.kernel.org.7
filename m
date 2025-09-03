Return-Path: <linux-kernel+bounces-798491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CFF16B41EB9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 14:19:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D3601BA0C97
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 12:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 960232E8B7F;
	Wed,  3 Sep 2025 12:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GxF2hQ7U"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B462719E81F
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 12:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756901972; cv=none; b=UVVtKqiJ92n/GFKVxI4AzJoVI8T2RhX4t+RUvEbFEqK1I1Y5+P3mV/ZxxyOMokvIl0Ufn1x78mWCHR4B30I/IKVnqQAa5HTLjjE9DvrHgF3ib/8pMpq6OM8cNp/eohDWbmsTdlH54z84LvX9r4x7y4ta6803o6nm7oZRpCqe/jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756901972; c=relaxed/simple;
	bh=YI0+EHjhLzw59hUheYkH9NxfUW5fMOLu0vW5nSKDt8U=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Om77yEQ28um4NVW33HJJPy6Mqq4dHOaKpyCzUvBUkLv5/hpY1X/CW7kJjvpIVsMbgolhMXdbjc8h9P06/p3DW+IS4lPrzWOKSu9h2bj+WWM8XZQVl0QMV5as7wVGLjbNDvT5HWwhQNiiVydgpzuAj4ZCypA1avNVvBplbuVIETE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GxF2hQ7U; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756901971; x=1788437971;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=YI0+EHjhLzw59hUheYkH9NxfUW5fMOLu0vW5nSKDt8U=;
  b=GxF2hQ7UsF6G8MMzuzKYkfCZuntqM2KY9uQxz20EoCkXQ0SDaxJcZcqj
   XP1BEDU6Ic+IFYOHPp+Ozg1scWgcoVt1puP7CXbO/fTuekJKSiHYrePhH
   Aot23qNVRVt07zYdmeaQZM84KCJspK4mAGuLMjuSqcYWQmnQjozDMbjt4
   ZVEp+UkrHH9Cei2N/83jQZVFILsHtw4Np1Ef7sfLxyofTQLn9kL9/8QuQ
   x2yzNR8EiWmYG9CPJ9lddiI8/4g8a2E6X031hfc/B2n293TAznuqaE55e
   PUTeIjA87+/DMEkD/UGX97Qxbs3U8FGcT8z3OAQluS5TiXm2E9M7DVYwf
   A==;
X-CSE-ConnectionGUID: ADItS9VzRU25MU4114OfzA==
X-CSE-MsgGUID: jQD0vBWUReSwKRJjDXV1XQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11541"; a="76656063"
X-IronPort-AV: E=Sophos;i="6.18,235,1751266800"; 
   d="scan'208";a="76656063"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2025 05:19:29 -0700
X-CSE-ConnectionGUID: 4OufXThASAKLDtD8YbEFxQ==
X-CSE-MsgGUID: 8/QpRYhdSEKqc3nTMv0XUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,235,1751266800"; 
   d="scan'208";a="171133977"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.1])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2025 05:19:27 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 3 Sep 2025 15:19:23 +0300 (EEST)
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
cc: LKML <linux-kernel@vger.kernel.org>, Peter Tyser <ptyser@xes-inc.com>, 
    Lee Jones <lee@kernel.org>
Subject: Re: [PATCH v1 2/2] mfd: lpc_ich: Convert to use resource_rebase()
In-Reply-To: <aLgcLju74eF5V78-@smile.fi.intel.com>
Message-ID: <c0a40afb-aff9-f68d-c9e5-179b90a61434@linux.intel.com>
References: <20250903081414.1972179-1-andriy.shevchenko@linux.intel.com> <20250903081414.1972179-3-andriy.shevchenko@linux.intel.com> <aLgcLju74eF5V78-@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 3 Sep 2025, Andy Shevchenko wrote:

> On Wed, Sep 03, 2025 at 10:12:29AM +0200, Andy Shevchenko wrote:
> > Simplify the resource handling by converting to use resource_rebase().
> > No functional change intended.
> 
> ...
> 
> >  	for (i = 0; i < info->nr_resources; i++) {
> >  		struct resource *mem = info->resources[i];
> > -		resource_size_t offset = info->offsets[i];
> >  
> > -		/* Fill MEM resource */
> > -		mem->start = base.start + offset;
> > -		mem->end = base.start + offset + INTEL_GPIO_RESOURCE_SIZE - 1;
> > -		mem->flags = base.flags;
> > +		/* Rebase MEM resource */
> > +		resource_rebase(mem, base.start);
> >  	}
> 
> We may gain 3 LoC more by dropping temporary variable.

Yeah, drop that super-obvious comment as well. :-)

> But I will wait for the reviews in general before mocking up v2 of this.
> 
> 

-- 
 i.


