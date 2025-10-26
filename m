Return-Path: <linux-kernel+bounces-870446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BFC6C0AD52
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 17:26:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A7E618962CE
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 16:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0015D218EB1;
	Sun, 26 Oct 2025 16:26:09 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D74C1A3164
	for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 16:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761495969; cv=none; b=DpOJZPg3359ojXaeZeHv/sYJ879kPzKfmUALrHmyoQAAh6g0bAgWUtiqEblsWzuwuENkps+QDB8U0HKHK4QNn6mHYbVdAL/jie8Jlqs/UZ6FAJrh7fLmgPY14c9rCj1ftzOsU0SGRiGv5oHxnGCgZ0z5I1YNHgQtqaMclgZ4YaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761495969; c=relaxed/simple;
	bh=L2OQ9nFN/WtDFuWejs5yV+5/Igcos50FlX0Aqd/rkSI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=fOEmtpmxyzURUKBPt4Qkh9FluXIjsmcjJ3GpWeReaE/gAVImuCy1VCXAacwRDOzOoXOFOv68vhTJehelIiwrcO9tHp2Q9Gilu/YEOEx59RCRTDdpeSUJ3ESLo8vGvDYFGz/W8uTEajejtTYLZY1R8YslzAxS+an9pZ3H8gdHGv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-430afaea1beso49338965ab.0
        for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 09:26:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761495965; x=1762100765;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pCJN6/lgLt/AfwJKPwFs5gCvPc90cICUUWyW6Li3B6Y=;
        b=Q0nZidtkGmTvGg0rDvN9tT99KIEGbzjNgrscdYugbQofNDPobhYYN/WkMOWP3fx72x
         5Xzm3y0Gu8cQbP7sSJcCtxwHd+yOSJu7raRv0ErEdBWjz5W4TCt6kcZwzD6I3wc/WCRo
         8XebyfVT0zFNq1qAWUkpoyTkoal1OAEnj/T3kM8cloTh1C6Tk07i12GTJdveOKZ3GqAG
         9GyWTLjDQs6MKnZwkXKPV9uo/zDpm4LR53d5mnhHmtVuQa5PJm6p2MQ6Af8bYLrzUCSL
         PPa5EG6OYt+Lkhnsey5GZGEWrzCLb6ClvjGJ449gEdYPH6m1U+exJA0MpfjIWs+Yi2sM
         4lSw==
X-Forwarded-Encrypted: i=1; AJvYcCV1cy6YzcTo1mWrn3/5Fcsd/fZAWAj88W8/uWJcxM9qL1ZJvupLgIHhcQyRLtFdcdtpH8lKl3Fgnbr/mTU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0QaIaT9k+oueZLKGqo2E+T04Zb8j7KJz2uqM7XP7zV1ZMywu4
	DbjA2uByW2H6dbAeBLpQHJtJQT6/nqaClY/92w4fL5GwQ90pk61dFfo6/5zgcqpw2qkuB4quUKI
	3Cd0lRKuw1Phm8a2QNTARfRFY5+m5tpkv7C6cPNZfmT/CY1KjniucXDQdwc0=
X-Google-Smtp-Source: AGHT+IH52psLEnDOZJSiEcCStoHiiJLLXvL2QIYffQxCD2Yjkp6ahcD2w+bzkWQts8kgQjeoH3A469n6jWlGRIMvzzTZdGoR3U4u
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cd82:0:b0:426:39a:90f1 with SMTP id
 e9e14a558f8ab-430c527dc54mr487007405ab.18.1761495965106; Sun, 26 Oct 2025
 09:26:05 -0700 (PDT)
Date: Sun, 26 Oct 2025 09:26:05 -0700
In-Reply-To: <CAPqLRf3LgEErOjV3V2A6XsaBL=fvhGPFooXWSv4Vt2Q6juWGXQ@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68fe4b9d.050a0220.32483.000d.GAE@google.com>
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

commit:         72761a7e Merge tag 'driver-core-6.18-rc3' of git://git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=122a1e7c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b8e9002258a92a7b
dashboard link: https://syzkaller.appspot.com/bug?extid=332bd4e9d148f11a87dc
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13ba93cd980000

Note: testing is done by a robot and is best-effort only.

