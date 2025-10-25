Return-Path: <linux-kernel+bounces-870116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E3ABC09F74
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 22:00:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 729B24E20EA
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 20:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6FBC27E054;
	Sat, 25 Oct 2025 20:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kArtkmSe"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC3020A5EB
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 20:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761422430; cv=none; b=fIxmc80AVZ2wca77zFrAT0NH1Ebyy4cLXpv+w2P61zgMEV2cUnTAvB1Y+dgbbyCr1QW2LP7Qd7IVm+KEjpDKLg539EoCSHvBdp89GoPUGEux8Iqx4tzbIgQKCfFdZhIs64TIH90pUD1s7Cq00MCrEmwR3CXjGpozgh1ZzifHzxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761422430; c=relaxed/simple;
	bh=gTK2JfluqP2TVQ+J2BjTjg97nxpnL8hWo8TWogHz7iM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OjmZ5uzEVkwE0Cs5JlhfkXYf+PJKDIusSbUQtl5TnpNIfcEFCXDYz64gT+0gvfqKCRiPgLim3Bj6UnqwA/esxK31ld3wowbsxX+bEucOC2BwdZIvM1DeE4S1yoYA7J6nqTDya6vGJTyiVePPxTYhQpIGNHPihUgitZNzyq2Ybsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kArtkmSe; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b6cf3174ca4so2206280a12.2
        for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 13:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761422428; x=1762027228; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QaYeMKwI1BF49vrEVOohJsMVytqLhSnbaX71rZear/E=;
        b=kArtkmSeAH8nFkbRaxl1aJ8fFoybLL3W26wGQKwSPzXHJhHxofOszcuyEfTnUvsUIO
         of/W33ngea63PmPoNtSjqS5CoqLCorhmlRI+G8ahALjVC1+ha7Muhu1/utZ2He4o/cuE
         akXuXJ0AY8r/V/qvYoU2MwqsSWPaPLTB/p9sUB5AzGJDckvukxzsKswqz8ZwwSVKSpQB
         RaLN+gtPTIJdbB1KyAlQ29+q7OfQHu0tbDu/afquzH4gOFNnXEE1/8TZRpVyk3YISdMU
         BiN0O5NsERM9LR1/LZ0dArAt/BU9i/F3lKYQjhIGPiKDb1jAeSrPdmzOTcLJ/RhVRwfw
         plJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761422428; x=1762027228;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QaYeMKwI1BF49vrEVOohJsMVytqLhSnbaX71rZear/E=;
        b=AvYkJ9NMFQSa2ichlt5u7u717W6AeLvdbj2RPUcfHw9pYPqCMYOzsFO3vjXgbhbQno
         NUgP+uCmh0lZFM8JW6IU/Pri3cs+eYlgDIUDZOK8ljSc3tXhU1pt9YAXpK5yXZN5eLbu
         2KJ6o8LFEdyr1+zuln5qsXEhUF2rj7NFd9uXmeDUvCvK2+R1svD4qHnqaqpGLL2GApDJ
         +tfn3cl1eIzRW4DXYejJvJUG1lRcs+17RnrSSEHg/m6F3Yjlf1kpCs18AEsjcyP8omgK
         A1nT0tj3tW2/9OPmIArbPojzXDvXUtRoTdJ1Izr5kfsH0EdF0F+69DQHKelmT9N3kUKi
         diHA==
X-Forwarded-Encrypted: i=1; AJvYcCV/SICMokpOmw5Bd1kA6PTuZ/Oy9fZfOID4LixtBvODD/kbA147ZK9ZOxuGBmAL08C3atrFzr/xqwneo5k=@vger.kernel.org
X-Gm-Message-State: AOJu0YygOiwoweSHTURI1F+K7iecsmOXFlk4eWX3He8pdCQdAFMh7y3G
	Cdg2hNvwVwhEWm1jj3dzWArFgdcHfjDUkFRMpGW6qCA6YG4RyUMGHKox
