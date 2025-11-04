Return-Path: <linux-kernel+bounces-885173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E2A2DC322C9
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 17:57:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B62D54E1773
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 16:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC8262741A6;
	Tue,  4 Nov 2025 16:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="A3fsDUGO"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE8926F2BC
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 16:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762275462; cv=none; b=N0TDz9mf8YQIwc2rggE+4cNXlarCfrpPu8EqPFQ674GvMvl6DpBcbbbVvFatr4gT/jRuS3ie2RJ+cRFmS3wyKyUvVF/ygVPJTYW6iTTbxpeBfExlNOWOX8+F1VZW1dD1nz+UTywVBXH2dDL+irk3vR8IsR7FvB8UDgy1362GUi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762275462; c=relaxed/simple;
	bh=o8FqlO06ubllWjKtbFv1zSp4RKwOXKUun69Md/ejx8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=usS6vzVv/6SeZL2vjNiigOYtqhpYNA6j46JAlqCEvXBkI87djT79B3wFWyPrSdrfngOR/BAebI9v30taH4kYCs801iH5RXaLeiMPbHd2/zW28D3AKICupmKOQYg1oBfRvSshpMMhKM6REPSR7m5prvQZI/L3xT2QVZKHGvgrjNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=A3fsDUGO; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-47117f92e32so47294495e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 08:57:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762275458; x=1762880258; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mlwXBKKEiD0RmcIOKolsb93Y5R8skb7DhUMfXKujcjY=;
        b=A3fsDUGOSXvE6NQ84+Kxhq0FXnREnGzf3h++B0uGcmopWRVSpXErVzy5qVI50lyvCD
         ts6lfH9IaWd9NODw3qP+q2rSMNGH1l3ErdCC1QD3C79pV202kFUzwyzR3J50dQ14eJ1y
         Gdvty6RH2RwZRZjm+0sYYBsKgoIQtEfgAVpUhpyg8/eZPxBmk1aQI/GHiReWWjAPvTXG
         d7OCk0tuxClVIErZV4zDcQsDUe7/R8SQa4sXRTb3Eaai85CkbdJrPeRi3g66JazneKWS
         ucVJfWO6RyvwRV7tc1MNzrPPXfl+H2j9zDvqW/5Ciz6jQkHqUHQmYFoYvt5C4GLiOaP1
         xh7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762275458; x=1762880258;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mlwXBKKEiD0RmcIOKolsb93Y5R8skb7DhUMfXKujcjY=;
        b=al15y5tg63nZEv8DjTeYmaZK+x6dbtD6UaK7tXrmhpFniBXZwtX/0FfKBDlHJr4CSm
         2CuDZFQVGBEhwdMdUfJsjLwerHpidEsp6vVonDBHmGptKQwZNz+/1794agMAhEwFqL2+
         TEbBTb+vtY+J1qznxsR4cn0UKXgob/mPlzwJbKt9xz51a5ne9z0gkJ/DoWTGthowQs3U
         /fc3A4gXXBuIUJVpkBNZWcSRUyFV5TvCXIyqnfUlZDbB1a3ZZp+YQqlE6R+hbuVMy9DB
         R4q+m36+AOMEPXPygO88lxJh2nygu8Iqwrp5vuWIJKq8b17KWlyjBkkfUcyusJgWcZSv
         J4bw==
X-Gm-Message-State: AOJu0YyNL37TN3C08dSwNtWsQxO9SHYXlKDU5LpHZYUyE9AZPJrzeSl+
	GACxwY/fkSwP/Mok3CVM7+foIk2HVdVfu+VwPQzSU36oYD0sl7TWM+fnz3xpBiK/pnbL9k1QE/y
	MmF1g
X-Gm-Gg: ASbGncu6pARFVB6YEADbjjMXE79HbpxpmeEqco00v+k7VdJFpSx0VAJaUea74iJSip3
	xHPDAsIzqpOlMSk/lAVQq5bY9m1c+FsEiwzwR1JPffJLD4/vQLjGiLC/Qi7rCkBy4f0ob3RQdUv
	9326ovsdg1ceKZMnAQ5p5isV5WmdedL9g4n968MFvoHzJV/tJ8JMU0xLu6jNV6gOWUTubCDHcTj
	ntTL1Cx4tFehq4E/7j6qL2LNYzbk6vixAqAWC0LgUH4JU524bmlOCXlh+tPMjEqah81Vh9V9Bwf
	xIDHl4vPo+ZyRBjZD6mbaWXM+fczYQbQ49dU/+84UAnnTNRZ7cJPOGiWbuVtB8DHLp+y4DKMQWw
	jMgLfPdDXODUs6+AQcWR2h67dEJCfH5QP+06KOFsAHCaMU6cfZI6nQBUmrB8ceTl0UhMVId7juK
	7zJq9/FoFhBmURWhhhiJT4CWs=
X-Google-Smtp-Source: AGHT+IGGpxciVU3IC52UvqvLQu7qBBlz9I1KHZxvhIU86nWuSc4WQ8BUqYR3aWCctDbQWiX1UN664A==
X-Received: by 2002:a05:600c:1912:b0:477:1622:7f78 with SMTP id 5b1f17b1804b1-477308a5e56mr150921885e9.40.1762275458183;
        Tue, 04 Nov 2025 08:57:38 -0800 (PST)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4775cdc2d14sm200645e9.1.2025.11.04.08.57.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 08:57:37 -0800 (PST)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Jyri Sarha <jyri.sarha@iki.fi>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Subject: [PATCH] drm/tilcdc: replace use of system_wq with system_percpu_wq
Date: Tue,  4 Nov 2025 17:57:31 +0100
Message-ID: <20251104165731.315074-1-marco.crivellari@suse.com>
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
 drivers/gpu/drm/tilcdc/tilcdc_crtc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tilcdc/tilcdc_crtc.c b/drivers/gpu/drm/tilcdc/tilcdc_crtc.c
index b5f60b2b2d0e..57518a4ab4e1 100644
--- a/drivers/gpu/drm/tilcdc/tilcdc_crtc.c
+++ b/drivers/gpu/drm/tilcdc/tilcdc_crtc.c
@@ -985,7 +985,7 @@ irqreturn_t tilcdc_crtc_irq(struct drm_crtc *crtc)
 				dev_err(dev->dev,
 					"%s(0x%08x): Sync lost flood detected, recovering",
 					__func__, stat);
-				queue_work(system_wq,
+				queue_work(system_percpu_wq,
 					   &tilcdc_crtc->recover_work);
 				tilcdc_write(dev, LCDC_INT_ENABLE_CLR_REG,
 					     LCDC_SYNC_LOST);
-- 
2.51.1


