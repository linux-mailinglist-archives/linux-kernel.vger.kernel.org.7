Return-Path: <linux-kernel+bounces-843913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CBD15BC08F2
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 10:11:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3858C3BBBCD
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 08:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E8E4256C8B;
	Tue,  7 Oct 2025 08:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KoP10Ygz"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638D6253F1A
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 08:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759824663; cv=none; b=rz9dfz8pBU6gKRIVWkguLkyoWP77XeeEgevkdvFyrriJYOJRyofsmNCJ7QPQezVwZMoumMgkyYQrjKxHaVvDbFSrcqWySL8IuuqgsxOkhvS+f7QFzsxZj60ra3TA6ZfrNlNzaiNfTUK/1i4cAY5nFWXDMNu9unGH0tO9biQrxIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759824663; c=relaxed/simple;
	bh=Ou9RbX5uqxCtGtynVkAROokYxmIljor33wkMogIURhI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n0LvutqpXZiOwx9smaf1mKCsZSvSmvJwJI6ZZoM2iP8slfb5zPc5CmQJvol8IpI0NZIg9NiZ5G203ubdlliKgQpr8QADTgMVHDvMmzgpNSB68hfVM2SA5qiGd7XBOvKmM3Ng4tiEYkO9OwRH6/QRDo0k2QR84Ds/kSm2EF48KnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KoP10Ygz; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-77f343231fcso3732664b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 01:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759824662; x=1760429462; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=M/D8wkb7OpnNtYTNHOq4pCL+v7kYN74Waroxt70FkiI=;
        b=KoP10Ygzg3UBWnn0LcgmcS8g3LNXfYgro8OADjrna+dubsk5aCAEycKUH/E/ngDBiE
         4itobOy3HgkcQY7NqayXlEEgm9n/oYIF7s6JQOmYe61hgj+GxS7tCV2ke+flZ230e3Nk
         uXVnOKjTXZb9KpgyLbx8xRDVQYR9c4FCKWOlM+PN8Rm78gZYfED+FFFvlNwaaZg9t20K
         463mQszIEDxh31rZtFN5yPtzojbr8yMpIqCu2dfN9mraG8Odi0TF8MfLzOffiLW3nCKu
         9N/YNJa/EFcOpW3ZnJHSuzr84z5HMDHeSjcpDuhGHiTAwY3bqoxA52KIBXeGA09YQGp/
         1O3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759824662; x=1760429462;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M/D8wkb7OpnNtYTNHOq4pCL+v7kYN74Waroxt70FkiI=;
        b=W9GEwLcsdJU5Hg4havlJLCmEOved6efAIudLklCFb9S6oV7eFVgcu23U3QQxCZyjGs
         qw5CiNaCyZsTyyLAhbiPOSFOlA2wElYBadw4JyBPGijRCDjDu1EhKDTsqL0CC7pZ7TaD
         lJoRZHd/wjVIHd2IbHw2pfhmZuTxq5DG7kYvpbF0gZvoOko+9wzrTBtu243rwvzvHtgi
         FbZpasy+aY4k842DqqcK3ciTq7MvFmE3t12tyM47icI5jjagScNriqG5uWLJgCaMIs9P
         kqjM6zHXMoeI6We6yXnjkxT5v8ENA3b3UPaujgFHfEXAtatcTUH4vsRznoVkS1RzYH5w
         W2MQ==
X-Forwarded-Encrypted: i=1; AJvYcCXEdm7IOgBJ9OaAi2ibGAersU6p2zI8ngEpQdd+tcB+hN79VzPCLH+THvS0A6VUcIMdYpWxGpvH/NB2Vio=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1WWteT783lnfLg3KGJeuXL9IKnnKFazUqLCFUKiHDgZ/q2LmE
	7hb+viwM4/wdSF7LHoKMoYLVnAD3TalA8kuf9LvInBUOXS9G5fkUoEZy
