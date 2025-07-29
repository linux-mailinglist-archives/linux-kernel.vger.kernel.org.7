Return-Path: <linux-kernel+bounces-748915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0AEAB1478C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 07:21:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E88F1AA116E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 05:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A2D8234964;
	Tue, 29 Jul 2025 05:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="eX88Y/zY"
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2538638B
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 05:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753766506; cv=none; b=RBqNjTegANd2Z0v1MHTRxUfoJBPQ5Jh2YsGx2N4/XmimMsPBHEZS+iaowG0crsPtErLUkTwhYxsGdko7KOOVgJTzbeH0UWeG+mUG5BJN+BUelM7Z+5JvVsNQUCxM287O40WQkbb3NyYDLfobJLNNnk3Q5/mlzPutPrsef9j65LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753766506; c=relaxed/simple;
	bh=gN8omh9+jZRnT2WyX5FyUkbqpxQzn9dfqD1XgXawL5U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sUVasYjWN+NV09tqWs/6/UIXzzx5JtlafB612hl8WrhRZzUJ760B5MD2LDgpdEEXSJrilUWEq1w0wEAxlc8s1Cb1C35GfVJO3dNRxgI3vLfnvyv3xRpgrAgV1fOTJnhXBokwQiGmxQp275EvZw8XIvE1kVDw8wI5RduzUvBtsSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=eX88Y/zY; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-7074bad055eso9493106d6.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 22:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1753766503; x=1754371303; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yCNWGElp5pC1atxEbdepPd2VdGD7IrJ4GQmz0sudHLw=;
        b=eX88Y/zYhqfoyxvNv8Nl8NEA/MBUwjWDZIYZ5jP939333qitX7ppAUNGCwJ1V/kOqM
         H94Ux0Eindx1YffIyevjP3RJMzwu2oi+PDb8gcHEZnQ+RGSBe9U165FMkuN2yIuLejwQ
         /6Gbkn5Pk29MG402AZNA0sPyIcoWPNKBQBzx4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753766503; x=1754371303;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yCNWGElp5pC1atxEbdepPd2VdGD7IrJ4GQmz0sudHLw=;
        b=UyLrZWNQfzlYR3bahvgPOOqzRSCKn0VEfcKO7nRz+it9n+2093QYXT1WFHvh9W53l8
         KCCLAaznjeQpp86Xyhw+gXRLEec7C22WOvM9o9uNWON2N0YeY/1r9PvtVpe4tEtxKDFH
         uMbdzi94kNIYhmmNpmf6+TxQsEMSMiEv4dqGgufu2PXmjCw/0MlcdOhNcRNUiV8RPL+K
         BPSXSl+nCJuCt0vCc3ICALFYT7jJtQtdnWTUgEKgW9S+5fCrS+evtMiJikmxQIL2kjHv
         Q2F8nQ8otCB5A2veDtWNz2Onxh0vCYPUfHSZyh+BzQFAvDlG8d7LzN4FkBD8CRUvo037
         iu9g==
X-Forwarded-Encrypted: i=1; AJvYcCWz2ChlL/+2i/DIWjJBZvCoY5YewudLup5GrjJ3BqD1Y0eyv0JdppwQum+/Y4N0BWz7uUhQ7EvvYelDe7E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKdyRn6uTTrYy3QCVzhZhdATsiUPbZaZ6cSsU7BAEMgHk0lSZt
	Q7f1HPeKzYKy2ufaf34/WwBNo/vT9DESh/AMR51i30HD00Ry2idbvk34f/+aYaeotA==
