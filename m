Return-Path: <linux-kernel+bounces-751965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9A90B16FEA
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 12:56:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 256F916B70F
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 10:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C46532BF001;
	Thu, 31 Jul 2025 10:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jJsVUMqo"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA462BE7B5
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 10:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753959354; cv=none; b=j7VwJqpdPQyozacSU4g5hO1Bk0ZVfOV8UF1J08zD2CEOa/8vDzjF504Bx9x3CN+Y7H/vR4CoqBO3FI/GV7uEHdIkglZVs2O18zeudLUaelX0N00c0b8aeeWhONVPXtsObQMT3+/8Ti37TAltTvHXNoEu9+y1igHXquXbaFD3mT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753959354; c=relaxed/simple;
	bh=2nNH86zTsg7R2fmNZl123xTHKQk9SLRGN74jQT1JzLs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nGs/YCGJBwRmJdlatBGZ8x/7f/n9GSC5XMPskDzgOqpoeKwILk1ZTTn0YReXMxzbPw57YSFbqRQmKvp/sOQU1A2UdrHMRwLpNhs++VVfDetQzX+m/qDS20s1rlgNdG0cpjMlWTk5JFFBRo8MYXFWgU70fCN6pWMeTP7Q3o5CnVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jJsVUMqo; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3b79bddd604so211518f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 03:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753959350; x=1754564150; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L0kWGTgavAow+H+0yQxg8Ps6erJvXQE/DQ1ARn7035s=;
        b=jJsVUMqoJwjxZameiwcj3IYs99SiWiChMMUg1vYTQKGIdJmBQJOnnRROhghR/D75sk
         bRHfPobIMwnbKV3b6QVV/bJyy5cpsA/xGSrDXnPeu/VrMyTM3RpXz9QlXS0PeU9BJjmQ
         4Fu30TC7C08+GnWvVzhdKXeZ3uNo3Cbbfl62ztvANdk6hvWrH1QGBpZVjxKknHoRtHDM
         DqnQdZG5osBiENIkIDYTKINbvsbGnaF8T/HzOs0u0pBmfwYvmRGxxwZ6QOPSemAM8Ysv
         ks7MDz+fmXpYn14i1pV4cwR6intNlUY/jQXin2GVmNmeE550e79ycVDXf00I5bZDcbrh
         9uJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753959350; x=1754564150;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L0kWGTgavAow+H+0yQxg8Ps6erJvXQE/DQ1ARn7035s=;
        b=mUIkSgt9qSGlsW50yJPhICEk+raeiwmbGi47/BJ8s9Wi2xyQIUrYYFZp5patm9o3oZ
         wV3smQAMTKmNxyKBpQs8sR3K0r6un1OoFyN14IOvsycrfnf/aJslfR9y3d1/rM/EtLgl
         kwXgMsla6tJdD8Rr5YTIuYSOcq1XqzcghlzdmpvhniYQ63RQMgDYJvxotD5FzA+Pb4Ec
         Lv3fBI64dTjUkIbjs81BhkyqjT59suuFYa9tcD825PLB91qOP2b6/yFHvCmSZ1Th4mqL
         X5h3a3vLFoP4KZ2y2u8yKewTR3cA5SIZ+eFJxEEKyE4iEwnOXClQASJg5KJzgIOy5rWe
         lQFA==
X-Gm-Message-State: AOJu0YxwieaL1kACxu5e0zQUtMxoHe4/07mvEcXHKwxSzBn9GpbWLsy9
	ZidxJ31IVb6V/jSwb2B+simDZOfOi/zu2HGnffTxVO+vh+hsGA9jxr0R
