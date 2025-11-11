Return-Path: <linux-kernel+bounces-895685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D61CC4EA7C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 16:01:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C787189DE79
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 14:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 313B83112C1;
	Tue, 11 Nov 2025 14:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="j5URKchb"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09F025B305
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 14:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762872984; cv=none; b=iaxV/3VjPTxPr22OTfR0LqQ6kVW4Rqsc+fHxkMndXHi3+eyQ8zoo+5YU0FmYLHnC3LWz/VeIbLQPbFXBGfvet6AhbMecSIipQI2y1BjabehKwl26rAMA14bR0pUwvFOh5jUhuEzOtGBgZN2Nk5IbS408+iph4sheFDV2GMP7uiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762872984; c=relaxed/simple;
	bh=BGlYUVNTsw42hsroooXzYQrIcdizBBPfg2/G44tubvw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=f6Rml6gt8sWnlX6l3YLZ7maUiGScfYKJ2AA02RULy1pFBTIY55TY/KAn8iN9i8bjA06aEIxga8PKtKVaUKEzkMdVyj5LZc7eEr24Ex2p3Rsg3wD16SLrxdg414omVE2c9DBJxhsEuMOWvYI59cykcmHoWLl2I6/1I3DEepvyhGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=j5URKchb; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-298287a26c3so22295425ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 06:56:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1762872982; x=1763477782; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tSrPXujcyIIc5zBIA1IqBgfqR0DS/PDQZ/DNXNkBnlA=;
        b=j5URKchbkYtv/Vh+Mfe1vMtWZ8RJXceDJMkpio33eb8RyG7quPN/L35aPPDI6PLeyW
         XFQflkzPeIpjxfCGYPkvDr7BRnaSE7pMkcx6nsHFX5oN+ofMo4E1AyveBbFtdMbnbiuV
         D//9Q+LIqnXkMNls0R1rh6mRwuQWaaicglxdvz03wzmrJ7FfWnnsHJeuVllvdEHOp2/L
         XWwbekOgm5Z4a3D5CqOgfpmltgXNBfc+FKcgavCrmggAcj+HGqbwdx4lA+r/SPvKdE5W
         YAPzESmLb0cPeVxN14IwWZ0Cn8KoSk+g3slhbzW8ssggbwNbNXSqan9fsZIwkOkwUldn
         txZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762872982; x=1763477782;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tSrPXujcyIIc5zBIA1IqBgfqR0DS/PDQZ/DNXNkBnlA=;
        b=Lzmm8wJOP0YT0zd2gbotbJPa6JPsb6afC2vJMQZqnOmE2VBv+vhQ736bknw6m4Z158
         BrW07PqPpTsoWErwJE6BDbFlpKgEz2CfiHUel0RnOAMz++s/xiBVj8CRA3YfbmlgZmlw
         pw1pKlwiuoEqeDVbFyqwqB7eDvumsw+WsicHU8cgzTJgfqWrtNzgLrVEnqkMkCYtWIsy
         8+Unzw9xM6OUf+X0j3zaWv+z6TiD4cNakX5rLEJAjWtyXPjrd5o10yfMtB1t6pDZ6NbY
         M00yLEiz1L8SL2rFx9SURjeyaMTb2Y/qGIDWaCBHURtHFm2fvbxL00cbhWI5JS1Vq/3D
         LH7w==
X-Forwarded-Encrypted: i=1; AJvYcCWTBCjREf6BOZhlrOG/maOTaDMyQNU5yy8F1XdB+B+s1Fg+8bZIeaxKhF8RGBlZ41pd/YwcV1xoVKiZe84=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXbCCeGv84BqGmu5KYXbe24Hn8PXVlvLsdzJ3AU+maqKLu/ohk
	frBtTsq64L2iXsSbXULqyyHDcsMUQlfpz5HJHo4z/5/61t+Sju6iDCKPf3iBz67YMyLqy8CZ8Wm
	9rWDF5Zk=
