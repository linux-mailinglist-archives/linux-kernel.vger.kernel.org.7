Return-Path: <linux-kernel+bounces-840168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13029BB3BB3
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 13:23:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAEB5192203D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 11:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69A7730F95F;
	Thu,  2 Oct 2025 11:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S2HQKpGC"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1501514DC
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 11:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759404194; cv=none; b=BhUq9+QfGTaRqAzM1/b3CqWahZVtuNaA9oHbBALANfpHnD08BHpVzErbf0zMJgjxrpDiAd2eAoCj2Hf8bst0bnzxI003yIdkqdfO55yEPZgIcQgGUaalH92ZNAF4puufOgt4+Xjg9xuy2mDEKO77ejhR3B4zMvMFkpZB931B2RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759404194; c=relaxed/simple;
	bh=g0JqBFU+aI1DuR3MahsXhe8n27CY4SXvqQcJv1zRNE0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=lVYiMhmYa4/YC25YIECJ7+sFvKSd11OJRGG1bzXima/Scvc9kuggM3hAdU2CusoHHmk5Fqgo2S2LT5o1UghVswbyvBMsmPz6gtQu9F4QdcUuTuO3Kr3HO0TEHFnQNARZ6DSUw10CVE4gMUqEEWCFp4tJVPH6lGxnqcaGYqZBTOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=S2HQKpGC; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-62ec5f750f7so1508266a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 04:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759404191; x=1760008991; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q+qExz1iDL/zHM7dQuda52j6jlNU91jk5J/AIYGBpJg=;
        b=S2HQKpGC5OKsdT7jcFMuMCQ94N1zmI4ZWfV0a4M/lJS6OFPO1KUFlpaoQ3sbROLaFv
         5ne61NdnZDl8L/rDfy6o1W8pLD88SttnVQvfqzQNWUeNYCFzhGjYao0b1mgNYTJ/UutX
         g/rAHErQbUWbm4DoSzakvj0WaiVEPPvg0/IlvI4ajd98d52ftMx+/qZYLJAlFkW2u9i3
         br0VrJwJwNsH/JobzkOS7rCYqwt9n8u3rqx8ymADLktLwXE5BTac7lk7rzMLMjQE3vg2
         rXfICnk8YEVwPOe+BaD24/xlNQ/jwY5BYcaHOzHrt/YZghARNpXoh51cr6IYbue2G+rM
         hVHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759404191; x=1760008991;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q+qExz1iDL/zHM7dQuda52j6jlNU91jk5J/AIYGBpJg=;
        b=UdHj/8DoVvE7Nt3VY9sVlf0ZGEcuh0eeN979g2M01IZtDCAWazK0kJKufMW41fAqwH
         uX19FbYcOzEwrECZkHhduOQPxFjHVtVgpYIHgmjVOV3+XSK7xqXy7okZ456bT99vmxmk
         LD6ZE3ovzN8+zTOZ9RxMhHxZuW8YJgu+CRgrLsUeUfPkDeW4vF2hXzFHtMsiHRp0JgCZ
         rvN8RSxiYV26V7regy+4YYIP2T+jtw/tHOcQalaC0lfx6HFQ/qbIjF00KDcYulb9/fgx
         YGgezsKa/kgHJguXRL56d5l27KNNB+AIlOJ/WAts6laQcKElcSgm0G1lZ1DwsKs/xpgJ
         8B/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUgAykCvAdU3KVsQTrN+tDQe9Kf9lwC1Nu8ESrKnOIOfYZPeyRdDHEL5rMnUH4UAH+Avure9cOsySOQJiU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8sguJPuNHgleXzn5Oj7gZWapCgvaV3uL4gsqeEDdQplqIokP8
	x/s1qRYusQUFxthdoml1Valt8NBSNlF5GkHBsJfvIHTklHZM8WbjGLRf2EaG3mBXQa4=
X-Gm-Gg: ASbGncsL4eBuFZ1xHRTKIM+aMxgR7lzFNT63LVdC5VQvrhgJwhSmlD2fJxgJ3FQnqNw
	coQ3y3oaxNIYtIRibQrXPyVL2AYzuZt3RoTxfvVDNP+Ms97PysYrFHPR08VF3JPsb3epixGWb01
	DMl9awIuqSvkn87Za7jfqstlNutI5KXH8Pq/StgAMBYNuIIqH6sJkjsfMMVepzPrUjLlLM0KJf3
	0CWOwxS/r35p/TciRowV1suVviaIkWwqjwG2kPfdQF3eU7JYMHLUmWfN5okOEZjddCfC+tC4Pgc
	Gmx6Jabmd4/V09hOC+GyojD6dvgH+4Z9hnny5WKQDfuYLY2d9/FSceZMXhSH60TXXRrMzMPZFSg
	jQdE3lc9skavCuGulNAwunBt4OrfzYXUa6N97nAsRXzKAg7xUYo+Z0xiip2BHCCiEyYUzbZ2kcJ
	CDXTWhjLNt8GznkSX3CKRthyaC+wjJh3kwjHU46SEK
X-Google-Smtp-Source: AGHT+IF0KpMJxDkR+B3f5xm67kWvcngwUxa8652cNaK2Q75GXB5H1G7Z5G90QRy2+STidfp5MernIg==
X-Received: by 2002:a05:6402:2808:b0:632:33cf:1b2e with SMTP id 4fb4d7f45d1cf-63678bc8554mr8420247a12.16.1759404191018;
        Thu, 02 Oct 2025 04:23:11 -0700 (PDT)
Received: from puffmais2.c.googlers.com (224.138.204.35.bc.googleusercontent.com. [35.204.138.224])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6376b3ab4b0sm1676098a12.5.2025.10.02.04.23.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 04:23:10 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Thu, 02 Oct 2025 12:23:09 +0100
Subject: [PATCH] sched: drop unused variable cpumask in mm_cid_get()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251002-sched-w1-v1-1-a6fdf549d179@linaro.org>
X-B4-Tracking: v=1; b=H4sIAJxg3mgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDAwMj3eLkjNQU3XJD3WQT02QjC5NUQ3NzUyWg8oKi1LTMCrBR0bG1tQD
 UexCtWgAAAA==
X-Change-ID: 20251002-sched-w1-c45c284e1775
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
 Juri Lelli <juri.lelli@redhat.com>, 
 Vincent Guittot <vincent.guittot@linaro.org>, 
 Dietmar Eggemann <dietmar.eggemann@arm.com>, 
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.14.2

When compiling with W=1, we get the following warning:

In file included from kernel/sched/rq-offsets.c:5:
kernel/sched/sched.h:3743:18: error: variable 'cpumask' set but not used [-Werror,-Wunused-but-set-variable]
 3743 |         struct cpumask *cpumask;
      |                         ^
1 error generated.

Simply drop the variable.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 kernel/sched/sched.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 1f5d07067f60a3195c11b0bfe203e027ebc3e3c5..361f9101cef97cde2b4cae963c3eed6e745283c8 100644
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

---
base-commit: 3b9b1f8df454caa453c7fb07689064edb2eda90a
change-id: 20251002-sched-w1-c45c284e1775

Best regards,
-- 
André Draszik <andre.draszik@linaro.org>


