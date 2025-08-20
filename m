Return-Path: <linux-kernel+bounces-777326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE50EB2D83D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 11:32:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 038651C42B68
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 09:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D737C2E426A;
	Wed, 20 Aug 2025 09:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g7NQfVHE"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7F12E3AF3
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 09:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755681498; cv=none; b=rkrgU5+TXNPHeyMPwcgdFn3K1TmvQMLHGcZJRJ4Vqb13+y6QYBuQ5PRk6pZ1W7L3gjK/+kyZQ9FYkeEZWX4NtoGrVAe8VoBlnrqKb1I7mCJsX0tCT9RSbWM/kyHPWs2VuBTTMQMPUrVrqobXGy1e/N39S+XRtmo0CbccVmGZUs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755681498; c=relaxed/simple;
	bh=/Vffl83wUI87E7o1oTDqOUkPoi70Eqk1k59wxwse63o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uSRHodsFtFYQl7eiTEjyDqdBomX6t7xGBZnJxJKq7GKSvCeOgAoEBT8fGKgDniyluWYe0i2Sf2qfPHWgWUJRNwic2Y83vwg9a5rsGLAUy3N2Ikg3DkjhdW6bDerB/lAf3UDg3NeeCHCnm4RD6MSjAsDLm5ci9AUlyHd/ZLQB72U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g7NQfVHE; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-76e2e89bebaso4613972b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 02:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755681496; x=1756286296; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VmJ7RIhD+Czj/7A+VwyBpCQYzPH3KIKkRyweRy7AzmE=;
        b=g7NQfVHEDol/fnN4K6qhR5eOwtS7OrcYOMolm3qi2RN5DYz/j1PvxDNDlKZmBtmbyl
         5HWe+yqw1dcgTnwzT01KteptttSkOaa2LlJVNRAZX92wouSlC6G4G5aO1uNMr3ka46Dd
         HvAQm58F1YxFyVFY0K0bFSycqzYXGR3AkGG3FQdz29BgdlHbUwmEx3hdP0I2b0CAdHJO
         DqKFs087YQpB644XIvYXm7rZWnEhdskcxRqxPZfFcX5WGTXOR1pg1LdilBmqXrwLzwKO
         uvZ3bH8J5G6fgQC0VGVE9zCwBwHpPborxzh+hHnVrak956KCCUwL/iHJcZtFZMN3l4Wz
         LHzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755681496; x=1756286296;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VmJ7RIhD+Czj/7A+VwyBpCQYzPH3KIKkRyweRy7AzmE=;
        b=cLBM0eXWmZC5dvy1iM4t7QnEGO5w/47pCWV2O/m/9SG9Vu/lcWbl6NvCrv6nypmfJb
         5udO8WF3Kk35Tq2an4U+D3FVYG55FXEwq4BzVGVEkZx1GOy70EOQ3XHoAIulvHGH5qop
         CHnmN5QOgK68Nu9SsbxpbyIH36K69Qnt2vKVy3VTKTeJ/8IzkassOY4GDbnkMEOi43UK
         x4hA6IiZcEoodo0LvknCGZFF/0k1Yv7yrCQParFlCGbYhV5eQNL4NTl6tt72vGPzhgYc
         czNO6Ux0Vhg4N8mDsRnHF8rJoz8CaywpkhAFQ71t27U42MGflQGW8wh0upDUBOfICo0E
         ZFZw==
X-Gm-Message-State: AOJu0YxeC9WAObNnRQjAuQxQxkHcsEKrFe3DTfqiTTc0Ix2d+l2aVtQp
	1HA9MJRoD3KZmAEc3fTGNaTgP13mPgfVZc4bb88pHz10t98h8SaVv93658mII+Jtc6tdrw==
X-Gm-Gg: ASbGncsdRnV/rrV3jNaM6mgCb+0L1rVtMFjaoyPFncWXblNv9OX53Yd186AVpL+U6JZ
	LiOMPQlXLpkBlDDG63SGm73LIp2YjHxm/0pSyoAKGQdgDX41SnYuPDr4uHNtvg9XSw9IJdf9hzR
	9mZxLOS5AoDQkBAoeVWlkH1x61brI1XHgnzGpnyh4ilpjrnKU2ydIQz+a0Mfjy3A3fm8D6ctZYo
	qlhNEXxAycJxM6aFp9+o60IQt9R8jTbgfDxpLOOHha3gg601oliQd2pv+mT+JeDy+x5075TIFA6
	NuXjBXNBIJldiEA8uzyS5bHahibYNIuCg6uhkV79tmLjtQuYzP29blj1kYKPZpM03ZKARi6VcpL
	yZhRiSdH0e6OGS/7qov6kxKzEYpzbOMjsIlYHqaD4l4npWOmnholU4sFhrsbf0fgdwNA2JaW23C
	Vo/INwp6DUrQ==
