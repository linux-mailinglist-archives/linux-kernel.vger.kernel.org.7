Return-Path: <linux-kernel+bounces-821888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 438C0B828E5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 03:51:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1714A5878CF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 01:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE77523C8AA;
	Thu, 18 Sep 2025 01:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="IPjp3zaR"
Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com [209.85.214.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F4322D7B5
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 01:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758160238; cv=none; b=D9Mj4z74erSj1diC5jf4DdgLmJGYClov3R3hrgoJILPSQJ8SF59E7QldVMLYEP5P8GVJrXkrrKkAbe0BGsi8tVf7D/+4hCjcDpAfHTF06rHjZf5a2YFuGcQGVMUT+CbckAqp/OfD8B4+lJnL6ZJdqHlzpRZQ994RtkimjhOgp7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758160238; c=relaxed/simple;
	bh=hxn3BKuTiiWjfVAHX7tPq6EobZQe9Ya48ubEsGAaYuY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oFOyiYcb2oV3dL8q8ABAC8kz8V7fbEgex6B85HBlkYKqEnS4K+xsIaX6pY15fAwdrCItyLOw4/qCbF3pJ4Go1Btg5s8h2oSPDq3kMGPiCWt4ovzdj/x4F7O6eKPZ4alkvAUsw8Y8BoGynNyXjUhxhSgM7cDaLVLg2Jsh5YMSDEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=IPjp3zaR; arc=none smtp.client-ip=209.85.214.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pl1-f227.google.com with SMTP id d9443c01a7336-24602f6d8b6so756255ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 18:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1758160236; x=1758765036; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vlg78m3Ev0QtoikD/oo2CO7iAsfO2QZiXUPUhq6FYRw=;
        b=IPjp3zaRtdMhYYy4QkP79M5alW63KtArdeFT4MMPZByZtz8lE8gf1K3U4cgdTNEgjU
         iGcaIZEHilhmK2NDfSdFLf7uBx9fou2wk9UFTWY1CxIDrrkwmNWRUphJ4CSoVAFfvBaN
         wnBa5rWtzatTnMbiWR+ZoWPCTy81YK9TID+gfxTAsOvHpdDAGg0MQbNYDrtPhwQ5rCmn
         gVmVNtXUbJLlWFg+2oOYmDIPmSaOJN4Jt56dBdglWw7K9XROcl4obwnbQEZif73F+ETu
         CF/+2SxtUwKzd5zW6oEK+r0StU5YK45xhCQIUfIG8yXg9yu/oyRv02ZJRa28d13p8eg9
         TzeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758160236; x=1758765036;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vlg78m3Ev0QtoikD/oo2CO7iAsfO2QZiXUPUhq6FYRw=;
        b=BUzdd4NLDpixcBQNM0x65PIC5ownngRfpjxJSBy7TfKhDeY5pGrFQy2T6Zjw0EPkHe
         80J/njgbYDM/QWPgIK05XK9ees3BF0RQOr4qK3BM4UQumBzUEOlh2chpj4SokrN6Vemo
         HafPAefU5TBoll5HknELqGjRimj6MsdL6B0F5xGZlFgrTq1tgj/sAi1hd7nXzef35uHa
         X3LfuCbv0Zc1GueP5g56uNpYOirk/XvLvJwsNUjgi0BrOvemocXB/1pa5GXmnRpFk+QK
         G9ijsjbn7e55Zh3ROzRKmkIqTqmkpSeHoMT0xO0hFJlpV8yaoeIbw/2Irrld/hIDiCZ4
         guxQ==
X-Forwarded-Encrypted: i=1; AJvYcCW211e6yR9yGnwgJRZ2ujXqO76sq98oFsjzl/3Q6J+zA4rqmY7YjFt7W9xHLHgxEVG0S7cgvcebe6LCwBk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxemcLqpgx/zJHz+O/Mpe+jahLxlbgMahIXHoTmtTBb2QvMDCKs
	k1RzJns1+cE5tNeDZtUQ078YvM9A/XZDmn8RfC3qIYzFsvmsv10AKva0Go5XaFepU2NvmBhZgFr
	5wFmbfPowwXUxUYgshccPKLO+WwygnVVgVFxJbVO1pV6lJd2vUgm9
X-Gm-Gg: ASbGncu12xNk8szh0SEWV9+0Kl4Hw0kwmOxiLz9/QjQ/orUtuUK0qqiHhGGTZ0NtfMe
	RiexoK8aYx8jjcjArOFolC9adXHdGTsNXZfIRPgc8MRNJl8xg+X5HVNkL6y0yOxOaB0n5AmBUyK
	OQJJY63bmFrsKkAcB33p/+W/WAcep/QAgGYYiMLBQ56Qb/Gcb6epolkkM3YxK+74dZZr1LgjOzo
	NsgZ6z6arVcUHiCVV1Wufuzetld5KpgCHCTN49LDTOFKBGCk5RsT2LfTXnRoS+wo9hSR10b1ImQ
	KBeCAf6wU4a26WK0trBLZ45zwNztgZSjn1+VfHO2eEd4ac4arWlaf4WctA==
X-Google-Smtp-Source: AGHT+IHj9QM0F6hgUxJ21zdX1Ylz68rApTHUPioBu4FMtIsDFauGSTQ8b1kTLdV4AbDZH+sT6hWv12TmQb7s
X-Received: by 2002:a17:90b:4b51:b0:32e:e18a:368d with SMTP id 98e67ed59e1d1-32ee3fc0567mr2677579a91.8.1758160235729;
        Wed, 17 Sep 2025 18:50:35 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-32eddbbec5dsm292836a91.3.2025.09.17.18.50.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 18:50:35 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 1764F340508;
	Wed, 17 Sep 2025 19:50:35 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 143F3E41B42; Wed, 17 Sep 2025 19:50:35 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 03/17] ublk: don't pass ublk_queue to __ublk_fail_req()
