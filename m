Return-Path: <linux-kernel+bounces-887687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E00AC38DFC
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 03:32:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 808663A5B16
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 02:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60C76757EA;
	Thu,  6 Nov 2025 02:32:06 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751D31F92E
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 02:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762396326; cv=none; b=b7e7wr+PMD5wr83bVTzfaFH8I2Cu416tuknMIV3c0IS3N83LDuKYgGkPr+U2SeAIC9QhAxtfQXMhuMnU8rXny7BUHjCk1adbyr3y/NSsHNtFLjBwxplX3ek5DTopuzvMLRP1xnpzkDYRQ4xgtTl6kjV9VnsisysabhQYSjPKz3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762396326; c=relaxed/simple;
	bh=uTpNjR5Iow3j8BPBVGc6oWNWrqUfdjOyD+8e8BILvY8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=hyAaBW05Q3LOjbTiJprvmZsUJ5vrUHWrUqbAVS34m3uxzj2xRguQjdnOvqCADlMSM3grmB4juDjQN+nMQmIoOoV1Pe25yGuHH4d3MysHmmpknwJWSty+F032U4Yt6WLrhjJuHsbbNiB7q6gIxPAXVtQDckogd9xorHIk5K7B+Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-43324a2096fso4449865ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 18:32:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762396323; x=1763001123;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mehm3ipu1uTRh0xEI+zxDeB+lMmpBc/99bcPQ2W13eY=;
        b=UiQOPYt6hfveOevq6Pn46zp5+tZxZRSGfeitPlQkL5FQHYLDWiFoRD3nlnZ8/YTw2t
         nMhLaJ5S61sgkAwfNGBi1Z5vNUGFQnaL2rUEGD8XbLdW3CIyTZPCZdiWbjFiSLPfx1eO
         TG3+173fKY31NlhMzj6s+M01HWIOYxuZMDzLrysWnfQVTlS/idwKxjjV2eaai83ypBBa
         Pvf5znBohnEBYX6yqAJewoZElMyBBn7CRZH8CWfRFYILePDV2RQtVvEmyrW+3avZOcBi
         RNJ3ts1qhhfOoNN1ceIqcZ4Cg58KYD+0So5UapFE1NMNZgr43bsxClGsGs4W6AReLAxZ
         k6UA==
X-Forwarded-Encrypted: i=1; AJvYcCUW6ZNMYvgaW+RIfcNp1haH5cY7HZUGXYZZ/Vxh9xvmQyv37sFNZpRPWuI8Bv5FlUcoSmJ2vqBxdyx+9/4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxjo9aKuhgNmC4ax8PkCFQuTcpIWvlep3X2686VqdZwWrC3r3zc
	tzboob71I9CFe01jYo/0WKvu/pP/9zJKn4OXr73QXZCf6boWVshAhHh6g3Cj/M7N6fJWfD3KXU9
	G26xYI/L8T4UY1XeqfHpbPMExun1RL1v9xxxqLp0XrGUuK6PL/J0bl3GEvAQ=
X-Google-Smtp-Source: AGHT+IEgTKGTNtoKzFcImnV9xw8A+JNAYfDAZmV1FL9JPNQXWWd0CmSGwR7/4iDB5ITwGFkpgTTsArONDu1aA5L6u4lrEhHoaZeu
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:441b:10b0:433:4e9d:de9f with SMTP id
 e9e14a558f8ab-4334e9ddf39mr31725995ab.17.1762396323584; Wed, 05 Nov 2025
 18:32:03 -0800 (PST)
Date: Wed, 05 Nov 2025 18:32:03 -0800
In-Reply-To: <20251106021039.8866-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690c08a3.050a0220.3d0d33.00cf.GAE@google.com>
Subject: Re: [syzbot] [sound?] [usb?] KASAN: slab-out-of-bounds Write in copy_to_urb
From: syzbot <syzbot+bfd77469c8966de076f7@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+bfd77469c8966de076f7@syzkaller.appspotmail.com
Tested-by: syzbot+bfd77469c8966de076f7@syzkaller.appspotmail.com

Tested on:

commit:         dc77806c Merge tag 'rust-fixes-6.18' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1647a532580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=929790bc044e87d7
dashboard link: https://syzkaller.appspot.com/bug?extid=bfd77469c8966de076f7
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16fd2012580000

Note: testing is done by a robot and is best-effort only.

