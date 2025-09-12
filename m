Return-Path: <linux-kernel+bounces-814246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B7D6B5518C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 16:31:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DB2E1D65380
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 14:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A83073164A3;
	Fri, 12 Sep 2025 14:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YO6sj5V0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F147E315D59
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 14:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757687081; cv=none; b=Qv7HlUU0OY8/B+EAc1Drl30bgtpkWvqH5ACTLn1vG4dSArZKjFUdUkhiypYvO9UdwpbHTtM+SpO+T8gOW5HG16Zjlimcr2cbU7nI7cbHfxmX9c82jcuDC8RKE7G6WajGFbR64gJSuvWEZfnDgbgrpBctdoU3APVNjSGCfGIFvnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757687081; c=relaxed/simple;
	bh=rWJ80vQ+VQZE74cSfx+U4FMz2cmKuGQYdK9+u4j4W7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W8sbjvdlOw9YzCZdUYk5qqrcXWHgemLJ5gvZbNpqDNaUTMp52WlHO1tiCaMAygEUBaCFQ9WuI8udPv71ePZoG9NXxWcLL7WP95iAji4rKM7UkJmY3Z9ZS8QcAueIYvOdu8I85UiCEmuC/Pz6LhpnQScdDllsnkWp9j9yOAsVqJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YO6sj5V0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE7F1C4CEF1;
	Fri, 12 Sep 2025 14:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757687080;
	bh=rWJ80vQ+VQZE74cSfx+U4FMz2cmKuGQYdK9+u4j4W7Y=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=YO6sj5V0I9SkdVmh2fQZrqQRE8MCEi0VMUDmsv8zdyNDvWvEbBeTPOG+DJjpgmh5N
	 onOOqMesd6HMCyvJxIs/rLci9xLuH+WHbJreF8LsS61UTuwmvNAd736/PLPBTI2MR6
	 0OL0jje9yOl5wEHSTEwuug/Ltfsl1Lx8uNA9WJrXbJ5VHPz1NLe2YgwoGRgjVVLhaA
	 d6ntw7XUgmdSMzbAPSTWpoABz0juv/juo8/1t/7xnU8esULbP5NzgjYrdFM8m3q622
	 p2hTCrj/SR+UYmOBWqDBDV2EX0Ouyrtq9dPrMQ5laYh72ix82o9QxI+KUjSk+SfUzE
	 zT/oeApULjlUw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 8BFFBCE0A4E; Fri, 12 Sep 2025 07:24:39 -0700 (PDT)
Date: Fri, 12 Sep 2025 07:24:39 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Marco Crivellari <marco.crivellari@suse.com>
Cc: linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Michal Hocko <mhocko@suse.com>, Ingo Molnar <mingo@redhat.com>,
	Rik van Riel <riel@surriel.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH 1/1] smp: replace use of system_wq with system_percpu_wq
Message-ID: <77b495f8-177d-4977-9d09-1dffc29db269@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250905090953.109082-1-marco.crivellari@suse.com>
 <20250905090953.109082-2-marco.crivellari@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905090953.109082-2-marco.crivellari@suse.com>

On Fri, Sep 05, 2025 at 11:09:53AM +0200, Marco Crivellari wrote:
> Currently if a user enqueue a work item using schedule_delayed_work() the
> used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
> WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
> schedule_work() that is using system_wq and queue_work(), that makes use
> again of WORK_CPU_UNBOUND.
> 
> This lack of consistentcy cannot be addressed without refactoring the API.
> 
> system_wq is a per-CPU worqueue, yet nothing in its name tells about that
> CPU affinity constraint, which is very often not required by users. Make
> it clear by adding a system_percpu_wq.
> 
> queue_work() / queue_delayed_work() mod_delayed_work() will now use the
> new per-cpu wq: whether the user still stick on the old name a warn will
> be printed along a wq redirect to the new one.
> 
> This patch add the new system_percpu_wq except for mm, fs and net
> subsystem, whom are handled in separated patches.
> 
> The old wq will be kept for a few release cylces.
> 
> Suggested-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

> ---
>  kernel/smp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/smp.c b/kernel/smp.c
> index 974f3a3962e8..c3b93476d645 100644
> --- a/kernel/smp.c
> +++ b/kernel/smp.c
> @@ -1146,7 +1146,7 @@ int smp_call_on_cpu(unsigned int cpu, int (*func)(void *), void *par, bool phys)
>  	if (cpu >= nr_cpu_ids || !cpu_online(cpu))
>  		return -ENXIO;
>  
> -	queue_work_on(cpu, system_wq, &sscs.work);
> +	queue_work_on(cpu, system_percpu_wq, &sscs.work);
>  	wait_for_completion(&sscs.done);
>  	destroy_work_on_stack(&sscs.work);
>  
> -- 
> 2.51.0
> 

