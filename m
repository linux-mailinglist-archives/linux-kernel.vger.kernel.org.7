Return-Path: <linux-kernel+bounces-890527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D01BCC40433
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 15:11:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9343C4EAC70
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 14:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62B35328612;
	Fri,  7 Nov 2025 14:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="auhHcOML"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB523271F9
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 14:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762524668; cv=none; b=aPnVdcfI7kdyPoVPjjbuYlr+EoJI9Skduw8t8ovO7DZQQfb90qbjaI4fQHE2fP1E+Jxq2GDQfbaclWyyJz3dG4qgs921SIw6z7uRJEjCgKmhwgXMpMYzjDfsdVtchZUq38/2UprZmp5Dx6dhnGPdDvXEUyAwT8TbdGeQvEV3ujQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762524668; c=relaxed/simple;
	bh=7oY4W8cvYI7cWgk2hDetziaayLxMm08O1hUX9ep82XI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MqsvMcFpEupP50jCoUQj/aa54OkVuzgXor2XicKv5BGBegkGkLv+MAASItbj523zNyU2pqrqfWG37b61zVAtmsqSSMIeNc3FNHULcYi98yQJvmMox5myj+cTFZSxDfErTVEOGlh49eTwz1yMV2DMD4RtUd0g+fnTjvyFOYhx80c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=auhHcOML; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-477632cc932so3469175e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 06:11:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762524664; x=1763129464; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=saC/xSM2GWNzn8WIqniCyfPLhsnZ0TcGnftuhkvfXXw=;
        b=auhHcOMLR7gD0N4E3861Gj/sjnXMjFRFpmAtuUguqrZ9RTObr5luCVIJOitseYOxA5
         87dsyTnEmmk5wQyA0WeRV6K9e4tK2lH18xnFtpsO847x6wilOjbrj/fTGa5new9G4qPn
         Lp7roOcyC/fq1n0Kpi4GCj833dvGRmp+xrLQL2wP6HkULw6XwgaHL2dVZnHiLksdRJLU
         cU22xFFEH+3TWo5rg/Kwe5WpFkwaZsSmqD4C1RfXhS3ay6oh+2FLPJUGu5uxyYeZvMLq
         v9E9GxnZMk1L5VKLq7B/MKOAZtjdBgttKTv8YsXbB+W80FKFjg5/PXq7vE0XMBbt1Olm
         4v9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762524664; x=1763129464;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=saC/xSM2GWNzn8WIqniCyfPLhsnZ0TcGnftuhkvfXXw=;
        b=alamcYFrE8h9gfYjTEHvYbeQw5WCARRfyuUViNwufP002FfqMTH/MbxXL0Tlq9/PWX
         a1HnMJydvi1NYXh3IPkJ9ZSXfizOBG29aEDRUd04p1fs2a0Fr2TUkGNwQMh3xUizH879
         BMDlrieqnZV7hSaOb9568C6ZEQoD4VmwixFpRX80PHojskpRySKmQn2xMHepDmoCsDyO
         FzFk5zme5d31+fod4inT1GUlAspdEBREU7RsTtAGooCzzUXcVkoYLVvmrW9s78HPI3Ev
         Jn/Ulq646OZ6US/WKzFMkOOT+SdPwvH8api+e6/AqQ39TPAplzGS1iaFLDg3jP6/BPYg
         RhGw==
X-Gm-Message-State: AOJu0YwF/g5Cs4b1oyQGQAHXUo7mUpb9gYcKxH8aF4rI7bQZxmJnS3dO
	e7prmwViG+BelQwaZDcZcLoXyAXGf7ALTCZSQFrKFOKWeEau2NQ3GQkn5kv0H6qtZ1P9V8ytrKm
	ELjnB
X-Gm-Gg: ASbGncufljPCoxhJPc0q6dG5hk+C6uWYrcfqGn+JiurdxcbHgPQLkbuFyeIw2Hp8zGp
	cC01Jzri1iHRsUdWjGch5J2P7hheUlyo3bMDGXZrjnj31jnDGDJHm43giWPJwOGzmwobP3jsHSp
	bk3uoHSzcX7lrkghmryFXIUjyAu9H7KbJ2mi60rW0C8zXn6rq1gjQMMAGYlWxIV+t4h1EGTwDPR
	qxYl7KXlGMrgTp0zEw8gfqHdXhcmWqZpe5xrD+VyIUHjCY4DEUNNMFpA/SnjeedWHzb5U/VDmNW
	N0jNLgRmkEBPyO+kMsD4UPQccu60jGBL0LmGaprwJw+fiwEVZG+FYr3PWc1nmB5bUnNr+iERPLk
	gwocT0qM7MCGzfK6mf1AcuosXqqdDgrfTVnCzsIBI3FbXJvP9Ain3RNDoNQqaVFPDtO/7TvgKdv
	7eHCDM7b4O8cZS7FLyRemEO1B9
X-Google-Smtp-Source: AGHT+IGKyGh79+Bwp1DW6zyVUm25mj+TgdIHaXGyejMxXcxObw2DsmyhhvrgTD7xRs8ge4kMqfNcTw==
X-Received: by 2002:a05:600c:1f0d:b0:46e:4586:57e4 with SMTP id 5b1f17b1804b1-4776bcb8963mr24846865e9.24.1762524663735;
        Fri, 07 Nov 2025 06:11:03 -0800 (PST)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4775cdcc552sm181174875e9.6.2025.11.07.06.11.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 06:11:03 -0800 (PST)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: [PATCH] media: ddbridge: add WQ_PERCPU to alloc_workqueue users
Date: Fri,  7 Nov 2025 15:10:52 +0100
Message-ID: <20251107141052.221108-1-marco.crivellari@suse.com>
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
 drivers/media/pci/ddbridge/ddbridge-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/pci/ddbridge/ddbridge-core.c b/drivers/media/pci/ddbridge/ddbridge-core.c
index 40e6c873c36d..d240e291ba4f 100644
--- a/drivers/media/pci/ddbridge/ddbridge-core.c
+++ b/drivers/media/pci/ddbridge/ddbridge-core.c
@@ -3430,7 +3430,7 @@ int ddb_init_ddbridge(void)
 
 	if (ddb_class_create() < 0)
 		return -1;
-	ddb_wq = alloc_workqueue("ddbridge", 0, 0);
+	ddb_wq = alloc_workqueue("ddbridge", WQ_PERCPU, 0);
 	if (!ddb_wq)
 		return ddb_exit_ddbridge(1, -1);
 
-- 
2.51.1


