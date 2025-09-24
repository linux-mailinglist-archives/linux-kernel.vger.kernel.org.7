Return-Path: <linux-kernel+bounces-830436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08D42B99A70
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 13:51:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA07E3A69A6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 11:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E8D92FE591;
	Wed, 24 Sep 2025 11:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UB9uPCkF"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124D9275B05
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 11:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758714669; cv=none; b=M5geazTIymm4NHOG6U3sv98yoji3AqQHqHtwja1xUNVhTbIi9USE71whRryg15VuDPfPN7Hu3LR7dqsL9A7+CW410A8yshJpLzQwmfaCpkSVNLUGPfWoBhkP5PxMPONgpLJMyxjs8a5Xsj074DE/+0fJ5V6bwqgykXzqnlfZUAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758714669; c=relaxed/simple;
	bh=sMpMTCHL318ik6vynlaPqZHJ3YUjKajXTIqWy73CgGE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fOwQQsPpCx5IsmLc8xfA8RrYCDRhUaoGNdcsX162b5MLq+wzpZHSdsr7hy+4lbpaOLccyDkmnfOs/qLXkXM/psfNTPatgbfGb22YqyUVAeDfEMfUTUo4Xm+pVzY9gbR+7D2/g9hnlFnb1qzctoi8umPVUTqERCxZ53OWJRu6Q7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UB9uPCkF; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-77e6495c999so5263610b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 04:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758714667; x=1759319467; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AdemVkqDIFv6mvv4r15R9buAsMv1Uh4QcRMWgVwjFE8=;
        b=UB9uPCkF4fyP8j2H6omASOnmrU0ySt7nAft6yqGFxp4Z9JdENnJIGGx+znRQbwMcOA
         zraG9ETmBPfU38Xih2gzHGGugvoTD6vhedpVtWLVZGT5Y/QP+kxp5u81m1mV8ALTotzt
         h9nG8I2lYrvvjIzUoOE8JyUHhV2xAWTUuIA/99Qy6PyzFaxLesE3IVSB8bTzrrr3rJhG
         1mJBFQknQeDpYM3ghNfXtyRPmKErLXi47fsMCFvM2gntbACcbxq8wzEcgX1Wg0TFZ/Tp
         tVqkSGxDK0VaCZyarPkKHsdKLZA2JIshGpceC+66mlJ3P3iwQwFet/gqRp871pI09guD
         x3RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758714667; x=1759319467;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AdemVkqDIFv6mvv4r15R9buAsMv1Uh4QcRMWgVwjFE8=;
        b=i9W6u9SpjX5K5R+Nxbb1Pc2SxbSu3Tlh7PptCwVXQpYlwlh8+vkMwZLezMIMVm5+qW
         4A4fq7pDmGQyTRU5HgZhNcXe8mTHTzYK9LhOJvJ1H0NTdAMWQgW2WaflWYa3PQ+FAiGH
         upccrautXihVd1PCsLZ06x3u/3M0esw1E7m/iNXL9tdM65QnkAvJZHdKTlLJ85TqFqlH
         xTUBC0hFxMB85CBL1bT2ngRmj0eFKUL1u8e3MSjC+Fs8HT7v3Fnr2CoVff9kh6ZYFhYO
         IsRM4vf057JdRP+0raecR6Fw/AvWpB9FB4sMFlzfAxwfsGw7scpnzcCEL6TkD2vr3mP+
         KITA==
X-Forwarded-Encrypted: i=1; AJvYcCV1C4UvGOxNZDgZpfj3FFjQcqFpDOldCgla3Bd6u9JeTJQmC2JYynfcbag3hvPdyNRHI1Pnds/UR2Ez7fM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6pDJSLkfhib4+Q0sGVPGZTqRINw6mGVWpFY6tzmltapOxC6fM
	7iNDAKPIDzAAsfbU7NQ6UUeEDjNeb3d5ieicEe00XEqrastrOoYFkLt8
