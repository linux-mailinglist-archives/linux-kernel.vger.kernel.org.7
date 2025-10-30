Return-Path: <linux-kernel+bounces-878569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2347AC21066
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 16:49:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2048646626F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 15:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 758F02F6939;
	Thu, 30 Oct 2025 15:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f7xbFnOL"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD072773F0
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 15:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761839227; cv=none; b=SKLx7hT0B9uXcxQeSQPUDRsw+1JDTkDg/+SN7A+2dvg5qy8x8Dp+LyNpEVIfrmCV0+KLJZBSYTtJ5ppvbhpSURExhhy/0wA2jtHveXiVvS91kvA0fUGeobu2rFUH41cR1sILYBRHFOBTfjEHThgbnmo7pGva7gOgl3/F1pOmGdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761839227; c=relaxed/simple;
	bh=KYCvtl9iIb9z3sYLX7mth6ZRx4xzHJNyk0OwzpOVQks=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=prWveiMWPRo67fVqZKKuUwcW7jtKBeqLwFUHlJ3u10i4mliF3pJGCMF0ElWgDcf1E6UuZCc9rm9Tqadglr92m1bbs+SmlN1GMDYbxSmEYJ4IS6fTU5G7B70S3RFEljfKyZWUbGWGpuX2r5FNLOjdQtqTR2+7QJdIn5qwgIQlR78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f7xbFnOL; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-782e93932ffso1258041b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 08:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761839225; x=1762444025; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4HwkNGraBfoQB4E2yTSbSQQ8WvUrKXkWt+AnAAOpCLo=;
        b=f7xbFnOLn5MVSmoPhrvkxGy77LmdxUNAcLjTlSMFOQAB1UCbLZkAxhMCPXmv/b9B/M
         IzuhNU0Dd6Rehxr9YOiOShTIUjwWs2NDTRB/4UUKcYGm/ELHNOU4ziB3hkB3nLOiQYJH
         nmZnE8uBJUNKlyDOrm2GQdYoccnW1wG7yTkn2e1h0MhRlXTf2TEcjug4XP9a6DP8WqsC
         D0SjJAK4sxpAM1ctAlQy1iRmQQgBFhqhMCqdmpWSA6ol3R/yKZ8fYR907ifySWOVtiWe
         kHgMqiEEOad2BR5sAj2wX0gPRorvpkIUI/KL+ebc91hcZyj0z4QcGTudmJx8f20h8LH+
         1nCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761839225; x=1762444025;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4HwkNGraBfoQB4E2yTSbSQQ8WvUrKXkWt+AnAAOpCLo=;
        b=PgG3Hlxo+5GvWeRAFDdUEfpRMfULcn1p0FWUVAltFCjrDll3YOy6fuuUVt1dnHn5nb
         EMLcG/krBp/Wtm9LsHqvHmzCcXH5ynSw5n/i45tIY9rrfC6zjeww0SR95dYX2GmvpGJa
         xIF9a5geT0nIvDdlP1O+isf9Fx4EnhyK8g01GQUk1+5dykBFpd2XKsOLsFn3MX5lj4If
         lg17i9C+qWYgVRy4uYGJylUQNPfLY7j6u/OSHyH2W+rk37P5BowVk0/oXP9bnlyJPv1i
         CQ9JR0dzgB5InLxDCaFZLEImmDXuPLDDwYDeOmh7zvsITOH2OaAz5pylLddrgkndxVDv
         HP2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUOyr3MH1Iq8yOFUWz82KMgDkGDZyITV7AbigCFknPgWKhmBt8fXAV2Ua+G53YDOrtQ/teFUfd4a9Q8tS0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzra+K+/+41zc5ztrGi4ZKMWjfb+XEHrlaBkpQeUWk79TULkltB
	Uwx9mVhjY9Lx7/iOZLgm5RU27ALuic4P+3uL4lWSPRr3ISkYScGB9ELl56QIxg==
X-Gm-Gg: ASbGnctWP9tqTlXnXauE2QdY0cJSsOUiUe+9V4B2IqZQ5DTVLqbaZWrZSeOWcHm4oZQ
	bdX+OZgxbhJxItrd+GanxJOyPOb3FPJEgOpSFbzN/j/FzM5kJ6zT4JZj1tU1jEk+k5Btpt2PWox
	C5zpzqPwEvvJ12Qav8HyYSlx9UfBz20LQjdeDFs2WM+tHTkJk7yce0sZTfIMwUTF0/9YmQohgg6
	OD/gecsIznb0fbWpnV5c/uKFNh4ttBY0h3dP2ISiATX+1M6LI0cD+KyTKzhQ5Yl6qjvkw9lvDUC
	zId/sgl5y1IfbpgTAV12RralNBsOZIoq2UychE85pT9Bm0Wet66Q85rfSHXuEG9rggqEhENcYNz
	CM0Unrc2HU1pCbxZKX8GqfrUBn/pEc/kNK0qQdWfN3iPuO+NQ0X8Fbd58Ghsw/jaJ4fkWvQLVK/
	X1bBZayeQq4q3EYaKGi7soAB6sDyTfZCtVRopkvtkzBHSVS3cpiKO9Vp8MseA=
X-Google-Smtp-Source: AGHT+IFcc33VqBkxqmqM9pNxRLYyND/KX19MuxGKFkzF9NJYd7inwOjqBTFF6JjTi4M2JMlKTu/4xQ==
X-Received: by 2002:a05:6a20:4327:b0:343:6639:f1b2 with SMTP id adf61e73a8af0-348cac86b7bmr94843637.15.1761839225002;
        Thu, 30 Oct 2025 08:47:05 -0700 (PDT)
