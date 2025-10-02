Return-Path: <linux-kernel+bounces-840588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E9BBB4BC3
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 19:46:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DEC019C8761
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 17:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9115F274B39;
	Thu,  2 Oct 2025 17:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G1ravXce"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51F519882B
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 17:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759427190; cv=none; b=hdR+2vA9hfYw+NtDbBuyF7Q1yVljK9Mjm0qK4XGNgp3zj0y0ocRJrZRgR0ekA85bUQADX+9WA9l6LJxUYCYqTfhYLfaB7AaoCSMERDfL474iSzstocera7pc4uJ/w1XryygkRakq4fWMp9KcRHddHCTWwi5YgmJufB3HtUb3tN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759427190; c=relaxed/simple;
	bh=azAzbZ47I5l4JwPusJDx6KaCBO3+FNHt+yo9NUchArw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=K4twWHx6786CZWF6e8xo46wc2GfyCVsqjoGzbGZgo366OKIE2VXch7ZPlbpdto8L60Bohh5T0f+1KLhFKGHNrfWfIca266qB19u53tve1ZwLeYH4QinEAtBjRmXNCeKtkebSwif2WN0Qqzb4pxcSM5ej++BdO9dVRTXA5KxcenU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G1ravXce; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759427189; x=1790963189;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=azAzbZ47I5l4JwPusJDx6KaCBO3+FNHt+yo9NUchArw=;
  b=G1ravXceiFrGWAytc5LpXgsQzsPw2ZC3Lr8B1OcIHTkvPfPB6SgQ3IEo
   25EJlgwMQBkDDospHo+IXVryRxdTPRdyhZL6YEt37efaUtPZow7Q1t4tI
   7dzZ05cmDi7vl47QX8YsI+LScSdi+Z8VGxGd7FGcJbQZ2JtHkswhruZ6V
   S43eW7qOsoPl0uUm2Sx0OWZYEmN53iGz8AXHVBrKNEtq/u47Vq2ryEb1C
   cH422nU8vXTlkqPwPNmNU1a4h8I/0cIjckBfVDvRB0OesxoBg12LfRXJ9
   hVRK6uzG27+2rtwaAFJ5IZoxHQVp+8vlestIy9iEGE3Wm0gfBygA6pqtV
   g==;
X-CSE-ConnectionGUID: X+RFX0cDQbuScUMcaTEbHQ==
X-CSE-MsgGUID: aX0e6OyORBiat7hNds99fA==
X-IronPort-AV: E=McAfee;i="6800,10657,11570"; a="61754831"
X-IronPort-AV: E=Sophos;i="6.18,310,1751266800"; 
   d="scan'208";a="61754831"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2025 10:46:28 -0700
X-CSE-ConnectionGUID: ahvDI2XSQ+SBOz5QdyVvkQ==
X-CSE-MsgGUID: riuwifEfT8SmZ0tRrvNZoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,310,1751266800"; 
   d="scan'208";a="179116115"
Received: from schen9-mobl4.amr.corp.intel.com (HELO [10.125.110.7]) ([10.125.110.7])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2025 10:46:25 -0700
Message-ID: <881eeb68d4e0711bdf73a7fe27cc29d9cae60321.camel@linux.intel.com>
Subject: Re: [RFC PATCH v4 07/28] sched: Add helper function to decide
 whether to allow cache aware scheduling
From: Tim Chen <tim.c.chen@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>, "Chen, Yu C" <yu.c.chen@intel.com>
Cc: Ingo Molnar <mingo@redhat.com>, K Prateek Nayak
 <kprateek.nayak@amd.com>,  "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, Juri Lelli	
 <juri.lelli@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel
 Gorman <mgorman@suse.de>,  Valentin Schneider	 <vschneid@redhat.com>, Libo
 Chen <libo.chen@oracle.com>, Madadi Vineeth Reddy	
 <vineethr@linux.ibm.com>, Hillf Danton <hdanton@sina.com>, Shrikanth Hegde	
 <sshegde@linux.ibm.com>, Jianyong Wu <jianyong.wu@outlook.com>, Yangyu Chen
	 <cyy@cyyself.name>, Tingyin Duan <tingyin.duan@gmail.com>, Vern Hao	
 <vernhao@tencent.com>, Len Brown <len.brown@intel.com>, Aubrey Li	
 <aubrey.li@intel.com>, Zhao Liu <zhao1.liu@intel.com>, Chen Yu	
 <yu.chen.surf@gmail.com>, linux-kernel@vger.kernel.org
