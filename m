Return-Path: <linux-kernel+bounces-789219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7233DB39256
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 05:51:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CD971B23997
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 03:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBF13252906;
	Thu, 28 Aug 2025 03:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="BXrS92y3"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A89830CD8A
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 03:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756353075; cv=none; b=Bprz0QWHBcZE4NJNxAxxk53TTPyyJZcr6VoAnWZmiGlErlzQcztpUQGczjC///WY2PPz2KwjRkgz35KPEcCIFjyJcP5u22fUn2F9ghn1OIgKlMv7mhBscPWIiA4bMxI655evAwzzTYIRGLXA/nxyPIVdC0JMkUWqZVKNukEN2sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756353075; c=relaxed/simple;
	bh=4bNShKzKYloFeLrPR2pun7N/Jfy76WaYB+K6q91keWg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZsCw/jSJulpb/LgyOLYXovYErmZzn4L7BVoaPRnEXJZ6m7NJ/FD18SjL6vkyjqCFfaROgAXMKIbYNHYt05wR2uyQAu6w3yFoa1B5ouxxvTi8xMQF5xKQJ0oAIsaqSjNPpYEX1acVRADNgITIXsOKF7YsHNTqULsXVu+GVy76SUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=BXrS92y3; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-248df8d82e2so964255ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 20:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1756353072; x=1756957872; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y4APYOBN7m40I1K2td0CwAVZ2zwd3LkalBks3ZKfrL0=;
        b=BXrS92y3PUKhggRTR0t7SKFAxwc4YCfIvw+Nglp3CU3z/TJwJZ2yUx+x2AxFq+GGxZ
         HljRGI2zahYJWNKmfKq0szg8yfnKlj17Mn+maVPgUnT4DLjAWc8hW7weJu+VlXAVLSw5
         Dy7rWTcl3trU987R5ObNjBUC0DsJySs/CnU6SRzrBxOut9STLZo3i9ZCerPT/X2MTPjh
         n5L0UI0c2mJqwytTvNVUGtRaZbbQBtwRzFfSF/30/k5Mbw5lj7O98abdYUzM5q9P++S2
         GtTyLxYZmjs0YQw5J/sb1ncviHlFpY1tFqmNjMWWdC6Cw+2uZKySOHH9l9FbC/Ni9i+x
         Ow4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756353072; x=1756957872;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y4APYOBN7m40I1K2td0CwAVZ2zwd3LkalBks3ZKfrL0=;
        b=TLtFEYHLtbmVl9cGPZTLzCq7TQXobuldzw4f4pmdGCUEPQp24mvv4Am5XlOGb3mD66
         SLW8hOaVPBMHw2iB9ArzfJhx8nb7mz5WQPiettpvUCGrhhSSyjjOkm0T7qxoNHWTW7wU
         qRu9d0ofC6/5JtYR8NSKd0tf3NzB4vGrfJ0ltYAP0Y7zquMzTeBxbcuM0pGTojaQCfeW
         2MjImyvuaSI8OBEFQM1SLjnQLSyC5JgNe48pbkICC3MUVS3hk3PyWkVFERCFFosLuekb
         uU0+ou681Hzg/jML3PujjhrQcLN4SllGRYE33gEzK/qLdwBCJEtbQ7Ko/HAce/PlcqsK
         DPHg==
X-Forwarded-Encrypted: i=1; AJvYcCUBznCf1n/tMVyVXdqae8j3E4J6OprQ9aPdirqOxq6VI6JxvDGjO7ePhmvCS4OiAgAAb/Mr1o1e7SFFtpg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAleBz3kAEAJU3vMCY2lSBb96Fhu5TSmpeVET54vgrx8mXgGHS
	PJDcq6poCL1sB/gs+ZYS6fUDD+OQrcvp0taLdrmtvYXXo84EHo75dbSpGozw31WOYw==
X-Gm-Gg: ASbGnctnoMA5AB+TmEqYrhRL/V9XHz8ZHXAM2l3RLw9M26IOE5PmWTiBjm/HVLjeOBV
	+meOs94LouKb0ZGhNZkGIIRzvtnY3GmweaGcZ+o12bwMDmijGN0PBsaUO7FMqtJ0l/OiX7qEQWi
	BzHwecjBJbzRJieaqdYhdKWuxsC3/nQQ5CIqD59CIkgSRvped1VAeekTs9hgkqNPlxbqpIMQqg0
	pEqSahy5DkFgU402n7ebnfCauWxf0rHQMXiGBHoaFvKSncHIxy1Cy4A8oX6i/jx3K+bu5KiNQy+
	NYg68x52fT6fOcT+3Pd8yAoowxKG1OmdPk9Y0imTONT/gyFV15pGsgwmpg2dX4rigxo/JNofLQp
	3/jv7Ok+/5qOuXvYvVsZljzbU9mHrkGHdO9MO4+ypL6MJNdjwXQ==
