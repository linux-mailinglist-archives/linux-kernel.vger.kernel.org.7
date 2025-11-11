Return-Path: <linux-kernel+bounces-895173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74607C4D27B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 11:48:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA5C33AE10F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 10:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27CC5350283;
	Tue, 11 Nov 2025 10:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mf/Jqbvg"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0013834F475
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 10:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762857748; cv=none; b=jFURC4TXSjKsQHhmdIR8BENnABIdMY/f9gFagbKcRl6Ql9LcU4h3R2gcWtbJZIDFE5R9KWDWwnc72FSaR+hjdcNgLpYw33qgnoXvFF+uvhn3C9+i9ieDucOImhjzaZx1G7Gw0SHYFEVBBAaTnjx+1tV+J8SoCex6iFNHZAhfug4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762857748; c=relaxed/simple;
	bh=tB8mAgojGV9nhPdqVPEff3EJbjDbspKUEJpWSxMHVu8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qlhVpM9UEOKog5jgqMBm9ezNnCNd2YeJEji3DdwLXG9yNKss8d+nt7AB+E6oS3VwHNBjKubX7aqVBYMy3VNPmioUntmrRqADb7A7pUamYmgfNt3h3elD24T0slvoh+VaRpf8yY6zUqLKTUZZFukWg/HRIHtnUn9bmIUAFz3iTcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mf/Jqbvg; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762857746; x=1794393746;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tB8mAgojGV9nhPdqVPEff3EJbjDbspKUEJpWSxMHVu8=;
  b=mf/JqbvgA9B6fCHJlUGvwWqw9J2qF+gi0DVQjrSibgBk5EyOd0l1NOOY
   tsKDT6ngAXzCA1X55fKIswsRFKuIe7xRzH5EJSO64G86TxPKlowGAXh/e
   r6LJFkwOOY46RgH5a56k62uzzApt9lbFv7CrxlvfdULDFkPPOzbpTKqk0
   DooyzLy06Q4e2j2GpstWWNL2t3eUVdfgRNvf4FDG23yqQkhiZo7hWmH3L
   399UJ90dPsuNyJC4/MA1k1PUbp4DLhr1bWoHV682Oft0JhWA6WnaX3dXM
   tNPLKe2tbe65aTp28Hc8No9aIyI5nA1DVsmDQ2s6ky4FnpSwkNAXZngdC
   A==;
X-CSE-ConnectionGUID: 7+D0eRVwR+2jwLAv0AC4xA==
X-CSE-MsgGUID: 4HA6c5BiT96T2PV1j+J32g==
X-IronPort-AV: E=McAfee;i="6800,10657,11609"; a="90388558"
X-IronPort-AV: E=Sophos;i="6.19,296,1754982000"; 
   d="scan'208";a="90388558"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2025 02:42:23 -0800
X-CSE-ConnectionGUID: RlIPGVlVQkekIwQceNRLOw==
X-CSE-MsgGUID: frrxrfjJTReeK7pqwYE7LA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,296,1754982000"; 
   d="scan'208";a="189195155"
Received: from lkp-server01.sh.intel.com (HELO 7b01c990427b) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 11 Nov 2025 02:42:20 -0800
Received: from kbuild by 7b01c990427b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vIlpJ-00033R-3B;
	Tue, 11 Nov 2025 10:42:17 +0000
Date: Tue, 11 Nov 2025 18:42:14 +0800
From: kernel test robot <lkp@intel.com>
To: Alejandro Colomar <alx@kernel.org>, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Alejandro Colomar <alx@kernel.org>,
	Marco Elver <elver@google.com>, Kees Cook <kees@kernel.org>,
	Christopher Bazley <chris.bazley.wg14@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Dmitry Vyukov <dvyukov@google.com>, Jann Horn <jannh@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Michal Hocko <mhocko@suse.com>, Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v1 2/3] mm: Fix benign off-by-one bugs
Message-ID: <202511111838.DEnuGlic-lkp@intel.com>
References: <87445e701574058b142e036c3b8a0f505086ab64.1758806023.git.alx@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87445e701574058b142e036c3b8a0f505086ab64.1758806023.git.alx@kernel.org>

Hi Alejandro,

kernel test robot noticed the following build warnings:

