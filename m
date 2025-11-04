Return-Path: <linux-kernel+bounces-885158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29FD1C3224C
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 17:52:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE8B8420D3D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 16:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F48C33343D;
	Tue,  4 Nov 2025 16:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ccbUkR7f"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D06520DD52
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 16:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762275144; cv=none; b=LDRxf9Dl7+eFWuC70CgV04vDvjLtAuumqMgTyrJjXqddstXCLeWpruahyKizCMu7hJQoWCtaxzVAC6wAA5UCDNXPp7n2YbkWMk3Kt2yFoZgzFGS1pW8NqCADSMDpspCq2hPzu9KkiINh5dzGI8btHy0LVtJ6JktJG7M5vkMAUVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762275144; c=relaxed/simple;
	bh=Waao77MgDhV6cGwLlUokeX5i0bHOrrBqnoXpmnvyJj8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uw33dXLU0tCjYx5bS+5/OmW5tVf50TLATXUY78T9u75tmIxOmzzZooVDfW/6hJ2IRcWk8KU3HiwI+TEDmDcUpOgdEcFdgbq2tv/hNjlVyL6gxPVPou0nx7cvA1byT8acCvtGa7G8K1mJnfKhhKN6neyQQ/IfETgykRxNSXiy65o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ccbUkR7f; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-47755a7652eso7861965e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 08:52:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762275140; x=1762879940; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3I7l2wLDDwEsKZizWvufJnUJgFCRc38UnTb6EWKRbEM=;
        b=ccbUkR7fn+V61q2bebSTjbDgYb/YzXipvMbYpfmCbYz7vUxG3Y/fq/xqW75QaJkyrM
         gPDHKK8u0x97Bh5bsk97oLXooUHvCdf329b6soM/XUDgE/+L6mZsxvILH8Lyq9D6BuRx
         fDEhbSepoNdELSkjvZgOYt1GCJO5dOM4YlPshHi2eBfohL0tBfUy5wQtiaDZddNfAQ2F
         si6KAn96xZiF6inGUbRlZ/deo5TjuLpVdizvE1PZbcCnWfdHMjlIvKea//PJ2Dtg6cZi
         kgRhNlt60aw5r3b7Bz0aoh4ZzoFKA6aFxr0PRHXF9cuKFGYcyZHbZE8SpFiSeVIC00aD
         AfyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762275140; x=1762879940;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3I7l2wLDDwEsKZizWvufJnUJgFCRc38UnTb6EWKRbEM=;
        b=f2v1cJ3AyBWCxzu9ANPaAn2/81lz/HR+xALpPOslz9JavKAlLGiMRfmr5BBXuQ3I7+
         ENxVC/R54ngNWg6r9eFp6uopklazX49MoLHcCppxom30IG93f8PuT9fOggaVQ4FzH0Bz
         La7JPqS/S3R8am2DiD0JHTJ9r+YdBhYpfBHc9NWcx+F6lsC4bZDLVsvuSA00X9xx4kuH
         GLYRx4hWtLbPE6bm/qCm5bGvIQVEd5B5qlgnH6F9wgaaGmJ+jfnkdnXEHDsWA7Zf9Bgm
         qGMmpdJV9IAEwWtDt8c4QtDohei1aSSOduq9JXI5HvUadtydeNrfSzu67fRLrwubiCFc
         d4jA==
X-Gm-Message-State: AOJu0YxSQjTEFyj6LTUToeyEprankut6eUXOwHZ6IZj9HpAsMkbUduuD
	26NAwdqv1VsJvUxIJMSj0bdhESfyTOkKwdqG4EgovzVZNs1ClJjjRQ7RemciVR4FMVuHJs/VQt+
	uTg7e
X-Gm-Gg: ASbGncu4E8/1DSVAs+zl7F8IiNjIOjHcim6s/fiU7lBfooIUpuKvCYMBw1WEHn72Vaw
	vSSXJLUQdyD+OSEzgT8Sh36nGz8NuNtXLEnQ4CiBrPzQ2Hirkis3rR17oStu8s7gu0B/tuGtRDT
	0JItvN0N/M9oMcG1yB93vSyI++MxqhHM/nClKZv+vJGHFTPPppelLZplN4vKytUsDrfUJKmlvtj
	ytBdMMTW2WGtR47sBoPFx1B0q89eFoux2tF0tLhH4CbeODVYuod8JJ00dd/mrHZPRc2J1LhqgvU
	Z5ph5+FJNVg/tQBlt5PgHmX6Xt4GITvIcyms/dVupfzxtM5rvYUi7I4ETDNIxCrovAbMlp+Mslj
	iwDOBqYuMszL47pKtcDcPjhKzlDJSGB4/1j65JYDqjKdf74gKjVzs/licpHnvEhVcP/2lYEZIlJ
	7PI3pWWe1/ATnvJjjJirCvC2o=
X-Google-Smtp-Source: AGHT+IG3f1EiisRZ2Ghmy4+ZkeArsqoIDEncz9VaV8Ksohr2DwWKIXQ/Q+IucAz4uItuId/2mUvT7A==
X-Received: by 2002:a05:600c:4e43:b0:477:e66:406e with SMTP id 5b1f17b1804b1-4773088be60mr168636915e9.29.1762275140054;
        Tue, 04 Nov 2025 08:52:20 -0800 (PST)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4773c394f17sm224276905e9.14.2025.11.04.08.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 08:52:19 -0800 (PST)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Philipp Stanner <phasta@kernel.org>,
	Christian Konig <ckoenig.leichtzumerken@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Subject: [PATCH] drm/sched: replace use of system_wq with system_percpu_wq
Date: Tue,  4 Nov 2025 17:52:09 +0100
Message-ID: <20251104165209.309545-1-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.1
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

This patch continues the effort to refactor worqueue APIs, which has begun
with the change introducing new workqueues and a new alloc_workqueue flag:

commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")

system_wq should be the per-cpu workqueue, yet in this name nothing makes
that clear, so replace system_wq with system_percpu_wq.

The old wq (system_wq) will be kept for a few release cycles.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 drivers/gpu/drm/scheduler/sched_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index c39f0245e3a9..13192e99637a 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -1315,7 +1315,7 @@ int drm_sched_init(struct drm_gpu_scheduler *sched, const struct drm_sched_init_
 	sched->name = args->name;
 	sched->timeout = args->timeout;
 	sched->hang_limit = args->hang_limit;
-	sched->timeout_wq = args->timeout_wq ? args->timeout_wq : system_wq;
+	sched->timeout_wq = args->timeout_wq ? args->timeout_wq : system_percpu_wq;
 	sched->score = args->score ? args->score : &sched->_score;
 	sched->dev = args->dev;
 
-- 
2.51.1


