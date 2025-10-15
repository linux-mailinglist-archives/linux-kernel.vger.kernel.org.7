Return-Path: <linux-kernel+bounces-854557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E4B0BDEB1D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 15:15:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6C7219C421C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 13:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51E3732A3D7;
	Wed, 15 Oct 2025 13:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ThP3M69/"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D943277A4
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 13:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760534094; cv=none; b=QaJO+DxvU9b7B24pdZ8qwsNn/VpoZrOmoGnjVIwYLMb9//xJ+zEnS2M+dm61O2gw0rlOjbs6KxhpkfO9MSoUUqe2nWsRDagvHVIKo8lwn/dWgY/5fn6KfrrwkfY5ObIS4JLVpJ8+tFk2M5uSydNW9JyAF9MfmbBukSOtfd2kkqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760534094; c=relaxed/simple;
	bh=GrxznmFcISqmk2Av+PkGc1oo1HHJvomNNcsAqdyM8NI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CAa8U7Zb7dehgp2pi7zuWV6BDmndHcmmJLFG0kdcueT+4C5Qji/2HBVdE/RSfNFblqNRwfTebcISUwfmbH8oWy7pivcb/0DyqNs60YcuHcd09BSJ4oyNnR81MNJsuHqX2dQEuWG7nQrBwH1weHkaBexjc9yVmOWMec7kmANRmFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ThP3M69/; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b60971c17acso5176080a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 06:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760534092; x=1761138892; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pLLYg6VdgHB/OjszsF6ZkrejxYDKjtXRA8u4+Rpa5To=;
        b=ThP3M69/o5+p3icGzWzjDbot1tRqGq2VJMKdfV9cV6lXYCCfyX4TrEPT1DlxgdK0+W
         gI49aVLi0sCmzslUDr9G1oi2dkwXPvdqgJnp9VhnJygli4mEDPTggTZsFq+2igNZ2NmU
         J6R/OjfwChFhnW8wtC0DUouhg2/iVMxTeAE+bzqOhGe34JQg8TGNyI8SQ8w36j/jFRDq
         F3Q4V8QaPaW9JGxBJzYxRemeAIrQPb4GVr5xT61+/sFQybWvW+KIvdZkyPETtZ0tGAvJ
         dHmf/KvXo4vYWXap2bMLywuhHwAIhmdOSb0z4qz4DsGm7cja9dPn3Rx66YbGIcxAnMep
         l2qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760534092; x=1761138892;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pLLYg6VdgHB/OjszsF6ZkrejxYDKjtXRA8u4+Rpa5To=;
        b=NPbiG5v8qBPDiQBp9SkRBZscDLVI3k4cYVBXXbjie0oqqkQVToQrRNsI1TKujpLqt+
         2cz+80oy8I3Oc1oFF3teioPDCDWKozQaaYmlTLt+7nEVRb0G8bqKq9gu8mEK+DQK97Tb
         5fcoy0DCjJQEV1Ttoikd0kkfR1SpVztD+ojWhbXAgS3BSerd87IHq73EDiU4DiKIELpO
         JOvE5ljyg0npcCWw6s9dgnfqg2lKbtMN27x/kP3B3AN1P4he4hGlasTJ8HgmKVaf413e
         L/1nTomfQyt8jv5o2qZ4N7c8dUhBbmD52Fo884PkEdEQEt2GFMmcI3rw2tBEDqDlasd0
         Z3ew==
X-Forwarded-Encrypted: i=1; AJvYcCUiMSNMtrBwKPZRrlFqw7Xs46c8LG+0HkVwAIfduIByv8i+HgQpBwmQqDvwZtqnezjUXLQBUsM+FxajKPQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr6VDv9Yn9HqI9gPRsWrAGnD7QehcDRwSkocMcyzgwfOyF2aqn
	9ukwui64sbjV12xNO/kDOocPZoMEdQJ5mteGd5SAsPkwHc0OpydsusxH4fn5bCLWPQk9LufgGaV
	NIyETsrGK0zQ2jNzKCZjQneNnryv4G74nIQPxo9EPUg==
