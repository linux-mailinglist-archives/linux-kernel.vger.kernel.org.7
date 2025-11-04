Return-Path: <linux-kernel+bounces-884546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8579EC30666
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 11:02:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EDFC04EEF50
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 10:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA1B4314B68;
	Tue,  4 Nov 2025 10:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gfq48Rav"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA462D594A
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 10:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762250454; cv=none; b=KMwRUuGCN4oPGVN19srJkdHbcwai01FHuFSJEAXAh0300bGagfUyiv6ycQ3ZAB1DdjLZePo3PRYIJM60mwoyZhMsqZ3M5J93AQtxka2OYpY5xVdzr/T/NtxgDjcyiC+D8lliGzig6iWJ4/in35D/g+ZZmq8d7EaWoQJ2423auPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762250454; c=relaxed/simple;
	bh=1lM896dluTThHb5Dr0rgqp7Q2lq1nzVGRs7ZWDUKcWc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FF+x6fdOUq+IQ0BbsiBHmGo0EqQJnepq5qegjwD753cndAKmFV8Y8A9MbkaYTtSHhdn1Fh5ldsM0ch0fZNGj2L6qBQYio465chiBHFfC2/omo3mvKSNLNaSfOHFIvHFSdadAfv3P7qeXHXnYHyMEC05YhA6ixl5OUh94/6Mmr88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gfq48Rav; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4710a1f9e4cso43980575e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 02:00:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762250449; x=1762855249; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JlVwKwolM5sjAhAjoNFJjS/Et/bs8gMf2Li6ilbi0sk=;
        b=gfq48RavXuchewHWyMlPJP39d3hGq3VUFG2QBiGGbvZff+Bhl+Y1Xa0zQwXi9Idbgc
         zk8vfk75Q7BvyqqZngorV1DkKBkdLytg5qIBqZkAVrIuYO/LrIqlR2MqLIzkfwncWfRN
         yl8owSjvJ475VySXpIfiPyxZkeJMPpy3WKgLP6rebl947NH9wvkUoVAGIbWTWNTtiM18
         GsAgXlpQ38URe9cDgDOFKmcEzeLLVJD2++A3azgy+0ZnZQ96aVmgZfGOnhdErhuHe6JE
         ZHtttuc8sIpfk9VObvzG4HwqBcbGv1UDHBz/eBk4eXgUY2ExUr3obzv6IcESH3mYL0Yq
         tmbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762250449; x=1762855249;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JlVwKwolM5sjAhAjoNFJjS/Et/bs8gMf2Li6ilbi0sk=;
        b=YLMx9Pb/w+X3fBhLuubNJHkxia8z18XzbJVEP/MKWKfLRf1+MW88izpa28/rW1ZxYo
         U47tfyAMjrTUJcHi0xn/4WtwtvYoFlKx3OU5+Bk8UV/hDkqeORYK8OhJQsya1j7mQzeL
         hLUf81el0uPH1Ue4xKfVz75MDNlo1cCddTZfOXm3cvOgeHZeUTE6u7yoCTpaLke+/y8I
         a9ykgwNR920zj0TvO0vZxigvtQnI+BxJ9LAjS8yMnHuIwCIz6SJ2mDwmQYok2nzEUINE
         88UKVXABZlz4w2CJMV438rX1NlV6Ykcn/ReSx/drZAQ/3Rw7osW+Yronhw/w0l6rN6yO
         IPlA==
X-Gm-Message-State: AOJu0YxrPIuwGnEe6fziGaq0N+ys7aOLbhxx2V+rrFu5epZwyv85B/Zx
	u/5bWeTrMIgTSkttgRhmGADTX6/a+VjLBCq1dm28BQcRr/i7HPUEJbhXZDOpyADpS8ABc9VV0NN
	M0NYd
X-Gm-Gg: ASbGnculx1LdLfDMz1vZUl/Ma/HT+4JklL4FDWZpBjHdcc/VDC/+BrqLASEYlIDfoEz
	VhcNOs899o+XBsdpcXKEm+EN5V0C7xpbDWICgrjf72zzVyXEhW+YBijuh4ghwccqLdIaIglK7yt
	bN74FRowhflLDET1wkt1G64TIirtm0JsuxB2pG2sior+UjUxZD1Xy69lVRijL/to3LGozPbyOVT
	VF+AsuGdxJ2Vcz5YU93PU3C8mSZVrtHp7CKkpRfItl6oTtPE5/VlzXNrCBjGycYQYZDAc31FDGv
	oU/Tj2fPUt675xTHLaHLpcex+RwB5vM+bsehBStyr4aoHIM0Rgu4ETr1G1uz1cLoApBT5J4gOWK
	8SWIlsSebuZJesqWsVfbyqRqaHp2thD7xbT3vKnaD1A+0XalgNrbtBG27BghJkz5Ik0fQOkeJQg
	NE77oFmT1FaOgEtw+xxAqTmAOD
