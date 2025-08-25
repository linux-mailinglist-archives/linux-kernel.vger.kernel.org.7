Return-Path: <linux-kernel+bounces-785555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 312C4B34DAC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 23:09:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDD9920849D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 21:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37EDE296BDF;
	Mon, 25 Aug 2025 21:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VEkrqiTQ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E31E28F1
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 21:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756156178; cv=none; b=f2/+L6u+ZvsfxXtWyNIfEVfDCashNN23rmkhmrghHGeHeIJtfSZ3IF4Lw8ktF5ArAI0Gu/wXqnJitrM7KejaQeYUvLyu4xSUmcYsoSRSpNDor0HLsNGS+XyrYfQqrCTE703BP/ruv3BPsZnAE56fJT6+AYCBE2lcK2eHGGVExIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756156178; c=relaxed/simple;
	bh=HAMhl5qMyU/2Ke1ibSr/6YLaYUAd2cOM5EaILjQjITs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QMWCe72uullHcTJV0BTfdbsq/+TpLkxyR2X0fYMEDxH+2FoP/wwMt7AFabaNbeu9yyQUvUcJoFHOS6a8ePwB+Al4MDTaqPHcsDOUMadCA80DRe49x7wFcGIOBUWIOJ6QSZWrmDJPkYr3MWNNYKMU29Cl54xppFx09HeRb7iIHlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VEkrqiTQ; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756156176; x=1787692176;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=HAMhl5qMyU/2Ke1ibSr/6YLaYUAd2cOM5EaILjQjITs=;
  b=VEkrqiTQd2lmC4v8HbEBp+jDwnUFJVa5+WDSEx8cUAE5Amih1Ez8tmRC
   fYPiWP2u+QXa+t8qteyRi58HldaQ8wQp3LWvYiZIHSyV5ALH1XQemB4rc
   65SdEpeT1QrHh06zCRK7Y6yNk2sophMkDJEG/tPtB0lm43UM7YuvHRqB4
   vAJsZpCsO66ei5Qv/cKdjZZs5qp0waeQHHHQl92ONNQORNzd49o6uxLbC
   7D0eauzipaLnOo4nmvpe0kkAOGGrO+JD5emIXSJi/YdI7goA5+dVe6PeB
   gkJJpHTvUrKUNqznrouNenUU9gelvrTPiwkq/0BZu4Q+kmK/NIPgTqkmm
   A==;
X-CSE-ConnectionGUID: LVc4CicHSR+1lLF3d0Jf3A==
X-CSE-MsgGUID: KAaM1AlCSaiBekPx505Myg==
X-IronPort-AV: E=McAfee;i="6800,10657,11533"; a="58526787"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="58526787"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2025 14:09:36 -0700
X-CSE-ConnectionGUID: th+dDh2gRuufggLajoXo8w==
X-CSE-MsgGUID: O6klx9dMSWqRVoXUhlUSLg==
X-ExtLoop1: 1
Received: from schen9-mobl2.jf.intel.com (HELO [10.98.24.137]) ([10.98.24.137])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2025 14:09:35 -0700
Message-ID: <59409890a5760e659f8e0ee1fb931ad37d2bc621.camel@linux.intel.com>
Subject: Re: [PATCH 1/2] sched: topology: Fix topology validation error
From: Tim Chen <tim.c.chen@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Vinicius Costa Gomes
 <vinicius.gomes@intel.com>, Juri Lelli <juri.lelli@redhat.com>, Dietmar
 Eggemann <dietmar.eggemann@arm.com>, Ben Segall <bsegall@google.com>, Mel
 Gorman <mgorman@suse.de>,  Valentin Schneider <vschneid@redhat.com>, Tim
 Chen <tim.c.chen@intel.com>, Vincent Guittot <vincent.guittot@linaro.org>,
 Libo Chen <libo.chen@oracle.com>, Abel Wu <wuyun.abel@bytedance.com>, Len
 Brown <len.brown@intel.com>,  linux-kernel@vger.kernel.org, Chen Yu
 <yu.c.chen@intel.com>, K Prateek Nayak <kprateek.nayak@amd.com>, "Gautham R
 . Shenoy" <gautham.shenoy@amd.com>,  Zhao Liu <zhao1.liu@intel.com>
Date: Mon, 25 Aug 2025 14:09:34 -0700
In-Reply-To: <20250825072538.GP3245006@noisy.programming.kicks-ass.net>
References: <cover.1755893468.git.tim.c.chen@linux.intel.com>
	 <a3de98387abad28592e6ab591f3ff6107fe01dc1.1755893468.git.tim.c.chen@linux.intel.com>
	 <20250825072538.GP3245006@noisy.programming.kicks-ass.net>
Autocrypt: addr=tim.c.chen@linux.intel.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-08-25 at 09:25 +0200, Peter Zijlstra wrote:
> On Fri, Aug 22, 2025 at 01:14:14PM -0700, Tim Chen wrote:
> > From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> >=20
> > As sd_numa_mask() (the function behind tl->mask() for the NUMA levels
> > of the topology) depends on the value of sched_domains_curr_level,
> > it's possible to be iterating over a level while, sd_numa_mask()
> > thinks we are in another, causing the topology validation to fail (for
> > valid cases).
> >=20
> > Set sched_domains_curr_level to the current topology level while
> > iterating.
> >=20
> > Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> > Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
> > ---
> >  kernel/sched/topology.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >=20
> > diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> > index 977e133bb8a4..9a7ac67e3d63 100644
> > --- a/kernel/sched/topology.c
> > +++ b/kernel/sched/topology.c
> > @@ -2394,6 +2394,14 @@ static bool topology_span_sane(const struct cpum=
ask *cpu_map)
> >  	for_each_sd_topology(tl) {
> >  		int tl_common_flags =3D 0;
> > =20
> > +#ifdef CONFIG_NUMA
> > +		/*
> > +		 * sd_numa_mask() (one of the possible values of
> > +		 * tl->mask()) depends on the current level to work
> > +		 * correctly.
> > +		 */
>=20
> This is propagating that ugly hack from sd_init(), isn't it. Except its
> pretending like its sane code... And for what?

How about the following fix for the CONFIG_NUMA case?  Will this be more sa=
ne?=20

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index b958fe48e020..a92457fed135 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1758,7 +1758,7 @@ static struct sched_domain_topology_level *sched_doma=
in_topology =3D
 static struct sched_domain_topology_level *sched_domain_topology_saved;
=20
 #define for_each_sd_topology(tl)                       \
-       for (tl =3D sched_domain_topology; tl->mask; tl++)
+       for (tl =3D sched_domain_topology; tl->mask; ++tl, sched_domains_cu=
rr_level =3D tl->numa_level)
=20
 void __init set_sched_topology(struct sched_domain_topology_level *tl)
 {


>=20
> > +		sched_domains_curr_level =3D tl->numa_level;
> > +#endif
> >  		if (tl->sd_flags)
> >  			tl_common_flags =3D (*tl->sd_flags)();
> > =20
> 		if (tl_common_flags & SD_NUMA)
> 			continue;
>=20
> So how does this make any difference ?
>=20
> We should never get to calling tl->mask() for NUMA.
>=20

True.  I think we originally was fixing the v6.16 case which
wasn't checking for the SD_NUMA flag.  Overlooked that when we ported
the fix.

That said, I think that the for_each_sd_topology() macro needs to have
sched_domains_curr_level updated to prevent future problems.

Tim



