Return-Path: <linux-kernel+bounces-881365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C390C2815B
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 16:32:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8C3DA4E3C62
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 15:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EC0F1509A0;
	Sat,  1 Nov 2025 15:32:18 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7145046BF
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 15:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762011137; cv=none; b=t/3YqF1ftEbiFcHgSxs6zIGQ3Bujd95luvIJhmeJRXkWJP46TX9Bodn08EJEBrDssOJJmfdSAw9nEsDePspTQRaW/hmmBNCe7bqxavaR7eMaB/cvKljJsrCw8VIwCW+yHxu/jq6jniDGGKKcqb5+V1WtV12+sdyoUAN9/qh0EeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762011137; c=relaxed/simple;
	bh=+DCEORwbwEgCvFfUPZJC7EYOPYCBs7y8s1ANZLQS0UE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Yc0L1proMaKohQyrBqrPjN7VWjWmhSnbUDY1/OzxiPNqp8HWbPHFG912rdTRw6xYUACHtsBnRhPiCVxck4rw9y0xXvS7+Gkdrp+KN1rTg4ZNx8DouiArB0zSGHNHMnKAZMCHhP5MxUSPPVbX5rpOj/r6J1NdO8wYElRhb/sE6F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-430c9176acaso46912125ab.1
        for <linux-kernel@vger.kernel.org>; Sat, 01 Nov 2025 08:32:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762011135; x=1762615935;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VwYNdC4hwCWArJ5ww2aWx8avTGASfURjrPlohlEaNj0=;
        b=p6ZczLE3LrXhZV6YRAauPDXtGBmBYFZ47Zc/KYMaFRQMsLGDPQLiqrm52xv0YSigkQ
         2MnK3w4Y7Z2Tvby1uroGU8ABXMUhhjdNX+zWUyvADikLad3fVDM2CopAMd/Mus6Rumk3
         P9Ebm3L1dh2qA5tjyVjEaUScQiFBrH9I1AlJj0HlrmT1tf+hMIFacSuw0Cbo1tQ4bsPk
         Jkco2TYX/Ty+mDcbolmjVK+wlnZdnL66Zm+bZf5kwuVP+pw2nkK0rF8mFvl9dauhs04+
         eDfccpXxcpx6tKT3berTLyzPWYQMEOjgYaEer2LqI6vi0KCy+DFdqn28i4iBSq74u3t4
         KAEw==
X-Gm-Message-State: AOJu0YzxnDyqdn558Xax74+FDQXVk1NBCZQQAM3fUB6Cf1ltWBAA9zgF
	ztVbjV9q5G8rj/Uer/0G4UI0KmqZ5lqJnJtmYlm9TBpNSZd7wgBP6ls88hgUIlM5TNByE9HBoY+
	zYe58KSDMQjSZA3EDdD4196vIckqFrwPOok5Le8GzlvEMqzQfEusdpr202PI=
X-Google-Smtp-Source: AGHT+IFtXgXPrbOyVXblNlFaFlu4EFUG112IZKek2EoHgbxNl+gflRU+KB+DyzpJ1+WPBmZcof2kdvDZhASqsBIGpDxFvKcTzpyS
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3f13:b0:430:b2a8:a9eb with SMTP id
 e9e14a558f8ab-4330bd799bcmr120340265ab.1.1762011135606; Sat, 01 Nov 2025
 08:32:15 -0700 (PDT)
Date: Sat, 01 Nov 2025 08:32:15 -0700
In-Reply-To: <68d32659.a70a0220.4f78.0012.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690627ff.a70a0220.37351b.0005.GAE@google.com>
Subject: Forwarded: Re: [syzbot] [fs?] BUG: sleeping function called from
 invalid context in hook_sb_delete
From: syzbot <syzbot+12479ae15958fc3f54ec@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: [syzbot] [fs?] BUG: sleeping function called from invalid context in hook_sb_delete
Author: m@maowtm.org

#syz test

diff --git a/fs/inode.c b/fs/inode.c
index 1396f79b2551..b28a61978d88 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -812,6 +812,8 @@ static void evict(struct inode *inode)
 {
 	const struct super_operations *op = inode->i_sb->s_op;
 
+	might_sleep();
+
 	BUG_ON(!(inode_state_read_once(inode) & I_FREEING));
 	BUG_ON(!list_empty(&inode->i_lru));
 
@@ -1968,7 +1970,6 @@ static void iput_final(struct inode *inode)
  */
 void iput(struct inode *inode)
 {
-	might_sleep();
 	if (unlikely(!inode))
 		return;
 

