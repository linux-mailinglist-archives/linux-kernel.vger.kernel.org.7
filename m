Return-Path: <linux-kernel+bounces-874331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1EFCC16147
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 18:14:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A5303AD5CD
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 17:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C835346E67;
	Tue, 28 Oct 2025 17:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lDVuiocb"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10EC9288C3D
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 17:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761671197; cv=none; b=e6VFaDosQhIKih912qSE5MPYm7+tiKECAkXsroalUF8WY7ZhWL4vl+l1ZOHKv6xfkn23CgN/3K84EhutfSwgqq2hO/n6QzGW4GiCk911b+/7ApFjjcVEf4oKNVmavAOcIIORXslMEduvIfQpY0gqgHaQGudaTJ/AD8WVRhRf2I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761671197; c=relaxed/simple;
	bh=1fRCFqCI/ZAvNd/ktogPG/ORwomJRauu8jGRPo54Svw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rGET9xmFJ7csX6wR192XHwa3R5ZT4EdQbdru9v1tMfiVvvFv+OcbZBXt59i+aay5W0V/DqeeF0ud1MGOZ4mS41SlFocIvisQTUfoi8HTJHU0dtlak0+KMYbV1RWUs+3cWv6qQJ1cs/ffmSe+8VFwtdpAvLVJ0+9sHUsknQjy6ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lDVuiocb; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761671191; x=1793207191;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=1fRCFqCI/ZAvNd/ktogPG/ORwomJRauu8jGRPo54Svw=;
  b=lDVuiocbbnUi+FPTXzKMFzSBn5zPWTTX7N08AGSUq4BHiOTvjtM6AGDG
   2g8Q+00yy5ZMlVwlfMbknlekQk6wA5BemXZsabb8rgYhfsUSKw2/VHal6
   jXkCGifGkRlnjF8hEEwtFy+CGfEbBir2FT09RnR6vnthm+O6cpduROL8i
   qXfGitNZrNkRQWmi88u67yFdF8e6NptshGfkrIWoisItpMrh4pM7bZkwn
   dgTQPzR9AX2wTFsV4/kS1O3QuvcnF2Vi7sr5Q+Ho7u3kBYLCpFREw4t+L
   OKaYjrTp+reGr32L9MzYo7qc5vciHGmycB6L2rFtekJ1b4zxjQrZ7fN4B
   Q==;
X-CSE-ConnectionGUID: BjQ8PKQFQWCb67+AWMFaFQ==
X-CSE-MsgGUID: iVIK6X2fRLKWJrbNmihyHA==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="81409946"
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; 
   d="scan'208";a="81409946"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 10:06:30 -0700
X-CSE-ConnectionGUID: pEKwIVaQTFiG5cn3iDp5wQ==
X-CSE-MsgGUID: vm7DQprKSLK1QmkPZeb+zg==
X-ExtLoop1: 1
Received: from unknown (HELO [10.241.243.18]) ([10.241.243.18])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 10:06:29 -0700
Message-ID: <23a9460132e9221bdfe91c334d4850e15ac6178c.camel@linux.intel.com>
Subject: Re: [PATCH 07/19] sched/fair: Track LLC-preferred tasks per runqueue
From: Tim Chen <tim.c.chen@linux.intel.com>
To: K Prateek Nayak <kprateek.nayak@amd.com>, Peter Zijlstra	
 <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, "Gautham R .
 Shenoy"	 <gautham.shenoy@amd.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>, Juri Lelli	
 <juri.lelli@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel
 Gorman <mgorman@suse.de>,  Valentin Schneider	 <vschneid@redhat.com>,
 Madadi Vineeth Reddy <vineethr@linux.ibm.com>, Hillf Danton
 <hdanton@sina.com>, Shrikanth Hegde <sshegde@linux.ibm.com>, Jianyong Wu	
 <jianyong.wu@outlook.com>, Yangyu Chen <cyy@cyyself.name>, Tingyin Duan	
 <tingyin.duan@gmail.com>, Vern Hao <vernhao@tencent.com>, Len Brown	
 <len.brown@intel.com>, Aubrey Li <aubrey.li@intel.com>, Zhao Liu	
 <zhao1.liu@intel.com>, Chen Yu <yu.chen.surf@gmail.com>, Chen Yu	
 <yu.c.chen@intel.com>, Libo Chen <libo.chen@oracle.com>, Adam Li	
 <adamli@os.amperecomputing.com>, Tim Chen <tim.c.chen@intel.com>, 
	linux-kernel@vger.kernel.org
Date: Tue, 28 Oct 2025 10:06:28 -0700
In-Reply-To: <fe5eeffc-ff8f-4bfb-b0a1-5b25731afb88@amd.com>
References: <cover.1760206683.git.tim.c.chen@linux.intel.com>
	 <ccbfda37200b66177a1c1add4715a49b863ac84d.1760206683.git.tim.c.chen@linux.intel.com>
	 <fe5eeffc-ff8f-4bfb-b0a1-5b25731afb88@amd.com>
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

On Mon, 2025-10-27 at 11:34 +0530, K Prateek Nayak wrote:
> Hello Tim,
>=20
> On 10/11/2025 11:54 PM, Tim Chen wrote:
> > @@ -3999,6 +4038,7 @@ account_entity_enqueue(struct cfs_rq *cfs_rq, str=
uct sched_entity *se)
> >  		struct rq *rq =3D rq_of(cfs_rq);
> > =20
> >  		account_numa_enqueue(rq, task_of(se));
> > +		account_llc_enqueue(rq, task_of(se));
> >  		list_add(&se->group_node, &rq->cfs_tasks);
> >  	}
> >  	cfs_rq->nr_queued++;
> > @@ -4010,9 +4050,14 @@ account_entity_dequeue(struct cfs_rq *cfs_rq, st=
ruct sched_entity *se)
> >  	update_load_sub(&cfs_rq->load, se->load.weight);
> >  	if (entity_is_task(se)) {
> >  		account_numa_dequeue(rq_of(cfs_rq), task_of(se));
> > +		account_llc_dequeue(rq_of(cfs_rq), task_of(se));
> >  		list_del_init(&se->group_node);
> >  	}
> >  	cfs_rq->nr_queued--;
> > +
> > +	/* safeguard to clear the cache aware data */
> > +	if (!parent_entity(se) && !cfs_rq->nr_queued)
> > +		reset_llc_stats(rq_of(cfs_rq));
>=20
> Instead of relying on reset_llc_stats() hack, I think a better approach
> would be to have a "p->se.llc_sched_active" flag similar to how uclamp
> has "uc_se->active" and we set this in account_llc_enqueue() which will
> still check for sched_cache_enabled() but account_llc_dequeue() would
> only check for "p->se.llc_sched_active" to decrement the stats and then
> unset the flag.
>=20
> That way, we cannot have an imbalanced accounting. Thoughts?

With our current accounting method, we should not have imbalanced
accounting even if you turn on sched_cache after the
scheduler has started running (see my reply to Chen Yu's follow up).
That reset_llc_stats() hack
should not be needed as Peter pointed out.

We will change that check to warning under debug option.

Tim

>=20
> >  }
> > =20

