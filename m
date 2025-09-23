Return-Path: <linux-kernel+bounces-828703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C85CB953D0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 11:25:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F71C17233D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 09:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8624E31E0F4;
	Tue, 23 Sep 2025 09:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S5f62Dcp"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C13B2F4A11
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 09:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758619521; cv=none; b=XeE/7stt8IqxGXsKQ3bljIfyeOFKRUXLrfuL0UV70ziwRpZG8aZNr50Auu4PBL4dVPqwLp9Qotny7sTRmjh1MgNBiDTW0J/G+RpAX4LtLxuh618UMbcUieJIJjjAr5TJ92Bjhjz9GKHbG6ATW61ABBmSErmOF+zhRdOd8/Q5aI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758619521; c=relaxed/simple;
	bh=PHiv/oFqAssT7C2vXwJaDcIHi9lPA2xHzt6CUrRq4Pk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G1zlU6Zbo+le3En2LfZ59pzIddgT9/IjOrzlCkpT/mDAmd1JR06U5P/wKAPl1T7wYfwkdGxJfZwAsi2tJbdR0jboon/NrPTecbOPd2WCvoEiQ1aWbvMC2u7DXlyPjPJwTge+o9eW2Ot00yt/Zz/L4wbBWQwhh74/1d0NK+DOdm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S5f62Dcp; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b5515eaefceso4003322a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 02:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758619520; x=1759224320; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=t0zopWVobPuDweXBkACHWGSxHrDh+qcAB4VX8MwOBTo=;
        b=S5f62DcpiUUsYU+Ygi1dc+PaUmAsV7QQrvqx6TAuPpF1a8XC6lRzCnqdXUwcWoReKF
         4ZVTI38f11Ip5gB07Rz15OKyVjvYPAnfS3tHcrVGdl6+Zsj7ctSTxzteLZn3tft4OJyX
         FnJkysEXoSRUthXpvcpB0lzGv1i12LCbgJRXz/cd2L9dxrVQKV63I3tAogl66DcBzffY
         UeK76IS8eI4GW8qga6ItrqJs+KcuhApPDpLcQ3Rmgj1J13QCFpux6rHvyUo8gFeC8bO5
         A1v/90ffd8WsBCaRvXEXkaZy/ZTLVsWeZzrYSAqMrErbEm4lMNpXNixeUA7Xjh7DctpB
         At3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758619520; x=1759224320;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t0zopWVobPuDweXBkACHWGSxHrDh+qcAB4VX8MwOBTo=;
        b=LCYhKMYUysI+12TqmXmtQfqUHgGgtDr9YTTZrhh2Ke9nPWksPjlowr6Vc/n7S5KvWY
         f0L++L9+7E5u90uqF844N59LnuDfn6Fwd+MmtSyjAqNhTbCo2nfVhYyMf/k+Nk60tjKK
         TlnKUlXiTKSl6/ekCOZ1tlnwa5Hn7C+5Y68/ZH8iQHXSxm7oCh7fhIrvd4FSNq9HgAI9
         9sU+iOC2OusBAuorGWk5/iSGU+MK2T5FK/OvQQP516C7jzLAxRHwgSPUPWX3QZ6C2fqf
         TZcJcPLPD0i/pUp/a/qBClSpKR5mnHEV0P+27dVHnk1iFMoUC2qk7ONnfYnwFIswcA5R
         Bcfw==
X-Forwarded-Encrypted: i=1; AJvYcCUXKYZZpF7o3diqrGiC6MBcAaFHjL3J2QIED2T4yHlDe5oYhdjgbeqyI72guZXfgoEc7/eq+aLzfh7WOuY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjPnL/lzBIsAFATl1BnKfqgbGtLih37jgw1jWls+OsH5pkWK8a
	W93A8upgpxY64OzmX5rUyH19DGM4zEjFiOWGbwyx8O/x0yuYWhAN2vej
X-Gm-Gg: ASbGnctNd9pLdNXhqSGcJMlqpYauOhQ3XFvuaGLFwXAi7X/NLALjQyCRs49PC3iHAsM
	Ox06fT+rNPHSQL+Jgc7m6VhuvH24UgvFrmqISnpX6sJLfH9elWWrI7qYakKuSYJZZTvtClHDM5n
	m/dVFb11S6LyYoFsHYJIPdNrNS07aL2s13HDyXN+0vwvyshtenFr3kWDs8xo+djSXypnZ1cNG08
	AA6+YOc1Di6tO5t1UTZzmmu5Atc5Hm1Kn9iK4PMxNZ46EiC2+AIie/mCyjbXxfBNkZFXQUgnM8t
	p31MpyOe+pk6mI4ub0lxPos8agdmZo9ebItiaFXdX0NOk7dtLcuHPcenqnIsDpw7D6nZhA0QL9p
	BUQt+BFjpZPbZ8yPwg1gIXAvQ64WnH3t0B4Wt0q9mrxxdzj5OGN/Se0hpWyO9QfZ1W6CSzMy35k
	ex
X-Google-Smtp-Source: AGHT+IGn7aSKodmfL9W3POGby8TbXXLOzrsHEIGZd2B2OQ1QB9XffdinzZ+NDU0Z9FIqeA8PqUP8VA==
X-Received: by 2002:a17:902:e5c5:b0:273:31fb:a86d with SMTP id d9443c01a7336-27cc8654955mr20149525ad.48.1758619519808;
        Tue, 23 Sep 2025 02:25:19 -0700 (PDT)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:3094:5a:8db4:4ddc:e3c5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269802df74asm156690375ad.94.2025.09.23.02.25.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 02:25:18 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: tytso@mit.edu
Cc: adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot+4c9d23743a2409b80293@syzkaller.appspotmail.com
Subject: [PATCH] ext4: validate xattr entries in ext4_xattr_move_to_block
Date: Tue, 23 Sep 2025 14:55:12 +0530
Message-ID: <20250923092512.1088241-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

During inode expansion, ext4_xattr_move_to_block() processes xattr entries
from on-disk structures without validating their integrity. Corrupted
filesystems may contain xattr entries where e_value_size is zero but
e_value_inum is non-zero, indicating the entry claims to store its value
in a separate inode but has no actual value.

This corruption pattern leads to a WARNING in ext4_xattr_block_set() when
it encounters i->value_len of zero while i->in_inode is set, violating
the function's invariant that in-inode xattrs must have non-zero length.

Add validation in ext4_xattr_move_to_block() to detect this specific
corruption pattern and return -EFSCORRUPTED, preventing the invalid
data from propagating to downstream functions and causing warnings.

Reported-by: syzbot+4c9d23743a2409b80293@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?extid=4c9d23743a2409b80293
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
 fs/ext4/xattr.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index 5a6fe1513fd2..60e224c622b4 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -2607,7 +2607,10 @@ static int ext4_xattr_move_to_block(handle_t *handle, struct inode *inode,
 	struct ext4_xattr_ibody_header *header = IHDR(inode, raw_inode);
 	int needs_kvfree = 0;
 	int error;
-
+	if (value_size == 0 && entry->e_value_inum != 0) {
+		error = -EFSCORRUPTED;
+		goto out;
+	}
 	is = kzalloc(sizeof(struct ext4_xattr_ibody_find), GFP_NOFS);
 	bs = kzalloc(sizeof(struct ext4_xattr_block_find), GFP_NOFS);
 	b_entry_name = kmalloc(entry->e_name_len + 1, GFP_NOFS);
-- 
2.43.0


