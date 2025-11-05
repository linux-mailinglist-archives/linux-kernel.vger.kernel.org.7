Return-Path: <linux-kernel+bounces-887363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CBE7C37FE5
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 22:25:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BF9574F178C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 21:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3000834CFBB;
	Wed,  5 Nov 2025 21:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VKu0yIcn"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB4F34A797
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 21:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762377529; cv=none; b=ZyZyyAgRAeulMUBQCY1/AbU+ehJy1H6dO/PCStpByScBFCbG/PzGRP3KNe77XNNs2iOPraGjVMrcnQa19yPanol5h9+NjkjzW8pKKmoFRCeitCh7Ix+x2p7nS58uDKnZ6m79BwkrUlF15fkYsXoqXVWQS4Ob1J4Nlb5fnoi2iHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762377529; c=relaxed/simple;
	bh=oPQYRyMF1pypwbrV2bfRFWBdMbkQqKT1Ffj4kqPzSb8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XlkhTdTquu16T4079ASqMihaM42l1xp6ab0uTubTdx5L3p+yJka7HNtjazQe3/yRVrwI44LIauTOMasYeVwXPLlwDRf5kpqngEZejwB1HlCFuMh74wmEYmHsTflTIyEmJ8dZdnEIsGRkwGrCEqHJCUCZsfb4kAbErjsi/sbe2Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VKu0yIcn; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-640e9f5951aso2297217a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 13:18:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762377526; x=1762982326; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DF0sydupouCelQ7a8hDVtjvfRn0GwCGA2yXi7RlWEjc=;
        b=VKu0yIcnrSC7Mjbvvjwj5n9EAQb4kgrRdztf/hlY5NLO/IrMfmRDPIxoCY7aD5x0w2
         G9zeFdqrV1MeLQeo8VMJDl9u27Rlt8qckREdf3sPNMUUmxaj6edp4Rd9JxOGMJnlzZk/
         lLm80g9EY29C594NXeG4gg/xKmI4c/Y7HIPxDI45VAuzR9V8W4TIKrIgtSO5AoetNcB/
         T5t0FaNJtIiX3AIxUsa7vYIFDrVKmeu6uXWRMzTf+7Ll+d8knzbi6UYLWVP6gTKj6I9N
         kLEBoF6ZBbo2Uskic0bmjqT76T836jEgtZYUEkiKYENt7UadmbAd/h9gcuWGTTe5QdIu
         66hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762377526; x=1762982326;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DF0sydupouCelQ7a8hDVtjvfRn0GwCGA2yXi7RlWEjc=;
        b=wHa6ofUZydwL59Nqobon/Tm/0bBCMYwZxwA9eDYwfvGaigMTzNxmYA2tdhfx2PjDSC
         98USREgLrfkbRN/pLBkUE84yC5Gm4fqrvXYiegbejQ2o92ktBuR0XjxX/3EVuANAet/S
         fT3kbdCBa+H7XgS3rtWn+8FV5wsj7Gdtj5XXPpyfyNTaChNxgGqD1aiNWbvzcQd2fFmN
         uXlU6McnzqWnsyqgr0vsoEnWit2n4+08OjGzIUPFSIXXK560yZmIb34xAOYG+QGOIMvL
         +zkcN4RUVNzrZBmU0MBkEFKSEAHGITP1IFFm8ZaangvnbdxhDZurAb31j8OQcYOqT3qW
         F2KQ==
X-Forwarded-Encrypted: i=1; AJvYcCWPry5CGz/3W2iWduKC+2YyKrUOWxLBEKsW3MglJmsskYvvzuXFyAvWAcuIx1pu8ueBLrJcDLplILfyiRw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsqiBR4AUfSI0uaVF5WK/FW8E4HoZp1KAsnQiZDdIaGQpNL5ic
	EV/aeplkAi7ZPE7FT0VrZKKzJdTQJmdOz5FVC5UF0+KzeysPT4GxEILN
X-Gm-Gg: ASbGncu1vCIWNSYf6utDwlvInrGiq4AAQ4DXhJb1B/vP57aoXT+g/PzKOyFT78Tm5Wp
	EHZTjNzKvZtKmQC71OaCGhZLKuSmBG7493zBbrPmNK1CEkyknhkkD5W6I5S/GQW4hgTZCZIaDAr
	SF6P5FRLfrdAtsgIjIapEMEGSbL/5fvuyXLWaFzeFfqax4Xzr/FjmCj243UhJLiQYyArUmz1MTZ
	hvHgIsWylighuCj4798Sm/NG0eGNNfvJJChqYMANzRAMZh00ddPjK+vFDnPmbX11S8HGk67AjZq
	nkcbU+PqvRlwxxgHLHdd0Ua2vGk+G5mD3h0YMPLOuxzYG/3hBqyyknn024kymb2CU6l8ttXpa8z
	cg0c8UGRjRNFikLA2Mf9cdWFFLUbLgLD6hZ0oBXCyx2GGN6kcusj59bQLypCgFInrUgj5nUyg8u
	AZstrsDJo1iir2dfyNcf5Sp5knVhvNfu7f2GTTBi92tzVAj52pr3e/CAlCFFSBiWyRRzdkxVIEd
	7TVmTlCcwQVo2bDCal1LUhwTY2NzU4=
