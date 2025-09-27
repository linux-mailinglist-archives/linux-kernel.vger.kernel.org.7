Return-Path: <linux-kernel+bounces-834815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0299BA5950
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 07:35:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6115C168783
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 05:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 047E122B8C5;
	Sat, 27 Sep 2025 05:35:05 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39638200C2
	for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 05:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758951304; cv=none; b=R6qv6ZP19cygobEvmPNglC306DrvMPw1z4AX4E5SCzvCX94rgSiHajCulvvX3XJutFjWfyotxpICsEa96gj84xVSDcFD15tUyjayxBfS9xRj3le+QUWX7Q2ENW+MuZrqbL4RUcupzHOQYR5FVWoMexZcVH8ZC5pEQBd02UvEJtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758951304; c=relaxed/simple;
	bh=05MkmsGIDt4UguLdW/B8sfQMR9VdlBwW+DjOgZuPi7k=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=jIb5CqirDYzA2gAWnaIZcteHVOrWNy+hBdRXqBEW54uPPdRKW/i8+8NqzTnfki71DkUYBPyageg5ILuEwX6vpLShgevWYwu+FL3pAMLTJcT6yLmzeigl/N331mMCSyn1Qqkqycr1ulkFoKj3U5VKX0ELN/bJcjkTet1D8QdLERs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-893658a9aceso308188739f.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 22:35:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758951302; x=1759556102;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tuCLaiipldyyHqW5s1mHUqUbdaat26uOB1DKIu7FtB8=;
        b=VlOghu996uAEVIj5xQ5+0k7pzSQg+2aHrIho2kiPWqmhe4Uf1JDj90glwtltlCz/RY
         ZeEvYaAtOY8eNebVotfpMs0MtLwCjqNqkIUHJR5azzsNZvcEaMZ4DCir9T1XM1oxiFqD
         ojOZ0r7kSKWb+Pzhhblh/tKvoLmWuKhDBkrfBiGuc/hyuHODvVTg2/ymu40nqWnYzN13
         aYFKX0kINmd+1PMNPKMqNgdY+MAHRmFMYFnDtlh91RuxVRHEm0txr+4H+dkxObOShgbc
         N0KLA7W3aq+JAnDx6GgWzmFzyMdGfGIo8vF7Z1vqNPsmeiwknHONgIzFDqfjw89owO77
         X2ew==
X-Gm-Message-State: AOJu0YzOrSdvwpyfUFqRKH004tfGnReTnYFHurJP40l2Fq6QUXYnuLEC
	VcePD2EsqAQQrlW/QdynEtuRIXC+d70yCjw3Fy8UlusQR/pqcuozK7k5pftnuIstSmAd0EE3BiO
	f5QcG2iS8Y0/xSvVYQStDmt3MBf4I1r0uZkmNs/rQ6BDw2ye2pM1oZzQtUZ4=
X-Google-Smtp-Source: AGHT+IF0SakYFZOLVG/ptiPBYKhNmuMxorvYtHJ2gSc12Kh2R2PhkH4xRyyzM+9Ml5jh01TsbWi1V0V8bDYd7cYt9nC0lJiS/Y6y
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a82:b0:424:7de2:61c2 with SMTP id
 e9e14a558f8ab-425955e82f8mr146581255ab.8.1758951302358; Fri, 26 Sep 2025
 22:35:02 -0700 (PDT)
Date: Fri, 26 Sep 2025 22:35:02 -0700
In-Reply-To: <CABPJ0vjb+1EzErp-t7cGR9T_0atGsUQrR49M0fxo61HfYXd1-Q@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d77786.050a0220.25d7ab.0248.GAE@google.com>
Subject: Re: [syzbot] [hfs?] KMSAN: uninit-value in hfsplus_strcasecmp
From: syzbot <syzbot+e126b819d8187b282d44@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, rampxxxx@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file fs/hfsplus/bfind.c
patch: **** unexpected end of file in patch



Tested on:

commit:         fec734e8 Merge tag 'riscv-for-linus-v6.17-rc8' of git:..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=e4580d62ee1893a5
dashboard link: https://syzkaller.appspot.com/bug?extid=e126b819d8187b282d44
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10193142580000


