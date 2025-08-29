Return-Path: <linux-kernel+bounces-791683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41307B3BA1A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 13:45:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE4F91CC0CEF
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 11:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6184A3148D0;
	Fri, 29 Aug 2025 11:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lXYPz+Ok"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D4E2D3725
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 11:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756467887; cv=none; b=PdoXMmnnIteVAjqUtRjds1Vl624ZDK0YN/j5ZmBhGhtV61rkQIJICMhVNuoJamT55BfhGP9P7uUotW1gTfbXr0O43Ng/ljy2ia/qoouMJFp+r+47tDi4elRzBc1c+9nWQY7NxC0b8SanyimaoxfNmO081FeLTteHWosaMkst59Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756467887; c=relaxed/simple;
	bh=y1oaiC2Vzo0cWINY8w/DPK8Tfo28TPudIZiSmEIyJUA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b0Hd8LYic+RX+Fu33Y3lIU96Qvm47M44au8gLLkC6lNzVdZpxqAg7Njua1BLJje/usEZs+oim0Qlp0e1cCgfhqT2OHdXdDCEoswo4pRdCC0sobkhRMhR8U0wwenthJq5rlE0DIKAQwTJJzRV9PvX5cGaozY7tm/1CXAULBizSzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lXYPz+Ok; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-55f44d5e6f8so2082488e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 04:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756467884; x=1757072684; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WFe1CktsVDIUFXMUlAWVFSXINqaL27dLXjci6lesYis=;
        b=lXYPz+OkK1n8/0iOvAWk1Z0lhuJwYFPM7rBuv7Qj4unNnW5Fdk+xGDzYF6NcJoD5gr
         18YZ6Nmpb+Nw0P7tAPAKE/+Aw7RX+SkVKC5JhZZljm563CBRZ0A2AYTSkyAniFSg0P9G
         +K0xDjxp5e4AJae36HAZwv5QxAzNlRqOwfIrqGWEhs5vVHuz/6WONW3dE4/ljJIe3CFt
         DQj5RThMvgdcvDUyoBXVsKJ/oouHkayEWlq6gkluoN7WdT7vLFJAk6fKmg2PHIwoUAxl
         oq18LNX0aGNXCrAQam0J2o77HXWpYxNju1tAaCK9n2F/QY/hcj87IufNlmrC46EyjW0I
         3D0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756467884; x=1757072684;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WFe1CktsVDIUFXMUlAWVFSXINqaL27dLXjci6lesYis=;
        b=vjJnjhFI4uL76dvZJmW08xnU00Q7qtL0azrODiIUFVQfXQrrIkMbkssapDklQUxK/G
         HZbWNzqYLGIPeQa8WDgFvv1V6H6Vliw4RwP0KIcep+mXsG/7Yr5T5G+Zw8lbSnWZ4fxO
         gsGtukpRGoOfllizCgHpudgeJW1S/f2v3e3Q/mRgUYT0W3HsnCRp4022IiXlkmSe7zKy
         T2d/y/05044SfLANoZvm7JwjjCjXZ1wEmXj/E5zzYiCt20jojikf+uMN+wnvnnvlnWY8
         dr2PCIIda8Vxt7fIt/LDwn/fSxSv0FLRwK+GBW/bgFCjrtU91/9WsqQISGgnhcfHH3eo
         Tk5g==
X-Gm-Message-State: AOJu0Yz+EDQ17CLWlcX5REkvcZQC7gK+rFN0u4pz5NvX/Ans8dRkJgyQ
	m5ZaVdJhorGLt/c/ai8YME8pSKEok7DT+cKa1KqjVxJqD555A6G4CYqJfqyu24h6x4o=
X-Gm-Gg: ASbGncvG7uR9yDbHpBvVm10Uw7lhAtLqtiuT+a6DJ+C4LCFqOQHOyNOOREz9MPHoScY
	Dbd0YOXqoRctCK9sX3ySPONeYdZpTLjzySY6hr6dVuydQVBU/3poeVjAEyHuJfGLAWN3+xVWILp
	+uYYd43QnsnsLKh9yOkfB2+gLpk9agEirg6bqIs4R3242OOepzVIOxNJSoNi9ea1+okqNUMDBe9
	dofzousfxaJh7GwjivXQa0nqb3A+SHR7AkRCUtD57DweOfmV55DAOREA0FU17asYPFvjjY8sVyk
	vjxBdKZQjYtQKNFO11TthQUYz0dT+CoDR+eOVPzLtXVRp2dxBKI/9Ke+zsEdF4UEWrTUn9h8Wye
	X5CVf3us/mId+xGC7fzot7Q5HTiMT4qhbLzYATyQXnKI=
