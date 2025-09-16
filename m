Return-Path: <linux-kernel+bounces-818797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A8FAB59691
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 14:49:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A66BE7AF58C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 12:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1391D19C553;
	Tue, 16 Sep 2025 12:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SQGqh4sW"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B69BA3D
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 12:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758026973; cv=none; b=aEP/kFqskLltA7iYOMIxQIU6Ec0ySf+YpGiQBV//aNhzTRFizRu0+geqHh6UA2YUW7xLBNd3IWpMHYf5sRH90/RUUhh1FiPPKFAAMrZAawpTRQmGgLvbuaGmo9j7brvDeoQfhBgu9ViJ5LqPA9gNgzCg1Zwr+N8bdoWa3pUDY4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758026973; c=relaxed/simple;
	bh=jocmhLPsAZ8cCLgRS+h2xpjpbXO9bX1/cihUEPrZzVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kJZ0L/HemnD3lIqyftPaZvYgATlBvFhtb9pZ2+9aAwnBk4QdYID9awpBQ7064c8HVeWjAbGerVHgC+oRjcVflv1XJy2yajkzb5HkZfMNRCnV2vj6niqtGTktHqpb64RH552J6Giad2TP8IngxpNUNkjyh84YHWaqsC9zslGXaKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SQGqh4sW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758026970;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GOhu+5eNQuIMVeRFVQ8+PIyrI1YVYeZmMZukHwORVlI=;
	b=SQGqh4sWSGTvLhHsKya4sjWqNDPt2PBeZsUIRO6yRsvFxDqM5A/dt8tNy6BGaarfhIhSxB
	/4OqH3dFDdg+BtgtnNDhWwTuS1trBDGbHBJcFSVeYZ5ybDus1V3wWMC1wSxQUTPU4qP9qC
	ks/Dxun0JiIvVGP+1bGlKInbR8iBN4A=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-41-85b75dhfMdaPm9ZCxr9t3w-1; Tue,
 16 Sep 2025 08:49:27 -0400
X-MC-Unique: 85b75dhfMdaPm9ZCxr9t3w-1
X-Mimecast-MFC-AGG-ID: 85b75dhfMdaPm9ZCxr9t3w_1758026965
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5181919560B5;
	Tue, 16 Sep 2025 12:49:25 +0000 (UTC)
Received: from pauld.westford.csb (unknown [10.45.226.188])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8791D30001B5;
	Tue, 16 Sep 2025 12:49:17 +0000 (UTC)
Date: Tue, 16 Sep 2025 08:49:12 -0400
From: Phil Auld <pauld@redhat.com>
To: "wangtao (EQ)" <wangtao554@huawei.com>
Cc: frederic@kernel.org, bsegall@google.com, dietmar.eggemann@arm.com,
	juri.lelli@redhat.com, linux-kernel@vger.kernel.org,
	mgorman@suse.de, mingo@redhat.com, peterz@infradead.org,
	rostedt@goodmis.org, tanghui20@huawei.com, tglx@linutronix.de,
	vincent.guittot@linaro.org, zhangqiao22@huawei.com,
	Waiman Long <longman@redhat.com>
Subject: Re: [PATCH] sched: Increase sched_tick_remote timeout
Message-ID: <20250916124912.GA179793@pauld.westford.csb>
References: <aMLs5G3WvlXOAxuY@localhost.localdomain>
 <20250911161300.437944-1-pauld@redhat.com>
 <124838f6-8cee-422a-b877-82ad98879d0a@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <124838f6-8cee-422a-b877-82ad98879d0a@huawei.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Tue, Sep 16, 2025 at 04:44:39PM +0800 wangtao (EQ) wrote:
> Increasing timeout alerts can reduce the probability of deadlocks. However, in the 'sched_tick_remote' method, there are 'WARN_ON_ONCE(rq->curr!= rq->donor)' and 'assert_clock_updated' in 'rq_clock_task'. Regardless of why these alerts are triggered, once they are triggered, 'printk' is called, which still leaves potential deadlock issues. Is there a better way to address these problems?
>

I'm not specically trying to solve the printk deadlock problem. My patch is
to make this particular warning go away by reducing the false positives.
That's tangential to your original posting. 

You can use the new printk mechanism with an atomic console to get around
the printk bug I think.

I think you could also use a serial console instead of a framebuffer based
console.


Cheers,
Phil



> 在 2025/9/12 0:13, Phil Auld 写道:
> > Increase the sched_tick_remote WARN_ON timeout to remove false
> > positives due to temporarily busy HK cpus. The suggestion
> > was 30 seconds to catch really stuck remote tick processing
> > but not trigger it too easily.
> > 
> > Signed-off-by: Phil Auld <pauld@redhat.com>
> > Suggested-by: Frederic Weisbecker <frederic@kernel.org>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Frederic Weisbecker <frederic@kernel.org>
> > ---
> >   kernel/sched/core.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index be00629f0ba4..ef90d358252d 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -5724,7 +5724,7 @@ static void sched_tick_remote(struct work_struct *work)
> >   				 * reasonable amount of time.
> >   				 */
> >   				u64 delta = rq_clock_task(rq) - curr->se.exec_start;
> > -				WARN_ON_ONCE(delta > (u64)NSEC_PER_SEC * 3);
> > +				WARN_ON_ONCE(delta > (u64)NSEC_PER_SEC * 30);
> >   			}
> >   			curr->sched_class->task_tick(rq, curr, 0);
> 

-- 


