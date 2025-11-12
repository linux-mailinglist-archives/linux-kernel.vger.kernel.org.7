Return-Path: <linux-kernel+bounces-897100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A923EC52078
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 12:41:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 75C074F6688
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 11:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 557D72FF641;
	Wed, 12 Nov 2025 11:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Q5zM2807"
Received: from out199-16.us.a.mail.aliyun.com (out199-16.us.a.mail.aliyun.com [47.90.199.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E2F288537
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 11:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.199.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762946749; cv=none; b=IaRMrs19EZPMoMSxGGF+VWDvRs2OF2xt3WVFsd+jFjuRPpsQZX/yvsdFoi2IE71i09glia0B0ijHNChcnACoLp0hsjgGnrn0XyXYSmf1HdTm4x6u17o5DgaULv0WCr0PBJePCfKgK6EVaEA4DV2Wm5HwTCUyD6ztDO795I6Nh+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762946749; c=relaxed/simple;
	bh=z5/oRnDVWkDvdyUlUlWf7tHA54EBXvWlbVoA/7jaRbw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GuEyyLhpb29oLg7xR0C9pDtDi339WWvUPZ5Ydo0+xyNnJx0koyRzNTJ/dSWY465YZp2FC3qdUQqpo7tsoUAE10srDP3+liEkf0+LaC1yixaCkJBIq89ZvLD/93okj+tAh94kV9pnhO45R6XFwERi6HBG2o3JCIDp0Xi5DmI7Dfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Q5zM2807; arc=none smtp.client-ip=47.90.199.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1762946728; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=wcttPK+eSjBPd/u/oTI00tYINUhIAz/rhQMPrHprd+8=;
	b=Q5zM2807BucGqOEsulJUEzQOJ7hVmWdAWUceYGNfeWVFwl3elNdEssfoPnt8yB/dtOvIVefAO/IFUBrnVIvlOulHf49yAo+ffsfkCrsMe2tjRy3M8jgbFF0jV3ilMsWasD1CIs84+zrDdG+jk9kra8mmM7uRQx9B4pAz1zg/zwc=
Received: from localhost(mailfrom:feng.tang@linux.alibaba.com fp:SMTPD_---0WsG716J_1762946727 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 12 Nov 2025 19:25:28 +0800
Date: Wed, 12 Nov 2025 19:25:27 +0800
From: Feng Tang <feng.tang@linux.alibaba.com>
To: Petr Mladek <pmladek@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Lance Yang <ioworker0@gmail.com>, paulmck@kernel.org,
	Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] hung_task: Add hung_task_sys_info sysctl to dump sys
 info on task-hung
Message-ID: <aRRupyzGaP5Z35qE@U-2FWC9VHC-2323.local>
References: <20251106023032.25875-1-feng.tang@linux.alibaba.com>
 <20251106023032.25875-3-feng.tang@linux.alibaba.com>
 <aRInLdgKCzaVeyG0@pathway.suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aRInLdgKCzaVeyG0@pathway.suse.cz>

On Mon, Nov 10, 2025 at 06:55:57PM +0100, Petr Mladek wrote:
> On Thu 2025-11-06 10:30:31, Feng Tang wrote:
[...]
> @@ -315,8 +295,10 @@ static void check_hung_uninterruptible_tasks(unsigned long timeout)
>  {
>  	int max_count = sysctl_hung_task_check_count;
>  	unsigned long last_break = jiffies;
> +	unsigned long total_hung_task;
>  	struct task_struct *g, *t;
>  	unsigned long prev_detect_count = sysctl_hung_task_detect_count;
> +	unsigned long si_mask;
>  
>  	/*
>  	 * If the system crashed already then all bets are off,
> @@ -325,6 +307,14 @@ static void check_hung_uninterruptible_tasks(unsigned long timeout)
>  	if (test_taint(TAINT_DIE) || did_panic)
>  		return;
>  
> +	si_mask = hung_task_si_mask;
> +	if (sysctl_hung_task_warnings || hung_task_call_panic) {
> +		si_mask |= SYS_INFO_LOCKS;
> +
> +		if (sysctl_hung_task_all_cpu_backtrace)
> +			si_mask |= SYS_INFO_ALL_BT;
> +	}

This probably needs to be moved to after the loop check of
check_hung_task(). 

> +
>  	rcu_read_lock();
>  	for_each_process_thread(g, t) {
>  
> @@ -336,16 +326,20 @@ static void check_hung_uninterruptible_tasks(unsigned long timeout)
>  			last_break = jiffies;
>  		}
>  
> -		check_hung_task(t, timeout, prev_detect_count);
> +		check_hung_task(t, timeout);
>  	}
>   unlock:
>  	rcu_read_unlock();
>  
> -	if (unlikely(cur_si_mask)) {
> -		sys_info(cur_si_mask);
> -		cur_si_mask = 0;
> +	total_hung_task = sysctl_hung_task_detect_count - prev_detect_count;
> +	if (sysctl_hung_task_panic && total_hung_task >= sysctl_hung_task_panic) {
> +		console_verbose();
> +		hung_task_call_panic = true;
>  	}
>  
> +	if (unlikely(si_mask))
> +		sys_info(si_mask);
> +
>  	if (hung_task_call_panic)
>  		panic("hung_task: blocked tasks");
>  }
[...]

Thanks,
Feng

