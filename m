Return-Path: <linux-kernel+bounces-872800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 101CAC12118
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 00:36:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 088611A20426
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 23:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27DAE314A84;
	Mon, 27 Oct 2025 23:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JCRuQyfc"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0643219A7D
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 23:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761608174; cv=none; b=m+LU9/Fv7h76izZDKV/71k8csDoW/kt3QiVKQ4xtUCFn2Jz6Hi90Sfdc+frSPOkeczmJo+WJ3k+xbm70DU0fRB7tar/oP2u5oYXaKWqIb2wjnZqcCxuRTyGdJ3qRJlgAm33nmyq7Bj+C9pOAf5j1qYd7Wa7U8CJSyHpJMbdmois=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761608174; c=relaxed/simple;
	bh=6qYAW7aDiyNloN5Ulnvu5eZKqbShOSX6wLXLvt5uVks=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KMg7FRPimS+hxEG1C2OvhNqZzQq1cY6MDSGaYOLqDrMb/8LdDFk+wbZSF0IXooTJllR4YFB6BGqFSrtG4G7wTV9VmRw5mJJIuchSrXCGLsPKbzmmN+LkxLrKAYoGUhxgH1VZUfoS8HP2WDHRI797527ebNwzfXyfdfqZyBgGsjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JCRuQyfc; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761608172; x=1793144172;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=6qYAW7aDiyNloN5Ulnvu5eZKqbShOSX6wLXLvt5uVks=;
  b=JCRuQyfciPwlWje//6bEngvqiC707pdGbYkL2Q4Zn38yWNQJQIHnqvhT
   n+rJWCD0KJ5Rlq/DvWJvltXfml/eHAN/vyoERM2PlIyM2W9+tzOWmkzOD
   6YGxWAbx482av+6QUzK2kiqFQiauU99Iegjq0Hh/IPSwXmNQvM9dSJ4LJ
   66mKz5ZDr5OCO/IGT26NDDUT0W7nBEX/2ARpzf7j0qs+jwr69VDZUMSjU
   XreV0ax3NUs4q8ScDdFyUPS7lu3xGSjylj9A8loyp2xQ2jxj3anhZng+C
   e+N0yLuoqpEOFQKNt5yGE2oyKews6Ij1XVWne5wf6ksZEI8qkKr5G7BlH
   g==;
X-CSE-ConnectionGUID: 1FyzHKhtQ62PhSi4eHNBDw==
X-CSE-MsgGUID: FWe9I/VXQV+DCH1YXyvWOw==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="67343626"
X-IronPort-AV: E=Sophos;i="6.19,259,1754982000"; 
   d="scan'208";a="67343626"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 16:36:10 -0700
X-CSE-ConnectionGUID: oO8IBs9IQ2ygCO5+MZ6SbA==
X-CSE-MsgGUID: d3upG4SUSYeNVVIdI9HRNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,259,1754982000"; 
   d="scan'208";a="216071315"
Received: from unknown (HELO [10.241.243.18]) ([10.241.243.18])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 16:36:08 -0700
Message-ID: <e0f2c144f6dd974a816784db676779c1a1a3c5ab.camel@linux.intel.com>
Subject: Re: [PATCH 04/19] sched/fair: Introduce a static key to enable
 cache aware only for multi LLCs
From: Tim Chen <tim.c.chen@linux.intel.com>
To: "Chen, Yu C" <yu.c.chen@intel.com>, K Prateek Nayak
 <kprateek.nayak@amd.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>, Juri Lelli	
 <juri.lelli@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel
 Gorman <mgorman@suse.de>,  Valentin Schneider	 <vschneid@redhat.com>,
 Madadi Vineeth Reddy <vineethr@linux.ibm.com>, Hillf Danton
 <hdanton@sina.com>, Shrikanth Hegde <sshegde@linux.ibm.com>, Jianyong Wu	
 <jianyong.wu@outlook.com>, Yangyu Chen <cyy@cyyself.name>, Tingyin Duan	
 <tingyin.duan@gmail.com>, Vern Hao <vernhao@tencent.com>, Len Brown	
 <len.brown@intel.com>, Aubrey Li <aubrey.li@intel.com>, Zhao Liu	
 <zhao1.liu@intel.com>, Chen Yu <yu.chen.surf@gmail.com>, Adam Li	
 <adamli@os.amperecomputing.com>, Tim Chen <tim.c.chen@intel.com>, 
	linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 "Gautham R . Shenoy" <gautham.shenoy@amd.com>, Ingo Molnar
 <mingo@redhat.com>
