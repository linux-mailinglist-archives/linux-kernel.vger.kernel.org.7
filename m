Return-Path: <linux-kernel+bounces-826196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BAA59B8DCE9
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 16:45:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2502189AF2B
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 14:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B6BF1B4F0A;
	Sun, 21 Sep 2025 14:45:05 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1ED11BBBE5
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 14:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758465905; cv=none; b=lZYx5GZjy7LwhnbVqGv7HD8Pu5Ij6nlmzv7/wOIhfUBNUFhHZ91WutszvzxcuoYvwk3ZlfZRYgMJo+chDy0Z+OOZot1i0HNcALiI2khWnUkiswhrmVXK/ZjdbrCQLvahsdIceOi3/kMjA4Xomry5OmEtGCACDF2XqbJRR5vFbas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758465905; c=relaxed/simple;
	bh=aSmRQ8sPYYor6mzesV06teDlJXnzaKvTu5gwjXrmPgY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=f7cQae9ABuLUj87Ix7Y9Dtfb71FNxTlNRip11GW5f2NVOps67hS5rtg2xyCvShwphXUK1VWSeQlaKN4ZEvSCT/QXKnty9qJgT8aX//NsALvWhxyFiMOrJvzkAbeloZeUt2oJRp1z+LnGmTDeeEKHiLo7ILS/z/Md5HWfYBWzDp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-4247e23f070so29141605ab.1
        for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 07:45:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758465903; x=1759070703;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5i6VwjOh7K3UAEP8WBko4uaZQTphFDWWdkoNTJu2soA=;
        b=kDfr3+2MWG1twTmK0nRaqFPht/xZWo5hZZ5RNM9vn0DGnbyGhR9EsdcsJlbsrj+GKA
         AmhCe8+uHmIg4QaV0OIIH33dLicnFs6wcjwjauPr1tCMZqyhUQx+UAe3r/4dyoy456Wb
         JC9FB40qe/ubLZcjsoVwYCVunQHhk5SfGRpkbFxcv+dfA9Xgun2p4ARe/rvhqQA3fTDd
         2G7QVAHcVyi4LnVkwxX4W4RGHChy6SuNZBY0NJ6lHTQVFmXcQpeeTl0s+hHSf2Pf2p2L
         E9QTbTrvw1Ij6BbspxF/z5v4yGbANPFIm4BfgOB/CYMCWrFfKYha5JK5Fk/gVxGaEYGU
         qytg==
X-Forwarded-Encrypted: i=1; AJvYcCXTV3oP+x4EGyWqBFOf8gr4E8AIkpdUNB9jhHww49YAbYiTSjeP7Lz9vWetQOia6H63nBMQViymAt2rLZI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0ADaSRA2b2Y5DfJMaQ+a9DtjUes9UKVmNnRa0KuOyK00/xaHj
	+wONJivf0qMBAA/2XS+87RYfa2Ebd1gn7xQ82rBi1OoO0xvxqAbuWgLoIXgg4N6Jrv2P91Qt9li
	Gh7hOJwC1Hi5vjAYVRXQ1qZR5f6KuC80IixUe9jlXgIeXwMSsxd6nqbM7SUk=
X-Google-Smtp-Source: AGHT+IEZJfW5lcFPGj4sKR+Q2pwBBlGrNnL+WrPz1i839MUf8KDPLUIgHeiY9/V2GzqzJwO/5nvdnsDHkIrEMK4/FUXKxoXlX6Lx
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a8d:b0:3f2:a7ef:bd88 with SMTP id
 e9e14a558f8ab-42481911aadmr139022175ab.5.1758465902902; Sun, 21 Sep 2025
 07:45:02 -0700 (PDT)
Date: Sun, 21 Sep 2025 07:45:02 -0700
In-Reply-To: <aNAKh-iE17qLD5es@shredder>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d00f6e.a00a0220.37dadf.003e.GAE@google.com>
Subject: Re: [syzbot] [net?] general protection fault in find_match (6)
From: syzbot <syzbot+6596516dd2b635ba2350@syzkaller.appspotmail.com>
To: idosch@idosch.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+6596516dd2b635ba2350@syzkaller.appspotmail.com
Tested-by: syzbot+6596516dd2b635ba2350@syzkaller.appspotmail.com

Tested on:

commit:         f975f08c Merge tag 'for-6.17-rc6-tag' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=109648e2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bf99f2510ef92ba5
dashboard link: https://syzkaller.appspot.com/bug?extid=6596516dd2b635ba2350
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14a008e2580000

Note: testing is done by a robot and is best-effort only.

