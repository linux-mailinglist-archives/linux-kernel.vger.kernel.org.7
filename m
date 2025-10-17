Return-Path: <linux-kernel+bounces-857176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D0CCBE617A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 04:18:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBAE3423E21
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 02:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A8D9221D87;
	Fri, 17 Oct 2025 02:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZsaEeUSv"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A841F1518
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 02:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760667478; cv=none; b=t1Vqp6KSy8UNOhkP8VTYchDKtQTdPybB1QHnXvSGeAkIHYT3a+oYHKSzbDcp6eg9bZCYfWlZ3aICHNDKNxWcvbZLHGLzfdoIxDc2YQuhUAyAbwsZ0Hoe2+EEk7avaHD+pgx9H5fKT/HxDU4TP0/7LTsV5su/WIX4/auG5E7ZyBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760667478; c=relaxed/simple;
	bh=/Un8LzctEQSHO9DJEZfkZItIz+oWX/DCtNE4h4VMKzc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TBlogC2hSzLAxZyEvS+SnAz+CzebM2MKL/Q1Yhr2W85+cpfCVSBRmDPPfCow4PcZbl1bgoltpetBzAk38D5h18szuCU+XZedz2BjNYoWwmXUdiG50S7042PUGusX20aeVkYMiOINfEyBtlriWBa2aq1qzr6AOW3Iy7djIouSvfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZsaEeUSv; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760667476; x=1792203476;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/Un8LzctEQSHO9DJEZfkZItIz+oWX/DCtNE4h4VMKzc=;
  b=ZsaEeUSvAyBA89cLlf68TvDeuK3swMR4GqBTIMWEIlILIFksXsqroFqj
   HxtMjYdDHDOfAsEdVDtnLm5/xAKmNaO/6B/gwKm8NLg4t+jveHZjVt8Hy
   uaSsJZj54wCISHdtvfnJEUbtwhtTzwaa/yIPMIPSQpdXF/s44R2h7LOIT
   FxoUXta7gjwFBcpIn/QotxmJkZiPVJd2GAIoEezG3hAfsy5W/OxXNdxs1
   of2cCYEhDnjLNrJYCq1qwnlEpvijlyt6GXiSyC+Z0iHqHcoQnB0Cx+CSD
   AK9cDpkkfVUMN1sz5KRwTixGSPYFUmULh2QyCu2hCPOp6hgeQCwk3AP/C
   A==;
X-CSE-ConnectionGUID: PnOE5TvVTWS4dVdWRd+dWA==
X-CSE-MsgGUID: /IWtrkrbSiSfWpcm/UjJ0A==
X-IronPort-AV: E=McAfee;i="6800,10657,11584"; a="63020180"
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; 
   d="scan'208";a="63020180"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2025 19:17:56 -0700
X-CSE-ConnectionGUID: POrmFGVhRTOOw0UCY3eV/g==
X-CSE-MsgGUID: B05CBBuHS1uXaiyX4dUmtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; 
   d="scan'208";a="182549461"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa006.fm.intel.com with ESMTP; 16 Oct 2025 19:17:53 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v9a2Q-0005Rv-2a;
	Fri, 17 Oct 2025 02:17:50 +0000
Date: Fri, 17 Oct 2025 10:17:37 +0800
From: kernel test robot <lkp@intel.com>
To: Marcos Paulo de Souza <mpdesouza@suse.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jason Wessel <jason.wessel@windriver.com>,
	Daniel Thompson <danielt@kernel.org>,
	Douglas Anderson <dianders@chromium.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net,
	Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: Re: [PATCH v6 5/5] kdb: Adapt kdb_msg_write to work with NBCON
 consoles
Message-ID: <202510171023.YREXxhMK-lkp@intel.com>
References: <20251016-nbcon-kgdboc-v6-5-866aac60a80e@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251016-nbcon-kgdboc-v6-5-866aac60a80e@suse.com>

Hi Marcos,

kernel test robot noticed the following build errors:

