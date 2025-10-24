Return-Path: <linux-kernel+bounces-868879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD05CC06646
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 15:04:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7BAD1A61A07
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 13:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A99F931B805;
	Fri, 24 Oct 2025 13:03:07 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4DC131B803
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 13:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761310987; cv=none; b=hokjBNQgVRqEqvyK4ZHgqft19PFNvvZ3L6mz3+hk6jpHqrOxa+B31xxj/HIabEqqvsvzEpt6M3iMmoEm4qhFa3hW/qRZGWdnOpd4jpOjO6LH1ABbYxL5V+y4i2uC7rAjQdb1RCv71KW7eeTNRM2q9CsZ5ZadcpBi0cf5+SuiZ0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761310987; c=relaxed/simple;
	bh=aXXWuB1Zo6bXrrt9smUSGlXKihox3sLz6mfAGMt3jE0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=lI4KkqBrSIsADyS5nNKwK9B52Z/jmaC8cHJzaOaQrZ9HXVGXFHeHtqpDdtrfzlJ0atk/4LVtNpmy/twAj3WqU8PGADXcmiukUSw7ET2gV3CfsmBo72h4fkUaQTAmNUBRzQ+meF0EGiODc0MkaVX4DmsunkF8FblzAc3yXYIpcus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-430d4a4dec5so74176735ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 06:03:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761310984; x=1761915784;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b7ujiDTKomcZXN3r5iLHV0MeyM75t9DZVuydBESHG3Y=;
        b=KNv3fYgIFIVyz83J60Kp7XW1+mkg9xPurdqgJDcBtVSMy5+mmt50wOIWNSuTLspeen
         boL+DAw86T8otWCmWVOf2CMkzdVhRKAH/T7phIxdLeiUzoY9SPzPN0frYLw+Q3jVXDwo
         dt/iTfqzAjjTKD4Trc+OZrJiZAXG36Qfy+Mi6AoOoI/zB5TrwkPCsnw300bhg/0IT3lB
         wPW/+bQc357T0u449gTsePMQyP/gUfIQxVLUXf2TtAf1WuwfDy5xuv5qp5TIVRjEERc6
         FNrBlxjNKjGiy+XFBuEsGTv/UVeGUo/umJZQmYe5/VwZEfEzgwWP5iJt/eBHbc26fN3j
         MN4g==
X-Forwarded-Encrypted: i=1; AJvYcCUNIbo9JCxMaAijBxD32OWal5b6FIVHQzZCDRgzbuGejiSZYKcIGDdpFYXPWDCAErWQiQcEYBbAXjNv7cg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ107E3kxxjtOof3acCQi4EeRLgKNzf9C3LWF3KM8yNk76nU6x
	vst+SH2DZcGVhw6vdOxYTy+2zqSyUgTUBX207TA0Shf/o+5mmUm58cFw5q1N6E5HSLCDofDrluA
	E1FBHPH0EPT9Yo8RPmT8RmTTiLa288sBG8vS+ILe+tJU5i4MCNH0Op+RtsD4=
X-Google-Smtp-Source: AGHT+IFGNoqjoa/qNqkEm20I9H0G4dMLJLLQHDQWnnBI63fyiMPFvYmVkBWJI+fvRZWHNO9ACsf4X9lALfJVSP88Ajq9ZRYIUhIS
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:318e:b0:430:ab29:e75b with SMTP id
 e9e14a558f8ab-431dc1e275emr79227365ab.17.1761310983792; Fri, 24 Oct 2025
 06:03:03 -0700 (PDT)
Date: Fri, 24 Oct 2025 06:03:03 -0700
In-Reply-To: <20251024071523.DLZkR%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68fb7907.050a0220.346f24.00e3.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] kernel BUG in ocfs2_commit_truncate
From: syzbot <syzbot+c16daba279a1161acfb0@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+c16daba279a1161acfb0@syzkaller.appspotmail.com
Tested-by: syzbot+c16daba279a1161acfb0@syzkaller.appspotmail.com

Tested on:

commit:         8e6e2188 Linux 6.1.157
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git linux-6.1.y
console output: https://syzkaller.appspot.com/x/log.txt?x=16fdae7c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7417700edc6ec0a0
dashboard link: https://syzkaller.appspot.com/bug?extid=c16daba279a1161acfb0
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11b69be2580000

Note: testing is done by a robot and is best-effort only.

