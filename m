Return-Path: <linux-kernel+bounces-879930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DECCC246A3
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 11:21:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CF3324F0322
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 10:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CEE333FE03;
	Fri, 31 Oct 2025 10:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="DTwUCsRU"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B767C33F362
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 10:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761906033; cv=none; b=I735g7Kod4H3Ezw6hdBhHdO1cGVL/Zfl3YYtChxKvgfExaVYvzpHz+s38wKLz/dJxoonE9mtOcYfGPR/wr4KiZ0qQCAAyfQuKPIS91CqvcOSdhvhGll0vqbT80ARHkd3eYf4B7rncZqUhGlOP9rsrr2nF1g5JCJYOKKY+OjUf9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761906033; c=relaxed/simple;
	bh=8vaJQn12N1SHmdIdktkw0yTPHhSfa/2Poi8KW4nkNOs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eQoKz8xBa8GoxqaDp3xDp1HQ09ayqH35FDNKv3loU+VddRvHM4Oz4GGbDzxV+WjVdLiTLJDzOdpVNAnFk5VnJ/RxXeFR9npSw4l9Ew78I0qFFgLnbXWQ8Yk0X3JNWv9IyGYWrYRyiLT/m9XGXa4w6X+CsG/aWlrvRmiHgLzCGmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=DTwUCsRU; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3ee15b5435bso1555382f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 03:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1761906030; x=1762510830; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/u+awZrbSzQ6eDfqV7nDtHfvXhS1UpzbuBjH1UCPs0c=;
        b=DTwUCsRUq5E0tlWX3E0X+blw6kHyNP7DuoDDDykweRk3ESGKcmrsKbMn/+nn8nCj8N
         YdiYWcrK4EvTlc51pXbKH4Jl2JVXoz708Tkxst7bH155vXIc84vgQ4b1/37O71yRYQ24
         Xgp2XTvZccYL5dmxtCHh+f30aew71iYTHHRpnF9ZfFwjZa+YJQedUDQ9beadY38QsNwe
         Ko5vjiJIbiqGXhaC7y4UvlAloBktQEv4Wg81XlXfQUunLsQibJw6zv9mCD7UaX0Tdr/N
         WKRGW7C5u5sK3299ceVTC2bN0VTa3R5ZMM5XN2BikafsINb6frzimvrohCQO/Q0WwRnM
         GSPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761906030; x=1762510830;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/u+awZrbSzQ6eDfqV7nDtHfvXhS1UpzbuBjH1UCPs0c=;
        b=NvoL7NkdcGySe8tkmxRwYllc5+p4MkHPS4XFGDnUL2zFKqKJDpAY1wbz7HIGdLswQl
         g2kJz2uvfcTzSEcnx7l+3JfWXTo21PySfHy2xIhf3jqVwn6zoJIPXNI4ve/HHaLFg1So
         J2y5oxr2TKCxtmZHihXJ3drFK521I9wFpzHu8eOcXEpKGGWcrhx5ErdkojQSm2cZeq44
         snvPL6jYCHNHLCi3LtNx7dUwZMbOXCm+4kvOkoJF5x9hQG5xgNOu5YoEewx87uPD0Sta
         UMBM+hfAKUxSCaDt3BTmSq8KJF4PsSCr6nDPcnb526OdTfUciENP8UDynpW0XMkn54jP
         xu0A==
X-Gm-Message-State: AOJu0Yz0sOH4ouemu4Q+FpIy3nHjtAolxFTuDbjOKdqbd4toD6rimDgF
	tJQIhbSabuJQNLKRYdTcPFivIU74SO/NPBWiJFSlPIqlY5WLCZMUVCtxCBtbXwobRIJm2u6Ebyx
	ndXgk
X-Gm-Gg: ASbGncsu/zncEeHRLv4K4FEAKIqkhExX8NG46M8OSlDyg7wj/+kbtbxBXvid52dnwzG
	jFo6RbbBapUktohPKyxm5El4t1uiBROXsILe5fYrNK8LNZ8DHCkbALlSBW6j5P4NAlrf1Ui0FtW
	SOA0xbs63ZR1Wz7QI4vYhM+N8SLgQ1MyL9NthW5l7NwKqpJviOkWfne+5j/jbOTn39zokc1wy1B
	DmRcsdGYYV6Yr8jL8fSenJAi/IlhmjXytpufqmDx8giKAtUosVFHOJrIDZ1GDVdQ0eeHWfarAMR
	j2eP7fbTDjMpArVH5NT+OtTH2gnI32HrzAGBJyG7skwPOMCZzV1DFgpjjEWdopikg6VQME9/g0v
	EfUaEqhN18PPoXMG+DsT7ac3M4SQq2thY0bLxiXD7F7Iaco9pS7LpaxV2XZoKuTYq8BW8HsqyGw
	TquJYZ/njyIGddXP+4yNXSFBwN0nkXzFMp4IvgQrszNSSUFg==
X-Google-Smtp-Source: AGHT+IFGDvTKB2rxlJh5yej09wy7WNNlEMpaWtu5SfSjAIP63L2LKeKXvN3qht8svwvhZJc5Fdl6Ag==
X-Received: by 2002:a05:6000:2f86:b0:3f0:2ab8:710f with SMTP id ffacd0b85a97d-429bd671cc6mr2113941f8f.8.1761906029644;
        Fri, 31 Oct 2025 03:20:29 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429c110037asm3090410f8f.3.2025.10.31.03.20.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 03:20:29 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	nouveau@lists.freedesktop.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Lyude Paul <lyude@redhat.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Subject: [PATCH 2/2] drm/nouveau: WQ_PERCPU added to alloc_workqueue users
Date: Fri, 31 Oct 2025 11:20:20 +0100
Message-ID: <20251031102020.95349-3-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251031102020.95349-1-marco.crivellari@suse.com>
References: <20251031102020.95349-1-marco.crivellari@suse.com>
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
 drivers/gpu/drm/nouveau/nouveau_drm.c   | 2 +-
 drivers/gpu/drm/nouveau/nouveau_sched.c | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c b/drivers/gpu/drm/nouveau/nouveau_drm.c
index 1527b801f013..5a2970ef27d4 100644
--- a/drivers/gpu/drm/nouveau/nouveau_drm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
@@ -631,7 +631,7 @@ nouveau_drm_device_init(struct nouveau_drm *drm)
 	struct drm_device *dev = drm->dev;
 	int ret;
 
-	drm->sched_wq = alloc_workqueue("nouveau_sched_wq_shared", 0,
+	drm->sched_wq = alloc_workqueue("nouveau_sched_wq_shared", WQ_PERCPU,
 					WQ_MAX_ACTIVE);
 	if (!drm->sched_wq)
 		return -ENOMEM;
diff --git a/drivers/gpu/drm/nouveau/nouveau_sched.c b/drivers/gpu/drm/nouveau/nouveau_sched.c
index e60f7892f5ce..79cf157ab2a5 100644
--- a/drivers/gpu/drm/nouveau/nouveau_sched.c
+++ b/drivers/gpu/drm/nouveau/nouveau_sched.c
@@ -416,7 +416,8 @@ nouveau_sched_init(struct nouveau_sched *sched, struct nouveau_drm *drm,
 	int ret;
 
 	if (!wq) {
-		wq = alloc_workqueue("nouveau_sched_wq_%d", 0, WQ_MAX_ACTIVE,
+		wq = alloc_workqueue("nouveau_sched_wq_%d", WQ_PERCPU,
+				     WQ_MAX_ACTIVE,
 				     current->pid);
 		if (!wq)
 			return -ENOMEM;
-- 
2.51.0


