Return-Path: <linux-kernel+bounces-824887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B71B8A5F9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 17:45:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 436EE3A37E5
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 15:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6730831D38B;
	Fri, 19 Sep 2025 15:45:07 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8387C31D39F
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 15:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758296707; cv=none; b=aUBtTnwbwKsN/eJ+LW3ySjIcHgR/0CLXp6Y6ExtiDs4x4UCUfMxA+aY9APkXkHqXPJ3TAMzd+WODOXIOVhULSysLe7i5VCuVBnFsCI7meWdmzAIp6QReLZMaiTQ7+9IKOsRsPjScfm5OBO131i5OywNnBF/yt5Gtb8YIYd1VXXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758296707; c=relaxed/simple;
	bh=NfNUB5wiwzo7TttIpxrFuu9jOmm5eTWgAUDagcdi0yk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=hBcOQ1RCNf5mJVBA+NCGpUwlL3UnfuYG6pueC0u3b2MFUnCxQfR26I4xvyBIsxm9U2jm+cy+fXiFAF5BuineH7IUlIKjRzNwMn6psWUlnJJs/qFieP0IYASpp+KwhRmHXrp3UAcAD3QuQ1jpbQW0G3rb1E/6F4ufETdbMzpf6Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-423feb240a7so41428085ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 08:45:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758296703; x=1758901503;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=awTc0bWJf4ZbKE4Iy/o8spupJhRX8radgXRDzlpOacY=;
        b=kupHxDwr3lu0ZrDjplmULbagEKjuk7Vfu06Tr31/hiqCn5KA9a0sLZN+spuxatC7rC
         yqOMSVia6pEpGblqvvBJ9BmXOpDPPjYIRdlbhzl04s07qRILynBAv79AyI0tTMZP10bt
         /MPK0/KYVYJlxac4h3IF4fYdoQYP1X0iqpL9ZEgI8FmcyL7NhYuOqrefKyi2CoAXj5Ky
         zqocuswYHQqzKUsFsDm8kb1D079pGfE/jWEDnpoNH5ji4ibC/lZlUwErpKm6oJJqKdwF
         PQaJ5QbSpTX174e6nkAr6xcgdChgdzsbCARvnrnFmhwbYXn2BkM9HFDlupgnk4o52Q0+
         d4wA==
X-Gm-Message-State: AOJu0YzzN+0BcT5/LDRLvAgajrtTRkJGdRoHcMWk6+0IGdIi0ehnsxZF
	GAR7blBe88nuZodrXAfJ+wX3T6BZnWqyzYzi3LPao/lf0cRsHd0av4fw1T6vXG8H3EpUMjMqK30
	ep66iHuwgidATboBWx5mbAuVX/0iOLfxYPkcXJEPK7lJaP1QoBwJYCOp2CtA=
X-Google-Smtp-Source: AGHT+IHGLmquzN1Chb6PjjpaG+SCI0jdPaZ4x70O4KMFXv+9klQXCRomDItYcXOZ+zHfhkV4HroHZ7gMALFJf/kMVJFUwHebLpT9
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12e7:b0:411:7b83:c9f2 with SMTP id
 e9e14a558f8ab-4248196892dmr56234395ab.17.1758296703606; Fri, 19 Sep 2025
 08:45:03 -0700 (PDT)
Date: Fri, 19 Sep 2025 08:45:03 -0700
In-Reply-To: <825ad453-7347-4af7-8a14-3aaf678c83a6n@googlegroups.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68cd7a7f.050a0220.13cd81.0003.GAE@google.com>
Subject: Re: [syzbot] [jfs?] UBSAN: array-index-out-of-bounds in dtDelete
From: syzbot <syzbot+4f9c823a6f63d87491ba@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, pedrodemargomes@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+4f9c823a6f63d87491ba@syzkaller.appspotmail.com
Tested-by: syzbot+4f9c823a6f63d87491ba@syzkaller.appspotmail.com

Tested on:

commit:         097a6c33 Merge tag 'trace-rv-v6.17-rc5' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=157a39cd980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=839dff357af8f40d
dashboard link: https://syzkaller.appspot.com/bug?extid=4f9c823a6f63d87491ba
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=103410e2580000

Note: testing is done by a robot and is best-effort only.

