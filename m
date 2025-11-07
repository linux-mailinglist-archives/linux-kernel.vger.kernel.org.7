Return-Path: <linux-kernel+bounces-890477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C31D7C4024D
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 14:36:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AA2E34E66A2
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 13:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C2972EA16C;
	Fri,  7 Nov 2025 13:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="OyMIxDJ+"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55281A5B8B
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 13:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762522610; cv=none; b=QuCz3I0hlEQHmiOS/Wx9ftDxXsbVMoVx1RwguWezKP+lepJDpHxomtmrS1DrIj0oFuDg6cX1wqc0gyg1V2T1L38jAYrhcR9E71fIVtiho8zPtYZecMeteA8CMt5QAhpsHTjhmp92pOxghbIRc6FlXX5JttdXj+5gfCPbqloIx0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762522610; c=relaxed/simple;
	bh=UZwswUwbvM3wAsUrhwZiZhYIMvbdcwWe0ZDflLX2Vw8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FF48nC0J//oF1s0zUzVf51CbghOfclHGiCkVWeqSFPumgI20DUegs/MlaZSiQPl/mt8zxodYZKx1GMC7NTrEhzYdqj2eu1kh2Ns8vwNrH0dCkbjcjgz1KtTHIxmIjE1sZ34vIdJ7cDE6Vcf2QoUbzQyBS/9IfFNIcsEKJxLgQpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=OyMIxDJ+; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-477632d9326so6014655e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 05:36:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762522607; x=1763127407; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JobActy8Q1tKHJAQkXK8C2eUozNLqX92f26Y3cDZo6s=;
        b=OyMIxDJ+4EyK/M9wQWycM/4cg3QY0YOWqYQIOr5kNlwN+MdSL/p9nPUCcLqDvS0/f5
         HhIiXg6DPyCCZzEn6mX+WP3BYpYhnoSJSFcuVEpNd26g2qQuU7tpr8XjQDp9kqIc7Tkd
         EsmN/obX9YoB0AdgrLpbQYgAyDEmH0Xl+qZDvExcw7aSnZlN1Sa6y4nyxcqJFI5aJbzS
         BfTMwTar4p6cu3RlSvaAsUrsp4PgdzA2wM0vDbQqtP/K/Va/2SfLPtfo9DxgeGsvjbcG
         v1MWgx8x+KrVI+aXTHr4GbzpdPCuurOBXBUJYlTEf0KyztNLnTI5lNMxvmpb71TXgUIt
         U3iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762522607; x=1763127407;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JobActy8Q1tKHJAQkXK8C2eUozNLqX92f26Y3cDZo6s=;
        b=jJ/p6rJpsgGva3yk3I1gz6ftMVLr2ntQzDgnpBW/K4Oih/htFTaMsNaZjdTokzo0Nt
         35bOvdikuFqqtQxWColSCtUdaPAQJfy7OKAueBqzzN14HxyLRVi81bPmPXURbTZYwzXt
         91bPskCroIIbrSu2Y+OkHoDb61A+m2drldUETx7Yb1HAt63GNRHF7bh51MG9wRYo4+tU
         BXWBVEmwB1zd0Zps/4wDfqM2cwn1TyYiZfmoKYviMuuPhyhOkuU0e7XPEUVfXYu+iosO
         +aPsWyfB2F9VXM23xsFrPDtf/FBnGnbv4MxVFCKHeTc6vLwQ3L7+bNYCb7m/1mSAXpPh
         cMMQ==
X-Gm-Message-State: AOJu0Yzb1Rn/k4YvTxl+uQBoYDOXCa3VqJtU/DJj+QhQEAzeGTW+tE+p
	VadQvz3GLsStK2MuStIGKFMe3XyngDRAs/bcbQfAiKHYPOmuexNyKS+kHvBxC9rGRqosDRVgJDq
	6IBuU
X-Gm-Gg: ASbGncsSGVfehrGLlgAYG9kJN6/GfXUPNq8ggZC6T8h0I6pXFRdghzqVWvkaY/R2Wc+
	x0/W7uSjmXyj7ZUtW+Jo/eYtBq55fhjX6oN/W8fYqr0f39G5mIiXkecw1KPUTKvYCiT6w5BtUMH
	cx12ak/AIRCUgVjWnNUZX5iMQMRWKvYqdDDkzIIezo+nHrIHJtXb6gMbA86WNrTengwfH22474r
	a/8OSTCXD879N+dKVIf0DVVUX0bgQ/PwMy76ldjHrB3zh4nUFalGvW9HUIfDM1nsjHqtQ6C4x4n
	jsK4nNPsTlyJtG9FNWOrW4z+hJ+CUEH0gEIKeeuA4nHcPdhoAhrs1G4x1BsenpHkCiCJuWbWtJx
	NVapqrb4ROrtzFvuytR7WhY7jGAxHWQMHDjL+tss3Ohm7290tVYwkTvjKj1tKWqX+XVx4JNkIeU
	x7OWkBVFDekmzEjgoy5X56UEzF
X-Google-Smtp-Source: AGHT+IHigxOt7e+EuY57cRMkA4R3lmI1I5oqR9eg08rBEkmbJ647xE77iJ/O9h1VcgnOpYFGx9jYAQ==
X-Received: by 2002:a05:600c:4fcb:b0:477:59e8:507d with SMTP id 5b1f17b1804b1-4776bcc537amr26494345e9.31.1762522606742;
        Fri, 07 Nov 2025 05:36:46 -0800 (PST)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47763e4d7f2sm40627915e9.4.2025.11.07.05.36.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 05:36:46 -0800 (PST)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	target-devel@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>
Subject: [PATCH] IB/isert: add WQ_PERCPU to alloc_workqueue users
Date: Fri,  7 Nov 2025 14:36:26 +0100
Message-ID: <20251107133626.190952-1-marco.crivellari@suse.com>
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
 drivers/infiniband/ulp/isert/ib_isert.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/ulp/isert/ib_isert.c b/drivers/infiniband/ulp/isert/ib_isert.c
index 42977a5326ee..af811d060cc8 100644
--- a/drivers/infiniband/ulp/isert/ib_isert.c
+++ b/drivers/infiniband/ulp/isert/ib_isert.c
@@ -2613,7 +2613,7 @@ static struct iscsit_transport iser_target_transport = {
 
 static int __init isert_init(void)
 {
-	isert_login_wq = alloc_workqueue("isert_login_wq", 0, 0);
+	isert_login_wq = alloc_workqueue("isert_login_wq", WQ_PERCPU, 0);
 	if (!isert_login_wq) {
 		isert_err("Unable to allocate isert_login_wq\n");
 		return -ENOMEM;
-- 
2.51.1


