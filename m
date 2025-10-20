Return-Path: <linux-kernel+bounces-860900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF0B4BF140D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 14:37:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E6B1189A507
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 12:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E5542638BC;
	Mon, 20 Oct 2025 12:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BJYAJO77"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BABC2E9EA4
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 12:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760963637; cv=none; b=femsTvTGQeOxxqVmXcYLadKyCiOuwMWJuFnGGt1AouT0WoPF10OzSz1dNgdR6gdrbwelx2DkSvog2SsEwdICpHmq8q3mop6hVCRee2TL0T1s8pzl3kpCyyw7BKgqiYYVT4jwb23BO7fssYG9fryh7zAX219ULgS15iD6JGRo7Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760963637; c=relaxed/simple;
	bh=rU8uVYLcF2AhmiLNNzi2LEgzFWs3egZ8KWbc8nmZbuM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AgiVfqg3WfvrU3hKlUm/4kFEDDyopFKRSyZXZZ7jx88l5OI9DdXVmqAbepYjxainwGfFvT7uUIROclq1FArgLLkJ+nbYt6OrA8wi/An9AZvH9hl1EspkSTuwKY38ra/+T3BD5M1WHSQK75pKJcuDvfNWKtF6rKsQ1BmTFKjcdrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BJYAJO77; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-36295d53a10so36362231fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 05:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760963633; x=1761568433; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5NVhDovZUT94TwG8yM18Fjy7iq+ALMqR310W9PkiJtA=;
        b=BJYAJO77/AfVBXQY+hsDXsbI1q82ukGIUT5YViXd/z3i5B811Iv02DvSSvCTTkMU4H
         LPT/RpnaKyCzXszYy4VoWj6DDT1dRzjDLQEDTRhPNI7Qd9uxK78U2+TVqbp7gp9hG2jQ
         EYxKY1gWPdsWSTSVWaaezBAHlAuANbzeNDMA4QXp6ri3e1+iHFmYnyhXhMLjc9sx0I/M
         MKm4NljKAWme5eWNjPle6CLQHYnSL3rpYm83bVXvcvr+5xM22ewJnaSOjOIm3G63X0mC
         dxqWQJo+LFCSiFCmqCt6IGLYF1ueYWsPr28kcqhIDNhOVZB0yluQGKQy1OKyco3czs9G
         p6EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760963633; x=1761568433;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5NVhDovZUT94TwG8yM18Fjy7iq+ALMqR310W9PkiJtA=;
        b=ccEffFjlMh0RT54eNOBBHhwFvMd2lwCHuKIjXRTZAEg40tArioBsvHULFWm2x4OT3l
         B37aN9Y57CLwSmsyPmmN8t2oyNyo/p4x63W9oP1Bxx+IBIREJ9UfUcFpjWOqCk/DzXu+
         6YLubwzolpJzi4PFqhfx4rzotyniHJi/UoGZfF7wqOj3Ud173Qcn8hYpSXIgAAbRYibw
         hwP0GfuUGNFY9NDoLv/E+Ta5sWEWHtzLeMK/Oo5mc6jiuOSGBT8zaqj4glV8XsitqxT1
         WR1UMgeZvPzFa5Ukr4zBSjtKvN+YD+2GCqnf5aLEoPnZLT3nOaSLvgdw3BwoCpR6hIUY
         Dpaw==
X-Forwarded-Encrypted: i=1; AJvYcCUGp6LPi6b6o+pCTGIemx7r8a3SPv/HHh2M8wsokOXvUBcWk3PPoN5RrVVzPeHerhGN+BMDTIzhRyl5vaA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsHZRYQh9LndekLKUUwhsSzswsqtoI8fA0Dy5A7qm2Us9eUSDv
	EDvGFZw0NDvm3Cj/s/+uN6pL5qWlsK6Efi+7ciGRkifevFuKsXFc/APG
X-Gm-Gg: ASbGncvXYiOXstHBpAoJ1G9XfDH3BHAPSPkLQWTWJF4k+hr/rq3772306owO4of6E1M
	Nyv2kEjjRvbclAPAbqEFj/etRVC21Y0LSPblf6qcVMlKgrWUkhuGBJjJVBy57ccoexoS4V0udPV
	t235npcD7Ks5aus4vrUp+DYHRf83hvvanfAWOHg3bJaV192ezmvRHqkGYVleJKlG5HVGnvi/l4P
	ExhbiKOY68LvMTUPQMrV43v86odeVbFX4jHDXK9rLuPBGqcFXI6cBjJ7bae0+qaxLFj+RRaqfS5
	8MnWPt7LXQuPHAXWIbzlxfBWqEZd2XQESLYir0rexGpVa6AtC7PL1T2TNC5mHSWr0H/OcoTXMt6
	u2RoOzcc1yyD3LAsUqJx0rD9i5+NEZie+eZa/YibIwruyA4brV6E+LN3tWXA1KHkqxASxQQz8Hf
	n8fJDV
X-Google-Smtp-Source: AGHT+IEHmugvulxBOoF5zYCC89SrkirMs/0QQ7fiUfyd2YWN72j+Jt3IPDQcNBZxXduznnLGhxQC3Q==
X-Received: by 2002:a2e:9fc9:0:b0:336:72be:3339 with SMTP id 38308e7fff4ca-377979feb62mr45322971fa.28.1760963633075;
        Mon, 20 Oct 2025 05:33:53 -0700 (PDT)
