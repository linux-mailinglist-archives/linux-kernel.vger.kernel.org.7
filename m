Return-Path: <linux-kernel+bounces-727542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34EE6B01B9A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 14:13:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF58A540646
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 12:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99EAB28C2D2;
	Fri, 11 Jul 2025 12:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nAcYueRC"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7103E2877FB
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 12:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752235996; cv=none; b=rLj/QHhciMPrdEcRHAGD/hRySrBDtKAGOFrvgqOnhEWuhp4uxqQOLABTo4hVjQiHTvfzJ7B+FlZ4OfTacr1Hmtt1T8C5Dk1mrgEfAC1WPcgJA7SP9yjcbbTMAXEwaL2M0S3foHdPkYi2Ad9uY8TteqOA3eV0S40Q1c9qfjZV6+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752235996; c=relaxed/simple;
	bh=PFP89s7Tk4OiG7iXu4URRBz970cc0c3IhJf6nX3fV3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SlNcKt3yMcH4dRgHLfe/fpecCZqp3G7ZvGnPevQeNo3aqzLsXvgrfcEmqVOn8CXnloEbOmkbfa7wD7OrWx/Z5YPAkCvTYLdgiOFjEWw5o3XsjpyOqXduORUiKP2fyzYi8XHxJW4XSV4RKya4Q/+kcochelNn77BVesx1GKlWpLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nAcYueRC; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752235994; x=1783771994;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PFP89s7Tk4OiG7iXu4URRBz970cc0c3IhJf6nX3fV3w=;
  b=nAcYueRCOZcTNrOwkGY9vfomGFK0QECAgxIbCxRvr7pR6yXzNeiPBxOO
   uA1Y4plii26e3vRUQMHJ4xkBPBvNkdm2IvKqWY2O4LVkJSFbgJji5+Bi2
   qp0LPBA8UEhDhRWzeXxOrtj1njSxMJzWTctaV4szQ8U9JxxX9nCCPy4M9
   ECN7+s4TX4bz/69qDEsdTkUHH7clXelblPL7O4Gq515NAFJTmxGhWuXwf
   NTDw4XjGxzCYsyk/41BLahwSbBPpiZIWQVMTrQvUo+3nVSPaOsXCLb2cG
   grt3IrhEU14E/9QQbiGTJ7bO6ddLcMNFrGK+Fbhc21vXGEzdAXsKZiS99
   g==;
X-CSE-ConnectionGUID: f81TTZsWQc6taPFNwnIUrg==
X-CSE-MsgGUID: 5GI7BmR8S5eFFFNczZKyKQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="53642676"
X-IronPort-AV: E=Sophos;i="6.16,303,1744095600"; 
   d="scan'208";a="53642676"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 05:13:14 -0700
X-CSE-ConnectionGUID: d4fFEr0OQrOfcd34t+FpFQ==
X-CSE-MsgGUID: GBZKi98jTA2aNQRiY5Toog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,303,1744095600"; 
   d="scan'208";a="155773852"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 05:13:12 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1uaCcn-0000000EWDa-2SYL;
	Fri, 11 Jul 2025 15:13:09 +0300
Date: Fri, 11 Jul 2025 15:13:09 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Feng Tang <feng.tang@linux.alibaba.com>, linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Nathan Chancellor <nathan@kernel.org>
Subject: Re: [rft, PATCH v1 0/7] panic: sys_info: Refactor and fix a
 compilation issue
Message-ID: <aHD_1QopiVCU-vzh@smile.fi.intel.com>
References: <20250711095413.1472448-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250711095413.1472448-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Jul 11, 2025 at 12:51:06PM +0300, Andy Shevchenko wrote:
> While targeting the compilation issue due to dangling variable,
> I have noticed more opportunities for refactoring that helps to
> avoid above mentioned compilation issue and make code cleaner in
> general. Please, give it a try.
> 
> I put a revert as the first patch of the previous solution, but I believe
> the previous solution may be pulled out without a problem.

Btw, I can try to pop the fix upper in the series, but since this
whole feature was only a few days old, I propose to drop it completely
for now and start again. Please, Cc me for the review.

-- 
With Best Regards,
Andy Shevchenko