X-Gm-Gg: ASbGncseqa4puGSEX/IApu2B77zD1iZvqDn104t6CoGZTg/vX5GfBXxsleT9XXgtS0H
	0VsmGRR/xRYrbEn+/rmQ7/yktE/nMD5Y+LjgFws1KtvZwgEEb2XTLtiHB5uvrFJ9i6E8jroXitG
	3Zk6wIN4r7mthKp2Uy6U5Hh/fyiJ2kbKsU0hltzivW7bsxBxNE+KaYZlGPJy4pSzvzowLBeFZvM
	+cEf6G1cGgwFsRBD28SbPEQWIJjAPOpSJcjr7TrOOribCoTMOfYcOjGoXsOdxzdS+QqTfJXAwf2
	gC7rDJfEcKd2QbQWIeoVlxCNDP2C2w1e29K6R2mwGhWvBhO9sYzag/tLVdXwAhyCAlZhKovnrlH
	OokE4oZSai1WqssDZTlofe7/SHzbNWg9llaIMmgbBa0YdQYqBnfuUtw==
X-Google-Smtp-Source: AGHT+IFtJDcZJJqDbhKbqGHc5CZCzc4ifM/PYLCIhIeNnxJMzG+HMs9lRz9oO9kaELRH8n44x51jlA==
X-Received: by 2002:a05:6a20:a106:b0:2f9:dc8d:d2a1 with SMTP id adf61e73a8af0-32b61e661efmr20081578637.21.1759824661302;
        Tue, 07 Oct 2025 01:11:01 -0700 (PDT)
Received: from LilGuy ([2409:40c2:505d:3f1f:140f:568d:710e:1a82])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-78b01f9daffsm14736864b3a.17.2025.10.07.01.10.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 01:11:00 -0700 (PDT)
From: Swaraj Gaikwad <swarajgaikwad1925@gmail.com>
To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	ntfs3@lists.linux.dev (open list:NTFS3 FILESYSTEM),
	linux-kernel@vger.kernel.org (open list)
Cc: skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	Swaraj Gaikwad <swarajgaikwad1925@gmail.com>,
	syzbot+83c9dd5c0dcf6184fdbf@syzkaller.appspotmail.com
Subject: [PATCH] fs/ntfs3: fix uninitialized memory in ni_create_attr_list()
Date: Tue,  7 Oct 2025 13:40:07 +0000
Message-ID: <20251007134008.144590-1-swarajgaikwad1925@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

KMSAN reported an "uninit-value" warning in attr_set_size(), which
occurs when the NTFS attribute list buffer contains uninitialized
trailing bytes.

In ni_create_attr_list(q), kmalloc() is used to allocate a buffer of
size al_aligned(rs). However, the amount of data actually written into
this buffer can be smaller than the allocated size, leaving the
remaining bytes uninitialized. If those bytes are later accessed,
KMSAN reports a read of uninitialized memory.

Replace kmalloc() with kzalloc() to ensure the entire buffer is
zero-initialized, preventing future uninitialized memory accesses.

This issue was reproduced and verified using the syzkaller-provided
reproducer. The patch was tested by:
  - Building the kernel to ensure the change does not affect the build
    process.
  - Running the provided repro to confirm that the
    uninit-value warning no longer appears.

Based on commit: 9b0d551bcc05
Reported-by: syzbot+83c9dd5c0dcf6184fdbf@syzkaller.appspotmail.com
Tested-by: Swaraj Gaikwad <swarajgaikwad1925@gmail.com>

Signed-off-by: Swaraj Gaikwad <swarajgaikwad1925@gmail.com>
---
 fs/ntfs3/frecord.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index 8f9fe1d7a690..4fe8da7fc034 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -767,7 +767,7 @@ int ni_create_attr_list(struct ntfs_inode *ni)
 	 * Skip estimating exact memory requirement.
 	 * Looks like one record_size is always enough.
 	 */
-	le = kmalloc(al_aligned(rs), GFP_NOFS);
+	le = kzalloc(al_aligned(rs), GFP_NOFS);
 	if (!le)
 		return -ENOMEM;
 
-- 
2.51.0


