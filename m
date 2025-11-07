Return-Path: <linux-kernel+bounces-890658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A0FC4097C
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 16:30:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D6E2560354
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 15:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6927832B9A1;
	Fri,  7 Nov 2025 15:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="XnHuUogn"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663282D8365
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 15:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762529403; cv=none; b=PCbzSdUb/yP2poF4r6ZUz5Iyb+lZi2gKeLEQkhE1DKNcQ/cyNnRaKDGDUlyTJ7BlqPI0tVePsUWETgd/EyTAOXGzqHWVZjw0a8AhzvucwTNp2L5BoUcTlvXvbxo/Dy921eEZfN1m7X7L8ju9AoM5R7M+m6vDQCSZ8gXXu14UCRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762529403; c=relaxed/simple;
	bh=Nf2hno+7gPF9vLCjnYoVPTRvKzA62DNEzNa2MXYGUN4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hlb904r5ydizBCPQVDrjpK2BlwS/KbYEnphWjsI/OVf7yPUdU2keazv+HLz3XZ/gwGzDA7lhhKe7O2H0L5IPRRd042ALIbrj69dgJJ8CzgYc7x4Ux0DXGoMFdFsMZC3n1MOuWkS43v52FPS/4yNi9+HK/gNgHGl6CYW2lOcx86g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=XnHuUogn; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-47114a40161so9230415e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 07:30:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762529399; x=1763134199; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3GoZhodGB9FYGEwkYt87VVVUhKMfEv1z2Z+2hgowflQ=;
        b=XnHuUognvJZnCJ0yCRPNFllfK6O8RH+7w2p0n8BhthJf+rWFtESFeSndbFZqmz/yYL
         Af0vt0i7tJ1UknmJa+v6q4V894/KFHhFWAtLb28D6vAG1a9GOJg2CU6YFZBpwklcwxXw
         PvYtifdScapSvddbQsANsFGTVM3wCk1l12vJo5NjauV2+lSGSswYzKaLQnhYHc1CdzpS
         octxlakb1+RSUMvPDC/bUJuhml88DxITnxcsfKQB79fZC7txSsPJqh22hzgcq2FY9Pfc
         gyyO78RtoHU+GBJdscuoBDapPGjs4RKv2tN/DwHHB+Jgm52hRED7JiDXELZl67q8EjDc
         XXZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762529399; x=1763134199;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3GoZhodGB9FYGEwkYt87VVVUhKMfEv1z2Z+2hgowflQ=;
        b=Wfw4TZhhU2TTe/WX4wXQo4SyqKIsCMMIfxh++k8V82H/VMmCSsmaWsf6mObelQRTd6
         tuS6Uhpi1wSx1qJvxZEha2uACegWVIW0BMm3kSJqxynMH1J3Z9wy+6n5YxWhFwY6rosT
         0pWTN54zv/8TWVFr9ypqAZoCcUc+JL0PMRnxv5W+JP7t2wiukDMnXFlhqNfDMAk0DALM
         LaAlx+pX9q9SV1q8+gHZHFHCRFKD1kpXgUyIIOlaUWXdwylRGEMqOsW12hS2DPNN5pNG
         qpOuHmC7pQUmP0QH+aGpguMmnQCNRd2kOjoLX0WJ4FXR3otsMTzt5ti0x6lrHJjxnDh0
         v11w==
X-Gm-Message-State: AOJu0Yy7G7yunpKmZwD8a34XlnaqRJ7eDXHDxlgK8hxjYHtbSPrBb+9Q
	1Rh6lQiDi/3g5BQfxQ2LMaXHMsOkOaLSZUcr0feIlC9T2ej5Wl6UjWg4rbLCu247lLVK5iLOUNQ
	f/c3TwKg=
X-Gm-Gg: ASbGncv5WRJ3wQ6tvmHLxqxeH1y/nKkiq7x/XkZBlsR3w96WIqePK/28ZbCSGuBplMn
	s09tOqFsP5FKWGfJeRu1ScU49uWstB0QIxtGpZjeDxDvKstwCF9w4EoFfG360e/TiX9qsM+uNKN
	SjtDRrHF1jI/F2Kg+X/L1iM/7CgnSWLbFwCUlHFKm4kKi7kZmdb/WQn/SCCTKqlyCaJUL5emhAA
	KCmOs/ccZfTR4xa1ecNB0isHty8zQ3aGZvBlAOBl9nHaOu4ddI8UPFUSDA58IueQIY6ZZD15vDE
	2EAI6pjMEV5yqJsfmIkrWH6RyXrNFZYLBArwHtHjotbmepk3ZgZ8PHpzIIEC8jbr7cEi9NkvghE
	n97XnO9spkFTb4xwodFOBd0YnQ9WnOddpjGV5lSBVOytWeSdH2KL+YPcQqvGi9erIb6qi64OuPl
	5nv2jMG/3raqAndVk/9kDEHWyl
X-Google-Smtp-Source: AGHT+IHmqZI9ktfvveouBP0DEC1fDTXy9L6bIOlkgXwbbIAASBfmpWtQSdTXKWT13I4wfNLTkOz9ug==
X-Received: by 2002:a05:6000:2889:b0:427:151:3db6 with SMTP id ffacd0b85a97d-42ae58d1316mr2821957f8f.24.1762529399362;
        Fri, 07 Nov 2025 07:29:59 -0800 (PST)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42abe62bf26sm5755029f8f.3.2025.11.07.07.29.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 07:29:58 -0800 (PST)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Kees Cook <kees@kernel.org>
Subject: [PATCH] soc: fsl: qbman: add WQ_PERCPU to alloc_workqueue users
Date: Fri,  7 Nov 2025 16:29:50 +0100
Message-ID: <20251107152950.293899-1-marco.crivellari@suse.com>
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
 drivers/soc/fsl/qbman/qman.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/fsl/qbman/qman.c b/drivers/soc/fsl/qbman/qman.c
index 9be240999f87..6b392b3ad4b1 100644
--- a/drivers/soc/fsl/qbman/qman.c
+++ b/drivers/soc/fsl/qbman/qman.c
@@ -1073,7 +1073,7 @@ EXPORT_SYMBOL(qman_portal_set_iperiod);
 
 int qman_wq_alloc(void)
 {
-	qm_portal_wq = alloc_workqueue("qman_portal_wq", 0, 1);
+	qm_portal_wq = alloc_workqueue("qman_portal_wq", WQ_PERCPU, 1);
 	if (!qm_portal_wq)
 		return -ENOMEM;
 	return 0;
-- 
2.51.1


