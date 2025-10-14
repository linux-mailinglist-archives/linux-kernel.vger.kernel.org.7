Return-Path: <linux-kernel+bounces-853303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5AC0BDB2CF
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 22:13:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 560FC543716
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 20:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6255D305972;
	Tue, 14 Oct 2025 20:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SccSHmVh"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE1B1946BC
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 20:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760472790; cv=none; b=DQAMsY7TJlEBDgWNjFmEEzp+AEOXywEZ0Fn7X+77DUx5ihNDmve0uA3c8TBHX/hl9SiiBUAtuvAB/Huj8B/ySMG94YZqqGEvac1k5B/5yrCOekr1T6FZI03jEZjDyHUap3GXGVTNcDUkK7GRT457ZeOHS7zEywG34oCfa4fu/XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760472790; c=relaxed/simple;
	bh=IPfRDcBYAnO9EJDF78mPsfoRM00n2T2dN8iuGZsjO4Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rjCVkxyhmrJcN6iecM1sY3cSID/+6R1f7AcwxHiKxSl74wQvLyYypWM+YBmeUt+gZgMyQBcOsbxB/I425DY2wpL/yhmEn26Hyk9NulXl6m5H9+2y5dOgdxjuwa0MJKtvo+v1hDSwZ9R9P1RwxPUN7uwTYjylzUduCB6f3gDntJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SccSHmVh; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760472788; x=1792008788;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=IPfRDcBYAnO9EJDF78mPsfoRM00n2T2dN8iuGZsjO4Q=;
  b=SccSHmVhAvMeb3UlAI70tsRWKBCAGwIghQLpyHHVpvIugiStq56X9o8Q
   zS/hwW/ItPkojtAjt+DEK3BrMnyJPNH0NTpxwJzP2Z2QopmS6MvMk0nN/
   WLpFr+LUfLAYcr+6oV15d2Z8UVZlDZmdybBchWUAEMwrqeBl3nJbDmZ2T
   AKSeT1KDpUIXTn218kIZXPfQqETHEGXL2c1tti5kNWot0K/kJFZTOKb1F
   jTo0mcwrO5BcwmbyI55FP9JuDnpyWCMZxkPVBkOM+nKPZyyuBZwzo4+Ey
   aZ47mINoLwPAqJa5RfXnC2k+rqzjc+ye2V4rbzKNAW15tK9SJOqN2ElKl
   w==;
X-CSE-ConnectionGUID: 1nTRJbnfS4S+/p9kyZFrxw==
X-CSE-MsgGUID: FH5Sia7eTgOurSNEQc+Pnw==
X-IronPort-AV: E=McAfee;i="6800,10657,11582"; a="73744223"
X-IronPort-AV: E=Sophos;i="6.19,229,1754982000"; 
   d="scan'208";a="73744223"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2025 13:13:07 -0700
X-CSE-ConnectionGUID: mljxMxocTdqPIXhDKNMgEg==
X-CSE-MsgGUID: fKsvtoJeRZWIp1lcUNac7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,229,1754982000"; 
   d="scan'208";a="186227672"
Received: from unknown (HELO [10.241.242.248]) ([10.241.242.248])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2025 13:13:06 -0700
Message-ID: <8e1c24c3e0e4cd13935beb8c1cef4b24e642f22b.camel@linux.intel.com>
Subject: Re: =?UTF-8?Q?=E5=9B=9E=E5=A4=8D=EF=BC=9A=5BInternet=5DRe=3A?=
 =?UTF-8?Q?_=E5=9B=9E=E5=A4=8D=EF=BC=9A=5BPATCH?= 06/19] sched/fair: Assign
 preferred LLC ID to processes
From: Tim Chen <tim.c.chen@linux.intel.com>
To: =?UTF-8?Q?vernhao=28=E9=83=9D=E4=BF=A1=29?= <vernhao@tencent.com>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, K
 Prateek Nayak <kprateek.nayak@amd.com>,  "Gautham R . Shenoy"
 <gautham.shenoy@amd.com>, haoxing990@gmail.com
Cc: Vincent Guittot <vincent.guittot@linaro.org>, Juri Lelli	
 <juri.lelli@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel
 Gorman <mgorman@suse.de>,  Valentin Schneider	 <vschneid@redhat.com>,
 Madadi Vineeth Reddy <vineethr@linux.ibm.com>, Hillf Danton
 <hdanton@sina.com>, Shrikanth Hegde <sshegde@linux.ibm.com>, Jianyong Wu	
 <jianyong.wu@outlook.com>, Yangyu Chen <cyy@cyyself.name>, Tingyin Duan	
 <tingyin.duan@gmail.com>, Len Brown <len.brown@intel.com>, Aubrey Li	
 <aubrey.li@intel.com>, Zhao Liu <zhao1.liu@intel.com>, Chen Yu	
 <yu.chen.surf@gmail.com>, Chen Yu <yu.c.chen@intel.com>, Libo Chen	
 <libo.chen@oracle.com>, Adam Li <adamli@os.amperecomputing.com>, Tim Chen	
 <tim.c.chen@intel.com>, linux-kernel <linux-kernel@vger.kernel.org>
