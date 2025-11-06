Return-Path: <linux-kernel+bounces-888899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8514C3C3D6
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 17:04:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12F233B610B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 15:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D8B9347FC7;
	Thu,  6 Nov 2025 15:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TVDREkOD"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855D7217F2E
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 15:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762444725; cv=none; b=J01Vr0xBSXKB1Hv1ten1IbHl8QnbwP4ae0Oij12whAHLcvo2XPki2P+qXTGb/xBWKNTpOEv2WMzZhtGP9K9whhtSfnVSnmW4HLM0VfErwpREZ5hrBsiUwGcd/4BEjjBCNhukqOCW7cCugE6qwkw4imG+cMTMRwUZ56RCnlYXNAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762444725; c=relaxed/simple;
	bh=hQvedwNnbNGqs2P7mPVC6w/cg/PsfhX8mSlzj6QVXUI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sIv642qZ+4ID34KfnkNzc0PtG5fOvH+eG9vddW35c/m+yYnsYH54zm0ra/wxc4M429YApeho9l2LY5O9RNA7PBAKkxcP0eObMeMjt2YelF5/edW94YLU89D6446ediN4vxMc6+cNUrm0TQs6lKqubWjzs07fZQfuqjbQWBSzTdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=TVDREkOD; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-47755de027eso8848745e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 07:58:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762444721; x=1763049521; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vTKQ/9KgyAcLZI3pm3L05sC2QlXoOYBGo9f5Rvs6qdU=;
        b=TVDREkODhHOpI1aGAXiB34m+SD7HZcFuaLCFvcIzqZWCyXKi8xSPrMoSL8gm3ZC67k
         J0yPrE6QTU+WlQMr35YAC8TI7fTAhds/K1ziGsvI4g/t24hQ+A1mW3nW0jhyA7PHxcA+
         7fvkZQ9H7YhO5uJMp9nTxemCcxsewjlPH0/xlm//QLrg+zxCKs3IUMeQrjnHOTlHInRz
         IcQA9uzMPnz0in4xceu/hKViXULJNUHGLgdPcUWNcZO98/fUSCNg3VtS4yuFE3+MkX14
         6T61h4NuTSQTSY+USwpCT+BucBdcGOndGkPrrNYTE7Y5mHSZ4e2GZTQHTBFO/2xx00Hj
         5EHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762444721; x=1763049521;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vTKQ/9KgyAcLZI3pm3L05sC2QlXoOYBGo9f5Rvs6qdU=;
        b=toP9sKHVNQxxscCZ/6qwFikD7CtQtXQl08oOUYP/YqgbNvp282QZVLJw8UsQywfY5l
         H2S5KLZEIFOklKh402L3/BI2oyW+L6iZ4sVgAq1TJo+h0YEKq3GTiYL1KPzARr/rzw2U
         Dyucks28A6DF5gS0YuZNUkBYX3+K17v5IIswiTGXh8UicI/7dnmN1gXLODlKRjXcdtMW
         VOdvve98eCOJfDlCyrFagNHFn9hQ8XbodCypm49zjzcABLEfC4OS0GXV99YCvJhISlrx
         d1iH9mWNT7bIsf5HV62dFCzus3uVUwKw1sbkph8ZpYlxdAT8hhN4iFjv4Gd9X/UYs8aN
         yDdw==
X-Gm-Message-State: AOJu0YyjkJZ4XMD78yhBt5aljNW3l6l6PT+Zs4PIhYTjWyE3dOu4m35V
	laJn/yR4SdCOKfmMTxFM2qRmUHiLq6wmcrTrGZzKIV4hFlLjFhzQzDufr3MB4wH843sckX/JEg1
	k0447
X-Gm-Gg: ASbGnctGXwJP82Jy3HxIIvFyYPytBw/YUYubWkQDuRN/Yj9+HhT+4ppb3m9kW/MCJ3u
	x2H6f238V2FnQZJ+P3C412iYSpPJWanK21mzGh36KwXTmvTsme5ulMvPDfNGxIsMDL7ivJxg833
	MR879901B9nKIx/gO2I/SKwg8GlJMxeu5ZA8KxbHcqLsy+vw2kHm41jlPpQww2b7WnJ8xv1VNxN
	n45jxfDjflRFSXJ3rtd0wCv84foJy2VtPqhruLJjCesz6UY8WRyTd3DwYrvNle7deLpoeuMmj48
	3/8MSuzsYi/cx2dMngm9AaPC+4+bgVz5KqntsJfogTlQC2D3VOVXaUaGva+QuY0i7HhG2v7EcoB
	7OUOye3T3MKL83kKOVf2kOI2bCwbLxoZSoyI6w7JMWaA2M0wW0/3vCkXqLB+k+btKGHDCURzaXt
	cWir3kJilGkla2r1b3kjMICFQ=
X-Google-Smtp-Source: AGHT+IFMnkLTlhStdnpadBpL2HuGw+mkAPiYvwVjt6jcTNz2UFYHeUrdQTK+BluDsXkk7abaXQWnhg==
X-Received: by 2002:a05:6000:420c:b0:429:cc5f:68a7 with SMTP id ffacd0b85a97d-429e330b919mr7123146f8f.44.1762444721404;
        Thu, 06 Nov 2025 07:58:41 -0800 (PST)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429eb403793sm5758966f8f.2.2025.11.06.07.58.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 07:58:40 -0800 (PST)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	xen-devel@lists.xenproject.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Subject: [PATCH 1/2] xen/events: replace use of system_wq with system_percpu_wq
Date: Thu,  6 Nov 2025 16:58:30 +0100
Message-ID: <20251106155831.306248-2-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251106155831.306248-1-marco.crivellari@suse.com>
References: <20251106155831.306248-1-marco.crivellari@suse.com>
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

Switch to using system_percpu_wq because system_wq is going away as part of
a workqueue restructuring.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 drivers/xen/events/events_base.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/xen/events/events_base.c b/drivers/xen/events/events_base.c
index 9478fae014e5..663df17776fd 100644
--- a/drivers/xen/events/events_base.c
+++ b/drivers/xen/events/events_base.c
@@ -581,7 +581,7 @@ static void lateeoi_list_add(struct irq_info *info)
 					eoi_list);
 	if (!elem || info->eoi_time < elem->eoi_time) {
 		list_add(&info->eoi_list, &eoi->eoi_list);
-		mod_delayed_work_on(info->eoi_cpu, system_wq,
+		mod_delayed_work_on(info->eoi_cpu, system_percpu_wq,
 				    &eoi->delayed, delay);
 	} else {
 		list_for_each_entry_reverse(elem, &eoi->eoi_list, eoi_list) {
@@ -666,7 +666,7 @@ static void xen_irq_lateeoi_worker(struct work_struct *work)
 			break;
 
 		if (now < info->eoi_time) {
-			mod_delayed_work_on(info->eoi_cpu, system_wq,
+			mod_delayed_work_on(info->eoi_cpu, system_percpu_wq,
 					    &eoi->delayed,
 					    info->eoi_time - now);
 			break;
@@ -782,7 +782,7 @@ static void xen_free_irq(struct irq_info *info)
 
 	WARN_ON(info->refcnt > 0);
 
-	queue_rcu_work(system_wq, &info->rwork);
+	queue_rcu_work(system_percpu_wq, &info->rwork);
 }
 
 /* Not called for lateeoi events. */
-- 
2.51.1