Received: from localhost.localdomain ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-377a90e2555sm20278271fa.0.2025.10.20.05.33.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 05:33:52 -0700 (PDT)
From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To: Mikulas Patocka <mpatocka@redhat.com>,
	Alasdair Kergon <agk@redhat.com>,
	DMML <dm-devel@lists.linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Mike Snitzer <snitzer@redhat.com>,
	Christoph Hellwig <hch@lst.de>,
	LKML <linux-kernel@vger.kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>
Subject: [PATCH v2] dm-ebs: Mark full buffer dirty even on partial write
Date: Mon, 20 Oct 2025 14:33:50 +0200
Message-ID: <20251020123350.2671495-1-urezki@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When performing a read-modify-write(RMW) operation, any modification
to a buffered block must cause the entire buffer to be marked dirty.

Marking only a subrange as dirty is incorrect because the underlying
device block size(ubs) defines the minimum read/write granularity. A
lower device can perform I/O only on regions which are fully aligned
and sized to ubs.

This change ensures that write-back operations always occur in full
ubs-sized chunks, matching the intended emulation semantics of the
EBS target.

As for user space visible impact, submitting sub-ubs and misaligned
I/O for devices which are tuned to ubs sizes only, will reject such
requests, therefore it can lead to losing data. Example:

1) Create a 8K nvme device in qemu by adding

-device nvme,drive=drv0,serial=foo,logical_block_size=8192,physical_block_size=8192

2) Setup dm-ebs to emulate 512B to 8K mapping

urezki@pc638:~/bin$ cat dmsetup.sh

lower=/dev/nvme0n1
len=$(blockdev --getsz "$lower")

echo "0 $len ebs $lower 0 1 16" | dmsetup create nvme-8k
urezki@pc638:~/bin$

offset 0, ebs=1 and ubs=16(in sectors).

3) Create an ext4 filesystem(default 4K block size)

urezki@pc638:~/bin$ sudo mkfs.ext4 -F /dev/dm-0
mke2fs 1.47.0 (5-Feb-2023)
Discarding device blocks: done
Creating filesystem with 2072576 4k blocks and 518144 inodes
Filesystem UUID: bd0b6ca6-0506-4e31-86da-8d22c9d50b63
Superblock backups stored on blocks:
        32768, 98304, 163840, 229376, 294912, 819200, 884736, 1605632

Allocating group tables: done
Writing inode tables: done
Creating journal (16384 blocks): done
Writing superblocks and filesystem accounting information: mkfs.ext4: Input/output error while writing out and closing file system
urezki@pc638:~/bin$ dmesg

<snip>
[ 1618.875449] buffer_io_error: 1028 callbacks suppressed
[ 1618.875456] Buffer I/O error on dev dm-0, logical block 0, lost async page write
[ 1618.875527] Buffer I/O error on dev dm-0, logical block 1, lost async page write
[ 1618.875602] Buffer I/O error on dev dm-0, logical block 2, lost async page write
[ 1618.875620] Buffer I/O error on dev dm-0, logical block 3, lost async page write
[ 1618.875639] Buffer I/O error on dev dm-0, logical block 4, lost async page write
[ 1618.894316] Buffer I/O error on dev dm-0, logical block 5, lost async page write
[ 1618.894358] Buffer I/O error on dev dm-0, logical block 6, lost async page write
[ 1618.894380] Buffer I/O error on dev dm-0, logical block 7, lost async page write
[ 1618.894405] Buffer I/O error on dev dm-0, logical block 8, lost async page write
[ 1618.894427] Buffer I/O error on dev dm-0, logical block 9, lost async page write
<snip>

Many I/O errors because the lower 8K device rejects sub-ubs/misaligned
requests.

with a patch:

urezki@pc638:~/bin$ sudo mkfs.ext4 -F /dev/dm-0
mke2fs 1.47.0 (5-Feb-2023)
Discarding device blocks: done
Creating filesystem with 2072576 4k blocks and 518144 inodes
Filesystem UUID: 9b54f44f-ef55-4bd4-9e40-c8b775a616ac
Superblock backups stored on blocks:
        32768, 98304, 163840, 229376, 294912, 819200, 884736, 1605632

Allocating group tables: done
Writing inode tables: done
Creating journal (16384 blocks): done
Writing superblocks and filesystem accounting information: done

urezki@pc638:~/bin$ sudo mount /dev/dm-0 /mnt/
urezki@pc638:~/bin$ ls -al /mnt/
total 24
drwxr-xr-x  3 root root  4096 Oct 17 15:13 .
drwxr-xr-x 19 root root  4096 Jul 10 19:42 ..
drwx------  2 root root 16384 Oct 17 15:13 lost+found
urezki@pc638:~/bin$

After this change: mkfs completes; mount succeeds.

v1 -> v2:
 - reflect a user space visible impact in the commit message.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 drivers/md/dm-ebs-target.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/dm-ebs-target.c b/drivers/md/dm-ebs-target.c
index 6abb31ca9662..b354e74a670e 100644
--- a/drivers/md/dm-ebs-target.c
+++ b/drivers/md/dm-ebs-target.c
@@ -103,7 +103,7 @@ static int __ebs_rw_bvec(struct ebs_c *ec, enum req_op op, struct bio_vec *bv,
 			} else {
 				flush_dcache_page(bv->bv_page);
 				memcpy(ba, pa, cur_len);
-				dm_bufio_mark_partial_buffer_dirty(b, buf_off, buf_off + cur_len);
+				dm_bufio_mark_buffer_dirty(b);
 			}
 
 			dm_bufio_release(b);
-- 
2.47.3


