Return-Path: <linux-kernel+bounces-838598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 36EC7BAFB44
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 10:40:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 268207A5CCB
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 08:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 406E2284665;
	Wed,  1 Oct 2025 08:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g3yM1iOb"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0332283FEE
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 08:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759307994; cv=none; b=lCHEz3tMV81jRjz7nRoRWpJFNBRfBSpWz0ZAZ1LsfLcY+LAqAW/giceLf+j7DlHAhKiSeZsrgXGNpKLEn7R3fsjR1oEEAtDAHrVubK+kxtVT9+e/D01CXzFIfzdYViLxlLzDhMV5DTAOjhh44hnUXHOJZIvKpJ8udHPSen+jb1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759307994; c=relaxed/simple;
	bh=VyoVY4Q4GDe6RMQi5QGg4ffoiIPwM6SwqIJ2pC+aeyo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=q48Tevezy4rLFEiQyjap3bH+kQP/13KKTUtSs6pofogwdc5p/MSGWx7OFXJ1vk5hPD1Vps1KDjSIzbM8zYqEPLjDmQ0yXksI4b2BkgQ+6T69Vrr0YHmgSAkjItvL5Dvoqx59yN7mBcB4xZSz/J/m6qf9BJwYno2PmOsWdknHJ1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g3yM1iOb; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b5a631b9c82so2549578a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 01:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759307992; x=1759912792; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=D4FfG++OYH0UQ2cb2chNsj++JT4lH4Ovdjh6P4PE8Qc=;
        b=g3yM1iObHwRxcTDwKEb4hPnaH5qID9F2qO/PBYntzF0jaxWD7P+SV/5VQ3KFwxtu+N
         sqPq26lmHKC7XiFRj/qXOcn5oWzLr4zv7pz03nIbJLgx5WPgXFsjd63aFesxxJ67qDMw
         ySFCbPyH9sByfJZKjYIRhfgt+F+MlqRw6dR5Mq/Y+4eY/VCylI/JtiiixVWnB81wts1K
         nXaBmrPSdIzOSFzO0Y6VHjWYbWmiU7VsCkjrIAhLda5k70ObaAkrUz1VUMv7qdRPvaNq
         M17uu9Xqwq1kawq9QDiLIgyiISmLgK5rjESsQKWzCPNPzJ9zX1HxaZ8gmOsatG7VRrrL
         YsoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759307992; x=1759912792;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D4FfG++OYH0UQ2cb2chNsj++JT4lH4Ovdjh6P4PE8Qc=;
        b=EeLNCBKC+QuFfJWyI60sqWXuX//CapS46dzpbsikm2MsHUVu8824TB2/f50mobshon
         l17AFxwvJihzEQ1+Po0JP/+bCjzTWUMqeldfVyGmngaQnECPvTR0uifbMKhwQpJ/0++H
         oLW96XSHTWFMdRD9m+hAuU2m2T1J5qqxJp1tJTbOCNUJC0hIvf0V20IX0ZkGeEQhtY1B
         r/vz7cIX10pddCCvlfTq/giZ4493GaO4nDY9T1/HX2uEU6blFbPzlNLsQhCed9kVOdTU
         4IHY6g79WYBXDYu4nP41v1tKXM1btjE+lancXRe5g+b1wzE1cuuWy7XwflIXxEwe6H7K
         iATg==
X-Forwarded-Encrypted: i=1; AJvYcCV65n6lxZeUNtDQbfwQf1320ICMGUhdLQTOmXSm6NVgtt5mIC/DPP9Rv3HVIx0AX0LSADsgsO5JFMdt97Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YycSOalhAymsNjBpKXpZFA5TDnWi0DiFYwVOsWWa0M2AFhGZ1zJ
	1F18xVVjG6atepQXFn2JRUW3JsXT79WDH7HCNp55g6YnaeReSl5UIHv0
X-Gm-Gg: ASbGncvqfiv1/2tXn9PT7kJwwJXfPbTcNgDaLryBNaRmTk3Cheo2+yiBpWr5pOMpoeO
	+zAEwAriRQfhjWf7qR9okHlAM16wakuPQH8jx4Kn+OSAwNd9kiePhq08o7WbG24JuY+Qbhg/lHT
	UvP4ITE/3jHbp63sfJKvSEXiqZ6tb9DescIwqfuBGj/ntIAs1QJqnqOkDOSBfb1oVEURYpxyKro
	+aDBeO9/8ObawakDu2v9DlS9hYWLnavNMrBbckdumZ36GdjjpNSnULBnnjf+rCt5OKnOVJYnMJ5
	TgE4gkuxrU2OzirTQ7bfAsqWZmJvn1HtMs8BZkuzagzpfmelHcJnzMli0ihkVNwT9A19jjPZJuI
	kw3wT+XAHgofPsoKW/vSepokuYef0t1Uwt+z8cRfaI2eDCqyyUpAWgnOqs68BQyWqs2ink4ZQmg
	==
X-Google-Smtp-Source: AGHT+IGDAA5bS+9IItYzYTvHt755RN1Ht/RXQRCnt03we0AczFtZuNBaAi5b7oWoS/mnvJ+e//+JYg==
X-Received: by 2002:a17:903:11c7:b0:269:8407:5ae3 with SMTP id d9443c01a7336-28e7f4b6843mr37492805ad.54.1759307991850;
        Wed, 01 Oct 2025 01:39:51 -0700 (PDT)