[auto build test ERROR on 3a8660878839faadb4f1a6dd72c3179c1df56787]

url:    https://github.com/intel-lab-lkp/linux/commits/Marcos-Paulo-de-Souza/printk-nbcon-Export-console_is_usable/20251016-225503
base:   3a8660878839faadb4f1a6dd72c3179c1df56787
patch link:    https://lore.kernel.org/r/20251016-nbcon-kgdboc-v6-5-866aac60a80e%40suse.com
patch subject: [PATCH v6 5/5] kdb: Adapt kdb_msg_write to work with NBCON consoles
config: i386-buildonly-randconfig-006-20251017 (https://download.01.org/0day-ci/archive/20251017/202510171023.YREXxhMK-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251017/202510171023.YREXxhMK-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510171023.YREXxhMK-lkp@intel.com/

All errors (new ones prefixed by >>):

>> kernel/debug/kdb/kdb_io.c:612:22: error: incompatible pointer types passing 'struct nbcon_write_context *' to parameter of type 'struct console *' [-Werror,-Wincompatible-pointer-types]
     612 |                         nbcon_kdb_release(&wctxt);
         |                                           ^~~~~~
   include/linux/console.h:667:54: note: passing argument to parameter 'con' here
     667 | static inline void nbcon_kdb_release(struct console *con) { }
         |                                                      ^
   1 error generated.


vim +612 kernel/debug/kdb/kdb_io.c

   560	
   561	static void kdb_msg_write(const char *msg, int msg_len)
   562	{
   563		struct console *c;
   564		const char *cp;
   565		int cookie;
   566		int len;
   567	
   568		if (msg_len == 0)
   569			return;
   570	
   571		cp = msg;
   572		len = msg_len;
   573	
   574		while (len--) {
   575			dbg_io_ops->write_char(*cp);
   576			cp++;
   577		}
   578	
   579		/*
   580		 * The console_srcu_read_lock() only provides safe console list
   581		 * traversal. The use of the ->write() callback relies on all other
   582		 * CPUs being stopped at the moment and console drivers being able to
   583		 * handle reentrance when @oops_in_progress is set.
   584		 *
   585		 * There is no guarantee that every console driver can handle
   586		 * reentrance in this way; the developer deploying the debugger
   587		 * is responsible for ensuring that the console drivers they
   588		 * have selected handle reentrance appropriately.
   589		 */
   590		cookie = console_srcu_read_lock();
   591		for_each_console_srcu(c) {
   592			short flags = console_srcu_read_flags(c);
   593	
   594			if (!console_is_usable(c, flags, true))
   595				continue;
   596			if (c == dbg_io_ops->cons)
   597				continue;
   598	
   599			if (flags & CON_NBCON) {
   600				struct nbcon_write_context wctxt = { };
   601	
   602				/*
   603				 * Do not continue if the console is NBCON and the context
   604				 * can't be acquired.
   605				 */
   606				if (!nbcon_kdb_try_acquire(c, &wctxt))
   607					continue;
   608	
   609				nbcon_write_context_set_buf(&wctxt, (char *)msg, msg_len);
   610	
   611				c->write_atomic(c, &wctxt);
 > 612				nbcon_kdb_release(&wctxt);
   613			} else {
   614				/*
   615				 * Set oops_in_progress to encourage the console drivers to
   616				 * disregard their internal spin locks: in the current calling
   617				 * context the risk of deadlock is a bigger problem than risks
   618				 * due to re-entering the console driver. We operate directly on
   619				 * oops_in_progress rather than using bust_spinlocks() because
   620				 * the calls bust_spinlocks() makes on exit are not appropriate
   621				 * for this calling context.
   622				 */
   623				++oops_in_progress;
   624				c->write(c, msg, msg_len);
   625				--oops_in_progress;
   626			}
   627			touch_nmi_watchdog();
   628		}
   629		console_srcu_read_unlock(cookie);
   630	}
   631	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

