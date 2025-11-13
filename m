Return-Path: <linux-kernel+bounces-899734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FA74C58C89
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 17:39:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5D3074F9481
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 16:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7691B358D0C;
	Thu, 13 Nov 2025 16:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="YixzqTrR"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02043587AC
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 16:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763049654; cv=none; b=P1fhAFJ182xRbKx/4xGqdD/E2glmIH56KwJLcdXGclP7liG4ASVzszKahdPbY/fwLbUXLj+cvJLcpJj+B9uJUptURkOdrmLN7NV/TlHX7vBaAIgZGIpCuq3rPCEL3MZrjeSXZ7yIxksq2yac5yGfikTlNVsuhYNslwCvAzLAx3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763049654; c=relaxed/simple;
	bh=6Wmz0w28rqLi7irIOJSMbni7pKwlVDgHYwe5FMEfE44=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pzWf2EbOYGWUj6yZRyGLGbp/ciGZ3h1VwhsETwZfPDhjPSmxKcI8a/luILlb+7MeWpIoJxNkbhdqKGu6bb6FRts4mAFLX1AguYa1VJlMAoy+uR/hZXwa+7dXI6Iiplv95V8vRiFLAeNNrTA1AoFftnOCM6yK3OOBK2lUAgpwixc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=YixzqTrR; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b71397df721so119862866b.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 08:00:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1763049651; x=1763654451; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0efUvnW3GMsirNYsN0z07zn/Oqcuhmed27sVsOeyKC4=;
        b=YixzqTrRhxU6H4bTQoP78/ot3Rd8AnXwGVt4Ow8leH8Sm5uJcWDbTNpX6MCwyq9+wd
         E8Xq2tkirChTaAE/zkeZVaf4l9NdRWi5RaAX97PKlueVe5CJPVWHmFr2GuTLHNcwgjVx
         4CELWU0BuFCZSwCkwPmIJVe2HenyYuuX0Awoyw1/jIUhrWJGHOP6xo2KVvjVa0I/4WoT
         BsJ/4dfdGPnhIPiVCj30o+z6jDbrvCIFG/0G51rR/b/DFD9xeja7dEQBTnVg2gxbStQA
         UA2KnkiJjTlJ0rdtCnxbZz3zxOtIz0AvLgbPfwoLZuONbh0fwEAyQNPECWEpLCw3a2xI
         SfLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763049651; x=1763654451;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0efUvnW3GMsirNYsN0z07zn/Oqcuhmed27sVsOeyKC4=;
        b=BoG+HnBcO2lxLwnrVDckrBDlzX6+2QQ8fTbI3gOiMgujJlxAvMRtnvDleUYexjiAyX
         J68rjZroCWKDkTn8Q8Uk6wbVzPS9MHHcmGA7sjNJdJrm7QQbcgc+WhcY1LIGtEHx1WNA
         wzNoxxMZXLmTs8hhSlOBV6iYGjDK4gyYOFQetVF4I3XzPZy686TpEccQ1WW3Ie7ukF/F
         TbxATVmFc2EIGfjnfocnFWUdttoudixRHJe4Oanvghp9k0x/MgP1Bh2RLixn5Kg7zNBW
         tr/QFKqPQWHQZxKhyh/rUlv/E7CFCcsR2J6C0arll+XfdaAAtGqEgtiMdPnYFWfCv8fS
         Hhvg==
X-Gm-Message-State: AOJu0YwhAF4SAP1eA6w8cfNZ9kzb/dKmEvInURxOngAZ2vxvQCm1/GKY
	LueSsC+YlL12JzmRDVB+hc/93fxQE9tfL6I40Yf1ckXAyOit84nd2pLr/g9Y/t0Okbyefsa9aBo
	ehCBq
X-Gm-Gg: ASbGnct6xPBSmal5YSj7j5ywCBU+AshQl9WkHGpDqgmXk4n4UEeQGUMf7mWLlivIb8N
	mVv4rxZxbP8DRIu0uf6Aaoz39n8ToMTEJGc0ItnMqL4jfMfyCLT8u5T34xI/iulsrMx51ns0Qwv
	6iR8XN7eNFJpOa57EKKtOJsnXlpINjMRKFdVCsU5GHFo/b3RyKioWerSvPAvaA5c1VMSF039gF/
	DjtkzxNF21ODpinJQjr5pNb42PgjnB75j9nenw2v2F8gY73C5mY0a2oJkXSPAlq6KsV1N5OktSX
	GAD8ATVtLW0PntLshTbdPmwvL+l7Y0r67NF137tk6oUmarETUg8oSTibNfAzgE3/6u3md20d1c1
	vxSPYhLMw+Yti7sp1lUpHx2o/hZwClfTF8FtflDBxN+oqy7u5kFGGF//PYBYwMlsB+WyGdrHiZ/
	0ilLI=
X-Google-Smtp-Source: AGHT+IHZ/2oxuZtYuT82Lm1zSTq2FAnEZ2rkLS2NxmDXzfnqzCNWyEKaV1Egj/Adc4f35fmvH0TWSQ==
X-Received: by 2002:a17:907:d0a:b0:b5c:66ce:bfe6 with SMTP id a640c23a62f3a-b7331aec498mr811149066b.55.1763049649244;
        Thu, 13 Nov 2025 08:00:49 -0800 (PST)
Received: from linux ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b734fa81275sm191424166b.13.2025.11.13.08.00.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 08:00:48 -0800 (PST)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Igor Mitsyanko <imitsyanko@quantenna.com>,
	Sergey Matyukevich <geomatsi@gmail.com>
Subject: [PATCH] wifi: qtnfmac: add WQ_PERCPU to alloc_workqueue users
Date: Thu, 13 Nov 2025 17:00:35 +0100
Message-ID: <20251113160035.376524-1-marco.crivellari@suse.com>
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
 drivers/net/wireless/quantenna/qtnfmac/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

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
-- 
2.51.1


