Return-Path: <linux-kernel+bounces-770658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC3E6B27D88
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 11:52:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE090AE3DBE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 09:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56D1D2FCC13;
	Fri, 15 Aug 2025 09:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="eVeWcDYC"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88DD927A11E
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 09:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755251334; cv=none; b=JevbIhvlc+yrv16BVP6ehXhWSdpSWEHRb/J+FmQ/UnYx9XtHDhrzrOvj55pZSnqLaaIM5Pe9yQvaKIqFVJL9fxee8WGHhPYZ+XPN+IMp/2kP0+zBIswDpGRhaLOpfzEmzMlfklzvITk7A38qo1eDLwoWBHh2tbhwUcgNuSKKF6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755251334; c=relaxed/simple;
	bh=vpMtMp//b0b8De85qCC3JA1iuWr7ernuXqJ4p27ur4w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Eu6U2f48ggADh9Ma7AVf/Ydpr3evfdkwQevrjzlJQ4uJwxqGCRsP6FBGanuTSei/1v+5O4uruONLK+x9RCTmIHuPfFl0f+WTTT+PNelXbzL5s+30bZamDqIMmZ7t8UTeOncXTokjLxlkXzL0xwOkQwqSrSG3tFBv3LA3bT/0BW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=eVeWcDYC; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3b9df0bffc3so1052674f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 02:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1755251331; x=1755856131; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mR5NkOjuGJ4ft4FhURCOTQDzGIwDt9G1P6tv9Keuhok=;
        b=eVeWcDYC6VVsXd8aWEN/h4e1s5WjC/Zpj3yTlAH9IKnWpBloxS8qdm3BQ0ib2Hy2j/
         3LxUzedoZvgu1Ky2CcU2rl1OKpoB5/qq6LqZERXyPy9hG1cSgIEomQN7rfksYOjQHm/J
         iIbvzqhoVdHID4UzPZRX2MomyJfWAV3LsGwDqXM5AkGBClEsEhZ7KIHW1bsr94nLdrOq
         IKfIa/pV6CUK6VGiitQEGJntHVuRZExnDJxAMrTKWztDtozP25ev5cnQnA19h+c5r5Gy
         U+lyRJbaMYiNoysZ6WpcgMW68AZOX6mws5gTmk2aQeiCXlwzoyx1FMtgRafFDL9X74Va
         NRRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755251331; x=1755856131;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mR5NkOjuGJ4ft4FhURCOTQDzGIwDt9G1P6tv9Keuhok=;
        b=hwiwvAw1wfdf7yjLxkFErYG79B085CLrar87DJ8d/TLkqnFnyHRmGiG2Q3rTJMK4gg
         7+n8ibmlMHNopAL8jHCU+0WxNc0OX/1Vq4tJaSJ1yIx4B62Ws6v9xdYtVVRjZQztehYY
         HQHpueAhaj4iCIfJM1FgjVloXcx2Id/oe/okem6qsX9WmBEZ0zimOAZRjZVUqCCB5QLr
         Nj8KwzISyDJ8hkJRQdfCWfQSCK/R+OkOXUldyqYU7riJDg/LPIUfDaT2RDQEPAAZNpbA
         7FJuKZXZBJub9VHSC3f6nUgkyMh9/frz0Bt2qx6WEwHlo9ffa3d1k/+oZwEHnQJENQ2X
         W18g==
X-Gm-Message-State: AOJu0Yz+ipRmdmeZjeGK+AmQXf6WvgGwBVmAEUfXBJi+OmGG2J3/G90f
	ISAKyMhRkQIFauTbJJAfMQZJWzI7k62TNCIS7L8KkBrR8Ifrc8mcE50DGKdOvybwLVfALEj2i7i
	atc1g
