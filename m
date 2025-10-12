Return-Path: <linux-kernel+bounces-849614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 864B6BD0803
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 18:57:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 386C93BBAB1
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 16:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6430F275870;
	Sun, 12 Oct 2025 16:57:06 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE5218A6B0
	for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 16:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760288226; cv=none; b=i31/7z/sBO6P3tH/6+2jpvjgtGx/6ge8Rm2xOgqSA1z7LycLd4gZ1dM1DVRVgywPFE1BFqE5NW+Nwl3jeJ/TqG70HeSs7KjAU6YykzgXbSQjLaZcnCEUt4wKbxfAF4KELisJPvGimt0WnJyrRHO3ckcLTqZRm+KbJc8u6tGxv8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760288226; c=relaxed/simple;
	bh=iZWfC0UlgyAI0NIW5GikAlFmHLUkUCTTxa2BYe0tWfw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=m4HkWx8cjVSAgB+0y4U2eqpqJb0pDp3+iIZW8F+guuNFjxQTxLU9o08FWY/hjeq2+NLhrgloNiYjDIrsPX2wPrwM5XjK0a/kkjN5+LUcIzHJJ/Ru8HwHJWVxGxdGxyV8CLUyMXCCFL5PCaZqGNFIfxUQd5EKSz5I4p0APo/HJ/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-42f67904af6so281603405ab.3
        for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 09:57:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760288223; x=1760893023;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nothlIl/S9rOKhMUVs2CWH/Hn6OkMhyW38mw3OgCBQ4=;
        b=j1XBJaTq2FjXGlshfYaPZGelDVT48vsB/gZ0zkZYgyckJJkSviZQbiD+WXOHbdVZzC
         5YJJoBb+N3b40gSucCCVwaDcxGzWGc+EeO1gARnSlxe1g4sAechwXyyZIodTwgkAzI9a
         xtKVjtcuGHknn6OnwAWnK0sUbsc1fNbH0HZB9IX13GEiYoNUgu0Q3e+yLBmPq8e4Zyel
         tBG1wMcX9ZBQ0COz5dsmSy0/2bU6i5hU/qny1Mi/CXknaeyF6/Yq5Gl+YYeL7JvahT0/
         VePwIYP2erR1l3cUgbWme6s5PVyJ/Rb4LGtJRWJ4seymDJvrulngMbaVQTvZK+ti0u2B
         6i/w==
X-Forwarded-Encrypted: i=1; AJvYcCVSUujEpjd9tQFEN9vlvQbRjc8XESo8y0x1IWVJ0UUyxh4AoOGHC8aWcYFrRHIGmDiE/c5ytLyEDBG78LY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6UhgeCNsE87bkAf5ETQbuTUgNxagtUudfkKRyA0GCEVx5xyd4
	r3yxLACpQicNAS8qIvU4pBhx0rBR00DfSgcgDi/uf32ic1PwQLWxN7UGWPp70LaijSYxi6/7oBX
	SB4m7JF+wIvSZ70TWg3j9okFuci7c7V6gwir0YiNXlk7WdEKflYmE13vLP80=
X-Google-Smtp-Source: AGHT+IEbuRdHIu9ArRJXMX2yDy9rVzLie4G7FFqcOa6SL/lGC7ru76cKZDpw+8heIvSAgTcJ1wrmMr/vgK7JeyW4jOwOSujTaNNL
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fca:b0:42d:8268:5016 with SMTP id
 e9e14a558f8ab-42f8741068bmr228290505ab.30.1760288223615; Sun, 12 Oct 2025
 09:57:03 -0700 (PDT)
Date: Sun, 12 Oct 2025 09:57:03 -0700
In-Reply-To: <284359865.871395.1760285980059@kpc.webmail.kpnmail.nl>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ebdddf.050a0220.91a22.01dc.GAE@google.com>
Subject: Re: [syzbot] [jfs?] WARNING in jfs_rename
From: syzbot <syzbot+9131ddfd7870623b719f@syzkaller.appspotmail.com>
To: jkoolstra@xs4all.nl, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+9131ddfd7870623b719f@syzkaller.appspotmail.com
Tested-by: syzbot+9131ddfd7870623b719f@syzkaller.appspotmail.com

Tested on:

commit:         8765f467 Merge tag 'irq_urgent_for_v6.18_rc1' of git:/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1551067c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=568e69ca0c2fa75
dashboard link: https://syzkaller.appspot.com/bug?extid=9131ddfd7870623b719f
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17fc39e2580000

Note: testing is done by a robot and is best-effort only.

