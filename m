Return-Path: <linux-kernel+bounces-804159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4551B46AE5
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 13:05:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F4ED1C2196B
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 11:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 550E827AC35;
	Sat,  6 Sep 2025 11:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YzxO7G8j"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6858020F079
	for <linux-kernel@vger.kernel.org>; Sat,  6 Sep 2025 11:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757156732; cv=none; b=qZuWe0PKRqD0HU1SDWkxA53JPdtKo3c4ZDwSOLdcf4MgtX4r+f9Cpiac5w21oRyTh31eBIdgBBWSspvuRUvK/VTwe82gZWE7wXADYHWcdp/D7iLfSbL13a/zkxDLUb6qhx/ucJG0xsEBgruH5IYkW/wGZYP5+yJabbW7+3H3/Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757156732; c=relaxed/simple;
	bh=iC/IQbMtS3ZhK4Pb9e1I1ljSdAmStO2a+MVILIrYT8A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L7hCrJxgvUqTmsDvSvloJzqjf/2t73E4/vohQqQykL5frfB6sjadpwGA+3E5Te4qhUK7EEGBf5258yyMiWt+uisaLUBdIW7Qw0QIdVDd85WsrlMThDD7mrfAdd9BVI1CsojmnKTj9tRv4Ytbjy1Hjy7Oh6w6e0bcZ9ic5lwz45w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YzxO7G8j; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757156730; x=1788692730;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iC/IQbMtS3ZhK4Pb9e1I1ljSdAmStO2a+MVILIrYT8A=;
  b=YzxO7G8jNMntH58h4gPaY+4e+KACp9ughiOXiX1Yo+rbppItmGf5DBng
   YnTvtCNc5rF84qmhPMyBMMUTO3eP56NsJ0ptQAlFWO4Ig+k4JyeS54qBF
   o/NFpK4x6bSv0XxRYQyKrXjsnvfEIvxamPYCSW9GhAZszVyiAiTKCno0T
   Ht6afzTxC7UGEVoarA/qpQfYJmxRiOPvypCX9GU/c24M2vatgdorkuLJZ
   c/qwK4MeMyOhTomTn1vOOofVLJ4lwfy//3akyPueT/MABEWkDaBWhN/yw
   ynEGjPzwul6OBlRZ6stMy0KDs2/5zkWAwcCQOX/bwudjva3ZcwMkgTqrP
   g==;
X-CSE-ConnectionGUID: LeWmLuELQ3GCUI2sMORxag==
X-CSE-MsgGUID: ncCAL+dLR4id7pX8YqgTBg==
X-IronPort-AV: E=McAfee;i="6800,10657,11544"; a="84922459"
X-IronPort-AV: E=Sophos;i="6.18,244,1751266800"; 
   d="scan'208";a="84922459"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2025 04:05:29 -0700
X-CSE-ConnectionGUID: qf3FtedCS9WIb4YPd2xb+A==
X-CSE-MsgGUID: PlnIjXl7S12LfQNVauwp9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,244,1751266800"; 
   d="scan'208";a="176448240"
Received: from lkp-server01.sh.intel.com (HELO 114d98da2b6c) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 06 Sep 2025 04:05:27 -0700
Received: from kbuild by 114d98da2b6c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uuqjV-0001NP-1K;
	Sat, 06 Sep 2025 11:05:25 +0000
Date: Sat, 6 Sep 2025 19:04:59 +0800
From: kernel test robot <lkp@intel.com>
To: Alessio Attilio <alessio.attilio.dev@gmail.com>, gfs2@lists.linux.dev
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	aahringo@redhat.com, teigland@redhat.com,
	Alessio Attilio <alessio.attilio.dev@gmail.com>
Subject: Re: [PATCH] dlm: improve lock management and concurrency control
Message-ID: <202509061809.348XSVqi-lkp@intel.com>
References: <20250905160552.496879-1-alessio.attilio.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905160552.496879-1-alessio.attilio.dev@gmail.com>

Hi Alessio,

kernel test robot noticed the following build warnings:

