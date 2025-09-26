Return-Path: <linux-kernel+bounces-834562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB7FABA4F27
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 21:10:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15F53189C255
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 19:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D74A23E347;
	Fri, 26 Sep 2025 19:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Bxz/9gbw"
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32238221F2D
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 19:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758913799; cv=none; b=WnIDKlnyXVPOQbPVFRicPZkvlNndjOOmkzzKr0M2vqxeXrfLbJUVwApX88w46q2BccTlYaOT+jJ4D5tiGIGZyfcDp8Js/deg91v5/sqX2sDEZcOYgjby/D/pllxn7j1FwX7C4Td2WRy18LQavfnn+6LOcYR8k9XaO0ZIrj22c5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758913799; c=relaxed/simple;
	bh=Q62ZDzIToQkxvjjbMJvNCic+DFZ6WhJVsANbaVcm4oA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=npBXRai1dVakXWoioqqPT+Oc0xOFPunwya7uwdjpWTv3V5jg3GRE1K5QPTXO7Shew0m9fw4UkjAXSphPa3YXcnsTPbqcT6lgVUqyt2FKV8eRVWAUJxuq/ZxQ8UL3bFVGj8sYUe+xSeF4DQwrb6QQar1T7W6kAE0S85U2+p82+tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Bxz/9gbw; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-917be46c59bso14198639f.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 12:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1758913797; x=1759518597; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Wvtv/qcICkYTsHwiHykESM7tgNOYNZooGCxrW6WCvqE=;
        b=Bxz/9gbwao0yCR3KUDsxKggFjsI4aXPvJ7Ytohc77hNUFyOoBebjLMdVcNjpq/Cley
         +WhDI2LWEURpbJ+0JRtmpdTRLECitwhsEfcRG2QVOWa84rgTCOwiI2K/1qL5/wVTdGx1
         ciacthNOWr/cXNIPNKTuNYxjTb0gPEoJK/U4UEJTghY/RsDLyNzzkWrQoUvlRkuhnWml
         QiB05h7d/nMqDzDy458LdWV/p7Kg0a8Cjwq0oL8/cz8g4AUoW5LxWeB4tqQF+gWTGkGf
         4GCWTq/3ft2mW1HOYPojGggy5G9T+QvyCEUjUetotB2NxGkXcE1j1sm+hP2455Wi4WY1
         l8yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758913797; x=1759518597;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wvtv/qcICkYTsHwiHykESM7tgNOYNZooGCxrW6WCvqE=;
        b=HpuiUxKvTCIi7lw3kDk8OcXnVrYUOGDVEfXi74Os/Ppg9BFFOkwjvlyoR/nur6fxBp
         cfpTqivA6JHcHB6cOIXmgQ1JySHbjC+5GXLHOGdr3vKX/g84c2gtN1i4gc6iIrLmsDg1
         zFRc7phPb3XJjAaCXqGMYYWYeVMtC61d6GuD4CAeECZGmmDjtZzx3WVqJTBtkEyqqH7Z
         G9S/ErXhVCgPeV3fz9ziHRWBOYpgUBIQr5JGhxgnY44W+UTXvP6Y9o8TXtx/ynYsXeSA
         jPVyf1c/QHbaxGd1rMnUdCzbNAgbFgofn4Kpzi3zd7dhOgs60eiNUvXPBriX+BFvPi2Q
         1IwA==
X-Forwarded-Encrypted: i=1; AJvYcCXyivkQaO2inN+4oSlSguMq26cP1h7u4dSJlfg1KTZo9RwUT/PjwxY9xVm3RLF2MTVxgsbPMzZ3DcKLQl4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUrZgu/W2+C3cHx2Z01de0g7Wad2zjNAa+QUOGyy32aE9J/bnM
	ZyDVh28olWpVllW/HSNSbwRBOYuXIuPRYImJWOPA8IJuW12ZBiD8Bnj/1oCvrb9CCpw=
