Return-Path: <linux-kernel+bounces-815051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB267B55EB1
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 07:52:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92A513B0275
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 05:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AFFF2E2DDA;
	Sat, 13 Sep 2025 05:52:06 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3898227467E
	for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 05:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757742725; cv=none; b=u1UiyIDR6Sj0DpbKWx3lmE4ppQ4HOXHq7K7LUBL8o8JaM7ko/C4u2FJfjQhTQ+oHRxfnd1ftFjMv6cIpic3DPShOevWbVZt6CXV6on53Slz2m8SRMezzFkzDngMTtdqKCSijAXH419GiMGP07oCMDgiXwa3dLbCz2GGLr33UYHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757742725; c=relaxed/simple;
	bh=xGPegRzuNLv3LRNKDrzS2ewnzTSM2mX5OE4KUOhzgPQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=O3uEnow6G1fWcHrnu0jXH5SDOhm+klRva+5iUDl486N7Yd8EH7QDLME/kguq9DKAoM2jib2SP0T8muXKUfYyWhRzHETLA1eS+y/Rqp6b2kyKJZCsgI+WbaqDyV3MfQ+6nzfs161OT7sCJ23fCeU5wNbR8zul/YodJ0gIsak4mCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3f31ac5bd9cso35254005ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 22:52:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757742722; x=1758347522;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3q4GDTDTfVbRvI3gWdPHWafppZWRiyes43kmSXWWR0Y=;
        b=Rx+9X0U6KyY/NF2OS1PdR7FfSum9sESNmadjPLm9xsRN52mF6KyYtnQvEw2vVPVWH5
         TS8UU4CzhpOBzvZtsHfMT7aq/m4X5NxeGqXLQRm6TkjDHANR/yFo12BIzFyjHKsaNU3E
         RYU04MEhzU62+2+YRMkf7l2uoNbV/qMYE71QvE6niVcloMmm1Al0aBWY5JBiYQuqH3AL
         g4tsOG9b4FGVqNwO2HXm4l3OEBNCmkiUdvQCOTgs+SgkWC/OJ5b0ckjNmhqiRdRXJ4+r
         Dvt7EcmmwdFk3QI3lo8A22OQ0y5jBbXalwSyjtc+QSxCgchOIQXa0rGiOC4PzQMJucgf
         nabw==
X-Forwarded-Encrypted: i=1; AJvYcCVgg8t87iWwBDgu8/7zCSVdkF+mBYd/rXRh796+3tGlZnF//ErmMoveTCzQLMxmF00oH9YS/xoRjhMK/oc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9b25+203Rq65s3M99dCmGw8mh95UyI6UtDKHCApfGVYo3zmi+
	IiJ3jIRmDenbEmPP7QUchHOOnHm/fun59g9hrqgHj/aWMjLAx+xalJlm+PV7dhPZ0egGkf7lt3k
	FA/M/BB/Ps/foF0w9fBzfLZFskUEyu6ZOU6+MxiZrzHizMJUzbsTBUhYFB3s=
X-Google-Smtp-Source: AGHT+IH75E6b9SBa8LhFDw80zMp/sVQyJhrQJ58ghpl6NDTYgceCwekJEwE/vEy7D+gF3MhvzY5EAEzAw6NXmtYe2GbT3nXJsMIj
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1527:b0:419:b24f:30b with SMTP id
 e9e14a558f8ab-4209e64b589mr73259745ab.9.1757742722379; Fri, 12 Sep 2025
 22:52:02 -0700 (PDT)
Date: Fri, 12 Sep 2025 22:52:02 -0700
In-Reply-To: <0000000000008acb1e061618e68e@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68c50682.050a0220.2ff435.036c.GAE@google.com>
Subject: Re: [syzbot] [usb?] [input?] WARNING in bcm5974_start_traffic/usb_submit_urb
 (2)
From: syzbot <syzbot+b064b5599f18f7ebb1e1@syzkaller.appspotmail.com>
To: dmitry.torokhov@gmail.com, gregkh@linuxfoundation.org, 
	javier.carrasco@wolfvision.net, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	mukattreyee@gmail.com, oneukum@suse.com, rydberg@bitmath.org, 
	stern@rowland.harvard.edu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 503bbde34cc3dd2acd231f277ba70c3f9ed22e59
Author: Oliver Neukum <oneukum@suse.com>
Date:   Thu Jun 12 12:20:25 2025 +0000

    usb: core: usb_submit_urb: downgrade type check

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16c6eb62580000
start commit:   e8ab83e34bdc Merge tag 'arm64-fixes' of git://git.kernel.o..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=a9a25b7a36123454
dashboard link: https://syzkaller.appspot.com/bug?extid=b064b5599f18f7ebb1e1
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1514f0f4580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11699a70580000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: usb: core: usb_submit_urb: downgrade type check

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