X-Gm-Gg: ASbGncsGRS+CidrS9fgHP1HJmmr5azOuxsWNcTYqvTTt89PLK4n5ta6v8voSrfOH5nP
	L5aG2FCwwK1vwm1YNn/QqkyLYrVA2MjdhA86o8qm8nc4k2k/ty70fz5lWSiDeBy7cIrqe1QLAHE
	s3Fxwz8SL6wPT9+pVzHA47fX3lzAc03BRgUYhBLUPJeA+r2qrHvG8AwLVPQbejdo5nqM/Z6OO9M
	195/vWeOUJQ8vPTnFjoQ7PlcNk5mp++pU+us5YeAvsKjgNYFWMzXS4KW8k91XBcV5xyxBEZNMqY
	jmjOq5MlgXBu5IXohJlRD+ls+9AEYh6tVAd61EzUz8g9ghVU4jnnxDlKxgPccJuvPurds7c8frk
	1tlEzQANiQ9QDjswgQmDcoKuvNjxMzHcNdV7akqxzW6KVWHUOoUDrbl34U8pSaAweygfT4KeILl
	mYSxH4PNQxTQ==
X-Google-Smtp-Source: AGHT+IF/SW2bBwaEzMPz1p7KR+YUAhGTkvxxeMNF+awmsUxOwYCQHqsob47D0nMgbULN58Y1tyFZrQ==
X-Received: by 2002:a05:6214:dcc:b0:707:1654:cf90 with SMTP id 6a1803df08f44-707204b8fb9mr198625856d6.2.1753766503088;
        Mon, 28 Jul 2025 22:21:43 -0700 (PDT)
Received: from shivania.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7075e3208d1sm1260226d6.72.2025.07.28.22.21.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 22:21:42 -0700 (PDT)
From: Shivani Agarwal <shivani.agarwal@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: bcm-kernel-feedback-list@broadcom.com,
	linux-kernel@vger.kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	tapas.kundu@broadcom.com,
	axboe@kernel.dk,
	linux-block@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>,
	Yu Kuai <yukuai3@huawei.com>,
	tj@kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>,
	Shivani Agarwal <shivani.agarwal@broadcom.com>
Subject: [PATCH v5.10] block: don't call rq_qos_ops->done_bio if the bio isn't  tracked
Date: Mon, 28 Jul 2025 22:09:01 -0700
Message-Id: <20250729050901.98518-1-shivani.agarwal@broadcom.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ming Lei <ming.lei@redhat.com>

[ Upstream commit a647a524a46736786c95cdb553a070322ca096e3 ]

rq_qos framework is only applied on request based driver, so:

1) rq_qos_done_bio() needn't to be called for bio based driver

2) rq_qos_done_bio() needn't to be called for bio which isn't tracked,
such as bios ended from error handling code.

Especially in bio_endio():

1) request queue is referred via bio->bi_bdev->bd_disk->queue, which
may be gone since request queue refcount may not be held in above two
cases

2) q->rq_qos may be freed in blk_cleanup_queue() when calling into
__rq_qos_done_bio()

Fix the potential kernel panic by not calling rq_qos_ops->done_bio if
the bio isn't tracked. This way is safe because both ioc_rqos_done_bio()
and blkcg_iolatency_done_bio() are nop if the bio isn't tracked.

Reported-by: Yu Kuai <yukuai3@huawei.com>
Cc: tj@kernel.org
Signed-off-by: Ming Lei <ming.lei@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Acked-by: Tejun Heo <tj@kernel.org>
Link: https://lore.kernel.org/r/20210924110704.1541818-1-ming.lei@redhat.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
[Shivani: Modified to apply on 5.10.y]
Signed-off-by: Shivani Agarwal <shivani.agarwal@broadcom.com>
---
 block/bio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/bio.c b/block/bio.c
index 88a09c31095f..7851f54edc76 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1430,7 +1430,7 @@ void bio_endio(struct bio *bio)
 	if (!bio_integrity_endio(bio))
 		return;
 
-	if (bio->bi_disk)
+	if (bio->bi_disk && bio_flagged(bio, BIO_TRACKED))
 		rq_qos_done_bio(bio->bi_disk->queue, bio);
 
 	/*
-- 
2.40.4


