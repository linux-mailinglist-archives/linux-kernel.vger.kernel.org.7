Return-Path: <linux-kernel+bounces-792687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1998BB3C79D
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 05:30:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73A201C81C5F
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 03:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3839925B695;
	Sat, 30 Aug 2025 03:30:07 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8BD273D9F
	for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 03:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756524606; cv=none; b=M8kCdKP6w5/VuNsH2hb1QOixm0mNha3bF8QG6EU/kiqslJu0R4PAkk+me5YgJDOFNzPiwSI9e8SQSHMxRtozVbTL7FbImZbIZyxt3S9rKhqa6Qvk8NIAnJ7jnYvtwC6FyFvX0cq55oEnT1M3vKIYlI/FISWwgv8ofxscBRUpj/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756524606; c=relaxed/simple;
	bh=Yir2kzmCQQoO8MMQx8m0Fstbb67N+W5wIGLWiwFaFWs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=VUtNJWcWttrNRRc6LBe1P1Wi5NUyXF+gNfN+u6BnEZNWofIkwAmp79+BdgVSkIoJSoYpNx5+8P7LrMQpSaqb8mUGhVK9eZ6Wll0jYbQPb3DV4ZBDJHvdPX0f+DLGOLgv+bCOqvPyY4BfXcnNT3bJZxc1dEsHdx0e3I9Bei5VDFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3f2cef166ebso28869615ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 20:30:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756524604; x=1757129404;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ggdcS0LlmnLIMZtC/UTrI1EAbYEnUJ4JfdXO7ximJGg=;
        b=UqJHY3FrEsjZE/S/4HPj1Vu3+vQPKaOsb66rEbpyh65L8iBPN5FUkwK91B6ach4L4u
         Gch13w6XNYsAW1oSGTX2Nfjo0LJky5ntW19S4GfSrCfwqyvllamVHH1Ly+kp7ubRbW+t
         CY/F/GhI0MXu3K91B5CoNtLYKxR218PCBYrEwfWUSdBheUk9yPfaDrZRIcvuvek0qGMd
         8V3mxgOUILrJG5oBbrUJSX8C0KNkBRG2jSvy+squGI0c2s4ArV//AYNbAgAYn3cz4378
         Y6YgbzVTgxgUBgsWrVsLa4ndAhvbMZKRodZN+3qYE4EMv8L7+HDQt66PHUdMlxwcuKmt
         Zh0Q==
X-Forwarded-Encrypted: i=1; AJvYcCWzeOB7qBIKRmDatdvOKDaXVqQLvjGSDsSeZ5pEHIFTKeu5F5M/JIANZInxWo2adqik2wWJw5aiw1ZRQ0I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+no/jxZVaI/F428acTdQRcNoK2VuOgoNcGjRjeJiH7XVKjUA/
	49TLlh3/6X1ar60xbQ//XjtVqtJT0bKa7jLDC69i61SYv4cIGYoMRtGIY/LQ/r59r9BI9QvYcpJ
	xZZLl8k2F5M4En7N96Rgb1ZeaOtmAR88N7k0wip3an8HzcwllQcVSKISZ00g=
X-Google-Smtp-Source: AGHT+IGs7ROfFulTgfy5I6T2RCK6Pvf+EacFTh6wTB9tieynHYFpAL300to6N6EfJQaebRQkAjknuQ6XIwdRMACxUFRyC9XmAqCa
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d8b:b0:3f0:f671:aca0 with SMTP id
 e9e14a558f8ab-3f3ffda2903mr16337785ab.1.1756524604448; Fri, 29 Aug 2025
 20:30:04 -0700 (PDT)
Date: Fri, 29 Aug 2025 20:30:04 -0700
In-Reply-To: <20250830005927.6096-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68b2703c.050a0220.3db4df.01a2.GAE@google.com>
Subject: Re: [syzbot] [net?] WARNING in est_timer
From: syzbot <syzbot+72db9ee39db57c3fecc5@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+72db9ee39db57c3fecc5@syzkaller.appspotmail.com
Tested-by: syzbot+72db9ee39db57c3fecc5@syzkaller.appspotmail.com

Tested on:

commit:         11e7861d Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1414d634580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bd9738e00c1bbfb4
dashboard link: https://syzkaller.appspot.com/bug?extid=72db9ee39db57c3fecc5
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1440ca62580000

Note: testing is done by a robot and is best-effort only.

