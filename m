Return-Path: <linux-kernel+bounces-884665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E575C30B9B
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 12:26:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0C5A18858A1
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 11:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A55A02EC54F;
	Tue,  4 Nov 2025 11:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="U/jY9TvH"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866182EAB8E
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 11:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762255551; cv=none; b=J0twr14BFOTrkJqhH4H87XOQgog/YIigreg/GBFYENwfOvNUa882CgbfTwxV/6rn1QBx72O3zTACJGKtGwRqu6HZBJ7FZ3Plfi0r8tmC3SSCEVZaUWlhzO0yfCbyFSXPhhMgnGiPvABLXB3YfP8hDWdajvrZzvX2pySQGKVkPI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762255551; c=relaxed/simple;
	bh=nz0CMheUSMhg+Cur994tubijSX1h+9AiSkyrByGrlDE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y3u/i6upKoPOwAxUFXrGvjjsUkK/QNGu2npoKACqG2XVLJM442jVve9pJo4vwNHj99MeniYnk6rpo2iWX8goFy+wyT1dU4KynjYcZQisPUL6HXOWOJ3PbZmCd/yA5PlPPFRTh4WqYdedELg3mChJ5Q0RkuUoS/jRAR1A6RSNV2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=U/jY9TvH; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b70bee93dc4so287667766b.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 03:25:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762255546; x=1762860346; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Hz/eXxLAJrsYCSjgGA9t2bRyGKcFTsC49+GNbs5K18=;
        b=U/jY9TvHEXbxLuy+9fh+QGpBEIaWpu2Gldrf+gyWOLMMXLjooW7Frd9x/xYHKCIV4T
         Ke2mdGPd1l0djnLH6Q7htXgZDpMysrbb2oOTRGULEP3VdPlxHJUp3nQrTc55/89w/OPz
         EWNoIp+MljkPYfgcFSjpe+w1Sxnvlqy9ExklBcDerlLK4KyOIq3X2rghsCJ2L33TmU+h
         YB0mkrdcmm6pkY7k9r6Zbfev+CQ8oSwG/7HWN98LPOHCabWl5DEF2/+Scz2A74s2NIKQ
         0DbRo+6HcfBkUb8qHac4Lvr1RGOHw5+HKC+F5TtOqknCQgNu7uNKZMX9NmQ5Tpaw8Edx
         zxVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762255546; x=1762860346;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Hz/eXxLAJrsYCSjgGA9t2bRyGKcFTsC49+GNbs5K18=;
        b=p5IWe0G/SDfSd5G8VAM2WH6jXCHjT7hQC2oif1+It6MGGe0Q1XCJPs2/+y32N9yOzD
         woAzSUk8spXbI2dxqIuo4YlcUqSVd0SFLmlit9W1+zb6mcTlMvUpIzLQCOnUxNKXTili
         WT9CM3TZEPejTPSF23XjvIc2GR7atxH+ABfFmRs7lLkklT5BfeTXwECVnNetHEWBiZhC
         3eUXggxeRqx0SNHZIXofK8g4+9pksywc3CKRdiEAVG0ISP/039bCGEBPG5g29Dsf4qmR
         QO8hk04ABKdZHFJYQ4twvue0zIj9xgakemFkemSlcN87MNW86SrrjB6vtJLnokLjdQHC
         RhAg==
X-Gm-Message-State: AOJu0Yw0x9ZNRGkN1MCLc3lD5x91dDs2tPh+aSizny9YM8PHsdEMnT/2
	u3PNjzz5DipTvbqBpHYODDKfmodcY/NIvxqbri0KV2+MmDnBeRyW8r+g3fQvrthKTIWZvMRU5aA
	r4/NY
