Return-Path: <linux-kernel+bounces-874307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DD7F1C15FAE
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 17:56:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 273804E5435
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 16:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFC73346A0B;
	Tue, 28 Oct 2025 16:56:09 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04EA33451C1
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 16:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761670569; cv=none; b=Io8u6jcDkEbJYCNwDkgz77PojqNhAS4Cfe5eykN+dcPt8xoMNPTvOH9pUHzDrgDoMosWVBhX6Yn9v8R24ihoVbyUob2oPpYdvZNgGMdPJChFsxwcUpbTAg+ZHjEwT5qNISBtz3upnj1cfw9ciaaBAg2MdII5ywaNOBLcSQWyM3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761670569; c=relaxed/simple;
	bh=WOQ1xmNxtYoTqX/5bEfTYtjhoumCJgYdg98MSSTwkXs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=IdVvrYUoDHY/kGZgXIcszJHTSFbqSqa/ooQzbaDf/YWxTeefMJK/RmKtK/1UKl9Z/WGraws5RJXTf1+U35+ZJ9Mqg036xs5DlKfnma2LX9UWMBPvu8i/itX9Htnm4zpd5vvxu6I2ryA0aoEnskuT9mP1LgyIfFCTm7Q70Dqvadk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-430d4a4dea3so1342265ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 09:56:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761670565; x=1762275365;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ozi99NcD6xWnvKgmrhFFCgg+4Pg8D/jR1dayURp6JBo=;
        b=EsgvDF07OlS5ziDjDIBVSWig/ZyeUpLE84jJHdvKpp1Ii53l0Z/FS8Xt4ucU25msS+
         DenMXdsgC+xDL7o11D4TWXw4YDdNiYtH0NuchvNP2S5eRVO+25yy6v6u8PkiLw6nMP4L
         rNq/eB7s7mW7PKRBOJF/9bm1UxtJTxiMSZ6/ShHN1KrdQ4Ra5DX0IQEy51pWpKLgZwY6
         RmblbGBisMjMQdoZhgKf3rZhdaFLncP44MeCpgT/Fk/i6+McsL88Eaw4qMNr8Ja6hty3
         JLvQg3j67w4fWfLzUNfQySZ5a5pm1wNKcYmKz2msya/+tJXqhmzKnfnBE4H5+GzdOmZU
         s7Zw==
X-Forwarded-Encrypted: i=1; AJvYcCU885CqsCFNNSVcD36LU06Gt3PA1iR6QxJ/uzPoanzlyqRZSuSbAh0y7jn/Zve4Ffm0gzIn/rPhPvgyA8g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3sV7qDcWX0ChJbUYb1mC9iuMPHBfAQbgPhsW6JFyKYumA4VW3
	JN/9PCaeF3bbv+npeEMQRS77IkPTSGDT9MARFk9bb9P9hnu0UfKn7bcnq3mi5lpd9Xi71lKFDEv
	/YA5N962bwDj3iQWZB6LKjF7GqQl/VRddgG+p3Iv+2xwZyqwxWjf94UPUPTc=
X-Google-Smtp-Source: AGHT+IFiQGALKQurVTu5wG2hAEJP6OUmrWfCn08tcDbl9qt42SjOPgZEk4NpsRvpGGqPip1lUjaE8YBq03SuXQx+t8SYee3wGWIm
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:9:b0:430:cafc:df6a with SMTP id
 e9e14a558f8ab-43210445659mr47064715ab.15.1761670564976; Tue, 28 Oct 2025
 09:56:04 -0700 (PDT)
Date: Tue, 28 Oct 2025 09:56:04 -0700
In-Reply-To: <njddimio6m6pi3bcfyixizrfzjfflqvqe32xlfwn24vtzk67j4@3cijvucydtb5>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6900f5a4.050a0220.32483.01c7.GAE@google.com>
Subject: Re: [syzbot] [mm?] WARNING in raw_ioctl
From: syzbot <syzbot+d8fd35fa6177afa8c92b@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, apopple@nvidia.com, byungchul@sk.com, 
	david@redhat.com, gourry@gourry.net, joshua.hahnjy@gmail.com, 
	krishnagopi487@gmail.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	matthew.brost@intel.com, rakie.kim@sk.com, syzkaller-bugs@googlegroups.com, 
	ying.huang@linux.alibaba.com, ziy@nvidia.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+d8fd35fa6177afa8c92b@syzkaller.appspotmail.com
Tested-by: syzbot+d8fd35fa6177afa8c92b@syzkaller.appspotmail.com

Tested on:

commit:         f7d2388e Add linux-next specific files for 20251028
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1244432f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d0af39d067deaba8
dashboard link: https://syzkaller.appspot.com/bug?extid=d8fd35fa6177afa8c92b
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14461f34580000

Note: testing is done by a robot and is best-effort only.

