Return-Path: <linux-kernel+bounces-888714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B45DC3BBAF
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 15:28:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CA2734E7CF1
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 14:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8097334D4D6;
	Thu,  6 Nov 2025 14:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="LtW6TchX"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43AE32E6B5
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 14:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762438813; cv=none; b=P8em+CSvXEHCTkCs+K2z1M0FjjFigCTznD72SAzlo99t5lq2MoKU35x4ZwG7QMlrloTgU4rjY1YaPmRFpLWp35DW+8Rxc1dfdj/VMRUd+RP8Hdfv2fCe3a57bWyS4AwVR6mjVto3R6Ap03Gegd9FolJ3n2vb/HKhzWST7nTUoqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762438813; c=relaxed/simple;
	bh=iGbdNz4zRjPt2GiUJulnVuYyuGFHGYnl5Zn/KzkGIU4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JOnIg7neS11ocSewmWwbThdedS/sU3beYOjkLdBwdfJ8qm9VTtKLR6f49krxSSQNVdNNHiqipm0KVtBPg6b6JUIFCFHeOdOTXH14ngnocGIqoPPFlFySEuyKJynxWgGRgVvIASCvK9kBN1eIwxwCTirfbooo7uX24RTXZdrLfQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=LtW6TchX; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4775638d819so5269315e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 06:20:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762438810; x=1763043610; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CF/3Zhb7QddI6EQtUEi+uCpLAFeiI4pZCmj4H7qhD5E=;
        b=LtW6TchXO72WjI5DsqGn2Y5jDMVWSdXzJZTz/DK3swKMpGXA59GzcvcDlJ5Q/IGd+V
         Nat/JqzsRkIO9iLhnuyZmTkvDvqQY0FtSBOXR8zZ6PvWa1M6mPti9IYn+fXsnqg6s6XS
         HWTKJKFynr2WOuZlomrulBf3CZaKR2itWH1kDqOQfuULtTKZqJ5cDZ6VuZMgris2MoWV
         BfoW+mKsI/bpwheGMjrn6URiHCFxwzl36YVx8+I/KGZdi3pEax1QtROS/1ZG3BFUm8je
         YtZbKqnOla3N9dbf3gyM4dQZ8Wf9ZOT0DxV1n3srqhvfZvtTrR3/G8d/LkgizPBmYtUu
         RQwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762438810; x=1763043610;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CF/3Zhb7QddI6EQtUEi+uCpLAFeiI4pZCmj4H7qhD5E=;
        b=NbRNv/VhjvhxWkqRr9LXBA3O+Mp0B5IyIMbNojMENE9f1fMU78lrF5z16b1ZMcBJU9
         LXFOMHcxNAG7mBw7LlOv/9jwhLzPA+gufMfunEKJ8Mklgkyt3AsOVB/ZDpYqPfIOGhWt
         7CoJ28MZIl3LFQ1q1OSqIVEZdmk5Nl1/JgYCkV9cEgsf6kdqi0OzcbAGpGPaXetavMWT
         ftmOm4cdv+gwUR/b1QAoWS7weh5OKYOOkuGwbFxbf6n48XM7Msy54zc8y7rwQ7Tc8W2F
         5v/Dn94URcwDWLRlsbo/6XyMdBxvi1jihiC9kxzA7s/raq9ckvUuVQl5BeSgdNC1qomJ
         WVRw==
X-Gm-Message-State: AOJu0Yxfp+KP5hK1u/vmY0PrzbUCj2VNIBGkZXC7GkwpB1BPkwhDPEjh
	KpLZQNkPRpZ+xZa0B0vw5Fa6vtPwZ/3srWIAlOyvPKMBXFCZJyelL6ghqGSvOKgolZCCSV0KF/4
	dQsfl
