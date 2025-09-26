Return-Path: <linux-kernel+bounces-833759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ADE8BBA2FB1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 10:39:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BF99324083
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 08:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB51929B20A;
	Fri, 26 Sep 2025 08:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="GJCz4KeU"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34D4291C1E
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 08:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758875940; cv=none; b=sBP8jzRIv+sI+cE35aoPrtGXF3RaLpwJhWAK3Y+24kFn8VIj/pd4CEYFtnQeirNcMLUruHD1S+8HPnrhnc77m6oXEtcW9lhBhag7ZltI3u2cwwSmwr3oFCowYOhlxtVSn8LTj6oBhLc5jGq0dtr2VQ3oWzxQBkNVb8hYtNRPHqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758875940; c=relaxed/simple;
	bh=IdNWL+RP6ByGlwqdHlGMFRFztdS35MmPQShZMG2Wg1k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CT61H9F6KAuwTe5F9T/jZEZlnX4ebUEY324VE1TVq4Fcy/Of132pJ+gb9P4Dlqw5neX0Vr/2eifi1ovgaMbTVGew9bm6qhV3hTTH6xmG0WqpmvRy+plwpBEgrFEj1V4i+eQ0+C5JFe2HQHJq2J6s4Kp3j93xXaqkJmXpAYmW3U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=GJCz4KeU; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-46e2e363118so18409255e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 01:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1758875936; x=1759480736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gIRZeCeIQNZ4hVWOGSa/wA4zfAS3lXvYWEK+xa/XxTI=;
        b=GJCz4KeUNsHq0yAqDTMrJAln7DMlEf+rPKUU+pMHi9+rmSexqgGQhoDdpIQ4lNA4OJ
         9gPIlMmu4lCODWfHPMlWTQBN/Qmxa9DEJ1O7h/5A6puQE8TiN7AtJAFfjt5UxyPXx+fB
         YDHJOPvEk/j0hye4qKhLvKaKgnPModBH8A+sofl8Bz5IemSZIzQohye2IXElsTyaX4yc
         b8e+3cZIgBH4FLsKcBoHhccsSUICq+MTrJNVMgwGOFO2d1SAfpZKZjygF7jUU6oiPtgV
         NMGTsJ2MysRDEPydPu1YOXZkCDrmOTz/AL/HBYFpVPNbSBF+NGOnr9bzupXrpfgrLNda
         va1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758875936; x=1759480736;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gIRZeCeIQNZ4hVWOGSa/wA4zfAS3lXvYWEK+xa/XxTI=;
        b=QFERovc0BazlAWTLRcDNGo9RHrvSOpck4OalrJy3/hEZtefwCJU8hEcuwH59Uum6ok
         mCFczHr7vFxLpRT7fohCcsyhHrQyxXc+r+2ERvmH67L8LmlfmjKZ3vU275TVkojpigZN
         LYGTreGjX4Gq/ep1TXTtJgXZ5k3F3PV3afxTJRjqDAetadQtoNbXQ/diatyJdAzoDoSK
         1i/uOvBFYMxotPDSJhc/MG8TrUyYaMGY0cNAsb1enllyHCTqiYFwekV5T2/VYy1/XhxP
         y/pGp0DTOiOvHTAGW1kwerVE4rc0wMacCnnWKRnpNxLsfYwdyo12WxSy1vabGiEGdDs/
         TksA==
X-Gm-Message-State: AOJu0Yyi21WT3rAfibJvXEk4YEsAt+IylPppLLDI1c4Sss+1jCG2BgZp
	fTVsa+Rx4FDUvohSaKn1ZdXqX9TWb4fQQqE7RPwb1znr2I+8r13g0/lXWzvXMd8nfcNw462bd5z
	0pY+2loo=
