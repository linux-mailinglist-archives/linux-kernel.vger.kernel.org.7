Return-Path: <linux-kernel+bounces-845492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B132BC525C
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 15:12:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8938189CD75
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 13:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ECA9283124;
	Wed,  8 Oct 2025 13:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g4X0YvC1"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8D82820BF
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 13:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759929144; cv=none; b=Qrq+4/hVKejG7FMFgY/C7j/pMhN7miKUUY1cqXlRzohnK8VLAUI9dCBojrxDMuxeipTF6fbVhqRwxXA2vR2uJPcjQs8Hfd24BZhyOUMBwgpcw7I9rSTf3aJXoXK6XPKVlsyTbcu+bT/+Nz7dL/aJNt8L4i5h/yeOL+GLBi1i8Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759929144; c=relaxed/simple;
	bh=4p1UWinSDvuUnC7Lvhny+4np9cwJcE7c98wT0kmH9qk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pdI3vFD4DaMMaR1El4HjAv3KFwkm1SwusAFFEBQcjCvZ1/RF6DJiRYbdVIPh0h5/g7wHyUsZEmcUdSG4ZwFVUWkohrC0+H+iTDhoSXJS4SZYfW0quDXa4+DVtlR2ahj+uBdXuyr7GdpDmDWfSeAt7U2IrEQLD8ZzSKwlgvsut5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=g4X0YvC1; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-46e6674caa5so4994375e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 06:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759929141; x=1760533941; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9+tj3sYGck50rH2sadY+CKJOkmDA2rPQZromxu+7Slg=;
        b=g4X0YvC1zTi2lbMy7ipEagPpz3RA35+CiVaTmIigWDyY4AnZBKkFSg9zNXM4Qz9pAK
         hc0YBo3RGBMO5M0UkDgkCDDWoamKs5vNUuXJZZZspAheWSTbNrvbZeA9Uls3c+1U64tH
         qFkTr9lYM8Kws/iVWGrf0gIqO9GIapNZAJy4wD883qBWuAbHN7e2eb+v+AwgF7XKZabb
         T8Ph91aMXGmgMyA08yNFBwHeeFBrI9BBJLBiWJa9GkrU15syUGPMI4Qgzh/L2wJ4iUqy
         ZLvvxhWnVB5yLS7px5bM3LRPHOwDy95TBvqW3TdDh5FXf2Sg5VrLkH3KAFR+H9Jalv4O
         9uhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759929141; x=1760533941;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9+tj3sYGck50rH2sadY+CKJOkmDA2rPQZromxu+7Slg=;
        b=N5+Ce1XHGug9KgQUBCukQdUIX7GyfcLUl073J8EIO40OYARfutNkSUYIEI0+XU9jGB
         r+Dgw1KhAPIwq4v6d9Nf4/xvD4D/4rmJzWepMWhDGna5ywRrkjLWDPfE9ClUgp8ik+wV
         sjq0/O2HXO6KNwejhYbm6W3fPakrerTZDzyow0ZFE/CZW8LXTck9eVCX2zbEkUI4T8su
         7hyeSdzQOmxg5bipaSy/5OXv3spty3LLZEuUIW2iNis8s50BPji0CRy8OHQpLam46Q7L
         AaPS/cvpUe/oLcA8x1Q1fzyZe2646oVVvqp6Oe/UvKL8JYVnMUBkVaXOnQW6k584cpZc
         v+CA==
X-Forwarded-Encrypted: i=1; AJvYcCVOfHCMCV3n3+2MYmKSH3mKfN0O5eNKKsR3XQhjJkASvfNZ6Cyb90ceZHe178aDreXq2Z/l4dGNpBmVuvE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwX/5lcO1cbS9ynwtrxMgo0X1FyrNMRUhL0f75ivX+G/XCUFSWh
	f0w6mr5r1pffaUlFOJwXuOs0keErsRgMLKQrksZvoFXh3zgMKg5rsreVEBfG3R0Sa70=
