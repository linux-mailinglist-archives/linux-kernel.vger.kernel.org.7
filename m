Return-Path: <linux-kernel+bounces-818387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8020B59114
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 10:44:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EAD2188788C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 08:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90B352868BA;
	Tue, 16 Sep 2025 08:44:48 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799452580F9
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 08:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758012288; cv=none; b=ajwipL2LhOoBS74Rr5wxTqcS+drJFOrYrL0rlHa39ptapWI8kQAsWJUpXp7QdF6gk/e4p3SwzCEsgSwAXeM5aH//rIlWiDOxHNb/lvNQYm1rzfPTPwpusoGN5/K78rtPLJHBIq2WMUGgKBO6MTQVUwHjZCcLa1Pn31l2vBgOsWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758012288; c=relaxed/simple;
	bh=vUAGHHFOkBUS+ZANlRjiM/2OR+iuCOcLe0VfBelVlk4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=AU5ibkiVezvc6Jho6bgt0qq+s73aLMlatW7P0G1/mLZa100xybxpBVt80+NzvJtW3hgXr36u6UDhjEncaidZlCXJgpwwzzx3Qvv1/YncyucUPUZFFYSv+aJzx6uu6WDjVdGtkaqaBmv3+KeNJlYMJnJzCxQ7LnMJiimYg3LPxWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4cQwS96DVPz14MwC;
	Tue, 16 Sep 2025 16:44:25 +0800 (CST)
Received: from dggpemf100009.china.huawei.com (unknown [7.185.36.128])
	by mail.maildlp.com (Postfix) with ESMTPS id CA8CA18007F;
	Tue, 16 Sep 2025 16:44:41 +0800 (CST)
Received: from [10.67.109.25] (10.67.109.25) by dggpemf100009.china.huawei.com
 (7.185.36.128) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 16 Sep
 2025 16:44:40 +0800
Message-ID: <124838f6-8cee-422a-b877-82ad98879d0a@huawei.com>
Date: Tue, 16 Sep 2025 16:44:39 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched: Increase sched_tick_remote timeout
To: Phil Auld <pauld@redhat.com>, <frederic@kernel.org>
CC: <bsegall@google.com>, <dietmar.eggemann@arm.com>, <juri.lelli@redhat.com>,
	<linux-kernel@vger.kernel.org>, <mgorman@suse.de>, <mingo@redhat.com>,
	<peterz@infradead.org>, <rostedt@goodmis.org>, <tanghui20@huawei.com>,
	<tglx@linutronix.de>, <vincent.guittot@linaro.org>, <zhangqiao22@huawei.com>,
	Waiman Long <longman@redhat.com>
References: <aMLs5G3WvlXOAxuY@localhost.localdomain>
 <20250911161300.437944-1-pauld@redhat.com>
From: "wangtao (EQ)" <wangtao554@huawei.com>
In-Reply-To: <20250911161300.437944-1-pauld@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 dggpemf100009.china.huawei.com (7.185.36.128)

Increasing timeout alerts can reduce the probability of deadlocks. However, in the 'sched_tick_remote' method, there are 'WARN_ON_ONCE(rq->curr!= rq->donor)' and 'assert_clock_updated' in 'rq_clock_task'. Regardless of why these alerts are triggered, once they are triggered, 'printk' is called, which still leaves potential deadlock issues. Is there a better way to address these problems?

在 2025/9/12 0:13, Phil Auld 写道:
> Increase the sched_tick_remote WARN_ON timeout to remove false
> positives due to temporarily busy HK cpus. The suggestion
> was 30 seconds to catch really stuck remote tick processing
> but not trigger it too easily.
>
> Signed-off-by: Phil Auld <pauld@redhat.com>
> Suggested-by: Frederic Weisbecker <frederic@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Frederic Weisbecker <frederic@kernel.org>
> ---
>   kernel/sched/core.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index be00629f0ba4..ef90d358252d 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -5724,7 +5724,7 @@ static void sched_tick_remote(struct work_struct *work)
>   				 * reasonable amount of time.
>   				 */
>   				u64 delta = rq_clock_task(rq) - curr->se.exec_start;
> -				WARN_ON_ONCE(delta > (u64)NSEC_PER_SEC * 3);
> +				WARN_ON_ONCE(delta > (u64)NSEC_PER_SEC * 30);
>   			}
>   			curr->sched_class->task_tick(rq, curr, 0);
>   

