Return-Path: <linux-kernel+bounces-889973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 084A8C3EF3C
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 09:29:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A60F4188C545
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 08:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDD3030FF31;
	Fri,  7 Nov 2025 08:29:05 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E582630FC34
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 08:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762504145; cv=none; b=iNCJJeWOS0GnPl5atmomREYXVDVTxBkVSkcIJYxS6NJ1uIBKXthpZMmbtBlr6jDLnUE6Oc9egO9Lpnlws1IhKgEuGCJCte501kbXmOVXcQGtsP8q59CWK4/1sjpu2YJRixCczLZW4LzlTPFiCZAHd0CeNtxje/40wfA0HJDyIMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762504145; c=relaxed/simple;
	bh=eM1w4ZBPbYDyAQqhBKm9yeExpXKafhylVz6psHKWs6U=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=WD1ImX062bMVoBWHQu8R58lNfrmpAHpHDa/SV8gixOZ5q/czz2zj+TcG4R0JL7Emnhbhwdoo6hZu6s3Z9lwNkuNpvMXlU9joZ7OjOyJ/zuMc+RDbsXZveiKJay8xsLvCjFP7T7sQUsOulDtIgQCTXB/+vQeZ+tRkq0Luw/Yefxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-43327c30cb1so4651015ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 00:29:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762504143; x=1763108943;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IKGznwLgsnKxvJl/fWRptQzEdBM9eB+r6Y3776TINlY=;
        b=tyuw469rEeJw0JbTlD84D70rRoKS+IlbwsTnvBR8+SH3My+3zsX7cHd/GlbXJ4kiDi
         qLGGzU/g7B6Y2Rbh26Ieb9A4ACQ2ZwXdKBL3KSgpIGBVyq9+tsbOtgid99KFSY2FA0dt
         bomW2jTP4gnIF3z59c34wJUiOWkWwqmCLUz4+o/7wp1OrrUbcGtcYCD6cVAWOQkRg0Cn
         fU/TIo0Cc2Qf/aArDZkPjHXey8XL1kJcDmp7RZ56eTZY1p9RNKYxGdws8cu/2V33uf5m
         s+GsRm5YvA4d1NY5Xagj0Kv8x+YTP9+OLd0i7WNni+Brwb+YKqW0UjzvnDJkMgBszSCQ
         IdCQ==
X-Forwarded-Encrypted: i=1; AJvYcCWjTAx91v3yCJ5rQ8Rl3aOkBFlhpzljrDmIuNsEBMKtqLPpOrH54pceYZLb3PmoeWPh5yCeQ2YOskpCEo4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFbFHMmewNG87gwczK5NIN5wFKzCyyuJOTTdYfLBwKJSI0bnni
	wgrdlFdRz+NQ2h3URZyPUITa41aQzVOYI44cXmJ7qOBgP1Q9TuMuSjYB38v5htHVSdTO/ZolIe6
	SxFhrOZQzMdAk+LMtiBzi1IpzECH+NH9/dJwJ9WLJ6aIRNhzBK1TaRtj6/qg=
X-Google-Smtp-Source: AGHT+IEt1bgr9GIx2Or3Ca0/Z0L3S7pHJ8nBvQxShCSy3z44CnyOYbrWwdfo64jehAdnzG4RsKxW4YkN23qeQYugiXbwPm/aB5pP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:ca0c:0:b0:433:3100:b3ea with SMTP id
 e9e14a558f8ab-4335f43dd27mr34640935ab.16.1762504143207; Fri, 07 Nov 2025
 00:29:03 -0800 (PST)
Date: Fri, 07 Nov 2025 00:29:03 -0800
In-Reply-To: <CAKYAXd8HxiEGLS4zBFEKAcxT_qtAFM8Ng0YKZ5seTnB3A_-RVQ@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690dadcf.a70a0220.22f260.002a.GAE@google.com>
Subject: Re: [syzbot] [exfat?] WARNING in __rt_mutex_slowlock_locked (2)
From: syzbot <syzbot+5216036fc59c43d1ee02@syzkaller.appspotmail.com>
To: brauner@kernel.org, jack@suse.cz, linkinjeon@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	sj1557.seo@samsung.com, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+5216036fc59c43d1ee02@syzkaller.appspotmail.com
Tested-by: syzbot+5216036fc59c43d1ee02@syzkaller.appspotmail.com

Tested on:

commit:         4a0c9b33 Merge tag 'probes-fixes-v6.18-rc4' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16bb9084580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=41ad820f608cb833
dashboard link: https://syzkaller.appspot.com/bug?extid=5216036fc59c43d1ee02
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14711114580000

Note: testing is done by a robot and is best-effort only.

