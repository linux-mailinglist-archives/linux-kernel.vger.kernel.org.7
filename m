Return-Path: <linux-kernel+bounces-798271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16B61B41B83
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 12:16:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD6C94814D0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 10:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BC9F2D543B;
	Wed,  3 Sep 2025 10:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="NRJqWy2O";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="MmOqhnZD";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Pd2RLM2f";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="JThfl9co"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0F2275B18
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 10:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756894610; cv=none; b=H0wxG9bf7qiKKnM4uH0zwepHQe4uMlO+KOF9URl6ImVqJMbGk6UmOOsEqhLejcpek/xJrKSvout29llbdXKS6bH8UfV83q8RB7XPv1evw2THYIAV36njWkOX/cszgHkFiHVnuHgOjMulxNBPJAEjY9ozq/mPOWKHHeSgzL6yb5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756894610; c=relaxed/simple;
	bh=zLXhfxHw72IXV1MwMaAM5D0WYGNWMsEp3g9O95xC2YY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DCVn8BJXqdrynoMY9Hhzf+9P/uw71Jjr+EiSjFezMt43Wl2J9WoyDyzYx/6NZpUdKIZbB5yutZVQtmDmmdruutAeVLC/IceMW2wamaa3A9bpnwlg++EEgchKmQlFOPBCvXUC/gHUGJ310WrRmFSEQVEKuKTrTyWUlExSr7lrnsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=NRJqWy2O; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=MmOqhnZD; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Pd2RLM2f; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=JThfl9co; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D433A1F456;
	Wed,  3 Sep 2025 10:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756894606; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Rvbu/jM3MWKUIPJPhYZELsI7iy4dSk0i6DfRhasd5mw=;
	b=NRJqWy2OAzMVfAvO/FglkVKF6nj1+/m4L8ngdXC3kGDFYNgHxZ54yHpg41iLhYS3enQsi8
	phAxgf7pIZdrbYpOY6cheeAnaCKy/fpitFAPDicU6EqNEJ9flKl6V+2w9tOAEi6lLYlIE4
	yRlIoOFNUE6/w8EHA/80oJZakxYu7Sc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756894606;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Rvbu/jM3MWKUIPJPhYZELsI7iy4dSk0i6DfRhasd5mw=;
	b=MmOqhnZDsS+Dw1rQ0m2lOxYacrLtwq4UZS/57btWB6jyBmSfpVLwAPHcrRrPlaYJ36hj/r
	St5IdAZ9Z+K/E0Cw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Pd2RLM2f;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=JThfl9co
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756894605; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Rvbu/jM3MWKUIPJPhYZELsI7iy4dSk0i6DfRhasd5mw=;
	b=Pd2RLM2fN9EOFy5KvDBDYtDC4HMdjXX2cfVMv6bs9bQl+hI2z94sCqYlj1mSe8HqdIwgAT
	Xxq0C5blRDVbygHaFsiOBmo9KNn/FGZDCHhrdFmFGbW5j7eXsexrtqoK8s/2cRtHQw2hyP
	Ib+iEk+9ch44eVULObDy6Lqr3qyNegM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756894605;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Rvbu/jM3MWKUIPJPhYZELsI7iy4dSk0i6DfRhasd5mw=;
	b=JThfl9cowFhidj+RhH2CYaaqUA2m0CO2ExgZKUbiIK/sb7b7pcy0spTHxmZsEWuNZb0i4P
	OWSnJ+8mtweMVxDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AC1D713A31;
	Wed,  3 Sep 2025 10:16:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id X7UJKY0VuGiIAgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 03 Sep 2025 10:16:45 +0000
Message-ID: <c41c82f0-e5c3-4c2e-b711-3ddf8fcb0135@suse.cz>
Date: Wed, 3 Sep 2025 12:16:45 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] mm/show_mem: Add trylock while printing alloc info
Content-Language: en-US
To: kernel test robot <lkp@intel.com>, Yueyang Pan <pyyjason@gmail.com>,
 Suren Baghdasaryan <surenb@google.com>,
 Andrew Morton <akpm@linux-foundation.org>, Michal Hocko <mhocko@suse.com>,
 Brendan Jackman <jackmanb@google.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Zi Yan <ziy@nvidia.com>, Vishal Moola <vishal.moola@gmail.com>,
 Shakeel Butt <shakeel.butt@linux.dev>, Usama Arif <usamaarif642@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev,
 Linux Memory Management List <linux-mm@kvack.org>, kernel-team@meta.com,
 linux-kernel@vger.kernel.org
