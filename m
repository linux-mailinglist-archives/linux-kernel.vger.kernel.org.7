Return-Path: <linux-kernel+bounces-829187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A1ACEB9679E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 17:01:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F06531884D1D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 14:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 366F12566D9;
	Tue, 23 Sep 2025 14:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="HZlNjRCd"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB0421FF38
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 14:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758639561; cv=none; b=Ef41INDOsS0ruCQ4z2iIrjGW6zTglxNPG7wkCqmvt8jWkp59s8ax1zRbXGwuqwpw35PzTCinnKz31Sd6TR4bGd6U9bvTqD855uvnFOlilTeYrVbNbCGMYC7PP9g3ZqhCsJDX728C68I886niCoffa0hj/DN4NFQxpZOMCsq7M/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758639561; c=relaxed/simple;
	bh=Nna1OdZOe0nnkKJ63oIewBWoT3so1EcPEublReL//R0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NjNArwrK54lgIh9TrPBbOoFUK6BwT2XWDaIvyd60VMZq7niEaM47cq6/DvRDnM6wLviz2WtAXqYnbGgwN1gSu0w8hHaRhs8Qnq0yPpKWmI18cx7R6mLJwhd7LBSMUXDpCocUcz54ATYZW/pfByRsjiAm2vhMe3cXUR3+IzjtDho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=HZlNjRCd; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-46e23a6617dso5800645e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 07:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1758639557; x=1759244357; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YOCISoePciLIeXeBbO4+qiMsX57pWEvn9G5NpvhqgC8=;
        b=HZlNjRCd1VvelEJ0VPpHPx0naAQFT6PUofEKLgCLn/5ixHoBDkueU9ZKncN4LWUsoy
         fWcxa+XJ8PZZlW1D9cyi7PUCVKOoP+zjWSj0VD++NXWRlsBv4vQcCttiLwLrSnP1Ucom
         u5ymCPMVx6m22IEtUQI201wy1c8nPkIqtajygIHCzyQxCImRvR93pO7FMBTSZKwNHZG9
         fljexQCx9hYkDXCBMKY5zngFrF9WTsGqEqGCzdyKBXTiQVSsqg5gR6PJjdqcIpq1RWUk
         OtI8Lg3sl10j0tfZJpX3pM9K0GEm2FaPpXbswd2E0L9YOmc6tjFHRuRmoyI1fGNAIMjL
         2lZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758639557; x=1759244357;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YOCISoePciLIeXeBbO4+qiMsX57pWEvn9G5NpvhqgC8=;
        b=HzCcIbhZ4iskCqnlDlhcfCXiBb+dybqitHvgw6er2f6bBVICNg0h/WrRTVmxpTsqhT
         E0UUD7hHTF/qiQSCt0g7C5E84mkBWoUTaQTehC05YXHPxHfEF2gCaktYR/OS+mcNEdBG
         vb3tzydzQzq1iEBPBd5dQ0nWU2Z5Dq6MPolmSmIAcMBsL4EB3UezlygaseutE9pkNgJN
         AOhoAy3HNLKPB6i2qfHPvmqhPjpENpviJixguouWSUdBavayJwIfUW64fmubyhz9VdCW
         qkqJ4l+hHCcUWm93QHPYByVLUO8pLfMPPQA3oxMeffaYimqpn/84xtCW4JKchiBtsW5j
         VmGA==
X-Gm-Message-State: AOJu0Yxhx4+iFDkVZuZOp7jg814N6km2rnflx/M7IKDNsjGGh3OwJAfg
	XQn2U0whrk7VsS8Z4nDUdN/3lVS99nCwFxPyDRtDxivpcP1xUbqaHENYpzoFFn6cVzF77/jYgXA
	0dSw/PE8=
X-Gm-Gg: ASbGncuuYjikR3cojgZMJbRptHJ1Mu1m+7FFIbMVDIds7KoumT7r/7tIdMSXNVPx4Qt
	Rz4Y44vn5cBbvG47IVnHpp1cmU8OzBTRv2l4JKFhhSUoNIGLecdUDbaL22db+2g/9OkLY7Ze0vG
	OVBc6Kt5YYRkoqCaYhBGzvWgYVSu5G35rV70UviinEZ9oHmpxaT/dvXUi8tbHU2pl7M3EKqLKHN
	0bkAVbODkBdcoe0KdZKAv7ERzXvhf9INtOlsf/NXO9q+3NP6AxOUT83qpCHV+xwh68Im1/+kBXg
	2X4+8OaG+AJt20uDTcgFFBwVQeMZLoaKhDJluh1yFUruz1pFgP827bKCRnHLjDFjDUCvf8mvjWc
	Fcz1xEsDl+EyQsoxN7ZvK8wQLBmyjMDf3pndp09ZFqPT9dJY=