[auto build test WARNING on akpm-mm/mm-everything]
[also build test WARNING on kees/for-next/pstore kees/for-next/kspp linus/master linux/master v6.18-rc5 next-20251111]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Alejandro-Colomar/array_size-h-Add-ARRAY_END/20251110-075203
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/87445e701574058b142e036c3b8a0f505086ab64.1758806023.git.alx%40kernel.org
patch subject: [PATCH v1 2/3] mm: Fix benign off-by-one bugs
config: arm64-randconfig-002-20251111 (https://download.01.org/0day-ci/archive/20251111/202511111838.DEnuGlic-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251111/202511111838.DEnuGlic-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511111838.DEnuGlic-lkp@intel.com/

All warnings (new ones prefixed by >>):

   mm/kfence/kfence_test.c: In function 'report_matches':
   mm/kfence/kfence_test.c:113:15: error: implicit declaration of function 'ENDOF' [-Werror=implicit-function-declaration]
     113 |         end = ENDOF(expect[0]);
         |               ^~~~~
>> mm/kfence/kfence_test.c:113:13: warning: assignment to 'const char *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     113 |         end = ENDOF(expect[0]);
         |             ^
   mm/kfence/kfence_test.c:143:13: warning: assignment to 'const char *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     143 |         end = ENDOF(expect[1]);
         |             ^
   cc1: some warnings being treated as errors


vim +113 mm/kfence/kfence_test.c

    94	
    95	/* Check observed report matches information in @r. */
    96	static bool report_matches(const struct expect_report *r)
    97	{
    98		unsigned long addr = (unsigned long)r->addr;
    99		bool ret = false;
   100		unsigned long flags;
   101		typeof(observed.lines) expect;
   102		const char *end;
   103		char *cur;
   104	
   105		/* Doubled-checked locking. */
   106		if (!report_available())
   107			return false;
   108	
   109		/* Generate expected report contents. */
   110	
   111		/* Title */
   112		cur = expect[0];
 > 113		end = ENDOF(expect[0]);
   114		switch (r->type) {
   115		case KFENCE_ERROR_OOB:
   116			cur += scnprintf(cur, end - cur, "BUG: KFENCE: out-of-bounds %s",
   117					 get_access_type(r));
   118			break;
   119		case KFENCE_ERROR_UAF:
   120			cur += scnprintf(cur, end - cur, "BUG: KFENCE: use-after-free %s",
   121					 get_access_type(r));
   122			break;
   123		case KFENCE_ERROR_CORRUPTION:
   124			cur += scnprintf(cur, end - cur, "BUG: KFENCE: memory corruption");
   125			break;
   126		case KFENCE_ERROR_INVALID:
   127			cur += scnprintf(cur, end - cur, "BUG: KFENCE: invalid %s",
   128					 get_access_type(r));
   129			break;
   130		case KFENCE_ERROR_INVALID_FREE:
   131			cur += scnprintf(cur, end - cur, "BUG: KFENCE: invalid free");
   132			break;
   133		}
   134	
   135		scnprintf(cur, end - cur, " in %pS", r->fn);
   136		/* The exact offset won't match, remove it; also strip module name. */
   137		cur = strchr(expect[0], '+');
   138		if (cur)
   139			*cur = '\0';
   140	
   141		/* Access information */
   142		cur = expect[1];
   143		end = ENDOF(expect[1]);
   144	
   145		switch (r->type) {
   146		case KFENCE_ERROR_OOB:
   147			cur += scnprintf(cur, end - cur, "Out-of-bounds %s at", get_access_type(r));
   148			addr = arch_kfence_test_address(addr);
   149			break;
   150		case KFENCE_ERROR_UAF:
   151			cur += scnprintf(cur, end - cur, "Use-after-free %s at", get_access_type(r));
   152			addr = arch_kfence_test_address(addr);
   153			break;
   154		case KFENCE_ERROR_CORRUPTION:
   155			cur += scnprintf(cur, end - cur, "Corrupted memory at");
   156			break;
   157		case KFENCE_ERROR_INVALID:
   158			cur += scnprintf(cur, end - cur, "Invalid %s at", get_access_type(r));
   159			addr = arch_kfence_test_address(addr);
   160			break;
   161		case KFENCE_ERROR_INVALID_FREE:
   162			cur += scnprintf(cur, end - cur, "Invalid free of");
   163			break;
   164		}
   165	
   166		cur += scnprintf(cur, end - cur, " 0x%p", (void *)addr);
   167	
   168		spin_lock_irqsave(&observed.lock, flags);
   169		if (!report_available())
   170			goto out; /* A new report is being captured. */
   171	
   172		/* Finally match expected output to what we actually observed. */
   173		ret = strstr(observed.lines[0], expect[0]) && strstr(observed.lines[1], expect[1]);
   174	out:
   175		spin_unlock_irqrestore(&observed.lock, flags);
   176		return ret;
   177	}
   178	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

