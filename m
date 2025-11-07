Return-Path: <linux-kernel+bounces-890589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 529D4C406AA
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 15:47:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 958AE424A22
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 14:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 532812E1C7A;
	Fri,  7 Nov 2025 14:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Ih0LvISz"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E3B19CCF7
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 14:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762526806; cv=none; b=d3k/qwLWeDNJG5JDpECZ+/4BrYIZChbcVAJ7DaEBPtMM48rCgTT0ZPbBwgS8lvAp67627P6OMB5rvVZDrUWeldHj77o5PbJR85ak7xzN0/XkGgu9JSpB57Hg5MATKRoitLy037x9fW8BYgPYVJ8qU0fbakv5DrSWWabYcNMZ6ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762526806; c=relaxed/simple;
	bh=PG32q2/C37tcSmWVSZljb1bstvl2yFc123kOEMN0cb0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jIjYluhG+GHu+Gmx5/tqPiSq8R5ROjHeD4syeJNCPtssDTAxlNke4I8ZODDvgXMfjFUsJZJdhvUMdG2Qorw7x0qOzEqLyYOcLx5l1GmP7nCde4F+MxkXo8txMNzVX7rHAQzz1mS2foAPBiJkJoDyTa98gSALhQUALDXlNu0H7MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Ih0LvISz; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3ed20bdfdffso788317f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 06:46:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762526802; x=1763131602; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xN1s2+S+GMHADntnbGaR1k0FXYcbMDFsyMSEB+M8SyM=;
        b=Ih0LvISz4VrBmy1OpEwB11JUuYonSC9359RviVpkqc69ilJ/r9p5a874KjYTz27KjU
         J3B3FClVctCPX071n1nCpaG5SeFZniL4/3C6NNc2YCUQ+hj/g41Q7aOCQZWW0PPQ8ma6
         DrFdXATOmxNZyalmWqOcq6Q2b+YlxXMdhF9CF2rTQP4Ks/dWZ8uFWroJTyJ1ze/4EfwS
         xiTIvBbsuAHOAItOnwe5YBd2NTiN1eNq0uzZBQXHtqci6dNlrprCg+1nUyLHes7ikX+i
         xCol9YPQpxBTI0ArnjXWm2CinCW3stRkeNlYMBaAfacCykWfRZSS2a0S6iE/hxa5qHyv
         spLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762526802; x=1763131602;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xN1s2+S+GMHADntnbGaR1k0FXYcbMDFsyMSEB+M8SyM=;
        b=jLp16YSTH0AE424eEUuPvaG1L4vc51+ls01NCWf4iIKkIWEGFvP8AGD+RM80RfeMmS
         bGB28wLsWKriCpMVySyh2xoMN2LjoUGQWGWiLqMZTUEKk2VArzYtVPKcyiLAz5fjio0A
         ga7gcK/4xp4tbarWm6LLlYSQSOlCxgeatOHI9P6/BEQrpMxnOgUutliYYi+ED08FY4mW
         ikVCBH4rHgSS4XDi3OHhsuwOdjRfuipFwbgchlZ+S3j8tkCsd/HTZWHGiDRACSO7ClX2
         p6KPAjXEOzC32MbImFiRlQjAbyeNF4P4KplENwph+677kr1CmJr+w1usf5VnbmzXxgR+
         1QuA==
X-Gm-Message-State: AOJu0YwiDLGYmKTGHzUydcF2sMzsWRAO0s3k7JX1ihGuXezm0+IX7Siq
	2eglPb3QVb+DowC3uvtHVLd+1RarN7EyEQOgHgKg1PIKvRmrTABu+Z1ow7lt9rz9t0yOpHnXTrZ
	uTqKg
X-Gm-Gg: ASbGncuX6YZ0Q5Y+8RUHn7RKNxCHhW0WHSPfm0DdYtsuVSZfSjn8mDbn+ur5k9K85U0
	TUaVanS/TcMiOMF9WosGnlzKvu4sgQR9MKrz5cQRJSywXRJN4sNBjqm2GUG0yvBdIXJzy0h78nO
	eWu6t7ULH+yBYPxGNHU3+opcelnQvrY2iV6rFy2fK2YEPDdalxmdBj/6G2g45H8xZuqxyi4pYJ4
	c43s8syp/cZt/goXNBNiJF+Vcx+GJEiZSvCw6xY3G1/jV6r2T5WkJ1dJoAQVQrRXi/FGPYggTV8
	6V1c4/QX8J3ETutPt2mZ5x4v2hlBCOILCcxJn/qbjz63N5cn1x9O0/VweDBfVsqtKt0A8lusUSM
	D3x2CMK4SMoa++eMUWLNz4CpwXfQig3rudVP9PZtafSVEtoQPr39iJ+KX/dK5tQPxJFqh+JWgLZ
	yPgmFpE4TMw14LuyIswh+mHkwz
X-Google-Smtp-Source: AGHT+IHNTq4QU/nsBg9XdTluFXKoNfsZbxuVEONALheSgQx95SYMfnKU5USOrDPFytUBa9CezVHjNQ==
X-Received: by 2002:a05:6000:2511:b0:429:d2d2:5047 with SMTP id ffacd0b85a97d-42adc689582mr2789686f8f.10.1762526802525;
        Fri, 07 Nov 2025 06:46:42 -0800 (PST)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42abe62b1e3sm5798482f8f.4.2025.11.07.06.46.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 06:46:42 -0800 (PST)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Matt Porter <mporter@kernel.crashing.org>,
	Alexandre Bounine <alex.bou9@gmail.com>
Subject: [PATCH] rapidio: rio: add WQ_PERCPU to alloc_workqueue users
Date: Fri,  7 Nov 2025 15:46:35 +0100
Message-ID: <20251107144635.253929-1-marco.crivellari@suse.com>
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
 drivers/rapidio/rio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rapidio/rio.c b/drivers/rapidio/rio.c
index 46daf32ea13b..38fbb77f5f61 100644
--- a/drivers/rapidio/rio.c
+++ b/drivers/rapidio/rio.c
@@ -1994,7 +1994,7 @@ int rio_init_mports(void)
 	 * TODO: Implement restart of discovery process for all or
 	 * individual discovering mports.
 	 */
-	rio_wq = alloc_workqueue("riodisc", 0, 0);
+	rio_wq = alloc_workqueue("riodisc", WQ_PERCPU, 0);
 	if (!rio_wq) {
 		pr_err("RIO: unable allocate rio_wq\n");
 		goto no_disc;
-- 
2.51.1


