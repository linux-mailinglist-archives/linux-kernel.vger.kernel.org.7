Return-Path: <linux-kernel+bounces-821163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EC757B809E3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 17:36:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 92C404E333A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 15:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62DA13397D9;
	Wed, 17 Sep 2025 15:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="DNNQqBqh"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402FD30C0F4
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 15:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758123408; cv=none; b=A5vjRlAXDgZXjMVbuQuDh1ujq2zB0kdsR844+NR1bkHRs5wctOgDlCg9DvLqXliI1iOFrrvkZGBZIMOyuw9LOXCd/Rjj+HwspSCAQ3LLTXKVQ1UYNSQHfdVce6+jLE5bYENI5pB7JioxNxvrk6nRFiuZ3AL0Ky1YEfIYEKDPwm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758123408; c=relaxed/simple;
	bh=naA4RqzDfx1g/AEbG7TvoN6iOGRTBF6ERPg1ybfJwR4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VzdsD2s2HY4B5T/vvHRL3G+HlWA9JluKn0ZmOvEK1FpBaeDumm8P48v1GYaHjo+ciCwm9yswlkr8a2r3NRxT9hKNqguqceG20nXBvnSm3TSEDZfteNQsHol5/Q4MbNqkdw/clowWMfhCjtc6Lcxv8Wj5vYyLexanw5jG31RNJNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=DNNQqBqh; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b0428b537e5so934088766b.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 08:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1758123404; x=1758728204; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uOdyIgVKQVbcfZmIBDqiw6XRB+lRYJ/AtJANCJAzYnU=;
        b=DNNQqBqhL+C0CfYd2ixEo6vJvA3SHfW0UqQGehmgTEiqhO7B7bh7w9CTU8ZzpOb9+a
         C5X4d0lugaWscQy68aFRU56d1tHaWwDszv459fzYCPJ9IA/nie9pK0yJxsN3ZIXlRhnY
         sYoS/kCz4Y6ybAgcFj9hGLfBKC0EW45CmOqkjxsOmyeVUn06gMmyGvZ+dXlN/xllq4Qr
         FOlxpcNgOiB+U5Bvt4uZ1Htz40WossGm4kwO84hnnoJE/mZ3V0yhb6Rskp9XNFG9X8fW
         hMYmLsdCfPpN2VWkuAkfebLcwTkTeJNN3EKoN2B4sZMQJYTGqzdpAkCe2UBzsU5z5BrB
         kZUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758123404; x=1758728204;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uOdyIgVKQVbcfZmIBDqiw6XRB+lRYJ/AtJANCJAzYnU=;
        b=CxDqr47iegIReBndhkVNxaxuUujQBtiWtDnXmnB4irU1chJi07vQ1FF14nJu1g/uon
         HzlNXIeDICR4mQLn884bd9i91AD2rtaLhu7YPA0aU2IERn3bz9buHXikkdMopK932iyw
         ACzjQgVwbSPg16lz9TkNia6j2V/JvqtpZ+jO1ohZK7wg8rQee5DLfyxRAiNgAsrey4yu
         ChIDfOPB1T3KvkK6ZfesxJwuzXukII6V5RofV8PJ34+MkdadIBXEwiNE2S8pkgEkyYYe
         ThWMA3u7sh5RODF7Yz04VsFJG3BS7yztK8mUJ2FMtNf7Pf6AOwDxpCal6lbcqEmgozUG
         GVtA==
X-Forwarded-Encrypted: i=1; AJvYcCXwdUbWbZAcagyT7yuL8XYkFOFk7d9LZZPXb+Uss1ujxoa8J7VYJ+I7Tl9K310tG3enExFnO7sQasmyC+A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBSqoreDpDP13UVKcpY8YS2b+h9uHU1CR/rr8nxtUoIJbfwkwc
	SAgDzn3IQFDXTyiZkwK5kvfP5XrPI98muB1jnc0Krc7w42d47ECVAQAoswe3174JocE=
X-Gm-Gg: ASbGnct1FboD41NzaF8TY42nvZdt7eGavs3Jv9YG2g6HoUz7hTmKecBzgbLBqshjlY4
	PlgCdAFZe+lWNOZZwAfvEcSqtv76JQee57lYI2MME9eetbp7pO4Umkhr3hWSVwUykZStrgHtuS8
	jYQjhuAw3EWkZVDB5Na9Kz2HWwqD6HFIwhkFGMoM1wj+eNjkLFZ/NkaF05BxE6O1YW2rqF7YP4a
	huG+hCZM3NQKk1MIU/laJe6rgxr8ZH4NbmTUTM1NDRI1t+wAqvAmUBOIURm4fAV2utx8cLad7er
	zCh/mSnEY58YcfnQFnMikEuieDjm4igYYeDY1rSiEmeFuPVeTgqrkClwjIWjKcI78wEVC5/gci/
	58XMZXeosX04opvzEl/QvRSCXkUd7HSkMmIJVVda7I59uGfHkOK4PMigXCL/8+EBGYyWOY5BqgB
	4iJTJLqriQ4Jm3aE7+VldZsBKWfXcoQ7XOHQ==
