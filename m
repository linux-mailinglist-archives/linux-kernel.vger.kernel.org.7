Return-Path: <linux-kernel+bounces-890820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62CE5C410B0
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 18:28:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BD653A673E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 17:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12C3A33506B;
	Fri,  7 Nov 2025 17:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ENt+Q3ms"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5953632C932
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 17:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762536514; cv=none; b=q6uj4EO+g7cOlDTYLzgOwuUavo0+/9s6GVmxPIRPP6xkIfEkJgnsksqp4bFNKmjITWCngtcECd5zU2WpsDFzwiK6p5TGflKfd3P66X25P05etdfFnlLxGPw58h1sTSFyElqA6ZXOsZilODRwhB6mKjwnUOGE0uYutVQpv9vNs58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762536514; c=relaxed/simple;
	bh=z/QEnIMl45eQb8QF7NpwI5CMxN8XtIIGZiVALUbCyno=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sGA6ikfx7bFlE5qi7B0zK+IMatfQTXKi/nf4muiByY5WsuFghawNUHMKzlHnVxMEOQ4a3zHH7OnpgL2MsWCqR/LEJBvId75szsL25TRvgpSnNwIj3WNcnFfEJkf2FRXHMo0FgqaA5LLzE9s3iE1glD44faSfuoqcym+BvcgdZeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ENt+Q3ms; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762536513; x=1794072513;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=z/QEnIMl45eQb8QF7NpwI5CMxN8XtIIGZiVALUbCyno=;
  b=ENt+Q3msEgPcI43NbYtaINByj4sXMejv0OBy8V079Z3n504bstQNvf/l
   de9WS1INimb5DTUaJfPji9A2RrVcN45usDnxEWt7DuHlFNpwyjfSh/IUA
   d5NiH6X/4bYR6oANYFShLjGhqSi+m3rC9CAH7IjfWeDa/8wn5QdwEPuMx
   NALSF7e8LGFf4/y/ormyWFCDWkodq4iId7dW6BAz7JRDI+/1BoYfRcFKs
   P7d169n164IMgd1ezzcCS6a2dGrPIYLwyG9sJ6oOOJNQ8mpiZMK1w2TjY
   vGUfTMohiwBSxB8OEVC4L7Ff9vP2z8F6ghH8djQKANApTwxB22yon6F5o
   A==;
X-CSE-ConnectionGUID: gwmtq0COTp+BkO3rH5Eb5A==
X-CSE-MsgGUID: 3NNge/pCSBCTq50LyKe2kQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11606"; a="87319907"
X-IronPort-AV: E=Sophos;i="6.19,287,1754982000"; 
   d="scan'208";a="87319907"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2025 09:28:32 -0800
X-CSE-ConnectionGUID: vX9nHQcPQsaKyjY+2H5oEA==
X-CSE-MsgGUID: LZp/I18fRKKk9mgNW1aJFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,287,1754982000"; 
   d="scan'208";a="187389989"
Received: from schen9-mobl4.amr.corp.intel.com (HELO [10.125.111.129]) ([10.125.111.129])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2025 09:28:32 -0800
Message-ID: <5d18148c47cda4fca9f970e0cf520b997abdce8d.camel@linux.intel.com>
Subject: Re: [PATCH v3] sched/fair: Skip sched_balance_running cmpxchg when
 balance is not due
From: Tim Chen <tim.c.chen@linux.intel.com>
To: K Prateek Nayak <kprateek.nayak@amd.com>, Peter Zijlstra
	 <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>, Chen Yu <yu.c.chen@intel.com>, Doug
 Nelson	 <doug.nelson@intel.com>, Mohini Narkhede
 <mohini.narkhede@intel.com>, 	linux-kernel@vger.kernel.org, Vincent Guittot
 <vincent.guittot@linaro.org>,  Shrikanth Hegde <sshegde@linux.ibm.com>
Date: Fri, 07 Nov 2025 09:28:31 -0800
In-Reply-To: <1d6c22aa-c882-4833-b0be-a3999d684885@amd.com>
References: 
	<52fcd1e8582a6b014a70f0ce7795ce0d88cd63a8.1762470554.git.tim.c.chen@linux.intel.com>
	 <1d6c22aa-c882-4833-b0be-a3999d684885@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-11-07 at 08:27 +0530, K Prateek Nayak wrote:
> Hello Tim,
>=20
> On 11/7/2025 4:57 AM, Tim Chen wrote:
> > @@ -11757,6 +11772,7 @@ static int sched_balance_rq(int this_cpu, struc=
t rq *this_rq,
> >  		.fbq_type	=3D all,
> >  		.tasks		=3D LIST_HEAD_INIT(env.tasks),
> >  	};
> > +	int need_unlock =3D false;
> > =20
> >  	cpumask_and(cpus, sched_domain_span(sd), cpu_active_mask);
> > =20
> > @@ -11768,6 +11784,13 @@ static int sched_balance_rq(int this_cpu, stru=
ct rq *this_rq,
> >  		goto out_balanced;
> >  	}
> > =20
> > +	if (idle !=3D CPU_NEWLY_IDLE && (sd->flags & SD_SERIALIZE)) {
> > +		if (atomic_cmpxchg_acquire(&sched_balance_running, 0, 1)) {
> > +			goto out_balanced;
> > +		}
> > +		need_unlock =3D true;
> > +	}
> > +
> >  	group =3D sched_balance_find_src_group(&env);
> >  	if (!group) {
> >  		schedstat_inc(sd->lb_nobusyg[idle]);
> > @@ -11892,6 +11915,9 @@ static int sched_balance_rq(int this_cpu, struc=
t rq *this_rq,
> >  			if (!cpumask_subset(cpus, env.dst_grpmask)) {
> >  				env.loop =3D 0;
> >  				env.loop_break =3D SCHED_NR_MIGRATE_BREAK;
> > +				if (need_unlock)
> > +					atomic_set_release(&sched_balance_running, 0);
>=20
> I believe we should reset "need_unlock" to false here since "redo" can
> fail the atomic_cmpxchg_acquire() while still having "need_unlock" set
> to "true" and the "out_balanced" path will then perform the
> atomic_set_release() when another CPU is in middle of a busy / idle
> balance on a SD_SERIALIZE domain.

Makes sense.


>=20
> We can also initialize the "need_unlock" to false just after
> the redo label too - whichever you prefer.
>=20
> nit. "need_unlock" can just be a bool instead of an int.

Sure.

Tim
>=20
> Apart from that, feel free to include:
>=20
> Reviewed-by: K Prateek Nayak <kprateek.nayak@amd.com>
>=20
> > +
> >  				goto redo;
> >  			}
> >  			goto out_all_pinned;
> > @@ -12008,6 +12034,9 @@ static int sched_balance_rq(int this_cpu, struc=
t rq *this_rq,
> >  	    sd->balance_interval < sd->max_interval)
> >  		sd->balance_interval *=3D 2;
> >  out:
> > +	if (need_unlock)
> > +		atomic_set_release(&sched_balance_running, 0);
> > +
> >  	return ld_moved;
> >  }
> > =20

