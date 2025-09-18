Return-Path: <linux-kernel+bounces-822790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2394B84AF8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 14:53:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 502001C23816
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 12:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2026F302146;
	Thu, 18 Sep 2025 12:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="DArMenWx"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8069E191F72
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 12:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758200013; cv=none; b=pZRU0C22y8CTogCOnAPhxAMc/US0W6zT5iNR5DDM8768FaYavktm+bxYnbLg67hbR2OQ58Bl5PRnQVq5jCCWQHW5ISa0BhzAA59glglb9wXNwoZaxKc85V+pmaCPvNWdYbcKqQol/IR+yCQJQpjaFcH6+r0OSsdNl+dTw8i03s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758200013; c=relaxed/simple;
	bh=ODiqRtMhIllV2YzBKYzSZwkBywmu1WnyBEw4Nm3NNH8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uAtVGHJuEWjdccF67YM4arkWUtjrmEvhA4LGuuoz0gE1nLg2ALqAvlpEzXpEHjW5tcD82iieqXNkb1Wr21FkePkO+jwRb1mMzAk4ZRHryeFpknl0sHgZ11XsVBMFV3VslmIB97q+BNHnLj9Vt8gKXFkod2DdOYEfIeZ4jJ7fVZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=DArMenWx; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-77d64726e47so495916b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 05:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1758200011; x=1758804811; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MUSOfdAVmTYSDhL/s2Qxq/RUUYslxbA3WNrnh15yqjM=;
        b=DArMenWx2EpJ9zEbiM2qip5l/RpGOOI2bAsSU2+jwXocJVKqpbAtrTrATYcnaSeZ2I
         SCtWaBZgQcrrzVBDWnrwujfTbybfptpm78B4FZMY+NzjnnCNRIGJXBR7z8h0RE1eFSlq
         LPJZbjqVS+7R8O7a+JDjFHTmV2SWWhIpmyoSvX018eOvEe3hVw8HfuSzJdzJdz9dPiD1
         DL+4h6C4ACwpvnLFSXnTK8ZYcq2mgYCA2pxom26bKzA8u/GZ6gUGXQw5E7Zzveujg7iQ
         qZ4m6GBmkhNMXzOWZUs3dpGSqHh1TECJgDxZ+2nIEDD4utdXD7N7jvS38+9zIl4fpEtk
         puMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758200011; x=1758804811;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MUSOfdAVmTYSDhL/s2Qxq/RUUYslxbA3WNrnh15yqjM=;
        b=KPec+taaf6jazJnc+eitaSNFQAd9mlT02uXjfZXmgeNWB+1pXRY8aKuUP12724CVSE
         j88CiNoYARgcCT7bCDI4XZwQ+jvv25gO0GeoxMvWNJSHnbxStIIIYJP/UTGnjiAn2T2m
         NiCCroxVIZRF6DQx3ElZBi8hA8tuttI0dncWnHToaGptBcsBymRsGKrmwkIrvVCTMEhf
         H/pbjasyW+eZJC7BObGuLtIIJOfvVLz6Xbb73+FRqjgPS3qFHKMBlyVdMRu/O2NU7cdp
         u13VlWhMq75sF/TCWZy+QQW/OQeYixzhmXgmfD/XXTZNwTdes/IIoOCtQpS4bGyVc/7x
         QZww==
X-Forwarded-Encrypted: i=1; AJvYcCXzJeEbR8dU6sCjzdHF0Ea1Wcm/PxrzMFv6Bv7kVGDoMxF0p7pUsDFFx1i7QkJ9+ycDTrqCcy7xihRZ7+g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjhlZzagcQqBK6TpJy6VqXIuhrBoP1eKN2xJZNBkx44YgsW8N5
	Zcfq587Hw04u8ZRIdOw/qlAiN19B/SMgkwHWwP+ja4qeJc5ZNQ/q08bhbzDY8enTFA2k53VxGDU
	hCS/o
