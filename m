Return-Path: <linux-kernel+bounces-879598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29E14C238A7
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 08:25:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82AD7402589
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 07:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00ED032937D;
	Fri, 31 Oct 2025 07:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HGKyfpaL"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51DA25DAFF
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 07:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761895522; cv=none; b=EgCWk8vbAmBwu4YqY3PyofY42doPNlYvwyQN6855hehvvNi1tbcQF39JyD0fS5b2EPgx0F8xHUI5aeD3DuJRtkpuY4ZMay1dQ8b+Cdnj7Nk9D03qkeXADv5U10ZhfzyvMyaryfbBpnNGhZqpu8oX67eSkQfaxd2eWuyM8/DegtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761895522; c=relaxed/simple;
	bh=C3eZSS8z3LSf2sAESbnv4Q1UGgFPhlCaETKRLgM3u3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nVFWWy4HC0krmUJYLMpvE/MftZYCLO0MxygKtHBqqbGpbiVhxQdqVQgmIgjL9UFBVNOFmXhA15iMGHvqSDNiadvLeqEmF/Ww9KNlTtkJ+uXfDgBvruvS698aK0fjyuZQtFjH6DzPWwlTD7BNS+UpJtj+h7cjTP5q4E7cfQJCV4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HGKyfpaL; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761895521; x=1793431521;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=C3eZSS8z3LSf2sAESbnv4Q1UGgFPhlCaETKRLgM3u3Y=;
  b=HGKyfpaLS4YChzPWlssAruI9BCIAqMMamsPWmgur8VzGkqbLRuRBpQkN
   Sk4CtpEzk7fvIABqH9LwRKP0+KVoUp9FmyILTWq5wQI9QwScmAuMH/Y6Z
   Mv9KDkX73cV/iWxNAPOIl14ki7kkecUQdWk4fRWovPEbUOwwqV6qHVVJB
   g4yIjqw8QYO8JnyjgM6xKYzZafcXXDSjYyijeyDngcFdo4mEd6vcgb8i8
   27pfq9vowiSaMJA+rX+fB6oGsOOqf1pikonckJ1vnxxEpr1htPxSII5VZ
   2QxG6M0zNod6NxFinXCytP3xp6Bm/KGfJMQ3nPJ+Q88ck6vCd2WfVFGc9
   A==;
X-CSE-ConnectionGUID: kyxk37QAR5q0rN6CD+rm+A==
X-CSE-MsgGUID: 0xUv/2F0SvKrdI12W+z9iQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11598"; a="74342518"
X-IronPort-AV: E=Sophos;i="6.19,268,1754982000"; 
   d="scan'208";a="74342518"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 00:25:20 -0700
X-CSE-ConnectionGUID: 3XgsTor8QjSpX5Ru3vbLhA==
X-CSE-MsgGUID: 25+w+DC6SO6b+0e6M8J1gQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,268,1754982000"; 
   d="scan'208";a="217003010"
Received: from mgoodin-mobl3.amr.corp.intel.com (HELO ashevche-desk.local) ([10.124.220.66])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 00:25:17 -0700
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1vEjVZ-00000004C3W-2nPr;
	Fri, 31 Oct 2025 09:25:13 +0200
Date: Fri, 31 Oct 2025 09:25:12 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Feng Tang <feng.tang@linux.alibaba.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 6/6] panic: sys_info: Factor out read and write
 handlers
Message-ID: <aQRkWFW1O3QrlR-w@smile.fi.intel.com>
References: <20251030132007.3742368-1-andriy.shevchenko@linux.intel.com>
 <20251030132007.3742368-7-andriy.shevchenko@linux.intel.com>
 <20251030201612.8970ca04e861a4f111cc1371@linux-foundation.org>
 <aQRjp4dgn6yWASqC@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQRjp4dgn6yWASqC@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Oct 31, 2025 at 09:22:16AM +0200, Andy Shevchenko wrote:
> On Thu, Oct 30, 2025 at 08:16:12PM -0700, Andrew Morton wrote:
> > On Thu, 30 Oct 2025 12:44:22 +0100 Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

...

> > checkpatch wanted this:
> 
> Makes sense. Have you applied this update to your tree already? Or should I
> send (re-send) a formal patch?

Never mind, I see it's there, thanks!

> Thank you for the review!

-- 
With Best Regards,
Andy Shevchenko