X-Google-Smtp-Source: AGHT+IE35Zr7TnYBf7Tgb5joKNHpDdpqyjXIULZRst3eRHtFoQa+qKm5wqipI7KhNj5WLe8NJxZfFQ==
X-Received: by 2002:a05:600c:1f91:b0:471:13fa:1b84 with SMTP id 5b1f17b1804b1-4773082e1e3mr138207635e9.12.1762250448895;
        Tue, 04 Nov 2025 02:00:48 -0800 (PST)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47755942772sm14325865e9.5.2025.11.04.02.00.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 02:00:48 -0800 (PST)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Krzysztof Karas <krzysztof.karas@intel.com>
Subject: [PATCH v3 3/3] drm/i915: add WQ_PERCPU to alloc_workqueue users
Date: Tue,  4 Nov 2025 11:00:32 +0100
Message-ID: <20251104100032.61525-4-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251104100032.61525-1-marco.crivellari@suse.com>
References: <20251104100032.61525-1-marco.crivellari@suse.com>
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

This change adds a new WQ_PERCPU flag to explicitly request
alloc_workqueue() to be per-cpu when WQ_UNBOUND has not been specified.

With the introduction of the WQ_PERCPU flag (equivalent to !WQ_UNBOUND),
any alloc_workqueue() caller that doesn’t explicitly specify WQ_UNBOUND
must now use WQ_PERCPU.

This patch continues the effort to refactor worqueue APIs, which has
begun with the change introducing new workqueues:

commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")

Once migration is complete, WQ_UNBOUND can be removed and unbound will
become the implicit default.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 drivers/gpu/drm/i915/display/intel_display_driver.c | 4 ++--
 drivers/gpu/drm/i915/i915_driver.c                  | 3 ++-
 drivers/gpu/drm/i915/selftests/i915_sw_fence.c      | 2 +-
 drivers/gpu/drm/i915/selftests/mock_gem_device.c    | 2 +-
 4 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_display_driver.c b/drivers/gpu/drm/i915/display/intel_display_driver.c
index cf1c14412abe..e12f9126b155 100644
--- a/drivers/gpu/drm/i915/display/intel_display_driver.c
+++ b/drivers/gpu/drm/i915/display/intel_display_driver.c
@@ -257,13 +257,13 @@ int intel_display_driver_probe_noirq(struct intel_display *display)
 		goto cleanup_wq_modeset;
 	}
 
-	display->wq.cleanup = alloc_workqueue("i915_cleanup", WQ_HIGHPRI, 0);
+	display->wq.cleanup = alloc_workqueue("i915_cleanup", WQ_HIGHPRI | WQ_PERCPU, 0);
 	if (!display->wq.cleanup) {
 		ret = -ENOMEM;
 		goto cleanup_wq_flip;
 	}
 
-	display->wq.unordered = alloc_workqueue("display_unordered", 0, 0);
+	display->wq.unordered = alloc_workqueue("display_unordered", WQ_PERCPU, 0);
 	if (!display->wq.unordered) {
 		ret = -ENOMEM;
 		goto cleanup_wq_cleanup;
diff --git a/drivers/gpu/drm/i915/i915_driver.c b/drivers/gpu/drm/i915/i915_driver.c
index 0f33cdc11736..380cb20a47c6 100644
--- a/drivers/gpu/drm/i915/i915_driver.c
+++ b/drivers/gpu/drm/i915/i915_driver.c
@@ -143,7 +143,8 @@ static int i915_workqueues_init(struct drm_i915_private *dev_priv)
 	 * to be scheduled on the system_percpu_wq before moving to a driver
 	 * instance due deprecation of flush_scheduled_work().
 	 */
-	dev_priv->unordered_wq = alloc_workqueue("i915-unordered", 0, 0);
+	dev_priv->unordered_wq = alloc_workqueue("i915-unordered", WQ_PERCPU,
+						 0);
 	if (dev_priv->unordered_wq == NULL)
 		goto out_free_wq;
 
diff --git a/drivers/gpu/drm/i915/selftests/i915_sw_fence.c b/drivers/gpu/drm/i915/selftests/i915_sw_fence.c
index 8f5ce71fa453..b81d65c77458 100644
--- a/drivers/gpu/drm/i915/selftests/i915_sw_fence.c
+++ b/drivers/gpu/drm/i915/selftests/i915_sw_fence.c
@@ -526,7 +526,7 @@ static int test_ipc(void *arg)
 	struct workqueue_struct *wq;
 	int ret = 0;
 
-	wq = alloc_workqueue("i1915-selftest", 0, 0);
+	wq = alloc_workqueue("i1915-selftest", WQ_PERCPU, 0);
 	if (wq == NULL)
 		return -ENOMEM;
 
diff --git a/drivers/gpu/drm/i915/selftests/mock_gem_device.c b/drivers/gpu/drm/i915/selftests/mock_gem_device.c
index fb8751bd5df0..684e6ca0f960 100644
--- a/drivers/gpu/drm/i915/selftests/mock_gem_device.c
+++ b/drivers/gpu/drm/i915/selftests/mock_gem_device.c
@@ -221,7 +221,7 @@ struct drm_i915_private *mock_gem_device(void)
 	if (!i915->wq)
 		goto err_drv;
 
-	i915->unordered_wq = alloc_workqueue("mock-unordered", 0, 0);
+	i915->unordered_wq = alloc_workqueue("mock-unordered", WQ_PERCPU, 0);
 	if (!i915->unordered_wq)
 		goto err_wq;
 
-- 
2.51.1


