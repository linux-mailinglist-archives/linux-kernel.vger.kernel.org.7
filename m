Return-Path: <linux-kernel+bounces-874687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6954EC16DB2
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 22:04:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D74F64FB7E2
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 21:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D7592BE029;
	Tue, 28 Oct 2025 21:03:07 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4CB2045B7
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 21:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761685387; cv=none; b=Bns2fuUV+u4MxwQX+nWgnRExdqfODyStggbOKB8G0lUrjYS7vegk4rGjcn1kiN8mO5Gf/SRD74/1BX+zR8nK2GnrcINwDryYzzq/i+1T7JETUrpL7vRoJYqBJuyMG4xxXgRhFsenU/8rftCgLfq/mx4+rYBDv5EvexkAQn2s/Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761685387; c=relaxed/simple;
	bh=6gF04eDpE6l9eUdm+zMZJdeQvx0wV0d0xnPhHYeuAtI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=tjmbtCROTReylsh6M2JKyTAjBV5AGg97aUIBCNLBdqAuIZgDk2dkHjW0GreKXWRi8m381BJxQo8z29dEIPuYbEOhBpmtio/IgGMZLPe+hybgTaX+p3QdhMigOfROEAX0j9Yz3sDKqlONSgGEyw4B9bgDbjYdocRSXjNqToTbAzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-430c9176acaso5514665ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 14:03:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761685385; x=1762290185;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fh04tIkxxNjI62LGKXy5UvS+5SwkvjxFvz2gBwHqI0A=;
        b=jWynuLHBjnMLJ6VfAmji4fem1X4x8Lvqo3kkonRQJXpFQ4SHW9H0VDVzwkXTl1ljqk
         lZbOrdGzqXQ2L7wSif0h/h++hQrxa6ej5yCTgxmCF9wlkl1Cw5t6J5dHjrP3hr+vBmOY
         4OVTFd2blR3Ys1Q1+ABC++YUh0J2O02RATxm+U8JJVr9zMWKO6JKGqm6s+DENIGbCXXr
         qB0iFoGeKJradqXv7oQ8bIFy5ssCdCzx/aYQxJk5OU5hleyxL1oyuPg8RPA7xuzlUbkM
         otudFONRHx+fGOv0N+eyblTrNQn1KYhKpshGQY/aRCPmEd5VDjfWQsqm5HwinUX+roCu
         w6Zw==
X-Forwarded-Encrypted: i=1; AJvYcCVDLih2fms+PYTM5KOTdTpjyyoJX6dQB1wh8pJgmp9OD8CdrOkuCex+KuU3X/PNVX6XhOc2iEW8n4YnFLs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNMcqUt45gaFMEGRjopUJ8kCO9vtDdj+ord7QAChO5yi76WBa9
	0/4J5AwswRkrDbIUeRj337BOtpX5eRUL4kCujaHdKcdo09Jtroq6LQD/Qa9hLXGgmsBxHAwCOJN
	fI+ehUc4iKSAMhLbPL0G5sbJLSaBpvRvaaACaoW45bCct+swrx+RKMcyiJIE=
X-Google-Smtp-Source: AGHT+IHFtKe4LWz9vfLRYezy4QJy32wWxBY0L97eoE28LA6H5rhrMIZFcJM19LEMuqe8xtXAqtWwa+SexrUH9uFX+woVF7XTaOpl
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3e05:b0:430:c857:734e with SMTP id
 e9e14a558f8ab-432f8e2f263mr13275285ab.10.1761685384629; Tue, 28 Oct 2025
 14:03:04 -0700 (PDT)
Date: Tue, 28 Oct 2025 14:03:04 -0700
In-Reply-To: <20251028182114.wDf39%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69012f88.050a0220.3344a1.03ef.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] KASAN: slab-use-after-free Read in ocfs2_fault
From: syzbot <syzbot+a49010a0e8fcdeea075f@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

fs/ocfs2/ocfs2_fs.h:472:40: error: expected ';' at end of declaration list
fs/ocfs2/ocfs2_fs.h:487:40: error: expected ';' at end of declaration list
fs/ocfs2/ocfs2_fs.h:500:43: error: expected ';' at end of declaration list
fs/ocfs2/ocfs2_fs.h:644:26: error: expected ';' at end of declaration list
fs/ocfs2/ocfs2_fs.h:657:16: error: expected ';' at end of declaration list
fs/ocfs2/ocfs2_fs.h:805:37: error: expected ';' at end of declaration list
fs/ocfs2/ocfs2_fs.h:941:43: error: expected ';' at end of declaration list
fs/ocfs2/ocfs2_fs.h:1028:39: error: expected ';' at end of declaration list


Tested on:

commit:         8e6e2188 Linux 6.1.157
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git linux-6.1.y
kernel config:  https://syzkaller.appspot.com/x/.config?x=f5b21423ca3f0a96
dashboard link: https://syzkaller.appspot.com/bug?extid=a49010a0e8fcdeea075f
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=103377e2580000


