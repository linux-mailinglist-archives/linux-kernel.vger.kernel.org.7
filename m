Return-Path: <linux-kernel+bounces-884545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9354C3065D
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 11:01:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 617C51885E88
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 10:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0723306B0A;
	Tue,  4 Nov 2025 10:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ayOOUCNo"
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A9C2D322E
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 10:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762250452; cv=none; b=L1qDzP8WP/ivBhECDb1UsiQFxQ00A+KvXjQJ6+wFQQzs3A6ml1wYsya4EIXwvTBvzECWven1d/SzCEiwmx50tuVI389fHmEF3Rt60kwl4gdakxFBDfUaOKQ4irvLSfpm4Abjr2rnhOoxk6jjtt1oz9nknk98RDEW6WjigW/96Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762250452; c=relaxed/simple;
	bh=AmM7ZCUqIUY91uQc2VN4Cs6OE5TimKGjh6qzDxFqB/U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E6z0d/Ue9+MEzimslhaGQtRViNiCVjc1dOJz0WBWGyUJU7Ma6GY3Ip3SVa7pXKnR4qPljaxU+Ju05tqmDjLQw1zfUeEvbnDjUL4IgM/3IZt2WniJWvavyMzxUd9bDixlEb/g8knBtLpyfvQB5vrPbolwOS6oXihjJjCSzH82UYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ayOOUCNo; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-475e01db75aso33294695e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 02:00:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762250447; x=1762855247; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+YWljBZFP2887OuvpstRsY0qgr/ICFMYNoEOshswZBI=;
        b=ayOOUCNoj5nvLuZP4TuLGRkpjin30xb7r5Z4eAcynSdyl8PGWNjjUt39pv661cSlFo
         A4YdY4T9aS+3kQlVo/ahBbv1iYziHJplRkSZPejpbHKY7TcpkrHezY9Y4Sa0MiG7vbz+
         eIHhlWcQ+kJThnzm5d63vBOixXZeOqYrZQ8c7djXZImBcG9o4c59fPiuhgvkUaAL//xk
         VEmIc3tHuSrvWV+wLWzf2RYJu23UC+JPGWa3mMKEqpBI6c3ogsQbGPuaXmV0w3rpRerW
         mrkWNEJ4txi6a3FNjrKExcv0Fy40lIkqbEK4yC1kLuQtw0KDHwKyY9mWf8H8oP8bb9N2
         pyNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762250447; x=1762855247;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+YWljBZFP2887OuvpstRsY0qgr/ICFMYNoEOshswZBI=;
        b=MnK02rrmc3RZip4we9wHS6PIUV52Phj33JJRwZ6XQZu1s/xjfgjDFwoBGvcyR72fDL
         5r7gf07XneqFaDePAtBtOjjwP2iKuKiJvapU2977bFMimJ4hPBdnTTb+8+5LnZ4WQaYa
         3FlQOD8T92qPmi/kbrMr8oAiU5/6dduWSG7luxn66sjhsDx9BN3mi5ZBCxqAmomp577L
         9JR9JgsBYraITh2qzhh4Tez3OP5QmzBJVFRd/xYsQ/tJou8F5/YjskXhRqk4pavvwOhk
         KrTDSrB7KCtb60Ovoyux4HcZqxHhnBt/rEVtWa4ohYkov7HqHVUXjmaDsvTsIB232EC0
         FvCw==
X-Gm-Message-State: AOJu0YxfFvMolXhHP1s9WhpDQggV2TxGQOotTsS2e2Brv3n2c7SR5T+0
	1u1LrLh4YuU4/jjD4NRIPTCuXlBjmdlI21j0sFvSpiNQWwjLtrXal0crMsNE8AeVzXaodS1ASnn
	03g2fqn8=
