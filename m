Return-Path: <linux-kernel+bounces-894533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5306C4B40B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 03:53:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD0AE189335E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 02:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8B3234A767;
	Tue, 11 Nov 2025 02:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TAxzHaJL"
Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com [209.85.218.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A03932E13A
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 02:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762829581; cv=none; b=HnGF1HlAH+fzm9+qQ24LIvbXYesHUGDVpGakndyvmGUg2E3mpJUA0oJ9ghFcivJ+LHjL7cuQjO98OVGTYaaWYXJ1rGcpD7iFhSJZirssPN13M/N2d4oIOb6KndFuDyDGKfRxmyTcH6dJFA4FBsM99v3XnJbDyxWv769cvh+6sWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762829581; c=relaxed/simple;
	bh=KVd7HqAGcj+scX8uIet43Z+a5mSnboeu3xvIctXuc3U=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=nqcDakfYrJjn4QJq1ldPE6J1K/3jyMdEsLehGmlfFWI2OqhYgXpdfoPgsvzVgSxZJ/8ko1G7BYgsrYKpHlDC/rbG76WxZr9AENiAPhQ+myngdKaBEiL7gybPq/nG3NF7Lf50ks7miJXHETgXIYxL4BLysKOdcOICGIF4kQBvsqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TAxzHaJL; arc=none smtp.client-ip=209.85.218.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f67.google.com with SMTP id a640c23a62f3a-b3d196b7eeeso570129166b.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 18:52:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762829578; x=1763434378; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XJkSjm1SepX8j7VmTKEM6qhV9wL1emDk6X4x3Rbnrr8=;
        b=TAxzHaJL0kxfMlyqvS9QJnxzkbRemO9b8bV9KsTVRMFBupHppBp36iWV5rdZO9vngC
         PLIU6P9yR5Bi3TkFVcNXKKbpNwUVu1/o/ix1M3uxJp1kcfGLGYdeXUjDlwA1qEz+CZsX
         XnQVBGdpsZ5bkRHSBrO+Wn+XRgXWbIY8WQtNAVuR2SIstdUuBZU7R3XGTvDGWfORpWzR
         DGHKJ/4olpa4Ei6l6gUfhwRCihlUanVJGYGQyYehGfXglgQqElVcVWL6waUB9DIkI854
         TgFDRxlxiphcXvkxfvmjvuBcV494daBUNjMmKoBqh86eqrjhC/w0YOKgX+Bk+qthyFZQ
         1oTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762829578; x=1763434378;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XJkSjm1SepX8j7VmTKEM6qhV9wL1emDk6X4x3Rbnrr8=;
        b=Ui9YiUXOe+rlbI621CfNKuAgaVG4X3n8CEEhukdgj6DKODiwgmFybCdbULQAUdAZ5A
         hX/0/zxLObyvArZQM1vqA2rujm84eIfw4Ebll5OS+fyCWQ9MTYK7iX+2m7/if8pZlNgA
         lKaIv4gJHax/7thEnvQFRug04cO7n+4LBo9nS/Hf8HNhfQ15urdehGsF2bSaeciM6FPL
         f7qRSus4A/ZXge9JA5FGT0a86vC6vjAaWJHGyFr799Wcr9W/FQkYeRkOUBPP8G1LVg7x
         7H7lRVSShDzI1IFlrPrC+y9xlr7AQ4zYblDn+mpb7xlPXDvMe9pSGAcnMPSeTC7usUgd
         uKLg==
X-Forwarded-Encrypted: i=1; AJvYcCUrQINRXykqmo2C4imjU07+qYXCJyCTUNlHF1bVzVLUiogE9AE6FeT7L6srV4+h3FXdwn/1iE7Ym1SLVTw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsuF1sL7M2Kr5+fHzhWOYBl7NEj8UQU+RLJkdkEC4zV25YUMyd
	8meo7Zaw3TDJPOsttaPBnQLNwQmmxzztrJzVCWNtR9YNTu9YswcqDtAEuHtrSBVhUIrbsVxGOwe
	gCCfhi95wRLNEWatbMxL2QEqFz6SQNB8=
X-Gm-Gg: ASbGncty1uIQWIwHz1VVmF3TpYcPcwqI3W3eqfa3OIvw4pwlrABMQUoPb3nsP9c4xAD
	3CZzmHipydQPxQE84UhUEoDi1jG0dEFg611V2hE3vS1220i4XdOY2HVi2lANTOgbE1HKCcI28CD
	0RxqsOsw7WRlSDxNKDtlVnktj11JdxHAuDSdXF36cE78/6MIkFeQwUV7Ijqgq/446Ty0eNE7ZKO
	SrCDqmNYQP0G+Ny8UtzUEln5kDSNHS5ZC75b2E7k2kBhE/9ny9G1XFySN4ne+trLc3fnvWnGdCC
	SomxlSc=
X-Google-Smtp-Source: AGHT+IEDwglFlhA5go9hbIfKsyVeakB6296g88EgEZVOmF45KZrQmSaZNNkkxZSEw3FDJT2dzivguIu5RBJBgSpUhTg=
X-Received: by 2002:a17:907:a0c8:b0:b70:50f1:3daa with SMTP id
 a640c23a62f3a-b72e053a7f4mr1059273866b.57.1762829577536; Mon, 10 Nov 2025
 18:52:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: ying chen <yc1082463@gmail.com>
Date: Tue, 11 Nov 2025 10:52:44 +0800
X-Gm-Features: AWmQ_bmcyWU386QL8AUws25bKToFphDyeQOauEHesNSm89kwVHLWVzA53k-nyJY
Message-ID: <CAN2Y7hwttMyUn0qsEcSBbrQ1h+aSzNpHMhgAxEbqJZn4vf5hBw@mail.gmail.com>
Subject: [PATCH] workqueue: add workqueue.mayday_initial_timeout
To: corbet@lwn.net, tj@kernel.org, jiangshanlai@gmail.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, laoar.shao@gmail.com
Content-Type: text/plain; charset="UTF-8"

If creating a new worker takes longer than MAYDAY_INITIAL_TIMEOUT,
the rescuer thread will be woken up to process works scheduled on
@pool, resulting in sequential execution of all works. This may lead
to a situation where one work blocks others. However, the initial
rescue timeout defaults to 10 milliseconds, which can easily be
triggered in heavy-load environments.
---
 Documentation/admin-guide/kernel-parameters.txt | 4 ++++
 kernel/workqueue.c                              | 5 ++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt
b/Documentation/admin-guide/kernel-parameters.txt
index 149bfa7..be3f488 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -7376,6 +7376,10 @@
                        When enabled, memory and cache locality will be
                        impacted.

+       workqueue.mayday_initial_timeout
+                       Set the initial timeout (jiffies) for the mayday timer.
+                       Default is MAYDAY_INITIAL_TIMEOUT.
+
        writecombine=   [LOONGARCH,EARLY] Control the MAT (Memory Access
                        Type) of ioremap_wc().

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 003474c..c810b61 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -481,6 +481,9 @@ static DEFINE_PER_CPU_SHARED_ALIGNED(struct
irq_work [NR_STD_WORKER_POOLS],
 static DEFINE_PER_CPU_SHARED_ALIGNED(struct worker_pool [NR_STD_WORKER_POOLS],
                                     bh_worker_pools);

+static unsigned long wq_mayday_initial_timeout = MAYDAY_INITIAL_TIMEOUT;
+module_param_named(mayday_initial_timeout, wq_mayday_initial_timeout,
ulong, 0644);
+
 /* the per-cpu worker pools */
 static DEFINE_PER_CPU_SHARED_ALIGNED(struct worker_pool [NR_STD_WORKER_POOLS],
                                     cpu_worker_pools);
@@ -3050,7 +3053,7 @@ static void maybe_create_worker(struct worker_pool *pool)
        raw_spin_unlock_irq(&pool->lock);

        /* if we don't make progress in MAYDAY_INITIAL_TIMEOUT, call for help */
-       mod_timer(&pool->mayday_timer, jiffies + MAYDAY_INITIAL_TIMEOUT);
+       mod_timer(&pool->mayday_timer, jiffies + wq_mayday_initial_timeout);

        while (true) {
                if (create_worker(pool) || !need_to_create_worker(pool))
--
1.8.3.1

