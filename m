Return-Path: <linux-kernel+bounces-802505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79ED4B452DE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 11:18:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F4441889842
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 09:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C11831770D;
	Fri,  5 Sep 2025 09:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Js014Lja"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A9130FC3F
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 09:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757063619; cv=none; b=Q80qqr7OnRWiYnIKGuy1tgO5ENcd/qhpyFTg9Y1XP1tlkgUhsvKkapjDaY1thwPx1B148x0QlkYOgnBWN7wt5lj4FaYlWPOCHaarf6xyqOclLv3uu2zHwtztem3RlXNLkR7HAp0Fcs5MuExNNKzCfuiD47ce6HH8TiLxFTYehaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757063619; c=relaxed/simple;
	bh=rcxNftRyzyKRzD1KQZIlmsH18h9h4Fz0l2lqKze0U5o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M2vYthF7MYZidlxbEV5HTqa/lEqUZRUySWbgQ++X+hz4F092XZsP0ZBmiLQOJrlBmmS0UYk/B2h6Pgbga3H2ZQh0yPKowBZr000Cpef2TM4scg12Rrnr5WPtVsXRrGLbz+UIcGDHu1/Mj7hGu4CMbUW/MS4HoE4huqtoh37VVSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Js014Lja; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-45b8b2712d8so17499855e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 02:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757063615; x=1757668415; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z3io79lXNPai/LjSUe9hCwspF7/+HpxLi4SOZ36MG78=;
        b=Js014LjaY6huhU7PaIpG/ZhRU6bITkUs+au88Bn5XB/KflrTIb9sVzo9zfEYrxt/iK
         ImmiSUsZcsee4FaMeFBV+IwlDk7OxOD5PdANvkuwWn22Z/g7aTL7JZ3J+1jfU7sl1W5g
         jVCa0bkgvVKtMcW64ZATeBQEOhR94/RXYONIzHoPKWacI+Q/fHrW9P52nBYCeoupF4oo
         hXzJpsmOwoTb15lHAXMuvsm968vr5I7OBntB61Z9evbPslKM6wzyzqCZTX1/Y39TAhpG
         Z4SGZ9jbkdM4CLepSEmGllWT9B3OvTyLlCL6pJpr7g0c6lUVG5Um3R9ZxySiHNJhDWB9
         YzWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757063615; x=1757668415;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z3io79lXNPai/LjSUe9hCwspF7/+HpxLi4SOZ36MG78=;
        b=agSqYOk+/71mB3sM9NEtHy+iJxlcaGzcSaJaVM7UUKGjIt1zwBCZSPZPNIHgVPnOKT
         HKEK03Z6htPEOHBgGiyzUGldoYj82bX6PcsI3kBXZvFCv9HnZ6u2upxGS92WMeaWymEq
         MN7hOHShZEUG2UivvYVC7zjILNNzznr9l5zW3BXGgwcPF6u+Qd9cEasLhXiRIRnrmjB1
         BOy6BnX8oTZnTy/NPURElB1nd1mxMWTy25Gp8TXGxxH9DbRvW2eIt4jl1f2sryllvz4e
         jCPQUaNQy+2OC0a6R87h1FyCo2E6CVyoHpvRgm2bVsrL3T5ckVA/bkFG4xBwrkz1M0xk
         5DEg==
X-Gm-Message-State: AOJu0YxYjGstEu5W3wnsX/5kZh+XKLnQm7KAN83ttKfX+KdkDJ9Y8aUa
	edgTQCUU0OLTBgASFocTKDIAwSbP7dN2fFJnHYRyy5DXBgv2SUnSYCWpZh0T1DPvCNdVordTuZU
	b2bkMiHM=
X-Gm-Gg: ASbGnct8KwmaL4CCQM2QR3Sj+DKz1XSNT+5yDgqz3rGAuqMPBIuQztYNjAOErcnE+/W
	3TpIpE38lPqH2TQgoMTA6eaqa88oUm/rbAEnk8lZ++/G7gRGnCJgdy50btfT/nnGhGFdjhdnivG
	v0/Qvp3rmklpFXQtVD7r7HKyCheyQG0C6wUqlfBOJjbwTbI2PROpG0RCU/30G8FxoFfDTv/29Mt
	7YYtIcF85o7y0g31ItNlVOpB9hnvoKQnHB5QZQVVp8WU+w/332u+iHJ34mlU/mcBbKkqmJwknd5
	kh2xgW1PNaR+LB/kWRPleI3ZT8Wnz2mWBzAGqCzGLYur60cpExw2fiP5QCqEvwZD7z9Qd5xz8XB
	eN79PEIoTUyvWAj3oVgrlCfKggcasY0At2hxFiCZSkLNgMdg=
X-Google-Smtp-Source: AGHT+IH6zMRnskyEZE33ZiL3c38eS7NFBPeRZlf8prmvM+d41FKQ2hbJMSl1mRuTfLjCWbVh8q+U5g==
X-Received: by 2002:a05:6000:2287:b0:3cd:edee:c7f8 with SMTP id ffacd0b85a97d-3d1dfcfbc70mr16146016f8f.29.1757063615202;
        Fri, 05 Sep 2025 02:13:35 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e4e2c3fe44sm167477f8f.0.2025.09.05.02.13.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 02:13:34 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>
