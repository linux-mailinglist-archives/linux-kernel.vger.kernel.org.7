Return-Path: <linux-kernel+bounces-877137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D403C1D498
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 21:50:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31308189A671
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 20:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A20C2FABE0;
	Wed, 29 Oct 2025 20:50:06 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6213E8635D
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 20:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761771005; cv=none; b=HIZyCdY0Jq1u+5xWHT0GKfm+j3XQW64Di8vm/YlGRCxrb8YhmcQggCpP9lvc9a099O3GreZr5nnWgTt9yt0jOgl5hMqESlZmDY8vcq/VM/xAjlxk8JaeozBi5JSWYx8D8MTp0F3I8td8UZo4kSYtuCnhX3LkdN1WY12anuToyZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761771005; c=relaxed/simple;
	bh=Co1+/jXsNeqJL7OYzC0jq7WXkJfMSXWBnc7qAws9XDs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=jDjlAW5QVX3mFc9VMwNT5BfEzmiin5ljoZ/gDb/m8D8SZPqUkQZHIii00saONmMmfwsqzNBJBPIHEL6jQ8gW0zlO3/OQD1vKvDvQcdy3CpQICldsrBDKt0PcZ/L9QlT9isi8fBlBfhiZkvuUwANqW1TxiJmWFmgox+o1KkdqQWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-431f20be851so3424235ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 13:50:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761771003; x=1762375803;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eVLnqVOWxI11j0W2YHTss0brXYq/Lrgnl/YMIU59soM=;
        b=Ty/sPAF/T6caNN9QkIzJQA266g/h0HF18nNtOCL7EghkuClXXt+BAvXe/GCpaeXjTi
         gf9ijp942I8mNO5dvJVkFqirokVECtKnQlZd6nG288nU43z4tJvtcOVFZW5rJyFkUsxf
         KG4k2S/PL2lwABecJ8ZiDDAOFtstsgPH0t4isDzInQEJNevfa30FM1UcaRiz1zlB1uYn
         Nt4RgPKyWDfeInBlsAg+2boVQ5eIRlBZQyNOrvFwKyRUZfafAVyLhLl6uYliTL8Pc1k3
         cCxYXueds1wunZBQS2pzdBiNZ0QRr978vJAFKAceHvRc+RyEQycTa9+oCyABehOZWpvf
         ji2w==
X-Forwarded-Encrypted: i=1; AJvYcCW1MrHDRTJJM7Ss+9Zf8KfyTPmLw6Y2DZuBH4mvcogUg953eQ0EgI6mhMqjVQIp3U72zJRyakHdV3I8UyE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJl//sY6CfWCnVl5tSb0a7uXjMSsFYSb79x2HUHW7aEcMIPAI0
	sUIq9lAr8MLoNqRw2smKaJBdsKsa3M90GvQEIGQvj5PBTK3emqGFvWO1fwqXb3G3I5BBWa8ISQI
	8M9Bsaz5ySBytXHSjtUYdavP8W7BlmZh4JeV/JYIdEETLFVpDDmqrvCuzFrQ=
X-Google-Smtp-Source: AGHT+IFB6pVJwjK6dCCatRsWVuduqcuW827bDEqq1xe2BbXW1s2PxbcMZaS7k1hNiSOuarcqtS4SHnpUT2tdgWCUQk7RPro/P1Ip
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2585:b0:431:d726:9efd with SMTP id
 e9e14a558f8ab-433014f2bfdmr12597125ab.12.1761771003618; Wed, 29 Oct 2025
 13:50:03 -0700 (PDT)
Date: Wed, 29 Oct 2025 13:50:03 -0700
In-Reply-To: <CAPqLRf1_Y=mCBQKKHoSZJ3BxxsfMWYd+asreyGLofV+ge2UySg@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69027dfb.050a0220.3344a1.0432.GAE@google.com>
Subject: Re: [syzbot] [ntfs3?] KMSAN: uninit-value in ntfs_read_hdr (3)
From: syzbot <syzbot+332bd4e9d148f11a87dc@syzkaller.appspotmail.com>
To: kubik.bartlomiej@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+332bd4e9d148f11a87dc@syzkaller.appspotmail.com
Tested-by: syzbot+332bd4e9d148f11a87dc@syzkaller.appspotmail.com

Tested on:

commit:         e53642b8 Merge tag 'v6.18-rc3-smb-server-fixes' of git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1661efe2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2901a6a99b67fbcc
dashboard link: https://syzkaller.appspot.com/bug?extid=332bd4e9d148f11a87dc
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10be4fe2580000

Note: testing is done by a robot and is best-effort only.

