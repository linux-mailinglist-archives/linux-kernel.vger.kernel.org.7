Return-Path: <linux-kernel+bounces-886234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94009C350C3
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 11:13:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3B8B3A2D12
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 10:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FF6E2C3253;
	Wed,  5 Nov 2025 10:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="eBMEbHhZ"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9735A25A631
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 10:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762337513; cv=none; b=KuQyY/PaEjRC7L3OnlL3i7RtoqtLD3heKRabkAw3ffOK5qsiue85wN41aamnoX1fSYHsGT6g6ah5ttr7aGlDxu6LVm2XE+luYdW44zxAjhJtn7GCcuq/gUnchKvt2B11lhGP9Y766bvHJ3UMaeEIFQtf/OH0G1bPtqILEbqWrAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762337513; c=relaxed/simple;
	bh=wXWpD8ofXjLP8g+SiKl2VIBAc/4GqWtGVWEq4wqe/lM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jngLpIKjqmtickoueyDyig7THpE16mYou4rJ29AKfq1/XT90+pwcaXBTDhbnNDcN9m2SSZHcLrBkkE77jrLVjVrJzjirb0tS+kZyWndtRsLOcADzDn8K/2rgCOWgZqfIq7BeX9AVdoS/QWwMqHqwvQcSnZjoFbXZnw0k5WqhmAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=eBMEbHhZ; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-42557c5cedcso3875070f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 02:11:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762337509; x=1762942309; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c6IOSSXQpeyOMWOQdM3N30XqGgJttW4GxAyefGZ0B4U=;
        b=eBMEbHhZnWwZz91vT3JpVoYjJjygp9W/FoEU68mmkQ5c4K+sacPaJU3VcpcRxDdQ8o
         efi7Bl0+mQuVw9KwSdQ2WiBy2Cn+JUOjdKOqMp+xjVHeR/f/9uZYv2KyH8uInhpTuHdl
         1qIWHhGDcARN/m/OLOAhFrIzGSAlm9mGszmGDRO+c/3S1uxAL9JyWcCIlYH8A8gyPvwy
         6Z7M4LjYaf0OuVedRg85Cx6lSxi9YydbssteOd/3s42cctVU5YvzXraW3kY2AZRLGuwC
         +n9qKjn0xq/6ta/CiEct16mETzqoWewpj74fBoOwbCz8VxA6Pqm6TTEn5slVesUEXWms
         VzcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762337509; x=1762942309;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c6IOSSXQpeyOMWOQdM3N30XqGgJttW4GxAyefGZ0B4U=;
        b=L8hNkT7tCvq1JwSTjRVCWgRDDADuw5m8FBmCchy2C3duc+w8ab/V5ianRMXAbRwZ4o
         rcgMuX9V4bM/q8GTFNJEMhQaPOs1221iZOcFpwDcyiChchY3uj0PFs4OhmdUXdNUnMv4
         2I0Y7pJbCMz9Th3ipudX5pTmxSQroIo5nqdrO5YAUNpsktNebZIqY1HuM9mwS7sA8jRR
         DPcUkC3HLMsnT977auYgQa3J7l5GVUXqPLw62mXZ4Ac1rq4GdFx40IViXxkMG7T3qNj2
         qZARzl952YBED+/xKi8jSsGciuD8GG8OEvK4Sn0gZdp5E7YM4CtzXygCi+ZDlZM3iVCC
         LodQ==
X-Gm-Message-State: AOJu0YzsuQXcdrdeG5ZQsFAQaX9n77vOBOfmPM+/xUYVNCJddy/Rf/OK
	v0D+Naq6zdh7YlYM2Kuwee8lwUt2ahs5NNxB7sv1NNifU8VqIpw/m5en6b1/POQEvExkQbFTBHv
	zWdMZ
X-Gm-Gg: ASbGnctaCUE68ei4+g2KrSPv/GHu/45wAUvTE8vfgVDocKjVmkSUBv/Cmh3YuMMYBGt
	7I381eSNAvtMpq9Kh20iqBuQYjqCfIJiBv7H0+xm6/iMRy3U8OfTwm9QgKIMtOafAY5kjtmHRBV
	Uw7I3J0+pt/oDpvLkHAgCFrgQma8ui1EA75qZlaZ2Hf1kIVivXpjNcdzAhv8Vc/4BDfW/9h2zGw
	jz3HMnI4zMi5nFYnJs44bdJ3EiJK/YmmYQMwEJOK08wsJ/kqh2OkgnDxk5fZZhNgg1G6rb/b0K4
	cnHId9X38jPAAbwNCFYMcJNLefOzMX6J0Gnqi/oh7MII2LARHKtvNobt7lLcPD9/s104RKe61YM
	Mo4Gqke8BQsiciaSxlc3kfHoQkWr/F5P7L5rwAy8nnIvSa8aqcpOTNy62nQIDPZTks2ZYEE81/I
	lrXEn8LlzbfdplnYoTDL5+FKO/
X-Google-Smtp-Source: AGHT+IFJg5iLqlMomvWLLSqs7mgunbxsu0SjUFjBymO69nvB6yBPIReaX/Fm9l5lX9rWprCUSBoxfw==
X-Received: by 2002:a05:6000:2084:b0:429:cbf8:1765 with SMTP id ffacd0b85a97d-429e3305c61mr2310886f8f.33.1762337509440;
        Wed, 05 Nov 2025 02:11:49 -0800 (PST)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429dc1fd2a7sm9294925f8f.39.2025.11.05.02.11.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 02:11:49 -0800 (PST)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Maxime Ripard <mripard@kernel.org>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Subject: [PATCH] drm/vc4: hdmi: replace use of system_wq with system_percpu_wq
Date: Wed,  5 Nov 2025 11:11:34 +0100
Message-ID: <20251105101134.82064-1-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently if a user enqueues a work item using schedule_delayed_work() the
used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
schedule_work() that is using system_wq and queue_work(), that makes use
again of WORK_CPU_UNBOUND.

This lack of consistency cannot be addressed without refactoring the API.

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
 drivers/gpu/drm/vc4/vc4_hdmi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index 07c91b450f93..c39cf1530f23 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -745,7 +745,7 @@ static void vc4_hdmi_enable_scrambling(struct drm_encoder *encoder)
 
 	vc4_hdmi->scdc_enabled = true;
 
-	queue_delayed_work(system_wq, &vc4_hdmi->scrambling_work,
+	queue_delayed_work(system_percpu_wq, &vc4_hdmi->scrambling_work,
 			   msecs_to_jiffies(SCRAMBLING_POLLING_DELAY_MS));
 }
 
@@ -794,7 +794,7 @@ static void vc4_hdmi_scrambling_wq(struct work_struct *work)
 	drm_scdc_set_high_tmds_clock_ratio(connector, true);
 	drm_scdc_set_scrambling(connector, true);
 
-	queue_delayed_work(system_wq, &vc4_hdmi->scrambling_work,
+	queue_delayed_work(system_percpu_wq, &vc4_hdmi->scrambling_work,
 			   msecs_to_jiffies(SCRAMBLING_POLLING_DELAY_MS));
 }
 
-- 
2.51.1


