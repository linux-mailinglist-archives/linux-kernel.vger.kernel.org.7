Return-Path: <linux-kernel+bounces-747063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D05DDB12F41
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 12:59:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19AAF17262B
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 10:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69F8C20B7FE;
	Sun, 27 Jul 2025 10:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i5E38ZSM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C990BBA36
	for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 10:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753613993; cv=none; b=g8kz714KU8ZSpzaiGlbKSCTEDE5xy7SKg9HHyAuDINbe+aoZU2MmnPXtJJd5dC0iyFdZvk2bscEpcmJzkNiom0RaoAoWtL347JHi7VEs3ucUvbwvrQyOAihh8A2nMqDkWFwghuLr/SR9tInjgwWEaIDHicB7u9IvGNTFW7+V3DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753613993; c=relaxed/simple;
	bh=58VEwhCHrFJ1R45SJv+ufoUUAGi0PqZriv1MDWB2qig=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q+HB7Xkec6T7Kxw+Vxvl9TatJ66vCFbGl72/SbdQPfzK7NkFJAwkjsOE7Um87IyxH7ZkUkwvy+egdRgGOH522K43JcZziVQ/Xs2I3UQnKXeZ7MJtf0Q5wx3pmeLoCMloYSRVtWKDF2SSOblaq9Y+iROBV94bMSQR9NyRfjbOUg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i5E38ZSM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67233C4CEEB;
	Sun, 27 Jul 2025 10:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753613993;
	bh=58VEwhCHrFJ1R45SJv+ufoUUAGi0PqZriv1MDWB2qig=;
	h=From:To:Cc:Subject:Date:From;
	b=i5E38ZSMQQw9olQF3vXX3wo3A9j65/Rw233xxLSXmuncUmz2QsTgprC197AqbX3gJ
	 AXA+x2tBU5+Vg5xj8RpupL4zXJ1SFNczYIRoW67wggJNDcsWFGcyJ4U5jROIms93+d
	 tfEBds2gxTp70qN3iCGJtmB6041aZUU2KLB13dHtUbadsqHtGhgne14EDjAS1Mj/Uj
	 PezAcUhZ4uDxoxPFCDnrM9YN/mc+A9GUBRIu0LSiEjCF1nAuMitQ6XqErxXw7wC5K8
	 zlE13ftoLpCJkRvUlc+o0bAxfgql8YHAjR2A81RyscNUPQHdXR3maaBAIHvg5bKQAB
	 DHV+ZKigbgZBA==
From: Danilo Krummrich <dakr@kernel.org>
To: akpm@linux-foundation.org,
	hannes@cmpxchg.org,
	david@redhat.com,
	mhocko@kernel.org,
	zhengqi.arch@bytedance.com,
	shakeel.butt@linux.dev,
	lorenzo.stoakes@oracle.com,
	gregkh@linuxfoundation.org,
	rafael@kernel.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Danilo Krummrich <dakr@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH] mm/vmscan: fix inverted polarity in lru_gen_seq_show()
Date: Sun, 27 Jul 2025 12:59:06 +0200
Message-ID: <20250727105937.7480-1-dakr@kernel.org>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit a7694ff11aa9 ("vmscan: don't bother with debugfs_real_fops()")
started using debugfs_get_aux_num() to distinguish between the RW
"lru_gen" and the RO "lru_gen_full" file [1].

Willy reported the inverted polarity [2] and Al fixed it up in [3].

However, the patch in [1] was applied. Hence, fix this up accordingly.

Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Link: https://lore.kernel.org/all/20250704040720.GP1880847@ZenIV/ [1]
Link: https://lore.kernel.org/all/aGZu3Z730FQtqxsE@casper.infradead.org/ [2]
Link: https://lore.kernel.org/all/20250704040720.GP1880847@ZenIV/ [3]
Fixes: a7694ff11aa9 ("vmscan: don't bother with debugfs_real_fops()")
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 mm/vmscan.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 0e661672cbb9..27c70848c0a0 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -5756,9 +5756,9 @@ static int __init init_lru_gen(void)
 	if (sysfs_create_group(mm_kobj, &lru_gen_attr_group))
 		pr_err("lru_gen: failed to create sysfs group\n");
 
-	debugfs_create_file_aux_num("lru_gen", 0644, NULL, NULL, 1,
+	debugfs_create_file_aux_num("lru_gen", 0644, NULL, NULL, false,
 				    &lru_gen_rw_fops);
-	debugfs_create_file_aux_num("lru_gen_full", 0444, NULL, NULL, 0,
+	debugfs_create_file_aux_num("lru_gen_full", 0444, NULL, NULL, true,
 				    &lru_gen_ro_fops);
 
 	return 0;

base-commit: 51a486feac0ca002bee6429f03da0a6c206d0dc5
-- 
2.50.0


