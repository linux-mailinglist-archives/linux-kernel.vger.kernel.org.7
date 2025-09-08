Return-Path: <linux-kernel+bounces-806684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4827AB49A58
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 21:52:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 578F81B23F2F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 19:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 325BA2D3EC2;
	Mon,  8 Sep 2025 19:52:06 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602CF239E60
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 19:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757361125; cv=none; b=n8aey94fz7V2GPFrCESGRrsncnNRQp9RcU95yGS0GIOGbCruJrvcWzVb3wfdQIjuX0hJ8Th1bQlFhA8USu1M63aV0jRFn2aquHUr82icWT8iEe0j+K3pO0t65biNcEFCo+CP4WCfuSUvS3HPxx3cmbRJXYccPqRu4G3s5ltoIAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757361125; c=relaxed/simple;
	bh=Xw3fA3hYo91wcLGD0HNrTR+08mGg9P6FC4LeHeM9EQA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=YzDXmoI2bZg6PRD/A74QktaK2zeSm6lLwI/HJcJelZy1+ux+SQL/0fiIMPFqjYWiaatH0Qf6901JNN4fl1UeJ2YUCp6DhNBXDFbY/jm3gvDQQTz3b1+zx6zZvZyOHEvuNg6vxgnq4cvRxcxpg1cboY4jZYixM9ufbRZ0GPhkKNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-4020e59b735so67983745ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 12:52:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757361123; x=1757965923;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6E6CGk2tmAlq5+OVCzHjqNr7fmm4smeKYiarZdZ2kMw=;
        b=andpXvjxaEnoRMivfD2GpxrtWTi0f6fR6j6icBsCMP3a5S4xfsymG8Vybr43GIL8hr
         cu0X83avypQ0Jnd+qJN0w36R3nPHY9KeVPxzATcKDDTwutesmcihcHKjsnaSurc8EQ0B
         wqVhy3rjsSS7G9KUrtEOHB9deiPKv0KcaCb2NfKIItPabp8+rL5cG88fQ9+PZEixp7jJ
         n6A0UdW7Bwxsx68J+txxuq5Dn8g2SGyEbz7RJDvsxCWHyIzL4lywZ6twBVxy832YzhVd
         m7paZfj+5ThwRh6bg0fgd32A/txlbUe14Te0tfclVfnlOSzfCTE22z3FGLqCHtYLqFK3
         eCDg==
X-Forwarded-Encrypted: i=1; AJvYcCVfERaSmVlZKeahrQ0NmDtWm0ZA1sjRxncLsVNeFgzGRwSLmhrpGyf+TDnQkosvCxPZjxubSg1URQ8HnPY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxP5uwYvfe7MgV+Sb5/feKWMZ8OgN2OT0B+cijSE8HFmu6D4hv
	BJo9whKjRhS++esv77ZrIMfvPF4Jlcd9zgZL9MYeZ5hicgKHyTASdSftyt0Lx5nRSrqYQZWHfw2
	lRfixNU2HU6pdMYv2aYSoGu5rT0//4Cz5k8S6P9QzPncWr8rYqOngdB4vdh4=
X-Google-Smtp-Source: AGHT+IGXg7L5kD0uoY5KYmviwfxTBneLi5Cm1Bw2Zj7cRXNgGfxtx4v4PIo7McUtRBfK4wibi8nrfPuz44FeC2vNCprnp34kScX8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1985:b0:407:51a8:6b5c with SMTP id
 e9e14a558f8ab-40751a86cfemr66244445ab.32.1757361123448; Mon, 08 Sep 2025
 12:52:03 -0700 (PDT)
Date: Mon, 08 Sep 2025 12:52:03 -0700
In-Reply-To: <68bf244a.050a0220.192772.0883.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68bf33e3.a70a0220.7a912.02c3.GAE@google.com>
Subject: Re: [syzbot] [mm?] [ext4?] WARNING in ext4_init_orphan_info
From: syzbot <syzbot+0b92850d68d9b12934f5@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, akpm@linux-foundation.org, apopple@nvidia.com, 
	byungchul@sk.com, david@redhat.com, gourry@gourry.net, jack@suse.cz, 
	joshua.hahnjy@gmail.com, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, matthew.brost@intel.com, 
	rakie.kim@sk.com, syzkaller-bugs@googlegroups.com, tytso@mit.edu, 
	ying.huang@linux.alibaba.com, ziy@nvidia.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 02f310fcf47fa9311d6ba2946a8d19e7d7d11f37
Author: Jan Kara <jack@suse.cz>
Date:   Mon Aug 16 09:57:06 2021 +0000

    ext4: Speedup ext4 orphan inode handling

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16645562580000
start commit:   76eeb9b8de98 Linux 6.17-rc5
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=15645562580000
console output: https://syzkaller.appspot.com/x/log.txt?x=11645562580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=429771c55b615e85
dashboard link: https://syzkaller.appspot.com/bug?extid=0b92850d68d9b12934f5
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=168d2562580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15869562580000

Reported-by: syzbot+0b92850d68d9b12934f5@syzkaller.appspotmail.com
Fixes: 02f310fcf47f ("ext4: Speedup ext4 orphan inode handling")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