Received: from ti-am64x-sdk.. ([157.50.93.46])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed6ad1d45sm179473835ad.141.2025.10.01.01.39.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 01:39:51 -0700 (PDT)
From: Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>
To: Kent Overstreet <kent.overstreet@linux.dev>,
	Jonathan Corbet <corbet@lwn.net>,
	Carlos Maiolino <cem@kernel.org>,
	David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>,
	linux-bcachefs@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Cc: linux-kernel-mentees@lists.linuxfoundation.org,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com
Subject: [PATCH] fs: doc: Fix typos
Date: Wed,  1 Oct 2025 14:09:31 +0530
Message-Id: <20251001083931.44528-1-bhanuseshukumar@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix typos in doc comments

Signed-off-by: Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>
---
 Note: No change in functionality intended.

 Documentation/filesystems/bcachefs/future/idle_work.rst  | 6 +++---
 Documentation/filesystems/xfs/xfs-online-fsck-design.rst | 2 +-
 fs/netfs/buffered_read.c                                 | 2 +-
 fs/xfs/xfs_linux.h                                       | 2 +-
 include/linux/fs.h                                       | 4 ++--
 5 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/filesystems/bcachefs/future/idle_work.rst b/Documentation/filesystems/bcachefs/future/idle_work.rst
index 59a332509dcd..f1202113dde0 100644
--- a/Documentation/filesystems/bcachefs/future/idle_work.rst
+++ b/Documentation/filesystems/bcachefs/future/idle_work.rst
@@ -11,10 +11,10 @@ idle" so the system can go to sleep. We don't want to be dribbling out
 background work while the system should be idle.
 
 The complicating factor is that there are a number of background tasks, which
-form a heirarchy (or a digraph, depending on how you divide it up) - one
+form a hierarchy (or a digraph, depending on how you divide it up) - one
 background task may generate work for another.
 
-Thus proper idle detection needs to model this heirarchy.
+Thus proper idle detection needs to model this hierarchy.
 
 - Foreground writes
 - Page cache writeback
@@ -51,7 +51,7 @@ IDLE REGIME
 When the system becomes idle, we should start flushing our pending work
 quicker so the system can go to sleep.
 
-Note that the definition of "idle" depends on where in the heirarchy a task
+Note that the definition of "idle" depends on where in the hierarchy a task
 is - a task should start flushing work more quickly when the task above it has
 stopped generating new work.
 
diff --git a/Documentation/filesystems/xfs/xfs-online-fsck-design.rst b/Documentation/filesystems/xfs/xfs-online-fsck-design.rst
index e231d127cd40..e872d480691b 100644
--- a/Documentation/filesystems/xfs/xfs-online-fsck-design.rst
+++ b/Documentation/filesystems/xfs/xfs-online-fsck-design.rst
@@ -4179,7 +4179,7 @@ When the exchange is initiated, the sequence of operations is as follows:
    This will be discussed in more detail in subsequent sections.
 
 If the filesystem goes down in the middle of an operation, log recovery will
-find the most recent unfinished maping exchange log intent item and restart
+find the most recent unfinished mapping exchange log intent item and restart
 from there.
 This is how atomic file mapping exchanges guarantees that an outside observer
 will either see the old broken structure or the new one, and never a mismash of
diff --git a/fs/netfs/buffered_read.c b/fs/netfs/buffered_read.c
index 37ab6f28b5ad..c81be6390309 100644
--- a/fs/netfs/buffered_read.c
+++ b/fs/netfs/buffered_read.c
@@ -329,7 +329,7 @@ static void netfs_read_to_pagecache(struct netfs_io_request *rreq,
  * the netfs if not.  Space beyond the EOF is zero-filled.  Multiple I/O
  * requests from different sources will get munged together.  If necessary, the
  * readahead window can be expanded in either direction to a more convenient
- * alighment for RPC efficiency or to make storage in the cache feasible.
+ * alignment for RPC efficiency or to make storage in the cache feasible.
  *
  * The calling netfs must initialise a netfs context contiguous to the vfs
  * inode before calling this.
diff --git a/fs/xfs/xfs_linux.h b/fs/xfs/xfs_linux.h
index 9a2221b4aa21..fdf3cd8c4d19 100644
--- a/fs/xfs/xfs_linux.h
+++ b/fs/xfs/xfs_linux.h
@@ -145,7 +145,7 @@ static inline void delay(long ticks)
 /*
  * XFS wrapper structure for sysfs support. It depends on external data
  * structures and is embedded in various internal data structures to implement
- * the XFS sysfs object heirarchy. Define it here for broad access throughout
+ * the XFS sysfs object hierarchy. Define it here for broad access throughout
  * the codebase.
  */
 struct xfs_kobj {
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 601d036a6c78..72e82a4a0bbc 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1040,7 +1040,7 @@ struct fown_struct {
  * struct file_ra_state - Track a file's readahead state.
  * @start: Where the most recent readahead started.
  * @size: Number of pages read in the most recent readahead.
- * @async_size: Numer of pages that were/are not needed immediately
+ * @async_size: Number of pages that were/are not needed immediately
  *      and so were/are genuinely "ahead".  Start next readahead when
  *      the first of these pages is accessed.
  * @ra_pages: Maximum size of a readahead request, copied from the bdi.
@@ -3149,7 +3149,7 @@ static inline void kiocb_start_write(struct kiocb *iocb)
 
 /**
  * kiocb_end_write - drop write access to a superblock after async file io
- * @iocb: the io context we sumbitted the write with
+ * @iocb: the io context we submitted the write with
  *
  * Should be matched with a call to kiocb_start_write().
  */
-- 
2.34.1


