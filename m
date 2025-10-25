Return-Path: <linux-kernel+bounces-869872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B75C08E78
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 11:30:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2DBFF4E3D67
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 09:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9540F2E370E;
	Sat, 25 Oct 2025 09:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cr/+UCYZ"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592782E284A
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 09:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761384606; cv=none; b=WbXcZSl30sptr7RkukYOjSYrs5bRwSE3WvPUxyG2QpLe881jovnGPMLqW0Ytze7bWkAy8lvSmrgx/dDQDj/yzQ/Cq0PTaD2hffYZwWHyq95GFv94O4Njwrt/HuIycP244U1iIHLhnfrjOnG6cItPCWuoxtXJu3keDt4yRlmLBQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761384606; c=relaxed/simple;
	bh=xTi9iK0cexilxltVMDnA5hECNlMR2KScYHdB9Pq9vS4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=t8BP4hEkLofed3ygyb6X+ZQZrz3+mozaHJbiknjMXCucaD4LtHMhIUyml4M5/OePjdxkl/y36ckdeyGakJWP07RUFQ521dT3P5SvYzYnV1qA0Dru+Y4+U1Z35E0LXS46mLPnMfE/hEDlCid5uw8HlwxmBfNljhzmjLNa4Reaa8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cr/+UCYZ; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-290ab379d48so27581205ad.2
        for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 02:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761384604; x=1761989404; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CzOdTahmgATvyBKKNNGk+6ocxaYqIIvV/CA7uucejZ8=;
        b=cr/+UCYZyy3VYyfPXq7/nt2s13kD1hIrmn0/yF/0yltigPxqoRkZijzO27hA/nDJVR
         /JPYc3RO4Sap44yuddp13RX/GAz8qZEZgto4Jn4Z4qS4MqwtoJX2E78rqs9rFnbcbUWx
         UBrPugwtL9aGaNf1ofoKsYpuXmUQB6i3EqlTZzP0llMxieNPIx/NdP7BgzjlAh6kcdAy
         Es9qb2xyy8PFmSw3gkD1nEBw5JN+Afao6NcsUq5h8c2yQBmoBEOAn65JZ7XRNqqS6Vfa
         lybOeQeMM4RymKQQ4PIyJ823dpiiuQlWQmIXIA0F68LlvXZ6D+sRw/0mlAZPWHWdjjfW
         DiHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761384604; x=1761989404;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CzOdTahmgATvyBKKNNGk+6ocxaYqIIvV/CA7uucejZ8=;
        b=QBHkPeUsaX+pP4fcqFEAbjkrSEMFQmnAgYHtopUdPmLkGyV2zvSltqcj6voBnaVgax
         rG8VuSEeYnPpDXPh8RjMK2dZ8w1qWdGdm8CBwQDm5X2YlROrwVLSEKSfREHCXYqhDJz+
         ufvubSrsmBtBgyu778kOVpaCTj5fRvwILsLkcema5J1gUb1oQXzdYqzEnbiUkakg/kUy
         /wbmUZd3NiSsZFjGJgCuOW+GIIAza6jp6x3v0tGod3e5uDSxlo7MCVVM/ugu8tJty4fJ
         X9d0JJENSsynRhx/cVJrMThOcgj3A4Sj5bxTki494xZnQHgNHTNp+B3NVFqdafwHgYYk
         qBHw==
X-Forwarded-Encrypted: i=1; AJvYcCU8ici7pc7xBI9A3FC0JPXMp6gMcuTbNUDABA14QUmwerXUez2UOH4EwLtFzpXCyNtrzJ8b3ha4tnokrWM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+/z6XuKfwelIngTUvp7dihSiotnhPTxDeNa2SCG5uEQLJkFz1
	4T6UwyqJ/OjhrOU396jzyru2hDgpKGI71HSdQFgSBwsXMMBe8KOoXQSC
X-Gm-Gg: ASbGnctRnhP8mVUNhiQr2K4zACUPCqpK4ESDbqWsJE0GmTHm5Iw5uZr4XCkOT9nDq2a
	q6s6GB0EjvBAInOss6eSTQM1fEZf9rnDWrMQvvM+x3F/3vFRd3S5i2QN52YOjiGs3Zt7WtOQCTj
	SAJYJc+eM9ZCRJI40LKZ0c4WvBcQ1UFoa9FNsuQ8UqYy4G/e4DKshSLFPseo4OknI8/uGzrmOQG
	8+aiF9GpLSuwUrDwlM40JBuuk3lTzzjvLbO5IKkVhzOUO4WIKhIEuPFh37L8etc/c4URJSAwTc6
	ruTncnqZw3JkQQsLXjwXx1q1ymzQZIDQndB3za3Z6qOvf9gH53k2A4X+ThkH95DM7PZwXEa/rEa
	37RT9uheWLZ2MmCv+P16RfQkfDqL4NnSonk/hakTBNCh44bpkePeCw+n6pEGUxjgnfr2gSDK3QQ
	1/rT39ljE2LQ==
X-Google-Smtp-Source: AGHT+IFzZAqzgx9hI9VWDaOpx4WVbJGiiiiPSP8erCa77EiYj7XPJXg1vLil+vrRBk3WAZVO6rop7g==
X-Received: by 2002:a17:903:249:b0:25c:8005:3efb with SMTP id d9443c01a7336-290cba423a6mr371056925ad.54.1761384604459;
        Sat, 25 Oct 2025 02:30:04 -0700 (PDT)
Received: from Shardul.. ([223.185.39.235])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d40dbfsm17878515ad.72.2025.10.25.02.30.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Oct 2025 02:30:03 -0700 (PDT)
From: Shardul Bankar <shardulsb08@gmail.com>
To: linux-btrfs@vger.kernel.org
Cc: clm@fb.com,
	dsterba@suse.com,
	linux-kernel@vger.kernel.org,
	shardulsb08@gmail.com
Subject: [PATCH fs/btrfs] btrfs: fix memory leak of qgroup_list in btrfs_add_qgroup_relation
Date: Sat, 25 Oct 2025 14:59:51 +0530
Message-Id: <20251025092951.2866847-1-shardulsb08@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Fix this by changing the early return to a goto that reaches the
cleanup code, ensuring prealloc is always freed on all error paths.

Reported-by: BRF (btrfs runtime fuzzer)
Fixes: 8465ecec9611 ("btrfs: Check qgroup level in kernel qgroup assign.")
Signed-off-by: Shardul Bankar <shardulsb08@gmail.com>
---
 fs/btrfs/qgroup.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 1175b8192cd7..0a25bfdd442f 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -1539,8 +1539,10 @@ int btrfs_add_qgroup_relation(struct btrfs_trans_handle *trans, u64 src, u64 dst
 	ASSERT(prealloc);
 
 	/* Check the level of src and dst first */
-	if (btrfs_qgroup_level(src) >= btrfs_qgroup_level(dst))
-		return -EINVAL;
+	if (btrfs_qgroup_level(src) >= btrfs_qgroup_level(dst)) {
+		ret = -EINVAL;
+		goto out;
+	}
 
 	mutex_lock(&fs_info->qgroup_ioctl_lock);
 	if (!fs_info->quota_root) {
-- 
2.34.1


