Return-Path: <linux-kernel+bounces-720494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85C8BAFBC85
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 22:29:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D12AF1886859
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 20:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96EA721CA0A;
	Mon,  7 Jul 2025 20:29:04 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F5621507F
	for <linux-kernel@vger.kernel.org>; Mon,  7 Jul 2025 20:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751920144; cv=none; b=nwNgnJWRGhzlEshAQI+DFg+UAl9Obqb6kQAcBHoT1DqCU0boX85xUN9wijzx+lscWFBQXF1RJoUK6OWfzFh4XnL/J+q8uj6Tnh5VwpgYJJ04hLVLmRYOlxynDmYZHqhqPEeZ83d07yZCcD7EiYT0kDvj9WEacfsx7iN3uJ62k+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751920144; c=relaxed/simple;
	bh=Ot02nqPa2ouHZW90wl6dQuaul5Pxf/vDsrQRSgDI/iw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=XXTc1SIHqRCgqk60tPoCsFyExvBNiuhMM+fHP8SwZyaVdbPnWfVgn0baTYBboxHjaaVNUJuCXOWbBfq3z8mk1qelryq/gsNu92aUydyyb/h1n7kdXrryBo0MDIJPCI9apo9CE9tY2789CtLqk7n7hDrK4fAW4Ie5+xJ/DFOfSIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-86463467dddso356979339f.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jul 2025 13:29:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751920142; x=1752524942;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=91bX3oUdnFkBh3AWeRAT8/+UY28YiWDPjER4C9ZXoqM=;
        b=RicJnNQewUeNkVvVhlS6k1gl+8+BIc6exwUVDoIytSdiRESgld0zgtHh2OSNHaaH0e
         NBlXu6P83eyRGLlRWyu7EfOlif2w5UQ97e3CCLkklZt5YhlwpDauVi6ckjjozQ53r66/
         zbuwtWZv4oMZ0N4Qqnxrp8pbx1SJ3lt3b5dYNWfqDQ50oxIqViFNEL6BHH2285wCAyBq
         FY08ONTPnsOCRD3sdaxcKXIApjT01bR9PZtI8KNuxt9uvs0D2VeDnr0pdt7OBSxfbyJR
         Vz2SP4yEsit/N9f0DAGkZeWMEQeXraZW48+Y41V44IAMN3aAu4EoP09CStiJbaKnLYcF
         WvvA==
X-Forwarded-Encrypted: i=1; AJvYcCW8MZkl+0j0cRqtVKaPEdNThz5nqYS45Lgf0ElmOLKF3TfSQ7lrTyykFRD4R23Re5Kg1PTrMBA2W/Lp6qo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8C6j8QIrZZQ2bp8C1pt/4GosiyelF8+wL33eIsmGpw/N8YXhz
	H5FFLrCKJgGzvpNPD3biLQAv/yu677QkfNLd0ukhsJLrNRjUw5tO9tdJwhOjbMBtg9yZ9JW4VcS
	ZkUtNzi15PNzPOjYooUmo0jkEEHTJI2TYO1w7aTDkFacCxDXV6vUDqotebjk=
X-Google-Smtp-Source: AGHT+IEbhTNVlC0ZTsaebcDui8mxJFU+YnwEblKdyep073zKGmZKVQEUYTykOVv7m/b7JvfHQgW6v9hQzDrk6VWeQSQWmGU6SRAE
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:360d:b0:86c:efdb:6eb9 with SMTP id
 ca18e2360f4ac-876e4904de5mr1025624039f.10.1751920141991; Mon, 07 Jul 2025
 13:29:01 -0700 (PDT)
Date: Mon, 07 Jul 2025 13:29:01 -0700
In-Reply-To: <67f76c11.050a0220.258fea.0029.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <686c2e0d.a00a0220.6237c.0004.GAE@google.com>
Subject: Re: [syzbot] [bcachefs?] kernel BUG in __bch2_str_hash_check_key
From: syzbot <syzbot+843981bb836d699c07d1@syzkaller.appspotmail.com>
To: contact@arnaud-lcm.com, joshua@froggi.es, kent.overstreet@linux.dev, 
	linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 757601ef853359fe2d57d75c00b5045f62efc608
Author: Kent Overstreet <kent.overstreet@linux.dev>
Date:   Sun Jun 8 15:40:00 2025 +0000

    bcachefs: Don't put rhashtable on stack

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15319582580000
start commit:   a79be02bba5c Fix mis-uses of 'cc-option' for warning disab..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=3bbffc3b5b4301e1
dashboard link: https://syzkaller.appspot.com/bug?extid=843981bb836d699c07d1
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11f8c1b3980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=177ce574580000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: bcachefs: Don't put rhashtable on stack

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

