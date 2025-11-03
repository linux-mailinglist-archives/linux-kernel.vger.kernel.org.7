Return-Path: <linux-kernel+bounces-882919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C77EC2BD88
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 13:54:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BCF423461BE
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 12:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0749F3112AB;
	Mon,  3 Nov 2025 12:53:06 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CCA33101AE
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 12:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762174385; cv=none; b=EwexrT82yOBWvsBH1n0bQ0/Ja2Gp3eefKsfdBke96MwfCZRc8I+FFewf21paWMhoFBbIf6bfm8KHe24UeKsRIgYGrmoUa2ikR51vzUtemIhsVv2CFDlTUzB20qHqHLYcTz+knjdqHtCH1Pf2AZTtkdAXvJhIhERjgBdzfdeekgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762174385; c=relaxed/simple;
	bh=bj5f9xX1fnJ3dJMGZn4fuhinQ3RL1yDqPcLoBUSc1xo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=G1OMn7c40iFuO8DW+0GC5AdXzrjylOhZGn5tlfpR5EdLGAE/3R4st8ufcpypKxhx33nqB4s1Ihzl9plcjqO8PXZSEwW5CtFoFW+pcTv03Ov+soOTHyrZOqc6AAC0E6m6K+y5Rq69PIUWaCmO0Xs58Lbhf4BMwTHLdCDcL4v6w/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-4330ead8432so28601745ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 04:53:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762174383; x=1762779183;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PZocnu8EPn4lamljcaWUH4pHMKtolYi0r0uHU4tO8xk=;
        b=EtmPSyDs+KoLBOsnMiN26XxvLmkmP76ANlRRT0VjxS9wdR9Mh3+lqFUXxn0pWxE/lV
         A05N3pWbBwYkIT/tj3kqOBoUeCNZBWxnMMaUbV/k6SaCe8BFZVDpcRRbt0w2jTZmE5vC
         FSQ/pujn1fGx3aOIfuCK4DyiYZcXdvgr5j0Tbf8lc9JUrWFl3feotEoPuXNZ1sZ+IFcE
         GJG/Fi7CKpyeFFOcc1yAKK2MvdAM84P3JTMKJ90KCDjd8tcVSq7n/N9PSMBZX5uMd9eU
         q3SMhtftr7UDOJcU1G5S7W2KweG1dopz4vVpGGHF+39Ge30f9NtLkvpNo+kqeNmGSlxo
         wmEw==
X-Forwarded-Encrypted: i=1; AJvYcCU8pceMJr5oh8hZn5/RUYOrKDQ/RUn/uqu3Pj/DtytS3bjHmvNZLwv3F2Cyw5jJPWuH6vrQ4JsFZqACC+E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwI0rjQ/Uj69HhJAGkrlWYlTG37+ErNdGge5jK+8LE2+dFHCjpQ
	8vEyEzr2LiLPP60EkQJrE2whkwu/ayI/6aMcGbF4EWgLTT8uVwsuL9OF2a45pfZN3SU0hZPIldR
	UvN0eGHK16UUu+n0eMUojMpvqN0aAsfePTxUZldjzKYq2Sfl+0aXOqNluEIY=
X-Google-Smtp-Source: AGHT+IFwlFkgaV7o3+DvWgavE3xAGKwP39gDABlIiyrLBCj8TXrT/YzKkM0KXAU1ZlT3M1ezADrzGHPyekAx4Z9zV9/0LDwK2U9Y
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cda1:0:b0:433:2d7c:66bd with SMTP id
 e9e14a558f8ab-4332d7c6b1cmr45662915ab.10.1762174383358; Mon, 03 Nov 2025
 04:53:03 -0800 (PST)
Date: Mon, 03 Nov 2025 04:53:03 -0800
In-Reply-To: <510529165.3578880.1762172846355@kpc.webmail.kpnmail.nl>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6908a5af.050a0220.29fc44.0044.GAE@google.com>
Subject: Re: [syzbot] [hfs?] kernel BUG in hfs_new_inode
From: syzbot <syzbot+17cc9bb6d8d69b4139f0@syzkaller.appspotmail.com>
To: jkoolstra@xs4all.nl, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+17cc9bb6d8d69b4139f0@syzkaller.appspotmail.com
Tested-by: syzbot+17cc9bb6d8d69b4139f0@syzkaller.appspotmail.com

Tested on:

commit:         6146a0f1 Linux 6.18-rc4
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=168f7932580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=72f4d1bb6e3e45a2
dashboard link: https://syzkaller.appspot.com/bug?extid=17cc9bb6d8d69b4139f0
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17391e14580000

Note: testing is done by a robot and is best-effort only.

