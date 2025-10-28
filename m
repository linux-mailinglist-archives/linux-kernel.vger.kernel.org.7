Return-Path: <linux-kernel+bounces-873037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 03D57C12E2C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 05:57:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9A95B4E6855
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 04:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD84A286D73;
	Tue, 28 Oct 2025 04:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gC1Rm9kZ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70254279327
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 04:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761627442; cv=none; b=PiOGiMC5SykQN2wlBg//Zkx04kaMuQgs5ZwtT9PC7rZ+eiIx42zJBRk1ieJM5/o7vjLzdo3gSpdXQ8MoDaAZCiztcBv27VIfc+u/KwGvBTckHUKosxvlXnJl3pNOwaTzMGRetOcV4Xs/r9iBh1fahYRj9r5bJyiTlNCPJ3KPOYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761627442; c=relaxed/simple;
	bh=gPQfuEP/NZtPxYyRhADM36SQ+VAYokglStYcpOmvZ0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I44Li4GEIJos6R04olXLFzHA5xEAj974n37GAECMDSZZ4mmPNDgib20g6L4YZZo0itvX7q5nZh4KTdA9HcgY4Zn+GaHSofK4RCmqFhJ4EVjo4XiAbVgX9It9PbS5JHmD/kWN75Lb9idZy6rn50JiWDr4KsrbGvATx8V6ndAtTZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gC1Rm9kZ; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761627441; x=1793163441;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gPQfuEP/NZtPxYyRhADM36SQ+VAYokglStYcpOmvZ0c=;
  b=gC1Rm9kZzEb+1IdZOpGQyaRaAvww721WV0IR2BLbWSm15nf4hiUQ/pDa
   6bHxDCQ9vSgFF5TEPvGQOKN6iX190AIp3o9ZtPRmoi5EwDRJU3T5+p/kq
   L7J7oAs/dMw5TOvItlapSDMfwc5AA6I3ScHX+K6K2coVjUXS68eKkUcwz
   ZqTB7lvAPNH1UiW14yF4+aZeIwKOVWROPDjB+mRAI37bTbFnV6gMzWo67
   OgpZnAze2nq8pNGy/+ULp8YurJatXV7TyGGJf4ehBpOG7AVKulZbhaoy7
   +F43SQ5BNG1e2tXTeB3XzAK4ro0O4m9sAVEKELqP36h9kLND+NfZjAGiX
   A==;
X-CSE-ConnectionGUID: qcT0wP1dRIKeOEivBIpSBA==
X-CSE-MsgGUID: nLaT4OImTqehdNEp6xXO2Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63606250"
X-IronPort-AV: E=Sophos;i="6.19,260,1754982000"; 
   d="scan'208";a="63606250"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 21:57:20 -0700
X-CSE-ConnectionGUID: yU3cw6qhRyWiUC1Pp48qsg==
X-CSE-MsgGUID: Wfa3N62LRJ+5gui+d0i2TA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,260,1754982000"; 
   d="scan'208";a="184420275"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa006.jf.intel.com with ESMTP; 27 Oct 2025 21:57:18 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vDblj-000IlV-0j;
	Tue, 28 Oct 2025 04:57:15 +0000
Date: Tue, 28 Oct 2025 12:56:04 +0800
From: kernel test robot <lkp@intel.com>
To: John Ogness <john.ogness@linutronix.de>, Petr Mladek <pmladek@suse.com>
Cc: oe-kbuild-all@lists.linux.dev,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Breno Leitao <leitao@debian.org>, Mike Galbraith <efault@gmx.de>,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v2 1/1] printk: nbcon: Allow unsafe write_atomic()
 for panic
Message-ID: <202510281206.cLKMJ90G-lkp@intel.com>
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
config: m68k-allnoconfig (https://download.01.org/0day-ci/archive/20251028/202510281206.cLKMJ90G-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251028/202510281206.cLKMJ90G-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510281206.cLKMJ90G-lkp@intel.com/

All errors (new ones prefixed by >>):

   kernel/printk/nbcon.c: In function 'nbcon_kdb_release':
>> kernel/printk/nbcon.c:1938:9: error: too many arguments to function '__nbcon_atomic_flush_pending_con'; expected 2, have 3
    1938 |         __nbcon_atomic_flush_pending_con(ctxt->console, prb_next_reserve_seq(prb), false);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~                                           ~~~~~
   kernel/printk/nbcon.c:1519:12: note: declared here
    1519 | static int __nbcon_atomic_flush_pending_con(struct console *con, u64 stop_seq)
         |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/__nbcon_atomic_flush_pending_con +1938 kernel/printk/nbcon.c

49f7d3054e84617 Marcos Paulo de Souza 2025-10-16  1916  
49f7d3054e84617 Marcos Paulo de Souza 2025-10-16  1917  /**
49f7d3054e84617 Marcos Paulo de Souza 2025-10-16  1918   * nbcon_kdb_release - Exit unsafe section and release the nbcon console
49f7d3054e84617 Marcos Paulo de Souza 2025-10-16  1919   *
49f7d3054e84617 Marcos Paulo de Souza 2025-10-16  1920   * @wctxt:	The nbcon write context initialized by a successful
49f7d3054e84617 Marcos Paulo de Souza 2025-10-16  1921   *		nbcon_kdb_try_acquire()
49f7d3054e84617 Marcos Paulo de Souza 2025-10-16  1922   */
49f7d3054e84617 Marcos Paulo de Souza 2025-10-16  1923  void nbcon_kdb_release(struct nbcon_write_context *wctxt)
49f7d3054e84617 Marcos Paulo de Souza 2025-10-16  1924  {
49f7d3054e84617 Marcos Paulo de Souza 2025-10-16  1925  	struct nbcon_context *ctxt = &ACCESS_PRIVATE(wctxt, ctxt);
49f7d3054e84617 Marcos Paulo de Souza 2025-10-16  1926  
49f7d3054e84617 Marcos Paulo de Souza 2025-10-16  1927  	if (!nbcon_context_exit_unsafe(ctxt))
49f7d3054e84617 Marcos Paulo de Souza 2025-10-16  1928  		return;
49f7d3054e84617 Marcos Paulo de Souza 2025-10-16  1929  
49f7d3054e84617 Marcos Paulo de Souza 2025-10-16  1930  	nbcon_context_release(ctxt);
49f7d3054e84617 Marcos Paulo de Souza 2025-10-16  1931  
49f7d3054e84617 Marcos Paulo de Souza 2025-10-16  1932  	/*
49f7d3054e84617 Marcos Paulo de Souza 2025-10-16  1933  	 * Flush any new printk() messages added when the console was blocked.
49f7d3054e84617 Marcos Paulo de Souza 2025-10-16  1934  	 * Only the console used by the given write context was	blocked.
49f7d3054e84617 Marcos Paulo de Souza 2025-10-16  1935  	 * The console was locked only when the write_atomic() callback
49f7d3054e84617 Marcos Paulo de Souza 2025-10-16  1936  	 * was usable.
49f7d3054e84617 Marcos Paulo de Souza 2025-10-16  1937  	 */
49f7d3054e84617 Marcos Paulo de Souza 2025-10-16 @1938  	__nbcon_atomic_flush_pending_con(ctxt->console, prb_next_reserve_seq(prb), false);

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

