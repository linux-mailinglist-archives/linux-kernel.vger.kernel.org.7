Return-Path: <linux-kernel+bounces-812329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA3FDB5365E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 16:53:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 904F23B04F9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 14:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF35C3431E2;
	Thu, 11 Sep 2025 14:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SEFj+iOD"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C793533EAED
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 14:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757602418; cv=none; b=T3p9oy1OZ+FLH1F7MUIgC8XgwXdc/5Yw0tBYeuzsp4ht28WDC5m8DGOKcsnhH32PTQUDankUH+HmRoP3GWCLwEJ18TTYqYWbeuaIBtHy87YQDG8R4q7FiO1t1+I+izIDyFvZvjsDFR0BsbIhpAVCCaiAmasdXVCfUIyHSDH371k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757602418; c=relaxed/simple;
	bh=1LuM3D5ANUA0j8puYdxNj4ZLt5FzLtMTMa0RmH9A2SE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ja3UjIpfp2VCJPCttFf07gHz1TQZXaMODLaHeQjknPwNwBIhpsffCmjoo1RyVKjqJyxMI7TM98A/PyXfGBBWA8usdozLYyiRyVQb/9v6LcGBEFVVoODs1V7Wgn/+5jQPFmHSZMkRhPEZXfvcMuTzcs6EN5X00OfOfvinC7qI/hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SEFj+iOD; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757602417; x=1789138417;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1LuM3D5ANUA0j8puYdxNj4ZLt5FzLtMTMa0RmH9A2SE=;
  b=SEFj+iODHADr2PM8IcjCfQC8oYzbMkm0FCvs2mbTkJ8wsFa+yB2JBfSz
   fMrObm1zOLhcIzwxav0/szyI5u4Rc4K/fcr2cAd8FXp8mdP90cJ7kcmqc
   /S1YWDvUHAd8/9NVj/yyz/fD8BgG2Ml96mKHYGpqXzm7sqLAyJ3tGSzpp
   FbfKQVPiiRpEkQF9tiluTEeb1y3iYZu3hKcg30OT2OfUPYXUpR0rhrYEb
   iyFeqTmXN18NOSSBfKF29AtQM6490Ksa0GkfOZ4qa524KfDywLHWYL8+K
   pYSPepSp3kYW3PWBhGu4+pjYuvwW0MB04d/V3peF653A/wshCqZWbOogO
   Q==;
X-CSE-ConnectionGUID: 8tnqsmhuReqNhyBzTpv0tw==
X-CSE-MsgGUID: TIODAY+VScSFDCCAFa/rGQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11549"; a="77392842"
X-IronPort-AV: E=Sophos;i="6.18,257,1751266800"; 
   d="scan'208";a="77392842"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2025 07:53:34 -0700
X-CSE-ConnectionGUID: Osz4Vj5sQM2CxaeUJVgxcw==
X-CSE-MsgGUID: 0ziyHY8OTv6yuMkbHoivrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,257,1751266800"; 
   d="scan'208";a="173615826"
Received: from lkp-server02.sh.intel.com (HELO eb5fdfb2a9b7) ([10.239.97.151])
  by fmviesa006.fm.intel.com with ESMTP; 11 Sep 2025 07:53:29 -0700
Received: from kbuild by eb5fdfb2a9b7 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uwifr-0000OW-11;
	Thu, 11 Sep 2025 14:53:24 +0000
Date: Thu, 11 Sep 2025 22:52:39 +0800
From: kernel test robot <lkp@intel.com>
To: Alessio Attilio <alessio.attilio.dev@gmail.com>, aahringo@redhat.com
Cc: oe-kbuild-all@lists.linux.dev, teigland@redhat.com,
	gfs2@lists.linux.dev, linux-kernel@vger.kernel.org,
	Alessio Attilio <alessio.attilio@engineer.com>
