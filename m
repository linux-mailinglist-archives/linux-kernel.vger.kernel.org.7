Return-Path: <linux-kernel+bounces-835630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F23FBA7A3F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 02:47:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76E7D18915F2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 00:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2772B15746E;
	Mon, 29 Sep 2025 00:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H0kZCL1d"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700D13A1DB;
	Mon, 29 Sep 2025 00:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759106868; cv=none; b=McAFHWpMlgrnHDBIdinnf8HdaxuEYZUApAzrJHCbyLCfrBEkURL9MCoFufm+RFTnra/63+r+Yinduz6y0P2w+Crgm0U/b8eVm4z5v2gSpAfUwtuFA95Se+mMvY0K5PnWiTi6PVkd26v1XxEO6z+cZ9x24Pa+VV/rqPpiNc2h2kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759106868; c=relaxed/simple;
	bh=YEUnlJyIiHlY7Vfpu4qR2648nJgvUPdwxj6vJ3d9yE8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=LYW7V6s6aS/RcoEmyA1ZmA0VIYEeO1mxS/x+gD/bb7WIF6t5mmuDzmgZXB4OnQYSGmYzZSdVmlyQoQqUYMVXmkE6z+rBfwRw4z96yn8jfvGCgHDclt8SATPfQuU26EblkJlyo9NhmIapFPHb143zpa8rllvirqnbm8h0ff4YFoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H0kZCL1d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37DBBC4CEF0;
	Mon, 29 Sep 2025 00:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759106865;
	bh=YEUnlJyIiHlY7Vfpu4qR2648nJgvUPdwxj6vJ3d9yE8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=H0kZCL1d9j+UwGN41Ub4WXmMCni7saAugBZ4DnmSBi8YGSFm3wKa88t9mNe+AmDwZ
	 2rX7yCpJzNZ72UgzfeHEDalWKoOkbD+Yr4b6JfMFQAt8Wzr/AKttOUAIt/rEIacFFW
	 Z6yXOairIRbT8LYOb8pNrBa9/vT7vMVx5GK/Iz96LFTRH3RfkQTDQrXrDcg0azrpz2
	 lr9lr+KC4kq1RWQzllPkHOyitItmJzTEI1AUpTvJ4l610pZSzIZFx6L24tgBpL79Ew
	 IBTtdiQ//9TQ+2Ks7KOpgWRL11gkvhAfsUMx9eISo0TDz+DqYBUmWSce79mzAKwL/7
	 hj0hWM8TLpOlw==
Date: Mon, 29 Sep 2025 09:47:39 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: lirongqing <lirongqing@baidu.com>
Cc: <corbet@lwn.net>, <akpm@linux-foundation.org>, <lance.yang@linux.dev>,
 <paulmck@kernel.org>, <pawan.kumar.gupta@linux.intel.com>,
 <mingo@kernel.org>, <dave.hansen@linux.intel.com>, <rostedt@goodmis.org>,
 <kees@kernel.org>, <arnd@arndb.de>, <feng.tang@linux.alibaba.com>,
 <pauld@redhat.com>, <joel.granados@kernel.org>,
 <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][v2] hung_task: Panic after fixed number of hung tasks
Message-Id: <20250929094739.e2d49113f52a315a900a2cd7@kernel.org>
In-Reply-To: <20250928053137.3412-1-lirongqing@baidu.com>
References: <20250928053137.3412-1-lirongqing@baidu.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 28 Sep 2025 13:31:37 +0800
lirongqing <lirongqing@baidu.com> wrote:

> From: Li RongQing <lirongqing@baidu.com>
> 
> Currently, when hung_task_panic is enabled, kernel will panic immediately
> upon detecting the first hung task. However, some hung tasks are transient
> and the system can recover fully, while others are unrecoverable and
> trigger consecutive hung task reports, and a panic is expected.
> 
> This commit adds a new sysctl parameter hung_task_count_to_panic to allows
> specifying the number of consecutive hung tasks that must be detected
> before triggering a kernel panic. This provides finer control for
> environments where transient hangs maybe happen but persistent hangs should
> still be fatal.

