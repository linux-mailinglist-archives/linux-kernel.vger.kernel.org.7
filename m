Return-Path: <linux-kernel+bounces-885108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E9FB4C3203B
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 17:20:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E85E04F152B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 16:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D22F32ED57;
	Tue,  4 Nov 2025 16:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MyA1pAx8"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645632561AA
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 16:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762273171; cv=none; b=RVCMcqYq808rt2Ij0TNdoUMLlNsO+FF1PNjJkcJL+NxnAiAkuadmzAWrCnqBepjiX86Grs3kKHlUnc+6+BvQ4HiwkWe7xhVzY6NXth0H4/BV6tuSOUzF1UPws5LEBMNUZZMJFb0p9iJq7bNyKcmoG3EZEBblCd1qQiIv9Wv4o2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762273171; c=relaxed/simple;
	bh=GeZ3Yx2Nustph9F7+u4asv383OMD1Ha7urNnR+GXemk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UBynOm6VK65wUi/ggd7hXhMfaVOtxC77ftrxaevLed3uTd3+stt7j1js11oKsIvJE7d11JE9L1qjZLY6S+3NhpaciJ3eCNnP9RZ32VLdaA14VPwCbzfT5YT/vPXqtVBWzjUsGR48WpuPaSlwSPl/nZXsCUK5i38ZBKJlH/RQT0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MyA1pAx8; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-340cccf6956so2150939a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 08:19:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762273170; x=1762877970; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xTY5WyoBsQN2JxFiFnbwp1fuuZHU0Trrum8pR4htY6M=;
        b=MyA1pAx8WGjwP3Y18RZgGNS+An/RudsmnLw/mkaLorJh6qqX0b8GSvuaLdF0H+FsOP
         7jtM/3VRTXwLoEPFRtYTptPZVFDsiq6ewC8I45ECeCD1R7sNGiLDwJtjNPguXx/SRQK2
         p58QE3i/xdZ47vS8MKOb335wyRCIKjwv63gwpubndpPc4LECe5UwtWY8TfBT3c/kL8yD
         vjb3je0snmmLl3YJWUHaLJWZHW8sWlaplJPZORv/ZzlXKH9tvdf65u0sbrevhGXYgC8Y
         WBIbPDq1Ic2PD38Q7AsV2bdii0Jyio4I46Qq90BPJ2yjypRVHrynH51aCp1me0zcwirp
         Fjuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762273170; x=1762877970;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xTY5WyoBsQN2JxFiFnbwp1fuuZHU0Trrum8pR4htY6M=;
        b=ocWMb50B9Rda+kaZgDm9AoS9CjP58MfN3Qt/cOFVF+7GVj4ll5BQtxaK4lzJJvowUs
         xoJV8G3sUOxCKA6wKa31Q4NLg36txIbeKJczCsyqcDaqhj4EoYtDEviwUQKjqs1kYUuF
         f5hZO+JpM+dkK9iRulULKeBkqNMFvVMFQMgG3G1UKhikHywTvdbNNvmaAaifcgcZqrjR
         D+FfT3fv7J0H/2ex0Usoawh0FwOXdrih5nc51pcZBRjSW2g3C4PByeRn7YPponkm9AEg
         1msl1bGrPCg1ncg3AyfKlr60Ev3snkxPG1qiy5qJ3TfRikDGkOmtR1yCp9jyzXaoZFPb
         lWqA==
X-Forwarded-Encrypted: i=1; AJvYcCXUIhx0HIjpD7YqNJX10b34B3Hbxb5ibNyBCDdBdff+3VbXYcrF67o9RwZbdMsJq5krX33Qe+SQ7IanSTQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzitG8DpXRLH9OZyerPZCuW+VxWNGPBWeARDhZAM30/a93nvJuM
	wQP7n1R6owPG3jw2xJuBETRCNdJ2dnl1sXCbKOLIG54rEmSjxGUmWJMv7G/hixGf
