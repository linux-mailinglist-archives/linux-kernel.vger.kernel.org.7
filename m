Return-Path: <linux-kernel+bounces-722770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26DDBAFDEA0
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 05:58:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E29B584D03
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 03:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24C2123ABBF;
	Wed,  9 Jul 2025 03:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="t40vXlIp"
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E453208
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 03:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752033509; cv=none; b=Nhux18THg7NwDp0nl1s2KTfqmYINKY6xn8xGnhKNtBRy5vPA9SJG8KezGjNMccKr5if1uNwWRWfdCKObotMyHbq4L6WvPWVkRIJtpVzWnVvt2nzCAgYMPtsTk89mhI6fIXWEKdeR0ArSOfbUb+LQ7+xRMGwhXnHHtCROILsM/wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752033509; c=relaxed/simple;
	bh=PIQpyc+uJ3idaxC3xRUFtlN03Wy0O3PPL9yw5WLZ/1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J0E6cL0RyYIj+zJVgn2TWKCO96EDWXgsZ1DnaSRNps812Jfgv+ANCQyp3JZj20AWi+3SYCdj1yUseF9pD3hLG2NWGG/aiJ2VH5pY/mEuCcKyF3zCfZ3tCG7Ha8hePuzCeJV7G7sXfurEWm5CLZ+TQK6mtdoZ2OU4206pVDRMfxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=t40vXlIp; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1752033498; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=F+TCm5yMLaR1zaqgTfgGSGazGjr5Lt2RVsmEPGa43Bk=;
	b=t40vXlIp2EXXaWWf5zhRfbTZ+VyjenLhQhddswQl6szukkvPtSVEV+FcmiiY1XRhwTCfIvf2LoQ7zSwBwkU/j5aH471ET7WatFerXgQtj3Lh4X+wR9yaP2SX6jfpwC61khIROWmwwB3m11SJCu5qWbeyrL1eyKw10FRH/AEFx9I=
Received: from localhost(mailfrom:feng.tang@linux.alibaba.com fp:SMTPD_---0WiWD7Ko_1752033497 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 09 Jul 2025 11:58:17 +0800
Date: Wed, 9 Jul 2025 11:58:17 +0800
From: Feng Tang <feng.tang@linux.alibaba.com>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
	Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH 3/5] panic: add 'panic_sys_info' sysctl to take human
 readable string parameter
Message-ID: <aG3o2RFHc5iXnJef@U-2FWC9VHC-2323.local>
References: <ndckw7vr5zxiz2olstjaxxk4a6qgrnbo65rex4242u3swnvvhm@whxmilgtgoyd>
 <aG3hjKg81xrDHjZc@U-2FWC9VHC-2323.local>
 <vksfx7stglvc7dvdsbu6b6eflmacg5eexnmzu47tdkak4uwscm@rm2ilr5ntriy>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <vksfx7stglvc7dvdsbu6b6eflmacg5eexnmzu47tdkak4uwscm@rm2ilr5ntriy>

On Wed, Jul 09, 2025 at 12:35:40PM +0900, Sergey Senozhatsky wrote:
[...]
> > 
> > > Moving sys_info_avail[] inside sysctl_sys_info_handler() seems to help.
> > 
> > Sorry for the trouble. I assume this is clang?  I locally used gcc v10.2.1
> 
> No worries.  Yes, clang.
> 
> > Nathan Chancellor has helped to post a fix here https://lore.kernel.org/lkml/20250708-fix-clang-sys_info_avail-warning-v1-1-60d239eacd64@kernel.org/
> 
> Great.
> Would __maybe_unused be better than something simpler:

I'm fine with both solutions :).

One thought is, as Petr also reminded, that user may extend the needed
sys info in future, and we added some explicit note in sys_info.c: 

	/*
	 * When 'si_names' gets updated,  please make sure the 'sys_info_avail'
	 * below is updated accordingly.
	 */
	static const struct sys_info_name  si_names[] = {
		{ SYS_INFO_TASKS,		"tasks" },
		{ SYS_INFO_MEM,			"mem" },
		{ SYS_INFO_TIMERS,		"timers" },
		
then standing-alone sys_info_avail[] may make it more obvious.  

Thanks,
Feng

> ---
> 
> diff --git a/lib/sys_info.c b/lib/sys_info.c
> index 46d6f4f1ad2a..3bd789fe29d2 100644
> --- a/lib/sys_info.c
> +++ b/lib/sys_info.c
> @@ -48,13 +48,11 @@ unsigned long sys_info_parse_param(char *str)
>  }
>  
>  #ifdef CONFIG_SYSCTL
> -
> -static const char sys_info_avail[] = "tasks,mem,timers,locks,ftrace,all_bt,blocked_tasks";
> -
>  int sysctl_sys_info_handler(const struct ctl_table *ro_table, int write,
>  					  void *buffer, size_t *lenp,
>  					  loff_t *ppos)
>  {
> +	static const char sys_info_avail[] = "tasks,mem,timers,locks,ftrace,all_bt,blocked_tasks";
>  	char names[sizeof(sys_info_avail) + 1];
>  	struct ctl_table table;
>  	unsigned long *si_bits_global;

