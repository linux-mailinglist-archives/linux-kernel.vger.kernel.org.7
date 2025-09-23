Return-Path: <linux-kernel+bounces-828802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 88F7DB95837
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 12:50:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CEE21888986
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 10:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB5763218BD;
	Tue, 23 Sep 2025 10:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JbNJZHKS"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6888F3218B9
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 10:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758624477; cv=none; b=KbYC1ioyFEwfe04efO79CrBzIBuVvvMuEFZiKOLnaJTYf7F4l9tFOPL9QqkCrmexToyGU8dWjj8ietG4hlpI7rl5BW3MiiIaoxom7/uuojWfv7V2VzJg4coBUa4f8GehzEiiFf3b6nWc4qfRgfZUn93XbuujvmSbcxLv13V9Wpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758624477; c=relaxed/simple;
	bh=3oVG6Scm2L4jUe5umVvGBq5Rz48Jj1jhs3dBx2TMtEc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pipIInENModvnK8tOCIet/A7dPJI0b9tguqdta/pk3emTXqNmm8otQDTvkQzHv2C5nzlivKHngHwdrlmU5dz7KaLlMh/tlj/4gQTpujlCSmBcJXkHQQ8BeSJaJPPBvAngiaXILlq4t46fDg1RTkfgpWJU6kRZ3Q8sprt4y2Rd4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JbNJZHKS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758624474;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JRjyXXs0f+N1EXS+7Pp/qkePU4N7ORt9g/7H9m4JRx4=;
	b=JbNJZHKSrVSJp6RoOuwMjJU4V8WFn11zp6vugluWqdFgxJ2p2u2AGBX1GG7Qjc1nZHe5Na
	eExYo0Uyq7VtNmCIiNFDvd41OH5lRCYhM4hXYP6QmW06nV8ibRDAIWpPUhV2JPExNk2WpS
	AxfgQtqoCoFaKdz3rq7kuhE2VEU+aWU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-524-Lneful5dNDGUo3_1N1N3_Q-1; Tue,
 23 Sep 2025 06:47:48 -0400
X-MC-Unique: Lneful5dNDGUo3_1N1N3_Q-1
X-Mimecast-MFC-AGG-ID: Lneful5dNDGUo3_1N1N3_Q_1758624467
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A9A4B18002C4;
	Tue, 23 Sep 2025 10:47:46 +0000 (UTC)
Received: from pauld.westford.csb (unknown [10.22.88.99])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8CF8F1800446;
	Tue, 23 Sep 2025 10:47:42 +0000 (UTC)
Date: Tue, 23 Sep 2025 06:47:39 -0400
From: Phil Auld <pauld@redhat.com>
To: frederic@kernel.org
Cc: bsegall@google.com, dietmar.eggemann@arm.com, juri.lelli@redhat.com,
	linux-kernel@vger.kernel.org, mgorman@suse.de, mingo@redhat.com,
	peterz@infradead.org, rostedt@goodmis.org, tanghui20@huawei.com,
	tglx@linutronix.de, vincent.guittot@linaro.org,
	wangtao554@huawei.com, zhangqiao22@huawei.com,
	Waiman Long <longman@redhat.com>
Subject: Re: [PATCH] sched: Increase sched_tick_remote timeout
Message-ID: <20250923104739.GA514793@pauld.westford.csb>
References: <aMLs5G3WvlXOAxuY@localhost.localdomain>
 <20250911161300.437944-1-pauld@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250911161300.437944-1-pauld@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Hi,

On Thu, Sep 11, 2025 at 12:13:00PM -0400 Phil Auld wrote:
> Increase the sched_tick_remote WARN_ON timeout to remove false
> positives due to temporarily busy HK cpus. The suggestion
> was 30 seconds to catch really stuck remote tick processing
> but not trigger it too easily.
> 
> Signed-off-by: Phil Auld <pauld@redhat.com>
> Suggested-by: Frederic Weisbecker <frederic@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Frederic Weisbecker <frederic@kernel.org>

Frederic ack'd this. Any other thoughts or opinions on this one
character patch?

Cheers,
Phil



> ---
>  kernel/sched/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index be00629f0ba4..ef90d358252d 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -5724,7 +5724,7 @@ static void sched_tick_remote(struct work_struct *work)
>  				 * reasonable amount of time.
>  				 */
>  				u64 delta = rq_clock_task(rq) - curr->se.exec_start;
> -				WARN_ON_ONCE(delta > (u64)NSEC_PER_SEC * 3);
> +				WARN_ON_ONCE(delta > (u64)NSEC_PER_SEC * 30);
>  			}
>  			curr->sched_class->task_tick(rq, curr, 0);
>  
> -- 
> 2.51.0
> 

-- 


