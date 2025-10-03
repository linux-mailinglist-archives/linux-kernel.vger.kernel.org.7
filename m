Return-Path: <linux-kernel+bounces-841450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 07841BB756A
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 17:40:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 621B54ED18C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 15:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8B6028507C;
	Fri,  3 Oct 2025 15:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B1/Pji0/"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26791E515
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 15:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759506053; cv=none; b=LvWMrTfXWObXDfTjnSk8F5uHkhupYf27701YNfIqYJAE/CXIr5a9+SLLrcAUDzJmZd6fNpgTzfsQ+yvVNfiSmXepFX/FVspsgxmoRORhkH/Pk4T59SveQUc1EmAqtoEqini2jv7ywmmNb9zQYAnYjV2md4QZK1fiBEYbiYN2CYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759506053; c=relaxed/simple;
	bh=LOg4T94ipRq8J347hgnTWV0pMK8tjjOpCc0XTauE/Uo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XdodFKI3ZKj1LFRwkPStchihlXhJnNX8ZN5sG34UG5Ijz2U0ZyXKDJ0G4EYm2//eKPTFdSTXXwaB71jf13l1uyUw1w7qkhq2b7XVkSpr3dgZfwb0eVAGqHCelO4tEU+W5DjQzZ3eSzcJMOOtYVmM3a2ZgO/aPcLVFosXFufyf9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B1/Pji0/; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-78115430134so1684794b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 08:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759506051; x=1760110851; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=K7r9cq9P/21nnwhqpNX1hAPkeXOwTrBQce9AVDcYHDc=;
        b=B1/Pji0/0S0VJWjlPLU9erjJEDO3+A6QsHEhEByJizRUQ0asUe1GDWZ3zYbIHZFvxa
         BbaK6nqsqMlPFXi4RV1WysOVEx68/XgEha6r93A54nwRIy+KSrXYKetkN4Q2ZsBYim6k
         f+W/ufTS/jLHSAzbqH2CWpoyHbc0MdpuV59AvOAwB67TW6QbOXpvTpNibdqTVK3Q5smm
         ztREQjyWYa6H35gKWwHE61OYxnHFiDif0OFdvXF7nRA5Hm2sFfXdgTMz98nFyymzF0C0
         1mTEU+4fvN9NMKa4iLBzDvDiqn+W2xqcaA6djK0hypi8EXT4dzJKt4gIEBlDoiolilOd
         8ylQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759506051; x=1760110851;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K7r9cq9P/21nnwhqpNX1hAPkeXOwTrBQce9AVDcYHDc=;
        b=dvtk/y6SgzalHPdc0a4A7oEng/VCxwKJQ/LQDhUNAhA3cfdaDrRdogaN71VyiUDg7O
         WCov5J8+SglIN3IXIjcrWJJafA8gIVvRkv4Osgwu7y5HLoX8SfmU5WYZSXfixdpWDgUS
         +M27NXhvZ7ix7/B+vCtNSr8ryn28VQqpTmMoMIHHoC3ayA4s4NZ0iLLmurwJtDkje7cs
         8InjWr2F+1Qe2HaqrJEXPAyt8pq1WHxVQRGpicWcUS7ZZFi5Ay2BLQMlNKBRs7RWoS9q
         4d44yewpHLkZQHMjSdiTyDark4qMw3OwayXe9JUgL1dQz2ULJrvgwbOjcudJ78KFEWW9
         eCMA==
X-Forwarded-Encrypted: i=1; AJvYcCWQz5fyPgdbyU3QaaboUR84B+jWi4rJeEf3sZs2z3s4b0DOf+U3qtY51RXdF29Tjlytke4htZmthY6cpuE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvvGu2xTy5STDS4SI3VOVmDEXaedlxF1lZp5u7KzKotSryHQ4T
	dEcp1UTjOYcQdheuC7ORiVMyyTzVzf9NixISipfe7ypwbxMSZpUrcgWC
