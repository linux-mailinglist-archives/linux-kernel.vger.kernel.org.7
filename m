Return-Path: <linux-kernel+bounces-802419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D68A4B45239
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 10:57:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 789067A9E7B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 08:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4DC43054DC;
	Fri,  5 Sep 2025 08:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="f4nv9kN5"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503793002C4
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 08:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757062639; cv=none; b=ayI0JpE9BqkKiqbnY2UtpUmWJSiCgWr5q2ZJIJtggR7nXsnG32Q56LCDna7bDgXt9C2OU6UlS8OZqZSxHekpLrlHjqOioYv+ocVIyZPJ7M+e2pRyd/BCHt9kdUyckgF9fDrXuiK/xzh0auPukUsXnMre7uJtpHY0rRZI0Ww0Wkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757062639; c=relaxed/simple;
	bh=zuvbcqOLzoPAa32zaS/DgxZj9rgIwsJxCNPUawS/9Lw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=N+EUNu5HbB6lYT+Iurl1iRh8/jEIPSS5epGHdCTbHs1nhs4QUVrgZblf1B1h+EHcV6CSPThruAhlxzZ5+Uuq/wXdVaHBHWQS8xM751yAGee7g6JRmrGOELERHVQXMoQf+Hz7GolhoqtJMCHfAtZkW2GfbjtLckl1mid9/Hk80fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=f4nv9kN5; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-45b804ed966so7566295e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 01:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757062635; x=1757667435; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=znwp4C4v95+qHd2E8LFw+2t+5KgGtZOkmrZsAKEXt/s=;
        b=f4nv9kN50iPQc0D32HBh1II0fKrGO1PQzdB8mmhnBSv8PkU4ckNKrxCx7L2U0rBbi0
         g17of2txVGe8BNSojqvsVSWJLTio/siHYrP5BUcaW+0bKYOkA4WAN7wSSipTY2TwIZco
         TTJefp4GwrJJWfl6DN0ZJ3+GC9E5mzjE/I4Eqv5elI982517K8wSeaRCpGIulhoQ3Tzz
         TdKHYTmSe5nbtrj6A1VRliL10iUYSH9FKGlE0Pq5TPt4mHALD7LSylKDKjhRefnCYU23
         OVfoYl/PTSi5c0z4uvHNUYOUfceXBl/nc8d8HYxfJANJqu1q2G/D4e9nDPSQ797QqeMS
         gvtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757062635; x=1757667435;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=znwp4C4v95+qHd2E8LFw+2t+5KgGtZOkmrZsAKEXt/s=;
        b=roG1q/oC/sqAiGqmgGNVuRFT0r3y8hjYcHPdAx63uZjoOuqFF0VObKWgYJXwCVTAr5
         oLM+GWpH3t5vhBhuyBeHMuTIfvCms/Kqs+pVpncXZ8WUJg5L3MqqBNrzlglq7CTJM39t
         219Xit1OTZ/0K5B1DjAcUeaoeEualcb/m9cQQsV8db73DsB3sgSocZfAVi1EGv0A1M2t
         OEnrIdVMLBNnOkRYiWLhMno/zhnHxvrGHdJ3aHJULyJjBbbKkjx+pgZa9dABe8UOlouG
         /xbIl+z0bpsebfAeQ4ReFmLBj7IvW7t5GSb8FrXPQDjvHTe7xm3d8vrBGo4CiTQoyle0
         Fh0A==
X-Gm-Message-State: AOJu0YycK9rYAz5I0CCWk3rla/TsVfYQDwYawiDKRRe1sKN7cjtIuTyq
	4iYueRBXi7tlS6Ulkd0lAvR3NsLS5LIcI8+xkJ7J4QhPMER5Wm66Rs+i3PyhK+dymwRUCoqr2BZ
	zovoS
X-Gm-Gg: ASbGncvChh2Hsebq80AMOiwl/3yBVxSxm7lr0TWRx36J96mezydqT5RUvG7g+FUNro1
	Gaj+Stjqdw+YrrlAyIcChWGi7QbE984ZYVZldKrgziLIXrSAiaxrstphEDdW4sDrFl4lihdG1HW
	1q50SFiCB64Up5mFu4YdaLZvBD0/pNGAoOIY5jncWSxCvmyNZH6XaH2g6fNtdUWlfK0WFr0nENZ
	PyCPl+OMqbvTMwkjHzn60sgWyIStTvJFR2tqcwjK2GnNbyZdS4qm+oX/hJtFLBfAhxFAUaM1FMY
	rbNlPWczzHLWatQETmWOfVUgYpVoipzAtoGUZsw9wQscMuj1so3pzlxQgZtRmIBLGPsxsWc8SgW
	RJ2Iej+y0wJJUDmzfQIu/SCqYLCCgcsihhS565BZF3p4cRFOa0JFaMaxs/A==
X-Google-Smtp-Source: AGHT+IGuYF2bLdMT7mLcoG6rGpsHYL5+Th0o0eIU2Lcti8x5bljtFqT8i7q4b6d9C9pace17CVL/KQ==
X-Received: by 2002:a05:6000:24c8:b0:3e2:9a5a:1f38 with SMTP id ffacd0b85a97d-3e29a5a21e7mr2177856f8f.50.1757062635243;
        Fri, 05 Sep 2025 01:57:15 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e177488999sm5094989f8f.36.2025.09.05.01.57.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 01:57:14 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	"David S . Miller" <davem@davemloft.net>,
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 0/1] crypto: replace wq users and add WQ_PERCPU to alloc_workqueue() users
Date: Fri,  5 Sep 2025 10:57:00 +0200
Message-ID: <20250905085701.97918-1-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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
  crypto: WQ_PERCPU added to alloc_workqueue users

 crypto/cryptd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

-- 
2.51.0


