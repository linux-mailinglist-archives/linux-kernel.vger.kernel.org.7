Return-Path: <linux-kernel+bounces-732304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E1C5B064DD
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 19:05:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8844A164302
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 17:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCFA727F16C;
	Tue, 15 Jul 2025 17:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z0dLuvLT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C287188A3A
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 17:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752599110; cv=none; b=TbQ0hj/p/byG1xp3jNuGBmYAlCXXcbxLfwAMr2TGpwpFSxfY8QvKPE7G2slOnUt6vu+2KGDzhFg8Dwi08ue9n98C3Hd41QVdoF2qFTY6NJDRjn5aIZSnw2ynTx0eARKk0WkoNGORJMEoHvtIdt5pxlDpXh+zs2gOylDmrNxZi1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752599110; c=relaxed/simple;
	bh=LGftwOz9xdJ8GTlkJ1yDeRmkU9qE4GZNp72yeZlYKAI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cIL1mFoi+2HCnMvyPVeQfc/JLuIf4o3C6Pl40MCLwbzfeh6a7xB54bq4BnRlFKctOicJ4j4S3LM9cQJ4+oXn5LylCxAbYQ00ypP/qsyAGrJW1eTHIhF0laRTrzsQC725jspb82w4NmRZM0jHuBCPWLM7KwZ+ghOnm5g8ChY0PQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z0dLuvLT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752599107;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zAnDbQ67WUNb5vEGWH0eEQyGmGIUTf+fd418RGadOXc=;
	b=Z0dLuvLT8/5CyxMre/yU+mrRhj9LyfVRAJ2GbJ8FEiI6x9bCzG3npwu55/AdHCzeuF2uPb
	2Etpt2Nil6PVAuI/N2sg7SbEpvWhLw5ph0A1c+GMWb82pauDLeYRhRb1A4b8ygFft37xr8
	OHNDLdE3t56rdAUUkulALIqouXTzn0o=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-523-8TZFWfMIOOmsTanokT56cw-1; Tue, 15 Jul 2025 13:05:03 -0400
X-MC-Unique: 8TZFWfMIOOmsTanokT56cw-1
X-Mimecast-MFC-AGG-ID: 8TZFWfMIOOmsTanokT56cw_1752599102
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-455f79a2a16so34115635e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 10:05:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752599102; x=1753203902;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zAnDbQ67WUNb5vEGWH0eEQyGmGIUTf+fd418RGadOXc=;
        b=RkZarK/fHYwezo+0rZOaPX8OgUKNVbirmMW25YrMjVp8Zow9MHiIL8Qjj9vrP1lg7n
         H2WENrp27HdKcJcVJOIoqcFwPSW5bEMkFSf71pvYB7yErRdg2BdgnKNxjRtBBZQW24wq
         AOJ+pSNNGUHiTrD0iS7N2lZx1cK3TukCLECOG8lbrPAOzCKV4z4vmCNArWtq7Uot+RAb
         b6j54BEws0x2TKVZNga3Z1ddFu2xpQ5kF+C44xj72Y+767uV+fOJx0q/GPMlTd/dZK8w
         FUabPk1vQbmqK1GxNdq59wDRdSzQuB2XDdA0JN76HssgAL0d2BZnU9MRNHcoiC3ktwj3
         etvQ==
X-Forwarded-Encrypted: i=1; AJvYcCX80aR8bMzKKjOID7ck1vjKXVYjY6T6I8al1B0QD+evf/e+pDrt6Cq/k3zLTc979FJJCBfyqWdNgUlleBY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzHuvoJK3Ui7xGJCQca/JisKXr/bvHR7RPOYhTZIL4VUgy9Iba
	FGanMATRLVfSfNfIJs7kH+Zwf1mdu4iGGZRCcpMPz2+v0CHzlL5bB80C+URLV65/hy01jOunlnf
	w8HAs0XcFinzzwlEpidQm98e0RxcYqsWV8XVNOKy/jE0mIeKFHrMiaBx2sGhttrDG2Q==
