Return-Path: <linux-kernel+bounces-832648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB14DBA0042
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 16:31:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E4C6168F17
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 14:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11BB0286422;
	Thu, 25 Sep 2025 14:29:06 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477A92BD5A8
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 14:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758810545; cv=none; b=oJfICnb6gQVV6rXSQYzFrXpJc8wtfSoLV8tNZOqOC8FG/XFuCFDojhtofiz2fBs0Z7OBDVF/RL9Cv+NQBRNbKn7SwRqQ5oKxLLOSZSMGGj2E5i+Ds7vk6+jIYWZTENo5LDSu9M3O46wZSi0o4hwZkzd5nVM7tyH0UpgmJNnNY1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758810545; c=relaxed/simple;
	bh=DwM7Lf47WrZ6LEtdg+twX2Wv6PTbM8b5DddCs3oniKQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=oOzx5f+7tNORAbTE2zLBLMWGCjUIDY4L98a549zPhrW2e/8TV7JPfyM99b0ivBua/JZZX34xxFfhilpEHGg46KTdQmogzVppdVEKPm8xaVFXKplStyzkCR0LpFQG0qZaUM8NjVCp92iH/dxQnXhYfHEaI5ieP+OlbjP9p8KU1IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-426188f9ebcso7568555ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 07:29:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758810542; x=1759415342;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gkq7z3fY2scFKJjKKusoHrmJZ0k27oiI0PXGAfaotvg=;
        b=wMpvgjbhfvKBUetppSoQzvSsEkYIWCSF1E9fc4SqdMJ6R8lIKouAA/jUW2WyT/cn4U
         67Biqeb3MXx7y7Z034ysfFeQQFfbXkfGff/f87we8M2ZIohU9MRmwkact9PEOf47VuxD
         ufrTPyeb6ipcr0dYfQdDql31XXxpytqvcrgkJqgrRwGHHL1Si6vZxvqlSSOOHpyH/vJs
         OPET2mtTO89yln4KfX26fIZoqhhaHsyYI7zqO00Fbn1SwPvcAttXiCgbyRgSag8I3GmM
         e6VYTVQqTgTmGgDyT8Fkukb4jvOJtYUf3sIQ5ul9bTbp+OXYS45snxLfEcK218ZrR7Dy
         C25A==
X-Forwarded-Encrypted: i=1; AJvYcCWc/xsSI9I/z/iLW7nYhqg2sTE6dHkbLowFV/fog0hKThbaULIVItnESH1bONxicHuWMUh4FOVfQ4qIOj8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzizhVkYbltQJ3sXJXsvQd4lR3bzHEhZqrPX3Xw1KdF3OeLIuwO
	Cb9EF6ZYJLENCt43p+203f2Js5GZvWm1OBfZelEfbKMVczDz0WFHc4p6PrPu4mbt8Idba6/g1A0
	igsAiuiXQvhbDXOM5FbzKd0P7i2sG6oRuCTqdzbrWVZ9pn27oQTJSA9SHCjg=
X-Google-Smtp-Source: AGHT+IEdyKkBJLZJdLXS+ioI3l0uV+ybZJv9ej0/Jv/Alz3S91nfm6vsT/oE0ktu70NrzHrCdUPIRDDovM2PQNbnK8EF0gpCRf9R
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:5:b0:425:7afc:b84d with SMTP id
 e9e14a558f8ab-42595660be3mr52604115ab.18.1758810542409; Thu, 25 Sep 2025
 07:29:02 -0700 (PDT)
Date: Thu, 25 Sep 2025 07:29:02 -0700
In-Reply-To: <CADfthj0xkbKwihXm-_gkCr0Arw3OU9fF=d1GdLNspniTDwLwTA@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d551ae.050a0220.25d7ab.002b.GAE@google.com>
Subject: Re: [syzbot] [fbdev?] KASAN: vmalloc-out-of-bounds Write in imageblit (5)
From: syzbot <syzbot+48b0652a95834717f190@syzkaller.appspotmail.com>
To: albinbabuvarghese20@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+48b0652a95834717f190@syzkaller.appspotmail.com
Tested-by: syzbot+48b0652a95834717f190@syzkaller.appspotmail.com

Tested on:

commit:         bf40f4b8 Merge tag 'probes-fixes-v6.17-rc7' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14e65ce2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8f01d8629880e620
dashboard link: https://syzkaller.appspot.com/bug?extid=48b0652a95834717f190
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17e0b4e2580000

Note: testing is done by a robot and is best-effort only.

