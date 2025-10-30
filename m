Return-Path: <linux-kernel+bounces-878601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 296ECC21114
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 16:58:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CBCF134F590
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 15:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0F7235BDC1;
	Thu, 30 Oct 2025 15:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="cEX8CcKw"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEED52E889C
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 15:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761839889; cv=none; b=O5RFfg6oCHcURmfGGa4/0+lIb1yIp1Ct+H7zSWoiHt30P8Mi1zjez74qBVSrYBHfi5PSjOksB8H6UuCkav1FVFyOpBEtMA9+6gT/dDrTEiGRb7wO+X+/xLidoP6GO4sPSBfnXa47u+FiuIG/+EOUnAoZes6tx29+YuI+bEdC/FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761839889; c=relaxed/simple;
	bh=1y/DN3AYHGnqbpT2Eg0xEtWALmP814RsWwlpxAr85Sg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sm85WxbbTV9FPgaHrWTNQXB7myGjOA+CG/Z6MfyekFWKaKjYwux7Gg5yc1JOzNqq/rLb9PQOovyEzXOS2WKKqKHIumRQlJfQMpM3ozrNVPaNgzDQWxvexJvcMD29cGsyajDn3qhhuNzTK1jZnRrvDL+Bd/F1TTbjOSPBEVZwFXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=cEX8CcKw; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-47112edf9f7so10394125e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 08:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1761839885; x=1762444685; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5CJg9mQNlJ38wxbemL94YZO9RRS8e3hW/dvJpglyIKg=;
        b=cEX8CcKwb56ffCnkFLKu+U/7IsGa0iKWEfp/0FJweE43VReDInh3/+nyb+LtZ65S/m
         TtctNR3E+q6tLIQhKoxBYuy+JNRzS60NQqO4Gr0g50g7es/4af1oonIL0DMNkse+eE84
         rWwMlmDlGteRDAhs9O6dljelOwLe340Pt1BZMol6ZSwXmwl4Y6ivwTFgjzA5nKRJPHbE
         FDpyWgOu7HESvStZtxun34/wu/m84+ytV9wGV+5bWHJ46durynWRjOZT80g4N/aPh5iW
         MftbqL5YyhWbkUKYsUdFSZHo8W1vqB146p1IbxhYIIqakmyGt+X+4Ga0ADaur4M2Qqdv
         JRjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761839885; x=1762444685;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5CJg9mQNlJ38wxbemL94YZO9RRS8e3hW/dvJpglyIKg=;
        b=MaQAdMif9DTxSXdo0REW9isf/ln3eiotfq6pYDv3FLovwmXRHB8Qh6M4zTXUikP4Fq
         jYXMbqyRnDWNDxRSvXWaycdtpAvhHehP1xNLvsqeQRKx7YXAqnSQpccdyKfyYAEY203p
         TfW6YMa9hyrb7IwTk4eyUJqBdMpiedPbHeEyH+nhNIrHaJNNTTTalrSs8inzX1InN9QG
         hsxIaz35dc7tLB4bWHTiq6qYlLaGsno2wo8749AeCCKmnycsq3kcOEhFlb7Zv1bCPB3f
         6mao7v71bGqqRMBXT8Sx9A+RCnMipYVKrKmNNcVrdnONLF2S2FuBtFU1nhmGeYJKZw0B
         Rpqg==
X-Gm-Message-State: AOJu0YwajV3c1ny5Yv52M9MJPlwhYSE2UzVCHx46q1OKhmfOSGbod1cv
	eL0WN+e5qdpBSeoHS2BzgIW8qzxi5YHBtDNXPnfYcb7yx3Pqp2AcGVYUVZlJDMq5Q6c2r44x9xh
	PuLgU
X-Gm-Gg: ASbGncvVmXyaEzaOnr7zjJMMtjaRLTAy/nl9O5Q69csvi/lvuZtV7KxYcsY9j7fX/ka
	TcqyvVvQeTIIE3cWASyRFLqrYJ6MoH8yA+H+s2HVYtmBsQucNRCEzSOuyj0rHyeb62Bkk75FTO6
	l8r5wiqID5ObAwnPiUOWuSK/EtRXl4Gk88aWLlUIo9ACWUMOBpnVLXazDRwHz5zMyN09nsIsBZn
	8ck/qkGUzbrA0M3Y3isMS/19gfs5lwsZ2nHvmKQpKAWfPUEBmn4Eg2ywjbMmHF7vim/62D2C3vy
	hUlKRSjLkBrZRkdev7Pq08Qu+Xu0ayBYRXWviwBbcXTU9LBs/iHPivhttgY8rsR4IJENCab8zhh
	GDRr4bCcRjISgFFpnGO39ofYZL6uxyqu9X7w41xbzihzLAT6YHoh9BtJF8aUHQfTNnunKbsZ4dS
	Vt2aXv3ABaTcAcSH0=
X-Google-Smtp-Source: AGHT+IHw3SB2MMgruxxcEvFw+K3HfUxUrvwYPAHUQZTP+JoVPcQIl+PwPho7Tm0UVuKSoiIIuWHkow==
X-Received: by 2002:a05:600c:1e19:b0:46e:711c:efeb with SMTP id 5b1f17b1804b1-477308aa8acmr2074895e9.25.1761839884743;
        Thu, 30 Oct 2025 08:58:04 -0700 (PDT)
Received: from linux.fritz.box ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47728ab375asm47387695e9.17.2025.10.30.08.58.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 08:58:04 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Theodore Ts'o <tytso@mit.edu>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH] random: replace use of system_unbound_wq with system_dfl_wq
Date: Thu, 30 Oct 2025 16:57:28 +0100
Message-ID: <20251030155728.271373-1-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently if a user enqueue a work item using schedule_delayed_work() the
used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
schedule_work() that is using system_wq and queue_work(), that makes use
again of WORK_CPU_UNBOUND.

This lack of consistency cannot be addressed without refactoring the API.

system_unbound_wq should be the default workqueue so as not to enforce
locality constraints for random work whenever it's not required.

Adding system_dfl_wq to encourage its use when unbound work should be used.

The old system_unbound_wq will be kept for a few release cycles.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 drivers/char/random.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index b8b24b6ed3fe..92ec34a303c9 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -259,8 +259,8 @@ static void crng_reseed(struct work_struct *work)
 	u8 key[CHACHA_KEY_SIZE];
 
 	/* Immediately schedule the next reseeding, so that it fires sooner rather than later. */
-	if (likely(system_unbound_wq))
-		queue_delayed_work(system_unbound_wq, &next_reseed, crng_reseed_interval());
+	if (likely(system_dfl_wq))
+		queue_delayed_work(system_dfl_wq, &next_reseed, crng_reseed_interval());
 
 	extract_entropy(key, sizeof(key));
 
@@ -741,8 +741,8 @@ static void __cold _credit_init_bits(size_t bits)
 
 	if (orig < POOL_READY_BITS && new >= POOL_READY_BITS) {
 		crng_reseed(NULL); /* Sets crng_init to CRNG_READY under base_crng.lock. */
-		if (static_key_initialized && system_unbound_wq)
-			queue_work(system_unbound_wq, &set_ready);
+		if (static_key_initialized && system_dfl_wq)
+			queue_work(system_dfl_wq, &set_ready);
 		atomic_notifier_call_chain(&random_ready_notifier, 0, NULL);
 #ifdef CONFIG_VDSO_GETRANDOM
 		WRITE_ONCE(vdso_k_rng_data->is_ready, true);
-- 
2.51.0


