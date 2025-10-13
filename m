Return-Path: <linux-kernel+bounces-851148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B56FCBD5A81
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 20:09:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 754264E9604
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 18:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C7BB2D0C79;
	Mon, 13 Oct 2025 18:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NxJI06hh"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B21259CA5
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 18:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760378984; cv=none; b=Bv0ZN294SGAeYv5OPYTxKLEx4BmOcKofyYd7CVUyOQRzlPeF/uc9zJudg3L6HCMXWNfwfH2/NlqQ80umCYJYgjEbDuLUIaA/01HAyzahDSgrMtj/B9s32ry/gqJMrTxBu9sRWxym52eQj7Dq2SAAxbbk9TCKVjzlPRQF/CPSL7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760378984; c=relaxed/simple;
	bh=4fXevMhK/wmq7g2S8wHUm3VORemgJE2/LVjCQ1Y8QJM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EP6TB45eZlWAE71378EJ3qI7xFukhp726nwUX38p34AXoUn+zM8tNXlXctDGhCEfcW95UlihVcOOVV4cBLaQUsbEiOxGAtqFTSoL8trtjvC1WgSCfYGoQKmPI2JIsmYHjGvR1nAJrjwjWJodfP27Mco5ieekn6KoWGdnu1CjI0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NxJI06hh; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760378983; x=1791914983;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=4fXevMhK/wmq7g2S8wHUm3VORemgJE2/LVjCQ1Y8QJM=;
  b=NxJI06hh+7iDzkDGHrXCFFsZwJokURfwStqt7HnNMrqd2h9xt4JU3Nh9
   gv1jlzHdZaFCjllUQ+ERIsl56NXe0rata1rA2Php6XcZoN/z4ft4Zi5VJ
   VdMlUXfLsOnZa+PF/5cgt0Lxpxqt6AoTfUicOUUwRlG/jH63PdIKk6zYb
   72uLWfPvJOVCp6oDK9S2/flW4Tqb9XsyDz/I/F3bBN7/jUWNNx1dcrRi8
   XAPU98xGwEr/qjq29qSMaJQNmWkxmz+LaAfIDiO7BdXnxHAJbmv1Edeau
   t+kNf9vfdUmDITUw5JjpmuVn+sr8JNTHDpxMunudfSg+moeeX9iiIssss
   Q==;
X-CSE-ConnectionGUID: ACUSLUaBTxi4e2AM4Byrcg==
X-CSE-MsgGUID: 3Bo6o7NWRj2PWJYWnEMBpQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11581"; a="73871759"
X-IronPort-AV: E=Sophos;i="6.19,226,1754982000"; 
   d="scan'208";a="73871759"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2025 11:09:42 -0700
X-CSE-ConnectionGUID: E4JQEVwqS3uX8VCWbWX9HA==
X-CSE-MsgGUID: Ey2K6aJLRQe5nqBtI6Z8jQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,226,1754982000"; 
   d="scan'208";a="181469341"
Received: from unknown (HELO [10.241.242.139]) ([10.241.242.139])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2025 11:09:42 -0700
Message-ID: <eed85200babfcfd43669270912176d38b8cc8f69.camel@linux.intel.com>
Subject: Re: =?UTF-8?Q?=E5=9B=9E=E5=A4=8D=EF=BC=9A=5BInternet=5D=5BPATCH?=
 06/19] sched/fair: Assign preferred LLC ID to processes
From: Tim Chen <tim.c.chen@linux.intel.com>
To: =?UTF-8?Q?vernhao=28=E9=83=9D=E4=BF=A1=29?= <vernhao@tencent.com>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, K
 Prateek Nayak <kprateek.nayak@amd.com>,  "Gautham R . Shenoy"
 <gautham.shenoy@amd.com>
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
Date: Mon, 13 Oct 2025 11:09:41 -0700
In-Reply-To: <tencent_660411F01236A0D747E5BF2B@qq.com>
References: <tencent_660411F01236A0D747E5BF2B@qq.com>
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

