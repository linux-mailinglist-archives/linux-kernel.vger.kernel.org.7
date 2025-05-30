Return-Path: <linux-kernel+bounces-668405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E222AC926A
	for <lists+linux-kernel@lfdr.de>; Fri, 30 May 2025 17:19:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 791337A9D22
	for <lists+linux-kernel@lfdr.de>; Fri, 30 May 2025 15:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DCB919F471;
	Fri, 30 May 2025 15:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="bNnyH7pH"
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47DF32DCBE6
	for <linux-kernel@vger.kernel.org>; Fri, 30 May 2025 15:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748618359; cv=none; b=jntjQuEVd/Ox8pBzqpiH8u6tEKaP8ppZIKXobRN9NxQhcdBnjtoe1nYxvThK0LuUCSHd68tSM+uh7KaK9b+bl7puRc50uE/ylpnBzh4am2mzUGlk5K0Kw/6oRXaZ4V4IlTfIjUzvBg+p8rMJzg4IMFvEcma6ULUaHj8Xh7GV1+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748618359; c=relaxed/simple;
	bh=Vyajyv9gcTyhCO1q8L9tdCgBFcmfGA4h41nYZiOAYPk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=faCLT++6leoOQho2gXFF3Tde1fa11Z1w7ayZHhFRptRnZJheXIzCRXaE+6mOol4+tvDzOQT0VY8/lAn+Z5bMjOYpTlEAAxT61om/45ehvfd0Ke4RGY4m+PXSr2K3zz0jKeuYXvYrFHtgQ1ej+3n1HXkN2dLUxpGo3o0YUudw6R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=bNnyH7pH; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-450cfb790f7so14552395e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 May 2025 08:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1748618355; x=1749223155; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rHzLL+KnCdbgcbNQWzWBQ9D1stAOWVmlpwTkZFpyF58=;
        b=bNnyH7pHkBxEuTZFx5o985yjuj/mTwyCowwGSojK3dpBHiuUpI9+fIhvu5YNz63eg+
         1WWj9fVC8AEvOMTfMzoNQrxL1y/vhO23tyox4harp4Gdpyq6fg0UZex9xJjtXnrxZehX
         oMzHJv86ES+EBdA2kSWXwzLN35BxQ6oedmozU1fMJY02tMeyqa4SFC48RZaNxwrPuhhS
         nd5gingd626Gc/jbJLUkZLdzlrlmHzvpudHusAo14oyWM3MBeSMEGVRqj8TADM0QvLwW
         CLjsiC3BjLy7qfRskSonDgm2hmIQMVpKDHQoKWvVQ4jqBvRn3YBdkiC7i64jYTEAFOW6
         03Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748618355; x=1749223155;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rHzLL+KnCdbgcbNQWzWBQ9D1stAOWVmlpwTkZFpyF58=;
        b=GzI/Wx6rk8fMuiKF9i472u52HtN/z8TTMUAYyAgRUBDzAwB+Xtx3t12a3ZEHA0/HCo
         hwFDnnHOSgQbdNVksAIUS5uePxY26rmiGOd0zLIO1G1lR9fvlvHuVT7h+2031qrY2JZN
         oTAiB9GPwANaLxXPsl1OjP1+IcYMl3AQob7ldE+Svr92NRkOMxP0PxvjLT2CRyfGGuyP
         41sL49LGynTs26DCdkuOMwA037b2XZ9oyhOEJuJ9iYjYLf9bKaMed/e/6YEcKRwHkgVl
         oI4OkhG7+ksKYxCcoLNWKdCugynYI63rzoSvyOPZyQnNbbtcmzQioTqEGDQSq/2PWV6k
         M+2Q==
X-Forwarded-Encrypted: i=1; AJvYcCU7WKey5ku9odQg0v8doMZdXQi1WCL6bNlxX2b7QQuX8ZS2UVLeHDcndwy0aMbYrTwE3+EYEC7Zxnnw1mg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYkV6i3hBw5P0K3CUkZsdAEWqd6vrewUzBUQilZzGazjHPQH7U
	qG4R923B58Gb2t+CTTVeiFPeNGTjik1CnJuz+aulxf3fRKC3mV3wWlD7BiA+LJUwPqc=
X-Gm-Gg: ASbGncstYaQZL/SWv0H3tSv1pm04lNuERvxlb/bQGQmnWXp+jfjXt2LYu9DH0O1Y6Cy
	0dG12YqKNuBwRauh08QPoK7NOvURjPzgyBT3B7r0VSkd4f/Ho9j3Jsoupd+fqCw1UaManGuILAj
	DYBaNnMZ5zXGkA/iywrCYlpHtvx2s4GkknDB4FA32e0kYONiVDoqkfHj7QyBHwmPnVV6zOr0iUp
	7sY6jU+wAdP0h+dsKvEpaFwMBiuFKLr8T+gy+JQ6WumuqBX95wKdg+RB0t6eYYmA1U3KtuasDBv
	7WKQj9COd/RB6mu+fAxbs3dIEPcXumn+KrqPLrl/xvrgnWYVgV3HNiO0qpCtaCNf
X-Google-Smtp-Source: AGHT+IFfgE9YkP6zKgTOBVVj8OU3ZF8h4Ob5dU10DqOggrcEUUPJXi1L8Z4gcTvobVCqNojEWm9B7g==
X-Received: by 2002:a05:600c:4f8b:b0:442:e147:bea6 with SMTP id 5b1f17b1804b1-450d6514eaemr35846435e9.11.1748618355407;
        Fri, 30 May 2025 08:19:15 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4f0097813sm5112533f8f.72.2025.05.30.08.19.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 May 2025 08:19:15 -0700 (PDT)