X-Gm-Gg: ASbGnctx21ejLIFy9C2wwvCivc/DGFZAB0QEc2jVx/BEEEq70BcA5Z3fNhIS4N8ww8W
	7Kwk7UkpwKIXJHGMw9v56Z9b4xaijRVtVki2M1PGe4Qq3bik5WcTv8t0gbtimDNR8zAHEtfcOx8
	S9n+jcBc7KO8LbHHjGL1iEngbAAmsgYATQ2aeWcizz/4RNAYEOyX7yNbxxvnOfSi/8pXtVrWzbI
	2F7rcsTaraG8tzH3MotztfLxh6NCyukzvnc5uGMWCzwrIzpsmPXDXkHF51Z9IjbLrjAy72seqYE
	gCZOOPfKBLOo9Zpb0oJYdh4CX95aKc6MphxjkgQZvKyPcy5LukdCAIII0+DblkmCCNl4iv3jDSo
	XKCrqYCI0joC55QOM69v4NrAQJ0j3nYUbTVcgqQfgvit3NaxR9CLb6AXI6nldzBJ65atzd2rVnj
	m+L20728eD
X-Google-Smtp-Source: AGHT+IHzw7KGS5V49PmS3dPImgttpK5QuWelyEH8VVaWzQ8/JjHlzL/5enOIxdcpy8EEGYBBT6pxmw==
X-Received: by 2002:a17:902:e891:b0:295:2cb6:f4a8 with SMTP id d9443c01a7336-297e56dd7bcmr160323645ad.51.1762872981997;
        Tue, 11 Nov 2025 06:56:21 -0800 (PST)
