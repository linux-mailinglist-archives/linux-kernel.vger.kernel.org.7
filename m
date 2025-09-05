Return-Path: <linux-kernel+bounces-802404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CDDE3B45216
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 10:52:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 853FD3AB3E2
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 08:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98AE63043D1;
	Fri,  5 Sep 2025 08:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="J/1X21Hv"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D25227EFF1
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 08:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757062335; cv=none; b=C05x8HbWaMZtSmtFLk/voTgMIPV7DbNfa4ATYAbA3bDAuXuHwHCKD8DYlEAvKF16CHnib/tiBdmBEdXIt6RjrjbPfbIe3dNlwK9ZHWfuSHj6h8Os7O/Pd5BqxrRQSgHJ+QI5njw50nqPVUjWqERAk6BBBWQOTbVSGP361HcuLew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757062335; c=relaxed/simple;
	bh=++ys8qf1mVFh7eaJ0LPRH0noW+e/5qWo081uJ6QywX4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OyIGCw4QxGMfEU6ewIV70BK5OThiELPt294WfZfnE4IJCJr7fdHl+gUjja9u3UU71PnO7DFPj2vKwETgR8uqoRY3U7tBZijwo8Pi/HN4AtSg+JkI6vv9MpDhSs75bYfC2wBRiU5endntbmEnSLkrSzY0h+Ls5a+DfdJOXz0r8Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=J/1X21Hv; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-45dd7b15a64so4016345e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 01:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757062331; x=1757667131; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6o4r2c6Wzzp+J29SS3YZXj6FxIBq7GTFCT9Pn6IdrUA=;
        b=J/1X21Hv9aeS3pK1XqRWVYzLZUylMw79x3kM7hwjj4PKyLuexMappeM6E6+biSXjoP
         sd6c3rfJZnLntDYkXdCxUskuyPCTD+25RNzIK7VNCtKEzXehW9wnE506YLyhj49CT2Oa
         OK73kobcTr32n3pe3Uaeew6C8hnEHqc/cZZX1bkCkl3q0VATh4QHbnuAYmnr+t+OZAyI
         xv98opbmchHpz+KDBgQWL3Yml3saNw9a+rhkkTcaMqN8n/+RqSX0ka1jKv/i7K+0SQ0I
         QGPzW3xhhVks2OnSnSfG38Y2bMGy9ajRa8+CIQLkjSask0aAHxbcdk+FH9R4CDajwgKb
         WIpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757062331; x=1757667131;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6o4r2c6Wzzp+J29SS3YZXj6FxIBq7GTFCT9Pn6IdrUA=;
        b=dtAG+QPAZwucW5RkfUopDBmKvZW/e54a8HPsNZhZmU5KzARw1xnUpb2aTWURQe0iD5
         IqEyhY6zl9fyIMKgij7iKi9Ut6Kl1GTE9qbG+O17jKip+9GOzbPcjsiLKPMizy3EnT+l
         SB6rQ9h8mG/ZA8wdOR4+YZnyxnnlYTPQdlxoyutE8A7u7vqnumqY5g4/LH52qgf6lEDe
         pebse+fpzqyDwFozBeiTsOxXJzOLnfEQBNcLAu3mtflX7NAGxZxeX8xFBFvxBjLd0/5U
         LZWm7qLvS40vZ7/AV+DyTICfw7p6sVI+EwppT74OCNF+RhiViwLpPRtBRNwh1Y4DQCs8
         mR9w==
X-Gm-Message-State: AOJu0YxnnN+RexdlS3QTpmaWCN1Mk2KLrDyT0zGJ29KjNLQIv+/Q7Hel
	vl34pos0a0LG2MkaHa7pqQ+aMJzTChn1P+SRMGbbM68Kx1aZYQtbqFVwcWaSL6YSoDihcjMQXIq
	af+I0
X-Gm-Gg: ASbGncuTOLznuqmnzqP5dIreRz2jnBwaolkUOziHiPQQZUKNSpAgPt8aBNta0O9Lix2
	tIAJgI+KxCEGasQ0LverxBuOuFBPqoDTeGsTsq01Oa9QkGtIvINLeNjPNL1Pe834Hgq8R0JlNYp
	/R0MJAgzY4ixFA7OtO3tL8BVRfZiWxMgRmk8g2f/2VghViebgOnqUOJzozREo4fvpn9LZr39R2X
	z/z/Y9q66y9TNLOHUmYh5PAWW0YUcKK66lbHmbI3y34YkvBxWP0H3/I5JmQvTJ8NSl3r6UODkcF
	BGDLgxGbIOhOFo0dHR/ePPO6f123Y00ej/fS4SpSkdor0+3oPw/tBGpnait7tgqRSL4SlWLJP1A
	KhHNiD9QfCGTX6e512EFMNcTJCNPDRjiv8q7t6gPf8f97GCwROLsc3qF/3A==
X-Google-Smtp-Source: AGHT+IGzUSTZ0dDnwg+i9qkis6hQBvZ5e7JyYMSkRPsAT6NSK9nycRZK+BwlgAZJyKeWJKn15q8TDw==
X-Received: by 2002:a05:600c:3b01:b0:45d:d202:77f0 with SMTP id 5b1f17b1804b1-45dd5b3c05fmr20914855e9.5.1757062331095;
        Fri, 05 Sep 2025 01:52:11 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b940bbc0dsm166359115e9.2.2025.09.05.01.52.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 01:52:10 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 2/3] drivers/block: replace use of system_unbound_wq with system_dfl_wq
Date: Fri,  5 Sep 2025 10:51:40 +0200
Message-ID: <20250905085141.93357-3-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250905085141.93357-1-marco.crivellari@suse.com>
References: <20250905085141.93357-1-marco.crivellari@suse.com>
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

queue_work() / queue_delayed_work() / mod_delayed_work() will now use the
new unbound wq: whether the user still use the old wq a warn will be
printed along with a wq redirect to the new one.

The old system_unbound_wq will be kept for a few release cycles.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 drivers/block/zram/zram_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index fda7d8624889..c7e0fa29a572 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -975,7 +975,7 @@ static int read_from_bdev_sync(struct zram *zram, struct page *page,
 	work.entry = entry;
 
 	INIT_WORK_ONSTACK(&work.work, zram_sync_read);
-	queue_work(system_unbound_wq, &work.work);
+	queue_work(system_dfl_wq, &work.work);
 	flush_work(&work.work);
 	destroy_work_on_stack(&work.work);
 
-- 
2.51.0