X-Gm-Gg: ASbGncvhi4wqbDf024lpoceIMMPUonNT6gpgLkZnougkSAfM1q2uAoGrnwgF6eilQiP
	eJWhRU6hMbopmIiKv2QeY+BK0KUB0EkOCSRNu3TNLEpX2k9kdLoA5huvu6ZLinwW+VqBy61abCV
	/9GkN/+hYNPuqFnnBIsE8XrBQeWHBN//L5KsPyD1ibE+Zy/QIIHYpXA6nrVQSQxm/FfWzWUcL0D
	TBJ8WB0N6c4XM/63v0rjQrQX/wHUd72wYL8SvSo8n29+hbKpBoGdiR3yDaYh5hXOOQfRIf1sBMG
	6WY4UzzyRcm7Jw9mgkaAKWhjx5t9JMjS20tHDKDfyJ6yWLPqtuz8U0xqcR5LMFxZ5dXo5IXLkb5
	hpWkQhLpR2guXZlnR5+r9IdaF
X-Received: by 2002:a05:600c:35cc:b0:456:18d4:5f7b with SMTP id 5b1f17b1804b1-456272e0d75mr38545175e9.9.1752599101969;
        Tue, 15 Jul 2025 10:05:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFAIezpm9SAgTzZxPPYw5CSTTYdWg/ty0muiqb+Tm4cWDbLe8wOiSqTdpL1HxeSG0gV05lTXA==
X-Received: by 2002:a05:600c:35cc:b0:456:18d4:5f7b with SMTP id 5b1f17b1804b1-456272e0d75mr38544545e9.9.1752599101454;
        Tue, 15 Jul 2025 10:05:01 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-135-146.abo.bbox.fr. [213.44.135.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-456101b616csm95533715e9.4.2025.07.15.10.04.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 10:05:00 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Huang Shijie <shijie@os.amperecomputing.com>, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org
Cc: patches@amperecomputing.com, cl@linux.com,
 Shubhang@os.amperecomputing.com, dietmar.eggemann@arm.com,
 rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
 linux-kernel@vger.kernel.org, Huang Shijie <shijie@os.amperecomputing.com>
Subject: Re: [PATCH] sched/fair: do not scan twice in detach_tasks()
In-Reply-To: <20250707083636.38380-1-shijie@os.amperecomputing.com>
References: <20250707083636.38380-1-shijie@os.amperecomputing.com>
Date: Tue, 15 Jul 2025 19:04:58 +0200
Message-ID: <xhsmho6tl1j2d.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 07/07/25 16:36, Huang Shijie wrote:
> When detach_tasks() scans the src_cpu's task list, the task list
> may shrink during the scanning. For example, the task list
> may have four tasks at the beginning, it may becomes to two
> during the scanning in detach_tasks():
>     Task list at beginning : "ABCD"
>     Task list in scanning  : "CD"
>
>     (ABCD stands for differnt tasks.)
>
> In this scenario, the env->loop_max is still four, so
> detach_tasks() may scan twice for some tasks:
>     the scanning order maybe : "DCDC"
>


Huh, a quick hacky test suggests this isn't /too/ hard to trigger; I get
about one occurrence every two default hackbench run (~200ms) on my dummy
QEMU setup.

Have you seen this happen on your workloads or did you find this while
staring at the code?

> The patch introduces "first_back" to record the first task which
> is put back to the task list. If we get a task which is equal to
> first_back, we break the loop, and avoid to scan twice for it.
>

Potentially more than twice, no?

> Signed-off-by: Huang Shijie <shijie@os.amperecomputing.com>
> ---
>  kernel/sched/fair.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 7e2963efe800..0e9c8ae68cc2 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -9443,6 +9443,7 @@ static int detach_tasks(struct lb_env *env)
>  {
>       struct list_head *tasks = &env->src_rq->cfs_tasks;
>       unsigned long util, load;
> +	struct task_struct *first_back = NULL;
>       struct task_struct *p;
>       int detached = 0;
>
> @@ -9481,6 +9482,8 @@ static int detach_tasks(struct lb_env *env)
>               }
>
>               p = list_last_entry(tasks, struct task_struct, se.group_node);

Small comment nit:

                /*
                 * We're back to an already visited task that couldn't be
                 * detached, we've seen all there is to see.
                 */

> +		if (p == first_back)
> +			break;
>
>               if (!can_migrate_task(p, env))
>                       goto next;
> @@ -9562,6 +9565,8 @@ static int detach_tasks(struct lb_env *env)
>                       schedstat_inc(p->stats.nr_failed_migrations_hot);
>
>               list_move(&p->se.group_node, tasks);
> +		if (!first_back)
> +			first_back = p;
>       }
>
>       /*
> --
> 2.40.1


