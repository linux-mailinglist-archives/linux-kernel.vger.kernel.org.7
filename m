Return-Path: <linux-kernel+bounces-883380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE0DAC2D469
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 17:54:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC500423C8D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 16:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 800A331A81F;
	Mon,  3 Nov 2025 16:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="GcwOkhO5"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1FFD31987E
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 16:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762188497; cv=none; b=W+T/iRiegomMzudd1k6KmFGx56uq6pR8o0jjz4KfnfWgdrUxwYFAgrp8n4UA/fX4152ZYE8sMt4dy374Mpr2Fp9fSyEsHW5Fjj9e+C4K0oYsPqHJMvEvMZIz9LuZbWZRAQFTEjJBYH05S36O0bLCjUCz9FA/9I7o555Dw+I4PaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762188497; c=relaxed/simple;
	bh=v3s20x2F2dQT398qRkqb0mfKxrgW+McbveyqUkXsr8g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pD5jN1J/1ubwv8MtVt23VWHVxwKizpmRpi5ivZjdKtbCwinQaR8J2VZ2LqC7cUygXqtE3tqrKjMnO1IKDKC364OlVkcmyrTg+NhR+VjcmCCSnPeCzM0x2AWeLa0xySS2Dn4qAydOatoS4Q17EHdJP04VUNs0zQJWacF5gvpfr7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=GcwOkhO5; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-475dc6029b6so41699195e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 08:48:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762188493; x=1762793293; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FI956lBy30mk8LME6plJ5is5xzYMLNO6i3xgI6duHkg=;
        b=GcwOkhO5NAg61ZfuPkQGyETsEB8KfBQ1axv51nd9L6JrB+JLlE7LwAYNuZiVPLMo21
         qpTjodYgJXfv6CtPyIBNp+2/qw1h2WsED6IatqD36j5lT/Ui9K59BPe5uBjMig12WCTx
         chDOVnG9q/YzRo3keftXLHHe6k6ihFAmZE0Vdx/AJnMNu6G0ONoWLlGjIp7Dnyzd9GeO
         3J07lRTHtF4T+qOoW8TN0qina1BBF/KnNSyGhngxHoqyP31VBOGK1S85kx6hexxvRTNn
         py9ZQ3RbB30q8OoKFPC/Gtvzdgu/9Sh3b2Mk9Qv9alKKqNoYBQEky3lCNbxZAZZgPjTb
         onFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762188493; x=1762793293;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FI956lBy30mk8LME6plJ5is5xzYMLNO6i3xgI6duHkg=;
        b=wIPMLpGPIaJH9cm2rtXBDZGfArnJPs8+9OrOX26cj8/Rlk63plpaAik1QpQc8WEd/6
         6oiVrp9a4QC5mkH92EMx9nUFcZUL8lGW7LLfhOuXxahVByPVobM/21OfTgaHmZ0jM5hU
         B39/mDKPLjfeODU3pc/XA/CzOZBxsW63/Ime3b8JlfHUnfFeInW6CjjN51T90bPwcO9Q
         jKUmQjqit0tbtxZsmYxa9M8jrSkwrvkGCyaR9+b42Oskvrsr16R5Jf76YAE3/2hhYPGD
         Un4hvZ+IYtF2x21K7F4rMF8h0HBHGi4aPeHzDSsm95VdUydOAwgjYyXzoEeqeWxBV6ow
         KeBw==
X-Gm-Message-State: AOJu0Yz4SWTgXR6eCTjg7BK7AQyd27GWw+eMSFMsyaryLu4tGL7bSUml
	yQLZlnminKPRV010tYfBl73lp/nJez6JW3Qka7INuoJa/RoCEMatJcMU9aNvzNZfsxM5JWkr2OE
	2aoKx
X-Gm-Gg: ASbGnctrpNsszMtbDj3CQY94TghVZzYEDkJsAu/+eTOV1OG67coZGxGyfevh10xl26+
	G+ZSwcR2wvWASVkb7gWKf5QqpDBQJXOLBxN+oD6Qh46J1ZWb3xLtiVZ8aRNfRnj+d12alyNZaWc
	MYIcMCodVF3CDumL0ZeP1H2hldvW9nxOALCaiAV+UpiKYzFz7AAqaTxu+fk7X73fqtoGzH42hln
	enZVdBVLTLnzTrN+3KNf+kXQFwPFQbn85UFWbz3eWCWSJ6LH8vtZJH/I8DDaz5gYNLzCPbAO8g1
	723EChHfOkQrjzdg9xGQFsFRrCg5XR8EKgu9YlW98VnnGhW8WmqqVEQxSaETP904Key2l4zz936
	iIPf+u5wS/v18HBD70HzCs6Q6HAybMLzvkprV6RC5rSZNQ/LrikjdX8XCe08UyFV5gXMyvpX7cu
	V/NzHKtywaNs6H9mxzPfTPx9st
X-Google-Smtp-Source: AGHT+IGVmeKMU2dsaQUkPgPXdqhRjYWIfzuES8flQr6U09xY1SVQ23sf3RB1gngixUUiNGnG+Ta+wQ==
X-Received: by 2002:a05:600c:4710:b0:46f:b42e:e360 with SMTP id 5b1f17b1804b1-477308a8972mr114450845e9.40.1762188493541;
        Mon, 03 Nov 2025 08:48:13 -0800 (PST)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429d1061efasm9864899f8f.24.2025.11.03.08.48.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 08:48:12 -0800 (PST)
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
Subject: [PATCH v2 3/3] drm/i915: add WQ_PERCPU to alloc_workqueue users
Date: Mon,  3 Nov 2025 17:48:00 +0100
Message-ID: <20251103164800.294729-4-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251103164800.294729-1-marco.crivellari@suse.com>
References: <20251103164800.294729-1-marco.crivellari@suse.com>
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

The above change to the Workqueue API has been introduced by:

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


