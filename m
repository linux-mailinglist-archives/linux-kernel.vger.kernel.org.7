Return-Path: <linux-kernel+bounces-899777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3329EC58F50
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 18:01:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7C3DC4FBDFB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 16:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 238FA35CB68;
	Thu, 13 Nov 2025 16:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fofcCtYu"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68CFC35C192
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 16:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763050381; cv=none; b=Sp2a1w9h3pn7Gy0ka66QEu9F0UlI2o0mo+gKi5wdJopKQFrR8Ad0g3N7DQ4/vNrlJNFn/c6A4+9YEunOgFAmpdKPmm21C3ey3VFO3cnzZn4JWX3peMkkE67K+HPP8PJQt7M28ahVs5ut2DCkPa1fDDABoiGIJWA/7yYDIzcIdO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763050381; c=relaxed/simple;
	bh=i6/Tdijqg6TUvObXhkp4KVAh++KkLe0kXSMy/xdGERI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lWrceyePHcE+XMlWX7uTwAXstXef2sGLMFD4qM3QSlIYCi0Dm9c6IPKzzy7jILl1PJh0z0rj+FzC5BlIr/xVa3oI1ivWubirtBVlDxefo5M5jWi33xiNwVA/rR7EWAGMaxs3bi/p66pRdIvDKu1JzmQbghADs5pnWl0B/svMh6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fofcCtYu; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4777707a7c2so16610965e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 08:12:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1763050377; x=1763655177; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m3hl8tY1RLv+K2+Ox9WrDl4hIf6rzuWKqmNX1UuS7YY=;
        b=fofcCtYu+DIHPIz/4L9a4+0o6Be0uh3jygGeeBaTZhohoJYHvMdCUA752g7JlCBM+m
         +8OIePTusMBvY+kw3n6RdpXFyEyWgatB9lPs2X4ezutCnBvlpUzJwbcyoC6+872jwb4W
         cGCpKAk/HSFakqjt2tKBaccU1Tj6VDVwooXJwPX8+r9Ya9weGpi8rTgB8txiVrTFDQCG
         RRkIs4HZS5ihcRvZDm5DIsS2Foh7cwYhUNgmzc2YeRqEKRun91OHXiXpri5qZI6PhRF/
         rWC336cxHewKJ9MNzLR8aHtX89Vyb9MSUdkQ9binBDaabBAugu39qofr+CHhAKL6w7ai
         am2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763050377; x=1763655177;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=m3hl8tY1RLv+K2+Ox9WrDl4hIf6rzuWKqmNX1UuS7YY=;
        b=ediXWOp4LNyCV3UwQsxZzMr5L07AmsyiuH+3N+y8YaLd7UA/muOzQ3F5WJNhihLSVA
         ikYTxB7wgj62VFkQ0MC61GfHrW1PB56ingfxqo3jPnGxMTFzh4FfTGRnHPzJIDixVgXJ
         PYZCHHalCb3P1b/sz7g+d5QLG10Gn0wvvVtSu7CfZ3jlJ3Q2VbmTS9lim7jti+O6smRE
         rHMC3fHDLTF01t+p5pkx0lbPxCNCoslvGDIPpipOFa+kL9jXFPvAsC4iSfqhBcnFyVd5
         lKr+He+EmcxopXNsbS+SNm54Ot1O2O5HnXCBkiYvRwrPOsAnmHBhbsE/5lM7VNSf0b/d
         Bj/A==
X-Gm-Message-State: AOJu0Yxwm2HPt9tcJGtbVeEsgtPKfN2MdLOhO3FGeO6F8Nz8aREVSaKB
	Tf/0Z9ZLxadWXYRlON2cZceW7ttthNEEHwsSTgl9a+/rz2jeZExa+liSV214MzPvPvG7iQ0EXQA
	UJUmy
