Return-Path: <linux-kernel+bounces-846249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B802BC760F
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 06:37:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8416019E0E22
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 04:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF62F259CBB;
	Thu,  9 Oct 2025 04:37:04 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019931E492A
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 04:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759984624; cv=none; b=E+KtjDpSejE68uKUirS7scR9k1vC8bEYYIDrDDrKG0C0yqJsPA7t5oAILUKhKlkWZPQvDYCKFI47r2uJ7XiyfBK1RsdT7IM/SfnXRz/Y4vAp/rPG+GqIl0aTW87yve3X0ZtJTHuwVmvexDKHnqzCesyWnwkxPXDpHEgfo4ul6V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759984624; c=relaxed/simple;
	bh=x3+J3puH18iBtu0p4Ngzz5BBjq/bEkLSu2XcZeKJnbM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=DV3pN4pxZU/FnqKrbQyieX5H88UC6lMVtUeA2xEFRy7Q5sX1JBiH30WDAaZoio6Eud1mkxOy3lruQ0zD+ZEt7zfW24hpQR3IijM1clgsuFznuJ7UOzoCwUwf9KZY7YD5ewrKdWv8iRXano9mhTYVbRH5ioJFZlM3p7aC9xrpXSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-911c5f72370so106971639f.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 21:37:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759984622; x=1760589422;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=43Zf1ZyH9cln2BnLQLjK/Ww8CSXVGpBmlcxa8YPOnfI=;
        b=miIJblbC24vQDR0gM3qBX0vhcIODtil0t/h+fyxhv3gnQetmgz5tv+azuNMFkUlBgq
         P52LVrozGER9M0cBNRwjs5a+QZZb1Y5UvM95SwLv1kAoNT8Bus1YJikVRGhCJLS2FeJ8
         HXqCGnTh720cVzMGGmiEH4Ak+BBKT5EgEdd4bITvX1BA9NSbgIUNJGNOfmrUYoTRHJGX
         InBfdmcdrKI4UHO2XWO6yyUchlljWHXxqo+HJRTq8kkezRBa3/AJekjlMO1/2SRhIm37
         uAJhz1lUDQbz8fECWKBG0xFvREKNqEehhHDCNmjf/7+gh2kcdEopZJkQ+VA5eW644O/W
         VRDw==
X-Forwarded-Encrypted: i=1; AJvYcCVLciEWxUsL8exPNFyNhdhdp5z9dWJV071HOlyjEq20xvvj45/aW3NbQ7Nh4ITpr2DRz6Ks9SdlU4hV9mM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1wBffyl40lymJpOdm42HsmX/7xhGRNj0UJF7RcCZQSRbLTxIB
	HzRMnuphhB57tQYdZc1Knvs0AxsgJDWmWBKKvu4ZnRXvLw1XY3ey9diO629oj2X4ImudLQQ5XvR
	w2YdfqGh36naqkaWDVyLPX774z5w8W1Ys6QIy2AVCtC2lxMB/035k4DTG/OE=
X-Google-Smtp-Source: AGHT+IGt6q+midDEfUZFIkUDMKnVssOlfxgCVejmzPI3mMpG3CFD5Wb1tQ9IL6hr2PME+yiTyEVwanNvqOaiwsze9RPLHH0X9L7J
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6d8e:b0:93b:c4b2:2b46 with SMTP id
 ca18e2360f4ac-93bd19b966cmr639084839f.14.1759984622155; Wed, 08 Oct 2025
 21:37:02 -0700 (PDT)
Date: Wed, 08 Oct 2025 21:37:02 -0700
In-Reply-To: <6897b156.050a0220.51d73.0082.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68e73bee.050a0220.256323.0174.GAE@google.com>
Subject: Re: [syzbot] [mm?] WARNING in try_to_migrate_one (3)
From: syzbot <syzbot+63859a31071a369082b1@syzkaller.appspotmail.com>
To: Liam.Howlett@oracle.com, akpm@linux-foundation.org, david@redhat.com, 
	dev.jain@arm.com, harry.yoo@oracle.com, hdanton@sina.com, 
	liam.howlett@oracle.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	lorenzo.stoakes@oracle.com, riel@surriel.com, syzkaller-bugs@googlegroups.com, 
	vbabka@suse.cz, ziy@nvidia.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit cf1b80dc31a1137b8b4568c138b453bf7453204a
Author: Dev Jain <dev.jain@arm.com>
Date:   Wed Aug 6 14:56:11 2025 +0000

    mm: pass page directly instead of using folio_page

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11f121e2580000
start commit:   0227b49b5027 Merge tag 'gpio-updates-for-v6.17-rc1-part2' ..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=2ae1da3a7f4a6ba4
dashboard link: https://syzkaller.appspot.com/bug?extid=63859a31071a369082b1
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=117c72f0580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17ab7ea2580000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: mm: pass page directly instead of using folio_page

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

