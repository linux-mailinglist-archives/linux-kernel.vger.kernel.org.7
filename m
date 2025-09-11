Return-Path: <linux-kernel+bounces-812824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69378B53D27
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 22:31:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19A4D4829F5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 20:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4B6D2C11E0;
	Thu, 11 Sep 2025 20:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V09YLcUB"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5632586EA
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 20:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757622703; cv=none; b=TgNEc6Vh5XK0uPUDAZE8Fs5dKv+kueF9yAGOV+ezK5oi6CipLb7bkyaXA3/R0YcNNpDAm2GFVSMXXbacJ8GkLG+qiRsivkv9IpQHOzBY7hQQ1tgvf8LYnb5MlVBfC98kK4xZwdlJ2CVmH3PBvktppDAvEm+VIk45OJE6nPJd8zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757622703; c=relaxed/simple;
	bh=QAOcpgsDTIrakjhcAz9Fm6/sUXE1iT7NZtcsllMJ1FQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fFnXPhR7hE3jjc1/CFCIW9uxPprh+ec+HlXKTNDh8Tzoj9pF81O2yKQ9WWhWwWCUTOJLErl9N54/TmwXAJXJ/WQ6VBZ9BSqkNaeHKUGipRPqCDtD20rQETlUPRVgd0gUuDRHhryW1pm04mmPpmHF6DZzVac46Rd9KuBHX35Y330=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V09YLcUB; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-77264a94031so923308b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 13:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757622701; x=1758227501; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=B7slzYj6sPwHji932dlNIFHOH+RmGYmiaFHFT6XYYXY=;
        b=V09YLcUBz2MgPIUbAyosiqL+HKDHQaTeO5QfNMHMmO83NgDcuPhzCWSBFs+6c0YQcM
         ASdGeFRPUxDU07rB44+nGqjoA5CJhzgwvEFNaDDAWsOygRAI0I2OXHBtSTi6vPVcph2d
         jdhPBUhkPk4TU+UBDuIJnUdgDBaWXnzcd+agi1Bgyq3VXkIt8LesmI0aGnAoCU2mP8fa
         TuXcYJm/THeNqhlMVsgkx8xrPw30XzniLrCWMqsS8oaC62BxFB3N9g8wPmL0grGpJwps
         o6/aKFHpXRnL8FK3LoXBApBSQZfrj64EIEq59QUKmMl8T4lPZ5NT1vH8ITHqrJ97wXY7
         zIhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757622701; x=1758227501;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B7slzYj6sPwHji932dlNIFHOH+RmGYmiaFHFT6XYYXY=;
        b=Y8ys46Phq4pgLwl2e/moSx9+C5bOZqes7MkTT+84IuMjNVAO8aYsrVJNjVQ83pENHY
         d0dtVcUf0cplNWmzXQ+0KXe5edFpu+bBdt7uP2kts7of/H5EUOuR1nmi1qLSiHDys1vX
         p/uKj1orVOFNyWYaoJUQfbwK1eFV1vFqKE6UqVmqQ6DxsClwLnZyfuAbKUVuTrT5EHhp
         PWL3yqgiGpI0zhquNWpuEJhLPfHTkpspsGoMLOyid4bzjf07k6n1J/K6v16lv+Q9swr7
         NOcjT5bjWFqanmFaOIJ5m7rAJgOKLL6XGNuUscT6yn93MWU/NpC3a+9lo9UQbvl+nDlY
         Lizg==
X-Forwarded-Encrypted: i=1; AJvYcCVtpgCWIKYLNHkb0MAOHv11kbG2SwMig6yRmgSQQO2d4UotrSUL8pnreO0QW2SJ8w9QF1XWmOxKyKfb9Tk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSb0r0sjY/m0XZSGYjusQojJ7rCbxj9PyFgq7UJsa5YhZxb7yt
	PLAqsNo/Y2G8dhF3wAaC5Dl9/Ks41RxNBf5WQgL+XRJQamGixBo+DLd0
X-Gm-Gg: ASbGncv4YHcOfUNvuzwWcqa21Jujwh+PrR/B7f08zZqe5iRHXxcz5y/wefABAl4hohY
	mG+Mzn+gbL3U/LhgCkLGa3Q9XecPhaWzvdFD6ix/+n3RQn9SmdeBZCflEME09IRN4HYJZXvCB7P
	LkCoBIwqrhS5kB6nS7fDXnuZZXqoDILDVNBkuRXJDLcpdSGxSKST8hGgCdyajT53P7SDGFuPf9m
	/XwqI7oLOxv9uAxxWySl3opQ6HMYBzp1jqBSYOomEVKZm1COGT829a7H2QY3RAZqVTec+xi8x8x
	GOfnyQmRkZTPfmJsq11wdn0pfbSFi0JqwSnJkxlskbwNeP99XU8DhdXIt++i2EznqHf5kaoINNn
	FUJn4jUjriJO3m4p4T01pt5S6rOdqfMC3
X-Google-Smtp-Source: AGHT+IEofGd78b9bpcQ8Ju1UfNhpww6hFcCY9tpj/dOas9AmTvOSvMV8WrE9RJVi9uuFmkK8XZx9TA==
X-Received: by 2002:a05:6a21:6d9e:b0:254:b352:6479 with SMTP id adf61e73a8af0-2602c14ca72mr678614637.32.1757622701052;
        Thu, 11 Sep 2025 13:31:41 -0700 (PDT)
Received: from localhost ([216.228.125.130])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77607c4744fsm3039342b3a.97.2025.09.11.13.31.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 13:31:40 -0700 (PDT)
From: Yury Norov <yury.norov@gmail.com>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org
Cc: Yury Norov <yury.norov@gmail.com>
Subject: [PATCH] sched/fair: simplify task_numa_find_cpu()
Date: Thu, 11 Sep 2025 16:31:35 -0400
Message-ID: <20250911203136.548844-1-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yury Norov (NVIDIA) <yury.norov@gmail.com>

Use for_each_cpu_and() and drop some housekeeping code.

Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
---
 kernel/sched/fair.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 0990ed90c14e..c48c0975fe7a 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -2474,11 +2474,8 @@ static void task_numa_find_cpu(struct task_numa_env *env,
 		maymove = !load_too_imbalanced(src_load, dst_load, env);
 	}
 
-	for_each_cpu(cpu, cpumask_of_node(env->dst_nid)) {
-		/* Skip this CPU if the source task cannot migrate */
-		if (!cpumask_test_cpu(cpu, env->p->cpus_ptr))
-			continue;
-
+	/* Skip CPUs if the source task cannot migrate */
+	for_each_cpu_and(cpu, cpumask_of_node(env->dst_nid), env->p->cpus_ptr) {
 		env->dst_cpu = cpu;
 		if (task_numa_compare(env, taskimp, groupimp, maymove))
 			break;
-- 
2.43.0


