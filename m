Return-Path: <linux-kernel+bounces-892071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E28FC4445B
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 18:25:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EAC6188881D
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 17:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 860F030BB8E;
	Sun,  9 Nov 2025 17:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dkgs2Bdf"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB79C30ACFB
	for <linux-kernel@vger.kernel.org>; Sun,  9 Nov 2025 17:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762709129; cv=none; b=bMQb5+InbCwdIgwuJfhXNAHWnt7zvaYRi1AHkgtX05/17TV8yNlzRG9SB3v0HXV/kB30dGEc9Rjimpb5gvdHgFA2lsUzWSjw+1DP4b+7R8OYnX7slczHYfzC3SOAEO6GiUBlOP6Atwsq+tJNSOBzEx2LVwH/1gRhvnk+Bp2DStw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762709129; c=relaxed/simple;
	bh=0gSECNM+lnpKaKv3hq0xVxiOPn997OqIgqHR+ztNkQI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YP2O2BFOOAm/UJoUS/IxhNwUvBu1LtcAWh9KuSMfTKuFYkDEGql5SfX2SP5USZAWK+/YNcyuDRuKxVDtVB4TJzw3RnN1M0CXnG7r2M6pqExQprm4/ExbnZ/Az27/jqH1V51Y9QHYxmZN5WxdAWB0JYhjuoztTg5MCj/xyezxqic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dkgs2Bdf; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6418b55f86dso360650a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 09 Nov 2025 09:25:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762709126; x=1763313926; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AjoThA5eIfhktl4UKgnb+Rmo28OBymrJAonx50pGa8k=;
        b=Dkgs2BdfGdeJ9N66I8abcwkUVzMiWSz5N/patHKf6GfrfV+PzA+o1PRh92xBOfVlU3
         Z7NQR8DQfqfOz2wdrmilZAP3kT3fXfbXYkB6L2xhYbIk9ZOFppSfkJ5MUCyPYg/rGPUT
         a3qYLv3tRoaUvfSqlv5xQzOP6Pcb9FsvNVzfMzVayPyKeqTs6d2a5VLL4gR4AlkVzUFg
         8c6VwaTnvZEB0IZI5wnNZlp0ijOdGd2INN5W6s/1ppUJQH2UyEgrExJIcYwbabf4Xniu
         2eKgudIie0IxCEr02PNPXCNaQOLiDBiAnyq5IBqjJkAu52ttlaJ3SN7jYMJ0GhfkcRBP
         gVcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762709126; x=1763313926;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AjoThA5eIfhktl4UKgnb+Rmo28OBymrJAonx50pGa8k=;
        b=WZER4KA/EytXxFVsqVKMbO9Q8AKeTrwgHEOLFD95lF839ZlLGez/ipM/dQtwVItOm+
         B4U0eDFq67tfGkw5xskRbGE/nl4984p9BcI69fCcafrOs8IaiSKlfrny50qlgzMrpZHn
         fG/OByidN055FbU8xP/ejpZ+iupFBciSrK9Ccuqrb2SSRCNZPAaHKWq0lXy9/OpjVAnp
         VQvGkq2Hu+wnmbdpenccnarUGG6MHWBkKUFvIRa4XqGzZheYlbR45mUggHn1q/aFmqw+
         ONpTHbxItIRWUJsjdgQKnlZ38Rzl8zto8ZVfPrk1lrDbzFgEsPAJJ3E5swEBgC5SCWjp
         T7xA==
X-Forwarded-Encrypted: i=1; AJvYcCUGieWPyZIBoG4S7RTgYSkEVjdUpH4uZyiCfFHFLsyNhUm6oh+S90NBbP7U7sWCBxjmbExIn5Hj4ZjkX8U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxS5GhYFVvcY81NDYLuUC1CMusPoW/3aN8Ab9WarMIjtjZ3stN8
	qInX467+daDdkhrRrRIpej7xa7nUeL/6bdWSf7nmhv6mMtiHCHyt9KbS
