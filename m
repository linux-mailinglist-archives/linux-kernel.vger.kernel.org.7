Return-Path: <linux-kernel+bounces-809477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1592AB50E19
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 08:39:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0754482AA6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 06:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F39CD305063;
	Wed, 10 Sep 2025 06:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nUvsQpLJ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2AED246788;
	Wed, 10 Sep 2025 06:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757486388; cv=none; b=ita0U14V1i9i+fOdIlGsV7FBrm8rKnTP6hUw+W7apZEaoTuIaOeSki+WuBRdqRZnzGUlVuCTtu2c7fjgf6NFZ3panq68bGqs831uK40p6iEsc6TYMlx50DlIb4oSFF5NYfkLGS5AKvDDmPMvGJRsmfP2X4ThrW2YwT12sDXRaOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757486388; c=relaxed/simple;
	bh=zpOHZC/gXQcma22GGygnWRWcRNGegH/ozfLbDoXfWIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F0yDBQR4SIuQSLWIFJzRWeRHgV7J1e4OgxQat0el7wU/F+xM5ISR4pKcNM9mClSKZpDEVjdVY45e7QNqp57DBrmfhwo/hd3Z6V24jxF7GQsIx+whav/ESqrkjSmy4iOP9UO4/vxYGcK3teWc7WJm4n+yrkvlaXLaWuluOBI76A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nUvsQpLJ; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757486385; x=1789022385;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zpOHZC/gXQcma22GGygnWRWcRNGegH/ozfLbDoXfWIY=;
  b=nUvsQpLJH/RD+9YbV9yT1WwYYYcTJe8XX2nCCAF8M8LX7bEb5Xrp2PrQ
   PXdglwDtZGdEkIws4JVsjZTxZE28SbL8lEhMWqVEP6xYIrXB4THFoALWD
   z7hOQ6gtHZdlgrXCAU5OeibhkUu1cThyahMmTb18z3zildvNDcI2iDHPv
   Vi4XOB0ISQpDuErUI283tAaZnGvTrPaIGr4kqIyqTqNJAQJjDrhmwNY/K
   VC2FRMyM/WHzh5XimdGmF1UgYDf7A71ziR0wHrxYlTbvHen1Pz6sv8+HH
   khug2MQOb8+KmTimTVN5pWwmbRZ4LZNyR+/3qNR6lxdJATZ7zagfwtggq
   Q==;
X-CSE-ConnectionGUID: k3+z5K3eRyGGmrBgfzWwvA==
X-CSE-MsgGUID: BFIVsmdHTEGr19X0bkT6SQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11548"; a="59861661"
X-IronPort-AV: E=Sophos;i="6.18,253,1751266800"; 
   d="scan'208";a="59861661"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2025 23:39:43 -0700
X-CSE-ConnectionGUID: PYuGWqYjQrSQjsZJI/J+1A==
X-CSE-MsgGUID: zM8uovvHQZiOvlj6Zd0FSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,253,1751266800"; 
   d="scan'208";a="178518386"
Received: from lkp-server01.sh.intel.com (HELO 114d98da2b6c) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 09 Sep 2025 23:39:40 -0700
Received: from kbuild by 114d98da2b6c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uwEUS-0005bP-2L;
	Wed, 10 Sep 2025 06:39:36 +0000
Date: Wed, 10 Sep 2025 14:39:22 +0800
From: kernel test robot <lkp@intel.com>
To: Gokul Praveen <g-praveen@ti.com>, j-keerthy@ti.com, vigneshr@ti.com,
	wbg@kernel.org, linux-kernel@vger.kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, g-praveen@ti.com, u-kumar1@ti.com,
	n-francis@ti.com
Subject: Re: [PATCH 2/2] counter: ti-dmtimer-cap : capture driver support for
 OMAP DM timer
Message-ID: <202509101412.ze6xyOUu-lkp@intel.com>
References: <20250909080042.36127-3-g-praveen@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909080042.36127-3-g-praveen@ti.com>

Hi Gokul,

kernel test robot noticed the following build errors:

[auto build test ERROR on robh/for-next]
[also build test ERROR on linus/master v6.17-rc5 next-20250909]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Gokul-Praveen/dt-bindings-counter-Add-new-ti-omap-dmtimer-cap-compatible/20250909-160651
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20250909080042.36127-3-g-praveen%40ti.com
patch subject: [PATCH 2/2] counter: ti-dmtimer-cap : capture driver support for OMAP DM timer
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20250910/202509101412.ze6xyOUu-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250910/202509101412.ze6xyOUu-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509101412.ze6xyOUu-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/counter/ti-dmtimer-cap.c: In function 'cap_omap_dmtimer_is_enabled':
>> drivers/counter/ti-dmtimer-cap.c:73:31: error: 'const struct omap_dm_timer_ops' has no member named 'get_cap_status'; did you mean 'get_pwm_status'?
      73 |         status = omap->pdata->get_cap_status(omap->dm_timer);
         |                               ^~~~~~~~~~~~~~
         |                               get_pwm_status
   drivers/counter/ti-dmtimer-cap.c: In function 'cap_omap_dmtimer_apply':