X-Gm-Gg: ASbGncvrfC08RFS1H+7kU0NHD0dbm6uxsbf98iYHreWwkimGnLeJ+V+qAkQnlChVvHr
	ZEAzLRNkkJPXKOpmDj9SJIsK94xIAeeWwe0o9QdgjJXOn9eWcCxpoe0VwgRM3jKpkoGChgE6hy/
	pCl02ppljDWpgKmxnIErfGPohRS4r349rhHZY3vWJxae5OFECaz3xRg7W9ClKaYdePLuHzLZLIe
	CL7CRrrvqUMCnRy+g2ycer+JTPfKWFkvXSJVZithOakx0RAfBawVBzsy7zKfdk=
X-Google-Smtp-Source: AGHT+IH+62LQlooszbvO6XVchCcIQaJFztYf4RWmSKiI/V7yR6i1nXNHQOvlAmR+JlIBEtLbIKdgRUGPWr0VwzhB5QQ=
X-Received: by 2002:a17:902:ccc4:b0:250:bd52:4cdb with SMTP id
 d9443c01a7336-290272c1971mr316635425ad.32.1760534092073; Wed, 15 Oct 2025
 06:14:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <bc08fcd528bad11311cd25de37962eb1ce0e7879.1760530739.git.peng_wang@linux.alibaba.com>
 <20251015124422.GD3419281@noisy.programming.kicks-ass.net>
In-Reply-To: <20251015124422.GD3419281@noisy.programming.kicks-ass.net>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Wed, 15 Oct 2025 15:14:37 +0200
X-Gm-Features: AS18NWDvPCBfCJCktJyFEkJTMImwZgtPoVLYsgpAT8RZPIQG5E6NtY-ZosREfB8
Message-ID: <CAKfTPtD-RJoMEHSQToF_578KZ=WszR+xStxNghiWpv4asnHBoA@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: Clear ->h_load_next after hierarchical load
To: Peter Zijlstra <peterz@infradead.org>
Cc: Peng Wang <peng_wang@linux.alibaba.com>, mingo@redhat.com, juri.lelli@redhat.com, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, vschneid@redhat.com, vdavydov.dev@gmail.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 15 Oct 2025 at 14:44, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Oct 15, 2025 at 08:19:50PM +0800, Peng Wang wrote:
>
> > We found that the task_group corresponding to the problematic se
> > is not in the parent task_group=E2=80=99s children list, indicating tha=
t
> > h_load_next points to an invalid address. Consider the following
> > cgroup and task hierarchy:
> >
> >          A
> >         / \
> >        /   \
> >       B     E
> >      / \    |
> >     /   \   t2
> >    C     D
> >    |     |
> >    t0    t1
> >
> > Here follows a timing sequence that may be responsible for triggering
> > the problem:
> >
> > CPU X                   CPU Y                   CPU Z
> > wakeup t0
> > set list A->B->C
> > traverse A->B->C
> > t0 exits
> > destroy C
> >                         wakeup t2
> >                         set list A->E           wakeup t1
> >                                                 set list A->B->D
> >                         traverse A->B->C
> >                         panic
> >
> > CPU Z sets ->h_load_next list to A->B->D, but due to arm64 weaker memor=
y
> > ordering, Y may observe A->B before it sees B->D, then in this time win=
dow,
> > it can traverse A->B->C and reach an invalid se.
>
> Hmm, I rather think we should ensure update_cfs_rq_h_load() is
> serialized against unregister_fair_sched_group().

The bug has been reported for v5.10 which probably don't have fixed
done "recently"
commit b027789e5e50 ("sched/fair: Prevent dead task groups from
regaining cfs_rq's")

>
> And I'm thinking that really shouldn't be hard; note how
> sched_unregister_group() already has an RCU grace period. So all we need
> to ensure is that task_h_load() is called in a context that stops RCU
> grace periods (rcu_read_lock(), preempt_disable(), local_irq_disable(),
> local_bh_disable()).
>
> A very quick scan makes me think at the very least the usage in
>
>   task_numa_migrate()
>     task_numa_find_cpu()
>       task_h_load()
>
> fails here; probably more.

