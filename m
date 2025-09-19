Return-Path: <linux-kernel+bounces-824848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D78FB8A4AC
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 17:30:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B54BE7BFE5C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 15:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E08D231A566;
	Fri, 19 Sep 2025 15:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="hDp+3sSm"
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA5331A546
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 15:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758295821; cv=none; b=t8h/pGpDntDVY2Y9q5GINABpy0cB1DQqUEeX2/qYbnD0vbUVHVsfVNH+zYZHbBArfT7NJ3y6w2pcbUt+X4hDnw/0AYaFMUtfXTp6Ymt08AtsOsB8+QwoAI4mBby9eXqnVgLM2FgjEZG/9ky6Ed0iYq571MT2J+z4GenEfabZmSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758295821; c=relaxed/simple;
	bh=gnm9chVz5ZG3NpnAbeiWQiWcPR/Yg+OBKfb9xKaxZec=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fPGZeeYjO8LjaDqcVGJys0+awmdNfGVYRQ7QByymMoVi9zhFo7mct9Af+/C35mO2lr5PqFv+c0RjuBerXzmJMa7KCSkZ0l2aCslrCApTT7Lml2WOwB6Tcoe6p6BxCsEjpvgNG8San0F5mx3Kt9MyFxaH4+U1Xzb0LNtPyeR9zMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=hDp+3sSm; arc=none smtp.client-ip=209.85.221.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f66.google.com with SMTP id ffacd0b85a97d-3f0ae439b56so575594f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 08:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1758295817; x=1758900617; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kpRkKxn7tjXF76vLWsxNTd8HfSJGm7UW72C1XTlcArM=;
        b=hDp+3sSmt4L+qlCELXLijHqtZYeIHVCv2W0I4WreVQ3hXMlHdVFyckMsthO14PiNNK
         p0HNp13IWJfqnPoiFs5wkU2BjNSpYQOFnTwnMKkwhOwDDW5eEAhUX9+HWm0EOsE3PA6L
         Mh1/0ulRmhvSNGKhGyP7ge9IWazjVaOn/i5WpId2q+Gv0+r70lZgS/ouQVtIkwH7QxbV
         FBHg2LvYa1YLd23lOa4rscC+gum9pU9SIrSZv1ojRIQhiEXK1Lu/1JbCcPojcoozEXNZ
         i7h5PuckC0fL7tAN+k5lhrwLgQf6Jct34K00jtnMMb7bqvc9odLmPJtwW8/V+I1Af+0K
         ZBKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758295817; x=1758900617;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kpRkKxn7tjXF76vLWsxNTd8HfSJGm7UW72C1XTlcArM=;
        b=VT6Q9R9h3WVyDHxLvtk1IcD3hg10qEgZCGfcUW60C785m7d7kd11DKxj0qM5bptgaH
         4L4AfaFntzVQww/DPAYLjHt1wR0D+rrS6BrI0DPWDF+y3YQM1d5GADXcVX8YHzGrPiju
         eDpfX4GIKX8+prQ09hZjDH0kWxa1gXAEP7HLGKjOSnaXiFCHqUc9melnbf5eQmDk3CqL
         USp09x6DiBBKU6LJcE5aFvwf7JBPYhEgzt9fh50TeIO6oWWCSWlcIvKfRTj/RvX5ZvDa
         ZO1qpEH2qTNBVAXWbHzcqcgJctuAfm+SIUtvKmMPoEjwV2jItY27Uov++cZA/HagQDcK
         uR7Q==
X-Gm-Message-State: AOJu0Yxw2/IdBLwGP2Ai5grn3Jd7EN4C47XL20t7JSK36KMsLYs2j8UZ
	i+oKfYO1U37j8tbm7dmh/KrS3kUeT3lP1O38v1V1S5tN6TAHjpfyxFZ6S7a7Ft75GoH7V7wXBMD
	58YEQAE05Nw==
X-Gm-Gg: ASbGncu2ZZWD9GI2+t54VXPD/A9oFGVRXYnW81QZi/sL6lwQ7s+WjX8e6TVV5kF2BT8
	dgbJDpdERDTi/9dCTZeVrRJWYpLHsLmO1v/7wcD2Fnp49hQtMWQzwFh3nAaKt2seMQQ9/JKtvJ/
	6/KsUlm/QmC6tqI8PjHjTtsDDmNTrznD8iA7kwA4HFOBHdlcanrgwCQ21CFjs/agCD57GwfX67g
	4D90x7TgI3F0oaRazjUchnKPs/LeR4s4Vx8hyDNmCSVaianalcIa2CXVga5l3vo7Ggf7WF3oNHN
	m2IGx2B655mo5SD1Gy7oy1JaMezHD/ScrC1F3ihCQGDtX9YE3C5Y+60vGo5BYov+amRE9aRVh9f
	fmphMjvW5+Ct38pgacBr4XEDvTC5BJqbqZ2aaqMCe7fDQQQ==
X-Google-Smtp-Source: AGHT+IGGLUHgftanRqnt6pFBM7QU+24mNVwxyAUgdJ5qN+HGMiXatVpfDKxcCdUk2TKtKGgN2DDBGg==
X-Received: by 2002:a05:6000:2911:b0:3e9:b7a5:5dd6 with SMTP id ffacd0b85a97d-3ee83da05camr2855515f8f.40.1758295817190;
        Fri, 19 Sep 2025 08:30:17 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee0fbc7284sm8619156f8f.33.2025.09.19.08.30.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 08:30:16 -0700 (PDT)
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
Subject: [PATCH v2 0/1] PM: WQ_UNBOUND added to pm_wq
Date: Fri, 19 Sep 2025 17:30:07 +0200
Message-ID: <20250919153008.324338-1-marco.crivellari@suse.com>
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

1) [P 1] add WQ_UNBOUND to pm_wq (alloc_workqueue() flag)

        Every alloc_workqueue() caller should use one among WQ_PERCPU or
        WQ_UNBOUND. Add WQ_UNBOUND to pm_wq to make it explicit this wq is
		unbound.

        WQ_UNBOUND will be removed in a next release cycle.


Thanks!


---
Changes in v2:
- WQ_PERCPU removed from pm_wq.

- WQ_UNBOUND has been added to pm_wq to make explicit this wq is unbound.


Marco Crivellari (1):
  PM: WQ_UNBOUND added to pm_wq workqueue

 kernel/power/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.51.0


