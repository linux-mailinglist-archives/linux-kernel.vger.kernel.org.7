Return-Path: <linux-kernel+bounces-873956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FFACC15273
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 15:26:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4D7DC4FB8F6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 14:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0B473090E1;
	Tue, 28 Oct 2025 14:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="DIEi4VDS"
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9231F75A6
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 14:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.143.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761661511; cv=none; b=cSX7xST4iaN27SsHYZkXeBbK6729j/qzbVlo81aYDNXMRR44rTJW6fc5jhlIBEelBtzCTzwb/JQgdeFe+hP+0uDE2WIOJgbNpr+lTDnF+alSc2ad0aDgR8XL/A0YmXiWU9+QFA51WjF8rh6PoJ53FZkipNYHc2nCdEDIOHI0jw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761661511; c=relaxed/simple;
	bh=hLjUxTlZhaH/jOTEpoOH7n3av5Ff8/w5Xxi7cNXYjzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FnGoKuj0pRnsE31422DjKAqcMnFK1pMRVrlvBbv5aW2U6O/c9sl1aMcPfESgCIH5QcES47/r6KVL7gpbx0jkxy6PxWJO3Xc8hFQoNNHDbCF6qrMZ2DdZt99V6H9CHezoqREwfABjh3aeyNi7KA5vqxORkOPh9ArdgkFC01qF9Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=DIEi4VDS; arc=none smtp.client-ip=148.163.143.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0134425.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59S9mYfk028670;
	Tue, 28 Oct 2025 14:24:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pps0720; bh=fVC4ZyP8q2Jt4Ik8l1xUffGSGb
	3hQcuSxi1g5xEq4H8=; b=DIEi4VDSzzubXi89noEeoJA8SdaYL8iGBAy+ojRK+X
	zQM25g0ylYhv8lHjey9wpmWC7xSb8p7GE5aQN8H63rEc4SDs13vLhO5I+ZImp6tO
	+B/Gz61CjTSnh3+5U084UfD3Nlepx7B6YDWv9Z/9X2QVWcEY8UEvBjBZHpWdOPel
	rdN6DkU44zMd+R+QjXEHSSHbfcbytOyQY6ZmrmEF5v7whWzp6Z5qXdSXM6jkqtA5
	oXcNKN8V3cxTCCKXpNmpIqfg86DJyknJ5IJea8kXUowkIEltYEHfbwR3zqeZcSXt
	jthnIZJI8KYoB3CLtZ3Tu8v7XO4Ohx0+Y3EJeCmbtj+A==
Received: from p1lg14878.it.hpe.com (p1lg14878.it.hpe.com [16.230.97.204])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 4a28jeuhxa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Oct 2025 14:24:54 +0000 (GMT)
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14878.it.hpe.com (Postfix) with ESMTPS id C2A6C130E3;
	Tue, 28 Oct 2025 14:24:53 +0000 (UTC)