X-Gm-Gg: ASbGncuzyLNv9DzlnyIt9SbxOP1iU0lGhMZ1YxrzT3+7mSSy2/DTRa7WQnekqfDgW3y
	Xo4cazOOPFZPqMWXXbhsbXlUyvz3r1Y+OJSufWEmVVYx7Z15tcmKVt/vyQbUsIWNSnblIGpvYcq
	Zt7ZMpq3jDxpqxnlMtGFCa0FoOVp4iu0TIUU3ygGiDoNExOelnPg0gp2fq25afGBTFOf4IRGkCS
	Lr49XerIkjW9axToPE26NM7xxIKP1RdaKQ3lcXozynV2J3c4b6GR8Gcp/MiuJ1hrUpSqaMUriJ7
	C8q2eX4ImErJzsYn70vCf/8sean1MkLeySLtrb2gBGT88/AHXnSVRLPb3RpKantHBhR+EIngamU
	UM/zmjXrVKxyb+iMnWCIEjcbOSTLRc14N1x4GmYKSWtJy4g==
X-Google-Smtp-Source: AGHT+IGfwwmPP0cJ8NtKTDTzNgTk6p0HWcl0j/eyi7s50c7lb/H8mjXhYq/x38gt6gyqORGglfALjQ==
X-Received: by 2002:a05:6000:250e:b0:3b7:9b4d:70e9 with SMTP id ffacd0b85a97d-3bb68c037a2mr1039377f8f.43.1755251330644;
        Fri, 15 Aug 2025 02:48:50 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3bb64758441sm1313811f8f.13.2025.08.15.02.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 02:48:50 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 2/2] Workqueue: mm: WQ_PERCPU added to alloc_workqueue users
Date: Fri, 15 Aug 2025 11:48:43 +0200
Message-ID: <20250815094843.55377-3-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250815094843.55377-1-marco.crivellari@suse.com>
References: <20250815094843.55377-1-marco.crivellari@suse.com>
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

This patch adds a new WQ_PERCPU flag to all the mm subsystem users to
explicitly request the use of the per-CPU behavior. Both flags coexist
for one release cycle to allow callers to transition their calls.

Once migration is complete, WQ_UNBOUND can be removed and unbound will
become the implicit default.

With the introduction of the WQ_PERCPU flag (equivalent to !WQ_UNBOUND),
any alloc_workqueue() caller that doesn’t explicitly specify WQ_UNBOUND
must now use WQ_PERCPU.

All existing users have been updated accordingly.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 mm/backing-dev.c | 2 +-
 mm/slub.c        | 3 ++-
 mm/vmstat.c      | 3 ++-
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index 784605103202..98fb7beddd4c 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -969,7 +969,7 @@ static int __init cgwb_init(void)
 	 * system_percpu_wq.  Put them in a separate wq and limit concurrency.
 	 * There's no point in executing many of these in parallel.
 	 */
-	cgwb_release_wq = alloc_workqueue("cgwb_release", 0, 1);
+	cgwb_release_wq = alloc_workqueue("cgwb_release", WQ_PERCPU, 1);
 	if (!cgwb_release_wq)
 		return -ENOMEM;
 
diff --git a/mm/slub.c b/mm/slub.c
index b46f87662e71..cac9d5d7c924 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -6364,7 +6364,8 @@ void __init kmem_cache_init(void)
 void __init kmem_cache_init_late(void)
 {
 #ifndef CONFIG_SLUB_TINY
-	flushwq = alloc_workqueue("slub_flushwq", WQ_MEM_RECLAIM, 0);
+	flushwq = alloc_workqueue("slub_flushwq", WQ_MEM_RECLAIM | WQ_PERCPU,
+				  0);
 	WARN_ON(!flushwq);
 #endif
 }
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 4c268ce39ff2..57bf76b1d9d4 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -2244,7 +2244,8 @@ void __init init_mm_internals(void)
 {
 	int ret __maybe_unused;
 
-	mm_percpu_wq = alloc_workqueue("mm_percpu_wq", WQ_MEM_RECLAIM, 0);
+	mm_percpu_wq = alloc_workqueue("mm_percpu_wq",
+				       WQ_MEM_RECLAIM | WQ_PERCPU, 0);
 
 #ifdef CONFIG_SMP
 	ret = cpuhp_setup_state_nocalls(CPUHP_MM_VMSTAT_DEAD, "mm/vmstat:dead",
-- 
2.50.1


