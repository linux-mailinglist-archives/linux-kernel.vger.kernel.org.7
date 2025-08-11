Return-Path: <linux-kernel+bounces-761811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48192B1FEBB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 07:40:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F84516DC48
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 05:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6016E15990C;
	Mon, 11 Aug 2025 05:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="KJM/Mtu2"
Received: from mail-pl1-f225.google.com (mail-pl1-f225.google.com [209.85.214.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04AFF26B098
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 05:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754890832; cv=none; b=fC88i27P259zbh+tCIxM3/dMi9qHA1r187EUkujQMupzVpMafPDp5kAvDUnvoqfW72WUfjeAImDJ9Y550AtbTp+suUVQhzP5pyu2qxCEiehepJu24p51S55/6/MsIhbEPY6Q8p7PY7f06DaYNIeys97AFvBQ1hR03fwt02Qo5fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754890832; c=relaxed/simple;
	bh=FB4GGfNmTB0JnryaMLhuZUnFM8olCLkKN5kF/YvLFVI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZmjW8k6eHhkW80KOIARVK/kvEizm5UaOrx6oF5Dw80e2MrpoEyNHmpi+Nj0r6ZW6KmXt3SX97UujAz+08lM/tLm2uj+uIBelbQRTJbZt7Ll88f9JrZ/QkbFxJHGD1uwJ82McdO7JHp1Lw0i2O+/UPR3K7DlXJQmxB695wkO7p34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=KJM/Mtu2; arc=none smtp.client-ip=209.85.214.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f225.google.com with SMTP id d9443c01a7336-2403c13cac3so34596685ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 22:40:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754890830; x=1755495630;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2AneEMvlSNWgSK1THzb8ZW0NUGNSj/nc53x2wpbcODQ=;
        b=HlUa1R7D1klpmpnEIdQ570LEomI2MjYgJAlplP/c9mstDx6zyHRgjizXfrG0hHqJ/X
         hI88/mYk3NkHV8B8B5Cp9tubyXFnRPI3IrV+TGxIok3BNCmq5a9iPTw7mkjvbOvSC3Ke
         ACH007XacMKv5XdAEVRHJPbJOKqzrhnk5SdvZowu5GZYl6GhF04m1c8HoJEe+YmVnsk/
         QAJhiTVavr5p//VeQ0NmJ9IdYPphRhKLEMIL0fZN0goLKkXqHZhV+DAvTD+ZmHa8U2oE
         gF/qLtzjVnLY3taMB7yWXJUiaA69yGMaUuFMeWLvUdIIa48voIB13vZqBZrJaLlkbC8y
         Yokw==
X-Forwarded-Encrypted: i=1; AJvYcCWVEBMcMPqM0sP3B1kEmzYEIXqfk76kZruNFHPrpmG1/jvYx+pwtFbJOdcmI5g7f3tv/H3NzxwTuh+iJTw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzpos9QjlnmXVQUx7+E5wReSSa+MJ10qT5vl2e5Fb7vj0yRgQoT
	i8esGWdjLIraZbYFCSPURGtslPB6OxAyUs+JE77w6N3hFWe2SsbJ5D1Bju2So+iQ2jnugT5dNpY
	DFT7PgWiGbTUkovRBGM5rEpCZJOMipMKOt5v8Y7ygn0Cc7OoSIe+K6OIncfKz5Y/M0s0LhcdasS
	My1jNY9PK/Aq0b1gmHWaNHqHu7mxW3iPOuFYUGwCc5AdlmaM1IIRn+YS/7xD2TMnpIb2KZYPWm9
	OkEYTPyR+DBnr4LFfmhMszR8Q==
X-Gm-Gg: ASbGncviewEbmaUjBamx9aPDXf4XRn8gnzOGiCzwynqQM1pb3pVWnlrikrhpoOT+F9u
	FeSiQA9qU4obfFTSIaFKK23NcK18LyAEmkCuCKFBb4JuEDSLw2iLW/HKluLXIy6gZOr5tX4Itv0
	ndIcnIs6ssyOJap7cXczvgFcc38DmBuMcBa/yhQKbRzcKDWihOYAba3Gfs/h03Dqf4cpr+CvOKI
	rlNwMPrTdN5osSjfFgGvroXNo6rk3mC6dEuJCdE1pafzz6gaeo7AWmMAAArogbVLFMeNcV4wx4I
	iiYWjl8jHSBdEcJDdt/dXXdjM91cZCr/YM/BNIFdlH0PTUhrGRQiR3xV/kqmHzvB14pQ9LIc77z
	4St0Zvhgn4/u0kFRWgUiwzFvFAnQQxWiiyPHjkXp8+NkEgIV3irKC5fCZIMzR3yiyUXDDihLNwZ
	DMj3zVUg==
X-Google-Smtp-Source: AGHT+IFSdJl0Z4LH/OkTd9esXqzeLVs7BVwx8D6G7BZ9D/jom3GASuQ3m8xhCi66YI37YdUCNus1fKhZBhu5
X-Received: by 2002:a17:902:c407:b0:235:efbb:9537 with SMTP id d9443c01a7336-242b05cca34mr216445645ad.3.1754890830177;
        Sun, 10 Aug 2025 22:40:30 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-122.dlp.protect.broadcom.com. [144.49.247.122])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-241afb7035csm16542435ad.0.2025.08.10.22.40.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Aug 2025 22:40:30 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-70747c020daso82174596d6.0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 22:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1754890829; x=1755495629; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2AneEMvlSNWgSK1THzb8ZW0NUGNSj/nc53x2wpbcODQ=;
        b=KJM/Mtu2K2wv8Czxt6Rga/qj8jWDFpMUaDFEDl5lp444rYCQQ3n4vV3NMtsbEDRvLx
         70O9jKMgjO3i9IzasmCAQTSfRvOaaK+YDnlwIbki/IQjDb7mPxgFSOHlYVFv7uIMXT1K
         RDfBlE044D0GoQoUSDy9ltAEece9S3v9dORuA=
X-Forwarded-Encrypted: i=1; AJvYcCUKMZijBC8AW9CnEcKJ+4NwTwKAQMtiZgWPXtFfG5z8oPgdGbMWXB9gKJMNgDRPmrXC6OOg40kHyM0zMNM=@vger.kernel.org
X-Received: by 2002:ad4:5d63:0:b0:6fa:abd2:f2bb with SMTP id 6a1803df08f44-7099b97d506mr154029646d6.8.1754890828582;
        Sun, 10 Aug 2025 22:40:28 -0700 (PDT)
X-Received: by 2002:ad4:5d63:0:b0:6fa:abd2:f2bb with SMTP id 6a1803df08f44-7099b97d506mr154029446d6.8.1754890828047;
        Sun, 10 Aug 2025 22:40:28 -0700 (PDT)
Received: from shivania.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7077ce44849sm150544766d6.84.2025.08.10.22.40.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Aug 2025 22:40:27 -0700 (PDT)
From: Shivani Agarwal <shivani.agarwal@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: bcm-kernel-feedback-list@broadcom.com,
	linux-kernel@vger.kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	tapas.kundu@broadcom.com,
	agk@redhat.com,
	snitzer@kernel.org,
	mpatocka@redhat.com,
	dm-devel@lists.linux.dev,
	Damien Le Moal <damien.lemoal@wdc.com>,
	Hannes Reinecke <hare@suse.de>,
	Himanshu Madhani <himanshu.madhani@oracle.com>,
	Mike Snitzer <snitzer@redhat.com>,
	Shivani Agarwal <shivani.agarwal@broadcom.com>
Subject: [PATCH 1/2 v5.10] dm: rearrange core declarations for extended use from  dm-zone.c
Date: Sun, 10 Aug 2025 22:27:01 -0700
Message-Id: <20250811052702.145189-2-shivani.agarwal@broadcom.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250811052702.145189-1-shivani.agarwal@broadcom.com>
References: <20250811052702.145189-1-shivani.agarwal@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

From: Damien Le Moal <damien.lemoal@wdc.com>

commit e2118b3c3d94289852417f70ec128c25f4833aad upstream.

Move the definitions of struct dm_target_io, struct dm_io and the bits
of the flags field of struct mapped_device from dm.c to dm-core.h to
make them usable from dm-zone.c. For the same reason, declare
dec_pending() in dm-core.h after renaming it to dm_io_dec_pending().
And for symmetry of the function names, introduce the inline helper
dm_io_inc_pending() instead of directly using atomic_inc() calls.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
[Shivani: Modified to apply on 5.10.y]
Signed-off-by: Shivani Agarwal <shivani.agarwal@broadcom.com>
---
 drivers/md/dm-core.h | 52 ++++++++++++++++++++++++++++++++++++++
 drivers/md/dm.c      | 59 ++++++--------------------------------------
 2 files changed, 59 insertions(+), 52 deletions(-)

diff --git a/drivers/md/dm-core.h b/drivers/md/dm-core.h
index ff73b2c17be5..99b2d2e2cf59 100644
--- a/drivers/md/dm-core.h
+++ b/drivers/md/dm-core.h
@@ -124,6 +124,19 @@ struct mapped_device {
 	struct srcu_struct io_barrier;
 };
 
+/*
+ * Bits for the flags field of struct mapped_device.
+ */
+#define DMF_BLOCK_IO_FOR_SUSPEND 0
+#define DMF_SUSPENDED 1
+#define DMF_FROZEN 2
+#define DMF_FREEING 3
+#define DMF_DELETING 4
+#define DMF_NOFLUSH_SUSPENDING 5
+#define DMF_DEFERRED_REMOVE 6
+#define DMF_SUSPENDED_INTERNALLY 7
+#define DMF_POST_SUSPENDING 8
+
 void disable_discard(struct mapped_device *md);
 void disable_write_same(struct mapped_device *md);
 void disable_write_zeroes(struct mapped_device *md);
@@ -177,6 +190,45 @@ struct dm_table {
 	struct dm_md_mempools *mempools;
 };
 
+/*
+ * One of these is allocated per clone bio.
+ */
+#define DM_TIO_MAGIC 7282014
+struct dm_target_io {
+	unsigned int magic;
+	struct dm_io *io;
+	struct dm_target *ti;
+	unsigned int target_bio_nr;
+	unsigned int *len_ptr;
+	bool inside_dm_io;
+	struct bio clone;
+};
+
+/*
+ * One of these is allocated per original bio.
+ * It contains the first clone used for that original.
+ */
+#define DM_IO_MAGIC 5191977
+struct dm_io {
+	unsigned int magic;
+	struct mapped_device *md;
+	blk_status_t status;
+	atomic_t io_count;
+	struct bio *orig_bio;
+	unsigned long start_time;
+	spinlock_t endio_lock;
+	struct dm_stats_aux stats_aux;
+	/* last member of dm_target_io is 'struct bio' */
+	struct dm_target_io tio;
+};
+
+static inline void dm_io_inc_pending(struct dm_io *io)
+{
+	atomic_inc(&io->io_count);
+}
+
+void dm_io_dec_pending(struct dm_io *io, blk_status_t error);
+
 static inline struct completion *dm_get_completion_from_kobject(struct kobject *kobj)
 {
 	return &container_of(kobj, struct dm_kobject_holder, kobj)->completion;
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 4fdf0e666777..0868358a7a8d 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -73,38 +73,6 @@ struct clone_info {
 	unsigned sector_count;
 };
 
-/*
- * One of these is allocated per clone bio.
- */
-#define DM_TIO_MAGIC 7282014
-struct dm_target_io {
-	unsigned magic;
-	struct dm_io *io;
-	struct dm_target *ti;
-	unsigned target_bio_nr;
-	unsigned *len_ptr;
-	bool inside_dm_io;
-	struct bio clone;
-};
-
-/*
- * One of these is allocated per original bio.
- * It contains the first clone used for that original.
- */
-#define DM_IO_MAGIC 5191977
-struct dm_io {
-	unsigned magic;
-	struct mapped_device *md;
-	blk_status_t status;
-	atomic_t io_count;
-	struct bio *orig_bio;
-	unsigned long start_time;
-	spinlock_t endio_lock;
-	struct dm_stats_aux stats_aux;
-	/* last member of dm_target_io is 'struct bio' */
-	struct dm_target_io tio;
-};
-
 void *dm_per_bio_data(struct bio *bio, size_t data_size)
 {
 	struct dm_target_io *tio = container_of(bio, struct dm_target_io, clone);
@@ -132,19 +100,6 @@ EXPORT_SYMBOL_GPL(dm_bio_get_target_bio_nr);
 
 #define MINOR_ALLOCED ((void *)-1)
 
-/*
- * Bits for the md->flags field.
- */
-#define DMF_BLOCK_IO_FOR_SUSPEND 0
-#define DMF_SUSPENDED 1
-#define DMF_FROZEN 2
-#define DMF_FREEING 3
-#define DMF_DELETING 4
-#define DMF_NOFLUSH_SUSPENDING 5
-#define DMF_DEFERRED_REMOVE 6
-#define DMF_SUSPENDED_INTERNALLY 7
-#define DMF_POST_SUSPENDING 8
-
 #define DM_NUMA_NODE NUMA_NO_NODE
 static int dm_numa_node = DM_NUMA_NODE;
 
@@ -897,7 +852,7 @@ static int __noflush_suspending(struct mapped_device *md)
  * Decrements the number of outstanding ios that a bio has been
  * cloned into, completing the original io if necc.
  */
-static void dec_pending(struct dm_io *io, blk_status_t error)
+void dm_io_dec_pending(struct dm_io *io, blk_status_t error)
 {
 	unsigned long flags;
 	blk_status_t io_error;
@@ -1041,7 +996,7 @@ static void clone_endio(struct bio *bio)
 	}
 
 	free_tio(tio);
-	dec_pending(io, error);
+	dm_io_dec_pending(io, error);
 }
 
 /*
@@ -1309,7 +1264,7 @@ static blk_qc_t __map_bio(struct dm_target_io *tio)
 	 * anything, the target has assumed ownership of
 	 * this io.
 	 */
-	atomic_inc(&io->io_count);
+	dm_io_inc_pending(io);
 	sector = clone->bi_iter.bi_sector;
 
 	if (unlikely(swap_bios_limit(ti, clone))) {
@@ -1336,7 +1291,7 @@ static blk_qc_t __map_bio(struct dm_target_io *tio)
 			up(&md->swap_bios_semaphore);
 		}
 		free_tio(tio);
-		dec_pending(io, BLK_STS_IOERR);
+		dm_io_dec_pending(io, BLK_STS_IOERR);
 		break;
 	case DM_MAPIO_REQUEUE:
 		if (unlikely(swap_bios_limit(ti, clone))) {
@@ -1344,7 +1299,7 @@ static blk_qc_t __map_bio(struct dm_target_io *tio)
 			up(&md->swap_bios_semaphore);
 		}
 		free_tio(tio);
-		dec_pending(io, BLK_STS_DM_REQUEUE);
+		dm_io_dec_pending(io, BLK_STS_DM_REQUEUE);
 		break;
 	default:
 		DMWARN("unimplemented target map return value: %d", r);
@@ -1640,7 +1595,7 @@ static blk_qc_t __split_and_process_bio(struct mapped_device *md,
 
 	if (bio->bi_opf & REQ_PREFLUSH) {
 		error = __send_empty_flush(&ci);
-		/* dec_pending submits any data associated with flush */
+		/* dm_io_dec_pending submits any data associated with flush */
 	} else if (op_is_zone_mgmt(bio_op(bio))) {
 		ci.bio = bio;
 		ci.sector_count = 0;
@@ -1684,7 +1639,7 @@ static blk_qc_t __split_and_process_bio(struct mapped_device *md,
 	}
 
 	/* drop the extra reference count */
-	dec_pending(ci.io, errno_to_blk_status(error));
+	dm_io_dec_pending(ci.io, errno_to_blk_status(error));
 	return ret;
 }
 
-- 
2.40.4


