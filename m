Return-Path: <linux-kernel+bounces-773203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 854C2B29C9D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 10:47:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8D987B2B4E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 08:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74E6530496C;
	Mon, 18 Aug 2025 08:47:19 +0000 (UTC)
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 750D330147C
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 08:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=183.62.165.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755506839; cv=none; b=HCuVistftY0fW0BxuANJbK4sABm1N2dYLAkXfCgINSHdvs8UByTGfpIGcL0hlCCmFCESTatmuNoJFWyt/nOVf6qT6OzF6r0b4J0w76eiyjb2iVuXxmmvQX32e8n5H1ISKEHr5qNEU1eLT0VBn2uazG0I2VkynjMjYifeDDKJ95c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755506839; c=relaxed/simple;
	bh=T0W/KL+FKoe/ZlpG/YyuJoSaUZIvL7vmNReGARj4bAs=;
	h=Date:Message-ID:Mime-Version:From:To:Cc:Subject:Content-Type; b=LCtzQOhxgz5AAyKMzOANDe0ZiBw3BqzqbZxOdmFRv2ioHs3Xt5O5RDfD+exEtfOM1VG64QwlRbKXPm62zlCvatpIcR5yYtYrgmtELj63kDSsq6RlYZjYYZd7saGqYu81dhs0cGbAYOHFHNFtrYOSRDyyHCs6GESNV+gOUsl44is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=183.62.165.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4c55tb2WNYz5B13h;
	Mon, 18 Aug 2025 16:47:03 +0800 (CST)
Received: from xaxapp04.zte.com.cn ([10.99.98.157])
	by mse-fl1.zte.com.cn with SMTP id 57I8kXYv051001;
	Mon, 18 Aug 2025 16:46:33 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp02[null])
	by mapi (Zmail) with MAPI id mid32;
	Mon, 18 Aug 2025 16:46:35 +0800 (CST)
Date: Mon, 18 Aug 2025 16:46:35 +0800 (CST)
X-Zmail-TransId: 2afa68a2e86b157-0e1c1
X-Mailer: Zmail v1.0
Message-ID: <20250818164635573BQolnx5DcBqRicqxF0DMl@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <shao.mingyin@zte.com.cn>
To: <chengzhihao1@huawei.com>
Cc: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <yang.yang29@zte.com.cn>, <xu.xin16@zte.com.cn>,
        <yang.tao172@zte.com.cn>, <richard@nod.at>
Subject: =?UTF-8?B?W1BBVENIXSB1YmlmczogYWRkcmVzcyBiaXQgZmxpcHMgaW4gdW51c2VkIGZyZWUgc3BhY2U=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 57I8kXYv051001
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.132 unknown Mon, 18 Aug 2025 16:47:03 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 68A2E887.000/4c55tb2WNYz5B13h

From: Shao Mingyin <shao.mingyin@zte.com.cn>

When the recovery detects a free space bit flip, the UBIFS mount fails,
rendering the UBIFS unusable. This issue can be addressed by reclaiming
the affected erase block, which involves relocating its valid data. So
attempting to fix free space bit flip during recovery reduces scenarios
where users cannot access UBIFS normally.

Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
Signed-off-by: yang tao <yang.tao172@zte.com.cn>
---
 fs/ubifs/recovery.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/fs/ubifs/recovery.c b/fs/ubifs/recovery.c
index f0d51dd21c9e..cebf4098557c 100644
--- a/fs/ubifs/recovery.c
+++ b/fs/ubifs/recovery.c
@@ -77,6 +77,25 @@ static int first_non_ff(void *buf, int len)
 	return -1;
 }

+static int ubifs_buf_bitflip_count(void *buf, int len)
+{
+	uint8_t tmp, shift;
+	uint8_t *p = buf;
+	int i, count = 0;
+
+	for (i = 0; i < len; i++) {
+		tmp = *p++;
+		if (tmp != 0xff) {
+			shift = (uint8_t)0;
+			while (shift <= 7)
+				if (!(tmp & (uint8_t)(1 << shift++)))
+					count++;
+		}
+	}
+
+	return count;
+}
+
 /**
  * get_master_node - get the last valid master node allowing for corruption.
  * @c: UBIFS file-system description object
@@ -690,6 +709,12 @@ struct ubifs_scan_leb *ubifs_recover_leb(struct ubifs_info *c, int lnum,
 			 * See header comment for this file for more
 			 * explanations about the reasons we have this check.
 			 */
+			int bitflip_count = ubifs_buf_bitflip_count(buf, len);
+
+			ubifs_assert(c, bitflip_count > 0);
+			ubifs_msg(c, "corrupt empty space LEB %d:%d, corruption starts at %d, bitflip count %d, try to rescure",
+					lnum, offs, corruption, bitflip_count);
+			goto rescure;
 			ubifs_err(c, "corrupt empty space LEB %d:%d, corruption starts at %d",
 				  lnum, offs, corruption);
 			/* Make sure we dump interesting non-0xFF data */
@@ -766,6 +790,7 @@ struct ubifs_scan_leb *ubifs_recover_leb(struct ubifs_info *c, int lnum,
 	len = c->leb_size - offs;

 	clean_buf(c, &buf, lnum, &offs, &len);
+rescure:
 	ubifs_end_scan(c, sleb, lnum, offs);

 	err = fix_unclean_leb(c, sleb, start);
-- 
2.25.1

