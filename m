Return-Path: <linux-kernel+bounces-796774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FDA7B40705
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 16:36:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D66B1B6043C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 14:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD3D9324B1E;
	Tue,  2 Sep 2025 14:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iq1MNYhZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15BB2314B82
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 14:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756823594; cv=none; b=fEDhu7oUfIDWvoijkuoB/w4/O08OiuIsDPLyw5dug09PZ/9QoQj041jNn1GrjsBpqZzkttxoDr32mSECbtT0h/rdMVaZH4X0Z4+P2KUwBmFUld9lcvYWBfPaqAJwNh5rluBd9MEhUjG8lb32WlM3gx/tH3uNHwAS09QN91J+U5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756823594; c=relaxed/simple;
	bh=tNlTZRMk9cfEFZgxMF0Jg6O3ggSosuJWQym6OxjCUwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OBum0O9f5YMSrlSzfjX0KruImAvF0eX395CDNAx+/QJQWBk9Kem+yHlnlF3bNA+ORMLwOEALwseGyxBZMJMVdn78h259zm+kjARoBMuDnq1l6u8Td+mykQSVT4mJnB08FbeE1O/1V13cAXNvH8UqfcRjwgCMOYGBD2S0uemzy/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iq1MNYhZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BAC1C4CEED;
	Tue,  2 Sep 2025 14:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756823591;
	bh=tNlTZRMk9cfEFZgxMF0Jg6O3ggSosuJWQym6OxjCUwM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Iq1MNYhZxvpK5n3aXgMxR4URkBMwxYJdPAB9p543QjuLuvjl6qCOIZgEck4p0DrfX
	 u/+/Rsydp6Xf9kH9SEkabCcQDu8m9aP9cRQmKUG04jeglKFMOih6/sdetBRImCcXmY
	 DyNfHIJc2Wz+/xfcNwbsnF0YwaydKSuMYJssbNtahwqgEGI7uUBbwnghczKKG0n62B
	 wg2m5eHbuE4N7XUeSFbUhqTLaKNeHQIc0UFIOKjOOJfWWE195TMQa0IzBnkfet2aqo
	 nfzswoPlob02q9prs2fkklTbE36PxH1LGdj5Nggkvd2jJmZl9KiBo3b6j557bDGcTT
	 u5XSOG8xITa+g==
Date: Tue, 2 Sep 2025 16:33:08 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v10 7/8] cgroup/cpuset: Fail if isolated and nohz_full
 don't leave any housekeeping
Message-ID: <aLcAJCgiiauFvuP3@localhost.localdomain>
References: <20250806093855.86469-1-gmonaco@redhat.com>
 <20250806093855.86469-8-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250806093855.86469-8-gmonaco@redhat.com>

Le Wed, Aug 06, 2025 at 11:38:54AM +0200, Gabriele Monaco a écrit :
> Currently the user can set up isolated cpus via cpuset and nohz_full in
> such a way that leaves no housekeeping CPU (i.e. no CPU that is neither
> domain isolated nor nohz full). This can be a problem for other
> subsystems (e.g. the timer wheel imgration).
> 
> Prevent this configuration by blocking any assignation that would cause
> the union of domain isolated cpus and nohz_full to covers all CPUs.
> 
> Acked-by: Frederic Weisbecker <frederic@kernel.org>
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
> ---
>  kernel/cgroup/cpuset.c | 57 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 57 insertions(+)
> 
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 6e3f44ffaa21..7b66ccedbc53 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -1275,6 +1275,19 @@ static void isolated_cpus_update(int old_prs, int new_prs, struct cpumask *xcpus
>  		cpumask_andnot(isolated_cpus, isolated_cpus, xcpus);
>  }
>  
> +/*
> + * isolated_cpus_should_update - Returns if the isolated_cpus mask needs update
> + * @prs: new or old partition_root_state
> + * @parent: parent cpuset
> + * Return: true if isolated_cpus needs modification, false otherwise
> + */
> +static bool isolated_cpus_should_update(int prs, struct cpuset *parent)
> +{
> +	if (!parent)
> +		parent = &top_cpuset;
> +	return prs != parent->partition_root_state;
> +}
> +
>  /*
>   * partition_xcpus_add - Add new exclusive CPUs to partition
>   * @new_prs: new partition_root_state
> @@ -1339,6 +1352,36 @@ static bool partition_xcpus_del(int old_prs, struct cpuset *parent,
>  	return isolcpus_updated;
>  }
>  
> +/*
> + * isolcpus_nohz_conflict - check for isolated & nohz_full conflicts
> + * @new_cpus: cpu mask for cpus that are going to be isolated
> + * Return: true if there is conflict, false otherwise
> + *
> + * If nohz_full is enabled and we have isolated CPUs, their combination must
> + * still leave housekeeping CPUs.
> + */
> +static bool isolcpus_nohz_conflict(struct cpumask *new_cpus)
> +{
> +	cpumask_var_t full_hk_cpus;
> +	int res = false;
> +
> +	if (!housekeeping_enabled(HK_TYPE_KERNEL_NOISE))
> +		return false;
> +
> +	if (!alloc_cpumask_var(&full_hk_cpus, GFP_KERNEL))
> +		return true;
> +
> +	cpumask_and(full_hk_cpus, housekeeping_cpumask(HK_TYPE_KERNEL_NOISE),
> +		    housekeeping_cpumask(HK_TYPE_DOMAIN));
> +	cpumask_andnot(full_hk_cpus, full_hk_cpus, isolated_cpus);
> +	cpumask_and(full_hk_cpus, full_hk_cpus, cpu_online_mask);
> +	if (!cpumask_weight_andnot(full_hk_cpus, new_cpus))
> +		res = true;
> +
> +	free_cpumask_var(full_hk_cpus);
> +	return res;
> +}
> +
>  static void update_exclusion_cpumasks(bool isolcpus_updated)
>  {
>  	int ret;
> @@ -1464,6 +1507,9 @@ static int remote_partition_enable(struct cpuset *cs, int new_prs,
>  	if (!cpumask_intersects(tmp->new_cpus, cpu_active_mask) ||
>  	    cpumask_subset(top_cpuset.effective_cpus, tmp->new_cpus))
>  		return PERR_INVCPUS;
> +	if (isolated_cpus_should_update(new_prs, NULL) &&
> +	    isolcpus_nohz_conflict(tmp->new_cpus))

If you resend this patchset, can you rename isolcpus_nohz_conflict() to
isolated_cpus_can_update(). I intend to put more conditions in there
that are not related to nohz, also this aligns with
"isolated_cpus_should_update()" name.

Thanks!

-- 
Frederic Weisbecker
SUSE Labs

