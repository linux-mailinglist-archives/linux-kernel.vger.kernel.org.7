Return-Path: <linux-kernel+bounces-839471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A250BBB1AF0
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 22:27:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57F783AA343
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 20:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9455C2FBE13;
	Wed,  1 Oct 2025 20:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sg4bTlQY"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F132ED164
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 20:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759350441; cv=none; b=qStSECXnIHrI5Ou+smoTlo3zdKSJudLvX17Mb88N2tNS6eXKOFs7+Qqj4n163/A/gQQWt6QHMze1UAlSMxKYmCgxJ4q7ooL+q7bazGssT2zIMK688lrqJbyf6HY3rC5GxbieoFeYOEh0L6QEaYp9dgIQCayaH4GZKc5BSgq4gM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759350441; c=relaxed/simple;
	bh=G963DtS/1FnUYe8Bk64aERAuIQSpK29BvJuSKXZoyJw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FCtxujsh1NM4BiYDGENiKoeU2uRFpNDcZdIuNsmgvzbzFXE/c4mDAtMOluqlQDHqXk2GTDLHGNUX+HZBKc6vZt9zrO2xycQ8cMdK4nHslnYJ+856Tjyw6WFigta9CcWL2puMxXCMZzL/Ppuy4rWupn/I5baHjaYREVZ3U8FpnJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sg4bTlQY; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-279e2554c8fso2208065ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 13:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759350439; x=1759955239; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0Y2TB2deAhvzJ9TnIqGPiw7EFDMg7t0R4+4KfZC05qo=;
        b=Sg4bTlQYx2n+eCGcFsR0VvyMOfoXzyyjTaGy8GADmnlY0wxmr+toLg88lpj92+G7E/
         kIvwXxuad1I/fon/LeERqF1gRdbdbLMpDCv8urjcd65awb7eP+vf5ea3O3UCYtdELbmM
         4dJUkpWjFpqfIFNx4bG8zfw0fUDQqA1RN4YGLseb8atelBuUZkRKOYAanRDnak/z7/r0
         Pmh2Bq9xg5UdjeTu1aCzUQvDclXFxib2rDiQnPeRcYhijJmtK/G6NKhqyNbxveJylOXT
         /2wvR9vlEeNsP7Ug3TtyOxhUaNGpjiNmn4/lbf/mTqv+8D8JPaNaEvD9AqmJTvS8nCSq
         MdqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759350439; x=1759955239;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0Y2TB2deAhvzJ9TnIqGPiw7EFDMg7t0R4+4KfZC05qo=;
        b=QekKoMMo+WNdHm54M6zuzxcbP/Yan3cIjiyxZzlCbcUXQZbZSunLHOYqSELCNbfrNE
         6IyataiHEkeBBk4qk082hQQ1tQGcOiMlws69tRSBztDCod/dJRMah/mBtbUjCdIMVp2G
         0KypOpv+9DME/qCn8+xULiBuQkjE6Z0SbKH3P86pUozpt0vBoCnagGqRsPI8pxYNnMEu
         wt1Rcr2wDPUFgRPidHk7m8OsIBKSG9nO8aZuKxYYoH/8t0L+iM3JezXJ/cOzCtGdSZHJ
         CQRFsSy5rym35OciGeriXURqEJxQmim+24+SK2uxFl0W7zjZRCBEQcwrNJej5+yU12EJ
         5mhg==
X-Forwarded-Encrypted: i=1; AJvYcCURNohYVrn2rRao0/bklJHWheJwTtPefQZ25/rYJ6+qqCnXP3XNvnbV8untEZ9BqhnViHnPLrIoAB7XmSo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7bqNpkpDcX4pIMxjnM7UbKH/8kWMMlAlHaE95D9c6CLeEWiIp
	paw+Xo78sluIUt7o9YwhH0zb3FxW3jk1NatBpU+ISycFvpDUTQyl6wwXPHhshw==
X-Gm-Gg: ASbGnctlybVUJoF+zskIb2xVWlgz/sdf04IBE9onGjWpDLc5khCx024jlPjO4JlyD98
	LfOQPvZ9ew4pj2ukL6ZvK5/U50noUowQINGr8XF3G+ldG5k52YcCg2QJLOSas0Sj55WNxJpwadI
	8p8G7tyTo56psnN9vl9k7oTO1uJvtFCevToisBt7GzGaElXUOZvolfOhT7Ffxcttu/lpiWZuCB1
	Y2iEhKRFnWlWDJzAI7Bd6f5DG3UggEMtDqZKtIn73MGUQ+3CeJpzk1cRlhcp5IW8sstw4yJZ2za
	4h1Ubc489eGJJQoc3a07YPi2F099WMCBHnSTrTZS+8YcSRiYthKccxw8hT75VqFrzvIguHC+vkJ
	e0wgV2aJPSP/CQc9loqbyIkSJZBqJCcQPDHZ3xY1pZ9Z8EduBsKdRSMC9/UG8It0hHOa/rT5DF5
	z793uUz7qfv2MIFN8dmDmd9MeGQzLk2uB4miovDA==