X-Gm-Gg: ASbGncshCjav0Kv7gQYsuGqosfE8qS13ZtiboWVVgTr+Vy1s8qyO5ipMFAbueE7qf28
	mGeDb8DVF6RqFgES+sQ9r+UHiWpGX+aPnis489PYhp6q9PdBEz5I0BAw4UitzTOxZBzGc/EVAX0
	jGkaJrR2YOjYvCDGrzAmThqxOP+RJy5v2FI9XtfQpaGrKNpUGKpPdqmh8+vrHyKJ9tPXbJbeEes
	/1G9MjHIZi7Yguos9VNl/MIbzgUmaoQPMoFmCQ72kXQyIS3ELzx9ZN0V+U+7qS+9FeZ8NberSfn
	F+ZgJbsjUoZvnwMwh7yNn7NR6/miBPJM9Ir53QvaMter20QvF2+4s/9Y3rqiksYRYnos35GfZzB
	uEioMJ3xlW1PSh2G2fwIy8h0tbhaQUdfj8FqKPbEqbbYiTHw=
X-Google-Smtp-Source: AGHT+IFJYDzppopz+YRLoC0ohfBa7Oer8f+hnuVJsYiGFH5CkS2ow2uJG6Dd8nSfYbQ92pu2RlsmGw==
X-Received: by 2002:a05:600c:6989:b0:46e:37b7:a7ad with SMTP id 5b1f17b1804b1-46e37b7a881mr55359245e9.31.1758875936047;
        Fri, 26 Sep 2025 01:38:56 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e33be363esm65702575e9.15.2025.09.26.01.38.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 01:38:55 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH 2/2] wifi: WQ_PERCPU added to alloc_workqueue users
Date: Fri, 26 Sep 2025 10:38:41 +0200
Message-ID: <20250926083841.74621-3-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250926083841.74621-1-marco.crivellari@suse.com>
References: <20250926083841.74621-1-marco.crivellari@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Currently if a user enqueue a work item using schedule_delayed_work() the
used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
schedule_work() that is using system_wq and queue_work(), that makes use
again of WORK_CPU_UNBOUND.
This lack of consistentcy cannot be addressed without refactoring the API.

alloc_workqueue() treats all queues as per-CPU by default, while unbound
workqueues must opt-in via WQ_UNBOUND.

This default is suboptimal: most workloads benefit from unbound queues,
allowing the scheduler to place worker threads where they’re needed and
reducing noise when CPUs are isolated.

This patch adds a new WQ_PERCPU flag, to explicitly request the use of
the per-CPU behavior. Both flags coexist for one release cycle to allow
callers to transition their calls.

Once migration is complete, WQ_UNBOUND can be removed and unbound will
become the implicit default.

With the introduction of the WQ_PERCPU flag (equivalent to !WQ_UNBOUND),
any alloc_workqueue() caller that doesn’t explicitly specify WQ_UNBOUND
must now use WQ_PERCPU.

All existing users have been updated accordingly.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 drivers/net/wireless/ath/ath6kl/usb.c         | 2 +-
 drivers/net/wireless/quantenna/qtnfmac/core.c | 3 ++-
 drivers/net/wireless/realtek/rtlwifi/base.c   | 2 +-
 drivers/net/wireless/realtek/rtw88/usb.c      | 3 ++-
 drivers/net/wireless/silabs/wfx/main.c        | 2 +-
 drivers/net/wireless/st/cw1200/bh.c           | 4 ++--
 6 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/ath/ath6kl/usb.c b/drivers/net/wireless/ath/ath6kl/usb.c
index 38bb501fc553..bfb21725d779 100644
--- a/drivers/net/wireless/ath/ath6kl/usb.c
+++ b/drivers/net/wireless/ath/ath6kl/usb.c
@@ -637,7 +637,7 @@ static struct ath6kl_usb *ath6kl_usb_create(struct usb_interface *interface)
 	ar_usb = kzalloc(sizeof(struct ath6kl_usb), GFP_KERNEL);
 	if (ar_usb == NULL)
 		return NULL;
-	ar_usb->wq = alloc_workqueue("ath6kl_wq", 0, 0);
+	ar_usb->wq = alloc_workqueue("ath6kl_wq", WQ_PERCPU, 0);
 	if (!ar_usb->wq) {
 		kfree(ar_usb);
 		return NULL;
diff --git a/drivers/net/wireless/quantenna/qtnfmac/core.c b/drivers/net/wireless/quantenna/qtnfmac/core.c
index 825b05dd3271..38af6cdc2843 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/core.c
+++ b/drivers/net/wireless/quantenna/qtnfmac/core.c
@@ -714,7 +714,8 @@ int qtnf_core_attach(struct qtnf_bus *bus)
 		goto error;
 	}
 
