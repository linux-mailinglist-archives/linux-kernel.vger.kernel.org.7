Return-Path: <linux-kernel+bounces-896428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F5BCC50585
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 03:28:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5E9C1896961
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 02:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C120229B36;
	Wed, 12 Nov 2025 02:28:05 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388F8197A7D
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 02:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762914484; cv=none; b=UAA9IXAndV2hU4IEDCCfmj4Lrjq+XN40KUSOKk44NCYQCULRpcJXoTZ8Ylw5uUPPdf6ryy/FIhHkIDwFPrHjpLcfGlcPoUwJuUA87pTjEvzvXkdj7vMpunOZdOQvsz185nPPhzoGYTkGpJr6GBFA1GgG3vRaf90adWrSOBfzszQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762914484; c=relaxed/simple;
	bh=OlWrmAa34Y5dTsLzi14yxKUNl20ENJtC3lV9n0ahGvI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=VlxOhHRk3cZsLziG+t1AtG9YVvagHOwl1PL30pt3fiN7nKsQ8uWInfsuHV0Xbr8kWoaVUuqnUbI5CSTQ8XhD7ElLtyUIByaaISH9ivrVQpHRVolnqNN6xkqT3S74sksgy+1188gO7Q/Zy4kt/lJ6iO3k5uCrDutJnMYYe8Fvi3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-9489c73d908so34762139f.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 18:28:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762914482; x=1763519282;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l9My/5h7OnR1VgrDNjSbwjVGwBIdlkhRi9Bh9Fnq3f8=;
        b=U59FdrJHkwPHGOHeta/n3KdlDI99s98ThrFOlWtIG9mjFU/UHg7fZSzCdBgrS3Ww6z
         G8ysmWJGs6j+jWSDI/jloyFok5bUxdPH+ZakY5KOexWFB5EH0wo5NTj/wA1ZRuBQS6nj
         l0BOg3BCRGXNcIIuzZes6mArT2f2Ph+cGWPFc9LNpJgY8d6+XtzOxfb/oO36c4mWC9cO
         y4HVMcLz2QEvj1zLuqygt0dtoQtO5wrvMJq4mZFn9/UZ4JsrxoM87yJ1BXYu0fDAt2/u
         fYQcIcIviuhZBWRdu8mpd66GYgiHSv9BIkEqS0d60ibFSNIekBD8FnXVP+9/bjoLX5XG
         QeQg==
X-Forwarded-Encrypted: i=1; AJvYcCUwiKDXCdZqc0RO41PoLXYK9DvUAoUL+U+fq0QSYeivphAgXh8BL3wfTNsJ06wfd9dHpqx1yXUm7KjGwCc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWsQRRIwh/FDZe3G/N99PBvzjYc8PVrEKlxhtvWxUsWJfiPjf0
	lzjmFBLuH8D/P28NBzICHqzlzSl1wWsK/9IA+f9/Qcyuz8/WViu7wwOEe744TTqhzzH0ZliFnnV
	QPPvndaDAW7BkEW4ZZSPXOkWjQGME/rVRa2ozicgvhHuORm9PFnIHGyRNB9A=
X-Google-Smtp-Source: AGHT+IEdqpnAGiWJTwIPlhp610QsSYk8bpJYLSSz6FO3MpZF5LsWsXeBjemYyZEyj2T7Qip674xVJY3bXF3tv8/4yku+NdTAe7dA
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:228a:b0:433:71a9:8f9e with SMTP id
 e9e14a558f8ab-43473cff2bdmr18984735ab.7.1762914482406; Tue, 11 Nov 2025
 18:28:02 -0800 (PST)
Date: Tue, 11 Nov 2025 18:28:02 -0800
In-Reply-To: <20251112012749.2082979-1-kartikey406@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6913f0b2.a70a0220.22f260.0155.GAE@google.com>
Subject: Re: [syzbot] [fs?] [mm?] KMSAN: kernel-infoleak in hugetlbfs_read_iter
From: syzbot <syzbot+f64019ba229e3a5c411b@syzkaller.appspotmail.com>
To: kartikey406@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+f64019ba229e3a5c411b@syzkaller.appspotmail.com
Tested-by: syzbot+f64019ba229e3a5c411b@syzkaller.appspotmail.com

Tested on:

commit:         24172e0d Merge tag 'arm64-fixes' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=107bdc12580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cbf50e713aaa5cb0
dashboard link: https://syzkaller.appspot.com/bug?extid=f64019ba229e3a5c411b
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12858914580000

Note: testing is done by a robot and is best-effort only.