Received: from localhost ([106.38.226.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29650c5c6b3sm182427605ad.24.2025.11.11.06.56.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 06:56:21 -0800 (PST)
From: Jian Zhang <zhangjian.3032@bytedance.com>
To: dwmw2@infradead.org,
	richard@nod.at,
	linux-mtd@lists.infradead.org,
	openbmc@lists.ozlabs.org
Cc: Jian Zhang <zhangjian.3032@bytedance.com>,
	Zhihao Cheng <chengzhihao1@huawei.com>,
	Fedor Pchelkin <pchelkin@ispras.ru>,
	linux-kernel@vger.kernel.org
Subject: [[RFC PATCH]] jffs2: attempt to fix "Error garbage collecting node"
Date: Tue, 11 Nov 2025 22:56:08 +0800
Message-ID: <20251111145609.1917969-1-zhangjian.3032@bytedance.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch shares analysis and a potential fix for the "Error garbage collecting node"
issue observed in long-run tests with SPI NOR flash under repeated AC cycles.

TL;DR:
An unstable block may pass CRC checks multiple times but fail during GC.
The practical mitigation is to locate such blocks and perform a read-erase-write
cycle to make them stable; the actual data content is irrelevant.

Background:

In long-run tests, JFFS2 sometimes fails to perform garbage collection, producing logs like:

[    3.470788] jffs2: notice: check_node_data: wrong data CRC in data node at 0x008cc2e8: read 0xb554ca36, calculated 0xc7ac50f7
...
[   46.815192] jffs2: Error garbage collecting node at 008cb694, mark node obsolete!
[   46.840646] jffs2: read_cache_page() returned error: -5

Root cause:

1. During GC, a power loss occurring while an `erase` operation is in progress
   can leave a block in an unstable state. Reads from this block may yield
   inconsistent results.

2. A node may pass multiple CRC checks, but during GC — particularly when moving
   a PRISTINE node — a CRC failure may occur, triggering the garbage collection error.

Detailed analysis:

- In `jffs2_garbage_collect_pristine`, moving a PRISTINE node does not increment
  the version number. At some point, two nodes with identical version numbers may
  exist simultaneously.

- With JFFS2 SUMMARY enabled, `jffs2_mark_node_obsolete` only marks the node
  obsolete in RAM, skipping flash updates. On the next boot, the node may be
  re-scanned and remain unstable.

- During file/node construction in `jffs2_add_tn_to_tree`, two nodes with the
  same version number are handled as follows:
  * Current node valid → discard the new node
  * Current node CRC error → replace with the new node

  This allows an unstable node to be selected even if it passes CRC on this pass.

Relevant call flow:

jffs2_find_gc_block
    jffs2_do_crccheck_inode
        jffs2_do_read_inode_internal
            jffs2_get_inode_nodes
                read_dnode
                    jffs2_add_tn_to_tree

Proposed mitigation:

Locate blocks that may be unstable and perform a read-erase-write cycle to
stabilize them. The actual data content is not important, only block stability.

Signed-off-by: Jian Zhang <zhangjian.3032@bytedance.com>
---
 fs/jffs2/scan.c | 172 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 172 insertions(+)

diff --git a/fs/jffs2/scan.c b/fs/jffs2/scan.c
index 62879c218d4b..1475d2c0be4c 100644
--- a/fs/jffs2/scan.c
+++ b/fs/jffs2/scan.c
@@ -442,6 +442,174 @@ static int jffs2_scan_xref_node(struct jffs2_sb_info *c, struct jffs2_eraseblock
 }
 #endif
 
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
+static int jffs2_pre_scan_eraseblock(struct jffs2_sb_info *c, struct jffs2_eraseblock *jeb)
+{
+	int ret;
+	bool error_found = false;
+	unsigned char *buf;
+	uint32_t crc;
+	struct jffs2_unknown_node *node;
+	struct jffs2_raw_inode *ri;
+	struct jffs2_raw_dirent *rd;
+
+	uint32_t ofs = 0, buf_len = c->sector_size;
+	uint32_t retlen;
+
+	buf = kmalloc(buf_len, GFP_KERNEL);
+	if (!buf) {
+		JFFS2_WARNING("Unable to allocate scan buffer of size %u\n", buf_len);
+		return -ENOMEM;
+	}
+
+	ret = jffs2_fill_scan_buf(c, buf, jeb->offset, buf_len);
+	if (ret) {
+		JFFS2_WARNING("Unable to read eraseblock at 0x%08x\n", jeb->offset);
+		goto exit;
+	}
+
+	while (ofs < c->sector_size) {
+		if (c->sector_size - ofs < sizeof(struct jffs2_unknown_node)) {
+			/* Not enough space for a node header */
+			break;
+		}
+
+		if (*(uint32_t *)(&buf[ofs]) == 0xffffffff) {
+			/* Reached empty space */
+			ofs += 4;
+			continue;
+		}
+
+		node = (struct jffs2_unknown_node *)&buf[ofs];
+		if (je16_to_cpu(node->magic) != JFFS2_MAGIC_BITMASK) {
+			ofs += 4;
+			continue;
+		}
+
+		if (jffs2_calc_node_hdr_crc(node) != je32_to_cpu(node->hdr_crc)) {
+			JFFS2_WARNING("node header CRC failed at %#08x\n",
+				      jeb->offset + ofs);
+			ofs += 4;
+			error_found = true;
+			goto check;
+		}
+
+		if (!(je16_to_cpu(node->nodetype) & JFFS2_NODE_ACCURATE)) {
+			/* This is an obsoleted node */
+			ofs += PAD(je32_to_cpu(node->totlen));
+			continue;
+		}
+
+		switch (je16_to_cpu(node->nodetype)) {
+		case JFFS2_NODETYPE_INODE:
+			if (c->sector_size - ofs < sizeof(struct jffs2_raw_inode)) {
+				/* Not enough space for a full inode node */
+				ofs += 4;
+				goto check;
+			}
+
+			ri = (struct jffs2_raw_inode *)node;
+			crc = crc32(0, ri, sizeof(*ri) - 8);
+			if (crc != je32_to_cpu(ri->node_crc)) {
+				JFFS2_WARNING("inode node CRC failed at %#08x, read=%#08x, calc=%#08x\n",
+					      jeb->offset + ofs,
+					      je32_to_cpu(ri->node_crc), crc);
+				error_found = true;
+				goto check;
+			}
+
+			if (je32_to_cpu(ri->dsize)) {
+				crc = crc32(0, ri->data, je32_to_cpu(ri->csize));
+				if (je32_to_cpu(ri->data_crc) != crc) {
+					JFFS2_WARNING("Data CRC failed data node at 0x%08x: Read 0x%08x, calculated 0x%08x\n",
+						ofs, je32_to_cpu(ri->data_crc), crc);
+					error_found = true;
+					goto check;
+				}
+			}
+
+			ofs += PAD(je32_to_cpu(node->totlen));
+			break;
+		case JFFS2_NODETYPE_DIRENT:
+			if (c->sector_size - ofs < sizeof(struct jffs2_raw_dirent)) {
+				/* Not enough space for a full dirent node */
+				ofs += 4;
+				goto check;
+			}
+
+			rd = (struct jffs2_raw_dirent *)node;
+			crc = crc32(0, rd, sizeof(*rd) - 8);
+			if (je32_to_cpu(rd->node_crc) != crc) {
+				JFFS2_WARNING("Node CRC failed dirent node at 0x%08x: Read 0x%08x, calculated 0x%08x\n",
+					ofs, je32_to_cpu(rd->node_crc), crc);
+				error_found = true;
+				goto check;
+			}
+
+			if (strnlen(rd->name, rd->nsize) != rd->nsize) {
+				JFFS2_WARNING("Name in dirent node at 0x%08x contains zeroes\n", ofs);
+				error_found = true;
+				break;
+			}
+
+			if (rd->nsize) {
+				crc = crc32(0, rd->name, rd->nsize);
+				if (je32_to_cpu(rd->name_crc) != crc) {
+					JFFS2_WARNING("Name CRC failed dirent node at 0x%08x: Read 0x%08x, calculated 0x%08x\n",
+						ofs, je32_to_cpu(rd->name_crc), crc);
+					error_found = true;
+					goto check;
+				}
+			}
+
+			ofs += PAD(je32_to_cpu(node->totlen));
+			break;
+		default:
+			ofs += PAD(je32_to_cpu(node->totlen));
+			/* Other node types are not pre-checked */
+			break;
+		}
+	}
+
+check:
+	// find any error during pre-scan, if found, erase the block, and write back.
+	if (error_found) {
+			JFFS2_WARNING("Erasing block at 0x%08x error_count %d due to pre-scan errors\n",
+				jeb->offset);
+			struct erase_info instr;
+
+			instr.addr = jeb->offset;
+			instr.len = c->sector_size;
+			ret = mtd_erase(c->mtd, &instr);
+			if (ret) {
+				JFFS2_ERROR("Erase at 0x%08x failed during pre-scan: errno %d\n",
+					jeb->offset, ret);
+				goto exit;
+			}
+
+			ret = jffs2_flash_direct_write(c, jeb->offset, buf_len, &retlen, buf);
+			if (ret) {
+				JFFS2_ERROR("Write back at 0x%08x failed during pre-scan: errno %d\n",
+					jeb->offset, ret);
+				goto exit;
+			}
+	}
+exit:
+
+	kfree(buf);
+	return ret;
+}
+
 /* Called with 'buf_size == 0' if buf is in fact a pointer _directly_ into
    the flash, XIP-style */
 static int jffs2_scan_eraseblock (struct jffs2_sb_info *c, struct jffs2_eraseblock *jeb,
@@ -453,6 +621,10 @@ static int jffs2_scan_eraseblock (struct jffs2_sb_info *c, struct jffs2_eraseblo
 	int err;
 	int noise = 0;
 
+	err = jffs2_pre_scan_eraseblock(c, jeb);
+	if (err) // only log warning, continue scanning
+		JFFS2_WARNING("Pre-scan of eraseblock at 0x%08x failed: err=%d\n",
+			      jeb->offset, err);
 
 #ifdef CONFIG_JFFS2_FS_WRITEBUFFER
 	int cleanmarkerfound = 0;
-- 
2.47.0


