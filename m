Return-Path: <linux-kernel+bounces-840205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F06EBB3D3C
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 13:55:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C41E188E634
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 11:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DA9C30FC3E;
	Thu,  2 Oct 2025 11:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BmLwhNC7"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E5330AD08
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 11:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759406141; cv=none; b=aG/aJZvbqEVL64DoWaK7NgLzKqduBlkwwf0B0SWMfLj2xrvnH/c6eom5RVabpvq4wchcXrPJAo923SFa7MF6rqP+iriMW9B2oqlW0TsH0i2YTLaFq6BWK3a8ycukTTp7cIjmp3FXAMpR+fOXSffgJVBU3t9RMYRqKWA9pskoNcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759406141; c=relaxed/simple;
	bh=TjLNfcpyj8VQq8zPQxWfQv7IU90Q9MWCSFBVuqlbqLU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=vDeLIkvHJUsn911sJarcm2esIVM4aC9AjaH8LHJ//ldu80a+3NXRmXm9EUu6yEx4tsiAdT/jOqddnfWTy0g1hbq1D6AlxYdrx4FeL7I2dENuTOlf48IyFK4N9/Jsxi6BHZ3r9C1WymAaKAVYV5bkcjTx9jX165ZUj2k6Z0VErNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BmLwhNC7; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b5507d3ccd8so706927a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 04:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759406139; x=1760010939; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Wt/5jmDAVyCoiW6KDcDMEjjPV7Rh60NwdAgacjtgDdw=;
        b=BmLwhNC718N+z22PdsqvRN3TowvksWrM8kblxG9Qw0Z/cf8X+QUph5Mw+3jTZj8tF5
         JNAcPur5IdLCRdx4VFLxFAJb8Zj6SXejYpXedhLby0SBPnHqgtEmD3Ng1S7ETDw1554F
         +ITwtuFRzkPh8ZxpeG28vTyDRkCC1IuntpJFdGUc2tQgs3/E6BSVxoihRg5BLC7bEnik
         x/e11OgdMG9eOQvkDo33H0Sbv2NiPF2shITPaSAyVBl2XxeaakR1uVnmCaxZdMxxHw60
         u9M8BeRW30jVOaF7F7jmSHeSf/KEnsxvi/HuywxkPurXpVj8ZK0dgpaZVLOeBd9mgbt1
         Meig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759406139; x=1760010939;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wt/5jmDAVyCoiW6KDcDMEjjPV7Rh60NwdAgacjtgDdw=;
        b=XL2wo7s1TirdwPEtcntfe18TZon28uEWCxA61cIftTXKArswW6uAmtRmNErmcoKDPX
         QzMPSOOqcV2sHdT166YYlQ774pASDJduPPYq8B1MTMtyZTpURb7bCkJNRSLboDj226D0
         Wc6/M3j5rLp4Cds1YzXEAZ/wa0Z6pc4F1uJXaam2DfDE1+TRsqMwuY7ZA55ozKoaLuwE
         9ybJ9S2TvQhMnChDB5yiL2otRyK+ZsM8ZzbHum2GyhJR7JbClqJN6xGSb68gYKJZWQG0
         8Z5YxnZjCnFsUoZnmtHiOCTub+TsFcX8p/781tlfLbAbbilsfh1+4AjW1u2I+Ij3cpYF
         F66Q==
X-Forwarded-Encrypted: i=1; AJvYcCVhnJHWP1wR14RE/Uv32udn0w8w50DcZnw6Ii8JAscIqBoMZHKfGDsBJultPWOR7Foqz2+Mfpnu587UDjo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHDzpgFsoy8MDR8xlCRQWTBK2Qpd4KeT7ED4iZZHOFZJ5ladlP
	4OlzDsy6UJm6QuANgzwTkIcn/4ek4ptVBRzHh9ryNTvYqWr6uOk9H3/H
X-Gm-Gg: ASbGnctznoPpp9gHU1rR+sF2WV0k/+S4d9IRkEgcUCylAwyI3tQVHmxqgV9ehGEkpmh
	PAEFu2BSTEAJTu2DaT40OMKgqucf0/6OCpr75ne5KMI3IWMRI9v7WKXhd3CeoUsP2Yz1Ci4IoVX
	+JLOPH6fr2hWwZDELprMIANXinycKr5+tBlTHHidGaAGTVYmn9Q5KpWJzymM3Sby9sF95Dcz13V
	x8Ua4jReFrVdr/nd6pkGI2eJ5R28VxVCepHhZ/WpkuOKnsHT1vqHhpZHs2ByunfaFvhVSjfn803
	Ut50nlsQDKJjDTeur06CHkwoH2ZrOz0Q4G4qCszWAdLTCaKMNqgQbsH3VXjmRxiGxNQDz563Bpw
	hBoEy6ojR6z0JxHSI4L+WpZSGCUMiz5XqjrjW4I3CI3UMMnxgyJMy4nrhso5ausibt4xOWl8SJj
	vWMzNX90ga
