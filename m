Return-Path: <linux-kernel+bounces-879909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DEFCEC2460F
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 11:15:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF683189E016
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 10:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00C9C337BBA;
	Fri, 31 Oct 2025 10:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="EMAnQkQy"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA9B34D38D
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 10:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761905386; cv=none; b=pgsMYYdnwzv7Y5yzLRIltk4T/w6V8rJ1Km/DV1joqppOITRZL8tJiJPP3jwTznznqBhM8u9ZydZ7ySnEHxI2QJiICp2FmxJZhWXMFaArbhkBGr4GQWHrBuazgnp6G1N1GTccxQaPIiN0OCEH2dl0ZN8qpu5o4hjvuEMZ5XCeyIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761905386; c=relaxed/simple;
	bh=XK+YeaIp0k6cloojSWsT+fjXxaO/2rEe2E4aSXG6N1M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rXanwAP7E7uC1x3oIkuS2fNqjIZOdYqI2DPaxbE0OsiyFqzmVAWo6RECBbPxC6k0U2yJSpwzlv99UfqdfR6FgtorHQxQrh+m2W2opXYGDFHw0oC7rJLyuEpTEgCrVZwx5b2DQ5VVCT0f8a66bvXdSrNFuCQC/XT8zdPIw8LjEuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=EMAnQkQy; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-477365fbdf9so1641495e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 03:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1761905379; x=1762510179; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AR6DCodMEiRozMtWWQUdsBs+LPg+2s6MkeWZ5TMIU0g=;
        b=EMAnQkQyQOdiNa+vtDbNQhv3uG3pYjIv3x77GPmuXUP/imesHmF8ngbssVFvAqx9Fc
         v7GrTFo3wHk0Ld+Im02k8dR5j+5qOHBfv66XZIU4ntYhXvEBWCqynfIFcv9kfGYrxoDF
         YYvSABXnjZVnnCTUqyih+Pwxkz/adnZGRRcr/9pqtKwSvp2OysL9P2NyhK91t2+hItWG
         9LiIhL35ihNvrlNIz6wNkSCEsZF4uSW8rcaSAztg3fwkGZpVzYG1Nw6PjVj3vN7Lb5MN
         Liv6u/QWBJuvtiNXFcTmoTLXkfNdwF6QMYxzkuFJjlz7/GCUNWO5lVlMOePhAPgNB01h
         w1rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761905379; x=1762510179;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AR6DCodMEiRozMtWWQUdsBs+LPg+2s6MkeWZ5TMIU0g=;
        b=JdcDuDcahgID4m5nXcbHuxdLVtlbLgeyj6tlCLyOVx6rJ9uq5Xyv5SjUpl15xUlozB
         lOhNitkSL2KfOdQ5oZzlRN6Ns7qQFHA54E84Vko4x8dzY6AeUkM2LvsoTK1x2LqdS3nv
         U7oniL0QxLGxMsBW3li4D9B4XfonT4LHnRqecVyZIr1r762HsOJcKcn71SVj/Poi1JbH
         j+U7zWM/5mMEcVRtRfz8IvI+tLm9MVu3CwGspb3pkfoCO5Tl4AGJDvNKIEaQ7QWQVVmX
         t/WeQ18jmyM+XBcMoxx/XFQLj4F7V6caXzLpO7DP6BkE3gyzv+/emljb5zo3ZJWk45oP
         v3wA==
X-Gm-Message-State: AOJu0YzcOru2GUa46WqlCElB8uWgL1NuA1MVUFRlnsaQuKbBzIUJrxe1
	bfGqx84cRlw1jCU/RpAjho63sNtq/V+VHc8TMergTlDpBBRgET1nHs/bMFiA8vo4QnwLkeXBoIk
	ZMlp+
