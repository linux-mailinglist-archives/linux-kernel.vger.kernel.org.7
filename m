Return-Path: <linux-kernel+bounces-736985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CCA1B0A656
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 16:26:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33ED21881F1B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 14:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87B242DE70F;
	Fri, 18 Jul 2025 14:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Je0n7J0h"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60FB2DCF62
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 14:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752848589; cv=none; b=doJ7f+OF2g929Ba8enw1jNL9BieBXcfwhuIz8T/wXk3B5NyJWJfgjEXHB0GWaiBnz/G2kVd/HcVIkn8wcSTzT9KD46VIQgMi+4kLfrJUXnAkpUIvYiacmHp3myDdAU1C7Y4LvkTlWNkC6NNY3yEHiI0BEcY4pDjaMibJEyZNh80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752848589; c=relaxed/simple;
	bh=udKiPtsfo5ZeHKc4m3xNjNZyVu6OikeDVNRQXrxyBK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UtbTOtLkqL0zztF0NLPkLPR/4nU/t/YZ7Pkwzz/Q8/S/e3PT8qS2dFvwPl3tKF0LO7Yv++y1HkQ+iZudlo+uSMcsLIBhyEW4hh7nUnIy3b8FqYwpcNRvkbW6+LK0Nr3mF6xZ/SxxiTAje6BYK/YY4TVh4l2x7Hih9LAoaIWyRMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Je0n7J0h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FAD4C4CEF4;
	Fri, 18 Jul 2025 14:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752848588;
	bh=udKiPtsfo5ZeHKc4m3xNjNZyVu6OikeDVNRQXrxyBK4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Je0n7J0hN4ADj1ilRQU7O2c1AMngZNQseTNbWu03g6WoFHxeQzpJGuF4bmPIlTg0Z
	 WKaRCvp/SHkOifHBrxaH4cU7twyD6uxGQOmeit1EhMFQmIqJONnzO+PFtrIudWSK20
	 cxTNkMdPY1oj5yvbegZeE6pni7f/g3IBkdbXpnEH0ALvrmIZhVrlGkDo7JXbGEv8jn
	 IH/4CmpuECKpyxyPeviOTCv78FCT6kgzPDWlfMwxxSfxd9VuQdaWbbiPRTfYD52bgC
	 N1EHG/AbvmXmY6qdz1vaYKAqzKYU77f5Seaefzbjn7c1lCYp3FOBkw5sl+q2dO4MYT
	 XYp0nbPNc0bMw==
Date: Fri, 18 Jul 2025 16:23:05 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Valentin Schneider <vschneid@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ingo Molnar <mingo@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Michal Hocko <mhocko@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org
Subject: Re: [PATCH 5/6] sched/isolation: Introduce isolated task work
Message-ID: <aHpYyZAprRjcqNTL@localhost.localdomain>
References: <20250703140717.25703-1-frederic@kernel.org>
 <20250703140717.25703-6-frederic@kernel.org>
 <xhsmh1pqdg726.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xhsmh1pqdg726.mognet@vschneid-thinkpadt14sgen2i.remote.csb>

Le Fri, Jul 18, 2025 at 11:52:01AM +0200, Valentin Schneider a écrit :
> On 03/07/25 16:07, Frederic Weisbecker wrote:
> > @@ -77,4 +77,21 @@ static inline bool cpu_is_isolated(int cpu)
> >              cpuset_cpu_is_isolated(cpu);
> >  }
> >
> > +#if defined(CONFIG_NO_HZ_FULL_WORK)
> > +extern int __isolated_task_work_queue(void);
> > +
> > +static inline int isolated_task_work_queue(void)
> > +{
> > +	if (!housekeeping_cpu(raw_smp_processor_id(), HK_TYPE_KERNEL_NOISE))
> > +		return -ENOTSUPP;
> > +
> 
> Am I being dense or this condition the opposite of what we want? That is,
> AIUI we want isolated_task_work() to run on NOHZ_FULL/isolated CPUs'
> resume-to-userspace path, so this should bail if the current CPU
> *is* a housekeeping CPU.

Geeze!

> 
> > +	return __isolated_task_work_queue();
> > +}
> > +
> 

-- 
Frederic Weisbecker
SUSE Labs

