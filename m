Return-Path: <linux-kernel+bounces-819190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CDC7B59CAC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 17:57:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BEEE1B21112
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 15:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C9BA371E9E;
	Tue, 16 Sep 2025 15:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H840wvs0"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE85371E8F;
	Tue, 16 Sep 2025 15:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758038189; cv=none; b=q1P/eupp8mjN1XqJE0zjGoGPiAwdQ5diteK8+MnY43S+OrX++9NmQQkrVM4C52WZ9IoAEMG/ErwBIQ+FDxh0JJtVg0soeaw4k1IlmXv2Cw2xjLPBj5/AqU994ACM8xqUWbBHu7bCzGSoNq/rgfetJhVSw8xHkENMChBF1xxFRwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758038189; c=relaxed/simple;
	bh=FkI9Tbml2q8AETxR1CPQZdgvVSUFpF2rgdlI2Oo5IcM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tU6AZhnSg81HplOZhZFFpw1xmQohcYor78D6sPJATUgAjcXDjl2T5Ytl3r0inBHaKpT4b1+eywGg5/R1sBguVaZg81joaJM6Z2CgJi3L+7mt761igtP6dAjZq9cvBIUTFlXpkrmlVypcryPgomr6fcTGlEtNyjvKD5l98DFXUWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H840wvs0; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758038184; x=1789574184;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FkI9Tbml2q8AETxR1CPQZdgvVSUFpF2rgdlI2Oo5IcM=;
  b=H840wvs0hgj3j77qmV98yPSfsb5wIg1k9az1ik7fp8ev/Xu+wXko+EY/
   ZnNwc3AGj9FZkTT+KGe1KeAFPa57ZzAPIMG+fTBDfXbpfXekEVsjlM/Q/
   TNHHJtwFJqnyfd9FIoNPUSLntScHJNR8JYTUcb2bd6krMO31j1Pj7iJfg
   syGLvNy1cX+gBY/qxLXI/6uixhunmg5hu2mgd28/xL72iOs0uWRpKzi4o
   KDdbucRCWQo6KYQ8xJ5F+37n9r7jYE+X/xxyTQnyUJhkg0xk2/Ynk7/5s
   mlrkDRYbDR8C5B/hUzbPdSlyImmUbPLXApmjJF3XbtoutVPQbfFKF1b7h
   A==;
X-CSE-ConnectionGUID: FA9vjiMxRxuoNuKEr4lGtQ==
X-CSE-MsgGUID: +OVPFbwnT6WBJX23L03htA==
X-IronPort-AV: E=McAfee;i="6800,10657,11555"; a="60393775"
X-IronPort-AV: E=Sophos;i="6.18,269,1751266800"; 
   d="scan'208";a="60393775"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2025 08:56:23 -0700
X-CSE-ConnectionGUID: 9AvNrVEQR92yo/d6J1r/OQ==
X-CSE-MsgGUID: rcwVnKqRTNyvw6rm9RmTkw==
X-ExtLoop1: 1
Received: from lkp-server01.sh.intel.com (HELO 84a20bd60769) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 16 Sep 2025 08:56:19 -0700
Received: from kbuild by 84a20bd60769 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uyY2T-0000RD-0L;
	Tue, 16 Sep 2025 15:56:17 +0000
Date: Tue, 16 Sep 2025 23:55:39 +0800
From: kernel test robot <lkp@intel.com>
To: Drew Fustini <fustini@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev,
	Kornel =?utf-8?Q?Dul=C4=99ba?= <mindal@semihalf.com>,
	Adrien Ricciardi <aricciardi@baylibre.com>,
	James Morse <james.morse@arm.com>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Atish Patra <atish.patra@linux.dev>,
	Vasudevan Srinivasan <vasu@rivosinc.com>, guo.wenjia23@zte.com.cn,
	liu.qingtao2@zte.com.cn, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	Drew Fustini <fustini@kernel.org>
