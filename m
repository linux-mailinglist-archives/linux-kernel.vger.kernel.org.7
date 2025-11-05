Return-Path: <linux-kernel+bounces-886669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A41DC3634D
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 16:04:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57EDC188F000
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 15:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC6D432C932;
	Wed,  5 Nov 2025 15:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="aZWo23IG"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353152FB988
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 15:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762355027; cv=none; b=mktDWC7Airf8p3pwH5K+qBfJBlkP5+FQ8i+TyeXu5E3TWs/V2xQ6jbCFlBW9y98MxK62TdTOqyE50yn7Gjv1vo3LzCCMwo28GC49S2lJTCxsSWowJkhG2ckBvcCdSmBFbFoYNEB/zw71Wx3eSoPZRjC5XQ/53XVoLwVET9LhXaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762355027; c=relaxed/simple;
	bh=HFGpbq6AGnpQDHs3RJgDweKupuWTaBcUzSm+7AIU1rM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZAtwsTw8SRYZRju14yDEysEzHyntTv5MO8feX6unVjkR8kR5X3yMG56+VVjATlxf10ppPAbZsSr9IIvn6AOu7xo2ymYMTm2BF8qurfaTpxMPzwypmANhM230B+aFy0fFxZJry5Sn7Q/GqajJlUHWKyxGbUaAgywEzB5qoJkriKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=aZWo23IG; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-471191ac79dso74706795e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 07:03:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762355023; x=1762959823; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/fCx1hZSgC1hl4Am8i+o/TTbFE77gj5sFZ6mozJ1t3M=;
        b=aZWo23IGVjDNvJG8r8yEC2Rd7XfLkaRg25HXEjCpnWSU2q2NcWBt+uyvfrjVOLdph5
         /pcmohUEY9htdjnF6TPCGdyo4XsGRNOed4/XRF3Vr2n8iUvOg7x9HbmsgQAqkF0iQOJu
         1R8oJt6TaH0ymCOgJ56jssbmit+SR1xGU/2aJ7Tylkh/Ur4CeHUIs2DqpLRXojGazPxW
         QzZS6CTPwxVBuJ4vuywhYW6AYTE0s33+vDjetXLGKNKKIFYLG40QVcXpBEVMELGIiAu1
         BK7P77h/3di2Daa6odhR33usVigKQXz79MpCdY9K0N8inOKhDRHxT2/QNld/zBC5M9qP
         g6Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762355023; x=1762959823;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/fCx1hZSgC1hl4Am8i+o/TTbFE77gj5sFZ6mozJ1t3M=;
        b=LnDmakHI6kYpsS/jShlKu5AHjs89pF/+5rGgEZHa+6I4LVVJpvNKx/48WfyT1J5Vug
         mHnioLSjhE0lr8hAIc+7SB0D/qyziszOlA0ybAkZVBAedPl148+XRyLw4hJWoTfLLXQ7
         V7962vuqt4bZDrPBYrDvTqHa5Rf4sxOI5pfW8oYPbUgAIa5+aAKLcJIrObUxJfoac6y3
         QkKGPl6M1n/UtX5WB5CKiYR3iB81t7FZ2DnngM4vCHQwho/EAAulrwnyKRauX41cK8I2
         clc5BkuxFOff6K2eNPi1ZwAifdTzKqP2KR+hPzHmoeq3y4d4dvPQ6Z9YuY8OWMAGixGO
         VcPA==
X-Gm-Message-State: AOJu0YxAijtgxy7QJJEFsUGG/LiAmgTWrDFNct0S2ZoBv9IJB7/gA2Ol
	jS0ZqDh5uCpDsIARQjHyNZ8Vq/7AilH0voXmminI6zAC0r5MBFjxspfSmOn383z4cMqLUapMS2Q
	Zkkjj
X-Gm-Gg: ASbGncsupo8wGLMonYTDJNUw4U5LD8DpfwNFUfv+r2O+BneE5eCtVRr20baFdx4+jjf
	N3BQFFlABVa4vDgWnos3DWmgxvQGLXpbTR39lJ6RKWgoOyQIuk85VPyZEG+mWa8VG8pY3a1bCNt
	He9/K8jRtOOxsapB0aCgPlJVMX/+WTQhGH+sf4WBBPKJjbG4LQdlAhEC3YPFzoFFfdtKpU8Cp7h
	zUWty7pouLfVWytzMhd4i8MG3D1wfQQqeLCGR9MVAWQsoNXJ7uUwxccOsgAuORdpsf4oBbhVT2y
	Q9lbTU4jmKqkRPxg37Ypg05oKSHeqjh+B7Xpr6FISZzzFS1Uedph+vW6zceCAS2N9niJ8aV+6iy
	y3GjOPFPRUE41TB/2IHKpOjbvYz2LKMvQDfu98YY9u/OeN7DRkNVlbBgNrjNB9DrSWvUqG9e6gP
	QshICv7d+/d/B28xARwPjUAKE=
X-Google-Smtp-Source: AGHT+IFmA0c4Wtd407mbM3RJEVqW2wIems/Y5GIiyaQOas2YI7MfDjPyLQJRRLt+sr4PuRJzXADpNg==
X-Received: by 2002:a05:600c:3e85:b0:477:bb0:7528 with SMTP id 5b1f17b1804b1-4775cdf7506mr28946685e9.22.1762355022966;
        Wed, 05 Nov 2025 07:03:42 -0800 (PST)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429dc1f9cdbsm11483290f8f.34.2025.11.05.07.03.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 07:03:42 -0800 (PST)
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
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH] scsi: fcoe: add WQ_PERCPU to alloc_workqueue users
Date: Wed,  5 Nov 2025 16:03:36 +0100
Message-ID: <20251105150336.244079-1-marco.crivellari@suse.com>
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

This patch continues the effort to refactor worqueue APIs, which has begun
with the change introducing new workqueues and a new alloc_workqueue flag:

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
 drivers/scsi/fcoe/fcoe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/fcoe/fcoe.c b/drivers/scsi/fcoe/fcoe.c
index 4912087de10d..c8c5dfb3ba9a 100644
--- a/drivers/scsi/fcoe/fcoe.c
+++ b/drivers/scsi/fcoe/fcoe.c
@@ -2438,7 +2438,7 @@ static int __init fcoe_init(void)
 	unsigned int cpu;
 	int rc = 0;
 
-	fcoe_wq = alloc_workqueue("fcoe", 0, 0);
+	fcoe_wq = alloc_workqueue("fcoe", WQ_PERCPU, 0);
 	if (!fcoe_wq)
 		return -ENOMEM;
 
-- 
2.51.1