X-Google-Smtp-Source: AGHT+IEtqnrt5/Ql7DIRG+zCE16ygkcuydJFljVN0dP8z3YrApUelOfj88zKZHX4scP5rUUGUXV3RA==
X-Received: by 2002:a17:902:dacc:b0:248:96af:518 with SMTP id d9443c01a7336-24896af07d5mr66448905ad.59.1756353071595;
        Wed, 27 Aug 2025 20:51:11 -0700 (PDT)
Received: from bytedance ([61.213.176.56])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-327ab0dbe86sm804817a91.21.2025.08.27.20.51.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 20:51:11 -0700 (PDT)
Date: Thu, 28 Aug 2025 11:50:52 +0800
From: Aaron Lu <ziqianlu@bytedance.com>
To: Valentin Schneider <vschneid@redhat.com>
Cc: Ben Segall <bsegall@google.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Josh Don <joshdon@google.com>, Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Xi Wang <xii@google.com>, linux-kernel@vger.kernel.org,
	Juri Lelli <juri.lelli@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>, Mel Gorman <mgorman@suse.de>,
	Chuyi Zhou <zhouchuyi@bytedance.com>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Florian Bezdeka <florian.bezdeka@siemens.com>,
	Songtang Liu <liusongtang@bytedance.com>
Subject: Re: [PATCH v3 3/5] sched/fair: Switch to task based throttle model
Message-ID: <20250828035052.GA35@bytedance>
References: <20250715071658.267-1-ziqianlu@bytedance.com>
 <20250715071658.267-4-ziqianlu@bytedance.com>
 <xhsmhv7myp46n.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <20250808101330.GA75@bytedance>
 <xhsmhsei2ox4o.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xhsmhsei2ox4o.mognet@vschneid-thinkpadt14sgen2i.remote.csb>

On Fri, Aug 08, 2025 at 01:45:11PM +0200, Valentin Schneider wrote:
> On 08/08/25 18:13, Aaron Lu wrote:
> > On Fri, Aug 08, 2025 at 11:12:48AM +0200, Valentin Schneider wrote:
... ...
> >> > +	if (throttled_hierarchy(cfs_rq) &&
> >> > +	    !task_current_donor(rq_of(cfs_rq), p)) {
> >> > +		list_add(&p->throttle_node, &cfs_rq->throttled_limbo_list);
> >> > +		return true;
> >> > +	}
> >> > +
> >> > +	/* we can't take the fast path, do an actual enqueue*/
> >> > +	p->throttled = false;
> >> 
> >> So we clear p->throttled but not p->throttle_node? Won't that cause issues
> >> when @p's previous cfs_rq gets unthrottled?
> >> 
> >
> > p->throttle_node is already removed from its previous cfs_rq at dequeue
> > time in dequeue_throttled_task().
> >
> > This is done so because in enqueue time, we may not hold its previous
> > rq's lock so can't touch its previous cfs_rq's limbo list, like when
> > dealing with affinity changes.
> >
> 
> Ah right, the DQ/EQ_throttled_task() functions are when DQ/EQ is applied to an
> already-throttled task and it does the right thing.
> 
> Does this mean we want this as enqueue_throttled_task()'s prologue?
> 
>   /* @p should have gone through dequeue_throttled_task() first */
>   WARN_ON_ONCE(!list_empty(&p->throttle_node));
>

While adding this change to the new version, I remembered this
enqueue_throttled_task() also gets called for tasks that are going to be
unthrottled on unthrottle path, i.e.

unthrottle_cfs_rq() -> tg_unthrottle_up() -> enqueue_task_fair()

because task's throttled flag is not cleared yet(but throttle_node is
removed from the limbo list so the above warn still works as expected).

I didn't clear p->throttled in tg_unthrottle_up() before calling
enqueue_task_fair() because enqueue_throttled_task() will take care of
that but now I look at it, I think it is better to clear p->throttled
before calling enqueue_task_fair(): this saves some cycles by skipping
enqueue_throttled_task() for these unthrottled tasks and
enqueue_throttled_task() only has to deal with migrated throttled task.
This feels cleaner and more efficient. I remember Prateek also suggested
this before but I couldn't find his email now, not sure if I remembered
wrong.

Any way, just a note that I'm going to make below changes to the next
version, let me know if this doesn't look right, thanks.

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 785a15caffbcc..df8dc389af8e1 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5904,6 +5904,7 @@ static int tg_unthrottle_up(struct task_group *tg, void *data)
 	/* Re-enqueue the tasks that have been throttled at this level. */
 	list_for_each_entry_safe(p, tmp, &cfs_rq->throttled_limbo_list, throttle_node) {
 		list_del_init(&p->throttle_node);
+		p->throttled = false;
 		enqueue_task_fair(rq_of(cfs_rq), p, ENQUEUE_WAKEUP);
 	}
 

