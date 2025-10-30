Return-Path: <linux-kernel+bounces-878684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 263E5C21448
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 17:44:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA2503A42AE
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 16:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C86552D6400;
	Thu, 30 Oct 2025 16:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="BMs5MKcw"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF882153EA
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 16:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761842327; cv=none; b=Q9x2Bxv/pION8cagcWUISWNrw54Lqwuqkm2WRo7Hq+vh0HxVA0sH2bIQ1C4B9J3ZMgmipSD950q28Yu3zWm0wrsY1nzTDANt+oTjeXKL7mWGf3VuD9PQa0xRWo3eH0tGoz8O/bGyiYH9/pkLuSyMd1oNQPgGKVint3RokOoiQRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761842327; c=relaxed/simple;
	bh=+yZIzum66M0oPmn/3oQOleUS3Pi5YkNB9duKj2LX/R0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oKn2frGWm7YZUo8mRV+Fj/zXmBTgLSak2L00gR5A9po3rUIUtSqRJT3zT3t0/YfVt9pOmimIFbCncnQgT6YcRgoDKqbiIQLQHipWgk6iwdc3bOV5sBng/ysTg4mlKAE6IfCgpOHDfOc74fqQOcAW3vAGcCTYQm6vvLa15t3RGXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=BMs5MKcw; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-429b9b6ce96so601037f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 09:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1761842323; x=1762447123; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=54giQrwwEn96jLZZhaBwfuj7+qjJhVGS+n5IIXiT1MA=;
        b=BMs5MKcwcPRdEGHBXIIEHAi2gLZWZAFj/qN9+GSE6lrW0HPSfcJUTD7Wp9mXQ4wUz1
         WNEo3v7y2DELWELE5rZoFMDVdl15Gck0+IVHhj4sEwfSjMX2QHa/s6p3AX9nZxXvFRwb
         /p4Dc0olMo8agC8m+8Z9CxGR1xD7rXO3UqHBfcTrqaf3U9PBx5a3gZ7W8gohNJjg6LAs
         hRFqdIS7EuPIcTT2o4KpW6aKFc6IBB9KW5X4oDyMihMyRjpYxsAtoxkQulOm/+/PN4jl
         1852AC9HXVCeVX1gdFHfQu+gJ8oGrqYh2NmH+Z1E6fop4JZK+iOCkZj2zFehrPQJ/76e
         tPWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761842323; x=1762447123;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=54giQrwwEn96jLZZhaBwfuj7+qjJhVGS+n5IIXiT1MA=;
        b=Ne5pjEjdSONB+cXMwUs+b+J7jiwYxkN/20kQ9YqudBcko4MrKwhMUDhRXOOenFKD2N
         jbex3FMuTNlb8pXfYHmyjOUnYc5yUbDIt2YmTl9vbxQx1SxxGB5tTpGaQN1JNSQh+DFT
         oGpw62287IO0gJ+oQv0CfT5jR3tnexzD5wcdZMjMts3BAR2a661YAy/TroDG6ybZRc5q
         2i1cFJz6dLVPjOiBCwZKtmACvfXf11af0tGgF+PHFHhao86tu/dQRtpNp1rBinJMNmyK
         8gfFWpWAI5oj9KnBOVBOkB1tqY09ZATKlVtnxSWRstNTSZ6RfdVWcO7ki4lMuhwOYjv/
         1Tww==
X-Gm-Message-State: AOJu0YwzdKCCJ1Ws8h0GVN2o0OmF9LoaEKQ0Dl3Wr2BFoUaKc6vgcTzj
	uCYP48PWOPa0TjxULYxL9WdX4oR/RGwfJOk7kWEFhIKoMqvjoQaORW3H4HgPzrXrP5uKBpHns2X
	/4Mi+
X-Gm-Gg: ASbGncsFvm3b8NlS7j30A7ptX9fmEeYx4yrU6VA9RA4vXiBDkwN2i1NEb5DYPA03q5j
	BNTkEI5VJvSd3tTDifOROfYcnNehkzil+RY6xyGxmz6Kv1gUeIeHkQxe9nKD8mrptwrgBEHhiov
	kHDyMcVXuaQYUoLK2ZaO9KmcbtYMxVXmtHNmOsT28ITm9bdMa+d8/U35l5j6GjYiSUkFv01CW6h
	rTZW6rt2rsRN8hhBk+9oLiGudTUXXNSCmyLykGkEsTD8iP3msTtWzTN88hmOC0S6Z0ZIVdtcVi1
	aJnBQi/Yx9ewcrYs/0bS/rqN4udY5XIYs4Xk/sBKzgk26twQeBrOuoJLkNqKKtxUq25+s4IfiOg
	/54xiPwLiW9i3HRkHbwG1j33LL+aWYZeepzXdI8MZM74km053pIOqa5MrMv0PN+uuTrVkw+PQ5f
	2AZ7Z5TXLOqa6iH3Y=
X-Google-Smtp-Source: AGHT+IH40grKlZFcgNET1Ic1yaJbEZTBCRZMx9hDmAfRXfwjzK7wZukFCQCR1jXrFH7HCUeLEGfujg==
X-Received: by 2002:a05:6000:430d:b0:429:b52e:3505 with SMTP id ffacd0b85a97d-429bd682fcbmr233503f8f.11.1761842323256;
        Thu, 30 Oct 2025 09:38:43 -0700 (PDT)
Received: from linux.fritz.box ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47728999a4bsm46197675e9.2.2025.10.30.09.38.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 09:38:42 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH] cxl/pci: replace use of system_wq with system_percpu_wq
Date: Thu, 30 Oct 2025 17:38:39 +0100
Message-ID: <20251030163839.307752-1-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.0
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

This lack of consistency cannot be addressed without refactoring the API.

system_wq should be the per-cpu workqueue, yet in this name nothing makes
that clear, so replace system_wq with system_percpu_wq.

The old wq (system_wq) will be kept for a few release cycles.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 drivers/cxl/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index bd100ac31672..0be4e508affe 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -136,7 +136,7 @@ static irqreturn_t cxl_pci_mbox_irq(int irq, void *id)
 	if (opcode == CXL_MBOX_OP_SANITIZE) {
 		mutex_lock(&cxl_mbox->mbox_mutex);
 		if (mds->security.sanitize_node)
-			mod_delayed_work(system_wq, &mds->security.poll_dwork, 0);
+			mod_delayed_work(system_percpu_wq, &mds->security.poll_dwork, 0);
 		mutex_unlock(&cxl_mbox->mbox_mutex);
 	} else {
 		/* short-circuit the wait in __cxl_pci_mbox_send_cmd() */
-- 
2.51.0


