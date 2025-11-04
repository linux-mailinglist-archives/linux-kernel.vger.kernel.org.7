Return-Path: <linux-kernel+bounces-884605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87F4EC3091D
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 11:45:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2122D3BD299
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 10:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 515B72D9481;
	Tue,  4 Nov 2025 10:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="PyGwY59m"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39AC12D7DDC
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 10:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762253132; cv=none; b=YMY2gttZuCD4bxy29Z2pKY7hc0M0tf/XZPtR3PhR2W0G8LshHA5uzAx9WMkVWk7acIKdTt+UfZ7nZR8+9Qc/Jt/E94yKOzQEMrN93ES2CBnGNuw+roSoShrMnXRd+ffX8x+g6o/4RN1aNVLOBk0eNT1lEfB/3xrrutqDleIWJqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762253132; c=relaxed/simple;
	bh=VX0zLAsPBGlwcqvp/8KD3Z0nfnIEYq4KM2NgJGr5aXk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rO3atncM55OznK3EzbCEbKJuPO4iblgC2mSEuDVA072xTu7Pvho0gox1bKK0PWQr7wmrsIONdFAhOXORzHKBdc4tl9wSJq18Bl3spyGH0XPs5DJWM/dBTlq4iPFadfRpgAoeojnaWaQUHR9d1QYfHg14b+SqB6ghuHrYOAX619k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=PyGwY59m; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b403bb7843eso186968566b.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 02:45:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762253127; x=1762857927; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WYj8Ir61bhOOSEvOfRY0NgbszhSvxELkBx7OQsS3cOQ=;
        b=PyGwY59mWp3utUgAh2CmYtifE3gNPZiSf6GY7GwMAB+DkCf/1JXrIlq9TfMhdxE+YQ
         2B2ECfWUTtR/K0AeYQ0VVshxBM/SlRnewghaQcoee+U1+NL0w9hzckYfh/5tF/vQGIx1
         062ayTngKU2E1ojnOXupLDw1C180xE3yYuxJShOygafocJhwZZblIqthF0lj2rpFEBzN
         J0sPTxm5MpB2atG3SpzlEjttx96zpyJ5sj2eomN1bq9n+C1jmnvAwPmoTZGBC1a0hKIB
         YNgYP83Ttnih1+3vhaphHbMAx26a+kmIF+ABLmzJPtg7GM/omOBMqGeu+4l67r7l3oV0
         whpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762253127; x=1762857927;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WYj8Ir61bhOOSEvOfRY0NgbszhSvxELkBx7OQsS3cOQ=;
        b=bPKvIrz7tGx/FE/Nhm0ueaNuafCTZ+Aw3VOm7o48bvy5KfJOjmRblD/nPs2+5h4KWQ
         9QOM6BPfuXa3y+jgNWlhJcubhFQSaoKCYSlOY0mwF3YsFqZA5bxdef4/p5U2S2RctZ5h
         G8HXoUN8ABtXwYG7ndKztWasPM0+HlaYfpxovEfQqjzZQD4GQwQpD6HJiK7LGfyUlSH2
         yvFIHSw0mzi0kP8+NS6BxxLKmlSm5a3x1vcxdVCiwxg9gVPX8q2AwV1yNZi9cilgx0v1
         XdmZo9AsuPemSafxjlQJf/u2uVl/pP/VOfBH9Ndm7VA1nBjMcFXWMZecXeAzrHAClJgC
         hedA==
X-Gm-Message-State: AOJu0Yz+SVNnGEXbkZoduo/N05n6UK/MWDvKgLNh8Uj4kswxpbNzfaf/
	VfBb/FQMUOCWNzcVHUReagtAh2bI2EGF+DYb7qy3F3Fa31NiV4yj5gsW4T8/VMNZ98gaxByketa
	7gv1h