From: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To: cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Martin Doucha <mdoucha@suse.cz>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [RFC PATCH] memcontrol: Wait for draining of remote stocks to avoid OOM when charging
Date: Fri, 30 May 2025 17:18:57 +0200
Message-ID: <20250530151858.672391-1-mkoutny@suse.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The LTP memcontrol03.c checks behavior of memory.min protection under
relatively tight conditions -- there is 2MiB margin for allocating task
below test's memory.max.

MEMCG_CHARGE_BATCH might be over-charged to page_counters temporarily
but this alone should not lead to OOM because this overcharged amount is
retrieved by draining stock. Or is it?

I suspect this may cause troubles when there is >MEMCG_CHARGE_BATCH charge
preceded by a small charge:

  try_charge_memcg(memcg, ..., 1);
    // counter->usage += 64
    // local stock = 63
    // no OOM but counter->usage > counter->max
  // running on different CPU
  try_charge_memcg(memcg, ..., 65);
    // 4M in stock + 148M new charge, only 150M w/out hard protection to reclaim
    try_to_free_mem_cgroup_pages
      if (cpu == curcpu)
        drain_local_stock // this would be ok
      else
        schedule_work_on(cpu, &stock->work); // this is asynchronous
      // charging+(no more)reclaim is retried MAX_RECLAIM_RETRIES = 16 times
      // if other cpu stock aren't flushed by now, this may cause OOM

This effect is pronounced on machines with 64k page size where it makes
MEMCG_CHARGE_BATCH worth whopping 4MiB (per CPU).

Prevent the premature OOM by waiting for stock flushing (even) from remote
CPUs.

Link: https://lore.kernel.org/ltp/144b6bac-edba-470a-bf87-abf492d85ef5@suse.cz/
Reported-by: Martin Doucha <mdoucha@suse.cz>
Signed-off-by: Michal Koutný <mkoutny@suse.com>
Tested-by: Martin Doucha <mdoucha@suse.cz>
---
 mm/memcontrol-v1.h |  2 +-
 mm/memcontrol.c    | 15 ++++++++++-----
 2 files changed, 11 insertions(+), 6 deletions(-)

My reason(s) for RFC:
1) I'm not sure if there isn't a simpler way than flushing stocks over
   all CPUs (also the guard with gfpflags_allow_blocking() is there only
   for explicitness, in case the code was moved over).
2) It requires specific scheduling over CPUs, so it may not be so common
   and severe in practice.

diff --git a/mm/memcontrol-v1.h b/mm/memcontrol-v1.h
index 6358464bb4160..3e57645d0c175 100644
--- a/mm/memcontrol-v1.h
+++ b/mm/memcontrol-v1.h
@@ -24,7 +24,7 @@
 
 unsigned long mem_cgroup_usage(struct mem_cgroup *memcg, bool swap);
 
-void drain_all_stock(struct mem_cgroup *root_memcg);
+void drain_all_stock(struct mem_cgroup *root_memcg, bool sync);
 
 unsigned long memcg_events(struct mem_cgroup *memcg, int event);
 unsigned long memcg_page_state_output(struct mem_cgroup *memcg, int item);
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 2d4d65f25fecd..ddf905baab12d 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1911,7 +1911,7 @@ static void refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
  * Drains all per-CPU charge caches for given root_memcg resp. subtree
  * of the hierarchy under it.
  */
-void drain_all_stock(struct mem_cgroup *root_memcg)
+void drain_all_stock(struct mem_cgroup *root_memcg, bool sync)
 {
 	int cpu, curcpu;
 
@@ -1948,6 +1948,11 @@ void drain_all_stock(struct mem_cgroup *root_memcg)
 				schedule_work_on(cpu, &stock->work);
 		}
 	}
+	if (sync)
+		for_each_online_cpu(cpu) {
+			struct memcg_stock_pcp *stock = &per_cpu(memcg_stock, cpu);
+			flush_work(&stock->work);
+		}
 	migrate_enable();
 	mutex_unlock(&percpu_charge_mutex);
 }
@@ -2307,7 +2312,7 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
 		goto retry;
 
 	if (!drained) {
-		drain_all_stock(mem_over_limit);
+		drain_all_stock(mem_over_limit, gfpflags_allow_blocking(gfp_mask));
 		drained = true;
 		goto retry;
 	}
@@ -3773,7 +3778,7 @@ static void mem_cgroup_css_offline(struct cgroup_subsys_state *css)
 	wb_memcg_offline(memcg);
 	lru_gen_offline_memcg(memcg);
 
-	drain_all_stock(memcg);
+	drain_all_stock(memcg, false);
 
 	mem_cgroup_id_put(memcg);
 }
@@ -4205,7 +4210,7 @@ static ssize_t memory_high_write(struct kernfs_open_file *of,
 			break;
 
 		if (!drained) {
-			drain_all_stock(memcg);
+			drain_all_stock(memcg, false);
 			drained = true;
 			continue;
 		}
@@ -4253,7 +4258,7 @@ static ssize_t memory_max_write(struct kernfs_open_file *of,
 			break;
 
 		if (!drained) {
-			drain_all_stock(memcg);
+			drain_all_stock(memcg, false);
 			drained = true;
 			continue;
 		}

base-commit: 0ff41df1cb268fc69e703a08a57ee14ae967d0ca
-- 
2.49.0


