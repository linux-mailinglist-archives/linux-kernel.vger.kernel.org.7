Return-Path: <linux-kernel+bounces-875613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EFF82C1978D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 10:49:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B1B225812AD
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 09:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86948326D50;
	Wed, 29 Oct 2025 09:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d78sc2hW"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7A23081CE
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 09:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761730630; cv=none; b=LdXnAVv9xX5VPAnET0UwawgAoWtI+YMQniDlyAJ/xZ4NYGC0xCpeKyCHk1VkoAJVShiQfsremB1i9E1m02gWThTDASseuVhQC09/cfADDMQmQfcCSF2oCTO2+BDOHW2Znayt5Uc4ziq68t3CcDGtpeN+roj+aIPF2shQTnXdBpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761730630; c=relaxed/simple;
	bh=psk7jnRsKkQx5k20Bor89B6OjlQbzy+s55YsOvHQl7A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=G2XClgm5pkLnSLZM5rB3pLnYq3vHLtJv+nqKLXrfXhMMDKkWIuKNR7Lxh7aIAFK4B55Bctpd1gYJ5fMJkZrM+6cOC6xYrDyO6dgtwEVXly6DfwEzhJoWJnUqoGwMDVj2GD/jMY4Iht1TywARukXtBSID2S61nBfxgp6wHajTuFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d78sc2hW; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-77f67ba775aso8663419b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 02:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761730628; x=1762335428; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ztXEJsAKxNCJhVwgCLNQt53y8b04msE+DYNtSFC8L4Q=;
        b=d78sc2hW8KjTXXsd9tlL2OOOIkRXCzHNm9r7dgX92Nmi/0guLa9nPSNneplamzHj8q
         iItjHaxSD80mCUevecSgLbvyEMZv0itFqNIfMT0vSnhgrMTchb1YySlpxXjcwTotSerV
         xldczJWs3J9SVAmtvpCacTeAqxrOwBSwSVs2g87m7MPHFYzo0UB9DcPRt7xWRX0SrmnP
         tksPtoe7RUJcbS1l2czu0BPy/b/Na2s70ctxUDfeBaghqHj3qbAn0LT1gfOkddHZiqtQ
         d78zfLp6kvxgxXT6ea9QgY2+Tkw1pmNaeBKseo4x22OKSqu3z8mRM3btMQReMjv7hpaq
         eE2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761730628; x=1762335428;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ztXEJsAKxNCJhVwgCLNQt53y8b04msE+DYNtSFC8L4Q=;
        b=RWdD/af+DKNUDRmQuieXI21qgxCGFujg1XqTrw+6HkWqjoQRZZnQ4L5Vqwz+ytsQX9
         4t0irW83RSkuqgnkZx4a0j0nQI1ARxB31gbE0ivNn9W1nJTW7mGvtl3OsQdVKwAOyN/4
         KGrdFxdepNF974FBB00SirSkg9TwArEpLrdgnlINuf0e3JZaUo3/XzaTllavzUpSSc4z
         yGhgzdmWKr58NZgqgvCOi4+TsboyeIFhi8VVZKF6te3H4xoMhIV1MbYkRZQS+ikiJ6s8
         q/ngb6SyL3LFslr7A0qkZ5G9tX5erWFZExQox427GBYVmXBUXlx2i2C+Lic7kduUeqlV
         ENSA==
X-Gm-Message-State: AOJu0YxsAq/VdPOMT4MZNTyTK2b2ILU5WUDkmhn1/WhGaErjAnM7+KMX
	DDLXnNitTMntWOQGpi1nG1q8C7oex5+irWxqW2XBQhHjMwl5nvXZ9QEh
X-Gm-Gg: ASbGncsW/p3cOVwY7WJ91eUZLMrcbcdvJN9f3nUgT6J2n4u46P9oy7NKVnS4YZO0697
	eWOP5sxT4PNV2xMyEoYXCCwsOyvFU7O4qT+JGLVb9VMfARTyQCRjACrN6QIYgo487wdNq/a6CY6
	oDOcPJ2Lw8Y1Djp5qWKF/eoTMP+iZ2VlGUNBEOG86Yoi9G2ybuzy6M0UOwkBg68zYiHzU8T5lCN
	OYPaCl8QILlKriE340MIeTs6rhJ+Tl1sDk3kOmRX3+3N1dwtcQT6qaHoFaQv52s8IiwVBNQjMdV
	ayQ5pg696vRzuRb0HX06sYZ11uWIiN59rsImhrUcCJVCTOyExoZUjLDpBqRvapxeDum3vXwEmsQ
	elupv5YKDB11rtsx6eIuiDHuq3c2xHxLZMytLS3OiE0TE4gr5DJCC9pT2QgtKM6V3eum7AHS/GL
	oY7NSdR0qZHyN2MSkV4zTzq6Ct39iAEqbAuEYhlMY=
X-Google-Smtp-Source: AGHT+IG0HoQwdmTRH5Z77DpJuhuL/Qj2/x5TAb7q6aNxspS+6Bfs4W8qH3NvB5h7YBQrvlJbkcaP6g==
X-Received: by 2002:a05:6a00:7608:b0:7a4:f552:b517 with SMTP id d2e1a72fcca58-7a4f552b805mr1926261b3a.23.1761730628415;
        Wed, 29 Oct 2025 02:37:08 -0700 (PDT)
Received: from localhost.localdomain ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a4140699basm14454369b3a.50.2025.10.29.02.37.01
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 29 Oct 2025 02:37:07 -0700 (PDT)
From: Hao Jia <jiahao.kernel@gmail.com>
To: mingo@redhat.com,
	peterz@infradead.org,
	mingo@kernel.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	kprateek.nayak@amd.com
Cc: linux-kernel@vger.kernel.org,
	Hao Jia <jiahao1@lixiang.com>
Subject: [PATCH] sched/core: Remove double update_rq_clock() in __set_cpus_allowed_ptr_locked()
Date: Wed, 29 Oct 2025 17:36:55 +0800
Message-Id: <20251029093655.31252-1-jiahao.kernel@gmail.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hao Jia <jiahao1@lixiang.com>

Since commit d4c64207b88a ("sched: Cleanup the sched_change NOCLOCK usage"),
update_rq_clock() is called in do_set_cpus_allowed() -> sched_change_begin()
to update the rq clock. This results in a duplicate call update_rq_clock()
in __set_cpus_allowed_ptr_locked().

While holding the rq lock and before calling do_set_cpus_allowed(),
there is nothing that depends on an updated rq_clock.

Therefore, remove the redundant update_rq_clock() in
__set_cpus_allowed_ptr_locked() to avoid the warning about double
rq clock updates.

Fixes: d4c64207b88a ("sched: Cleanup the sched_change NOCLOCK usage")
Signed-off-by: Hao Jia <jiahao1@lixiang.com>
---
 kernel/sched/core.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 1842285eac1e..1123cd0ddffb 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2999,8 +2999,6 @@ static int __set_cpus_allowed_ptr_locked(struct task_struct *p,
 	unsigned int dest_cpu;
 	int ret = 0;
 
-	update_rq_clock(rq);
-
 	if (kthread || is_migration_disabled(p)) {
 		/*
 		 * Kernel threads are allowed on online && !active CPUs,
-- 
2.34.1