X-Gm-Gg: ASbGnct0G5WuRYMKHCXG6lh1m6918LH8XbcOx4vi7g+ZpJW7e6KccM4BFvPu+h+jMx2
	OULBMR+hN2bv1IINqwZi3CxH+11h2eGoVQtKfgXEdOUOuvqfuQzR8K6sLCaTgqv8btzO3bfxBBz
	OrV50HuISuf1fw95JzngPFL+u8ZFO1/b7rG9+WGHd94MmvQ5/F00kfxeEczkTQUQlmpXBBc/N+I
	ohl7ILk+MJeRNZ/kS/8T9e0KThPB8EhmUlEDf5cJM5HQAncy50CoFgYP3lhXcqyEDyc79BOne7P
	zQzyypd52FBkEue0OdosFP2ff9x91uxGOMFs5YhGuJFJwzqQX7KKRY4W4aaYCfbsEkG7BicRUKO
	9HxzSY3tdd0ayPACHdfz8EF7dDq6w6xNILvc9nP/10wv0CNYwIS29L47jsZepuqScGESxtLEtdN
	rV0U+ESwS2M5bmxg==
X-Google-Smtp-Source: AGHT+IEMA8UdWF6f+LHriDUDE/NjxHUOw+zfGpPihm2oIRRAOwA1BfGgSkWC9f9a8GPJW8x10c9pUQ==
X-Received: by 2002:a17:906:e0d6:b0:b70:7d5a:2111 with SMTP id a640c23a62f3a-b707d5a6021mr1065888366b.64.1762253127163;
        Tue, 04 Nov 2025 02:45:27 -0800 (PST)
Received: from linux ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b723d3a3082sm177827666b.11.2025.11.04.02.45.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 02:45:26 -0800 (PST)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	target-devel@vger.kernel.org,
	linux1394-devel@lists.sourceforge.net
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Chris Boot <bootc@bootc.net>,
	"Martin K . Petersen" <martin.petersen@oracle.com>
Subject: [PATCH] sbp-target: replace use of system_unbound_wq with system_dfl_wq
Date: Tue,  4 Nov 2025 11:45:18 +0100
Message-ID: <20251104104518.102130-1-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently if a user enqueue a work item using schedule_delayed_work() the
used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
schedule_work() that is using system_wq and queue_work(), that makes use
again of WORK_CPU_UNBOUND.

This lack of consistentcy cannot be addressed without refactoring the API.

This patch continues the effort to refactor worqueue APIs, which has begun
with the change introducing new workqueues and a new alloc_workqueue flag:

commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")

system_dfl_wq should be the default workqueue so as not to enforce
locality constraints for random work whenever it's not required.

The old system_unbound_wq will be kept for a few release cycles.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 drivers/target/sbp/sbp_target.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/target/sbp/sbp_target.c b/drivers/target/sbp/sbp_target.c
index 3b89b5a70331..b8457477cee9 100644
--- a/drivers/target/sbp/sbp_target.c
+++ b/drivers/target/sbp/sbp_target.c
@@ -730,7 +730,7 @@ static int tgt_agent_rw_orb_pointer(struct fw_card *card, int tcode, void *data,
 		pr_debug("tgt_agent ORB_POINTER write: 0x%llx\n",
 				agent->orb_pointer);
 
-		queue_work(system_unbound_wq, &agent->work);
+		queue_work(system_dfl_wq, &agent->work);
 
 		return RCODE_COMPLETE;
 
@@ -764,7 +764,7 @@ static int tgt_agent_rw_doorbell(struct fw_card *card, int tcode, void *data,
 
 		pr_debug("tgt_agent DOORBELL\n");
 
-		queue_work(system_unbound_wq, &agent->work);
+		queue_work(system_dfl_wq, &agent->work);
 
 		return RCODE_COMPLETE;
 
@@ -990,7 +990,7 @@ static void tgt_agent_fetch_work(struct work_struct *work)
 
 		if (tgt_agent_check_active(agent) && !doorbell) {
 			INIT_WORK(&req->work, tgt_agent_process_work);
-			queue_work(system_unbound_wq, &req->work);
+			queue_work(system_dfl_wq, &req->work);
 		} else {
 			/* don't process this request, just check next_ORB */
 			sbp_free_request(req);
@@ -1618,7 +1618,7 @@ static void sbp_mgt_agent_rw(struct fw_card *card,
 		agent->orb_offset = sbp2_pointer_to_addr(ptr);
 		agent->request = req;
 
-		queue_work(system_unbound_wq, &agent->work);
+		queue_work(system_dfl_wq, &agent->work);
 		rcode = RCODE_COMPLETE;
 	} else if (tcode == TCODE_READ_BLOCK_REQUEST) {
 		addr_to_sbp2_pointer(agent->orb_offset, ptr);
-- 
2.51.1


