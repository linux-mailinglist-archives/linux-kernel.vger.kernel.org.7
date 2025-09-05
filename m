Return-Path: <linux-kernel+bounces-802415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D757BB45233
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 10:56:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92EA0A00FB3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 08:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2A5D3054F0;
	Fri,  5 Sep 2025 08:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="MfKvMmhr"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692F62820BA
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 08:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757062524; cv=none; b=OTuyhK7lwjq/IHLjIcoVyzN3FqgW8rlrIpVWgfbVkA77Hk18s0/Qwmasbkep4RjO5fhFdijUYBenVZPtikfYO5vKSfRU6NPrhq+PCHBgMU6Z7nn7d9FvubPz6v9UUFHc1XLIwIH+twDL/yXHyRpA2+TRSy+7MhU9mJoE22vqnO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757062524; c=relaxed/simple;
	bh=W33kCBQrq1sazmSN8/SXjWeRCYxWjdmqGuSQHrjaZxU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SL2LgehAMBOU/nyS+ccVNHGl6nB6QOPn+z1lmYLQziCwa/0ZwTqVqReuyB7jIn5oWTG6O5U79Ie62oS28WhgiJfAgL9QmZQsyL0wy7Vk2dfSny3hfzpbHLVKqzj4ohOb4PdjRwNQYRg8PhtHHb5lqoY3M8mb9127V8Dh1ztppJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=MfKvMmhr; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3dae49b117bso1588133f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 01:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757062519; x=1757667319; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7/ipke7Yn7BBLcOWQazhCZw2ILXfe7LPFnHyae+lwYk=;
        b=MfKvMmhrocqOFWzxyGPDZLFun/HKVeRgNOyc/5vtb3/jMFytRT9Myi7Eoh+ny8Syu2
         XT7rPeIvZJQapBpmQ3cxWmN+5p+mJhiSQetm56Q7vmgl2w3QJDTtUqaOINjvAeJKXzbW
         05GfCnGazWpU9BMhhEPjQ42/dTPuZCeDc5NkcXaRhltNJvHCcsmBpmXF+duZfXumjLiq
         K1NMz3Nxw1RNRSUsknd279cKZk8wpj0vZjni+zXvSf0PnIbELArGEOqrohPMGJJRkpfV
         7tznVPKi4NlmFT0KIWo+HodasA5a9+zMIEq/pQr/8VmPu7y+8HV0YEknoStQOn+s5SDh
         ph2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757062519; x=1757667319;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7/ipke7Yn7BBLcOWQazhCZw2ILXfe7LPFnHyae+lwYk=;
        b=ShK3yui/yZ8ZeqdQzXoukD8fZ+pctceZwxKIGj2UglGsuFtKwppmkhXtyIX2ftlBD1
         ubq9bBYCcsarSxXgopfZbgHlNv4VVlHXeOT7b0t9Ifq8dxEgcM0bd+kB+F2BS4tHhhUU
         y47yepZbm3tj+czDYI8M/j7pCPGfKaw/G1Jaj8Hd549wM3ruz8uF+GDJvOkWX7SMyMz0
         3WLfqZyQqmz05tH2eY3V6pxlYZLpAjMpIIbZx9nBG+eSIB2xKkw1CSyNIliM3LmNrPjm
         fXkWRf0GVQrdIGVh6IlvcJ2vDmmFSkqbnmxXN5DrnsMUcfAqUXeGzBqOfkg9Jzl0+FB1
         p78Q==
X-Gm-Message-State: AOJu0Yx/8xtmZVNS9kKQoDuNMrp7uww0LMoNGMO33Jrcr+woRGhnAdyn
	1EUt/fi1I+zHvFw/Hwe5BK8xpZUpttz6eOZyOwoUB1lqRtQTci3EDQKnOVsSuk0WElliItbfRQu
	1NRW1
