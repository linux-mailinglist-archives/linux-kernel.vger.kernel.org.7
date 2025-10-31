Return-Path: <linux-kernel+bounces-879324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 431B1C22D6D
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 02:05:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 025A44E8F78
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 01:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0627221D59C;
	Fri, 31 Oct 2025 01:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="CS6017fJ"
Received: from mail-ej1-f104.google.com (mail-ej1-f104.google.com [209.85.218.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D4821B196
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 01:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761872729; cv=none; b=tSpoy6LPoCl4VWmAMFxD7yDC5K0LeYjbf4nQD4gqFFmDu+trIe+8xvWREbCGKG+R85yVb0CPIV6DMNqDSXnL+CT56bzgfuVViVSjLfC9lt9z4FL7G1p4/3RrpnJOH/66gVwO1iXQwH7lw04Mp7gi3z2cfNluEYD5r5aNB6f4Sto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761872729; c=relaxed/simple;
	bh=QgO1i7/LcbddJaAQvCDrIY0FhdeHRaZIDoyXNGxmPko=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OQ4Wo//kwSxSPI6SxhpuOUmhiexIkkyXytp1ifw29sJOl07GhMEzjOlZnU1VyLk41kwVyAUNbsbxgx4pvXjGnI3mKrX1Jx++fAM8NG4O9YetQHPtsAn+aXpQ8dYeYguzp4HyLDpXWDQvBSqF9v8TqKhNOGLj9q0+tWV9it3A3o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=CS6017fJ; arc=none smtp.client-ip=209.85.218.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-ej1-f104.google.com with SMTP id a640c23a62f3a-b704117df3eso30126666b.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 18:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1761872726; x=1762477526; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rfVQMMzkhlV0Y30v8r08oWrAUc2m58EUIU01ulibFEY=;
        b=CS6017fJxmdiXkl7OZBqYrqGJ1I9KjiUP3XnTrHqkw7Y6FzjIPhXwNmZfBEQTkAWjr
         9nQxCsgKlWkNRsoxNGblsDzibXonI2N2zk9gWZJZ7sHLNCDYlmegMJOVOgREpusKrOxW
         wZ+QZUB+V1EEs8CkGuva/PZ/vBG7+yI2EI2wnTrvKOXLvZ6vJ1cfo50YTrAivt14CuhM
         eROt2MZLKAQT9wv4fjxePHMz8EI1qXiaAKPxwMHE/qtnFXbJi1HiBSfGcZEJTQbrCxrp
         KylMChthwhJ0XAu2joJr8VXfxzNLfM8H4QW9GShlomoL/ZOVVQ07GjPPpmKz2d643mrI
         2LDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761872726; x=1762477526;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rfVQMMzkhlV0Y30v8r08oWrAUc2m58EUIU01ulibFEY=;
        b=TvL4b59eQyl4shPJxjeL84cStYpgYh9LerZ5m/x+eyFPa4JigefKzwodrU0T0JlsLS
         +ezXpNqUSTMfWynvK8OOlvHv9znb3KSj2xmJ/2UJmQkO4Nn9c59BZaFxCi9NjqFTFXg0
         cG6SSVbW9jbafIA3Sr1FusdmxX2QQHRQbSAyuZ4PQ1AIhDi8djaMZ6L6JUa9pef4uk9l
         zE707oxQLfRq73lP8GkYJ9y4UVCULOAJDz7MNp+zTQfLFwrEA7yUwZpU4G96DNIlm28+
         bNJrrau8EnR8CTZw2LRWMAls0CFeDcNzaKwr/0V+jV/FvkFq59SO69l1AbUuWMWMPVWI
         2Ztw==
X-Forwarded-Encrypted: i=1; AJvYcCWq1NDokmCApsvK5emu6mE3mbz4ck+PpfA5CTXpzi5lhLaLcL76LlFwZux+mbEGkCgYhEksgSsUPEIvAHc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcQewfdYLfijdOxPXBoxFEjSQIu28g0SZI4cvciU0IQl90Xgsa
	+tdkIUVi0L2yg6NxsP/4rV1VH/jhSu/E3S3LPfo2+HUT7hPXbofczTA3fc5H4Do1PdqaeCvwH2+
	8eInTuQ3par/Iqwz3b6FlJPHFqMAR5jr0jEyvUYYUbuUlv3MNmDLM
X-Gm-Gg: ASbGncum/jDtOc+j1OaOGk1XjOjNEpo82igap06ZRZR2Ugd8gCWIvPVLxZEQ3/Yy2IV
	brUqBocbPZrL408IBotidYzd8LuHmkLKNrlT+NvrCH4Cha6CNOxrA2H6GnlGD0QJMwSRKlo9c1A
	iTq/NcEp0sxr8yuS+ODs8uDPX7pGIulFy9Ixpbe8ZVq5P0/ZdJTX2HpHsEV9+kPXh6BN5g+6Z9h
	L6gMUqZUBysBZjhsRqdos9hRi2FBLCcUG3ab+SRVax1qYqkXeTkPB/wjEuXWUI/o3jg6ElHvMp3
	jS/wwkSE8mMGHftsCiBozJ9XSqM5E3YAKMooPXK7ut1kmh84qC6WJJtoTEexuXZucaHzRFVnU3/
	rmX/4q3ZZYKdKwXq4
X-Google-Smtp-Source: AGHT+IFOK69ROlMKXBBWP8G4jGiql0UOfHUJc2N6zLUoUX6qzQjFY+p6mG1kcfzN4L3bW8Mg1AiFvbwj6Gsf
X-Received: by 2002:a17:907:3f13:b0:b65:c8b8:144f with SMTP id a640c23a62f3a-b70705fb91fmr71990966b.6.1761872725535;
        Thu, 30 Oct 2025 18:05:25 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id a640c23a62f3a-b70779a15a0sm4231666b.2.2025.10.30.18.05.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 18:05:25 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 26A5C3400E5;
	Thu, 30 Oct 2025 19:05:24 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 1B0CCE41BC3; Thu, 30 Oct 2025 19:05:24 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ublk: use copy_{to,from}_iter() for user copy
Date: Thu, 30 Oct 2025 19:05:21 -0600
Message-ID: <20251031010522.3509499-1-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ublk_copy_user_pages()/ublk_copy_io_pages() currently uses
iov_iter_get_pages2() to extract the pages from the iov_iter and
memcpy()s between the bvec_iter and the iov_iter's pages one at a time.
Switch to using copy_to_iter()/copy_from_iter() instead. This avoids the
user page reference count increments and decrements and needing to split
the memcpy() at user page boundaries. It also simplifies the code
considerably.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/block/ublk_drv.c | 62 +++++++++-------------------------------
 1 file changed, 14 insertions(+), 48 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 0c74a41a6753..852350e639d6 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -912,58 +912,47 @@ static const struct block_device_operations ub_fops = {
 	.open =		ublk_open,
 	.free_disk =	ublk_free_disk,
 	.report_zones =	ublk_report_zones,
 };
 
-#define UBLK_MAX_PIN_PAGES	32
-
 struct ublk_io_iter {
-	struct page *pages[UBLK_MAX_PIN_PAGES];
 	struct bio *bio;
 	struct bvec_iter iter;
 };
 
-/* return how many pages are copied */
-static void ublk_copy_io_pages(struct ublk_io_iter *data,
-		size_t total, size_t pg_off, int dir)
+/* return how many bytes are copied */
+static size_t ublk_copy_io_pages(struct ublk_io_iter *data,
+		struct iov_iter *uiter, int dir)
 {
-	unsigned done = 0;
-	unsigned pg_idx = 0;
+	size_t done = 0;
 
-	while (done < total) {
+	for (;;) {
 		struct bio_vec bv = bio_iter_iovec(data->bio, data->iter);
-		unsigned int bytes = min3(bv.bv_len, (unsigned)total - done,
-				(unsigned)(PAGE_SIZE - pg_off));
 		void *bv_buf = bvec_kmap_local(&bv);
-		void *pg_buf = kmap_local_page(data->pages[pg_idx]);
+		size_t copied;
 
 		if (dir == ITER_DEST)
-			memcpy(pg_buf + pg_off, bv_buf, bytes);
+			copied = copy_to_iter(bv_buf, bv.bv_len, uiter);
 		else
-			memcpy(bv_buf, pg_buf + pg_off, bytes);
+			copied = copy_from_iter(bv_buf, bv.bv_len, uiter);
 
-		kunmap_local(pg_buf);
 		kunmap_local(bv_buf);
 
-		/* advance page array */
-		pg_off += bytes;
-		if (pg_off == PAGE_SIZE) {
-			pg_idx += 1;
-			pg_off = 0;
-		}
-
-		done += bytes;
+		done += copied;
+		if (copied < bv.bv_len)
+			break;
 
 		/* advance bio */
-		bio_advance_iter_single(data->bio, &data->iter, bytes);
+		bio_advance_iter_single(data->bio, &data->iter, copied);
 		if (!data->iter.bi_size) {
 			data->bio = data->bio->bi_next;
 			if (data->bio == NULL)
 				break;
 			data->iter = data->bio->bi_iter;
 		}
 	}
+	return done;
 }
 
 static bool ublk_advance_io_iter(const struct request *req,
 		struct ublk_io_iter *iter, unsigned int offset)
 {
@@ -987,38 +976,15 @@ static bool ublk_advance_io_iter(const struct request *req,
  */
 static size_t ublk_copy_user_pages(const struct request *req,
 		unsigned offset, struct iov_iter *uiter, int dir)
 {
 	struct ublk_io_iter iter;
-	size_t done = 0;
 
 	if (!ublk_advance_io_iter(req, &iter, offset))
 		return 0;
 
-	while (iov_iter_count(uiter) && iter.bio) {
-		unsigned nr_pages;
-		ssize_t len;
-		size_t off;
-		int i;
-
-		len = iov_iter_get_pages2(uiter, iter.pages,
-				iov_iter_count(uiter),
-				UBLK_MAX_PIN_PAGES, &off);
-		if (len <= 0)
-			return done;
-
-		ublk_copy_io_pages(&iter, len, off, dir);
-		nr_pages = DIV_ROUND_UP(len + off, PAGE_SIZE);
-		for (i = 0; i < nr_pages; i++) {
-			if (dir == ITER_DEST)
-				set_page_dirty(iter.pages[i]);
-			put_page(iter.pages[i]);
-		}
-		done += len;
-	}
-
-	return done;
+	return ublk_copy_io_pages(&iter, uiter, dir);
 }
 
 static inline bool ublk_need_map_req(const struct request *req)
 {
 	return ublk_rq_has_data(req) && req_op(req) == REQ_OP_WRITE;
-- 
2.45.2


