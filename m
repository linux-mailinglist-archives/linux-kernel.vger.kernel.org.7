Return-Path: <linux-kernel+bounces-886650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 48902C362D7
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 15:55:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EBEE14E475F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 14:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B898D32D0EA;
	Wed,  5 Nov 2025 14:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="FeFHczlX"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0237245008
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 14:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762354259; cv=none; b=mEjdaZAyc3hqj8yjOHLze/NzE1Ofewo10KX4BRer7qF20IZysWR9FAnkzcJTPmTQqf2TRtHcTODRdBYjVc19o9/Dif9MVmDKsL28aour7wR5OXnWc4NSqToLBW1scTUs23ILu6mQmE15UXFgdsHWE8qEb24LTedMzWsoHrrCIG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762354259; c=relaxed/simple;
	bh=Kzf3O5Pfv0M6xSM+kEXKJUJ8D5H545XidDJ6k27PEAc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WYhuAgEVFwvcZxxwm6QT3AeLf9C2hNE1S31SkvJnSCWgYcGrlR2XSKrn1AJObADBT+x+6dcNgOQx/F2Uyf0+vyyXMSgR1396NsdN9uEMgNmdz2+aYI+PqwF8tM36Ih1EvbW6+lx1eIS5mvImW76FWFWrAExKvivpqK2G5JU0h7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=FeFHczlX; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-429c2f6a580so1685184f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 06:50:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762354255; x=1762959055; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5iqpU7301ZddzKgkBJ5b+qets1xyPEBx6ArgKTOvQVg=;
        b=FeFHczlXxH385gVhfQit/crSWV+w98r5GrQopgF6J8k1z2JHuflftFGcZffBvnVi93
         orO+1P0yiNznRWjwbovh+mznlU49lLk4izxM102Ngm74DX/1rTyg7oX0shELO2psy2Sk
         jWxTTfgTmGF+eaEZWBiL1NxahyB2WLX1gh/EbHQvu7NdeNP96ZaWmJeC0YaWPBYgupNi
         z4rHxZ6UzgRaAxjbAOFaR6DtvC2tmdB/PZbBBDA9UcECRGg1/hjl5oFt1Gd/qm+aFIsN
         DZJfnzitFyO8PYXuVlOut5Hr8mm9Xgk2ohGwhGfgjC//u8QBMH28d7PxvYsyGO2Zkw9A
         iZTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762354255; x=1762959055;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5iqpU7301ZddzKgkBJ5b+qets1xyPEBx6ArgKTOvQVg=;
        b=mVdUNqyS2MI3KCOP9osFAUi+UGNSqvsntoPdfa1JHppHqc1HxiZng1G4wZl5/QgJ9c
         U2O2slWeEnFH8alUFtick3SgPlDchubfF64J3Rk+BEdaUUBaatgxlunQC/twXRyOIfxV
         GQzos3HBOpgfxgMX1VV2m98eRAlsjoZSthqtzaTayqO4nzyWLrRfQ341tOTnYkLer6P0
         WK8DbRgVWbr4KvW3NETetOIOcRmI8MbX/EUvOTfMfTNZbh+EycCClYgHTI+RYTQM0lDn
         ULkcPif6wsBHPBuaLRbXriV7RDsvYJPRqnGWDaVWSR1y8LNDK7Th8JGzuCu9+DXNiSAL
         nZIg==
X-Gm-Message-State: AOJu0YwEIcuzGL/5d0EDKlXCLTkWD07pLwbzNgQDa0HHaXD/egc6EQrD
	i9lbruI0w69h9vfX/Ah8fFzU3+/I5lYFK4bKWhc/qfQ+hDkUMIt5cpDfcgFcoCWoH7rZ4nuCFzm
	5eEer
X-Gm-Gg: ASbGncv14WLAjHgw0A1r3aYneq8zeNwotB/rdybz0z1sGPCnfQPHIpSXPzjx8JWd4t9
	0fIHMcATWRb24JjoQOnW8Hz+LTL5agSS7y6pl0hUKNEULeglYN07idOmHNPPBzfyKirbC4BBP3Y
	UNN3IxgACmeI2FMm1/jT5uptrXKyoami5NrVXYobOPVPz/WISotKbcjLIwwxhfdgqgbr45LNB8m
	2soxRjS9URpf5KKvTi3IJeg6YLPUxD+N4A/RnrgoddKRvnkFniZ/ApnPVEZAwwFYG2Hxifkc6Mz
	q5V+SBBEQMemV9epwUmFu+hv8C5nluY8yN0TFR3PHEEyHyreUWLBVuKE25UzW1hJClGh6fFPhHa
	proJ/PlXje6ooMlykL82pslzHHt0TTCiarx8Wm4WWmqhlGBCmXAvl8yaedN3DL4DabHuNBVvVOa
	gF8KBrR0VNJLBpKSSb7uDiUY4=
