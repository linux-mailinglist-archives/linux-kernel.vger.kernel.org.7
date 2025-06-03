Return-Path: <linux-kernel+bounces-672270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F95BACCD15
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jun 2025 20:32:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A060B1887F8C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jun 2025 18:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBFFB24DCEE;
	Tue,  3 Jun 2025 18:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="ACGM6Mix"
Received: from mail-il1-f225.google.com (mail-il1-f225.google.com [209.85.166.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F2D2BA34
	for <linux-kernel@vger.kernel.org>; Tue,  3 Jun 2025 18:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748975529; cv=none; b=qkhBMHsY9+ePGZhw+hQZ+EryA+cZQihSOLyJnAGtP4jInC9KXXnbSv4Xveog+6juKE3OMpWoRow1tpxbDigHus5UQ/ybHJoaKoaRMFH5hG4M5zVfIh0Z/Y/VG+1YQ1/ol5EBRxlek4y6ydzRAQ0aqgkPLl3jbT3Qp3peeIEJ4RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748975529; c=relaxed/simple;
	bh=VpCnu/vgkMXoRizxEVcXipW9pE06TvbWDwZZnY+eyHI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qPp823UMA4TUFSOwbMTTjvUBFiBVjGC1Kx7XNmEg4y02zfC00a1+PEnasb80z6kCdzy9NQcy1OAdqLrDgnfMVFSFlVtVnFJAWRFMg1FM8Ds3Rv3M/TO+PLKV8hCTJ2nxmGXequWTyMWpogDky7aXMFFqtRlZt21KAjNYMcZvXxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=ACGM6Mix; arc=none smtp.client-ip=209.85.166.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-il1-f225.google.com with SMTP id e9e14a558f8ab-3dd7bef8b22so1114935ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jun 2025 11:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1748975526; x=1749580326; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nSEqmtH8cAoHSrP17Ob/VSrxyz6o4t+D0NIScOXkFbc=;
        b=ACGM6Mix3TNlXAZ2RDuAUoIiyLd9uTl702TEQiRE1rNSpOyN5U7POcn3qoNV/jbP2y
         A22nO7s9Hi2lh9TRkk28suEIHsw0XvCUjaH5J7xtlxCjerwXWsg4yjOZ/lKU8tKuNSTD
         mUsgCwFlclWzJnZadWAj8IvAUkttWtk0Sybq4MMqzYiiT7L7HEvEv+MBDPKEgMVdU9K+
         5YnxsTSis5rOSFMdQQBuVOEpHj2ec5pb0r46R1xXhEhp50S9v4LbqUeWDJYKjeWWtlYO
         ngY+AR3haKKEJ9BErtgzo2lmeUFsUgBpKDZv1aDuH1dRrNx1jEmIPpqOKXVsGHawpc1r
         rZwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748975526; x=1749580326;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nSEqmtH8cAoHSrP17Ob/VSrxyz6o4t+D0NIScOXkFbc=;
        b=t1VbnHhXMyqCOQhYaqrx4hKdO/COIqbPtB5rmlImkAPgz7/HI65a/0nW6RfdW4Z5Cu
         Ab2CX1QOewUeGlsZ8/7nwBc47HX0GnNupfhGfzDLQip/3IaFd/Ht8O08Tp5AUEe2Kbsv
         GeEozrNUtKMoUk7U52s6E1QaNb9O8i9kAdG1bJ5vop8epRW2UZDQrTduvp7xTtKgyRjS
         IIdfP+oLK012ylKwC89v3kK7PlDqySWx5rjSVms+mX5Y5r68aXKPJtE8urMq+dWse2t3
         LJmOOPeLuOTwhFsrlGBu+NNIMQ6ZviWpZJyBcXRRKhVEum3eoN92qaq/6gojONmO+6sf
         k0PA==
X-Forwarded-Encrypted: i=1; AJvYcCWMsXpnfjvjU4DsS3kvP8ztJyR3P1Tp4puWm23tVnLUGl1nZajBocFRCTawS0/erpIlXXC0fC08htvn1rk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yycy0gG9Bs7mhk3XtjMiwWxGk8X4J6Kwu9T8VSXGxg31sWeHhwc
	VFwm/E8vDuswNFOdpAHgETBydrHJYgf+6Q/i2/OLSBzcEvZgkoDNFmJM5SOmXmq/yO6AekfwZ5W
	aaNnfz1BlSy0x/02Uz/GiqalRB7U9t9JnpR31L00DTHAxtNe4Huwh
X-Gm-Gg: ASbGncsEL9hR0zwelE3ZElA0qDG96vTpfnv2V73R0z9ZwbRVGoqyAw6LUHyYw2FmGK9
	dhH+VQxWSNN5UuETqKOJbZqzJsZbrJtp+HPh3pulWgtVEsTZsgeeErWFFrdk54MfnRHWUffhQWl
	l2d4XrW/Zg6oe4M/4uwD8LbowTsEbCPYss1/6S2YPsOrRmBeEq/M5VZiks1nOiorxFefcSagynn
	sEwB+9YMCXM9adoGPbv7zot3jviKBenz3ynC5kJ2tZ6uJmTifIxqDLokYu3X06t2dD3i7dKYEsS
	O4+Zr6dNWWVKzV/F+lptQXUx/A+TSw==
X-Google-Smtp-Source: AGHT+IH1ugbkQ4Bd1c/ELDzPsfBlGebzYbxe7TsT0zkXX3K5ma/cS/EK4OHQptbYEMSeaz4a1vTV0VHHzVR7
X-Received: by 2002:a05:6e02:1d9a:b0:3dc:811c:db77 with SMTP id e9e14a558f8ab-3dd9bb51700mr53645675ab.5.1748975525910;
        Tue, 03 Jun 2025 11:32:05 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 8926c6da1cb9f-4fdd7dffa46sm280255173.4.2025.06.03.11.32.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 11:32:05 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 5E45F34027F;
	Tue,  3 Jun 2025 12:32:05 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 5212DE41E07; Tue,  3 Jun 2025 12:31:35 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] block: drop direction param from bio_integrity_copy_user()
Date: Tue,  3 Jun 2025 12:31:32 -0600
Message-ID: <20250603183133.1178062-1-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

direction is determined from bio, which is already passed in. Compute
op_is_write(bio_op(bio)) directly instead of converting it to an iter
direction and back to a bool.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 block/bio-integrity.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index cb94e9be26dc..10912988c8f5 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -152,25 +152,24 @@ int bio_integrity_add_page(struct bio *bio, struct page *page,
 	return len;
 }
 EXPORT_SYMBOL(bio_integrity_add_page);
 
 static int bio_integrity_copy_user(struct bio *bio, struct bio_vec *bvec,
-				   int nr_vecs, unsigned int len,
-				   unsigned int direction)
+				   int nr_vecs, unsigned int len)
 {
-	bool write = direction == ITER_SOURCE;
+	bool write = op_is_write(bio_op(bio));
 	struct bio_integrity_payload *bip;
 	struct iov_iter iter;
 	void *buf;
 	int ret;
 
 	buf = kmalloc(len, GFP_KERNEL);
 	if (!buf)
 		return -ENOMEM;
 
 	if (write) {
-		iov_iter_bvec(&iter, direction, bvec, nr_vecs, len);
+		iov_iter_bvec(&iter, ITER_SOURCE, bvec, nr_vecs, len);
 		if (!copy_from_iter_full(buf, len, &iter)) {
 			ret = -EFAULT;
 			goto free_buf;
 		}
 
@@ -262,24 +261,19 @@ int bio_integrity_map_user(struct bio *bio, struct iov_iter *iter)
 	struct request_queue *q = bdev_get_queue(bio->bi_bdev);
 	unsigned int align = blk_lim_dma_alignment_and_pad(&q->limits);
 	struct page *stack_pages[UIO_FASTIOV], **pages = stack_pages;
 	struct bio_vec stack_vec[UIO_FASTIOV], *bvec = stack_vec;
 	size_t offset, bytes = iter->count;
-	unsigned int direction, nr_bvecs;
+	unsigned int nr_bvecs;
 	int ret, nr_vecs;
 	bool copy;
 
 	if (bio_integrity(bio))
 		return -EINVAL;
 	if (bytes >> SECTOR_SHIFT > queue_max_hw_sectors(q))
 		return -E2BIG;
 
-	if (bio_data_dir(bio) == READ)
-		direction = ITER_DEST;
-	else
-		direction = ITER_SOURCE;
-
 	nr_vecs = iov_iter_npages(iter, BIO_MAX_VECS + 1);
 	if (nr_vecs > BIO_MAX_VECS)
 		return -E2BIG;
 	if (nr_vecs > UIO_FASTIOV) {
 		bvec = kcalloc(nr_vecs, sizeof(*bvec), GFP_KERNEL);
@@ -298,12 +292,11 @@ int bio_integrity_map_user(struct bio *bio, struct iov_iter *iter)
 		kvfree(pages);
 	if (nr_bvecs > queue_max_integrity_segments(q))
 		copy = true;
 
 	if (copy)
-		ret = bio_integrity_copy_user(bio, bvec, nr_bvecs, bytes,
-					      direction);
+		ret = bio_integrity_copy_user(bio, bvec, nr_bvecs, bytes);
 	else
 		ret = bio_integrity_init_user(bio, bvec, nr_bvecs, bytes);
 	if (ret)
 		goto release_pages;
 	if (bvec != stack_vec)
-- 
2.45.2