Received: from carrot.home.local (i114-180-53-102.s42.a014.ap.plala.or.jp. [114.180.53.102])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a414072487sm18992926b3a.52.2025.10.30.08.47.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 08:47:04 -0700 (PDT)
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-nilfs@vger.kernel.org,
	Thorsten Blum <thorsten.blum@linux.dev>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] nilfs2: replace vmalloc + copy_from_user with vmemdup_user
Date: Fri, 31 Oct 2025 00:46:43 +0900
Message-ID: <20251030154700.7444-1-konishi.ryusuke@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Thorsten Blum <thorsten.blum@linux.dev>

Replace vmalloc() followed by copy_from_user() with vmemdup_user() to
improve nilfs_ioctl_clean_segments() and nilfs_ioctl_set_suinfo(). Use
kvfree() to free the buffers created by vmemdup_user().

Use u64_to_user_ptr() instead of manually casting the pointers and
remove the obsolete 'out_free' label.

No functional changes intended.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
---
Hi Andrew,

Please queue this for the next cycle.
This updates the ioctl handling code of nilfs2 to follow current
practices.

Thanks,
Ryusuke Konishi

 fs/nilfs2/ioctl.c | 35 ++++++++++-------------------------
 1 file changed, 10 insertions(+), 25 deletions(-)

diff --git a/fs/nilfs2/ioctl.c b/fs/nilfs2/ioctl.c
index 3288c3b4be9e..e17b8da66491 100644
--- a/fs/nilfs2/ioctl.c
+++ b/fs/nilfs2/ioctl.c
@@ -49,7 +49,7 @@ static int nilfs_ioctl_wrap_copy(struct the_nilfs *nilfs,
 						   void *, size_t, size_t))
 {
 	void *buf;
-	void __user *base = (void __user *)(unsigned long)argv->v_base;
+	void __user *base = u64_to_user_ptr(argv->v_base);
 	size_t maxmembs, total, n;
 	ssize_t nr;
 	int ret, i;
@@ -836,7 +836,6 @@ static int nilfs_ioctl_clean_segments(struct inode *inode, struct file *filp,
 		sizeof(struct nilfs_bdesc),
 		sizeof(__u64),
 	};
-	void __user *base;
 	void *kbufs[5];
 	struct the_nilfs *nilfs;
 	size_t len, nsegs;
@@ -863,7 +862,7 @@ static int nilfs_ioctl_clean_segments(struct inode *inode, struct file *filp,
 	 * use kmalloc() for its buffer because the memory used for the
 	 * segment numbers is small enough.
 	 */
-	kbufs[4] = memdup_array_user((void __user *)(unsigned long)argv[4].v_base,
+	kbufs[4] = memdup_array_user(u64_to_user_ptr(argv[4].v_base),
 				     nsegs, sizeof(__u64));
 	if (IS_ERR(kbufs[4])) {
 		ret = PTR_ERR(kbufs[4]);
@@ -883,20 +882,14 @@ static int nilfs_ioctl_clean_segments(struct inode *inode, struct file *filp,
 			goto out_free;
 
 		len = argv[n].v_size * argv[n].v_nmembs;
-		base = (void __user *)(unsigned long)argv[n].v_base;
 		if (len == 0) {
 			kbufs[n] = NULL;
 			continue;
 		}
 
-		kbufs[n] = vmalloc(len);
-		if (!kbufs[n]) {
-			ret = -ENOMEM;
-			goto out_free;
-		}
-		if (copy_from_user(kbufs[n], base, len)) {
-			ret = -EFAULT;
-			vfree(kbufs[n]);
+		kbufs[n] = vmemdup_user(u64_to_user_ptr(argv[n].v_base), len);
+		if (IS_ERR(kbufs[n])) {
+			ret = PTR_ERR(kbufs[n]);
 			goto out_free;
 		}
 	}
@@ -928,7 +921,7 @@ static int nilfs_ioctl_clean_segments(struct inode *inode, struct file *filp,
 
 out_free:
 	while (--n >= 0)
-		vfree(kbufs[n]);
+		kvfree(kbufs[n]);
 	kfree(kbufs[4]);
 out:
 	mnt_drop_write_file(filp);
@@ -1181,7 +1174,6 @@ static int nilfs_ioctl_set_suinfo(struct inode *inode, struct file *filp,
 	struct nilfs_transaction_info ti;
 	struct nilfs_argv argv;
 	size_t len;
-	void __user *base;
 	void *kbuf;
 	int ret;
 
@@ -1212,18 +1204,12 @@ static int nilfs_ioctl_set_suinfo(struct inode *inode, struct file *filp,
 		goto out;
 	}
 
-	base = (void __user *)(unsigned long)argv.v_base;
-	kbuf = vmalloc(len);
-	if (!kbuf) {
-		ret = -ENOMEM;
+	kbuf = vmemdup_user(u64_to_user_ptr(argv.v_base), len);
+	if (IS_ERR(kbuf)) {
+		ret = PTR_ERR(kbuf);
 		goto out;
 	}
 
-	if (copy_from_user(kbuf, base, len)) {
-		ret = -EFAULT;
-		goto out_free;
-	}
-
 	nilfs_transaction_begin(inode->i_sb, &ti, 0);
 	ret = nilfs_sufile_set_suinfo(nilfs->ns_sufile, kbuf, argv.v_size,
 			argv.v_nmembs);
@@ -1232,8 +1218,7 @@ static int nilfs_ioctl_set_suinfo(struct inode *inode, struct file *filp,
 	else
 		nilfs_transaction_commit(inode->i_sb); /* never fails */
 
-out_free:
-	vfree(kbuf);
+	kvfree(kbuf);
 out:
 	mnt_drop_write_file(filp);
 	return ret;
-- 
2.43.0


