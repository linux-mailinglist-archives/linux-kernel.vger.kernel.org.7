Return-Path: <linux-kernel+bounces-897618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3643AC5334A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 16:55:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6F6903561F6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 15:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33FFA33970D;
	Wed, 12 Nov 2025 15:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VYkHACNf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E532C0277
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 15:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762962345; cv=none; b=STpFOmdqkRjNAJNhM1Rw+gd/hsrBPnY5wAqiPS1EfW+EpFXaLKgGIVYge1uxpxT/wcIJYmOAD98WYKOJTOoWbMkF5OYpGKfvAuzVwCrP7LrS8EHaRLX/RcE5gitQl8ohIObsWRsvCyw28Sxk3wWoPJXaohozvydSsp6mKJlsOjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762962345; c=relaxed/simple;
	bh=fWzdt03epAh2bmGfOPbBWcrVtXBwXu7O11/dwAK+SiI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dUb/oMXTfPbk12d+EqFlYFvY1d4NRJo8CxAll47RHINlmPerJ1wLdExbBZ0FvSFuXX5/oBVQpaswTC+2XP+851hFDWcgUZfS/lNXkEkcYVhFs+n0Fte8gp0fanpPGFZvj7HKmPNy8ssTEDnL4UD8mUZdeFrDVfmc50yhRGJzJv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VYkHACNf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4AFAC19421;
	Wed, 12 Nov 2025 15:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762962345;
	bh=fWzdt03epAh2bmGfOPbBWcrVtXBwXu7O11/dwAK+SiI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VYkHACNfJ1ngpwGdfRFYHnm4iy+vKxU+8xN3k5Eb5ZbWEgcz5DypeaPesbwZFSMtS
	 mHscskwVjxVPH9NNTmVkM4u4GDUB8nNHv3nv5zSNTjP4SUOy64pXz95dSpLl62Cazd
	 bWTXEUhTb3cD72a5iFTd4Kohn7SvGB6J5H43VeIcItpI9cDMRQ2f775m42MKmJddsQ
	 s5HDX24Dtw5Xj6O+C9jD6IpSaL4+WRBbL9aGe2b2JvVgIp04mxcaQgOpYNuX/vpRJJ
	 b969oadgg5HW/uQWrR4exEft7aAurHkxqHD6tZpJWFWJAzTDW72hmUT4TRrWtOXZqI
	 p+hDROIpuLUxA==
Date: Wed, 12 Nov 2025 16:45:42 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Waiman Long <llong@redhat.com>
Subject: Re: [PATCH v14 1/7] timers: Rename tmigr 'online' bit to 'available'
Message-ID: <aRSrpgytUvrP6Res@localhost.localdomain>
References: <20251104104740.70512-1-gmonaco@redhat.com>
 <20251104104740.70512-2-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251104104740.70512-2-gmonaco@redhat.com>

Le Tue, Nov 04, 2025 at 11:47:33AM +0100, Gabriele Monaco a écrit :
> The timer migration hierarchy excludes offline CPUs via the
> tmigr_is_not_available function, which is essentially checking the
> online bit for the CPU.
> 
> Rename the online bit to available and all references in function names
> and tracepoint to generalise the concept of available CPUs.
> 
> Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
> ---
>  include/trace/events/timer_migration.h |  4 ++--
>  kernel/time/timer_migration.c          | 22 +++++++++++-----------
>  kernel/time/timer_migration.h          |  2 +-
>  3 files changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/include/trace/events/timer_migration.h b/include/trace/events/timer_migration.h
> index 47db5eaf2f9ab..61171b13c687c 100644
> --- a/include/trace/events/timer_migration.h
> +++ b/include/trace/events/timer_migration.h
> @@ -173,14 +173,14 @@ DEFINE_EVENT(tmigr_cpugroup, tmigr_cpu_active,
>  	TP_ARGS(tmc)
>  );
>  
> -DEFINE_EVENT(tmigr_cpugroup, tmigr_cpu_online,
> +DEFINE_EVENT(tmigr_cpugroup, tmigr_cpu_available,
>  
>  	TP_PROTO(struct tmigr_cpu *tmc),
>  
>  	TP_ARGS(tmc)
>  );
>  
> -DEFINE_EVENT(tmigr_cpugroup, tmigr_cpu_offline,
> +DEFINE_EVENT(tmigr_cpugroup, tmigr_cpu_unavailable,
>  
>  	TP_PROTO(struct tmigr_cpu *tmc),
>  
> diff --git a/kernel/time/timer_migration.c b/kernel/time/timer_migration.c
> index c0c54dc5314c3..78700f90944f0 100644
> --- a/kernel/time/timer_migration.c
> +++ b/kernel/time/timer_migration.c
> @@ -427,7 +427,7 @@ static DEFINE_PER_CPU(struct tmigr_cpu, tmigr_cpu);
>  
>  static inline bool tmigr_is_not_available(struct tmigr_cpu *tmc)
>  {
> -	return !(tmc->tmgroup && tmc->online);
> +	return !(tmc->tmgroup && tmc->available);

Please rebase and test your patchset on top of:

git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
	timers/core

There is one more "->online" field to rename there.

Thanks.

-- 
Frederic Weisbecker
SUSE Labs

