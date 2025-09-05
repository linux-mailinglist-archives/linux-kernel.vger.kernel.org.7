Return-Path: <linux-kernel+bounces-802413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6342EB45232
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 10:56:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0FDC4803DF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 08:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6941B3002B2;
	Fri,  5 Sep 2025 08:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="IcprrIPu"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C633F27FB27
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 08:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757062522; cv=none; b=I8HleU8WmCWp+elgkQcUJxjk+1AtRPzPQmyslclv9cuvPlobgugJGyJpn7hsZ7t+UgjKSnx4sPrghmtGcNSFH3lPkdBHO6yLUddeAn169JvssUqtIF4TCIniYd9I8U9OIj35vn8Gh/WUHh4BAr6vAgTzM8Pu9ZVC+L61xDJ83Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757062522; c=relaxed/simple;
	bh=ZNmTX3oAdF44H3USpk7f7fW//sb77ehYji7toAjzm70=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dns1ERYc7GcwccKAmIEjPikbTxR5Agva1QzHKrhV1j76tMch02vzBE61MV14bpGZCvccZXf/CC4ZuIFtsYNXO8/V2E589C53XxY31Uw+1wtAo/BHvHj3RU0EpyyfjV9V4G8+ployq1a33ADL/tfW+gb5s5a7jk2jcqBE1xsC2WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=IcprrIPu; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-45b8b8d45b3so17916425e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 01:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757062518; x=1757667318; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TmD8jC/Hvu39/0Cbcsv+8PlqynIT2eeLiLbe6yPBxLs=;
        b=IcprrIPu1tjHDRYYZMYmOAd00d3I8MIvlXSed3QasEEZJ1Gd6mjitRJj/vHITGSFFN
         Fzd+whucTNh6BV7OxxYV7QU0UdFASbD7amaoGgVnRJRu34r0KampcyaxNwSvpjBmwNAb
         evD9H/cYUV+Wt9XOoTdM+AMtn4eM0iLj+zEsVAvborNwLjiVP4iOk9KJuCZCK6vNfA7B
         itbErYPqScCRLK4GbrogBNprONXmFylqBkNFyh78WfO3BgrfwzL7rkbin/gOQYMzfL47
         YEZehceqtyoQB6Ksawn9ApY+cV50JBqIP06SVZGbKNCyCDzuwVJL+ZaX356YXeufdThg
         fk5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757062518; x=1757667318;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TmD8jC/Hvu39/0Cbcsv+8PlqynIT2eeLiLbe6yPBxLs=;
        b=Cx8lkZfiPaz7ohuTLhB0Yf5VqyNV+D03SyNg/q4auJG9ATvso1GG2ENMHI2pAvslhT
         LVCj0EKxmecVJETSttGKneOwMbecZWbnGMX/yHshqga1samOUkUwh2cHxqkkeLpt+k6m
         f+Zd5jO+O+XpVhdBa9S4h1DnEHRvF6kS/6ZR2sJjZLCMyHVpFYX3NNfZqYMiXYTJIE71
         fY9BuhEXPScJSKGWnARC+S0conjM7EAImjch1aYFxWMGWO/CmpavacLjDjtimHAs1o4E
         7vknhLnSc8eFjTiNFxlMW7+AXXhDvOs2/lr1nMLYdRnAWnnsH0r7yv+zEKCuNtVB/I56
         WYYg==
X-Gm-Message-State: AOJu0YzcEG+Lw1RPcHnlXvvm9X6BxZyjZd6Xd8PkK44BYWmjwhj4Y4eG
	0se3WNk1cJsxDf8Lop28opsbu6iXEf7dbS1V7YC++5qSPrserVX+JbigAzmMVYDRmJknk+sTudz
	yjmit
X-Gm-Gg: ASbGnctzSSlOj5IJBFoDEs4eZmSfeUxZauPzO7nlHhAneDdhYzdZQ9t7VWfDUvXFjNQ
	S4HQR2VrEZ7tDoH5fzi2xeLgAAPE+ERDsBiQIP5cD82utUHcaLjW9uUUvK1VpRVIN+P/t+Kh2Fl
	N8JdR4Et8wwS91bfAwhBuzvJURCbcjorhZlSbYScZRIdxYPyH+B+IVkz/ptm/Fr8buVpEZtLBQY
	8qDkJLor7+vMRmDdM5FqH384zt6yXonqCzy31NJPxBHXIiNSxD9IvKP77SdD0+rek5eSPmANnk/
	teBgoqpE19m/crOmzL9N5Trj5m4jBKnwxcjR2DTMLc9MhHVY0cJ13DOYwPxfxa8hEN/zlpN/t8v
	KVIGGMxvzSTVEGnd885S/ggB5SW044BTdo5lajVpqXQT6TkRFz+icrySP5oFfVjXd8Tft
X-Google-Smtp-Source: AGHT+IHhROF317+2kjAbdQsZUZQMjt0NEFfP1/BNsJKXzDUoqvrYtUTX3aoZfTb6ShDt+JT4bSrlpg==
X-Received: by 2002:a05:6000:230c:b0:3e3:5951:962a with SMTP id ffacd0b85a97d-3e35951994amr1663286f8f.47.1757062517581;
        Fri, 05 Sep 2025 01:55:17 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3d21a32dbc5sm28178346f8f.11.2025.09.05.01.55.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 01:55:17 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Koutny <mkoutny@suse.com>
Subject: [PATCH 0/2] cgroup: replace wq users and add WQ_PERCPU to alloc_workqueue() users
Date: Fri,  5 Sep 2025 10:54:34 +0200
Message-ID: <20250905085436.95863-1-marco.crivellari@suse.com>
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

1) [P 1] Replace use of system_wq

        system_wq is a per-CPU workqueue, but his name is not clear.

        Because of that, system_wq has been renamed in system_percpu_wq.

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
  cgroup: replace use of system_wq with system_percpu_wq
  cgroup: WQ_PERCPU added to alloc_workqueue users

 kernel/cgroup/cgroup-v1.c | 2 +-
 kernel/cgroup/cgroup.c    | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

-- 
2.51.0