Date: Tue, 14 Oct 2025 13:13:07 -0700
In-Reply-To: <tencent_598967A906422C602EF51130@qq.com>
References: <tencent_598967A906422C602EF51130@qq.com>
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

On Tue, 2025-10-14 at 15:07 +0800, vernhao(=E9=83=9D=E4=BF=A1) wrote:
> Hi Tim,=C2=A0
>=20
> >=20
> >=20
[snip]

> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 61c129bde8b6..d6167a029c47 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -1312,6 +1312,7 @@ void account_mm_sched(struct rq *rq, struct task_=
struct *p, s64 delta_exec)
> > =C2=A0 struct mm_struct *mm =3D p->mm;
> > =C2=A0 struct mm_sched *pcpu_sched;
> > =C2=A0 unsigned long epoch;
> > + int mm_sched_llc =3D -1;
> > =C2=A0
> > =C2=A0 if (!sched_cache_enabled())
> > =C2=A0 return;
> > @@ -1342,6 +1343,12 @@ void account_mm_sched(struct rq *rq, struct task=
_struct *p, s64 delta_exec)
> > =C2=A0 if (mm->mm_sched_cpu !=3D -1)
> > =C2=A0 mm->mm_sched_cpu =3D -1;
> > =C2=A0 }
> > +
> > + if (mm->mm_sched_cpu !=3D -1)
> > + mm_sched_llc =3D per_cpu(sd_llc_id, mm->mm_sched_cpu);
> >=20
> > In high-concurrency multi-threaded scenarios, not all threads handle sa=
me events, so their hot data in the LLC is not completely shared.=C2=A0
> > Therefore, if every thread's preferred LLC is migrated to the LLC point=
ed to by mm->mm_sched_cpu, this would lead to the incorrect=C2=A0
> > assumption that all threads prefer the same LLC, thereby intensifying c=
ompetition between LLCs.
>=20
> Yes, that's the reason why we stop aggregating to the preferred LLC once =
the the utilization of the
> LLC becomes too high relative to the other LLCs.
>=20
> But this approach is only a compensatory measure after the fact. The thre=
ads have already undergone incorrect migration to they are not perferred LL=
C.=C2=A0
> Is there a better way to handle this situation?

The threads would stay where they were instead of migrating to preferred LL=
C
that's overloaded.

>=20
> If you know your threads characteristics before hand on which of them
> share data together, you probably can use cgroup/cpuset
> from user space to separate out the threads. =C2=A0
>=20
> Yes, this is a solution, and I am trying to implement it.
>=20
> There's not enough info from occupancy data for OS to group
> the threads by data sharing. Perhaps an alternative if NUMA balancing
> is on is to group tasks by their task numa group instead of by mm. =C2=A0
>=20
> This may not be a good solution either, especially for virtual machine sc=
enarios which has no NUMA.

If you are in a VM, the cache topology may not correspond to
real CPU cache topology and you probably should not enable cache
aware scheduling inside, unless you are doing some explicit
binding of VCPUs.

>=20
> That would incur the page scanning overhead etc and make
> cache aware scheduling be dependent on NUMA balancing.
> =C2=A0
>=20
> >=20
> > So I'm wondering, why not move =E2=80=98mm->mm_sched_cpu=E2=80=99 to =
=E2=80=98task_struct=E2=80=99, so that each thread can individually track i=
ts preferred LLC? What are the losses in doing so?
>=20
> You would need a way to group related tasks together and put them
> on the same LLC.=C2=A0 Either group them by mm or some other means.
>=20
> Yes, you are right, how about this, beside in 'mm',=C2=A0 add cgroup supp=
ort too =EF=BC=9F=C2=A0

Doing cgroup may not solve the original issue you brought
up, where a process may have a group of tasks wanting to go
into one cache and another group of tasks going to another cache.
I could be wrong but I don't think you can split up tasks in a process
in cgroup v2 to different cgroups.

Also the cgroup folks are quite resistant to adding new knobs.

Tim

>=20
> >=20
> > +
> > + if (p->preferred_llc !=3D mm_sched_llc)
> > + p->preferred_llc =3D mm_sched_llc;
> > =C2=A0}
> > =C2=A0
> > =C2=A0static void task_tick_cache(struct rq *rq, struct task_struct *p)

