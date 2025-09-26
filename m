Return-Path: <linux-kernel+bounces-833758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34458BA2FAE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 10:39:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70D467A6F7E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 08:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D79A5299A85;
	Fri, 26 Sep 2025 08:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="bzIehHGV"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483A52877D2
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 08:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758875939; cv=none; b=E0hmvJqMASUk9yw0I5OkbegLsL9cBqeoY7+4BMNl8oI1MsZ7UnSe2vJSmOP4YL2gdv9MVY9LDCWm1u+cZ/dNQSQ9pVATnbkt0GkGo7wQwTnX9bKQCnASUaWfXgP7utHbEZArVw6SttHew8OGRLJsS+VDB+yWS9eHyhX+Bh9k0Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758875939; c=relaxed/simple;
	bh=0vV/6+DW2cm01keT91jsIqu23jaeYIORdbfiyr4Va/c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JT7APSN6VIeJ2bLXmwNeUrRJew+zRc+sjFMljwhkoNvyUj/bcc3EOcanL9fHLZ09lo5k7Jb1mXM7KAQOJ/NgJI1ysDBofItVdPTXIlf4c/4iAzJjP0ofgHzUrWV5w2niyS6/ZxDU0cHSK4zlDQVjT48vLLk12e9e5UWIGMuvCQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=bzIehHGV; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-46e37d10f3eso10729795e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 01:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1758875935; x=1759480735; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IMLjDEzqq5Jujc77cy2DJvSmyYzyNsCtcN0IOCmmWBk=;
        b=bzIehHGVYTnS/4oBGB6504Effgd0Q9aFf0HBb4eNhRldLuC2nGn3zKwi2wyVhY3bxz
         brt5XTVoVKgb2swSKLhRv0UF/wWs+A/ymssTZUT1tkmTOZj5idRqBXNBUaPDICSoJ5Pk
         EjvGHSU0PzQK55pEumKxsYOtuPOrjCZAVkCr6E2m/hO4D0PepHuJbXc0dxLgHBMbSg51
         7t1V39dPg6XfsL2/Q18Wykia7m6ynbjKjFtQFfcJKSNjUtnv1CXdBZX7nYjn/M94XTS1
         IKzRc+/DCSN5A4mZKI7YVujJNNA3czd0tgsGSZz7LA1UQBu254km+dtnqbUNc94I0yhQ
         hGKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758875935; x=1759480735;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IMLjDEzqq5Jujc77cy2DJvSmyYzyNsCtcN0IOCmmWBk=;
        b=Jks2r0smJdQ0CUH4N+AD4jfBhDuXwGV2YazDWOJsQqb+18QpUEd24QaaFaMHEqRX5o
         6eIzz6mCL08U2P4tEhSEvJmGZjkArVHJXCwdVVYfGHSoGdT2wWJNH5lPl8CJbfVZ3mgW
         pZb85mo0j+jvVnEjOYewV7dXmM7LKhUEHL/U8x/qpMJImJHS8oTrMF3ROWw4gc8EFzkj
         Jr5ODlwlbbPjsWVLQLRxCV6OSSXjT2klsSWe/v7H7LSNcqH03uwn52z1MBz3p+srPL4Z
         8JXshgFlbFo9u3JwyX9UW/wpp6QAnOtk/BXIsvdPsIZEqUZhDrmfNsoWb7YFQXqCx5tN
         RV1g==
X-Gm-Message-State: AOJu0Yz4TNQbqDdo3GfU09bdU66n6L648wRdkLZuure+oPGa1ufl/fHp
	QT4hG3lqW6gGGi/jRsjbRHJ8z2pzkHVpNl7kijVym+CbDLx89HglppvSh1FlgPiXjqzHoMZFcKt
	UUb17zac=
X-Gm-Gg: ASbGncs6EJtrdsSYBr9EV5GEU29Y/+RgzGQzGsvkS0iiawjVUb09ZsVDhYFuup0SpCB
	4yNHjWDM28i7j3qgKo7igJHc+ZvdLfwo98UFIxZBh2fv4yAliMzOGo/mClMdejkCtksZU95Xlwc
	ljiyVp8JQckn59+mzzqpa0jYSDFyghUe3Hp8HRzgDSmWWeyppw4cqC7VNg0LdkMug1a0fPXD3Q9
	8ED9JRMhcTQ7iUt4uW5ItbDSqSUva5HmJNjzGWT2KtQFKZHKzOU8KJI2moVCNzSim1d2JB6gDHi
	dzRoRduk6uhIrKEEbYBNN6k3MuS4bWgsea1MXim9u/g8aQ+kPDWwYXFjQbVwZktSHmcmQDXay0M
	wv1HYCJfVoG9KUwVp4WETXZseDHbxyZ1zwdnPY66qy7ooAvsGds8DZLR8ug==
X-Google-Smtp-Source: AGHT+IFzU7cESuwoaHKhg8/LeRn2b2knH40I8N65Uuh8v9isvS50hDXLZ33MPrWkvtH6PlDOOjts+w==
X-Received: by 2002:a05:600c:1d07:b0:45f:2805:91df with SMTP id 5b1f17b1804b1-46e329eb016mr60669885e9.20.1758875935242;
        Fri, 26 Sep 2025 01:38:55 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e33be363esm65702575e9.15.2025.09.26.01.38.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 01:38:54 -0700 (PDT)
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
Subject: [PATCH 1/2] wifi: replace use of system_unbound_wq with system_dfl_wq
Date: Fri, 26 Sep 2025 10:38:40 +0200
Message-ID: <20250926083841.74621-2-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250926083841.74621-1-marco.crivellari@suse.com>
References: <20250926083841.74621-1-marco.crivellari@suse.com>
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

system_unbound_wq should be the default workqueue so as not to enforce
locality constraints for random work whenever it's not required.

Adding system_dfl_wq to encourage its use when unbound work should be used.

The old system_unbound_wq will be kept for a few release cycles.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 net/wireless/core.c  | 4 ++--
 net/wireless/sysfs.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/wireless/core.c b/net/wireless/core.c
index 797f9f2004a6..93b8e18ca630 100644
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
2.51.0


