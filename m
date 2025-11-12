Return-Path: <linux-kernel+bounces-897170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA5E1C52301
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 13:09:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A5D91893013
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 12:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96687314A9B;
	Wed, 12 Nov 2025 12:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="X2vSnTgk"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D372E305044
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 12:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762948898; cv=none; b=akeZzqKc1l/ePmwaFn8tVuqCMphyfUQ4iId8auvG2RLhBh6nGNX0b4MK9WylnyHDctmJg1Oc+gX5bb90qBrBLqFQyLFp9omkzYmEg8EHnAqG+QECjFh6WGvSsbs3JUC2w8JnbIGW8TN2RrDAdj+byPACdHJ9i8Oq9YzuhJIFqBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762948898; c=relaxed/simple;
	bh=sFj2zazGV4WYL81m3zn9aJ05ODam9PIsgaadkAnP5mY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sXR2XK4eZHvhvxJZ5Mmot09127Ogyj4uPFODG96Ft4/xPsl2/bdKafK7/lZXORaBnAsEdlgMrJHiEx3jel70wEDLACpbhZTN6bHJzeX/qTC7wOGsUFVaHwbwbSsRpLF6ngIo3W5RwH5YgYaCIIH4B2dGMP0b30VJbPqoIAclDKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=X2vSnTgk; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-47758595eecso3911695e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 04:01:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762948894; x=1763553694; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zV0gPAsgv2Yz7X77lNEHJyr8BfPRe8t/jR17bseIeNE=;
        b=X2vSnTgkiqS7cCumeiS0W4AR/OsZDnjMfYr9vFIUfFdkijRZ41oSGZPm0DGM4uf33d
         kPmiHe6/ehIYS3XZykt8ZDNL46cboy+n8IjCo6pQRhwZtkg7uErvPxJjC4qPrVHkc2b0
         p26ngF445mYPHg55Pg1bVa6smD8PSP4VRoj4CMDHf3g6pONlzZdG2h1gopsO1Zawtc1a
         1Z5k+DHS0MdqBqlugb/dXz7/NtNxtTARxp0guMKMyiSRRbVIqdtQXrfkfH3LbqNPfgrd
         PGxNuhT/8RBemQNbBDBw563aPMTJE1+qBTYTWHjC9rXn1uU7b0AXU4PZ6gCgqZKrm7hh
         7ASA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762948894; x=1763553694;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zV0gPAsgv2Yz7X77lNEHJyr8BfPRe8t/jR17bseIeNE=;
        b=chHsc6dlHtKbFIALBHTpBI+fRQYO8PAYa6+5COUsOYzhc/QOvaqRRlBNJPoG2+y7B8
         GGm0D2LCy/s/9fpOThdpqHziIjiKbca8to3YTkHSbkQeuB3M2V2XrZeFzLYUQb0wEark
         A6damac1P6onWQRgFPC9DdjIzPH2CocQG13ZRplCBxmGriPobPaTRsxmxC8sWpA6s0yZ
         lc4bYqSauSKQ6jKioe8/q+g7lAxD8ELXQHtkxfGz4vN/qARfAjmHlqwu+4OxnQNrFMnc
         M9/N+14ox7pD8LglDSSW9vEwtuBmSYnAQY0tZxRZK9TpwzWpQ6+SfhdcR3bDAI51NBQJ
         idEg==
X-Gm-Message-State: AOJu0Yy5VwfcjDyn5aCUG8PX+kS2myR0b17yb7RZzlNsD/PTUP+6+E9f
	2Z3XsnLzz6vTfE0HMq7Kq/Yl8wH0UrUrzJePhmzUw7Osvkyyjwiy40UjLnmBbOR/u3acZEf80q9
	fCLpQ
