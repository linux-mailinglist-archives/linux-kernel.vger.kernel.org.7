Return-Path: <linux-kernel+bounces-841226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F22CBBB68E7
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 13:46:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F08614E619E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 11:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C47523D288;
	Fri,  3 Oct 2025 11:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SiOAqlmt"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E838C2848AF
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 11:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759491984; cv=none; b=UYYEjrXHkNaRNKKCtOzQqEC0AYbSuTnIXoqWLS6aOw6oxsvOrnDRGHC9uyclRvxQttZdbYlMuFeh2YI3SeLYykQrtHG0R9J14VUnDdPg8Ydz4cM+OpKitTwIMQ2JOlgJcfmm9nF50d8C0nHkEDGVxDUnrI1pfuiTDDWgQJT6rtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759491984; c=relaxed/simple;
	bh=PqpCO1hZ5AzWg8lpqzlwYEmvVQBm7UKwvlNkj9beh4k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iC9j+xvkgRlk9QVk9eUd8/9npUjf+NEWUQvWOJVNVsY47rvR4w4qHB+BnWCnwsgE+hamIL9niLNN9JpVx9EFn3IiKFntTdLly9ToMbEkg54nG3DumTct00Ji9EOaYSsIJngMQWSGsErWILzvOwe0ajJCHTgBAfm9k5mS79Lu29g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SiOAqlmt; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3369dcfef12so2655070a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 04:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759491982; x=1760096782; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kr5m4Q2MhDO3zmxeDrZVa1hCLYfkmOsaOLffDymj6ak=;
        b=SiOAqlmt27ePeqSJ7T9RG26dcd3D+41sWqvR9rcByKf0jjvhuH/XHHU4HuF8JWaY1x
         R5zg3ZnEYeCn5NurdA5kkVKb9gHaeGpiwsQpnBdik5S1PhjSxI6nwJYLydfGX3So3Anv
         2nA5M/b9c8IcQgGhTSXy74xJNTbBOS8a+fhpeeWae5FV4cX3bqyD4NDOQXUP1TB7DsPt
         P6HbDPmYr34hVmbWazIOpeshhMnpR8QaH9yL3JRv/tzRsbd5HmgtQzrsVDkoMeX7Za0t
         eglA/n3RekNe4qgACJ9ZBAKTqfBhjvpI6/aV1lf9AtlRPoCiUYEvB8MG4kn1ODUA5doa
         +8Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759491982; x=1760096782;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kr5m4Q2MhDO3zmxeDrZVa1hCLYfkmOsaOLffDymj6ak=;
        b=e1So+lLX30JJQoh5wG9BGnoo7SpHYDI+wFt6dEV1n59HUW3ZeyjqxVp0IhMFwMSVM0
         tQXH5S58eFXmmgUw6YLlhQxQzl/rdud/C/tDUs+bLgJNBLP+Ta/hZc8yQWAHpPeTLa96
         +PQbN3G1j0KUg7mA2oNGFi5CmF5LGyxRy9TOB/OfBflWR/HXT4ALyaoVe1IEbeZPK/e/
         y7mvy6/ob/71e976AwHoQNg6OfQ385AnwkxLBDe6Q9zn77vnW8TbrXcanpv6Qsoxa9S9
         iRvTGtut8WD/D+fypW35i73hrkXzzrciatkgOwkUIjVOesbMpEwP+4WJv/6SmQTeeKmd
         xujg==
X-Forwarded-Encrypted: i=1; AJvYcCXyOS0kRD5vAGPpKI23l9dIWXwlqV5wAk9KypQDrCYNGgI3522OsEMPd+Fhr/GP5IJuu3vB1GZ0CwC5V6I=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywkac9MdMQT9wMeRdLU/KYcvXWVwmjMhnMGd1jGNcUvPPb0er88
	I28f360Cc61xznXQy0o0slJTyzWAFkaL1yLNyNrXaFBvhYP8FumD/JAi