X-Google-Smtp-Source: AGHT+IFSHOpmU+tiZFi1WwF/0IqSVMuQDH3frGeMOd5w+e2OLJaFmNhJOspRWyZINZN6L9DIiNzoBg==
X-Received: by 2002:a17:902:fc44:b0:27d:6777:2833 with SMTP id d9443c01a7336-28e7f319f34mr61832625ad.47.1759350438619;
        Wed, 01 Oct 2025 13:27:18 -0700 (PDT)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:389d:2f27:4b44:4a2e:f965])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d1280a1sm4709695ad.51.2025.10.01.13.27.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 13:27:18 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: jack@suse.cz
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] isofs: fix inode leak caused by disconnected dentries from exportfs
Date: Thu,  2 Oct 2025 01:57:13 +0530
Message-ID: <20251001202713.2077654-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Jan,

Thank you for the review. You're absolutely right - my initial explanation was incorrect. I've done extensive debugging to understand the actual mechanism causing the leak.

Root Cause Analysis
===================

The leak occurs specifically with CONFIG_JOLIET=y through the following sequence:

1. Joliet Root Switching During Mount
--------------------------------------

In isofs_fill_super(), when Joliet extensions are detected:
- Primary root inode 1792 is created with i_count=1, i_nlink=3
- During Joliet switching, iput(inode) is called on inode 1792
- i_count decrements to 0, but generic_drop_inode() returns false (i_nlink=3 > 0)
- Inode 1792 remains cached at i_count=0
- New Joliet root inode 1920 is created and attached to sb->s_root

Debugging output:
  [9.653617] isofs: switching roots, about to iput ino=1792, i_count=1
  [9.653676] isofs: after iput, getting new root
  [9.653880] isofs: old inode after iput ino=1792, i_count=0, i_nlink=3
  [9.654219] isofs: got new root ino=1920, i_count=1

2. open_by_handle_at() Triggers Reconnection
---------------------------------------------

When the system call attempts to resolve a file handle:
- exportfs_decode_fh_raw() calls fh_to_dentry() which returns inode 1856
- The dentry is marked DCACHE_DISCONNECTED
- reconnect_path() is invoked to connect the path to root
- This calls reconnect_one() to walk up the directory tree

3. Reference Accumulation in reconnect_one()
---------------------------------------------

I instrumented reconnect_one() to track dentry reference counts:

  [8.010398] reconnect_one: called for inode 1856
  [8.010735] isofs: __isofs_iget got inode 1792, i_count=1
  [8.011041] After fh_to_parent: d_count=1
  [8.011319] After exportfs_get_name: d_count=2
  [8.011769] After lookup_one_unlocked: d_count=3

The parent dentry (inode 1792) accumulates 3 references:
1. Initial reference from fh_to_parent()
2. Additional reference taken by exportfs_get_name()
3. Another reference taken by lookup_one_unlocked()

Then lookup_one_unlocked() creates a dentry for inode 1807:
  [8.015179] isofs: __isofs_iget got inode 1807, i_count=1
  [8.016169] lookup returns tmp (inode 1807), d_count=1

The code enters the tmp != dentry branch and calls dput(tmp), then goes to 
out_reconnected.

4. Insufficient Cleanup
-----------------------

For inode 1807, I traced through dput():
  [10.083359] fast_dput: lockref_put_return returned 0
  [10.083699] fast_dput: RETAINING dentry for inode 1807, d_flags=0x240043

The dentry refcount goes to 0, but retain_dentry() returns true because of 
the DCACHE_REFERENCED flag (0x40 in 0x240043). The dentry is kept in cache 
with refcount 0, still holding the inode reference.

For inode 1792:
  [10.084125] fast_dput: lockref_put_return returned 2

At out_reconnected, only one dput(parent) is called, decrementing from 3 to 2. 
Two references remain leaked.

5. Unmount Failure
------------------

At unmount time:
- shrink_dcache_for_umount() doesn't evict dentries with positive refcounts (1792)
- Doesn't aggressively evict retained dentries with refcount 0 (1807)
- Both inodes appear as leaked with i_count=1

  [10.155385] LEAKED INODE: ino=1807, i_count=1, i_state=0x0, i_nlink=1
  [10.155604] LEAKED INODE: ino=1792, i_count=1, i_state=0x0, i_nlink=1

Why shrink_dcache_sb() Works
=============================

Calling shrink_dcache_sb() in isofs_put_super() forces eviction of:
- Dentries with extra references that weren't properly released
- Retained dentries sitting in cache at refcount 0

This ensures cleanup happens before the superblock is destroyed.

Open Questions
==============

1. Are exportfs_get_name() and lookup_one_unlocked() supposed to take 
   references to the parent dentry that the caller must release? Should 
   reconnect_one() be calling dput(parent) multiple times, or are these 
   functions leaking references?

2. Is adding shrink_dcache_sb() in put_super() the appropriate fix, or 
   should this be handled in the reconnection error path when 
   reconnect_one() fails?

3. Does this indicate a broader issue with how exportfs handles parent 
   dentry references during failed path reconnections that might affect 
   other filesystems?

I can investigate further into the implementation of exportfs_get_name() 
and lookup_one_unlocked() to understand where exactly the extra references 
are taken if that would be helpful.

Best regards,
Deepanshu Kartikey

