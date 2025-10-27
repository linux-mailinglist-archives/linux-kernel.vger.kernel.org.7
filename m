Return-Path: <linux-kernel+bounces-871505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BCD54C0D82E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 13:28:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BE6F3AFFCD
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 12:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8278F2F6904;
	Mon, 27 Oct 2025 12:20:06 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029EB2D949E
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 12:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761567606; cv=none; b=jLmf1YNqyeARzoZynRiBRLLTcrYubtQ+RQ0SYTKejMD2fjnCqVTPsVP5DtCLJWnSChbZq9mUBhb+IROSyf2errUQfqpZwNJmUansnbWI039oRFWpP+hlSjglVmXB4yvIS+ykogSTzllwsbO0sFGN3c/+nysFo9/nYOq2pI1IrzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761567606; c=relaxed/simple;
	bh=+v7ks9/eTNNhXqjj83VGdNIZhAXyFvyg3wHQrgrPCtQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=lHJzYe27U3TEbEikxIVbO+YqL/FJ3F4Wd2MbJ7CVV9xuDMSBY7x5wPGs9PRsg7gjEEEX3nRfKYo3VRU4D2C4oldVgR+6/84MHjzydj50wjNlK53c2XcKfZDFPfXcGv9fCZF7ggFcgFAs+bMZN0Rd/Xe7TH938NWzErb1aZEFgwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-430c477fe44so52311415ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 05:20:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761567602; x=1762172402;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qkdLZi4ZV+215bJaTi/JeEB1alaBWY0kyjpkyUYTr3k=;
        b=ueGEG6SPCi4cNowCgZxZbFsqRIx+zb6zgpTiclWJmJj04vF413Z+ZuE/d/RKvQi9Xc
         XU7IcbDgOhhRmjXZFMYNqMynUPLIJp2er+b5rW/YPB12Z4MlXFajMy2B2aAa5WF3B1kr
         zu693WqyTFtjX/+/28lpe5Y01sGHxcm4OhG1isTWccmoGSmNtetbF6NvGxtdA9AE3z/3
         NQpFeNsQD8D2hrZc+1OrF6QIikCdJO10AjTR9ZX+7AmjKxLp260V75VgE41bQVINSEsY
         xwxsKYtRbWP/AjjUFbE9bGwvITnTnV26C9YMuOYIZVURFXNjvdkOZ+lM3H3j8K3P9XzR
         WtVA==
X-Forwarded-Encrypted: i=1; AJvYcCWfbE1aNpgBOZSpnj4sPm+tq3FPrXWjtFoZpH3hCx+806TvgUVp9nD2/FDr7TrrTu7cQawhXaeKIHCYjqc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZkSQSdDCYqalZKw73VO3YaQNIp+3G7/c7O6IfY7VnAFFuEpq1
	uNUl+SYRTItWGQKdSY+3ELCNuW2J0zLqCo/xt1ZkyykD8dUBPhK35nVQGn+RHXiSVfw6OSYzgp5
	7U/K1CY2QFZD72vQBKnJ8E3B4+ys8uETrVeoq69rfW2I+O7PNt17jmRtjkkQ=
X-Google-Smtp-Source: AGHT+IHfAtKzApOq/yF+X5k8SHk/HjFQMhS741f1oSYAqo7YLgpQGhwkBXZCLE4F7N/1tfWLOg4KPNfxoTqWPW6jXC0CoLi13FsC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3c04:b0:430:b27a:7702 with SMTP id
 e9e14a558f8ab-430c5204155mr511415395ab.3.1761567602122; Mon, 27 Oct 2025
 05:20:02 -0700 (PDT)
Date: Mon, 27 Oct 2025 05:20:02 -0700
In-Reply-To: <68bacb00.050a0220.192772.018c.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ff6372.050a0220.3344a1.038f.GAE@google.com>
Subject: Re: [syzbot] [bcachefs?] KASAN: use-after-free Read in bch2_prt_printf
From: syzbot <syzbot+7f176adb30b21606c5fc@syzkaller.appspotmail.com>
To: david.hunter.linux@gmail.com, kent.overstreet@linux.dev, 
	linux-bcachefs@vger.kernel.org, 
	linux-kernel-mentees@lists.linuxfoundation.org, linux-kernel@vger.kernel.org, 
	nirbhay.lkd@gmail.com, skhan@linuxfoundation.org, 
	syzkaller-bugs@googlegroups.com, torvalds@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit f2c61db29f277b9c80de92102fc532cc247495cd
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon Sep 29 20:43:52 2025 +0000

    Remove bcachefs core code

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1190ef34580000
start commit:   d69eb204c255 Merge tag 'net-6.17-rc5' of git://git.kernel...
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=bd9738e00c1bbfb4
dashboard link: https://syzkaller.appspot.com/bug?extid=7f176adb30b21606c5fc
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17f99312580000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: Remove bcachefs core code

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

