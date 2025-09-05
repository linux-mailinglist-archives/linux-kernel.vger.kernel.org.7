Return-Path: <linux-kernel+bounces-802460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65632B45292
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 11:09:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A0DC1C86223
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 09:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42D38301484;
	Fri,  5 Sep 2025 09:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="LP3rIwqg"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7C72868A2
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 09:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757063185; cv=none; b=SBW8aSC68osy62JinuDB1kMKhe3PGLLTdaYUD9X6VdnThWKfI6hzkoCLvMBo471SbYhBUyf68MR4dfHmtpE9HVJxVZ+GSEqGa7Wfc6vSgKf/Ii6hbBE6kjDwQIlgZEqr4FsQ2kkat2dX4dPCzKYklJnRsoNGWPuNSTyP4FXPJGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757063185; c=relaxed/simple;
	bh=dABGYsiKKLOX/Kq8cTybGZ4tHpgS7edgjHmr7Wzii4U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jJfJ0yJJagdnjjTT1GpanVcas4NcoMDP9ahGucedVFU8m406aIy02l3ziIUkmB8VjYZnxb814C5ZU7J37dosaQ8/78b5VKBdCvntzbtVFj6exBhhF9L5U70asNnXHbJak3iiFMmmlViUdVL6/yGaE+LDLcwHOuyC7bUtV/UvpLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=LP3rIwqg; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-45b8b25296fso12131115e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 02:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757063182; x=1757667982; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9HDxgh3qSSs1YrkGcZ/7kjNewL5W1+Cb6Hqr89ZZbwM=;
        b=LP3rIwqgZRuKmfMGJm800xvLv8P5llu5sH+lPQzLUPfPIMslPy+ngLkfkoxa3mjiH+
         H7suXsvVdmN9I1n/0GvdDFXNVpXGrk9TUYs4Q48Hq7XduzGpwaAnKMpA0Tk2BpR+I38U
         NOwvEaU8thdXpgAqdz6pQ9QEWDILYk6cDmMWcrh6ht75tsg/SfrQK/25MQ4lUm1xhaty
         ebkGlO64W5kNPSLtni+eMjjL3LsKuBCNL6U3pc8uY0tPI6nIVfKtSmx5nLRXHU2PCPM4
         /rvJF8AsSooJG/uB6lFxjqUtnMo29/7xRsUgvn7TNI/JOssIqbLvd65Z+CD/+Bq2+a0T
         zMXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757063182; x=1757667982;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9HDxgh3qSSs1YrkGcZ/7kjNewL5W1+Cb6Hqr89ZZbwM=;
        b=HO39L8Ni4ibY9C/gh9BPgxclcbu2hGDJXYQqMtRDjy955PFMPj0zGwbcDIXOuqCdJW
         EJ+0s3YnU2G2ys+7AwaPWrF1M0Vs9O+gnheg9MnCp9alKIIKWxpHZNkBG99RdZPHLaI3
         ZUKIYkHQvX26uZ9Vs9TksUdwLV0VuqyDhmU71+isdNRSMEVIhvIneS/SVamEsZ/pCoGt
         bba4awfXvUGh15/aaR3KyKaDXemChWS6FfpMjeoxFan5yFfXaO+C4nf9THBFXtMEIqRk
         TxVcMwYLy5tkxozb70D7KRqiporfGOLaiqu1hX77IhvYR2ZhxaKB/ZB+AuZV3XSxWoke
         kUvA==
X-Gm-Message-State: AOJu0Yw1hMmXwdcLOTWGCImB2t0/EP4yHw9fSBshqMWXMMIUQan0IUIV
	2WedG2iDa/b/eNUt0NpII7k5m5J7rjLTcFs0MJdu2oAYaxm2MThG5fT0YnXR7xnHblxIo0EAPDV
	r7/+6
X-Gm-Gg: ASbGncu1tsJQUkEs1zj5MkefvaEx6+Sc8RBTS4aodshPmU+9809maB8V8pVTjS5WYuC
	4VsqMKbug7zs9kDNgYFUP/TUmeitLi85cuDJoY+P5r+gvrN63z2wnPj5flAp89B6pneNqRMyN/w
	CVbhsuhzXIsKfYC6k00ORe2Q/KoDxnBoDta3rv5TnXq0DQ999eUbPfc6zJT5eIaaea2easE8fkq
	ncHEZ0f2XSD9pOnUf4QT/mzFzyFOZqIHMjzPK0GJm5IXV2wpmnZQ3X77Uo3oIbE0/5gdc9bL5U6
	rbfw30h2ljLe125aFoX0rcZ/P4J0OnXUBODh4njB/gY/a+kRJXmQijvc3+n8+zpNbM1oaKDep+E
	3TX2vAOtuglg2iY7bjN30DrtleDt8N4xWdTqIx+tz0LD4zE8=
X-Google-Smtp-Source: AGHT+IF5XvCixPDSV9pw9XzuahkIIPM6RFcpr9IFw0jmi4TereK/q8xwd7vHAI9e0FeN8ZyjEyW1+Q==
X-Received: by 2002:a05:600c:45cf:b0:45b:868e:7f80 with SMTP id 5b1f17b1804b1-45dd5d2186cmr22522165e9.8.1757063181775;
        Fri, 05 Sep 2025 02:06:21 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45dcfd000dasm35392835e9.5.2025.09.05.02.06.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 02:06:21 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Len Brown <len.brown@intel.com>
Subject: [PATCH 0/1] power: replace wq users and add WQ_PERCPU to alloc_workqueue() users
Date: Fri,  5 Sep 2025 11:06:01 +0200
Message-ID: <20250905090602.105725-1-marco.crivellari@suse.com>
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

1) [P 1] add WQ_PERCPU to remaining alloc_workqueue() users

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

Marco Crivellari (1):
  PM: WQ_PERCPU added to alloc_workqueue users

 kernel/power/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.51.0


