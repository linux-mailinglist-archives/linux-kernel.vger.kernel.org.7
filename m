Return-Path: <linux-kernel+bounces-855229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 703C5BE0900
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 21:57:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58676487DDE
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 19:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58390305948;
	Wed, 15 Oct 2025 19:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="QLJuXvK2"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A7D304BCD
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 19:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760558238; cv=none; b=iMGOhtGoILSRlSkLxT4YBAiyfKvq/EdnMjkaVPwLNoqWLEDckWlucWXrtmwbTBcCEkpi7Btil3oLJFyx+y3fz4bKz7CQTz+ddQsc/XEg5zLHpbQdkSKWYcgHmCcyeq9hk8JVcZWAz1qpHo7+M6kEmUGw12PXrK/8Y4N6oCRzvG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760558238; c=relaxed/simple;
	bh=6jmAs8WhhU9CSJ3TuowwyM4AJQMjc7pSJd+2ezFEaKY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qhy0phcvoO8QyMUYURwVjcgrSEHYBLRqsyUAvs4Ug3EySYYatOVPuqpTeA58nmrerMjGtyohv/RjFVCx0XTOr+Y5RHATlPFW8b/ypAJxMvPiL67RNPNjmbprbMVr1jeUt53M7ZrQyOUPfCJ8Dzu1NXIAzvNY6O+T9WoWgzJGfS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=QLJuXvK2; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-76e2ea933b7so1524664b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 12:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1760558236; x=1761163036; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2XXJNRa+a1EmBL15srEVpdMPkO8sE1KKJAIBSS6n0KY=;
        b=QLJuXvK2u5p34miN3WCr9VaQ+Ze7c+MaCpZEytu51ZNk2BqUhdP03xpczMJnocoTnL
         qyqFyhvId13B5EMSdlLlSQHwkHZ7VWdfxzRNYuvypJgJbK8HXxnfdbSf1zkxLXbebg2t
         N1ztoCFF4P+9pLS0T0lTzVjmFX1ViIgEw/U+m0r7pDIwanAAGFbBCWgxsufy5cybUKZI
         bF66FB5/KonYJLk/OVHMBz45GHKBm756UPhv8GXeq4SO+MJCzXPoHSxPMpJPlsztvgXY
         v2bHuI9n80EpGiJ0spoyqLERdOiWb1egtMyobRfiEwnb5WXAsUx7TAeQYimqsETKz+Uo
         x6Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760558236; x=1761163036;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2XXJNRa+a1EmBL15srEVpdMPkO8sE1KKJAIBSS6n0KY=;
        b=W66Ol1NniE7VTyAucLE8iYzhknDAIDKhnW24bHNy/2NSCbxWj3B2tIQpfqjfTmiOJV
         yZYo3rALzgyUa6KBQw7cgRQ+1jwfpKInDGnTQcV5ky3fULrIztNTAMlW2/SkHfjUoZqG
         mcDkT5MDjdihrtIs0e2SJkVq78hWHqNwkp5orsJQd8A/2SRXqfJ83Dtg5flrwTZF1TKa
         wf3kXUIqkcB/8WMZPDtiUJefpHri7Y5GeeJW3KW5W/JItuFncSvUrYID0q/OR4zvDocx
         g5nOVKJTyYZwG4WqA6dEozWXAvuBL9Qh5U9Ii9NWQMSyJOH49aVIJUqKEi/QGxxWQE4Y
         /ocA==
X-Forwarded-Encrypted: i=1; AJvYcCUi+6Ct8GyPhzN5RZiA5t57g91hQ4YgqW4sV1l3qNyMejGJkpYpkRokr3/dDTGNrbiqMEHhvWaiYKnuido=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPoMNR1W5SII1hojFx7EW3mPPqb+YfDegDqwxgxuLsjTVG05AE
	MgN+GV4iqI+gr67lx4l8tFC4UzDJr0p8RQbqTlttg3horAolTlJvS9HFTESP6zXqlIf4bgX1Swo
	vWfe5