X-Google-Smtp-Source: AGHT+IEXkDOfQYg0NvfjHWusyyJCUZTfFWw+TXCd+fdhRd8DEqQUld5w5tVgIFeRFHJkBH3gi/CKag==
X-Received: by 2002:a05:6a00:3c8a:b0:76e:885a:c33b with SMTP id d2e1a72fcca58-76e8ddc3dddmr2755576b3a.25.1755681496154;
        Wed, 20 Aug 2025 02:18:16 -0700 (PDT)
Received: from localhost.localdomain ([114.242.33.243])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7ccfa8d1sm4847120b3a.0.2025.08.20.02.18.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 02:18:15 -0700 (PDT)
From: Jinchao Wang <wangjinchao600@gmail.com>
To: pmladek@suse.com,
	akpm@linux-foundation.org,
	Jinchao Wang <wangjinchao600@gmail.com>,
	"Yury Norov [NVIDIA]" <yury.norov@gmail.com>,
	Douglas Anderson <dianders@chromium.org>,
	Ingo Molnar <mingo@kernel.org>,
	Li Huafei <lihuafei1@huawei.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	Thorsten Blum <thorsten.blum@linux.dev>
Cc: linux-kernel@vger.kernel.org,
	feng.tang@linux.alibaba.com,
	joel.granados@kernel.org,
	john.ogness@linutronix.de,
	namcao@linutronix.de,
	sravankumarlpu@gmail.com,
	Will Deacon <will@kernel.org>
Subject: [PATCH 9/9] watchdog: skip checks when panic is in progress
Date: Wed, 20 Aug 2025 17:14:54 +0800
Message-ID: <20250820091702.512524-10-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250820091702.512524-9-wangjinchao600@gmail.com>
References: <20250820091702.512524-1-wangjinchao600@gmail.com>
 <20250820091702.512524-2-wangjinchao600@gmail.com>
 <20250820091702.512524-3-wangjinchao600@gmail.com>
 <20250820091702.512524-4-wangjinchao600@gmail.com>
 <20250820091702.512524-5-wangjinchao600@gmail.com>
 <20250820091702.512524-6-wangjinchao600@gmail.com>
 <20250820091702.512524-7-wangjinchao600@gmail.com>
 <20250820091702.512524-8-wangjinchao600@gmail.com>
 <20250820091702.512524-9-wangjinchao600@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Both watchdog_buddy_check_hardlockup() and
watchdog_overflow_callback() may trigger
during a panic. This can lead to recursive
panic handling.

Add panic_in_progress() checks so watchdog
activity is skipped once a panic has begun.

This prevents recursive panic and keeps the
panic path more reliable.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 kernel/watchdog_buddy.c | 5 +++++
 kernel/watchdog_perf.c  | 3 +++
 2 files changed, 8 insertions(+)

diff --git a/kernel/watchdog_buddy.c b/kernel/watchdog_buddy.c
index ee754d767c21..79a85623028c 100644
--- a/kernel/watchdog_buddy.c
+++ b/kernel/watchdog_buddy.c
@@ -93,6 +93,11 @@ void watchdog_buddy_check_hardlockup(int hrtimer_interrupts)
 	 */
 	if (hrtimer_interrupts % 3 != 0)
 		return;
+	/*
+	 * pass the buddy check if a panic is in process
+	 */
+	if (panic_in_progress())
+		return;
 
 	/* check for a hardlockup on the next CPU */
 	next_cpu = watchdog_next_cpu(smp_processor_id());
diff --git a/kernel/watchdog_perf.c b/kernel/watchdog_perf.c
index 9c58f5b4381d..7641de750ca5 100644
--- a/kernel/watchdog_perf.c
+++ b/kernel/watchdog_perf.c
@@ -12,6 +12,7 @@
 
 #define pr_fmt(fmt) "NMI watchdog: " fmt
 
+#include <linux/panic.h>
 #include <linux/nmi.h>
 #include <linux/atomic.h>
 #include <linux/module.h>
@@ -110,6 +111,8 @@ static void watchdog_overflow_callback(struct perf_event *event,
 
 	if (!watchdog_check_timestamp())
 		return;
+	if (panic_in_progress())
+		return;
 
 	watchdog_hardlockup_check(smp_processor_id(), regs);
 }
-- 
2.43.0


