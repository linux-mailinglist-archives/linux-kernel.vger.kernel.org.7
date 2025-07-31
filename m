Return-Path: <linux-kernel+bounces-751968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61AD2B16FEC
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 12:57:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 549173B5C66
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 10:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBB6C2BFC9B;
	Thu, 31 Jul 2025 10:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WL6XGOZ3"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0AE2BEC37
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 10:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753959355; cv=none; b=rqFVuom71Q5hTRnLewxTdIGtPi500ysAF8QrAlAQRRllFVsinVPW1+6tse0+dVbXT1rOq2IBTbRPHCyDDUTzciE2BTm9p3FpgH5AN0oNOGbNbE2Qv8kJF7dSUHJupIrnTHXjTjzrkhiJ2sil217hE9xHRy0GAMu1Z5SRS6cMarI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753959355; c=relaxed/simple;
	bh=5h8kV4D5T34UY7lWfYT38q0co0S9gry1y2pxE4/+dPE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JYVfX02AE2urd3Z4+HJa2se6qjNR3vRquwSgb1OJJxyR3ErXiuFGMp1Gm6/xLYyd0tN5un0C5J/aP/fUxERUeGxaonQH9Oc0T1oP0h+7OUFNFIoSDNJQ8dqQSlzfgEesGLQDQt92nDkgMqlMYBTVfbziKgnc2DXLv1Dj4PWRfuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WL6XGOZ3; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-455b002833bso2762315e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 03:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753959352; x=1754564152; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DsoVVUXbQcQUiFyMHfd1wlwL2hp1Ean1m0cDIu2kNZg=;
        b=WL6XGOZ3rfxfxqbIkk6VskkLoyV4KiBVQ/mQkp+IC/DuV1d5DRDK5XcTXvid37HpVm
         z/S2AfwQYFWxAjL506TqdXNXvR/oFnYoBH0U2qS1uvzK/D4CFeHOGyYiSUOmlvzxNwq1
         IzrpAcs53uPZzNCGT1OYmo/7Gk+W7p2sMdyPtrYjYlzGSIKH9R9emGZsUn4wdHpsbNaj
         mxu/hPzRGsENtveEDrXwnybEBF9koMt8f93HvL0CFvLZhQaTZ0/rut/zO6yrnDxR/1s6
         pLhqTJ/GZHzbhmhcG8jkVYJ9gvLC2dYF/c8t2Lbx/xEwcYJFLKICYo+ZgjWS9Ah9C7LM
         dfIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753959352; x=1754564152;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DsoVVUXbQcQUiFyMHfd1wlwL2hp1Ean1m0cDIu2kNZg=;
        b=nG8LM8+Ty01zsuZTJ636kxXg0qHP2ZwNR5QJPnwQCJ3znhHg4UCdNPavJOitI9lhpQ
         p+MUl44vsnr4OKn9L33tmmZ0079kJvm2IZ+zE6WqntSibk7HqutCFDuCEg43X+mhDtch
         9YnVkqy3z8KtV8Ea/ywT3fFpfDa2HPbUi3EgwflcgXKP6E2R0anQlFIu5cBxILJo0fuq
         alcc2ro79F4A+QKk9Xx6CTSso+gsiNYxGqEi7ceI0zdPUJd/cMI3A8wDYSBZpmZm9fBM
         WEULhWqRNBIK648Of6l1e790b3x0dUBzw78fLXDHIA2O/iaXZ2kqPz+MdLj+CPmbHLsF
         Ic+w==
X-Gm-Message-State: AOJu0YzdnRsKvdJ05DXhxvlQIL1QGtUcTLxX8wgiF5wB4Pcjz/lnJJBF
	LeFI4DC47hyDwwzJ34azfxI1KxnOz/Se8PPWb9xnpqSFULl9og1gje9N
X-Gm-Gg: ASbGncsyUfT99naQBNsbU6v3pAteRSwqLPJ7TrsmIl54AsJRC+NshPiQ5yuoz/BUcGE
	JfhbAJeOWy0gyWVTHPzI5f242ZbRYttFQJDqCGPcq7CxxVxUUM4BiYXwk/ZNXT1cbwzc9PXRjJA
	iZyLCvm1LSHJQhqnYYdfqBTgzI4EaSKFSd91STpEY4U6L4yKSONl7W/fG4nP8NgOSpceM5YAobb
	WGp4HTsY0DTRzgp9cLwTzi3Gu7Bh/bdh6xSYh7dOzAuBtwwenkBNcKYDUByKbxehZtwJes7tg64
	//NJ+9wE4fNFeOISStNvVpQqICc6fdh6ywRFa4SAPMx8cjhzcQI60RADVXO5IzTYsPhCTzH+NUJ
	MHhZE8/TXDo27t6xLeN4=
X-Google-Smtp-Source: AGHT+IEqruCgsr8I+jh6GHoDrJ/dFtAuwDM180ZpyVnxfnZhiISVrJ+XZ/qcNKXB/tSH11xA2eGhAQ==
X-Received: by 2002:a5d:5d0a:0:b0:3b7:7d63:f4f2 with SMTP id ffacd0b85a97d-3b79502d719mr5260838f8f.48.1753959351735;
        Thu, 31 Jul 2025 03:55:51 -0700 (PDT)
Received: from victus-lab ([193.205.81.5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c4696c8sm1946025f8f.55.2025.07.31.03.55.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 03:55:51 -0700 (PDT)
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
Subject: [RFC PATCH v2 09/25] sched/deadline: Account rt-cgroups bandwidth in sched_dl_global_validate
Date: Thu, 31 Jul 2025 12:55:27 +0200
Message-ID: <20250731105543.40832-10-yurand2000@gmail.com>
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

sched_dl_global_validate (similarly to the previous patch) must take into
account the rt-cgroups' reserved bandwidth.

Signed-off-by: Yuri Andriaccio <yurand2000@gmail.com>
---
 kernel/sched/deadline.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 43af48038b9..55b7f883815 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -3098,11 +3098,17 @@ int sched_dl_global_validate(void)
 	u64 period = global_rt_period();
 	u64 new_bw = to_ratio(period, runtime);
 	u64 cookie = ++dl_cookie;
+	u64 dl_groups_root = 0;
 	u64 fair_bw;
 	struct dl_bw *dl_b;
 	int cpu, ret = 0;
 	unsigned long cap, flags;
 
+#ifdef CONFIG_RT_GROUP_SCHED
+	dl_groups_root = to_ratio(root_task_group.dl_bandwidth.dl_period,
+				  root_task_group.dl_bandwidth.dl_runtime);
+#endif
+
 	/*
 	 * Here we want to check the bandwidth not being set to some
 	 * value smaller than the currently allocated bandwidth in
@@ -3119,7 +3125,7 @@ int sched_dl_global_validate(void)
 		fair_bw = dl_bw_fair(cpu);
 
 		raw_spin_lock_irqsave(&dl_b->lock, flags);
-		if (cap_scale(new_bw, cap) < dl_b->total_bw)
+		if (cap_scale(new_bw, cap) < dl_b->total_bw + cap_scale(dl_groups_root, cap))
 			ret = -EBUSY;
 		if (cap_scale(new_bw, cap) + fair_bw > cap_scale(BW_UNIT, cap))
 			ret = -EBUSY;
-- 
2.50.1


