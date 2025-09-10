Return-Path: <linux-kernel+bounces-809344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CFCAB50C39
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 05:13:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D56803A4591
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 03:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B6B3258ED6;
	Wed, 10 Sep 2025 03:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tq6ok0J/"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA78247299
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 03:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757474002; cv=none; b=MhomX0M1WMnO3WleIYCiTTiYwjNXTcmVrPjfDHtiglWZPXAD7GjdSn0tg6uWoPh9TABVs12sZWawM7ICCVIdBfPThPUAFPjNUZreGM258NVTrhVc7I6q5tO6Z8ep+hdUkYaVe/SBQCFBlleQHMF0w24FMMZTfJ1BVw6BfzJwqg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757474002; c=relaxed/simple;
	bh=J28vm5b6yIuBl/feMLo1OI7gbTHwbuYVhkxdzVRaG00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UvfpTqk89WlGnxq8q0TVVEg5no3Bg1kOkmswmhBeW/WlPCdwFYah6VkdzIy80kSUhycLegfub8vQMrb+/qKE6wcB5nD7crsW4dUu5TU7bZTS5vAJ7EDLE1Sg+3+8qj/2/f1h5FhAjjDMoaW8MsDRaSP1mDoSM1rVJD056yJmQAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tq6ok0J/; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757474001; x=1789010001;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=J28vm5b6yIuBl/feMLo1OI7gbTHwbuYVhkxdzVRaG00=;
  b=Tq6ok0J//DgE7o2uSNYpHkZRcv/xBwqXaJ5OEj9e2HmcHM+lRxDAlUOK
   4UTkKoTMEJIo6rcHM9NYQxoNUCSuqYNR8dfazLB5L7C+NYwHDd9PnlWvI
   WAxmsSsm07Gf9m4KRRDzlL/VdATFNsZIfum+jzjrmAI3srd5JK/Fg4vmR
   PyNlwB/Svr2/AnH/eluy5em0K/lmgrIntsj/eoLlFfrLkQIkrJaSEB4JO
   DeeiOYEz+woihKIhHvIiQvTFyBU9wsu1Lp9ien7uY8E3zpgkKm82loRio
   ZsST8T6491EN6FM92Q4ngqGn9drmtMgHBpEZBlb9uRCC/A0sMXHJK/xJv
   A==;
X-CSE-ConnectionGUID: VXM0nMDcQASoSkNL6DHKpA==
X-CSE-MsgGUID: /lllq/06SBSoiqFwRajAow==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="59724039"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="59724039"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2025 20:13:19 -0700
X-CSE-ConnectionGUID: 9SPwsoCdTx6D29kUADR0dA==
X-CSE-MsgGUID: fxUCTiCCQlOlmo9Byb1KLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,253,1751266800"; 
   d="scan'208";a="196935774"
Received: from lkp-server01.sh.intel.com (HELO 114d98da2b6c) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 09 Sep 2025 20:13:17 -0700
Received: from kbuild by 114d98da2b6c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uwBGl-0005Up-0m;
	Wed, 10 Sep 2025 03:13:15 +0000
Date: Wed, 10 Sep 2025 11:12:37 +0800
From: kernel test robot <lkp@intel.com>
To: Haofeng Li <920484857@qq.com>, John Stultz <jstultz@google.com>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Stephen Boyd <sboyd@kernel.org>, Haofeng Li <13266079573@163.com>
Subject: Re: [PATCH] timekeeping: Move debug sleep time accounting outside
 spinlock
Message-ID: <202509101047.oTfSjXyE-lkp@intel.com>
References: <tencent_6FBD7FB2B5EDA57B1481766C52482D033008@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_6FBD7FB2B5EDA57B1481766C52482D033008@qq.com>

