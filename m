Return-Path: <linux-kernel+bounces-888801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CD96C3BF58
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 16:09:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35A37623690
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 15:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2E951DA60D;
	Thu,  6 Nov 2025 15:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="AKcTWIKL"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34FD119D07E
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 15:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762441293; cv=none; b=Xo90V7QCsYQmmqLvwCzi8c1QDhgg4YgzCvJ2g7XRs2iiL+Z8RobFREmxvgPddUDZzTTExkhI6wFgiJK4TJ0e4ZtEzeFeIlTEVAF9p5XHEDlU8S7zG6PRXMh23cGjIcV2kKCeGl6/Ih5JSyvBvrna/4MDiAINPA0WQGkLiRSm/Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762441293; c=relaxed/simple;
	bh=jCvKBBp1W8WUva/81K4STHxtNMngHkCbAjdRsMt0xxo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RQesYVJMKdkd9Sb74UxHRMn+xQ0D2EkjwVx531zRgW5mRaN47M6Jgnxe/Bn3YJQEQ669Nf1iEHHmKUsOe502MufRTJwJbcw1le4IJZSnxUykafSkZF6mv9CASXJo6XCf5pkr1XbjyBsNhH7TGTplX5auzstnoSf1MPq0KQgfSHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=AKcTWIKL; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-429ce7e79f8so811827f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 07:01:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762441289; x=1763046089; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9q33Ehb0aqC9B6A5x4aRuL8tc8kDojsM4ivTH96hSK0=;
        b=AKcTWIKL8taTgyiA28I/KI32jtfMPYTLhw5BOlq6emgUsdDby6xXCYM4ReCHuhnnVP
         ZEfkzJf+yBJtX0Z0mUcnSTnEmjyh9KkzrZwj5U23L+dPnke50LMkgHY2UOL4hzfTYOT7
         VaoFqRJioQEtgoGMr/bIIPLvBaYWNTaRP2v6mklc7fKEp2t3hPI7+ASji68Y6UJQO1ed
         r/Tx66DiswG6m3McHjtX1rLK6ZaRdXdx0Lp6JwuNV34NH7iOcKVBP+qV1ivwobIqGSUO
         /JZd+lVTnD1B3B2jOElrt9j+j1Zkm3ugV7gOrbopr9A0T7zx7q+3pn90VLqxQoci4stc
         5D2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762441289; x=1763046089;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9q33Ehb0aqC9B6A5x4aRuL8tc8kDojsM4ivTH96hSK0=;
        b=BCY4Tnmh66LnolfRKdOGxJbx6p6RiI1H/jjBKclexAHnUrni4duIt0iCYvRPyA6fXd
         lQiWDsfQTrta/a7BrEf7zft8VmHQRaFpWOm6f67du16XoqTFuqQTlyT7gfDrOfHk14OX
         xawhcBEZHW5sddPDyMEWbF6STx7IwCBsgLgJXhTnp2Iz+/YYRau5dLKxO71Y6L68dVvn
         F9d17SJpCI3fALS86wnCZ2ywXIobiLmQ9Iwuxy2HvmAvJBkfHVsuvR7dLY0FyC3iorHF
         uvEX8IMpHUba+WkBqjFj408psxQBovn6ES/WcGnz4CDqYQ6OWL0TfPJr/r7iMPoIHB6O
         0YrQ==
X-Gm-Message-State: AOJu0YwArBeXTnaXGuxkgL6lh5sS7B7CukaGTQ8MnYFr9N3FLWv1U6mm
	/HVc4/d9SWYxh/KG0D3SPPSx+HfVaXKYE2P0dZlpRc7HdIohWWztpTeQW+wiDr02tGtExVOu0Ng
	9pzUm
X-Gm-Gg: ASbGnctWAQknqsrJJnd6B9sGFqtXrv3TVGndg8VKY0CwOgnqIDK+yJnku8vFLXsJ3Xg
	dIkINTcbGekcrb9IOgJTwJ30h++tFFpl4sfBQYF0Ou6egeRnWnjpQWi6lP5jnulOMqb8p1jrvUL
	w8FB4vLtBHuEPYKzn/LdC4cZp77TUD/H+RPlQwOVefygTIwF8mqgFdFvhrxUTG64gQclD/3EqBm
	jrFU7qSZ8UtBRZEOqCQp7kellcGlM9RbtRmrxUOGIabVmU5Ak04pAquR9t+K+Ublj+d0WvZIRZa
	o6GMgP6bneCSh//foPtHPrNsxhvZexhCgEK+EoUVotYCvfUAphiOtSKfRtZtY3Fmwyu+wuli1lR
	U+t9BqPa7mjIeLUp9bYiU27h2G4lfVD4C6VOAzUzWbsXNa8MSVmOVoXrro54Cs9eiVewbLK7bo8
	NXG63QzV5O0tTEeHe8DlU5UJ4=
X-Google-Smtp-Source: AGHT+IEsFeQ6pFu7U+/BG5InY/YZgal1+DD+B2PUI/gvSc13hYUekISQ1y5DPHswsv/q41vwvjXBTg==
X-Received: by 2002:a05:6000:2410:b0:429:c965:af5 with SMTP id ffacd0b85a97d-429e32c9e17mr7078839f8f.10.1762441288471;
        Thu, 06 Nov 2025 07:01:28 -0800 (PST)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429eb49c394sm5784038f8f.41.2025.11.06.07.01.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 07:01:28 -0800 (PST)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Philipp Stanner <phasta@kernel.org>,
	Christian Konig <ckoenig.leichtzumerken@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Subject: [PATCH v2] drm/sched: Replace use of system_wq with system_percpu_wq
Date: Thu,  6 Nov 2025 16:01:21 +0100
Message-ID: <20251106150121.256367-1-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the general workqueue implementation, if a user enqueues a work item
using schedule_delayed_work() the used wq is "system_wq" (per-cpu wq)
while queue_delayed_work() use WORK_CPU_UNBOUND (used when a cpu is not
specified). The same applies to schedule_work() that is using system_wq
and queue_work(), that makes use again of WORK_CPU_UNBOUND.

This lack of consistency cannot be addressed without refactoring the API.
For more details see the Link tag below.

This continues the effort to refactor worqueue APIs, which has begun
with the change introducing new workqueues and a new alloc_workqueue flag:

commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")

Use the successor of system_wq, system_percpu_wq, for the scheduler's
default timeout_wq. system_wq will be removed in a few release cycles.

Link: https://lore.kernel.org/all/20250221112003.1dSuoGyc@linutronix.de/
Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 drivers/gpu/drm/scheduler/sched_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index c39f0245e3a9..13192e99637a 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -1315,7 +1315,7 @@ int drm_sched_init(struct drm_gpu_scheduler *sched, const struct drm_sched_init_
 	sched->name = args->name;
 	sched->timeout = args->timeout;
 	sched->hang_limit = args->hang_limit;
-	sched->timeout_wq = args->timeout_wq ? args->timeout_wq : system_wq;
+	sched->timeout_wq = args->timeout_wq ? args->timeout_wq : system_percpu_wq;
 	sched->score = args->score ? args->score : &sched->_score;
 	sched->dev = args->dev;
 
-- 
2.51.1


