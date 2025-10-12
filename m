Return-Path: <linux-kernel+bounces-849583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F3E6BD0723
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 18:22:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1DDB64EC7ED
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 16:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 422132EFD88;
	Sun, 12 Oct 2025 16:20:03 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748B02EFD9B
	for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 16:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760285997; cv=none; b=FUCfCRwd6KgYqdTS2o3Nq8lfCvW45jLn70WxyT2z5QdTIkWaVPxKEqkyLsdnQXAS7J5odJe/ShM6/qwySxQWqEDUOLmxNAO8TmWo4CyOtuQ2oi0Jk+DBJCE3ToMa3xbegQ2t31wmx/AOgAh7W3g3xRTDx+ZiKhB9A/4kf7qiMRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760285997; c=relaxed/simple;
	bh=VaSd3xs2k2S6zQm1GCRHcYov0X9WcwCsqRLMCsR2pG0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=uv4WlkQ97bq+thnG30sKk1MrigOsJGbsS0cF8fdadijDhjVxkHeA+2PDvdYfL9lAgUpvfrMG1WUIXozW40iJ7kmp2J5jAfxuOvezN+RVDb3FK0lX7ZsuvdPtXr/F/l8Czwvkcc/FnqPCIgt0eLeuVf2IoI2OBUfPF3EF1+6H42g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-911c5f72370so999827639f.0
        for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 09:19:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760285981; x=1760890781;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h4F68hFcxGxXMTCL25edS/3/kfVYHUBJSsbVDzM/jEU=;
        b=o0NBP82z1jb6lHm2ySnPnuh2PhkOSt8RLt419QQfdj+KuaGID89JCIPI69W+z/QNKj
         /wIW0xVDZvPOUIrOneXyuoidj7pcESfB/1uAjS30DKSKsVdnw6mC1IRfGWlYKuzGoH4/
         Kl7Gauv0hR4XjpsDjORdDDJNwChlTDj8krAx32RF+Dj7sRKwJ289oHTDWquXC9XWU7cH
         CuGfPCWb3BYOjbE1FuQOC2yCNBp01I4zCDXdI0FgLMmnWrgWSkua29uqR7hLdUGvpVtn
         65X5+Z5J9ZbuvZsFveLuBoC6fh6duNKhOwoiHILepDiBMyqSlzv79MdTh9zOVYX82rfp
         TN3g==
X-Gm-Message-State: AOJu0YxeNBYSDs8okt45vymG4L/qDesG5CC+ugyw4OXmkcWiTx+pN/79
	IovJkuPT/scL9hVHPdGjXhcM01ZCE4U2IXUU9TEANrWtyuurDV0aHJfdykMCDtJW0M4vvjFmVVW
	ghRuqQVozJPnHIiAAMLEIl594qL3gvpcU4F4ZORBFcZFi5C1OQb/6CVMZeTw=
X-Google-Smtp-Source: AGHT+IGluL/OaVhIfcNTHXn0kChayMfdba8ZcL4liZpDtIkOw/kIV53ZpPA/jM9gcH3BOqky8UpTDjowcjZS+0gKfyAveGHqycRz
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6416:b0:919:9bac:8bb0 with SMTP id
 ca18e2360f4ac-93bd19f4688mr2540068039f.19.1760285981150; Sun, 12 Oct 2025
 09:19:41 -0700 (PDT)
Date: Sun, 12 Oct 2025 09:19:41 -0700
In-Reply-To: <681d87ef.050a0220.a19a9.0125.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ebd51d.050a0220.91a22.01db.GAE@google.com>
Subject: Forwarded: 
From: syzbot <syzbot+9131ddfd7870623b719f@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: 
Author: jkoolstra@xs4all.nl

#syz test

---
 fs/jfs/namei.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/jfs/namei.c b/fs/jfs/namei.c
index 65a218eba8fa..37cd16a423c5 100644
--- a/fs/jfs/namei.c
+++ b/fs/jfs/namei.c
@@ -1228,7 +1228,7 @@ static int jfs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 				jfs_err("jfs_rename: dtInsert returned -EIO");
 			goto out_tx;
 		}
-		if (S_ISDIR(old_ip->i_mode))
+		if (S_ISDIR(old_ip->i_mode) && old_dir != new_dir)
 			inc_nlink(new_dir);
 	}
 	/*
@@ -1244,8 +1244,9 @@ static int jfs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 		goto out_tx;
 	}
 	if (S_ISDIR(old_ip->i_mode)) {
-		drop_nlink(old_dir);
 		if (old_dir != new_dir) {
+			drop_nlink(old_dir);
+
 			/*
 			 * Change inode number of parent for moved directory
 			 */
-- 
2.51.0

