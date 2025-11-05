Return-Path: <linux-kernel+bounces-887269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A8ADC37BB3
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 21:31:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1D0B64ED5A2
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 20:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34ADD346799;
	Wed,  5 Nov 2025 20:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="EIOjqxkG"
Received: from mail-wr1-f102.google.com (mail-wr1-f102.google.com [209.85.221.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97835346FBA
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 20:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762374517; cv=none; b=p2E5P1+ntyM80NM0aFkm/AaqgPDdAfk40CaR3pKGBU5/3qAEiQt7lJVqDbM86VdiRdvMaRCTGcez7NrQKRRopNF5uFcBlx1M+LWJzKIrQGD4mrHGwd+gfr9rMzE3UkfOTgvAsqpObg5ccF9qbl6s4FvaPBi9lVYuOsV78X/yz5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762374517; c=relaxed/simple;
	bh=ZNQBWF5E/kCd66vnCIEh1pwOhtP6knbpleihD38HzT8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=svXMZwblX64BQryIYJumB+tCQ+5iW3DjkVfV3W5+CI/HBqhfMRoKRBMBdIob6NZbSxLkWoBiKpcmv9MD5F1xzmzwShja8Hl1SBZ2L0+nOCC2Uq3L9DUKDbogAYwW0JNusB1SiBQ3PlOb39goGDtmWgUlB06e++DssRklVYg+510=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=EIOjqxkG; arc=none smtp.client-ip=209.85.221.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-wr1-f102.google.com with SMTP id ffacd0b85a97d-429bfa1d3f8so27904f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 12:28:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1762374514; x=1762979314; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=piuezMo/+nJvsS63m8MZriLez8iEvJ7btVwHROt2ogA=;
        b=EIOjqxkGKrivEbXDb9Hzqr+XKgCZu9uLXAO52ajIC1d5bU5D+wKp8UPN/eTqZhUoh2
         jVwjznhDeZgD5NtVc75BcA68M1csx86CihXWniV9cwT4Zx7k4tN7B2zR/CFQRavzOOt+
         +vAn2TExCUJcCbb1b7egXbmLVa+oC+nAeuiDXnh71N16FtrltrvQugt1BkU+IgHOJxGf
         ydDxP14jYMripXPKDke84T4JHvEIbjiqurMgNCsIH/wdhTdgtvKLBrxl2Gq+EuSqaQIz
         TyRbpv7WBYXsUOQUr9CnJ5Q12AXnGS/VmgCyMaEw4KI3tXLRRw5YVdVZwRP5ILHGt4jU
         KJnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762374514; x=1762979314;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=piuezMo/+nJvsS63m8MZriLez8iEvJ7btVwHROt2ogA=;
        b=k3j/u6spKpkUbZRZtSTgNVEP1LYnFU+mNGUZUOBXtJBbcIMbgC43mIMu7zjlFKsGJE
         q+3hq8oEHSh0svS1THhCMLmr9cnXYNzz21gzzOe+bGi293gAnbo5rP966cbF5A+iR8vc
         j7sopN/1m8EmOFZd6+sURw7AJvEr4rksaW9W+PcrCcf3dlaSUBymrDQMgqfGf9qdrX8w
         Nyhwo0AWJjJOkfjAwtagf7BjhPw+pYLbTEkXytH9Bs7KXE5OziXITIjIdKrfOvYeC1n0
         9SFCjW8KB278UrF4/yxCsuVivwheKtBJk/oOFjh+rHa/kdY1Wjl1dwEOwZgqQw+e1rGl
         vBlQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHLJEdu2F7cji2j3I8s31NEE9VLKrplec36JncP8ILzWYQ8dmEiO0NVkpj59s5cGnJvGYEr9SBdbKGkR4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwB1+Z/XECSfPurqofEOmNAlFY+nl6s8IdLDsETn5C07vRvrqeS
	GVNANbQOB7rnGyrrQYOJp1LrpcRIhs+zX5M9XGTkRlNn/sTA59vJ3NN9Ug0ly2upOSYTk8EBksq
	GY6yMO7y2lGaULfR0YcQ42Z8PLfFhkfEyvWzW
X-Gm-Gg: ASbGncuMXPWmimyrLWYQNyP153Cl8S7zvwp4WM+QmrYizgOu7xrIMyz3O5Ami+0rRlD
	r5MLam0BKoOQ9zCDo/x71pOST/u9Qwdo8rZDJOE6uXVvNSs68U2ByKljDnL6F6jEaDQ3tBICvAq
	A4sEGxYBC6v+bGlpmKxTrqXVROjBgUpQ2yA8Fob24Qvk+MPeJ9U1jDPcg9iqH1n0a8cTjT0G8w+
	jhc6UZygih/KkPyBzWZpmK7nH1grx+lFkDhYtk4wgrjNPwrC0cRwNI5LLjod5CWMJZ9D4wXB9ZF
	WbZJUtW6cL6lLHao5ousBGA+zReCaaTSHyhfBYKYyiVspS7GyD/RqYBKV6f+Xno5p+j2KqbDC+/
	Q/hthZGQr5obg2uDnhwy3tRwiLW0rfiQ=
X-Google-Smtp-Source: AGHT+IF3HJ9NqzHMzyJZYtlBawCznKJ3NSlqmqxl8ss4jfLNnF2OITyYlaRDgdmSnz2QY8Aul6AHUCVP6eiM
X-Received: by 2002:a5d:64c9:0:b0:429:b697:1fa with SMTP id ffacd0b85a97d-429e32c53fcmr2205430f8f.2.1762374513766;
        Wed, 05 Nov 2025 12:28:33 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id ffacd0b85a97d-429eb3d499bsm24593f8f.19.2025.11.05.12.28.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 12:28:33 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id E416934057A;
	Wed,  5 Nov 2025 13:28:30 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 10591E413BB; Wed,  5 Nov 2025 13:28:31 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v2 2/2] ublk: use rq_for_each_bvec() for user copy
Date: Wed,  5 Nov 2025 13:28:23 -0700
Message-ID: <20251105202823.2198194-3-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20251105202823.2198194-1-csander@purestorage.com>
References: <20251105202823.2198194-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ublk_advance_io_iter() and ublk_copy_io_pages() currently open-code the
iteration over request's bvecs. Switch to the rq_for_each_bvec() macro
provided by blk-mq to avoid reaching into the bio internals and simplify
the code. Unlike bio_iter_iovec(), rq_for_each_bvec() can return
multi-page bvecs. So switch from copy_{to,from}_iter() to
copy_page_{to,from}_iter() to map and copy each page in the bvec.

Suggested-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/block/ublk_drv.c | 78 ++++++++++++----------------------------
 1 file changed, 23 insertions(+), 55 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 40eee3e15a4c..929d40fe0250 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -911,81 +911,49 @@ static const struct block_device_operations ub_fops = {
 	.open =		ublk_open,
 	.free_disk =	ublk_free_disk,
 	.report_zones =	ublk_report_zones,
 };
 
-struct ublk_io_iter {
-	struct bio *bio;
-	struct bvec_iter iter;
-};
-
-/* return how many bytes are copied */
-static size_t ublk_copy_io_pages(struct ublk_io_iter *data,
-		struct iov_iter *uiter, int dir)
+/*
+ * Copy data between request pages and io_iter, and 'offset'
+ * is the start point of linear offset of request.
+ */
+static size_t ublk_copy_user_pages(const struct request *req,
+		unsigned offset, struct iov_iter *uiter, int dir)
 {
+	struct req_iterator iter;
+	struct bio_vec bv;
 	size_t done = 0;
 
-	for (;;) {
-		struct bio_vec bv = bio_iter_iovec(data->bio, data->iter);
-		void *bv_buf = bvec_kmap_local(&bv);
+	rq_for_each_bvec(bv, req, iter) {
 		size_t copied;
 
+		if (offset >= bv.bv_len) {
+			offset -= bv.bv_len;
+			continue;
+		}
+
+		bv.bv_offset += offset;
+		bv.bv_len -= offset;
+		bv.bv_page += bv.bv_offset / PAGE_SIZE;
+		bv.bv_offset %= PAGE_SIZE;
 		if (dir == ITER_DEST)
-			copied = copy_to_iter(bv_buf, bv.bv_len, uiter);
+			copied = copy_page_to_iter(
+				bv.bv_page, bv.bv_offset, bv.bv_len, uiter);
 		else
-			copied = copy_from_iter(bv_buf, bv.bv_len, uiter);
-
-		kunmap_local(bv_buf);
+			copied = copy_page_from_iter(
+				bv.bv_page, bv.bv_offset, bv.bv_len, uiter);
 
 		done += copied;
 		if (copied < bv.bv_len)
 			break;
 
-		/* advance bio */
-		bio_advance_iter_single(data->bio, &data->iter, copied);
-		if (!data->iter.bi_size) {
-			data->bio = data->bio->bi_next;
-			if (data->bio == NULL)
-				break;
-			data->iter = data->bio->bi_iter;
-		}
+		offset = 0;
 	}
 	return done;
 }
 
-static bool ublk_advance_io_iter(const struct request *req,
-		struct ublk_io_iter *iter, unsigned int offset)
-{
-	struct bio *bio = req->bio;
-
-	for_each_bio(bio) {
-		if (bio->bi_iter.bi_size > offset) {
-			iter->bio = bio;
-			iter->iter = bio->bi_iter;
-			bio_advance_iter(iter->bio, &iter->iter, offset);
-			return true;
-		}
-		offset -= bio->bi_iter.bi_size;
-	}
-	return false;
-}
-
-/*
- * Copy data between request pages and io_iter, and 'offset'
- * is the start point of linear offset of request.
- */
-static size_t ublk_copy_user_pages(const struct request *req,
-		unsigned offset, struct iov_iter *uiter, int dir)
-{
-	struct ublk_io_iter iter;
-
-	if (!ublk_advance_io_iter(req, &iter, offset))
-		return 0;
-
-	return ublk_copy_io_pages(&iter, uiter, dir);
-}
-
 static inline bool ublk_need_map_req(const struct request *req)
 {
 	return ublk_rq_has_data(req) && req_op(req) == REQ_OP_WRITE;
 }
 
-- 
2.45.2