X-Gm-Gg: ASbGncuKLr1KvDE7+EjIsoE9ucwniUhEdl2gZNcuXPqO9k3XIQSTgbdxKIacSsgEwda
	BGTQIeKkbFVGL46ji0HuvbOxe4idoaZo7MdyjDp99a9qCwfZT3SFRY6xON0xK8ligAwAJL4UXAI
	Gwn3xZtzx2E6ffkULtOpWayYDAssO3IR5fTQKWLRieSxkM1GW7zOkD9fdz6V6E1WMNoRKbjX5WD
	39Fmz0kCDllcEEHc555NzcWjqpH06TjqNk0yZughJw03lA72s8OGyIJDQ2MeuZPFUUpSxaCw50V
	P3JEKiPPvtDJriUioTvaNW+Q0rdKiyDxHCW195i/Bg6ur0WrZcYbGF75/5glHWg6XTc0hEpvFT+
	MVyCRHWe9HtoSEqy7vAEImOT46i4OoeD3OUMP7QrPzMzpk2gBq0EisbexHw==
X-Google-Smtp-Source: AGHT+IGitHvWLOqBjAyxPQjM9IH3xo6OKea6/HJ7aRIdCG0mScILj6I0E++jeB+MRm8QGg9KrD1aLg==
X-Received: by 2002:a05:6a20:12c9:b0:246:3a6:3e41 with SMTP id adf61e73a8af0-27a9303f071mr8878716637.6.1758200010648;
        Thu, 18 Sep 2025 05:53:30 -0700 (PDT)
Received: from localhost ([106.38.221.167])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54ff35adabsm2265455a12.11.2025.09.18.05.53.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 05:53:30 -0700 (PDT)
From: Jian Zhang <zhangjian.3032@bytedance.com>
To: dwmw2@infradead.org,
	richard@nod.at,
	linux-mtd@lists.infradead.org
Cc: Jian Zhang <zhangjian.3032@bytedance.com>,
	Zhihao Cheng <chengzhihao1@huawei.com>,
	Fedor Pchelkin <pchelkin@ispras.ru>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] jffs2: Fix panic in jffs2_scan_eraseblock()
Date: Thu, 18 Sep 2025 20:52:53 +0800
Message-ID: <20250918125254.3980444-1-zhangjian.3032@bytedance.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

During AC off and file-system write stress testing, a low-probability
occurrence of the following kernel panic on my test platform,
Gigadevice’s GD25B512M flash is more prone to this issue. Other flash
chips have not exhibited this issue.

The specific manifestation of this issue is:
If a power loss occurs while an Erase command is in progress, it may
cause incomplete charging or discharging, s data read from the same
offset to be inconsistent across multiple reads.
The vendor refers to this as a 'middle-bit' issue.

When we read a node’s header located at the end of the previous block
and the CRC check passes, we use that node’s start address as the
starting point for `jffs2_fill_scan_buf` to read more data.
Because the data has just passed CRC verification, we trust it and
skip re-checking. However, due to the "middle-bit" phenomenon described
above, some bits may flip, resulting in corrupted data and ultimately
causing this issue. Therefore, a stricter check was added: after calling
`jffs2_fill_scan_buf`, the data is verified once more.

