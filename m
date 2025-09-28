Return-Path: <linux-kernel+bounces-835425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A843BA70BF
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 15:15:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE1521793E1
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 13:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 827EC1DF26E;
	Sun, 28 Sep 2025 13:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bdp8DspB"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A21134BA32
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 13:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759065323; cv=none; b=L0RN7OQdMzxBAssE+m1WMk3lpZSa/PtGFJUjlPFf1keTBPKKHe0cg5TpitMKAbPqNSKHDFwsquPCJQ6jz9THUhCzmgHlCT4N0VKmC9bedGzr/7vkjZeSBcOzJYbbGrcxz2s06LcKBTkL+risfGB7oA97M3NjPjRHkmSUARljEAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759065323; c=relaxed/simple;
	bh=OKtwzObm746UbmyVAjpVwKeRZvohe4n/dLhJxbUjSa0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GU4GudtXTufQRAsElVtp54CciCc/tHDFHIGQkbumwBqO1pkZ5+nLzN7g6KzF1nW2zbTLpsy50iozlDgst2yZrJs+fj5ct16SCNy7+9dnBe5XP6G/f1NHJof99PwIcvom1viupN+N8eSTM0cxD8Dq2IeT0uNQElC0ImuzL2OsUTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bdp8DspB; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7841da939deso238659b3a.2
        for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 06:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759065320; x=1759670120; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nR2uIZObkTs1yBjw4Xmy+f8XsVDHniquW/u7nHFG3VE=;
        b=Bdp8DspBaBfLj+0uZuxwZ65IA0om5ePXIf0DzFpAH7ehgOnusx1MixpR6++1tIz7Jr
         GaE02p/X3oC8ITKxrwlq53JWpNHZ/4JFMcqRoMD0TcILk4BPrLI47AHmWi877EpA8adF
         Z0MfxKGBj3La3TcUqZA8aMOtutWKr2XceYSR5zPgUrcHn8MsMORcIyNmnpc67aa7lBN2
         wfg+NYehxFoTGEVNjtnxPEiiG/FYMeDx6OLJa7+1/0btFdTnXqM+PKruVwX6xVkIyJP2
         WoRzJUJ7Ont3q1h4F+b8j1qITEoZV4RW3+4ojXTrboYCfR2pdPUi+HkLCHZmIMOYy8Ib
         3bAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759065320; x=1759670120;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nR2uIZObkTs1yBjw4Xmy+f8XsVDHniquW/u7nHFG3VE=;
        b=djsfJ64hEcy1Nli0VSyyWbnRNoaGjJjyCU4G+IR8vX7lkwmOlfC0OkxFfFqLF48Ve6
         /eumrTKRpAr898dgv6vz3SzHsF6vqD9VuyECQLtk6eSNbiH9V/5hUyVjscN9wbNadEnn
         fwtImNlH1Qqr+3Txw1u6BUnoLv5eWTBzT6Zbn69hV0jJtp7I3SxwqnpAELoO+Yy8IMDe
         IbQxNdZT9gtpDTPqs29qXzaLc7yVAJEfDAsUZmaJv9tbbZvUvk7acRnin3mRs9JyTIUD
         7D8BQvhPzpwSjDTSI/wmm+KY+If31OUWwUfC9ESLZ0qV6rTlVgzY9LTfhj36fTYQ1Rzu
         r43w==
X-Gm-Message-State: AOJu0Yw+150uvwoXL2X8aam0nY+GNMvLyCDXFopFOZNXFAi+PynnEu+S
	jcKl5p4uSnXte6bCe2/iEZZNlMjrLvutwyIC//sVCi+PVLtbuJBX0mSAsboxaY1oI3LS4Q==
X-Gm-Gg: ASbGncvgMV7qkeFl0zdpivdf5VXeSIdfAJCNns+dqCwiLb2qy9MF31BWITbLY90vHvS
	v75GqE4R40tUiQzTu7+A/ZRU3bWo+STioVi4j8xXJPxk3C7Ta7de8YZe29DFKyoFHowD0RnnUuF
	aPTHzwehy64jSkBPlPKv9LNEy0fk6SQy8UlhBEbFZUWVxz9sgiLM6UOsbs4P4MH8aMOsEGJ590W
	Ipb0cO41eGaMyZW/CicDBqsYQJHQsg8N0EMoQ5kVgJKAkfcqsb2wz+Oq9njT9eYc2lrEnBRY8Ud
	nWeShX6mybsVrbO6eJcN6oNjcSONN2FhQmXQkZ4PjAc3L7KHKHFzoJCuugZwUxriPrDQamgoFfA
	nitAvBC+dB7WCjLmpSPdR/LmeyKrWfyq7vYypee3fWDl8yXgXRPXXC92nKjUvCkZYrsoJsoMZjc
	3g46oh2L0tjg==
