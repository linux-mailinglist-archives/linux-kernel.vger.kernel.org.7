Return-Path: <linux-kernel+bounces-847404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E126BBCAB9B
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 21:50:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EA6D4271CD
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 19:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF57E23956A;
	Thu,  9 Oct 2025 19:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Co8DfyaD"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7DA34BA59
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 19:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760039412; cv=none; b=spgV9RRWjVs8Bs1JLbtRvv6UpJingG7yL4WhhMJt1giQz43T6leYaFj9/JQxLO0rg26nUqO2vdm6EvP0Aa7/j2m5Qt91j6FRJzfXJE4HfGl7Zz0tSJE5Y1obOMixyByU5w6UEjqTuXkdE0PG/mf46TUsawgEvzWhU6dSkBkPbXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760039412; c=relaxed/simple;
	bh=9BfCnm4a+moAebm+lAc7x02KcpgIFNkL3C9Pe8qEqvU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=YW879mbESgneCA/TPV84VRN0LM2kUu+RXZPTD5TIUulL8Hl6ux7c8XcvPpXufc83Um8xcyOzRpcvH1v6vSuEDg0P711oFuH0OYlUlv7b2JpvsdXFWO8qduwvi+nt5gcuy4sJ63IZdHLRvz/O4/BTFfubqLBzTbLNAatQnDcMcOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Co8DfyaD; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-781010ff051so981622b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 12:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760039410; x=1760644210; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oV/72t5JsF8vgtfOY56WybM/wZVx/NKpczva6kumf/Q=;
        b=Co8DfyaDH8fJ6gMvAV1c5iozn7/SEQLfNcV5hw9Z2gmk3d22YcuHzzJI2CUpp+SZXg
         AJvbRNMl1jzVV2FjJQjh7L1CrLJzRzUw6NF/PsvbPJoiP3RdHE/RAHeyuk5Rt9BJSD8t
         DZT7BUl+fzPu4xneBUse0meprmvBErQmVa0LsRPHfWAamznPZbv3lS49CvythHgzIaHf
         KZbHMBiTqekkZ+dmcWnqf0vu5Aq+NZGRBzuiQp2UGD5zd3TBpAVpqvZj2OyyITTC23Wr
         uCwYMHXDRE6Pju+kGttk0lzoIuVNDDLl8JAviH3Cznl/KYIm6MrvPmqLzk9nERWmMgEI
         /HVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760039410; x=1760644210;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oV/72t5JsF8vgtfOY56WybM/wZVx/NKpczva6kumf/Q=;
        b=aeMkieAoQ6CLCLRPQSfaHeNZNACurbSO0GXk8JbUbTAqS3eJGRB9AUsdNWxEDgMKXd
         YKQIgvo1dlO3VvWrMOV1uYwQJVVpF35By/GUOHKrZpjz+vj2JC+lofhUhQAy573XjW9I
         9doqCRM+27Q2Xl+1+JbT8YlbguBLUlAn0XoZ/CiGUxJM5CbwDU4jtUj1H1fE8LMqKam4
         t5XH9ea/UiwOjCZvHSnvMXMDW3qg3vzWwfV/zGYUG2wZi3RdcVy7JCqJiR94Oic8KcBM
         8yQgO+Slvusis70YcfmuHsoR6Hqu3YfvxcayzVOAdMp2S72XPCDJb0mWcpB1HqntYMNN
         KTZg==
X-Gm-Message-State: AOJu0Ywb7Yyeb4AF9Dy4fjGb8NOVW2ojBKHMptcM47sw9gwMMHEyY+LR
	AvSIxsGhztq5eFX09gJwC2GWlLtEG/hh6FyHVMvPzErVusRv9E4PLXt/
X-Gm-Gg: ASbGncvbEIA2hLMGgzjuWlOJao0kS3q5Z2kTXKtYLNncJrsACqeZ6JrS34Wi22whkSi
	/3z0hKCpyhuPVdYjADkGkxAntNnmQcRjDCQixddCRWxlfktgxAov94Dy2c+CVZnOY21QCAgiKZ/
	l9O+V5kNr7hYszwOcCJaZqO7TwsrWJOT3sv3KXGUr5nwbwTySNLXidXidwl59Eplu0hkTy0Q37V
	tsXHBkut19km9R5YvsGXrcaWIxQZlAMenGgDWCtxFRjGyjIOh9flUgqut3iFwaiwk+t2jKmhlXF
	fJWfynwV8wO6imNu/hUSdvAO9/dUdb3Rj8Cm4yyjhJnwwyn0uA4h5E8Bqx9Fz52IbfNzMV5cGW/
	Nh6eCuLy4NBLrq6LTPwe+YbLsgCiDKQoObwM1s6nfBotIyZl/wAOiBaStsThMBBlQaR/ZSfG1pp
	QxfEBDLzoRbauzyFUXGE8Em8TxGvLIKzqIqz3Ki0CBhrFOSdHQoA==
X-Google-Smtp-Source: AGHT+IHYP8yFcv3/aAFZRBWO1rioFqkTqMO6uY+GyEZq93qSUwsRGOyGVCMjOaxaIHSa/BDjQu+nfg==
X-Received: by 2002:a05:6a00:179b:b0:782:2b62:8188 with SMTP id d2e1a72fcca58-79387242eeemr11556232b3a.15.1760039409826;
        Thu, 09 Oct 2025 12:50:09 -0700 (PDT)
Received: from crl-3.node2.local ([125.63.65.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992b065ac2sm562212b3a.16.2025.10.09.12.50.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 12:50:09 -0700 (PDT)
From: Kriish Sharma <kriish.sharma2006@gmail.com>
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
	david.hunter.linux@gmail.com,
	skhan@linuxfoundation.org,
	Kriish Sharma <kriish.sharma2006@gmail.com>
Subject: [PATCH] sched: remove unused cpumask variable in mm_cid_get()
Date: Thu,  9 Oct 2025 19:48:18 +0000
Message-Id: <20251009194818.1587650-1-kriish.sharma2006@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The variable 'cpumask' in mm_cid_get() was assigned but never used,
causing the following build error with -Werror:

kernel/sched/sched.h: In function ‘mm_cid_get’:
kernel/sched/sched.h:3743:25: error: variable ‘cpumask’ set but not used [-Werror=unused-but-set-variable]
 3743 |         struct cpumask *cpumask;
      |                         ^~~~~~~

Removing the unused variable allows the kernel to compile without errors.

Signed-off-by: Kriish Sharma <kriish.sharma2006@gmail.com>
---
 kernel/sched/sched.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 1f5d07067f60..361f9101cef9 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3740,11 +3740,9 @@ static inline int mm_cid_get(struct rq *rq, struct task_struct *t,
 			     struct mm_struct *mm)
 {
 	struct mm_cid __percpu *pcpu_cid = mm->pcpu_cid;
-	struct cpumask *cpumask;
 	int cid;
 
 	lockdep_assert_rq_held(rq);
-	cpumask = mm_cidmask(mm);
 	cid = __this_cpu_read(pcpu_cid->cid);
 	if (mm_cid_is_valid(cid)) {
 		mm_cid_snapshot_time(rq, mm);
-- 
2.34.1


