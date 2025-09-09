Return-Path: <linux-kernel+bounces-807697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8DECB4A82B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 11:36:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 841203A370E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 09:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A47042D1913;
	Tue,  9 Sep 2025 09:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F1kUUruk"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076272D130C
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 09:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757409981; cv=none; b=skk8swTCMXuMVXW7kw5uw7XcuY3tPbWQlRGi4qoajknz/LypoqEUD8olTxPONZAuGmKcxo70U/P9yA7aIN9QCS7vddRNNdZ7LMVcZNex2vUI9YkjSSRdrdgddhh8+sGanHyH9+UJCYpOYNl+RyY9do8bCpGGzoxeuQba9/X/Ba4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757409981; c=relaxed/simple;
	bh=hIv0M1xI8frJxsikJ5DnOhEUO2kleaKFfsP8HrIZwSw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PF8GPYjwV3m22m/OqSjR/Ecom2bFDYqPuYSdi11ZoBj325EgVDPTaDmTrLwloAiUh/IDzNxl3Nn3HVtxcQEeCB598hPIRyg8g4rE18eCk1D/GGJ1ff3XH4ENAGAi+Y9LD108QlD0A9pgj5APmncQtHTxYWP9DLfq5XVzvi5OrrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F1kUUruk; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-45ddddbe31fso18266385e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 02:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757409978; x=1758014778; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4ZBpNNflTkMWuUHCsBPf2naE+qYZiwrT7qmaFKr9fdw=;
        b=F1kUUruklAMZIxcZr51n7oEC3UR5qZsVyCCqIbGXjeIkWQbcB6UO61SYsYELXUw9TA
         A+1FwJ1R/XJ/XszBYZ9Vl6DpCHWTwhFMwagIB4fWsyPtlDYfXbxxe1eFOa2Htx1EdvTI
         vqxvtMBz8c422Y+KjI74INowrdf+fXKP7ksRqVBBSgl0EG0Vty+7Iq3yrW4HsAHI36LG
         PVa1w729ZkQxh14qtbQ3WKl31+OYpNVXivwIoWNkqCITPUT4anO94o4nVf/SpMFa++SD
         vwMGCGFBG1CNYrRDnTa4JgksNQ11QNIZZ9mQVL3FTzTqSVmFYuA+Ad5PM6Lo9CgBgBru
         9Idw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757409978; x=1758014778;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4ZBpNNflTkMWuUHCsBPf2naE+qYZiwrT7qmaFKr9fdw=;
        b=ejz1b6w9+UPiz64eybtZAsqFdVUcJGOF18XcGrdGxj2uQQjN1pTOKarrcla17W+mvK
         3aetHWsqg5kBntUIs2Up19DQqZYag6nGMKOGygwWqQj7RMcuSs8ScmZag1T/PdlwVFLM
         KFhS9Y3HpnTeXQAroGkE1mnLAQj4vHpG8IfRbat29zgYlamjANt5lIn3vxnXMoC5JxbQ
         OPVOgj8PBB2VSfV6ZaT9jPONrjjcsunfAMT01BW45eX08RlOYE6EVnAs+W03fJeMR6Ur
         3EvEQefU+JaJTvPIO6tB/YL9ysbBuC0i/eES9Hwqv4DfyKo0lwkYGuKxMDsUAxeKQyoS
         es6g==
X-Gm-Message-State: AOJu0YxVMFlWGuDUFagYRk9FlQpOykFqqydShS7pe4cEhpKbMW6sKh3o
	4z8Eru1ZwqaWwsJInwZu4lQCBE2Q6YhCN4X5mnK1lQYHv3NUkvhgF3V6croivQ==
X-Gm-Gg: ASbGncsjtEk9SHcfbwb6JtigX/V4a/z3cfqeNc8+AyDPNOkaX+YHZ3CUpoVP/Z7zhQ9
	mGjPxF6T0+02D9b5FGiQsucuEqz2X2sdoR6zM5qAXt8q0Eu+s/7h3emECNlmQ6j2ohv6RyyPbxO
	S7KAb5OQ89vm3JgVZBqeeiysbycZd3JPwGRTSYjlMpO2iLxslJj62dziY8CemEI4hz2RDrTSl/P
	Z1VjAHz1b9rLEOQFeAhwKk3BmTRhyYuJe11p6pIWlZld+j0v3cWSwI/Ipi+uqO3K8Goc8MfTRqk
	bGvdotvfQFVXRjKq7fndlN9ubXQKyJ5J119vNrgHasBvJdrvMRddlmgD///3U8zep2drs3rmOi+
	+sWWrdDzimCF87ml+IMm5/TI=
