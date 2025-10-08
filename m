Return-Path: <linux-kernel+bounces-844967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 008BFBC32A0
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 04:24:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACEA9189E875
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 02:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2025E29B78F;
	Wed,  8 Oct 2025 02:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZS8Na8OU"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179B4299AA3
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 02:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759890238; cv=none; b=e6wpYbPkFbYIH/CoenZzDSXjyhYxJCSiWArTDwGxLFCqZmOOCR0c+ZR0pblXYk9xZvRxj7W+3RFExUUdFu6Q54eRtXf9xGIiNVcO7dtBKzbfD7R431xXL43dJaSslOeJKBmG3F3UhH6kfjuUtwl72A+Wn/rL2yxs13YwbK/nprI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759890238; c=relaxed/simple;
	bh=i2EHr2yFOvzEk2nw9aqlx1F3BnQnl5hUTpMRYd4KJeU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M8LMPmtMp554GTQPucDGy6dYUdHMc82BAqhLAo6kiE5cjbd84GhXfhvb//xww4n9Y/108tTWWXIlFSf4mP2J4qSOr1XZZTeohMbg0cHy+NStXfTndTYBoGEah/GkCf0RL/5Wu0is0isLrWmgbE5SPKEuHZBVMKY4NRpEEHnmqDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZS8Na8OU; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b6271ea3a6fso4163189a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 19:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759890236; x=1760495036; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hdXIcG8jCEHWHqBSd8qVzKFmP2x2AR7ZX05huB9bKT4=;
        b=ZS8Na8OUL/DRt6Fq3Y7nPwE43wkWXMQ9AJBZmTyqWaJeWld2icsyNsq7PY0gH4SkhZ
         I5nVDrB1yUIAlLHrsnUrtn+peykoihlzOktAoLsxz4PuEJFQT5J61mHXjxaizKb8qFFQ
         A5uIIvL8K2gEo2MK6JJLsu7CDmA00B/OsLMRQqM4ewyZ1/yIdPy9hlHFbXRqgYizDttk
         zhpVHdZj2SNo6uDtQUofWAfnNBVfJkmDANQMWuvIiEy6pf0FI52H0wm+7ZFz9cpnCdJ0
         2wqWaY74ElBtWBYdmynwdeyZ4txUsJCd7TdNE4Jp1u0P0HCBxV5jVOK/f1koEA7ssUrj
         F/WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759890236; x=1760495036;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hdXIcG8jCEHWHqBSd8qVzKFmP2x2AR7ZX05huB9bKT4=;
        b=r/6VC1DL6m6b0LfdO+EWySCF7zRTEMDHSWMywb5c9oR5tj0TePLp6YEEa/qfuuTAVX
         T2FI/W0o1l5w4+6nOv7DMbawl/HCUV7APlD5cBZY0fufGrWIozHWGNjUbiQtcYKhWoQj
         PR31TLk/6RqqOWm2E7q07yeRdO9z2gADg/mo6CPn0WoGBQxuV+sPxhAfYynqt/EGqLeX
         Jaci+LpcEOr4sTGiQGh9jEA6WwtMRsMkOZqkTexMSuRkivl9xH4l133JU7j9NqxwPN9k
         SS9s8X/Nl7pbhqldohwl2JXfLarvOyBTu6iTdBdFOv08pwGHVV3uov5ZemCP0oN5kLEQ
         saFw==
X-Gm-Message-State: AOJu0YyN75OuxvjiI9cGm9CDki1EjFX5sZeoDKgkK9DmRQI5WdUhgikI
	HNRQDuDshyaNTTM8UKH9lxExitnjmSThsXxML02ioC6Ga4Zp6emn0i/i
