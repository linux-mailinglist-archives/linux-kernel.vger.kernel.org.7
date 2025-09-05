Return-Path: <linux-kernel+bounces-802487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A61EB452C2
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 11:15:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C79A4A64543
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 09:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C19A83126CA;
	Fri,  5 Sep 2025 09:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="B4rcocMm"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A13284678
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 09:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757063454; cv=none; b=AhEsV3Gf1citEBCj05tnZT8WkhdXZs6pDCNUVFMO0fvva/Fb7ddS1Q8HwPumTmGxiaiZ+zUlz5lcJEtN9qUfkcGXFVrzZ8uzcqd3azcTj/0P56RqzzgsRhWOk3iZZi7v0oCF5ybMx+AawLjhsjag1ku54j6MT/DqIv1baRyTwJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757063454; c=relaxed/simple;
	bh=bnA5ox/O/mmmiQEy1E7E95sgYqDQgnA0GWdQw5e6aE4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MvbjcVkAc28tRD7V41BBdz5Lpx93y9NEHkPIUc4MdY6XcBTNGMjop7fvbxQ/OzrQgxTgEAlXrOOnZPeigHRlzt3iER4++clTQxy8TbkLywITJmibTiWq6SClYQ/3pdQ3jfsegl6NNfHyOlghTyl1lBlw/XY5Zkyy0Zxr6EaZzFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=B4rcocMm; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-45b8e28b3c5so17677885e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 02:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757063450; x=1757668250; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4qXDnbZXZ7ZGHEJeuNju+2jnsBVNxEVg6Jd0e4YiKfA=;
        b=B4rcocMm+6yZbBCd96SyWbtrOMosQNKdN0c+Ch8Nsa5OaFe/Ru20A4WmYb5MydiLhS
         pwGC41AODgjUtDdOho3B5O3f26DPrMLrcapfjWwUuwFho8utjLF6KUa45gZxP2VM9IC2
         t0H5mN+W3F5yG+jh1hQ5tEiDGCBZJSDtsKRvVzStKW4cXU7KtwopnafxLFJqbkHTesqb
         4duLCbmRel/JFiebJUGi0bcHPPcYzYiO1g66J5Sio5R+x9iM05YYvyTW15vutZwqq6nA
         eri2FN3Ms9Zi027gKbNXSXCyGcqQISQn/sX8JSjSnUHTJOtP3e9CM6tH5mbc1XhgjlQy
         ZX3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757063450; x=1757668250;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4qXDnbZXZ7ZGHEJeuNju+2jnsBVNxEVg6Jd0e4YiKfA=;
        b=DxxTC48OSSsCl8pkT/u4aJcO7WnkufV2PBDbT3VqfN0QhYTczcNAKbJTMUDu/pCp0f
         8pqVTEsFPh20RGKLTFauTVt6oCAMEUZVmGrfjNs+TUMd5xBNoYLrTwqbmxVNRPK3UBVX
         eKQ7TLcxtY8kC4iJSiYUTPhMlVWxYEALwZqPZ3SAGdoH4VCa4/tn6ZQawOvhwR3PN0ep
         NWkL0OKW3DRUdFzZQUJDKjxL7sucQGUj5qlM9JvEaQGjrpGTf80sw5ghW7mcV5vXh4WT
         kNhAjCq5cVi/5ff5YsFjb8wA/0W1xgHu0+aiGb7k3G6vGUzxCxPnwtvR8RuqJtiTwvaa
         2RWA==
X-Gm-Message-State: AOJu0YyxqXsP/k+tH/c9ciYamtZkd87GjiTJRymx0vTRb8VJK/kjQ1x9
	OKUjLhRo05wpOGYl1X9Zh57iLsu4fiVg+28NtyDt9QKi00rf8P+q7mGyWUx26BV4O02mgrx5uZk
	95CQelic=
X-Gm-Gg: ASbGncs0Va7ymtcPRhwdJD/vDxT/b6t7PwQeRnytOxLR9+20symCiRq6J26Neb+HCd1
	tyGrNIKB17fDF2n9vS8iHp7MaEKtW6ET8Qdwbm23g3qZQAvtqGPrsaSgzdqa3ZIAZ/lgQFr73c7
	xye6OsgxqECcpIhez63um8AXIDyQCkNJIlwUB2j4s/YabZke6cTOgfkv5urs5ZdcZ2EjXFWLxdy
	gE8FfKF2ZjnaBtmdPqJr+tXZ7bIa3YXOyvcuOghncYkpypSESJ35+eMZhFDZ42Fm9oS3JuoKjcc
	VMhZsX8XTrTwK+IESaXEYTAgiyOuO4HxDvyjhiLq1LaRXbFOwTUbmvET2UJaNpvXbTA38PkP5Jm
	HMWOgU+Kq5tUAY7BDRXFBj0186wVgPtdStIxWyUAbDlcaFZzob0bwIUPffA==
X-Google-Smtp-Source: AGHT+IGJKWfV6/Yh1Z/aQVrls/z/VbBEpNyOnSJSAtS1DRjFIfLVWd0Pz7fqNBaXooRuOl/rZxxyWg==
X-Received: by 2002:a05:6000:2211:b0:3e2:a287:2cf2 with SMTP id ffacd0b85a97d-3e30331bcebmr2465782f8f.23.1757063449746;
        Fri, 05 Sep 2025 02:10:49 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf270fc3fasm30302590f8f.5.2025.09.05.02.10.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 02:10:49 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH 1/1] tracing: replace use of system_wq with system_percpu_wq
Date: Fri,  5 Sep 2025 11:10:40 +0200
Message-ID: <20250905091040.109772-2-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250905091040.109772-1-marco.crivellari@suse.com>
References: <20250905091040.109772-1-marco.crivellari@suse.com>
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

system_wq is a per-CPU worqueue, yet nothing in its name tells about that
CPU affinity constraint, which is very often not required by users. Make
it clear by adding a system_percpu_wq.

queue_work() / queue_delayed_work() mod_delayed_work() will now use the
new per-cpu wq: whether the user still stick on the old name a warn will
be printed along a wq redirect to the new one.

This patch add the new system_percpu_wq except for mm, fs and net
subsystem, whom are handled in separated patches.

The old wq will be kept for a few release cylces.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 kernel/trace/trace_events_user.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index af42aaa3d172..3169182229ad 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -835,7 +835,7 @@ void user_event_mm_remove(struct task_struct *t)
 	 * so we use a work queue after call_rcu() to run within.
 	 */
 	INIT_RCU_WORK(&mm->put_rwork, delayed_user_event_mm_put);
-	queue_rcu_work(system_wq, &mm->put_rwork);
+	queue_rcu_work(system_percpu_wq, &mm->put_rwork);
 }
 
 void user_event_mm_dup(struct task_struct *t, struct user_event_mm *old_mm)
-- 
2.51.0


