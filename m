Return-Path: <linux-kernel+bounces-884671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E092DC30BD4
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 12:29:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 113164E8BB4
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 11:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B3532EA14E;
	Tue,  4 Nov 2025 11:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="EsxR5tmn"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C262E92D9
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 11:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762255781; cv=none; b=gNeeWmG5+r/4w4hwIrykS9EaSI1qEuJL6CPDeNL3jeV2GikiuuKWSxe0ys2sJdr/FN0+bck3+vv1ikU0ZMaNv/wzUmEZizUDNT4d9ckphzVjP+LyeDft85zMsljyHBfjReNXgYFU2YXEUYSd9pIHbSGzOS8M6LQaC9jjTx9l2hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762255781; c=relaxed/simple;
	bh=wyu+RYWCNS/h85oh6x6201n2b4N20mGIx1Xo71VnQMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AkvWMilKfnC4N0o9CM1Vz1w2JVJxpTJwEs5wO4/MGA6AbxYSnLVtEKHtazZO+W3fCN3HJweAX+EzEH2c0NwZ/NCw6ooRGVH7mV8aZ41prrqXVVWgNyEEOjWr7BfhVpApceHJ5a17CygGP0exMrHnbCAkL/e7GFQExH8AHpFgn5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=EsxR5tmn; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-64034284521so9334319a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 03:29:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762255777; x=1762860577; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/6U30xhVv6V/OllWka10lpmVdIsxk7KF/mWNRD7vXBM=;
        b=EsxR5tmnegjb81RpjEbPmu4SumcHDqxzR7SiABr7Anwm3SazEbzGVBi3didtpzY+0N
         tWSys4MLg/s5isT40HtbMfve0nLsB6OzasXL8u0aSXjmUQlOG7pCyuRI/DVa5fgYHJFM
         4ivRYTN75OkLbgV1JpLOHoSQ9FttuTqnsBDTihdASeXk45YeSgUSmgqJ+OuVHS/jDes8
         dYCe7PH/JXkUoy+M686vWUpSggR1QJwV783pSbVFlOuosJtQw+PZsgxPr2xG5XUT3H79
         KjylqrVaz6Qxy73Yj+QZEO967cVddmcRTLiiiuXI4uMlxzb4GevbBc9dmYnFVjjtt/cB
         JD4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762255777; x=1762860577;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/6U30xhVv6V/OllWka10lpmVdIsxk7KF/mWNRD7vXBM=;
        b=ohdpDp/Wxfo/mBYI8a3epQISveSVUMs4wEpaxyGUWUeQf9MxgdQCHQbs3dLPur4UiO
         e20qmWyNoDanrIm4qMURU65Z7uWB1si8z1A17u/s8G0Yp87jSWeGzQau/OQJint+pC52
         Mn86uNYxWX0WFpXnh0WmNjxT6iZUauo5zZR5KvZv5xaSdC8aTinrssp+ieMsSa7DBrgt
         ekHGRkQ7Csc3CTQyi34sFbTKAjKyJsIPylgVuTOWKO8GYR3IpL4RW/C9uq7D2WO/aGC/
         yddP7/LmsgeWiXmTcwiLSykH1Q5wqZ34Vk/XuCCSXCZIw9cZ/urmWkQBXvB+9xsXOjzk
         9+SA==
X-Gm-Message-State: AOJu0Yx5db1m8ohTWEd+4oPZeFro1FWU6wlUh67B7nLFZd97qurSVatm
	B8ynkLnjsCAVke+P+PMAxeE6XMp7Gjp6DhtzFn5nzCS9mJvPdPjoRDaP0uAy16GcKrHCllSICcw
	bFX/s
X-Gm-Gg: ASbGncurkxuueGyVyUeuOgclqBhUCCgR4gRX93FJQ0Tg/DBcrtdjHlQh1YXVAyCYpkF
	nUEmoLduNVo6OOCaxB5izqq0NqYS7ncpfMb2frxhTNzNTe5lBNBJkDndQdodsepDrWrKqyx/Wn6
	Ba02x464zboitvm843Qmkd3WkQYKXZZCH1UN05QV30tioTS441IRWWQA9X8exp55d+gwLckYETm
	/9zSQ4iBQA/itNuktIMHkIeJc5LxaIzm/fks3NXmcz0x+DdfbbONYNYbPxJuNK5sTCWy7MqDR46
	RsWH8LuQLNWM8w4VOH0zsNoBB1+7sg18oQdnKoq6YxL9TlN9fKpbDRhhVxbcVhbSK/6AfW2iEoY
	TNEB3V1f+jjeZC/xH4Pb+EUsn9i00+PFMCrFUkfOz9LauedEAeZcdtez8pSkXV6ySuXNUODOhPv
	AlO9Y=
X-Google-Smtp-Source: AGHT+IEH6YLnLzKBUaOBrPF+gt/Vwu3vr6ZVwfIBKjg5lysKKReAoUvEVvkYcdEX36hZw8BRX3tIXQ==
X-Received: by 2002:a05:6402:26d6:b0:640:a356:e78b with SMTP id 4fb4d7f45d1cf-640a356f0e2mr8579226a12.7.1762255777493;
        Tue, 04 Nov 2025 03:29:37 -0800 (PST)
Received: from linux ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-640e680578esm1820370a12.10.2025.11.04.03.29.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 03:29:37 -0800 (PST)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Inki Dae <inki.dae@samsung.com>,
	Seung-Woo Kim <sw0312.kim@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>
Subject: [PATCH] drm/exynos: hdmi: replace use of system_wq with system_percpu_wq
Date: Tue,  4 Nov 2025 12:29:23 +0100
Message-ID: <20251104112923.143408-1-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.1
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

This lack of consistentcy cannot be addressed without refactoring the API.

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
 drivers/gpu/drm/exynos/exynos_hdmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/exynos/exynos_hdmi.c b/drivers/gpu/drm/exynos/exynos_hdmi.c
index 01813e11e6c6..8e76ac8ee4e2 100644
--- a/drivers/gpu/drm/exynos/exynos_hdmi.c
+++ b/drivers/gpu/drm/exynos/exynos_hdmi.c
@@ -1692,7 +1692,7 @@ static irqreturn_t hdmi_irq_thread(int irq, void *arg)
 {
 	struct hdmi_context *hdata = arg;
 
-	mod_delayed_work(system_wq, &hdata->hotplug_work,
+	mod_delayed_work(system_percpu_wq, &hdata->hotplug_work,
 			msecs_to_jiffies(HOTPLUG_DEBOUNCE_MS));
 
 	return IRQ_HANDLED;
-- 
2.51.1


