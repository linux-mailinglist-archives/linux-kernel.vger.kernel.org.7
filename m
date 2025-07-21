Return-Path: <linux-kernel+bounces-739580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D321EB0C833
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 17:55:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 308057B0135
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 15:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6AA42E2672;
	Mon, 21 Jul 2025 15:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kZL4oX2L"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C942E093E
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 15:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753113110; cv=none; b=ee8fFQ8rUFaUfzfOTKZFDjNG0OqKrFEga9bnmC/fTFMwC8RTi4KgTPVMvORewtAIDExvpxOUCFKoxS8xdWrbiwNQLsxOic2ZsGftWi32USaeDyvAL29YvntcIQYiG4v6m1ZGHf0N6gAPzL750j3R4iOWoouYmV4x5JqjAYNdSKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753113110; c=relaxed/simple;
	bh=i72tUraiggqS8hxZp+hlGcogffzRQ0ePhgz+KAtSnBo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Wlz5i70z6nmilVmKOxPFcu8RkbSKgr2uTDhQk4M6zlKZqUQ3qNaZOQWNpCURiB46ImKpfrXctYEG9fjI20MqWygbn3gEdysgkBkZKYT9aCBQvPVSGda9Z1jM9Vts68mHghtdMpyvD4o0FHdbPd3GX8+JPSkh2MUZuiO0p5bFmXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kZL4oX2L; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4560cdf235cso22366435e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 08:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753113106; x=1753717906; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ET4kztpJf92MI8R2O27jT0Cu4Z/i82gSQbiDAj3o6ww=;
        b=kZL4oX2LieEInSKJ72ELxCTyQSxiUK4Ry3Bchkso7JPedav4OWonXyv2yej+SHEBld
         +vg07E2IeKWXRCpBFYH8aZBfK66EY/G/n6hyeODdYyECXkQCRq/SVjizR1Dj5xemgG8L
         qog1T7zw69dWiyDj8mxgbU+Dn2Fo7nQzA5nlrTvCzfU7AEax29bM22yXLytejHQPARdC
         FukRJ5r+s6wmISebAsEtn+O/fBkqPQClUDUS5fjGVsGIIC7lPeLC2TeMwgkupOsnSj6c
         03xTezlBtya27EgKTXFJo+SPWbzbj52l7kmYKh/HkHn733D2nGwQC1kMGxTUlfBNG+cl
         Q4zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753113106; x=1753717906;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ET4kztpJf92MI8R2O27jT0Cu4Z/i82gSQbiDAj3o6ww=;
        b=ircUGCUMrKir7MmTT/3BIO8eGTiBQX8oQVrVtkNzuRVT1VvWk+bAUGVcawXJHGoUAD
         EYsMbV8ru81l0i3prvaFrluEpwiV7IhcOlvc+jPTmTDQt/yRE3zS8jnqLS0LzuMilwHH
         sQw/wkaE+l+XqOk0ZcsYe/Obl6t9XKhno2HFVMn6HSMo2YFW0v2dDJdLpCR1m6jTNz0g
         gV+29Mek/dydSFBIhvlr3oLZItPTEWq1uHX0V9Qtqw2EVCGJzquNJ08UR8RRuo4Z3QY/
         wRRFeMqkiY4ynw32qrxG2cE0g23v8dCZOZhwW4DCavjSY8y/+Ozb9T/oCZNODZPYQaa3
         Z7jw==
X-Gm-Message-State: AOJu0YwQeppjaZXMgK+WrI3TKfNa5aJ9QXjKUUeQEP9wJUu6K7VneISW
	4/VUqMQC7c8M4Q/3/vyVTR/VT9ipGET5xTEiJ8yPbg3ZVi2ZyJreYw1Gl8X8pg==
X-Gm-Gg: ASbGnct2CUOPGPh+HETirzuGawdAOH1g+/oAUd16b7SzE0VyGqXj5qleynNqRr4t7ib
	esZx1acAiIug60lMzMEPi8XJEMlgQQZdBDEkuQxp6gccHtnP+J0tqw7pWnjSXjud3qkOvz7zPeY
	Ht91WTNKP6iAoLjt+T8xOo8NQnzXSx2BWnZHlPGVgeL7aTAr/8RJipGcYmmNhqt4wCuc5JcAZAq
	sENofrFxVvKRepvgqc3YliAy2+yog19rLFf5Pz3D+NG6xQ3yOFeM5N9BImKa8vIsQghnGnf2TPy
	sk3HZqrs/oZr6LQKeXEP0hAKcAGXokNL35tF52WJrmopuE45p2pgYIbyz6ZQeKD/HjpR9vyDhGM
	iiVMtPcGwM3cYIBdt/WddVA==
X-Google-Smtp-Source: AGHT+IHH5pUEEEPzu1eQ9Qung4cpc81HqNkmYj4/GRKYu2adW8qWPUvIzdXWgs8WELot44NaSq+z6g==
X-Received: by 2002:a05:600c:1e1a:b0:456:1c7c:73df with SMTP id 5b1f17b1804b1-45635345f49mr154704015e9.27.1753113105973;
        Mon, 21 Jul 2025 08:51:45 -0700 (PDT)
Received: from fedora ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4562e7f2e8csm164263795e9.5.2025.07.21.08.51.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 08:51:45 -0700 (PDT)
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
Subject: [PATCH] sched/core: use try_cmpxchg() in mm_cid_pcpu_unset()
Date: Mon, 21 Jul 2025 17:51:21 +0200
Message-ID: <20250721155142.9403-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.50.1
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
index 83e3aa917142..42006e8525c9 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3647,21 +3647,16 @@ static inline void mm_cid_put_lazy(struct task_struct *t)
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
+	/* Attempt transition from valid or lazy-put to unset. */
+	} while (!try_cmpxchg(&this_cpu_ptr(pcpu_cid)->cid, &cid, MM_CID_UNSET));
+
 	return cid;
 }
 
-- 
2.50.1


