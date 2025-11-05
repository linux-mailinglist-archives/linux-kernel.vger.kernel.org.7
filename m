Return-Path: <linux-kernel+bounces-886262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CDD2C351CF
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 11:35:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A529A3B4134
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 10:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E82B303C8D;
	Wed,  5 Nov 2025 10:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="JzHS0hhq"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24B62DC357
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 10:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762338934; cv=none; b=cYnB1t5NQF31roTTcnIUPsbMh2+ltlD+tFP4uLIvm7MkBFrF7/nnS++EM9PKEayfuZvddkR5IkGQaEEJJXeuJE5+TxICygGjcH0/3S6PLQCniABvMC9PpiC/ZEDkoYVx77vG6MVLAzGatRqYw9e14sh2UbNpfyP+g8JeN4GvYgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762338934; c=relaxed/simple;
	bh=rjKKQg8702Z/q15UoUyi9h1Tzgen7J1IoN9fhR4y/tM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B5LElOa9Uum2lZQF0DGLyVNFxqwRj4OC2u7cUoFYbI9ZWL9M/lkRJ46AXoJscysqaT7hCzccrQIy2c4hohLde6ltD9o6A2fuOT0dYIDFoS6B3PH7K0dYXCtj9CCm42rgirqeRfNO37mJbxcNgs2nKyo447PmgTQZARtVGJtRRrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=JzHS0hhq; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-429c7e0282dso3591498f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 02:35:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762338931; x=1762943731; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ffwDWl1euFeh/d8bsIt6qdslvLQdjZaJDHY4R0/IRhc=;
        b=JzHS0hhqAHPOiyhAA5fJCRDPIp30f86auMJ/o5i+H6Hug015obZM1TwV2mwXmu08N3
         feLuNvtr5h2EyOaXsYdXAZhoU12XiP8kt4nei3IsdoHdxwFap4ZrrpYOQAWAX6jT51yM
         Z36uymj5TleaCsC0BtU0l/L1gcqNWQEzg1RRTR+1KDdMe5tbXDYLjOijSO26IvkiclLX
         lMzc4wf+lAZM2/YEdf4QmGcfOHljqe6xi/9tEnJkXMTGCMI0RoDVy6oZK6EASPBso/lE
         EIbK50NwLOR8U8olHLIB66qEmmBNJfJTxtDkU760bVWOscBctMUjhibZ8o57IKGSvLgV
         IAsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762338931; x=1762943731;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ffwDWl1euFeh/d8bsIt6qdslvLQdjZaJDHY4R0/IRhc=;
        b=O3F22Nf7BH21iJHNamuIFuPI2W2gWiturgjRu+sZZ5ulTgGYKTO1B0HRiVBpw3CVoO
         f2Z4VDVJfxlHiqcOIZNz0eqVdCqoh45gdL738Y3DobTej+3ThgSX3dTmnclk6X6OgWxW
         0AGPyCQqlZ4WqroApZ30bSyazig7Sucnqr5QG0r8B8ZuXyinXs5DsUATu7CurFHw2Ukk
         WV12j8zjw1POGVQeIHCeD5IFUFaauaN6gboAnn48iWvKl8IqkxjaMbG9Yu493Yx03tbW
         SIQ41OkEjaIYbJHXx+jTjZl9hmE50mGUUgNE7B/CHd7HYAYNQZgm5FPIruYbSdPjrZnW
         rtdA==
X-Gm-Message-State: AOJu0Yy7Djia6Gb5E4wmypiRpWgeWTtU0BmYn3sBW1cP1V6EVnEjmApB
	zhYpp5Sgm/pObH6wu/btinF3nc2Go5D2maIfVD3ENNU4NemK3hI+65A/j0oKaAVhpalYnkAqWJ6
	lxV4T
X-Gm-Gg: ASbGncsu+pZup2htdJK49LpwCU9aKqZmR6y4RADeDH6R5AxiRswvwOX9XXcCDVD3e6+
	HRmloAMddRSpbPiRA5cbKw9Z5TthLjX5agvD6RDk5MQRZ2E7jB5T4J4jicfTlHRhDCQt32nZgSq
	5OMjTWJEAb0rJ3pe8o+XyDK/IqqJ7h9wEP8zv8Hr1ONNbBIZpDOAERnqEc2dsxa1ryX+kP2aeqO
	jKnCf6jCxz08LZvEzscdv7Vzm217nZ4WhYdWtypy4b9Zs1P17aNOLYOMCjqVTCaJFHrSFsMyJb7
	3BjarAgoDtUg8Vsx+f6C8vUlnY6WKSV4FxH/jZzkVqOhnyZlyWkJ3SV12SZnbVDacQnY6jH0J3g
	YuwSZUkdnUHkTGJz6tSqckV3N73cYM/FrYJ4n03qNT2sgRcjYUIR59Ztf8XJzOQiSwKZAglFOg/
	W4s906jHScNJIx/D4c/M3qZKy6
X-Google-Smtp-Source: AGHT+IGaL1j/3biV0s8/NtYNyEyD52bRBIDAi40lrDnOzt9fFjIECkbDJilQHsfXNsb0YmXEFx5KNw==
X-Received: by 2002:a05:6000:641:b0:427:603:715 with SMTP id ffacd0b85a97d-429e32e468bmr1635523f8f.18.1762338930842;
        Wed, 05 Nov 2025 02:35:30 -0800 (PST)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429dc1f9cdbsm9924053f8f.34.2025.11.05.02.35.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 02:35:30 -0800 (PST)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 1/4] Input: gpio_keys - replace use of system_wq with system_percpu_wq
Date: Wed,  5 Nov 2025 11:35:20 +0100
Message-ID: <20251105103523.103622-2-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251105103523.103622-1-marco.crivellari@suse.com>
References: <20251105103523.103622-1-marco.crivellari@suse.com>
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

system_wq should be the per-cpu workqueue, yet in this name nothing makes
that clear, so replace system_wq with system_percpu_wq.

The old wq (system_wq) will be kept for a few release cycles.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 drivers/input/keyboard/gpio_keys.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index f9db86da0818..f3fcb1f4d26f 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -434,7 +434,7 @@ static irqreturn_t gpio_keys_gpio_isr(int irq, void *dev_id)
 			      ms_to_ktime(bdata->software_debounce),
 			      HRTIMER_MODE_REL);
 	} else {
-		mod_delayed_work(system_wq,
+		mod_delayed_work(system_percpu_wq,
 				 &bdata->work,
 				 msecs_to_jiffies(bdata->software_debounce));
 	}
-- 
2.51.1


