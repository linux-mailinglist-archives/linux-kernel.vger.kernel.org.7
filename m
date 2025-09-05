Return-Path: <linux-kernel+bounces-802478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E147B452B4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 11:13:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11B70A63EC1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 09:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 052ED2FD1A4;
	Fri,  5 Sep 2025 09:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="eJuEbq8a"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0862DF71F
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 09:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757063381; cv=none; b=RBz7dXqpXefMq8cXFHRuJZlk0rxysLZephmsyTIL5MPW+z8aC4d5jYbnkHtU87io67UVhGG3QRmzEzfBs9eS0xN2kj1I6rxVIMePz6S1TxYmWvk+Zqi++QHa6zF0RdKZPQqsKfCuHDZ/N/60L0Y+LGvDPy4ZB4y5Aum4eAyqBfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757063381; c=relaxed/simple;
	bh=sSCLt6iYDkYxm7pYWK5vtqGer19gg5Y6rXG+iZJ3TLU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dsAOin2pmL5cV6bmGRw59SiTl/W1Yw30USYjVB8Rlsz25djz5PaQsJW95cJFvH08SQS/grFYvw7iwDhnklcA+EUDrZV/Xbq/XkkrGt4IAvCY295Qt+ced8+aqcsGuTdUrZoZZhaMMQeT0olGF4vvl85bDBOOZLNUsYdBsR2j84c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=eJuEbq8a; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3e014bf8ec1so1386574f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 02:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757063377; x=1757668177; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aEEvGIk2vBLT8Wr5iUZxSI+UswciD2DfqeroWOlApYU=;
        b=eJuEbq8aTHJTLKmp8zz8xIgVL4NBmzpK0QJr7ccsZQkoLVoEzdBpK/Ite3ZG9rFH63
         xIqQXDeHG1zGpHETz6bdID3kSsu8XbSlPKDmVWdvONY05DWzn5h6bt7lO8HZpt1Bvsgj
         3lG0HGXYuJBFjb/8OS57nDejdo3YX87UTd4vnGmBcu0Hl2cvxUtil+7CwNwA9ogPt1w0
         2GmbVhicCvCxkkmvl7CTXoaYvDbmIF1lV9ArcsTUWaWhKRaWqxtbzqpt+bMpCdmvbynM
         ZrTPkp0aqmADGZAhkulVRmqh5YakF7VIlIX8f0aL0kkoNBW1y3+N1yezD/B6wbxmvEhX
         HgvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757063377; x=1757668177;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aEEvGIk2vBLT8Wr5iUZxSI+UswciD2DfqeroWOlApYU=;
        b=PcJzZRCDsyLtu6p3gPk4e/S7RA/MlE//wYV8BxTsbeLVBx7wuB5uo3rvs/jfOWagLi
         H0FPeYSd4nusksaFQh4xSX2foqkHnX+LDkZXdJbpEjBk65sV4BFeAWSLC407hg+6YA3v
         qW/mvZK02VjEMnnLbfC+nWIxPjUsjZu6pVE6Kr/idcbQFfka+5zra0rXIH+tsO5JePiM
         TBMo7RQhF1D/o58O7J280vGnlDGoZ1nLEi77Mr19r09IGdZ9bhqA3qkXONm5bUPOsB1D
         rT4+mmF6ysE7K+Efx9Kv2zYzce+u21ERs6s6XAFQpbA6hnGI/1srTE6UpjGdlnUhQH6J
         3n0A==
X-Gm-Message-State: AOJu0Yzou3nUP9h04QbJXpbI9ygrCpqlD+6vMIqNfGRjHBVuf9KqPpcf
	kj33/QWNJrUZhLu3uVsGScES0PA4MKlttnbIPWqNP7eEElTh7ubqsZwlcjxUOGtyQBG5fcu7lH2
	6/Syodr0=
X-Gm-Gg: ASbGncvqHJXaHQJQ5b3nblBK1qpbqHVuHuN0v2UZWir73zkuq06+feF3Eob+LD34/Y0
	7vO3n66G1eBJHoPLeak0iGilMqEHUtZ3CG484zQNX1aPgqs+rlt/S7fH3geFyUK5PeC+D19TeHm
	GzEnUiiGMVEVN3BeeDzGA/G1AZUrxzM4VWro5Y0Q9RlN9koZ65kFkQKfLdoN+YLxgh9EHVyT7W3
	RfrVzzHQy9MlBNiUFMJJncK5nRV3lSOuc0G34p+sk1rZPaIDmefM40Op2RCdy9+tad8G05sW7lM
	WPj/AohkPqazD+HTz2HWfHilqoeKZeWDzzW7zlP3BLpBy3w7sFOKfmCmSwQ16amalCRmeE31ZOs
	hEuwut8/M/m5g0WO+y2icjhgS+MoaykNl+q9yxx5Cfvg1big=
X-Google-Smtp-Source: AGHT+IHLJ/yrQNE3QeXhR1ZEo5O5dKykmL6OqYbB9WLALTHxCb6GyfRKdQwu+Edj4jHiXsX+MDqi5A==
X-Received: by 2002:a05:6000:643:b0:3d7:d444:da19 with SMTP id ffacd0b85a97d-3d7d444df60mr12787730f8f.55.1757063377414;
        Fri, 05 Sep 2025 02:09:37 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45cb5693921sm120245205e9.0.2025.09.05.02.09.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 02:09:37 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 0/1] sched: replace wq users and add WQ_PERCPU to alloc_workqueue() users
Date: Fri,  5 Sep 2025 11:09:27 +0200
Message-ID: <20250905090928.108703-1-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
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

        Because of that, system_wq has been renamed in system_percpu_wq, and
        system_unbound_wq has been renamed in system_dfl_wq.


=== For Maintainers ===

There are prerequisites for this series, already merged in the master branch.
The commits are:

128ea9f6ccfb6960293ae4212f4f97165e42222d ("workqueue: Add system_percpu_wq and
system_dfl_wq")

930c2ea566aff59e962c50b2421d5fcc3b98b8be ("workqueue: Add new WQ_PERCPU flag")


Thanks!

Marco Crivellari (1):
  sched: replace use of system_unbound_wq with system_dfl_wq

 kernel/sched/core.c | 4 ++--
 kernel/sched/ext.c  | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

-- 
2.51.0