X-Gm-Gg: ASbGnctDrZ6COoqX5WcaRhJv3H5fZKuq9d+OVxwqISqrmL0CY7gQuEzBclMXG8yHwV2
	VeGkUkuYKToxBXxb7q3N/FAqh03tKKujE+kN02uINC/k7NKTN38GWgWUafnAIJZ+4jgavUkkRpb
	a58gPqnynCdahbXuqar2TbFEfKk0eUlUbYIL+A2fv5Rw77wulrSzjv4dSpIqZ2l9ZzgQl4A3jHA
	fGE9HOAS7v6edsgK4Mj1lAuCsd/rsssRuDaMpbCse3W3QWxMsFYGysft+9Z/CWouLDW75p+crvO
	Cfv5kDLnX9Tk2DTWMunPc+TfSkuxoZo2h5ISZWknFRm5vu+CPpUXxQs+sdBCFLy/WDB+Q7MsE4L
	kmd5vbmHbMGsGyKSCXL+Wu4eBqbCTkddNNKqHFpEGRvJZH9vel3XSLT5Utxe3ycjoXaaR5usDRW
	2Noz65ubvrbUh0eyphvLRvD16l
X-Google-Smtp-Source: AGHT+IENmaUAtcIakh8Mn4zUT3IzBfIjhSaHtJtleCx6qYleuptiYERekZkAHB4z2rUrdoiGfSHzcg==
X-Received: by 2002:a05:600c:2e0c:b0:46f:b42e:e363 with SMTP id 5b1f17b1804b1-4778bd3c9d3mr22882215e9.20.1763050377491;
        Thu, 13 Nov 2025 08:12:57 -0800 (PST)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4778c850000sm41700085e9.4.2025.11.13.08.12.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 08:12:57 -0800 (PST)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Kalle Valo <kvalo@codeaurora.org>
Subject: [PATCH 2/2] cw1200: add WQ_PERCPU to alloc_workqueue users
Date: Thu, 13 Nov 2025 17:12:48 +0100
Message-ID: <20251113161248.387964-3-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251113161248.387964-1-marco.crivellari@suse.com>
References: <20251113161248.387964-1-marco.crivellari@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Currently if a user enqueues a work item using schedule_delayed_work() the
used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
schedule_work() that is using system_wq and queue_work(), that makes use
again of WORK_CPU_UNBOUND.
This lack of consistency cannot be addressed without refactoring the API.
For more details see the Link tag below.

alloc_workqueue() treats all queues as per-CPU by default, while unbound
workqueues must opt-in via WQ_UNBOUND.

This default is suboptimal: most workloads benefit from unbound queues,
allowing the scheduler to place worker threads where they’re needed and
reducing noise when CPUs are isolated.

This continues the effort to refactor workqueue APIs, which began with
the introduction of new workqueues and a new alloc_workqueue flag in:

commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")

This change adds a new WQ_PERCPU flag to explicitly request
alloc_workqueue() to be per-cpu when WQ_UNBOUND has not been specified.

With the introduction of the WQ_PERCPU flag (equivalent to !WQ_UNBOUND),
any alloc_workqueue() caller that doesn’t explicitly specify WQ_UNBOUND
must now use WQ_PERCPU.

Once migration is complete, WQ_UNBOUND can be removed and unbound will
become the implicit default.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
Link: https://lore.kernel.org/all/20250221112003.1dSuoGyc@linutronix.de/
---
 drivers/net/wireless/st/cw1200/bh.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/st/cw1200/bh.c b/drivers/net/wireless/st/cw1200/bh.c
index 3b4ded2ac801..bdf7132c5849 100644
--- a/drivers/net/wireless/st/cw1200/bh.c
+++ b/drivers/net/wireless/st/cw1200/bh.c
@@ -54,8 +54,9 @@ int cw1200_register_bh(struct cw1200_common *priv)
 	int err = 0;
 	/* Realtime workqueue */
 	priv->bh_workqueue = alloc_workqueue("cw1200_bh",
-				WQ_MEM_RECLAIM | WQ_HIGHPRI
-				| WQ_CPU_INTENSIVE, 1);
+				WQ_MEM_RECLAIM | WQ_HIGHPRI |
+				WQ_CPU_INTENSIVE | WQ_PERCPU,
+				1);
 
 	if (!priv->bh_workqueue)
 		return -ENOMEM;
-- 
2.51.1


