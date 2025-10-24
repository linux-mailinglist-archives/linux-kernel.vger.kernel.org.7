Return-Path: <linux-kernel+bounces-868578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CA80C058BF
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 12:19:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 836003B2923
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 10:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF0B930F81C;
	Fri, 24 Oct 2025 10:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Fx2w/VLi"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B8252F7AD3
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 10:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761301161; cv=none; b=uU+CoqRIKDvFUepfhVYImYRsY6MVHH92CsUMPkYM5UrNSCb7ZmfWfw7q1VeFybZOTH3Cz/ifJpFN+K27/YNdKKXykF9qR5jQu0piIX4qnsxNEbQtq1M27kqv6X7X/gqaWHtnOmSCcABa+RGtpLEzKFT9uxD2qaeMPE+ZB+Z9xyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761301161; c=relaxed/simple;
	bh=xGX0jcu/AxIgrdLkf+RmZm8Zwpl6uc3UXevAS3KvQ2M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PZlppi6t81kiWRl4+e88AonEYkAgs+u6H6f0hEhsDVyTyzlSqly4IwjMm0iltsC4m7xyZge5pn09slaymhZEru1t7u9i+qFLyjwN8y/U6ZxgjocDHvcRPwTfBcsROEgObxMCt1ZzoYrSUCONrbAW+yDpwhGjiWwRaE6lsmXctR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Fx2w/VLi; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-4298b865f84so973623f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 03:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1761301157; x=1761905957; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GKqisNwXTJDZI+wR2RYd28vkkSLGz4FYHLs6Ua2k+3A=;
        b=Fx2w/VLiTysq7ZFfdogGd2iJR21xq7Nb0vUjaqyExfJO5E/89i1j6q2XLl8+d2K6Lq
         1MGhcDu0n6v5ksqdOMgQug5GZY13ketij6CcjauilBksN4F73EWLoILL2nmHfCXsEK4B
         Yx3NNE/ABEe/SQUXRUPgwbc/hnSWCDY7Pu3J6aHyui1OVb7jf/OcMhJN+kCYJz4fSjM9
         lLtU0cLwjBYb1LRrXrAfva59nXY0MxxWiObDYXe6Ya7jTYEK2sAa2DnTmRSzhodti+WR
         iCYtJjlv34pvUvoJ2b28k+SM8JyKJBrEO6k/0zZEWAngRSKvIL9xuSWxR4dBCEgLb8/F
         jzMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761301157; x=1761905957;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GKqisNwXTJDZI+wR2RYd28vkkSLGz4FYHLs6Ua2k+3A=;
        b=r0NUiwc2x+aHFJlh4Vtg8oN6HdYZFPD7xL9EBpl/0WLblVqQuW6gSLDw28m8XuOJLV
         x0ZzVQ1ulCPaFpWqhYUQQ/ZwWZmQ+aJl2Z39jVB+Lx3e+CSnxI30kjoQGib6vRUDY3U0
         0Fni6p2oC5BPPFyJCnosGd8mcumqvYipv2/Jb+Q1SLarWKuDwVpeefJOiaPR9X49Bmhr
         o7kyDQOr27XV75fcib02DUz6Q62C7rEEy7rkbRsVJdWgG8m3+bOBjE8aPNNL+Q+C1XeT
         Je+BJ903RWmXWnZU3Sl+yNi1rBcXTT6YyVYlyI5H2yB/HvjW3xpIFLx+6tc7hjJ7Aw8v
         KX6w==
X-Gm-Message-State: AOJu0YwFX17OUlD9fCqpdHmIwDZHtHoN/rRWvsbejV2SjrsUIF8Bpqhx
	6U8WKN8N6lwkLT6/bNhJo+9cYbOTsJjrZEGlcXbw3A1qji4AlJTVDTekBYJ9lftbava6CufFQE+
	6e8bm
X-Gm-Gg: ASbGncsGpy2CabyZz2pbZDAHOX9X7V6HtlZ3/xnvnYfchi42b7IzhOOZk/mlSQQxNuU
	jYb58GVgs2ibHfDmpma+niBGntMU/U+6PXlZoGAlr7QVI8SVbBrMJ1vo6LB4P2PqUspkTTkAFWu
	/iyrgwaXcZ4cIkcNNVH4P/q9IZZyNd9XU4PlbxUhHj+IGP/ZHOxnEUL6RD1zuvE1V8buGeL+iEY
	Xz0b85QYBe0kZeZNYKcl8a0cCcy1tMaHuSspAf9BHVlmlozQwdwjkIksTaG7D9QByPAYC0Qhoqy
	ywTyYyExIkRoSjUtuNAIFG4FmSpK/NIvr/vQyVbp/9h5LM3A1EJXqE7yMUE3/K3wZBNegUbjWrJ
	REE4C8rdrzCnSG5fLuXzXa8Mz4Cy92NQAJ9pKe+B1JlIjT7MImn3CDN4XaOKrvTqq5tN04afVL5
	Zz1iwuZLeweTBIfVPKroHLK45i0CJhLFsE7tYkUX+ldwj1Rg==
X-Google-Smtp-Source: AGHT+IEDws00kGUBaNvwkWCTMoyO89Z75ce335RgL2/u09yXKLqHieVV6nqxzzHnWoYNmNfkIB4/uw==
X-Received: by 2002:a05:6000:240d:b0:427:854:773 with SMTP id ffacd0b85a97d-4270854086amr15692135f8f.37.1761301156979;
        Fri, 24 Oct 2025 03:19:16 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429897f52aasm8372695f8f.12.2025.10.24.03.19.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 03:19:16 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH 0/3] WQ_PERCPU added to alloc_workqueue(), old wqs replaced
Date: Fri, 24 Oct 2025 12:19:01 +0200
Message-ID: <20251024101904.146351-1-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.0
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

=== Recent changes to the WQ API ===

The following, address the recent changes in the Workqueue API:

- commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
- commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")

The old workqueues will be removed in a future release cycle.

=== Introduced Changes by this series ===

1) [P 1-2] Replace uses of system_wq and system_unbound_wq

    system_wq is a per-CPU workqueue, but his name is not clear.
    system_unbound_wq is to be used when locality is not required.

    Because of that, system_wq has been replaced with system_percpu_wq, and
    system_unbound_wq has been replaced with system_dfl_wq.

2) [P 3] WQ_PERCPU added where relevant

    With the introduction of WQ_PERCPU every alloc_workqueue() caller must
    specify one between WQ_PERCPU or WQ_UNBOUND. This change add the
    WQ_PERCPU flag to the alloc_workqueue() users that do not specify
	WQ_UNBOUND.


Thanks!

Marco Crivellari (3):
  driver core: replace use of system_unbound_wq with system_dfl_wq
  devcoredump: replace use of system_wq with system_percpu_wq
  driver core: WQ_PERCPU added to alloc_workqueue users

 drivers/base/core.c        | 2 +-
 drivers/base/dd.c          | 2 +-
 drivers/base/devcoredump.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

-- 
2.51.0