Date: Thu, 02 Oct 2025 10:46:25 -0700
In-Reply-To: <20251002115034.GS3419281@noisy.programming.kicks-ass.net>
References: <cover.1754712565.git.tim.c.chen@linux.intel.com>
	 <701c7be7f0e69582d9ad0c25025ec2e133e73fbb.1754712565.git.tim.c.chen@linux.intel.com>
	 <20251001131715.GO4067720@noisy.programming.kicks-ass.net>
	 <89c777b7-33bd-400d-8b6f-4e6d697dc632@intel.com>
	 <20251002115034.GS3419281@noisy.programming.kicks-ass.net>
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

On Thu, 2025-10-02 at 13:50 +0200, Peter Zijlstra wrote:
> On Thu, Oct 02, 2025 at 07:31:40PM +0800, Chen, Yu C wrote:
> > On 10/1/2025 9:17 PM, Peter Zijlstra wrote:
> > > On Sat, Aug 09, 2025 at 01:03:10PM +0800, Chen Yu wrote:
> > > > From: Tim Chen <tim.c.chen@linux.intel.com>
> > > >=20
> > > > Cache-aware scheduling is designed to aggregate threads into their
> > > > preferred LLC, either via the task wake up path or the load balanci=
ng
> > > > path. One side effect is that when the preferred LLC is saturated,
> > > > more threads will continue to be stacked on it, degrading the workl=
oad's
> > > > latency. A strategy is needed to prevent this aggregation from goin=
g too
> > > > far such that the preferred LLC is too overloaded.
> > >=20
> > > So one of the ideas was to extend the preferred llc number to a mask.
> > > Update the preferred mask with (nr_threads / llc_size) bits, indicati=
ng
> > > the that many top llc as sorted by occupancy.
> > >=20
> > >=20
> >=20
> > Having more than one preferred LLC helps prevent aggregation from going
> > too far on a single preferred LLC.
> >=20
> > One question would be: if one LLC cannot hold all the threads of a proc=
ess,
> > does a second preferred LLC help in this use case? Currently, this patc=
h
> > gives up task aggregation and falls back to legacy load balancing if th=
e
> > preferred LLC is overloaded. If we place threads across two preferred L=
LCs,
> > these threads might encounter cross-LLC latency anyway - so we may as w=
ell
> > let
> > legacy load balancing spread them out IMO.
>=20
> Well, being stuck on 2 LLCs instead of being spread across 10 still
> seems like a win, no?
>=20
> Remember, our friends at AMD have *MANY* LLCs.
>=20
> > Another issue that Patch 7 tries to address is avoiding task
> > bouncing between preferred LLCs and non-preferred LLCs. If we
> > introduce a preferred LLC priority list, logic to prevent task
> > bouncing between different preferred LLCs might be needed in
> > load balancing, which could become complicated.=20
>=20
> It doesn't really become more difficult to tell preferred LLC from
> non-preferred LLC with a asm. So why should things get more complicatd?
>=20

For secondary and maybe tertiary LLCs to work well, the
ordering of the occupancy between the LLCs have to be
relatively stable. Or else we could have many
tasks migration between the LLCs when the ordering change.
Frequent task migrations could be worse for performance.

From previous experiments, we saw that the occupancy could
have some fairly big fluctuations.  That's the reason=C2=A0
we set the preferred LLC threshold to be high (2x).
We want to be sure before jerking tasks around to a new LLC.

With the secondary, tertiary LLCs, LLC ordering would change
more frequently than having just a single preferred LLC.
The secondary and tertiary LLCs have fewer tasks/mm and
occupancy could fluctuate more.
One concern is this could lead to extra task migrations
that could negate any cache consolidation benefits gained.

Tim

>=20
> Anyway, it was just one of the 'random' ideas I had kicking about.
> Reality always ruins things, *shrug* :-)

