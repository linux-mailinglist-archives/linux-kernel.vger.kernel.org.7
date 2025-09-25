Return-Path: <linux-kernel+bounces-832620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 197B1B9FF06
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 16:20:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04ECE2A5512
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 14:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5F2E28CF4A;
	Thu, 25 Sep 2025 14:11:06 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6BD287271
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 14:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758809466; cv=none; b=Vhwglpi4TubPGcQzkHxf/yOoHD6NxmKNQSx+scl5wXq7thNS73dVdWU+gGFoz+VPMK2CNjczVUFE9YlxCOCVj2Ocgo/K3qpJhxa2iGoNHKCSxS1nlXbFopUB8G/EBy2NQJ3UFVjulhoARRKbFeRZgrnPIz8SEvrYX6wom6BPlkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758809466; c=relaxed/simple;
	bh=717eIeAaFs6sBxGF8GbD/tdG9Q7KBH8hZ+cjvtAjVLk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=H5sXakXYEEgnnVEiIujnTprDLjnJ243WDsY3V1QfNKKvA45Uz190hy/c2QtjG6+70pJ3j5qQTBQvFHMIW8wZYIARSGGJUGewldAQke8RDVfWCdnVfdqAS/q1qFGvLcdFo4TNVt0zSk15S8QHkIWmgQhIpZ5o+H5wM2d0jEP4j0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-42591c9fca7so12531115ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 07:11:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758809464; x=1759414264;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7ib+VA6ZtCmQkUmEd7hwtx9ACaX9kJgPRS35PlgvoHs=;
        b=sgdzR0gcqui77JKBc7oxTktzfh9nsOvq/kTJdCSBGEDsOlGQgFanlmz2ygHSn0HZLl
         L94dtZyOy1CrnJPAa/QyX0Ny6WzvFU565pzVFYxPeSlbD5nbsU7yHL2JHIJjAx1ypvqi
         Thmd+cB4rXx74EnZaZ2jn3cdynLSInO0xWQRMU9n22t9e368tlYGY8miILzDTC5YSsuW
         mDLEUDT0yzDw4VZszAJKpwl5oT9TbWkc+ms3CDZBWGLCbGKwqsyJMPx2TUINpUMixE0D
         Qb5Sy6fiyvdoqWGgWSnzdTMNPZ+TtwOAHd9HYxQkleLBxpV8g+ZLKiDsSZ2BiGltKpYc
         Qllg==
X-Forwarded-Encrypted: i=1; AJvYcCVfBnr7pts7hnMeDuP2xA//wwTLsclT2J1HTszoUz3uaQzxTO0m/LpNUhiPn/RM9UsmdP0kOS1hy349Aqc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxirO6f7C2Z7Z0ACxRnpjuuYiLk+NRCRRGelmMc56yPLEwl/I5G
	tsRrwNiPZ2jbY+XZsCx3HE6pjzHc1p7IhvimYUJrCXbX2AT91YXMahRN4Chf0kcMHyUl6J37f+8
	VKYyJifqTj1QfQVOBcUIINv/WE1JNkjM3iBlaLp2VvIM/ZfoOp1yyDO3tBIU=
X-Google-Smtp-Source: AGHT+IE6OPIdVxj/qXK58vt9AtnPRMQw+W+1kK0Hv/Nxnd9juNzoZG4k7juTMPiCfAFb3JdvEn/Q/R3xgEJxwLzIWdtU1UHU7Xuc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12cf:b0:424:9926:a97b with SMTP id
 e9e14a558f8ab-42595654326mr53032315ab.25.1758809464045; Thu, 25 Sep 2025
 07:11:04 -0700 (PDT)
Date: Thu, 25 Sep 2025 07:11:04 -0700
In-Reply-To: <CABFDxMFiDMVJLdXsYb90czLsvBJJebJoK1OcZVHUHW_X9naZaQ@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d54d78.a00a0220.303701.0013.GAE@google.com>
Subject: Re: [syzbot] [exfat?] general protection fault in exfat_utf16_to_nls
From: syzbot <syzbot+3e9cb93e3c5f90d28e19@syzkaller.appspotmail.com>
To: ekffu200098@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file fs/exfat/super.c
patch: **** unexpected end of file in patch



Tested on:

commit:         b5a4da2c Add linux-next specific files for 20250924
git tree:       linux-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=fc64d939cce41d2
dashboard link: https://syzkaller.appspot.com/bug?extid=3e9cb93e3c5f90d28e19
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13d1e142580000