X-Gm-Gg: ASbGncudJrmUj4d8HmsdoTSPRRY99G7RLHpqBi07m+rtPDbqDogbqxjTPgWRETrbmAp
	R02q7YsUtn+aQCc/qpdQJK0JOnv98ighY4bV5rSh8aXYXN0eRHLKv1uEQUJAx0KsqWeA+M3uyuf
	q8nbsNPYROT8sJ7UEDCA/5WCGVGVg7hlRjmwFngk9XnA0YgPHXIs73uMdtiV+E0ZAwM9CSFXYw3
	85vCrhhx65WSSig/kbxKTJgHzQbCWa4XCHJHolTRMTYwbc+hhk/emeD4b4B1dPFX050vg6pI0sr
	Y0jS+K/dOrZosyK/c+WK78j+tOCxW2L/CV80aMDnkmxVYxmLri8ApnWc/3+aTKjLMIUuwOvlK2j
	zaUerrjofroOKmI5B9gqKZpbCSVXe+Cq3RcceGuY8wULynX6noAVh91Vjgk9WKDyw7FUdM6m9kr
	/tvMK8IjihYA==
X-Google-Smtp-Source: AGHT+IHSOuHphbmG3g6A0WPDYkpmRmaUeSt/uHAeUHBHPqJHLyn8M8hem8ooNEv/cPxzBc6Dfir51w==
X-Received: by 2002:a05:6a21:9989:b0:2ec:65c:c25 with SMTP id adf61e73a8af0-32b61dfb914mr4385705637.8.1759506051178;
        Fri, 03 Oct 2025 08:40:51 -0700 (PDT)
Received: from weg-ThinkPad-P16v-Gen-2.. ([2804:30c:166c:ce00:17a8:586a:f651:fcd5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6099f7ab4fsm4946496a12.44.2025.10.03.08.40.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 08:40:50 -0700 (PDT)
From: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc: ntfs3@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Pedro Demarchi Gomes <pedrodemargomes@gmail.com>,
	syzbot+f4f84b57a01d6b8364ad@syzkaller.appspotmail.com
Subject: [PATCH] ntfs: set dummy blocksize to read boot_block when mounting
Date: Fri,  3 Oct 2025 12:38:50 -0300
Message-ID: <20251003153850.55643-1-pedrodemargomes@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When mounting, sb->s_blocksize is used to read the boot_block without
being defined or validated. Set a dummy blocksize before attempting to
read the boot_block.

The issue can be triggered with the following syz reproducer:

  mkdirat(0xffffffffffffff9c, &(0x7f0000000080)='./file1\x00', 0x0)
  r4 = openat$nullb(0xffffffffffffff9c, &(0x7f0000000040), 0x121403, 0x0)
  ioctl$FS_IOC_SETFLAGS(r4, 0x40081271, &(0x7f0000000980)=0x4000)
  mount(&(0x7f0000000140)=@nullb, &(0x7f0000000040)='./cgroup\x00',
        &(0x7f0000000000)='ntfs3\x00', 0x2208004, 0x0)
  syz_clone(0x88200200, 0x0, 0x0, 0x0, 0x0, 0x0)

Here, the ioctl sets the bdev block size to 16384. During mount,
get_tree_bdev_flags() calls sb_set_blocksize(sb, block_size(bdev)),
but since block_size(bdev) > PAGE_SIZE, sb_set_blocksize() leaves
sb->s_blocksize at zero.

Later, ntfs_init_from_boot() attempts to read the boot_block while
sb->s_blocksize is still zero, which triggers the bug.

Reported-by: syzbot+f4f84b57a01d6b8364ad@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=f4f84b57a01d6b8364ad
Signed-off-by: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
---
 fs/ntfs3/super.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index ddff94c091b8..7648663d70c9 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -933,6 +933,9 @@ static int ntfs_init_from_boot(struct super_block *sb, u32 sector_size,
 
 	sbi->volume.blocks = dev_size >> PAGE_SHIFT;
 
+	// Set dummy blocksize to read boot_block
+	sb_min_blocksize(sb, PAGE_SIZE);
+
 read_boot:
 	bh = ntfs_bread(sb, boot_block);
 	if (!bh)
-- 
2.43.0


