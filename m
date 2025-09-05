Return-Path: <linux-kernel+bounces-802469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2489B452A6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 11:12:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 303DE169C25
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 09:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E5693093C7;
	Fri,  5 Sep 2025 09:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="CsktbZDU"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5637A3090E6
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 09:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757063284; cv=none; b=fa3mKhNy/DH3nUYUv7C1pyyn+cmOWi/haXgCAIMtLs8e3WK03XugdIM+PmszaaL5Ie7+RyyuRtJPxfxGrufLYFqhXKy7uX8WbjkFhr+ynznN8TpNzUn25ja9k4AyObJb90gdjWof2z5Y77q22cCf4AmsPHa25x1k6mvCPjgBE9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757063284; c=relaxed/simple;
	bh=iFOnnxJrC94LV2LEks6kE1pmEF2x261VyN5f5eLmpgg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CJY7w+8vx2enVhoo8IzS4trrr8C+BbNvOSg9f7FA1valJSJyKLRdhs5imZ/Ld2VXNBkRct8Z0OQImNEROU2Ca/ieV6GFzORdvqynD8LXF/ZQb0mexhxIC8ezSCYtCK3IOVus1tIVQRLJ52/gxpWpp2yF964aPy/S9QarliJKwq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=CsktbZDU; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3e2055ce7b3so903301f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 02:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757063280; x=1757668080; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RMG28cPmINkh9yGK/HjokSpuEVCf8KpRl5KQ/ClSDEs=;
        b=CsktbZDUMLrmFf/KMdU6w0W6C5v7TPUsSEp5al2zyFDMWu9awaduoFqjRnx0N3lGI+
         XRzS1Tj4JZcB4yiSV6ubZMOJUmXmFzEtyyN2sILapCM42dg4oPTlBSz2ru+1qaBmAW+W
         wY6lCIyRa5PwvFv7q5n3nx39QwatebPcOjkwTaQ48+gxJKLRkw8mLnMTYQQopyF3/5n4
         8q0J8EL0hfrHb5bARyigpyXe6ajCIf5uiz8tIdHgRaDfohrKEvbjBSiAGRzB9rvKZQvN
         zHsjiVKx3tPCDBTQu4h2aDryvr/9vGHcJx0zYW+oiTddSB1y4V36wh68DqYYLB+zkL7N
         rPJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757063280; x=1757668080;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RMG28cPmINkh9yGK/HjokSpuEVCf8KpRl5KQ/ClSDEs=;
        b=OoyaNydAITGDTei/0YpEoBpiYov3CKgu8uMrWw3WyIwn8F0vkQxn8taYWnxsh+j0Yu
         K4DHHzBAXxx85HdlYBEweCcnbINylZZhNau/EpaHJjR63a++ON6luW59dxQ2WKPk+Ram
         PFC9GjrSAp6Z2sTSwn0j/Iu4JwgD2BB6CNNh3cGupuMk6wJPzQ3jAtg3h9Y7Jc1HgiwS
         xgvNFDPbPiSxaR7/iEyLLQSOM6Mr43DHeJgZYwjyObltFbj2+3IetxPepFuVuZSbUi8x
         3FyWK2giSVCluCV9GO3lQ3NIua09K3rXdvS7vk2/JKwGylMLSLYMgDZzkdDiIH1LFbsg
         XUUA==
X-Gm-Message-State: AOJu0YzZzQ6eyHFUOayLzbzNM8U0AxD4txD9RQGvuO3/0bEbmvSjFtT2
	s+R34hAGM88joek0bnaXPWrgWAChGMTIGuHSL6wlAHN4QWJW4lyrDHEW6drQaUIyAl7779MgGzJ
	GLNVEJC0=
X-Gm-Gg: ASbGnctaNYuPTvcgjl1vVotm3V6uWN5C8CK8NMuXHbs+AHIs7youi6ucwfbLqeDJ/2u
	v/tOQbPErSIupbLDPxSRw9GSLCstj8ovx0P27zLlLAPdeG9AsIMZrYTX+u+aSwm+7sGgK8WHqLc
	ni6tCD7m7nBTIcLovtCNb3DxNgTw0HGFLeGBrVinIioRbWF903KT/1uLNZ6C95vb7wgk20tOa5f
	czHLlwUzrRTCwSYS9/bc9OG10caWEAyGX6e9Z1XAvLGaTwPEtdi+I/hfcbw5dt/QjqoZ4YHT+Wa
	1H0s2AQ8WZqx+lFVSDVo9YofEbBmbGdYfSXbirfmnCm8miE4sxtcI9MCanpaTa+X2jaOA612MQ+
	+Mj1C1t+7bstaPiBtvx3nL7FYDCJmasD0c4bwElmuRqUP8+gyzjLaqAU2HA==
X-Google-Smtp-Source: AGHT+IHXqencWzdhmJCLzSHG6b957AFApxs+PiiNiGv952XmmQ7dyv023BmoBwStfcQ3i9qpXNojQw==
X-Received: by 2002:a05:6000:200f:b0:3d5:d5ea:38d5 with SMTP id ffacd0b85a97d-3d5d5ea4100mr18390890f8f.25.1757063280428;
        Fri, 05 Sep 2025 02:08:00 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b7e7fec07sm311505335e9.10.2025.09.05.02.07.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 02:08:00 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Jens Axboe <axboe@kernel.dk>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>
Subject: [PATCH 0/2] rcu: replace wq users and add WQ_PERCPU to alloc_workqueue() users
Date: Fri,  5 Sep 2025 11:07:45 +0200
Message-ID: <20250905090747.107232-1-marco.crivellari@suse.com>
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

1) [P 1] Replace use of system_wq

        system_wq is a per-CPU workqueue, but his name is not clear.

        Because of that, system_wq has been renamed in system_percpu_wq..

2) [P 2] add WQ_PERCPU to remaining alloc_workqueue() users

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

Marco Crivellari (2):
  rcu: replace use of system_wq with system_percpu_wq
  rcu: WQ_PERCPU added to alloc_workqueue users

 kernel/rcu/tasks.h | 4 ++--
 kernel/rcu/tree.c  | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

-- 
2.51.0


