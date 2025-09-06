Return-Path: <linux-kernel+bounces-804424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA4CAB47656
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 20:54:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64EBFA45860
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 18:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 233F8280332;
	Sat,  6 Sep 2025 18:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lzWL8taN"
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E1E20C038
	for <linux-kernel@vger.kernel.org>; Sat,  6 Sep 2025 18:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757184844; cv=none; b=S0IzZyv/LejDDfPl0aPe5mlATYaDG3eaQnSmBUB3+93ZbukN5EVpvOzjIH5Inet5hjuORN1SI3z0lpmzI0h+UMQLrBD8Cdf0oi3ix5ELt7gPOiRe9mKp1oaAHzrra+2rJtegtaP6Encirile1nlTieBSIyb+rQi57eECeDVYZCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757184844; c=relaxed/simple;
	bh=JVSSzooaeRtlbZ9KyKg65C0rxpyfnalO6XKZPhSyhiY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iEwa2oiP/MHBYOxObxDrysK4mEzaM/aIwU5rVsjghvrSu1Lrg+kAGxm44tiIFlf4cDJKErR6l5n0a6KIUvJC2nLiMfGxDYE8hs1GeG1ixH4EzMgjF22apfcQncqiI8xM3oLfAP3mESvB8tKsSr+GxE2EWpcQDu+L2nyltdWokKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lzWL8taN; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 6 Sep 2025 14:53:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757184829;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XO840S967ZCwkusZH6+LwK2cAB4CKb+fEX5rRQuBhxw=;
	b=lzWL8taN52a62L9f8e9UZ98/Idh9lnGwUka/nwBEYvThPg3RaZ9yPXmpSdg+6ObhaUmtkf
	naCUNDJxc3k6EFKcRm8YrYpPAxQrB8dPWzTPLEaXCsmSC+J8Yfxzs3Am+DDrLHz1j0Oyyb
	FI9ofKzHA3CJ64vJIB32giGkkBpVZ5M=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Marco Crivellari <marco.crivellari@suse.com>
Cc: linux-kernel@vger.kernel.org, linux-bcachefs@vger.kernel.org, 
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH 1/1] closure: replace use of system_wq with
 system_percpu_wq
Message-ID: <n7ktycej5ipkjem7hdf6bqsz3srawduxdstxe5du3gybwrm5gz@wdd3ipeyxn7a>
References: <20250905085625.97367-1-marco.crivellari@suse.com>
 <20250905085625.97367-2-marco.crivellari@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905085625.97367-2-marco.crivellari@suse.com>
X-Migadu-Flow: FLOW_OUT

On Fri, Sep 05, 2025 at 10:56:25AM +0200, Marco Crivellari wrote:
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
> ---
>  include/linux/closure.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/closure.h b/include/linux/closure.h
> index 880fe85e35e9..959b3c584254 100644
> --- a/include/linux/closure.h
> +++ b/include/linux/closure.h
> @@ -58,7 +58,7 @@
>   * bio2->bi_endio = foo_endio;
>   * bio_submit(bio2);
>   *
> - * continue_at(cl, complete_some_read, system_wq);
> + * continue_at(cl, complete_some_read, system_percpu_wq);
>   *
>   * If closure's refcount started at 0, complete_some_read() could run before the
>   * second bio was submitted - which is almost always not what you want! More
> -- 
> 2.51.0
> 

I was confused until I realized you're updating a comment.

Acked-by: Kent Overstreet <kent.overstreet@linux.dev>