Subject: Re: [PATCH v2 3/3] RISC-V: Add support for srmcfg CSR from Ssqosid
 ext
Message-ID: <202509162355.wByessnb-lkp@intel.com>
References: <20250915-ssqosid-v6-17-rc5-v2-3-2d4b0254dfd6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915-ssqosid-v6-17-rc5-v2-3-2d4b0254dfd6@kernel.org>

Hi Drew,

kernel test robot noticed the following build errors:

[auto build test ERROR on 76eeb9b8de9880ca38696b2fb56ac45ac0a25c6c]

url:    https://github.com/intel-lab-lkp/linux/commits/Drew-Fustini/dt-bindings-riscv-Add-Ssqosid-extension-description/20250916-131818
base:   76eeb9b8de9880ca38696b2fb56ac45ac0a25c6c
patch link:    https://lore.kernel.org/r/20250915-ssqosid-v6-17-rc5-v2-3-2d4b0254dfd6%40kernel.org
patch subject: [PATCH v2 3/3] RISC-V: Add support for srmcfg CSR from Ssqosid ext
config: riscv-allnoconfig (https://download.01.org/0day-ci/archive/20250916/202509162355.wByessnb-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250916/202509162355.wByessnb-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509162355.wByessnb-lkp@intel.com/

All errors (new ones prefixed by >>):

   kernel/sched/core.c: In function 'context_switch':
>> kernel/sched/core.c:5357:35: error: macro '__switch_to_srmcfg' passed 1 arguments, but takes just 0
    5357 |         switch_to(prev, next, prev);
         |                                   ^
   In file included from arch/riscv/include/asm/switch_to.h:17,
                    from kernel/sched/core.c:80:
   arch/riscv/include/asm/qos.h:38:9: note: macro '__switch_to_srmcfg' defined here
      38 | #define __switch_to_srmcfg() do { } while (0)
         |         ^~~~~~~~~~~~~~~~~~
>> arch/riscv/include/asm/switch_to.h:124:17: error: '__switch_to_srmcfg' undeclared (first use in this function); did you mean '__switch_to_envcfg'?
     124 |                 __switch_to_srmcfg(__next);     \
         |                 ^~~~~~~~~~~~~~~~~~
   kernel/sched/core.c:5357:9: note: in expansion of macro 'switch_to'
    5357 |         switch_to(prev, next, prev);
         |         ^~~~~~~~~
   arch/riscv/include/asm/switch_to.h:124:17: note: each undeclared identifier is reported only once for each function it appears in
     124 |                 __switch_to_srmcfg(__next);     \
         |                 ^~~~~~~~~~~~~~~~~~
   kernel/sched/core.c:5357:9: note: in expansion of macro 'switch_to'
    5357 |         switch_to(prev, next, prev);
         |         ^~~~~~~~~


vim +/__switch_to_srmcfg +5357 kernel/sched/core.c

^1da177e4c3f41 kernel/sched.c      Linus Torvalds      2005-04-16  5296  
^1da177e4c3f41 kernel/sched.c      Linus Torvalds      2005-04-16  5297  /*
dfa50b605c2a93 kernel/sched/core.c Oleg Nesterov       2014-10-09  5298   * context_switch - switch to the new MM and the new thread's register state.
^1da177e4c3f41 kernel/sched.c      Linus Torvalds      2005-04-16  5299   */
049369487e2068 kernel/sched/core.c Josh Poimboeuf      2016-02-28  5300  static __always_inline struct rq *
70b97a7f0b19cf kernel/sched.c      Ingo Molnar         2006-07-03  5301  context_switch(struct rq *rq, struct task_struct *prev,
d8ac897137a230 kernel/sched/core.c Matt Fleming        2016-09-21  5302  	       struct task_struct *next, struct rq_flags *rf)
^1da177e4c3f41 kernel/sched.c      Linus Torvalds      2005-04-16  5303  {
e107be36efb2a2 kernel/sched.c      Avi Kivity          2007-07-26  5304  	prepare_task_switch(rq, prev, next);
fe4b04fa31a6dc kernel/sched.c      Peter Zijlstra      2011-02-02  5305  
9226d125d94c7e kernel/sched.c      Zachary Amsden      2007-02-13  5306  	/*
9226d125d94c7e kernel/sched.c      Zachary Amsden      2007-02-13  5307  	 * For paravirt, this is coupled with an exit in switch_to to
9226d125d94c7e kernel/sched.c      Zachary Amsden      2007-02-13  5308  	 * combine the page table reload and the switch backend into
9226d125d94c7e kernel/sched.c      Zachary Amsden      2007-02-13  5309  	 * one hypercall.
9226d125d94c7e kernel/sched.c      Zachary Amsden      2007-02-13  5310  	 */
224101ed69d3fb kernel/sched.c      Jeremy Fitzhardinge 2009-02-18  5311  	arch_start_context_switch(prev);
9226d125d94c7e kernel/sched.c      Zachary Amsden      2007-02-13  5312  
306e060435d7a3 kernel/sched/core.c Mathieu Desnoyers   2018-01-29  5313  	/*
139d025cda1da5 kernel/sched/core.c Peter Zijlstra      2019-07-29  5314  	 * kernel -> kernel   lazy + transfer active
aa464ba9a1e444 kernel/sched/core.c Nicholas Piggin     2023-02-03  5315  	 *   user -> kernel   lazy + mmgrab_lazy_tlb() active
139d025cda1da5 kernel/sched/core.c Peter Zijlstra      2019-07-29  5316  	 *
aa464ba9a1e444 kernel/sched/core.c Nicholas Piggin     2023-02-03  5317  	 * kernel ->   user   switch + mmdrop_lazy_tlb() active
139d025cda1da5 kernel/sched/core.c Peter Zijlstra      2019-07-29  5318  	 *   user ->   user   switch
223baf9d17f25e kernel/sched/core.c Mathieu Desnoyers   2023-04-20  5319  	 *
223baf9d17f25e kernel/sched/core.c Mathieu Desnoyers   2023-04-20  5320  	 * switch_mm_cid() needs to be updated if the barriers provided
223baf9d17f25e kernel/sched/core.c Mathieu Desnoyers   2023-04-20  5321  	 * by context_switch() are modified.
306e060435d7a3 kernel/sched/core.c Mathieu Desnoyers   2018-01-29  5322  	 */
139d025cda1da5 kernel/sched/core.c Peter Zijlstra      2019-07-29  5323  	if (!next->mm) {                                // to kernel
139d025cda1da5 kernel/sched/core.c Peter Zijlstra      2019-07-29  5324  		enter_lazy_tlb(prev->active_mm, next);
^1da177e4c3f41 kernel/sched.c      Linus Torvalds      2005-04-16  5325  
139d025cda1da5 kernel/sched/core.c Peter Zijlstra      2019-07-29  5326  		next->active_mm = prev->active_mm;
139d025cda1da5 kernel/sched/core.c Peter Zijlstra      2019-07-29  5327  		if (prev->mm)                           // from user
aa464ba9a1e444 kernel/sched/core.c Nicholas Piggin     2023-02-03  5328  			mmgrab_lazy_tlb(prev->active_mm);
139d025cda1da5 kernel/sched/core.c Peter Zijlstra      2019-07-29  5329  		else
139d025cda1da5 kernel/sched/core.c Peter Zijlstra      2019-07-29  5330  			prev->active_mm = NULL;
139d025cda1da5 kernel/sched/core.c Peter Zijlstra      2019-07-29  5331  	} else {                                        // to user
227a4aadc75ba2 kernel/sched/core.c Mathieu Desnoyers   2019-09-19  5332  		membarrier_switch_mm(rq, prev->active_mm, next->mm);
139d025cda1da5 kernel/sched/core.c Peter Zijlstra      2019-07-29  5333  		/*
139d025cda1da5 kernel/sched/core.c Peter Zijlstra      2019-07-29  5334  		 * sys_membarrier() requires an smp_mb() between setting
227a4aadc75ba2 kernel/sched/core.c Mathieu Desnoyers   2019-09-19  5335  		 * rq->curr / membarrier_switch_mm() and returning to userspace.
139d025cda1da5 kernel/sched/core.c Peter Zijlstra      2019-07-29  5336  		 *
139d025cda1da5 kernel/sched/core.c Peter Zijlstra      2019-07-29  5337  		 * The below provides this either through switch_mm(), or in
139d025cda1da5 kernel/sched/core.c Peter Zijlstra      2019-07-29  5338  		 * case 'prev->active_mm == next->mm' through
139d025cda1da5 kernel/sched/core.c Peter Zijlstra      2019-07-29  5339  		 * finish_task_switch()'s mmdrop().
306e060435d7a3 kernel/sched/core.c Mathieu Desnoyers   2018-01-29  5340  		 */
139d025cda1da5 kernel/sched/core.c Peter Zijlstra      2019-07-29  5341  		switch_mm_irqs_off(prev->active_mm, next->mm, next);
bd74fdaea14602 kernel/sched/core.c Yu Zhao             2022-09-18  5342  		lru_gen_use_mm(next->mm);
139d025cda1da5 kernel/sched/core.c Peter Zijlstra      2019-07-29  5343  
139d025cda1da5 kernel/sched/core.c Peter Zijlstra      2019-07-29  5344  		if (!prev->mm) {                        // from kernel
aa464ba9a1e444 kernel/sched/core.c Nicholas Piggin     2023-02-03  5345  			/* will mmdrop_lazy_tlb() in finish_task_switch(). */
139d025cda1da5 kernel/sched/core.c Peter Zijlstra      2019-07-29  5346  			rq->prev_mm = prev->active_mm;
^1da177e4c3f41 kernel/sched.c      Linus Torvalds      2005-04-16  5347  			prev->active_mm = NULL;
139d025cda1da5 kernel/sched/core.c Peter Zijlstra      2019-07-29  5348  		}
^1da177e4c3f41 kernel/sched.c      Linus Torvalds      2005-04-16  5349  	}
92509b732baf14 kernel/sched/core.c Matt Fleming        2016-09-21  5350  
223baf9d17f25e kernel/sched/core.c Mathieu Desnoyers   2023-04-20  5351  	/* switch_mm_cid() requires the memory barriers above. */
223baf9d17f25e kernel/sched/core.c Mathieu Desnoyers   2023-04-20  5352  	switch_mm_cid(rq, prev, next);
223baf9d17f25e kernel/sched/core.c Mathieu Desnoyers   2023-04-20  5353  
269d599271fa60 kernel/sched/core.c Peter Zijlstra      2018-02-06  5354  	prepare_lock_switch(rq, next, rf);
^1da177e4c3f41 kernel/sched.c      Linus Torvalds      2005-04-16  5355  
^1da177e4c3f41 kernel/sched.c      Linus Torvalds      2005-04-16  5356  	/* Here we just switch the register state and the stack. */
^1da177e4c3f41 kernel/sched.c      Linus Torvalds      2005-04-16 @5357  	switch_to(prev, next, prev);
dd41f596cda0d7 kernel/sched.c      Ingo Molnar         2007-07-09  5358  	barrier();
dfa50b605c2a93 kernel/sched/core.c Oleg Nesterov       2014-10-09  5359  
dfa50b605c2a93 kernel/sched/core.c Oleg Nesterov       2014-10-09  5360  	return finish_task_switch(prev);
^1da177e4c3f41 kernel/sched.c      Linus Torvalds      2005-04-16  5361  }
f711f6090a81cb kernel/sched.c      Gautham R Shenoy    2009-04-14  5362  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

