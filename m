Return-Path: <linux-kernel+bounces-764551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 87EF0B22463
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 12:17:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 387DB7B3269
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 10:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ECE9189F5C;
	Tue, 12 Aug 2025 10:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jbdns70t"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2F32EAD07
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 10:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754993841; cv=none; b=SlJnaf3bDQSetPY1+qlcKQ5ftUTaV6AWATafaVpXBL9pq6OZ/Y4m+rr9FpAmRvrILBnhPSkj60X98ZzEanRN6Ualt3FpH6xIHyiP/WMc5IyVfeZQqIU1/GeiVB44IdecG7kqPaOhQi8TaSKeQ/w2Dj7O+suZYSy/Uop8NU81YWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754993841; c=relaxed/simple;
	bh=Ny8XbyguypEdsSdRIs3kzjqtG3O0P7VKO0BiwhlY8cc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=UmC2gS9IAQR5JqFy7XnLksQcyP00qpUV4xtQQSogNRBQC7mG/enFIky3e98fyvm2owHfFcJxj4rrTKPCkSt/VqDN/BtwSYYOL+DCpLOLrsZZlIONbGHAvQs7QIcWX+9/tm8Fqe3MH4Q1BAfuzZaMj94Nrgzgbn9x3A8LgpLsVNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jbdns70t; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-24041a39005so33525465ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 03:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754993839; x=1755598639; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tAiDA+pPXeX+eqjEKGR/i+gKN8pUN58x+qsDUmNsB7M=;
        b=Jbdns70t/wvZ5HMyUWl7520VVnwF6QDxFRstBzcHHLo9hIYFURO/kbiNbnwU1xJwhY
         8ABs2Xz7GgXTA2R3RxbslPcms9nN4xMbjPecRwRgfa0O1Ux7/8ts+OMJYLouv6lN330O
         xlxH3LbVMyUZ3kfbqrteb1vo0IvYd0xfVV3etZjefPHqIiThTf74CAObkVpT3CGjIR9K
         knKqwBNOfYlIv0b4+Y6dneMGO4QkH0ISUPo+AAe3t/JJuKIlkiNz/fbJqSlOsV55MBDI
         +ESEPARye1S7XyM+9nOIYJZrMX0Cmly6cUKfheEmZun0u6HQKW6zjYzuGjIAfItzbK/R
         Oa4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754993839; x=1755598639;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tAiDA+pPXeX+eqjEKGR/i+gKN8pUN58x+qsDUmNsB7M=;
        b=rtLMnkRVNLxArG6HwfCl5erOtuZB9ucq5pZJeNF7gxokaj3/3CWwceI1kciAseUiWi
         X/Sd+CONGY7n22AWQvForn1+VBafOlp8ESgOjFzvtoHAhkaI9mEYhd2e1KXiYH/njq25
         cywD/7ec59+gKNrO6BDjhGcJBL/k9H+xQCqfkbKpmvNs0K26xofrnTjrsChhX9WW2xMg
         rwxmj2dQzcLMhRPMrA2hfx0LKU0nCmlMC0gHqrcciS8UffszQ0ngP8t8g7RvwJLLQWfC
         Ckp9pMgybr3WVdYyFhGTO9NH9ZvrWll6/39uAjpzNj7GL2aD4MiUddyV2jQDP5zJgtoe
         1GYg==
X-Gm-Message-State: AOJu0YyL4Hpd6foH4Qs/3WM7audbrYUka0fMqdfvxtmUdaJmPhAKe2+5
	a7AfobFZbTsARuPNMjOqZxcU/qQYbEXCycayyyRyVMBipfdr2PBk7SA+
X-Gm-Gg: ASbGncsUBUUurerFJs81JK3FXfRFGwtBwzCC3r6fu23D1tHr3i6QeopfW42N6zLv6v9
	9zAS4raZ1eCl0Tg0LSmUH7lvJ78bWdvsrwLw89kB9nqiD6X1P9u5cBvL0QVUHPTbcXvTaUwYue1
	IGBCAMxi5knPXmVRREmpwpjm+m+EL+1U26DPx+e1VnLwQyddxDaF2vdhEWTWLGheIom17su9l9T
	DZj0oo11w7xBZEcOWP/+CetO8KO14ZFuFzw0Fz+IQAl2md6dgtj1TqnqJvd3t1Q/RXC7akNNezx
	CT7K1LJlr/H3/C/qlj4/LQumQGcJZbWk19utpeIlAzCxWz8TaUyrXDSHcp39gWIIEDN0QX7C+HA
	40DyDUNQAC7ENJWoA0rrUUZoY34scSQE/plAWzz4JUpPVxeU=
