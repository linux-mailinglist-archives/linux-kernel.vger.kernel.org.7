Return-Path: <linux-kernel+bounces-802447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B7D6B4527D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 11:06:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 867B67ADBDB
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 09:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB81F2E719C;
	Fri,  5 Sep 2025 09:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="E5yUjS8i"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD8128466D
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 09:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757063018; cv=none; b=fLEQbddWFMOJbdQ6dyZVa+AkLguZZ3/E3bbqkhZccW+zMpYofgwpFFtX63m9wNDY6bna6tDtWvuX5KEqsnuF946DNomhr/X8Ai7AXlHbiDpzbKcMbfvJmWR5c4/qe26eTJSWjP9SxBvVAoREjOUrzF1pB+XUTUIr2fDcSlE0y6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757063018; c=relaxed/simple;
	bh=n+KhciNpsuV7q2I8UDIMYtRrlSiTbAdZNFYjuYv2wOw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lvkGHCY9UFo0f46+BmSyLn780Atxy9sROKpvelVUH1TmxRSz0Ut3fzasRhscwba7MSJQGIyJxsfG6y5c9BTQwhl+3Xe0BjjllVVBPyQltIUgSKN+lxuAlO2OAeRXEXSr88hmiJ4cWmNE1CeBsZbAo8NeejXMUE2HaopuUicX9vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=E5yUjS8i; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45b79ec2fbeso13358075e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 02:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757063013; x=1757667813; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OzCSgcP8J/wJxN3+pA5atn3uFy0f4CbQVghrsqERdgY=;
        b=E5yUjS8irUmNGnrWc76G3mAwsqVipd2ISmV0XC9fx4DoiAeRZtuDC8pGQpOQRIQKmY
         Nb5c0Bo5HwDTePARRd+Nu4czD1iTLHLzaGmDNKMPUq175PY8/q4CKtjpd+AC28iYzOjZ
         qQNIfJBqZM2Ni9cRx+Zyd0GnS2gAN0vTbUZCJbUdOdQLD7hz65apV7l0kqSHqmHOVSLB
         N7z7rtVKab/KTRcsRpL7Mtsriw6lfWkpO44N6hemvObbC1SgYp7biB8mTJbHVoZWe6gz
         i4TikLqq4B1UdZjXGwKSFOS5xcVbRLOPq7ugT+mLdxRIQRxe3h3bolgwflndlvjjkjJ2
         lh/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757063013; x=1757667813;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OzCSgcP8J/wJxN3+pA5atn3uFy0f4CbQVghrsqERdgY=;
        b=hBfhQuUnyef2PdZP/VJkilFLLUwh8lUhmpY3Rm2Kp3sPvz9/65N2Og6nEH9zQQyXox
         wIF5R7VzKCM1pNZOJOJPpuT3NEFaGfpauY54ng6CGwkM1YgVjmq1m2fZ6GooPVsgF/NK
         osiBPG8UEPsTEwipg3u9RzbmTqm0e5CB5FywRp637u9alyvSfY1w7STYGrdvon39r1NH
         wS+HvM2I/R9FNzxAnDnQ5YEj2AOV7S6KP4XIZ6KPUzpFztYDFrfkbSxegDjzNld8CqRh
         sPViQfnhvg6z9TGJfk553OIMOgydu+YlTu9Mxlvd8sse8ZQIkh59HhvkjYuF1FDCIIOj
         JuQQ==
X-Gm-Message-State: AOJu0YzAAy6XEsATyFJUmXNvXq44ZMaAES9XKGYih0M/cb4Tu8t7wy1o
	RqBLDrPXn3ZuYDMQ6arf5uxZt4VGb3beU2nAbDnEvHZW9yFRV/x4JEhNkcmW2GLLCuI3W2Fy5Jh
	nzU4v
X-Gm-Gg: ASbGncu8qK2PuGjIv7KfI6oi7E9v7ksbhkCWleSB/c9dWlUQlCW/NflGar64e8oq3qN
	CBhCbZ9cz5aot6oJqmauZcoVi5s4xI/6pVPDno7PXI6DOTHqvPsd41guDP1MlUz3cjA28WYelai
	iM6rmLA0UmwLU3VH6ZJeg+3yycKeTGPOnMlXDn8jHQcNBhEdfRVhdY6zvV5oLKFw2T5xMWgMf54
	N5gpoYbDS1Iclb9xop5fRvu8mPulo3NfRUO701GJT5zdYwlUYYYjaKamciGiwQs7lMjPUy7Aopv
	sLFjd7G2DTh8oximy3PAvOBPYlqTkuLJ1DdO7NZBadi02pRTGZdN63SyRZV0attK0dbKRteHM5M
	valrj8DSyYRuCH7LZLk22d5lCX3ud7DUdzbr0K/ToNNV0Gbs8Vvb+E71ixP/C+bSiN0Q8
