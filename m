Return-Path: <linux-kernel+bounces-895057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id ACA3AC4CD09
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 10:58:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D37CC4FD9BB
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 09:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD5552FBE0E;
	Tue, 11 Nov 2025 09:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="VKJH3jyn"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8877D2F5478
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 09:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762854666; cv=none; b=jRt1p8xCH6gx9YPOuhiUx04tdFAvDspNR2d+D4IIZJnjUQlI4yI5UdpACprw1dx5Af7uuexaTAdaw6IpofD2dY1TlObh6ZGZ7lvqco8L9/k2cyaLD6CrBJBJ9RB/QxU7fqSjUW8MhMC/g8AQfgqfGWGk+SjmX7ZLhZAXMi+ktLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762854666; c=relaxed/simple;
	bh=PxMjrQfLGCNPCPfcG+3vDmiZS4Gy+k6Hbmk68mQZykg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pw3L23worrw+WM1IPjvffropyp89rhm8IkKTjltAcaFnuFyQ4Vq6bX4R1klPpfGcW/2zE2aPc48zz1bc8iqFS1ynkGGUMgqebG3xIrS6Cz5G432w3WHVQFCaq3iutT3b8alZBxzBEkRN1lQ/t/ec6i3Ntg8AWIkKKKCAWfFhmZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=VKJH3jyn; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-42b32900c8bso1310274f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 01:51:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762854660; x=1763459460; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=COk/1h5aEbbVr2g94DPcBm4hMzvak0kI6Rv1sekEHQg=;
        b=VKJH3jynHExwz7NhLWH/gUYB6qgW4gFUGbwK3k0BR24ucb1WXLS9SkkBdnuHVNJDBu
         lSow5G1x+NQo540tS2Vq5NdwfkmtIPzQ61cAApRZM6Mooh944Jfgy91GuLrmHrCJ3gkW
         aiJ7liS2Cuigntb1QsXiBt0CMZIARMhLPIaTSK+mtqmWlGfI5UnDPlDRNLqZQQ0bAi1I
         pxMgBhLpuHUH3vlwFVbW6YF/RSv7aBqy2QwKuAFdMRAVvYe/3anu+LVxbA3eR2sGDjQA
         ohj2tO8YdTJj98hX7JkoB+JVTnYTVTt/jEcfATdCA8bm4jo1mNsgIOBlkl3QItaXEmX+
         sTeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762854660; x=1763459460;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=COk/1h5aEbbVr2g94DPcBm4hMzvak0kI6Rv1sekEHQg=;
        b=K6q464jTHgzyNzhF8tlD8uAhwYrUv0iRO4QNZUptMhYI4gFJnHhVPac+IOiQm37zyI
         4rbkbEOUKBMLLtGGYbZHs7QwhxameuTA8JFJL9003v/EfrYsgQo6FPDxtDdjWvEV2PiC
         trK080f48M9QmZZ4/V/FlTB/Scfw0JYdMnfxSfuB6UXjLw6ji54dU5jZxmB8D8ZGLvVj
         wIJ9ovWBtvMtm3eCVnfAxv2lLmU6cG2s+PiV+l1gP1lgF6UpIeE8ak9S0Nh3rzPvybDE
         EcHwESK4DtSFdIl9c7cN8UoyeShB111ScfLGv3vJZqgLonGvX36KpdRU5msizFoB+yuu
         ejEA==
X-Gm-Message-State: AOJu0YyNvbTb1XgAHz3y/qngQiaEuJB/28r7bN6MY8hA6ef/0D18BXEC
	fsM8jAhpRwHynhumOZG0zDUsMLbbamrSbX6Fl+BNvipWcRWqLfRC4XTQ1nvk82Yywpupwa7XYLf
	jV+Cy
X-Gm-Gg: ASbGncuwUXvLPQ/lY23b5vM/HcWJa1cxuosawJmYswSlcpxQ9DmvTs2ime1nHHFIOzo
	3Xxp7cKIFHb0/nYIM0RVe6a47csy2ry8/sv4/is252XSIYJCfVyLxntGVFJpEchrtJ3zWiRtRjN
	j5eKqw4elx7kmnB//TVf2nIFpJrNOYbg4RfY2kIhgiFUo1zqL/Kpsqzs9pqV0Z5raHuTvJVzB5g
	F1biLGONL7T7y/57923MApwkrFOs1hdCJab7FebDOJT8tZqweSNiMGuZJmtp2IfiOV+d8d3KQbo
	rpU0inkxc1Ysqd0yHwiBRzWHLb0MZhaudBhUjOJ2VbC361HDCIrE2VxTuixKWE7TfxvwTB8ITam
	Z7JvSKClokMQVl60ZvVnu/bn2aWLLbU/zX/bxyACMoJ6gM6NU6S4ebIfEh+XpLL4vfbQJdo9OmN
	Dzc2LdleNQREQh6myZSyjHvctJ
X-Google-Smtp-Source: AGHT+IEGGihhO34PtW58vPvnGz96BDqop1knHZcnwdzlKCuwCgN24yrgoK5E5PupaYVgZy5LodYAqg==
X-Received: by 2002:a5d:5d81:0:b0:429:c711:22d8 with SMTP id ffacd0b85a97d-42b2dc1eb5dmr10445085f8f.15.1762854659576;
        Tue, 11 Nov 2025 01:50:59 -0800 (PST)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42ac675caecsm27136013f8f.30.2025.11.11.01.50.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 01:50:58 -0800 (PST)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-modules@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>
Subject: [PATCH v3] module: replace use of system_wq with system_dfl_wq
Date: Tue, 11 Nov 2025 10:50:49 +0100
Message-ID: <20251111095049.67658-1-marco.crivellari@suse.com>
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

This continues the effort to refactor workqueue APIs, which began with
the introduction of new workqueues and a new alloc_workqueue flag in:

commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")

Switch to using system_dfl_wq, the new unbound workqueue, because the
users do not benefit from a per-cpu workqueue.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
Changes in v3:
- rebased on 6.18-rc5
- commit log improved

Changes in v2:
- a per-cpu wq is not needed: replace system_wq with system_dfl_wq
---
 kernel/module/dups.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/module/dups.c b/kernel/module/dups.c
index bd2149fbe117..0b633f2edda6 100644
--- a/kernel/module/dups.c
+++ b/kernel/module/dups.c
@@ -113,7 +113,7 @@ static void kmod_dup_request_complete(struct work_struct *work)
 	 * let this linger forever as this is just a boot optimization for
 	 * possible abuses of vmalloc() incurred by finit_module() thrashing.
 	 */
-	queue_delayed_work(system_wq, &kmod_req->delete_work, 60 * HZ);
+	queue_delayed_work(system_dfl_wq, &kmod_req->delete_work, 60 * HZ);
 }
 
 bool kmod_dup_request_exists_wait(char *module_name, bool wait, int *dup_ret)
@@ -240,7 +240,7 @@ void kmod_dup_request_announce(char *module_name, int ret)
 	 * There is no rush. But we also don't want to hold the
 	 * caller up forever or introduce any boot delays.
 	 */
-	queue_work(system_wq, &kmod_req->complete_work);
+	queue_work(system_dfl_wq, &kmod_req->complete_work);
 
 out:
 	mutex_unlock(&kmod_dup_mutex);
-- 
2.51.1


