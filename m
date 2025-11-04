Return-Path: <linux-kernel+bounces-885571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DC68C33597
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 00:15:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2875718C22E1
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 23:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B9512DAFC2;
	Tue,  4 Nov 2025 23:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EFIAyBeO"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4135172605;
	Tue,  4 Nov 2025 23:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762298139; cv=none; b=szbLvaDcrSvHPmUAPAhO1a6qmkDxUv5kCUqsAMMpZ5esVkQOT3ZZ2TGY61ygWYddaFDokrQf/rsv6iGeYB1s1XDe0PtvL19xDLZ5oJ6axghPBexHPPESRy2nv0kiOXomq3dl4KSmR1kLbUlOMC8aiD3KjpCCvlV3YZNEBK+LJiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762298139; c=relaxed/simple;
	bh=5FzMxmsnnMI6iEWbGWYMjpuof9Q20uo2BdQ1iMH4P6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tWPIKZwAkyNTSlRpY6zcAwsoNGQ3N8TLvldQcnbpsfCYhWtZeYDpr8e8oG9J+OGiMUYG+yE+nJ1uxPFlHHnVGaabq9jmKWcAaQ7uDiHwXzgeqc/1OyTl1HQFTWUDD44wnIjlVl62joP9ecx25m6Nqlcsc791sFujB0ooMV4aEVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EFIAyBeO; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762298137; x=1793834137;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5FzMxmsnnMI6iEWbGWYMjpuof9Q20uo2BdQ1iMH4P6U=;
  b=EFIAyBeOrKxRAWH/QVK4kqWDIcAZkzErlf6jtjEvyo7Haa4Z1nbrOGTV
   nvVyT/UDDSoitKuFcSfzEhk3bQUzl357PImOAj8uPv8oZDJvtERaxSrLe
   HLfA+5QMJzAoOXQZUb6lmjheIsREJqHKdWlbLX3fk8nS7TQKu7U3t6BXD
   Gm7p/uI2u4i5oAwdqUZox/75xmWc6vThbf3rUsMzVrde60oM2PiIcDlXp
   8NawwMtvYKt6BBa1lJO8MjRknGK/nT9IaU8C0dcynsw4gYf7s+Rt4MX4d
   bFimhE89nOdAhMCjij9VXTRnNrBEQ+U6eGD6Z9wAwyBirAG1myOT4vPaT
   A==;
X-CSE-ConnectionGUID: A1MSccoVTjGg4HUnFO5lbw==
X-CSE-MsgGUID: AQqraXF5QWWhY2PLxIGRmw==
X-IronPort-AV: E=McAfee;i="6800,10657,11603"; a="63414893"
X-IronPort-AV: E=Sophos;i="6.19,280,1754982000"; 
   d="scan'208";a="63414893"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2025 15:15:36 -0800
X-CSE-ConnectionGUID: wjt6xLDaT+uGk/zSP4IGlw==
X-CSE-MsgGUID: PMp4CIS+S3mJaVfp3g4bRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,280,1754982000"; 
   d="scan'208";a="186963412"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa007.fm.intel.com with ESMTP; 04 Nov 2025 15:15:35 -0800
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vGQFR-000RvO-0F;
	Tue, 04 Nov 2025 23:15:33 +0000
Date: Wed, 5 Nov 2025 07:14:58 +0800
From: kernel test robot <lkp@intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-media@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/1] kernel-doc: Issue warnings that were silently
 discarded
Message-ID: <202511050706.NIxJwZER-lkp@intel.com>
References: <20251104215502.1049817-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251104215502.1049817-1-andriy.shevchenko@linux.intel.com>

Hi Andy,

kernel test robot noticed the following build warnings:

[auto build test WARNING on lwn/docs-next]
[also build test WARNING on next-20251104]
[cannot apply to linus/master v6.18-rc4]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Andy-Shevchenko/kernel-doc-Issue-warnings-that-were-silently-discarded/20251105-055629
base:   git://git.lwn.net/linux.git docs-next
patch link:    https://lore.kernel.org/r/20251104215502.1049817-1-andriy.shevchenko%40linux.intel.com
patch subject: [PATCH v1 1/1] kernel-doc: Issue warnings that were silently discarded
config: sh-allnoconfig (https://download.01.org/0day-ci/archive/20251105/202511050706.NIxJwZER-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251105/202511050706.NIxJwZER-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511050706.NIxJwZER-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: drivers/sh/intc/irqdomain.c:29 function parameter 'd' not described in 'intc_evt_xlate'
>> Warning: drivers/sh/intc/irqdomain.c:29 function parameter 'ctrlr' not described in 'intc_evt_xlate'
>> Warning: drivers/sh/intc/irqdomain.c:29 function parameter 'intspec' not described in 'intc_evt_xlate'
>> Warning: drivers/sh/intc/irqdomain.c:29 function parameter 'intsize' not described in 'intc_evt_xlate'
>> Warning: drivers/sh/intc/irqdomain.c:29 function parameter 'out_hwirq' not described in 'intc_evt_xlate'
>> Warning: drivers/sh/intc/irqdomain.c:29 function parameter 'out_type' not described in 'intc_evt_xlate'
>> Warning: drivers/sh/intc/irqdomain.c:29 expecting prototype for intc_irq_domain_evt_xlate(). Prototype was for intc_evt_xlate() instead

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