X-Gm-Gg: ASbGncuTUUSU04D8oRo7mfkOrJPhSfNrDUn1BuXccG2t2ZxAcA56Pe4YAAiBURMPVDO
	sEa1UjOgxqnLTMnGkGNFwuJ51F1z/32zusErMEo4hQGbV6GlaR9xq5nfkFjogjmO3jgsYRkvdZV
	ScsepMZw/G8Hklw5SGkxRWpjKbXuHrgb1UdD0nMlvvl81ZvKBqItRa5mpOmTvcLL65x8SIswN87
	0X3tk9xVPg1evLeL0+s+wIBmkEZQj1XBE7WjZoLpCoGkijdRdWTCjWq0VcgkXqJT8srpib4thTt
	cLRqYtwmmdRRFvEJ/wY2CpsqomoUDUE8UGxKztGnLsyqp25YJRNqV2K2tYRBVuIauydR0DYtoln
	/i1frTcQ5onaSvO9YcsKbi0SnnLjVp1KcrBJLzrGoTU/iBthaqItZ2ldbedVW0ItcueAIF0auSA
	KeE/85JlOQhAC+dbRspH2a6Ez8
X-Google-Smtp-Source: AGHT+IGvS7J2hj1U1MzFKWpFjl4ALAZBw0xlOFIDItGj9fOM4XvJHZNMdTDM/EPubX5EUajXp8ZbNQ==
X-Received: by 2002:a05:600c:8b66:b0:45d:f83b:96aa with SMTP id 5b1f17b1804b1-477307c1f31mr164394635e9.7.1762250447236;
        Tue, 04 Nov 2025 02:00:47 -0800 (PST)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47755942772sm14325865e9.5.2025.11.04.02.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 02:00:46 -0800 (PST)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Krzysztof Karas <krzysztof.karas@intel.com>
Subject: [PATCH v3 2/3] drm/i915: replace use of system_wq with system_percpu_wq in the documentation
Date: Tue,  4 Nov 2025 11:00:31 +0100
Message-ID: <20251104100032.61525-3-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251104100032.61525-1-marco.crivellari@suse.com>
References: <20251104100032.61525-1-marco.crivellari@suse.com>
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

system_wq should be the per-cpu workqueue, yet in this name nothing makes
that clear, so replace system_wq with system_percpu_wq.

This patch continues the effort to refactor worqueue APIs, which has
begun with the change introducing new workqueues:

commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")

The old wq (system_wq) will be kept for a few release cycles.

This change only update the documentation of drm/i915.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 drivers/gpu/drm/i915/i915_driver.c | 2 +-
 drivers/gpu/drm/i915/i915_drv.h    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_driver.c b/drivers/gpu/drm/i915/i915_driver.c
index a28c3710c4d5..0f33cdc11736 100644
--- a/drivers/gpu/drm/i915/i915_driver.c
+++ b/drivers/gpu/drm/i915/i915_driver.c
@@ -140,7 +140,7 @@ static int i915_workqueues_init(struct drm_i915_private *dev_priv)
 	/*
 	 * The unordered i915 workqueue should be used for all work
 	 * scheduling that do not require running in order, which used
-	 * to be scheduled on the system_wq before moving to a driver
+	 * to be scheduled on the system_percpu_wq before moving to a driver
 	 * instance due deprecation of flush_scheduled_work().
 	 */
 	dev_priv->unordered_wq = alloc_workqueue("i915-unordered", 0, 0);
diff --git a/drivers/gpu/drm/i915/i915_drv.h b/drivers/gpu/drm/i915/i915_drv.h
index 6a768aad8edd..d9f73b9995cf 100644
--- a/drivers/gpu/drm/i915/i915_drv.h
+++ b/drivers/gpu/drm/i915/i915_drv.h
@@ -256,7 +256,7 @@ struct drm_i915_private {
 	 *
 	 * This workqueue should be used for all unordered work
 	 * scheduling within i915, which used to be scheduled on the
-	 * system_wq before moving to a driver instance due
+	 * system_percpu_wq before moving to a driver instance due
 	 * deprecation of flush_scheduled_work().
 	 */
 	struct workqueue_struct *unordered_wq;
-- 
2.51.1


