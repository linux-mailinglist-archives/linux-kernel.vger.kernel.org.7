Return-Path: <linux-kernel+bounces-839642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A4F5BB2101
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 01:24:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 599764A3D2A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 23:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6448729B775;
	Wed,  1 Oct 2025 23:24:05 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D81024A076
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 23:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759361045; cv=none; b=X/rY5d/0S+FVG4VKvQJqtlsFzNeqGYWZz/TeoP44A/ibdRBt5x9eb6ASJd0a1SI9sZTGvUGyov1RckWmVtDaW+NrrujaAD2EUp7REwaVINGpul6RjoLPglXRVdscbI26m203bLgKySHDnGVBIqvWEttbk2IQfKAKse+0Kgba2pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759361045; c=relaxed/simple;
	bh=Yb8Vrh4uA3QvnqJ8boNP4TvqcHP9z9p7y1sjVIL2Gdk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=A8YMadloYu/6f1RO8aZUjxXo6K9gMWB5T56DVbkAbgG8UN13uirJH2v77cNk9Gc0Hh/nDYlIWGQSB4pk3Aq3ny/PAycuNAAsslNAo6cfcNAYcku/T3msngO9NvToSB0bBXY8bx0+IjJ3xm+bax/Z2eM9Cq6S0MIuye9jrpZVX6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-937e5f9ea74so46094839f.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 16:24:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759361042; x=1759965842;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4O3mEcf6qsBybWP1wjmafctGXSIfcjSxLwzlg0v4NRY=;
        b=tYwKJJo9DKG2fLe8nMlyPRoRdKj/0Qjk9/QlGL/z8gpHW4o0l7LLwEK5fzooUFO1J4
         dVAY6vDt3oNueNZO7Y3eF4te/rqyUbTMk4hli31WPl4XUuOxbqEaYW5WxTkxjYK3JYev
         lbQ9ewzavoyIWPZLV7nQvVbypJ9CYnvT+4FSarerRTIJNroou2IgK0YF3GDFnbOWLYPZ
         eeVC7emepQ4pfcB4zJCf3W4gdW9/u5SbC9oqT/AwpDxHt7NOb7BOnkNPXsHAjxx/5R2Y
         CgqDlBMB4hwA/vNp76Uc2iFucEbrPuxkOrgHBFPBUZozk8V/qNtrGD0FBUvkfKHHqvpE
         jfLw==
X-Forwarded-Encrypted: i=1; AJvYcCWrNiTbwnnaCn++9inBz71fC+q7n7aQFGWykdcRKmxquw9kLK2amsI/2nGnRN6iEhu2KtX4lxcP+bGVBfk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnOvkyTQ6vpR8hg5HNRVT+muW8WAMW9lVAuvUdmChGx8K9uMBN
	OdXJsL6TqaGALiCuBn8c49UeUABR4kf1qa9HTYoNbhot+MEuGpcp2Nx/NeFSD7wqbWaLj612r6q
	fVZDKXdSv42YgEhTgL5tt2O3/EKdaag8GnCDTqlN9q9L3JR+xONCUawcUfFA=
X-Google-Smtp-Source: AGHT+IGOe6mvjPv/yBekmWM/bVWYvVryfamq1nInf3uEj/wLuMJbXmq85Di4OUwk4jbCkukFpdW42zetU1J7veV15eiQpcBPo02o
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2b06:b0:936:acb:5864 with SMTP id
 ca18e2360f4ac-937a8239b3dmr834902139f.5.1759361042600; Wed, 01 Oct 2025
 16:24:02 -0700 (PDT)
Date: Wed, 01 Oct 2025 16:24:02 -0700
In-Reply-To: <aN1yNdQbiSD7jMTl@chandna.localdomain>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ddb812.a00a0220.102ee.006a.GAE@google.com>
Subject: Re: [syzbot] [bpf?] [net?] BUG: sleeping function called from invalid
 context in sock_map_delete_elem
From: syzbot <syzbot+1f1fbecb9413cdbfbef8@syzkaller.appspotmail.com>
To: chandna.linuxkernel@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+1f1fbecb9413cdbfbef8@syzkaller.appspotmail.com
Tested-by: syzbot+1f1fbecb9413cdbfbef8@syzkaller.appspotmail.com

Tested on:

commit:         080ffb4b Merge tag 'i3c/for-6.18' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=142856e2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=17002aecfc286d89
dashboard link: https://syzkaller.appspot.com/bug?extid=1f1fbecb9413cdbfbef8
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=131b912f980000

Note: testing is done by a robot and is best-effort only.

