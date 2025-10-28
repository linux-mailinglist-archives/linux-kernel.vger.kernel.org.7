Return-Path: <linux-kernel+bounces-873038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B4B1C12E2F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 05:57:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B27914F08B1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 04:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03930295DAC;
	Tue, 28 Oct 2025 04:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B2DFdbPu"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FDCE273D9A
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 04:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761627443; cv=none; b=SOTKdj0BVXnVt8x4Z04Rle31frW4fiQ/yYfkvuvVP8qZA0upjcLr4cbosaBtqm2/4e9DKbJShqyOJIoTTFq8uJ3zDHf703r8Pw1lu3tUbYWDVbLjqyOWMgne2+djYJ7AZsMs59MGh+wVCTKur1LOKPSS0QLzZ3l3S+OEpsvI+lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761627443; c=relaxed/simple;
	bh=uBAahjZdhdahvA1/zYVD0LO8QR+Y8RWVUwmXJwwAv9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JAIuVEkv1kEGYEzdjiufqRFcFyEyEYgrqM9mNK6LzuwKYnpMZM7wgKO84hpZqnBp95EqVj24zLO84N5mDKu58UvIvcMGg0FMK91LJBBSHeMB+fz/5AglMs0dC/2oXVl/oIHRq7JCIb4GgB+7cjbuFvnWuVn6o6FU5rX0NR/ZMkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B2DFdbPu; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761627441; x=1793163441;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uBAahjZdhdahvA1/zYVD0LO8QR+Y8RWVUwmXJwwAv9Q=;
  b=B2DFdbPunz9qUUolBSGrEa7xhM0PCBriOPS8Vqi2kDhYc4zSYxnJ/Ta+
   xy2fDxygrSVJCjXRc0XMMdqQ9o2HpE6lGsokznbLqQNiwmiK5C5jPFwI2
   5ba6cmFAUO7vIjyN2iDNqA3X5ig4RtpOMhVAmkSfFyBjwRyKH/tt3yWOo
   WiUFzLv6fsYV38ZwWwE/LJRrkhoOY9J+N/CG8RodDCNmNwVXi2Z2qi56H
   cr9BQNh+gAiaua/i43aSysd7xsarXj+IYGgvE6SevCgTswjIfDeDq5GM5
   CWMxwN0NAuz0vKp6i8F5vnxMYgX03CaFLO0oLm8uBRA65ZlbsNNymWDBV
   g==;
X-CSE-ConnectionGUID: yymWd6x5Tg+Ls0WNCDWrWQ==
X-CSE-MsgGUID: F5RYSqMNRuGBo/pOA1XMmw==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="86344903"
X-IronPort-AV: E=Sophos;i="6.19,260,1754982000"; 
   d="scan'208";a="86344903"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 21:57:20 -0700
X-CSE-ConnectionGUID: U+S+xsEeTNO7YALn4jqalQ==
X-CSE-MsgGUID: yPu8p8PFRt63clUK6Tr7Ow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,260,1754982000"; 
   d="scan'208";a="189553465"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa004.jf.intel.com with ESMTP; 27 Oct 2025 21:57:18 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vDblj-000IlX-0n;
	Tue, 28 Oct 2025 04:57:15 +0000
Date: Tue, 28 Oct 2025 12:56:20 +0800
From: kernel test robot <lkp@intel.com>
To: John Ogness <john.ogness@linutronix.de>, Petr Mladek <pmladek@suse.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Breno Leitao <leitao@debian.org>, Mike Galbraith <efault@gmx.de>,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v2 1/1] printk: nbcon: Allow unsafe write_atomic()
 for panic
Message-ID: <202510281239.CrKvR38C-lkp@intel.com>
References: <20251027161212.334219-2-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027161212.334219-2-john.ogness@linutronix.de>

Hi John,

kernel test robot noticed the following build errors:

[auto build test ERROR on 62627bf0cadf6eae87d92fecf604c42160fe16ef]