X-Gm-Gg: ASbGncvbqtHimHbLQ7fvKanp/95sjw1yLNphBehggLaiWLLMk20dOoNNK8FXQJntHIp
	sjLwozvx9EVF9jwpokPRF7v2SCQHUGy1pkzMg+YrT33Vucgn6GZYs7MGDKLRlf65WvGBHUSUryx
	o0q1iXlENjDsQr9TMhuAX9xzCMsqzdH+k74/MATHRA/WgWSwOQmy30sQt+ltSuYpAj5rvsVMlba
	bJwBaaerc6A4aTTM1nLTonPK1I4x8/rxKpUpFTmkK5W4Hn4k9rJ5RL77MB71Dgr90HmELo1+/v3
	iQvwa/NotRIUoQembvpXrhmhq+G6x+FtokZs2GJduCl0lwC16McJKdTC7x4ewSpfzS91/ajkZBn
	pSZZnx3j5TVfGpTSLtns=
X-Google-Smtp-Source: AGHT+IER4w7Gv2HT+lC8OIjC2A2wM1LDd+FmczqJH8iIfDQUqrkmZjEiTLub/ovZQlhvGnrzY9zJKA==
X-Received: by 2002:a05:6000:2381:b0:391:3aaf:1d5f with SMTP id ffacd0b85a97d-3b795009481mr5578956f8f.52.1753959350129;
        Thu, 31 Jul 2025 03:55:50 -0700 (PDT)
Received: from victus-lab ([193.205.81.5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c4696c8sm1946025f8f.55.2025.07.31.03.55.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 03:55:49 -0700 (PDT)
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
Subject: [RFC PATCH v2 07/25] sched/rt: Introduce HCBS specific structs in task_group
Date: Thu, 31 Jul 2025 12:55:25 +0200
Message-ID: <20250731105543.40832-8-yurand2000@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250731105543.40832-1-yurand2000@gmail.com>
References: <20250731105543.40832-1-yurand2000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: luca abeni <luca.abeni@santannapisa.it>

Each task_group manages a number of new objects:
- a sched_dl_entity/dl_server for each CPU
- a dl_bandwidth object to keep track of its allocated dl_bandwidth

Co-developed-by: Alessio Balsini <a.balsini@sssup.it>
Signed-off-by: Alessio Balsini <a.balsini@sssup.it>
Co-developed-by: Andrea Parri <parri.andrea@gmail.com>
Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
Co-developed-by: Yuri Andriaccio <yurand2000@gmail.com>
Signed-off-by: Yuri Andriaccio <yurand2000@gmail.com>
Signed-off-by: luca abeni <luca.abeni@santannapisa.it>
---
 kernel/sched/sched.h | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 2f9035cb9e5..2a7601d400c 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -319,6 +319,13 @@ struct rt_bandwidth {
 	unsigned int		rt_period_active;
 };
 
+struct dl_bandwidth {
+	raw_spinlock_t          dl_runtime_lock;
+	u64                     dl_runtime;
+	u64                     dl_period;
+};
+
+
 static inline int dl_bandwidth_enabled(void)
 {
 	return sysctl_sched_rt_runtime >= 0;
@@ -467,9 +474,15 @@ struct task_group {
 
 #ifdef CONFIG_RT_GROUP_SCHED
 	struct sched_rt_entity	**rt_se;
+	/*
+	 * The scheduling entities for the task group are managed as a single
+	 * sched_dl_entity, each of them sharing the same dl_bandwidth.
+	 */
+	struct sched_dl_entity	**dl_se;
 	struct rt_rq		**rt_rq;
 
 	struct rt_bandwidth	rt_bandwidth;
+	struct dl_bandwidth	dl_bandwidth;
 #endif
 
 #ifdef CONFIG_EXT_GROUP_SCHED
@@ -819,12 +832,12 @@ struct rt_rq {
 	raw_spinlock_t		rt_runtime_lock;
 
 	unsigned int		rt_nr_boosted;
-
-	struct rq		*rq; /* this is always top-level rq, cache? */
 #endif
 #ifdef CONFIG_CGROUP_SCHED
 	struct task_group	*tg; /* this tg has "this" rt_rq on given CPU for runnable entities */
 #endif
+
+	struct rq		*rq; /* cgroup's runqueue if the rt_rq entity belongs to a cgroup, otherwise top-level rq */
 };
 
 static inline bool rt_rq_is_runnable(struct rt_rq *rt_rq)
-- 
2.50.1


