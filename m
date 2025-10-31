Return-Path: <linux-kernel+bounces-879910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF05DC24618
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 11:15:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A2A51895F68
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 10:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1400933891F;
	Fri, 31 Oct 2025 10:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dTrsjJoj"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E72E337B8F
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 10:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761905387; cv=none; b=SIlidwDyxPTCCNeGDZtbIu4dkLnPQe3DtZ6mzIV6M7jgk5LkhMxJIg5VcriU2De35ZGT54jTe3Mu5CGlILyCTwnt3K9bv6XRCcj3cep8WQRAUhkOLOpxPa3oUBgdgBTEw3YAIjU6aN5DEE3yjl3INOGNFJqzfqzpug+D3yPqzmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761905387; c=relaxed/simple;
	bh=iPFArMrJamTiHTE+8pUotcITyD91jaBL0nGmruRRbag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pLTJ4OpvRBRmr3vdls8OHLkltMxH9uLQCQRFNgxluC30b+trlGb2Oul+x2ynlsTpAj/Ny4609w8RZtXlODg/5ehsHJxnMODbUKsEhXgY9pfcTrrF8YDDXUJQl5/DwNKFX4gPQ9x28EzjpBbbeCGJRyxTNOBeajTf88E4MpGeC/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dTrsjJoj; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-475db4ad7e4so7889125e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 03:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1761905380; x=1762510180; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uIEAHpZJgPenfQa0eR0eha1rgNHE8FkwlCwPAkqtADI=;
        b=dTrsjJojpuAVvQwrg2BK0EbY62E7KUzbVuJut5eHgOkIxUCzKn22CPQxWI9xeq1Jc+
         3feLbHKRiQ2mKL+/iyZiPk7REnQhUdqPyAC0vMjKHe+LsGRCPPdjdWDS9qum4K3VkkmO
         YerOw4n8hd6+G+c9+eRcwFDjmxcvJQ4CUdj89yyx5hI08PB6a7b1491loIolfL/WFSLh
         wyVvf0lB8OEiyeF/hLuys0EMtNMwwKxpeLaISbObU4sr0MShtGg4KtQ/F45Pn/vz9PIq
         LkWqi9Oo0FxmEcyl/lB8iJQhA0pulkAiHyiFqelyGgX6esiTDi8hDepe6LcJ0BAl08ib
         HnHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761905380; x=1762510180;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uIEAHpZJgPenfQa0eR0eha1rgNHE8FkwlCwPAkqtADI=;
        b=dhfSTa3qboxV9qOYdkML8u5UsNQDuL2boXlp1CNsP0DOG/tIz7MGip/6FR7U6oaljZ
         UtehSEYcPWzTRvUiBrcb6UcJreaMxVzs51YR6qx34GmUeYNlNNegwmdltycMWIgrODhK
         l3+YfMnJHSjU2CUoubibeOowA+rk5CGqcv9ehANx+krAmZFZ09F72dPx8L0APCVb531s
         HTFMojD18bHWz84pp/GpZ4Qe4Ud0furQiMDyGxF2stelDMjaug3iKBTIJGOea6uaVHK8
         YsU6BnhF4sJ0rRZhdebQZBLw/4VgNtuxUnzqzfuixGFcDOxuXzISpYAOGZkTEDjvgNfv
         aegg==
X-Gm-Message-State: AOJu0YxxbG/Gs17UZi88qCu9jq2DVkdyn1e8OSjsWzsBxi5GLKxhoW59
	S2vzCsLbUqnqlHhayL4gfBMacLaxJ68LgQyGHpdlQoTypygmf8sS76v8n52RKSUTwiQTQ+PBgs5
	BxVae
X-Gm-Gg: ASbGncumwlVKA2Q7JDdxJeYKZxFbCLUdI2GzYxbC13dBmDo73RmBtsRGAVvWrvHl4G2
	PGogImLE9dB2vDjYOe7PVxkvJHfTCGvoDEBHaAtdnXGl17U411LN/G5mI1l1jVSvwKo754X4EB0
	BI0mfYrl6N5nNDX9CJ++h3WZpowUIFM7HvhfE+1NR9+JGJ5nzTzh9bHgFtpzPsMtrQbkHEg63mF
	KpAuGJi7C8kmqnbQczMYxCqGv8WwJuotB/U03Vrtat4ogFtI7rXPIBWhm7cSm/s7+kTMNWA5oxl
	pr0M2Ne1g+sS5lEevlgj1ohwOIkkytW15+X9orco/k+VLuX0bnmAcgwljctB3D7dpBW1XFsCV4e
	DMrepBTslZrDPn15NTgZ/KTnT+dHWZT1lTt0cy9oFRpMYe7fVY3kAAzEWduc2J6qODi7ynGLEtU
	c6IS0tA3LqOG4jJyBXcOE4hxozvepKELHktCxkhXhhxSEFQQ==
X-Google-Smtp-Source: AGHT+IEuYSheTD0LAmCUTXMqTUnmXFPaQcuKHhOpSOYN7DCVbycYCPaNazgBhc5bsfGHuKVEiD6GEw==
X-Received: by 2002:a05:600c:4695:b0:471:1774:3003 with SMTP id 5b1f17b1804b1-477308be7b3mr29933385e9.29.1761905379892;
        Fri, 31 Oct 2025 03:09:39 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429c13e1c9esm2839171f8f.22.2025.10.31.03.09.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 03:09:39 -0700 (PDT)
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
	Simona Vetter <simona@ffwll.ch>
Subject: [PATCH 3/3] drm/i915: WQ_PERCPU added to alloc_workqueue users
Date: Fri, 31 Oct 2025 11:09:23 +0100
Message-ID: <20251031100923.85721-4-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251031100923.85721-1-marco.crivellari@suse.com>
References: <20251031100923.85721-1-marco.crivellari@suse.com>
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
2.51.0


