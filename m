Return-Path: <linux-kernel+bounces-749133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13DDEB14A87
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 10:56:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3644217AC0D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 08:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 458A3287270;
	Tue, 29 Jul 2025 08:56:05 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE3C286404
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 08:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753779364; cv=none; b=RZHGKsQj9kw/A7fiLCiDsMrNbYhWDG4qb4796Let43GoqW1awFqASN2DTl98YKnj0QBHfohiICMQFmtloRSKXTXtx6oJz72hpZWfftUDZbvg52CD1mlG45MMt+v8vWot22irQHWOztgprr7fUzACjG3HrYk0tvMQH3MaK3gn/sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753779364; c=relaxed/simple;
	bh=uBjlPTSujMJnq+adL8AQHG9GvvL9ojVDTJ8XvBEl+Ig=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=bXJeZ8ANTtK9CoTrY14ok/8/ZCL+FRTWDnkMoej8pLzAGrTK/rSWSG0j/rvbvUodfxNx/dn7yGMYDyyGulKY+jL8z598g+YTBNh/6TI6nAbUMFk3414pEY5eOs5wQ9SK7i7CipJ2UslnoAumtwIFe9vLQdpl/hbjZRyyNwJlY8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-87c0e531fc4so1282936239f.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 01:56:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753779362; x=1754384162;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jlHNxi6fbgmpncRlD4B+e2NWpW9TaER/WSxCeS0bgh0=;
        b=eRE/pMenqnKQSryKIbmZhM0Zc2tkLQtmFO/HA0wvv+IbnCFAngmo62/oFdv0qKz1Oo
         AuGwZ0PmKqgxaU99ph0EyK13xuENInBQiPNWnSBQQ7RYAEuVI8+PSRlIDjG0pcogm++1
         2OapbXqJCfVQJmajYLy+nY3s5jxqCVOTXEKRJnlWiPgq1j093sRJLGiniucdi8+b+jL+
         tC8LnI9zEGX1s/coQCN0J1Df1WkAo7/N7shhbDYgekWBSQHKVmGUT+xoYpfNjji0bucy
         +u26ugyKDKjOiLnG1Qx+/5XfYu9UsfVtVJ493ck3knyM7tjonWX5zUB3n5YrMc/gDkvD
         Jhmw==
X-Forwarded-Encrypted: i=1; AJvYcCW/t8RD1IllFMr0H/9i8DsjRk6YoHbpaeJmUA4e8l+zC8+bXobqlPRWoQK+oFmWrkWudB413378Mdk/wHk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkiP42AU4W0YRsTZ2QCvEFzPowqY5YWvciP06wSmWtmvFgcez5
	V0pmdHIB4tdrhN8ziv3S3WSCyNE+Fjt4efX9wIHACxm/n4q8MLoI7zcp7kw4nc4REvE0ikknOAG
	T6dYudPqcJn6iHWQlqOyduRihlnO25R5sEhsKAPTgIIQUn6mO4E9lInxK88s=
X-Google-Smtp-Source: AGHT+IEDK/1RkYgL4GVGXQltD8EKmq+l5LGMj/Z/HdZqdOw9HDMwzpgSQ4PEQ5MKZoIuzzePtUJqsR/qq6gvOPv5MKRU/3ZdTqq8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1408:b0:87c:49fe:cafe with SMTP id
 ca18e2360f4ac-8802298192emr2690950839f.11.1753779362649; Tue, 29 Jul 2025
 01:56:02 -0700 (PDT)
Date: Tue, 29 Jul 2025 01:56:02 -0700
In-Reply-To: <20250729072234.90576-1-contact@arnaud-lcm.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68888ca2.a70a0220.13df61.0000.GAE@google.com>
Subject: Re: [syzbot] [bpf?] KASAN: slab-out-of-bounds Write in __bpf_get_stackid
From: syzbot <syzbot+c9b724fbb41cf2538b7b@syzkaller.appspotmail.com>
To: bpf@vger.kernel.org, contact@arnaud-lcm.com, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+c9b724fbb41cf2538b7b@syzkaller.appspotmail.com
Tested-by: syzbot+c9b724fbb41cf2538b7b@syzkaller.appspotmail.com

Tested on:

commit:         cd7c97f4 Merge branch 'bpf-show-precise-rejected-funct..
git tree:       bpf-next
console output: https://syzkaller.appspot.com/x/log.txt?x=15fe44a2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=934611ae034ab218
dashboard link: https://syzkaller.appspot.com/bug?extid=c9b724fbb41cf2538b7b
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11bbb4a2580000

Note: testing is done by a robot and is best-effort only.

