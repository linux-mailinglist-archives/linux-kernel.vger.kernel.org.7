Return-Path: <linux-kernel+bounces-845016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 73148BC349E
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 06:23:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D237234D493
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 04:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1753A2BE643;
	Wed,  8 Oct 2025 04:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lmHpitye"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C941799F
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 04:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759897415; cv=none; b=OPlWf6mQenJ4dx2xb2s/7yhx3sjXdCfpp4yhAWrYZTZ0LH+OyQnMQbO6AFzCSb1TczeWqq05aiHP6n9BR5zTATpmUSLcHhol8EDGnuYkEfKozrxqIUjzI8MLNvTacH1OJzvfQViSkyvtDwJz33qQV8k06xcaSFOcG/eLizS2Vwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759897415; c=relaxed/simple;
	bh=D8oStHzcz7/r9I2ztl+yPQZW7adQ4HY7aBSQCA8STv0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BSC2lBSCjnmaoiSepUoLbc+Sa8RDRtdFf3FiKSOrPo66uEn9BF0SL9LrURQTRofnphYfgyH6YFY5441b8txyCM6MPlvmQYtnoB2LIzLt1+/0M7Cj/7Yfl+EqXhcVOpugKkRUg/s8xspVmFGDqEVz3gHsPLMXdtj+E5/zoYWWiHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lmHpitye; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b556284db11so6585455a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 21:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759897413; x=1760502213; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hEVi0oUCP/S6neTrRa1ElmpxEMfl3lohtPyax+Yify4=;
        b=lmHpityeBY1w7XBY3EzSKBUnmpS/+x2vGN/CAxzJCXZ9ICDrBhPfXqMFLCB30GYqa+
         TYRkzWDplrhZU8GzXvqp67gnU3UlIY3Zb6KvHMPcGfLEUvX2BExjlOFUg9TakV+31F+K
         OIqsxLROQpwWf6+sCVje2PFuyeu2m/CfD9q/OP7XV/0yC1/y7SR4pee1Dfh5/dyBu6Vf
         RyxsKyqqvnc6ROdC6Eqa4iHZaatiPvg4ywETfimmsJ/HjZiHzAnrxxJzezjscQ4wzBt2
         1x3HHSkh35WoIkTRm0Brtbb8p1bTKNlKya1eOkXbUNXY/vJ1xsypCmoNDE5O5vICNpxB
         1IXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759897413; x=1760502213;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hEVi0oUCP/S6neTrRa1ElmpxEMfl3lohtPyax+Yify4=;
        b=j5Ei0lpwmvvE1r2BVOfZ3GWyQxAGu4Mafbo+zm/rgeQd5HVmcFifz7zooWgn2ufsN2
         Ur1MnEiLq2xkW+OnqJhiFMcrpIngQhIPcLYcERLyiX5Bp7cizIYy6QS1RSaJiqHnntp/
         uWKNUpNQzRVocndl40bbaW8KQgg7MG0I41cSHF+hEWMoZ7CtRiSX8y6z8SrLic6BeueQ
         f7TpD2b0MOpTVAv70xGG8qFND7QGkxnnjfmPl6NKPs096vVj+3W5nUGgr21vlP9l4OCf
         e8yue/+LIqvXevSJdy7rB99q5V5mQsziUYjNOErwieb1FDxddkV7E+KI0exoRArNC3o9
         kTBQ==
X-Forwarded-Encrypted: i=1; AJvYcCVvT4aA0ARczdDEQLa/qZuULNwP/FjZ8J5Mu5ojsmhZDRXCa9lXAgKUOHlv3cSfYAsQVnWRjyElbvn2KbI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPG0pok+3lSdQY3RWKFemX4NWezfVDA3G6RRA1pPSrloCPjFiC
	CGXIpDwwG5eW55JK1pQZ26kp3i1AqA84zORlEwQGjVHGjaZg8xsGTY2Y
X-Gm-Gg: ASbGnctRJ+sVOaHuQ2LuxfVqZ9FMGvHMCbXssZ0KmIe7MqvD7pYaOWdTayGhAH4wKp6
	4L2Loc9EkD/4/djGfZgJ5g7HwdyHgFMPabOYfGCthcCUP9H9DSpGEEelP9hiMpayxAH5sH7yuQD
	DRaOxsO4bmdPEWAyguOrq6H60U3X1JxDfD034/yYqgXsV5N4BT8cE32fNoBs71qF4vttSmHZl5d
	RGtJNxQHkEAN+yWbPtPItUmCW2YgL7kzmLx5iSU7CkQsg/65FvqGkoJMflQK5vvMj2bBGDg/E8O
	SpmPyBwZ9WHgwinVE7N+9jHdlIau1nkl+vtBUa8Lfs6qI4aGh/SdaUMQNlMlavL89tYtMSb6UpN
	tMt+b/mEJP82uO4gXGO7/tLwpoCryRsdQZzchERTrD5+n6MIaMOPXZ5ofh3hCTq43BbSb5wk8aK
	npot8ksUfyV5M6iyEkVm3RPOBm/g==
X-Google-Smtp-Source: AGHT+IEJBnMCIgvoHdyBF9yP6PCao/mGhzvPLHd4Wu9DKbCAPpFelf/olPSoc4LkwkiKMOEZWgCxEg==
X-Received: by 2002:a17:903:2446:b0:25c:2ed4:fd7f with SMTP id d9443c01a7336-290273ffdd8mr25857445ad.42.1759897413285;
        Tue, 07 Oct 2025 21:23:33 -0700 (PDT)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:389d:b64c:5a0:15b6:8522])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d1d5e36sm183392215ad.114.2025.10.07.21.23.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 21:23:32 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: mark@fasheh.com,
	jlbec@evilplan.org,
	joseph.qi@linux.alibaba.com
Cc: ocfs2-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot+6fdd8fa3380730a4b22c@syzkaller.appspotmail.com
Subject: [PATCH] ocfs2: fix stale extent map cache during COW operations
Date: Wed,  8 Oct 2025 09:53:25 +0530
Message-ID: <20251008042325.468846-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
Tested-by: syzbot+6fdd8fa3380730a4b22c@syzkaller.appspotmail.com
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
 fs/ocfs2/refcounttree.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/ocfs2/refcounttree.c b/fs/ocfs2/refcounttree.c
index 267b50e8e42e..e8c8fcdc3dd9 100644
--- a/fs/ocfs2/refcounttree.c
+++ b/fs/ocfs2/refcounttree.c
@@ -3451,7 +3451,8 @@ int ocfs2_refcount_cow(struct inode *inode,
 	int ret = 0;
 	u32 p_cluster, num_clusters;
 	unsigned int ext_flags;
-
+	/* Clear extent map cache before COW operations to avoid stale data */
+	ocfs2_extent_map_trunc(inode, 0);
 	while (write_len) {
 		ret = ocfs2_get_clusters(inode, cpos, &p_cluster,
 					 &num_clusters, &ext_flags);
-- 
2.43.0


