Return-Path: <linux-kernel+bounces-846137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C808BC7219
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 03:56:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 133CF3BA32C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 01:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A3581922FD;
	Thu,  9 Oct 2025 01:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mijZG073"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C1342F5E
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 01:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759974997; cv=none; b=RLeFaMSPF47atc1jDctaPQ4gGTdxkh6NNKDDqMoApWPnqrBfqXMespmbfUrtubhEEShYJ4D+ccW1Fn8eeYJOEv8Xdgig+FjQcNHMxZB95PeKz3FdKY/SM0sZBL8EzXvecTWuVBiRZYifWyxGE/jDylRGcyscWZhQ66qxUAlBYcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759974997; c=relaxed/simple;
	bh=YLsW/r4hSHgy1nGf7J+zvZa+MGChmds4cJyYYHSmPmc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rj0fuUr281dYB+/g8R/2dNjA4hEZt90Rars65p2XoG04+B+MFoyHJmSs55VBUUvHzBY7VsGKOA4PuCPwyUHeFoidCE51RsGT9yLw56FVkebAAmtH8NKwCNV2FGMgGxa6rGbCiee7wQYB1jA/UiB0xwhXQjSGzBavkadtxvY9ZAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mijZG073; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-26e68904f0eso4458855ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 18:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759974995; x=1760579795; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bv8PPkUpdqr4xqrIFXn0ISsaH/w9siKBZC2GS79dh68=;
        b=mijZG073eW58siuaeLBBFOPLMd+5sixfyAaFQDhyJwDLIgnKkZn8bevlW1ruhJn7C0
         SXuSQZwJy+aODLG7kq//8UKyeQ/wsFXbTkesojEiXjmq0HoXTPVTLgk0h47L/SPmowUy
         yd8ybZa1GkrIHPCA/xN+mBdXzUOGunl4di/HjdvH2SxiT5KDrMFzqznhbo14sVsLLWaE
         9ci5BoK42zgTp5ggGwuZXVDSeQBD5l7+49pQXLPm2rOpSK7zi6FIAjyHJJOS/IBwad6g
         zSePg6LaFgDMrbjkV3Ry9qPEqKUFFU1Zxd0rmPXwTwTA10mSqSJilRpPwlhkiT08kAgx
         ZBHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759974995; x=1760579795;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bv8PPkUpdqr4xqrIFXn0ISsaH/w9siKBZC2GS79dh68=;
        b=MWgruU9v7xtJwNMAY6x/fpJDFImxxC6utDunjCmp/TrGPqGDUUflc9qtbe1dX2Pplw
         XBCjoE6Y7nn0CNliegvUCWFCs9ohpIXspiE8zWiVnLsySEMfUJ4SMkkGDaPe+S3townx
         3eUkmCfVgtKKnL7MmDfFrk40uAkfxQZlThXgs2M212gAZma5xZIvlk8KL1xezWC97BLg
         asa8MMoeB9AhmLizDhJjyCCQ/U1qxFtdkwDmjLAvp8ZMRTgFkaVKnqLoSHMWBY2/jcAH
         ohSz/RH6snnIadeWSjd9XICOzZhlxnw8r7QMJ5A1G6JhqHYmkFxZc/aNaaxvpYwHY5B/
         e7FA==
X-Forwarded-Encrypted: i=1; AJvYcCVlk/WkJkuubiSeqtizuPT1sboKFEdax3cdGTXzO27De/7uzDnr2lSsZvMWDfmp2V+ekGt6U3poG1hkBZg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx147Erz6UCfNtH4WiUTYnDqXccUVwN4Px2Y+XmMhyRQbK1KST6
	c3+rTS9d8fSPzZ+/kpYe3rm8N370GEfqMQXUO3ajZvpbWsuMcL6mxVcHoSwcs3Gr3QE=
X-Gm-Gg: ASbGncuKeS9MzjysdF8qCfMcPKTAGUpLT+yB9SQ8NL18lydLVJWJ/N1GBzqliTV2/9U
	JK9NhtBDrydJ7mNAAtTPjOFA9+kTzVvFbq0hHdEzpFKghGEbaS+JxAnnrRsHu3L3vATWQpn4Vfo
	8ErM38wYi5Kaici78cGxDUUgfsrpO576RLxRnG3uJLPBzCEhpYWI/eHEaAAQZhxicdw+A0UcsVX
	HdxcQFiJL/wrVIWzgKAnjrAHujXDwN4ZF+XiNMDoG54hhcK5mUyYeMDvMsGGqEs3zZD+lWLKeZy
	SFxTFphKAVzzQx6FEPO8IRb88Urrq/PQbRhnnhHP2dS4YTOQxT85BiJpumk4I0DJCH801iiQkXE
	Io+Cy77PSUSeN1Aveceh5k/BXshl4bNHzvtmP9sGOmGptiTRFVYYwQ5hudWmwVtFUjJMuC6LglH
	sCWgDtng7fML4IYKrMFsGKDtQ=
X-Google-Smtp-Source: AGHT+IF5AgRtrw/DOmynU0guVKW9MLrWr+SvF2IPOcnhY1iY2UDq1nPteyNK9ux+pUEFol7FzOVMbQ==
X-Received: by 2002:a17:903:11cf:b0:261:1521:17a8 with SMTP id d9443c01a7336-2902723b1d9mr76696455ad.16.1759974994879;
        Wed, 08 Oct 2025 18:56:34 -0700 (PDT)
Received: from mi-HP-ProDesk-680-G6-PCI-Microtower-PC.mioffice.cn ([43.224.245.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f941a5sm10673715ad.127.2025.10.08.18.56.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 18:56:34 -0700 (PDT)
From: zhidao su <soolaugust@gmail.com>
To: tj@kernel.org
Cc: soolaugust@gmail.com,
	linux-kernel@vger.kernel.org,
	suzhidao@xiaomi.com
Subject: [PATCH] sched/ext: Implement cgroup_set_idle() callback
Date: Thu,  9 Oct 2025 09:56:15 +0800
Message-ID: <20251009015615.766392-1-soolaugust@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250928131510.538231-1-soolaugust@gmail.com>
References: <20250928131510.538231-1-soolaugust@gmail.com>
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