X-Google-Smtp-Source: AGHT+IHTJr8AjxhM97DIyH1nX6frQj5Bab2I9iIRm2poKuO46hcNcueAX4sXHhcrkhFS4FnEzpATPA==
X-Received: by 2002:a05:600c:a0a:b0:456:1824:4808 with SMTP id 5b1f17b1804b1-45b855aeb67mr166210085e9.32.1757063013132;
        Fri, 05 Sep 2025 02:03:33 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf3458a67fsm3614543f8f.62.2025.09.05.02.03.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 02:03:32 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 1/3] mm: replace use of system_unbound_wq with system_dfl_wq
Date: Fri,  5 Sep 2025 11:03:21 +0200
Message-ID: <20250905090323.103401-2-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250905090323.103401-1-marco.crivellari@suse.com>
References: <20250905090323.103401-1-marco.crivellari@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently if a user enqueue a work item using schedule_delayed_work() the
used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
schedule_work() that is using system_wq and queue_work(), that makes use
again of WORK_CPU_UNBOUND.

This lack of consistentcy cannot be addressed without refactoring the API.

system_unbound_wq should be the default workqueue so as not to enforce
locality constraints for random work whenever it's not required.

Adding system_dfl_wq to encourage its use when unbound work should be used.

queue_work() / queue_delayed_work() / mod_delayed_work() will now use the
new unbound wq: whether the user still use the old wq a warn will be
printed along with a wq redirect to the new one.

The old system_unbound_wq will be kept for a few release cycles.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 mm/backing-dev.c | 2 +-
 mm/kfence/core.c | 6 +++---
 mm/memcontrol.c  | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index 783904d8c5ef..e9f9fdcfe052 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -934,7 +934,7 @@ void wb_memcg_offline(struct mem_cgroup *memcg)
 	memcg_cgwb_list->next = NULL;	/* prevent new wb's */
 	spin_unlock_irq(&cgwb_lock);
 
-	queue_work(system_unbound_wq, &cleanup_offline_cgwbs_work);
+	queue_work(system_dfl_wq, &cleanup_offline_cgwbs_work);
 }
 
 /**
diff --git a/mm/kfence/core.c b/mm/kfence/core.c
index 102048821c22..f26d87d59296 100644
--- a/mm/kfence/core.c
+++ b/mm/kfence/core.c
@@ -854,7 +854,7 @@ static void toggle_allocation_gate(struct work_struct *work)
 	/* Disable static key and reset timer. */
 	static_branch_disable(&kfence_allocation_key);
 #endif
-	queue_delayed_work(system_unbound_wq, &kfence_timer,
+	queue_delayed_work(system_dfl_wq, &kfence_timer,
 			   msecs_to_jiffies(kfence_sample_interval));
 }
 
@@ -900,7 +900,7 @@ static void kfence_init_enable(void)
 		atomic_notifier_chain_register(&panic_notifier_list, &kfence_check_canary_notifier);
 
 	WRITE_ONCE(kfence_enabled, true);
-	queue_delayed_work(system_unbound_wq, &kfence_timer, 0);
+	queue_delayed_work(system_dfl_wq, &kfence_timer, 0);
 
 	pr_info("initialized - using %lu bytes for %d objects at 0x%p-0x%p\n", KFENCE_POOL_SIZE,
 		CONFIG_KFENCE_NUM_OBJECTS, (void *)__kfence_pool,
@@ -996,7 +996,7 @@ static int kfence_enable_late(void)
 		return kfence_init_late();
 
 	WRITE_ONCE(kfence_enabled, true);
-	queue_delayed_work(system_unbound_wq, &kfence_timer, 0);
+	queue_delayed_work(system_dfl_wq, &kfence_timer, 0);
 	pr_info("re-enabled\n");
 	return 0;
 }
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 421740f1bcdc..c2944bc83378 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -651,7 +651,7 @@ static void flush_memcg_stats_dwork(struct work_struct *w)
 	 * in latency-sensitive paths is as cheap as possible.
 	 */
 	__mem_cgroup_flush_stats(root_mem_cgroup, true);
-	queue_delayed_work(system_unbound_wq, &stats_flush_dwork, FLUSH_TIME);
+	queue_delayed_work(system_dfl_wq, &stats_flush_dwork, FLUSH_TIME);
 }
 
 unsigned long memcg_page_state(struct mem_cgroup *memcg, int idx)
@@ -3732,7 +3732,7 @@ static int mem_cgroup_css_online(struct cgroup_subsys_state *css)
 		goto offline_kmem;
 
 	if (unlikely(mem_cgroup_is_root(memcg)) && !mem_cgroup_disabled())
-		queue_delayed_work(system_unbound_wq, &stats_flush_dwork,
+		queue_delayed_work(system_dfl_wq, &stats_flush_dwork,
 				   FLUSH_TIME);
 	lru_gen_online_memcg(memcg);
 
-- 
2.51.0