On Mon, 2025-10-13 at 17:10 +0800, vernhao(=E9=83=9D=E4=BF=A1) wrote:
>=20
> Tim Chen<tim.c.chen@linux.intel.com>=C2=A0=E5=9C=A8 2025=E5=B9=B410=E6=9C=
=8812=E6=97=A5 =E5=91=A8=E6=97=A5 2:18 =E5=86=99=E9=81=93=EF=BC=9A
> With cache-aware scheduling enabled, each task is assigned a
> preferred LLC ID. This allows quick identification of the LLC domain
> where the task prefers to run, similar to numa_preferred_nid in
> NUMA balancing.
>=20
> Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
> ---
> =C2=A0include/linux/sched.h | 1 +
> =C2=A0init/init_task.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 3 +++
> =C2=A0kernel/sched/fair.c=C2=A0=C2=A0 | 7 +++++++
> =C2=A03 files changed, 11 insertions(+)
>=20
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index d7ddb7ce6c4b..8a5e4038cd5c 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1402,6 +1402,7 @@ struct task_struct {
> =C2=A0
> =C2=A0#ifdef CONFIG_SCHED_CACHE
> =C2=A0 struct callback_head cache_work;
> + int preferred_llc;
> =C2=A0#endif
> =C2=A0
> =C2=A0#ifdef CONFIG_RSEQ
> diff --git a/init/init_task.c b/init/init_task.c
> index e557f622bd90..5fffbe766f57 100644
> --- a/init/init_task.c
> +++ b/init/init_task.c
> @@ -188,6 +188,9 @@ struct task_struct init_task __aligned(L1_CACHE_BYTES=
) =3D {
> =C2=A0 .numa_group =3D NULL,
> =C2=A0 .numa_faults =3D NULL,
> =C2=A0#endif
> +#ifdef CONFIG_SCHED_CACHE
> + .preferred_llc=C2=A0 =3D -1,
> +#endif
> =C2=A0#if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
> =C2=A0 .kasan_depth =3D 1,
> =C2=A0#endif
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 61c129bde8b6..d6167a029c47 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -1312,6 +1312,7 @@ void account_mm_sched(struct rq *rq, struct task_st=
ruct *p, s64 delta_exec)
> =C2=A0 struct mm_struct *mm =3D p->mm;
> =C2=A0 struct mm_sched *pcpu_sched;
> =C2=A0 unsigned long epoch;
> + int mm_sched_llc =3D -1;
> =C2=A0
> =C2=A0 if (!sched_cache_enabled())
> =C2=A0 return;
> @@ -1342,6 +1343,12 @@ void account_mm_sched(struct rq *rq, struct task_s=
truct *p, s64 delta_exec)
> =C2=A0 if (mm->mm_sched_cpu !=3D -1)
> =C2=A0 mm->mm_sched_cpu =3D -1;
> =C2=A0 }
> +
> + if (mm->mm_sched_cpu !=3D -1)
> + mm_sched_llc =3D per_cpu(sd_llc_id, mm->mm_sched_cpu);
>=20
> In high-concurrency multi-threaded scenarios, not all threads handle same=
 events, so their hot data in the LLC is not completely shared.=C2=A0
> Therefore, if every thread's preferred LLC is migrated to the LLC pointed=
 to by mm->mm_sched_cpu, this would lead to the incorrect=C2=A0
> assumption that all threads prefer the same LLC, thereby intensifying com=
petition between LLCs.

Yes, that's the reason why we stop aggregating to the preferred LLC once th=
e the utilization of the
LLC becomes too high relative to the other LLCs.

If you know your threads characteristics before hand on which of them
share data together, you probably can use cgroup/cpuset
from user space to separate out the threads. =C2=A0

There's not enough info from occupancy data for OS to group
the threads by data sharing. Perhaps an alternative if NUMA balancing
is on is to group tasks by their task numa group instead of by mm. =C2=A0

That would incur the page scanning overhead etc and make
cache aware scheduling be dependent on NUMA balancing.
=20

>=20
> So I'm wondering, why not move =E2=80=98mm->mm_sched_cpu=E2=80=99 to =E2=
=80=98task_struct=E2=80=99, so that each thread can individually track its =
preferred LLC? What are the losses in doing so?

You would need a way to group related tasks together and put them
on the same LLC.  Either group them by mm or some other means.

Tim

>=20
> +
> + if (p->preferred_llc !=3D mm_sched_llc)
> + p->preferred_llc =3D mm_sched_llc;
> =C2=A0}
> =C2=A0
> =C2=A0static void task_tick_cache(struct rq *rq, struct task_struct *p)

