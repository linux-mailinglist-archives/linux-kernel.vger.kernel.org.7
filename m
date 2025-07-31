Return-Path: <linux-kernel+bounces-752434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6ED1B1758B
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 19:20:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 700FF3B8C0A
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 17:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E06F9262FF5;
	Thu, 31 Jul 2025 17:20:06 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083C723D29B
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 17:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753982406; cv=none; b=HhBpGTEPLoDCkPDjIvW/rVwatt34CmOusbKXUwcvUa+Tujzt9vme6JnyYwlntsL9Acck5NFF1Wo+a65E6dVwIcmzD5HWa2oz6410CuXP/f0XV6HPeGPpk1SPVk16FExcctDHnO21FL6DJDUEGKRss/gu3XeMFw8/jflK1OnYxlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753982406; c=relaxed/simple;
	bh=klHrsWHFVcknr3dZloM2cwMZiRrX3CHSHLFjaJwOu9s=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=F2nnyJd/0mubF9sd+wUBCXGBUdWIDIuryLLvEWY5QCQBaG8APH8ijeUSXZAB1mjMARH56phYjEP2lWN4Mvwj7slgpEK/JjHQjYR/z4BdYzAyIbI6Fxubiy/hcsPU/dOLf1AVt1iRYnFpqFy1fksKUGDI0oNjW1X6ICTtQ85IrOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3e3ef736a78so8119365ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 10:20:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753982404; x=1754587204;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8/1huQ4QMjZAEsHOs2PIn3P55XuD8IHO2EHlOkap8yA=;
        b=tINUu03YF5WJOlxb6XxlHqrdu/V0WNSZdE8XbXmqST0foLXEO8sGKTC5kJSUkZyn+n
         BgH1LdNAeivK4G3k1ijprWSDIg+mxw2MtLWWIJKE+OVIaLke/vB8k9MTrmF3SfQQ6XVy
         aaRwPu7oatl7Ij3Lcsp2SoUH3YXVCsxTpV9tasJnqcKonPrAanRNPF8Wtq8i0mZrMQN5
         XNGAFZ/jqbdDRsky/TNSjjWduOBDgtTam2LCqVfC/Fn5g4UR/bDkn/6rBWYyJVeBLgYX
         BWpimnYd4a0QO/pUYWzy78RTx83XHMg4Ztzea6W8a49cVq0nu6sZgmnP7byPMO7hBUmT
         +Y/Q==
X-Gm-Message-State: AOJu0Yzz5yY1Yn04gtdXsH1iIWhet/gshjN0PIEoqyl8UgTHe5hKrjT2
	4QkRlKptFIXxLt/K9mDfzSRByqnaU0bOUhEIAMCC0zFFhKMSYNG678/CKLcA3nlLEJhuCXV61om
	daytcVgNzFEBDykEWDAujzt0natAZNryoiWOUvPiYp0vm56pPVtQy35PrIuM=
X-Google-Smtp-Source: AGHT+IEYSiOBsR5nCgkPXw4IiQp77s4+QVlT/Xm1dkmBqraDmGRisT44gFv3b+AWLWDaiRzdxKxEoW1pBU/TO485GOYtpdXLMI95
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3a10:b0:3e3:d246:55fb with SMTP id
 e9e14a558f8ab-3e3f624f087mr148622775ab.15.1753982404235; Thu, 31 Jul 2025
 10:20:04 -0700 (PDT)
Date: Thu, 31 Jul 2025 10:20:04 -0700
In-Reply-To: <CAJuRXzD+rHPTo42O25mZ67uzbH27n+K0q8kgNBDXiJUeiC3hgg@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <688ba5c4.a00a0220.26d0e1.004b.GAE@google.com>
Subject: Re: [syzbot] [fbdev?] KASAN: vmalloc-out-of-bounds Write in imageblit (4)
From: syzbot <syzbot+c4b7aa0513823e2ea880@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, sravankumarlpu@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+c4b7aa0513823e2ea880@syzkaller.appspotmail.com
Tested-by: syzbot+c4b7aa0513823e2ea880@syzkaller.appspotmail.com

Tested on:

commit:         c7fb1692 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=134ee9bc580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d573220e49f07420
dashboard link: https://syzkaller.appspot.com/bug?extid=c4b7aa0513823e2ea880
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14e6e9bc580000

Note: testing is done by a robot and is best-effort only.

