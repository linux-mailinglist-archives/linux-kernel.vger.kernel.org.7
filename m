Return-Path: <linux-kernel+bounces-817821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5C3BB586F8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 23:54:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BE5F4C60F3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 21:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 529902BD02A;
	Mon, 15 Sep 2025 21:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D28e4gFe"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD9C14A4F9
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 21:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757973263; cv=none; b=C1yd+ZTTJ5RW3nLKyDbd1KVPv8YdvE7igBPQmKl7dOztD5Tb2JgTeHievfwtcR3tAcKDkFqRGQtpzLOf7nDlWLMsW8FpX0g10ppz1SKF9YDxZ0I2cu2pByyOst3AGyA7Q/Dg8GPCWjASduOx3aCG8GwLj+aedumVktLtn+aO52Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757973263; c=relaxed/simple;
	bh=c0Ac7UXWI1v4zUQIuGSwAN/yCyF3esVeFAY1OwrZ6Lk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LA3zbVnFd/3B90MShbjiIhpAEpuh71XlIIQsZh57l7C+HEQlN6xJLlZshGzL6dvQid6x9EJHdfwsaFwdVfSLDt44kek5ZXrQanLPtI7Xasld8LuHipX92XW8HkJ2BMY5j9HYk80Yd3UhKis5wLef/ESTT/OjOLripHoa5Jqm8CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D28e4gFe; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-25669596955so48700535ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 14:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757973261; x=1758578061; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=j42G7OmXgFW89X4IYKFRm0guuNDSmbT9j7wRLbkbUtY=;
        b=D28e4gFezGytvgW98FxA3BRP1ZmsJX92UpyLM119xCpIMQKtM3od/yDb+cALUVa5ut
         wmUKfmXXEFby1JTX2K3rUO1H8d8gZUu8vwuAm/SbqSLKq+UQmrKIuOJNCRA2JiAL2+Vt
         SQVaal9LD10w9bG8CRfrJEfhmX9y3Vo6iqNp+iuBxxpWdcl4JoWJifYMDSqKSRQlSg/X
         Xko2o+k9bvtjvpD+4OznQIvJHblge4M9XWmIZI6nJSNBT5C3OJB+SN/ggYM20CJ81eRZ
         OwUw3WYMEmBkZDTb3w7wAqc1OvKdP/8g84u1z0eL0s4EQeZ83PGdfl9OKLb9hQqYX7hg
         A/6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757973261; x=1758578061;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j42G7OmXgFW89X4IYKFRm0guuNDSmbT9j7wRLbkbUtY=;
        b=RiiJzBQ6XyvOq6WjoNrjrae7RXPM13YOqaWI63IpZV6I7arcRlDFpQNSVHbL9c73/e
         CqQ+UC0ch435cRunAUKtbMWDh9jZu5yrXqtXTf3epVOUGrUMQAYlShkwGaHGW5ZQehPG
         uaIHHhLj6kFWsMT6VyBQYSYMNtyzk5Z9BRkzC+hAItPbw7EASriMEqFQHeABi6rkFM1F
         QPBqxqSdReAXvh85K8Ixdau+dXdK7JFWtha3/8sH6OeN3T/gQrxeos+t5t+otsgrzbe/
         09dAMCIbWtAnzjD1i6afIXNf35mEQGHF5tmm6NtO4TFZMmrIbIwEnlW06LJfyc1yReJm
         qdpQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNgfQow+TQGXHq/vePcMX4TaxzJb2Hzic371iNdztIkMMWnhaqp9Nsy4VJUxUIa7Go30C5wFrd/HOleFc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXqFRsYn6sVIMxphyYDIAhfjyAy/woQQOtCbSiV7D8ocmd8bX2
	1tsrzis4RtRv1q/eCtsB8GPKGE/O5t0C5b9DpBOkL1zAsW70u7m32zMM26rWhRsfPA==
X-Gm-Gg: ASbGnctwDEAtSJ9VBO5Xm43YJMy8/z6JTvBwxYPMrvCN0GhwMA3Vk1duAoPzbeGdY2p
	hf9NLWco2k9Qf6dUsCrQODNfJlSoMoiQplopC2/jZpw5QrpcGVqXR61LMMNqQUM6lM7DfP4wrks
	FmsX4S6dCKgSnKiuHGNnbqX9qrN0tI+c4jTP1Mdaez4JKTjDV3yC4K7srHc1uF5RIoBFgdJVtm1
	Sfp4bnly9zOjRUKHFEimogWjgrHFtTCyqRCAr+KnIHbtuFCRx2hSq7qNUM9sobCNNBRXbioM3mi
	DqEw1N1Wvoxrqbcwl57Olymhse+AaQdHpqe567sFsKuTsQDc1GYBL6uti8UWoe5tNo+QOZxAuxn
	jfuXcd6Oj+AD4cOsuzJ2zJuIWWjgE612f6ogJlZ+ffUOUv4DgrSeaaVfHA1JUAZ9j5HQh0/JY8o
	qo2lMtkM/kVvq6VXE=
