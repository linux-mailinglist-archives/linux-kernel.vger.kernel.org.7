Return-Path: <linux-kernel+bounces-890692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C87F2C40AE9
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 16:53:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EB421883F2B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 15:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6D55184540;
	Fri,  7 Nov 2025 15:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="NBXE5J5h"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C8929A9C9
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 15:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762530808; cv=none; b=ZVcGSo46wMyUgdawINCKJin1urrNv5lqEwxqz2TGGwEmijZh1mrsI4BDPkBiPiNOh2HzH61IPCNVEjaWBgOFtjCQfeiih0JFRrP1HeJrYzsnAr0SykBk+j4aOada0v2vy2KEHGQ4+LHB0nLXe50a3ImZJdFSitq1umtkmevY4wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762530808; c=relaxed/simple;
	bh=Z/HW6Gd2eaFdwzc3o2Q/3/qDsl9IgmaCSmXGYi3MYJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qHGrFj3GkIXqvhEIDylExnOYpdkVxReiT5/IEgOFneAJKll2uIze88//DmkysDj6qoWUF3NeEGLkHmERTBLcW/cCJY6RgftIaNX+Mm81+emawGH8k7uEV+NCFc+pgNAe21Mv7j5AAtYDXLuepadiTcWVfC0oo9pNWMDCt27PtuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=NBXE5J5h; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-429c19b5de4so711895f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 07:53:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762530804; x=1763135604; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=17YEM9k7IvljCCDwPTNBWkpc9TMBSZ/b/zjRccaW+FU=;
        b=NBXE5J5hfHWccO7T+0GV9FjwJoQ/vVSzP9NWz2LeGOerYqpB61Zz04YZGniwOgo7Ci
         EGxi87SNGyny7zGNUUlJriEcj2235NZXFilgUOSJqb1vPcjslqR++aLeHWj1OFaPQIRP
         nXBBFWOmrnv/XxMbkprqeFQTGuj/3qRxT6ljlG2cTPwCzIfJXeC9zh8HeHEAtNIboDKg
         +jDMmm0wUmGNmmIyIUTrF+Ok4V9b3t3giOs2ziNx+3U00jldlcsExydVG8kQLueUW0ME
         bjLl+NKe8iWjGO82AFsVFoX0Mw9RElO3wqUkIgLvIvyY/oZyDuPjv1c5RurxKqtQpXCA
         lnkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762530804; x=1763135604;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=17YEM9k7IvljCCDwPTNBWkpc9TMBSZ/b/zjRccaW+FU=;
        b=gfvN8WqYAuf2bwNviiJztt5oBVREBKfQGjCJDGxv626UJU3Ajd1/4iUPwtsBD3cC4s
         TPDsDW09NS+e8BRvO8yZW2Hrg4hZ+VY8posj1yuHRcWHD7Tb4Wd+WDi7wRSgTwOI8lC6
         VVrwWYat+G4UTh8VcDH3lq/Bl9ZrJvzRDLcFrggqRO2aMVU8Y4tNuP6KJ3mNAR1Om+I2
         sVWhb+yu2hJOPhg6P/c6XvOMCzJC6zl9rqOi9cCjU752rvl/UgrAG+TFemZ3yuQi+yoY
         F0DORj1QulH1/ASgqdVGDcQoabKlmFYNYcEryRJCv459R2aYBaT98jUY7EiEw+99iMpe
         KidA==
X-Gm-Message-State: AOJu0Ywkg1tg/PGjo3HhsyFX7kPwvoPrQ4rqWqav2JTupWs3aPsFUZje
	mJLmpjndW3KiuHes5nakyWBJvDdUhhtkB15XvZ+dtmRMnodyJPxOT6dtWZ4X5PapyEUWmGXB2kr
	OLdUF
X-Gm-Gg: ASbGnct0KksduTByhDU0sFO1xoyZk4qMbQ/+nA0MBLuI+2zBQwU2FNRhdMbLGcwVcgL
	BXn8Ib1HKLuei6BwVdW4/HeXhVHXSgT6FOBkQDqbYLWtMmp/1fuiKu/SFrSNz5NCFPEiyeJIhXo
	ttDITqV4NFegrsdJWvMNNI6h/gP+1gFFLomTDxPfCDd4CW6FEaO+eYjJ96wF7rTPBRlouX+LsUQ
	iMGMlGLbePXcoEKGQ9d+RjYlth7t7UxVQ0il8/G5g4vS6qpm/55YQJ9K3fhv+LWzHvKNBO8DoSu
	q0Cxhs2w55PwhKa1tLtS3tcBE3+Iv9zHa2QpTMtd9nNd/bx3NKl85adLsK8J5sAejf9Xo62Hz2y
	Eq8QRqStqpMh5XRnr/FQljOL7AzAOMzoNHUfMXRjbNr4tP+baBFAkzthm5d6peqGpdfO6efpW2l
	2d7THqaw+/cdiU/VF2La4Dk1UP
X-Google-Smtp-Source: AGHT+IEokRi0h80eOyFa6VsIO+fcg0fMne03igfDqDKxQ9pp+KJhIGPFNTKOsC+yFoOa5eXicCpnrQ==
X-Received: by 2002:a05:6000:4026:b0:429:ee71:2ff0 with SMTP id ffacd0b85a97d-42ae5aeff0dmr3333462f8f.53.1762530804428;
        Fri, 07 Nov 2025 07:53:24 -0800 (PST)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42ac675cbefsm6256121f8f.27.2025.11.07.07.53.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 07:53:24 -0800 (PST)
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
	Jack Wang <jinpu.wang@cloud.ionos.com>
Subject: [PATCH] scsi: pm80xx: add WQ_PERCPU to alloc_workqueue users
Date: Fri,  7 Nov 2025 16:52:57 +0100
Message-ID: <20251107155257.316728-1-marco.crivellari@suse.com>
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

This  adds a new WQ_PERCPU flag to explicitly request to alloc_workqueue()
to be per-cpu when WQ_UNBOUND has not been specified.

With the introduction of the WQ_PERCPU flag (equivalent to !WQ_UNBOUND),
any alloc_workqueue() caller that doesn’t explicitly specify WQ_UNBOUND
must now use WQ_PERCPU.

Once migration is complete, WQ_UNBOUND can be removed and unbound will
become the implicit default.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 drivers/scsi/pm8001/pm8001_init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/pm8001/pm8001_init.c b/drivers/scsi/pm8001/pm8001_init.c
index 8ff4b89ff81e..9acca83d6958 100644
--- a/drivers/scsi/pm8001/pm8001_init.c
+++ b/drivers/scsi/pm8001/pm8001_init.c
@@ -1534,7 +1534,7 @@ static int __init pm8001_init(void)
 	if (pm8001_use_tasklet && !pm8001_use_msix)
 		pm8001_use_tasklet = false;
 
-	pm8001_wq = alloc_workqueue("pm80xx", 0, 0);
+	pm8001_wq = alloc_workqueue("pm80xx", WQ_PERCPU, 0);
 	if (!pm8001_wq)
 		goto err;
 
-- 
2.51.1


