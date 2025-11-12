Return-Path: <linux-kernel+bounces-897001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04170C51C9D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 11:55:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AE693ACB9B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 10:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B0A83054EB;
	Wed, 12 Nov 2025 10:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fFnW01iJ"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C87186294
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 10:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762944299; cv=none; b=W8SP6PhkAc4soWKSB6AEAdKrxJEX8V6SWzqwfJlA77SLvc7b6vpQMg3TzZ/sKuLG3Some2t2il8X+cBPdaBP3+Pdyc/mhOtbRnyjkBCtlGmm+UZo9y/vO2Njhj0j9s73zRw4Fa2GwBqe2utTokvCg1z8WDpSXECaXMadn6SfFG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762944299; c=relaxed/simple;
	bh=jVVHSN1Ia0m7suhpLhdBRS0i/NuFYMLccQiGIpH0n5c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WSndEnjJ0iDkCzPrdxWw71ol0xz3dr9Wb1YcbzGD2v0VApt7cjGgT5hrsRV4qvaHUCmSZYj5RCHaHQRf4VykqF25FjbB9sPo4Y5zvabV3vD0VTTlJ0+O8Muj9LzG1ppXn8OjgJjgJiJjP1mwG98aWFhgWZML5u0I336dONMpwyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fFnW01iJ; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6418738efa0so1171920a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 02:44:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762944296; x=1763549096; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=diWnm0JyJYGFiZDAem/3nW/f8owMOyhfRK2JI7Y37Qc=;
        b=fFnW01iJDV+QHZZ67rfLMq41Y6CMQC+BwcnhuDLjs8g64XNauOacOf0TSKFUWclx4k
         AQsA2Hqng+o7coW3rVVfIIzXQLfufvcghscMYBK2Sh8pP3rgUFQHkqrwVS09i0dSK45I
         9yW4r+RfEx/6gJTxAjSRbLQjyN6IEyKER9DiU8eqzoRZClmQUgaDiJPgyJnbf3Smxy7g
         N3lAlyeKvMUqFQe0u68XE2q1gYeVqFdgAE3oHFdxu/P99eujTflTMWPrJ9RR4dlYxA6y
         OVuhsiILxuJfFkENhLxgnZ+MTPD+gR4r6baAH+qgrpRJTk2KBuOJO+s088HOtn6L/Sj9
         mDag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762944296; x=1763549096;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=diWnm0JyJYGFiZDAem/3nW/f8owMOyhfRK2JI7Y37Qc=;
        b=badyAl3FVtOmkW8shdhNH3LPMczh5CH7oLxK7CgZm8nVTD55spKySNoZBXwolToSFH
         89NcJAz116EzB3z/bYP1vBhkThOvb3i/gOdQAURQTcjzTFOh6y8Mx1un2DaHyE7ev4/s
         8P/N63ugItd+/Y86OdSseasB1oeGqWc0Z2NFmFR3EXk8eCbcMuLWnwZQD4UhLOtmEreO
         /gKHKueMZGXAGEL65EqXKrR1bkt+p7hU910la8y2NIfutgRg+zwH6DErtqZuHJGXtXGT
         BZWkxi1Vv4qMTGXSKZVcuvg5nJ0KAB0ZdlIZ9usmpTH9l06vcNbLsvfIPvji7jrWCFqv
         zJxA==
X-Forwarded-Encrypted: i=1; AJvYcCWdG5C8uSkoQwq1wea0ZOwl9R6LkPb4Rpytqmanz/b0/Ne892EfH0kegOgAxRncbb/6Enyvb9E9s3f0vjA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGIk84NTlkArMSXN3A9ZwRFP3+nK10AY4njv2uI2hXIKbDLOwk
	hRoJoLEzmYgm3n+pmNFRCGxTB2Jo19chiRQ8VPi3tncZUfIWaAjJwrsp
X-Gm-Gg: ASbGncsjqNOLJtJq85P7AV1ZXa2//M28g4cCqm1ljO5U9oeVspMN2V1XOy+/a5ABkPW
	B5X+dgc2+9hRpsxXLQz6Z5qlxgZWsqHwHL7nCG4Sw1Mf8rlOt2mjz9jA8lVoIb3ZjLor1uFgrXO
	LLT02IyGzNzzqy02zcOg6ARASyslvUnwBV67mKTECbo3OJBI9cYtGo4Fl+PcGz6/Nb7sW9RkrUB
	cd5ZC8naZkkRbX607At4lzKMnJtviP/fuFaXDSjBfYrGK1x2dgW0UdGvkqVS0x0K6my1hYaZ/Jh
	Y5mRM29IqayKg9o2YbfMlhblV9mcaWeS4/YQ4GOYCVzzAUT2CVt8hl7sAJmutgf11WCSYlAqdIO
	BLpL5HMaKodZy5pbB43qV6EZkJYB1PEXbFJ4FzHh0pZP1xEVqWFLUK0j/W/OCMIw9qtHZH0liaY
	R4UPrY1mb+DUqmuoEwTwfChhedb6dipC+B10hZ2x4ZavsGULeq
X-Google-Smtp-Source: AGHT+IFapCigowYKP/7reL8ipy3F7qwfbeibcY5jbBzVXg2n5X0ZXayk+PDSexWzKxxsD7ULI4wIuw==
X-Received: by 2002:a17:907:da6:b0:b4b:4f7:7a51 with SMTP id a640c23a62f3a-b7331b3bcb6mr280456166b.62.1762944295535;
        Wed, 12 Nov 2025 02:44:55 -0800 (PST)
Received: from f.. (cst-prg-14-82.cust.vodafone.cz. [46.135.14.82])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bf9bc874sm1606655466b.54.2025.11.12.02.44.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 02:44:54 -0800 (PST)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org,
	jlayton@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v2 2/2] fs: track the inode having file locks with a flag in ->i_opflags
Date: Wed, 12 Nov 2025 11:44:32 +0100
Message-ID: <20251112104432.1785404-2-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251112104432.1785404-1-mjguzik@gmail.com>
References: <20251112104432.1785404-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Opening and closing an inode dirties the ->i_readcount field.

Depending on the alignment of the inode, it may happen to false-share
with other fields loaded both for both operations to various extent.

This notably concerns the ->i_flctx field.

Since most inodes don't have the field populated, this bit can be managed
with a flag in ->i_opflags instead which bypasses the problem.

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
do_dentry_open().

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---

v2:
- fix smatch warning:
./include/linux/filelock.h:241:24: warning: Using plain integer as NULL pointer

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
index 37e1b33bd267..9dc57b3dcfae 100644
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
+		return NULL;
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
index b803a592c07e..b3d9230c310f 100644
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


