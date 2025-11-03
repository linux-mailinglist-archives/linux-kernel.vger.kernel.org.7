Return-Path: <linux-kernel+bounces-883379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE6B8C2D45A
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 17:54:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12233461AFF
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 16:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4485A31A7F3;
	Mon,  3 Nov 2025 16:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="VftuqKhs"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81114319605
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 16:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762188496; cv=none; b=WPFEGo3s9a9c05vVY/icMs2nJDk4faCTgkyrSfmKi5JS96IU532ADjWqb6lMJgC5S3yLEVtMOnD6F6Bpb5pAOT3fxpNEu3hl9eTDISLbppZwctbZdktveNUv8E7IegPHiWiG7p4goZdtVHYLbfe+/3VBGsAjurmVYHMccmHjNr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762188496; c=relaxed/simple;
	bh=ufaOl3evv+/LIYt1BotEtyDKPJ6ZcPVXTw/e4bkgr18=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KOhdADMp3DEsaJjd3eIBpfF+MQGbZtoOnp7P6a1dzEOBDIJ2ni5G8ZIjNfLeBA9Y+7ZRVNZLdFtWloRa7GxUs1nFTjRWKHbZA1w/e9RifLNyf5Gxiinv5N+xhMIqZhtAXvSh7coWJDIW4ISpOOa6+DTqaOezE9YiM8A0xAALRwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=VftuqKhs; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-429bcddad32so2567942f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 08:48:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762188492; x=1762793292; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SyYmbonVksmjO4zdrRb5zZMg/W/CIKYJ9eFNKIpVKgE=;
        b=VftuqKhsdGRWaBgVA2eh69BamQ7BgJL1NFaJzbaNB6ivC3EX8NgQz0MUhyWeTFAlAe
         +zQWOOyD14LYCywHOt6UsBIhiHB51H7di+3NEVdnPdnWKb/JqzcDZDh0mGdtKDNLLqDJ
         Rg9K+F9WWPx16MAxD6ihklyxqWYe6hOM/nmmu6Yd32ugg8WF1IvNtBROkbDnzQvdnI4f
         hpsDOb+t6EiiBEVeHu6TwJTJAbGAI4hmEj2/r8QWhDl8x+UQv2yZiCTIdKUpBg/L1m2K
         r80xTkJw+GsVAa/uTu/nOF1iN0n7e6orwTWpZW8WZSKXWU90x8qZkfQHY00qT/dNKeqE
         Bkmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762188492; x=1762793292;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SyYmbonVksmjO4zdrRb5zZMg/W/CIKYJ9eFNKIpVKgE=;
        b=pSGV5TNVW3cZcm/jEGp1nF/xadZARYKf8CmO4GRTJpJoLbIgKupbMgtHSuen30M0HD
         EZAObynSdCbSW8JhlQeoZEnjhjVq3wthg/JRlRg2uhlv8kS6AnpQbi1PdZprOKC8XqYA
         J4cY/VUK4jCGmllhJiDdCdwE+Y0HdK+BJNoOnwYR9vJNUrv5+VXjzphtDT9B2kvd9EOU
         js8b7mt6dl/d1SxHQbc4MHiMXaHZjk3VelEv8Sxn6b0a8URsOZzTiyvwCQOhL3G5aFNs
         PlQEFuYQPKTch1wIondRPxGTOLfMPE49uEvZW/GVg+DIrRZjnHdc0TQd8K8weoerBLli
         Znlw==
X-Gm-Message-State: AOJu0YwxA6jWbTET2BN1yXpox97gWCptTY6YhaqLBSI1TA38B8mLLUXS
	GZKYa5c496KVtabMHrx+7+RkdHc3wYhliulgNgKRmxXT5jDZ1NrobR0m/Ji7K84Tig6xauG796O
	S3dKA
X-Gm-Gg: ASbGncv2/Cy2DXq+vsSDzJVBd4hqnJr9elF+mHAhcjFjz1jFgZn4OWZzGDNRjYnaMMo
	NS5eKTHA0eWbNyDm3oNejdVnqdpIYHljhHoPnJWEMiUY1uF65Pm4xqC2IOqPicHLub7O2acsHVg
	cSbAEUBjchff58Y9XFZ4c6w7/rbzep47d/kHD3nWqQmYTATnSPSUPsRBwQ6nPBJ1Hr9BlJ9gNiZ
	EsmYcKdM9n03efPKD/eTmohMYWE+n6aeNShrMLESX+gFFFL9v3W+LZLO77GIWfgrs9enaML6fKM
	dA5L75dQXGmpsxJWk305eBPKGfM6d6kB5gUSpHJiuSiFJpomz+l/1lKRO6ic/bqADZC04p3R4rY
	8EAUU8pfD6MYdYQnZ9VW1U4GHMOS/dSCPhQgu3h7ggnNeH5gu7iKZNqnGReEficEoW69I3yxQ+6
	xIfiXXbGWp48Fj0G/6zYJY+yj8D60gppBy/qA=
X-Google-Smtp-Source: AGHT+IFc884SvsviOs5LrjoU8X3I/ITy7QFOXG0JfVMfzUC93v8R6MCSY9RxAFBfGaj4xUYdphxHcQ==
X-Received: by 2002:a05:6000:2010:b0:429:cc1c:c2e with SMTP id ffacd0b85a97d-429cc1c0e3emr4859302f8f.1.1762188492269;
        Mon, 03 Nov 2025 08:48:12 -0800 (PST)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429d1061efasm9864899f8f.24.2025.11.03.08.48.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 08:48:11 -0800 (PST)
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
Subject: [PATCH v2 2/3] drm/i915: replace use of system_wq with system_percpu_wq in the documentation
Date: Mon,  3 Nov 2025 17:47:59 +0100
Message-ID: <20251103164800.294729-3-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251103164800.294729-1-marco.crivellari@suse.com>
References: <20251103164800.294729-1-marco.crivellari@suse.com>
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

The above change to the Workqueue API has been introduced by:

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


