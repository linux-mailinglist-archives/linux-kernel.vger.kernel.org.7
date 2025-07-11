Return-Path: <linux-kernel+bounces-727966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFA9DB021E3
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 18:34:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 252EA17513C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 16:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 696132EF2B2;
	Fri, 11 Jul 2025 16:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Popdtsq9"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CEF8167DB7
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 16:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752251670; cv=none; b=l7qq2lI20eB64NYu5is5EoPm1FihHXs7LZFKIpNYqNHVlChiIC61P1KvKMB5CQ8MMop2Zw7OgSS8Mu7yJohgvIJcjElKFlBW2kUxnaw58at04BLC8RPK/mdl+bQKvCxpew7IbSUcl9gyI1q+yx3n1StC7laXskXb/puyaHpRIno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752251670; c=relaxed/simple;
	bh=RZjyckc3Wj2pK2ZJFVLOxwpUUXvPzZ0oGSNiWN0h8Pw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jG4ffu6MBqBuzP4yTJnoWAOfv3dBafekMl5ZWhB2/Zd9GYBHlCp2cedBYd0oTRZnJOXv/s0FO1WzO29aVFTwT/AtZP3l1d2uxL09Iz4Ze5Wj7TwMBJSHsFrpPBohZPTya0walypKpLVJVT+JjRTsTDpz892FT2ZbopDoVhtu5Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Popdtsq9; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752251670; x=1783787670;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RZjyckc3Wj2pK2ZJFVLOxwpUUXvPzZ0oGSNiWN0h8Pw=;
  b=Popdtsq9ohsS26N3RB97LZqOo2tIzwxTvEb5FYIbqQ+6i38HbNJTDswI
   1sOKhB8GSz3YCoPDyyYgRFk3z1g4pEtt+ITWiZ5GPlNE8OHrV6s1xEEQQ
   +3YPYu4XC6zT+MA/SoDT53OoshXF4U9IKJrrSVd9C18wt5iAjsj4hj5yc
   bVqdrwhhUsspNMHO7tqB1kk1Cd4KThylGiBAg+83rvD1/q1LIZ/dNPkAl
   kC8i3a9TaV4dTWnhVKUteY+sCJB4Ex0+i7sncC54wDQB9idCQKGj56rRz
   139DQfQr8NvQqb2aYEnBSsbtc6UVrsI9Y8F76EY0zZGCyQGr8OeqpJLzF
   Q==;
X-CSE-ConnectionGUID: 2ZECliwKQ3WXKBzSoHbD8w==
X-CSE-MsgGUID: rw51KWqiT4GcXkYBvCNfHQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="54711514"
X-IronPort-AV: E=Sophos;i="6.16,304,1744095600"; 
   d="scan'208";a="54711514"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 09:34:29 -0700
X-CSE-ConnectionGUID: r9p+XPAhRaeLHYHoz/pByw==
X-CSE-MsgGUID: eDyA4amkSGGiTkw17Mq7ww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,304,1744095600"; 
   d="scan'208";a="156189405"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 09:34:27 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1uaGhc-0000000EaEH-1hqz;
	Fri, 11 Jul 2025 19:34:24 +0300
Date: Fri, 11 Jul 2025 19:34:24 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Feng Tang <feng.tang@linux.alibaba.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH v1 7/7] panic: sys_info: Factor out read and write
 handlers
Message-ID: <aHE9EEbsCuDOfD3J@smile.fi.intel.com>
References: <20250711095413.1472448-1-andriy.shevchenko@linux.intel.com>
 <20250711095413.1472448-8-andriy.shevchenko@linux.intel.com>
 <aHEpHEtnPms2LUi-@U-2FWC9VHC-2323.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aHEpHEtnPms2LUi-@U-2FWC9VHC-2323.local>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Jul 11, 2025 at 11:09:16PM +0800, Feng Tang wrote:
> On Fri, Jul 11, 2025 at 12:51:13PM +0300, Andy Shevchenko wrote:
> > For the sake of the code readability and easier maintenance
> > factor out read and write sys_info handlers.
> 
> IIRC, I did implement separate 'write' handler, but chose not
> to do that to save some common definition. I guess it's personal
> preference, and I'm fine with either one. 

It looks better, in my opinion, to be three functions.

-- 
With Best Regards,
Andy Shevchenko



