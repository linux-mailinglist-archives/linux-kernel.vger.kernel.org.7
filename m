Return-Path: <linux-kernel+bounces-802482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3187B452BA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 11:14:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A61C1C87870
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 09:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE9643112C0;
	Fri,  5 Sep 2025 09:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="KJOJ+Xe2"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C6530E84D
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 09:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757063431; cv=none; b=E+1+3ZU0SRRrJmVxzQ8YOwHILKKqMMQphU5UV0ckPydPuaEMP63LxSllBdy75DKGORDJkPMjEbrLD9FwW6ncjTrDQ8F0yVtnw6qS6q/MXSQ8q4Q52URJ9ImoOiXf6aUnU6esTUhz3rx06kLC7wpcbSOpivM4jH6MofS0t7aHdP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757063431; c=relaxed/simple;
	bh=INrPsOaDPOgTfeCDARaJthcf6XrpCVFPdMENM7Zss0M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bqOVpv0H31kw3LGW4k9TVH9OpaNERmKarSa2ik6Z1KClEEzpkn29sGturiknwSr1MBaq52EgejKrCBcf1vKiO1mciHeK4znwbFkEfRYfFZsrTEVajrMNFMoSYGQfywMaZrRra+lC3HcK+MadofhXS/wbWS0f0qMdkFRgvt0MEuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=KJOJ+Xe2; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-45dd513f4ecso8030555e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 02:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757063427; x=1757668227; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dpdupnX4vfe35A0YWfmfZS06mTiUiX4f85kgJALe7OA=;
        b=KJOJ+Xe2mjmb7bAprSD+QvNniNx6LJpQAws3oMdOOlS31JRYJFQ3RO3FIDZIGn9Qkx
         3mlQlMu9bOdBi4pGIkJoTCv1jjGBzHQE/GkjN9iXjEsNWq/Hh6wTRRhJb0HTCeNuzGSD
         +91cjb7fZ8/WVvB35UT5bQJst7kbHe59GqWtUZIBJqNVOEiICNX5vU7wdWTorrwqctjE
         h/7aD4SQmM5SSXAacg1eEXDV56AVGxpzQMGroDIMNDn7uu/lX/3gqWs1hBxJHQlIfYxl
         teRQ8ZTE2Bkqc454aXgumw6iZ5EF2xhJ5cIrbGdQZJfYZm38FiqRYxZnI6TRXJ3o4ASv
         ln2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757063427; x=1757668227;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dpdupnX4vfe35A0YWfmfZS06mTiUiX4f85kgJALe7OA=;
        b=Hz8elhXCXVh5FXQp71pA7tuENoHiYrAWZ+8TNwkWrYQQ0MkHkDROXvHzcOggLtox4G
         +w0qAZQ8XOA0dOqX7MBaWpBXKEu7yM8EPPmAyqM1VtVvm2c/ubGG1k/x0u7rccLr8r4x
         xGyNqPJq3A8wlL3RwYv2Q069n1wnB/FShH0qxm1oFhh2VxmgceF6mxPU34rhmwAQbgGJ
         8J59kFqkcayPcZ2NxJdKWU1tHT/AQunv5VYZVeSgqTOYghjhzkLj5srXK73OR4fO4s6S
         iTd4PvXsYJjAcM6khdCGj05OV0cHSoftx6U0+iX7PU2gv4zQ49D4HWYFgQgv1LtZFENK
         dPeQ==
X-Gm-Message-State: AOJu0YzImr8ZsXarE7rqmiZs1MSLLpigFcZzEz7an0fyCAzOoRPDr7XY
	BWQhvS5bgSWrdWD6cMX1YgdaRtmQu3gtPKbub5nW2MRDLk3qKpJplq+2zhjmYOX/52AMNtGnrCj
	E9gN3kdQ=
X-Gm-Gg: ASbGncvJb0YFOoQbed3dT3fMBJH+/579t0+MfstPZbiYEXtvBxYt/Vzyj0Ty4o+5Pzr
	bDArhQX2cjiGy9UicKcHdNycms0a3mFzEesQ5ROgyu++291SEyvEDd2Vn4N2LGumHd7iU6kTj1i
	XAqg3zThkFNmu4Eul/I0FZ1Vhm+XRmR+GmqcWBi+FwqUz0SBUdnwBTbWlK1vxXuez2tAY01B7br
	Pnr4dIY6kc5ebjMBJfIFz1DkZiLBsrA63rGOEs7Ek9SAChH7O0X3pfqZIGjwhamKhGRtzMZ9nV/
	bIWnKjybslhVQiSeVxggRIFksVH6sDr391ZJX80MpSvwi0Jey6LFbmrF2UyBZsi3syIIUoata+M
	1SqtbvVSAG63dxfaNxyCbQQKISIjUTo9xabwD+HJvhq919Ng=
X-Google-Smtp-Source: AGHT+IFr+TiMT2uI2Q2nJdE3JgvgpnzZ9ukTZzZnhJP/XpcOI3yrffJHsD8X/7zkbTldBeHaxM0ymA==
X-Received: by 2002:a05:600c:4fcd:b0:456:19eb:2e09 with SMTP id 5b1f17b1804b1-45b85528589mr202725185e9.8.1757063427034;
        Fri, 05 Sep 2025 02:10:27 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45dd4affb6bsm39726915e9.1.2025.09.05.02.10.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 02:10:26 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Subject: [PATCH 0/2] sound: soc: replace wq users and add WQ_PERCPU to alloc_workqueue() users
Date: Fri,  5 Sep 2025 11:10:14 +0200
Message-ID: <20250905091016.109428-1-marco.crivellari@suse.com>
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

Marco Crivellari (2):
  ASoC: replace use of system_unbound_wq with system_dfl_wq
  ASoC: replace use of system_wq with system_percpu_wq

 sound/soc/codecs/aw88081.c          |  2 +-
 sound/soc/codecs/aw88166.c          |  2 +-
 sound/soc/codecs/aw88261.c          |  2 +-
 sound/soc/codecs/aw88395/aw88395.c  |  2 +-
 sound/soc/codecs/aw88399.c          |  2 +-
 sound/soc/codecs/cs42l43-jack.c     |  6 +++---
 sound/soc/codecs/cs42l43.c          |  4 ++--
 sound/soc/codecs/es8326.c           | 12 ++++++------
 sound/soc/codecs/rt5663.c           |  6 +++---
 sound/soc/codecs/wm_adsp.c          |  2 +-
 sound/soc/intel/boards/sof_es8336.c |  2 +-
 sound/soc/sof/intel/cnl.c           |  2 +-
 sound/soc/sof/intel/hda-ipc.c       |  2 +-
 13 files changed, 23 insertions(+), 23 deletions(-)

-- 
2.51.0


