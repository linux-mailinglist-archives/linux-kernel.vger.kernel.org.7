Return-Path: <linux-kernel+bounces-890308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B9321C3FC31
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 12:43:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3C7DE34B432
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 11:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE7CE31D748;
	Fri,  7 Nov 2025 11:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ZGs1MnWH"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77533161BD
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 11:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762515809; cv=none; b=IRBggqaiQwXsGnUiZt3dJ3+868BzcwfeGbo5kW18mdy2unzdJTRM4TgMeOA2isSj0TWu+QeneJl99a/XIrDZjAgZH/Gj9n46T5V3+o8rl2I3oHZ5Tov75YPeHCekCoukLeUof/5jaItQPbuoDegGyWDfDjJcLu8LOCDNP8DPmQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762515809; c=relaxed/simple;
	bh=igxcugRo2gsC7ToIarEn9D9lM1HOHbVKL+npVMN4tqw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OXrU9KoGpeAYDDCJq0jKPC5XOsWGLJC8pYHEvoZgis4InihMj7dE0AR+CVgZH9GUCd4KmoszP9Ea2LMMlrH3HR62URZSjxgpuUKaMxI7TUDsPPHalCim9UDFaG38Ey4/yDX7b2Zvln6PY0/tRyhNIug1KrxgZdUn71KzoPrLk64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ZGs1MnWH; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-429cf861327so448249f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 03:43:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762515805; x=1763120605; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DtU5xQgGX5yGwiOtiwdnNsANwvMzJtrcdDz0DORVP0k=;
        b=ZGs1MnWH4zpjQIteSLHp/iMq9sBdsPvdsXSd+0H42dsYa52CxfGhr8QOZpK+cK01vT
         xXFxMz8V7030vSEdNuetUMN9GHnlP8+b7vACkKDoYGlWVfKA6m58O2Bbtg6xe9dfvY/U
         jT5qhZ2q9RRZYqohO6Hz1A2Mt1N3br7gFFCelUlqSJaSG9zBOf89Qm3V2SnhhpJSDXsf
         D8L67LeewOlInyldwsl7rdu9eLHs+3unV5ifdrWwYw82EJa9YW2y9ttg2VyP3FsBv2Iw
         qJIwyUzIs5lsAL6m+BJsOwacmX8RdM+ARIXq/Er+283T5be50SQWkhDpwu0RaYah4XIc
         jsMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762515805; x=1763120605;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DtU5xQgGX5yGwiOtiwdnNsANwvMzJtrcdDz0DORVP0k=;
        b=JACcCKCMH3qRPZr0mbjqmmyg1TpjF1MeRj2JuPqpFRs/sliJJNkBJWgMyMyk/yKDdS
         k5u1vCZeyUyCR+O4bB/pSX//Js8EVji8fAanCvMyqqd6DuXDwGwcAuWX+s9hHXAKXopc
         HDfQE63onJw0pRMojqdC9Ta+q1gClEHtQyKVY4LjtWgjh2ZmDzf0lFauHMkmpL2zUqE+
         n5JDEwXRs4pc4yumredUDPuv9OgCXPO+YNW14scEIkaTve9L6ImecZeCRqSom+dow+Ek
         e3/hmHpgVjsAQDOpovtHIxVlXMG3a37IT8893bdffUn4yGvHm9sAZ3Fd2eIcv7zbJVi2
         TZCA==
X-Gm-Message-State: AOJu0YytvTlLPWGN9NM8oDrFzcMgeipF4NTKKrLChws6IqPkpHpQzO2g
	CvYdWXNfK1Om6kKsZxbIoY3cuIJUyIe+7w5pvdJjhgNggkasdwJg4O/TpyOE6jSusN954tj8FiT
	J6+dC
X-Gm-Gg: ASbGnct/2hYTUNAD3+p1CdZ/aOHLy+ghqpuZO2hsOX9G1kVXTxdF813MxOYKU1E4QkI
	QnKlzlQnQuyt93hIp0f5ggJfBgQ/9pN2NBo1trA3ImPi3IK9+VuTeRPsIydix5D2Mv92a8PFEQJ
	ogCfAEpSlb+0wdgHowYdSu4GCEwubK9RH1WyASBHUBOSj1loXhYC0n3Mvodo+DpHNSRTEIVp/rO
	H3ompdpe/p9NAEIlFprrdresgGAnE492V+8qbxw7exZN6lUKp7rj1lTQSBsjyCUEm4PcCOgFM75
	LTe3yVfq8p0/ry5tCgKcJkgqaSRIjbCZq0US0FJXgliFm3yrs+/7swxOQS5ivrWP9RXKpBfK5P6
	hP3s8mEx8URzu0viuwXxg2dzTSBMC9B7va9O045bEyH2w3g6q9SVLhQumkKHgh6e4hIi3ch1jDv
	5eclQgwo9V32GszjTNU4aafI3+
X-Google-Smtp-Source: AGHT+IE71d1qwFCKRyct0sR3hoeElw0JEYM50BDNUYXDvLimPs82nxZjGLhOCDMs0ycfoeg2TKW09w==
X-Received: by 2002:a05:6000:2210:b0:429:d437:cdd7 with SMTP id ffacd0b85a97d-42ae5aefd48mr2333132f8f.52.1762515804767;
        Fri, 07 Nov 2025 03:43:24 -0800 (PST)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42ac679c5dcsm5705754f8f.44.2025.11.07.03.43.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 03:43:24 -0800 (PST)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	dm-devel@lists.linux.dev
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Subject: [PATCH] drm/bridge: anx7625: add WQ_PERCPU add to alloc_workqueue users
Date: Fri,  7 Nov 2025 12:43:18 +0100
Message-ID: <20251107114318.163015-1-marco.crivellari@suse.com>
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
 drivers/gpu/drm/bridge/analogix/anx7625.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
index 6f3fdcb6afdb..4bd34b9825a0 100644
--- a/drivers/gpu/drm/bridge/analogix/anx7625.c
+++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
@@ -2668,7 +2668,8 @@ static int anx7625_i2c_probe(struct i2c_client *client)
 	if (platform->pdata.intp_irq) {
 		INIT_WORK(&platform->work, anx7625_work_func);
 		platform->workqueue = alloc_workqueue("anx7625_work",
-						      WQ_FREEZABLE | WQ_MEM_RECLAIM, 1);
+						      WQ_FREEZABLE | WQ_MEM_RECLAIM | WQ_PERCPU,
+						      1);
 		if (!platform->workqueue) {
 			DRM_DEV_ERROR(dev, "fail to create work queue\n");
 			ret = -ENOMEM;
-- 
2.51.1


