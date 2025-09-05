Return-Path: <linux-kernel+bounces-802492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC137B452CF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 11:17:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90F7516BBEF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 09:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85D6A30C37E;
	Fri,  5 Sep 2025 09:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dUErvWkb"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB67530AD16
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 09:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757063513; cv=none; b=RjxCZ7LI8/HvGc4GBJE3JQkt1yoVtci1BG65t2qhGLQLwuwZ5qaRd3IqTc8Co5k0Sj+5vwzNUUhdbzSDCVk9mpUCEzDEIwCSOvtykjsVQN5MblLHQ0nA8InDFH0dx6MBxvyghwqHRT8anj8aI6PrTbrgGWMi3/0Ko2nrKIlqZ0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757063513; c=relaxed/simple;
	bh=ee08y+FToQ23EV+nOY1gBohX8lWEerJ9I+vvAkfaXYw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Z/OO0C1GlQrY18nrHpY1yL5MNP2aLyaTxHcy2qiOPjobauvqiRRW4NjgD4hpjkxqt2rFmpHhpLaikJYG27Y41rzESYSBlOjdt8LimfN97PbSPJlU+05y92McCH6AF+Q84oxKQ7/WEpyCjSCojL40N3XYQJKSLk6KUN5f8E/94kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dUErvWkb; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45dcff2f313so11649055e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 02:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757063510; x=1757668310; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gfUtMBuIyjImG1NCDDVutuzjLjr8WiqYK5nZGeq/4v8=;
        b=dUErvWkb/H6ztynLkOaTTrWf1g1XNEANegFTzgUpjPiZWxCqPvw/+OI0DXLo839n/G
         tV/wmRZ95AQP3SP4A5VR5e+kD2tA5grBgiKSrRrtZO+bxji2anlBgW7uoqsRXKlbtfni
         WatdncNo1QrzpBrHSS53rEVFJZhSFIbW21i/+l3/GjbhOvqVDjj1XecUn+gfEezuyvyt
         Tc6YMXD+9wRKFj4YO2R5ikpvFady/AL5+xygRJx6SlxkuvXg0bXFHPW5+0osPOlHpT9C
         GzVFFbFMCufOe5tVNf4miLxtcFjXglQwP28nAZMEXvgsv1fEwyVsJoyFZzil5gQxme01
         N8kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757063510; x=1757668310;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gfUtMBuIyjImG1NCDDVutuzjLjr8WiqYK5nZGeq/4v8=;
        b=l4uTDXvVENSZwBbhjigNdO/H9i85kbal3/HlQ31u3VvphtgRk4yP38SQR3GxA723WI
         ogTfjpWaGnzEO14DvNmNHbMVjXaygBoE12kmVH2PPzyJP4IvF9X7dzCVsz3K3MPQ8qtr
         dk/MbTB6QMyjOhLVu8wBrTxj7r/qVzxnCCn+DuHdNw8Kxynd2PvGoOilFoe//p8DJCSP
         vzdmSR3jNEBpzAVmRo58q/MvSscAPimEbgFAL6KF3hrSsSoy+JxuB0Sb7KfWsKyzM/2O
         pPxXsVvO7Vkm2uw93nh47qGVTNfFWDfWltBiEnK9xD7HOjezTeTlDgiHOrwNGsj6P38t
         Crug==
X-Gm-Message-State: AOJu0Ywtisv5/buiNR9zt31ygMs0Ufo2OnskhHonptIrPtOc1TOlcPEn
	ATH10QsEscvH5Aqr6dXvzPlWLb026PK199qBrl4fqF1M/eO6jNbc/m98bcIad3y0n1NZqnw9OFk
	8S002l3I=
X-Gm-Gg: ASbGncuZITfMbVTZgEqYLSKHCpS4o8gOMb7cjb2/lbHX/zw3AZf6rMxuVp7/rX8MU2V
	8VbAzbq/8fn09HpqL6uijVWzCQ/0DC7ui+pbPb5FWe23sykF/tegpkHoIxGhkWH1Q74DOPi6n9O
	zVXMOXunS6b+Br+g2TRYz7QpHZYIyheYK70Xr62AQxVUlxvXWYcS7YDNU2v1QJ3yThF7r/lNuSZ
	x5BYkQ/zQHU+r1+VlBx3EXigtYTYuWlCbzG1BeOl7TBW+sCY4Zq846KeSee3D8lIawn9oR/gkUT
	RQ3WxDg8WJpJmxJeewIjiA27I6EPy7shFt/1SejBdAMdAmmM3AP/AaaGbUCh9lulCMTe+EpDox1
	o+B4ya9UeUfU9Q1c0HipkPTL0zuOUY9bAkvm8Gz8MoF+b5rbkFGt5KtAlzg==
X-Google-Smtp-Source: AGHT+IFmiKbY7rG269eGLgHYnov6lUPs+ErrVyw/cdm+io3s/lLyrlTuJiAd9cb4mPqxxF5nuF8Lfw==
X-Received: by 2002:a05:600c:1994:b0:45d:d68c:2a43 with SMTP id 5b1f17b1804b1-45dd68c2c7fmr16618905e9.33.1757063509721;
        Fri, 05 Sep 2025 02:11:49 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45dda4f2a0dsm13296265e9.2.2025.09.05.02.11.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 02:11:49 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 0/1] KVM: replace wq users and add WQ_PERCPU to alloc_workqueue() users
Date: Fri,  5 Sep 2025 11:11:38 +0200
Message-ID: <20250905091139.110677-1-marco.crivellari@suse.com>
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
  KVM: WQ_PERCPU added to alloc_workqueue users

 virt/kvm/eventfd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.51.0