X-Gm-Gg: ASbGncvDGAOlnn/lFCG8FB5XQcwIOsaFT/liNVGbS3F0GmkuRiP5uM7d6C0uLcEW1gE
	TH2xCtcfU3P4/3dmJCdsqXEJQ55dlfj8AuSQR7/+DBhvU70MVhijJkEFiaYMKuuAjtngTm7OffI
	sC9gGc0082GUFx3NpGtNYTsPNIlFm5liosi/1SrFLDB4IgDaLRpJb+91J297bTzKBZSbY3lyFsy
	GqSGanAuwLzB96QLKDwOkyadcq1i8mYGooknzE2WpICrXQAD1G8u/97uJDwZlfBL9dLHhRTLQjD
	1YTh4PCRB5zEgFtjqz4/MMNyHJxxvvgpS3Hzqyij5QMe7SThtz9Ba72EfEE05ffXiMXYOMzjKOH
	N/O51C0/usbfZeEWlyMajLERqYdW1W2emNahcZ8D092AmP3uoiemQFer08kBUdQxotMEYHoYG6N
	s9gGSgmm2YKPchK3/vbISfLeJCehI0u2yuEGPogH7L2/siKCYG
X-Google-Smtp-Source: AGHT+IFLaNVl386arymG7RrgijMaYW+d0cPy4IzepQbBwwz9okDBmYk8GzgHVAoXIJvl7BW+ouva+w==
X-Received: by 2002:a05:6402:40c5:b0:640:95fc:2fcb with SMTP id 4fb4d7f45d1cf-6415dc16b87mr4262732a12.12.1762709125959;
        Sun, 09 Nov 2025 09:25:25 -0800 (PST)
Received: from f.. (cst-prg-14-82.cust.vodafone.cz. [46.135.14.82])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6411f813bedsm9257748a12.10.2025.11.09.09.25.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Nov 2025 09:25:25 -0800 (PST)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org,
	jlayton@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH 2/2] fs: track the inode having file locks with a flag in ->i_opflags
Date: Sun,  9 Nov 2025 18:25:16 +0100
Message-ID: <20251109172516.1317329-2-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251109172516.1317329-1-mjguzik@gmail.com>
References: <20251109172516.1317329-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Opening and closing an inode dirties the ->i_readcount field.

There is false-sharing with both of these operations, extent of which
depends on how misaligned the inode happens to be.

This notably concerns the ->i_flctx field. Since most inodes don't have
the field populated, this bit can be managed with a flag in ->i_opflags
instead which bypasses the problem.

Here are results I obtained while opening a file read-only in a loop
with 24 cores doing the work on Sapphire Rapids. Utilizing the flag as
opposed to reading ->i_flctx field was toggled at runtime as the benchmark
was running, to make sure both results come from the same alignment.

before: 3233740
after:  3373346 (+4%)

before: 3284313
after:  3518711 (+7%)

before: 3505545
after:  4092806 (+16%)

Or to put it differently, this varies wildly depending on how (un)lucky
you get.

The primary bottleneck before and after is the avoidable lockref trip in
do_dentry_open(), afterwards it's a toss up between apparmor and
->i_readcount.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---

of course someone(tm) should sort out struct inode, but that's a longer
story and even then it may be beneficial to not load i_flctx.

bench code for will-it-scale below.

It differs from open3 in that it is not read-write. Opening a file
read-write in parallel suffers *more* false-sharing and is less common,
thus a more likely case of read-only.

# cat tests/openro3.c
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <assert.h>

static char tmpfile[] = "/tmp/willitscale.XXXXXX";

char *testcase_description = "Same file open/close read-only";

void testcase_prepare(unsigned long nr_tasks)
{
	int fd = mkstemp(tmpfile);

	assert(fd >= 0);
	close(fd);
}

void testcase(unsigned long long *iterations, unsigned long nr)
{
	while (1) {
		int fd = open(tmpfile, O_RDONLY);
		assert(fd >= 0);
		close(fd);

		(*iterations)++;
	}
}

void testcase_cleanup(void)
{
	unlink(tmpfile);
}

 fs/locks.c               | 14 ++++++++++++--
 include/linux/filelock.h | 15 +++++++++++----
 include/linux/fs.h       |  1 +
 3 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/fs/locks.c b/fs/locks.c
