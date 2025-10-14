Return-Path: <linux-kernel+bounces-853193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D58FDBDAE3F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 20:06:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 122ED4F4CC9
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 18:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34981305E3E;
	Tue, 14 Oct 2025 18:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WsboeoY5"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23DE8273811
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 18:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760465159; cv=none; b=YB7nWdV/LJbudE/boEOweadhen3tf5l00lJZDVOTsYBF/VG1WfySIH5QEYZc2NUrLBjp2zfFGCcjvPlJ507fgsR8U7Ba8pTCj4Yfa6UR6jDzDeKfDHAtPldwbiBVhRJZ6LwLwctu2Ll2hIXSs8VguKu1Uu2084O2swkxqwlFdH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760465159; c=relaxed/simple;
	bh=aL7njz421BWl4esk3hyMqFZQpGSaLu4r1TABfWe6t3w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BPdzHzflkviERye3j6qpWfBpOs5k7QUFqAb0d6/UwsiGsAeFskPRgCLvtFxKqWQbjOEt2YA9BMNRBQETW7V+MoH+7em/rwgE7B4WQyrcz3cao9XyQhNs2tZ6PpkmsjkCziIIhe6h8l+b+7K7QMCS0kvxirsc6kV76bygw156qeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WsboeoY5; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760465157; x=1792001157;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=aL7njz421BWl4esk3hyMqFZQpGSaLu4r1TABfWe6t3w=;
  b=WsboeoY59vCrF/PTgtlSGWNNsQ0V/LgzAQ6x8PAmeJlqTlWGWI5L8EVf
   hMSiPEOAq6YJeWK/y+1bAm9rdFDGznFCg1FXgo7JfpbPU+hynxKnGllF7
   8U+dzNjP/dSdQyWAf/2t1bv4gQpnzREug46H4x7UNn7fXqIxSdo5bBvD0
   Jz7nPSe5RVbcVhCDEgnKe8PJxXOMtDtC518idbf2eTq/tfVx92U9yhm2o
   /sDn/dok0HYTUyiY2BmtzEKomkJmMu2ZOWwioPAstuLCpoMSCvJKMCY6c
   fS4NlQbJ5LVrFGqMgC+Ixx3QnMile1ExO8j8cfPQ1GOjEnGibPIDogoap
   g==;
X-CSE-ConnectionGUID: 0Kb4Db0XTNqLlRBz/+q94w==
X-CSE-MsgGUID: RtNzuBsDQoenM09BkrElcw==
X-IronPort-AV: E=McAfee;i="6800,10657,11582"; a="73735292"
X-IronPort-AV: E=Sophos;i="6.19,228,1754982000"; 
   d="scan'208";a="73735292"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2025 11:05:56 -0700
X-CSE-ConnectionGUID: NZDXLh0RScizLNfnjzBJkg==
X-CSE-MsgGUID: XC32DP5HSgWkVC4ftyCZig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,228,1754982000"; 
   d="scan'208";a="187042997"
Received: from unknown (HELO [10.241.242.248]) ([10.241.242.248])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2025 11:05:57 -0700
Message-ID: <a96d3a24e47da7572e7b6d6fa7bb1f6f1be9353e.camel@linux.intel.com>
Subject: Re: [RESEND PATCH] sched/fair: Skip sched_balance_running cmpxchg
 when balance is not due
From: Tim Chen <tim.c.chen@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>, Chen Yu <yu.c.chen@intel.com>, Doug
 Nelson	 <doug.nelson@intel.com>, Mohini Narkhede
 <mohini.narkhede@intel.com>, 	linux-kernel@vger.kernel.org, Vincent Guittot
 <vincent.guittot@linaro.org>,  Shrikanth Hegde <sshegde@linux.ibm.com>, K
 Prateek Nayak <kprateek.nayak@amd.com>
Date: Tue, 14 Oct 2025 11:05:56 -0700
In-Reply-To: <20251014092436.GK4067720@noisy.programming.kicks-ass.net>
References: 
	<e27d5dcb724fe46acc24ff44670bc4bb5be21d98.1759445926.git.tim.c.chen@linux.intel.com>
	 <20251013142638.GM3245006@noisy.programming.kicks-ass.net>
	 <aa3d20e6d451e0d0b812fe16e9d403c1033feeaa.camel@linux.intel.com>
	 <20251014092436.GK4067720@noisy.programming.kicks-ass.net>
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

On Tue, 2025-10-14 at 11:24 +0200, Peter Zijlstra wrote:
> On Mon, Oct 13, 2025 at 02:54:19PM -0700, Tim Chen wrote:
>=20
> > > So I'm not sure I understand the situation, @continue_balancing shoul=
d
> > > limit this concurrency to however many groups are on this domain -- y=
our
> > > granite thing with SNC on would have something like 6 groups?
> >=20
> > That's a good point.  But I think the contention is worse than
> > 6 CPUs.
> >=20
> > The hierarchy would be
> >=20
> > SMT
> > NUMA-level1
> > NUMA-level2
> > NUMA-level3
> > NUMA-level4
>=20
> Aren't you missing the LLC/NODE domain here? We should have at least one
> !SD_NUMA domain above SMT.