X-Gm-Gg: ASbGncu2hqe7lpS7F+GQfRfWayLKm3uH/N0olcicTKGROKYPg7V+pAy3EP4S9NEvhud
	stQDCHk/MQV6JgG6EEtj7gaJJfryAJdhpNwfepy3M1M4w7ds6xah3U0N369uwK1QaV0Dr3OluCF
	43WFmz7IE4umKxIovc9SzkkPl0uJi5VYCXLKWIzPOkFTCabjY1fDSZgjVjl8XIt4E8e7Dk1ThhK
	MVZ2tggW+IKnhTg2QGwcgluXRFmOtUEHHs1yzYLKb1sE8D5jBu9sWv2fXGfizMsrBe9l33v51+T
	xHTfhUJdo4vdOMOQbaGnZtNlFnkjQegKiGSOH6KomtDj1/w7xHetH8nei+dnmJZ0uDnum7ih058
	R+T5uwUphacTopjiOAg9/Z2xwezT1OAE2MWyTlSN3aDE3qp3adXvRIoVK55sGl7ur4N7m71utAt
	k=
X-Google-Smtp-Source: AGHT+IEOdukJj9iAE0dM5GhVY3oVQCgeXAqTQ5UrcJb6jylIu6zhZdGwFEjdzwklrdczbajwQ4pahg==
X-Received: by 2002:a17:90b:35cc:b0:340:c261:f9f3 with SMTP id 98e67ed59e1d1-340c261fc91mr15182354a91.14.1762273169550;
        Tue, 04 Nov 2025 08:19:29 -0800 (PST)
Received: from fedora ([110.224.245.171])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3415c7a21a3sm5027696a91.17.2025.11.04.08.19.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 08:19:28 -0800 (PST)
From: Shi Hao <i.shihao.999@gmail.com>
To: almaz.alexandrovich@paragon-software.com
Cc: ntfs3@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	i.shihao.999@gmail.com
Subject: [PATCH] fs: ntfs3: remove redundant kmap() calls
Date: Tue,  4 Nov 2025 21:49:13 +0530
Message-ID: <20251104161913.20256-1-i.shihao.999@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove unnecessary kmap() mapping calls which serve
no functional purpose because their return values are
immediately discarded right after the calls and also
vmap() calls has been used right after these kmap()
functions which is another contiguous memory mapping
function too.

Signed-off-by: Shi Hao <i.shihao.999@gmail.com>
---
 fs/ntfs3/frecord.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index 8f9fe1d7a690..372673bf803f 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -2407,8 +2407,6 @@ int ni_read_frame(struct ntfs_inode *ni, u64 frame_vbo, struct page **pages,
 	 * To simplify decompress algorithm do vmap for source
 	 * and target pages.
 	 */
-	for (i = 0; i < pages_per_frame; i++)
-		kmap(pages[i]);

 	frame_size = pages_per_frame << PAGE_SHIFT;
 	frame_mem = vmap(pages, pages_per_frame, VM_MAP, PAGE_KERNEL);
@@ -2657,7 +2655,6 @@ int ni_read_frame(struct ntfs_inode *ni, u64 frame_vbo, struct page **pages,
 out:
 	for (i = 0; i < pages_per_frame; i++) {
 		pg = pages[i];
-		kunmap(pg);
 		SetPageUptodate(pg);
 	}

@@ -2735,7 +2732,6 @@ int ni_write_frame(struct ntfs_inode *ni, struct page **pages,
 		}
 		pages_disk[i] = pg;
 		lock_page(pg);
-		kmap(pg);
 	}

 	/* To simplify compress algorithm do vmap for source and target pages. */
@@ -2745,9 +2741,6 @@ int ni_write_frame(struct ntfs_inode *ni, struct page **pages,
 		goto out1;
 	}

-	for (i = 0; i < pages_per_frame; i++)
-		kmap(pages[i]);
-
 	/* Map in-memory frame for read-only. */
 	frame_mem = vmap(pages, pages_per_frame, VM_MAP, PAGE_KERNEL_RO);
 	if (!frame_mem) {
@@ -2815,15 +2808,11 @@ int ni_write_frame(struct ntfs_inode *ni, struct page **pages,
 	vunmap(frame_mem);

 out2:
-	for (i = 0; i < pages_per_frame; i++)
-		kunmap(pages[i]);
-
 	vunmap(frame_ondisk);
 out1:
 	for (i = 0; i < pages_per_frame; i++) {
 		pg = pages_disk[i];
 		if (pg) {
-			kunmap(pg);
 			unlock_page(pg);
 			put_page(pg);
 		}
--
2.51.0


