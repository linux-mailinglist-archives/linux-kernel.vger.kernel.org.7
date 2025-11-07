Return-Path: <linux-kernel+bounces-890539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF076C4048A
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 15:19:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 384A33ACECD
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 14:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CC792DC771;
	Fri,  7 Nov 2025 14:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="IQ3laIxc"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8882257C9F
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 14:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762525158; cv=none; b=A7/bOLlXbcnZZNxaF78V7B2FdioUWk5EbzUvYiCLPiIA7dY/6M2T76WaMMNVW6oE6azTPsojDXIIjHxOZtt1qPhOCsx2mRRM2OMLOp7EUAER78Z2xqDFDgBBMQp3lxpC93z61D0tbMtOk/7/MSSRp9TYI5EHhUP+NuLeQdPHgVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762525158; c=relaxed/simple;
	bh=jCYKhr1kX0Hg4QzRhHflP6OrqpUQR4791saqDTc52U0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CPfjzE/5r0LBOBliMhr5I1gQooMvQVB17w2POx61SQvArw91zHkMvGwiaIBkFB5RNLJH68TO4YxVFUAXAbc0wM+dTIQBUZHSANwXES3HgN472Vjt1QEPcW04XAls1ZaVk6L3ns1Wc/r48PQ61ctYSKYKL+mEE89uhyLr4ozafu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=IQ3laIxc; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-477442b1de0so5216035e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 06:19:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762525153; x=1763129953; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z3JtYpkQpGswXvZK8VCxneoBHV3vIkWcBIrbrAdQki4=;
        b=IQ3laIxc5MDZhq0kNxa3vRaVIoo2BNVJV7HiIEQf6IW6CgHTlIudOJBCyYyqNee2Yx
         jw1QY4h0qgFxTwRAdICZyAhceCeL+f2j542b1xzVpZ6mPonG6h0IYSwKsMT5H8NE0WHn
         8aa+H5SMqaML30li5LeEjHenZVrj6Qa9uSxiPYcdWzDfFS9RaQBIyZZrw8AeAYPUgJ3q
         rxRlwQvRywBI20dl8etirb3iMrd41WMlWdh5CwGx80cKXTqVqQ1anhDDZ9EcGYHT0HP6
         tk24MlgfD3madGpzxEC06+qHgkNbGn/YsMR0yPq3D4gxnh+vLlvF9KwDNumIAlGeS6O7
         Ji/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762525153; x=1763129953;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z3JtYpkQpGswXvZK8VCxneoBHV3vIkWcBIrbrAdQki4=;
        b=BwgRYhyLQ/8uAKBXD8UXZYvopq4xHbgXjpIbmSsjgjs5DCUS2jRwWGjGx2h08OQc/m
         L1kluu0QYh4z5g1I+DY4u9vm451Pb7WpfqjfWesZ5TFNprqQecx3/japEZYuln5BFcJm
         Cpwc2Tn5Z3+g6XHOn5nCZhW4yL46Y6q0CT8No6YETkDy2eXzzVz6sTv2hHMa25ACevPO
         +d/H6YX+ltHr6RsOwS6Us+GrtWDZgsZbYdXFy/vGVfMY8wBA5Y9Ym0+E8gYkvhZCAZMJ
         5Lo+mQ8WQA4M9pac2CZkIFOFyyXLhHD2dtHlndwUjv8p4u5DBxTlRyXQc0Ngw5kM5eM3
         Xu3A==
X-Gm-Message-State: AOJu0Yw0n7bLKjFM6AKSmO9UPJDSVMerNn9gZQjAOJT9Dz4sfOSbZlf4
	047iI4QGgHQgnxB7EUIHbIGHGx3oT736TO8RNizV0DpFDbpIi5kaAMu6S5WGzQCViO0nPyuIgdH
	/nxxk
X-Gm-Gg: ASbGncuYl6HemkKxcwDB6clCzLm+p18fMltXPYGVPijOke52aMQr8b1OJGX9cUQYl5H
	D8620TWpDMogBBt/vKKYy2ru8W1mJDEONBLG/NJM7PtHToE8b8tfU1f8JcUyhcedUx7+RRLXCNP
	1ngEbTw/I4Hi5zoHknFR4sDbs66QoYGfrqiwC+PaJtHO4GlfJIH5tGnZ7C3CXnJRWS6aAF85yI/
	Dz5nMZwpgbra6yDK8iNt5Atxu3oIPNZ6mLGT4fjYWkaSFdk2CSfpJHFM4uM5r96xnrXoAR63POd
	7Eubst15/zNasLGspjS5iCeB9bDCIX2RVdZxXXWsb5hyAAG31RLsZZyFKeggbRLN/AX3dPn++Ai
	SmOczQkCDYvl7L3VbnBZfG3336ujfQB33VQ19/rbgnaaPMT7W113TJqh/hc1WM9JdOo6U8JDdJo
	7AA99iMsdgbPciFdO8pwB/HANN
X-Google-Smtp-Source: AGHT+IH37Au8aet7V82ZM9z8/ovCarJgLYRwpuhLBnJNCo/JFhaSvNC80oCEjo8MjD+qazemNPFSbw==
X-Received: by 2002:a05:600c:1d12:b0:477:63db:283f with SMTP id 5b1f17b1804b1-4776bcc7346mr26051305e9.37.1762525153461;
        Fri, 07 Nov 2025 06:19:13 -0800 (PST)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477640fb801sm41441845e9.11.2025.11.07.06.19.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 06:19:13 -0800 (PST)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	linux-omap@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH] mmc: omap: add WQ_PERCPU to alloc_workqueue users
Date: Fri,  7 Nov 2025 15:19:07 +0100
Message-ID: <20251107141907.229119-1-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.1
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
---
 drivers/mmc/host/omap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
index 52ac3f128a1c..4a13111e1698 100644
--- a/drivers/mmc/host/omap.c
+++ b/drivers/mmc/host/omap.c
@@ -1477,7 +1477,7 @@ static int mmc_omap_probe(struct platform_device *pdev)
 	host->nr_slots = pdata->nr_slots;
 	host->reg_shift = (mmc_omap7xx() ? 1 : 2);
 
-	host->mmc_omap_wq = alloc_workqueue("mmc_omap", 0, 0);
+	host->mmc_omap_wq = alloc_workqueue("mmc_omap", WQ_PERCPU, 0);
 	if (!host->mmc_omap_wq) {
 		ret = -ENOMEM;
 		goto err_plat_cleanup;
-- 
2.51.1


