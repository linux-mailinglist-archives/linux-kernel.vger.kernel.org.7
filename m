Return-Path: <linux-kernel+bounces-770656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E030B27D8B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 11:52:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9FBE1C83F52
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 09:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 501EF2E0B5E;
	Fri, 15 Aug 2025 09:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="SK3w2WnP"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F04926E6FF
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 09:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755251332; cv=none; b=hzAbbPjg9Pw4hFW8BvREX9d0LH0QcaJvSGA1Yfn30kmUee5QY5Lyn9KuctpnUnlU97DPefR6mgKWTTvo1dTxwA8HDjsJBLI52MG08gX2rNJiLhlVf+40g2YP32U5MjwoZ85M/+NnI4uiMuIE0oUIZNgx5qcuMGd4+1JlfvdnUuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755251332; c=relaxed/simple;
	bh=3E6ED4kl2DKhLKWFJxIYGkWHCjRL3sD9DQGh6ClBFYo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qvm/1+7AlHYPKLjuXv8uidtw31jnQtcUmrHKAIIWf9tDjtHOtCJbhp9rKxOPy3isl5MAOP5sa8zsT8PWuC6xAN1i/U/nxwC+l94guzZOVpt2Ea/gcpacm6KNgLq8CRoGkb6SwJ5BEHOHbYy/dYC+FjEo0Otj0cAtI5Idyln2cdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=SK3w2WnP; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-45a1b098f43so11529555e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 02:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1755251328; x=1755856128; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3P6GcReFX2IDfezC2PoNMN6XyVd2UvgwDeZlDPyBkh4=;
        b=SK3w2WnPUS0B1OA2KkjXfDUkCfmsASsEDnFmGlGo8q7HYIe889dnzhfUZhTeoZwjvS
         nygDIOeXUVG8/8Roz0kHYIJW2W6ACmy7HrXtj+o0ko4bEjjZ2umXaBzt/YwCIjYhTEYG
         kPXQwvwiGzIZdif8bhylKJrVigocKFiL9+dKx5jivZlM8J7nanpLKvbCP5HT/aFn67Bi
         nzW6+DymuQbpftGo4XKVb26BqzjULvPsuojNKPBWeORHwVg9VXlWVqrFkhXilYrnh7Pk
         kdnIRKH44JeOdSxhEPXdp7DXffb/SZznj+gmo1mrzmsfY5rlsvfIX2ZhZH5J2UP54iy8
         b5nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755251328; x=1755856128;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3P6GcReFX2IDfezC2PoNMN6XyVd2UvgwDeZlDPyBkh4=;
        b=ncKrZLq/4Jz/kLwW/do3rP66ER+EFeqw88plelaWGi0aOfot/yIIDHciATnkY8nAKA
         1ioSjNq0E9eqqa2yZ7jKl2hRzE0ufCOwNwrckoLxZ3/N7DgylitrvCdY6xxuIkIwKe0Y
         xY4YPruYrcGNAhoPlVBRmU6dOrm2is1RwwRS6FVbkN1G25RaqvTB1mIRoDo6a49/uKKl
         He9zDjfAETPWzCnUiIr2ny/OwW6wTTEicktQR/IVxubElGbdlps3hUcSzE+ja0K6qTfe
         /toGK/bxLMCPLkyw4mJImOCku3CwKtz+Waovjpzu0HWnSbM/jKVIQFXURVzTEd4wqcMU
         ppJg==
X-Gm-Message-State: AOJu0YyCIZqjv3kQDMVvNq1bZqJbQOn1rXXYXvxgFKrF1dHbi2NzVRdB
	EFMoz0B2Qz4PtI6Uoe88XnGW2WTrFRkNTyUj4xerfTO5IbUAGQpJivFVrAKvzN2Wr5LKSFvYmFp
	2xZym
