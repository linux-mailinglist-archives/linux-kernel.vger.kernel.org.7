Return-Path: <linux-kernel+bounces-899793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D58AC591FD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 18:25:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8062350659A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 16:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47B413624D3;
	Thu, 13 Nov 2025 16:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="C2PWx2sN"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE1B35A15E
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 16:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763050846; cv=none; b=LQ1DkKJgH3Tk9rmYAoL4cQ/6FtIsj1UcCMsiAXCu7l6LEy2rDb9Tov8Mad4JCWn0Vav2ca5KxRBMm/IjzvbejS+szQm6xAA8IFmCydugVRWqVHcXHdP0MmZNQsBa9tr0C2K3BNMK1cklZTMFZ7+XSsa9vmrRZCTDJ1r8wsHHgR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763050846; c=relaxed/simple;
	bh=1K1JLKSX7hTeWYysvdPECNmlkXUUFyTi2U94FWDnNIw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OdwfiG/svV//5BkOBME10VrfQZD4Jo+PhJv8rJxREG9RtQbgBEyjB0FHMQvY8s/8sWosYMvHIRqHJ3q3m1Z+jxzvKHTL94c+4CSumFIw3xUug/1e48/B/fajU+nmk4oIOM/z72Wvyq9hB5w87rH/O8TS1PEhPFYBiv6U/7ylWPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=C2PWx2sN; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-47775fb6c56so11772595e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 08:20:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1763050842; x=1763655642; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3sUAiK7iqBMOBnmlfbuwKDHVMLnBI93R+oE5+mQBb3o=;
        b=C2PWx2sNZ8jI2ZpIXeP4DOvKgMqHp7AmYSQjHqZf+jrh3QvuRxqZBiD5TS1rkHyyqR
         vUrNDHCLH2PQHjsM8/Dx88OCuGzyzjKFQ2u9qBwdOsUotsNOOs8EshylOXvQESvN/2G9
         TKOfRQdWyzDlB2ckTVLTBG3AO4pVtJGHm69TaYHjfSf8pNo2U8TOqPT1eRYGCG3ukqFs
         8eUVvvgCzRHepyn01AOQKTa3/4BHOSniQgkgfI0bF4iZs61DozdipSAER+eT+W4E5+/l
         qVsA0+W7FNV8n5WXbY8MR5FqGItnM2w+qVkYAFiWrpGvrwHXTMq2LKYi0kMQKTqakfse
         BWeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763050842; x=1763655642;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3sUAiK7iqBMOBnmlfbuwKDHVMLnBI93R+oE5+mQBb3o=;
        b=GbmWQtT0jOeC8AFE2mvNmWcUc+QlrkRTaf3Bx5RgmtLHufQCgjTO0U0mrb7U+wPQs9
         +zc834Rh17BvTy+HRSh752ECmqKkFuKwW69b7FqfuOwTf6HnK4cpno3ZvUZAYgd5egiw
         T42uWbGmENs/QzvK02zVN9gRK5ZC+otETSUxhXCEPTT3GhQJCThst6fs3WuJRS+tnYup
         6z3VeEpVGfzaoWZNtBd5/6jGIRcnI+OTrtKlrVsn0Js6uDrUKExAtg0t3ZFKesZf+cuI
         jYEQlJ6xxAy7Uzip9Ba56ANTTp601DkG6vvdnkjOzF7TF6akBemnsYRx/up9wkAvs6FN
         0pTw==
X-Gm-Message-State: AOJu0YzQr201Pqkl0tl9ODjVIdq5SJucVYanv2LhrEUqUxNWc8xYcpYi
	0e7Oj9BT0NZ7yQWamaiRTD9V2BQu530FIXjHIyoYcQkkZmLMnNrjaX0ys2A3njNx6VgF/4ls3B2
	qInB5
