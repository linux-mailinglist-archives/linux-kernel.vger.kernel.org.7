Return-Path: <linux-kernel+bounces-823126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B1F2B8599C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 17:30:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35B361885501
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 15:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5FF530E0E9;
	Thu, 18 Sep 2025 15:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="MC8OHQOX"
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793ED30BF5C
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 15:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758209168; cv=none; b=L17SiRDnBK8XAoUflfLthVlyDK3OBZZ7ZWbq/gAQCJngOOlEvNyHhYOxY/MIUb6DpnQ3CPEoRMJeAkY1mvBHM3xkm9hWxNY9jsRdSJ8k+tLGYXrVM6FrehvXqTnQCnFISG+REFykkA4o1FPoR5B12u+TBDkQmPlFdASNBwHWQ6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758209168; c=relaxed/simple;
	bh=FlFeYK/P8M4DKwGYCpf4qn+yi5CngzOJCfxT1anNwNI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ikcGHnlWOKl0/Jf/ucPYkAz1/KxpjzzRYa4yJo6yTdxj34xAnb93jsSVKsLzjARsLTw+l7WHNArRdn9rL8bWVMKif7Jz5v0uPG8aX1o6ogCnYWq662w1KRPl2h6Z+tKFWZxaF9JY2Iu239zyYmqwsXSzVaUShT4X8fXIP/yWNUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=MC8OHQOX; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-45f2313dd86so9966165e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 08:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1758209164; x=1758813964; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1aAkJlXYKjN6+SVed9mTseivPV6VNBFSloxajZ++CrI=;
        b=MC8OHQOXoQ+cdcSoIrrsHMvskpgVTS0g3V/eVp6jsr6JjLPRpKZA4AUX/pYVnEDBPg
         wfoQd5g7zdJnU40cDwCliyKlLs4lCttIbOqjd9OsYPJ34cw2hSfO9K30VlQNYrfxcauo
         iT/GCLDuss/gKGNSCnsXDgYiiaggsChw5a2LjmfiMvksNAMpfR5pWJzCQx2/8pj+bwl8
         hfixO5zml9R4sa69y1PyWNrPS3rbb7TujNMvBCCCPSSH2OwWgwnvdAF8nzefvNQIhDHC
         eXCwu66GMH1ZL8J4xI4UaSm+nhQdY9GcIUe3zqVa9SUCAfrOQwgialRSJeA5PS9Psg1y
         Zv2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758209164; x=1758813964;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1aAkJlXYKjN6+SVed9mTseivPV6VNBFSloxajZ++CrI=;
        b=g6X61ieWc02x5Z3d7M03Olsxe3S7U5pwRa8D5sqtcRE0amhR75Yy3za50chGHZO5n1
         v8FSLjbB7ivQKJXRKRccFY3Wkd97mdhwo1LIfaQnb++RlbYYAJNnZh12HqlOkRWFKSjO
         imX+ZAYH2sh502hArdT0FmQLPDeqcRzr50doRUDVMZWDUMX1cmMLqMTvA7iKwhr5Gdl2
         qQvIVngKJPOpYkJEf6qna1/Ne6GnWdizRwFi9KTGm/HJnDOt4bbpcGKI/TlhOS1sYS3Y
         5Ghy1BvYNajI/PVkXR9AyP/cH0JURp3CJwFzK82niYn7j9S9aQEtJ4VHEqZwM5gEsD41
         y2+Q==
X-Gm-Message-State: AOJu0Yzlav8OlHHzz/IhQR8rViikxHL20PBaqw6fYm/tEKciiOw9tdZ3
	oJ8KOBv0x1bqf0j/aUSUrtYfFA/dAxAjiHX698EKYjc4RLqA8Yv5AzSXOsRdQ0qTTxyIwM7KhFT
	XoXWvdeKybQ==
X-Gm-Gg: ASbGnctaSP2tAZccLC16QcWh/+cKp54eIt5ieNl/8kFXNHzwANSWNexw6VraMckOVql
	loI1vcijpYayRjfr+e/rP5HR/6uHHKDORX2AXUunvd4zHtXjrwbbLH5g7grT3OmoKc0Q3LfzuOQ
	ySeJkT/1kpGF9HGaGRQABl8RIZfXUFZOGEvPf8d8jcjLsmQvtDOUkH5c+FzyUjPo3nHQY15frqq
	eNT9vyQDCbT4rF9suwLMlPBanvVOH6+osKKf9WYNuwZyYyZIB4NAVbz+JqQ1Njgwik+jzlRmmZf
	c126m6GtieyIB5nRbx+BaGvEpqvaBnTs3xnS4pmMI7Et2reQp86L99Iayi5R309OPBSV0esMkfh
	/Bmy6JGceiJ+HkvnsXx8tuo96ndBt2zpXYilCA/RLuCsYxsQKWj8puY7ocEGm9H6j
X-Google-Smtp-Source: AGHT+IGKQeDkMmIGNMdzWkJiOqAHCaEWxdtONk7V+x9o038PlgKztAxQBaMi7uzRdlQumJ9A00EZHA==
X-Received: by 2002:a05:600c:1554:b0:45d:d6fc:24f7 with SMTP id 5b1f17b1804b1-462074c55cfmr57329525e9.32.1758209164338;
        Thu, 18 Sep 2025 08:26:04 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee073f3d73sm4069815f8f.8.2025.09.18.08.26.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 08:26:04 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Subject: [PATCH 0/2] wifi: replace system_wq and system_unbound_wq uses
Date: Thu, 18 Sep 2025 17:25:15 +0200
Message-ID: <20250918152517.361773-1-marco.crivellari@suse.com>
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

Thanks!

Marco Crivellari (2):
  wifi: iwlwifi: replace use of system_unbound_wq with system_dfl_wq
  wifi: replace use of system_wq with system_percpu_wq

 drivers/net/wireless/intel/ipw2x00/ipw2100.c   | 6 +++---
 drivers/net/wireless/intel/ipw2x00/ipw2200.c   | 2 +-
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c    | 4 ++--
 drivers/net/wireless/intel/iwlwifi/iwl-trans.h | 2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tdls.c  | 6 +++---
 5 files changed, 10 insertions(+), 10 deletions(-)

-- 
2.51.0