X-Gm-Gg: ASbGncv+8ZtJ1T63ID+BV3qMNcKVuMvmVeVZePASakySj1iYdKNVRDPNdINsQBOdZbk
	tNzoBSPSOmhS9Fp/wCXvZzNhRBj6doLQXjUlc2uDesMdVblk5BeIR0w/b7MHZZaOnYmBAxBAecO
	D390gfmsLVNokyGrpfdGcKFEXKVngj2shOQTA1aFYHG6HchwwBbBLOqDmSr3BCBCm1yvjr9DOdh
	lnxtGwwXKDZ37nu5zH9sogfn0KADnIs/RFs17XG4jWA0hEM2jA/NUtKOuTlOUkihEtaZV7O6fHt
	6mrCA6p5Iw2jtKUWW+U3MSwdB9xunDgrd/w8UwrSlWBhVWF0jfYrYkbo2QkOAmSc5291M0FhsWE
	6U7jerKjYAc+xfzMZkqNK6e9KJCOtmzcsH41r00/tMoDl5PU1Kowa9NiC
X-Google-Smtp-Source: AGHT+IEKsXSkXZ9L5Pc0IUnIlHrfYmoUJRQ1cJv0SPK+GIBQNLQMaGOxhLCoeS/Cd0XzdiYU2v5zKw==
X-Received: by 2002:a05:600c:4f50:b0:456:2a9:f815 with SMTP id 5b1f17b1804b1-45a217fb2bamr14953205e9.4.1755251328498;
        Fri, 15 Aug 2025 02:48:48 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3bb64758441sm1313811f8f.13.2025.08.15.02.48.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 02:48:48 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 0/2] Workqueue: mm: replace use of system_wq and add WQ_PERCPU to alloc_workqueue users
Date: Fri, 15 Aug 2025 11:48:41 +0200
Message-ID: <20250815094843.55377-1-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello!

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
	-	Make more clear and uniform the system wq names, both per-cpu and
		unbound. This to avoid any possible confusion on what should be
		used.

	-	Introduction of WQ_PERCPU: this flag is the complement of WQ_UNBOUND,
		introduced in this patchset and used on all the callers that are not
		currently using WQ_UNBOUND.

		WQ_UNBOUND will be removed in a future release cycle.

		Most users don't need to be per-cpu, because they don't have
		locality requirements, because of that, a next future step will be
		make "unbound" the default behavior.

2)  Check who really needs to be per-cpu
	-	Remove the WQ_PERCPU flag when is not strictly required.

3)  Add a new API (prefer local cpu)
	-	There are users that don't require a local execution, like mentioned
		above; despite that, local execution yeld to performance gain.

		This new API will prefer the local execution, without requiring it.
		
=== Introduced Changes by this patchset ===

1) [P 1] replace use of system_wq with system_percpu_wq (under mm)

		system_wq is a per-CPU workqueue, but his name is not clear.
		system_unbound_wq is to be used when locality is not required.

		Because of that, system_wq has been renamed in system_percpu_wq in the
		mm subsystm (details in the next section).

2) [P 2] add WQ_PERCPU to alloc_workqueue() users (under mm)

		Every alloc_workqueue() caller should use one among WQ_PERCPU or
		WQ_UNBOUND. This is actually enforced warning if both or none of them
		are present at the same time.

		These patches introduce WQ_PERCPU in the mm subsystem 
		(details in the next section).

		WQ_UNBOUND will be removed in a next release cycle.

=== For mm Maintainers ===

If you agree with these changes, one option is pull the preparation changes from
Tejun's wq branch [1].

As an alternative, the patches can be routed through a wq branch.

The preparation changes are described in the present cover letter, under the
"main steps" section. The changes done in summary are:

- add system_percpu_wq and system_dfl_wq, for now without replace the older wq(s)
  (system_unbound_wq and system_wq).
- add WQ_PERCPU flag, currently without removing WQ_UNBOUND; it will be removed
  in a future release cycle.

You can find the aforementioned changes reading:

("Workqueue: add WQ_PERCPU, system_dfl_wq and system_percpu_wq")
https://lore.kernel.org/all/20250614133531.76742-1-marco.crivellari@suse.com/


- [1] git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git WQ_PERCPU

Thanks!

Marco Crivellari (2):
  Workqueue: mm: replace use of system_wq with system_percpu_wq
  Workqueue: mm: WQ_PERCPU added to alloc_workqueue users

 mm/backing-dev.c | 4 ++--
 mm/slub.c        | 3 ++-
 mm/vmstat.c      | 3 ++-
 3 files changed, 6 insertions(+), 4 deletions(-)

-- 
2.50.1