Yeah, I should have said the MC level which contains SMT groups

SMT
MC
NUMA-level1
...

Actual dmesg log:

[    7.977893] CPU0 attaching sched-domain(s):
[    7.977897]  domain-0: span=3D0,192 level=3DSMT
[    7.977902]   groups: 0:{ span=3D0 cap=3D972 }, 192:{ span=3D192 cap=3D1=
022 }[    7.977907]   domain-1: span=3D0-31,192-223 level=3DMC[    7.977909=
]    groups: 0:{ span=3D0,192 cap=3D1994 }, 1:{ span=3D1,193
cap=3D2048 }, 2:{ span=3D2,194 cap=3D2047 }, 3:{ span=3D3,195 cap=3D2047 },=
 4:{ span=3D4,196 cap=3D2048 }, 5:{ span=3D5,197 cap=3D2046 }, 6:{ span=3D6=
,198 cap=3D2047 }, 7:{ span=3D7,199 cap=3D2048 }, 8:{ span=3D8,200 cap=3D20=
47 },
9:{ span=3D9,201 cap=3D2046 }, 10:{ span=3D10,202 cap=3D2046 }, 11:{ span=
=3D11,203 cap=3D2046 }, 12:{ span=3D12,204 cap=3D2044 }, 13:{ span=3D13,205=
 cap=3D2048 }, 14:{ span=3D14,206 cap=3D2046 }, 15:{ span=3D15,207 cap=3D20=
43 },
16:{ span=3D16,208 cap=3D2046 }, 17:{ span=3D17,209 cap=3D2048 }, 18:{ span=
=3D18,210 cap=3D2046 }, 19:{ span=3D19,211 cap=3D2045 }, 20:{ span=3D20,212=
 cap=3D2046 }, 21:{ span=3D21,213 cap=3D2044 }, 22:{ span=3D22,214 cap=3D20=
45
}, 23:{ span=3D23,215 cap=3D2046 }, 24:{ span=3D24,216 cap=3D2045 }, 25:{ s=
pan=3D25,217 cap=3D2044 }, 26:{ span=3D26,218 cap=3D2046 }, 27:{ span=3D27,=
219 cap=3D2045 }, 28:{ span=3D28,220 cap=3D2045 }, 29:{ span=3D29,221
cap=3D2046 }, 30:{ span=3D30,222 cap=3D2045 }, 31:{ span=3D31,223 cap=3D204=
5 }
[    7.977956]    domain-2: span=3D0-63,192-255 level=3DNUMA
[    7.977958]     groups: 0:{ span=3D0-31,192-223 cap=3D65418 }, 32:{ span=
=3D32-63,224-255 cap=3D65453 }
[    7.977962]     domain-3: span=3D0-95,192-287 level=3DNUMA
[    7.977963]      groups: 0:{ span=3D0-63,192-255 mask=3D0-31,192-223 cap=
=3D130871 }, 64:{ span=3D32-95,224-287 mask=3D64-95,256-287 cap=3D130929 }
[    7.977968]      domain-4: span=3D0-127,192-319 level=3DNUMA
[    7.977970]       groups: 0:{ span=3D0-95,192-287 cap=3D196314 }, 96:{ s=
pan=3D96-127,288-319 cap=3D65439 }
[    7.977974]       domain-5: span=3D0-127,160-319,352-383 level=3DNUMA
[    7.977975]        groups: 0:{ span=3D0-127,192-319 mask=3D0-31,192-223 =
cap=3D261753 }, 160:{ span=3D160-191,352-383 cap=3D65430 }
[    7.977980]        domain-6: span=3D0-383 level=3DNUMA=20

>=20
> > There would be multiple CPUs in that are first in the SMT group
> > with continue_balancing=3D1 going up in the hierachy and
> > attempting the cmpxchg in the first NUMA domain level,
> > before calling should_we_balance() and finding that they are
> > not the first in the NUMA domain and set continue_balancing=3D0
> > and abort. Those CPUS are in same L3.
> > But at the same time, there could be CPUs in other sockets
> > cmpxchg on sched_balance_running.
>=20
> Right, Yu Chen said something like that as well, should_we_balance() is
> too late.
>=20
> Should we instead move the whole serialize thing inside
> sched_balance_rq() like so:

I think that makes sense. Probably a separate patch.

Tim