References: <1491df0ac12a7626b7c9b00e26a6e10adb8c9045.1756827906.git.pyyjason@gmail.com>
 <202509031744.HcibSETe-lkp@intel.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 m6M14QORSWTLRg==
In-Reply-To: <202509031744.HcibSETe-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: D433A1F456
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TAGGED_RCPT(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[intel.com,gmail.com,google.com,linux-foundation.org,suse.com,cmpxchg.org,nvidia.com,linux.dev];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,suse.cz:dkim,suse.cz:mid];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Score: -3.01

On 9/3/25 11:47, kernel test robot wrote:
> Hi Yueyang,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on akpm-mm/mm-everything]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Yueyang-Pan/mm-show_mem-Dump-the-status-of-the-mem-alloc-profiling-before-printing/20250903-000616
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
> patch link:    https://lore.kernel.org/r/1491df0ac12a7626b7c9b00e26a6e10adb8c9045.1756827906.git.pyyjason%40gmail.com
> patch subject: [PATCH v2 2/2] mm/show_mem: Add trylock while printing alloc info
> config: i386-buildonly-randconfig-001-20250903 (https://download.01.org/0day-ci/archive/20250903/202509031744.HcibSETe-lkp@intel.com/config)
> compiler: gcc-13 (Debian 13.3.0-16) 13.3.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250903/202509031744.HcibSETe-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202509031744.HcibSETe-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>    In file included from mm/show_mem.c:18:
>    mm/show_mem.c: In function 'show_free_areas':
>    mm/show_mem.c:336:49: error: 'NR_ZSPAGES' undeclared (first use in this function); did you mean 'NR_STATS'?
>      336 |                         K(zone_page_state(zone, NR_ZSPAGES)),
>          |                                                 ^~~~~~~~~~

This is from a different patch and being fixed. Interesting that lkp will
report additional warnings even in presence of prior errors.

>    mm/internal.h:560:16: note: in definition of macro 'K'
>      560 | #define K(x) ((x) << (PAGE_SHIFT-10))
>          |                ^
>    include/linux/printk.h:512:26: note: in expansion of macro 'printk_index_wrap'
>      512 | #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
>          |                          ^~~~~~~~~~~~~~~~~
>    mm/show_mem.c:298:17: note: in expansion of macro 'printk'
>      298 |                 printk(KERN_CONT
>          |                 ^~~~~~
>    mm/show_mem.c:336:49: note: each undeclared identifier is reported only once for each function it appears in
>      336 |                         K(zone_page_state(zone, NR_ZSPAGES)),
>          |                                                 ^~~~~~~~~~
>    mm/internal.h:560:16: note: in definition of macro 'K'
>      560 | #define K(x) ((x) << (PAGE_SHIFT-10))
>          |                ^
>    include/linux/printk.h:512:26: note: in expansion of macro 'printk_index_wrap'
>      512 | #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
>          |                          ^~~~~~~~~~~~~~~~~
>    mm/show_mem.c:298:17: note: in expansion of macro 'printk'
>      298 |                 printk(KERN_CONT
>          |                 ^~~~~~
>    In file included from include/linux/spinlock.h:89,
>                     from include/linux/wait.h:9,
>                     from include/linux/wait_bit.h:8,
>                     from include/linux/fs.h:7,
>                     from include/linux/highmem.h:5,
>                     from include/linux/bvec.h:10,
>                     from include/linux/blk_types.h:10,
>                     from include/linux/blkdev.h:9,
>                     from mm/show_mem.c:8:
>    mm/show_mem.c: In function '__show_mem':
>>> mm/show_mem.c:399:32: warning: unused variable 'mem_alloc_profiling_spinlock' [-Wunused-variable]
>      399 |         static DEFINE_SPINLOCK(mem_alloc_profiling_spinlock);

This is the warning

I think you can simply move the definition to the existing #ifdef
CONFIG_MEM_ALLOC_PROFILING block above the spin_trylock(). The kernel now
uses a new enough C standard to allow this and not only at the beginning of
a cuntion. While not encouraged to do that in general, this seems to be a
valid use case.


>          |                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/spinlock_types.h:43:44: note: in definition of macro 'DEFINE_SPINLOCK'
>       43 | #define DEFINE_SPINLOCK(x)      spinlock_t x = __SPIN_LOCK_UNLOCKED(x)
>          |                                            ^
> 
> 
> vim +/mem_alloc_profiling_spinlock +399 mm/show_mem.c
> 
>    396	
>    397	void __show_mem(unsigned int filter, nodemask_t *nodemask, int max_zone_idx)
>    398	{
>  > 399		static DEFINE_SPINLOCK(mem_alloc_profiling_spinlock);
> 