X-Gm-Gg: ASbGnctkny87ixClWY7Oc8xZULXJJdUCKhmJduq6tCCdBk7QI60AbX9rEopXw0x6Coo
	bcMImZczWcLi8Y9Lk2Y6ivLk5OMwrG0/TtYJsdI3jcqtLCIJuY4umdsYnV4GIyULVYtAIfiz7lM
	sXRKQWl6c2teqo0EAxBR8MafN8CSyqLOo0klZhks/tfzgdhD1xgapHjaBUUq9uRzK9jvGqvev6N
	HAwXtROgpLcxq5gT3AY4clmb2Vkxbc+Tw68YC+9tD8uAPoouH7mdRQHjlJ5V8z+fKyBEdmV6nQP
	3SHtiJgYUf71fa3JlA+X2lMpIO4NmF9Kw3eyh/qbfXVQ8cZeuGGTPQlUOAnGj8GuZ8QJ0SbtXZ9
	blNH7oz2k+JgjpLvnb/Kh2nk1NfYCPami68hf5VNPcw==
X-Google-Smtp-Source: AGHT+IE+B+A6PY10FHNa/K7kwAlpZK7Yj3hJ8GaSS7FT2H3r5Hjjq9oeSORJAi5t9tZGsLPWJ2J+ng==
X-Received: by 2002:a17:90b:4a50:b0:32e:38b0:15f4 with SMTP id 98e67ed59e1d1-339c2724834mr2844413a91.7.1759491982024;
        Fri, 03 Oct 2025 04:46:22 -0700 (PDT)
Received: from fedora ([119.161.98.68])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-339a701c457sm7825727a91.23.2025.10.03.04.46.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 04:46:20 -0700 (PDT)
From: Nirbhay Sharma <nirbhay.lkd@gmail.com>
To: Tejun Heo <tj@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Tiffany Yang <ynaffit@google.com>,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	syzbot+27a2519eb4dad86d0156@syzkaller.appspotmail.com,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	linux-kernel-mentees@lists.linuxfoundation.org,
	Nirbhay Sharma <nirbhay.lkd@gmail.com>
Subject: [PATCH] cgroup: Fix seqcount lockdep assertion in cgroup freezer
Date: Fri,  3 Oct 2025 17:15:55 +0530
Message-ID: <20251003114555.413804-1-nirbhay.lkd@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The commit afa3701c0e45 ("cgroup: cgroup.stat.local time accounting")
introduced a seqcount to track freeze timing but initialized it as a
plain seqcount_t using seqcount_init().

However, the write-side critical section in cgroup_do_freeze() holds
the css_set_lock spinlock while calling write_seqcount_begin(). On
PREEMPT_RT kernels, spinlocks do not disable preemption, causing the
lockdep assertion for a plain seqcount_t, which checks for preemption
being disabled, to fail.

This triggers the following warning:
  WARNING: CPU: 0 PID: 9692 at include/linux/seqlock.h:221

Fix this by changing the type to seqcount_spinlock_t and initializing
it with seqcount_spinlock_init() to associate css_set_lock with the
seqcount. This allows lockdep to correctly validate that the spinlock
is held during write operations, resolving the assertion failure on all
kernel configurations.

Reported-by: syzbot+27a2519eb4dad86d0156@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=27a2519eb4dad86d0156
Fixes: afa3701c0e45 ("cgroup: cgroup.stat.local time accounting")
Signed-off-by: Nirbhay Sharma <nirbhay.lkd@gmail.com>
---
 include/linux/cgroup-defs.h | 2 +-
 kernel/cgroup/cgroup.c      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index 539c64eeef38..933c4487a846 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -435,7 +435,7 @@ struct cgroup_freezer_state {
 	int nr_frozen_tasks;
 
 	/* Freeze time data consistency protection */
-	seqcount_t freeze_seq;
+	seqcount_spinlock_t freeze_seq;
 
 	/*
 	 * Most recent time the cgroup was requested to freeze.
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index ab096b884bbc..fe175326b155 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -5789,7 +5789,7 @@ static struct cgroup *cgroup_create(struct cgroup *parent, const char *name,
 	 * if the parent has to be frozen, the child has too.
 	 */
 	cgrp->freezer.e_freeze = parent->freezer.e_freeze;
-	seqcount_init(&cgrp->freezer.freeze_seq);
+	seqcount_spinlock_init(&cgrp->freezer.freeze_seq, &css_set_lock);
 	if (cgrp->freezer.e_freeze) {
 		/*
 		 * Set the CGRP_FREEZE flag, so when a process will be
-- 
2.51.0