Subject: [PATCH 3/3] workqueue: WQ_PERCPU added to alloc_workqueue users
Date: Fri,  5 Sep 2025 11:13:25 +0200
Message-ID: <20250905091325.112168-4-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250905091325.112168-1-marco.crivellari@suse.com>
References: <20250905091325.112168-1-marco.crivellari@suse.com>
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

This default is suboptimal: most workloads benefit from unbound queues,
allowing the scheduler to place worker threads where they’re needed and
reducing noise when CPUs are isolated.

This patch adds a new WQ_PERCPU flag to explicitly request the use of
the per-CPU behavior. Both flags coexist for one release cycle to allow
callers to transition their calls.

Once migration is complete, WQ_UNBOUND can be removed and unbound will
become the implicit default.

With the introduction of the WQ_PERCPU flag (equivalent to !WQ_UNBOUND),
any alloc_workqueue() caller that doesn’t explicitly specify WQ_UNBOUND
must now use WQ_PERCPU.

All existing users have been updated accordingly.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 include/linux/workqueue.h |  4 ++--
 kernel/workqueue.c        | 19 ++++++++++---------
 2 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index 542529d3b41b..4db59f886656 100644
--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -409,7 +409,7 @@ enum wq_flags {
 	__WQ_LEGACY		= 1 << 18, /* internal: create*_workqueue() */
 
 	/* BH wq only allows the following flags */
-	__WQ_BH_ALLOWS		= WQ_BH | WQ_HIGHPRI,
+	__WQ_BH_ALLOWS		= WQ_BH | WQ_HIGHPRI | WQ_PERCPU,
 };
 
 enum wq_consts {
@@ -568,7 +568,7 @@ alloc_workqueue_lockdep_map(const char *fmt, unsigned int flags, int max_active,
 	alloc_workqueue(fmt, WQ_UNBOUND | __WQ_ORDERED | (flags), 1, ##args)
 
 #define create_workqueue(name)						\
-	alloc_workqueue("%s", __WQ_LEGACY | WQ_MEM_RECLAIM, 1, (name))
+	alloc_workqueue("%s", __WQ_LEGACY | WQ_MEM_RECLAIM | WQ_PERCPU, 1, (name))
 #define create_freezable_workqueue(name)				\
 	alloc_workqueue("%s", __WQ_LEGACY | WQ_FREEZABLE | WQ_UNBOUND |	\
 			WQ_MEM_RECLAIM, 1, (name))
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 89839eebb359..d33ca6acc5a5 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -7819,22 +7819,23 @@ void __init workqueue_init_early(void)
 		ordered_wq_attrs[i] = attrs;
 	}
 
-	system_wq = alloc_workqueue("events", 0, 0);
-	system_percpu_wq = alloc_workqueue("events", 0, 0);
-	system_highpri_wq = alloc_workqueue("events_highpri", WQ_HIGHPRI, 0);
-	system_long_wq = alloc_workqueue("events_long", 0, 0);
+	system_wq = alloc_workqueue("events", WQ_PERCPU, 0);
+	system_percpu_wq = alloc_workqueue("events", WQ_PERCPU, 0);
+	system_highpri_wq = alloc_workqueue("events_highpri",
+					    WQ_HIGHPRI | WQ_PERCPU, 0);
+	system_long_wq = alloc_workqueue("events_long", WQ_PERCPU, 0);
 	system_unbound_wq = alloc_workqueue("events_unbound", WQ_UNBOUND, WQ_MAX_ACTIVE);
 	system_dfl_wq = alloc_workqueue("events_unbound", WQ_UNBOUND, WQ_MAX_ACTIVE);
 	system_freezable_wq = alloc_workqueue("events_freezable",
-					      WQ_FREEZABLE, 0);
+					      WQ_FREEZABLE | WQ_PERCPU, 0);
 	system_power_efficient_wq = alloc_workqueue("events_power_efficient",
 					      WQ_POWER_EFFICIENT, 0);
 	system_freezable_power_efficient_wq = alloc_workqueue("events_freezable_pwr_efficient",
-					      WQ_FREEZABLE | WQ_POWER_EFFICIENT,
-					      0);
-	system_bh_wq = alloc_workqueue("events_bh", WQ_BH, 0);
+					      WQ_FREEZABLE | WQ_POWER_EFFICIENT, 0);
+	system_bh_wq = alloc_workqueue("events_bh", WQ_BH | WQ_PERCPU, 0);
 	system_bh_highpri_wq = alloc_workqueue("events_bh_highpri",
-					       WQ_BH | WQ_HIGHPRI, 0);
+					WQ_BH | WQ_HIGHPRI | WQ_PERCPU, 0);
+
 	BUG_ON(!system_wq || !system_percpu_wq || !system_highpri_wq || !system_long_wq ||
 	       !system_unbound_wq || !system_dfl_wq || !system_freezable_wq ||
 	       !system_power_efficient_wq ||
-- 
2.51.0