X-Gm-Gg: ASbGncu1urwwjuThgrXviPV4K0eJq/LRGdxGtwIvzdiCxhznYVJZRQwBHKozr132c0i
	gA2LTMjStNkfmV6GrwtaWin47xAIoy+fIxJj3FcfN+ILIKZbzU8L3RP0NyCbASZmiKHK/1FI3y1
	ClYLyiBq7zNoPr5vY32XvF3Dq7zIxCzEPiiWFolTBpyw1/4EhYUDA8x6Nokx2zZG/ZiEgZdz6Rn
	cq6Oodtj1KNXENx8E5jAobOtcClgiC0+kfDgu1vZRfg4C6TsFCNkXjWiHbKlyVPGtdSqfFiVRfd
	dv6JZzxHufp9B1rGWKs4etkUW4BkZ0XisG26aOarH+9YiI5z9OqD6dWUd0GGqqfgDQzEASOVMcq
	EHEOXwOM8SSITVPCt2riCrRnkUaLU9nm1ctxDByUtJkn4w7X5m7M3DBpO7GAf5olSM76if7Lt3d
	HUbLU=
X-Google-Smtp-Source: AGHT+IF1k470AEqd/HXmgoSWzg+3W3h3tiSB1rbfKQH9JA4864/MW5uhBMF5xc1yU7RXjnqRtZC1Dg==
X-Received: by 2002:a17:906:bcd5:b0:b72:52c2:b8e2 with SMTP id a640c23a62f3a-b7252c2baa2mr127511866b.26.1762255546396;
        Tue, 04 Nov 2025 03:25:46 -0800 (PST)
Received: from linux ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b723d6f33aesm184101266b.19.2025.11.04.03.25.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 03:25:45 -0800 (PST)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH 2/3] nvme: add WQ_PERCPU to alloc_workqueue users
Date: Tue,  4 Nov 2025 12:25:27 +0100
Message-ID: <20251104112535.139450-3-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251104112535.139450-1-marco.crivellari@suse.com>
References: <20251104112535.139450-1-marco.crivellari@suse.com>
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

This change adds a new WQ_PERCPU flag to explicitly request alloc_workqueue()
to be per-cpu when WQ_UNBOUND has not been specified.

This patch continues the effort to refactor worqueue APIs, which has begun
with the change introducing new workqueues and a new alloc_workqueue flag:

commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")

With the introduction of the WQ_PERCPU flag (equivalent to !WQ_UNBOUND),
any alloc_workqueue() caller that doesn’t explicitly specify WQ_UNBOUND
must now use WQ_PERCPU.

Once migration is complete, WQ_UNBOUND can be removed and unbound will
become the implicit default.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 drivers/nvme/target/core.c | 5 +++--
 drivers/nvme/target/tcp.c  | 2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 5d7d483bfbe3..ae8e903b55ad 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1943,12 +1943,13 @@ static int __init nvmet_init(void)
 	if (!nvmet_bvec_cache)
 		return -ENOMEM;
 
-	zbd_wq = alloc_workqueue("nvmet-zbd-wq", WQ_MEM_RECLAIM, 0);
+	zbd_wq = alloc_workqueue("nvmet-zbd-wq", WQ_MEM_RECLAIM | WQ_PERCPU,
+				 0);
 	if (!zbd_wq)
 		goto out_destroy_bvec_cache;
 
 	buffered_io_wq = alloc_workqueue("nvmet-buffered-io-wq",
-			WQ_MEM_RECLAIM, 0);
+			WQ_MEM_RECLAIM | WQ_PERCPU, 0);
 	if (!buffered_io_wq)
 		goto out_free_zbd_work_queue;
 
diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 470bf37e5a63..fa7a56626bcc 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -2198,7 +2198,7 @@ static int __init nvmet_tcp_init(void)
 	int ret;
 
 	nvmet_tcp_wq = alloc_workqueue("nvmet_tcp_wq",
-				WQ_MEM_RECLAIM | WQ_HIGHPRI, 0);
+				WQ_MEM_RECLAIM | WQ_HIGHPRI | WQ_PERCPU, 0);
 	if (!nvmet_tcp_wq)
 		return -ENOMEM;
 
-- 
2.51.1


