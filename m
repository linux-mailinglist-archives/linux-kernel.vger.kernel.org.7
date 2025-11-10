Return-Path: <linux-kernel+bounces-893312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 637B0C470C5
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 14:55:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2C10E4EC020
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 13:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A771C3101C5;
	Mon, 10 Nov 2025 13:55:41 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B9B920D4FC
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 13:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762782941; cv=none; b=WeBtZvX6j7ywF5TfvnbGApmo43SyW0IChHW/Wm//1i2zQYUsw9MIlJtUHzKOk611sgq1KinMGxteHkiiBHleAUMznwo9kaTbfCyRPO7eGTuCgnyOOZZwOOxuawgvYibquXzDduMiOv5ddeYqs9VSVFX0AoGkuM37/pDjqunzXfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762782941; c=relaxed/simple;
	bh=w/QyW3BLTieuZwRJiRGko34GJWG/LYO2/xn+M39jsQs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KUWMZCsL6J5IoPoP2ijI5BTYkiXXHe7PXxeLTla8gqh7AcHsYxJ3MLTKjnUD3WI7+NC2T8g/hgXLOm7mTsw1zsy/QJhlnckOwrOgjp0wnkuZ0tDg1Ag2P0UIYgD2kYHONIxzW5nS+v1w2/X+nbtwJOQFsiO9WwAEU3/IFcP13IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 121A32F;
	Mon, 10 Nov 2025 05:55:31 -0800 (PST)
Received: from [10.57.88.175] (unknown [10.57.88.175])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 61B203F66E;
	Mon, 10 Nov 2025 05:55:36 -0800 (PST)
Message-ID: <bcd48c73-b65f-47be-917b-7fb2b8ed8ec0@arm.com>
Date: Mon, 10 Nov 2025 14:55:34 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] sched/fair: Small cleanup to sched_balance_newidle()
To: Peter Zijlstra <peterz@infradead.org>, Chris Mason <clm@meta.com>,
 Joseph Salisbury <joseph.salisbury@oracle.com>,
 Adam Li <adamli@os.amperecomputing.com>,
 Hazem Mohamed Abuelfotoh <abuehaze@amazon.com>, Josh Don <joshdon@google.com>
Cc: mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
 vschneid@redhat.com, linux-kernel@vger.kernel.org
References: <20251107160645.929564468@infradead.org>
 <20251107161739.525916173@infradead.org>
Content-Language: en-GB
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20251107161739.525916173@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 07.11.25 17:06, Peter Zijlstra wrote:
> Pull out the !sd check to simplify code.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  kernel/sched/fair.c |   10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -12811,14 +12811,16 @@ static int sched_balance_newidle(struct
>  
>  	rcu_read_lock();

Maybe scoped_guard(rcu) here?

>  	sd = rcu_dereference_check_sched_domain(this_rq->sd);
> +	if (!sd) {
> +		rcu_read_unlock();
> +		goto out;
> +	}
>  
>  	if (!get_rd_overloaded(this_rq->rd) ||
> -	    (sd && this_rq->avg_idle < sd->max_newidle_lb_cost)) {
> +	    this_rq->avg_idle < sd->max_newidle_lb_cost) {
>  
> -		if (sd)
> -			update_next_balance(sd, &next_balance);
> +		update_next_balance(sd, &next_balance);
>  		rcu_read_unlock();
> -
>  		goto out;
>  	}
>  	rcu_read_unlock();



