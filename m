Return-Path: <linux-kernel+bounces-884650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E69A6C30AFB
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 12:14:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF61D18C0276
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 11:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B83D2E6125;
	Tue,  4 Nov 2025 11:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="YT55sXM6"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93BB2E5439
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 11:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762254834; cv=none; b=McP4qT28dJqoN6EH+pkyWZ6Ax/ZUBhQJvIDc9g8K3A8j1GTMF0yaWhx8AI5vgaKtMOHLR6GGN6O7QONtQKvM3A6qAnG9s6o1sDCrfzEjuqb0RJ4fQz812lept2OTnBJKZDH2HLrfkmstf8SkvBePRL0VO6tTW+rdp2bkI9nd5kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762254834; c=relaxed/simple;
	bh=KA0j3YgxB3XEEM9Ys/NhFXMaqN/FeFIG4+oUH4AOWbM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AOSBCcgHDFaIF0TfEu4f3n1ix9c8iJsqk/M713I+ONHWfx6lm5G8b2scWJBPx2qbWDD8bydbrT0d+3SHEvfPMH7yh5xyRLP4C7qlJc6+XBQnEcYNb4Hsjs9eMCM7xLuuNMzDektPyTX90OPbZskybcNOHtbKm0LRbeFn0xVXgcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=YT55sXM6; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b5b823b4f3dso869618766b.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 03:13:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762254831; x=1762859631; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=s94GaX5ziUst06zKBktu8domBKnJPpNxJWVCWIZ+Hqs=;
        b=YT55sXM6scBp1Wbbqyk/Om7ckPKl6Rzws/3KDoJevh3cEOIPFT9AXhwqy87Kdcxigm
         awJej6+PMo7Fesl+TJtysJ1q2I32oJ/jIkKOGoaMIGC9z66u+umG039KIxJgcQZwnL6k
         TaXOSRLyATqzZIJpk9EXzqgALrL9LWGhD1pn3ycPL6S42IbOhfH1mS2H/leomV6Z0/Lh
         MdDqknKlQrRW81X+2UJ0bgIbKzrDHkiLKQ5n0vGWnco2p74nyKIllZg/3UtmBsbvu1iv
         bQnbF6HPgO2xWHfMUg2zmPQzsyCLU5K06n3nczKQkZzLkK21/xvnQ8hPP7xCemu46i+Y
         P7Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762254831; x=1762859631;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s94GaX5ziUst06zKBktu8domBKnJPpNxJWVCWIZ+Hqs=;
        b=qbtHQwZq5E5xmZ76T0Eu4NkNZzIM7iJuXGDcujplxSuVwUPNgTGf7E6UjSDMHP1x2p
         9Gukz8bRCzktnab16uRMDnv8osrOv6j3WVO4RKMU59IR0xc34ynTcFPFFOBaSRJrxpfq
         M6imxLc5DJFrRww3kIH61Jzm+GfQMcj8msrh+ZfoRrLqyvzrGRuA+/MmcAOpgmS25skP
         qML+oJxZSw7Tw8t+3iIqbW2XgvtppTIqG7816mWeyZIy4EvtSt3KWhhzUQ23hckD/KSv
         jeM+mTZEv/atHNGZ03EwUF2QQoxjyf/QLEsn5LoNO+1v9MjO3/c1fjFG4rGkvfQIL/Oo
         LAug==
X-Gm-Message-State: AOJu0Yw93c+0fKTsJwo230yuYiIXgCRzEP68oghineSNG/94L8iLdqcr
	CfKZJaD/J0yIWGtWg5to9gx6AegbWsB+wRy9jOFlq6hCOtshPz8O0YhiL6Zudbd3sdG4XLQ1Y7r
	ruxLo
X-Gm-Gg: ASbGncvaQDqdAuZdgs/QALghqaS0SSoKTVvfeCNJBPtNY2mE56O5/vUkw7nJY2I5K6H
	olaJrZ8E55vcoIw/ce1djjiOi7iHdzzMQsmt5VtUJ+jvBtsgD5u97qop9tZ3E9ZmpfkDIInI4dX
	z8PunDFH78AL/aTF0JbQUqH7WwscSFwytsVKr7jTbUe2TUMumW/KA23sEce+ii0bA6k7G6kUDFC
	LsOY+dPMcgixlPFf1rtn7Io//ODvbd/BiXBzb/kzwwadMnRaeDGozssFZuwHBcKk1oYeKaBF7ED
	mu+x/QO8+9chITShU3WVJXkMkBxfCEAPS0/QB8oYJ0l5MsUccJ0Va9kLgco6oQhgR7nvhcIj7LW
	7Cq+7UVEBxXvHexh813WAGcQFC/fcASLCsMLdhTdehmCfXrqxtgDNJtcvneHhWxrfOv0wiPDrB+
	VSNEg=
X-Google-Smtp-Source: AGHT+IGIKQ0i7VCw1+VrOGOFsyW3F2C7ehcgVweuycR8D6O6/kCL/ZfipETLPXIUcsBv9LNPdQBEJA==
X-Received: by 2002:a17:907:e8e:b0:b6d:606f:2aa9 with SMTP id a640c23a62f3a-b70708a8b76mr1463526366b.65.1762254830678;
        Tue, 04 Nov 2025 03:13:50 -0800 (PST)
Received: from linux ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b723fa0828dsm184236966b.50.2025.11.04.03.13.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 03:13:50 -0800 (PST)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Robert Foss <rfoss@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Subject: [PATCH] drm/bridge: replace use of system_wq with system_percpu_wq
Date: Tue,  4 Nov 2025 12:13:39 +0100
Message-ID: <20251104111339.128685-1-marco.crivellari@suse.com>
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
 drivers/gpu/drm/bridge/ite-it6505.c | 2 +-
 drivers/gpu/drm/bridge/ti-tfp410.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge/ite-it6505.c
index a094803ba7aa..37bb8123cf9b 100644
--- a/drivers/gpu/drm/bridge/ite-it6505.c
+++ b/drivers/gpu/drm/bridge/ite-it6505.c
@@ -2048,7 +2048,7 @@ static void it6505_start_hdcp(struct it6505 *it6505)
 
 	DRM_DEV_DEBUG_DRIVER(dev, "start");
 	it6505_reset_hdcp(it6505);
-	queue_delayed_work(system_wq, &it6505->hdcp_work,
+	queue_delayed_work(system_percpu_wq, &it6505->hdcp_work,
 			   msecs_to_jiffies(2400));
 }
 
diff --git a/drivers/gpu/drm/bridge/ti-tfp410.c b/drivers/gpu/drm/bridge/ti-tfp410.c
index b80ee089f880..85fa3f8a747e 100644
--- a/drivers/gpu/drm/bridge/ti-tfp410.c
+++ b/drivers/gpu/drm/bridge/ti-tfp410.c
@@ -115,7 +115,7 @@ static void tfp410_hpd_callback(void *arg, enum drm_connector_status status)
 {
 	struct tfp410 *dvi = arg;
 
-	mod_delayed_work(system_wq, &dvi->hpd_work,
+	mod_delayed_work(system_percpu_wq, &dvi->hpd_work,
 			 msecs_to_jiffies(HOTPLUG_DEBOUNCE_MS));
 }
 
-- 
2.51.1


