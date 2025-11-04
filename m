Return-Path: <linux-kernel+bounces-884645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 79C41C30AAD
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 12:08:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CFF0F34C488
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 11:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 131E22E2644;
	Tue,  4 Nov 2025 11:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="AO9Lghqq"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C46191F92
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 11:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762254505; cv=none; b=H2CXfLUY4Rl/jNbcg4dJVwhSuiS05KcVC5AJhs4K8Ro/L2NcU41c+EaM0Ubprgatak7jJRcS+bmS8VwJDZZSCTb8vzgykRNLWa3Ww+sTMSkIi2QLKQoWcUdyCJ2mf5S5mt4mZhtTZy+tP156mlRIcRYDd59b3ifWtiFBBIW7e64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762254505; c=relaxed/simple;
	bh=WQ/ohDia7uzWf+QTovyDFaXkQtp6pvGqaaFaRGl927Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iioMiGJustWjHjUb59nIEEoZZVQDVk/5vvwBhuiDM9xTKeopGYitZEcocUvfc2d4cGOVQ/CN3VFhQFGJrxYhnhiBkt3gc82CegvDfYFv/uwPMLIUQgJpH8SOl0Lb7MkqdTp7K9cHRT+tb9Ib/ceGiJO0Wb/E1BSfoSCZXnxSvAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=AO9Lghqq; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b6d3effe106so843512566b.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 03:08:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762254501; x=1762859301; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ffwBII/8UKbjUAsU6g4VA0sKiKJx/b1RbgapN8DJwps=;
        b=AO9Lghqqqr7EHG3Zj8HrzMVidUzoXNWzw+visfpyluiaIvLNPdzej6EG4OJN1n9gxY
         hNo+3lzDiv5SHBjkEyAJ+wEZRHEk2zte5mzsgrilYvVseXdTMMw+bt+6yuCFFiGzyhvh
         7aD+oIPCoOaLTtYwJ3hiJ6ZNGN879ckhoKNBJFX4Z8TUjpMBXMg3Fp7mrwJHjAoI6QBS
         9itqI6ZyiSN0sl5Aq54CQyiMIqQsUt9uPV2jaLw2sJiEed+4dDi27kH875gtDkbb2b9X
         820KzOznCJtVbb5ctXQhcpsJmwd9qEHNJKIsFsnu41zZ4xEIHqF9If0NXlt8G+e50QoH
         OkWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762254501; x=1762859301;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ffwBII/8UKbjUAsU6g4VA0sKiKJx/b1RbgapN8DJwps=;
        b=hEtVzsyCVXNE5IkL70BKvDWO8L+pG2Ukv87fUtT9WEd8mwGXNLFrGvQWC2uRqmoxA2
         HdjqvBgZW7OXWS+GX1BHXxE4WckV9HbkfEGJJp6wHDuOE/0ablHx8ikHF1kRCgv7GGhC
         FCLDbsr8jpYaiJk5ITYEz8/SsWVloLCwYXfauPWDyvxS/MmoXkW7uVcBy5ficvGHi58z
         PC412/GgIVx6e1RtEZXfaiL2+XEM6l9md4nP1lN4xfzOW//yAHHJ481oy3EXo4eLVvIi
         Z9fNg8OxZVyiCJXQqW/lxoaJuWMiurVG7KxhUntKxvQaFRWs1K3CWkF3RaeYOfZhvALf
         h40A==
X-Gm-Message-State: AOJu0YyLqUsAk3aZl58oXcZMQ6RwxuKwweHR2NJQ2GHN6cKsmdi5eXz9
	D+jqFz4ImDN5WiGDJYfivQc0N6l3ZZLE06I0Xb8vfOqwXa6ll2wSs+871sCFf61+0WsqDucIyAc
	Y8IBa
X-Gm-Gg: ASbGncse4m54SQHwegrv5L2zoz2kuR1e1wVqHoWdBq1Lx+RDVfLzOdItVCNxz3L1FZe
	kXbVrl8OsICakipsa/NCDKzW+76z557RPS+Nt7qb69EZEeDweBt0dixyPRIW2uwtWqMs+bzQp/y
	AaP7Yjh3zX50dtc+I4OSzLA7cmc8zrnjTvTIIcNxbFwoHon4GzfwMcXC4gQjZi99+60x2qpCzYx
	m5bhBqt4UZ3wyLqcsxBrVtunzUJrb6+laONF1xJhdXtXuKlG5hRiVXj5Wcxo5PWX7wi4jnrt2J3
	/zIRXkt9S0Ew5U23hVtYBGYDuCf1g7XoYZFM7aVjjz8cUVvXjWgrYNOy5NUOlPJSaxU/zmszzz8
	pJu0K/Fz/Oz8F77+xweRIVnVEuPqu91YVmDWV+YUuPiskL4xgcXRI0Wvv7xo0kM6av5AcKX8ArV
	d4DAs=
X-Google-Smtp-Source: AGHT+IF5qrlPWCkuEzv3QTctjZLDhOiaF5uRDaxLj/l/ay6tSejPh79HWrKLIT/9StR2Q5AWaBBgAA==
X-Received: by 2002:a17:907:7f94:b0:b70:e15b:286a with SMTP id a640c23a62f3a-b70e15b2d72mr680407066b.57.1762254500568;
        Tue, 04 Nov 2025 03:08:20 -0800 (PST)
Received: from linux ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b723fe38a4esm178899366b.62.2025.11.04.03.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 03:08:20 -0800 (PST)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-scsi@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	"James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Justin Tee <justin.tee@broadcom.com>,
	Paul Ely <paul.ely@broadcom.com>
Subject: [PATCH] scsi: lpfc: WQ_PERCPU added to alloc_workqueue users
Date: Tue,  4 Nov 2025 12:08:08 +0100
Message-ID: <20251104110808.123424-1-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.1
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

This change adds a new WQ_PERCPU flag to explicitly request
alloc_workqueue() to be per-cpu when WQ_UNBOUND has not been specified.

This patch continues the effort to refactor worqueue APIs, which has begun
with the change introducing new workqueues and a new alloc_workqueue flag:

commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")

With the introduction of the WQ_PERCPU flag (equivalent to !WQ_UNBOUND),
any alloc_workqueue() caller that doesn’t explicitly specify WQ_UNBOUND
must now use WQ_PERCPU.

Once migration is complete, WQ_UNBOUND can be removed and unbound will
become the implicit default.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 drivers/scsi/lpfc/lpfc_init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.c
index f206267d9ecd..45d43e9c5827 100644
--- a/drivers/scsi/lpfc/lpfc_init.c
+++ b/drivers/scsi/lpfc/lpfc_init.c
@@ -7950,7 +7950,7 @@ lpfc_sli4_driver_resource_setup(struct lpfc_hba *phba)
 	/* Allocate all driver workqueues here */
 
 	/* The lpfc_wq workqueue for deferred irq use */
-	phba->wq = alloc_workqueue("lpfc_wq", WQ_MEM_RECLAIM, 0);
+	phba->wq = alloc_workqueue("lpfc_wq", WQ_MEM_RECLAIM | WQ_PERCPU, 0);
 	if (!phba->wq)
 		return -ENOMEM;
 
-- 
2.51.1