X-Gm-Gg: ASbGnctZbr94utfcWyYwdhPe21WjQxf2qGhTal4FrY59M4EOUOCtpDuoqCpEIPbZXjF
	+GYHaBzDr9JUjISxMmLZb1nQnqVGEcxHHWrPsH7XG77sh/SLtZvppgXpgOQkXvSBYMGOOHhalkV
	7/9TwfYdXrXI8kWO76S9d0FNO5xxLt9/6/0UpLviDEc52upLtMPB3bJz4rPAU0ZDxcQYxC3yMdy
	whXhRbCF6tx4wFedwIZS9Xx9DELfqvyRCXc4glIdMFHQE4OvyZNQzRcSRWvw9vzHQM6BLRLwSOs
	hj2Qt6kyKXA+3DOCjNZrt/PwDniqGAbTVcU0lE9z5SD0AEYGuDNviwxtjgCtXaYE7gpk/grLXO0
	uppzD5HsAwA6B3X9zz8Rr60oDrIEviqucc4SjVN1QEber75HI1NsAhwm4oA==
X-Google-Smtp-Source: AGHT+IH1vxXmkmQJCTds9ZYf/rs6uQBCjDIYTyd1wRbv+xHr6msO7l7HeEiqGF0FFDuaxiocSRxd/Q==
X-Received: by 2002:a05:6000:2883:b0:3e4:bec8:dcd3 with SMTP id ffacd0b85a97d-3e4bec8dd01mr369961f8f.42.1757062519375;
        Fri, 05 Sep 2025 01:55:19 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3d21a32dbc5sm28178346f8f.11.2025.09.05.01.55.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 01:55:19 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Koutny <mkoutny@suse.com>
Subject: [PATCH 2/2] cgroup: WQ_PERCPU added to alloc_workqueue users
Date: Fri,  5 Sep 2025 10:54:36 +0200
Message-ID: <20250905085436.95863-3-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250905085436.95863-1-marco.crivellari@suse.com>
References: <20250905085436.95863-1-marco.crivellari@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Currently if a user enqueue a work item using schedule_delayed_work() the
used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
schedule_work() that is using system_wq and queue_work(), that makes use
again of WORK_CPU_UNBOUND.
This lack of consistentcy cannot be addressed without refactoring the API.

alloc_workqueue() treats all queues as per-CPU by default, while unbound
workqueues must opt-in via WQ_UNBOUND.

This default is suboptimal: most workloads benefit from unbound queues,
allowing the scheduler to place worker threads where they’re needed and
reducing noise when CPUs are isolated.

This default is suboptimal: most workloads benefit from unbound queues,
allowing the scheduler to place worker threads where they’re needed and
reducing noise when CPUs are isolated.

This patch adds a new WQ_PERCPU flag to explicitly request the use of
the per-CPU behavior. Both flags coexist for one release cycle to allow
callers to transition their calls.

Once migration is complete, WQ_UNBOUND can be removed and unbound will
become the implicit default.

With the introduction of the WQ_PERCPU flag (equivalent to !WQ_UNBOUND),
any alloc_workqueue() caller that doesn’t explicitly specify WQ_UNBOUND
must now use WQ_PERCPU.

All existing users have been updated accordingly.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 kernel/cgroup/cgroup-v1.c | 2 +-
 kernel/cgroup/cgroup.c    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
index fa24c032ed6f..779d586e191c 100644
--- a/kernel/cgroup/cgroup-v1.c
+++ b/kernel/cgroup/cgroup-v1.c
@@ -1321,7 +1321,7 @@ static int __init cgroup1_wq_init(void)
 	 * Cap @max_active to 1 too.
 	 */
 	cgroup_pidlist_destroy_wq = alloc_workqueue("cgroup_pidlist_destroy",
-						    0, 1);
+						    WQ_PERCPU, 1);
 	BUG_ON(!cgroup_pidlist_destroy_wq);
 	return 0;
 }
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 1e39355194fd..54a66cf0cef9 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -6281,7 +6281,7 @@ static int __init cgroup_wq_init(void)
 	 * We would prefer to do this in cgroup_init() above, but that
 	 * is called before init_workqueues(): so leave this until after.
 	 */
-	cgroup_destroy_wq = alloc_workqueue("cgroup_destroy", 0, 1);
+	cgroup_destroy_wq = alloc_workqueue("cgroup_destroy", WQ_PERCPU, 1);
 	BUG_ON(!cgroup_destroy_wq);
 	return 0;
 }
-- 
2.51.0