X-Google-Smtp-Source: AGHT+IFrhRlSR2BV3K3SsNYVanRi/LbVHaUuwWiyIlYFXbJgyiRM66Wm0VZiulUCa1X98AgblCJWxQ==
X-Received: by 2002:a05:6000:210c:b0:429:c851:69b3 with SMTP id ffacd0b85a97d-429e3307472mr2299746f8f.30.1762354254929;
        Wed, 05 Nov 2025 06:50:54 -0800 (PST)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429dc1f5ccasm10662873f8f.25.2025.11.05.06.50.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 06:50:54 -0800 (PST)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-bcache@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Coly Li <colyli@fnnas.com>,
	Kent Overstreet <kent.overstreet@linux.dev>
Subject: [PATCH 1/2] bcache: replace use of system_wq with system_percpu_wq
Date: Wed,  5 Nov 2025 15:50:42 +0100
Message-ID: <20251105145043.231927-2-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251105145043.231927-1-marco.crivellari@suse.com>
References: <20251105145043.231927-1-marco.crivellari@suse.com>
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
 drivers/md/bcache/super.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index 6d250e366412..8ce50753ae28 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -1388,7 +1388,7 @@ static CLOSURE_CALLBACK(cached_dev_flush)
 	bch_cache_accounting_destroy(&dc->accounting);
 	kobject_del(&d->kobj);
 
-	continue_at(cl, cached_dev_free, system_wq);
+	continue_at(cl, cached_dev_free, system_percpu_wq);
 }
 
 static int cached_dev_init(struct cached_dev *dc, unsigned int block_size)
@@ -1400,7 +1400,7 @@ static int cached_dev_init(struct cached_dev *dc, unsigned int block_size)
 	__module_get(THIS_MODULE);
 	INIT_LIST_HEAD(&dc->list);
 	closure_init(&dc->disk.cl, NULL);
-	set_closure_fn(&dc->disk.cl, cached_dev_flush, system_wq);
+	set_closure_fn(&dc->disk.cl, cached_dev_flush, system_percpu_wq);
 	kobject_init(&dc->disk.kobj, &bch_cached_dev_ktype);
 	INIT_WORK(&dc->detach, cached_dev_detach_finish);
 	sema_init(&dc->sb_write_mutex, 1);
@@ -1513,7 +1513,7 @@ static CLOSURE_CALLBACK(flash_dev_flush)
 	bcache_device_unlink(d);
 	mutex_unlock(&bch_register_lock);
 	kobject_del(&d->kobj);
-	continue_at(cl, flash_dev_free, system_wq);
+	continue_at(cl, flash_dev_free, system_percpu_wq);
 }
 
 static int flash_dev_run(struct cache_set *c, struct uuid_entry *u)
@@ -1525,7 +1525,7 @@ static int flash_dev_run(struct cache_set *c, struct uuid_entry *u)
 		goto err_ret;
 
 	closure_init(&d->cl, NULL);
-	set_closure_fn(&d->cl, flash_dev_flush, system_wq);
+	set_closure_fn(&d->cl, flash_dev_flush, system_percpu_wq);
 
 	kobject_init(&d->kobj, &bch_flash_dev_ktype);
 
@@ -1833,7 +1833,7 @@ static CLOSURE_CALLBACK(__cache_set_unregister)
 
 	mutex_unlock(&bch_register_lock);
 
-	continue_at(cl, cache_set_flush, system_wq);
+	continue_at(cl, cache_set_flush, system_percpu_wq);
 }
 
 void bch_cache_set_stop(struct cache_set *c)
@@ -1863,10 +1863,10 @@ struct cache_set *bch_cache_set_alloc(struct cache_sb *sb)
 
 	__module_get(THIS_MODULE);
 	closure_init(&c->cl, NULL);
-	set_closure_fn(&c->cl, cache_set_free, system_wq);
+	set_closure_fn(&c->cl, cache_set_free, system_percpu_wq);
 
 	closure_init(&c->caching, &c->cl);
-	set_closure_fn(&c->caching, __cache_set_unregister, system_wq);
+	set_closure_fn(&c->caching, __cache_set_unregister, system_percpu_wq);
 
 	/* Maybe create continue_at_noreturn() and use it here? */
 	closure_set_stopped(&c->cl);
@@ -2531,7 +2531,7 @@ static void register_device_async(struct async_reg_args *args)
 		INIT_DELAYED_WORK(&args->reg_work, register_cache_worker);
 
 	/* 10 jiffies is enough for a delay */
-	queue_delayed_work(system_wq, &args->reg_work, 10);
+	queue_delayed_work(system_percpu_wq, &args->reg_work, 10);
 }
 
 static void *alloc_holder_object(struct cache_sb *sb)
@@ -2912,11 +2912,11 @@ static int __init bcache_init(void)
 	/*
 	 * Let's not make this `WQ_MEM_RECLAIM` for the following reasons:
 	 *
-	 * 1. It used `system_wq` before which also does no memory reclaim.
+	 * 1. It used `system_percpu_wq` before which also does no memory reclaim.
 	 * 2. With `WQ_MEM_RECLAIM` desktop stalls, increased boot times, and
 	 *    reduced throughput can be observed.
 	 *
-	 * We still want to user our own queue to not congest the `system_wq`.
+	 * We still want to user our own queue to not congest the `system_percpu_wq`.
 	 */
 	bch_flush_wq = alloc_workqueue("bch_flush", 0, 0);
 	if (!bch_flush_wq)
-- 
2.51.1