X-Gm-Gg: ASbGncvbk8Reo+UBksBCVz6fbytvKTH9suLWt8r0rt8wfIBqj1yF0Q41dvOH/XqaWSU
	WxftXS7xldIWKt/hBC8Eth949Q2p9aEEPh8H6hoMV7ZsZc8lYy1Ye/7PLr9cgSbLl6pYlOK0x5l
	9cJuEjCK1IuDhoSTyG7NLeYipcJX5qz5aI3bds1zjxvQhGmFpGR2651qIlM1/X4nu4C0IUbnIbq
	uUbJugj56XlXcVJhR/g91IojVHLZp+VfHUUnqg6FYxAA2k68ZwY+Tknl/vsWBSdHzvUqDLbOARG
	67he8xG6jRhfG9eBKZ30VuWX3CjULcKo+elwe9YFE3QlFCFXxQcLRJWxD22O5yCgc4jMoBvArkj
	Lfc+ZTA6L/r4YSC1a10xPxcZd6yqoWIVEYkmi3r7LPdEguPMqjXF4WIQO3HUgxya/5hevq3cuGV
	LL7g593rqKAm77jm3jfpfm5sMF
X-Google-Smtp-Source: AGHT+IF5CL1Q/oaHD87zPjFp4KiqyMUDxM2HoYOoLKtrm0XnT5ekaMI5s76J1xMKBksDY9h87GST6A==
X-Received: by 2002:a05:600c:3e06:b0:475:dc58:39e5 with SMTP id 5b1f17b1804b1-4773089b541mr25699695e9.27.1761905378913;
        Fri, 31 Oct 2025 03:09:38 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429c13e1c9esm2839171f8f.22.2025.10.31.03.09.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 03:09:38 -0700 (PDT)
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
Subject: [PATCH 2/3] drm/i915: replace use of system_wq with system_percpu_wq
Date: Fri, 31 Oct 2025 11:09:22 +0100
Message-ID: <20251031100923.85721-3-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251031100923.85721-1-marco.crivellari@suse.com>
References: <20251031100923.85721-1-marco.crivellari@suse.com>
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

This lack of consistency cannot be addressed without refactoring the API.

system_wq should be the per-cpu workqueue, yet in this name nothing makes
that clear, so replace system_wq with system_percpu_wq.

The old wq (system_wq) will be kept for a few release cycles.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 drivers/gpu/drm/i915/i915_driver.c | 2 +-
 drivers/gpu/drm/i915/i915_drv.h    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_driver.c b/drivers/gpu/drm/i915/i915_driver.c
index a28c3710c4d5..0f33cdc11736 100644
--- a/drivers/gpu/drm/i915/i915_driver.c
+++ b/drivers/gpu/drm/i915/i915_driver.c
@@ -140,7 +140,7 @@ static int i915_workqueues_init(struct drm_i915_private *dev_priv)
 	/*
 	 * The unordered i915 workqueue should be used for all work
 	 * scheduling that do not require running in order, which used
-	 * to be scheduled on the system_wq before moving to a driver
+	 * to be scheduled on the system_percpu_wq before moving to a driver
 	 * instance due deprecation of flush_scheduled_work().
 	 */
 	dev_priv->unordered_wq = alloc_workqueue("i915-unordered", 0, 0);
diff --git a/drivers/gpu/drm/i915/i915_drv.h b/drivers/gpu/drm/i915/i915_drv.h
index 6a768aad8edd..d9f73b9995cf 100644
--- a/drivers/gpu/drm/i915/i915_drv.h
+++ b/drivers/gpu/drm/i915/i915_drv.h
@@ -256,7 +256,7 @@ struct drm_i915_private {
 	 *
 	 * This workqueue should be used for all unordered work
 	 * scheduling within i915, which used to be scheduled on the
-	 * system_wq before moving to a driver instance due
+	 * system_percpu_wq before moving to a driver instance due
 	 * deprecation of flush_scheduled_work().
 	 */
 	struct workqueue_struct *unordered_wq;
-- 
2.51.0