[auto build test WARNING on teigland-dlm/next]
[also build test WARNING on linus/master v6.17-rc4 next-20250905]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Alessio-Attilio/dlm-improve-lock-management-and-concurrency-control/20250906-000819
base:   https://git.kernel.org/pub/scm/linux/kernel/git/teigland/linux-dlm.git next
patch link:    https://lore.kernel.org/r/20250905160552.496879-1-alessio.attilio.dev%40gmail.com
patch subject: [PATCH] dlm: improve lock management and concurrency control
config: sh-randconfig-r071-20250906 (https://download.01.org/0day-ci/archive/20250906/202509061809.348XSVqi-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 10.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250906/202509061809.348XSVqi-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509061809.348XSVqi-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> fs/dlm/lock.c:6153:24: warning: 'del_proc_lock' defined but not used [-Wunused-function]
    6153 | static struct dlm_lkb *del_proc_lock(struct dlm_ls *ls,
         |                        ^~~~~~~~~~~~~


vim +/del_proc_lock +6153 fs/dlm/lock.c

597d0cae0f99f6 David Teigland  2006-07-12  6148  
ef0c2bb05f40f9 David Teigland  2007-03-28  6149  /* We have to release clear_proc_locks mutex before calling unlock_proc_lock()
ef0c2bb05f40f9 David Teigland  2007-03-28  6150     (which does lock_rsb) due to deadlock with receiving a message that does
23e8e1aaacb10d David Teigland  2011-04-05  6151     lock_rsb followed by dlm_user_add_cb() */
ef0c2bb05f40f9 David Teigland  2007-03-28  6152  
ef0c2bb05f40f9 David Teigland  2007-03-28 @6153  static struct dlm_lkb *del_proc_lock(struct dlm_ls *ls,
ef0c2bb05f40f9 David Teigland  2007-03-28  6154  				     struct dlm_user_proc *proc)
ef0c2bb05f40f9 David Teigland  2007-03-28  6155  {
ef0c2bb05f40f9 David Teigland  2007-03-28  6156  	struct dlm_lkb *lkb = NULL;
ef0c2bb05f40f9 David Teigland  2007-03-28  6157  
578acf9a87a875 Alexander Aring 2024-04-02  6158  	spin_lock_bh(&ls->ls_clear_proc_locks);
ef0c2bb05f40f9 David Teigland  2007-03-28  6159  	if (list_empty(&proc->locks))
ef0c2bb05f40f9 David Teigland  2007-03-28  6160  		goto out;
ef0c2bb05f40f9 David Teigland  2007-03-28  6161  
ef0c2bb05f40f9 David Teigland  2007-03-28  6162  	lkb = list_entry(proc->locks.next, struct dlm_lkb, lkb_ownqueue);
ef0c2bb05f40f9 David Teigland  2007-03-28  6163  	list_del_init(&lkb->lkb_ownqueue);
ef0c2bb05f40f9 David Teigland  2007-03-28  6164  
ef0c2bb05f40f9 David Teigland  2007-03-28  6165  	if (lkb->lkb_exflags & DLM_LKF_PERSISTENT)
8a39dcd9c32dd3 Alexander Aring 2023-03-06  6166  		set_bit(DLM_DFL_ORPHAN_BIT, &lkb->lkb_dflags);
ef0c2bb05f40f9 David Teigland  2007-03-28  6167  	else
e1af8728f600f6 Alexander Aring 2023-03-06  6168  		set_bit(DLM_IFL_DEAD_BIT, &lkb->lkb_iflags);
ef0c2bb05f40f9 David Teigland  2007-03-28  6169   out:
578acf9a87a875 Alexander Aring 2024-04-02  6170  	spin_unlock_bh(&ls->ls_clear_proc_locks);
ef0c2bb05f40f9 David Teigland  2007-03-28  6171  	return lkb;
ef0c2bb05f40f9 David Teigland  2007-03-28  6172  }
ef0c2bb05f40f9 David Teigland  2007-03-28  6173  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

