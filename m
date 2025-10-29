Return-Path: <linux-kernel+bounces-876887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 843B6C1CADF
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 19:08:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA26856473B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 18:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EAFD2DC76C;
	Wed, 29 Oct 2025 18:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ia5gEJSP"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE8123FC4C
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 18:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761760847; cv=none; b=mPRJDP3/kc81S7QS3mMRy1aIn+AQoTB4lBLTY4UJfvaqQY3Os8cKjuCxQijlx2watDWj4UYtoWbgdkVguHfvi9hdp8/5rPtqts7/W7lQw3XNjD5RwVkpt035SP+lbjQ53ZQlUsoSalr/SZ8tjXxaMQd0wRPf9yjR3/oDBYgtz0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761760847; c=relaxed/simple;
	bh=9dF7Jpw1fF5OK0v2bxCUzoCBfmcOh8mwQMkWM8puRy8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XIwyV0zNpm44O+NbXRHb1BLHT4ZTrDKix4J/VwpwV/2NnWEyWRYNBZcVql8sjETsEu2RrdCoNC7UTl8CmkBDOYnJk9EneR9FVhmFq29GDWNGg0b3fRibVsbmi8ck80c9uaf5jzs05gyZ58Xs3YjrJ2Alp7PjAHh/C37qdUjPMHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ia5gEJSP; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761760845; x=1793296845;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=9dF7Jpw1fF5OK0v2bxCUzoCBfmcOh8mwQMkWM8puRy8=;
  b=Ia5gEJSPdQ3wW36jqWHIKO247lcSl9eveYPOiVG5xnvmVwWw+ryjC5tp
   OjzJufJ5Sl/Yte2KuccJx51B+Axh4ah/P06+7S/zqnJi0XBDJaKPXZ7FV
   Ix5PyA8GxQ0x7py6MVhH9qV2is7RRf29ynkzjFO34xyBomqDzZJexs5gJ
   kfvm7pVyaBiTOdh4nO70CsA0w5yvEY7SpKeZ4c1M2ImZvvkgSEatp+775
   3+wYyIoeXSpEPUQoVprEV121lgeLDahEAfR+7ZJkfJ68dPMJzlfcEunUb
   W3mzo8lTyTHeXblk7p/Y2EVza63loFRD+83Sj1zr3jzu8/ELcrhcdl079
   Q==;
X-CSE-ConnectionGUID: Ts/Abvv5QweohbcAeSP/+g==
X-CSE-MsgGUID: 3V2RD1YRQGmeZaSYxhvxOA==
X-IronPort-AV: E=McAfee;i="6800,10657,11597"; a="81312092"
X-IronPort-AV: E=Sophos;i="6.19,264,1754982000"; 
   d="scan'208";a="81312092"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 11:00:45 -0700
X-CSE-ConnectionGUID: TUrzPIYrTjWzLrVTPcc54Q==
X-CSE-MsgGUID: tMZ/1HgjTia/jLNYT5y7OQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,264,1754982000"; 
   d="scan'208";a="186078312"
Received: from unknown (HELO [10.241.243.18]) ([10.241.243.18])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 11:00:44 -0700
Message-ID: <1101760b77a5979ba8ad1de16b8fd310a990e7c9.camel@linux.intel.com>
Subject: Re: [PATCH v2] sched/fair: Skip sched_balance_running cmpxchg when
 balance is not due
From: Tim Chen <tim.c.chen@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>, Chen Yu <yu.c.chen@intel.com>, Doug
 Nelson	 <doug.nelson@intel.com>, Mohini Narkhede
 <mohini.narkhede@intel.com>, 	linux-kernel@vger.kernel.org, Vincent Guittot
 <vincent.guittot@linaro.org>,  Shrikanth Hegde <sshegde@linux.ibm.com>, K
 Prateek Nayak <kprateek.nayak@amd.com>
