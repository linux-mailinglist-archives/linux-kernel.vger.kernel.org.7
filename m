Return-Path: <linux-kernel+bounces-802471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 947B0B452A9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 11:12:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79353543EBA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 09:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E32F130C603;
	Fri,  5 Sep 2025 09:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="PrJjvlkG"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E535309DD8
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 09:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757063289; cv=none; b=pPDL28KcLhDd9M+trJINsJcgcevhmISiCc8crMFC8QAC6dCxYAGk4Xl+j1IgjDbNUZ0olMYd2b3TJbq9aG58SOia8XshyDQwBhARqa0Y2PsXyKKtiT0agGnZ7lcJFH0VbFbbAUgXdKGV761vqDBfZnIgxmex/ySof11zwhiyS8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757063289; c=relaxed/simple;
	bh=1zF4ped0JCfrpWQyfByH3Csxtam+ue4QKqQ7xKEVUIo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WiRCC3QIOMfVmSF/cvyQt0wFfZVWZsCjzq9G1GbW9rhhRfwkuaMnWd5kbN5zpv3mC+x1UNN6H1tbvEvLNw2blmvs3wv+MPRy8rZ0iWoZzs8t3pnJYYJfpAxWRA0RaDPfAdZeSlS9N6bjvc7hyDrlFUvrlZnjYp0cMActxXoZeL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=PrJjvlkG; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-45a1b065d59so11925405e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 02:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757063282; x=1757668082; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xBJDT20pfEXOkjhhpY/VXucFpS1NHhYqFSc/i9LvNFY=;
        b=PrJjvlkGz/Ne4nIpJQbWN5BIO8AZTFUb7QWPeCeYcVn4cUd/kxf0UEjJFMDJSjQvsn
         t5Vpj6MwY4vDoxXp3hPpMbHhDxdyPlH9j+ZEzhMwkSwHnLyHsj3k2NdIMsKl9IBNBWfn
         /KUdsTmWFX+B/vqA6XjsAekaWkWjUegl8w9UotKCF0e0Z46sXsIxTgs3vOEYv9gbeCJa
         xC7Ja7G8A95Dhe/2lHTiqdx6Or0JaVrHvP9dMVh4PySmnHGIJjMXbrT4UuyJv7jPeFVM
         Fwngjudc5wKdXF/6RLu0j0VhdVNR9De6AuyyuoMAFJiiLMOpn2Wdw6mmY9yuJWriBHSh
         JtKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757063282; x=1757668082;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xBJDT20pfEXOkjhhpY/VXucFpS1NHhYqFSc/i9LvNFY=;
        b=TELMfr+3EeA9EUk+jRIq4Iiq4I15gIjZxMR+7kCE2mm/Z0M4LnUJmWSLdDt9DECKMn
         Qmt1eDGTUNM2HYchUAMfpf5EAqRtveKAMGiNkJs/bcKFTdOUlvpJ9T9vIcYkfcJtfoM3
         CdGl8fB3SQ9QObz0PtUaUcZNv0euwcboe4kRZEPU1DLU7SkA0UxqLsmRPvmyHWlno0vY
         PZbUZ/V8QpETXfRPymgT8Wgy72W/KFzkqM+Do+9VGiitPzM6MPePiL/nNiFP4mxtj6XH
         jrGrff9I+2OIMc5yu1cXN5/xeKKoOPs7OmmJ1IQuMLXzNWFDCe0csLNvJ7s1QdQVSo5k
         OBgQ==
X-Gm-Message-State: AOJu0YxrHMlahqv9EtsVskq9eKGhlgm8bHABa3P44LB68si5xhcUw2Pf
	dy5uwfsE+IQj/RcoLuBaauYrDQORJTSUTbXjPgtQ2hY7CenFPT73aPoVLCYd9oosGRiyDRCEhv/
	lCuc8
X-Gm-Gg: ASbGncuovOw+UgZCOUe+To+/W2DQLp0OFCXfHZhQG2TK1eSZKa2ih7rvLZ4frlXXyAI
	hDCFh37cKI/cas17Az9SYUC/lMlmh/yPncC64qjbJ4rcukexzz/tAYIh5RGSHWyJradcyBxDl2Z
	6DjZ7LzPEphu+fY8smWM1Rabyt1Ezk3ddTilv41RMFop0li6yVOELuubvSH5YgbO9lshEqOicCF
	S0ezBr2gmEeCnxWb2+okRHhK4sdNYEV7lrXr8W78pRuwJOtO5Lfe2pEILth52IbdzHV3DP3YuH/
	z+EgRxvj0E2E9HHbFgr9i7N/IZrtFKYZzFX7yEs2abXhAcJ0+ks7jNwfPl8ye1lrlHTmqsYBYwv
	OPr6tB7J8KuUnOqYikoe8v9YqLJ9bf9aIYGzrTD8CWM6D2Gs=
X-Google-Smtp-Source: AGHT+IF70anKgRw6wAGn1dfUgMIB1wbFZ76sqlJNdsBKrD65DfS49bp2Si8SqcEceEqcUooqlqTOMg==
X-Received: by 2002:a05:6000:2283:b0:3d0:e221:8922 with SMTP id ffacd0b85a97d-3d1e04bddc0mr18173649f8f.46.1757063282299;
        Fri, 05 Sep 2025 02:08:02 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b7e7fec07sm311505335e9.10.2025.09.05.02.08.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 02:08:02 -0700 (PDT)
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
Subject: [PATCH 2/2] rcu: WQ_PERCPU added to alloc_workqueue users
Date: Fri,  5 Sep 2025 11:07:47 +0200
Message-ID: <20250905090747.107232-3-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250905090747.107232-1-marco.crivellari@suse.com>
References: <20250905090747.107232-1-marco.crivellari@suse.com>
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
 kernel/rcu/tree.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 659f83e71048..e763c3d1e851 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -4829,10 +4829,10 @@ void __init rcu_init(void)
 	rcutree_online_cpu(cpu);
 
 	/* Create workqueue for Tree SRCU and for expedited GPs. */
-	rcu_gp_wq = alloc_workqueue("rcu_gp", WQ_MEM_RECLAIM, 0);
+	rcu_gp_wq = alloc_workqueue("rcu_gp", WQ_MEM_RECLAIM | WQ_PERCPU, 0);
 	WARN_ON(!rcu_gp_wq);
 
-	sync_wq = alloc_workqueue("sync_wq", WQ_MEM_RECLAIM, 0);
+	sync_wq = alloc_workqueue("sync_wq", WQ_MEM_RECLAIM | WQ_PERCPU, 0);
 	WARN_ON(!sync_wq);
 
 	/* Fill in default value for rcutree.qovld boot parameter. */
-- 
2.51.0