X-Gm-Gg: ASbGncvodVezfSIbO8Ryt0XMtUvx1QSL0lZXtqCokgtD3UDVNkher6GV+OYPpXcpffb
	ipCMKEvoSyOKcS8YzWEe1j4okWB5QdYnqN/mEUh2VJU6a6/+7GlwVB69d/HlEEwBDh0GE+vNACQ
	gaNP4ik1TqoDpgm/N7VZBdnbSmC8MV9zFE+4ScdY1tIVNXzAliEG8IW53+zVmIHExUppP0UQFdG
	bRi+/h/O6vdKAMXD2oEeDfei4GmQpOCN/AD4S8t2bUdzblY4+cWboJjGXJ9npy+H1grC2qf5Txt
	ld8tG8Flq2VInHAHJcCRn/eOb9GXP9ZxtL2X6RLaQ7ZjXlJmLoOzpJG51O8v7stz3fL7ekrmYbc
	3A8cclV9PwnarM6kkflOWQYP6GOoakj6ai5PVsUxTJOxB8yNiDoXSenuQSnSjhKyzcVbFFx/d7R
	4fVt8HbHK5+IzhYCSv/X3qH6BF
X-Google-Smtp-Source: AGHT+IGFQwzsHPp0td0bX6xyP1y2UaK6itRtAc8vaFN6HWGlbtUtJjpcomwRQKhV1Yi9/zD0/AuekA==
X-Received: by 2002:a05:600c:1c89:b0:477:7bca:8b34 with SMTP id 5b1f17b1804b1-4778fe4f62amr1016465e9.6.1763050842430;
        Thu, 13 Nov 2025 08:20:42 -0800 (PST)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53f203afsm4680578f8f.39.2025.11.13.08.20.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 08:20:42 -0800 (PST)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH 3/3] wifi: replace use of system_unbound_wq with system_dfl_wq
Date: Thu, 13 Nov 2025 17:20:32 +0100
Message-ID: <20251113162032.394804-4-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251113162032.394804-1-marco.crivellari@suse.com>
References: <20251113162032.394804-1-marco.crivellari@suse.com>
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
For more details see the Link tag below.

This continues the effort to refactor workqueue APIs, which began with
the introduction of new workqueues and a new alloc_workqueue flag in:

commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")

Switch to using system_dfl_wq because system_unbound_wq is going away as part of
a workqueue restructuring.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
Link: https://lore.kernel.org/all/20250221112003.1dSuoGyc@linutronix.de/
---
 net/wireless/core.c  | 4 ++--
 net/wireless/sysfs.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/wireless/core.c b/net/wireless/core.c
index 54a34d8d356e..01775d8f4406 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -428,7 +428,7 @@ static void cfg80211_wiphy_work(struct work_struct *work)
 	if (wk) {
 		list_del_init(&wk->entry);
 		if (!list_empty(&rdev->wiphy_work_list))
-			queue_work(system_unbound_wq, work);
+			queue_work(system_dfl_wq, work);
 		spin_unlock_irq(&rdev->wiphy_work_lock);
 
 		trace_wiphy_work_run(&rdev->wiphy, wk);
@@ -1698,7 +1698,7 @@ void wiphy_work_queue(struct wiphy *wiphy, struct wiphy_work *work)
 		list_add_tail(&work->entry, &rdev->wiphy_work_list);
 	spin_unlock_irqrestore(&rdev->wiphy_work_lock, flags);
 
-	queue_work(system_unbound_wq, &rdev->wiphy_work);
+	queue_work(system_dfl_wq, &rdev->wiphy_work);
 }
 EXPORT_SYMBOL_GPL(wiphy_work_queue);
 
diff --git a/net/wireless/sysfs.c b/net/wireless/sysfs.c
index 62f26618f674..8d142856e385 100644
--- a/net/wireless/sysfs.c
+++ b/net/wireless/sysfs.c
@@ -137,7 +137,7 @@ static int wiphy_resume(struct device *dev)
 	if (rdev->wiphy.registered && rdev->ops->resume)
 		ret = rdev_resume(rdev);
 	rdev->suspended = false;
-	queue_work(system_unbound_wq, &rdev->wiphy_work);
+	queue_work(system_dfl_wq, &rdev->wiphy_work);
 	wiphy_unlock(&rdev->wiphy);
 
 	if (ret)
-- 
2.51.1