X-Google-Smtp-Source: AGHT+IEkHsybnNaIxaBFEfVj1kIY3d3G3hiLCzbN2/ndqe/LdNG+/k5r6X74sVsHOJsMfoa47sH13w==
X-Received: by 2002:a05:6512:6703:b0:55f:449c:19e7 with SMTP id 2adb3069b0e04-55f449c217emr4969600e87.55.1756467883912;
        Fri, 29 Aug 2025 04:44:43 -0700 (PDT)
Received: from [192.168.1.140] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55f67a4c612sm581162e87.146.2025.08.29.04.44.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 04:44:43 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 29 Aug 2025 13:44:41 +0200
Subject: [PATCH 2/2] task_stack.h: Clean-up stack_not_used() implementation
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250829-fork-cleanups-for-dynstack-v1-2-3bbaadce1f00@linaro.org>
References: <20250829-fork-cleanups-for-dynstack-v1-0-3bbaadce1f00@linaro.org>
In-Reply-To: <20250829-fork-cleanups-for-dynstack-v1-0-3bbaadce1f00@linaro.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
 Juri Lelli <juri.lelli@redhat.com>, 
 Vincent Guittot <vincent.guittot@linaro.org>, 
 Dietmar Eggemann <dietmar.eggemann@arm.com>, 
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, 
 Kees Cook <kees@kernel.org>, David Hildenbrand <david@redhat.com>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.14.2

From: Pasha Tatashin <pasha.tatashin@soleen.com>

Inside the small stack_not_used() function there are several ifdefs for
stack growing-up vs. regular versions. Instead just implement this
function two times, one for growing-up and another regular.

Add comments like /* !CONFIG_DEBUG_STACK_USAGE */ to clarify what the
ifdefs are doing.

[linus.walleij@linaro.org: Rebased, function moved elsewhere in the kernel]
Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Link: https://lore.kernel.org/20240311164638.2015063-13-pasha.tatashin@soleen.com
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 kernel/exit.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/kernel/exit.c b/kernel/exit.c
index 343eb97543d568baeb23142edcc9050a8b8be8bf..9f74e8f1c431b6aa6e391ff71aadf9895a3857ae 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -780,24 +780,29 @@ static void exit_notify(struct task_struct *tsk, int group_dead)
 }
 
 #ifdef CONFIG_DEBUG_STACK_USAGE
+#ifdef CONFIG_STACK_GROWSUP
 unsigned long stack_not_used(struct task_struct *p)
 {
 	unsigned long *n = end_of_stack(p);
 
 	do {	/* Skip over canary */
-# ifdef CONFIG_STACK_GROWSUP
 		n--;
-# else
-		n++;
-# endif
 	} while (!*n);
 
-# ifdef CONFIG_STACK_GROWSUP
 	return (unsigned long)end_of_stack(p) - (unsigned long)n;
-# else
+}
+#else /* !CONFIG_STACK_GROWSUP */
+unsigned long stack_not_used(struct task_struct *p)
+{
+	unsigned long *n = end_of_stack(p);
+
+	do {	/* Skip over canary */
+		n++;
+	} while (!*n);
+
 	return (unsigned long)n - (unsigned long)end_of_stack(p);
-# endif
 }
+#endif /* CONFIG_STACK_GROWSUP */
 
 /* Count the maximum pages reached in kernel stacks */
 static inline void kstack_histogram(unsigned long used_stack)
@@ -856,9 +861,9 @@ static void check_stack_usage(void)
 	}
 	spin_unlock(&low_water_lock);
 }
-#else
+#else /* !CONFIG_DEBUG_STACK_USAGE */
 static inline void check_stack_usage(void) {}
-#endif
+#endif /* CONFIG_DEBUG_STACK_USAGE */
 
 static void synchronize_group_exit(struct task_struct *tsk, long code)
 {

-- 
2.50.1