Hi Haofeng,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tip/timers/core]
[also build test WARNING on linus/master v6.17-rc5 next-20250909]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Haofeng-Li/timekeeping-Move-debug-sleep-time-accounting-outside-spinlock/20250909-183705
base:   tip/timers/core
patch link:    https://lore.kernel.org/r/tencent_6FBD7FB2B5EDA57B1481766C52482D033008%40qq.com
patch subject: [PATCH] timekeeping: Move debug sleep time accounting outside spinlock
config: m68k-allnoconfig (https://download.01.org/0day-ci/archive/20250910/202509101047.oTfSjXyE-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250910/202509101047.oTfSjXyE-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509101047.oTfSjXyE-lkp@intel.com/

All warnings (new ones prefixed by >>):

   kernel/time/timekeeping.c: In function 'timekeeping_resume':
>> kernel/time/timekeeping.c:1986:55: warning: suggest braces around empty body in an 'if' statement [-Wempty-body]
    1986 |                 tk_debug_account_sleep_time(&ts_delta);
         |                                                       ^


vim +/if +1986 kernel/time/timekeeping.c

  1929	
  1930	/**
  1931	 * timekeeping_resume - Resumes the generic timekeeping subsystem.
  1932	 */
  1933	void timekeeping_resume(void)
  1934	{
  1935		struct timekeeper *tks = &tk_core.shadow_timekeeper;
  1936		struct clocksource *clock = tks->tkr_mono.clock;
  1937		struct timespec64 ts_new, ts_delta;
  1938		bool inject_sleeptime = false;
  1939		u64 cycle_now, nsec;
  1940		unsigned long flags;
  1941	
  1942		read_persistent_clock64(&ts_new);
  1943	
  1944		clockevents_resume();
  1945		clocksource_resume();
  1946	
  1947		raw_spin_lock_irqsave(&tk_core.lock, flags);
  1948	
  1949		/*
  1950		 * After system resumes, we need to calculate the suspended time and
  1951		 * compensate it for the OS time. There are 3 sources that could be
  1952		 * used: Nonstop clocksource during suspend, persistent clock and rtc
  1953		 * device.
  1954		 *
  1955		 * One specific platform may have 1 or 2 or all of them, and the
  1956		 * preference will be:
  1957		 *	suspend-nonstop clocksource -> persistent clock -> rtc
  1958		 * The less preferred source will only be tried if there is no better
  1959		 * usable source. The rtc part is handled separately in rtc core code.
  1960		 */
  1961		cycle_now = tk_clock_read(&tks->tkr_mono);
  1962		nsec = clocksource_stop_suspend_timing(clock, cycle_now);
  1963		if (nsec > 0) {
  1964			ts_delta = ns_to_timespec64(nsec);
  1965			inject_sleeptime = true;
  1966		} else if (timespec64_compare(&ts_new, &timekeeping_suspend_time) > 0) {
  1967			ts_delta = timespec64_sub(ts_new, timekeeping_suspend_time);
  1968			inject_sleeptime = true;
  1969		}
  1970	
  1971		if (inject_sleeptime) {
  1972			suspend_timing_needed = false;
  1973			__timekeeping_inject_sleeptime(tks, &ts_delta);
  1974		}
  1975	
  1976		/* Re-base the last cycle value */
  1977		tks->tkr_mono.cycle_last = cycle_now;
  1978		tks->tkr_raw.cycle_last  = cycle_now;
  1979	
  1980		tks->ntp_error = 0;
  1981		timekeeping_suspended = 0;
  1982		timekeeping_update_from_shadow(&tk_core, TK_CLOCK_WAS_SET);
  1983		raw_spin_unlock_irqrestore(&tk_core.lock, flags);
  1984	
  1985		if (inject_sleeptime && timespec64_valid_strict(&ts_delta))
> 1986			tk_debug_account_sleep_time(&ts_delta);
  1987	
  1988		/* Resume the clockevent device(s) and hrtimers */
  1989		tick_resume();
  1990		/* Notify timerfd as resume is equivalent to clock_was_set() */
  1991		timerfd_resume();
  1992	}
  1993	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