Date: Wed, 29 Oct 2025 11:00:43 -0700
In-Reply-To: <20251029084725.GC988547@noisy.programming.kicks-ass.net>
References: 
	<248b775fc9030989c829d4061f6f85ae33dabe45.1761682932.git.tim.c.chen@linux.intel.com>
	 <20251029084725.GC988547@noisy.programming.kicks-ass.net>
Autocrypt: addr=tim.c.chen@linux.intel.com; prefer-encrypt=mutual;
 keydata=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
 uQ==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-10-29 at 09:47 +0100, Peter Zijlstra wrote:
> On Tue, Oct 28, 2025 at 01:23:30PM -0700, Tim Chen wrote:
> > The NUMA sched domain sets the SD_SERIALIZE flag by default, allowing
> > only one NUMA load balancing operation to run system-wide at a time.
> >=20
> > Currently, each MC group leader in a NUMA domain attempts to acquire
> > the global sched_balance_running flag via cmpxchg() before checking
> > whether load balancing is due or whether it is the designated leader fo=
r
> > that NUMA domain. On systems with a large number of cores, this causes
> > significant cache contention on the shared sched_balance_running flag.
> >=20
> > This patch reduces unnecessary cmpxchg() operations by first checking
> > whether the balance interval has expired. If load balancing is not due,
> > the attempt to acquire sched_balance_running is skipped entirely.
> >=20
> > On a 2-socket Granite Rapids system with sub-NUMA clustering enabled,
> > running an OLTP workload, 7.8% of total CPU cycles were previously spen=
t
> > in sched_balance_domain() contending on sched_balance_running before
> > this change.
> >=20
> >          : 104              static __always_inline int arch_atomic_cmpx=
chg(atomic_t *v, int old, int new)
> >          : 105              {
> >          : 106              return arch_cmpxchg(&v->counter, old, new);
> >     0.00 :   ffffffff81326e6c:       xor    %eax,%eax
> >     0.00 :   ffffffff81326e6e:       mov    $0x1,%ecx
> >     0.00 :   ffffffff81326e73:       lock cmpxchg %ecx,0x2394195(%rip) =
       # ffffffff836bb010 <sched_balance_running>
> >          : 110              sched_balance_domains():
> >          : 12234            if (atomic_cmpxchg_acquire(&sched_balance_r=
unning, 0, 1))
> >    99.39 :   ffffffff81326e7b:       test   %eax,%eax
> >     0.00 :   ffffffff81326e7d:       jne    ffffffff81326e99 <sched_bal=
ance_domains+0x209>
> >          : 12238            if (time_after_eq(jiffies, sd->last_balance=
 + interval)) {
> >     0.00 :   ffffffff81326e7f:       mov    0x14e2b3a(%rip),%rax       =
 # ffffffff828099c0 <jiffies_64>
> >     0.00 :   ffffffff81326e86:       sub    0x48(%r14),%rax
> >     0.00 :   ffffffff81326e8a:       cmp    %rdx,%rax
> >=20
> > After applying this fix, sched_balance_domain() is gone from
> > the profile and there is a 8% throughput improvement.
> >=20
>=20
> this..
>=20
> > v2:
> > 1. Rearrange the patch to get rid of an indent level per Peter's
> >    suggestion.
> > 2. Updated the data from new run by OLTP team.
> >=20
> > link to v1: https://lore.kernel.org/lkml/e27d5dcb724fe46acc24ff44670bc4=
bb5be21d98.1759445926.git.tim.c.chen@linux.intel.com/
>=20
> ... stuff goes under the '---' sign.
>=20
> Also, what happened to my other suggestion:
>=20
>   https://lkml.kernel.org/r/20251014092436.GK4067720@noisy.programming.ki=
cks-ass.net
>=20
> ? That seemed like a better place to put things.

Yes, I agree it is better to lock sched_balance_running after should_we_bal=
ance().
That will keep all the CPUs that shouldn't do balancing from locking sched_=
balance_running, as Shrikanth
also pointed out. Let me put that version of the patch through some OLTP te=
sting
to validate it.

Tim

