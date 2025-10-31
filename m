Return-Path: <linux-kernel+bounces-879882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B5698C244E2
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 11:00:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5C9E34F4058
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 09:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62722335097;
	Fri, 31 Oct 2025 09:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="L9W+SN3I"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9169D33375B
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 09:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761904617; cv=none; b=aaSG4Seuwp+GyUjGqe2fnZ28+CJ3f8LqRobd/8sdydf8I3i24P6fBLmL0KAjMz3C2SlV4hMqiYWXI0E2/eVdglIMUM7bkFlHB9foZvwN6w3p8AttQG+PhX8RInZtN6L2hhC7AQbl86hYD7Ahi5JPY5tkSyrwWen9bD6jLAk4LsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761904617; c=relaxed/simple;
	bh=YsRvqvzwy42IvsqDkcBl0YyIAOhXzGMpxsJ8NofpaA0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fnoiXVTzwakTK0UZq5fpoZXIrNbv77K1ILw328W+hhbUFqMHVCWcJMehOupuMLNG67Ni+E3/0B797dwdDRtk4V7o7V63yd5BzEaNFRj6GNqimzke1lUv2LEFNQQhLkfsLY0kyJWzc0O3o5R8C5Y31U3Kk1fmrr+uox6UKQSjAQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=L9W+SN3I; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-426f1574a14so1341120f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 02:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1761904614; x=1762509414; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wj5wFR8hbemxjJEZ74XNLCfMf4UXzmASpi1RkT2VDLs=;
        b=L9W+SN3IK4LSuka3+vex1h2xg/fdpPfQEEsTE02E84HyN3F6FMqD0U9pn9c7kZIfUJ
         n4Epv8Ru4Z7qPM3BdlV1KxrlCoHlq1Ztn7SK+nBd9Bqy5Tq06ToIFQibS6pE8urj2cq8
         RcgCS+6VKJrG+t+ur0VCIwzAIGesvfZFTA1QVzh0aCXQl2sBOb38n8wWgglvKZRN6Z9h
         X7TKjUnq5aj0fXa28K7YIapdb0KQ6TLQHUVGLykssWj0XeEhuoKYqukWCE48twwwW480
         8Ghf7vaa1J+cs4GEvxAV4n7VfetDYHpSjcHgh2lvcGHO2i7fO5SOECYm6552Oot+tEUG
         Qc6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761904614; x=1762509414;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wj5wFR8hbemxjJEZ74XNLCfMf4UXzmASpi1RkT2VDLs=;
        b=QMuysyg/Y1x9Vhc1ga5ebp1ex7i3/AQHXGP0Qrj7XY/aRqXZreZ9ZT3DNt/ZVIf+Fa
         yHTNOoTUato5VyJHGd/TszrgwJLyk1rK0OxhTuV3d3FYQ6MTwnmgJ4zRNT2KzikWXlfK
         TzQXQ1XsoYvjTOU5d0uOy8o/s9IAPDa6MvyStmOP3XXVUTuSMToa0r01jkf9yQmjqCfJ
         AkxUrmTfgh9AQkiL3PG0HOq4GPjTG8vRape3R90ptaZClnJHOMnSfhFkpbUtq1DicdVi
         Y6/yDVtWAaqqEAIPnoaEyC34psXAPaR41fg0AB3wAsffml4uwNDZSONYEiBCh4fxfvgF
         avgg==
X-Gm-Message-State: AOJu0Yy8tf8dJ0hGLZuARWi/KJAkUBuGQUPhaV2r3Mfoq32wEboSPYZB
	ULHtd3bVI3YtrITtg7vpYRP5vFPpiw9/9ugj7WsObYK523IJNZh2R68Nz6Tafwo2CwvP4AlC09m
	b2Obo
X-Gm-Gg: ASbGncseqD8C5qHYMJPzAqfHsJl8YXpiB3sAi/w6N+RvuUvGiCF9uacDzSt4Ew4iJsB
	iViVZQEp/ggVlcWcOuJz7y5rv3+b4gVYlziUd4HxuYjn8Atyyd9OELQEoEJWoIH/Qk0b2byUAqV
	5mkdVZnRPqPWO/ueIBkUEKwWGSyyFmpzKZm4QgVVH5gFAXYsMpOff4Dm0zasscdzt5uRhiywf+H
	zu15mEUQzxJ+vnhEtXWaiT0vHWXLZ0CTn5/W/Wn3OrDmVprLDnS2nwNl495uXiBdVXoR9FXX4/S
	w3TiDShzkR/6aXnaaGvQdqW2F5uuZ0A3NCspFX+UAszqeOpsF7Qw9w9hOyBfrhq6gnxHb0a/B2I
	juTCxHLE/U1KsX6KGmEtTOrsE3GjiQbX4LBOcD1m4+EVHwIiPnZHUWGYutM9A+0f30AzXYAc1Wo
	Fmel0Tmzx0eeTkd2niFdpN59nb
X-Google-Smtp-Source: AGHT+IGvgD1iUrqYLeXYES3g/5f/GyDFaDz9O3/AmAhZTEp0SFV6QYXUW5hz3hGfRU8tFX97XX6G3Q==
X-Received: by 2002:a05:6000:220f:b0:426:d582:14a3 with SMTP id ffacd0b85a97d-429bd671cbbmr1825694f8f.9.1761904613645;
        Fri, 31 Oct 2025 02:56:53 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4772899fdfbsm81572335e9.4.2025.10.31.02.56.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 02:56:53 -0700 (PDT)
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
Subject: [PATCH 4/4] scsi: scsi_transport_fc: WQ_PERCPU added to alloc_workqueue users
Date: Fri, 31 Oct 2025 10:56:43 +0100
Message-ID: <20251031095643.74246-5-marco.crivellari@suse.com>
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
 drivers/scsi/scsi_transport_fc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/scsi_transport_fc.c b/drivers/scsi/scsi_transport_fc.c
index 3a821afee9bc..987befb02408 100644
--- a/drivers/scsi/scsi_transport_fc.c
+++ b/drivers/scsi/scsi_transport_fc.c
@@ -441,7 +441,8 @@ static int fc_host_setup(struct transport_container *tc, struct device *dev,
 	fc_host->next_vport_number = 0;
 	fc_host->npiv_vports_inuse = 0;
 
-	fc_host->work_q = alloc_workqueue("fc_wq_%d", 0, 0, shost->host_no);
+	fc_host->work_q = alloc_workqueue("fc_wq_%d", WQ_PERCPU, 0,
+					  shost->host_no);
 	if (!fc_host->work_q)
 		return -ENOMEM;
 
@@ -3088,7 +3089,7 @@ fc_remote_port_create(struct Scsi_Host *shost, int channel,
 
 	spin_unlock_irqrestore(shost->host_lock, flags);
 
-	rport->devloss_work_q = alloc_workqueue("fc_dl_%d_%d", 0, 0,
+	rport->devloss_work_q = alloc_workqueue("fc_dl_%d_%d", WQ_PERCPU, 0,
 						shost->host_no, rport->number);
 	if (!rport->devloss_work_q) {
 		printk(KERN_ERR "FC Remote Port alloc_workqueue failed\n");
-- 
2.51.0


