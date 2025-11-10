Return-Path: <linux-kernel+bounces-894197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40F6EC49751
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 22:55:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F7C8188815C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 21:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64135330B1F;
	Mon, 10 Nov 2025 21:55:06 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A244A21B9FD
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 21:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762811706; cv=none; b=kjyM128TpmQgqEfVwjLYmw5IyAvMs48JZv1V1SSnszM318Qoxvxb1maCUBApuymrDVFYQABVwhLLSoM73ripoXmgPzE5lIxWA7YDxGd/2LQT09RY6lTkoYuIAzekv3ppQ7zTYvm7dfWV1eDO9vnt6Fs1P1bjteS/az4GxpqKNQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762811706; c=relaxed/simple;
	bh=vU0TO8BD+idNrc28jXRVI8wWAlZ+X0qdYCZvmkn0T6Y=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=WZY1a4pYSFI0YiWJ6MjB6KETeSSiBUP5/qjN/oSWJyoNdFxKQXcafNM+mbevjPOR7b9FfjByBT33nLWfsl8aO03gAkg2Sb9uguZTB5RqbxdlqVgo5LkPrexzaH8YYzjzarwMh5QFy9d6FbtGO2/HbPdX0xoO7CxtGfCkVY9JZAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-43322b98837so41790395ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 13:55:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762811703; x=1763416503;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ie2/PeJ0jgx5E8HiVBVNYjG7K8kqqreSpRHnsimU148=;
        b=ARIUkD33t4nnbRJCEC5roC8hSYUd5punJGWn/9sqg9ZCOnu5/M/XJpfPc5V43hoida
         oPj8tU4VjzoIOFmOhWnLT5UGDoWwvBUkNiWhsVQM4tnOM9FdeXYFebE3Tj6pHDQkNf5A
         DXLP4lbuiW/tZVpGvlwcGahIawcRNLnAOo75W3iuSGrDxYsL6G7oc+bVzWfYLgwUCaQN
         GGGuSTFRQ3khXwyEE+ikecIBTwhM8pLJ9152lTvK/8zsuARbtRxzb0YEv0Fg0mHj02ag
         G0BkYU3TobLCUDmDmWm1YJxxVuKgKQBHnhRijNC7nrY3/UivL9ZKSS5sWV22Cmwa1Ngg
         R++Q==
X-Forwarded-Encrypted: i=1; AJvYcCVSlo+aXL1Vp18I6err1+LxGSYaOkaizFO/BRAPdUrMwdSccUOCH5WsYppwuAelyIyzijUr7WrRUhLGL7Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YymZD/H3RjjgW6saLTxGOlxLochSFpG95jN7Vy912g+gARc5o/x
	hFisE8HWFTsTzxiCgnyLd/O3KKo2jIX6hwY9u1FRXTGPS0uZY9I6u+9koFqkPjcrywpmp/YiSJF
	9oQ1lF6pckYORiqooX6O7inIlEHsXBHqMFynRa1Djv633279s9QmkWOIiRH8=
X-Google-Smtp-Source: AGHT+IFUrp0LeNJfpbbEEybABNZcxFBbxPlCJBUWD2fXo9BWxHePezzLCfZ2+zOMd0I93Borf/de7KfAOoL7fCFMbpQmMLnNo9Xv
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a81:b0:433:773d:adc0 with SMTP id
 e9e14a558f8ab-433773db12amr116490455ab.17.1762811702828; Mon, 10 Nov 2025
 13:55:02 -0800 (PST)
Date: Mon, 10 Nov 2025 13:55:02 -0800
In-Reply-To: <d9753537-b2d6-450e-bd7f-7bd86dfbb7fe@kernel.dk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69125f36.a70a0220.22f260.010e.GAE@google.com>
Subject: Re: [syzbot] [io-uring?] memory leak in iovec_from_user (2)
From: syzbot <syzbot+3c93637d7648c24e1fd0@syzkaller.appspotmail.com>
To: axboe@kernel.dk, io-uring@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+3c93637d7648c24e1fd0@syzkaller.appspotmail.com
Tested-by: syzbot+3c93637d7648c24e1fd0@syzkaller.appspotmail.com

Tested on:

commit:         4ff33a31 io_uring/rw: ensure allocated iovec gets clea..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git io_uring-6.18
console output: https://syzkaller.appspot.com/x/log.txt?x=174a317c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fa4513d3a243489e
dashboard link: https://syzkaller.appspot.com/bug?extid=3c93637d7648c24e1fd0
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

