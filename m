Return-Path: <linux-kernel+bounces-884666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ECC5C30BA1
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 12:27:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F54942483D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 11:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB8B52EC568;
	Tue,  4 Nov 2025 11:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="I+gzfpBk"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF612EACF8
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 11:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762255552; cv=none; b=SK4GT/KR9e0fnqWu+mJ/5n2wF7zJcGX6qCHwGgC0qUXoFZdw2smwKkK1nLuayzP8RXUV9BhpXu4QXM8XdDiDDKHqE+SdZnN1dgxGxBhzuOB8uhwEy6+XE+UQCIq8b3xtlPfca1dlBezIYg6qZXPPzP/QELCoh/Ub0D32S8ixd2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762255552; c=relaxed/simple;
	bh=EfEGmqKgQNrkpGkIrhSxjTAfQflH2CxOaVMCDrdEOQI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jGeP28c+T7SwNg+ju13ttqUYVPptVhyIH2RspQ113/NnurOzcQY1K7p5DAkjF5EMPKyX6vwbwfBV/VunUhsQpuEVZXbsj/WMPUks9FN8alHOWOHhCQdD7oVP+Z9yrrMA2McS/xjbhKKpJ0GfT4UNeNZ1LWSThEDaqZnmhEKDh9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=I+gzfpBk; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b719ca8cb8dso164774066b.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 03:25:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762255548; x=1762860348; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=36j1MV0BBUKjnBRL8wiWamNCoEnZNdmYYjMeE2B5BRo=;
        b=I+gzfpBkjg8fI7eGEzNg//Wxeh8gQ9TZ64WI2GSIJCZm0iAn0Vu5g8H5kOPsAtt8y4
         7P6moZNa+z3m/7rLXRAmCwa8kBcc+ADyVauRJ1zaGDwQ/iCK9mFJV81gECbh8uAciqmU
         J3GmQrqMM4DhkgrIcYnFmrSyirRrt9Nej7DBY4/KjU2kuMW+SDIyCtssu5IdbiYG1o4h
         IWH9JYha+p5iFxQ6DRlkTgZy3d/oocx1CVakgYYqfVazJSTjhkloymXgB3wdrW6Zd+uH
         uojrHWGhCIKaa4YKOpTOu4a+zO3ENrb9GI2vfaAoeBRTaMTBLrWDmOUZ7TiuhieVfLWX
         eemQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762255548; x=1762860348;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=36j1MV0BBUKjnBRL8wiWamNCoEnZNdmYYjMeE2B5BRo=;
        b=mJjKLv3iTwLQU44Fcfz8tDYG6oYyiuMUXGOeQC7H9aaKYo5BmQvXzKPJbV4Rvp36fz
         HV5igjU8GGclI4mWBiEIDB54HIpYvN1lsF7dcXpRMXQEesvu1g0DSDI8lbqfElYtRQrC
         1rL9tay8fNnw5BvZqUe23AbeZ9gpLXbOeqGNmGoXS7u8B8y0u6kApmFuPEAtsfbCZ0hx
         NzSC6BAnx4HIwTQ72ib4PBqqlw017iVw4qHbbCcfMUBWK4iiV5pF7RwxmjvOMs/c5hKa
         8okanaEW1aUQDiSObD5/xBdvg+CJvVEK1wTLWlymBTvRU1gTgSEZ7miqD5cLi2tZa+nD
         jxPw==
X-Gm-Message-State: AOJu0Yy6bAS5WtM6AIAFdHeX7taY+1oIat/b26mtLW/qqwFe5EK+mTP/
	vbkB3YK4QiTrbOjAibZXlBMWwc2TwScZAfu1he9AnLMqG3y/WHfokmQqtcEl6NWjaEP9j+sPRxL
	BmxII
X-Gm-Gg: ASbGncv/eeB7+rG/eAM/gEJPJnqShs++JSu34LPkRzc5NNA65rfNLuCFyhiLENgHBEt
	HRCUvkEAS6CWiJQ8v/C78Q5yCDb71xRvzzgENq2a3qosRU/SEr2YHkxVoOy3S5FvrfVyg3MGcDV
	WtASvTmjWJNS8NnQ8P5KMCyZPgX0jb2CRKu1oskoLPyRlzpTsLR3G4Kgha0XEceDwmvyalnWv86
	sL04E9DROFSD66mDnICxC3a6tFUsjCHD6zhg8zm51hI8ESdRjDCb+yIADXdZD7tC0dt2nvuKVDD
	PK/YmwuKUpuaotfE0nE5dx3aqMlQL8IO2HsW7GmBHnFfmT3igqSmqe2nxHL+mEvd/UGpyMVAXvf
	TGueNAXgxPjpTjpxYIJcUBKZfEPJNBRD8+E/5lypcMZsOgBzOM4fLFaRwpzU4taTK3j6/8w7s4p
	nArXQ=
X-Google-Smtp-Source: AGHT+IGIauAMQQkqNOIjJqL/lfAch5QIY2pQHmm2/rqf5NN0Qlk/r1xJiw1HdsIBefQeKTnDF/XtWg==
X-Received: by 2002:a17:907:97cd:b0:b70:b7f8:868f with SMTP id a640c23a62f3a-b70b7f88d2bmr789376866b.27.1762255547591;
        Tue, 04 Nov 2025 03:25:47 -0800 (PST)
Received: from linux ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b723d6f33aesm184101266b.19.2025.11.04.03.25.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 03:25:47 -0800 (PST)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Justin Tee <justin.tee@broadcom.com>,
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
	Paul Ely <paul.ely@broadcom.com>
Subject: [PATCH 3/3] nvmet-fc: add WQ_PERCPU to alloc_workqueue users
Date: Tue,  4 Nov 2025 12:25:28 +0100
Message-ID: <20251104112535.139450-4-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251104112535.139450-1-marco.crivellari@suse.com>
References: <20251104112535.139450-1-marco.crivellari@suse.com>
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

This change adds a new WQ_PERCPU flag to explicitly request alloc_workqueue()
to be per-cpu when WQ_UNBOUND has not been specified.

This patch continues the effort to refactor worqueue APIs, which has begun
with the change introducing new workqueues and a new alloc_workqueue flag:

commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")

With the introduction of the WQ_PERCPU flag (equivalent to !WQ_UNBOUND),
any alloc_workqueue() caller that doesn’t explicitly specify WQ_UNBOUND
must now use WQ_PERCPU.

Once migration is complete, WQ_UNBOUND can be removed and unbound will
become the implicit default.

Cc: Justin Tee <justin.tee@broadcom.com>
Cc: Naresh Gottumukkala <nareshgottumukkala83@gmail.com>
CC: Paul Ely <paul.ely@broadcom.com>
Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 drivers/nvme/target/fc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 7d84527d5a43..ac730f2e6ea1 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -795,9 +795,9 @@ nvmet_fc_alloc_target_queue(struct nvmet_fc_tgt_assoc *assoc,
 	if (!queue)
 		return NULL;
 
-	queue->work_q = alloc_workqueue("ntfc%d.%d.%d", 0, 0,
-				assoc->tgtport->fc_target_port.port_num,
-				assoc->a_id, qid);
+	queue->work_q = alloc_workqueue("ntfc%d.%d.%d", WQ_PERCPU, 0,
+					assoc->tgtport->fc_target_port.port_num,
+					assoc->a_id, qid);
 	if (!queue->work_q)
 		goto out_free_queue;
 
-- 
2.51.1


