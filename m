Return-Path: <linux-kernel+bounces-837424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50592BAC496
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 11:37:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 052E93B6CEA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 09:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 461C32F5A1F;
	Tue, 30 Sep 2025 09:37:08 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5E22F5479
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 09:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759225027; cv=none; b=WcyVRe4cTAQ+8/F9N4t/On5ktxvqgHrs0ysSrv9QIuAugGQVX4XFprU2iyl1oI+88PrdrQdW55xzC4+KIyh27pnl8pm4Dm1FP3uxWF1z1i5RtGDaPaHHjsj5YPtzM62iVVJofOzN8SVkx2XGn8PEQSxIcreIejzqb9e3Vo84PTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759225027; c=relaxed/simple;
	bh=JRQ3LTgbeDX7YHJmlNZZlgdp25/osCwRdOu29ygjOPw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Xzmz3ig09o2mZxUhmSbr8iJPtv6LWUoas+Ep+h0rSvXGzPkEm6GLN+CC03ahaCaqHycnhIbpUrpp+SBztUqdJE0lcDL8pd5xfniw2oCqLwwLdJxOX7Uz6RNEzR1bYw4JS55iwBbX01QT22jxxRt7Yx6lff0G1nWEDjzisKNUbag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-9228ed70eb7so535374239f.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 02:37:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759225025; x=1759829825;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YB79uH5/LfaWuCl3g3TQotEzhI0/ry9ZLrefnxTcfyc=;
        b=dTyj9PtQfKb/ErVnSKzG9q58qXqSJSbgwP+sAKtC2Dokd2NQKDOPHC8cCY3rm+Fr47
         0hkAk+YscGpJ37FMm13ZbpBVIZSyL8Y2F2Y+6t0/AlCWh6Bg1xrkKBHJbAyDINZdV7xE
         M4uTZ7+xZ5rbCgXgmucgRjj3zs9vmgBuJNrX9uhob+F6iETsUZxgsqG7KXk+5uJ8Fv7p
         eHyVta4PEN2GSN0+NYpo4n1390xS44PU+OBWkzm6HCTLzKnEYlLapOAoNamwtHhEC+FD
         V31rBQWQ1BhXU7ur624juSB/6QsunotUxZGf3iuFTp+8KZ7MO/JKLb9PLsIGlJ598Bx2
         kESg==
X-Forwarded-Encrypted: i=1; AJvYcCXhN2rrSbzVf96BQGQ2/wJR8waxbEpKgukFpoIuoUQ2MFKiVBQ+vMla+RBHoElmDUmI5PkCG5u1pPpjeCo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIYpWC6SUfmQtKs7ylfzV97rHyFwiuK4xFBHi3Jfp8H7j9kESI
	N+o4B6fr2mpbWxvkX6SMqk8mQIxvFQ5Sot2PAP5yIDfR1ysBZj8AQQFQiAvibEcs8J9n4L2u5Eb
	8bFMIDzxnZyzYf3yrE12nhZ3fMWYKuwJZnquei4s7lKpjO/LakhmlFM5ELXY=
X-Google-Smtp-Source: AGHT+IFufqM5vlHRno7RZLQWFXK5tfnPBdg6n+lRh359mp/KyB/MNGtQ66mMojuFnUsBs1gFwkJdCXk0OeYmXYcGFL6qJcQCDrd4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:340a:b0:887:633e:9a9b with SMTP id
 ca18e2360f4ac-929be8ab070mr818688339f.10.1759225025649; Tue, 30 Sep 2025
 02:37:05 -0700 (PDT)
Date: Tue, 30 Sep 2025 02:37:05 -0700
In-Reply-To: <20250930091631.310211-1-kartikey406@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68dba4c1.a70a0220.10c4b.0138.GAE@google.com>
Subject: Re: [syzbot] [ext4?] kernel BUG in ext4_es_cache_extent (3)
From: syzbot <syzbot+038b7bf43423e132b308@syzkaller.appspotmail.com>
To: kartikey406@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, yi.zhang@huawei.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+038b7bf43423e132b308@syzkaller.appspotmail.com
Tested-by: syzbot+038b7bf43423e132b308@syzkaller.appspotmail.com

Tested on:

commit:         30d4efb2 Merge tag 'for-linus-6.18-rc1-tag' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16b3f27c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=607d55e4510cba63
dashboard link: https://syzkaller.appspot.com/bug?extid=038b7bf43423e132b308
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13cb16e2580000

Note: testing is done by a robot and is best-effort only.