-	bus->hprio_workqueue = alloc_workqueue("QTNF_HPRI", WQ_HIGHPRI, 0);
+	bus->hprio_workqueue = alloc_workqueue("QTNF_HPRI",
+					       WQ_HIGHPRI | WQ_PERCPU, 0);
 	if (!bus->hprio_workqueue) {
 		pr_err("failed to alloc high prio workqueue\n");
 		ret = -ENOMEM;
diff --git a/drivers/net/wireless/realtek/rtlwifi/base.c b/drivers/net/wireless/realtek/rtlwifi/base.c
index e26feb8de658..2786e4ee67eb 100644
--- a/drivers/net/wireless/realtek/rtlwifi/base.c
+++ b/drivers/net/wireless/realtek/rtlwifi/base.c
@@ -445,7 +445,7 @@ static int _rtl_init_deferred_work(struct ieee80211_hw *hw)
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	struct workqueue_struct *wq;
 
-	wq = alloc_workqueue("%s", 0, 0, rtlpriv->cfg->name);
+	wq = alloc_workqueue("%s", WQ_PERCPU, 0, rtlpriv->cfg->name);
 	if (!wq)
 		return -ENOMEM;
 
diff --git a/drivers/net/wireless/realtek/rtw88/usb.c b/drivers/net/wireless/realtek/rtw88/usb.c
index 3b5126ffc81a..db60e142268d 100644
--- a/drivers/net/wireless/realtek/rtw88/usb.c
+++ b/drivers/net/wireless/realtek/rtw88/usb.c
@@ -965,7 +965,8 @@ static int rtw_usb_init_rx(struct rtw_dev *rtwdev)
 	struct sk_buff *rx_skb;
 	int i;
 
-	rtwusb->rxwq = alloc_workqueue("rtw88_usb: rx wq", WQ_BH, 0);
+	rtwusb->rxwq = alloc_workqueue("rtw88_usb: rx wq", WQ_BH | WQ_PERCPU,
+				       0);
 	if (!rtwusb->rxwq) {
 		rtw_err(rtwdev, "failed to create RX work queue\n");
 		return -ENOMEM;
diff --git a/drivers/net/wireless/silabs/wfx/main.c b/drivers/net/wireless/silabs/wfx/main.c
index a61128debbad..dda36e41eed1 100644
--- a/drivers/net/wireless/silabs/wfx/main.c
+++ b/drivers/net/wireless/silabs/wfx/main.c
@@ -364,7 +364,7 @@ int wfx_probe(struct wfx_dev *wdev)
 	wdev->pdata.gpio_wakeup = NULL;
 	wdev->poll_irq = true;
 
-	wdev->bh_wq = alloc_workqueue("wfx_bh_wq", WQ_HIGHPRI, 0);
+	wdev->bh_wq = alloc_workqueue("wfx_bh_wq", WQ_HIGHPRI | WQ_PERCPU, 0);
 	if (!wdev->bh_wq)
 		return -ENOMEM;
 
diff --git a/drivers/net/wireless/st/cw1200/bh.c b/drivers/net/wireless/st/cw1200/bh.c
index 3b4ded2ac801..3f07f4e1deee 100644
--- a/drivers/net/wireless/st/cw1200/bh.c
+++ b/drivers/net/wireless/st/cw1200/bh.c
@@ -54,8 +54,8 @@ int cw1200_register_bh(struct cw1200_common *priv)
 	int err = 0;
 	/* Realtime workqueue */
 	priv->bh_workqueue = alloc_workqueue("cw1200_bh",
-				WQ_MEM_RECLAIM | WQ_HIGHPRI
-				| WQ_CPU_INTENSIVE, 1);
+				WQ_MEM_RECLAIM | WQ_HIGHPRI | WQ_CPU_INTENSIVE | WQ_PERCPU,
+				1);
 
 	if (!priv->bh_workqueue)
 		return -ENOMEM;
-- 
2.51.0


