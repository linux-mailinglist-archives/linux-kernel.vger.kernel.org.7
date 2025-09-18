Return-Path: <linux-kernel+bounces-822021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F0D7B82E04
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 06:20:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 328351C213EC
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 04:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E945524468C;
	Thu, 18 Sep 2025 04:20:04 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5FF1FF7BC
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 04:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758169204; cv=none; b=bHTlb+OxkMRg+7Exr99eSCdjcV0JDELGgS1DYjIz7Fqn001VDUCtZoP4crcfCPE6nSQR0YNygV3moy4kyE4GWtHof6XMMdxvVgE/wjrgpv10VBDthSo4YjonFCBy8c6yFbekpOdT+dl04f5DP7nxBQnYtdFXoD0kG4pEtYJegO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758169204; c=relaxed/simple;
	bh=LbnaHd3EmgJtqbn7Fkiv1QyN3WXQtN6rXDDVivuHz+c=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Fr0kg7vbGWD1w0lP1cbDWDbxFKXrK2Oc5DFxLNqJe7lFLJRB0ATiArZOcveK2sikyP3MNdrzb+L9602izUl7uRNQB2R+NWR7Ul/YZXgPomkF54vR9mo3wBfobPHi5oQpjqjqOk3CE/uT0LwsokNucI7qfdjatY0ZHvQG/a5ng+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-42306862fc5so5943755ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 21:20:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758169202; x=1758774002;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ue/YAm3cJpgDhidtCqMMc4btQNUiwme+VAaiL1Y76ew=;
        b=If3A9rUHNf/Jakv61K76P34/8jRWyIwn98aHYU6TROTocCe/AEbiwJFXVSwZ5cq2py
         +T0igI7K26oNk6JhT13RMsU2sNjQkqwNQqsgGYR7PuXbd79F/bYIHT/v8vjpV2u92d9R
         E1a/AsaNULPy9pkUDk07i044k/0sBbrguGj1Y8901rmatNWt06d55kFpQVaunePGYkQm
         QYTmIogLKuOzczcvEQ6XNPWNr7ZJaIeI2M1IdQey4I9W72slGgJuSB9TtJcSvHOuegTh
         uiUtw42qcJbET1pl1ShIAPw299w4SNTiy6Y8uiEKa2sHJDRIEPOVMIdLL07Je0/MHnkX
         kQgQ==
X-Forwarded-Encrypted: i=1; AJvYcCVUCMz4eCfAm0YkxfAOe7kvqEtPkB8xCx0hFFBKrLyaA3Fcbb6Ki/CSFcvJMH2dy88u0yWH4MRJWY2cSgc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFzS4UlyXc4017W6lSXKcs6RzAGEIO9wCQUjiPZ87BKt9HAMUx
	/UFiTT0c7dy24aCslYAFpg2gtGoFAWifqp3mQ2VCxnVGJxTmJo7H4vkWlJlgz9EuHVCDoYyGSKJ
	koxAPChADplX3n9YD6QNvIji94FgV54rxHu1w2ZWjocH8bZT2WhXczkGs0LI=
X-Google-Smtp-Source: AGHT+IGL3ip0Nq9Gp1spnwgnX9WRqm3n93HcfW1YG+a8XTMHyT+gQAnMDx7W5C25edBFW+vPViM5/vj6lQA0jfwKpyJbtFOY+hp5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2290:b0:3ec:e669:7d76 with SMTP id
 e9e14a558f8ab-4241a4efa49mr72478785ab.14.1758169202135; Wed, 17 Sep 2025
 21:20:02 -0700 (PDT)
Date: Wed, 17 Sep 2025 21:20:02 -0700
In-Reply-To: <CADfthj0NZ7duGqudQRUfmE=J69+hBkb+gWKQMVrJ18hDsMUGpw@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68cb8872.050a0220.2ff435.05a2.GAE@google.com>
Subject: Re: [syzbot] [ext4?] WARNING in ext4_xattr_inode_update_ref
From: syzbot <syzbot+0be4f339a8218d2a5bb1@syzkaller.appspotmail.com>
To: albinbabuvarghese20@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING: lock held when returning to user space in ext4_xattr_inode_update_ref

EXT4-fs (loop0): 1 orphan inode deleted
EXT4-fs (loop0): mounted filesystem 00000000-0000-0000-0000-000000000000 ro without journal. Quota mode: none.
================================================
WARNING: lock held when returning to user space!
syzkaller #0 Not tainted
------------------------------------------------
syz.0.17/6582 is leaving the kernel with locks still held!
1 lock held by syz.0.17/6582:
 #0: ffff88805849d798 (&sb->s_type->i_mutex_key#8/3){+.+.}-{4:4}, at: inode_lock_nested include/linux/fs.h:915 [inline]
 #0: ffff88805849d798 (&sb->s_type->i_mutex_key#8/3){+.+.}-{4:4}, at: ext4_xattr_inode_update_ref+0xad/0x650 fs/ext4/xattr.c:1025


Tested on:

commit:         592a93fe Merge tag '6.17-rc6-ksmbd-fixes' of git://git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13caef62580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f5b21423ca3f0a96
dashboard link: https://syzkaller.appspot.com/bug?extid=0be4f339a8218d2a5bb1
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14c58712580000


