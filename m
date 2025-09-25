Return-Path: <linux-kernel+bounces-832376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38AA2B9F332
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 14:21:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB9154E83D1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 12:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD70A2FD1AD;
	Thu, 25 Sep 2025 12:15:04 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3222FFFBC
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 12:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758802504; cv=none; b=YFY0uB1P+K+4bHXEC9Kxc7Fi1PANdG4Y0SiJ+MqcH6juLEQIwjTNzTRGPlkBNMidk7tgZ08MNtlvJItLiUQClH7ECqoaQW7OCZmq6lpDJvoDeVTi4+TpTRy1qlyHOVqS9eqUD2OucnmMAkgF7lT5P8CD1xFXKskZ6m/7s9o9XL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758802504; c=relaxed/simple;
	bh=BK4kjlczWz5AmsfhVR71ERE0mxoZl/kseF1jGO45K2w=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=qbs6+uGYbJeiO0amrD7VIMAR58jYQAli4jrz1rV1HMxuLMD6Gwjfl7TPTV7HztKHMuVB5dSY4GuMKM4fNl3zXczvvLYonHSkNDJ4vri4yYE5D/sODlWSwUwQ61GVebXRKuzkQ/i5ZpHaak5vV13s+CEzmifuPsFbJlt02hPDrcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-896d8bc595aso207245139f.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 05:15:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758802502; x=1759407302;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/KUWavqk6WOmR+ziqN2dRNuzTGN9d+1Rwg8YY+h/8WA=;
        b=eJlrB3cFJp61dWMaE2UmjnoblWeYSzUa/EtKLyPebxsC1wgsCGjGq4KKjWoZ/vc0LW
         Kg7JrpLmSkXY7bD5SDoRJy0jUH0lrd5NHIo0vyViIrBhNJIOYA7dFgDVhTeB3GARpwBu
         Oa4iPSmJ/GODDfH/DFOrUjkCv/1Ta9lMVYoPSGByIPrziaX6q2pX7W9rnKJtmGWjEHtg
         vG2V7OxrYs55wDTZMO4zsoK92c13iDyikTBq4cSwlyj00T2rHyWUmiN75QqHuw3n2gbx
         hCVCN16OiZSJZF9x/GH6PJULGLxWAGcqx1rQvZ4oR+JJff2L/RFb/zsBb4z7bx7mPESR
         v8fw==
X-Forwarded-Encrypted: i=1; AJvYcCWRuF6wm//iBTUPciLZjVp5NotLdpcnDSVaPadmEV7xj+tMUmHiuvgv4YPghuOuKEpXZ2VcFvsws1Lv+n8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsXr8bi3Ohf9Y/5Z3WWmMdCOewidxJQPp22iBboy5JtpnGB5OG
	3MNZB/qmX/++zvUeO/dnEcUqzKl9CnNE/7G4RRu30Jgep59Ds3vtZzoOzI8GVp3RS0YF//LFuTC
	ZaOd23S2dAYl76Hmb+E5uE17Ne+kQvyi4VTqhhRLNgelgDzaKWZDeG5usKU4=
X-Google-Smtp-Source: AGHT+IH23kK7qjqeACn7X9sPXv3GjSzM7vTi1x8hjEvfuFd7s7JA8R5hblR1q/S0BGRYD4gp2Tdbz0z4M5yWPd0y4rIt0DXZ0ejL
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c52c:0:b0:425:8a7b:70f8 with SMTP id
 e9e14a558f8ab-42595614267mr45199385ab.15.1758802502199; Thu, 25 Sep 2025
 05:15:02 -0700 (PDT)
Date: Thu, 25 Sep 2025 05:15:02 -0700
In-Reply-To: <CAC_ur0pGOubmRFViT7oV8_pE5FykkCESLftpN6dxAPF3fmUL5g@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d53246.050a0220.3a612a.000c.GAE@google.com>
Subject: Re: [syzbot] [net?] [nfc?] KMSAN: uninit-value in nci_dev_up (2)
From: syzbot <syzbot+740e04c2a93467a0f8c8@syzkaller.appspotmail.com>
To: deepak.takumi.120@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+740e04c2a93467a0f8c8@syzkaller.appspotmail.com
Tested-by: syzbot+740e04c2a93467a0f8c8@syzkaller.appspotmail.com

Tested on:

commit:         bf40f4b8 Merge tag 'probes-fixes-v6.17-rc7' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10cfed34580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1b093ccee5a9e08c
dashboard link: https://syzkaller.appspot.com/bug?extid=740e04c2a93467a0f8c8
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=149634e2580000

Note: testing is done by a robot and is best-effort only.

