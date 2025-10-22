Return-Path: <linux-kernel+bounces-865927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 183FBBFE584
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 23:50:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71A003A54CA
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 21:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05736279DCD;
	Wed, 22 Oct 2025 21:50:08 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3752C1FF61E
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 21:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761169807; cv=none; b=fs3O47HwbuflEIan+Kk4gXILe1/YEEfzJEStM5/1JdSnTUzOY97Zi7CSBq921Via8qcnvNltvvD995VuHj8VQ4HwjNs4YKMEuxyou3ylJk7hbi52g4x51kiTwR3TTFVOln87W7S+wUGqU9lOYQxP3HHLvZ+voFMheX/LL+QFIVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761169807; c=relaxed/simple;
	bh=5Q844gZRGQ76duuf95J4vE5womQsHPiijXBO0mQnE0E=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=D9A+hBM/CVtVVcA4y3BxwCPB+jO9EQxbCjKdlsl5TeYYQXH3X9KOvAtpUzkqp3aG+hMcsACV2Bbp9npKRAV/ffvbg35C0fqHVstkC90phag5FY1iK70WCMngSaeBXYfOWn6kl4f8xPPSpDE6y/VzlLHVeSZoRb3Cs8MmLaMcvOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-430db6d36c6so5221735ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 14:50:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761169804; x=1761774604;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IMfH/Fi/M1jiphxotJ7LwQuGeAdrdIz/V8BOnDUP9MY=;
        b=Jq31y9LZ17qMr+fcJZw45/vOwGljtfSNnWUVrtIx3PTFT2bJdkHxcZXrW2x5biAMJB
         dXEB2sWkLJrz9OoiIxZ2/J6Kx1UawqwUKdydV9M3uRZuKehO2Phv/HijXudymRRL9esA
         bhyT2wQ1aqpsHCHlL/3E1PfXxkeCTNOwbEvCzqpcC15phw/oDGF5A5SZmBUAr6VFEBgc
         ymEhFwkl2Vw5ejOZT3rRn7qm6vlnebLOAbBAgIFBG/4T9x8+OgH4/XZ6SwHbsBXtOao5
         vr2DcM5zsCWTRFLN1K7MZlAliEwfBd/cDnp9SzrIr76jp/Bn6a0Fz8REy+Kkz7q3VfXW
         T48A==
X-Gm-Message-State: AOJu0Yy7Tsu4jy3HlHwxYaQSFzZLMeD5Oye3YzCRECjFWifeVpl7OtsR
	e0LPJT4g6tCJnzkM2c9LG6oXgeKJe+k0dkvWMUibd+15dpTq9gE+jsTyBOJ4v8U8mQ4sb5YpzGk
	18+16tcIVY4aNLRzvbOUKB+hztHSOEDz8e3dEY6X/zxxn+YFbWBaxEnpe3bE=
X-Google-Smtp-Source: AGHT+IGEKeani19/bvHRnzfZ+ybEiU6og6gOpok6yipQdIu02j7Z8ruWBmmmSeSBjFPHk0MwRwiRqygf5ECeyKzVeCtfXthm6y+E
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:152d:b0:430:ab80:66f9 with SMTP id
 e9e14a558f8ab-430c52081femr332249905ab.1.1761169804203; Wed, 22 Oct 2025
 14:50:04 -0700 (PDT)
Date: Wed, 22 Oct 2025 14:50:04 -0700
In-Reply-To: <CAMz+-CNCHqKbcvi7F7J_eBDMm_9J+eWvSC2WkJVzQRHLJiy8=w@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f9518c.a70a0220.3bf6c6.0029.GAE@google.com>
Subject: Re: [syzbot] [sctp?] KMSAN: uninit-value in sctp_inq_pop (3)
From: syzbot <syzbot+d101e12bccd4095460e7@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	vnranganath.20@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+d101e12bccd4095460e7@syzkaller.appspotmail.com
Tested-by: syzbot+d101e12bccd4095460e7@syzkaller.appspotmail.com

Tested on:

commit:         dd72c8fc Merge tag 'platform-drivers-x86-v6.18-2' of g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10aed3e2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bbd3e7f3c2e28265
dashboard link: https://syzkaller.appspot.com/bug?extid=d101e12bccd4095460e7
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10bee3e2580000

Note: testing is done by a robot and is best-effort only.