X-Google-Smtp-Source: AGHT+IEIPtbSsWo6dVRsAMW229x4yzJgJx4HgWpoTAGkn3ab8jiwD4vY2vOQDp1TwA/CSqTehMF3Mw==
X-Received: by 2002:a05:600c:470e:b0:45d:f650:376f with SMTP id 5b1f17b1804b1-46e1dab50f9mr31786745e9.23.1758639557483;
        Tue, 23 Sep 2025 07:59:17 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46de4d67625sm76708005e9.16.2025.09.23.07.59.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 07:59:17 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Brian Norris <briannorris@chromium.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Kalle Valo <kvalo@kernel.org>,
	"Dr . David Alan Gilbert" <linux@treblig.org>,
	Jeff Chen <jeff.chen_1@nxp.com>,
	Stefan Kerkmann <s.kerkmann@pengutronix.de>
Subject: [PATCH v2 1/1] wifi: libertas: WQ_UNBOUND added to alloc_workqueue users
Date: Tue, 23 Sep 2025 16:59:05 +0200
Message-ID: <20250923145905.327269-2-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250923145905.327269-1-marco.crivellari@suse.com>
References: <20250923145905.327269-1-marco.crivellari@suse.com>
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

This change explicitly add the WQ_UNBOUND flag to alloc_workqueue() users,
to mark the workqueue unbound.

Once migration is complete, WQ_UNBOUND can be removed and unbound will
become the implicit default.

With the introduction of the WQ_PERCPU flag (equivalent to !WQ_UNBOUND),
any alloc_workqueue() caller that doesn’t explicitly specify WQ_UNBOUND
must now use WQ_PERCPU.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 drivers/net/wireless/marvell/libertas/if_sdio.c | 3 ++-
 drivers/net/wireless/marvell/libertas/if_spi.c  | 3 ++-
 drivers/net/wireless/marvell/libertas_tf/main.c | 2 +-
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/marvell/libertas/if_sdio.c b/drivers/net/wireless/marvell/libertas/if_sdio.c
index 524034699972..fc5318035822 100644
--- a/drivers/net/wireless/marvell/libertas/if_sdio.c
+++ b/drivers/net/wireless/marvell/libertas/if_sdio.c
@@ -1181,7 +1181,8 @@ static int if_sdio_probe(struct sdio_func *func,
 	spin_lock_init(&card->lock);
 	INIT_LIST_HEAD(&card->packets);
 
-	card->workqueue = alloc_workqueue("libertas_sdio", WQ_MEM_RECLAIM, 0);
+	card->workqueue = alloc_workqueue("libertas_sdio",
+					  WQ_MEM_RECLAIM | WQ_UNBOUND, 0);
 	if (unlikely(!card->workqueue)) {
 		ret = -ENOMEM;
 		goto err_queue;
diff --git a/drivers/net/wireless/marvell/libertas/if_spi.c b/drivers/net/wireless/marvell/libertas/if_spi.c
index b722a6587fd3..8a2504a62840 100644
--- a/drivers/net/wireless/marvell/libertas/if_spi.c
+++ b/drivers/net/wireless/marvell/libertas/if_spi.c
@@ -1153,7 +1153,8 @@ static int if_spi_probe(struct spi_device *spi)
 	priv->fw_ready = 1;
 
 	/* Initialize interrupt handling stuff. */
-	card->workqueue = alloc_workqueue("libertas_spi", WQ_MEM_RECLAIM, 0);
+	card->workqueue = alloc_workqueue("libertas_spi",
+					  WQ_MEM_RECLAIM | WQ_UNBOUND, 0);
 	if (!card->workqueue) {
 		err = -ENOMEM;
 		goto remove_card;
diff --git a/drivers/net/wireless/marvell/libertas_tf/main.c b/drivers/net/wireless/marvell/libertas_tf/main.c
index d1067874428f..fb20fe31cd36 100644
--- a/drivers/net/wireless/marvell/libertas_tf/main.c
+++ b/drivers/net/wireless/marvell/libertas_tf/main.c
@@ -708,7 +708,7 @@ EXPORT_SYMBOL_GPL(lbtf_bcn_sent);
 static int __init lbtf_init_module(void)
 {
 	lbtf_deb_enter(LBTF_DEB_MAIN);
-	lbtf_wq = alloc_workqueue("libertastf", WQ_MEM_RECLAIM, 0);
+	lbtf_wq = alloc_workqueue("libertastf", WQ_MEM_RECLAIM | WQ_UNBOUND, 0);
 	if (lbtf_wq == NULL) {
 		printk(KERN_ERR "libertastf: couldn't create workqueue\n");
 		return -ENOMEM;
-- 
2.51.0


