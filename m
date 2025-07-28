Return-Path: <linux-kernel+bounces-748261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 867CEB13EB3
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 17:37:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAD6C18941C8
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 15:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 925C72741B3;
	Mon, 28 Jul 2025 15:34:41 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 402992741C0
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 15:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753716881; cv=none; b=gdkI7fsxPgFTRKjPUeyKBOCsrX6eC/kON2wLgH5bEmCqx+jmKenMjaxc4Xq6V7NBxgu8zR4qy3sBjCJPtLKWj0EUlqxbd892bYWivm1Pynv2B6fOYe4ct9HHZn4+lzo6Yc/h8kGlffS7nc8ec+MhFC5N9sWCwq/1gTY4B+QL3cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753716881; c=relaxed/simple;
	bh=FPjXGjoh1/67nk6gDcHnawKbg4fEreeXUAwAcP+ctpw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DD2GxWW0IQt6I3xJIxVifmdDkA1AjN60JdBW5+pTCQacjLE3e0OTHrHVUPo0lwwn1JBhXH75uJAKUG/uJdupZa22+BlzhO3sBfYLGPXJ6ZfatcH9NJQ+EL7J4blDTj/ptHlfsDLOmCmO5Sjr0VIULcamKF172CVCOGlL6F2B2Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0789B152B;
	Mon, 28 Jul 2025 08:34:28 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.59])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AB3323F66E;
	Mon, 28 Jul 2025 08:34:32 -0700 (PDT)
Date: Mon, 28 Jul 2025 16:34:27 +0100
From: Dave Martin <Dave.Martin@arm.com>
To: Ben Horgan <ben.horgan@arm.com>
Cc: James Morse <james.morse@arm.com>, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, Rob Herring <robh@kernel.org>,
	Rohit Mathew <rohit.mathew@arm.com>,
	Shanker Donthineni <sdonthineni@nvidia.com>,
	Zeng Heng <zengheng4@huawei.com>,
	Lecopzer Chen <lecopzerc@nvidia.com>,
	Carl Worth <carl@os.amperecomputing.com>,
	shameerali.kolothum.thodi@huawei.com,
	D Scott Phillips OS <scott@os.amperecomputing.com>,
	lcherian@marvell.com, bobo.shaobowang@huawei.com,
	tan.shaopeng@fujitsu.com, baolin.wang@linux.alibaba.com,
	Jamie Iles <quic_jiles@quicinc.com>,
	Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
	dfustini@baylibre.com, amitsinght@marvell.com,
	David Hildenbrand <david@redhat.com>,
	Rex Nie <rex.nie@jaguarmicro.com>, Koba Ko <kobak@nvidia.com>
Subject: Re: [RFC PATCH 27/36] arm_mpam: Allow configuration to be applied
 and restored during cpu online
Message-ID: <aIeYgxJf9EASA5Zs@e133380.arm.com>
References: <20250711183648.30766-1-james.morse@arm.com>
 <20250711183648.30766-28-james.morse@arm.com>
 <7ab40c09-3922-4e0c-85dd-00ff05be4ce6@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7ab40c09-3922-4e0c-85dd-00ff05be4ce6@arm.com>

Hi,

On Mon, Jul 28, 2025 at 12:59:12PM +0100, Ben Horgan wrote:
> Hi James,
> 
> On 7/11/25 19:36, James Morse wrote:
> > When CPUs come online the original configuration should be restored.
> > Once the maximum partid is known, allocate an configuration array for
> > each component, and reprogram each RIS configuration from this.
> > 
> > The MPAM spec describes how multiple controls can interact. To prevent
> > this happening by accident, always reset controls that don't have a
> > valid configuration. This allows the same helper to be used for
> > configuration and reset.
> > 
> > CC: Dave Martin <Dave.Martin@arm.com>
> > Signed-off-by: James Morse <james.morse@arm.com>
> > ---
> >   drivers/platform/arm64/mpam/mpam_devices.c  | 236 ++++++++++++++++++--
> >   drivers/platform/arm64/mpam/mpam_internal.h |  26 ++-
> >   2 files changed, 234 insertions(+), 28 deletions(-)
> > 
> > diff --git a/drivers/platform/arm64/mpam/mpam_devices.c b/drivers/platform/arm64/mpam/mpam_devices.c
> > index bb3695eb84e9..f3ecfda265d2 100644
> > --- a/drivers/platform/arm64/mpam/mpam_devices.c
> > +++ b/drivers/platform/arm64/mpam/mpam_devices.c

