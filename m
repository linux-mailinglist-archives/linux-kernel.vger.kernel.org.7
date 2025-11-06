Return-Path: <linux-kernel+bounces-888925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A38CC3C499
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 17:12:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DBCF2502CFB
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 16:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AEDC345722;
	Thu,  6 Nov 2025 16:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="WzDUul+g"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B463469EC
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 16:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762445305; cv=none; b=Xn64tGYbZywbjo3ICVibKWUCCZBuyd39EDFKzrVemgzHMKrf4PEQ6/fgBezTAbok1H/24uQAW4gsvkpjC8ekXF4fQCbgOqeSKVSaOhYZUMi4AO8lbpTLSA4BK+eTJLNrlKF18RaCJUPEbpWH+JqFi7zSc84LfKeTogsAE1I4IOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762445305; c=relaxed/simple;
	bh=xPWclQvY+EnBtUcWHuPqxyG5ICL9eKEa6h1sgDCttAs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pY63ylwidCj4aycT7q/1u9H9aFLTE11G7tgDg7licr6Ta1ru0ve645b4DVygmmiTJZnE2vqsdjvyZ7hRq14L1k1qU0PgGuPyW4O0yeKRZ1g2yxf2uPUjjS5RumDYQbicKrX6L4Cgc/cf3+NAQN0LlkS4d+V2xAEeSWudj6xRrVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=WzDUul+g; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-421851bca51so939407f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 08:08:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762445301; x=1763050101; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nx1lPTEbzZHY1qdv26YxvfoI4idRJcQOTqxZM+W3Lcg=;
        b=WzDUul+g+w2wFmZ2zTUAvqAHNkhLnfcbNhVc4GXrKf/IQqyF/M85+h6P0RRdw67+HY
         Q18CaFi//xYtGsGT78VaryIwu+ecbCx14sRB6DNCGVhKtfQodVI8G+5fcpscsecH66eO
         ZHSH2jdWumGPWFmdHSO9y2muY/6T2O9Mer6U44B4Wyxid+uGkL9Ebggbk+69QbvXMqAU
         9D0/0qzkrEzFL5OKGHHljcvoy9EoBgoJ7xgpXh4/PWPpx8K6ZxLDvwN8qlk11gLwLyVx
         r5nn65msZzaxw1yeYHYFBqVfKIdmJj42ft4aX1NAOFa4nNsCII7faY3V2ENDqkl2NDa3
         GdYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762445301; x=1763050101;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nx1lPTEbzZHY1qdv26YxvfoI4idRJcQOTqxZM+W3Lcg=;
        b=tmjpTTX5OHn+UfxsIhKj/h0NZeVI0+Zciipdwji+kM0BEUI4WWnvBSErTdKEHDiMTH
         WKZN6QzZRhCN385ArUf549vNvk1IA4tjQpOL246DAicmsq4IAOVXXpo9l7yMAu3K+so7
         IMb1XERFS2c9iVxRGF1Khhz2d2VvVzY7OPudBss3aE6FtO5vUQw4fybTYhqlQif0TKOb
         D3+LNlPfZMUR3pTFsxigjEaHVn1sP8vsGAJCXgmJFHZQ2FFnNPxKTO8MPcRV+rIGycOq
         xgE8nX1j6HhTy8fet2JlXNKM5K2nAcvlmlk0vTm21M4baKDE6EFXRaCfk2NwfYp4kXVs
         ULPQ==
X-Gm-Message-State: AOJu0YzuOqfdRNU/nVr4BOOJEnfOBhjUOl3y0UuGy3BeKHfdyP6xlDYc
	c44eIxnskmzqH1wzioLI6noB0/6GfMXzQYb9O4o7v9Tu7aUamrjpDWW4tIgBroKp1JmtBmI8V+h
	9Na74
X-Gm-Gg: ASbGncu/Tx9HHmxdh96WmU0qx3ogT9oK2cjKQbxjufKOmBH6usF5mTbjgITAGvZm9XZ
	sXwNdoNSF19Dkqax8mC5sYGThAi460uaPRSduyNWrmu9252jlbQTmj/eCM8/R29YUe4DUkvyiCT
	F8BAlUVPdugV6jclR4cOY2RMONI9UGzasR19M7BosAh/aBmXK00gs6WM0jjrL+3ny+BsCYoLOSs
	EuB/2ckDtDNbezZg+u6tOLVMmH+aQlGJ/Ip0p/TyMdsXByZR11D7uRM/iAtPNknWz2Gl//rSwZY
	3ZD2rWJwKEQkxKmp8K3CXYCMRv4wcy7p4MB6/xCOrzT1ByzBf9BDh3pefDC98zX8mG9n6tBLg0X
	bLQm87/XnOYrpg45wplUdaJhZ2ZTUOSzZ40YAwnOoH/POxEN/gQz9m2LNyKm4EVmeZIPg4sDSy1
	yS9qCk7U1tyVsY/bV+qiKw9kzwRQubG84cqw==
X-Google-Smtp-Source: AGHT+IHrwHGLgBBhAgtrfyKEpFfxFAA7i3wIf/3/ZalE+AmFaR63fQ6Dh3eaDSrDXVqOyiQRM7ThTQ==
X-Received: by 2002:a05:6000:420b:b0:400:7e60:7ee0 with SMTP id ffacd0b85a97d-429e327888emr5905151f8f.0.1762445300744;
        Thu, 06 Nov 2025 08:08:20 -0800 (PST)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429eb4037d3sm5893097f8f.6.2025.11.06.08.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 08:08:20 -0800 (PST)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-ide@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH] ata: libata-sff: add WQ_PERCPU to alloc_workqueue users
Date: Thu,  6 Nov 2025 17:08:13 +0100
Message-ID: <20251106160813.314932-1-marco.crivellari@suse.com>
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
 drivers/ata/libata-sff.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index 1e2a2c33cdc8..785b6e371abf 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -3191,7 +3191,8 @@ void ata_sff_port_init(struct ata_port *ap)
 
 int __init ata_sff_init(void)
 {
-	ata_sff_wq = alloc_workqueue("ata_sff", WQ_MEM_RECLAIM, WQ_MAX_ACTIVE);
+	ata_sff_wq = alloc_workqueue("ata_sff", WQ_MEM_RECLAIM | WQ_PERCPU,
+				     WQ_MAX_ACTIVE);
 	if (!ata_sff_wq)
 		return -ENOMEM;
 
-- 
2.51.1