Date: Mon, 27 Oct 2025 16:36:08 -0700
In-Reply-To: <ebc82974-7fe5-4e9a-8dae-7964cfdff471@intel.com>
References: <cover.1760206683.git.tim.c.chen@linux.intel.com>
	 <ef136e6a6f5a2ef840b1f9571c47411f04705b6a.1760206683.git.tim.c.chen@linux.intel.com>
	 <7ff17661-05fe-4137-b7e1-c799fe318c9f@amd.com>
	 <ebc82974-7fe5-4e9a-8dae-7964cfdff471@intel.com>
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

On Mon, 2025-10-27 at 20:56 +0800, Chen, Yu C wrote:
> Hi Prateek,
>=20
> On 10/27/2025 1:42 PM, K Prateek Nayak wrote:
> > Hello Tim,
> >=20
> > On 10/11/2025 11:54 PM, Tim Chen wrote:
> > > @@ -2530,10 +2531,12 @@ build_sched_domains(const struct cpumask *cpu=
_map, struct sched_domain_attr *att
> > >   				 * between LLCs and memory channels.
> > >   				 */
> > >   				nr_llcs =3D sd->span_weight / child->span_weight;
> > > -				if (nr_llcs =3D=3D 1)
> > > +				if (nr_llcs =3D=3D 1) {
> > >   					imb =3D sd->span_weight >> 3;
> > > -				else
> > > +				} else {
> > >   					imb =3D nr_llcs;
> > > +					has_multi_llcs =3D true;
> >=20
> > One caution: this will not hold if all the CPUs aren't online during bo=
ot.
> > One case I can think of is when the kernel is booted with "maxcpus" cmd=
line
> > and CPUs are hotplugged later.
> >=20
> > Unfortunately, I don't think we even have the raw topology data from th=
e
> > arch/ side under such scenario to accurately make a call if the system
> > contains single or multiple LLC :(
> >=20
> > I'm not sure if it is feasible but assuming the task_work() cannot run =
if
> > &sched_cache_allowed is false, can the fist instance of the task work f=
or
> > sched_cache do the necessary setup?
> >=20
>=20
> build_sched_domains() might get invoked to rebuild the corresponding sche=
d
> domains during CPU hotplug via cpuset subsystem. So if the CPU gets onlin=
e
> after bootup, we still have the chance to detect multiple LLCs I suppose?

The case Pratek brought up of adding CPUs and enabling SCHED_CACHE=20
should be covered.=C2=A0

The trickier case is if we disable SCHED_CACHE when CPUs are
offlined and multi_cpus becomes false.  We'll need to clear out rq->nr_pref=
_llcs
data and tasks' preferred LLC would need to be cleared.  Or else the accoun=
ting
could be skewed we bring CPU online later and again re-enable SCHED_CACHE.
So far we haven't done that when we disable SCHED_CACHE from an enabled sta=
te.

Tim

>=20
> I did a check on my VM:
> root@ubuntu:/sys/devices/system/cpu# lscpu
> CPU(s):                      32
>    On-line CPU(s) list:       0-7
> root@ubuntu:/sys/devices/system/cpu# echo 1 > cpu31/online
> Tracing ... Hit Ctrl-C to end.
> ^C
>=20
> @build_sched_domains[
>      build_sched_domains+5
>      partition_sched_domains+613
>      cpuset_update_active_cpus+838
>      sched_cpu_activate+272
>      cpuhp_invoke_callback+340
>      cpuhp_thread_fun+139
>      smpboot_thread_fn+238
>      kthread+249
>      ret_from_fork+193
>      ret_from_fork_asm+26
> ]: 1
>=20
> thanks,
> Chenyu

