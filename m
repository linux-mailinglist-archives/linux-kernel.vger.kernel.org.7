Return-Path: <linux-kernel+bounces-857144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2BA5BE607F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 03:26:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60B185E3600
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 01:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1DEB21FF3F;
	Fri, 17 Oct 2025 01:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b6yDQAsB"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD5F21C167
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 01:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760664387; cv=none; b=IOYDlI1EbPVtqvVIXJ0GEvBa1cyZx92leKClc457eFLb1f2g8hFdtG3v2fKVdWsz1mfomlZFysNsLnv4WiQCFzN8G7gcLt+nL9h8KQPMWsm5aH125aiYLmMkX3GWSCM+GcW34rqMdwPfmFCuufS56fDs2EtDd0rXXGbPSDLK57s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760664387; c=relaxed/simple;
	bh=8yqxrPMDUDIopjMpMaVfn56rVVvt//g54hut99p+kBE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UE+SpthaIOaugiRCHqNrWC4KF7S9mLjDpmQw7+ByZFiZkuYF5ZqARu3V18me4h1L8zf+8HJMSjKs03DlVuYSk1u+QloxLi/USjr9uJVHf3MPD+RLdyAeloY+ZsH60URzMo/4FhbMBpfbwlEecc6/SXWcF6RLgyAXYyj3ODDOswA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b6yDQAsB; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760664386; x=1792200386;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8yqxrPMDUDIopjMpMaVfn56rVVvt//g54hut99p+kBE=;
  b=b6yDQAsB5i6/Cz6bB2BRyaNKpKSg/Kc/4h38zVcuQeYTuTQD3+4GnSNl
   Jn3z4l3/ZcGQP4Fu1Z2L4iSt/Q4B18L4g9iXVmE+XWKWxS/FVThWVjzLx
   TMe9kuFGMrw3G9QLfvQKXsdTwDY3XQcxR1b78pcljb47J7k0eJkJYlWjU
   KMk5583SPM6risrdlYw2DJ21hjuRcQ+8fEYUR+2QOu+x9Ngr2exEC1OWe
   W/9yyCbpc4lNdVQoPL4dk9xRrf2nzxT5mCsoYAXYhXege26Qz4sKsSgtG
   ajm5sSO3dwGPTsE5XWbOqUErvDZQUuPlCo3FFxznq77D0shi+EnYHSTM3
   A==;
X-CSE-ConnectionGUID: 7Qk05NnzTDOOf2OnOftlSQ==
X-CSE-MsgGUID: 1WHSZjCNQoGnX0plUzYIXw==
X-IronPort-AV: E=McAfee;i="6800,10657,11584"; a="66517230"
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; 
   d="scan'208";a="66517230"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2025 18:26:25 -0700
X-CSE-ConnectionGUID: Team0iFbSKqfERnQjCcG/Q==
X-CSE-MsgGUID: 0W2mbKcvRo6bgWR+5Q+jtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; 
   d="scan'208";a="181742346"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa006.jf.intel.com with ESMTP; 16 Oct 2025 18:26:22 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v9ZEZ-0005P1-2Q;
	Fri, 17 Oct 2025 01:26:19 +0000
Date: Fri, 17 Oct 2025 09:25:53 +0800
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
Subject: Re: [PATCH v6 3/5] printk: nbcon: Allow KDB to acquire the NBCON
 context
Message-ID: <202510170949.NTx9lt0p-lkp@intel.com>
References: <20251016-nbcon-kgdboc-v6-3-866aac60a80e@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251016-nbcon-kgdboc-v6-3-866aac60a80e@suse.com>

Hi Marcos,

kernel test robot noticed the following build errors:

[auto build test ERROR on 3a8660878839faadb4f1a6dd72c3179c1df56787]

url:    https://github.com/intel-lab-lkp/linux/commits/Marcos-Paulo-de-Souza/printk-nbcon-Export-console_is_usable/20251016-225503
base:   3a8660878839faadb4f1a6dd72c3179c1df56787
patch link:    https://lore.kernel.org/r/20251016-nbcon-kgdboc-v6-3-866aac60a80e%40suse.com
patch subject: [PATCH v6 3/5] printk: nbcon: Allow KDB to acquire the NBCON context
config: openrisc-allnoconfig (https://download.01.org/0day-ci/archive/20251017/202510170949.NTx9lt0p-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251017/202510170949.NTx9lt0p-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510170949.NTx9lt0p-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from kernel/kallsyms.c:19:
   include/linux/kdb.h: In function 'kdb_printf_on_this_cpu':
>> include/linux/kdb.h:229:63: error: expected ';' before '}' token
     229 | static inline bool kdb_printf_on_this_cpu(void) { return false };
         |                                                               ^~
         |                                                               ;


vim +229 include/linux/kdb.h

   228	
 > 229	static inline bool kdb_printf_on_this_cpu(void) { return false };
   230	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

