Return-Path: <linux-kernel+bounces-806292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 41DC5B494A4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 18:03:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BEECD4E1E38
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 16:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F177230CD80;
	Mon,  8 Sep 2025 16:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="IWijZDdr"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D89E18FDDB
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 16:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757347379; cv=none; b=Pzq6OU7KG94QOFaRyc8rwILMZVeUihlJMF3Uxe2N2DgpqmYOwKNO2PBRvtcIp5YIQv1nMK1y8hNrxnFzIc4Aszez1bdUMx5myvPH4iQ4cAMZV7Yr4Y9zhP2RMbmpa03TAy4CMQ3jncVq1a9/Aoup1TRa/tVAyQl82C/G3urj4dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757347379; c=relaxed/simple;
	bh=HZxc6F66+G0PbyVH2yadyP9FcEUJBc5LxZa/NglwtPg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BX6l8JIxNcb3C8bZDOZ31pUJlxMPiMazdct9OeSZJgZmgjCOTenT4HVHj9lN47s9OP3Rn88ScsesZA34nTgLo9h+SRaWZY8U8OYxYzmFvN1EuGW22XfLSo2vp7Gu9rQ+RVqXB07TXN9L3ZpOVyl5gMwBNhKbcxhHUHIdgbT9euc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=IWijZDdr; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45cb5e1adf7so38091665e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 09:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757347375; x=1757952175; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IwyR31UmcDpcvwrohT3/mVpzqIRzkBLSvGxGe00o824=;
        b=IWijZDdr5umf5b8gNiY7MEfWB9sCAV48sjeqLheDeM3bzCswRWpHmLCNwqS8/bW5Nw
         H3AiJspPnt8R5ct3G3bo4hzYN7JZXL8mDbj8C6ZQe8MxNQ7LK7ll+CviwnY4PEwx/5IO
         249J+W0H7qKvtWVSr1AshQ/YYYQW8bQ4nGnUAjJCMIv79cs0ovgKbF2ZOU6AhLTVMiAF
         EEj4xJ/+1xJIX1MLIqBq1bz1xmYFOZymaU9sgEPstDLUONrNKtQvnNeDYsgCpDnk20mJ
         4hnhdY54PPnSJg2a08oQc7cnz3Yj7Pyfd3tOEqLNrUTOYBWP5QbPBqSCBRrIJlqNrlsf
         wZjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757347375; x=1757952175;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IwyR31UmcDpcvwrohT3/mVpzqIRzkBLSvGxGe00o824=;
        b=TLlRSjUgGA84Ojt3SLCmZEoZY7xZGJxco6UweEGAkVsbYdWAwh2uCZOJHRzH0i9qxq
         pRivwDI+UrxaFTaWDy3LfnzNxLWETWekcRJbChpSa+/K3CfI6+jq0Td6OpxKZfgUIrGg
         Mku/gE6I40oGYXIRd+1NMox6urt50lR4UyKHD35cOFL3UWIj5RMkqeyA1FFJn0QuVDaj
         g7GmmSEwSv/AflkV+dfyn4p9Le/jSfikbWm6bSV7NyBXZav+Jw2Wb0Imdqj0Vq39nrGY
         8jpb9wu3Q2QlmUMgl/qq0iVAiQiZ0+I0lB99uWjjW8S6LFngSRnoWDVzjtJs3Ny/F6a7
         foag==
X-Gm-Message-State: AOJu0YxSdaw7EaWxyIvLgH99Ft+gIT7BzOXSGTz5cEuDhzjhl1Ely19m
	LXnVNXjoavL2itHafuFD/aEhZYcYrLBTy8p/mnLaH1yetuDmaxHJRsD086cyPey3ViVTZGB7CjH
	1UKYq
X-Gm-Gg: ASbGnctAI+MG8+BztGLd5vv/eDoYLEd7ppkDOjMEQpC6WOoG6ED27NtGAmXtzx3F3kL
	p4uTDU9uuzM+PpKv2mJMuGQ39RnBbEk8JqnczhdwplQ0Auh2g9/t1XYMjJvjBveAnwz8MtroI34
	/2+i5AvRlF6wTkxVUR/LV77PBQHDVfItQRqvDJOwl/1DS3GmbRm/ZEW+hrKeJiTfm1dKVyJNW5l
	cZk1Bjgd0fC3uMWyFcwvSw309qIHp4rAlCoFg39uHVBYdS+aFm0CqyiD0vXt1BVFcZGZXnEfZjg
	zEQQrbIB3N4t0uAXeEqUzpMr8kk7f8tn3idpLrn4N2KCASrImVbUzKacv94rkFpckutFLaJNeHZ
	S8N3AGaYL5rYSL6xz+DK3rh9rvxoEm05m48md0ODKzgIrVVU=
X-Google-Smtp-Source: AGHT+IHLOU6+4TKAD332EzcBIyoD7KeqXED7b2WNoVJGjyakCj5fEbIKQpRk/M2dyIBXDyvuvvoTdw==
X-Received: by 2002:a05:600c:630e:b0:45d:d8d6:7fcc with SMTP id 5b1f17b1804b1-45dddee5da3mr65643835e9.27.1757347375224;
        Mon, 08 Sep 2025 09:02:55 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45de5eabdb0sm55358075e9.8.2025.09.08.09.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 09:02:54 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Alice Ryhl <aliceryhl@google.com>
Subject: [PATCH v2 0/2] rust: replace use of system_unbound_wq and system_wq
Date: Mon,  8 Sep 2025 18:02:22 +0200
Message-ID: <20250908160224.376634-1-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
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
1)  API refactoring (changes introduced by this series)
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

1) [P 1-2] Replace use of system_wq and system_unbound_wq

        system_wq is a per-CPU workqueue, but his name is not clear.
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

---
Changes in v2:
- added system_percpu() and system_dfl() in order to use the new
  wq defined in the C code.
- fixed misleading paragraph in the commit log (no warnings are currently
  present).

Marco Crivellari (2):
  rust: replace use of system_unbound_wq with system_dfl_wq
  rust: replace use of system_wq with system_percpu_wq

 rust/kernel/workqueue.rs | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

-- 
2.51.0