X-Gm-Gg: ASbGncvyuJCCquPdX7cgOvta82KBJwAkfLJXH97eS3/gyPW1Jd1C8OBudedPSgd5xvN
	e8yW+6GR2O2ajW5WyXaofQqwxp8c0mnkM33YzBEBIt9+OLCLCnYhqsBRTnQt3w8+IdixS7MPQQX
	ecBwnH+SOsfmP24Tw1B3KH2fXuovcufB5Qf/fAcHQ6hVmYEKm5LrCxARxgNUDH4z2r1mqyXfZuC
	gZO50EgfWW/4edxgqRpUqJyYmnNdcpisDzM8OSzVplHGRmkQwTWJqWVyfxJPVZ3+KVmfr2+s4OE
	zUfMSm+dNGo+hQ6emLW866RYh7uDjc35EifiOsK9B6hLEmbfpi/INDDH6kZKOWtHC1jD+7ZH64D
	j3UeigtgC5ANNMjMSG1Hx6J9CGitc50ul63d7JZKPI5Ynrmd3A674pR2azcwW64/xAqDKwDe6KJ
	GGqyvoAQzxpHQ8IDk=
X-Google-Smtp-Source: AGHT+IF5tkBJyCw/2/U+967Ak/tlZAJQIixZ0cO5ez5rZhOo0gjntdhB2by2OMFhbQV9h7jsFeGSLg==
X-Received: by 2002:a05:600c:138b:b0:46d:ba6d:65bb with SMTP id 5b1f17b1804b1-477870c31c4mr25267855e9.31.1762948893841;
        Wed, 12 Nov 2025 04:01:33 -0800 (PST)
Received: from linux.fritz.box ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42ac6794f6esm38158832f8f.41.2025.11.12.04.01.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 04:01:33 -0800 (PST)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux1394-devel@lists.sourceforge.net
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH v2] firewire: core: add WQ_UNBOUND to alloc_workqueue users
Date: Wed, 12 Nov 2025 13:01:25 +0100
Message-ID: <20251112120125.124578-1-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Currently if a user enqueues a work item using schedule_delayed_work() the
used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
schedule_work() that is using system_wq and queue_work(), that makes use
again of WORK_CPU_UNBOUND.
This lack of consistency cannot be addressed without refactoring the API.

alloc_workqueue() treats all queues as per-CPU by default, while unbound
workqueues must opt-in via WQ_UNBOUND.

This default is suboptimal: most workloads benefit from unbound queues,
allowing the scheduler to place worker threads where they’re needed and
reducing noise when CPUs are isolated.

This continues the effort to refactor workqueue APIs, which began with
the introduction of new workqueues and a new alloc_workqueue flag in:

commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")

This change adds the WQ_UNBOUND flag to explicitly request
alloc_workqueue() to be unbound, because this specific workload has no
benefit being per-cpu.

With the introduction of the WQ_PERCPU flag (equivalent to !WQ_UNBOUND),
any alloc_workqueue() caller that doesn’t explicitly specify WQ_UNBOUND
must now use WQ_PERCPU.

Once migration is complete, WQ_UNBOUND can be removed and unbound will
become the implicit default.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
Changes in v2:
- This workload benefit from an unbound workqueue. So change WQ_PERCPU
  with WQ_UNBOUND_WQ.

- Rebased on 6.18-rc5
---
 drivers/firewire/core-transaction.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/firewire/core-transaction.c b/drivers/firewire/core-transaction.c
index c65f491c54d0..a9677a8affb7 100644
--- a/drivers/firewire/core-transaction.c
+++ b/drivers/firewire/core-transaction.c
@@ -1437,7 +1437,8 @@ static int __init fw_core_init(void)
 {
 	int ret;
 
-	fw_workqueue = alloc_workqueue("firewire", WQ_MEM_RECLAIM, 0);
+	fw_workqueue = alloc_workqueue("firewire", WQ_MEM_RECLAIM | WQ_UNBOUND,
+				       0);
 	if (!fw_workqueue)
 		return -ENOMEM;
 
-- 
2.51.1


