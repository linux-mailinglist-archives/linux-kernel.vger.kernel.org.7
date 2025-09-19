Return-Path: <linux-kernel+bounces-824754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22804B8A14E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 16:51:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 564E85A13A6
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 14:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33C81314D39;
	Fri, 19 Sep 2025 14:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="A1+fIz8n"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ABDF3148D4
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 14:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758293458; cv=none; b=QNiOupiGmn4CpUPgDVKY+enHOwtThiFOhhal7fj4LqHt4HuU9XjzAxRiMnCdGMMJkaKzXgnHldgmZbSflIV8HMnCq74LezOtAkuK8c6F+amQFQZPIWVaFP3ubGkZzTk/M5ycA3T/pgWW5bOg9+Lf/SfWUDleqdDpEVi18WOvdj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758293458; c=relaxed/simple;
	bh=PV1pAIQ5r/c1M5gMZ2HohN1y5CIC3ZVhLK658XfNPxw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AqJ1AOHha9j0aL85L2fkXiLXtmdeP6CliMq3ZDoTv54VzpiWJd/LVYANhKj4mSOc9EaTRrN47z/qP4Gc49rx4wFg7JXgyoQOwVl4wf3ux/TYxXUJIEuiKzXk75Fo7NFqTdKWyFdnuQW/b1+2Xoyo49qGLV0CnppDylT68UMb6AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=A1+fIz8n; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-45f29e5e89bso25274145e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 07:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1758293454; x=1758898254; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f7KPemB2n/F5BC+EkjNbWfvGZs7MphH30xFCVibraPw=;
        b=A1+fIz8nzWUpGNFVF49sR1dEHw6QDb7EpaKwIDXcuZicKM2wfWdTgyh6v0G/+SwgSw
         N5VpQczXeXYQtz9O0LmzLKSri5Vn7NHblJ/owXuOk88EAdx+1YmxPV9sMiTF4nCYE62X
         JGdQluOJ89dfdWNRTjgjjkCVa9YU/zY3KmjtjFV2s/EhH24Vna9+vzEMn9cKjhpw26uf
         +v2EKa6s9smKQ3QVVMzXJMJvaa3PqCRl3jNCekRt60mGCNBwNGuqfXDqgvqFAZlsbHrE
         PuFdPL4ZaSblvblXqHjXcDxb935ZyOQZNGGk0wt2uWBqTEXByy5hfyFzEREeTopazOA4
         5TLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758293454; x=1758898254;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f7KPemB2n/F5BC+EkjNbWfvGZs7MphH30xFCVibraPw=;
        b=PxCLHqHse9zDhCYoBrGHG6ZQjE/iFZ+f8b70n29eveArpbcwKnkOO1Xwi6STUQJjTm
         2qcHsV/uO5BIyzsLXeCBwQCJ2wscA5U61jd6lNqQWzauGNd/utZpeIJCmQZW+Xrd1X6s
         3GImW9dXU+zCo0FWUf01FdbK+O3XPtRYbB/+k5XT7mtUSUgBZJtgFUtN9Dz/6t22Q8+Z
         /pVYuHOQ12KpUKtu7fs0JhFvM/6RWafXhMFm7CfTtv0shQsAy3QWtm2ERD45SRghU5iZ
         BpHQKwCP1ncUPBQxL9P6hc2lP4AtxNcACfLiMitmIFR33mOGqs21WamfOsz+jrltwTpb
         1Kgw==
X-Gm-Message-State: AOJu0Yzut38UPmSXeYsVWK5+k1PREFHBWPks1wO9LERyrEiEmAElqBMv
	BtX8hB5rGVj5D8I7/kultPGs1euWZicPFfj9dj+JghdaHnil12qmnGU9WC03c5GV8O93JLIXJuu
	Ceo66D6w=
X-Gm-Gg: ASbGncvc+dYiyVcW3CpabhMWtd5Gk2NwfRbJOK0HiWxxYFnbMCHkbujdnPIgMhLPG58
	Oq6OXu4Dkhcu+jJNTDI15cIliozs+RMhQ3NloKfvwd80eT9iynMpqQYWONBQOvfRa9PsU7WmiN8
	WyuWufdkr1PobgVoBc56CUij3LM6U85S0TBzaXSOZ5dD5AK9ev1/FNRG6kUFEAiAa45crboCN+A
	pm9wvkLf1DjDgKc8rlNdMlK2zl2IeBF2agFFrELJV7rqXzlKWtyY6RIPcXUJasypMIkTogpOmmr
	WVg2WGY3oEm8/C2tG0yqSF5cW9zfv7ASxqXgtYBvRsdGeS/DeJcD8L/tUTDdj64+K7aVNEjbeBg
	biWY0NkjiZMOgTxB4dblWdoAUosfNOVVOz10Sh6woQbbh0g==
X-Google-Smtp-Source: AGHT+IF9CraP+MLmX7L2E45ETGVlK7VJDOImtYV8q1ZaMup6tdlxqtMY+0E+owqXOtOkfQashquiyA==
X-Received: by 2002:a05:600c:470a:b0:45f:29e4:92ff with SMTP id 5b1f17b1804b1-467ea89daccmr39463245e9.17.1758293454299;
        Fri, 19 Sep 2025 07:50:54 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45f325c3c29sm86220025e9.3.2025.09.19.07.50.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 07:50:54 -0700 (PDT)
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
Subject: [PATCH v2 2/3] rcu: WQ_PERCPU added to alloc_workqueue users
Date: Fri, 19 Sep 2025 16:50:38 +0200
Message-ID: <20250919145040.290214-3-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250919145040.290214-1-marco.crivellari@suse.com>
References: <20250919145040.290214-1-marco.crivellari@suse.com>
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
 kernel/rcu/tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 8eff357b0436..4f3175df5999 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -4885,7 +4885,7 @@ void __init rcu_init(void)
 	rcutree_online_cpu(cpu);
 
 	/* Create workqueue for Tree SRCU and for expedited GPs. */
-	rcu_gp_wq = alloc_workqueue("rcu_gp", WQ_MEM_RECLAIM, 0);
+	rcu_gp_wq = alloc_workqueue("rcu_gp", WQ_MEM_RECLAIM | WQ_PERCPU, 0);
 	WARN_ON(!rcu_gp_wq);
 
 	sync_wq = alloc_workqueue("sync_wq", WQ_MEM_RECLAIM, 0);
-- 
2.51.0


