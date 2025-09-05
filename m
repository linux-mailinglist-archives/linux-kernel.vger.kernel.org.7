Return-Path: <linux-kernel+bounces-802500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77A2CB452DF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 11:19:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B07317A70A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 09:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1C1C30FF08;
	Fri,  5 Sep 2025 09:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="VVnLmL9X"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96435308F3A
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 09:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757063616; cv=none; b=q1kybaSXpG45pKNqerVqQHb99hbNrxE0WzLa//N4MYG1HHc0MUI199mw02+EA+AByjQ/ht1eLpqDLUOpJ4845P5u7ar3jT2/E70Z27uQywSNv+1Ri+c62nOaaRW7mom9lFUAanHItquSsUxMynZ+CgjWuleXPe0jRku5xs4hWGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757063616; c=relaxed/simple;
	bh=xjej/kYDNqQPebgXT6tHOxX3YBBaZvnjKKNmel41Ees=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nFSw27VCNcoeWsZUXQme7+CsF8W7YaJygRu+hO1mTs3hjbQFmcItCuT2NOuGB7+QH/uhxhh8B+hVUXT3SscyWEasTdXTrXNV3I80UuF9SPMB4Lnafdzw/x8HiCD+U6NDXj8vMDVyhDSGGBGudbHM2Z22l/yTQJXHN3mEXgoSIME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=VVnLmL9X; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3dce6eed889so1545783f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 02:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757063612; x=1757668412; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NQWYKdUrkbucux1r+P71RtTJM5A+HaI/LGMcYLDUFnM=;
        b=VVnLmL9Xz6NMUYRe9085YuDDRcb5fymyEUvgkcg/gEg55hLXq18tD+2n49bKUGKtdc
         oRHDCMBCoTK4ahRG6UkItPfAkle8Eg8LGX+I9BRBG4F1N2t56WlLXyaWwwbB2qB1Hgia
         +1yKDPobTzelrDoQiVr4oc9Oxha0q+7l2FCOmrCLmSjQQkMhxsCnXIL4mXS8nEJ7ObP2
         uibgtESpiLFGcPJ/n/bpY7eQA7euwR8QYP66a4Rp0qgLcyYM3SDXbDBopRAWZO34WQPu
         rmo1pA7sc3T3Wo2to37lKcE2omcEqcPiiL/uFR0fmx38T6DiNXjcL69pvAPt3iZPivLu
         bjTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757063612; x=1757668412;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NQWYKdUrkbucux1r+P71RtTJM5A+HaI/LGMcYLDUFnM=;
        b=pK2lFhsc+xL9YB9ippRk5i1pPctRlj0a91whiahJMpHt8WXmWMfYhY4TlI/wfZ4yc3
         Lq3aeZnaZm+UpzY5znLHjODtT0Kp3ccpVgD15Y2BAJadv6aGaNTY9p/3wxoX7TUEuocs
         ZE6Y6d3wd6HtLoMgRHDWJPeWUUC/HcZ2904YwmkSimH8svzYuGyw13aRxG5nESaWT5md
         7XHBTOKWEGpFR2H3TlbZIQCEyMoooxiwkRKCn6LAD2xGKTn6CYvGC5yQLT+6IG1r7CtN
         4NjOq/jKol/1DW418b8YLdcA5JSOnq3PicEISaR8PFLHB5/6Svloa2pqxmfiXv/FlB7B
         zrJg==
X-Gm-Message-State: AOJu0YyuEnPSdRieYxcBBDmGlXrTMoyIrn6QU3ApZMfCD5Fl1pDoWgJY
	7Rp1ceJcJP8zExEwXUs8/V8Ic31zUXsX6X1F7PieRv5DBaTAB2L+xQ2on3xIFKgAI/FrNhEGru0
	Iga3Pn5M=
X-Gm-Gg: ASbGnct30VMAdpMOJyS4MnPO28RrF6VHiTx72wMdslPMxg8g6He18nABi7D6g2h8gxM
	Kxh7JTcu85+AxPPax/FKOx4dlWzj1p4UidwCCN79kkl1C9jrB2s/IpIT9dCkZyW02o0D/T4R0dN
	cFAw8OnLnqUhyp2x3LwTws3++DW10bAL741PvgPaoIJWoPJXV4FcRAMATvxnPdVYGJt+1WJyiPg
	qCwbVh8AsmIMHM5fS6dp9F6Y5F6Vlm0QZHCUSnquxpSS8vEwUJfghg6JIsjDCOGPX406HPyiAJY
	2T5NflDrGMK1sHlPmmg0QgYiy2AQ5MryRa8Sj6l+23HDmEZ71ahWwTnyK4sP3rjud+4CUKbL5KC
	phyVoSWyNEBUOoSLc2hr+040wHarSLkHWU5haFYQk/QQcGkQ=
X-Google-Smtp-Source: AGHT+IGkyalW/7AUfWYEYQVGRI9yndjzBt4cGgpcgnjB3bjoX5oyDn+icTrep6Omgr9A6Ne9zQOSEQ==
X-Received: by 2002:a05:6000:268a:b0:3da:bf6b:f2f1 with SMTP id ffacd0b85a97d-3dabf6bf39fmr10345579f8f.14.1757063612499;
        Fri, 05 Sep 2025 02:13:32 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e4e2c3fe44sm167477f8f.0.2025.09.05.02.13.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 02:13:32 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>
Subject: [PATCH 0/3] workqueue: replace wq users and add WQ_PERCPU to alloc_workqueue() users 
Date: Fri,  5 Sep 2025 11:13:22 +0200
Message-ID: <20250905091325.112168-1-marco.crivellari@suse.com>
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

1) [P 1-2] Replace use of system_wq and system_unbound_wq

        system_wq is a per-CPU workqueue, but his name is not clear.
        system_unbound_wq is to be used when locality is not required.

        Because of that, system_wq has been renamed in system_percpu_wq, and
        system_unbound_wq has been renamed in system_dfl_wq.

2) [P 3] add WQ_PERCPU to remaining alloc_workqueue() users

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

Marco Crivellari (3):
  workqueue: replace use of system_unbound_wq with system_dfl_wq
  workqueue: replace use of system_wq with system_percpu_wq
  workqueue: WQ_PERCPU added to alloc_workqueue users

 include/linux/workqueue.h | 30 +++++++++++++++---------------
 kernel/workqueue.c        | 23 ++++++++++++-----------
 2 files changed, 27 insertions(+), 26 deletions(-)

-- 
2.51.0


