Return-Path: <linux-kernel+bounces-889028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67B17C3C880
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 17:43:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C196562387
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 16:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71C1234EEE7;
	Thu,  6 Nov 2025 16:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ZX1v7TAo"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87F934D92F
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 16:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762446832; cv=none; b=jHUamgY5AaOC03U+PyZUa0gdrSg35VthzLi1V4flIc08rmtvQmk/ZSERbCfSINiuSdo4qghT5GnKGLSTOxEtAtLuXBEYTt7OqLzRrhct52mUOqdQPAyQ1yxl6B00fqc5uELdVLo/WZIeY5sfOaWEmJDJoGRgphzoi+iDQ/Ld+2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762446832; c=relaxed/simple;
	bh=3I2vzrQn2493MZariDAPILNiax7J1mg+M2E3mdJOuYc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Wh+MGcP984eVYKm3fDpqsFU9Ad5xZSYj1lOYle4kH5VEe324cwv4Jg9sehz74uCdho28tg5sEJCuuQDYiVl8KsoyG6ZJDMRhxAfRwHNYLBogssfymsS8Blk1lSzsv9MXBA7sObdo6us3lbvbuXlERnmWYfoSTh820UEheJ8UcT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ZX1v7TAo; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-47728f914a4so7248235e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 08:33:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762446829; x=1763051629; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Wmza2AdLyO5hSkvbNEJb99o8w0t6fMLr8LtB6/z3n84=;
        b=ZX1v7TAoAaE1Cr0ovjMjVHvKs0yAVtD10hEje1V4Y4ktRjHwXLjLjb8xp6hYLU8GTF
         I/oKF+3lZ1MczYiK3Oqe/IgkqFFHcu0uWQ4pU9l2OxY/wchfGENcQUtZ31xyYNiDis2L
         kYKOJtTkrmWPpePco9oWKKmNEDsJiQVFkMCmXJRsc6XDb+dtIhnkKqr9j0LPQZrSS+m+
         lZY18TkcFNavHVzPdrGHjAZccni2okNZVevb/r5UFRxz0mE6X+8IAzWCm3ArfLKAUdLv
         YNCVIR72pk2CzFUencduAMhwHaIkKtLaYfj6DtW9R3HuCdVUqn9yJcL2u6gW6ZLJRNw8
         rDPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762446829; x=1763051629;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wmza2AdLyO5hSkvbNEJb99o8w0t6fMLr8LtB6/z3n84=;
        b=Qn9G6YwaCaQm9Fa/U6xtnomY+05AUg/KyOBnojvAAIHdukNiz/ppG4dsBi1riPLQ+W
         gD6LUryYFQ7FuMFcL1DYGo9QoJXDj8E7/w4JAmW4UdJeB/auuo6XIswlfeB86oyXK6+t
         YyjkpKD6tTpFTrNsRAAgobXb1uUeRCA8ssy9fU4Exc2ymDjyE1OmDqJ4gFJG6pRG/Lw2
         GYzLwfrt71QZJLuhXAYWQrBGBtUS4KzWdPua6RNTSI3M68CgNGSdcVkXW5mqrAifno0A
         PVSRBA/84qoAPINvC2tBYBUghnQGKvBaS0oY5da0m7/3D9coymuOJSJIvvvXwGnqCvvF
         JLWA==
X-Gm-Message-State: AOJu0YyMqrgrRDy1/5kFBeqAfW0RR1ZW/A57/PruPyNpVHGxKyUMgZZC
	WLh7f9KuGQWyyS2T2CX/Un0G6xzJnuWlIPBeA0RloLSitpApWIyqHwOhfDwy03mzlDppCutKvki
	/ydEn