X-Google-Smtp-Source: AGHT+IHOALXQ5l9whnE27aAEgqy+VYLSBRR+HzCpEHOqxBWhJ3bkq0EcBRzSX7y/4E/VKPsCthw9/w==
X-Received: by 2002:a17:902:ce08:b0:267:776b:a31a with SMTP id d9443c01a7336-267776ba376mr52086555ad.29.1757973261250;
        Mon, 15 Sep 2025 14:54:21 -0700 (PDT)
Received: from bsegall-glaptop.localhost (c-76-132-13-32.hsd1.ca.comcast.net. [76.132.13.32])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77607a6a10fsm14000037b3a.46.2025.09.15.14.54.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 14:54:20 -0700 (PDT)
From: Benjamin Segall <bsegall@google.com>
To: Aaron Lu <ziqianlu@bytedance.com>
Cc: Valentin Schneider <vschneid@redhat.com>,  K Prateek Nayak
 <kprateek.nayak@amd.com>,  Peter Zijlstra <peterz@infradead.org>,
  Chengming Zhou <chengming.zhou@linux.dev>,  Josh Don
 <joshdon@google.com>,  Ingo Molnar <mingo@redhat.com>,  Vincent Guittot
 <vincent.guittot@linaro.org>,  Xi Wang <xii@google.com>,
  linux-kernel@vger.kernel.org,  Juri Lelli <juri.lelli@redhat.com>,
  Dietmar Eggemann <dietmar.eggemann@arm.com>,  Steven Rostedt
 <rostedt@goodmis.org>,  Mel Gorman <mgorman@suse.de>,  Chuyi Zhou
 <zhouchuyi@bytedance.com>,  Jan Kiszka <jan.kiszka@siemens.com>,  Florian
 Bezdeka <florian.bezdeka@siemens.com>,  Songtang Liu
 <liusongtang@bytedance.com>,  Chen Yu <yu.c.chen@intel.com>,  Matteo
 Martelli <matteo.martelli@codethink.co.uk>,  Michal =?utf-8?Q?Koutn=C3=BD?=
 <mkoutny@suse.com>,  Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 0/4] Task based throttle follow ups
In-Reply-To: <20250910095044.278-1-ziqianlu@bytedance.com> (Aaron Lu's message
	of "Wed, 10 Sep 2025 17:50:40 +0800")
References: <20250910095044.278-1-ziqianlu@bytedance.com>
Date: Mon, 15 Sep 2025 14:54:19 -0700
Message-ID: <xm26348ntm9g.fsf@google.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Aaron Lu <ziqianlu@bytedance.com> writes:

> Peter noticed the inconsistency in load propagation for throttled cfs_rq
> and Ben pointed out several other places regarding throttled cfs_rq that
> could be no longer needed after task based throttle model.
>
> To ease discussing and reviewing, I've come up with this follow up
> series which implements the individual changes.
>
> Patch1 deals with load propagation. According to Peter and Prateek's
> discussion, previously, load propagation for throttled cfs_rq happened
> on unthrottle time but now with per-task throttle, it's no longer the
> case so load propagation should happen immediately or we could lose this
> propagated part.
>
> Patch2 made update_cfs_group() to continue function for cfs_rqs in
> throttled hierarchy so that cfs_rq's entity can get an up2date weight. I
> think this is mostly useful when a cfs_rq in throttled hierarchy still
> has tasks running and on tick/enqueue/dequeue, update_cfs_group() can
> update this cfs_rq's entity weight.
>
> Patch3 removed special treatment of tasks in throttled hierarchy,
> including: dequeue_entities(), check_preempt_wakeup_fair() and
> yield_task_to_fair().
>
> Patch4 inhibited load balancing to a throttled cfs_rq to make hackbench
> happy.
>
> I think patch1 is needed for correctness, patch2-4 is open for
> discussion as there are pros/cons doing things either way. Comments are
> welcome, thanks.
>
> BTW, I also noticed there is the task_is_throttled sched class callback
> and in fair, it is task_is_throttled_fair(). IIUC, it is used by core
> scheduling to find a matching cookie task to run on the sibling SMT CPU.
> For this reason, it doesn't seem very useful if we find it a task that
> is to be throttled so I kept the current implementation; but I guess
> this is also two folded if that to be throttled task is holding some
> kernel resources. Anyway, I didn't write a patch to change it in this
> series, but feel free to let me know if it should be changed.
>
> Aaron Lu (4):
>   sched/fair: Propagate load for throttled cfs_rq
>   sched/fair: update_cfs_group() for throttled cfs_rqs
>   sched/fair: Do not special case tasks in throttled hierarchy
>   sched/fair: Do not balance task to a throttled cfs_rq
>
>  kernel/sched/fair.c | 50 ++++++++++++++++++++++++++++-----------------
>  1 file changed, 31 insertions(+), 19 deletions(-)
>
>
> base-commit: 5b726e9bf9544a349090879a513a5e00da486c14

Yeah, these all make sense to me (with v2 for patch 4).

Reviewed-by: Ben Segall <bsegall@google.com>