[...]

> > @@ -1000,10 +1041,38 @@ static void mpam_reset_msc(struct mpam_msc *msc, bool online)

[...]

> > +static void mpam_reprogram_msc(struct mpam_msc *msc)
> > +{
> > +	int idx;
> > +	u16 partid;
> > +	bool reset;
> > +	struct mpam_config *cfg;
> > +	struct mpam_msc_ris *ris;
> > +
> > +	idx = srcu_read_lock(&mpam_srcu);
> > +	list_for_each_entry_rcu(ris, &msc->ris, msc_list) {
> > +		if (!mpam_is_enabled() && !ris->in_reset_state) {
> > +			mpam_touch_msc(msc, &mpam_reset_ris, ris);
> > +			ris->in_reset_state = true;
> > +			continue;
> > +		}
> > +
> > +		reset = true;
> > +		for (partid = 0; partid <= mpam_partid_max; partid++) {

> Do we need to consider 'partid_max_lock' here?

Just throwing in my 2¢, since I'd dug into this a bit previously:

Here, we are resetting an MSC or re-onlining a CPU.  Either way, I
think that this only happens after the initial probing phase is
complete.

mpam_enable_once() is ordered with respect to the task that did the
final unlock of partid_max_lock during probing, by means of the
schedule_work() call.  (See <linux/workqueue.h>.)

Taking the hotplug lock and installing mpam_cpu_online() for CPU
hotplug probably brings a sufficient guarantee also (though I've not
dug into it).

This function doesn't seem to be called during the probing phase (via
mpam_discovery_cpu_online()), so there shouldn't be any racing updates
to the global variables here.

> > +			cfg = &ris->vmsc->comp->cfg[partid];
> > +			if (cfg->features)
> > +				reset = false;
> > +
> > +			mpam_reprogram_ris_partid(ris, partid, cfg);
> > +		}
> > +		ris->in_reset_state = reset;
> > +	}
> > +	srcu_read_unlock(&mpam_srcu, idx);
> > +}

[...]

> > @@ -1806,6 +1875,43 @@ static void mpam_unregister_irqs(void)

[...]

> > +static int __allocate_component_cfg(struct mpam_component *comp)
> > +{
> > +	if (comp->cfg)
> > +		return 0;
> > +
> > +	comp->cfg = kcalloc(mpam_partid_max + 1, sizeof(*comp->cfg), GFP_KERNEL);

> And here?

Similarly, this runs only in the mpam_enable_once() call.

[...]

> > @@ -1861,6 +1976,8 @@ static void mpam_reset_component_locked(struct mpam_component *comp)
> >   	might_sleep();
> >   	lockdep_assert_cpus_held();
> > +	memset(comp->cfg, 0, (mpam_partid_max * sizeof(*comp->cfg)));

> And here?

Similarly to mpam_reset_msc(), I think this probably only runs from
mpam_enable_once() or mpam_cpu_online().

I think most or all of the existing reads of the affected globals from
within mpam_resctrl.c are also callbacks from resctrl_init(), which
again exceutes during mpam_enable_once() (though I won't promise I
haven't missed one or two).

Once resctrl has fired up, I believe that the MPAM driver basically
trusts the IDs coming in from resctrl, and doesn't need to range-check
them against the global parameters again.

[...]

> Thanks,
> 
> Ben

I consciously haven't done all the homework on this.

Although it may look like the globals are read all over the place after
probing, I think this actually only happens during resctrl initialision
(which is basically single-threaded).

The only place where they are read after probing and without mediation
via resctrl is on the CPU hotplug path.

Adding locking would ensure that an unstable value is never read, but
this is not sufficient by itself to sure that the _final_ value of a
variable is read (for some definition of "final").  And, if there is a
well-defined notion of final value and there is sufficient
synchronisation to ensure that this is the value read by a particular
read, then by construction an unstable value cannot be read.


I think that this kind of pattern is not that uncommon in the kernel,
though it is a bit painful to reason about.

Cheers
---Dave

