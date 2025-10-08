Return-Path: <linux-kernel+bounces-845000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 03A6FBC3400
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 05:47:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DFDC44E7F78
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 03:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97D342BDC25;
	Wed,  8 Oct 2025 03:47:48 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61B728CF5D
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 03:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759895268; cv=none; b=ca5Qd2oCl4B1CPK8OFM5Nm4RtI6wQX1TuMsofWzQhpy0FOJW39QK/0T6L80P3RC5kNXE2J4uHyFyM8A2v5FkJOjKkKDiCw/CX9Y6oVcSLwPH79DPfuMCgwbpPSSjOabljYqfm5Ck532zwviGq7spVI72hyHOplK4VAKWCtSgULo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759895268; c=relaxed/simple;
	bh=fnWNKEZwd0rqDw/oekVW4qhjL53mZN7ocuwPUvSbRAc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=gv5xbkJzLvZ/gpbA7ogSaAL+py9zMfMNkCjo58tEfGvWeD2cONZ3geludsH6r2AmovzVUU89tEN+BY6zam95lUZ4Jl4DMTg7NXq6Ilzy9OklLFjmbnAB2hf90i049/kMEwavoUWILig8CREkItPRrRyEwaHL8+uia1XZWcEK/wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-925332ba890so1931687339f.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 20:47:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759895266; x=1760500066;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pVPg9dVUfw8zlVww2Aa5Avl/dKeBwRpboWnUZaHpeIk=;
        b=Bom8jriP+9d4Jlgrr5lLgY5qWcooaQCiUmyheek5kYpyYyd8z0pRtHY5jjVt+pYp7J
         YF9LTBvvzy0oBz6/rnylYWl5p7Bb93FV/6zrWufeMZUtyguL1gyUXHqLIERQJh9KGyMv
         JkAV+kpqsGCFRnfunAmSk3mSIPaFMWcUeJ0Gy4J8HaFweiPlAGgiZ++HYSC0S/7fzGs8
         +KSyLtljsVK/pnPWZ4bP3idbtratXOuSE/A9WQCINEN3bvMNzJfE5vw9OIc0ilG6iBKb
         fIbsJsQomvJ2Rzxm6hBAUgtz50AiO+jmBIFLXBEdt7bpYllrU29lFjqfqB2cdv8UkboQ
         +Y4g==
X-Gm-Message-State: AOJu0YwWh3qUqz+4fpQBMwW/i6y3ZXzBJ1OLifnfvjbe1pKncZj7pB6H
	irLnQ+Q7H0hU61nNSNFCAz/4c99s7l2fGAR9r0aE2WD3Zt0i8/qy9YnR8QeRWuWheWpbyHtkdj+
	1mWIDReMj6Ga+pIHoK0495Fc6yPrMsmLBm2r2e3zNGDOJtvRMZhgB1mVgGl0=
X-Google-Smtp-Source: AGHT+IH8Q3ByDsneRia1l9174n6JGqy98Oh/WCQiGLHlwwyu/PVV0P9AcKoNv2IQsWNzKIC4aE1HYYi/BN6vpS+jeTgUptqUT4WZ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2b82:b0:927:3f:411c with SMTP id
 ca18e2360f4ac-93bd16b5a83mr206024639f.0.1759895265830; Tue, 07 Oct 2025
 20:47:45 -0700 (PDT)
Date: Tue, 07 Oct 2025 20:47:45 -0700
In-Reply-To: <68e0b136.050a0220.2c17c1.002d.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68e5dee1.050a0220.256323.0033.GAE@google.com>
Subject: Forwarded: [PATCH] ocfs2: fix stale extent map cache during COW operations
From: syzbot <syzbot+6fdd8fa3380730a4b22c@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: [PATCH] ocfs2: fix stale extent map cache during COW operations
Author: kartikey406@gmail.com

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

The extent map cache can become stale during COW operations, causing
ocfs2_refcount_cal_cow_clusters() to see an outdated extent state.

The problem occurs when:
1. ocfs2_get_clusters() reads and caches an extent with OCFS2_EXT_REFCOUNTED
2. ocfs2_refcount_cow_hunk() performs COW, clearing the REFCOUNTED flag
3. The extent map cache still contains the stale REFCOUNTED flag
4. Subsequent access on the same extent via the cache gets incorrect flags,
   triggering BUG_ON(!(rec->e_flags & OCFS2_EXT_REFCOUNTED))

Fix by clearing the extent map cache at the start of COW operations.
This ensures that ocfs2_get_clusters() always reads fresh extent data
from disk during COW instead of using stale cached data.

Reported-by: syzbot+6fdd8fa3380730a4b22c@syzkaller.appspotmail.com
Signed-off-by: Deepanshu Kartikey <Kartikey406@gmail.com>
---
 fs/ocfs2/refcounttree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ocfs2/refcounttree.c b/fs/ocfs2/refcounttree.c
index 267b50e8e42e..3804e62ffcdb 100644
--- a/fs/ocfs2/refcounttree.c
+++ b/fs/ocfs2/refcounttree.c
@@ -3451,7 +3451,7 @@ int ocfs2_refcount_cow(struct inode *inode,
 	int ret = 0;
 	u32 p_cluster, num_clusters;
 	unsigned int ext_flags;
-
+	ocfs2_extent_map_trunc(inode, 0);
 	while (write_len) {
 		ret = ocfs2_get_clusters(inode, cpos, &p_cluster,
 					 &num_clusters, &ext_flags);
-- 
2.43.0