Received: from swahl-home.5wahls.com (unknown [16.231.227.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTPS id 039A38014F9;
	Tue, 28 Oct 2025 14:24:52 +0000 (UTC)
Date: Tue, 28 Oct 2025 09:24:51 -0500
From: Steve Wahl <steve.wahl@hpe.com>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: Steve Wahl <steve.wahl@hpe.com>, Russ Anderson <rja@hpe.com>,
        Dimitri Sivanich <sivanich@hpe.com>, Kyle Meyer <kyle.meyer@hpe.com>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tick/sched: Limit non-timekeeper CPUs calling jiffies
 update
Message-ID: <aQDSMxKDr85kPCJJ@swahl-home.5wahls.com>
References: <20251027183456.343407-1-steve.wahl@hpe.com>
 <bfa0a61e-7cb8-4bdd-b913-1bf241f316c7@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bfa0a61e-7cb8-4bdd-b913-1bf241f316c7@linux.ibm.com>
X-Proofpoint-GUID: SrVKyEshYSkjF23KlGyw7PoncmRoZ2KL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI3MDExNCBTYWx0ZWRfX3l/u/hAFp1x6
 Da5Vjdl+XiHS6HUUVAsNSxRPbCWHrhF/L9AMcXN831hHGnl08uG2oEwv7Q0r83fh25N89liX5Em
 Qq/8EPHe5zeQ44Y45BZ3H+1zZ4MnO/we+bSMvyjtPA5eYRYAaZMs3a/dzNJ8zNeU4INdZFA1Hmj
 l3DcvokylSe09Eyw8tPNcPuIAxsQg2FKHAyI48dcUCZgaID1/DSdqBnu33DA5OcQ/I+zhCXGbsC
 xlkgho9mloGehrVk8uXvEkKkzlYQ/Jit8bkvtSu0o9nmvxPSewfLGvvBCyp1H0JoFzVz6PiJh9R
 jDYJ2Spxzl2LX1mlLe7/ggaC9BWZ2wccy0G60HbEYEF3vKtOJTnnNTZtT4pSdQ97p8MSY7cAucd
 YL6sn34akVAIzfG4S9KesidnuhQ2Pw==
X-Authority-Analysis: v=2.4 cv=DLOCIiNb c=1 sm=1 tr=0 ts=6900d236 cx=c_pps
 a=UObrlqRbTUrrdMEdGJ+KZA==:117 a=UObrlqRbTUrrdMEdGJ+KZA==:17
 a=kj9zAlcOel0A:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=MvuuwTCpAAAA:8 a=VnNF1IyMAAAA:8 a=rZGjQiiclJUFgjU9IJsA:9
 a=CjuIK1q_8ugA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: SrVKyEshYSkjF23KlGyw7PoncmRoZ2KL
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_05,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 malwarescore=0 impostorscore=0
 adultscore=0 clxscore=1011 phishscore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510270114

On Tue, Oct 28, 2025 at 11:39:30AM +0530, Shrikanth Hegde wrote:
> 
> 
> On 10/28/25 12:04 AM, Steve Wahl wrote:
> > On large NUMA systems, while running a test program that saturates the
> > inter-processor and inter-NUMA links, acquiring the jiffies_lock can
> > be very expensive.  If the cpu designated to do jiffies updates
> > (tick_do_timer_cpu) gets delayed and other cpus decide to do the
> > jiffies update themselves, a large number of them decide to do so at
> > the same time.  The inexpensive check against tick_next_period is far
> > quicker than actually acquiring the lock, so most of these get in line
> > to obtain the lock.  If obtaining the lock is slow enough, this
> > spirals into the vast majority of CPUs continuously being stuck
> > waiting for this lock, just to obtain it and find out that time has
> > already been updated by another cpu. For example, on one random entry
> > to kdb by manually-injected NMI, I saw 2912 of 3840 cpus stuck here.
> > 
> > To avoid this, allow only one non-timekeeper CPU to call
> > tick_do_update_jiffies64() at any given time, resetting ts->stalled
> > jiffies only if the jiffies update function is actually called.
> > 
> > With this change, manually interrupting the test I find at most two
> > CPUs in the tick_do_update_jiffies64 function (the timekeeper and one
> > other).
> > 
> > Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
> > ---
> > 
> > v2: Rewritten to use an atomic to gate non-timekeeping cpus calling the
> >      jiffies update, as suggested by tglx. Title of patch has changed
> >      since trylock is no longer used.
> > 
> > v1 discussion:
> > https://lore.kernel.org/all/20251013150959.298288-1-steve.wahl@hpe.com/
> > 
> >   kernel/time/tick-sched.c | 30 ++++++++++++++++++++++++++----
> >   1 file changed, 26 insertions(+), 4 deletions(-)
> > 
> > diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
> > index c527b421c865..3ff3eb1f90d0 100644
> > --- a/kernel/time/tick-sched.c
> > +++ b/kernel/time/tick-sched.c
> > @@ -201,6 +201,27 @@ static inline void tick_sched_flag_clear(struct tick_sched *ts,
> >   	ts->flags &= ~flag;
> >   }
> > +/*
> > + * Allow only one non-timekeeper CPU at a time update jiffies from
> > + * the timer tick.
> > + *
> > + * Returns true if update was run.
> > + */
> > +static bool tick_limited_update_jiffies64(struct tick_sched *ts, ktime_t now)
> > +{
> > +	static atomic_t in_progress;
> > +	int inp;
> > +
> > +	inp = atomic_read(&in_progress);
> > +	if (inp || !atomic_try_cmpxchg(&in_progress, &inp, 1))
> > +		return false;
> > +
> 
> You come here if (ts->last_tick_jiffies == jiffies). So it may be not necessary to check again.

TGLX had this in his rewrite suggestion, and I looked pretty intensely
at this test.

The situation I'm looking to resolve is caused by inter-NUMA links
being abnormally swamped with traffic.  Especially for writes, access
to shared memory locations, such as the atomic operations to
in_progress right above this, take longer than one usually would
expect.  So to me it makes sense that things may have changed since
the atomic_try_cmpxchg was initiated, and so I left the check in
place.

> > +	if (ts->last_tick_jiffies == jiffies)
> > +		tick_do_update_jiffies64(now);
> > +	atomic_set(&in_progress, 0);
> > +	return true;
> > +}
> > +
> >   #define MAX_STALLED_JIFFIES 5
> >   static void tick_sched_do_timer(struct tick_sched *ts, ktime_t now)
> > @@ -239,10 +260,11 @@ static void tick_sched_do_timer(struct tick_sched *ts, ktime_t now)
> >   		ts->stalled_jiffies = 0;
> >   		ts->last_tick_jiffies = READ_ONCE(jiffies);
> >   	} else {
> > -		if (++ts->stalled_jiffies == MAX_STALLED_JIFFIES) {
> > -			tick_do_update_jiffies64(now);
> > -			ts->stalled_jiffies = 0;
> > -			ts->last_tick_jiffies = READ_ONCE(jiffies);
> > +		if (++ts->stalled_jiffies >= MAX_STALLED_JIFFIES) {
> > +			if (tick_limited_update_jiffies64(ts, now)) {
> > +				ts->stalled_jiffies = 0;
> > +				ts->last_tick_jiffies = READ_ONCE(jiffies);
> > +			}
> >   		}
> >   	}
> 
> 
> Yes. This could help large systems.
> 
> Acked-by: Shrikanth Hegde <sshegde@linux.ibm.com>

Thanks for your time reviewing!

--> Steve Wahl

-- 
Steve Wahl, Hewlett Packard Enterprise