>> drivers/counter/ti-dmtimer-cap.c:117:26: error: 'const struct omap_dm_timer_ops' has no member named 'set_cap'
     117 |         ret = omap->pdata->set_cap(omap->dm_timer, true, true);
         |                          ^~
   drivers/counter/ti-dmtimer-cap.c: In function 'cap_omap_dmtimer_capture':
>> drivers/counter/ti-dmtimer-cap.c:140:34: error: 'const struct omap_dm_timer_ops' has no member named 'read_cap'
     140 |         *duty_cycle = omap->pdata->read_cap(omap->dm_timer, false);
         |                                  ^~
   drivers/counter/ti-dmtimer-cap.c: In function 'cap_omap_dmtimer_period':
   drivers/counter/ti-dmtimer-cap.c:161:29: error: 'const struct omap_dm_timer_ops' has no member named 'read_cap'
     161 |         period = omap->pdata->read_cap(omap->dm_timer, true);
         |                             ^~
   drivers/counter/ti-dmtimer-cap.c: In function 'cap_omap_dmtimer_probe':
   drivers/counter/ti-dmtimer-cap.c:355:19: error: 'const struct omap_dm_timer_ops' has no member named 'set_cap'
     355 |             !pdata->set_cap ||
         |                   ^~
   drivers/counter/ti-dmtimer-cap.c:356:21: error: 'const struct omap_dm_timer_ops' has no member named 'get_cap_status'; did you mean 'get_pwm_status'?
     356 |             !pdata->get_cap_status ||
         |                     ^~~~~~~~~~~~~~
         |                     get_pwm_status
   drivers/counter/ti-dmtimer-cap.c:357:23: error: 'const struct omap_dm_timer_ops' has no member named 'read_cap'
     357 |                 !pdata->read_cap ||
         |                       ^~


vim +73 drivers/counter/ti-dmtimer-cap.c

    62	
    63	/**
    64	 * cap_omap_dmtimer_is_enabled() -  Detect if the timer capture is enabled.
    65	 * @omap:	Pointer to cap omap dm timer counter
    66	 *
    67	 * Return true if capture is enabled else false.
    68	 */
    69	static bool cap_omap_dmtimer_is_enabled(struct cap_omap_dmtimer_counter *omap)
    70	{
    71		u32 status;
    72	
  > 73		status = omap->pdata->get_cap_status(omap->dm_timer);
    74	
    75		return !!(status & OMAP_TIMER_CTRL_ST);
    76	}
    77	
    78	static int cap_omap_dmtimer_clk_get_freq(struct counter_device *counter,
    79					 struct counter_signal *signal, u64 *freq)
    80	{
    81		struct cap_omap_dmtimer_counter *omap = counter_priv(counter);
    82		struct clk *fclk;
    83	
    84		fclk = omap->pdata->get_fclk(omap->dm_timer);
    85		if (!fclk) {
    86			dev_err(counter->parent, "invalid dmtimer fclk\n");
    87			return -EINVAL;
    88		}
    89	
    90		*freq = clk_get_rate(fclk);
    91		if (!(*freq)) {
    92			dev_err(counter->parent, "invalid dmtimer fclk rate\n");
    93			return -EINVAL;
    94		}
    95	
    96		return 0;
    97	}
    98	/**
    99	 * cap_omap_dmtimer_apply() - Changes the state of the cap omap dm timer counter.
   100	 * @counter:Pointer to capture counter.
   101	 *
   102	 * Return 0 if successfully changed the state else appropriate error.
   103	 */
   104	static int cap_omap_dmtimer_apply(struct counter_device *counter)
   105	{
   106		struct cap_omap_dmtimer_counter *omap = counter_priv(counter);
   107		struct device *dev = &omap->dm_timer_pdev->dev;
   108		int ret = 0;
   109	
   110		/* Ensure that the timer is in stop mode so that the configs can be changed. */
   111		if (cap_omap_dmtimer_is_enabled(omap)) {
   112			ret = omap->pdata->stop(omap->dm_timer);
   113			if (ret)
   114				dev_err(dev, "%d: Failed to stop timer.\n", ret);
   115		}
   116	
 > 117		ret = omap->pdata->set_cap(omap->dm_timer, true, true);
   118		if (ret) {
   119			dev_err(dev, "%d: Failed to set timer capture configuration.\n", ret);
   120			return ret;
   121		}
   122	
   123		cap_omap_dmtimer_start(omap);
   124	
   125		return ret;
   126	}
   127	
   128	static int cap_omap_dmtimer_capture(struct counter_device *counter,
   129						struct counter_count *count, u64 *duty_cycle)
   130	{
   131		struct cap_omap_dmtimer_counter *omap = counter_priv(counter);
   132		*duty_cycle = 0;
   133	
   134		if (!omap->enabled) {
   135			dev_err(counter->parent, "Timer is disabled.\n");
   136			omap->pdata->stop(omap->dm_timer);
   137			return 0;
   138		}
   139	
 > 140		*duty_cycle = omap->pdata->read_cap(omap->dm_timer, false);
   141	
   142		*duty_cycle = *duty_cycle > 0 ? *duty_cycle : 0;
   143	
   144		return *duty_cycle;
   145	}
   146	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

