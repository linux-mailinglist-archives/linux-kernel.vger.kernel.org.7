Return-Path: <linux-kernel+bounces-876489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EC09C1BE44
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 17:00:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 793FC5A77D0
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 15:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 102122EA178;
	Wed, 29 Oct 2025 15:13:05 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C352E284B
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 15:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761750784; cv=none; b=f30Sc1oJjBPq5rH6PryVWXWO3jx4JYzPgf+sxico0IWUvWqVb9sqFh2onxqAHez9U9ubOqRB/peIA/cwaHRXIwPl0IBZHkVpaxI9LMZkvYGvzD23+b9C2LjsbEzeURyMurnG57bxi+nJfC7dfJbaI4C1JsoYbKz27To4+B703JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761750784; c=relaxed/simple;
	bh=zsPdesw4+1YPzuYKkwCg6SdyObmLk/tm4svboZLOPVI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=blC1ntY+6BHXHb8QaGAsGQtq1mmCptbIMfygSEfRGTkwIHR8eqOYgZlyGXETrZxy73ko8ZRxz/oVe/WNAgurA0aX8nPnx95eW9M0cXHwQNeL0S9ysd2L3+UJGKWZh3iINBYk2TTOMmByQ40+K51fvBEeZwCvK6bjYsDXGCFFsl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-945ab8d3d0bso399419839f.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 08:13:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761750782; x=1762355582;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h4Q7V8r9QGYS/xTeyzhRieq3ZgCpn516qiFjijI1kVc=;
        b=imGd5R+S8z6oYLzqrQLXf07mrMexqNgLNH2Kwu9/vG3Rg62rsePeULVMRwqQBY+G4P
         Pjm9AppakE4Mu9HnWJUgg/7k254WOqxJFSttP+rrrEuw09g//UuwLDCbrz2Jny2M0WHX
         f67cD6KU7Fe8cXSDDwLvMkazTpqOJZTFwwn0kJ1b69GTlclmDdbqVWw3eoPm73v/fvIA
         mQztZKhyMssBkQ7UAUIvunWIW1TezLE8x4coH3cWpVcWU3FzQm5sqTtlHSMeF2zoa/GY
         mdLU1nArIOj4s1iSPiVqdP2Wg91Epcy13AUXuZ2wrC5a7v9xolt0hR4MgwEgwfUqru9O
         ZEmA==
X-Forwarded-Encrypted: i=1; AJvYcCWCjiCuKoaxGxXyCA1iyweS5hxkB3CSTWg/kNz0eWoJuG2Kz64SuxfitVZh2B6qDNq5IWpHuJRVCkCkf9k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0mximhzofFd9t/KsA4nhOL2plSxATeYEGX3s1z0t+7NTGaZBi
	xNTj54IdNdpaE6MP23z6ywvCUVqnfCt/9fYJbkn8erggNvHoPwjf3/9Le1eWA1zaPAOABj8jSjX
	PmF7kF7yGG1qeivDiRbS7X2Y5UVPBx/PvqEU+mb8RKIb7u73Iubt1A2zM6vM=
X-Google-Smtp-Source: AGHT+IE4qg6Lpifyp9eopJcsmZTNj8RqrEZGEycp0BGWjApnKa38JxHcNZXov/k7TFDjtL/zeTbKvhXQRAHLIY/VnatqulXNMnuh
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3004:b0:42d:7dea:1e04 with SMTP id
 e9e14a558f8ab-432f904464amr39509555ab.25.1761750782266; Wed, 29 Oct 2025
 08:13:02 -0700 (PDT)
Date: Wed, 29 Oct 2025 08:13:02 -0700
In-Reply-To: <20251029062550.DPi_g%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69022efe.050a0220.32483.0212.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] kernel BUG in ocfs2_commit_truncate
From: syzbot <syzbot+c16daba279a1161acfb0@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+c16daba279a1161acfb0@syzkaller.appspotmail.com
Tested-by: syzbot+c16daba279a1161acfb0@syzkaller.appspotmail.com

Tested on:

commit:         f6e38ae6 Linux 6.1.158
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git linux-6.1.y
console output: https://syzkaller.appspot.com/x/log.txt?x=178a4fe2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7417700edc6ec0a0
dashboard link: https://syzkaller.appspot.com/bug?extid=c16daba279a1161acfb0
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15983e7c580000

Note: testing is done by a robot and is best-effort only.

