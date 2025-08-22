Return-Path: <linux-kernel+bounces-781582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3834B31430
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 11:53:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2F68562AED
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 09:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CEA42EFD9E;
	Fri, 22 Aug 2025 09:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i6gmK0BZ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3A22882CA;
	Fri, 22 Aug 2025 09:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755855858; cv=none; b=nck03/i0nvJU9LXDBGlKFVm3xR4VvWBvdAVdGLMevwkKHhS9mbphTtOWLC6RlJKrKGHyDDJK5Fjd3C9AqwJgFmQVr6d8gv4IJSzuTfI+0ZJuERPy/NuIObKiLbQFy18a7ennsaOOvmqIJYcb5OOEn48escXy4kmosw2bhkt0zm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755855858; c=relaxed/simple;
	bh=W2C6Re7Vw3DtX+1rmGtIoWysL7yYT+6xAjbwTheXHf0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hR4KnnYy19YcIEd1w9eScKNXbKCuNvRY+ytfktSUemTyuzTPPkX71vGJn4mxhNdqZ1Y918Sw/dzgGvjnMRk4HuXSpkXWyPPIKnFGl0jqY9VV91ZJ7GvlnXpOmCTqqMYhXO39nhudYrUrmlWXA/1qSSEwjKcIT0dSVQRVwpsOJLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i6gmK0BZ; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755855857; x=1787391857;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=W2C6Re7Vw3DtX+1rmGtIoWysL7yYT+6xAjbwTheXHf0=;
  b=i6gmK0BZuZaHrrgAP2hrvI8btZa4nGIPKOR1XvHoljmaXBw0le/VE53C
   bIG6gBaANTj6ldGmtDmgedMbK0tudDc+uQtB0p3eKIerM9zSPTnu/v2mT
   WjJF451BfswBFqQuiTh4q+7l1hC1K1quNEv7ojyenQGJOUIw+1rGEJvNh
   tTc54SRj4Ce+anVAaR+e/OJStt4gS2fMEBT7vX9SKiEXUeRAm6N2bF3oZ
   Gdq6usy/2Jmu+umrN5DhrrJM+/AgkFOeY7SygC8tr6lOkiyhZJY90vyPa
   XopPew77TNFmY0Axgmxm/0dDTEsjSsyuwlUcpUAAA4S4TK0v7ZcSNt+Z5
   Q==;
X-CSE-ConnectionGUID: vubCQiGHQaKV4UX7uMedKg==
X-CSE-MsgGUID: Oo4v44Q5RnuXLSIbQowBXg==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="57362167"
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="57362167"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2025 02:44:17 -0700
X-CSE-ConnectionGUID: 0OcfKOZ0RUi9+kz/e89TkA==
X-CSE-MsgGUID: obP/HrmxQJi3iyj3ivPTUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="168571682"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa006.fm.intel.com with ESMTP; 22 Aug 2025 02:44:15 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1upOJg-000L8F-11;
	Fri, 22 Aug 2025 09:44:12 +0000
Date: Fri, 22 Aug 2025 17:43:20 +0800
From: kernel test robot <lkp@intel.com>
To: Jisheng Zhang <jszhang@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 2/2] clocksource/drivers: Add ARM SSE(Subsystems for
 Embedded) Timer driver
Message-ID: <202508221736.qO3Ji6Dw-lkp@intel.com>
References: <20250821152429.26995-3-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250821152429.26995-3-jszhang@kernel.org>

Hi Jisheng,

kernel test robot noticed the following build errors:

[auto build test ERROR on tip/timers/core]
[also build test ERROR on robh/for-next linus/master v6.17-rc2 next-20250822]
[cannot apply to daniel-lezcano/clockevents/next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jisheng-Zhang/dt-bindings-timer-Add-ARM-SSE-Subsystems-for-Embedded-timer/20250822-000122
base:   tip/timers/core
patch link:    https://lore.kernel.org/r/20250821152429.26995-3-jszhang%40kernel.org
patch subject: [PATCH 2/2] clocksource/drivers: Add ARM SSE(Subsystems for Embedded) Timer driver
config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20250822/202508221736.qO3Ji6Dw-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250822/202508221736.qO3Ji6Dw-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508221736.qO3Ji6Dw-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/clocksource/timer-sse.c: In function 'sse_setup_clockevent':
>> drivers/clocksource/timer-sse.c:228:13: error: implicit declaration of function 'FIELD_GET' [-Wimplicit-function-declaration]
     228 |         if (FIELD_GET(CNTP_CFG_AIVAL_MASK, val) == CNTP_CFG_AIVAL_IMPL) {
         |             ^~~~~~~~~


vim +/FIELD_GET +228 drivers/clocksource/timer-sse.c

   211	
   212	static int sse_setup_clockevent(struct device *dev, struct sse_timer_frame *f,
   213					unsigned long rate)
   214	{
   215		int ret;
   216		u32 val = readl_relaxed(f->base + CNTP_CFG);
   217	
   218		f->ticks_per_jiffy = DIV_ROUND_UP(rate, HZ);
   219	
   220		f->ce.name = "sse-timer";
   221		f->ce.rating = 300;
   222		f->ce.irq = f->irq;
   223		f->ce.cpumask = cpu_possible_mask;
   224		f->ce.features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT | CLOCK_EVT_FEAT_DYNIRQ;
   225		f->ce.set_state_shutdown = sse_ce_shutdown;
   226		f->ce.set_next_event = sse_ce_next_event;
   227		f->ce.set_state_oneshot_stopped = sse_ce_shutdown;
 > 228		if (FIELD_GET(CNTP_CFG_AIVAL_MASK, val) == CNTP_CFG_AIVAL_IMPL) {
   229			f->ce.set_state_periodic = sse_ce_set_periodic;
   230			f->ce.set_state_oneshot = sse_ce_set_oneshot;
   231		}
   232	
   233		clockevents_config_and_register(&f->ce, rate, 0xf, ULONG_MAX);
   234	
   235		ret = devm_request_irq(dev, f->irq, sse_timer_interrupt,
   236				       IRQF_TIMER | IRQF_NOBALANCING,
   237				       f->ce.name, f);
   238		if (ret) {
   239			dev_err(dev, "Unable to register interrupt\n");
   240			return ret;
   241		}
   242	
   243		return 0;
   244	}
   245	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