X-Gm-Gg: ASbGnctG0CbNNEG0Muh3c78S8VgRATF5elrfj5J8Fha9qTn2DKxcdkQOc/8JJqWcV6N
	XRnEwsrWVws3WoCnwmpMkVG9lSqIc6r0gPhOhuz+q5w6ZyZb9rVtm1KXHL3FvJDEFThtEab8BC9
	Wc9YBjwXfHI8rsCws23nagdFt/dQwW2onICqTc/ceWaSaTiSyx9N98uMxPpUIiBwkbhDR5Y4E+r
	3ywP/oOFAhupquW2vOIAWRQX6jJZCW9mQlyhzlukyDN5OQoWjMBlMUYSO7zGxYSWwJlcPNQe67R
	s8MMdW08lqLvAOCQoSKTqiuLO8DPG68JvE5mC1GhseahYxMCifgUplYLv2VDqCQIBAZZxbjhrtr
	Ve5GTADCUS638rKLrePA7YAgVWy/sL6qk8ovKmiDnbj6T084Ko5tvDuiMrFA=
X-Google-Smtp-Source: AGHT+IEdp21lHWucjnH31ZPHqsp0lnQX0xwMEiA8mNoUsUUWDWTriY07NKlpecIVmqT3CXJzuP6A6w==
X-Received: by 2002:a7b:c341:0:b0:46e:24a4:c247 with SMTP id 5b1f17b1804b1-46fa296e01amr35605835e9.5.1759929141178;
        Wed, 08 Oct 2025 06:12:21 -0700 (PDT)
Received: from vingu-cube.. ([2a01:e0a:f:6020:5123:5650:449b:dc1c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fa9c077acsm38270865e9.5.2025.10.08.06.12.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 06:12:20 -0700 (PDT)
From: Vincent Guittot <vincent.guittot@linaro.org>
To: mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	linux-kernel@vger.kernel.org
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH] sched/fair: Fix pelt lost idle time detection
Date: Wed,  8 Oct 2025 15:12:14 +0200
Message-ID: <20251008131214.3759798-1-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The check for some lost idle pelt time should be always done when 
pick_next_task_fair() fails to pick a task and not only when we call it
from the fair fast-path.

The case happens when the last running task on rq is a RT or DL task. When
the latter goes to sleep and the /Sum of util_sum of the rq is at the max
value, we don't account the lost of idle time whereas we should.

Fixes: 67692435c411 ("sched: Rework pick_next_task() slow-path")
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---

I Noticed this while reviewing [1]

[1] https://lore.kernel.org/all/20251006105453.648473106@infradead.org/

 kernel/sched/fair.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index b3be1e2749ce..dd0ea01af730 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8920,21 +8920,21 @@ pick_next_task_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf
 	return p;
 
 idle:
-	if (!rf)
-		return NULL;
-
-	new_tasks = sched_balance_newidle(rq, rf);
+	if (rf) {
+		new_tasks = sched_balance_newidle(rq, rf);
 
-	/*
-	 * Because sched_balance_newidle() releases (and re-acquires) rq->lock, it is
-	 * possible for any higher priority task to appear. In that case we
-	 * must re-start the pick_next_entity() loop.
-	 */
-	if (new_tasks < 0)
-		return RETRY_TASK;
+		/*
+		 * Because sched_balance_newidle() releases (and re-acquires)
+		 * rq->lock, it is possible for any higher priority task to
+		 * appear. In that case we must re-start the pick_next_entity()
+		 * loop.
+		 */
+		if (new_tasks < 0)
+			return RETRY_TASK;
 
-	if (new_tasks > 0)
-		goto again;
+		if (new_tasks > 0)
+			goto again;
+	}
 
 	/*
 	 * rq is about to be idle, check if we need to update the
-- 
2.43.0


