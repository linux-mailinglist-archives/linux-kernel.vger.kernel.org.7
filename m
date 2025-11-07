Return-Path: <linux-kernel+bounces-890576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC86FC4065F
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 15:37:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 519FD3B68A2
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 14:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3955A2E6CBC;
	Fri,  7 Nov 2025 14:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dLa/oT4L"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3E82C21FC
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 14:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762526027; cv=none; b=c7fxdyAFK5HjLlkZF/Zzns0TqijC93xgZJ3PwAWwn8+2P7PfRfD/sgzyLuhocE3Y4caIbZOfWavYq0T0DHltDP/b9kpWKmeGGnelhUzHZs4GsQn/pvzyrLSlwokR0LUXji+VOSfELkgMTFmM1Of5jdRPd/q3085z78lsyTR7+4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762526027; c=relaxed/simple;
	bh=hjyBa29LvF5ke1bIbdIdjRleYwiz0qsv2bHQaxIvBTg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=M+vGzWtuaDZGhZJJsN4q80vO6LtPSeJSssFQwx5BeeBTpRXgGtvLG3/yJyXoN1NP0p02qKV3KUL2H6QtYDFNQ9tNRnRT+oJL97CeneqJ433AB74bFG7XJWvdGbDFMB1NNXek7Dk3ABbTK7hspQ1xJ3qqs0h6lqahD7+3Iw8MvWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dLa/oT4L; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-426fd62bfeaso326177f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 06:33:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762526024; x=1763130824; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zZwooRdHB1TiRGXyDl2NtjlO6yhOj/8qnno438SS5o4=;
        b=dLa/oT4LfOxUCj6VM2szBUjNXF8ISsp9ao6TL4LXAmBLa5VzAXB5ziuq8wJl+mz10E
         ohEfVM1Dq0hQ3vu/Bqj1aicUj5YjtcI4+ri6k5F8yZDH8nFOh3LSdYk/QsR5hc5aYUF5
         0LkokKuGIZp1LvtcwOzE+bsPt40LJRIVzOxCrWzZOiDcshZOBeFuql/ycBEbHo2uOhIe
         7tnixhdRfp02aJsCJ2DG8vGZBUgt3DMjU3t1uOgXuiPzOJxDP9efDneoFD0PmOf4wwxd
         WFNCuvKpNv7Y+Fsl/Dd3S9GWuRhgtHCR9UkyPA3mfTeGSwJrYAHYrZBrgBHFell42I6S
         Xm5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762526024; x=1763130824;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zZwooRdHB1TiRGXyDl2NtjlO6yhOj/8qnno438SS5o4=;
        b=S6uUqell28ezICnLDK8IQpbqwy0A3TuQhLc9+hvfMWni7BdNOQYbYEmYA3GsSm4/38
         NGMLqxIbP9h4la5VvsW+92qelBF/Q674X5osZ5RTmFDsz3PPwyupNjGAVriffpW/C8o7
         9QFHPqF35W+C3WXT4pPj4fqVx/syncLt2eS6NUkXYVns6rcSLis/Y+Ip0AppzbwwOFbi
         0CCW9xOQ4zNvHpx3VYrDh42n/QHcGInFwlwzSosu/qDc6+dLHor7CNfG4xdVkoc0HSLq
         Y/e6irwLvFB18fhWDPx5YyLUCaUh4xps9RZt0tYvFDzGyMfWY21RHTqC9A/p0sH5VZOY
         LkgA==
X-Gm-Message-State: AOJu0YwBvoRPPDGp1L9cK+qyjgA8tufEAwINm7XyTluarYQC3ZTNOgH8
	AuzVrkgju0UJUMxpMawuIIgmG87ZxEFazOg5k/0Hth/9hbU+U+NoyB/Fj5l9RyrcMIqWGrkg294
	4ItwS
X-Gm-Gg: ASbGnct4Nrva68xN7IheCBMK5n/KEATPe4TxWDRjP4rGoyM8uLuspinGMYc9IjKyv7H
	aqGI3A+TVy9+8HmvhlFX7aQ2SabqSl//5Pj3hI6AZDU7urCdouwZZdtN294gt+RDKyKBB1SzurA
	t3Gnho+TQkvz8dWpnUjNUiAlJbMTuaJphswhV6+43COzUJO4ZnBVEh2Mygc0bmGglU02RWX7q9m
	3TtwxgDb1a9eIowbzF2Of2Sj/boWfnhqiWCaMnXaXqhbdYd+TyKRjwrItgRXRd0FQoRJbaZV5eJ
	eZXmcxgTvcPRDqZ0aokOdYO3ACq1hSevgz7zCPzzZ99aQOqf1dSIN6OLkS1otGLipB+IySE3CeU
	5HHIARh2m0yGpazmJNECfWEysvUo9ZfR2/OArMJK8mGfB12X95lQdIZBMiiVw7R+P3YTnJIhzrB
	iXTVqGDPHbAa1pqK0QkSGU5Khv
X-Google-Smtp-Source: AGHT+IHKuyvTGNSoJsQ3fSAGflXQvX+4fyFLXoLOYbtCrxRpdLm0CfiflATW1SeGn2vQFdIECJYLiw==
X-Received: by 2002:a05:6000:1a8d:b0:429:cc01:c6a1 with SMTP id ffacd0b85a97d-42ae5888a25mr2897316f8f.28.1762526023562;
        Fri, 07 Nov 2025 06:33:43 -0800 (PST)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42abe63e126sm5647624f8f.16.2025.11.07.06.33.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 06:33:43 -0800 (PST)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH] PCI: pnv_php: add WQ_PERCPU to alloc_workqueue users
Date: Fri,  7 Nov 2025 15:33:35 +0100
Message-ID: <20251107143335.242342-1-marco.crivellari@suse.com>
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
 drivers/pci/hotplug/pnv_php.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/hotplug/pnv_php.c b/drivers/pci/hotplug/pnv_php.c
index c5345bff9a55..35f1758126c6 100644
--- a/drivers/pci/hotplug/pnv_php.c
+++ b/drivers/pci/hotplug/pnv_php.c
@@ -802,7 +802,7 @@ static struct pnv_php_slot *pnv_php_alloc_slot(struct device_node *dn)
 	}
 
 	/* Allocate workqueue for this slot's interrupt handling */
-	php_slot->wq = alloc_workqueue("pciehp-%s", 0, 0, php_slot->name);
+	php_slot->wq = alloc_workqueue("pciehp-%s", WQ_PERCPU, 0, php_slot->name);
 	if (!php_slot->wq) {
 		SLOT_WARN(php_slot, "Cannot alloc workqueue\n");
 		kfree(php_slot->name);
-- 
2.51.1


