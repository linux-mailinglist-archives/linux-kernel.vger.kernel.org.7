Return-Path: <linux-kernel+bounces-842343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E64BB98BB
	for <lists+linux-kernel@lfdr.de>; Sun, 05 Oct 2025 17:14:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EC2354E44AF
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Oct 2025 15:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF4D4289E21;
	Sun,  5 Oct 2025 15:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=vjti.ac.in header.i=@vjti.ac.in header.b="JjSlPqgb"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2058F4A
	for <linux-kernel@vger.kernel.org>; Sun,  5 Oct 2025 15:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759677254; cv=none; b=if38Q22NYsx0syQuZSVplN5BZyA6tVLZ0syikjC/NTbEg00SlHf+GoZZ6+kbDZpsQArHRy/RB0yHGK0gA7b9nTsAq9JuFo5QWYRUbMxU43xq/g3lS4ORwgWj3XiiIn8it++qXXZIaHFlGhrk64ekrandriNT4f4Dv5Dj50wLK2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759677254; c=relaxed/simple;
	bh=8TnJB3YQxRebJGGTR6fB5k3Fr5QTJA2vinNsLRimdFY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BY3CL/XLLudw4JyZX6MliTgQ5tKNhRUGTip6MKnCyFRaW7teElMsHVCpIna1eR4mqLy1Ywt8pGXBCoK99z2N0mkckxGgQ6iiNNec7+Zu81Gmzj8ZMCgOqE5lJm/Tt9A6UNuZIZCYpG+PS6fRho3tseakLZ2zcLRrbCFUj8ptlOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ee.vjti.ac.in; spf=none smtp.mailfrom=ee.vjti.ac.in; dkim=pass (1024-bit key) header.d=vjti.ac.in header.i=@vjti.ac.in header.b=JjSlPqgb; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ee.vjti.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ee.vjti.ac.in
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-782bfd0a977so3451635b3a.3
        for <linux-kernel@vger.kernel.org>; Sun, 05 Oct 2025 08:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vjti.ac.in; s=google; t=1759677252; x=1760282052; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gG6l4sZPIWetTmhsdiktxSijsm0HjkE1waDz9JdkO8I=;
        b=JjSlPqgbcyRuqeN31GPvW4jujKw6noyyrvxl1bHmsagcofliE/g7jX97fozPQxJl0t
         GNHrz2wM2bKjiawvoiDN4Y9l1QB8RL8F8pEzCPnA/VwOoopoThh6qP7Lo+svqQ0N0ybK
         IesGmH8Q0e6Z/77Ku2uuK3k2hUrsCv/Ognc6U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759677252; x=1760282052;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gG6l4sZPIWetTmhsdiktxSijsm0HjkE1waDz9JdkO8I=;
        b=EhRaJU58BNpYBld0CaP9uZ3AMbrdj6iwCP1PiTyI/cCvqBoIw6RXubUna0m5qc6Euz
         z1doGNVAOmgzQghtScfOlKju7qV4Q44tjvZQ5bUC69r6ilqqM5fU7wwmwL8OOk4m3y0Y
         9md1ask8ISGE8zODLkGAVdN/pXu671a62GtX1QYeXepbLjXKGdZEQVwsOcD1v5L/xvCQ
         D3EW1XbjUtZe3/9xL5NwnCgeA52omi3lFbdL9Hw2yN5CaYzt0gofpl77BtwZ8OEt4PxY
         PtPOVIvseI0baIZ3IYHhnh/AEY5c/ON2LrOsPczz16S87Oqgyt9CTeojQlhsEn2tTME/
         7/JQ==
X-Forwarded-Encrypted: i=1; AJvYcCXdjivxmLqDFAJoabAmMbn3/A0NPV4IvRKJzro0ypEqIhE4l0YxrpqjWPAHHqbboSiY46miCduyrEEuogc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWzV70PNo0AbCFPFLZClKzfI/F/C4vyI7bvMxE7SUMvoWvjouG
	Rcw0k/bn+T6LNN72qgVrEIqruOCCzcplkU/Wa6YfInYA4DvtAinK1Tx+6d5c+rN2sqo=
