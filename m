Return-Path: <linux-kernel+bounces-874514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7627DC16798
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 19:28:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 36544504AFF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 18:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88E1134DB59;
	Tue, 28 Oct 2025 18:27:07 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9127534DB67
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 18:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761676027; cv=none; b=UjQhd6ts9Efhg+Nz/7EtiBKItINSUzjeGphCJX43mYCvIjG2qappznmeRHva3PRWm9ivBb0sLGbzdsGP38dnolOMpYhCTxVC6y/KEL69wdBFdV1GX2LSe3sLi6f9bSWxYHnDVwU2VF0X35LQYmq4Eakcfgs8gP6sJO1FSPUj4gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761676027; c=relaxed/simple;
	bh=zfH+8I36S0UqgEB3vCYK8k0nfg8C1JlVSl3/iDf4JMQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=O6ld6cDm1Py2HKfLIsfeML29ZScFPWk7TaOcy3UlsQilwG1Kk1aTWH4FTaNgxs+9aKechpiQP3SQoJeVVLYg2YkCfvI3xmtg/p6d/riwFP/mk1m3Z9iR6YvVFd/03+abSYML9BfbsW9zAuV0v4oMXviGkFoaZFqmhEtB+isMfVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-431d3a4db56so262351625ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 11:27:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761676023; x=1762280823;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WsDWZ13/AJyWtds6RiTV5HjteRCLNAX4pOyRqC3Rdhw=;
        b=BQt6oVFEhLYCQHeP303peQXOjn19x6gu71gY6xy29mCqdyrPGwjvPAavJLz61V8pcR
         +QYjpEKU6cx/CR0+EygN04QSUe5GHyGqIIIuQSKw8Z4wTifKGWV2CEBWvqeEjqP29sS4
         5WJ7co7OMcZWhb6ws0eJNkmB6vZxsNasjB0gZhLh0rR1ahPr3Tq9wd733HrWFNRzIFA/
         AKWcjgYeDWSFfLMbiPGY4Wc68ZQYPxgZQqBKUYDZ7RqBQORZ8/Fmtw7kxcRLc+D6RzCO
         t/OoVGLcNVfemN9FRC+kFEST0cOPD7BU7RE8AyTx1BnKklSxwVLrgkxub4fPru7tiUtm
         ZL4w==
X-Forwarded-Encrypted: i=1; AJvYcCUBlS7A02L9NWnfnOksPL0W1LwC6AfCSR3gfqdI2pA4OZQxf42NFXtV3OqzYBm9CKnJpZLZLX5Zv0/cQ88=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJNJ2Y8fRjST6bhbuTntg/u1Nxn7yFzpPiYJOGT+Cw/yr1Iz0r
	tHhYzys765cey3l08rqXQNXvxdRaiHQToxbsxrOe/vLuWsOHajfsEmh1hisc541bgowf3DaPUnr
	x+X74QP0+QvXqC6HKt5ACNMilU3m8LecgUpI6GGHggA+ziY1Y/ieWq2NyDVA=
X-Google-Smtp-Source: AGHT+IFFt9vV9fXP4b+OtlikkFNU8Z4t3MK3IVdBuZzTJEVzR28xjdc3wBa2OPsqYDA9P/ABAxBQCGOWPMOUsp9pObHujP53n/EJ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:220b:b0:430:a530:ede2 with SMTP id
 e9e14a558f8ab-432f904495dmr2205095ab.24.1761676022789; Tue, 28 Oct 2025
 11:27:02 -0700 (PDT)
Date: Tue, 28 Oct 2025 11:27:02 -0700
In-Reply-To: <20251028181926.Doh7s%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69010af6.050a0220.3344a1.03d6.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] KASAN: use-after-free Read in ocfs2_dx_dir_lookup_rec
From: syzbot <syzbot+30b53487d00b4f7f0922@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

fs/ocfs2/ocfs2_fs.h:474:40: error: expected ';' at end of declaration list
fs/ocfs2/ocfs2_fs.h:489:40: error: expected ';' at end of declaration list
fs/ocfs2/ocfs2_fs.h:502:43: error: expected ';' at end of declaration list
fs/ocfs2/ocfs2_fs.h:646:26: error: expected ';' at end of declaration list
fs/ocfs2/ocfs2_fs.h:659:16: error: expected ';' at end of declaration list
fs/ocfs2/ocfs2_fs.h:807:37: error: expected ';' at end of declaration list
fs/ocfs2/ocfs2_fs.h:943:43: error: expected ';' at end of declaration list
fs/ocfs2/ocfs2_fs.h:1030:39: error: expected ';' at end of declaration list


Tested on:

commit:         d3d0b4e2 Linux 5.10.245
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git linux-5.10.y
kernel config:  https://syzkaller.appspot.com/x/.config?x=bf99f2510ef92ba5
dashboard link: https://syzkaller.appspot.com/bug?extid=30b53487d00b4f7f0922
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1089dd42580000


