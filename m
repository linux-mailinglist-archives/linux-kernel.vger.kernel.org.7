Return-Path: <linux-kernel+bounces-847100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C34E9BC9DB0
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 17:49:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A95564EA601
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 15:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C676E21FF21;
	Thu,  9 Oct 2025 15:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hZRRUYVH"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF91E21B9C5
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 15:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760024954; cv=none; b=MXEWh+ykP7sqqVBjGES/BydFr8h78LzA4mvTaS7WCAJSX5Xenw1aaG2rHiqd+jtAczCuIhIVfGjOd9+iYIUxwu4VyH8zKqc0LVtwNN6eMrZAzegtR7DYW/X0e2kaw1OPbnOAUV1mRabeXmaMfK7GhCol0kVd0Tm5AXpY29gkcdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760024954; c=relaxed/simple;
	bh=GuLLQAKATyLvjbNuey46y06cX5Vw7qz03m0TI8g/60o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MnWmYWTXu2lPpULnnAynUs+EtxnNdlw+F7LN3PGAlzfhmqq5Y5MceNw3qXi5p3ugFoQH+DerHqrJh3K8OAhbXa9Mo6ecWYhH6XTcf3u+t6A2dUEwXESjMs0qMNMq4rBG+TbVcS6qDw4qyEzYJ07KO2pHsO0PPE//wYv6wuqeXBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hZRRUYVH; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-33292adb180so1078378a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 08:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760024952; x=1760629752; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=j1GcN+G00e8rgYgWddESo3aRTzLrdG6jM+98jl/EWDU=;
        b=hZRRUYVHCFmOo0xnRv8bRvKZtYhod/JideTGA1Dp8geE1PNcbY4Jni1C+PF6mvPELu
         A+NtJseHHPE8NFpGG34ycAZfS5JfgH/4m7VNKyt2mKHra4Mefc5IIg9lRwQsx+0jKpir
         rdsgAO8sy1CD/P+brUBdumGzKDUK0XUdTHz86ER+8gKufGSxM02aJI59gnXEFmxnEVvV
         Yhywg55d6tFnkhFUHfDu0kiOS8Cvp/eZdp7Xj232N4E8BXe9vfnWpSXlYzgezMBUffyT
         B8l08pV9vsKAL+eANhuFFvK5N99U3P3tl6lfNncFflbX+IEcxCEJ9feFRAqukP9oaEVl
         Nehw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760024952; x=1760629752;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j1GcN+G00e8rgYgWddESo3aRTzLrdG6jM+98jl/EWDU=;
        b=EVo0jDVT3SEJEXCcKa9EU6sPId1uRJl8ND+fPXSa8SvZlOhCV88IT7uBcXMnPiJfGo
         hVLaarCEk1AS87M9lP7vdWWywGhPqCgorkM+PGnVjLKey6rfX/FJDGyNDynsSdLyAcxG
         nR+7lHIOtCKpRxdjr45LVuvmnTfe/azGUaxpPfxo6IKnp6q7+DxPPwCIk1QupSNIDfpU
         G50MTFut/BOLdqAOuStf97WClHEHTi4u8E5Pkq1e1TWgatCnLOYRgD/Oaa+UUKYGKCDM
         mzs9N1BNNaTZdTvjcybTJUekyGzPG6OD54Ls44PGd2XJQ45YqtC7ab+QxKBz9d5acSEX
         nl8A==
X-Forwarded-Encrypted: i=1; AJvYcCV3jN6Ur6wXwwRCM9tFZDCjE13OB4QKzrAm4047VmnzhLZYwQQh+pfzPrcIb6dY7d1EdZpvMZNMkufGvjQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQYJ8sTAhs5h20mRNDxIjteS4QyaG6yYfQQpGoC1AlCxTaEl7x
	xvgI8jnED92xnvM2DoLioVuUPzBdDPARnht4p4PFGyx8T7KVWEsTxWlF