X-Google-Smtp-Source: AGHT+IEiyvNjbueqwD2m6uyn9hGiCFKOElpcUtnIoXnLnoXrC/giOH+BN4AZeaByskAmR2yVP+7ivg==
X-Received: by 2002:a17:903:15cf:b0:234:c8ec:51b5 with SMTP id d9443c01a7336-242c2259699mr202977645ad.53.1754993839297;
        Tue, 12 Aug 2025 03:17:19 -0700 (PDT)
Received: from localhost.localdomain ([2408:80e0:41fc:0:fe29:0:2:4699])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-242ff520192sm14464165ad.90.2025.08.12.03.17.13
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 12 Aug 2025 03:17:18 -0700 (PDT)
From: yaozhenguo <yaozhenguo1@gmail.com>
X-Google-Original-From: yaozhenguo <yaozhenguo@jd.com>
To: mingo@redhat.com,
	peterz@infradead.org,
	vincent.guittot@linaro.org
Cc: linux-kernel@vger.kernel.org,
	yaozhenguo@jd.com,
	ZhenguoYao <yaozhenguo1@gmail.com>
Subject: [PATCH] sched/fair: Introduce WAKEUP_SELECT_IDLE sched feature
Date: Tue, 12 Aug 2025 18:16:50 +0800
Message-Id: <20250812101650.44110-1-yaozhenguo@jd.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: ZhenguoYao <yaozhenguo1@gmail.com>

Introduce WAKEUP_SELECT_IDLE to control if to select
CPU only has SCHED_IDLE task or idle cpu.

open it:
echo WAKEUP_SELECT_IDLE > /sys/kernel/debug/sched/features
close it:
echo NO_WAKEUP_SELECT_IDLE > /sys/kernel/debug/sched/features

In cloud computing host environments, management and monitoring software
are typically configured with SCHED_IDLE priority to avoid interference
with normal virtual machine operations. However, if vCPU wakeups
consistently select CPU cores running SCHED_IDLE tasks, critical
management and monitoring services may fail to execute—even when other
idle CPU cores are available in the system.

Our servers operate in performance power mode with idle states ( >2μs)
disabled. Consequently, selecting CPU cores running SCHED_IDLE processes
yields minimal benefits while introducing excessive latency for monitoring
and management software. Although these processes are low-priority, they
are not equivalent to offline processes.

To address this, we propose implementing a configurable switch to control
whether wakeups may target CPUs executing SCHED_IDLE tasks.

More info:https://lore.kernel.org/lkml/cover.1561523542.git.viresh.kumar@linaro.org/

Signed-off-by: ZhenguoYao <yaozhenguo1@gmail.com>
---
 kernel/sched/fair.c     | 5 ++++-
 kernel/sched/features.h | 2 ++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index b173a059315c..2d1629086307 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6781,7 +6781,10 @@ static int sched_idle_rq(struct rq *rq)
 
 static int sched_idle_cpu(int cpu)
 {
-	return sched_idle_rq(cpu_rq(cpu));
+	if (sched_feat(WAKEUP_SELECT_IDLE))
+		return sched_idle_rq(cpu_rq(cpu));
+	else
+		return 0;
 }
 
 static void
diff --git a/kernel/sched/features.h b/kernel/sched/features.h
index 3c12d9f93331..bf23a9dc6e05 100644
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -63,6 +63,8 @@ SCHED_FEAT(DELAY_ZERO, true)
  */
 SCHED_FEAT(WAKEUP_PREEMPTION, true)
 
+SCHED_FEAT(WAKEUP_SELECT_IDLE, true)
+
 SCHED_FEAT(HRTICK, false)
 SCHED_FEAT(HRTICK_DL, false)
 
-- 
2.43.5


