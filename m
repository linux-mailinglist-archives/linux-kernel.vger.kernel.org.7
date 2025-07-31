Return-Path: <linux-kernel+bounces-751976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B19CB16FF6
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 12:58:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 542463B9EAE
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 10:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F82B2D0C7E;
	Thu, 31 Jul 2025 10:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fJb44Ojf"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE53A2C3244
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 10:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753959361; cv=none; b=OFCnc88CkPMg6Jdam8C7FDAlXeLXbd5+MFMXmDZTfLSeWbZoROQ4tY396gTX1o8GMrmKIZiwBbvvOwUNE8t6Wl/oZSMex/pEje8l8fGbEaonToCGBG2A6MPUI40/9DyIrDZiii0/+SIDyCuVbqvdnQF1tpI5esLTuQCvlU+bviY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753959361; c=relaxed/simple;
	bh=0lGiSVg9B9/1r1Abqba1GBms0sXGUPhMMmufol61dqs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DsEBD30ArVqUIXhdelKh2v9wcVzCIOLaSbRTOeq+bRavCs8h9mG1eSdWgNMRkOQnrI859yqb8GeW5jhzpZ9rB/YA5JrlNRb07Qp2Wu60jPbYHgWG83mqDuka+5bZfGTgLlIPbskEg8eJoXKMnOeSH8+5/JR1rnOzwez6LqcKhNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fJb44Ojf; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3b7862bd22bso1131392f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 03:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753959358; x=1754564158; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+O4AnU3EwEKBel9AzlHSCXMa3OEVEdjq3202WmSD4KM=;
        b=fJb44OjfzrgRDskorwkcOtmCUkoavP9WrBQLCJ1hdy/RvvoBPQzRNZvj2UlWpSK5a3
         hs39gwnpz8HgKck8a7cpOLqku1wZ6DNSL5LDZJ+nMya7iUkfBTOeRYNUb8d5u3rXJl+O
         e7UQkngl+911RRZZqnKW8CRo/CMW5iSJ1B4RzbHPB63hHTUAkgxct8r5IJq/yP8y5UjT
         d/BkDy9BExy7AZ77KBSDEvf3Km0jc37BwUR34KlsAnqDPPmrswvGh1GIeVijurrq69xJ
         j7y0AJYLyroegsXr6YAePmi3TU4vdPXUf2UHCgklmwDd2ouEYi2rTdP6fwC8FJACNNQR
         65rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753959358; x=1754564158;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+O4AnU3EwEKBel9AzlHSCXMa3OEVEdjq3202WmSD4KM=;
        b=O6tz5XhzsMoBgeL2m/fFViGVLt4jbcrz2LqIEfLXyazC+NOzopFUEKgZfurOK4296h
         i14inEF6CLih+ckeTU8+/Dg78lWCVLQkOsXxa5MJ3bh4Quwgy0MhS2EFJfPazc1ZZxes
         olAlBHvMFQr1ptZZcC4BXKr0dlcPJOeanYUWxkHaBnam8T1OXPN7n9GyL1rLl4A5Dgof
         rn3Iwv8dlNd18DH38oyTz4vDYT92jjJ9Ljl5dqIyUx2TnuM6rUO0zNwBmWWUQeZLZq/e
         UPTSYDhemCW113WrnAizQN9MFyCYbZxy3famALB3qeACeXQ4rGU/Uw+VpsJWq96Sd+uI
         SDig==
X-Gm-Message-State: AOJu0YwoSWTKencLzJFrlvHub2+UYlYirXuTvzudMwtcSHxuAOLfjGXv
	U0vtQIoQE63sWc+aUoPmSiGQ2iZ2eFIESRGiCJCgPiz1pwVdAmvwYjOt
X-Gm-Gg: ASbGncuts7qomMCJvkfBSYZUnXwJtLpgQTyBDLEY5+r+X5R8Db6S19sqSbFdc9bT9ay
	Ms5VWVaUK3sLimrSN/OBqh6JodcnLPW0uB4Lsnij5O0TD9pE/zKESZ5HMUgsOk9IhBR+Me/j+LV
	leZEfIUJElQ+/m62XW85HYTWepC+IIftf5pJCBxWglcpiEdARro9F9ik2wvqtPuy/LbejUt9psu
	dOG1pYk32z6Q7ApJi1otirOoWmr3mjJLZpyCvHjxCVqT1MLdEAoLvR+B0Z+wR3qYbtvdKcRTM24
	t+TOif8AVo8SyGg6M5tEEPlWrwo4ZxOG6hFTtYTVFUeuAnMg3juEcvqDEiXxf2HwQz6VWYPLyoy
	4u32eBtMyZVRvfsyDSaAzIduoOKraCg==
X-Google-Smtp-Source: AGHT+IHGpDsILQ6xEj635dFaDMpEp64oVlwH46UxdQYX+4iZc6IiBwfa+yAB3WHwwGeExUJSaY2iYQ==
X-Received: by 2002:adf:a418:0:b0:3b7:91a3:bc9d with SMTP id ffacd0b85a97d-3b79d4e5954mr1169644f8f.23.1753959357955;
        Thu, 31 Jul 2025 03:55:57 -0700 (PDT)
Received: from victus-lab ([193.205.81.5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c4696c8sm1946025f8f.55.2025.07.31.03.55.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 03:55:57 -0700 (PDT)
From: Yuri Andriaccio <yurand2000@gmail.com>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	Luca Abeni <luca.abeni@santannapisa.it>,
	Yuri Andriaccio <yuri.andriaccio@santannapisa.it>
Subject: [RFC PATCH v2 17/25] sched/rt: Remove support for cgroups-v1
Date: Thu, 31 Jul 2025 12:55:35 +0200
Message-ID: <20250731105543.40832-18-yurand2000@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250731105543.40832-1-yurand2000@gmail.com>
References: <20250731105543.40832-1-yurand2000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Disable control files for cgroups-v1, and allow only cgroups-v2. This should
simplify maintaining the code, also because cgroups-v1 are deprecated.

Signed-off-by: Yuri Andriaccio <yurand2000@gmail.com>
---
 kernel/sched/core.c | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 465f44d7235..85950e10bb1 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -10039,20 +10039,6 @@ static struct cftype cpu_legacy_files[] = {
 };
 
 #ifdef CONFIG_RT_GROUP_SCHED
-static struct cftype rt_group_files[] = {
-	{
-		.name = "rt_runtime_us",
-		.read_s64 = cpu_rt_runtime_read,
-		.write_s64 = cpu_rt_runtime_write,
-	},
-	{
-		.name = "rt_period_us",
-		.read_u64 = cpu_rt_period_read_uint,
-		.write_u64 = cpu_rt_period_write_uint,
-	},
-	{ }	/* Terminate */
-};
-
 # ifdef CONFIG_RT_GROUP_SCHED_DEFAULT_DISABLED
 DEFINE_STATIC_KEY_FALSE(rt_group_sched);
 # else
@@ -10078,10 +10064,6 @@ __setup("rt_group_sched=", setup_rt_group_sched);
 
 static int __init cpu_rt_group_init(void)
 {
-	if (!rt_group_sched_enabled())
-		return 0;
-
-	WARN_ON(cgroup_add_legacy_cftypes(&cpu_cgrp_subsys, rt_group_files));
 	return 0;
 }
 subsys_initcall(cpu_rt_group_init);
-- 
2.50.1