IIUC, perhaps there are multiple groups that require different timeouts
for hang checks, and you want to set the hung task timeout to match
the shorter one, but ignore the longer ones at that point.

If so, this is essentially a problem with a long process that is
performed under TASK_UNINTERRUPTIBLE. Ideally, the progress of such
process should be checked periodically and the hang check should be
reset unless it is real blocked.
But this is not currently implemented. (For example, depending on
the media, it may not be possible to check whether long IO is being
performed.)

The hung_tasks will even simulate these types of hangs as task
hang-ups. But if you set a long detection time accordingly, you
will also have to wait until that detection time for hangs that
occur in a short period of time.

The hung tasks on one major lock can spread in a domino effect.
So setting a reasonably short detection time, but not panicking
until there are enough of them, seems like a reasonable strategy.
But in this case, I think we also need a "hard timeout limit"
of hung tasks, which will detect longer ones. And also you should
use peak value not accumulation value.

If it is really transient (thus, it is not hung), accumulation of
such normal but just slow operation will still kick hung_tasks.

Thank you,

> 
> Acked-by: Lance Yang <lance.yang@linux.dev>
> Signed-off-by: Li RongQing <lirongqing@baidu.com>
> ---
> Diff with v1: change documentation as Lance suggested
> 
>  Documentation/admin-guide/sysctl/kernel.rst |  8 ++++++++
>  kernel/hung_task.c                          | 14 +++++++++++++-
>  2 files changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
> index 8b49eab..98b47a7 100644
> --- a/Documentation/admin-guide/sysctl/kernel.rst
> +++ b/Documentation/admin-guide/sysctl/kernel.rst
> @@ -405,6 +405,14 @@ This file shows up if ``CONFIG_DETECT_HUNG_TASK`` is enabled.
>  1 Panic immediately.
>  = =================================================
>  
> +hung_task_count_to_panic
> +=====================
> +
> +When set to a non-zero value, a kernel panic will be triggered if the
> +number of detected hung tasks reaches this value.
> +
> +Note that setting hung_task_panic=1 will still cause an immediate panic
> +on the first hung task.

What happen if it is 0?

>  
>  hung_task_check_count
>  =====================
> diff --git a/kernel/hung_task.c b/kernel/hung_task.c
> index 8708a12..87a6421 100644
> --- a/kernel/hung_task.c
> +++ b/kernel/hung_task.c
> @@ -83,6 +83,8 @@ static unsigned int __read_mostly sysctl_hung_task_all_cpu_backtrace;
>  static unsigned int __read_mostly sysctl_hung_task_panic =
>  	IS_ENABLED(CONFIG_BOOTPARAM_HUNG_TASK_PANIC);
>  
> +static unsigned int __read_mostly sysctl_hung_task_count_to_panic;
> +
>  static int
>  hung_task_panic(struct notifier_block *this, unsigned long event, void *ptr)
>  {
> @@ -219,7 +221,9 @@ static void check_hung_task(struct task_struct *t, unsigned long timeout)
>  
>  	trace_sched_process_hang(t);
>  
> -	if (sysctl_hung_task_panic) {
> +	if (sysctl_hung_task_panic ||
> +	    (sysctl_hung_task_count_to_panic &&
> +	     (sysctl_hung_task_detect_count >= sysctl_hung_task_count_to_panic))) {
>  		console_verbose();
>  		hung_task_show_lock = true;
>  		hung_task_call_panic = true;
> @@ -388,6 +392,14 @@ static const struct ctl_table hung_task_sysctls[] = {
>  		.extra2		= SYSCTL_ONE,
>  	},
>  	{
> +		.procname	= "hung_task_count_to_panic",
> +		.data		= &sysctl_hung_task_count_to_panic,
> +		.maxlen		= sizeof(int),
> +		.mode		= 0644,
> +		.proc_handler	= proc_dointvec_minmax,
> +		.extra1		= SYSCTL_ZERO,
> +	},
> +	{
>  		.procname	= "hung_task_check_count",
>  		.data		= &sysctl_hung_task_check_count,
>  		.maxlen		= sizeof(int),
> -- 
> 2.9.4
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