X-Google-Smtp-Source: AGHT+IGMRHdj1slwV4bLVyYkD0N4kZa7TBulRZA4XTeW2hkIidh5BryId4F+eQgbBdrZ5RTvgJ82Ng==
X-Received: by 2002:a17:907:3d86:b0:afe:fb5a:6428 with SMTP id a640c23a62f3a-b1bb559b7d7mr302200966b.22.1758123404446;
        Wed, 17 Sep 2025 08:36:44 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f055a00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f05:5a00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b19a4c2d3cfsm235212866b.26.2025.09.17.08.36.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 08:36:42 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH] fs: add might_sleep() annotation to iput() and more
Date: Wed, 17 Sep 2025 17:36:31 +0200
Message-ID: <20250917153632.2228828-1-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When iput() drops the reference counter to zero, it may sleep via
inode_wait_for_writeback().  This happens rarely because it's usually
the dcache which evicts inodes, but really iput() should only ever be
called in contexts where sleeping is allowed.  This annotation allows
finding buggy callers.

Additionally, this patch annotates a few low-level functions that can
call iput() conditionally.

Cc: Mateusz Guzik <mjguzik@gmail.com>
Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
For discussion of a loosely-related Ceph deadlock bug, see:
 https://lore.kernel.org/ceph-devel/CAKPOu+-xr+nQuzfjtQCgZCqPtec=8uQiz29H5+5AeFzTbp=1rw@mail.gmail.com/T/
 https://lore.kernel.org/ceph-devel/CAGudoHF0+JfqxB_fQxeo7Pbadjq7UA1JFH4QmfFS1hDHunNmtw@mail.gmail.com/T/
---
 fs/inode.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/fs/inode.c b/fs/inode.c
index fc2edb5a4dbe..ec9339024ac3 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1279,6 +1279,8 @@ struct inode *inode_insert5(struct inode *inode, unsigned long hashval,
 	struct hlist_head *head = inode_hashtable + hash(inode->i_sb, hashval);
 	struct inode *old;
 
+	might_sleep();
+
 again:
 	spin_lock(&inode_hash_lock);
 	old = find_inode(inode->i_sb, head, test, data, true);
@@ -1382,6 +1384,8 @@ struct inode *iget5_locked_rcu(struct super_block *sb, unsigned long hashval,
 	struct hlist_head *head = inode_hashtable + hash(sb, hashval);
 	struct inode *inode, *new;
 
+	might_sleep();
+
 again:
 	inode = find_inode(sb, head, test, data, false);
 	if (inode) {
@@ -1422,6 +1426,9 @@ struct inode *iget_locked(struct super_block *sb, unsigned long ino)
 {
 	struct hlist_head *head = inode_hashtable + hash(sb, ino);
 	struct inode *inode;
+
+	might_sleep();
+
 again:
 	inode = find_inode_fast(sb, head, ino, false);
 	if (inode) {
@@ -1605,6 +1612,9 @@ struct inode *ilookup5(struct super_block *sb, unsigned long hashval,
 		int (*test)(struct inode *, void *), void *data)
 {
 	struct inode *inode;
+
+	might_sleep();
+
 again:
 	inode = ilookup5_nowait(sb, hashval, test, data);
 	if (inode) {
@@ -1630,6 +1640,9 @@ struct inode *ilookup(struct super_block *sb, unsigned long ino)
 {
 	struct hlist_head *head = inode_hashtable + hash(sb, ino);
 	struct inode *inode;
+
+	might_sleep();
+
 again:
 	inode = find_inode_fast(sb, head, ino, false);
 
@@ -1780,6 +1793,8 @@ int insert_inode_locked(struct inode *inode)
 	ino_t ino = inode->i_ino;
 	struct hlist_head *head = inode_hashtable + hash(sb, ino);
 
+	might_sleep();
+
 	while (1) {
 		struct inode *old = NULL;
 		spin_lock(&inode_hash_lock);
@@ -1826,6 +1841,8 @@ int insert_inode_locked4(struct inode *inode, unsigned long hashval,
 {
 	struct inode *old;
 
+	might_sleep();
+
 	inode->i_state |= I_CREATING;
 	old = inode_insert5(inode, hashval, test, NULL, data);
 
@@ -1908,6 +1925,7 @@ static void iput_final(struct inode *inode)
  */
 void iput(struct inode *inode)
 {
+	might_sleep();
 	if (unlikely(!inode))
 		return;
 
-- 
2.47.3


