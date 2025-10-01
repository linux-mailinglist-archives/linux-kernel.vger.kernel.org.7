Return-Path: <linux-kernel+bounces-838679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 923E6BAFE85
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 11:44:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA67217DFD7
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 09:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD6802DBF47;
	Wed,  1 Oct 2025 09:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bWn9d93b"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B422F2DA779
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 09:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759311835; cv=none; b=c0fNFUrqwQxJL/dwpv8XklX6EWX26EEaXDYEa7DpQ7LcHcnlrnybJcxhzCFRhNdssUE2k6popx7EXzJCwmcPacMUe9urf22CEFz+4YQQwUSuaJgD83CKtD6WliMF1hCirDH1yBasGt2YdX1AZrLqTganAg5PnuidPCQ4uPbCPzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759311835; c=relaxed/simple;
	bh=ongDB0Pty1DRgDK7cUbIM5q/ExUfYVOWDm6lciYAdr8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oCMpkMwKPNgsXusvg94RL/XAq/zuz4tkUwS5y6yBmp8H2dYlIB3RRKgbT57qaYdABOJYE74WcGoWHAVkrP1SXwz4k5nKxgeUx5SpcRIXGe0l14Q/BABMf4Hhy4Yrxlk+3SgXJ20cAvYx7rNZQwYu4Y8FehkRXXcYaY46oa6FOMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bWn9d93b; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7841da939deso3448862b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 02:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759311833; x=1759916633; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4vdJdBt+Nr80DlfAVPf7IR3F3kl2Y2rk5v2m5tTJwGs=;
        b=bWn9d93bogdaR/AWBk2lxAV2Keng+pX3rNx6tcqHOfOD7uY29ZO2dg4+CP3tnlUPZE
         la4clzi2iq0HZ3UD9N2JDuCqEz/gd3g/VJgTgLR4d1v47CTKMmM+PFhDv2+Vv+G4j157
         si90qzkIW36ly42H6IX0wZC0wuiKUgwaIvr472wEGsbkr+TcovONdbIfA6lmuSxe8zUs
         1P8E/lv1D7xhanCeQIZ8WhjndFn1wSGouA0QxV+F5ZtyET0ccB+z21CKjiY791JSnBCW
         foBGZ7BRVszwwZdDbo1zNBjP//YQJe9lDSkheUxh0TjeTZtrt/8gl9dO7NrXX7Ik+cKP
         tngA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759311833; x=1759916633;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4vdJdBt+Nr80DlfAVPf7IR3F3kl2Y2rk5v2m5tTJwGs=;
        b=W5PS0aU33xi81O1pWpNiq829UYaK+GkdMLr15FQOOnUzEKgdb0tMZf0PlHKNTb0pvz
         5lV/TnGi632EfGISpWtAwkvhLddxOpIwjr2xg/vBnxy6FDAfhZ8ZXXLumiKKPBtI9yYv
         mP/oq+nwIk5sFEMZS1BVH40t5BFUK31hyC7e1lUBsGaIa1m2MHv3IvzvSXk+3R8VIu2p
         8fBE5oveO+6SkSYLn3sH0fKXjPec0715vc7mjDtNYZC3F0BpDHOgvkox7bYp8J8r5wUQ
         Ly3ICDRqiV2yQMFLV/bgEiMaQej4xvDxtn7S9DJMoZTgMfZNKXaJW72Jv0rZcoabrWOx
         wQPQ==
X-Forwarded-Encrypted: i=1; AJvYcCWz1uaYVnUBcQ7+AA2WiJh7g+D7L+EAu6xAFTmHbJuvg3NUMtxtxjsvUJyI6ci+2ujrjAfM/S4Kzs3sJEA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/95w4rnyrtKsz75QDXuLH/8Rp2Q5XYzOHVoM6fsDFzE6GIozY
	Xsc8Fn4nz8E4BXsvR+FxalcXS0xqrSxmGXgvH+xijgC3yDMsRxnvfVoK
