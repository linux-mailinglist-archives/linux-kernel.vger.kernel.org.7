Return-Path: <linux-kernel+bounces-811310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAD52B52753
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 05:47:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9FA1C7BADE5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 03:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81B5423A9A8;
	Thu, 11 Sep 2025 03:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YKQVvCXh"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76FED216E26
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 03:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757562299; cv=none; b=jvhHfWAtallaAnopsxniWnq6xL9vPFCeUgeupD6OFFhLueyOpXebNfiTlMzuN3MHmGEzyMR/iqugxNVPz+ug9GMP0HkAdwBPS+c4geSFYcEf/Bo3K6Pjdte04VZDmrOY8XZhRPp2Hc8JGAfyBVQr+AndCGz7LbgR9bYhy8Hhy0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757562299; c=relaxed/simple;
	bh=FeBkI+DIqbKuWPeey3r5Aq7+0VqdTIhyf7KTvq5WyfY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UXtLvTWl6Bxkdf+zi4f2J3MsBE8Mpx2FiQxE3Wgkhfy4qOVRqp+kOu2+jDyxuyIk72nGMPadVmI1jT+eTWt+40iL/eBfUzfypdPN+TNVlTxpj8/LOjhyn2Q3T9VL67MQWBwXNJaIwGsHppSSdHhOdJeqPtbwcFfzWu2flvyX3Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YKQVvCXh; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2570bf6058aso3471105ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 20:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757562298; x=1758167098; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gp7NlDOj8s1C6nikuQpES2a8b5/gpCrL3jTyE2azAEo=;
        b=YKQVvCXhXsCO2mmdx659EkPVv2noNuWkj4tfEgQwNzU/+W2K3g2HOE4ilutW2CJWS9
         2QYycULuSGUjoZrDtN8N4kD54qsVzcbkLM/KFCj5DS2K4Lw051yyDPf1PmQGJGsngxZ4
         Aj/R3giODqyohYy5J34P3PCLMQH6vmEL89kgK5AoRYZ/VFER1BKG51w9y0g+NS4Af/gM
         4srg0NBADpNhMp7cYOHW270coHMgVzjRfGsYSKsOyv1aR299NDsoo2y4k3NtZyEY/+WE
         vPWa9BsZNaoAlHzyYG6oIphN6A/cy0NbVCm44yL4XkO11HFBo39eWghHMinzIoTPajq4
         PwOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757562298; x=1758167098;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gp7NlDOj8s1C6nikuQpES2a8b5/gpCrL3jTyE2azAEo=;
        b=Gjuv7VizXp9uQzyeqAJZKpjxKpZMkm2jkTGmo3LhTAjo/W22uY/029yOVynsk+g525
         mRxxya5CvS7BLcrafLkbbqNV/9G8+N0h1aBO9v/ki7DVdK+KRIyCWHr50+9iRMgYSjRn
         gUnpNYRvjIkwLI5ur23xNkizE2z4dtb+4hMezT0lQ8aXeQJRPjhOpAhRiv02/9a/+tIi
         dE2MLxvjB19JLf/isXU0RKD3XL4snGkTJTiAmTRltOFaEyFDxzqyndQg7lXCmO1q+fGj
         olOLruj9wch8YWPX0KWhNTUBGOxvpfdJv9krxQ5GiasKCbQvGa+dYLaASkf2X2vOHi5g
         9ayA==
X-Forwarded-Encrypted: i=1; AJvYcCUUhJ3dHxCIGITFOsCfcfI0Z0Vj/0oSIkLG9kyUgiYWZ4llX6NmMIHs5pVTP2bkWUW76NDvBC5qA95xKhs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAiRnq0X6J5tDzPXGQsceTxTuv/wwfwa6m+/9YTXdRoLvT5Kk2
	vHAEVapFEEH408Gsl1T8bWg/jLVbZRrbSgyo41aulOUMe8v6kviXQ5B5
X-Gm-Gg: ASbGncu7rKO0JP7/IQ6chfCbeeLUuVZJdL7YN+NIppK1E5iGSCO74STZRBthv5e6bI1
	zwbZmunc5OmxV/mrvtGmaKNbZymAFGQsAmPoNDkp1/dihuBuf/UJRJA+dl3szwj8bXeC+Bv5Guk
	FDR0/rojUyXwjjiIfGpaDw/R7Nowj971Xva9vqY6TZO41zX9Geq94zyk3Q1fXFs0PdZOX/lwckW
	5Tz8smaYcwD3OJBKLV6FF6GoUa1aDidR+eNVj0qF5q/bN+fK/bT9MQfgzh3jiq4u/GVSciZHaIZ
	0W3rsldLOzbFXGDbfVKqRJwKx1G5fF0D3OuMSYjMtN6VmEoFYeJ/e0tz1/toFPXXnduN2UcLgTA
	s/88wTqi3Ye+lesduldC5yWLR2LY8v9wP
X-Google-Smtp-Source: AGHT+IE9eIw3BYWelQzgiLIf4tSTJAM7ag7P7YkdABaf0pm4V8ouHglCKbgNfTPQ99v5GJCsHPGMZQ==
X-Received: by 2002:a17:902:f549:b0:24e:e5c9:ecfd with SMTP id d9443c01a7336-251728629c4mr228614175ad.42.1757562297473;
        Wed, 10 Sep 2025 20:44:57 -0700 (PDT)
Received: from localhost ([216.228.125.130])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54a35b7e31sm365453a12.11.2025.09.10.20.44.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 20:44:56 -0700 (PDT)
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
Subject: [PATCH] sched/fair: use cpumask_weight_and() in sched_balance_find_dst_group()
Date: Wed, 10 Sep 2025 23:44:52 -0400
Message-ID: <20250911034454.494852-1-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yury Norov (NVIDIA) <yury.norov@gmail.com>

In the group_has_spare case, the function creates a temporary cpumask
to just calculate weight of (p->cpus_ptr & sched_group_span(local)).

We've got a dedicated helper for it.

Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
---
 kernel/sched/fair.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 7229339cbb1b..4ec012912cd1 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10821,10 +10821,9 @@ sched_balance_find_dst_group(struct sched_domain *sd, struct task_struct *p, int
 			 * take care of it.
 			 */
 			if (p->nr_cpus_allowed != NR_CPUS) {
-				struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_rq_mask);
-
-				cpumask_and(cpus, sched_group_span(local), p->cpus_ptr);
-				imb_numa_nr = min(cpumask_weight(cpus), sd->imb_numa_nr);
+				unsigned w = cpumask_weight_and(p->cpus_ptr,
+								sched_group_span(local));
+				imb_numa_nr = min(w, sd->imb_numa_nr);
 			}
 
 			imbalance = abs(local_sgs.idle_cpus - idlest_sgs.idle_cpus);
-- 
2.43.0


