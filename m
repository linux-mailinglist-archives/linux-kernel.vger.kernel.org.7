Return-Path: <linux-kernel+bounces-830420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D6D4B999D1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 13:38:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 415622A6362
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 11:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54DC72FE050;
	Wed, 24 Sep 2025 11:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nB1Rk2bz"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49FAB2C21C7
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 11:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758713875; cv=none; b=q/9oQPzKlJTL1EnuZKW+M8u0Wj/AoS0K8DvFvK4/uF3bzm5K/x+if2qvKxHVlS4DfxPQCjVU0F/2OsNfKc8Zak7y7za3KnM45u8N9+nFlvz/had2C8D6+qH+03bN6xPsGVubADXQzIJE6+DXYpcUbwBOmr+WKnkmAF4IMCPNeiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758713875; c=relaxed/simple;
	bh=BTgYPkpXWTJ3wzKg6hY80hLuF/ObCRTOY4tFMAsjuro=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ogjux1DsbUNlCjwkl/qKW1sqo2A589M0gHDbjDSTHpnl+POhYrWGfwLxGh+omdlJn6qti1/hZTGOD+4/h6F9vC+zG+PR15WkycqV/hfDJ3yasH6euho9q6+WYOJFiwufYrwS8NAKWMV6rbjoDG3xSUh2VeOxlh2v4BlVcDLrt0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nB1Rk2bz; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3306d93e562so5996841a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 04:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758713873; x=1759318673; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mRYVyzheAwZ8osfGPBBGeLi3ZyBejqOSryW/UzRDTV0=;
        b=nB1Rk2bzs2f+Gbpuzl24dZZltbI5F33Nxgde5I/FmZAgFPzlJLbOI7CPbjZJLWySKx
         7nTtWJv69ytqpNYPRxFwz0d2hNPhMp7VCOcExELioCCAD0YBbag9Kp7+MKNkv4AygdhM
         DyviLrnaGsG7+hb6sqI5uAf11+TL3EYLzZEx0yhRG5zJL+esc26j9+12lODmlRJRgqaT
         IZtbmGIk6JQFJhIMJhvJK3noeSc/x3ReTQ2BgAH4XETIdNLkkC3b1bF8M0Da8BD0O4Gr
         HD0DNRiV/iTsF+2RuhBCfCvWmgR4PHNVHWNxY8/w6mkQ9RHSRXmajPqbAObe9jj2J9f/
         5sAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758713873; x=1759318673;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mRYVyzheAwZ8osfGPBBGeLi3ZyBejqOSryW/UzRDTV0=;
        b=u0b1QGB9i7zFvqUosPMDu4khE3sojawY+SSDSkftDI1vI5pMbgFll96CCVCOKLPHQ8
         GhbdV2xZUA1F3w/yv2nDm6X5gz9A3SfMzTURT2+iDFlJRs6r6zsR2oNO9IFnlHnbreqh
         HA0dwhzh7kC4oWPk7FQpzuTc0iiW3sWJszYJsY7HsBD+Rh3mDOr40XL2bD/hX7KFMloK
         3LhS9GyM9ok7iX24N+a1LGGKwuzqSWBia2/p53Wk94tfHPqgJZ4WQf6tGN52hiV71U0b
         SewY+yimnTz6laJKx7+5QNiL86bMoU5FcSivZ/1HEWQOgC4SOn3AjCbE4vTiXF78/2mt
         GE+w==
X-Forwarded-Encrypted: i=1; AJvYcCWxUtgDB9SO38F+FldycqOcR/V/8wSlxqQKmdWkVllb1f+VrMSQIaZRTfG3zYJjjDPKHxVTNlKAnZWzKH0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiMmTJfyb6rzjGDsY/Kf2TYVA+OWaBGtLlfknHOkD95iQDe1kn
	kvlePtmpup41EOVBI+7pQpyBCkO9Hei1n37bKgYb4LBQzyR3kUWjEnLL
X-Gm-Gg: ASbGncvGIFaC8ICHIerwEHYKvvPI1m2RpJRcLVU2jNEP2fMSNs4WniWgmUbuUr8OJyM
	BVpepYjZTpXPqYPefi+raK+y4udUGUxCJku57mOETbgRWemgh9xcMciRtopUIybER5oLG0anR0G
	oX9n9ZF6krBld1iuz2UcNz3slxPeUq8D0vGdtkeOcC5CNpYRKAU0FoO8QqXUICo4YSSmK17QeTT
	FDRhT3gEEcb5qORLkcdM/CgX9/MTaH1kr2UQXZ3DI3rHxzaESpOw8iRTTnWamKCBTgJ1cbj3/Zp
	bkRqvvTe0x/vVYd+Xo0y6ajpV8/ZfdMhfKuyvnXrj/T3jVmGJ4/bHYKD12QNoP04LlfxwGuWQAJ
	m8vv1ZFVYwfg+2ENCepRimCHPY3c26coUXhibTVATVhryE2Us1zsQ5/TrkeiWgwuGDmBN45Shr6
	BFnuY=
X-Google-Smtp-Source: AGHT+IGmHCwTlAKe5f/2j+sj15VZ0PFrj6hvwkJrV/TiWCLkMkocBxV38Ih1VWWQnTvSw4cvbpsxbA==
X-Received: by 2002:a17:90b:3d09:b0:32e:753d:76da with SMTP id 98e67ed59e1d1-332a95e9263mr7253575a91.20.1758713873531;
        Wed, 24 Sep 2025 04:37:53 -0700 (PDT)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:3094:e599:c13c:81b7:3864])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-332a96fc922sm2462606a91.4.2025.09.24.04.37.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 04:37:52 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org
Cc: jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot+9eefe09bedd093f156c2@syzkaller.appspotmail.com
Subject: [PATCH v2] nsfs: handle inode number mismatches gracefully in file handles
Date: Wed, 24 Sep 2025 17:07:45 +0530
Message-ID: <20250924113745.1262174-1-kartikey406@gmail.com>
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

Changes in v2:
- Handle all inode number mismatches, not just zero, as suggested by Jan Kara
- Replace warning with graceful error handling for better architecture

Reported-by: syzbot+9eefe09bedd093f156c2@syzkaller.appspotmail.com
Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
 fs/nsfs.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

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