After discussions with the flash vendor and our own testing, we
confirmed that the `middle-bit`` scenario is indeed fairly common—it
only requires an erase operation combined with a sudden power loss
(we tested MX/Winbond typical flash chips).
However, this exact issue has so far only been reproduced on the
GD25B512M device.

* Logic analyzer capture/data as follows:
(6C)Quad Output Fast Read with 4-Byte Addr. <- first read
...
13:15:05. 03A62108 20 00 00 00 08 00 00 0C ...
13:15:05. 03A62110 08 00 00 00 00 00 00 80 ...
13:15:05. 03A62118 96 50 FA AB A6 CE 8A 6A ...
13:15:05. 03A62120 16 20 00 00 FC 23 00 00 ...
13:15:05. 03A62128 85 19 02 E0 81 02 00 00 ...  <- header, end of block
13:15:05. 03A62130 47 31 E0 DA 49 F5 00 00 ...
13:15:05. 03A62138 1B 14 04 00 A4 81 00 04 ...
13:15:05. 03A62140 00 00 00 00 00 00 00 00 ...

(6C)Quad Output Fast Read with 4-Byte Addr. <- second read
13:15:05. 03A62128 85 19 02 E0 A1 42 00 48 ... <- some bits were flipped
13:15:05. 03A62130 47 31 E0 DA 49 F5 00 00 ...
13:15:05. 03A62138 1B 15 04 00 A5 81 00 04 ...
13:15:05. 03A62140 01 00 00 10 10 40 00 00 ...
13:15:05. 03A62148 B2 D7 E1 B8 92 D5 E9 38 ...
13:15:05. 03A62150 92 D5 E9 38 00 30 00 00 ...
13:15:05. 03A62158 3D 02 08 02 00 10 0B A4 ...
...

* The panic backtrace:
[    3.597643] kernel BUG at /fs/jffs2/nodelist.c:670!
[    3.603092] Internal error: Oops - BUG: 0 [#1] SMP ARM
[    3.608836] CPU: 0 PID: 136 Comm: mount Not tainted 6.1.51-6f8bb35-dirty-2b7a246 #1
[    3.617391] Hardware name: Generic DT based system
[    3.622743] PC is at jffs2_scan_dirty_space+0xc4/0xc8
[    3.628402] LR is at jffs2_scan_dirty_space+0xc4/0xc8
[    3.634041] pc : [<40419624>]    lr : [<40419624>]    psr: 60070013
[    3.641041] sp : 9fd59da8  ip : 00000000  fp : 00001000
[    3.646878] r10: 00b510a4  r9 : 411ae000  r8 : 4298a000
[    3.652714] r7 : 4298a000  r6 : 00001000  r5 : 427d24c4  r4 : 00b510a4
[    3.660006] r3 : 42688a00  r2 : 00000000  r1 : 00000000  r0 : 00000046
[    3.667298] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
[    3.675270] Control: 10c5387d  Table: 8284006a  DAC: 00000051
[    3.681687] Register r0 information: non-paged memory
[    3.687337] Register r1 information: NULL pointer
[    3.692595] Register r2 information: NULL pointer
[    3.697852] Register r3 information: slab task_struct start 42688a00 pointer offset 0
[    3.706618] Register r4 information: non-paged memory
[    3.712263] Register r5 information: non-slab/vmalloc memory
[    3.718587] Register r6 information: non-paged memory
[    3.724231] Register r7 information: slab kmalloc-4k start 4298a000 pointer offset 0 size 4096
[    3.733870] Register r8 information: slab kmalloc-4k start 4298a000 pointer offset 0 size 4096
[    3.743508] Register r9 information: slab kmalloc-1k start 411ae000 pointer offset 0 size 1024
[    3.753146] Register r10 information: non-paged memory
[    3.758887] Register r11 information: non-paged memory
[    3.764630] Register r12 information: NULL pointer
[    3.769984] Process mount (pid: 136, stack limit = 0x8ea8246c)
[    3.776504] Stack: (0x9fd59da8 to 0x9fd5a000)
[    3.781375] 9da0:                   40b830e8 40a22968 00b510a4 4041e5f4 ae4b8c93 9fd59e0c
[    3.790513] 9dc0: 4298a000 95713a15 00000004 000000b5 000004af 000024c4 427d0000 4271f6c0
[    3.799650] 9de0: 00b510b0 02851885 00000000 00000000 00000000 0000e002 42688a00 00001985
[    3.808787] 9e00: 4298a000 00000000 00001000 00001000 e0021985 000000c4 00000000 33dd4eb3
[    3.817924] 9e20: 00f00000 411ae000 411ad800 0000000c 00000000 4273ea00 00000000 42688a00
[    3.827062] 9e40: 00008000 40421c78 00000000 42688a00 00008000 402b2430 404240ac 42688a00
[    3.836199] 9e60: 00000000 33dd4eb3 411ad800 411ae000 411ad800 0000000c 00f00000 4273ea00
[    3.845337] 9e80: 00000000 42688a00 00008000 404240c8 40e602a8 40424618 4187e400 411ad800
[    3.854474] 9ea0: 4273ea00 4187e400 40424588 00000000 00000000 405d8324 4187e400 4273ea00
[    3.863612] 9ec0: 40424588 00000005 00000000 405d84a0 4271f700 4032e8dc 4273ea00 01f00005
[    3.872749] 9ee0: 40b5ab4c 33dd4eb3 00008000 4273ea00 00000020 9fd59f74 4271f8c0 402f332c
[    3.881886] 9f00: 40b5ab4c 4273ea00 00000020 4012bf00 42688a00 4273ea00 00000020 40318f24
[    3.891023] 9f20: 00000000 421fb000 00000000 00000001 ffffff9c 33dd4eb3 00000000 00000000
[    3.900161] 9f40: 00008000 4271f740 4271f8c0 00000000 3ed86f72 00008000 42688a00 40319900
[    3.909298] 9f60: 00000000 00000000 00000800 33dd4eb3 00000000 42735cd0 414f0d48 33dd4eb3
[    3.918434] 9f80: 401002c4 00000000 00008000 00000000 00000015 401002c4 42688a00 00000015
[    3.927571] 9fa0: 00000000 40100060 00000000 00008000 3ed86f63 3ed86f72 3ed86f86 00008000
[    3.936707] 9fc0: 00000000 00008000 00000000 00000015 004c65c8 004d16c0 00000000 00000000
[    3.945844] 9fe0: 004d0f90 3ed86b30 004797f8 36eaae40 60070010 3ed86f63 00000000 00000000
[    3.954988]  jffs2_scan_dirty_space from jffs2_scan_medium+0x584/0x1730
[    3.962398]  jffs2_scan_medium from jffs2_do_mount_fs+0x1e4/0x740
[    3.969220]  jffs2_do_mount_fs from jffs2_do_fill_super+0xe8/0x228
[    3.976139]  jffs2_do_fill_super from mtd_get_sb+0xb4/0x100
[    3.982371]  mtd_get_sb from get_tree_mtd+0xac/0x2b0
[    3.987924]  get_tree_mtd from vfs_get_tree+0x2c/0xe8
[    3.993576]  vfs_get_tree from path_mount+0x634/0xa18
[    3.999232]  path_mount from sys_mount+0x1f4/0x248
[    4.004590]  sys_mount from ret_fast_syscall+0x0/0x54
[    4.010244] Exception stack(0x9fd59fa8 to 0x9fd59ff0)
[    4.015891] 9fa0:                   00000000 00008000 3ed86f63 3ed86f72 3ed86f86 00008000
[    4.025028] 9fc0: 00000000 00008000 00000000 00000015 004c65c8 004d16c0 00000000 00000000
[    4.034162] 9fe0: 004d0f90 3ed86b30 004797f8 36eaae40
[    4.039809] Code: e1a0100c e3010b4c e34400b8 eb14c972 (e7f001f2)
[    4.046619] ---[ end trace 0000000000000000 ]---
[    4.060330] Kernel panic - not syncing: Fatal exception

Signed-off-by: Jian Zhang <zhangjian.3032@bytedance.com>
---
 fs/jffs2/scan.c | 66 +++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 61 insertions(+), 5 deletions(-)

diff --git a/fs/jffs2/scan.c b/fs/jffs2/scan.c
index 62879c218d4b..cf5c9bc3b442 100644
--- a/fs/jffs2/scan.c
+++ b/fs/jffs2/scan.c
@@ -59,6 +59,17 @@ static inline int min_free(struct jffs2_sb_info *c)
 
 }
 
+static inline uint32_t jffs2_calc_node_hdr_crc(const struct jffs2_unknown_node *node)
+{
+	struct jffs2_unknown_node crcnode;
+
+	crcnode.magic = node->magic;
+	crcnode.nodetype = cpu_to_je16(je16_to_cpu(node->nodetype) | JFFS2_NODE_ACCURATE);
+	crcnode.totlen = node->totlen;
+
+	return crc32(0, &crcnode, sizeof(crcnode) - 4);
+}
+
 static inline uint32_t EMPTY_SCAN_SIZE(uint32_t sector_size) {
 	if (sector_size < DEFAULT_EMPTY_SCAN_SIZE)
 		return sector_size;
@@ -447,7 +458,6 @@ static int jffs2_scan_xref_node(struct jffs2_sb_info *c, struct jffs2_eraseblock
 static int jffs2_scan_eraseblock (struct jffs2_sb_info *c, struct jffs2_eraseblock *jeb,
 				  unsigned char *buf, uint32_t buf_size, struct jffs2_summary *s) {
 	struct jffs2_unknown_node *node;
-	struct jffs2_unknown_node crcnode;
 	uint32_t ofs, prevofs, max_ofs;
 	uint32_t hdr_crc, buf_ofs, buf_len;
 	int err;
@@ -757,11 +767,9 @@ static int jffs2_scan_eraseblock (struct jffs2_sb_info *c, struct jffs2_eraseblo
 			ofs += 4;
 			continue;
 		}
+
 		/* We seem to have a node of sorts. Check the CRC */
-		crcnode.magic = node->magic;
-		crcnode.nodetype = cpu_to_je16( je16_to_cpu(node->nodetype) | JFFS2_NODE_ACCURATE);
-		crcnode.totlen = node->totlen;
-		hdr_crc = crc32(0, &crcnode, sizeof(crcnode)-4);
+		hdr_crc = jffs2_calc_node_hdr_crc(node);
 
 		if (hdr_crc != je32_to_cpu(node->hdr_crc)) {
 			noisy_printk(&noise, "%s(): Node at 0x%08x {0x%04x, 0x%04x, 0x%08x) has invalid CRC 0x%08x (calculated 0x%08x)\n",
@@ -810,6 +818,18 @@ static int jffs2_scan_eraseblock (struct jffs2_sb_info *c, struct jffs2_eraseblo
 					return err;
 				buf_ofs = ofs;
 				node = (void *)buf;
+				hdr_crc = jffs2_calc_node_hdr_crc(node);
+				if (hdr_crc != je32_to_cpu(node->hdr_crc)) {
+					noisy_printk(&noise,
+								"%s(): Inode Second CRC check failed at 0x%08x (expected 0x%08x, calculated 0x%08x)\n",
+								__func__, ofs,
+								je32_to_cpu(node->hdr_crc),
+								hdr_crc);
+					if ((err = jffs2_scan_dirty_space(c, jeb, 4)))
+						return err;
+					ofs += 4;
+					continue;
+				}
 			}
 			err = jffs2_scan_inode_node(c, jeb, (void *)node, ofs, s);
 			if (err) return err;
@@ -827,6 +847,18 @@ static int jffs2_scan_eraseblock (struct jffs2_sb_info *c, struct jffs2_eraseblo
 					return err;
 				buf_ofs = ofs;
 				node = (void *)buf;
+				hdr_crc = jffs2_calc_node_hdr_crc(node);
+				if (hdr_crc != je32_to_cpu(node->hdr_crc)) {
+					noisy_printk(&noise,
+								"%s(): Dirent Second CRC check failed at 0x%08x (expected 0x%08x, calculated 0x%08x)\n",
+								__func__, ofs,
+								je32_to_cpu(node->hdr_crc),
+								hdr_crc);
+					if ((err = jffs2_scan_dirty_space(c, jeb, 4)))
+						return err;
+					ofs += 4;
+					continue;
+				}
 			}
 			err = jffs2_scan_dirent_node(c, jeb, (void *)node, ofs, s);
 			if (err) return err;
@@ -845,6 +877,18 @@ static int jffs2_scan_eraseblock (struct jffs2_sb_info *c, struct jffs2_eraseblo
 					return err;
 				buf_ofs = ofs;
 				node = (void *)buf;
+				hdr_crc = jffs2_calc_node_hdr_crc(node);
+				if (hdr_crc != je32_to_cpu(node->hdr_crc)) {
+					noisy_printk(&noise,
+								"%s(): Xattr Second CRC check failed at 0x%08x (expected 0x%08x, calculated 0x%08x)\n",
+								__func__, ofs,
+								je32_to_cpu(node->hdr_crc),
+								hdr_crc);
+					if ((err = jffs2_scan_dirty_space(c, jeb, 4)))
+						return err;
+					ofs += 4;
+					continue;
+				}
 			}
 			err = jffs2_scan_xattr_node(c, jeb, (void *)node, ofs, s);
 			if (err)
@@ -862,6 +906,18 @@ static int jffs2_scan_eraseblock (struct jffs2_sb_info *c, struct jffs2_eraseblo
 					return err;
 				buf_ofs = ofs;
 				node = (void *)buf;
+				hdr_crc = jffs2_calc_node_hdr_crc(node);
+				if (hdr_crc != je32_to_cpu(node->hdr_crc)) {
+					noisy_printk(&noise,
+								"%s(): Xref Second CRC check failed at 0x%08x (expected 0x%08x, calculated 0x%08x)\n",
+								__func__, ofs,
+								je32_to_cpu(node->hdr_crc),
+								hdr_crc);
+					if ((err = jffs2_scan_dirty_space(c, jeb, 4)))
+						return err;
+					ofs += 4;
+					continue;
+				}
 			}
 			err = jffs2_scan_xref_node(c, jeb, (void *)node, ofs, s);
 			if (err)
-- 
2.47.0