X-Gm-Gg: ASbGncuEkeg3yVRAp2LKmZ9P/ZIuBfBtD3GgYiR4Cn4PTszvxgdw+pWUrgriVj2YuGr
	t28nE4ziYo76yxIHIJwFWJFHz5GovU7BRMufaf20yECISVwC7ce6paRydTWkdmCjL3iy3nccSAJ
	ypCBknz/cwHPXOMFq4ZuIAVpIQ50HR7slTA5sNrsIA2L0Y0929BHQgdnfh8yQvvx9W8AKySPpC2
	VZX1GjmBYLRf4dZ2C6eWVoJWq3+oENmbHeivMsgrBH2ROx5Er9U1xjWOBMUDZZmnOazx7RxXKof
	axpwPWiHzlH23C92iZ44eqDRAylDoXh4M3zMLsJExYnBUOgpPEyBQXWkt2wV63Ppokkj5inXbyP
	gMkYYUpT97acPMUjEOIUr4Za2qXyAun4Op0Ef6f+NHeKHXiYKDzAPJEim51hoew0Zv6DXYuw03v
	XxV8WflSquqZdHqadlXJqZBNHAT4ZTJtD90eBW
X-Google-Smtp-Source: AGHT+IGh0K+r8nflRBqpJ94if0tMDpZ97UVi7zrbovtIuV6dpxWvrRhjhNVlFvK8HpnBFUsSZQ597Q==
X-Received: by 2002:a17:903:198b:b0:267:da75:e0f with SMTP id d9443c01a7336-28e9a543a8emr91836865ad.11.1759677251745;
        Sun, 05 Oct 2025 08:14:11 -0700 (PDT)
Received: from ranegod-HP-ENVY-x360-Convertible-13-bd0xxx.. ([2405:201:31:d016:7b29:830:6e7c:1c3e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d111a37sm105437955ad.8.2025.10.05.08.14.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Oct 2025 08:14:11 -0700 (PDT)
From: ssrane_b23@ee.vjti.ac.in
X-Google-Original-From: ssranevjti@gmail.com
To: Mark Fasheh <mark@fasheh.com>
Cc: Joel Becker <jlbec@evilplan.org>,
	Joseph Qi <joseph.qi@linux.alibaba.com>,
	ocfs2-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	syzbot+30b53487d00b4f7f0922@syzkaller.appspotmail.com,
	Shaurya Rane <ssrane_b23@ee.vjti.ac.in>
Subject: [PATCH] ocfs2: Fix use-after-free in ocfs2_dx_dir_lookup_rec
Date: Sun,  5 Oct 2025 20:44:03 +0530
Message-Id: <20251005151403.9012-1-ssranevjti@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shaurya Rane <ssrane_b23@ee.vjti.ac.in>

A syzbot report triggered a KASAN use-after-free read when creating a
file on a corrupted OCFS2 filesystem image.

The crash occurs in an error-handling path within the
ocfs2_dx_dir_lookup_rec function. When the function fails to find a
matching extent record (`found` is false), it attempts to log details
about the corruption by reading from the `rec` variable.

According to the KASAN report, the memory pointed to by `rec` can be
invalid at this point, leading to a kernel crash.

Fix this by modifying the error message to use only variables that are
known to be safe, such as the inode number and the extent block's
buffer head block number. This preserves the valuable error log for
debugging corrupted filesystems while preventing the memory safety
violation.

Reported-by: syzbot+30b53487d00b4f7f0922@syzkaller.appspotmail.com
Tested-by: syzbot+30b53487d00b4f7f0922@syzkaller.appspotmail.com
Signed-off-by: Shaurya Rane <ssrane_b23@ee.vjti.ac.in>
---
 fs/ocfs2/dir.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/ocfs2/dir.c b/fs/ocfs2/dir.c
index 8c9c4825f984..8c4dd61efa8d 100644
--- a/fs/ocfs2/dir.c
+++ b/fs/ocfs2/dir.c
@@ -820,8 +820,7 @@ static int ocfs2_dx_dir_lookup_rec(struct inode *inode,
 		ret = ocfs2_error(inode->i_sb,
 				  "Inode %lu has bad extent record (%u, %u, 0) in btree\n",
 				  inode->i_ino,
-				  le32_to_cpu(rec->e_cpos),
-				  ocfs2_rec_clusters(el, rec));
+				  eb_bh ? (unsigned long long)eb_bh->b_blocknr : 0);
 		goto out;
 	}
 
-- 
2.34.1


