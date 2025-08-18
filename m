Return-Path: <linux-kernel+bounces-773623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDAA8B2A298
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 14:59:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77B63622682
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 12:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22C7C31CA6E;
	Mon, 18 Aug 2025 12:56:06 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA2B27B355
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 12:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755521765; cv=none; b=ossHfjGO1U0aY3NQ1bEi0jg85kJX6dY/MSfhLNnzFWi0ZfjyGk+VBfXEAX4ykVJGzqStgJfUtHt8wocInz9Nwo/KT8ZJARvHha2p8IJ1gjWDPuMzH+7db0I52UXLpnPK6pz6H7d0vDwxwpwYi59F1gVV2yD6TPgR0yzfxcJBHEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755521765; c=relaxed/simple;
	bh=hjevJhTPSzaNsPbiCRMlw7XODHeDtuChrkgNxX58Fto=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=rG+PtUWMukpa8XhOnv8imHPr5D67nJdhlbwMxM0je9+6OMdT66PIp7VWud5//PEL/LsXf5QUJRaOiZOSCLDM1TjXyX1HYsqe7ZamfnxcVQXpBJLxKDkVsfMUt7y+wLRdanZGfwcVPWsnR/NBcu1B3NGpi8vsCnps236b16rQnN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3e5d398a961so57260985ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 05:56:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755521763; x=1756126563;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NX93WSBTJ05Ivc6BEiIOWeOPQPiP+fK8Sz0GY/O4zc4=;
        b=SLU03yMlCmb1eAmf3xqMY/5Zt1NgOjaidHYUwCHlvBZpNekJmsnzg2nf/ys9MJoB2L
         93ZrZ2wRqx6iRdWMXGSkNi0HlYxe8wAgkw50wWXtBde9hguH0YT2yVFGIs742v14b/6B
         0A+x38eR0KA8mqiP2uQuFFO8MjTiF8JWdl3IAPXJHQd6Zs5BFIEDHgljaubn+18ohMBD
         ZNzT2wBrJPsVUHFV+n9HF4eQH1aazAp1oH6ZZz2ttzbfCAOJSgQVxjXuGWxHJuYcyuyy
         RLEhsOB7Pr+VzSriOMPUpSuZP5VqQw8uSk8e3zsRpoZltyFB+qZGfO5jyzCuOg6Z1JDD
         htSg==
X-Forwarded-Encrypted: i=1; AJvYcCWTT8HnhZfv4b2+IUKvrPWE8OTxV00RpxUbOKe81lIKibT+jG/3n64ugI7k4dWTGExDujOkS093wPXhzs8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0xZG9k7sVxPvI6wLiXWDixn+rF73pXKUH/c91AYY+59IZtTE4
	KNjeUg3miroFVZP+u2rWW4dI9whOADfqkAlLIgpNHijSDCEgBBFBdD32lD4ApcgHrSDtsp7NNaY
	f+HW6kJwGl5GO52MJkLixGfVrAavuphK+N/Vatx+LxGBEarEb/di8wH/TSQM=
X-Google-Smtp-Source: AGHT+IGkuvlwu4mI8pMZwo9KW6bP24fbad2mbz6Q7pJVSKOoGc9tk+MbhdWW8H05AZ84psWblQe/qSfX+/dxZ09cnb0dwvZVIFZF
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d8e:b0:3e5:5357:6de7 with SMTP id
 e9e14a558f8ab-3e57e82553amr232423835ab.4.1755521763496; Mon, 18 Aug 2025
 05:56:03 -0700 (PDT)
Date: Mon, 18 Aug 2025 05:56:03 -0700
In-Reply-To: <6bd5ffe2-8f28-497e-9092-085e5d1cbc1f@redhat.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68a322e3.050a0220.e29e5.00a7.GAE@google.com>
Subject: Re: [syzbot] [mm?] WARNING in move_page_tables
From: syzbot <syzbot+4d9a13f0797c46a29e42@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, david@redhat.com, harry.yoo@oracle.com, 
	jannh@google.com, liam.howlett@oracle.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, lorenzo.stoakes@oracle.com, miko.lenczewski@arm.com, 
	peterx@redhat.com, pfalcato@suse.de, ryan.roberts@arm.com, 
	syzkaller-bugs@googlegroups.com, vbabka@suse.cz
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file mm/mremap.c
Hunk #1 FAILED at 323.
1 out of 5 hunks FAILED



Tested on:

commit:         c17b750b Linux 6.17-rc2
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=f9319a42cfb3bf57
dashboard link: https://syzkaller.appspot.com/bug?extid=4d9a13f0797c46a29e42
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=107dbba2580000