X-Google-Smtp-Source: AGHT+IEXDQv5WzWFvUN7TK5i6ZwaXNev1K2Rc7O8ISKUuj2oex0jxGVKtUV/MHSCJ8NvEldO1g3n/A==
X-Received: by 2002:a17:903:1a0d:b0:28e:7ea4:2023 with SMTP id d9443c01a7336-28e7f441e8cmr81339725ad.46.1759406139161;
        Thu, 02 Oct 2025 04:55:39 -0700 (PDT)
Received: from fedora ([45.116.149.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d1d31c8sm20527535ad.95.2025.10.02.04.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 04:55:38 -0700 (PDT)
From: rtapadia730@gmail.com
To: dsterba@suse.com,
	clm@fb.com,
	fdmanana@suse.com
Cc: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	khalid@kernel.org,
	david.hunter.linux@gmail.com,
	Rajeev Tapadia <rtapadia730@gmail.com>
Subject: [PATCH] btrfs: push memalloc_nofs_save/restore() out of alloc_bitmap()
Date: Thu,  2 Oct 2025 17:24:28 +0530
Message-ID: <20251002115427.98773-2-rtapadia730@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rajeev Tapadia <rtapadia730@gmail.com>

alloc_bitmap() currently wraps its allocation in memalloc_nofs_save
/restore(), but this hides allocation context from callers. GFP_NOFS is
required to avoid recursion into the filesystem during transaction commits,
but the correct place to enforce that is at the call sites where we know
recursion is unsafe.

So now alloc_bitmap() just allocates a bitmap. Also completing the TODO
comment.

Signed-off-by: Rajeev Tapadia <rtapadia730@gmail.com>
---

The patch was tested by enabling CONFIG_BTRFS_FS_RUN_SANITY_TESTS
All tests passed while booting the kernel in qemu.

 fs/btrfs/free-space-tree.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/free-space-tree.c b/fs/btrfs/free-space-tree.c
index dad0b492a663..abdbdc74edf8 100644
--- a/fs/btrfs/free-space-tree.c
+++ b/fs/btrfs/free-space-tree.c
@@ -159,8 +159,6 @@ static inline u32 free_space_bitmap_size(const struct btrfs_fs_info *fs_info,
 
 static unsigned long *alloc_bitmap(u32 bitmap_size)
 {
-	unsigned long *ret;
-	unsigned int nofs_flag;
 	u32 bitmap_rounded_size = round_up(bitmap_size, sizeof(unsigned long));
 
 	/*
@@ -168,13 +166,11 @@ static unsigned long *alloc_bitmap(u32 bitmap_size)
 	 * into the filesystem as the free space bitmap can be modified in the
 	 * critical section of a transaction commit.
 	 *
-	 * TODO: push the memalloc_nofs_{save,restore}() to the caller where we
-	 * know that recursion is unsafe.
+	 * This function's caller is responsible for setting the appropriate
+	 * allocation context (e.g., using memalloc_nofs_save/restore())
+	 * to prevent recursion.
 	 */
-	nofs_flag = memalloc_nofs_save();
-	ret = kvzalloc(bitmap_rounded_size, GFP_KERNEL);
-	memalloc_nofs_restore(nofs_flag);
-	return ret;
+	return kvzalloc(bitmap_rounded_size, GFP_KERNEL);
 }
 
 static void le_bitmap_set(unsigned long *map, unsigned int start, int len)
@@ -217,7 +213,9 @@ int btrfs_convert_free_space_to_bitmaps(struct btrfs_trans_handle *trans,
 	int ret;
 
 	bitmap_size = free_space_bitmap_size(fs_info, block_group->length);
+	unsigned int nofs_flag = memalloc_nofs_save();
 	bitmap = alloc_bitmap(bitmap_size);
+	memalloc_nofs_restore(nofs_flag);
 	if (unlikely(!bitmap)) {
 		ret = -ENOMEM;
 		btrfs_abort_transaction(trans, ret);
@@ -360,7 +358,9 @@ int btrfs_convert_free_space_to_extents(struct btrfs_trans_handle *trans,
 	int ret;
 
 	bitmap_size = free_space_bitmap_size(fs_info, block_group->length);
+	unsigned int nofs_flag = memalloc_nofs_save();
 	bitmap = alloc_bitmap(bitmap_size);
+	memalloc_nofs_restore(nofs_flag);
 	if (unlikely(!bitmap)) {
 		ret = -ENOMEM;
 		btrfs_abort_transaction(trans, ret);
-- 
2.51.0


