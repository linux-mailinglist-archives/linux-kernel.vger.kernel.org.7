Return-Path: <linux-kernel+bounces-879880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E2EEC244D6
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 10:59:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EC6A44F28A6
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 09:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5D4831329D;
	Fri, 31 Oct 2025 09:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="JY+Vr18g"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6A2333455
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 09:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761904615; cv=none; b=admRw/8ApYXSIjWOazAUlM+vzTCCZhialzTbUWdxY5vv60nSzuGFBPMtSPApeXzibD2p67SPXC5UGm5BaugCy3T1K+rKAjoS/1FsdHfKxdYcMw01/v27UjnptlIJCf3g6IOM17us34ypcSI1LgAh5adBTOHUNWO5REnhDnoqaYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761904615; c=relaxed/simple;
	bh=zSU4HFRWc5yjlOePtP3l5a54RXFYN+qEWiVewuQaZ1U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aYZ/JCpC8AelcYiGrB/Rb9edh0qPzWSZxyUw6II+SJ0NUo3IQaLJMRl3DqMrbwAk0fQAegndJUajx5b7XgVCIGxkLv7uT1W/Xuu4o4dSCtbvFoE4HwIVmBMU+vx4JWh/gSDP/6BfGWegXB2KH9fV7e2LaOVCtnwiFPI7LlAbiuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=JY+Vr18g; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-47112edf9f7so16293605e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 02:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1761904612; x=1762509412; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MmAkRDH072pmMAt8C09hH0SSMKdgHgvAXQzj/nVWYGI=;
        b=JY+Vr18gVLBvYvDUnb8cOAGRJpv4kqAUtVSoRfrUS7PfSC+8wLZu1BxQCpzLiyjzxg
         kCMaWdJmFNSa7xDeBLTgRw4HyAxLoU46MTYpvXP3cBIWpYaoi9QP1IjCTg2tDOXs9sSK
         zOld/rzmRdutPIxjMyofZpzBbUYSnPlsKJiitgqOQlpaQ8S9HjQh4akEi+oOHQvHwtAS
         1YgSKOYfjtn9EvXDX3eQ3DiOnMx6yMc3Qg2Nv/QPBtWYAuhPJ74vCd3E1D1E3DT1BsBi
         a2JabnGoKIwHkqfMHAbD0iNOaDlgpIdsU6YIcVjHmv8SfcsmoqYRsfOh9iaIfL2Eozfk
         Xtbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761904612; x=1762509412;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MmAkRDH072pmMAt8C09hH0SSMKdgHgvAXQzj/nVWYGI=;
        b=MXyYA5QFwdPYHU0kHmhIL/2ekvXkZykrotZo6uiRGm2c13yIAD3x7Gwy0dprP/CL8E
         3b+Ovl+E0tOBo1rwX9jgCLSpx0mxEeUL5dyK0z9nSJ0KiQxOt3K/DXhh2h9FYRS7oLyt
         /3XKStDxGlz3593OLghB/7pQY08XY0gtYAf8sdGiXnd1b1jp5nfgjdTaidFcAelUjjXB
         lbGALx8PKlRgx8je2PW0SKT0kz1Mv76TCXHIFYG1u2W4Nljnz5ENUMPPW+t9uxXVJkUm
         pLVU22fUcdwgteUctyag2USE2xdzZlM3VVfwxtWbyUW0jO2HhbtK7YF09TnnrglkoT61
         lIHw==
X-Gm-Message-State: AOJu0YxTbCuus8s8cSNlNZgVRZfbXnTQc4LFW+JNhuAKzRWJCOH6DeHD
	bUP7Sk+pC/0tUeIC13ickY/syfLGY+e2PvG70Ei424mFJHiQwCla35D6rNA7MudUSOiAc8nyyig
	gfZpm
X-Gm-Gg: ASbGncu7q/Ey6s1rxAARt9eCMoH/ADMWZaVSy+YOCJb5N6x0uJNC6KU4QKiUmJlfVmb
	yMunCc9+KgFs0/9ugHhh92+a1AgsVgtNqvd1CQIID+Y6XYleVB8dxjfSqglbHa0QuxZ8sDC3Vud
	8r0MpYxdOZ5IZcjtPPLOhhahD4nf2WNB7/HLlkdn1LgkdbOgWZ5cOYKTexCbURiPytvYwOpFlUY
	MoXDi4mOrDRw/GqaIwWJUUZ7S632Bqj7osP6I1oL8vkl9y5Sy4SJs0KvW8IuAKc85VZlDSFog7E
	8Z1oNC2qjHUESELLSYWgnttDziNRCnTtbwFHJQDNvCCcve89CNKzHLYwgmK+YC0ntvst/DfG4tm
	uC/tdBtUEE0mo2punJHvodZdsxsxaojwNtu06Ww8Uq967ja9ZOPRPUikAKJmRK+Qzy5Zm80Fw0J
	3g9q1YL2pkneSVXr6/lIxvCVmA
X-Google-Smtp-Source: AGHT+IEWdBLW+xRIf/F2cVKkNcU7C9/5C1kAno6QiP2mfQjJ5dJJs+H0nq1O8xvzmqMM+7ltKU/mvg==
X-Received: by 2002:a05:600d:8312:b0:477:326c:b32f with SMTP id 5b1f17b1804b1-477326cb6ebmr10175535e9.11.1761904612013;
        Fri, 31 Oct 2025 02:56:52 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4772899fdfbsm81572335e9.4.2025.10.31.02.56.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 02:56:51 -0700 (PDT)
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
	"Martin K . Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 2/4] scsi: qla2xxx: WQ_PERCPU added to alloc_workqueue users
Date: Fri, 31 Oct 2025 10:56:41 +0100
Message-ID: <20251031095643.74246-3-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251031095643.74246-1-marco.crivellari@suse.com>
References: <20251031095643.74246-1-marco.crivellari@suse.com>
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

With the introduction of the WQ_PERCPU flag (equivalent to !WQ_UNBOUND),
any alloc_workqueue() caller that doesn’t explicitly specify WQ_UNBOUND
must now use WQ_PERCPU.

Once migration is complete, WQ_UNBOUND can be removed and unbound will
become the implicit default.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 drivers/scsi/qla2xxx/qla_os.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index d48d8671c18a..af51f1cf5daa 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -3397,7 +3397,7 @@ qla2x00_probe_one(struct pci_dev *pdev, const struct pci_device_id *id)
 	    "req->req_q_in=%p req->req_q_out=%p rsp->rsp_q_in=%p rsp->rsp_q_out=%p.\n",
 	    req->req_q_in, req->req_q_out, rsp->rsp_q_in, rsp->rsp_q_out);
 
-	ha->wq = alloc_workqueue("qla2xxx_wq", WQ_MEM_RECLAIM, 0);
+	ha->wq = alloc_workqueue("qla2xxx_wq", WQ_MEM_RECLAIM | WQ_PERCPU, 0);
 	if (unlikely(!ha->wq)) {
 		ret = -ENOMEM;
 		goto probe_failed;
-- 
2.51.0


