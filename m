Return-Path: <linux-kernel+bounces-849035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 21F8ABCF0D9
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 09:17:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DAB4A4E300C
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 07:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D5AB19CC27;
	Sat, 11 Oct 2025 07:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Amb9oVNf"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D5134BA24
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 07:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760167031; cv=none; b=jnm8mcUpNbtWo2s2HZK++IDKBRfHFV2HPnQ5nknW08bG+z5kN8W5pw2NiAwDzuOd/EcMJz+YUasWngf1xC5g5MGYp1wI7dgmQ8eRx7Q2gzzcehWdKpH5/KkPKYfjlRijckdiymmzlAOkoUb0KHP7YH3E5+G8SjG6D2s0DqoIL4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760167031; c=relaxed/simple;
	bh=YLsW/r4hSHgy1nGf7J+zvZa+MGChmds4cJyYYHSmPmc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=edKMFDrKQFzh415ZIPjUTYmYvSMnqTSiFxGlREWiI0NG/8OgScw8gnHzGBDZx6Waphd9GKQybKD4JUIr7Lud6653QMz2Fm5+JXS4fvRv78Y5LGrBpw7LeIQKSu81LuQRYROCA3pGdZ7PW4V3EdVCSWueny3rkRFmO8eji6wlcMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Amb9oVNf; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-77f605f22easo2473265b3a.2
        for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 00:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760167029; x=1760771829; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Bv8PPkUpdqr4xqrIFXn0ISsaH/w9siKBZC2GS79dh68=;
        b=Amb9oVNf9mhSC7McqwEVSi5Tal+XrIUez0kot2yhVRK7g7NnVcPYCYzohjvlB+tD5q
         zJWihKTgGSzrvo++Gcv62PTJQXTTuRDdUHJMB664Ej9BRyK1oC12Xk0Z0QpxecPddjnQ
         GpaRDqKwlvDFQDRcCLHg3G1tXBxBqnVOpXgFGz8m3j+8ddneywh69oc/rGXbyQuZka7w
         8ymPfqqHi3KxSde67g8TBSNsjHlihOTHUsXsGqfnet/51K9mUQyb66ndD+4YGISFwVAX
         S1k4ceZbTuhumpIyn6q22Ba2fEo+SJPKpOaXnY4jVOVr0XbxOMx0Q1wibEEiZtx8AN4H
         uuMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760167029; x=1760771829;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bv8PPkUpdqr4xqrIFXn0ISsaH/w9siKBZC2GS79dh68=;
        b=xArolSNTManhon3dwx67LP3JQm+GYoiGx/L0sQag41fWEqt3elN6w/cmBdU+aSZqM7
         N8Sfw4MV05cCApOhue5b59bcYWHAqjAUfzTan3u3qrr4NEPHjcxueQNIVcHJ2qKng73O
         RPXYBqe6Wa5bBTkWpK4h+s6zV1tEtzmF/h6r7ibVwcxr1O3AnGT6rMeci7TyFW0SYpPA
         Zu/YqJHanRd2XKKbYf3BzEoW7evY9Xy851SleFYczMbdX1MKx5iHjEEQJ2/JY9ZPFcvE
         k2liBYMOon7+SSW4mm30fbd90L9D9hs17KZ/i8iYeBB+UkuaH32B1w+OMb31u05L6B2E
         JyaQ==
X-Forwarded-Encrypted: i=1; AJvYcCXz/O7JqfLMczbUh9lDKwWlVTtsyvqs/tcFM8x+VvznBAADGvZrNziq16dS6LFARpqolkiudiCPHqBbHYk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6nGsmg1Koq5+9ztm+PXeRQnNWq4ficQjmmPVrJeGTnYHTe0Na
	brq1247UdMlIFV83sLEdvhWcsHKyKj9GXglETPE2XJ2RnIPvfp2QtBkC