Subject: Re: [PATCH] * dlm: improve lock management and concurrency control
Message-ID: <202509112200.zlSc9HkB-lkp@intel.com>
References: <20250910171706.173976-1-alessio.attilio.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910171706.173976-1-alessio.attilio.dev@gmail.com>

Hi Alessio,

kernel test robot noticed the following build warnings:

[auto build test WARNING on teigland-dlm/next]
[also build test WARNING on linus/master v6.17-rc5 next-20250911]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Alessio-Attilio/dlm-improve-lock-management-and-concurrency-control/20250911-012449
base:   https://git.kernel.org/pub/scm/linux/kernel/git/teigland/linux-dlm.git next
patch link:    https://lore.kernel.org/r/20250910171706.173976-1-alessio.attilio.dev%40gmail.com
patch subject: [PATCH] * dlm: improve lock management and concurrency control
config: sh-allyesconfig (https://download.01.org/0day-ci/archive/20250911/202509112200.zlSc9HkB-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250911/202509112200.zlSc9HkB-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509112200.zlSc9HkB-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/smp.h:12,
                    from include/linux/tracepoint.h:15,
                    from include/trace/events/dlm.h:11,
                    from fs/dlm/lock.c:56:
   fs/dlm/lock.c: In function 'clean_proc_locks':
   fs/dlm/lock.c:6181:39: error: 'safe' undeclared (first use in this function)
    6181 |         list_for_each_entry_safe(lkb, safe, &proc->unlocking, lkb_ownqueue) {
         |                                       ^~~~
   include/linux/list.h:858:17: note: in definition of macro 'list_for_each_entry_safe'
     858 |                 n = list_next_entry(pos, member);                       \
         |                 ^
   fs/dlm/lock.c:6181:39: note: each undeclared identifier is reported only once for each function it appears in
    6181 |         list_for_each_entry_safe(lkb, safe, &proc->unlocking, lkb_ownqueue) {
         |                                       ^~~~
   include/linux/list.h:858:17: note: in definition of macro 'list_for_each_entry_safe'
     858 |                 n = list_next_entry(pos, member);                       \
         |                 ^
   In file included from include/linux/container_of.h:5,
                    from include/linux/list.h:5:
   include/linux/compiler_types.h:507:27: error: expression in static assertion is not an integer
     507 | #define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
         |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:78:56: note: in definition of macro '__static_assert'
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^~~~
   include/linux/container_of.h:21:9: note: in expansion of macro 'static_assert'
      21 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~
   include/linux/container_of.h:21:23: note: in expansion of macro '__same_type'
      21 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |                       ^~~~~~~~~~~
   include/linux/list.h:601:9: note: in expansion of macro 'container_of'
     601 |         container_of(ptr, type, member)
         |         ^~~~~~~~~~~~
   include/linux/list.h:645:9: note: in expansion of macro 'list_entry'
     645 |         list_entry((pos)->member.next, typeof(*(pos)), member)
         |         ^~~~~~~~~~
   include/linux/list.h:860:27: note: in expansion of macro 'list_next_entry'
     860 |              pos = n, n = list_next_entry(n, member))
         |                           ^~~~~~~~~~~~~~~
   fs/dlm/lock.c:6181:9: note: in expansion of macro 'list_for_each_entry_safe'
    6181 |         list_for_each_entry_safe(lkb, safe, &proc->unlocking, lkb_ownqueue) {
         |         ^~~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/list.h:860:21: warning: left-hand operand of comma expression has no effect [-Wunused-value]
     860 |              pos = n, n = list_next_entry(n, member))
         |                     ^
   fs/dlm/lock.c:6181:9: note: in expansion of macro 'list_for_each_entry_safe'
    6181 |         list_for_each_entry_safe(lkb, safe, &proc->unlocking, lkb_ownqueue) {
         |         ^~~~~~~~~~~~~~~~~~~~~~~~
   fs/dlm/lock.c:6189:34: error: 'cb' undeclared (first use in this function); did you mean 'mb'?
    6189 |         list_for_each_entry_safe(cb, cb_safe, &proc->asts, list) {
         |                                  ^~
   include/linux/list.h:857:14: note: in definition of macro 'list_for_each_entry_safe'
     857 |         for (pos = list_first_entry(head, typeof(*pos), member),        \
         |              ^~~
   include/linux/compiler_types.h:507:27: error: expression in static assertion is not an integer
     507 | #define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
         |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:78:56: note: in definition of macro '__static_assert'
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^~~~
   include/linux/container_of.h:21:9: note: in expansion of macro 'static_assert'
      21 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~
   include/linux/container_of.h:21:23: note: in expansion of macro '__same_type'
      21 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |                       ^~~~~~~~~~~
   include/linux/list.h:601:9: note: in expansion of macro 'container_of'
     601 |         container_of(ptr, type, member)
         |         ^~~~~~~~~~~~
   include/linux/list.h:612:9: note: in expansion of macro 'list_entry'
     612 |         list_entry((ptr)->next, type, member)
         |         ^~~~~~~~~~
   include/linux/list.h:857:20: note: in expansion of macro 'list_first_entry'
     857 |         for (pos = list_first_entry(head, typeof(*pos), member),        \
         |                    ^~~~~~~~~~~~~~~~
   fs/dlm/lock.c:6189:9: note: in expansion of macro 'list_for_each_entry_safe'
    6189 |         list_for_each_entry_safe(cb, cb_safe, &proc->asts, list) {
         |         ^~~~~~~~~~~~~~~~~~~~~~~~
   fs/dlm/lock.c:6189:38: error: 'cb_safe' undeclared (first use in this function)
    6189 |         list_for_each_entry_safe(cb, cb_safe, &proc->asts, list) {
         |                                      ^~~~~~~
   include/linux/list.h:858:17: note: in definition of macro 'list_for_each_entry_safe'
     858 |                 n = list_next_entry(pos, member);                       \
         |                 ^
   include/linux/compiler_types.h:507:27: error: expression in static assertion is not an integer
     507 | #define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
         |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:78:56: note: in definition of macro '__static_assert'
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^~~~
   include/linux/container_of.h:21:9: note: in expansion of macro 'static_assert'
      21 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~
   include/linux/container_of.h:21:23: note: in expansion of macro '__same_type'
      21 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |                       ^~~~~~~~~~~
   include/linux/list.h:601:9: note: in expansion of macro 'container_of'
     601 |         container_of(ptr, type, member)
         |         ^~~~~~~~~~~~
   include/linux/list.h:645:9: note: in expansion of macro 'list_entry'
     645 |         list_entry((pos)->member.next, typeof(*(pos)), member)
         |         ^~~~~~~~~~
   include/linux/list.h:858:21: note: in expansion of macro 'list_next_entry'
     858 |                 n = list_next_entry(pos, member);                       \
         |                     ^~~~~~~~~~~~~~~
   fs/dlm/lock.c:6189:9: note: in expansion of macro 'list_for_each_entry_safe'
    6189 |         list_for_each_entry_safe(cb, cb_safe, &proc->asts, list) {
         |         ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/list.h:857:64: warning: left-hand operand of comma expression has no effect [-Wunused-value]
     857 |         for (pos = list_first_entry(head, typeof(*pos), member),        \
         |                                                                ^
   fs/dlm/lock.c:6189:9: note: in expansion of macro 'list_for_each_entry_safe'
    6189 |         list_for_each_entry_safe(cb, cb_safe, &proc->asts, list) {
         |         ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:507:27: error: expression in static assertion is not an integer
     507 | #define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
         |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:78:56: note: in definition of macro '__static_assert'
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^~~~
   include/linux/container_of.h:21:9: note: in expansion of macro 'static_assert'
      21 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~
   include/linux/container_of.h:21:23: note: in expansion of macro '__same_type'
      21 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |                       ^~~~~~~~~~~
   include/linux/list.h:601:9: note: in expansion of macro 'container_of'
     601 |         container_of(ptr, type, member)
         |         ^~~~~~~~~~~~
   include/linux/list.h:645:9: note: in expansion of macro 'list_entry'
     645 |         list_entry((pos)->member.next, typeof(*(pos)), member)
         |         ^~~~~~~~~~
   include/linux/list.h:860:27: note: in expansion of macro 'list_next_entry'
     860 |              pos = n, n = list_next_entry(n, member))
         |                           ^~~~~~~~~~~~~~~
   fs/dlm/lock.c:6189:9: note: in expansion of macro 'list_for_each_entry_safe'
    6189 |         list_for_each_entry_safe(cb, cb_safe, &proc->asts, list) {
         |         ^~~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/list.h:860:21: warning: left-hand operand of comma expression has no effect [-Wunused-value]
     860 |              pos = n, n = list_next_entry(n, member))
         |                     ^
   fs/dlm/lock.c:6189:9: note: in expansion of macro 'list_for_each_entry_safe'
    6189 |         list_for_each_entry_safe(cb, cb_safe, &proc->asts, list) {
         |         ^~~~~~~~~~~~~~~~~~~~~~~~
   fs/dlm/lock.c: At top level:
>> fs/dlm/lock.c:6149:13: warning: 'clean_proc_locks' defined but not used [-Wunused-function]
    6149 | static void clean_proc_locks(struct dlm_ls *ls, struct dlm_user_proc *proc)
         |             ^~~~~~~~~~~~~~~~


vim +/clean_proc_locks +6149 fs/dlm/lock.c

  6148	
> 6149	static void clean_proc_locks(struct dlm_ls *ls, struct dlm_user_proc *proc)
  6150	{
  6151		struct dlm_lkb *lkb;
  6152	
  6153		dlm_lock_recovery(ls);
  6154	
  6155		while (1) {
  6156			lkb = NULL;
  6157			spin_lock_bh(&proc->locks_spin);
  6158			if (!list_empty(&proc->locks)) {
  6159				lkb = list_entry(proc->locks.next, struct dlm_lkb,
  6160						 lkb_ownqueue);
  6161				list_del_init(&lkb->lkb_ownqueue);
  6162			}
  6163			spin_unlock_bh(&proc->locks_spin);
  6164	
  6165			if (!lkb)
  6166				break;
  6167	
  6168			if (lkb->lkb_exflags & DLM_LKF_PERSISTENT) {
  6169				set_bit(DLM_DFL_ORPHAN_BIT, &lkb->lkb_dflags);
  6170				orphan_proc_lock(ls, lkb);
  6171			} else {
  6172				set_bit(DLM_IFL_DEAD_BIT, &lkb->lkb_iflags);
  6173				unlock_proc_lock(ls, lkb);
  6174			}
  6175	
  6176			dlm_put_lkb(lkb);
  6177		}
  6178	
  6179		spin_lock_bh(&proc->locks_spin);
  6180		/* in-progress unlocks */
  6181		list_for_each_entry_safe(lkb, safe, &proc->unlocking, lkb_ownqueue) {
  6182			list_del_init(&lkb->lkb_ownqueue);
  6183			set_bit(DLM_IFL_DEAD_BIT, &lkb->lkb_iflags);
  6184			dlm_put_lkb(lkb);
  6185		}
  6186		spin_unlock_bh(&proc->locks_spin);
  6187	
  6188		spin_lock_bh(&proc->asts_spin);
  6189		list_for_each_entry_safe(cb, cb_safe, &proc->asts, list) {
  6190			list_del(&cb->list);
  6191			dlm_free_cb(cb);
  6192		}
  6193		spin_unlock_bh(&proc->asts_spin);
  6194	
  6195		dlm_unlock_recovery(ls);
  6196	}
  6197	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

