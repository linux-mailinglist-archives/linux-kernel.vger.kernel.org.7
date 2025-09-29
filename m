Return-Path: <linux-kernel+bounces-836031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A06ABA8984
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 11:25:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E62643C2EF7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 09:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1D082D23A8;
	Mon, 29 Sep 2025 09:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YV5XOHCQ"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D671E2D0601
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 09:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759137759; cv=none; b=gXT7GfLytv4gopaYl9nIKbS0tbjTNHLrwGLtla5IFPFYjWARe/t+vDSoTJFQ6b8TwU3nj3sbiM4cVADbt+iCBtEuoVZj0cTRdULEceioeYSVpiXrZZUrHQhkbvknXygNG/cGM8n3/JHdZIvF+UuQgdnrORTxKFgh1kEy+wZ3BIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759137759; c=relaxed/simple;
	bh=AqMfnXGDJbqgHWw3glDpocUaBJ6+Dpq8ZPGwXRgKweg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LrtKhPvi2YrZry2AtJhLA/WBD7A7oJlpf+l7tgs55otr7BLl/pmOBFR3TL+Mr7DnzfGz1OvsfnI+/exmh0e+xoxyPBOjyr6LvvClCzkFcpQP8bW+0mRlQA3h3CtA1i7YJYa5nFZDbybQUpbq1j8p2Rd0KbMTISIokFCxJwyx1Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YV5XOHCQ; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-afcb78ead12so758001966b.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 02:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759137756; x=1759742556; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=emBg48566aQmdaDJEGloD7DA0LLiiyLE4SYZ2DkK16w=;
        b=YV5XOHCQWytZsEutChQ1+GxVOeRdY+Sq++FgIi9qFqkyXwMh1qcWhfYmTu5qElKG9I
         96n3CGC1NZZo+DrAh34pTMPBMp4YKVEe9lufCBOYarDcgOX4G2Kt44hSojhOktE495M3
         5vWbADouTRWXwJ3fnG86cjXta5fdRpWEkVjq4VTlsH/wS6MbKHNbECFFaAt+YFVE4x/f
         GhT3xBEQmyXKttjOUuyBALcMOjcGATct3kvfNIpNVNp0CP7deRIcZ4rkosCpPRjP6UfN
         BLR9u/t5bhqbBSNR0uIYoaXmS8QUu3DhtEwwOS/kKE0EULLIO+GOh7muD7FQ3Q+dH1hy
         47pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759137756; x=1759742556;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=emBg48566aQmdaDJEGloD7DA0LLiiyLE4SYZ2DkK16w=;
        b=VjaSEjqPtnImoJhpegSKZ15UXEFCFy/4AeZkZ7CqIrTfYjGPTO0HzlGT774GOZIp+x
         HbEO+5l2nuIsXks6m7z2OkL/gdRoZzcjjQQXLEQMZwZNdKQH2t9WqhyxJiy8E+P428Rn
         4XQ8xWGhkl0LFs/6eTGZuKPLeYw5gyqBBbqz4VYFHCWZt3Bwc3g2+LyCi/B4uBYYXyaG
         TwZoAZDufmAw6QLvbVSofeLFQSaYWDzHRKG4h4Wb6C9Mq7kVURqS0KDMEvhmv0YGSRbI
         2nOkUSSvymCJ7KZiCmZCUkD9pZMkPqdTZYvzP+F1f4tJu1Gpa6U5nfNaH5U8wyX+KVWm
         EtGQ==
X-Gm-Message-State: AOJu0YzPD7Tw0mHD2w7ksnbTvMoRfvLLVr321QLiHDpNvoHczx9tiUak
	ZL7I64oE5WCfpJ35XkyhdIJ5vxtTN+dXzjV5GyJ3j3vaUYlEg4iGO8kS
