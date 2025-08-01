Return-Path: <linux-kernel+bounces-753279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94464B180F4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 13:20:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBDBA5652AA
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 11:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F4552459D9;
	Fri,  1 Aug 2025 11:19:06 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F997139D
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 11:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754047145; cv=none; b=H2xzdawzfJDLPEyJxyPzgpXLXnlMG8ZVmTvGmXF8VbBF8nOwh8Jp2s3MofrripQCyUElgO17TLNaNpNGoMTBuGkBxin5wzyGlndPXp00dmBu+oNG/eFwnCDTyepIu+Kolz8lSsCGErCn2wD6+Syh1JIm7f9B/70jMmPDcK61eyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754047145; c=relaxed/simple;
	bh=q28JNh58dwBqtCM6swD3TmohMfXvSr3pGGkFR+t6hb4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Xz+yp9SIW5WR7q01FFGDcDO3El5fvjZAgz1c8qsieIHy1vm9rXFi3lJc8hOmc71L5CYm1b44nVjar7BU38NDouwgSsbvGpYOC/10Q3JSXvnSG0OaHf5yUzeI8DWSB5kZl7lpVlNMKlgUD46FU81gUSpEa97dChlYRI+RvZ2jqw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3e3e6bd9e7eso12618625ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 04:19:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754047143; x=1754651943;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9zQIgqfHRWskP84CROWGGd3zjZJ5REbJ6oo2IHFf5BU=;
        b=MG2zTW+HSFjGEMq2rizKBxEIFGDKNVUl9DQZOpgN3H3/1c4BcgfqE/Rwae21wAdgDg
         JOaMWQszqTU2fvHciBXgYUP0VmJ+22ZDHhgX5ElhBsv7lQzyOjtcblD7dCt0iJIRrm4m
         wGUvq8yQ3pGxbJCaDfKoEdYZPa7ZU5E/nFc6+sbn3bFuTanl3+ll77dt/0ttJnDFnvED
         L8uJPVnIttX6p/VM7uFHf8T3Lg3yB/EWaeNOk2QqjkZ7luqO3gltZTfvqaVtFNaOt46N
         lmEDsvoBgdwc2Ovv8plhU2Qr98W7wjHF+2RCnPT2v2D5rp2637JXVEv4kDklvxi9W2dP
         uiCA==
X-Forwarded-Encrypted: i=1; AJvYcCWLRa0Gu5fLPKtLpGQSHMToejf+Ds+jxQIFyuLcOLboaXSQ4cUUi+G5xh8S6NEVpe43+M1U9/H5fBXGvCE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxTh0Y/3OpNjIvgF/glImxvklDODkkP512JhKi480i9m7kl2Ky
	8mYN5dznioqlfTKbMMtNsAeACbrsWbV2d80+GKTm6VaBiOQO7xC/YXiirEi2WarWTeIV3AZsmUQ
	dWNbRgqrCgRgMPVF+ttUwo9wBF3v+TYSpk/219/X0NLeEknXn3Z7rrYcRFKk=
X-Google-Smtp-Source: AGHT+IFhhBqr8M8cc4DELb56FmCE9ort3fOeUhYgkgxclllTiA5Y40kRdwhPkZMhAC1T1qYw70mCHH22jwMHgGhy494ttoB9yXMb
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:ccc2:0:b0:3e3:d8af:3847 with SMTP id
 e9e14a558f8ab-3e3f6280e8amr145442905ab.16.1754047143387; Fri, 01 Aug 2025
 04:19:03 -0700 (PDT)
Date: Fri, 01 Aug 2025 04:19:03 -0700
In-Reply-To: <688b3341.a00a0220.26d0e1.003b.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <688ca2a7.a00a0220.26d0e1.006a.GAE@google.com>
Subject: Re: [syzbot] [bcachefs?] kernel BUG in bch2_btree_repair_topology_recurse
From: syzbot <syzbot+9eb4c69fd4d4a1934f3a@syzkaller.appspotmail.com>
To: kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit c366b1672d74cb008974f6e36e34dc191621f3bb
Author: Kent Overstreet <kent.overstreet@linux.dev>
Date:   Sat Apr 26 13:31:23 2025 +0000

    bcachefs: btree_node_data_missing is now autofix

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12b59834580000
start commit:   e8d780dcd957 Merge tag 'slab-for-6.17' of git://git.kernel..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=11b59834580000
console output: https://syzkaller.appspot.com/x/log.txt?x=16b59834580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b45b5c69b7ae37ec
dashboard link: https://syzkaller.appspot.com/bug?extid=9eb4c69fd4d4a1934f3a
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16d2c834580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11d32cf0580000

Reported-by: syzbot+9eb4c69fd4d4a1934f3a@syzkaller.appspotmail.com
Fixes: c366b1672d74 ("bcachefs: btree_node_data_missing is now autofix")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

