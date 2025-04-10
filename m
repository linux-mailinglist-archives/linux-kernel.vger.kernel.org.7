Return-Path: <linux-kernel+bounces-597306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 198E2A837CF
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Apr 2025 06:25:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 356D38A5E62
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Apr 2025 04:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A37F1F0E56;
	Thu, 10 Apr 2025 04:23:06 +0000 (UTC)
Received: from ssh248.corpemail.net (ssh248.corpemail.net [210.51.61.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D821C8609
	for <linux-kernel@vger.kernel.org>; Thu, 10 Apr 2025 04:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.61.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744258985; cv=none; b=MIaDNl6QGt1gI7EjaxX08yBR/YVOgu41bxLx8PxlzcbUQGa+VglzQUiYon+O7jAoHYLzuhmARK/1BogHtrsh5fLMsIM64YLJi7ze1WolAHI9SFqjq59waL3VITLTU6TY0AHhSA1tBzbOisZuDW91sbV146Wev2bszHPEBSWCQfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744258985; c=relaxed/simple;
	bh=j0OUherja7S6Pq1kGSUjYII5H7TVXpIkLVrGY520/pU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DoNpJJwFWldTtKbQIJEftEsnLoGM7BCYGyAb1oiaWa2aTyPgXIJ5UDR5FwmHxFyGun2LoKUK34vzW3MvWT+ZEEejaeTYOVRyopqBnKxChfP+caN0feISxr8W9FyOjWVR+uvetmk1bapJusjd2nCOE0VSHRccTbAUZAE6qyEupdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.61.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from jtjnmail201622.home.langchao.com
        by ssh248.corpemail.net ((D)) with ASMTP (SSL) id 202504101222497180;
        Thu, 10 Apr 2025 12:22:49 +0800
Received: from localhost.localdomain (10.94.13.146) by
 jtjnmail201622.home.langchao.com (10.100.2.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 10 Apr 2025 12:22:50 +0800
From: Bo Liu <liubo03@inspur.com>
To: <xiang@kernel.org>, <chao@kernel.org>
CC: <linux-erofs@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>, Bo Liu
	<liubo03@inspur.com>
Subject: [PATCH 2/2] erofs: support deflate decompress by using Intel QAT
Date: Thu, 10 Apr 2025 00:20:48 -0400
Message-ID: <20250410042048.3044-3-liubo03@inspur.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20250410042048.3044-1-liubo03@inspur.com>
References: <20250410042048.3044-1-liubo03@inspur.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: Jtjnmail201613.home.langchao.com (10.100.2.13) To
 jtjnmail201622.home.langchao.com (10.100.2.22)
tUid: 20254101222494575475f9e853de47923a998131f5f9a
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

This patch introdueces the use of the Intel QAT to decompress compressed
data in the EROFS filesystem, aiming to improve the decompression speed
of compressed datea.

We created a 285MiB compressed file and then used the following command to
create EROFS images with different cluster size.
     # mkfs.erofs -zdeflate,level=9 -C16384

fio command was used to test random read and small random read(~5%) and
sequential read performance.
     # fio -filename=testfile  -bs=4k -rw=read -name=job1
     # fio -filename=testfile  -bs=4k -rw=randread -name=job1
     # fio -filename=testfile  -bs=4k -rw=randread --io_size=14m -name=job1

Here are some performance numbers for reference:

Processors: Intel(R) Xeon(R) 6766E(144 core)
Memory:     521 GiB

|-----------------------------------------------------------------------------|
|           | Cluster size | sequential read | randread  | small randread(5%) |
|-----------|--------------|-----------------|-----------|--------------------|
| Intel QAT |    4096      |    538  MiB/s   | 112 MiB/s |     20.76 MiB/s    |
| Intel QAT |    16384     |    699  MiB/s   | 158 MiB/s |     21.02 MiB/s    |
| Intel QAT |    65536     |    917  MiB/s   | 278 MiB/s |     20.90 MiB/s    |
| Intel QAT |    131072    |    1056 MiB/s   | 351 MiB/s |     23.36 MiB/s    |
| Intel QAT |    262144    |    1145 MiB/s   | 431 MiB/s |     26.66 MiB/s    |
| deflate   |    4096      |    499  MiB/s   | 108 MiB/s |     21.50 MiB/s    |
| deflate   |    16384     |    422  MiB/s   | 125 MiB/s |     18.94 MiB/s    |
| deflate   |    65536     |    452  MiB/s   | 159 MiB/s |     13.02 MiB/s    |
| deflate   |    65536     |    452  MiB/s   | 177 MiB/s |     11.44 MiB/s    |
| deflate   |    262144    |    466  MiB/s   | 194 MiB/s |     10.60 MiB/s    |

Signed-off-by: Bo Liu <liubo03@inspur.com>
---
 fs/erofs/decompressor_deflate.c | 145 +++++++++++++++++++++++++++++++-
 fs/erofs/internal.h             |   1 +
 fs/erofs/sysfs.c                |  30 +++++++
 3 files changed, 175 insertions(+), 1 deletion(-)

diff --git a/fs/erofs/decompressor_deflate.c b/fs/erofs/decompressor_deflate.c
index c6908a487054..a293c44e86d2 100644
--- a/fs/erofs/decompressor_deflate.c
+++ b/fs/erofs/decompressor_deflate.c
@@ -1,5 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 #include <linux/zlib.h>
+#include <linux/scatterlist.h>
+#include <crypto/acompress.h>
+
 #include "compress.h"
 
 struct z_erofs_deflate {
@@ -97,7 +100,7 @@ static int z_erofs_load_deflate_config(struct super_block *sb,
 	return -ENOMEM;
 }
 
-static int z_erofs_deflate_decompress(struct z_erofs_decompress_req *rq,
+static int __z_erofs_deflate_decompress(struct z_erofs_decompress_req *rq,
 				      struct page **pgpl)
 {
 	struct super_block *sb = rq->sb;
@@ -178,6 +181,146 @@ static int z_erofs_deflate_decompress(struct z_erofs_decompress_req *rq,
 	return err;
 }
 
+static int z_erofs_crypto_decompress_mem(struct z_erofs_decompress_req *rq)
+{
+	struct erofs_sb_info *sbi = EROFS_SB(rq->sb);
+	unsigned int nrpages_out =
+				PAGE_ALIGN(rq->pageofs_out + rq->outputsize) >> PAGE_SHIFT;
+	unsigned int nrpages_in = PAGE_ALIGN(rq->inputsize) >> PAGE_SHIFT;
+	struct sg_table st_src, st_dst;
+	struct scatterlist *sg_src, *sg_dst;
+	struct acomp_req *req;
+	struct crypto_wait wait;
+	u8 *headpage;
+	int ret, i;
+
+	WARN_ON(!*rq->in);
+	headpage = kmap_local_page(*rq->in);
+
+	ret = z_erofs_fixup_insize(rq, headpage + rq->pageofs_in,
+				min_t(unsigned int, rq->inputsize,
+							rq->sb->s_blocksize - rq->pageofs_in));
+
+	kunmap_local(headpage);
+	if (ret) {
+		return ret;
+	}
+
+	req = acomp_request_alloc(sbi->erofs_tfm);
+	if (!req) {
+		erofs_err(rq->sb, "failed to alloc decompress request");
+		return -ENOMEM;
+	}
+
+	if (sg_alloc_table(&st_src, nrpages_in, GFP_KERNEL)) {
+		acomp_request_free(req);
+		return -ENOMEM;
+	}
+
+	if (sg_alloc_table(&st_dst, nrpages_out, GFP_KERNEL)) {
+		acomp_request_free(req);
+		sg_free_table(&st_src);
+		return -ENOMEM;
+	}
+
+	for_each_sg(st_src.sgl, sg_src, nrpages_in, i) {
+		if (i == 0)
+			sg_set_page(sg_src, rq->in[0],
+					PAGE_SIZE - rq->pageofs_in, rq->pageofs_in);
+		else
+			sg_set_page(sg_src, rq->in[i], PAGE_SIZE, 0);
+	}
+
+	i = 0;
+	for_each_sg(st_dst.sgl, sg_dst, nrpages_out, i) {
+		if (i == 0)
+			sg_set_page(sg_dst, rq->out[0],
+					PAGE_SIZE - rq->pageofs_out, rq->pageofs_out);
+		 else
+			sg_set_page(sg_dst, rq->out[i], PAGE_SIZE, 0);
+	}
+
+	acomp_request_set_params(req, st_src.sgl,
+				st_dst.sgl, rq->inputsize, rq->outputsize);
+
+	crypto_init_wait(&wait);
+	acomp_request_set_callback(req, CRYPTO_TFM_REQ_MAY_BACKLOG,
+						crypto_req_done, &wait);
+
+	ret = crypto_wait_req(crypto_acomp_decompress(req), &wait);
+	if (ret < 0) {
+		if (ret == -EBADMSG && rq->partial_decoding) {
+			ret = 0;
+		} else {
+			erofs_err(rq->sb, "failed to decompress %d in[%u, %u] out[%u]",
+					ret, rq->inputsize, rq->pageofs_in, rq->outputsize);
+			ret = -EIO;
+		}
+	} else {
+		ret = 0;
+	}
+
+	acomp_request_free(req);
+	sg_free_table(&st_src);
+	sg_free_table(&st_dst);
+	return ret;
+}
+
+static int z_erofs_crypto_prepare_dstpages(struct z_erofs_decompress_req *rq,
+							struct page **pagepool)
+{
+	const unsigned int nr =
+				PAGE_ALIGN(rq->pageofs_out + rq->outputsize) >> PAGE_SHIFT;
+	unsigned int i;
+
+	for (i = 0; i < nr; ++i) {
+		struct page *const page = rq->out[i];
+		struct page *victim;
+
+		if (!page) {
+			victim = __erofs_allocpage(pagepool, rq->gfp, true);
+			if (!victim)
+				return -ENOMEM;
+			set_page_private(victim, Z_EROFS_SHORTLIVED_PAGE);
+			rq->out[i] = victim;
+		}
+	}
+	return 0;
+}
+
+static int __z_erofs_deflate_crypto_decompress(struct z_erofs_decompress_req *rq,
+									 struct page **pgpl)
+{
+	const unsigned int nrpages_out =
+			PAGE_ALIGN(rq->pageofs_out + rq->outputsize) >> PAGE_SHIFT;
+	int ret;
+
+	/* one optimized fast path only for non bigpcluster cases yet */
+	if (rq->inputsize <= PAGE_SIZE && nrpages_out == 1 && !rq->inplace_io) {
+		WARN_ON(!*rq->out);
+		goto dstmap_out;
+	}
+
+	ret = z_erofs_crypto_prepare_dstpages(rq, pgpl);
+	if (ret < 0)
+		return ret;
+
+dstmap_out:
+	return z_erofs_crypto_decompress_mem(rq);
+}
+
+static int z_erofs_deflate_decompress(struct z_erofs_decompress_req *rq,
+				struct page **pgpl)
+{
+	struct super_block *sb = rq->sb;
+	struct erofs_sb_info *sbi = EROFS_SB(sb);
+
+	if (sbi->erofs_tfm)
+		return __z_erofs_deflate_crypto_decompress(rq, pgpl);
+	else
+		return __z_erofs_deflate_decompress(rq, pgpl);
+}
+
 const struct z_erofs_decompressor z_erofs_deflate_decomp = {
 	.config = z_erofs_load_deflate_config,
 	.decompress = z_erofs_deflate_decompress,
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 4ac188d5d894..96fcee07d353 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -122,6 +122,7 @@ struct erofs_sb_info {
 	/* pseudo inode to manage cached pages */
 	struct inode *managed_cache;
 
+	struct crypto_acomp *erofs_tfm;
 	struct erofs_sb_lz4_info lz4;
 #endif	/* CONFIG_EROFS_FS_ZIP */
 	struct inode *packed_inode;
diff --git a/fs/erofs/sysfs.c b/fs/erofs/sysfs.c
index dad4e6c6c155..d4630697dafd 100644
--- a/fs/erofs/sysfs.c
+++ b/fs/erofs/sysfs.c
@@ -5,6 +5,7 @@
  */
 #include <linux/sysfs.h>
 #include <linux/kobject.h>
+#include <crypto/acompress.h>
 
 #include "internal.h"
 
@@ -13,6 +14,7 @@ enum {
 	attr_drop_caches,
 	attr_pointer_ui,
 	attr_pointer_bool,
+	attr_comp_crypto,
 };
 
 enum {
@@ -59,12 +61,14 @@ static struct erofs_attr erofs_attr_##_name = {			\
 #ifdef CONFIG_EROFS_FS_ZIP
 EROFS_ATTR_RW_UI(sync_decompress, erofs_mount_opts);
 EROFS_ATTR_FUNC(drop_caches, 0200);
+EROFS_ATTR_FUNC(comp_crypto, 0644);
 #endif
 
 static struct attribute *erofs_attrs[] = {
 #ifdef CONFIG_EROFS_FS_ZIP
 	ATTR_LIST(sync_decompress),
 	ATTR_LIST(drop_caches),
+	ATTR_LIST(comp_crypto),
 #endif
 	NULL,
 };
@@ -128,6 +132,12 @@ static ssize_t erofs_attr_show(struct kobject *kobj,
 		if (!ptr)
 			return 0;
 		return sysfs_emit(buf, "%d\n", *(bool *)ptr);
+	case attr_comp_crypto:
+		if (sbi->erofs_tfm)
+			return sysfs_emit(buf, "%s\n",
+				crypto_comp_alg_common(sbi->erofs_tfm)->base.cra_driver_name);
+		else
+			return sysfs_emit(buf, "NONE\n");
 	}
 	return 0;
 }
@@ -181,6 +191,26 @@ static ssize_t erofs_attr_store(struct kobject *kobj, struct attribute *attr,
 		if (t & 1)
 			invalidate_mapping_pages(MNGD_MAPPING(sbi), 0, -1);
 		return len;
+	case attr_comp_crypto:
+		buf = skip_spaces(buf);
+		if (!strncmp(buf, "none", 4)) {
+			if (sbi->erofs_tfm)
+				crypto_free_acomp(sbi->erofs_tfm);
+			sbi->erofs_tfm = NULL;
+			return len;
+		}
+
+		if (!strncmp(buf, "qat_deflate", 11)) {
+			if (sbi->erofs_tfm)
+				crypto_free_acomp(sbi->erofs_tfm);
+			sbi->erofs_tfm = crypto_alloc_acomp("qat_deflate", 0, 0);
+			if (IS_ERR(sbi->erofs_tfm)) {
+				sbi->erofs_tfm = NULL;
+				return -ENODEV;
+			}
+			return len;
+		}
+		return -EINVAL;
 #endif
 	}
 	return 0;
-- 
2.31.1