X-Gm-Gg: ASbGncsAfH1oe6Iq8Px2m8VKYhHCUfsKYmJ7r/A+XebyQ19OTbOAFUZ0ZmlDDdd8vuq
	bwQNr6sIF+VYlxYEUEAvUn7QE8wvkdAtNpQ2TNFgx7U7RTyfpJG9EsyS9aLEv6VqspvXEiZ8dAw
	WNMQW6/8EQn0V5ZMucZDZNCstjf681aYSiMQj8oye/RUg1DejzjMQ2cLOJeyCuKY8DXip1sq8QN
	XPgmJcf5OYSmVI6novRHt8vuXGkGh8M+az8jR1YlDRft6s5HICi7fTrvxBjsEiOpwSE/8TiGnLU
	3v8LoN3evRz0mVCMqYTZppg9MgEMY+gaXGxygU47l2GkLp7uacMNhGhIfnbJQLkbe8eAlqMXw4H
	bMQXQK9NXujbU8Jhxbv8=
X-Google-Smtp-Source: AGHT+IESrnCuYjxXCfrzeWo9ElJeqYwTyvvLe3b45Jp4EisnHBLUFA2Jl5eU7/ETkdStyckFGEcYzg==
X-Received: by 2002:a17:907:9713:b0:b40:cfe9:ed2c with SMTP id a640c23a62f3a-b40cfe9f8e1mr55983366b.64.1759137756096;
        Mon, 29 Sep 2025 02:22:36 -0700 (PDT)
Received: from victus-lab ([193.205.81.5])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b3e89655b09sm181082366b.77.2025.09.29.02.22.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 02:22:35 -0700 (PDT)
From: Yuri Andriaccio <yurand2000@gmail.com>
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
	Luca Abeni <luca.abeni@santannapisa.it>,
	Yuri Andriaccio <yuri.andriaccio@santannapisa.it>
Subject: [RFC PATCH v3 17/24] sched/rt: Remove support for cgroups-v1
Date: Mon, 29 Sep 2025 11:22:14 +0200
Message-ID: <20250929092221.10947-18-yurand2000@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250929092221.10947-1-yurand2000@gmail.com>
References: <20250929092221.10947-1-yurand2000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Disable control files for cgroups-v1, and allow only cgroups-v2. This should
simplify maintaining the code, also because cgroups-v1 are deprecated.

Set the default rt-cgroups runtime to zero, otherwise a cgroup-v1 kernel will
not be able to start SCHED_DEADLINE tasks. The bandwidth for rt-cgroups must
then be manually assigned after the kernel boots.

Signed-off-by: Yuri Andriaccio <yurand2000@gmail.com>
---
 kernel/sched/core.c | 20 +-------------------
 1 file changed, 1 insertion(+), 19 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index f6e9a4b22aa..6f516cdc7bb 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8723,7 +8723,7 @@ void __init sched_init(void)
 
 #ifdef CONFIG_RT_GROUP_SCHED
 	init_dl_bandwidth(&root_task_group.dl_bandwidth,
-			global_rt_period(), global_rt_runtime());
+			global_rt_period(), 0);
 #endif /* CONFIG_RT_GROUP_SCHED */
 
 #ifdef CONFIG_CGROUP_SCHED
@@ -10062,20 +10062,6 @@ static struct cftype cpu_legacy_files[] = {
 };
 
 #ifdef CONFIG_RT_GROUP_SCHED
-static struct cftype rt_group_files[] = {
-	{
-		.name = "rt_runtime_us",
-		.read_s64 = cpu_rt_runtime_read,
-		.write_s64 = cpu_rt_runtime_write,
-	},
-	{
-		.name = "rt_period_us",
-		.read_u64 = cpu_rt_period_read_uint,
-		.write_u64 = cpu_rt_period_write_uint,
-	},
-	{ }	/* Terminate */
-};
-
 # ifdef CONFIG_RT_GROUP_SCHED_DEFAULT_DISABLED
 DEFINE_STATIC_KEY_FALSE(rt_group_sched);
 # else
@@ -10101,10 +10087,6 @@ __setup("rt_group_sched=", setup_rt_group_sched);
 
 static int __init cpu_rt_group_init(void)
 {
-	if (!rt_group_sched_enabled())
-		return 0;
-
-	WARN_ON(cgroup_add_legacy_cftypes(&cpu_cgrp_subsys, rt_group_files));
 	return 0;
 }
 subsys_initcall(cpu_rt_group_init);
-- 
2.51.0


