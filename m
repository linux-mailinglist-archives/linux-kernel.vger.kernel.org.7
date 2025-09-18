Return-Path: <linux-kernel+bounces-823625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD3ACB87071
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 23:11:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EF211884322
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 21:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1866E2F7AC6;
	Thu, 18 Sep 2025 21:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gajZGjjN"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7882F28E2
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 21:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758229869; cv=none; b=l/Z958tQkGSyUVwpHgdPeGs07vqTeTXUSrNXsoFrGnQK+sMLFKQuOgRSAzXL01/cXW4ZWgd2A694r+wZOOrBXRyLNDC63SiJg6Ae9BStkAXxmt3Stwa6zrhN2uqVf9xOBoQza09xoPe58mdvl6bE5yqaMXPJ1v4juN2FAyWbzHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758229869; c=relaxed/simple;
	bh=LHQO7gfJWptsmBRoNkM9Q5ykBBcKDDcn/v7M+lXtbMQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qWGxNOBc49F3nq/9apl+JHfc2FSrh1+kJGieZMY8MTcWlPj190XAfUgAYCVPHP/t4R2TPoqpcI6og1CUyVswsywJXEMk0h83Ttkxv/h8YUUhYVIOfSR6wIAdDPgo4IxVP5y/3zRySGV09wwfB1D/0MiBe4/OKOesvFqlg65qSQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gajZGjjN; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-77e543e41e9so246390b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 14:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758229867; x=1758834667; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x1e65N4mSYgYj4bNQD+ee0xPVC5irAb94SbFNc9xAbU=;
        b=gajZGjjNuznWwXirESJNUQ1ihug6XU6bMBqQizzCaUe/NsDTCG+44OPgUHxwci+gwN
         bIqM7R6xBF4sphZaMgFOy4LsQXYzLp6VbTYbxGxovzch8dQCUWXNwnH4Kt5XabkGUkdL
         Sy4FCAVR/gVBipirzcvxZMoy1hR8SendM3X690iusl493vYEP6dd5PBcC4BcY90iVXGN
         +sTXGDCDhs1EaXHNjJWtsLIKHrdKuJC7ZDa07l5TZ5kA8IbzXQ6RsOjbzG2Jt5FLl0ay
         FT75s/qIjE5QhuEXGrLjdyQ4f44ebuDWLmT7fPSNvXxetpcASlRm7IuWJbCCBloBNhjh
         BhyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758229867; x=1758834667;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x1e65N4mSYgYj4bNQD+ee0xPVC5irAb94SbFNc9xAbU=;
        b=pEt+yG+ONxQ4m0jRcCpC2GV0kMhdd+/bwDfKB2giTW+cLcP1nqmlhjfxB3Uy5hT//d
         a5PoS6iDQUCb48W0/TgjrVQEOo1JCQ2zip30PU8uaXJzQhDbblhm8KDWV+lKRvXPSs1T
         IHyh2KkMv2ENtrzOjlIDs7qCFm27wHh2pvDdQRr1rV9gBhRBr+G8ReJJEdYH5O4OzUr4
         unhAxoWsilTdGvNkHVMU3K4vxdtSyxtXcPAwT4O4qW84j5b7HyRGKVsG1+uaDUO69QhN
         seKTDbNzWCOcoJVZpMXoQSZHF/YA3aEBkAfrCPL6SclgMZPDEFOzQOenVZvZmvEfCy9m
         UbZw==
X-Forwarded-Encrypted: i=1; AJvYcCWcUPn8977z46zdVOp5rRJ1QjpMKBOH5uapFq3kj9MBj4w6ocOYTAFBK0KE09EJQaD9q5RpyQK/5KVFy2E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCmt9Pvu0Fnd6BdtNWgUeUBKTydnyqPlNMe5OYfPSn7Hp78kjv
	Fx+X/dCGGrDcWcfhNjCm8cUe5wKqpYhgfZmhGDWsnTOXB79fkQcQoQZwmw5wfhNC
X-Gm-Gg: ASbGncvEpJ8q9XWNy8NzlQY5vS7zYi4tjr4Kjzh79rx3uhxTofARsecZbamB7RDxY2m
	oMI5Yutuazg0oi9C2FhVvtNydUC9mEL7zKSVQGUzCTMbDoe1VUeeAVwQiF2CsBHUPsN4GCMw/dj
	hWBU/0mChXb7lYm1o3LqQMcfMfpsIuWcig7nnHBY9UomPUB2Z9STAEtvZp2PHF+Dx5zqf76siIj
	kFvFH6Cw756eTDO/2TdNTzzeuqqqbxWD2MVrZ0V/LNzhqXwHmj3zTrhuu9J6sccqDb1dm2LS1rj
	71HlujAVTjFVfoEK/vCGfX9u4tHP5ru3f+twK9mVJ5F8m2dp5AjK2ifgvMKP1NGADG4y8VH5whO
	yq6gwunbUedq+mj4M9F++o1UOSku7vpPC9Thl95ptfUvVRA==
X-Google-Smtp-Source: AGHT+IG75frq5+oHc/0AU9MSRl+oyX7SQoTS2CFYbsqXBDqcXb2zLzk1a39sNOJDFsiQszUntSpGfQ==
X-Received: by 2002:a17:902:ce0f:b0:25c:4b44:1f02 with SMTP id d9443c01a7336-269ba51ecd8mr14561345ad.46.1758229867292;
        Thu, 18 Sep 2025 14:11:07 -0700 (PDT)
Received: from ryzoh.. ([2804:14c:5fc8:8033:edf5:239a:a9e8:d865])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-3309c81f50bsm93135a91.23.2025.09.18.14.11.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 14:11:07 -0700 (PDT)
From: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
To: syzbot+4f9c823a6f63d87491ba@syzkaller.appspotmail.com
Cc: jfs-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	shaggy@kernel.org,
	syzkaller-bugs@googlegroups.com,
	Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
Subject: [PATCH] jfs: Add check for array bounds in dtDelete
Date: Thu, 18 Sep 2025 18:04:14 -0300
Message-Id: <20250918210414.15022-1-pedrodemargomes@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <67d9cf78.050a0220.3657bb.000f.GAE@google.com>
References: <67d9cf78.050a0220.3657bb.000f.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test

---
 fs/jfs/jfs_dtree.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/jfs/jfs_dtree.c b/fs/jfs/jfs_dtree.c
index ab11849cf9cc..b30f57304c09 100644
--- a/fs/jfs/jfs_dtree.c
+++ b/fs/jfs/jfs_dtree.c
@@ -2129,6 +2129,14 @@ int dtDelete(tid_t tid,
 					next_index = -1;
 				else {
 					stbl = DT_GETSTBL(np);
+					if (stbl[0] < 0 || stbl[0] >= DTPAGEMAXSLOT) {
+						jfs_err("JFS: Invalid stbl[0] = %d for inode %ld, block = %lld",
+							stbl[0], (long)ip->i_ino, (long long)le64_to_cpu(p->header.next));
+						DT_PUTPAGE(nmp);
+						DT_PUTPAGE(mp);
+						return -EIO;
+					}
+
 					ldtentry =
 					    (struct ldtentry *) & np->
 					    slot[stbl[0]];
-- 
2.39.5


