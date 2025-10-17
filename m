Return-Path: <linux-kernel+bounces-857480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D947BE6E9B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 09:20:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26FAD3A6FEA
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 07:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04552242D91;
	Fri, 17 Oct 2025 07:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WiNWr1Pf"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7EF0241695
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 07:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760685640; cv=none; b=M2n0/F8a0A/f/QqHRI2B8LwKYXTAL9ZUnELU2i3ru8Sxr5Sd33k+Rz5qJ7sDZHHRIvEg4R4SS0/ny4nHmJBuBfD+R6sNryOjx3VgVClgqTiaz5o+mV/L9I3BDHFO/7Ma9D1eog38D4syfS7BOkt4pP6POfASZsJG9DGm5o5COzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760685640; c=relaxed/simple;
	bh=+Q70WKO2l7or27Kg3QqpFB4NgM3dvZpGl7hkoR13fiI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oSPOdDnWPb7KAVXVHwcmGtyRtx9yYwP/pS7/LHmAbPOApwR70NMvw8tUxM7tIQLXj5hmUZMWyboCi0t1xfsvujeQh8y/vEEd7Bp+9CAjZkhyBGBQXJ9Hrf0DUwtQQxTWGs9+4Z+m8AKEQzLyaYswEzICy1OuBaC02Ms3krc6DHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WiNWr1Pf; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760685639; x=1792221639;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+Q70WKO2l7or27Kg3QqpFB4NgM3dvZpGl7hkoR13fiI=;
  b=WiNWr1Pf10RB+caoPaHfOgIZqNueg60vnFGYfBBqkIY0YfpEQnfWaB3D
   KHFLme4qNdDmuP2mVo9t9Amu4JzGtH/7kUixawgDFGdzxYOAcoEVv+yfc
   qPUTfoq3Zfv2PlVYyi1yulF0gUpU1nWw8Cd+XB1QBaRVEl2nOxfWMlJyG
   Zva21YsrEqZfvWTTmRU4NeHhNlFvgM/ZPgsxKZk+NBCDk7BhM8pxNyvGe
   I25/6Scycfsv8IpbqvhT9BunC07JhJ33y3X90k3ubl8sBfEX4SyQhZF7T
   OWs+VMspZcRwEPano9HqLYYhd2oYICr42ZM5QWr6TzjGFx5xjj3/i1H7m
   w==;
X-CSE-ConnectionGUID: l9gE5dH8TPKQEEbO38Tunw==
X-CSE-MsgGUID: QUgyQso7RjmEIIVlU+314A==
X-IronPort-AV: E=McAfee;i="6800,10657,11584"; a="66757541"
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; 
   d="scan'208";a="66757541"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2025 00:20:38 -0700
X-CSE-ConnectionGUID: WabAx5iESUmWJ2UVrKbjpw==
X-CSE-MsgGUID: 6XsIiTXiSiyeKVbjYiCj1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; 
   d="scan'208";a="187947824"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa004.fm.intel.com with ESMTP; 17 Oct 2025 00:20:34 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v9el4-0005g3-0l;
	Fri, 17 Oct 2025 07:20:14 +0000
Date: Fri, 17 Oct 2025 15:14:34 +0800
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
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	kgdb-bugreport@lists.sourceforge.net,
	Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: Re: [PATCH v6 5/5] kdb: Adapt kdb_msg_write to work with NBCON
 consoles
Message-ID: <202510171450.G2KdvDMm-lkp@intel.com>
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
config: sh-randconfig-002-20251017 (https://download.01.org/0day-ci/archive/20251017/202510171450.G2KdvDMm-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251017/202510171450.G2KdvDMm-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510171450.G2KdvDMm-lkp@intel.com/

All errors (new ones prefixed by >>):

   kernel/debug/kdb/kdb_io.c: In function 'kdb_msg_write':
>> kernel/debug/kdb/kdb_io.c:612:43: error: passing argument 1 of 'nbcon_kdb_release' from incompatible pointer type [-Wincompatible-pointer-types]
     612 |                         nbcon_kdb_release(&wctxt);
         |                                           ^~~~~~
         |                                           |
         |                                           struct nbcon_write_context *
   In file included from kernel/debug/kdb/kdb_io.c:17:
   include/linux/console.h:667:54: note: expected 'struct console *' but argument is of type 'struct nbcon_write_context *'
     667 | static inline void nbcon_kdb_release(struct console *con) { }
         |                                      ~~~~~~~~~~~~~~~~^~~

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for I2C_K1
   Depends on [n]: I2C [=y] && HAS_IOMEM [=y] && (ARCH_SPACEMIT || COMPILE_TEST [=y]) && OF [=n]
   Selected by [y]:
   - MFD_SPACEMIT_P1 [=y] && HAS_IOMEM [=y] && (ARCH_SPACEMIT || COMPILE_TEST [=y]) && I2C [=y]


vim +/nbcon_kdb_release +612 kernel/debug/kdb/kdb_io.c

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

