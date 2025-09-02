Return-Path: <linux-kernel+bounces-796425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D787B40079
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 14:28:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 770157AB431
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 12:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF0192FC009;
	Tue,  2 Sep 2025 12:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WFYoUvU/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C08D2F90D4
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 12:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756816053; cv=none; b=NR1delyGGfzI4Zl+rpnaxba+rNlONCTmvQ1+LeuYXKuD+Zo7LzWHPyBnUOrX4B31XJ7dsMCA5+yFgXqSpuQ7mA1Ik3XRk89CiUIbpkT9b1ruQK/JiS9Kp7WxEgCzj55jfeFVd3Ny2g3pqfdYOcJhCC/DoOK19oqnw6Iu5qUECPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756816053; c=relaxed/simple;
	bh=kLqXIyG7JMsCDuJdIBF+lJeJW74pc8LBnf2tM9jt1Uk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kSsuD6VOpmNP//Iwb39PSKM8rrm7jrEDCGPoBoD76NPmihpzGAlF9+Y/wtJWEOxg3j2efklczacKQuieIgGRoRBiqzIQJUttS8u8wA3dt8pcCszMTCIb/BSEY9jCnJ4pBvyFH/RZFra3hlXWlhcEidmNH7OSZGwopRF8wMimZWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WFYoUvU/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E0DEC4CEED;
	Tue,  2 Sep 2025 12:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756816051;
	bh=kLqXIyG7JMsCDuJdIBF+lJeJW74pc8LBnf2tM9jt1Uk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WFYoUvU/a82+Q+mx2ySc9N2qiKVLdYxSlJsty9hmy7XzBLjTBxMGJQQsMpSTXHRGq
	 IvBsM/QlErZsKuKfefYFfzNVraTP8QuVZtqRsd9Dxso+prgMAVS++xJGf7XBmyH2MU
	 3Lr62k2RMxFvo83xqejOtW8es9olKbOL0IXj2vci5oqXuPw3Gayry9dxLs1vOq/L0C
	 L3hqoBK1TbGO+17imDn2zjnx5rzr7FLSdzeBImHr3tXgG0pjJlvZDl/iW/jEstBLQr
	 7TJSdR7NS3csfRchEHdnu4RKmQ9n31kJn1xcmPvVbzYyxJgcNYQArDbxTX48nruyUD
	 iUIpnk+0wmsAQ==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH 2/2] f2fs: clean up error handing of f2fs_submit_page_read()
Date: Tue,  2 Sep 2025 20:27:20 +0800
Message-ID: <20250902122720.2750481-2-chao@kernel.org>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae-goog
In-Reply-To: <20250902122720.2750481-1-chao@kernel.org>
References: <20250902122720.2750481-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Below two functions should never fail, clean up error handling in their
callers:
1) f2fs_grab_read_bio() in f2fs_submit_page_read()
2) bio_add_folio() in f2fs_submit_page_read()

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/data.c | 41 ++++++++---------------------------------
 1 file changed, 8 insertions(+), 33 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 7961e0ddfca3..990ff6ee322b 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1083,7 +1083,7 @@ static struct bio *f2fs_grab_read_bio(struct inode *inode, block_t blkaddr,
 }
 
 /* This can handle encryption stuffs */
-static int f2fs_submit_page_read(struct inode *inode, struct folio *folio,
+static void f2fs_submit_page_read(struct inode *inode, struct folio *folio,
 				 block_t blkaddr, blk_opf_t op_flags,
 				 bool for_write)
 {
@@ -1092,23 +1092,16 @@ static int f2fs_submit_page_read(struct inode *inode, struct folio *folio,
 
 	bio = f2fs_grab_read_bio(inode, blkaddr, 1, op_flags,
 					folio->index, for_write);
-	if (IS_ERR(bio))
-		return PTR_ERR(bio);
 
 	/* wait for GCed page writeback via META_MAPPING */
 	f2fs_wait_on_block_writeback(inode, blkaddr);
 
-	if (!bio_add_folio(bio, folio, PAGE_SIZE, 0)) {
-		iostat_update_and_unbind_ctx(bio);
-		if (bio->bi_private)
-			mempool_free(bio->bi_private, bio_post_read_ctx_pool);
-		bio_put(bio);
-		return -EFAULT;
-	}
+	if (!bio_add_folio(bio, folio, PAGE_SIZE, 0))
+		f2fs_bug_on(sbi, 1);
+
 	inc_page_count(sbi, F2FS_RD_DATA);
 	f2fs_update_iostat(sbi, NULL, FS_DATA_READ_IO, F2FS_BLKSIZE);
 	f2fs_submit_read_bio(sbi, bio, DATA);
-	return 0;
 }
 
 static void __set_data_blkaddr(struct dnode_of_data *dn, block_t blkaddr)
@@ -1265,10 +1258,8 @@ struct folio *f2fs_get_read_data_folio(struct inode *inode, pgoff_t index,
 		return folio;
 	}
 
-	err = f2fs_submit_page_read(inode, folio, dn.data_blkaddr,
+	f2fs_submit_page_read(inode, folio, dn.data_blkaddr,
 						op_flags, for_write);
-	if (err)
-		goto put_err;
 	return folio;
 
 put_err:
@@ -2145,16 +2136,10 @@ static int f2fs_read_single_page(struct inode *inode, struct folio *folio,
 		f2fs_submit_read_bio(F2FS_I_SB(inode), bio, DATA);
 		bio = NULL;
 	}
-	if (bio == NULL) {
+	if (bio == NULL)
 		bio = f2fs_grab_read_bio(inode, block_nr, nr_pages,
 				f2fs_ra_op_flags(rac), index,
 				false);
-		if (IS_ERR(bio)) {
-			ret = PTR_ERR(bio);
-			bio = NULL;
-			goto out;
-		}
-	}
 
 	/*
 	 * If the page is under writeback, we need to wait for
@@ -2303,18 +2288,10 @@ int f2fs_read_multi_pages(struct compress_ctx *cc, struct bio **bio_ret,
 			bio = NULL;
 		}
 
-		if (!bio) {
+		if (!bio)
 			bio = f2fs_grab_read_bio(inode, blkaddr, nr_pages - i,
 					f2fs_ra_op_flags(rac),
 					folio->index, for_write);
-			if (IS_ERR(bio)) {
-				ret = PTR_ERR(bio);
-				f2fs_decompress_end_io(dic, ret, true);
-				f2fs_put_dnode(&dn);
-				*bio_ret = NULL;
-				return ret;
-			}
-		}
 
 		if (!bio_add_folio(bio, folio, blocksize, 0))
 			goto submit_and_realloc;
@@ -3639,11 +3616,9 @@ static int f2fs_write_begin(const struct kiocb *iocb,
 			err = -EFSCORRUPTED;
 			goto put_folio;
 		}
-		err = f2fs_submit_page_read(use_cow ?
+		f2fs_submit_page_read(use_cow ?
 				F2FS_I(inode)->cow_inode : inode,
 				folio, blkaddr, 0, true);
-		if (err)
-			goto put_folio;
 
 		folio_lock(folio);
 		if (unlikely(folio->mapping != mapping)) {
-- 
2.49.0


