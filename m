Return-Path: <linux-kernel+bounces-745140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52034B1158A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 03:07:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F04A1CE4729
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 01:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03DF5194124;
	Fri, 25 Jul 2025 01:07:05 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E6B43ABC
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 01:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753405624; cv=none; b=jip1j+/vtaf3DJfs6b64Od1HCMlDK+Fiq0/qX/MOX9GWYWO9hvUs+nAvtFzDQvCY5SxhmMiuoFzzt1CYgKTUKceSXTwuOazO5+bVGTFdGkfmTOIg8Q/PNWi1xS5iE8XN2vXcR34degcExWOqOFxPqMpRQvFN5fR25gYbgJjCcrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753405624; c=relaxed/simple;
	bh=CI/RHgSQQPq5cz4oz/qODNELT0mcE3KfaOe7pFhn4Nw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=qiBDxKm1ll4TFn1/msNe/345kEW8adB/0gxPEqZ3jezivzTGA8n4yPZuWhWb1v3KCW9Y15NdqhMIbpNTewrphpQxZex6rrjM8ze65Y0oX2p1AbBewPGX5zXZm2ImeW6SZh6pSMYY8J+S9ORbpggDJi91dlQMIhIskvglht/DB7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-87c0e531fc4so359773339f.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 18:07:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753405622; x=1754010422;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JzWn4aQP0Aq0bpr9BKpw+wIGQYqK80zwC80EWgOke74=;
        b=B076sN9pLWts27+GhbJBzTlca64oIjlr73Tp9u9WprlDYzlQcoxlbRIAQuNJmKfmwW
         P9LOIqnCaE+wp7Cr/am6hJiVXdwkUV/Jfi2BGxd3W0JGaTrBaifN6Iebx3YyEZLv9lh8
         WdC+9hlh01ycYtx+1VTEZlf6hPBQ0JRk0Im16RycfmHNIdsQzwdi/a+7ce6JuoNVCuz3
         5gX7F68JkwtB8VfLM6MtKvq6QbsJ8IM11HOA6CP4dVW4UOthudEv8T9eLqwQl0KClYsZ
         F9QixGmMaedLFw6m7DAa/p8zxl1aOruGpGnU3aZnYqLv8YZoUkwhk3QLp038WyrtMpnY
         CuUw==
X-Forwarded-Encrypted: i=1; AJvYcCWwJ3VES0yk4L/7fTq3nt1GX8aJdWctXcZxidOkeK8zTiKOAg+j5twFNFPbCi7fbP5drwf6de3G8LoZatc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOPMqd+o2I4BGSc1Sm0lgakaVNv1y6XWfkJBfOamzunv9lchp6
	vcQlfenvj1nSs7hrGbvt63XVL/BPFYzp7cQapYCb3hoRrJnW2smSFvHhtHMeI7qFXHDdN1CdAe0
	NCTwT8MZ8VUXjd03UpPSduxV+9CzAjxq587EfymDuJJfMxcreVdNaetX00Bk=
X-Google-Smtp-Source: AGHT+IFYs1deFG+i/7ICzDZksZbWitt0cMLyaTMvrJVzFF9vFzCQQXNeRkpG8DhghGXisyPgWENmMabrXPYWR7J2HvApTOp9Gco2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6b87:b0:87c:16e0:4aa2 with SMTP id
 ca18e2360f4ac-87c64fac4fcmr1727844239f.8.1753405622319; Thu, 24 Jul 2025
 18:07:02 -0700 (PDT)
Date: Thu, 24 Jul 2025 18:07:02 -0700
In-Reply-To: <20250725004220.3189-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6882d8b6.a00a0220.2f88df.0039.GAE@google.com>
Subject: Re: [syzbot] [hams?] KASAN: slab-use-after-free Read in rose_new_lci
From: syzbot <syzbot+0fc08dad8f34563208d5@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+0fc08dad8f34563208d5@syzkaller.appspotmail.com
Tested-by: syzbot+0fc08dad8f34563208d5@syzkaller.appspotmail.com

Tested on:

commit:         9ee814bd Add linux-next specific files for 20250724
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=126494f0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=83210eaba5794b83
dashboard link: https://syzkaller.appspot.com/bug?extid=0fc08dad8f34563208d5
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17e1bb82580000

Note: testing is done by a robot and is best-effort only.

