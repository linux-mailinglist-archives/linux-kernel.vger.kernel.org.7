Return-Path: <linux-kernel+bounces-836030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A4855BA897E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 11:24:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2A96189E150
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 09:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEDCC2D1913;
	Mon, 29 Sep 2025 09:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dWWrAnCb"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5662C3263
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 09:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759137759; cv=none; b=aQzbELc7S97QOGwpHFldnxaZNM3Bdw4CKV5xqW1hjBKS7ImuYf1MTXjp3IMnH/hR/TRJyOv7OWPL8+YMgVR8wopgenBn33HslbNXsdqpFPi29QKqM6vYtwdsb7E6+0x4VCSHDxwS7+YAgp/jiWH3dWzaU2jT+3um5nEtYZ3d504=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759137759; c=relaxed/simple;
	bh=EnaltF9AtPol8+QofD30sWxNSAUKa7XJAuOqdqgY8qw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t9fSkG11qd+MytxGUeb28dUnyvqbUtIZeN7S8PpsbH4n8K+IJemcVIHvekwzxukzcU51eIOo4KDcKSLydHLy88wF9H8trVQFHpOri/2HkvFMxroB3VXeVrZhHnHcsaklkvokvQrm2Psfptepb4BDPH6gLT3KPtmlWMh3g9ofrVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dWWrAnCb; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-62ecd3c21d3so8133102a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 02:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759137755; x=1759742555; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IbDFA1CgYTL7s/j1v3pYiRwiNX7dw5cHY213QrnT9E8=;
        b=dWWrAnCbdrn83H9NhgENygzTFvTjKLd3bgS1bqKZNRDJqV6COBKWb+2zl+TNic9HCn
         85qVlUDDigb0Onf6ZbTCz4GmD3T8h65xOBgZPqOg3T5i5vsYcA0K677OjN0x2W3PoR+F
         mC3QyrGcA1to9tDt2YYgqQj8L1jiFhM6jU0zTXoU5Mclqj0QD4Cqkg7nWleZx9hmm0MJ
         hRfV5UeHF7dwReSOgQeguXuQYxWDdqzfQtNMEqmSXXiFoyaVdlZS0nPynqSp91sywdul
         rkqdpS3B9Vnwcrr+tD8zMaNSUa3iNygITEUym5ovioOnNwadhvvvLvS0J8mku47jv0Pq
         N4Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759137755; x=1759742555;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IbDFA1CgYTL7s/j1v3pYiRwiNX7dw5cHY213QrnT9E8=;
        b=bWZ9HUEoTcSEvc4ijrpz9+JtbB7xQdbG1Xb6YHVep8g4v5eo0NNdWzsN1Rs82IdNB9
         v+jTjimPqsil81rmK5Byik0SvRep9JmUeJxBmmtA7kk/zAbtvlMi/J/5Rm4FZxJSntw+
         LVKB6H3+XFfwUVLDF3Aair/ulUmu0cfiEBhdiEJhPuWrJAh5ZELE29Nq2xvSOvAdE8Ky
         1WEVaD9G7FcCwB6TevWVR92zAaVjflJIjgs+KSWoTpsJLd39EldW+7YhmgYsAwEHmYkl
         wP9RzA3kqglnfJx13tntvLhhHHUaPej2OiBcg3yaSOiQTxZHMcFqQ5l33zZTKte+RJ0+
         LNNg==
X-Gm-Message-State: AOJu0Yyvjg7gAj8JyY96eAckcTERU5sHgY+1QVlsqnyk1m6kqtD0lLzY
	M56DU3G1duTnk6U/LLgPvGayKtshZUecGqSzLr7rr6wQEiLnNP0jHJb6
X-Gm-Gg: ASbGncsPB7TEhxqoCN7ViEEd/+AzEvIKCkCN484r3CXyXGQatFWOXPWAEkLFb1wf1sP
	2fgBq6UwrMdk6hBjVv5f2o8gbvIWLgZDqcSKAV9ncbyE2TfQqbF4bCYx38Fi9vGMQd25jlf+TiR
	qgRzOEU62R4rmlZb7DC/0hwZbfYdSxQlboXQ00WtgrcvAxcZpyc1CkNG9b2sEOY52KnuTfa6i2v
	7UdsyqtNzmlta01RdNphOxwU2ou6R575VnUYcrDxA2CVHpOdQ0GAYWbIA7LAd+gCdLbeUj/t3zR
	TJ/TV1A0dAsmRSQNSreYLbHgve9cR5gFDvrOx+7dlNKkD3vAJ5BJ2IyeSxdloTCbJXr7o3oRkUS
	2cJ5lsDsCRLq4xX6NUEVmCNlUuEc6hQ==
X-Google-Smtp-Source: AGHT+IG1uQtVtnlTg7TWyOjZ1NucFFoxqVtFaN2a1MQ5usOK/APy4aSpI67JS9HCp9tVhlbWACOOjg==
X-Received: by 2002:a17:907:9446:b0:b04:590a:a5b5 with SMTP id a640c23a62f3a-b34bb41a8f0mr1741222266b.24.1759137755344;
        Mon, 29 Sep 2025 02:22:35 -0700 (PDT)
Received: from victus-lab ([193.205.81.5])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b3e89655b09sm181082366b.77.2025.09.29.02.22.34
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
Subject: [RFC PATCH v3 16/24] sched/core: Cgroup v2 support
Date: Mon, 29 Sep 2025 11:22:13 +0200
Message-ID: <20250929092221.10947-17-yurand2000@gmail.com>
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

From: luca abeni <luca.abeni@santannapisa.it>

Make rt_runtime_us and rt_period_us virtual files accessible also to the cgroup
v2 controller, effectively enabling the RT_GROUP_SCHED mechanism to cgroups v2.

Signed-off-by: luca abeni <luca.abeni@santannapisa.it>
Signed-off-by: Yuri Andriaccio <yurand2000@gmail.com>
---
 kernel/sched/core.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 1217f714dd2..f6e9a4b22aa 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -10323,6 +10323,18 @@ static struct cftype cpu_files[] = {
 		.write = cpu_uclamp_max_write,
 	},
 #endif /* CONFIG_UCLAMP_TASK_GROUP */
+#ifdef CONFIG_RT_GROUP_SCHED
+	{
+		.name = "rt_runtime_us",
+		.read_s64 = cpu_rt_runtime_read,
+		.write_s64 = cpu_rt_runtime_write,
+	},
+	{
+		.name = "rt_period_us",
+		.read_u64 = cpu_rt_period_read_uint,
+		.write_u64 = cpu_rt_period_write_uint,
+	},
+#endif /* CONFIG_RT_GROUP_SCHED */
 	{ }	/* terminate */
 };
 
-- 
2.51.0


