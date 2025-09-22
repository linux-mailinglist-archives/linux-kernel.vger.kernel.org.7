Return-Path: <linux-kernel+bounces-827890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4B4DB935D4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 23:21:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98E35446478
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 21:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0535928850B;
	Mon, 22 Sep 2025 21:21:06 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12746283141
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 21:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758576065; cv=none; b=kxFe/PVN1Q3urbgWVpGxqo3CT0pJ2HhjHtWCQDMLzngTEWTSZzEkcMxnW4sMi5jDshMP6rVWBxlIzFCJb3rYexNDWczoPgOxSN4DAeDGG+qbd0KRdXUvyIjxh6WYceqLtDXQCxYdRa9AT+yJ28/V8W1/9YGxWLcJQw8wALoG4n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758576065; c=relaxed/simple;
	bh=r3NpGz1qBNHJUaKYOiNUrMQdMwwoP6Ucp5LUoYR9YGI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=MD1vgYXXyBwdV4jLuvg4mnHrK8J6Eodkos9uSrrb4cwFlolTN8yO9NcJEzZvr7ZvAY0iSQxjOhAZjPIek9jky/bnHfY0ZupsLFSjhybE4swDljPLtWW6DQqvvLHOPIESB4mnecmXTfxwnIQ1shHDDsYYX1sL6yLmRw16nnGFdaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-4247d389921so57369185ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 14:21:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758576063; x=1759180863;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pEXVzVh1xRpn36QUJyWBl0yE9J7HW6QGqDG73VIJJTE=;
        b=XbM0Z7N9z8gJMfQ5CukCqYRrgt82fdv5iMnEG4EdWp4AflvUFixr0VctUwzIb4Dl8k
         wL8lecC4zgV/J3Y35CVoOGrOvlg1vGF+UF+S8VceB3jQh/5g/2gGMbyb36VSKEovvY98
         nPxJH8XttQd7a0Nr/JuR4fvvVLLwf6nhY1myutmkLgdNrbEKA2+b85KgBr/jUnBKbxQA
         mxXf1701or72pSQ97+qr3xdTeXJ1XaIgGS5obR2OeL+eXC51Ef8sXsQ6H7jXkf7Qd9tU
         bk9OqKoGuSAGZ9CWtNh5TPmYip3KkXLUKrr6tTTDsc3us/KdxwBTRQTwFydFDksqq4Q5
         d7nA==
X-Forwarded-Encrypted: i=1; AJvYcCUDBA/8HUivNydZnUp0HVv6Ja33DAagEqCKmULJvjRo+B6Fdm/NphdUwqC73cgr6FICi3iNGKAI9tfm4Ds=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4Q+Fu9vImCUMQ9/ds5Q+njzuNGHDG1zTo64IXo1taVIVEYroz
	j6ckK55DHFwdjx6JSRfqzqOx7Z0SSBdxg/c3FXnFi/REg/DrlEGlrEV1FAjLjs2cGFhGYjkzz7O
	SwzEGUA47bko08uRs+rfugxUSrsY21CjahksToi7km33au0/XO0/Bpq21I3Q=
X-Google-Smtp-Source: AGHT+IHJ5Lcy1PFoE+1HFqUxDvjXb3iEWiVH3SD6SKxbsyUcUF2l8Pan6sffL9AvGWy5az5bN517uy1gywSblFEpVuz8oT8HE9qK
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1542:b0:424:86d:7bb9 with SMTP id
 e9e14a558f8ab-42582209805mr3563505ab.0.1758576062967; Mon, 22 Sep 2025
 14:21:02 -0700 (PDT)
Date: Mon, 22 Sep 2025 14:21:02 -0700
In-Reply-To: <672b23bd.050a0220.2a847.1ba3.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d1bdbe.a70a0220.1b52b.0003.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] INFO: task hung in flush_delayed_work
From: syzbot <syzbot+ab509d831d9b0222f5fd@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, glass.su@suse.com, jack@suse.com, 
	jlbec@evilplan.org, joseph.qi@linux.alibaba.com, linux-kernel@vger.kernel.org, 
	mark@fasheh.com, ocfs2-devel@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 276c61385f6bc3223a5ecd307cf4aba2dfbb9a31
Author: Su Yue <glass.su@suse.com>
Date:   Mon Jan 6 14:06:53 2025 +0000

    ocfs2: mark dquot as inactive if failed to start trans while releasing dquot

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=140da8e2580000
start commit:   2e1b3cc9d7f7 Merge tag 'arm-fixes-6.12-2' of git://git.ker..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=11254d3590b16717
dashboard link: https://syzkaller.appspot.com/bug?extid=ab509d831d9b0222f5fd
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=142f4e30580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12c00d87980000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: ocfs2: mark dquot as inactive if failed to start trans while releasing dquot

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