X-Gm-Gg: ASbGnctuyGJUibKPvyGdEvLFeStX7CdL9UgfHPexF+B/6LMFYQaiwjHXk9LsYFk48Le
	fL607kQWrzYk62xuZ4DZ2/Gpzf//I3SC0xVnJvDLpypHA8hZ7lMUIV0LL9SfF1+ZpNVzWwwHjV1
	3QG6Jol3wKT6gUaPpEzL9laVBqdjBlw6pUYk8qNJ9ElvGI78kXxTQYxZzDqt71fSRm1S9D/kLLT
	jzC/n3AYfYXj54rSP2f13+Bjbg5zN4EH1NOihXF6DgGKuuPj7l3+yrJ35qFqtPIH00Gkjj5Ltqk
	1ukNfBMZbKBuBU4OidB4H7aLSdbJFMZPcE2k+gLcYlkLFvGpEGz3bk1I1SZpTuyebXWpcH6wV4Q
	+zp9KOpX6n2eurNGppkunl2w/gQQYXb1JA9omEi43h1FxONd/eb8V+aFmmojVRAqHedTyoaFdoD
	QBWm2PeuqoxHajGN+5Y68PnjCKLrfjz5bBnwdtSXI=
X-Google-Smtp-Source: AGHT+IEkNoWjL/AfSPjsfICKC5fTp8Soz048NP2zmC3B2vwQgePcu6Dx1MC3KujmUuVq4hbg4LQh+A==
X-Received: by 2002:a05:6a20:1590:b0:2e6:a01e:f212 with SMTP id adf61e73a8af0-32da839f8c6mr20207562637.35.1760167029245;
        Sat, 11 Oct 2025 00:17:09 -0700 (PDT)
Received: from mi-HP-ProDesk-680-G6-PCI-Microtower-PC.mioffice.cn ([43.224.245.226])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b529f2409sm4697534a91.6.2025.10.11.00.17.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Oct 2025 00:17:08 -0700 (PDT)
From: zhidao su <soolaugust@gmail.com>
To: tj@kernel.org
Cc: soolaugust@gmail.com,
	linux-kernel@vger.kernel.org,
	suzhidao@xiaomi.com
Subject: [PATCH] sched/ext: Implement cgroup_set_idle() callback
Date: Sat, 11 Oct 2025 15:16:51 +0800
Message-ID: <20251011071651.99392-1-soolaugust@gmail.com>
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

Signed-off-by: zhidao su <soolaugust@gmail.com>
---
 include/linux/sched/ext.h |  1 +
 kernel/sched/ext.c        | 29 +++++++++++++++++++++++++++--
 2 files changed, 28 insertions(+), 2 deletions(-)

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
index 088ceff38c8a..ddb49ffb2227 100644
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
@@ -4092,6 +4103,7 @@ void scx_tg_init(struct task_group *tg)
 	tg->scx.weight = CGROUP_WEIGHT_DFL;
 	tg->scx.bw_period_us = default_bw_period_us();
 	tg->scx.bw_quota_us = RUNTIME_INF;
+	tg->scx.idle = false;
 }
 
 int scx_tg_online(struct task_group *tg)
@@ -4258,7 +4270,18 @@ void scx_group_set_weight(struct task_group *tg, unsigned long weight)
 
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
+	/* Update the task group's idle state */
+	tg->scx.idle = idle;
+
+	percpu_up_read(&scx_cgroup_rwsem);
 }
 
 void scx_group_set_bandwidth(struct task_group *tg,
@@ -6004,6 +6027,7 @@ static void sched_ext_ops__cgroup_move(struct task_struct *p, struct cgroup *fro
 static void sched_ext_ops__cgroup_cancel_move(struct task_struct *p, struct cgroup *from, struct cgroup *to) {}
 static void sched_ext_ops__cgroup_set_weight(struct cgroup *cgrp, u32 weight) {}
 static void sched_ext_ops__cgroup_set_bandwidth(struct cgroup *cgrp, u64 period_us, u64 quota_us, u64 burst_us) {}
+static void sched_ext_ops__cgroup_set_idle(struct cgroup *cgrp, bool idle) {}
 #endif
 static void sched_ext_ops__cpu_online(s32 cpu) {}
 static void sched_ext_ops__cpu_offline(s32 cpu) {}
@@ -6042,6 +6066,7 @@ static struct sched_ext_ops __bpf_ops_sched_ext_ops = {
 	.cgroup_cancel_move	= sched_ext_ops__cgroup_cancel_move,
 	.cgroup_set_weight	= sched_ext_ops__cgroup_set_weight,
 	.cgroup_set_bandwidth	= sched_ext_ops__cgroup_set_bandwidth,
+	.cgroup_set_idle	= sched_ext_ops__cgroup_set_idle,
 #endif
 	.cpu_online		= sched_ext_ops__cpu_online,
 	.cpu_offline		= sched_ext_ops__cpu_offline,
-- 
2.43.0