X-Gm-Gg: ASbGncvB6rrz4l+ihmP3TQ2jnf0+ZKgo3zF1XCs0mOwby2gWU2KqTwTwfWWkoo2PWXV
	xozRfKV3UwnRRR4C90sMoUpn3hipKIlVdCvurrYRCPmsvIbBK0Ino3AszXUJchy/KvnUO9c4Ruk
	2dIheelalir6KVt4BSH9a+KWSLZR59W1lLDAS0vIYVmqtubUR1m6SLzDsj/qe7Sx29ZPh+Hox/E
	bFnpcUXZhmq8aKOVf6XCo9hohq0VNKMuHFEDaus59kzO6TDbvEkztG1m54RrDBhQPFi/Uv/BGP9
	Aj/Mszl9eFWw3N9gstsQyV1SPBfN/p0ns2Y31QLGSaavIVAfBuYiPsqna2nrTWg1gI+Knxs75f+
	mTF0/N0nP/I2w5etEbKLvB8nkgrO6za0CbdXH5Nx+MzZGvq9VpKDkQG+CfteXf3FoDtvTOemc1g
	==
X-Google-Smtp-Source: AGHT+IFYzvKYJ39wIxnM+7RE1dPFgDr4+Lj3QmztieH+Js7P0YTUrQYUELqiUNF31KEmW0OEISH7cA==
X-Received: by 2002:a05:6a20:42a3:b0:32b:8022:15 with SMTP id adf61e73a8af0-33495c20923mr1630846637.3.1760558236034;
        Wed, 15 Oct 2025 12:57:16 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992b06075fsm20151322b3a.17.2025.10.15.12.57.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 12:57:15 -0700 (PDT)
From: Samuel Holland <samuel.holland@sifive.com>
To: Anup Patel <anup@brainfault.org>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
	linux-kernel@vger.kernel.org,
	Alexandre Ghiti <alex@ghiti.fr>,
	linux-riscv@lists.infradead.org,
	Paul Walmsley <pjw@kernel.org>,
	Samuel Holland <samuel.holland@sifive.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Subject: [PATCH 2/4] irqchip/riscv-imsic: Embed the vector array in lpriv
Date: Wed, 15 Oct 2025 12:55:13 -0700
Message-ID: <20251015195712.3813004-3-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20251015195712.3813004-1-samuel.holland@sifive.com>
References: <20251015195712.3813004-1-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reduce pointer chasing and the number of allocations by using a flexible
array member for the vector array instead of a separate allocation.

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

 drivers/irqchip/irq-riscv-imsic-state.c | 10 ++--------
 drivers/irqchip/irq-riscv-imsic-state.h |  2 +-
 2 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/irqchip/irq-riscv-imsic-state.c b/drivers/irqchip/irq-riscv-imsic-state.c
index dc95ad856d80..9a499efdebe3 100644
--- a/drivers/irqchip/irq-riscv-imsic-state.c
+++ b/drivers/irqchip/irq-riscv-imsic-state.c
@@ -487,7 +487,6 @@ static void __init imsic_local_cleanup(void)
 		lpriv = per_cpu_ptr(imsic->lpriv, cpu);
 
 		bitmap_free(lpriv->dirty_bitmap);
-		kfree(lpriv->vectors);
 	}
 
 	free_percpu(imsic->lpriv);
@@ -501,7 +500,8 @@ static int __init imsic_local_init(void)
 	int cpu, i;
 
 	/* Allocate per-CPU private state */
-	imsic->lpriv = alloc_percpu(typeof(*imsic->lpriv));
+	imsic->lpriv = __alloc_percpu(struct_size(imsic->lpriv, vectors, global->nr_ids + 1),
+				      __alignof__(*imsic->lpriv));
 	if (!imsic->lpriv)
 		return -ENOMEM;
 
@@ -521,12 +521,6 @@ static int __init imsic_local_init(void)
 		timer_setup(&lpriv->timer, imsic_local_timer_callback, TIMER_PINNED);
 #endif
 
-		/* Allocate vector array */
-		lpriv->vectors = kcalloc(global->nr_ids + 1, sizeof(*lpriv->vectors),
-					 GFP_KERNEL);
-		if (!lpriv->vectors)
-			goto fail_local_cleanup;
-
 		/* Setup vector array */
 		for (i = 0; i <= global->nr_ids; i++) {
 			vec = &lpriv->vectors[i];
diff --git a/drivers/irqchip/irq-riscv-imsic-state.h b/drivers/irqchip/irq-riscv-imsic-state.h
index 57f951952b0c..196457f1bbca 100644
--- a/drivers/irqchip/irq-riscv-imsic-state.h
+++ b/drivers/irqchip/irq-riscv-imsic-state.h
@@ -40,7 +40,7 @@ struct imsic_local_priv {
 #endif
 
 	/* Local vector table */
-	struct imsic_vector			*vectors;
+	struct imsic_vector			vectors[];
 };
 
 struct imsic_priv {
-- 
2.47.2