X-Gm-Gg: ASbGncsp/wk83KCG7um3TV/nZK+IpPVSNZVRPzQG5bHT5UTBtXiu04QjGromfnL9CLO
	2eJdFoVV9qNGGbiQ4myiNlvOyCZJxt0Jt/IcrDZ/GKBFTg8xFOIY1hlAnPsD4BYLjYu+5EWL4Fk
	VoEhXXW0GKw/xYObgDD4BEgCgvSvnIni8lCgnaD38pcxa90BGcm59I24Y04vgn9OON5aCY/S63N
	b4j3HQN0i8GHNysUxslBPpgAm0c6ich4SOTAvGcc1CkDOr8FW65OXxD6yG/9CjVjxj6Vm6B/O8M
	X/RpIJXsTrCQfrjaZeDXSee4fNaal5Sf3QdKwnV2+lr1UzufIGAQvAExlfr6KxF+A6tlkOGB7rl
	oCtzplp+/kstSYvF484U6GRzDw5xuWeM5KXAsrKa5etgmFOKLij82utLX6yHhy5+okUe2n6LzsZ
	KGJ7gXR30hVRutAQpLv8cRqB7IRG2SQ1BhmQ==
X-Google-Smtp-Source: AGHT+IFW+O/CoCb7xED6y+Ltl4gz0/OdvbxqMSNnvVU72mzUQf/s26b2ifVZCIL+FfdWgyI3Eah13w==
X-Received: by 2002:a05:600c:1e1d:b0:477:a9e:859a with SMTP id 5b1f17b1804b1-4775cdf54e7mr65221865e9.22.1762438809722;
        Thu, 06 Nov 2025 06:20:09 -0800 (PST)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429eb49be96sm5255531f8f.35.2025.11.06.06.20.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 06:20:09 -0800 (PST)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH v2 3/4] Input: mouse - replace use of system_wq with system_dfl_wq
Date: Thu,  6 Nov 2025 15:19:54 +0100
Message-ID: <20251106141955.218911-4-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251106141955.218911-1-marco.crivellari@suse.com>
References: <20251106141955.218911-1-marco.crivellari@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently if a user enqueues a work item using schedule_delayed_work() the
used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
schedule_work() that is using system_wq and queue_work(), that makes use
again of WORK_CPU_UNBOUND.

This lack of consistency cannot be addressed without refactoring the API.

This patch continues the effort to refactor worqueue APIs, which has begun
with the change introducing new workqueues and a new alloc_workqueue flag:

commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")

This specific workload do not benefit from a per-cpu workqueue, so use
the default unbound workqueue (system_dfl_wq) instead.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 drivers/input/mouse/synaptics_i2c.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/input/mouse/synaptics_i2c.c b/drivers/input/mouse/synaptics_i2c.c
index a0d707e47d93..c8ddfff2605f 100644
--- a/drivers/input/mouse/synaptics_i2c.c
+++ b/drivers/input/mouse/synaptics_i2c.c
@@ -372,7 +372,7 @@ static irqreturn_t synaptics_i2c_irq(int irq, void *dev_id)
 {
 	struct synaptics_i2c *touch = dev_id;
 
-	mod_delayed_work(system_wq, &touch->dwork, 0);
+	mod_delayed_work(system_dfl_wq, &touch->dwork, 0);
 
 	return IRQ_HANDLED;
 }
@@ -448,7 +448,7 @@ static void synaptics_i2c_work_handler(struct work_struct *work)
 	 * We poll the device once in THREAD_IRQ_SLEEP_SECS and
 	 * if error is detected, we try to reset and reconfigure the touchpad.
 	 */
-	mod_delayed_work(system_wq, &touch->dwork, delay);
+	mod_delayed_work(system_dfl_wq, &touch->dwork, delay);
 }
 
 static int synaptics_i2c_open(struct input_dev *input)
@@ -461,7 +461,7 @@ static int synaptics_i2c_open(struct input_dev *input)
 		return ret;
 
 	if (polling_req)
-		mod_delayed_work(system_wq, &touch->dwork,
+		mod_delayed_work(system_dfl_wq, &touch->dwork,
 				msecs_to_jiffies(NO_DATA_SLEEP_MSECS));
 
 	return 0;
@@ -620,7 +620,7 @@ static int synaptics_i2c_resume(struct device *dev)
 	if (ret)
 		return ret;
 
-	mod_delayed_work(system_wq, &touch->dwork,
+	mod_delayed_work(system_dfl_wq, &touch->dwork,
 				msecs_to_jiffies(NO_DATA_SLEEP_MSECS));
 
 	return 0;
-- 
2.51.1