X-Gm-Gg: ASbGncs4QmQNtJcq1v5l2RKtNFm/RG0mEviFeBUqvEYPYbzll8CtE2wF000I4MMeKDq
	PI8E0SXlpRx9pXQQTXV6EoACXGckDZjQbhQUnIbm8HnTX1rG50w2Q90x4RNG3+s0VCn0GKhSsMD
	+45GgeP8yyT005kwc7xBN3ZhA0LWOiQNeJ3JkrgkAH8lS0uswaFXX9dIRBDEiUHJy3GWGYbN6iv
	tGBsraSkMAyi9Au/wx+3IC9mE7Gb1kqsHqnmm/6+OhIaH5J4WEta9Jp/Vo5JQiXag3H9CCHM+md
	J1z6a+K1lN7eC7Hg6cUuaR1A+PN9imNgcimBwfRnD/Y9rxe6k7DE3zxQSfdZsxBDtgImJOGV0f0
	W2ePJNQVwPeJ1aYfH5EqlRCkBxvMbCvt7zWtB3S/QXkh9rMc12HWR+GJfuVNK2ZX6Yac5cA==
X-Google-Smtp-Source: AGHT+IFjghvNCqO6TOfbA98+sZd3KQTpt5kAvS4oQsge2mxcUu3UVERk7C8TvE1C6z9/EDMI2LD95A==
X-Received: by 2002:a6b:6a0c:0:b0:8fd:baa7:bce2 with SMTP id ca18e2360f4ac-9016c57c02amr1232916839f.16.1758913797264;
        Fri, 26 Sep 2025 12:09:57 -0700 (PDT)
Received: from 8745f5817b94.dev.purestorage.com ([208.88.159.128])
        by smtp.googlemail.com with ESMTPSA id ca18e2360f4ac-90e48099408sm105070639f.10.2025.09.26.12.09.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 12:09:55 -0700 (PDT)
From: Amit Chaudhary <achaudhary@purestorage.com>
To: achaudhary@purestorage.com,
	Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: mkhalfella@purestorage.com,
	randyj@purestorage.com,
	jmeneghi@redhat.com,
	emilne@redhat.com,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/1] nvme-multipath: Skip nr_active increments in RETRY disposition
Date: Fri, 26 Sep 2025 12:08:22 -0700
Message-ID: <20250926190823.5031-1-achaudhary@purestorage.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For queue-depth I/O policy, this patch fixes unbalanced I/Os across
nvme multipaths.

Issue Description:

The RETRY disposition incorrectly increments ns->ctrl->nr_active
counter and reinitializes iostat start-time. In such cases nr_active
counter never goes back to zero until that path disconnects and
reconnects.

Such a path is not chosen for new I/Os if multiple RETRY cases on a given
a path cause its queue-depth counter to be artificially higher compared
to other paths. This leads to unbalanced I/Os across paths.

The patch skips incrementing nr_active if NVME_MPATH_CNT_ACTIVE is already
set. And it skips restarting io stats if NVME_MPATH_IO_STATS is already set.

base-commit: e989a3da2d371a4b6597ee8dee5c72e407b4db7a
Fixes: d4d957b53d91eeb ("nvme-multipath: support io stats on the mpath device")
Signed-off-by: Amit Chaudhary <achaudhary@purestorage.com>
Reviewed-by: Randy Jennings <randyj@purestorage.com>
---
V1 -> V2: Moved check to mpath start and check relevant path bits

 drivers/nvme/host/multipath.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 3da980dc60d9..543e17aead12 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -182,12 +182,14 @@ void nvme_mpath_start_request(struct request *rq)
 	struct nvme_ns *ns = rq->q->queuedata;
 	struct gendisk *disk = ns->head->disk;
 
-	if (READ_ONCE(ns->head->subsys->iopolicy) == NVME_IOPOLICY_QD) {
+	if ((READ_ONCE(ns->head->subsys->iopolicy) == NVME_IOPOLICY_QD) &&
+	    !(nvme_req(rq)->flags & NVME_MPATH_CNT_ACTIVE)) {
 		atomic_inc(&ns->ctrl->nr_active);
 		nvme_req(rq)->flags |= NVME_MPATH_CNT_ACTIVE;
 	}
 
-	if (!blk_queue_io_stat(disk->queue) || blk_rq_is_passthrough(rq))
+	if (!blk_queue_io_stat(disk->queue) || blk_rq_is_passthrough(rq) ||
+	    (nvme_req(rq)->flags & NVME_MPATH_IO_STATS))
 		return;
 
 	nvme_req(rq)->flags |= NVME_MPATH_IO_STATS;
-- 
2.43.0


