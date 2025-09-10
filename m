Return-Path: <linux-kernel+bounces-809886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A14BDB5132D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 11:51:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A521F1C24ED8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 09:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C4C525F797;
	Wed, 10 Sep 2025 09:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ISuvdleM"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C2D1DFF7
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 09:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757497865; cv=none; b=TcuxBd130jyEgfVn50YM0PIb/VuNT11w6/7RDB/GHRlfPvcSj678PspfA7V6WGjizxVvswwSuW+GzFzHV04tDSmdiDfp9ZkiLOodxQHKUpAMuE+5GaVnKyxkK4TZjJsf+FrD+kAcWPl832CF1yiakki+/VjC9cBr3LYMQBfOsP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757497865; c=relaxed/simple;
	bh=1Ekj0qCIIDmPMKd7MKdQz0vD6mXZnE9z0aNJq7133j4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OP/Gt4hOqOXzjBXATcD4lQZWmgGs2h8NhmBr0kuUq9uIqjDWeiFYM5kK5wTerNcWAWDKy0zDdYdtZrkgs8RWFObp0mHL6V9USODqjAWyIps3zf9gXtCrvO2fsEaTEdZSoMiDE+iHosauGZB/3jpiYeby8BM86qAC4tDyV48MjVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ISuvdleM; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-76e4fc419a9so5439829b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 02:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1757497863; x=1758102663; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZDb/LrvnV1UIDhd01+52KAVilWExL2afxMFnYseaFZk=;
        b=ISuvdleMbsmRKn6KmvXN4USv6uhGR66YT9h382pyJwJbtWgu948UkOn3dlSG/6XeHP
         IYAafl/bPCHqp8CTJrOiQuCmLFIV60zAJYcBrdp04SXYdb99MPu+Fr/qfI5S9zGdW4N3
         4mQm775gY6eTwlvC96OYWFMUrtIswM7uCQmmXjCKcvdcL5sEYY+IPdoHdcGwa0xx70z1
         7wFBnhrhkH3nm+9D1CHORNiFulMQAotPJaLDXR5EXwBZQ6uOSjoV/rM2qa9HMw/drEbh
         xvzQMDrBo8i/wlSowN+BkYwD3eKr85BZMRbxcJrrfk64N+vmDv1Ask1gZ830MzdN9wOB
         o3Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757497863; x=1758102663;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZDb/LrvnV1UIDhd01+52KAVilWExL2afxMFnYseaFZk=;
        b=UHQhhHkTp+U2YB3gRapljO1XySmT0lGiVqfBSkC9LniyEiyeP3a6CVF9hCrmz2L5Dk
         ZIG4kP1US5hySIAJs9SLNZ4n9mwGgQ2jkitGc+8ZHvx4+BqIxSyTeBES+XOCDCUc8qjx
         zCj+QyXCNrdVMjeZFsmjnnLN2uFBZ02eHVppyT3MLMj8Mz4QACPdhbxWIOZVGbNHqLsM
         3b1ZcKni3+uRZzr7oYUnNV7IWeXZ7xxbhlwafgZdusq1lZ2graEPq2rOiFwd/hMRq49E
         eMt80dsOasAceXe1vRj+VcSMzYWxZVJtHBQSSQ5PWFOgOhUblKoizcvFSZ50j0qzX5zU
         s8RQ==
X-Gm-Message-State: AOJu0Yyk1hrYzDyM7wux9m9jLvLQyyfBtIEM/GOttF+AZxoAsJuEPqI4
	LdkSGwb8+Wet4/PorO/y2lLYW8CAf8HRlhWt0NMeJ+EuKqKijKpo6l4WX4JO5+9zpg==
X-Gm-Gg: ASbGncvqKBEF6WBGqQ0bdCduY1ESZ7OGTn3xWImzmqaamsPq/KVoOmQAFRwCJ0LPkCP
	4m16H9xh3W12npD9RDEIOz4qvmXh3lHkyxpcSdICAXN3R7fuBkUAUTEQGU0AVvijMi5PHpKqzkr
	JniagVSa1awCTip7wXJcAKXOVSOGmnPn0W9PDROYZDuClfz5piY4V+ArdhqdyAtxh+948lOty/l
	L6GDk59sGLfsKR81tp+9impoxbl6FpTG4buGEd/0D0vqSe2+nvYknn6enSfD9ar6NoR3UGn0tSq
	5v9K9Twv4WrPsZAs3O1Ny5YmCaBbd3i0wgXtrsZUvq/i26SYrWXQcMmIVzcVLflzPhCE65Gchj0
	Ps1g1E9CpoQdhh22Bjr25KwBawqv8klaoV8anOG9IGVRwrinoYVHWh0b/TO7kSitct3RFAJzpWq
	I=
