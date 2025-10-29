Return-Path: <linux-kernel+bounces-875053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7CC1C1816D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 03:49:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98D0F1C25B2E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 02:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC7BF2DC321;
	Wed, 29 Oct 2025 02:47:07 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A3E4204E
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 02:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761706027; cv=none; b=krfUi9wthvnQ1RgGr/XsJ48ozCKayWBQadaAsMrdJOdfP6lecbxlo+huckfBBi/vghygikhFl1NHblm1y880vmJPfk8hfeHAdhZXdk9pABi7YUvOzrwDxjn04pmtixgiU6zQOd1l1shnX87gaQ8YqNkuCyhYvjO5wz5BtzrgRf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761706027; c=relaxed/simple;
	bh=G95Xq83QHSwQQDXVAGny+D1ppXC3agSP2Fihv6x/wkA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=Kh1uyAe/n8rZ4RApcD6L5ASvDNBYRyz4Dfl3YRUsCbjMhA+jkGfgqHWGE2+BmPfRL8H/vi6JnX2sOzjiBy5WHmox4l0QO5ivvnNprKdTbaEXi+MIEgQe8Pttl9RW6oWYbcCQTf6zYYY9s5Li5QWSP2e42Siv72IDrRWzb7YrZJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-430d4a4dea3so7746795ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 19:47:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761706025; x=1762310825;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OIxrBcjqxi6MdB501DIWAjC5TKz9NI2Cr73fXTAjGMg=;
        b=AedJdNRSmDw6omNoPaNFiT0nWl0bsC8WRRL1BOz8eRxAjQxuEm9rtjKCNq7e4m4zVh
         ya/KVeOKTuvjQVzavPLW/ofSg689Y6oiUNyUidOoY//FzcE4u0udlnXKMG08RcTg5A1g
         X+m+IiWEW7kxPF34N2yhe9KDInIxi5fgnQAWZxSJt6EI/Ar64BJ0251G0235Chp2W0tE
         86sFXj2JRb0jr/xKtqjg5pUNV+gNaZr1XNO0c6Dgsd8+RT0ViO5lI/eDuTVANkIOS35d
         MifZ+7MmCC8iGozDROkVmIRh/Pw0cOl8K4CJmsQxGzFcuZaVoF4yIII7CKFl6sOMdLQb
         exDw==
X-Forwarded-Encrypted: i=1; AJvYcCU5z9E9xumj9WkZ0tvrDFIq93Z1HgjcEGLJ+4tw6/isHQHaYYwAUA+qQYT/IRVWV2vKd0XQE37XydMjl7c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yygx7hkRuBePok5IsrwJ2ZqY0JGILSHzMSm3ve1SsiHi7W+vdXn
	u5BTKmLwfojRukchpVNJqW/RjPX2B9D+lqPkjLJdf6n0c7kXi+UhTs3maoTwbcFIRoZhB+FsGGB
	tY3+RRG+yWeOFQ6AO3DtydZ2MhRRzxyiNaVNDbp4l9p9Lu+6X9XJz8BCqGkk=
X-Google-Smtp-Source: AGHT+IGDQRZz2qxj+aO0kUdKaAerSQbExjzzpe4285SCkJSdsbihZvePmOJdVcTtRMyYClYgCQlGFMB/9ytDuOmcQRI8mrbw2t4q
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:34a1:b0:430:db6d:30f8 with SMTP id
 e9e14a558f8ab-432103bc8e1mr90567015ab.4.1761706025015; Tue, 28 Oct 2025
 19:47:05 -0700 (PDT)
Date: Tue, 28 Oct 2025 19:47:05 -0700
In-Reply-To: <aQGALTpEwjtSrAJD@Bertha>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69018029.050a0220.3344a1.03fe.GAE@google.com>
Subject: Re: [syzbot] [hfs?] kernel BUG in hfs_write_inode
From: syzbot <syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com>
To: contact@gvernon.com
Cc: contact@gvernon.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

> On Thu, Oct 02, 2025 at 06:27:02PM -0700, syzbot wrote:
>> Hello,
>> 
>> syzbot has tested the proposed patch and the reproducer did not trigger any issue:
>> 
>> Reported-by: syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com
>> Tested-by: syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com
>> 
>> Tested on:
>> 
>> commit:         24d9e8b3 Merge tag 'slab-for-6.18' of git://git.kernel..
>> git tree:       upstream
>> console output: https://syzkaller.appspot.com/x/log.txt?x=1472aa7c580000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=e9442f6915cec8b7
>> dashboard link: https://syzkaller.appspot.com/bug?extid=97e301b4b82ae803d21b
>> compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
>> patch:          https://syzkaller.appspot.com/x/patch.diff?x=13c8d942580000
>> 
>> Note: testing is done by a robot and is best-effort only.
>
> #syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git

want either no args or 2 args (repo, branch), got 1