index 04a3f0e20724..9cd23dd2a74e 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -178,7 +178,6 @@ locks_get_lock_context(struct inode *inode, int type)
 {
 	struct file_lock_context *ctx;
 
-	/* paired with cmpxchg() below */
 	ctx = locks_inode_context(inode);
 	if (likely(ctx) || type == F_UNLCK)
 		goto out;
@@ -196,7 +195,18 @@ locks_get_lock_context(struct inode *inode, int type)
 	 * Assign the pointer if it's not already assigned. If it is, then
 	 * free the context we just allocated.
 	 */
-	if (cmpxchg(&inode->i_flctx, NULL, ctx)) {
+	spin_lock(&inode->i_lock);
+	if (!(inode->i_opflags & IOP_FLCTX)) {
+		VFS_BUG_ON_INODE(inode->i_flctx, inode);
+		WRITE_ONCE(inode->i_flctx, ctx);
+		/*
+		 * Paired with locks_inode_context().
+		 */
+		smp_store_release(&inode->i_opflags, inode->i_opflags | IOP_FLCTX);
+		spin_unlock(&inode->i_lock);
+	} else {
+		VFS_BUG_ON_INODE(!inode->i_flctx, inode);
+		spin_unlock(&inode->i_lock);
 		kmem_cache_free(flctx_cache, ctx);
 		ctx = locks_inode_context(inode);
 	}
diff --git a/include/linux/filelock.h b/include/linux/filelock.h
index 37e1b33bd267..e23cbc562534 100644
--- a/include/linux/filelock.h
+++ b/include/linux/filelock.h
@@ -233,8 +233,12 @@ static inline struct file_lock_context *
 locks_inode_context(const struct inode *inode)
 {
 	/*
-	 * Paired with the fence in locks_get_lock_context().
+	 * Paired with smp_store_release in locks_get_lock_context().
+	 *
+	 * Ensures ->i_flctx will be visible if we spotted the flag.
 	 */
+	if (likely(!(smp_load_acquire(&inode->i_opflags) & IOP_FLCTX)))
+		return 0;
 	return READ_ONCE(inode->i_flctx);
 }
 
@@ -441,7 +445,7 @@ static inline int break_lease(struct inode *inode, unsigned int mode)
 	 * could end up racing with tasks trying to set a new lease on this
 	 * file.
 	 */
-	flctx = READ_ONCE(inode->i_flctx);
+	flctx = locks_inode_context(inode);
 	if (!flctx)
 		return 0;
 	smp_mb();
@@ -460,7 +464,7 @@ static inline int break_deleg(struct inode *inode, unsigned int mode)
 	 * could end up racing with tasks trying to set a new lease on this
 	 * file.
 	 */
-	flctx = READ_ONCE(inode->i_flctx);
+	flctx = locks_inode_context(inode);
 	if (!flctx)
 		return 0;
 	smp_mb();
@@ -493,8 +497,11 @@ static inline int break_deleg_wait(struct inode **delegated_inode)
 
 static inline int break_layout(struct inode *inode, bool wait)
 {
+	struct file_lock_context *flctx;
+
 	smp_mb();
-	if (inode->i_flctx && !list_empty_careful(&inode->i_flctx->flc_lease))
+	flctx = locks_inode_context(inode);
+	if (flctx && !list_empty_careful(&flctx->flc_lease))
 		return __break_lease(inode,
 				wait ? O_WRONLY : O_WRONLY | O_NONBLOCK,
 				FL_LAYOUT);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 7c2aa286ef87..314a1349747b 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -655,6 +655,7 @@ is_uncached_acl(struct posix_acl *acl)
 #define IOP_MGTIME		0x0020
 #define IOP_CACHED_LINK		0x0040
 #define IOP_FASTPERM_MAY_EXEC	0x0080
+#define IOP_FLCTX		0x0100
 
 /*
  * Inode state bits.  Protected by inode->i_lock
-- 
2.48.1


