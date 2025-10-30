Return-Path: <linux-kernel+bounces-879046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 276F3C22200
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 21:08:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 883F7189251B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 20:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC44636E357;
	Thu, 30 Oct 2025 20:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VovJ++th"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB6F31D39F
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 20:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761854861; cv=none; b=pieE4qT1aG59aZYUH54bYPL5rJWYbJbbjSG49IToT/4azu56aq3SMFX6KS1/p6ra0ZadPbUpyc2Rd0I7biNUMCRMqEwQhKmdUatByJFiL3SozAO38oAt4S0CU4GzVlYNh7j98LeXTtqWsS9kQQNWkV6VycHava756579nnUguE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761854861; c=relaxed/simple;
	bh=LcYMdAA5QAJffUL5Dg8odGZGOYwV5gcq2K9N4gApDzM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kYslEFmOQi7/lmLiE1p47+DMkcyY4d8RYI+T6Q39/nYyZJo2HhVIRXnRZ+STz7JvXZQj+LbKT8ATAV/O47EH7zswcIRk2CUIqlEu7I/SqnnbjAS45v046fxkY+dwRGAt8XyumoL0wT4fFoq9LDU1RgUGf38xpRREX56i8rMdFvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VovJ++th; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761854860; x=1793390860;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=LcYMdAA5QAJffUL5Dg8odGZGOYwV5gcq2K9N4gApDzM=;
  b=VovJ++thFox1g4f4GLt9yZ8yJlYn2U6T6PpybTiyNZ/aTGOiPn8gdcG8
   1G0GO3iZW4SUse7vtDK06lyqNc0KelRE1UqtAn5w+z5BXKatYakmOWAVf
   84QkCVUlr4IxaOJY+XvK5PxBLWZCCbSE+e1+2C0hM89ikoEwrOpgtjXca
   FGtDaDRE2X7PY4O2pgxKiKOvZ8KbcbGRARYStWvLX2SzviVkYzVkJuk2H
   gzZPTRVvmzByxvU0SEKxEUgeENASEJi7SfLBP2pHmSIuGCKP2WLJjOnec
   rhHYiMfTtOqhs8IQrx4/V0Nyp4CD4SCp6idhnajDq0iiwJJGCehVoq67D
   Q==;
X-CSE-ConnectionGUID: pWmq/VhwQMm4mRjpqJVs1g==
X-CSE-MsgGUID: WVgJ3oCAR4GzyNliu2Ie4A==
X-IronPort-AV: E=McAfee;i="6800,10657,11598"; a="74686617"
X-IronPort-AV: E=Sophos;i="6.19,267,1754982000"; 
   d="scan'208";a="74686617"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 13:07:39 -0700
X-CSE-ConnectionGUID: CwP6epySSxyKGH/byFMLuQ==
X-CSE-MsgGUID: bZbxLd5QS3Ctxq8mFp4vLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,267,1754982000"; 
   d="scan'208";a="190392879"
Received: from unknown (HELO [10.241.243.18]) ([10.241.243.18])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 13:07:38 -0700
Message-ID: <c85e242d55da1f12419e2c2dc2bfa3fc942a848e.camel@linux.intel.com>
Subject: Re: [PATCH 15/19] sched/fair: Respect LLC preference in task
 migration and detach
From: Tim Chen <tim.c.chen@linux.intel.com>
To: K Prateek Nayak <kprateek.nayak@amd.com>, "Chen, Yu C"
 <yu.c.chen@intel.com>
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
Date: Thu, 30 Oct 2025 13:07:38 -0700
In-Reply-To: <53f9a8dc-c215-405b-958b-9cdd326dbfe3@amd.com>
References: <cover.1760206683.git.tim.c.chen@linux.intel.com>
	 <d3afcff5622222523c843f5c1b023bfe43f9c67c.1760206683.git.tim.c.chen@linux.intel.com>
	 <5cdf379c-b663-424d-8505-d91046e63c20@amd.com>
	 <0a81b5be-6edd-4231-859b-0c6d06c61595@intel.com>
	 <2c57d76f-fb31-4e1b-a3ce-ca13713e1b86@amd.com>
	 <ebe994addb5624089db71df8fee402a664f8800a.camel@linux.intel.com>
	 <53f9a8dc-c215-405b-958b-9cdd326dbfe3@amd.com>
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

On Thu, 2025-10-30 at 09:49 +0530, K Prateek Nayak wrote:
> Hello Tim,
>=20
> On 10/30/2025 2:39 AM, Tim Chen wrote:
> > > > I suppose you are suggesting that the threshold for stopping task d=
etachment
> > > > should be higher. With the above can_migrate_llc() check, I suppose=
 we have
> > > > raised the threshold for stopping "task detachment"?
> > >=20
> > > Say the LLC is under heavy load and we only have overloaded groups.
> > > can_migrate_llc() would return "mig_unrestricted" since
> > > fits_llc_capacity() would return false.
> > >=20
> > > Since we are under "migrate_load", sched_balance_find_src_rq() has
> > > returned the CPU with the highest load which could very well be the
> > > CPU with with a large number of preferred LLC tasks.
> > >=20
> > > sched_cache_enabled() is still true and when detach_tasks() reaches
> > > one of these preferred llc tasks (which comes at the very end of the
> > > tasks list),=C2=A0
> > > we break out even if env->imbalance > 0 leaving
> >=20
> > Yes, but at least one task has been removed to even the load (making fo=
rward progress) and
> > the remaining tasks all wish to stay in the current LLC and will
> > preferred not to be moved. My thought was to not even all the load out
> > in one shot and pull more tasks out of their preferred LLC.
> > If the imbalance still remain, we'll come to that in the next load bala=
nce.
>=20
> In that case, can we spoof a LBF_ALL_PINNED for the case where we start

In the code chunk (with fix I mentioned in last reply):

+#ifdef CONFIG_SCHED_CACHE
+		/*
+		 * Don't detach more tasks if the remaining tasks want
+		 * to stay. We know the remaining tasks all prefer the
+		 * current LLC, because after order_tasks_by_llc(), the
+		 * tasks that prefer the current LLC are at the tail of
+		 * the list. The inhibition of detachment is to avoid too
+		 * many tasks being migrated out of the preferred LLC.
+		 */
+		if (sched_cache_enabled() && detached && p->preferred_llc !=3D -1 &&
+		    llc_id(env->src_cpu) =3D=3D p->preferred_llc &&
		    llc_id(env->dst_cpu) !=3D p->preferred_llc)
+			break;

We have already pulled at least one task when we stop detaching because we
know that all the remaining tasks want to stay in it current LLC.
"detached" is non zero when we break. So LBF_ALL_PINNED would be cleared.
We will only exit the detach_tasks loop when there are truly no tasks
that can be moved and it is truly a LBF_ALL_PINNED case.

We should not be causing problem with the LBF_ALL_PINNED.

Tim
> hitting preferred task. That way, the main lb loop will goto redo and
> try to find another busy CPU to pull tasks from.
>=20
> >=20
> > Pulling tasks more slowly when we come to tasks that preferred to stay =
(if possible)
> > would also help to prevent tasks bouncing between LLC.
> >=20
> > Tim
> >=20