url:    https://github.com/intel-lab-lkp/linux/commits/John-Ogness/printk-nbcon-Allow-unsafe-write_atomic-for-panic/20251028-001756
base:   62627bf0cadf6eae87d92fecf604c42160fe16ef
patch link:    https://lore.kernel.org/r/20251027161212.334219-2-john.ogness%40linutronix.de
patch subject: [PATCH printk v2 1/1] printk: nbcon: Allow unsafe write_atomic() for panic
config: x86_64-allnoconfig (https://download.01.org/0day-ci/archive/20251028/202510281239.CrKvR38C-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251028/202510281239.CrKvR38C-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510281239.CrKvR38C-lkp@intel.com/

All errors (new ones prefixed by >>):

>> kernel/printk/nbcon.c:1938:77: error: too many arguments to function call, expected 2, have 3
    1938 |         __nbcon_atomic_flush_pending_con(ctxt->console, prb_next_reserve_seq(prb), false);
         |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~                                           ^~~~~
   kernel/printk/nbcon.c:1519:12: note: '__nbcon_atomic_flush_pending_con' declared here
    1519 | static int __nbcon_atomic_flush_pending_con(struct console *con, u64 stop_seq)
         |            ^                                ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   1 error generated.


vim +1938 kernel/printk/nbcon.c

49f7d3054e8461 Marcos Paulo de Souza 2025-10-16  1916  
49f7d3054e8461 Marcos Paulo de Souza 2025-10-16  1917  /**
49f7d3054e8461 Marcos Paulo de Souza 2025-10-16  1918   * nbcon_kdb_release - Exit unsafe section and release the nbcon console
49f7d3054e8461 Marcos Paulo de Souza 2025-10-16  1919   *
49f7d3054e8461 Marcos Paulo de Souza 2025-10-16  1920   * @wctxt:	The nbcon write context initialized by a successful
49f7d3054e8461 Marcos Paulo de Souza 2025-10-16  1921   *		nbcon_kdb_try_acquire()
49f7d3054e8461 Marcos Paulo de Souza 2025-10-16  1922   */
49f7d3054e8461 Marcos Paulo de Souza 2025-10-16  1923  void nbcon_kdb_release(struct nbcon_write_context *wctxt)
49f7d3054e8461 Marcos Paulo de Souza 2025-10-16  1924  {
49f7d3054e8461 Marcos Paulo de Souza 2025-10-16  1925  	struct nbcon_context *ctxt = &ACCESS_PRIVATE(wctxt, ctxt);
49f7d3054e8461 Marcos Paulo de Souza 2025-10-16  1926  
49f7d3054e8461 Marcos Paulo de Souza 2025-10-16  1927  	if (!nbcon_context_exit_unsafe(ctxt))
49f7d3054e8461 Marcos Paulo de Souza 2025-10-16  1928  		return;
49f7d3054e8461 Marcos Paulo de Souza 2025-10-16  1929  
49f7d3054e8461 Marcos Paulo de Souza 2025-10-16  1930  	nbcon_context_release(ctxt);
49f7d3054e8461 Marcos Paulo de Souza 2025-10-16  1931  
49f7d3054e8461 Marcos Paulo de Souza 2025-10-16  1932  	/*
49f7d3054e8461 Marcos Paulo de Souza 2025-10-16  1933  	 * Flush any new printk() messages added when the console was blocked.
49f7d3054e8461 Marcos Paulo de Souza 2025-10-16  1934  	 * Only the console used by the given write context was	blocked.
49f7d3054e8461 Marcos Paulo de Souza 2025-10-16  1935  	 * The console was locked only when the write_atomic() callback
49f7d3054e8461 Marcos Paulo de Souza 2025-10-16  1936  	 * was usable.
49f7d3054e8461 Marcos Paulo de Souza 2025-10-16  1937  	 */
49f7d3054e8461 Marcos Paulo de Souza 2025-10-16 @1938  	__nbcon_atomic_flush_pending_con(ctxt->console, prb_next_reserve_seq(prb), false);

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

