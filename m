Return-Path: <linux-kernel+bounces-727006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49656B013D9
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 08:44:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5274F1C46308
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 06:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29D121D90A5;
	Fri, 11 Jul 2025 06:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mIeYjvX9"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB8B18DB2A
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 06:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752216289; cv=none; b=Wg9snRowq6YsDbM09QcBU0a+V+0SxFH0Iq3A6vevdxJ+THEtPgm+MxRDRf9+qWscjh8u7vQtqj9Fn8WAtpPVn/myB3LRJ3ZjGlf6M+Ih2CIhHj7ab673mjyqGAR3ekJ/Gn+et0fFokNdcJGxWxhHc69B1bVRsUC43CdIeoVuMsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752216289; c=relaxed/simple;
	bh=IwMHeqST3LMiK28n56UkPVwryksyKcJCNDGnAXNd7Vg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UbkkFm2Z8glqvJiAmU2URBOkA1cMBt9pnd9vjC4NjszX9xMvJ79vuwyyh8dovqrQ5IFMUrR2kWkoKMvSxUjQBl0v+hT5QWJeg5TMxzVA9LvD5kmTKvxYZ/sEdAIpNZobFzyLI6y5N/T29eWL4vZWmtRecrvYnUIWiXfklba9njE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mIeYjvX9; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752216288; x=1783752288;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IwMHeqST3LMiK28n56UkPVwryksyKcJCNDGnAXNd7Vg=;
  b=mIeYjvX9Yz7WC0N1COK+4Ff12qCypOJ67bBiNsGAzM8jug0UxJesTZo8
   c6KNJp0Toj8xGqYYg+M1ndzBPZ90IQJg7r1gidxtTO2iB6TZWKq1UkGtm
   ewsZWvbBZ7K4++/drjfC1IsyDSg8O+Ux757s4Y3VfPZ+OyD+gVzYzCI+U
   ZBsFqTKDDstsZTE/l/xgG2BZ7m/pGZMqyflGpS2+MROUx9qm/lDs2I+No
   JlVqW6Xub1IaDRJ6FmdwB7pzJ2mdAwFYzvPRdhx4FaZyFfoRm1O+GCkzm
   rwVjUfspRW4f2Fez9lD4JFSy/RrZleph+fcplpyqt9Kt9BNyS/kcXPLbU
   Q==;
X-CSE-ConnectionGUID: 93ZBGA5JRWCAFxRJYblyxg==
X-CSE-MsgGUID: 6jouvTVmSlSqIuHWRp+Leg==
X-IronPort-AV: E=McAfee;i="6800,10657,11490"; a="77053923"
X-IronPort-AV: E=Sophos;i="6.16,302,1744095600"; 
   d="scan'208";a="77053923"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 23:44:47 -0700
X-CSE-ConnectionGUID: M/f7YHXsRYymQCpBlKVFNw==
X-CSE-MsgGUID: nBfK+5raQYmgP4b2svChoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,302,1744095600"; 
   d="scan'208";a="160627285"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 23:44:45 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1ua7Uv-0000000ERSK-28Wm;
	Fri, 11 Jul 2025 09:44:41 +0300
Date: Fri, 11 Jul 2025 09:44:41 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Feng Tang <feng.tang@linux.alibaba.com>
Cc: Nathan Chancellor <nathan@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH v1 1/1] panic: Fix compilation error (`make W=1`)
Message-ID: <aHCy2Tv0zmhklKdo@smile.fi.intel.com>
References: <20250710094816.771656-1-andriy.shevchenko@linux.intel.com>
 <20250710150133.680679cf8a0f6b2f0bf3369f@linux-foundation.org>
 <aHBgwRrFfmEWcp-T@U-2FWC9VHC-2323.local>
 <20250711014947.GA863150@ax162>
 <aHB7fV7QgNp8Fre4@U-2FWC9VHC-2323.local>
 <aHCpbB7cfwfdFBzl@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aHCpbB7cfwfdFBzl@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Jul 11, 2025 at 09:04:29AM +0300, Andy Shevchenko wrote:
> On Fri, Jul 11, 2025 at 10:48:29AM +0800, Feng Tang wrote:
> > On Thu, Jul 10, 2025 at 06:49:47PM -0700, Nathan Chancellor wrote:

...

> > We can even move the SYS_INFO_MAX_LEN definition close to si_names[],
> 
> Agree.
> 
> > initially sys_info_avail[] was next to si_names[], and was moved inside
> > "#ifdef CONFIG_SYSCTL" region for compiling CONFIG_SYSCTL=n case.
> 
> But let me think a bit, perhaps we can come up with something even better.

Okay, guys, I have a better approach found. Let me mock up a patch series
for that (we need one prerequisite).

-- 
With Best Regards,
Andy Shevchenko



