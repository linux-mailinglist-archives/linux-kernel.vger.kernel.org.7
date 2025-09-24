Return-Path: <linux-kernel+bounces-830510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D3308B99DF3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 14:39:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64A467ABC0C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 12:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC12B2FC874;
	Wed, 24 Sep 2025 12:39:37 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5E12DECD3
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 12:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758717577; cv=none; b=IrgSzn7hmykj/e8A7fpzGl6DrkjnZ/dpEu8NmbyI+m6q8svUbyoB+y9uI1eH439oeP7ueivM5WvAGKwNhJBFHrD35FlWuzrPgPs4yuBATsY0/MeaGmJbsICrQV+6x7aYnOK5EbB8Q8K6xybMDQEFQBlNDCXG/Dq70SY9N8QvnvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758717577; c=relaxed/simple;
	bh=CrgsaLAKkUPq/Xn/YhT+WQ7Nq5/iVqqODOViwp1jc3k=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=n+/oZjcqFoknU2b8eylLdnknCCBqjy0tPnr6/cg4izorEuBeI3DVcqZFztbC2pn1OeKvVft5amyw0xRBkWMHgIguEI796PyiYET0Ih/zt6k9iVlaT4zLHJ6qXUVnQegho8sOtAc6m+m84WAIFr0XoLJQIsFlCkvj2/PsPo77RwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-4247f4fda63so81871935ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 05:39:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758717575; x=1759322375;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tqiLggZgu14N6upcI6vr6abaJeYFuz0NRIQm4lctDM0=;
        b=HLdgxf0kcczK8m9mApZavjp0MNDwdL2GzEuqPilR4FdrRAbgNUARcWGArqL/YzQe0G
         +4pbznu815X7ZgAE8O2nDjkVOv0nU9tlo1UBopbovVOYzJlKSvm/6pHN+mdInkjz09rG
         Z6s5gMbSmij46JzE5cVAd+BVvuseQGwY8nFKNBDXZPZy8Yiiy3LGZgw65Cq4x/7Bt5j2
         nuxeFUJEpRPDfi1i153wNRI/1Yqb1HnuG9l0zaUgOLw7KT7BZx9YAjH7DIckOsplWXr3
         UqvmlpZHJ6JLyjMjduBQHTzrHAflA7KfHG0+s8q/UXWBjrd6lV3V1H9I/iXkDopCJocl
         rdXw==
X-Forwarded-Encrypted: i=1; AJvYcCUakRvc5SSvDm5BZv9n6+UB/N/oDuulM5D2bvUUNMglM3qEQw4GAfvrq8Ulu4JBnDaxD+wSNvi+WFBVDtM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVYhj57uaDK4Q9ol6XeIiDuBfPCxoAHOtEj+qj8gyN9trCtTdA
	szuu8qdXo+5/CAVQioatFgoQQDHStTcfjtNt8jnBokxlV1nY3sOEBtHATtDKBBP2Swm5ucsIYe9
	CCxAarAgS9MMdhLQ0ebduXeDanyCg0BwQBikY+5tjb81/L7P46EdXEV1Szpo=
X-Google-Smtp-Source: AGHT+IGzF9EJRPq5UUICfE6bTYc2f5rGwxLTDig9z1B18QbOvSHlD46gZRc3R3RbIv3AWKEKoKwT51lpzvpnjZGCL4B+bKvdBZux
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c26b:0:b0:424:64d8:73e4 with SMTP id
 e9e14a558f8ab-42581eac74dmr91442785ab.28.1758717574907; Wed, 24 Sep 2025
 05:39:34 -0700 (PDT)
Date: Wed, 24 Sep 2025 05:39:34 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d3e686.a70a0220.4f78.0024.GAE@google.com>
Subject: [syzbot] Monthly comedi report (Sep 2025)
From: syzbot <syzbot+list0119abf18c5d23a8a062@syzkaller.appspotmail.com>
To: abbotti@mev.co.uk, hsweeten@visionengravers.com, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello comedi maintainers/developers,

This is a 31-day syzbot report for the comedi subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/comedi

During the period, 0 new issues were detected and 0 were fixed.
In total, 11 issues are still open and 8 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 7563    Yes   general protection fault in pcl818_ai_cancel
                  https://syzkaller.appspot.com/bug?extid=fce5d9d5bd067d6fbe9b
<2> 772     Yes   BUG: unable to handle kernel paging request in subdev_8255_io
                  https://syzkaller.appspot.com/bug?extid=f7ad508e3c76c097483f
<3> 349     Yes   BUG: unable to handle kernel paging request in parport_attach
                  https://syzkaller.appspot.com/bug?extid=c47f45cfb7fc1640ced7
<4> 28      No    divide error in comedi_inc_scan_progress
                  https://syzkaller.appspot.com/bug?extid=af53dea94b16396bc646
<5> 13      Yes   INFO: task hung in comedi_open
                  https://syzkaller.appspot.com/bug?extid=7811bb68a317954a0347

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

