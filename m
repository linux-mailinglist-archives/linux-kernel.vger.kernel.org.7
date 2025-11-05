Return-Path: <linux-kernel+bounces-886677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4997EC36435
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 16:13:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 960B04FE2FD
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 15:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A967325494;
	Wed,  5 Nov 2025 15:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="YpXa65DJ"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31C832E698
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 15:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762355322; cv=none; b=Q4S+JUXS85PJcsdx1YCIK38kH1Tpr+IrUDFhFY8N1MPnwQxGp30C6TT/DDRMwCaXuO7OS3QmdThcMF7BKb++omC5H2AGaNfpp+UhRfy0qKEv3eJleHOg4+nnfLMkZV9nQZoJAUpw+Pp21HIUP9w0IIfDd4LWkMQWARB7IegIBW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762355322; c=relaxed/simple;
	bh=Hf/rfLR96qfpPUUD2e/foDC8QeKSEdcQO3QrgpjU9tc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WxPAIKyIhubwvuVewygz8NkboUNTruDEGVbeHi5nQqCKWATStRVB6HegOz983a5GZxsHbdOQOLB/uh3zOct9xt8Vyw7V0182qt0SsrrFxxe10XRnd12xoE6g+uQXcjFkOC61VIbeHUz+VTmfH/HqsQ0Wq6zWWmT1+dzAUSYSLoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=YpXa65DJ; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-429ce7e79f8so2765950f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 07:08:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762355319; x=1762960119; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=itio/ZsVwLCabLmzfTJkSF00ft7NW0DfrxBlVBCeKeY=;
        b=YpXa65DJUBlUJHEhy4KeVkcpo21pf2/juBz0kkgkjs/f8VUGr0ohjV+uqPDv/e2yRP
         UmuU5sOwc+w6c4+gdKSCKSjuYnCZpOFSVTRkChU9iAWhy4XcLIKeyEXCalTPWKsNacdr
         vGg57Qw1owfwVJu9xCV5wLs04zrYeBZsg2tWc5ltHDjPs7NNhUpIGJfL18XvTLHESyvs
         hZ4Vs6elSLHJAe5WIzF/MzJdIvQI3Dt5ZwixLNOBucsqUddaROuqFRmYa0WYca6swj0R
         oLoll4k/Z9EhFsXEJKdIRGP3M+Wpa9kDhnPggyZiXWrI7L15dOoo5N5kBvuoXGHwT6xY
         FMFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762355319; x=1762960119;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=itio/ZsVwLCabLmzfTJkSF00ft7NW0DfrxBlVBCeKeY=;
        b=cMwKmH7Cy7eKyQTJw1fBzfdU8hF9qL0btrBB/g5h1gwD+Gb4qeqwTjIqfgPCeS/gUr
         Wj6wXYw3QjJGsIFzL0/QNYEodxPt8rcDv2IvYCHtSE6mPnCLxyMenOkOpFrOeIj7jYgg
         YrBOWGcHk6LcgaGlHQI8zwWtfKsxt6v5LEXi19LSX4OWG8+Bgp+MxUwGrqZhsXmHHVjF
         YBUQqIeBv2dNxY8Stp73V/X1qxx2KLmwx2PhFm+eqntvRYEbp8lwpZKPe8cgbz/rWqlY
         tcI2O4DifZ4Kyryb3zDx0CBFuiPymJp0QLNBfyeY16KJH6FhaXcq4HnLwRSdMSrMavCF
         0/3A==
X-Gm-Message-State: AOJu0YykKy9W9+DVXeZSlYuYqYyWUZu6emLhnjaaXK8/048c2L/1r8E0
	W38pd6u8qnTK6uyDLb45g5yM1H195hmz5Pup0RTMKU84bn9N4mqnTz6+5wUk9y8x8qKOUjsAkf3
	R6Tae
X-Gm-Gg: ASbGnctIrxi/HRDhsS17Im09Z6H37XiggPzz7DWMUINmAwUfJZPfhdy7liV8UOIFPp3
	uHJaI9KErJlwWLrRnV69COUgMurZkpdn4Z5HHNDfCTmQ6tRxqAX5cMONu9N6SzXR6MhcBj+omJu
	NcTgha3px2lNPyHu6uJjpkrU3SGlgyMas5Mia2pDfz95LfSZ4eh3ZB8cMDdCcxIb/TusXcjslFm
	btMDuVUAEmWV9VDyuJy5RXts0aNeIyitnl1LWIsSC57QSeu47dbvpLSMZIncBSqCPpdikpu3A9G
	BCSi8kKWFVRyDeaHVn0QsiF67xMddqPLEMCJNvVPYao+WeQ580c1dwRjw3AGbrnoYLzT0Uno6Oz
	A1/uGHJOSy8JOWKli165PFhT+NXrXkn5gU3SQ6mA+dZBHAaOP+6bD75cTekdaFCjBe3ktJOLjU8
	nI7mBn5aIaxHHWFV2ICRjLkk5WZ8l6bJdHLg==
X-Google-Smtp-Source: AGHT+IHyjVa1GIzRPu08WXNQml466hsDkpEFv1Tr9nN3l1ce6eu3HfF96OLNZcs85q5I7sclBYcfoQ==
X-Received: by 2002:a05:6000:64b:b0:429:ce0c:e67e with SMTP id ffacd0b85a97d-429e32e516amr3160567f8f.19.1762355318901;
        Wed, 05 Nov 2025 07:08:38 -0800 (PST)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429dc19258bsm11750758f8f.12.2025.11.05.07.08.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 07:08:38 -0800 (PST)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	nvdimm@lists.linux.dev
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH] nvdimm: replace use of system_wq with system_percpu_wq
Date: Wed,  5 Nov 2025 16:08:26 +0100
Message-ID: <20251105150826.248673-1-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently if a user enqueues a work item using schedule_delayed_work() the
used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
schedule_work() that is using system_wq and queue_work(), that makes use
again of WORK_CPU_UNBOUND.

This lack of consistency cannot be addressed without refactoring the API.

This patch continues the effort to refactor worqueue APIs, which has begun
with the change introducing new workqueues and a new alloc_workqueue flag:

commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")

Replace system_wq with system_percpu_wq, keeping the same old behavior.
The old wq (system_wq) will be kept for a few release cycles.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 drivers/nvdimm/security.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvdimm/security.c b/drivers/nvdimm/security.c
index 4adce8c38870..e41f6951ca0f 100644
--- a/drivers/nvdimm/security.c
+++ b/drivers/nvdimm/security.c
@@ -424,7 +424,7 @@ static int security_overwrite(struct nvdimm *nvdimm, unsigned int keyid)
 		 * query.
 		 */
 		get_device(dev);
-		queue_delayed_work(system_wq, &nvdimm->dwork, 0);
+		queue_delayed_work(system_percpu_wq, &nvdimm->dwork, 0);
 	}
 
 	return rc;
@@ -457,7 +457,7 @@ static void __nvdimm_security_overwrite_query(struct nvdimm *nvdimm)
 
 		/* setup delayed work again */
 		tmo += 10;
-		queue_delayed_work(system_wq, &nvdimm->dwork, tmo * HZ);
+		queue_delayed_work(system_percpu_wq, &nvdimm->dwork, tmo * HZ);
 		nvdimm->sec.overwrite_tmo = min(15U * 60U, tmo);
 		return;
 	}
-- 
2.51.1


