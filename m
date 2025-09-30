Return-Path: <linux-kernel+bounces-837418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B4A7BAC46C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 11:30:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35774480CF9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 09:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 631E42F362F;
	Tue, 30 Sep 2025 09:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="OGAlANiV"
Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9CF2BD5A7
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 09:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759224598; cv=none; b=AVZOdI3pdaX/C1lKJ4EzGMmbMOjOpHwRSlF8Pp3zAkd7Chs9VBCOOUKsnJhmmR2xnAZzbUIdn4MDmAyECUA6dkRCzptiwHIlmOWfOXBURYHisbu85cVrBE0XRumJZ56Kw9ATBGFJiY6Lb2GPAjk+P0iHwawCx2iIcKlHxFJOq64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759224598; c=relaxed/simple;
	bh=4MLz/dRramsBGJje5kXGZ+Y/Qgz00KE2p8K/KWcaM7U=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=YDkvXUcSjLxVZn/u8fKBryn+xieZWQsJECjnBqEpoNQnOOT6VGZ1stAQofV7icvJWxnzsehs5aAY/XUgM9SgMUdDfOzm6ZivQh9LupMjr02jXHaqMz5GFFpAZ/8EXq9tOI5RVogM8O5uQYqD09VM9WlNxmjw4vsqXktjtdSDNW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=OGAlANiV; arc=none smtp.client-ip=162.62.57.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1759224589; bh=sjKOMSUKFceEsi2HVyF69WgmsGT8yilr2nItsl+yc10=;
	h=From:To:Cc:Subject:Date;
	b=OGAlANiV7lLv8EZxaSvedbYCp30eczGVH6q8U32Iqy3UWRx7LpdGnbs7m6rxrQzL/
	 GaQeevvKwjbt35cdFmr5iGGwbKvbe07MXT48/WvVY2ImyCLrR/yr/NodJCe2jiQkH8
	 R6R3fhBrlDfrvxG8HvozLlTB4VtPk+sQQ/F/XmtI=
Received: from localhost.localdomain ([116.128.244.171])
	by newxmesmtplogicsvrsza29-0.qq.com (NewEsmtp) with SMTP
	id 4191B498; Tue, 30 Sep 2025 17:16:25 +0800
X-QQ-mid: xmsmtpt1759223785thn26fkks
Message-ID: <tencent_3FA2C956B557ED4D050EB26922B50D3CF40A@qq.com>
X-QQ-XMAILINFO: OKZmdVNIw/gXA5s3qo7J1+t0PGITjuC65oo1emaYhlWFT/KnKh9Lz5G4FR6smF
	 GUz+lqBcgG9ItF2hL0vkpTbd53/GEGR/k/9IU5G3R28rqwRW99fNeaDlSl46mydd2KGLE7uPOoM7
	 lbGlyPa3NLWbs739E9QugkMnMgYBYMNRdBNLSb10e6egsqtFcOhU+46lu8JzEMCJ3QWagzhqJFm4
	 oc0PYY9z2SyCo2970aoOV5JBl2O8tk2RR61X1U3Sy8DOxb7InqKubmjtTHwz8TIbHGbkt/xo1p+P
	 dpwQZJrSQc/lFduLKLOpCLSw5FGLtH6Oc/EWebcAczSlT+wBD01LvY7J7j01hppO+BGAJH0fqKpf
	 Z1960ni2xMPftIabtPsnvdY8k+BE2uPxYknGWi68CkRF5ZSiJh8zmZjVgyjNarLQ71AK60pXrDfg
	 7DorJm6jdfLQANOVDEL1KyVs1u992S6sI9CwJmXZTVNhTnVtXObQ6kzl4Dh14rOkRZZdbjKgO2kz
	 GqrTNj3F2cE0DVwH1CkVUUnWgo2fak7kixz5JeNCfVpa6md9tR65SsnS3o6vWizSke2OTEna5F5E
	 TJ40AySI6oVxgvxpziGgPPspJrKl8njkGgGcLFKGSphYsUmZZ+PwpW7s8PjyfgW7c1P6Vqpg1F19
	 8MewWVqq2GRmbxpTtRKnTqnjxKT3SPz17tf+raKtfLuaL4V9ssbEwRQY9OjWDQpKUlivy6Xdn2a4
	 1jA2gg420V3P1yw2GU5rRq8N49GBpmdUpSMltZL3LKzZbvzgFWZ6O0HfrHFCx8SrilOTLyojsiLG
	 FwXfvbDx5/yxj6GL/IdjL6H3T2MBfcd6ZsQ68KXcjehKQoRUIgI8ak3ScRIb8tUuF727dNjD+D3Z
	 p46IjBK36mkvj7jDVAjFYyYrelJNjXtFGPkvhYe4gTviGkKoewsfHvu+v6uBI2QWTlFelUbjckXo
	 bDSS/kl84YzpPRqwndojbqqCAeACaW7fikKSybBMrTFgVj0r0TItZRv1rDip3AKyR86b+lqTlTy/
	 OWS3sRHRwb71mvdLbmBQVWMO3PrJE8BF5W+6SWkFGTwUqf6hVLAMA//8H0oyEs+QkhjV6suhu/kv
	 MnY84b
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
From: Haofeng Li <920484857@qq.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Haofeng Li <13266079573@163.com>,
	Haofeng Li <lihaofeng@kylinos.cn>
Subject: [PATCH] f2fs: fix ifolio memory leak in f2fs_move_inline_dirents error path
Date: Tue, 30 Sep 2025 17:16:21 +0800
X-OQ-MSGID: <20250930091621.4006285-1-920484857@qq.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Haofeng Li <lihaofeng@kylinos.cn>

Fixes a memory leak issue in f2fs_move_inline_dirents() where
the ifolio is not properly released in certain error paths.

Problem Analysis:
- In f2fs_try_convert_inline_dir(), ifolio is acquired via f2fs_get_inode_folio()
- When do_convert_inline_dir() fails, the caller expects ifolio to be released
- However, in f2fs_move_inline_dirents(), two specific error paths don't release ifolio

Fixes: 201a05be9628a ("f2fs: add key function to handle inline dir")
Signed-off-by: Haofeng Li <lihaofeng@kylinos.cn>
---
 fs/f2fs/inline.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index 58ac831ef704..2496866fc45d 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -425,7 +425,7 @@ static int f2fs_move_inline_dirents(struct inode *dir, struct folio *ifolio,
 	set_new_dnode(&dn, dir, ifolio, NULL, 0);
 	err = f2fs_reserve_block(&dn, 0);
 	if (err)
-		goto out;
+		goto out_put_ifolio;
 
 	if (unlikely(dn.data_blkaddr != NEW_ADDR)) {
 		f2fs_put_dnode(&dn);
@@ -434,7 +434,7 @@ static int f2fs_move_inline_dirents(struct inode *dir, struct folio *ifolio,
 			  __func__, dir->i_ino, dn.data_blkaddr);
 		f2fs_handle_error(F2FS_F_SB(folio), ERROR_INVALID_BLKADDR);
 		err = -EFSCORRUPTED;
-		goto out;
+		goto out_put_ifolio;
 	}
 
 	f2fs_folio_wait_writeback(folio, DATA, true, true);
@@ -479,6 +479,10 @@ static int f2fs_move_inline_dirents(struct inode *dir, struct folio *ifolio,
 out:
 	f2fs_folio_put(folio, true);
 	return err;
+
+out_put_ifolio:
+	f2fs_folio_put(ifolio, true);
+	goto out;
 }
 
 static int f2fs_add_inline_entries(struct inode *dir, void *inline_dentry)
-- 
2.25.1