X-Gm-Gg: ASbGncsmxlMoXx7NwbprPG67UhNHWd0zCuud/zVh0rcXVPTFN+iqjWqVXu+aCLoSQ+V
	n5YqcwtzscyWzY/JKapHCY1APXuj+cId85zXPeIGpAsu2VfXxYmtxnbxgz4kj5bIZyhRnS3l5Ad
	v6zjW96U6RzA2aGG20No98K2OjdJ2tSeAuEh+QY6rpQP/B2KwZB4219tgXfjVAnHAnNPwNE3Sv7
	sRDbVz/vxmOw5XU6IU546LVkm40dciZ2sdsTNxHa9Hps9VkHyZ4AOJxR41myICAXNuSwaw48dkj
	ZXZdTnfe+cdmoGXArrZpAdj/oaJYq+OA5tm3aQqD1PfJ7bNdrn9nmdvartMUPZ56/L1Zi2QcXwm
	70N1UrneLPKqfe9n7+TG4jlcF90dE8zb/0CReBphyE+aiZn6RPIortO9sXXU3AWqDgdTGgH+90+
	jjkVMD7CyyGahM1w==
X-Google-Smtp-Source: AGHT+IHufTiK/baJS9Oy3ntOrLfKf9tdtE8l8xl6OU+bWCyFqVpTcNJMnarEK1TcF7eHmncL6YrTQQ==
X-Received: by 2002:a05:6a00:3c8b:b0:77f:2eb8:5959 with SMTP id d2e1a72fcca58-77f53aeb466mr6942136b3a.29.1758714667308;
        Wed, 24 Sep 2025 04:51:07 -0700 (PDT)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:3094:b157:e484:932e:7ded])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77e0bb98790sm16151926b3a.9.2025.09.24.04.51.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 04:51:06 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org
Cc: jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot+9eefe09bedd093f156c2@syzkaller.appspotmail.com
Subject: [PATCH v2] nsfs: handle inode number mismatches gracefully in file handles
Date: Wed, 24 Sep 2025 17:20:58 +0530
Message-ID: <20250924115058.1262851-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace VFS_WARN_ON_ONCE() with graceful error handling when file
handles contain inode numbers that don't match the actual namespace
inode. This prevents userspace from triggering kernel warnings by
providing malformed file handles to open_by_handle_at().

The issue occurs when userspace provides a file handle with valid
namespace type and ID that successfully locates a namespace, but
specifies an incorrect inode number. Previously, this would trigger
VFS_WARN_ON_ONCE() when comparing the real inode number against the
provided value.

Since file handle data is user-controllable, inode number mismatches
should be treated as invalid input rather than kernel consistency
errors. Handle this case by returning NULL to indicate the file
handle is invalid, rather than warning about what is essentially
user input validation.

Reported-by: syzbot+9eefe09bedd093f156c2@syzkaller.appspotmail.com
Suggested-by: Jan Kara <jack@suse.cz>
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
 fs/nsfs.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

Changes in v2:
- Handle all inode number mismatches, not just zero, as suggested by Jan Kara
- Replace warning with graceful error handling for better architecture

diff --git a/fs/nsfs.c b/fs/nsfs.c
index 32cb8c835a2b..002d424d9fa6 100644
--- a/fs/nsfs.c
+++ b/fs/nsfs.c
@@ -490,8 +490,9 @@ static struct dentry *nsfs_fh_to_dentry(struct super_block *sb, struct fid *fh,
 
 		VFS_WARN_ON_ONCE(ns->ns_id != fid->ns_id);
 		VFS_WARN_ON_ONCE(ns->ops->type != fid->ns_type);
-		VFS_WARN_ON_ONCE(ns->inum != fid->ns_inum);
-
+		/* Someone is playing games and passing invalid file handles? */
+		if (ns->inum != fid->ns_inum)
+			return NULL;
 		if (!refcount_inc_not_zero(&ns->count))
 			return NULL;
 	}
-- 
2.43.0