X-Google-Smtp-Source: AGHT+IGiz9VN3EwGclfE2mM2roTXLFXItqHPPpfh2E0/oV854mv2wjZ6x4OeB6U7GyRrVN+rgMV2Yg==
X-Received: by 2002:a17:907:2d94:b0:b70:b161:b9a8 with SMTP id a640c23a62f3a-b72892ac5acmr90989366b.2.1762377525586;
        Wed, 05 Nov 2025 13:18:45 -0800 (PST)
Received: from localhost.localdomain (host194.safe-lock.net. [195.20.212.194])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b728964480esm52226166b.38.2025.11.05.13.18.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 13:18:44 -0800 (PST)
From: Bartlomiej Kubik <kubik.bartlomiej@gmail.com>
To: almaz.alexandrovich@paragon-software.com
Cc: ntfs3@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	david.hunter.linux@gmail.com,
	skhan@linuxfoundation.org,
	khalid@kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	Bartlomiej Kubik <kubik.bartlomiej@gmail.com>,
	syzbot+332bd4e9d148f11a87dc@syzkaller.appspotmail.com,
	syzbot+0399100e525dd9696764@syzkaller.appspotmail.com
Subject: [PATCH linux-next] fs/ntfs3: Initialize allocated memory before use
Date: Wed,  5 Nov 2025 22:18:08 +0100
Message-Id: <20251105211808.260893-1-kubik.bartlomiej@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

KMSAN reports: Multiple uninitialized values detected:

- KMSAN: uninit-value in ntfs_read_hdr (3)
- KMSAN: uninit-value in bcmp (3)

Memory is allocated by __getname(), which is a wrapper for
kmem_cache_alloc(). This memory is used before being properly
cleared. Change kmem_cache_alloc() to kmem_cache_zalloc() to
properly allocate and clear memory before use.

Fixes: 82cae269cfa9 ("fs/ntfs3: Add initialization of super block")
Fixes: 78ab59fee07f ("fs/ntfs3: Rework file operations")
Tested-by: syzbot+332bd4e9d148f11a87dc@syzkaller.appspotmail.com
Reported-by: syzbot+332bd4e9d148f11a87dc@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=332bd4e9d148f11a87dc

Fixes: 82cae269cfa9 ("fs/ntfs3: Add initialization of super block")
Fixes: 78ab59fee07f ("fs/ntfs3: Rework file operations")
Tested-by: syzbot+0399100e525dd9696764@syzkaller.appspotmail.com
Reported-by: syzbot+0399100e525dd9696764@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=0399100e525dd9696764

Signed-off-by: Bartlomiej Kubik <kubik.bartlomiej@gmail.com>
---
 fs/ntfs3/inode.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index ab61388f819c..13720baf079d 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -1281,7 +1281,7 @@ int ntfs_create_inode(struct mnt_idmap *idmap, struct inode *dir,
 		fa |= FILE_ATTRIBUTE_READONLY;

 	/* Allocate PATH_MAX bytes. */
-	new_de = __getname();
+	new_de = kmem_cache_zalloc(names_cachep, GFP_KERNEL);
 	if (!new_de) {
 		err = -ENOMEM;
 		goto out1;
@@ -1723,10 +1723,9 @@ int ntfs_link_inode(struct inode *inode, struct dentry *dentry)
 	struct NTFS_DE *de;

 	/* Allocate PATH_MAX bytes. */
-	de = __getname();
+	de = kmem_cache_zalloc(names_cachep, GFP_KERNEL);
 	if (!de)
 		return -ENOMEM;
-	memset(de, 0, PATH_MAX);

 	/* Mark rw ntfs as dirty. It will be cleared at umount. */
 	ntfs_set_state(sbi, NTFS_DIRTY_DIRTY);
@@ -1762,7 +1761,7 @@ int ntfs_unlink_inode(struct inode *dir, const struct dentry *dentry)
 		return -EINVAL;

 	/* Allocate PATH_MAX bytes. */
-	de = __getname();
+	de = kmem_cache_zalloc(names_cachep, GFP_KERNEL);
 	if (!de)
 		return -ENOMEM;

--
2.39.5


