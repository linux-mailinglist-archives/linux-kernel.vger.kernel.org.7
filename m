Return-Path: <linux-kernel+bounces-802456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97271B452A1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 11:11:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 543327AE0FF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 09:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17A7730DD09;
	Fri,  5 Sep 2025 09:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dbM/Fo3j"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2970127C875
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 09:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757063146; cv=none; b=mOzQMKcozAGU9aqmH27WlZwa56PVS9CtVe009iVOfqw2Agxk+wY/F621+fnOAr2yviDE896Y2MFcUDrapoo2iJB211sAa/Fr+Dpt8w9lCFLS/G08lPzxqnnwLoZtd8dpbpBZwmCbMCeLbtgGW3I4Mqwz/ZyseNYpp2R+sH/Wnd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757063146; c=relaxed/simple;
	bh=7rlP443ba0DDzYK8NU/BhptQqMUCNDKTq2nxVqEIgKs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Bjw1W7ByXeopY98OY63VUoGWOBb6FACqxT0nBRwT63tmgVXfEtEpYcJnNC5EBAscVcvzWKpC3man7gWopZ1DrRvOaNLOEnGLGv+boUyPo8HL+G+K3pgKiVJzEJ15M8qVgFdmOg5cZ6tihc+hOEmHbPG8ph7mXpe0QQKWEyxITF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dbM/Fo3j; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-45b89147cfbso20703205e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 02:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757063142; x=1757667942; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ml6kpLurLHQgzI1MKt6btUcw5MKMOYGSJX0YVkxJgts=;
        b=dbM/Fo3jvneDFejTUcgAPsOVX9e3GKcrX4TcHUYR6nJ9mMCkxH/IzFqBK5resNU32A
         DjDe1lJJXPkyaW5cl4Svva2Mt433yEfDVOpCr3hoN5UKBwmLjRo3q5/d+eFAN17ZGnMU
         +NUlk8XawZb4/IUUsbDZxjG4bJgrk9mylsF/A156zamjr0ZpCelMM8+hmkPA8PMcSTET
         16JLLXE7ssm/p8U/MNDss9g8Rgbv9T6fB/noG9K2sveEWAbIQx6NFALbAWsNAvkjaKfq
         rVWjkS1jbnLPkTc+c6TMCm/Td0J6lgvyVdt5cVpQd7bhm1uFurIzb9zgjgQbkmU94dFr
         UIMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757063142; x=1757667942;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ml6kpLurLHQgzI1MKt6btUcw5MKMOYGSJX0YVkxJgts=;
        b=k3F0KCoIBw400m18STW71zZ80j/ZGGkmY88LnGM+QBzKQtC6e1oRA0uIdLeYLWNqVN
         0CEjFSrnYlPQwkRpq2dUdOQCwXgiNoA6sS81Qi9VANNa7FXxfDaKMkRVA104wDGJcqwS
         n9i3OEf0vjQZDYd9IE+YtP4SL3NBl+37PrdrrsZND0++oa5UeKoOe+P1mC9Fr0su+WQl
         QCXY56awgkqU5+k4bWuc3A23Fe1BGVGj6EoDKc/64m6nBdEfdUhoT1NTx5cWZBSVkGjr
         hYwsOfHCBRbK5FcxKOt5q1nzqzGckJ6mLmFbXMS0KlIgjVsTVbL5ObdhoswtG8KHfAT/
         NQbA==
X-Gm-Message-State: AOJu0Yw2ZhMvD0yvu85Adk2vVycZb8o6l4vx292pP3xiWhhAqw+FG5SZ
	D+ismhFxqHS/jewR3SgdrPTCs/ak7EpAeFZdyirX3xCvw2U4TuwejPmKXMcv8m1Id2QuipDRRwq
	YRntS
X-Gm-Gg: ASbGncs+Q1kEzwL9G+iKn53ApsCeglrkeRlgUWrp6YStEYXSAPIZ8f6J9NU3B6ZwsWN
	8BS8V6dlqyU+wJvm2b2Pu+fOp7aN2XiPawxm9y05nrgG6xDZoxMAlsfQVJBbOL36+F83Eh/Mg9q
	0m2pyuFWuxDqzQKN/QzkXfRbntcyLDn7gwdWzgv7oRG9oiwUP+KTw5PoxBdOjfRm5sGXEgPGhOQ
	mRey5VIX+Tv8Qz+dKhfuUMEiLPDCLsCuST1PN4q7tDqSnrhu82tbn6PkiFNFdoxBRUuTGcYkMDR
	ijDrp8lCOfY+5Me7L3aSnkw5zBpvz2df2p+xide/5Iucova9X+2wHGjlmendqwJ3O7TwamU1xKB
	8mI9eNifIJ/rYQPorGfnigifTrduCjaMkNC++KG5qGzX5/To=
