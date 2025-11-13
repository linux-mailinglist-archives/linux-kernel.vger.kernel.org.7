Return-Path: <linux-kernel+bounces-899790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9710DC58D76
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 17:47:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0DE62504A11
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 16:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B20635A15B;
	Thu, 13 Nov 2025 16:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="b/q/Zr9E"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C919730BB81
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 16:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763050843; cv=none; b=hAdB/c5lkAkUoN6392rgT7yXMRKUhMhDfptkUmR/2IhhUQyqjFHLlJMdw/AcpqewpOsvPIKuEsd7iM3OXw/tORdLZKnT9jc3LjruONE4JmChyOccjQ6C4CHIJKQdKjP8AUvMoVsd8MaNtnh2PvSQkuw+xDMm8+iIasNXTe+zC7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763050843; c=relaxed/simple;
	bh=35rAosLmASCxkDu1QiQXtPeKjmJ3k4mGMeBMYmKH6EQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=j0C2Con+noswbiWQHVaJcF47q/cMvB/XtIG9pkR6p51U9QTS57w6vuHy6tL78Nq26uZlIc1fUclBcDnMfeUI9gIe7soSisbLvRb1jjJIO0l3b8vjWO6yq9BGuL/YbyjTwzYrD02ZoyLD8et9HnKMGBGVKm35xNPt+f4qnpE+A28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=b/q/Zr9E; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-477632cc932so4903645e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 08:20:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1763050840; x=1763655640; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7xazDthsRCUcKnLYdHaH8ru5Cm7jJ2pThAeDqyEpzeU=;
        b=b/q/Zr9EYHqZs2oSdtQi85H5wnTZ1nM6yh20vUt3PsQ0sqKsNFB/ngoLTTxelK1M/h
         wJ9IN2bTa6422d8PsxfpK1aX5pfRD2tyAXcmru/koJ4Fr9nXvtD69esQJNxOXenKMGUj
         EtCxptw0mr8nIyJdeHr+OCz0qkp9mYft3FWTCtdtsFe1LE97nk7heivfKZbCBOqUsDxS
         5DcoYqsicvD0vHRYJ8oRfjMwAtyAl6ngzGDXoOMqSJIiC9BhaUXgH+Jx9p5TZBcwGK20
         bEnHiX8pgpIiCgnuR5AKZzHN7Jaqb8txG+4YTQEtErrGu1tgxbN0I89DOO+l7wOrIqED
         OwEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763050840; x=1763655640;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7xazDthsRCUcKnLYdHaH8ru5Cm7jJ2pThAeDqyEpzeU=;
        b=qeJlowVewrXBvlwAnbmgwvpm0LE6gKWcFVZ1dRVnrtIAmzZ0l5/mVasdFVx+OW/4pr
         VClZhAWHgJ78k6pjjLUV7zVTsnMPoC2oaPEgHnqNZvzb26vPBqeVZqd7u28pGYxX/sA9
         0Gn0MqcWHT3aFP2WY7nPirjXofL99FWmH70ghTtpXK9XlOQp5rnjbon01dYTojDTznds
         AmNKZYoKTxZ7AGHyzrlZYLlX2RrIqYjLMtmbJtidhUP4aXGGXgAAMjEI92aQs4JySbzZ
         sqbu/xUhlzwD6xP3wEO+ktffl8MIwi0L/765FOFMmTpZmma1lJsrBZex4S+GA/kKGWnO
         OgmQ==
X-Gm-Message-State: AOJu0YzuUsS6oGlM1t9s8UcX88yIZaIDQKqexJ4L0U8iZCvzKV3gadwv
	fwHuEflJUHUXLCcCAplgO9f3VgaPjQ3eq5g7I1lLWsH3bICtMPkfguRKfB/a8E3RMPQ6TffUsL3
	5R4vK
X-Gm-Gg: ASbGncuNPekNcqEb2ilCNdmVyL479eqCrJRaKqtaOQurIf8wDi10iLpnIx2MDVy6TZr
	kp6G2Q9EKlRQH9Yywqk+gySY+WZki/9LdkA/z9Lew13QoJ8iLXqWTENhsrtQtl8OzJiMYWLT+Ss
	Phgp0ZjZZrVE2aafoxdkNMJ61gVSOfLSb4sbCdItHr7J+LRN6L6SVXdemfVViilu/hmFOWgc5G8
	7xk6vdFwJ4u8hIdcC4tanyeTXwVttPeJ/I5QuOzZVdmAEbe1htG/zHoH3CSgDP9X7cVM/Lc5JFD
	7rHagIrBCu+X3/RjFBMA8ZWWu8lvFAhg1uxX3IzpbFAesIs71ziSWPt3BpU8NBIzqLqIrwv2noj
	tNAe+L0/84Qzqw3RNWxV1nqv8ezNxB073zOmH1RNN8e5C426GWiD4KBPq5jYmD0dqttw26gVyBL
	foYknup/T4WxpL8Z2vbaF/vgdn
X-Google-Smtp-Source: AGHT+IFVDrqcYEKVBCodWQj3q2o1v8pmbkPO3/UGmJ1Qg1Sz2D+w7euXqOTQbqbGEXDjlG1IUdJCWQ==
X-Received: by 2002:a05:600c:45c4:b0:477:5c45:8117 with SMTP id 5b1f17b1804b1-4778febac95mr335065e9.41.1763050839756;
        Thu, 13 Nov 2025 08:20:39 -0800 (PST)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53f203afsm4680578f8f.39.2025.11.13.08.20.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 08:20:39 -0800 (PST)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH 0/3] replace system_unbound_wq, add WQ_PERCPU to alloc_workqueue
Date: Thu, 13 Nov 2025 17:20:29 +0100
Message-ID: <20251113162032.394804-1-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

=== Current situation: problems ===

Let's consider a nohz_full system with isolated CPUs: wq_unbound_cpumask is
set to the housekeeping CPUs, for !WQ_UNBOUND the local CPU is selected.

This leads to different scenarios if a work item is scheduled on an
isolated CPU where "delay" value is 0 or greater then 0:
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

This lack of consistency cannot be addressed without refactoring the API.

=== Recent changes to the WQ API ===

The following, address the recent changes in the Workqueue API:

- commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
- commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")

The old workqueues will be removed in a future release cycle.

=== Introduced Changes by this series ===

1) [P 1-2] WQ_PERCPU to alloc_workqueue()

    Add a new WQ_PERCPU flag to explicitly request alloc_workqueue() to be
	per-cpu when WQ_UNBOUND has not been specified.

1) [P 3]  Replace uses of system_unbound_wq

    system_unbound_wq is to be used when locality is not required.

	Switch to using system_dfl_wq because system_unbound_wq is going away as
	part of a workqueue restructuring.


Thanks!

Marco Crivellari (3):
  ath6kl: add WQ_PERCPU to alloc_workqueue users
  cw1200: add WQ_PERCPU to alloc_workqueue users
  wifi: replace use of system_unbound_wq with system_dfl_wq

 drivers/net/wireless/ath/ath6kl/usb.c | 2 +-
 drivers/net/wireless/st/cw1200/bh.c   | 5 +++--
 net/wireless/core.c                   | 4 ++--
 net/wireless/sysfs.c                  | 2 +-
 4 files changed, 7 insertions(+), 6 deletions(-)

-- 
2.51.1