X-Gm-Gg: ASbGncutOvdXRUZi1ouiOYXETbvvNWLiNh8t/DoZWpe/m4xEaUT2lSu+WFX9my0ACt4
	RNaAWrCHZ7uyBZ5GpneN2bLzbnu5lXyAr/P0+P/a+SJui30jkQugZJLTaJlRMMwY60t9uXStAQN
	xAtswy6ZeH+q4WAJR8YqBJehcPwggaDfuws7cHO+/6vNo3GsE9yU9OXQOIt2Qc5cH+RpdLkQ++n
	GpcrjkUP8wzIvTocmPCSM9paZuZ+Mp32jMnFXmk1vuqpBarEt8CsvzqezJRFSUOYcNd3dWL4Lbs
	K+NTItF8/lLQ18E19741FMCSPPMYOK50Loo6kgQdZ+1PnkpsJ1CBk2T6rqJNxpT8pU2dzNnKGeG
	Usdb3X0wW3trgs9KKVUc11vA7b2CKyyEiaymwPUUViVUkaPY1dnXHYqitBBunt/mA33IKRAntsP
	o5kK5Wr87n7g+DihRgaBaV/Fi3it/TzCBTixl1hg==
X-Google-Smtp-Source: AGHT+IGlxxcNR7XDAyX4adXF1GcePCKMdbrxEUyXnPCJOnQwtrOiaD0zrpCNu1lna5j8aUrWpQM91w==
X-Received: by 2002:a05:6a20:d0a3:b0:319:75fe:783 with SMTP id adf61e73a8af0-321dc4bb48bmr4007826637.27.1759311832950;
        Wed, 01 Oct 2025 02:43:52 -0700 (PDT)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:389d:bf1f:a781:827e:8d26])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78102c057ecsm15780763b3a.80.2025.10.01.02.43.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 02:43:52 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot+1d79ebe5383fc016cf07@syzkaller.appspotmail.com
Subject: [PATCH] isofs: fix inode leak caused by disconnected dentries from exportfs
Date: Wed,  1 Oct 2025 15:13:10 +0530
Message-ID: <20251001094310.1672933-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When open_by_handle_at() is used with iso9660 filesystems, exportfs
creates disconnected dentries during file handle resolution. If the
operation fails (e.g., with -ESTALE during reconnect_path()), these
dentries remain cached with their associated inodes.

During unmount, shrink_dcache_for_umount() does not fully evict these
disconnected dentries, leaving their inodes with non-zero reference
counts. This triggers the "VFS: Busy inodes after unmount" warning
and causes inode leaks that accumulate across mount/unmount cycles.

The issue occurs because:
1. open_by_handle_at() calls exportfs_decode_fh_raw() to resolve
   file handles
2. For iso9660 with Joliet extensions, this creates disconnected
   dentries for both primary (iso9660) and secondary (Joliet) root
   inodes
3. When path reconnection fails with -ESTALE, the dentries are left
   in DCACHE_DISCONNECTED state
4. shrink_dcache_for_umount() in generic_shutdown_super() does not
   aggressively evict these disconnected dentries
5. The associated inodes (typically root inodes 1792 and 1807)
   remain with i_count=1, triggering the busy inode check

Add explicit shrink_dcache_sb() call in isofs_put_super() to ensure
all cached dentries, including disconnected ones created by exportfs
operations, are released before the superblock is destroyed.

Reported-by: syzbot+1d79ebe5383fc016cf07@syzkaller.appspotmail.com
Tested-by: syzbot+1d79ebe5383fc016cf07@syzkaller.appspotmail.com
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
 fs/isofs/inode.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/isofs/inode.c b/fs/isofs/inode.c
index 6f0e6b19383c..bee410705442 100644
--- a/fs/isofs/inode.c
+++ b/fs/isofs/inode.c
@@ -52,6 +52,7 @@ static int isofs_dentry_cmp_ms(const struct dentry *dentry,
 static void isofs_put_super(struct super_block *sb)
 {
 	struct isofs_sb_info *sbi = ISOFS_SB(sb);
+	shrink_dcache_sb(sb);
 
 #ifdef CONFIG_JOLIET
 	unload_nls(sbi->s_nls_iocharset);
-- 
2.43.0