>=20
> ---
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index bc0b7ce8a65d..e9f719ba17e1 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -11722,6 +11722,22 @@ static void update_lb_imbalance_stat(struct lb_e=
nv *env, struct sched_domain *sd
>  	}
>  }
> =20
> +
> +/*
> + * This flag serializes load-balancing passes over large domains
> + * (above the NODE topology level) - only one load-balancing instance
> + * may run at a time, to reduce overhead on very large systems with
> + * lots of CPUs and large NUMA distances.
> + *
> + * - Note that load-balancing passes triggered while another one
> + *   is executing are skipped and not re-tried.
> + *
> + * - Also note that this does not serialize rebalance_domains()
> + *   execution, as non-SD_SERIALIZE domains will still be
> + *   load-balanced in parallel.
> + */
> +static atomic_t sched_balance_running =3D ATOMIC_INIT(0);
> +
>  /*
>   * Check this_cpu to ensure it is balanced within domain. Attempt to mov=
e
>   * tasks if there is an imbalance.
> @@ -11747,6 +11763,7 @@ static int sched_balance_rq(int this_cpu, struct =
rq *this_rq,
>  		.fbq_type	=3D all,
>  		.tasks		=3D LIST_HEAD_INIT(env.tasks),
>  	};
> +	int need_unlock =3D false;
> =20
>  	cpumask_and(cpus, sched_domain_span(sd), cpu_active_mask);
> =20
> @@ -11758,6 +11775,12 @@ static int sched_balance_rq(int this_cpu, struct=
 rq *this_rq,
>  		goto out_balanced;
>  	}
> =20
> +	if (idle !=3D CPU_NEWLY_IDLE && (sd->flags & SD_SERIALIZE)) {
> +		if (atomic_cmpxchg_acquire(&sched_balance_running, 0, 1))
> +			goto out_balanced;
> +		need_unlock =3D true;
> +	}
> +
>  	group =3D sched_balance_find_src_group(&env);
>  	if (!group) {
>  		schedstat_inc(sd->lb_nobusyg[idle]);
> @@ -11998,6 +12021,9 @@ static int sched_balance_rq(int this_cpu, struct =
rq *this_rq,
>  	    sd->balance_interval < sd->max_interval)
>  		sd->balance_interval *=3D 2;
>  out:
> +	if (need_unlock)
> +		atomic_set_release(&sched_balance_running, 0);
> +
>  	return ld_moved;
>  }
> =20
> @@ -12122,21 +12148,6 @@ static int active_load_balance_cpu_stop(void *da=
ta)
>  	return 0;
>  }
> =20
> -/*
> - * This flag serializes load-balancing passes over large domains
> - * (above the NODE topology level) - only one load-balancing instance
> - * may run at a time, to reduce overhead on very large systems with
> - * lots of CPUs and large NUMA distances.
> - *
> - * - Note that load-balancing passes triggered while another one
> - *   is executing are skipped and not re-tried.
> - *
> - * - Also note that this does not serialize rebalance_domains()
> - *   execution, as non-SD_SERIALIZE domains will still be
> - *   load-balanced in parallel.
> - */
> -static atomic_t sched_balance_running =3D ATOMIC_INIT(0);
> -
>  /*
>   * Scale the max sched_balance_rq interval with the number of CPUs in th=
e system.
>   * This trades load-balance latency on larger machines for less cross ta=
lk.
> @@ -12192,7 +12203,7 @@ static void sched_balance_domains(struct rq *rq, =
enum cpu_idle_type idle)
>  	/* Earliest time when we have to do rebalance again */
>  	unsigned long next_balance =3D jiffies + 60*HZ;
>  	int update_next_balance =3D 0;
> -	int need_serialize, need_decay =3D 0;
> +	int need_decay =3D 0;
>  	u64 max_cost =3D 0;
> =20
>  	rcu_read_lock();
> @@ -12216,13 +12227,6 @@ static void sched_balance_domains(struct rq *rq,=
 enum cpu_idle_type idle)
>  		}
> =20
>  		interval =3D get_sd_balance_interval(sd, busy);
> -
> -		need_serialize =3D sd->flags & SD_SERIALIZE;
> -		if (need_serialize) {
> -			if (atomic_cmpxchg_acquire(&sched_balance_running, 0, 1))
> -				goto out;
> -		}
> -
>  		if (time_after_eq(jiffies, sd->last_balance + interval)) {
>  			if (sched_balance_rq(cpu, rq, sd, idle, &continue_balancing)) {
>  				/*
> @@ -12236,9 +12240,7 @@ static void sched_balance_domains(struct rq *rq, =
enum cpu_idle_type idle)
>  			sd->last_balance =3D jiffies;
>  			interval =3D get_sd_balance_interval(sd, busy);
>  		}
> -		if (need_serialize)
> -			atomic_set_release(&sched_balance_running, 0);
> -out:
> +
>  		if (time_after(next_balance, sd->last_balance + interval)) {
>  			next_balance =3D sd->last_balance + interval;
>  			update_next_balance =3D 1;