X-Gm-Gg: ASbGncvnPJxD5q1Mx2DnfqV6j61IAVSQNBuSRp3XSSx1F/jTPg/0zGI83q/+wQ8s+K/
	3nID101Z0Odr7iNzn72HDjPly+Swjnco3/+lztd9IHXg7bHFkKJhql8eU5vo/e1h0RauTZ1sXM4
	aMkLGaIq9M0ZHPq2V4vEHyOCL0TVGnXMWA+KG+krq7+RnYXOlsqgXnpqLcWLTB4aSQ9oKPz7rrg
	7vxkkuDHemfHpzdYiYEpCMGm6Iqj1fdiNs2YRe/rPFPfKtKL+6ixvH5rV4IqXdbeCnx6ojgUBNj
	bdoz7RUOiqOHxILr222W+7dm078OzNWYP4+eGMlfy//wxQAM18kAGVDsvmH9o6jIQKRRmTEi8uf
	dCa47HYLBgC0sDr34rqswv/d3NDckq5q029KAVRQ98mU6uFe8cLqC5EVo3T/pX/f2GuPd6x5Qd8
	sV/ihprnz2ue6eSE06cZdoywA=
X-Google-Smtp-Source: AGHT+IGFWpY82eROlGt/IX7UOf7kCtUyDekAQ9UvFn07q2QCNfzpqPv8WqFvhg+p+89h9GgqQyjyDA==
X-Received: by 2002:a17:903:1aeb:b0:26d:72f8:8d0a with SMTP id d9443c01a7336-2902721672amr23802405ad.12.1759890236279;
        Tue, 07 Oct 2025 19:23:56 -0700 (PDT)
Received: from mi-HP-ProDesk-680-G6-PCI-Microtower-PC.mioffice.cn ([43.224.245.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d1b87e7sm181731605ad.82.2025.10.07.19.23.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 19:23:55 -0700 (PDT)
From: zhidao su <soolaugust@gmail.com>
To: suzhidao@xiaomi.com
Cc: linux-kernel@vger.kernel.org,
	zhidao su <soolaugust@gmail.com>
Subject: [PATCH] sched/ext: Add tg->scx.idle which tracks the current state
Date: Wed,  8 Oct 2025 10:22:31 +0800
Message-ID: <20251008022313.632514-2-soolaugust@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <aOVmuWwyLUNkPG7S@slm.duckdns.org>
References: <aOVmuWwyLUNkPG7S@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add an idle field to the scx_task_group structure to track the current
idle state of a task group. This field is initialized to false in
scx_tg_init() and updated in scx_group_set_idle() when the idle state
changes.

This allows BPF schedulers to check the current idle state of a task
group directly from the scx_task_group structure.

v2: Add tg->scx.idle which tracks the current state
Signed-off-by: zhidao su <soolaugust@gmail.com>
---
 include/linux/sched/ext.h | 1 +
 kernel/sched/ext.c        | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
index 7047101dbf58..b65e9abafcb6 100644
--- a/include/linux/sched/ext.h
+++ b/include/linux/sched/ext.h
@@ -224,6 +224,7 @@ struct scx_task_group {
 	u64			bw_period_us;
 	u64			bw_quota_us;
 	u64			bw_burst_us;
+	bool			idle;
 #endif
 };
 
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 72bf2ad382fb..a2bbcc34e5d5 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -4103,6 +4103,7 @@ void scx_tg_init(struct task_group *tg)
 	tg->scx.weight = CGROUP_WEIGHT_DFL;
 	tg->scx.bw_period_us = default_bw_period_us();
 	tg->scx.bw_quota_us = RUNTIME_INF;
+	tg->scx.idle = false;
 }
 
 int scx_tg_online(struct task_group *tg)
@@ -4273,6 +4274,9 @@ void scx_group_set_idle(struct task_group *tg, bool idle)
 
 	percpu_down_read(&scx_cgroup_rwsem);
 
+	/* Update the task group's idle state */
+	tg->scx.idle = idle;
+
 	if (scx_cgroup_enabled && SCX_HAS_OP(sch, cgroup_set_idle))
 		SCX_CALL_OP(sch, SCX_KF_UNLOCKED, cgroup_set_idle, NULL,
 			    tg_cgrp(tg), idle);
-- 
2.43.0


