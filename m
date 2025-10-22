Return-Path: <linux-kernel+bounces-865551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F3E4BFD5D8
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 18:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1781C1885244
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 16:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D426F2BE7B2;
	Wed, 22 Oct 2025 16:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P/2AF4m9"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665EF2BE7C3
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 16:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761151619; cv=none; b=l0i6ReowUJll+eRK3o7ftU6ynmmnGiPXu0LHuLOj2+QlbawFmtMeHHMwNd2AXbBWZX1iybuCr6X+T41NXfqoF91X+cSARggrTcnujYzgBDMaQu2ntepboroJvlZ6CJB0Xc9v9g7TWwZGR6DURC6HDpr8PPH9UlV/xLydDInlGZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761151619; c=relaxed/simple;
	bh=Z2XJiNmkuJ0fIw4QCMTv+KndSSTCiyYTnR4KJCWszJo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hXSFFJOU5f7IFp43cDVH3N4Ka1TolhEtCk2Go2zOf8lpAco9rPDZLxWQMABnupZNiNJB/M9XMudx3sluGwbi+BYDYZJSQSiRii3PKlyb6/0cmRhlRQGal0o4F3qh+dZul66qEFHCrsMOa2esYv5ugYIy92bvIa72ACE5ayrgyrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P/2AF4m9; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761151617; x=1792687617;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Z2XJiNmkuJ0fIw4QCMTv+KndSSTCiyYTnR4KJCWszJo=;
  b=P/2AF4m9BAKxaXQWoM1YffzKqyjhC8ZNCYCtRkMeRl6HR1q4Mfnye081
   sQ8Q7fa5el8bV2BaPHecfIYgYrZYaka+uQ1b/5ewA84I6bm92hGkCNzoL
   wIEPgRZe/rLcc+8tWML6IxS0lOxNtlTxlqpvqcL0zT44vuDlG6MjBhkHv
   EmVcPHMWOlZbZsuIHUHfTvbU7iNJdoVbT0cdqJo6+75gzf9wSq7uDaAxg
   BMHHKIUST9S/FXcDTfueB3l/Xs2UlRyCSvZpCOxeVxJtxksxOqC5dLdAI
   Jnpx1omUE364/YFq5iz4W4CzKOaztp+IxU0SOPXlO4ngopqUFMOJPhyDn
   w==;
X-CSE-ConnectionGUID: fZaP6PWcTEqp2g/zK6xJbQ==
X-CSE-MsgGUID: LMmz3sZTSa+lhniKedQrnA==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="73912339"
X-IronPort-AV: E=Sophos;i="6.19,247,1754982000"; 
   d="scan'208";a="73912339"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2025 09:46:56 -0700
X-CSE-ConnectionGUID: QhzpkzgrRuqRtAsUZ26e/A==
X-CSE-MsgGUID: 0Um1dRhZQYaJ33aPFS6DFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,247,1754982000"; 
   d="scan'208";a="214863158"
Received: from cpetruta-mobl1.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.244.83])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2025 09:46:53 -0700
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1vBbz8-00000001kNv-1QFe;
	Wed, 22 Oct 2025 19:46:50 +0300
Date: Wed, 22 Oct 2025 19:46:50 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>
Subject: Re: [PATCH v1 1/1] sched: Remove never used code in mm_cid_get()
Message-ID: <aPkKei1uy8k1xnha@smile.fi.intel.com>
References: <20251015091935.2977229-1-andriy.shevchenko@linux.intel.com>
 <aPYKpJ4MdjlGeILa@ashevche-desk.local>
 <20251020104934.GQ3419281@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251020104934.GQ3419281@noisy.programming.kicks-ass.net>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Oct 20, 2025 at 12:49:34PM +0200, Peter Zijlstra wrote:
> On Mon, Oct 20, 2025 at 01:10:44PM +0300, Andy Shevchenko wrote:
> > On Wed, Oct 15, 2025 at 11:19:34AM +0200, Andy Shevchenko wrote:
> > > Clang is not happy with set but unused variable (this is visible
> > > with `make W=1` build:
> > > 
> > > kernel/sched/sched.h:3744:18: error: variable 'cpumask' set but not used [-Werror,-Wunused-but-set-variable]
> > > 
> > > It seems like the variable was never be used along with the assignment that
> > > does not have side effects as far as I can see. Remove those altogether.
> > 
> > Anybody to apply this for fixes?
> 
> Why? W=1 and WERROR is very much you get to keep the pieces land, no?

The builds I have almost W=1 clean, I have only a couple of patches which I try
to push forward (already for a few releases). Your patch to move static inline
unused function warning to level 2 would drop them, leaving the above the only
culprit so far.

-- 
With Best Regards,
Andy Shevchenko