X-Google-Smtp-Source: AGHT+IE5fbZk9PGJMqaSZD8J9XfW9t0gxKPoo40ttIreXkGM+ffknrv3gbosZgxIPdQC14TL9joIHg==
X-Received: by 2002:a05:6a20:734b:b0:251:8a26:2648 with SMTP id adf61e73a8af0-2533fd94dacmr22855595637.14.1757497862561;
        Wed, 10 Sep 2025 02:51:02 -0700 (PDT)
Received: from 5CG4011XCS-JQI.bytedance.net ([61.213.176.57])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b548b81f5acsm1850623a12.1.2025.09.10.02.50.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 02:51:02 -0700 (PDT)
From: Aaron Lu <ziqianlu@bytedance.com>
To: Valentin Schneider <vschneid@redhat.com>,
	Ben Segall <bsegall@google.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Josh Don <joshdon@google.com>,
	Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Xi Wang <xii@google.com>
Cc: linux-kernel@vger.kernel.org,
	Juri Lelli <juri.lelli@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mel Gorman <mgorman@suse.de>,
	Chuyi Zhou <zhouchuyi@bytedance.com>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Florian Bezdeka <florian.bezdeka@siemens.com>,
	Songtang Liu <liusongtang@bytedance.com>,
	Chen Yu <yu.c.chen@intel.com>,
	Matteo Martelli <matteo.martelli@codethink.co.uk>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 0/4] Task based throttle follow ups
Date: Wed, 10 Sep 2025 17:50:40 +0800
Message-Id: <20250910095044.278-1-ziqianlu@bytedance.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Peter noticed the inconsistency in load propagation for throttled cfs_rq
and Ben pointed out several other places regarding throttled cfs_rq that
could be no longer needed after task based throttle model.

To ease discussing and reviewing, I've come up with this follow up
series which implements the individual changes.

Patch1 deals with load propagation. According to Peter and Prateek's
discussion, previously, load propagation for throttled cfs_rq happened
on unthrottle time but now with per-task throttle, it's no longer the
case so load propagation should happen immediately or we could lose this
propagated part.

Patch2 made update_cfs_group() to continue function for cfs_rqs in
throttled hierarchy so that cfs_rq's entity can get an up2date weight. I
think this is mostly useful when a cfs_rq in throttled hierarchy still
has tasks running and on tick/enqueue/dequeue, update_cfs_group() can
update this cfs_rq's entity weight.

Patch3 removed special treatment of tasks in throttled hierarchy,
including: dequeue_entities(), check_preempt_wakeup_fair() and
yield_task_to_fair().

Patch4 inhibited load balancing to a throttled cfs_rq to make hackbench
happy.

I think patch1 is needed for correctness, patch2-4 is open for
discussion as there are pros/cons doing things either way. Comments are
welcome, thanks.

BTW, I also noticed there is the task_is_throttled sched class callback
and in fair, it is task_is_throttled_fair(). IIUC, it is used by core
scheduling to find a matching cookie task to run on the sibling SMT CPU.
For this reason, it doesn't seem very useful if we find it a task that
is to be throttled so I kept the current implementation; but I guess
this is also two folded if that to be throttled task is holding some
kernel resources. Anyway, I didn't write a patch to change it in this
series, but feel free to let me know if it should be changed.

Aaron Lu (4):
  sched/fair: Propagate load for throttled cfs_rq
  sched/fair: update_cfs_group() for throttled cfs_rqs
  sched/fair: Do not special case tasks in throttled hierarchy
  sched/fair: Do not balance task to a throttled cfs_rq

 kernel/sched/fair.c | 50 ++++++++++++++++++++++++++++-----------------
 1 file changed, 31 insertions(+), 19 deletions(-)


base-commit: 5b726e9bf9544a349090879a513a5e00da486c14
-- 
2.39.5


