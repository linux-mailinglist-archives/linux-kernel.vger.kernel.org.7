Return-Path: <linux-kernel+bounces-817576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36ACBB58401
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 19:52:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B142B3AB0AD
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 17:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 866282C2345;
	Mon, 15 Sep 2025 17:52:08 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD56329CB48
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 17:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757958728; cv=none; b=XyU4Vwj7Kcq/U0PvgxujBYKXhTj+JmbWNcjebQ1MRflVM/5R8NvQNmy3l5NotB1Rw1n73sgl6zv2fBWHbieyqNv1SRgKmg+E+RXg355Sn4Ks/XOYHgDxe/tTz2bzUcbau8BfH7X+NJtNoZtJ6AgfPjsnohBdvK4/a19R821Q7Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757958728; c=relaxed/simple;
	bh=L3iNPtLV29vihGHH9eO//rUY/3dTdqv29QrUth7+D/0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=PhnAmSjGK3N6NihQ5itkOAWkQrszgDwvndNubZ0obtMD86H5BBgk4rbYnaQ8NCfZWNT/GYc0Awa3Rnc+gA8UQ5qnoK4qV9TOEvR0oci8fJcFFErDe6xFFxSdjUSvACg8qXcRQKKPSyEOCTC4xiMXehpf1DpnA7BrlmPocJxuNv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-42409f4ca72so19833815ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 10:52:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757958726; x=1758563526;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=26ocySBz5Kz9X1yZLNutgxJyhoVyEgJmtFwenGcnTTg=;
        b=Iv87JAzuKOWclx1rlM/hfGijsMkzUdK1Swz406fmwFjIxvQ7NZZrvh87ZaYUBcPG02
         nN8QYn7K1me+kLLD04LGOJuX8s8OLgROTfgMqS10ct/laP9u2SG0C7lGDVsjYDMf979t
         nhQ58EfP6ICXt+/+mxAWHp4BtJbD00v/1mpti1513C2nop8tDnu4jRMOiDOHffN3Uh+6
         FrMWXH52S8NWy/NSAVylICINtQQJcO/x3cSntO5YZPmXN7UVSFHsSySF3TVHc4yn/fGi
         dpCTO8wlpkiNXsqaUKMqCOfZV/dBRasLVlfhV0loxtE3vSJzueGs5UM5j4Y07m35khbH
         /rNA==
X-Gm-Message-State: AOJu0YwuBAW8m6GvpMtHwksnIYvsnjARZWpXh1Sj+WYmjwiedp2qLZ8c
	yywi9P8FdcqSJCH4faF6fPV44SomC7gS4VMKcnxSpZmMrFyVYV60P7oqLaTU8r1SMl7lXDRfXxh
	n6EFauAErD2hBtinfHVddnVQq2eCjpXX9NhR0e9Wi+3EtG/bWspcFQfiH4eY=
X-Google-Smtp-Source: AGHT+IGfiBWf9L+HdO9uRTMEnFyXYiD50FwDtW/78CWQ9lkWmJ6f2km4YYQMVr2FkC9DGL9AOzo4kB4BSJYAAIV+OJQAQBv1PVCO
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1545:b0:423:fc5f:caea with SMTP id
 e9e14a558f8ab-423fc5fcdcamr71270605ab.14.1757958725768; Mon, 15 Sep 2025
 10:52:05 -0700 (PDT)
Date: Mon, 15 Sep 2025 10:52:05 -0700
In-Reply-To: <CAPrAcgP7f7rGNKKvHYe72jHMjo2D_8wRzoPt61stAiM0fccOhg@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68c85245.050a0220.2ff435.03a0.GAE@google.com>
Subject: Re: [syzbot] [net?] [usb?] WARNING in rtl8150_start_xmit/usb_submit_urb
From: syzbot <syzbot+78cae3f37c62ad092caa@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	viswanathiyyappan@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+78cae3f37c62ad092caa@syzkaller.appspotmail.com
Tested-by: syzbot+78cae3f37c62ad092caa@syzkaller.appspotmail.com

Tested on:

commit:         590b221e Add linux-next specific files for 20250912
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=17dd7b62580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9134e501f17b95a4
dashboard link: https://syzkaller.appspot.com/bug?extid=78cae3f37c62ad092caa
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1043f934580000

Note: testing is done by a robot and is best-effort only.