X-Gm-Gg: ASbGncudBLOKJBc380oK3hby1z0AiM5RRLlbcQ1M3VreTCNde0k7fVB/FFdZHUOIHs4
	HQpOQLrrGs94O6HS7ERabJwwMa556CwvyJnU216+eeDIVRGtZspE55bgiL2lk4o24mxGRzEnR2Z
	+2TUNM2tkdReGFRjIaxPnyc1GmNs2mgRIW2xJ7F2Zc8d8mTZ4o+OriHxxX12U5R1cIjU4ugMT6F
	e13telfQmjgmIAvq9lc3nIz4o2eHsjeTsfbccUEhrkuSlXGJsVww9ccsAj13KexagMiR0232dzo
	WadtZzXyOX5ENsZDlgE0kRTF9zcnvsERskTOFwyrvo/gZ9mfE55OeATRKpgLz3ue8Ke18Oa01Tm
	V6bWgeBcHzk085c9VzUBR+yDQLiy5sYQmCtG6ua8kQ2vg1XqJPuCU6hUmVskEE6VQMS0kpY4oG/
	rgw7o7IyyndNCkEZN6OiGG8InKoX4=
X-Google-Smtp-Source: AGHT+IGPxJaBI26Q/y09qEXEoJ1IfSAYTKBwEim3r875wNzdr7XXReJ2+3sYc7blAxyeynmq02rbiw==
X-Received: by 2002:a17:90b:4a06:b0:32e:dd8c:dd2a with SMTP id 98e67ed59e1d1-33b50f2c758mr10974597a91.0.1760024951818;
        Thu, 09 Oct 2025 08:49:11 -0700 (PDT)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:389d:60a2:fbdd:54e6:8eb3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b61a3cbf2sm232811a91.8.2025.10.09.08.49.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 08:49:11 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: mark@fasheh.com,
	jlbec@evilplan.org,
	joseph.qi@linux.alibaba.com
Cc: ocfs2-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot+6fdd8fa3380730a4b22c@syzkaller.appspotmail.com
Subject: [PATCH v2] ocfs2: clear extent cache after moving/defragmenting extents
Date: Thu,  9 Oct 2025 21:19:03 +0530
Message-ID: <20251009154903.522339-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The extent map cache can become stale when extents are moved or
defragmented, causing subsequent operations to see outdated extent
flags. This triggers a BUG_ON in ocfs2_refcount_cal_cow_clusters().

The problem occurs when:
1. copy_file_range() creates a reflinked extent with OCFS2_EXT_REFCOUNTED
2. ioctl(FITRIM) triggers ocfs2_move_extents()
3. __ocfs2_move_extents_range() reads and caches the extent (flags=0x2)
4. ocfs2_move_extent()/ocfs2_defrag_extent() calls __ocfs2_move_extent()
   which clears OCFS2_EXT_REFCOUNTED flag on disk (flags=0x0)
5. The extent map cache is not invalidated after the move
6. Later write() operations read stale cached flags (0x2) but disk has
   updated flags (0x0), causing a mismatch
7. BUG_ON(!(rec->e_flags & OCFS2_EXT_REFCOUNTED)) triggers

Fix by clearing the extent map cache after each extent move/defrag
operation in __ocfs2_move_extents_range(). This ensures subsequent
operations read fresh extent data from disk.

Link: https://lore.kernel.org/all/20251009142917.517229-1-kartikey406@gmail.com/T/
Reported-by: syzbot+6fdd8fa3380730a4b22c@syzkaller.appspotmail.com
Tested-by: syzbot+6fdd8fa3380730a4b22c@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?id=2959889e1f6e216585ce522f7e8bc002b46ad9e7
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
Changes in v2:
  - Fix moved to __ocfs2_move_extents_range() instead of ocfs2_refcount_cow()
  - The real issue is in FITRIM/move_extents code path, not COW path
  - COW path already clears cache at end of ocfs2_refcount_cow_hunk()

 fs/ocfs2/move_extents.c | 5 +++++
 1 file changed, 5 insertions(+)
---
 fs/ocfs2/move_extents.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/ocfs2/move_extents.c b/fs/ocfs2/move_extents.c
index 86f2631e6360..10923bf7c8b8 100644
--- a/fs/ocfs2/move_extents.c
+++ b/fs/ocfs2/move_extents.c
@@ -867,6 +867,11 @@ static int __ocfs2_move_extents_range(struct buffer_head *di_bh,
 			mlog_errno(ret);
 			goto out;
 		}
+		/*
+		 * Invalidate extent cache after moving/defragging to prevent
+		 * stale cached data with outdated extent flags.
+		 */
+		ocfs2_extent_map_trunc(inode, cpos);
 
 		context->clusters_moved += alloc_size;
 next:
-- 
2.43.0