X-Google-Smtp-Source: AGHT+IEFhzNziIE5TdHt0mPg7TCniCxcHF9tGv0y3DAAnEZxULpbeIBBZaUqgxWoy5QwPnkCUUjqwA==
X-Received: by 2002:a05:6a21:c206:b0:2fa:76b6:80d7 with SMTP id adf61e73a8af0-2fa76d51983mr5987352637.28.1759065319777;
        Sun, 28 Sep 2025 06:15:19 -0700 (PDT)
Received: from mi-HP-ProDesk-680-G6-PCI-Microtower-PC.mioffice.cn ([43.224.245.226])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78102c06ff4sm8503448b3a.86.2025.09.28.06.15.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 06:15:19 -0700 (PDT)
From: zhidao su <soolaugust@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: zhidao su <suzhidao@xiaomi.com>
Subject: [PATCH] sched/ext: Implement cgroup_set_idle() callback
Date: Sun, 28 Sep 2025 21:15:10 +0800
Message-ID: <20250928131510.538231-1-soolaugust@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: zhidao su <suzhidao@xiaomi.com>

Implement the missing cgroup_set_idle() callback that was marked as a
TODO. This allows BPF schedulers to be notified when a cgroup's idle
state changes, enabling them to adjust their scheduling behavior
accordingly.

The implementation follows the same pattern as other cgroup callbacks
like cgroup_set_weight() and cgroup_set_bandwidth(). It checks if the
BPF scheduler has implemented the callback and invokes it with the
appropriate parameters.

Fixes a spelling error in the cgroup_set_bandwidth() documentation.

Signed-off-by: zhidao su <suzhidao@xiaomi.com>
---
 kernel/sched/ext.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 088ceff38c8a..72bf2ad382fb 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -688,12 +688,23 @@ struct sched_ext_ops {
 	 * 2_500_000. @cgrp is entitled to 2.5 CPUs. @burst_us can be
 	 * interpreted in the same fashion and specifies how much @cgrp can
 	 * burst temporarily. The specific control mechanism and thus the
-	 * interpretation of @period_us and burstiness is upto to the BPF
+	 * interpretation of @period_us and burstiness is up to the BPF
 	 * scheduler.
 	 */
 	void (*cgroup_set_bandwidth)(struct cgroup *cgrp,
 				     u64 period_us, u64 quota_us, u64 burst_us);
 
+	/**
+	 * @cgroup_set_idle: A cgroup's idle state is being changed
+	 * @cgrp: cgroup whose idle state is being updated
+	 * @idle: whether the cgroup is entering or exiting idle state
+	 *
+	 * Update @cgrp's idle state to @idle. This callback is invoked when
+	 * a cgroup transitions between idle and non-idle states, allowing the
+	 * BPF scheduler to adjust its behavior accordingly.
+	 */
+	void (*cgroup_set_idle)(struct cgroup *cgrp, bool idle);
+
 #endif	/* CONFIG_EXT_GROUP_SCHED */
 
 	/*
@@ -4258,7 +4269,15 @@ void scx_group_set_weight(struct task_group *tg, unsigned long weight)
 
 void scx_group_set_idle(struct task_group *tg, bool idle)
 {
-	/* TODO: Implement ops->cgroup_set_idle() */
+	struct scx_sched *sch = scx_root;
+
+	percpu_down_read(&scx_cgroup_rwsem);
+
+	if (scx_cgroup_enabled && SCX_HAS_OP(sch, cgroup_set_idle))
+		SCX_CALL_OP(sch, SCX_KF_UNLOCKED, cgroup_set_idle, NULL,
+			    tg_cgrp(tg), idle);
+
+	percpu_up_read(&scx_cgroup_rwsem);
 }
 
 void scx_group_set_bandwidth(struct task_group *tg,
@@ -6004,6 +6023,7 @@ static void sched_ext_ops__cgroup_move(struct task_struct *p, struct cgroup *fro
 static void sched_ext_ops__cgroup_cancel_move(struct task_struct *p, struct cgroup *from, struct cgroup *to) {}
 static void sched_ext_ops__cgroup_set_weight(struct cgroup *cgrp, u32 weight) {}
 static void sched_ext_ops__cgroup_set_bandwidth(struct cgroup *cgrp, u64 period_us, u64 quota_us, u64 burst_us) {}
+static void sched_ext_ops__cgroup_set_idle(struct cgroup *cgrp, bool idle) {}
 #endif
 static void sched_ext_ops__cpu_online(s32 cpu) {}
 static void sched_ext_ops__cpu_offline(s32 cpu) {}
@@ -6042,6 +6062,7 @@ static struct sched_ext_ops __bpf_ops_sched_ext_ops = {
 	.cgroup_cancel_move	= sched_ext_ops__cgroup_cancel_move,
 	.cgroup_set_weight	= sched_ext_ops__cgroup_set_weight,
 	.cgroup_set_bandwidth	= sched_ext_ops__cgroup_set_bandwidth,
+	.cgroup_set_idle	= sched_ext_ops__cgroup_set_idle,
 #endif
 	.cpu_online		= sched_ext_ops__cpu_online,
 	.cpu_offline		= sched_ext_ops__cpu_offline,
-- 
2.43.0