X-Google-Smtp-Source: AGHT+IGWrx1bb2cUBMB5LIaILRjDOZfhZW+ZgLyibZtX8apgT8z/wC4Ly25gHnGwXQHSNQFe0S7lZA==
X-Received: by 2002:a05:600c:4fcd:b0:456:43c:dcdc with SMTP id 5b1f17b1804b1-45dddee3ae6mr106910395e9.33.1757409977589;
        Tue, 09 Sep 2025 02:26:17 -0700 (PDT)
Received: from fedora ([193.77.86.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45dd4affb6bsm196955685e9.1.2025.09.09.02.26.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 02:26:17 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>
Subject: [PATCH RESEND -tip] sched/core: use try_cmpxchg() in mm_cid_pcpu_unset()
Date: Tue,  9 Sep 2025 11:25:52 +0200
Message-ID: <20250909092606.1678763-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use try_cmpxchg() instead of cmpxchg (*ptr, old, new) == old in
mm_cid_pcpu_unset(). x86 CMPXCHG instruction returns success in
ZF flag, so this change saves a compare after cmpxchg.

Also, try_cmpxchg() implicitly assigns old *ptr value to "old" when
cmpxchg fails, enabling substantial source code simplifications.

The generated asm code improves from:

    d6cd:	eb 18                	jmp    d6e7 <...>
    d6cf:	65 48 8b 0d 00 00 00 	mov    %gs:0x0(%rip),%rcx
    d6d6:	00
    d6d7:	89 d0                	mov    %edx,%eax
    d6d9:	4c 01 c1             	add    %r8,%rcx
    d6dc:	f0 0f b1 71 08       	lock cmpxchg %esi,0x8(%rcx)
    d6e1:	39 c2                	cmp    %eax,%edx
    d6e3:	74 3a                	je     d71f <...>
    d6e5:	89 c2                	mov    %eax,%edx
    d6e7:	83 fa ff             	cmp    $0xffffffff,%edx
    d6ea:	75 e3                	jne    d6cf <...>
    d6ec:	48 c7 83 20 0a 00 00 	movq   $0xffffffffffffffff,0xa20(%rbx)
    d6f3:	ff ff ff ff
    ...
    d71f:	81 e2 ff ff ff 7f    	and    $0x7fffffff,%edx
    d725:	f0 48 0f b3 95 90 05 	lock btr %rdx,0x590(%rbp)
    d72c:	00 00
    d72e:	eb bc                	jmp    d6ec <...>

to a substatially more streamlined:

    d6cd:	83 f9 ff             	cmp    $0xffffffff,%ecx
    d6d0:	74 23                	je     d6f5 <...>
    d6d2:	65 48 8b 15 00 00 00 	mov    %gs:0x0(%rip),%rdx
    d6d9:	00
    d6da:	89 c8                	mov    %ecx,%eax
    d6dc:	4c 01 c2             	add    %r8,%rdx
    d6df:	f0 0f b1 72 08       	lock cmpxchg %esi,0x8(%rdx)
    d6e4:	75 42                	jne    d728 <...>
    d6e6:	81 e1 ff ff ff 7f    	and    $0x7fffffff,%ecx
    d6ec:	f0 48 0f b3 8d 90 05 	lock btr %rcx,0x590(%rbp)
    d6f3:	00 00
    d6f5:	48 c7 83 20 0a 00 00 	movq   $0xffffffffffffffff,0xa20(%rbx)
    d6fc:	ff ff ff ff
    ...
    d728:	89 c1                	mov    %eax,%ecx
    d72a:	eb a1                	jmp    d6cd <...>

No functional change intended.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ben Segall <bsegall@google.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Valentin Schneider <vschneid@redhat.com>
---
 kernel/sched/sched.h | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index b5367c514c14..d7f2cf458aa5 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3557,21 +3557,16 @@ static inline void mm_cid_put_lazy(struct task_struct *t)
 static inline int mm_cid_pcpu_unset(struct mm_struct *mm)
 {
 	struct mm_cid __percpu *pcpu_cid = mm->pcpu_cid;
-	int cid, res;
+	int cid;
 
 	lockdep_assert_irqs_disabled();
 	cid = __this_cpu_read(pcpu_cid->cid);
-	for (;;) {
+	do {
 		if (mm_cid_is_unset(cid))
 			return MM_CID_UNSET;
-		/*
-		 * Attempt transition from valid or lazy-put to unset.
-		 */
-		res = cmpxchg(&this_cpu_ptr(pcpu_cid)->cid, cid, MM_CID_UNSET);
-		if (res == cid)
-			break;
-		cid = res;
-	}
+		/* Attempt transition from valid or lazy-put to unset. */
+	} while (!try_cmpxchg(&this_cpu_ptr(pcpu_cid)->cid, &cid, MM_CID_UNSET));
+
 	return cid;
 }
 
-- 
2.51.0