Date: Wed, 17 Sep 2025 19:49:39 -0600
Message-ID: <20250918014953.297897-4-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250918014953.297897-1-csander@purestorage.com>
References: <20250918014953.297897-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__ublk_fail_req() only uses the ublk_queue to get the ublk_device, which
its caller already has. So just pass the ublk_device directly.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/block/ublk_drv.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index bac16ec3151c..4cb023d26593 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1706,16 +1706,16 @@ static int ublk_ch_mmap(struct file *filp, struct vm_area_struct *vma)
 
 	pfn = virt_to_phys(ublk_queue_cmd_buf(ub, q_id)) >> PAGE_SHIFT;
 	return remap_pfn_range(vma, vma->vm_start, pfn, sz, vma->vm_page_prot);
 }
 
-static void __ublk_fail_req(struct ublk_queue *ubq, struct ublk_io *io,
+static void __ublk_fail_req(struct ublk_device *ub, struct ublk_io *io,
 		struct request *req)
 {
 	WARN_ON_ONCE(io->flags & UBLK_IO_FLAG_ACTIVE);
 
-	if (ublk_nosrv_should_reissue_outstanding(ubq->dev))
+	if (ublk_nosrv_should_reissue_outstanding(ub))
 		blk_mq_requeue_request(req, false);
 	else {
 		io->res = -EIO;
 		__ublk_complete_rq(req);
 	}
@@ -1735,11 +1735,11 @@ static void ublk_abort_queue(struct ublk_device *ub, struct ublk_queue *ubq)
 
 	for (i = 0; i < ubq->q_depth; i++) {
 		struct ublk_io *io = &ubq->ios[i];
 
 		if (io->flags & UBLK_IO_FLAG_OWNED_BY_SRV)
-			__ublk_fail_req(ubq, io, io->req);
+			__ublk_fail_req(ub, io, io->req);
 	}
 }
 
 static void ublk_start_cancel(struct ublk_device *ub)
 {
-- 
2.45.2