X-Gm-Gg: ASbGncsOFgzUVfKzLqiXxriEn2U9dvKwSijNZFSWo/0/mrWLBzrQk9CwH0L6WSvIVuH
	LQxAC8XZGsBvTNsvfzc8eDlXVoIQXmRoh9jt/+6H+9HvEh7Uf468FuQuPUpeB2GmExpzKlHo1X1
	FVvK4ulUMbXZfSvTok2dM2zG4DFTWZY/UTC8cjph2e5xbq0G2b4/9syCd1QAA5gXHd8VxCuBcNt
	jhP/fKHpFzIaXzveQ5g3QsZpQ/TgYuOGPPLPABjyqekybtBJrVB3gAw0XCKGmD9pDDO5cZAjHY5
	lqtdE1egq/PEpsR8P1YrxSl+mlbzZ0yIb9NPhvRaA45MvDjoOUg52S5TMAqDA0FqVOu53ATiG2+
	WzbPB42KvadipPqPSYDNQEBxSdDYG+yVTStksplrb49G5RvaMrRvniu+UEDV3cetKD1cP6qZk52
	v0EeZzcdxm6A==
X-Google-Smtp-Source: AGHT+IEvmm33i5yQ74Ry6lP4P6rB7QNWNDpbtf1i0gbKVWkTsxAaii5ceRUOfu1A2ad8axHlPDDddQ==
X-Received: by 2002:a17:902:da88:b0:24c:9a51:9a33 with SMTP id d9443c01a7336-290c9cbc119mr409541635ad.22.1761422428005;
        Sat, 25 Oct 2025 13:00:28 -0700 (PDT)
Received: from Shardul.. ([223.185.39.235])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d273cdsm30677905ad.55.2025.10.25.13.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Oct 2025 13:00:27 -0700 (PDT)
From: Shardul Bankar <shardulsb08@gmail.com>
To: linux-btrfs@vger.kernel.org
Cc: clm@fb.com,
	dsterba@suse.com,
	linux-kernel@vger.kernel.org,
	shardulsb08@gmail.com,
	wqu@suse.com,
	fdmanana@kernel.org
Subject: [PATCH v3 fs/btrfs v3] btrfs: fix memory leak of qgroup_list in btrfs_add_qgroup_relation
Date: Sun, 26 Oct 2025 01:30:21 +0530
Message-Id: <20251025200021.375700-1-shardulsb08@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251025092951.2866847-1-shardulsb08@gmail.com>
References: <20251025092951.2866847-1-shardulsb08@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When btrfs_add_qgroup_relation() is called with invalid qgroup levels
(src >= dst), the function returns -EINVAL directly without freeing the
preallocated qgroup_list structure passed by the caller. This causes a
memory leak because the caller unconditionally sets the pointer to NULL
after the call, preventing any cleanup.

The issue occurs because the level validation check happens before the
mutex is acquired and before any error handling path that would free
the prealloc pointer. On this early return, the cleanup code at the
'out' label (which includes kfree(prealloc)) is never reached.

In btrfs_ioctl_qgroup_assign(), the code pattern is:

    prealloc = kzalloc(sizeof(*prealloc), GFP_KERNEL);
    ret = btrfs_add_qgroup_relation(trans, sa->src, sa->dst, prealloc);
    prealloc = NULL;  // Always set to NULL regardless of return value
    ...
    kfree(prealloc);  // This becomes kfree(NULL), does nothing

When the level check fails, 'prealloc' is never freed by either the
callee or the caller, resulting in a 64-byte memory leak per failed
operation. This can be triggered repeatedly by an unprivileged user
with access to a writable btrfs mount, potentially exhausting kernel
memory.

Fix this by freeing prealloc before the early return, ensuring prealloc
is always freed on all error paths.

Fixes: 4addc1ffd67a ("btrfs: qgroup: preallocate memory before adding a relation")
Signed-off-by: Shardul Bankar <shardulsb08@gmail.com>
---

v3:
 - Update Fixes: tag to correct commit SHA as suggested by Filipe Manana.
 - No code changes.

v2:
 - Free prealloc directly before returning -EINVAL (no mutex held),
   per review from Qu Wenruo.
 - Drop goto-based cleanup.

 fs/btrfs/qgroup.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 1175b8192cd7..31ad8580322a 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -1539,8 +1539,10 @@ int btrfs_add_qgroup_relation(struct btrfs_trans_handle *trans, u64 src, u64 dst
 	ASSERT(prealloc);
 
 	/* Check the level of src and dst first */
-	if (btrfs_qgroup_level(src) >= btrfs_qgroup_level(dst))
+	if (btrfs_qgroup_level(src) >= btrfs_qgroup_level(dst)) {
+		kfree(prealloc);
 		return -EINVAL;
+	}
 
 	mutex_lock(&fs_info->qgroup_ioctl_lock);
 	if (!fs_info->quota_root) {
-- 
2.34.1