X-Google-Smtp-Source: AGHT+IELzmyy1eL7EyLMHGA3N8GmuzB2XtybSVBENvuBhEJhkQgQeq9bXjwDmrmHtVrOVJjdzy5lMw==
X-Received: by 2002:a05:600c:4710:b0:45b:8adf:cf2b with SMTP id 5b1f17b1804b1-45b8adfd14bmr148467355e9.21.1757063142188;
        Fri, 05 Sep 2025 02:05:42 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45dd0350e80sm68794625e9.22.2025.09.05.02.05.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 02:05:41 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Daniel Jordan <daniel.m.jordan@oracle.com>
Subject: [PATCH 0/2] padata: replace wq users and add WQ_PERCPU to alloc_workqueue() users
Date: Fri,  5 Sep 2025 11:05:31 +0200
Message-ID: <20250905090533.105303-1-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi!

Below is a summary of a discussion about the Workqueue API and cpu isolation
considerations. Details and more information are available here:

        "workqueue: Always use wq_select_unbound_cpu() for WORK_CPU_UNBOUND."
        https://lore.kernel.org/all/20250221112003.1dSuoGyc@linutronix.de/

=== Current situation: problems ===

Let's consider a nohz_full system with isolated CPUs: wq_unbound_cpumask is
set to the housekeeping CPUs, for !WQ_UNBOUND the local CPU is selected.

This leads to different scenarios if a work item is scheduled on an isolated
CPU where "delay" value is 0 or greater then 0:
        schedule_delayed_work(, 0);

This will be handled by __queue_work() that will queue the work item on the
current local (isolated) CPU, while:

        schedule_delayed_work(, 1);

Will move the timer on an housekeeping CPU, and schedule the work there.

Currently if a user enqueue a work item using schedule_delayed_work() the
used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
schedule_work() that is using system_wq and queue_work(), that makes use
again of WORK_CPU_UNBOUND.

This lack of consistentcy cannot be addressed without refactoring the API.

=== Plan and future plans ===

This patchset is the first stone on a refactoring needed in order to
address the points aforementioned; it will have a positive impact also
on the cpu isolation, in the long term, moving away percpu workqueue in
favor to an unbound model.

These are the main steps:
1)  API refactoring (that this patch is introducing)
    -   Make more clear and uniform the system wq names, both per-cpu and
        unbound. This to avoid any possible confusion on what should be
        used.

    -   Introduction of WQ_PERCPU: this flag is the complement of WQ_UNBOUND,
        introduced in this patchset and used on all the callers that are not
        currently using WQ_UNBOUND.

        WQ_UNBOUND will be removed in a future release cycle.

        Most users don't need to be per-cpu, because they don't have
        locality requirements, because of that, a next future step will be
        make "unbound" the default behavior.

2)  Check who really needs to be per-cpu
    -   Remove the WQ_PERCPU flag when is not strictly required.

3)  Add a new API (prefer local cpu)
    -   There are users that don't require a local execution, like mentioned
        above; despite that, local execution yeld to performance gain.

        This new API will prefer the local execution, without requiring it.

=== Introduced Changes by this series ===

1) [P 1] Replace use of system_unbound_wq

        system_unbound_wq is to be used when locality is not required.

        Because of that, system_unbound_wq has been renamed in system_dfl_wq.

2) [P 2] add WQ_PERCPU to remaining alloc_workqueue() users

        Every alloc_workqueue() caller should use one among WQ_PERCPU or
        WQ_UNBOUND. This is actually enforced warning if both or none of them
        are present at the same time.

        WQ_UNBOUND will be removed in a next release cycle.

=== For Maintainers ===

There are prerequisites for this series, already merged in the master branch.
The commits are:

128ea9f6ccfb6960293ae4212f4f97165e42222d ("workqueue: Add system_percpu_wq and
system_dfl_wq")

930c2ea566aff59e962c50b2421d5fcc3b98b8be ("workqueue: Add new WQ_PERCPU flag")


Thanks!

Marco Crivellari (2):
  padata: replace use of system_unbound_wq with system_dfl_wq
  padata: WQ_PERCPU added to alloc_workqueue users

 kernel/padata.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

-- 
2.51.0