X-Gm-Gg: ASbGncsCAC+FcaP8F33djitAjHJwMKJp3lTU7fAGfhibU0+LRgYUPdlsd3l7ZKyUWPG
	rhSqS5srxdnNgnv35nsQrfECUDknJT0NIUA8Yt2+4v2jRRitSXnohDw5tvDVgv7WaoKXyLK8KYg
	qggpO9Y9Gi3EKEM3TT54RvIBhCiNwC00vbTceMcafuUfXq2RjBd8/0LkWSPXIfWepA1fFgBwKRT
	1ngDx4NPtcjQ/RepkzWGw/paPKZ+8vQPSsNppuOECLA/95/y/dPTuqxN4NxRHypSyGcsjCSsAaW
	eWRFKEP10WpdfE4r0hkJ5nMaaK6aotoJ3f1gBaWnb8lzXXvChQBJzOj+mdK8oBC0pvf5GQntjdB
	VyhScS/CjqKzed/9jBVwjMdDEDSc+elSnC97L+ZJVcpN280rmqI7RhW1KauRkQ5l0uRlFCLvxfD
	MpTbXCRf8a3t+yNgtu7UfAk1acKuFtWDRlmg==
X-Google-Smtp-Source: AGHT+IHMQwUSDo58hdMpPVw1nMtG9wyNVUVuAFCRYr+ffd6NpaE3dP6xzd/TRMuvSh7wbP1rkuh8Cw==
X-Received: by 2002:a05:600c:4f16:b0:475:daa7:ec60 with SMTP id 5b1f17b1804b1-47769d50585mr22128845e9.21.1762446828531;
        Thu, 06 Nov 2025 08:33:48 -0800 (PST)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47763e4f13dsm19539105e9.5.2025.11.06.08.33.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 08:33:47 -0800 (PST)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-tegra@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>
Subject: [PATCH] cpufreq: add WQ_PERCPU to alloc_workqueue users
Date: Thu,  6 Nov 2025 17:33:41 +0100
Message-ID: <20251106163341.336989-1-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Currently if a user enqueues a work item using schedule_delayed_work() the
used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
schedule_work() that is using system_wq and queue_work(), that makes use
again of WORK_CPU_UNBOUND.
This lack of consistency cannot be addressed without refactoring the API.

alloc_workqueue() treats all queues as per-CPU by default, while unbound
workqueues must opt-in via WQ_UNBOUND.

This default is suboptimal: most workloads benefit from unbound queues,
allowing the scheduler to place worker threads where they’re needed and
reducing noise when CPUs are isolated.

This continues the effort to refactor workqueue APIs, which began with
the introduction of new workqueues and a new alloc_workqueue flag in:

commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")

This change adds a new WQ_PERCPU flag to explicitly request
alloc_workqueue() to be per-cpu when WQ_UNBOUND has not been specified.

With the introduction of the WQ_PERCPU flag (equivalent to !WQ_UNBOUND),
any alloc_workqueue() caller that doesn’t explicitly specify WQ_UNBOUND
must now use WQ_PERCPU.

Once migration is complete, WQ_UNBOUND can be removed and unbound will
become the implicit default.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 drivers/cpufreq/tegra194-cpufreq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/tegra194-cpufreq.c b/drivers/cpufreq/tegra194-cpufreq.c
index 9b4f516f313e..695599e1001f 100644
--- a/drivers/cpufreq/tegra194-cpufreq.c
+++ b/drivers/cpufreq/tegra194-cpufreq.c
@@ -750,7 +750,8 @@ static int tegra194_cpufreq_probe(struct platform_device *pdev)
 	if (IS_ERR(bpmp))
 		return PTR_ERR(bpmp);
 
-	read_counters_wq = alloc_workqueue("read_counters_wq", __WQ_LEGACY, 1);
+	read_counters_wq = alloc_workqueue("read_counters_wq",
+					   __WQ_LEGACY | WQ_PERCPU, 1);
 	if (!read_counters_wq) {
 		dev_err(&pdev->dev, "fail to create_workqueue\n");
 		err = -EINVAL;
-- 
2.51.1


